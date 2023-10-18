# Stage 1: Build the Angular application
FROM node:16 AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --output-path=./dist/out --configuration production

# Stage 2: Serve the application from Nginx
FROM nginx:alpine
COPY --from=build /usr/src/app/dist/out/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
