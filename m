Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E714C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEDy-0001lJ-Rd; Mon, 15 Jul 2024 01:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEDw-0001ek-W4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEDv-0000cU-79
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7163489149eso2850616a12.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721021166; x=1721625966;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZFkKq/AYFbP1nhs8BcE0hhSFScS/T8p6YkOLZvLOSgg=;
 b=B39YuR48wYg5x+UqddZnqafw/g7ocI7313t8jmrB4R/DrDwCugzvF4LyWv1TzjIzG4
 yJNUkakcAx/VgU9b2rpGR6Fu85H3NH/3+hPc3j2PjHVpmtqnNmECQGHXw9kRHwq+lI1C
 MZMdzuHphGCcmUzIgWw41Kg343EpI+JndmPQLMkXnMk6LtKt8nNnxtzRtCmVlZoX80on
 Oafs2JtzX3AitgpEgZlrVVudILyF1OoRnIw6Uj5mDVmRMmRry2/vVzi4DyOlhpbhZbYF
 O6xIkYUEfHwEY3ZfPyusdhEkv50nxhnz+RGqH5Oqn1cWeUkf0iSwBHMyW7bkYwNbNPyX
 GPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721021166; x=1721625966;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFkKq/AYFbP1nhs8BcE0hhSFScS/T8p6YkOLZvLOSgg=;
 b=K026Hqwhyb/E3SbGcEXGafH82XBETg6GHYyP9Mrku7W9VlBUPwyiEUjpD1+1ZO2Pts
 1RIC/jZNjXKEUroyfizFOhZ1zrGitIy/hc8JCe6EJ464zflvO6JARvVa1l0FNDwjoEmc
 oOGv8sEl3P6rcNasoKy8akdEQ13KlPMz7FrjuU2WBUf4XEh+gq5LvqsvoO+PpSckyJek
 uJTbBHdYURvDtLD7RH7knnb5wuHUh63e/uFGKWxSewAFeC9hvEa8UWHcbWv2swEa7FMU
 s9B7cw2krlg3p9iiBCRnplMSTE0RhvpyCHJ6VZ7wybjC5OzaqXZQcz6RjR4/tfAxJOtI
 O5XA==
X-Gm-Message-State: AOJu0YwT77c6TgkhAbl6ro7lNzOg/HY/mrrjES3uDcJL8tJ7jQ0x+9b0
 GBNFhtHmVZWurnRSY0oQ0ajyMV+ecukanQYu0HlNlckxyaDnyoSlrnUyizVRaLs=
X-Google-Smtp-Source: AGHT+IGZKmvxNVMzMR1/cDVyYE1jnjsAKt5pFh4eDQmFv+FGb598OxvFvjW3keiaZuIQvb7px6yDTA==
X-Received: by 2002:a05:6a21:9997:b0:1c2:92ad:3331 with SMTP id
 adf61e73a8af0-1c2980f943dmr24235367637.2.1721021165862; 
 Sun, 14 Jul 2024 22:26:05 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc3c768sm32580055ad.233.2024.07.14.22.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:26:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:25:42 +0900
Subject: [PATCH v3 1/4] ui/cocoa: Release CGColorSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-cursor-v3-1-afa5b9492dbf@daynix.com>
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
In-Reply-To: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
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


