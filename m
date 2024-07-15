Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D975C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEX2-0005XB-Uz; Mon, 15 Jul 2024 01:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEX1-0005W1-1b
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:45:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEWy-0005hT-UQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:45:50 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-75e7e110e89so2089893a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721022347; x=1721627147;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJ0CdL+PtiKVqbnuQj7qHH9Vx9h9q/Bc0tYx3a9MMek=;
 b=0c6RKJuNpYAEwNqjqrlSdOTID64SI+LepvTtkR53NywO95ZQmmJDqi4q+XTh3KYjKZ
 p9OFA1qlmU+TFIyQ092JdHTtboW2GQyD7EZsjlPL+9P9ZKtBC68coi8wenLPQRClhGYv
 4iGavJiOVkFRh3zAbvKwBhLNcDAokNBONW9ub+mpdePDF6yG5M+i0hj3n/YzTHaAbSCQ
 6Jgt9V5/MWD7s8WGX+gc4cRW/oBQzF8MUGQ9HvVw0+MdugJHdKs7hS6pyCA/RwNWFmzI
 M1dgmZoPoLyclC/utWBS42cFvh9/NVQvUjI3g18hcnKqxc3Kl/5rBJLL8Y5pSBF/zg2G
 YOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721022347; x=1721627147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJ0CdL+PtiKVqbnuQj7qHH9Vx9h9q/Bc0tYx3a9MMek=;
 b=kS4wjJQi5xTKM5HsReId3iNQQGmG4MbJfVcitd5dcTOUw+0wZDpFP2Miba+r1Z+Xew
 fYS+ylsiKatb4RovgXL3/GnLV+ovb7IcyBP5AEZlyfiC3nI6vIHtdlR18YRKHz+O7BaE
 g9zrhizZvdOPSfRXKcpRcY3y4fKaUMDbfEh+9osVK+VquwDaT7rwotwcNAzBuh0CE9Ik
 JeV1bUKaLjkzakb+K/0rBxFF5P3DOKd2Ju+AetqiEI1fP/FikcVQSA/o5GYIi8T7eM2v
 AXq1PSI97R7290hF6tl+ZHuw0tiTJGDjX+VtJyJy0cTE0MmURv4I4tkya4LgG5E4/qL+
 Ty6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvXqZrYiXmY3TWRuBDiE5IK30G4JD+/IHdsWiXH1ROF5Ma1nYZ6Y1512rcaZPdmy2m/4hsMK2OMuAR/anGAj/aMV68Y1U=
X-Gm-Message-State: AOJu0YyJLoXToPNPz4Z2cH7bMpzrsA74VK2vz74UBwFcZ2oPtZOGYWvA
 UVWQjQ+JeN8GqKBzx+2pDzwx9KzOXP9uWyWmX3MMjbT0J29s6LUMA6tTHQxqny4=
X-Google-Smtp-Source: AGHT+IEO4J0U2KiRSv1O+uMtbF05ikcqx22f4XyyYZ2QW0h9ltoHn5y8Xm3xITaXACLgV39r1HCvHg==
X-Received: by 2002:a05:6a20:6a05:b0:1bd:28b9:6f88 with SMTP id
 adf61e73a8af0-1c29821accamr20308421637.24.1721022347363; 
 Sun, 14 Jul 2024 22:45:47 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bb73ea1sm31824795ad.34.2024.07.14.22.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:45:47 -0700 (PDT)
Message-ID: <f8b2badd-c0c0-452a-a1cf-0a85467013ee@daynix.com>
Date: Mon, 15 Jul 2024 14:45:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ui/cocoa: Wraps CGImage creation in helper function
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com, 
 lists@philjordan.eu
References: <20240706204345.99392-1-phil@philjordan.eu>
 <20240706204345.99392-4-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240706204345.99392-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024/07/07 5:43, Phil Dennis-Jordan wrote:
> This reduces the incidental complexity of the screen update draw and
> cursor conversion functions and minimally reduces overall code size.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   ui/cocoa.m | 85 +++++++++++++++++++++++++++---------------------------
>   1 file changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 309d1320d7..36abb679d0 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -292,6 +292,39 @@ static void handleAnyDeviceErrors(Error * err)
>       }
>   }
>   
> +static CGImageRef create_cg_image(void *data, unsigned width, unsigned height,
> +                                  size_t stride, unsigned bpp, unsigned bpc,
> +                                  bool use_alpha, CGColorSpaceRef colorspace)

The choice of parameters looks arbitrary. The number of bytes per pixel 
(4ul) and CGBitmapInfo are hardcoded while the other parameters are not. 
Having a function that simply hardcodes some parameters of another 
function while passing through the others makes little sense; such a 
function will be no use once some parameters change.

However I do see some benefit in extracting the pair of 
CGDataProviderCreateWithData() and CGDataProviderRelease() into a 
function. A better design of this function would be to pass through 
parameters of CGImageCreate() while deriving the parameters of 
CGDataProviderCreateWithData() from them.

I also suggest moving this function into QemuCocoaView. QemuCocoaView 
has its colorspace defined so its method can assume that defined colorspace.

Regards,
Akihiko Odaki

> +{
> +    CGImageRef image;
> +    CGDataProviderRef provider;
> +    CGBitmapInfo bitmap_info = kCGBitmapByteOrder32Little
> +        | (use_alpha ? kCGImageAlphaFirst : kCGImageAlphaNoneSkipFirst);
> +
> +    provider = CGDataProviderCreateWithData(
> +        NULL,
> +        data,
> +        4ul * width * height,
> +        NULL
> +    );
> +    image = CGImageCreate(
> +        width, //width
> +        height, //height
> +        bpc, //bitsPerComponent
> +        bpp, //bitsPerPixel
> +        width * 4ul, //bytesPerRow
> +        colorspace, //colorspace
> +        bitmap_info, //bitmapInfo
> +        provider, //provider
> +        NULL, //decode
> +        0, //interpolate
> +        kCGRenderingIntentDefault //intent
> +    );
> +
> +    CGDataProviderRelease(provider);
> +    return image;
> +}
> +
>   /*
>    ------------------------------------------------------
>       QemuCocoaView
> @@ -464,7 +497,6 @@ - (void)setMouseX:(int)x y:(int)y on:(bool)on
>   
>   - (void)setCursor:(QEMUCursor *)given_cursor
>   {
> -    CGDataProviderRef provider;
>       CGImageRef image;
>       CGRect bounds = CGRectZero;
>   
> @@ -480,28 +512,12 @@ - (void)setCursor:(QEMUCursor *)given_cursor
>       bounds.size.width = cursor->width;
>       bounds.size.height = cursor->height;
>   
> -    provider = CGDataProviderCreateWithData(
> -        NULL,
> -        cursor->data,
> -        cursor->width * cursor->height * 4,
> -        NULL
> -    );
> +    image = create_cg_image(
> +        cursor->data, cursor->width, cursor->height,
> +        cursor->width * 4 /* bytes per row */,
> +        32 /* bits/pixel */, 8 /* bits/component */, true /* alpha */,
> +        colorspace);
>   
> -    image = CGImageCreate(
> -        cursor->width, //width
> -        cursor->height, //height
> -        8, //bitsPerComponent
> -        32, //bitsPerPixel
> -        cursor->width * 4, //bytesPerRow
> -        colorspace, //colorspace
> -        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
> -        provider, //provider
> -        NULL, //decode
> -        0, //interpolate
> -        kCGRenderingIntentDefault //intent
> -    );
> -
> -    CGDataProviderRelease(provider);
>       [CATransaction begin];
>       [CATransaction setDisableActions:YES];
>       [cursorLayer setBounds:bounds];
> @@ -533,25 +549,11 @@ - (void) drawRect:(NSRect) rect
>           int bitsPerPixel = PIXMAN_FORMAT_BPP(format);
>           int bitsPerComponent = PIXMAN_FORMAT_R(format);
>           int stride = pixman_image_get_stride(pixman_image);
> -        CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(
> -            NULL,
> -            pixman_image_get_data(pixman_image),
> -            stride * h,
> -            NULL
> -        );
> -        CGImageRef imageRef = CGImageCreate(
> -            w, //width
> -            h, //height
> -            bitsPerComponent, //bitsPerComponent
> -            bitsPerPixel, //bitsPerPixel
> -            stride, //bytesPerRow
> -            colorspace, //colorspace
> -            kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst, //bitmapInfo
> -            dataProviderRef, //provider
> -            NULL, //decode
> -            0, //interpolate
> -            kCGRenderingIntentDefault //intent
> -        );
> +
> +        CGImageRef imageRef = create_cg_image(
> +            pixman_image_get_data(pixman_image), w, h, stride,
> +            bitsPerPixel, bitsPerComponent, false /* no alpha */, colorspace);
> +
>           // selective drawing code (draws only dirty rectangles) (OS X >= 10.4)
>           const NSRect *rectList;
>           NSInteger rectCount;
> @@ -571,7 +573,6 @@ - (void) drawRect:(NSRect) rect
>               CGImageRelease (clipImageRef);
>           }
>           CGImageRelease (imageRef);
> -        CGDataProviderRelease(dataProviderRef);
>       }
>   }
>   

