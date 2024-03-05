Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E78C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdR-00085I-Ju; Tue, 05 Mar 2024 06:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdK-0007ue-Bj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:54 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdG-0002o1-89
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:53 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso7948390a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636807; x=1710241607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEncxItvyBuKzeJwaGvPvRwTlJqcX1dHZlco9vuriMg=;
 b=MYfIyrQ6angPUoj52gNZRbOnQHpige8CSZv8khb+kr9S250dK8VOEihxva/gA9dohR
 URVVvcZC7FfGCLs6l0PeAbM0cxgquT2HtSfvkItO/LiANSu3Wcj4Ck48/1Yat7pAAtm2
 8hGFDLryQWUWk08tKjAg2zIx/5+KMLhGS8jG1dFg12gxacs5MWmA0u1S3ulEOejmTOPV
 jEScj3aeYaXIr/4jFcaySuB4dd9cwO9vzh5xycUoPZKb7wHJo77jT0XJcSshGC2GVFYs
 OuOlPWg0R1W7GM1/3ejEDvG6H4fILnt0AMyhhkgnoUketRop80BpKeP2j8f3FPUcBsvr
 vzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636807; x=1710241607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEncxItvyBuKzeJwaGvPvRwTlJqcX1dHZlco9vuriMg=;
 b=IVzki+chIfwoYuPOG7weDniAsvQcpYcIJJuhznXAhjqwf4FrtYoV6fbPi3MRZT43hu
 VE9G/4Nh8ChoSZQVsInwuWnNyg8dmOmnrf7024qofnVXDDSYWghSe2md/47T/4L0UTtD
 t7m1mhOE5oj4Wz7wHpkR1Q+UoAJPlgBK24yViTk+P0EAkOGIOmw0xH1LTf1HdGnFmWiG
 peg4764mtVAGVs/c1q4Yerwrh97Vf0Tk+Mg24YtmW6lEsB5Z0olvGF8M/TQkR0kI7CRO
 fLKh5eyMUjweFG2o2G+MNu+FHgnWASi2g2XcijsYJQ/6OY2iN2tKcfcXICPiZ+qolmfQ
 LK8A==
X-Gm-Message-State: AOJu0YxMehvtw1i4Fb8KpFlpXNL3rbokvzXAGTM0WaLICWJSgX20AgVY
 mLHSuviohMnNCfX2/VP4n2IHOo7+AgrN8xf68QIJoRb1dw3Urt0LqV3oe3tuXeaMnexluDw/zTf
 E
X-Google-Smtp-Source: AGHT+IF3ddaKtcRlwCfehtOqa/HERFAb64KMXn3vaCo1qkGWJO7yXhJNdFH7drkiqYVg/9kZ9xX/mg==
X-Received: by 2002:a17:906:a24f:b0:a45:aa4a:6495 with SMTP id
 bi15-20020a170906a24f00b00a45aa4a6495mr804115ejb.37.1709636806828; 
 Tue, 05 Mar 2024 03:06:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a1709064a0900b00a44f0d99d58sm3477672eju.208.2024.03.05.03.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/12] ui/cocoa: Scale with NSView instead of Core Graphics
Date: Tue,  5 Mar 2024 12:06:01 +0100
Message-ID: <20240305110608.21618-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Core Graphics is not accelerated and slow.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-4-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e156527082..6e8cd24e88 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -504,10 +504,8 @@ - (void) drawRect:(NSRect) rect
 
         [self getRectsBeingDrawn:&rectList count:&rectCount];
         for (i = 0; i < rectCount; i++) {
-            clipRect.origin.x = rectList[i].origin.x / cdx;
-            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
-            clipRect.size.width = rectList[i].size.width / cdx;
-            clipRect.size.height = rectList[i].size.height / cdy;
+            clipRect = rectList[i];
+            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
             clipImageRef = CGImageCreateWithImageInRect(
                                                         imageRef,
                                                         clipRect
@@ -553,6 +551,11 @@ - (void) setContentDimensions
     }
 }
 
+- (void) updateBounds
+{
+    [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
+}
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -642,6 +645,7 @@ - (void) switchSurface:(pixman_image_t *)image
         screen.height = h;
         [self setContentDimensions];
         [self setFrame:NSMakeRect(cx, cy, cw, ch)];
+        [self updateBounds];
     }
 
     // update screenBuffer
@@ -1305,6 +1309,7 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
 
 - (void)windowDidResize:(NSNotification *)notification
 {
+    [cocoaView updateBounds];
     [cocoaView updateUIInfo];
 }
 
@@ -1967,16 +1972,7 @@ static void cocoa_update(DisplayChangeListener *dcl,
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        NSRect rect;
-        if ([cocoaView cdx] == 1.0) {
-            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-        } else {
-            rect = NSMakeRect(
-                x * [cocoaView cdx],
-                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-                w * [cocoaView cdx],
-                h * [cocoaView cdy]);
-        }
+        NSRect rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
         [cocoaView setNeedsDisplayInRect:rect];
     });
 }
-- 
2.41.0


