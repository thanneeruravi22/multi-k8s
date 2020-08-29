docker build -t thanneeruravi/multi-client:latest -t thanneeruravi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thanneeruravi/multi-server:latest -t thanneeruravi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thanneeruravi/multi-worker:latest -t thanneeruravi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thanneeruravi/multi-client:latest
docker push thanneeruravi/multi-client:$SHA

docker push thanneeruravi/multi-server:latest
docker push thanneeruravi/multi-server:$SHA

docker push thanneeruravi/multi-worker:latest
docker push thanneeruravi/multi-worker$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thanneeruravi/multi-server:$SHA
kubectl set image deployments/client-deployment client=thanneeruravi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thanneeruravi/multi-worker:$SHA
