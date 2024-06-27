Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMn8Q-0004Dj-A6; Thu, 27 Jun 2024 07:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8N-0004DM-QE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8M-0000SE-6N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fa0f143b85so41940585ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719487065; x=1720091865;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+0MBOmhbtz1lyAbOdZb3RFV2v8aK9qDzLjqTtuOILhg=;
 b=aVpESaxCtpddr3pqSDHFwTEH6CLXmB+h0HLfUCtiXmn7ZjfAjz1nLKdALGhXXybfYw
 ganTfEIIvtZWsCLxEWCHWmnf6VXQQc2ZmH9vb9N/VWg7lQpU42/Nu9JIHMthOpf5PHbV
 UIOB59vBO79lxdhZ3jI9z0IWCUbuoAa8wz6De+N6AN+Fv9XP4V4sjuRV76pOHt81Osh6
 GrRUN5eVwt9BKnrZKKrSUih9RoEUfEGcXV5yOyxosUMZuSWYSzMFfp7zKEyYiGERHnuh
 ge+vyls9STdwGwSGZgrqbwAFbMwDR/SvBfzrNJShITUQRn8rGZ5kiiCcHnqv0TJJroFE
 V5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719487065; x=1720091865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0MBOmhbtz1lyAbOdZb3RFV2v8aK9qDzLjqTtuOILhg=;
 b=DAXbWuF87idr3ehccPFgQ9aikrb/Y0O67oeF/9xEnGHW6jnTqRNx+QZ7Eedp+QKkOJ
 hZ+LeZPjhdNB7jvJTO0NBKha3ISXGE2wmJ8xea2IbJ3TSV2zmn/Mrc5OJqwh4yg7xaTp
 yaHsONBjMgKR1c52tdPdnxl5Cy4CioysdVRx/R0e1R+2nVQHT9kxD4hPtVEiCSoMU3+T
 X124pmLooC4X5ztS+qC6g09Hpu4SOHiIO5gOGhvDY7iqApoKNxwlrICQ/V8W/5n9vMwy
 eB/PNPR3rNLSqCFfinxl8i8wMoQp+wb8dSordkxLaNMIDoG/vGlUXS3emUuC++DFivT9
 l2Pw==
X-Gm-Message-State: AOJu0YxqqIcgZpkU1Nd77fh5VfkJ12kKYGLxNIeo0rmQS0QkQTQmZzqc
 CKH5TtifYOgt5M/ml0/vXtGcnldlwXjvJb2zGUrNlEGfSbZXFboDJ9sbWXq7Ap0=
X-Google-Smtp-Source: AGHT+IHZoBPxo8wvKyYnk+m0uKlaX+bMxaB2yPURoUti6HmVmC1MoQYITT1XeX5mbLU+PBUKrcRZXA==
X-Received: by 2002:a17:902:f611:b0:1fa:a50c:def9 with SMTP id
 d9443c01a7336-1faa50ce0b7mr23427225ad.57.1719487064821; 
 Thu, 27 Jun 2024 04:17:44 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac8f5a93sm10960755ad.77.2024.06.27.04.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:17:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 20:17:33 +0900
Subject: [PATCH v2 1/4] ui/cocoa: Release CGColorSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-cursor-v2-1-c3cd3ee35616@daynix.com>
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

CGImageCreate | Apple Developer Documentation
https://developer.apple.com/documentation/coregraphics/1455149-cgimagecreate
> The color space is retained; on return, you may safely release it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 981615a8b925..908454a434c5 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -299,6 +299,7 @@ @interface QemuCocoaView : NSView
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
+    CGColorSpaceRef colorspace;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -360,6 +361,7 @@ - (id)initWithFrame:(NSRect)frameRect
         [trackingArea release];
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
+        colorspace = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
@@ -380,6 +382,7 @@ - (void) dealloc
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
2.45.2


