% This script are used to re-produce the PHOT approach for anomaly
% detection mentioned in the article 
% "The Phase Only Transform for unsupervised surface defect detection", Aiger & Talbot 2010.
% contact.thinh@gmail.com

%% Clear data
clear all
close all

%% Load Image
I = imread('sample.png');
I = rgb2gray(I);

%% DFT transform
DFT = fftn(I);  
MAG = abs(DFT); %Get the magnitude only
PHASE = DFT./MAG; %Get the phase only

%% Reconstruct image from phase
R1 = ifftn(MAG);
R2 = ifftn(PHASE);

%% Display Images
figure,imshow(I); %original image
figure,imshow(uint8(R1)); %reconstructed image from magnitude only
figure,imshow(R2,[]); %reconstructed image from phase only

%% Thresholding using Mahallanobis distance
Y = imgaussfilt(R2,3); %Gaussian filter with sigma = 
figure,imshow(Y,[]);

%% Compute distance Euclidean
MEAN = mean2(Y);
[x,y,z]=size(I);
for i = 1:x
    for j=1:y
        D(i,j)=(Y(i,j)-MEAN).^2;
    end
end
figure,imshow(D,[]);

%% Detect the blob
O = (uint8(255*mat2gray(D)));
imshow(O);
level = graythresh(O);
BW = im2bw(O,level);
figure,imshow(BW);

