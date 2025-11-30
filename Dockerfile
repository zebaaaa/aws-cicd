# stage 1 : build frontend
FROM node:18 As frontend-build
WORKDIR /app

COPY client/package*.json ./client
RUN cd client && npm install

COPY client/ client/
RUN cd client && npm install

# stage 2 build backend
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install -production
COPY . . 
COPY --from=frontend-build /app/client/build ./client/build
EXPOSE 3000
CMD ["node","app.js"]