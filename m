Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9BCC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIj8-0007Wj-9p; Sat, 17 Feb 2024 06:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIj3-0007Uk-On
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIj1-0002h4-Hy
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:21 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dba94f9201so13161295ad.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168758; x=1708773558;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rh6E8zcXhleUApU9zQlOU01Crb6mmE2x6guB2DANNRU=;
 b=VJWFjK2obYlqpLRU6QCuL+4eIp9Qv+Xggml9aaN2/YjB92A3ETco82OTcj8vBAdJ/7
 DfATdrz0dxekXPRn1DPCegmFL2ie6YjJKSTZqKLrIj0xbthNfaCRFaeJ31RwiCOgRvR7
 QuoX/rqlfURI7aap/y2lMbvI6cnyY5EO0auxP/2LfYSrfy2kWfQN9+k9hNaB13YDhxBw
 7BmtISpMpmCUqFvl12zVsUg2q2xScnOG/5a+53NECXlxEydvyIjpPtx3ir9HXKDh1qNP
 feMBIdIE2bxZtq1qGQCNnJdIx4PxnTl+Yi+Hr2EbH/7CRwu2YIZpR00NdkFP5+CksU8c
 loJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168758; x=1708773558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rh6E8zcXhleUApU9zQlOU01Crb6mmE2x6guB2DANNRU=;
 b=jqEe8ssHTI+hJf/76sNWdssE2pPuuzhHfS3ZOhATY4DeaZrP4M2oTG5mpd7V3+pTnY
 CH3/5T2zN5uSGYd4ekkwXUelQA0C8bJvaGMq+l8Apdgb8nEdohkTH6k6L2a4aDXaCnfc
 xelYJYcY5TxMFRY0Y4ch2Kj0BYKrbF99q3LorCllmGbt0OFF9hbj34/2imoEkhaPYbbl
 8DUI3C2kLQkcOCrxCdGsXN5mST63aB/jxTSADJrYfkxoNINJqXOf0njYkaki7/e6U8fX
 gFwh0A+lSYwVQBCJN+ZzsoIKiOxp5LofMWMDbw5Hamiqubzt5M14WRx73pzOU8sb5wyy
 6H6g==
X-Gm-Message-State: AOJu0Yy9aWVqp/BUHNucp2TTyLQdgcRWHEke7BU9AzizyghCtIC30sM1
 gJp6lCyalNd+B9rvD0NKabc8B4ikvi2dsEBAbmUvfa3Oyjd6NDU/leC8aP7nbQY=
X-Google-Smtp-Source: AGHT+IG5H0/MxAv32L/7aiqrpAU3y92JItd0nir3z896HPdvjyiO+V5cv0BQZh4i1BgVGLsdZryKTA==
X-Received: by 2002:a17:902:ccc8:b0:1db:aef3:ac06 with SMTP id
 z8-20020a170902ccc800b001dbaef3ac06mr4666484ple.4.1708168758419; 
 Sat, 17 Feb 2024 03:19:18 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 jw6-20020a170903278600b001d9620dd3fdsm1242592plb.206.2024.02.17.03.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:19:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:52 +0900
Subject: [PATCH v11 6/6] ui/cocoa: Remove stretch_video flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-6-0a17a7e534d4@daynix.com>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Evaluate [normalWindow styleMask] & NSWindowStyleMaskResizable instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 81de8d92669b..401ed0c3f1f5 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -103,7 +103,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -533,7 +532,7 @@ - (void) resizeWindow
 {
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
-    if (!stretch_video) {
+    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
@@ -1296,7 +1295,7 @@ - (BOOL)windowShouldClose:(id)sender
 
 - (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
 {
-    if (stretch_video) {
+    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
         return [cocoaView fixZoomedFullScreenSize:proposedSize];
     }
 
@@ -1377,8 +1376,7 @@ - (void)showQEMUDoc:(id)sender
 /* Stretches video to fit host monitor size */
 - (void)zoomToFit:(id) sender
 {
-    stretch_video = !stretch_video;
-    if (stretch_video == true) {
+    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
@@ -1650,7 +1648,7 @@ static void create_initial_menus(void)
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
-    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
@@ -2036,7 +2034,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
-        stretch_video = true;
         [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 

-- 
2.43.1


