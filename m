Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CCEC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmdV-0001b4-PT; Tue, 16 Jul 2024 14:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdF-0000fM-AG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdC-0001HM-BM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4279ca8af51so36334045e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153428; x=1721758228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXyrM2tLHAmHfdAt3y0LUG4EVP52RhZxQbundRVG0Yk=;
 b=CgOdY1rdX/R+0iYabBrqhZX/UUZ6usnVkGKR3gaIG8754cW0nmV/wAZNDeFv8XRW+Z
 unDaJ57AN+ApG47d3SogWvKDFkFzA9+apxm+wMZtLPxkp+kUNo13ne9alhxKon5PAyEC
 /OVyKzNTFRo7FQT5XYw3f4qjz3XeOP00q5WgtZG+LV4/IvV23pRc7e/WuvK07yIbIVLm
 eP+LRnYxD2fOZ8lpI5y4ONHXf0c4ckdYcYYC/OTS4DE6EfRsyXdIh6Cjcn9UzJUWHjEi
 ncIqFFDc9VVTSz6APhQAxgwNTpjG5yB8ZvzhDTwQuB6n8n0OINznBkMlnQlVsvVi+4uK
 FW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153428; x=1721758228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXyrM2tLHAmHfdAt3y0LUG4EVP52RhZxQbundRVG0Yk=;
 b=bqN4qCRW0bH4KG1AvMKis3xVTkhKO784AsELvE5+EabBcOrgp6gXSrs2RnM5T+6+eo
 EHasbOKMMmeyIdGVlTZuqTJPL7GfWFv045KWJz8S7ZNJ/SQ6+pVn5FlQDsE+zVF+FJff
 azo6n7HNW0OwQm/E/GToeFa5c0Ejqu9PyOzmnGO1zAeM2VSGX9+VgLHSFhFQ4tyzFDUY
 gOpph8UPA7saGyYn68MBKT0tO596/Nzl46ptNjagYkekvt4c6ACGHPtOBg+47Tpn5/39
 ZvRdYLEYTw0Qhz7tBKJxPQgxvMW6qxGMm1QbDIwzLCUaVPygPLSxa43CpwA17iDFZl/O
 InTQ==
X-Gm-Message-State: AOJu0YzEp6xlt3whbGARUrTl6L+6yqrUESp1kNvp1smyYW/fjxks2JD3
 G0q53S/sKToENaNl3IEEKumZ8CdijEG9xw3trz/MdTHq3/cleKWxYvKvI43M0pOkmi/vOUOk1k8
 /lRtw9g==
X-Google-Smtp-Source: AGHT+IFYPsh45bPgDYPiaEsXzn5InYH6oWDA2rxJh5e/B5UAxqVbg9egiUwT0wMJZL+6Jbhi8NIimw==
X-Received: by 2002:a05:600c:468e:b0:426:67f0:b4fa with SMTP id
 5b1f17b1804b1-427ba655261mr22919295e9.1.1721153427828; 
 Tue, 16 Jul 2024 11:10:27 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e8387fsm136156095e9.20.2024.07.16.11.10.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/13] ui/cocoa: Release CGColorSpace
Date: Tue, 16 Jul 2024 20:09:35 +0200
Message-ID: <20240716180941.40211-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

CGImageCreate | Apple Developer Documentation
https://developer.apple.com/documentation/coregraphics/1455149-cgimagecreate
> The color space is retained; on return, you may safely release it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240715-cursor-v3-1-afa5b9492dbf@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2935247cdd..79a054b128 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -307,6 +307,7 @@ @interface QemuCocoaView : NSView
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
+    CGColorSpaceRef colorspace;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -359,6 +360,7 @@ - (id)initWithFrame:(NSRect)frameRect
         [trackingArea release];
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
+        colorspace = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
@@ -379,6 +381,7 @@ - (void) dealloc
         CFRelease(eventsTap);
     }
 
+    CGColorSpaceRelease(colorspace);
     [super dealloc];
 }
 
@@ -456,7 +459,7 @@ - (void) drawRect:(NSRect) rect
             DIV_ROUND_UP(bitsPerPixel, 8) * 2, //bitsPerComponent
             bitsPerPixel, //bitsPerPixel
             stride, //bytesPerRow
-            CGColorSpaceCreateWithName(kCGColorSpaceSRGB), //colorspace
+            colorspace, //colorspace
             kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst, //bitmapInfo
             dataProviderRef, //provider
             NULL, //decode
-- 
2.41.0


