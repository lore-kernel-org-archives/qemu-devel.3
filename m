Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD3AE6FE49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 06:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snXgy-0004H6-8K; Mon, 09 Sep 2024 02:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXgw-0004FS-0m
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:02 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXgu-0003T9-CB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:01 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout07.t-online.de (Postfix) with SMTP id AB9F738DC;
 Mon,  9 Sep 2024 08:15:58 +0200 (CEST)
Received: from linpower.localnet ([93.236.144.183]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1snXgr-0s6EZV0; Mon, 9 Sep 2024 08:15:57 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id DC322200442; Mon,  9 Sep 2024 08:15:52 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/3] ui/sdl2: ignore GUI keys in SDL_TEXTINPUT handler
Date: Mon,  9 Sep 2024 08:15:52 +0200
Message-Id: <20240909061552.6122-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1725862558-4E7F241D-0244F0DC/0/0 CLEAN NORMAL
X-TOI-MSGID: 9d54a0aa-9e48-48e4-869c-87dc911b8714
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Ignore GUI keys for SDL_TEXTINPUT events, just like GUI keys are
ignored for SDL_KEYDOWN events. This prevents unintended text input
in a text console when hiding the text console with the GUI keys.

The SDL_TEXTINPUT event always comes after the SDL_KEYDOWN event.
See libsdl-org/SDL issue #1659.

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 include/ui/sdl2.h |  1 +
 ui/sdl2.c         | 17 +++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 6907115809..dbe6e3d973 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -42,6 +42,7 @@ struct sdl2_console {
     int updates;
     int idle_counter;
     int ignore_hotkeys;
+    bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
 #ifdef CONFIG_OPENGL
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9d9a9362cb..cb1acd4499 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -396,12 +396,13 @@ static void handle_keydown(SDL_Event *ev)
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
     int gui_key_modifier_pressed = get_mod_state();
-    int gui_keysym = 0;
 
     if (!scon) {
         return;
     }
 
+    scon->gui_keysym = false;
+
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
@@ -427,15 +428,15 @@ static void handle_keydown(SDL_Event *ev)
                     }
                 }
                 sdl2_release_modifiers(scon);
-                gui_keysym = 1;
+                scon->gui_keysym = true;
             }
             break;
         case SDL_SCANCODE_F:
             toggle_full_screen(scon);
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             break;
         case SDL_SCANCODE_G:
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             if (!gui_grab) {
                 sdl_grab_start(scon);
             } else if (!gui_fullscreen) {
@@ -448,7 +449,7 @@ static void handle_keydown(SDL_Event *ev)
                 /* re-create scon->texture */
                 sdl2_2d_switch(&scon->dcl, scon->surface);
             }
-            gui_keysym = 1;
+            scon->gui_keysym = true;
             break;
 #if 0
         case SDL_SCANCODE_KP_PLUS:
@@ -467,14 +468,14 @@ static void handle_keydown(SDL_Event *ev)
                         __func__, width, height);
                 sdl_scale(scon, width, height);
                 sdl2_redraw(scon);
-                gui_keysym = 1;
+                scon->gui_keysym = true;
             }
 #endif
         default:
             break;
         }
     }
-    if (!gui_keysym) {
+    if (!scon->gui_keysym) {
         sdl2_process_key(scon, &ev->key);
     }
 }
@@ -500,7 +501,7 @@ static void handle_textinput(SDL_Event *ev)
         return;
     }
 
-    if (QEMU_IS_TEXT_CONSOLE(con)) {
+    if (!scon->gui_keysym && QEMU_IS_TEXT_CONSOLE(con)) {
         qemu_text_console_put_string(QEMU_TEXT_CONSOLE(con), ev->text.text, strlen(ev->text.text));
     }
 }
-- 
2.35.3


