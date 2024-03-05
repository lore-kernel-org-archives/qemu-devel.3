Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9122EC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSdy-0001iY-6k; Tue, 05 Mar 2024 06:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSds-00014l-7m
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:28 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSdp-0002yE-8h
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:07:27 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a458eb7db13so121856566b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636843; x=1710241643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6n73qW0ydBRSB1J+ZYz20Ufnelrw0ubO1rh+yoO1Cs=;
 b=G5CZUp5J6nmQqFFIniPu2h8MCQXloNt2FG34aqq+VZP2dh3ofeCfS/SyEM40I/3Wen
 J1lC2KkuX5x3anyHQ6DJ6HwWK0MJLa7Fdww34jpKltVDC+zSWWERJdC8TeTSSIylhoYQ
 w6jn3i7lDmi07OiXEVvxBl5V3YGU/Jtz6cC1Zw7HDPfY7eU8JGoQO8gymp+aO1xDZTSR
 CtAdTJzohV/84EQ5CWrTNMMKwXja9fmZLWvzZExA1vr7koOqpRsAo0awIbZvk7ZrH46o
 tqzJXsG6rg3p7mxn3kkv65NPcpM8S22R8khNgEZPRdhZfFRYs2vdQ2pQvXJzgqJb85yL
 VZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636843; x=1710241643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6n73qW0ydBRSB1J+ZYz20Ufnelrw0ubO1rh+yoO1Cs=;
 b=agNGzkmy6a3Bd/31Dv56KAfFnrRSIL384Dwvv4McCHkXrPS/5g7KJL9p0vZAjvw2Zf
 hVxVhwx1kbTQwJ/JdTw1dvzNFTeanMOFMyqV/a1L7FJ8A1T6cjBac4ZUduIV9pcmLU6+
 NOEFJTBKvPnUttbShQtOeb6i5NTTufYBvQrXZuxKLW6UTFXtk/+BhzuOce36giUo50pO
 nB+fcr+Fd5eWWShPKeVbkqYaGdIQNBs+LcAZWWQG2LBzOMPqC6tBSj5rimdy32ZgtZ8w
 zQfJWSviGt/gTF7BWQifhPHbVlNLcqX//syCNkzThJednAChNmyz3+atoho3hCK9T7LA
 dN6g==
X-Gm-Message-State: AOJu0YyptAp/XWfQlG+KQXuTOVnCWpKzW9EgtxNMgxZ5ejisFh2nY3Zp
 9XXJSJlNpK1SlZPfR2OIhazfNiCSlXuztzT9gUyZUJh8lncdOCvkKvWk0ZX9McEQB9w4v1Db7F3
 V
X-Google-Smtp-Source: AGHT+IGsJ0xA5gp5PVLE4hvnhzm2/1SP6fLDnyp7I+pjOUCbEbIKp7wGAHBFhCbuSynMdoYC466y4w==
X-Received: by 2002:a17:906:bc54:b0:a43:f182:66c4 with SMTP id
 s20-20020a170906bc5400b00a43f18266c4mr8561650ejv.17.1709636843351; 
 Tue, 05 Mar 2024 03:07:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 lm7-20020a170906980700b00a449fdfe27bsm4588465ejb.170.2024.03.05.03.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:07:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/12] ui/cocoa: Remove stretch_video flag
Date: Tue,  5 Mar 2024 12:06:07 +0100
Message-ID: <20240305110608.21618-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240224-cocoa-v12-10-e89f70bdda71@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index bc63043158..fa879d7dcd 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -106,7 +106,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
 static CGInterpolationQuality zoom_interpolation = kCGInterpolationNone;
 static NSTextField *pauseLabel;
 
@@ -522,7 +521,7 @@ - (void) resizeWindow
 {
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
-    if (!stretch_video) {
+    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
@@ -1354,15 +1353,10 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
-        [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
-        [sender setState: NSControlStateValueOn];
-    } else {
-        [cocoaView window].styleMask &= ~NSWindowStyleMaskResizable;
-        [cocoaView resizeWindow];
-        [sender setState: NSControlStateValueOff];
-    }
+    NSWindowStyleMask styleMask = [[cocoaView window] styleMask] ^ NSWindowStyleMaskResizable;
+
+    [[cocoaView window] setStyleMask:styleMask];
+    [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
 }
 
 - (void)toggleZoomInterpolation:(id) sender
@@ -1638,7 +1632,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [[cocoaView window] styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom Interpolation" action:@selector(toggleZoomInterpolation:) keyEquivalent:@""] autorelease];
     [menuItem setState: zoom_interpolation == kCGInterpolationLow ? NSControlStateValueOn : NSControlStateValueOff];
@@ -2027,7 +2021,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [cocoaView window].styleMask |= NSWindowStyleMaskResizable;
     }
 
-- 
2.41.0


