Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D596DCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 06:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snXhR-0005dd-7n; Mon, 09 Sep 2024 02:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXhP-0005P1-D7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:31 -0400
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXhN-0003WM-9B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:31 -0400
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout08.t-online.de (Postfix) with SMTP id BE08F1BC8C;
 Mon,  9 Sep 2024 08:15:56 +0200 (CEST)
Received: from linpower.localnet ([93.236.144.183]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1snXgp-1kVRWD0; Mon, 9 Sep 2024 08:15:55 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id D9E3F200364; Mon,  9 Sep 2024 08:15:52 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/3] ui/sdl2: release all modifiers
Date: Mon,  9 Sep 2024 08:15:51 +0200
Message-Id: <20240909061552.6122-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1725862555-EAFFB5E9-177AB33E/0/0 CLEAN NORMAL
X-TOI-MSGID: ac1a4aa1-d33d-4afc-9b1a-b40a24cc6470
Received-SPF: pass client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Each virtual console in the SDL2 frontend has a key state map.
When switching windows with GUI keys we have to release all
pressed modifier keys in the currently active window, because
after the switch the now inactive window no longer receives the
key release events.

To reproduce the issue open a text editor in the SDL UI and then
press Ctrl-Alt-2 to open a Compat Monitor Console. Close the
console with the mouse. Try to enter text in the text editor and
notice that the modifier keys Ctrl and Alt are stuck and need to
be pressed once to be released.

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 include/ui/sdl2.h | 1 +
 ui/sdl2-input.c   | 5 +++++
 ui/sdl2.c         | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index e3acc7c82a..6907115809 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -60,6 +60,7 @@ void sdl2_poll_events(struct sdl2_console *scon);
 
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev);
+void sdl2_release_modifiers(struct sdl2_console *scon);
 
 void sdl2_2d_update(DisplayChangeListener *dcl,
                     int x, int y, int w, int h);
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index b02a89ee7c..2286df4223 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -58,3 +58,8 @@ void sdl2_process_key(struct sdl2_console *scon,
         }
     }
 }
+
+void sdl2_release_modifiers(struct sdl2_console *scon)
+{
+    qkbd_state_lift_all_keys(scon->kbd);
+}
diff --git a/ui/sdl2.c b/ui/sdl2.c
index ac37c173a1..9d9a9362cb 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -426,6 +426,7 @@ static void handle_keydown(SDL_Event *ev)
                         SDL_ShowWindow(sdl2_console[win].real_window);
                     }
                 }
+                sdl2_release_modifiers(scon);
                 gui_keysym = 1;
             }
             break;
-- 
2.35.3


