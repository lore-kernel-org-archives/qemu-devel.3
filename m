Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76458C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfe-0001SK-TV; Thu, 13 Feb 2025 11:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfU-00019R-Bl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfR-0005ga-5E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAa0SpJOhaviYKcQwZDtYWFA+1EBiCd0TLgglhF27bI=;
 b=fJxDxCMwUo+vESqIeRd3oiOI9dr45hC/9/oOL35EN+Y1KhY10mXp0H5F7fRcp6XdfvvGfL
 PRnupgglG21tlvePBtEs3rDjP3CKi2BfkVXWerps0cj4dsJ57GRiNynihy0Wn1DCR4mweN
 M1yBRKijbo66+jGi9EBlkBWeBBnoOJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Y4heQnClOlG8JmTaVcZQrQ-1; Thu, 13 Feb 2025 11:02:18 -0500
X-MC-Unique: Y4heQnClOlG8JmTaVcZQrQ-1
X-Mimecast-MFC-AGG-ID: Y4heQnClOlG8JmTaVcZQrQ_1739462538
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dd533dae6so476084f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462537; x=1740067337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAa0SpJOhaviYKcQwZDtYWFA+1EBiCd0TLgglhF27bI=;
 b=u+VORsuWz23HXTy4LwKjrJPYQBTpDPgx3TP1ACSQy0GB8wzNpbuZCAYtnlRcS8XW7Z
 QnP1N0MFurTWBNi5t6rJfSF0n5YbkLXJitU38GQGLCRXqIKPrJtVCtBOdEdQIChs5kMM
 oK+idBA1GsKkWrVYCJvzzGUI8GmHkK6BaiCaP6xO4YZ0bpDRVdR5nC2c5CT14vgyZz8X
 kWXuX2H3/96eOAwM/wL4SvjCJRC51q1lTJZhMAhdU/wwaufl81kN4HdB6Eo/tT4d2Wwb
 cjTe0/Yo5604lzx7OLthWYHQoEAwlL2CnKz8D9/WVp1FYecFE9wxDIF1jluNthXN0bKd
 DxLA==
X-Gm-Message-State: AOJu0YyebYFHJBOVCLoGIiakMC02Rlw5zKeiMb77EtNLixV3pNBD4N1F
 Y9rMrPglS/qnCQrL4AX5bhkE73KiYg2UO93M4MchCchMYKfnuT7JYy0LqXuagVZvWsyWsWNd+PN
 dR2RYwFSGkh+l4nSD+grOTT1Huq3SU06mESF35+JWdjqWp+ssYeVug0Ljrk4nvs7lD+JM7opLjE
 RpSGEIbHjjCNIGjyME2gO7auywwQhpWraGXrT4SEk=
X-Gm-Gg: ASbGncv78HtK7dqkqNGB+miA9mO3oQj2Vr/X13qcQw1swu/M35W8aBkaOqZcJ/Bp1Q5
 FJCmY1vSDJhOrDdrH5J4RPC8Y3xhd1aBWuyGnmA30jeclHLqaXCd8hjlOe93rT2DedAo0x1a+Hi
 ysAOYJgjbQTdWiSsb7uMaX7fMSTbV8hgm3yRU1IDXaYlzChe/ConhK9y5Zgu0sF19P6cLE3Aoj4
 3DI+QlwH7sS+VrrKEISTJRva8H3qWykv1j+6/zdtLi23EQDHWNMPDuevpNdmLgbAYUOa6jwk+lw
 7oz4/UknaRTvXXaUXAP3dQcQ12CeNRqQF9a9MvxeDSSGRQ==
X-Received: by 2002:a5d:5f55:0:b0:38d:b0fe:8c99 with SMTP id
 ffacd0b85a97d-38dea2ebbd1mr8558459f8f.48.1739462535699; 
 Thu, 13 Feb 2025 08:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH05DZOGx7lO/0Wri7A8Tlyc31kB2zVkd29y1pQEpDWm9DlXIKKsWEZCIbncTUQp/sjVPKzQA==
X-Received: by 2002:a5d:5f55:0:b0:38d:b0fe:8c99 with SMTP id
 ffacd0b85a97d-38dea2ebbd1mr8558151f8f.48.1739462533427; 
 Thu, 13 Feb 2025 08:02:13 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8dd6sm2270907f8f.62.2025.02.13.08.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:02:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 27/27] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
Date: Thu, 13 Feb 2025 17:00:54 +0100
Message-ID: <20250213160054.3937012-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

Windows only:

The libSDL2 Windows message loop needs the libSDL2 Windows low
level keyboard hook procedure to grab the left and right Windows
keys correctly. Reenable the SDL2 Windows keyboard hook procedure.

Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
out the special left Control key event for every Alt Gr key event
on keyboards with an international layout. This means the QEMU low
level keyboard hook procedure is no longer needed. Remove the QEMU
Windows keyboard hook procedure.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Link: https://lore.kernel.org/r/20241231115950.6732-1-vr_qemu@t-online.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/sdl2.c      | 26 --------------------------
 ui/meson.build |  4 ----
 2 files changed, 30 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 445eb1dd9f9..cda4293a53e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -32,7 +32,6 @@
 #include "system/runstate.h"
 #include "system/runstate-action.h"
 #include "system/system.h"
-#include "ui/win32-kbd-hook.h"
 #include "qemu/log.h"
 #include "qemu-main.h"
 
@@ -263,7 +262,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
-    win32_kbd_set_grab(true);
     sdl_update_caption(scon);
 }
 
@@ -271,7 +269,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab = 0;
-    win32_kbd_set_grab(false);
     sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
@@ -372,19 +369,6 @@ static int get_mod_state(void)
     }
 }
 
-static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
-{
-#ifdef CONFIG_WIN32
-    SDL_SysWMinfo info;
-
-    SDL_VERSION(&info.version);
-    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
-        return info.info.win.window;
-    }
-#endif
-    return NULL;
-}
-
 static void handle_keydown(SDL_Event *ev)
 {
     int win;
@@ -609,10 +593,6 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
-        win32_kbd_set_grab(gui_grab);
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
-        }
         /* fall through */
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
@@ -628,9 +608,6 @@ static void handle_windowevent(SDL_Event *ev)
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(NULL);
-        }
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
@@ -870,10 +847,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
-#ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
-#endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
diff --git a/ui/meson.build b/ui/meson.build
index 28c7381dd10..35fb04cadf3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -120,10 +120,6 @@ if gtk.found()
 endif
 
 if sdl.found()
-  if host_os == 'windows'
-    system_ss.add(files('win32-kbd-hook.c'))
-  endif
-
   sdl_ss = ss.source_set()
   sdl_ss.add(sdl, sdl_image, pixman, glib, files(
     'sdl2-2d.c',
-- 
2.48.1


