Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF4EC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 06:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnuk6-0005x1-0J; Sat, 23 Mar 2024 02:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujy-0005tY-GR
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujv-0007f2-BC
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e8f51d0bf0so2223240b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711174821; x=1711779621;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9a+wseDHyW/HqtA3ozakI/wgiKhPEsw9cRXVXB7EC8c=;
 b=1LwpUwnwoIIcsI7NmbnPsNK9N1fNMulsZevfFPKbiTUuaLoYX6jWXu8FgA6Y1Buc6q
 zauUDBKqXLC9fwDJmV5WuQXF9s57ipHCjQCqrQ4SEGlH6F0sq62E2rouBX3mDTM171el
 f8P147q7ensJCTJ9FJ1xHpc97rLUyXrPoiDkqGcMyBnGSRM+emqJN88+o5rcEP8XPHcW
 BxLwwUtzBbhylPO41J7AmslyhfzcLnAs9FWL87z7PMGs3OjZlnpvOU/70Prti7PYww1u
 7XtyxPPa5WKxkw2aWlO7uamGldo3ry+P6zFmR2s86msmPPM29qrv1bmpSSr6l3wJDBqA
 YzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711174821; x=1711779621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9a+wseDHyW/HqtA3ozakI/wgiKhPEsw9cRXVXB7EC8c=;
 b=JYc3bBPicl1AN1HVPAAltMnVdNLvTFPnh/OlOMP2MUEU8h8uSB8jnEYFb+1YRYnBi6
 aKzIseWeGc7oRjcu2s99TbsEDrROgzOQzqH7CgNz/icPMItzX43tKHoQOyVbcur3hQaS
 65jT/80+h8Aj+t315uHomEHW+iZtIUhHTqnGUAq7qeMon116QCnS+YrwPPJ8XWEPlX6b
 xhR4WNQSD2IIvCOpJL8Se/3LTPiDNmv1NDqr50JtCY9NNfq4+8NNu5HUT+BoO6bRmJu2
 aIxk7CmdZeoMDqFj1zI2hsgFNNoTxchqht+N6mtAVNI/b9dIfNiKJrqdyohB9KNT3BrS
 pZUw==
X-Gm-Message-State: AOJu0Yzrx/phGgzawTxoVgihmjj+/QWqGzxyOzTBAlsp9dhB2EajFkbd
 aEwTYj5K3WrB30Du7tss7MwLQNSQDKDhWbCgVhoZRpYf7rIH1Xh/s2yjD0P1c5U=
X-Google-Smtp-Source: AGHT+IGAPNWW1fZoEYmZoZHzyC/I+CeMezcELxhai3dMHJyt9lVldEDALMf1QIz7C/Dr/ZDm/KS1Ww==
X-Received: by 2002:a05:6a21:7884:b0:1a3:4fcd:86e3 with SMTP id
 bf4-20020a056a21788400b001a34fcd86e3mr1841681pzc.42.1711174821404; 
 Fri, 22 Mar 2024 23:20:21 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 az2-20020a170902a58200b001e01176682dsm807582plb.27.2024.03.22.23.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 23:20:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 23 Mar 2024 15:20:03 +0900
Subject: [PATCH v2 3/3] ui/cocoa: Use NSTrackingInVisibleRect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-fixes-v2-3-18651a2b0394@daynix.com>
References: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
In-Reply-To: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

I observed [NSTrackingArea rect] becomes de-synchronized with the view
frame with some unknown condition, and fails to track mouse movement on
some area of the view. Specify NSTrackingInVisibleRect option to let
Cocoa automatically update NSTrackingArea, which also saves code for
synchronization.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3a1b899ba768..fb60debb9a8e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -306,7 +306,6 @@ static void handleAnyDeviceErrors(Error * err)
 */
 @interface QemuCocoaView : NSView
 {
-    NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
     QKbdState *kbd;
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
         kbd = qkbd_state_init(dcl.con);
@@ -392,41 +404,9 @@ - (BOOL) isOpaque
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
 
 - (void) hideCursor
@@ -1302,7 +1282,7 @@ - (void)windowDidExitFullScreen:(NSNotification *)notification
 - (void)windowDidResize:(NSNotification *)notification
 {
     [cocoaView updateBounds];
-    [cocoaView frameUpdated];
+    [cocoaView updateUIInfo];
 }
 
 /* Called when the user clicks on a window's close button */

-- 
2.44.0


