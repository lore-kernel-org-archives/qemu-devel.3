Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CC6CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90O-00050Q-Qq; Tue, 26 Mar 2024 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp90M-0004tu-GK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp90K-0001Lj-O9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-341c7c8adf3so2025540f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467983; x=1712072783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usUN06CXz0bBKoHDMc3RGiloPrjkbc783kJkw+v3z/k=;
 b=zL+i41wI2OQLyaW+F97VcEN78Tgz7Y7XJyWGQzfbgsZ9BBWGOSpDMH2++dJiFt+9Pq
 533oQhTszL7C8hHLwZhaEUprwHJVHabudjQ/0vgJY6le3GfPnEygtVvoWCf3Lp4EOmKI
 JbXPEYGmUk+gom7bFL4f5L/lgASqYu0DwQwyvR5UdCx6KffsYr7MNky+qsXNNd3+5kDH
 py305Y3F4zJBgKg3HjxZeqBREQzpJQqNefSUjoWGqDE1/vjNaEKmTq1a2j9qEECBNQ+D
 jjyFUZpRg/cHJjf8v/BGPiIbI0+8EmYpn4+biajxt1YCzUyjMzBe8TDiB9PXcwIUBoI5
 zMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467983; x=1712072783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usUN06CXz0bBKoHDMc3RGiloPrjkbc783kJkw+v3z/k=;
 b=QYgGkYNVB56+kwX6UYrRZuUUbzV/dyzVjvoNyNEKWzTnkGSyFlGfIBRxVdpq6jo3KX
 4Ke6LTu59Z/44VmvFpBZKV171DYWN15ZMYMn3caPxEOioWE7m4iyXsrIFfn3QgZTp8+S
 n49ifKqYJjbB7/Zhh2jeVsRH6JR8qoa54Z/cv/z2/ImTkzgwTno56L9XwRN/jqGIYf+4
 YKuC6oMbm5d8sQpcXwL8oCy+T4ZKHBuRxz/lqDo4BMsDfcMprEOu/8R1yrAxoDBNEEEs
 WQl1Cvaa7net5n5V+tck/Mjr5bSui2qLIuBWahLqpi8PO/rrN84nBhCwEfZX+g4vgsaB
 C2UQ==
X-Gm-Message-State: AOJu0YwBf6H0yVA5cdEMZApFhkuqd8bdHSsHrH6OMKm8q+FAMjVwVPx7
 8/zQ9yYIg3qohDxtM6s65UqHzDeoY8rfBjLiN7eC68D8uoJiN1TNf+KbGQ+TuGRMLwXLZfHZ736
 r
X-Google-Smtp-Source: AGHT+IGOf6ZEMSb7TpgL4kqO++Mk9y+JX94tncdO3Hs4TvnAcC68XNkXOg4saPupWEICcD/XP/0ftg==
X-Received: by 2002:a05:6000:2c1:b0:341:b836:6318 with SMTP id
 o1-20020a05600002c100b00341b8366318mr45533wry.11.1711467982753; 
 Tue, 26 Mar 2024 08:46:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 dk9-20020a0560000b4900b00341cb3489b7sm6710357wrb.71.2024.03.26.08.46.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:46:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 13/13] ui/cocoa: Use NSTrackingInVisibleRect
Date: Tue, 26 Mar 2024 16:45:04 +0100
Message-ID: <20240326154505.8300-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I observed [NSTrackingArea rect] becomes de-synchronized with the view
frame with some unknown condition, and fails to track mouse movement on
some area of the view. Specify NSTrackingInVisibleRect option to let
Cocoa automatically update NSTrackingArea, which also saves code for
synchronization.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240323-fixes-v2-3-18651a2b0394@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3efa8ac1a9..25e0db9dd0 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -307,7 +307,6 @@ static void handleAnyDeviceErrors(Error * err)
 */
 @interface QemuCocoaView : NSView
 {
-    NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
     BOOL isMouseGrabbed;
@@ -359,6 +358,19 @@ - (id)initWithFrame:(NSRect)frameRect
     self = [super initWithFrame:frameRect];
     if (self) {
 
+        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
+                                        NSTrackingMouseEnteredAndExited |
+                                        NSTrackingMouseMoved |
+                                        NSTrackingInVisibleRect;
+
+        NSTrackingArea *trackingArea =
+            [[NSTrackingArea alloc] initWithRect:CGRectZero
+                                         options:options
+                                           owner:self
+                                        userInfo:nil];
+
+        [self addTrackingArea:trackingArea];
+        [trackingArea release];
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
@@ -389,41 +401,9 @@ - (BOOL) isOpaque
     return YES;
 }
 
-- (void) removeTrackingRect
-{
-    if (trackingArea) {
-        [self removeTrackingArea:trackingArea];
-        [trackingArea release];
-        trackingArea = nil;
-    }
-}
-
-- (void) frameUpdated
-{
-    [self removeTrackingRect];
-
-    if ([self window]) {
-        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
-                                        NSTrackingMouseEnteredAndExited |
-                                        NSTrackingMouseMoved;
-        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
-                                                    options:options
-                                                      owner:self
-                                                   userInfo:nil];
-        [self addTrackingArea:trackingArea];
-        [self updateUIInfo];
-    }
-}
-
 - (void) viewDidMoveToWindow
 {
     [self resizeWindow];
-    [self frameUpdated];
-}
-
-- (void) viewWillMoveToWindow:(NSWindow *)newWindow
-{
-    [self removeTrackingRect];
 }
 
 - (void) selectConsoleLocked:(unsigned int)index
@@ -1314,7 +1294,7 @@ - (void)windowDidExitFullScreen:(NSNotification *)notification
 - (void)windowDidResize:(NSNotification *)notification
 {
     [cocoaView updateBounds];
-    [cocoaView frameUpdated];
+    [cocoaView updateUIInfo];
 }
 
 /* Called when the user clicks on a window's close button */
-- 
2.41.0


