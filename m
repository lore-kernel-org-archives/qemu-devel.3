Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E064ECD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnVk-0004LM-Fb; Tue, 12 May 2026 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuhongchao006@gmail.com>)
 id 1wMdJh-0001Iz-0J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:57:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liuhongchao006@gmail.com>)
 id 1wMdJe-0002nq-GJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:57:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bc85eda6b6so11588325ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778554668; x=1779159468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ehxRJJAIOpui0vhKNEMat8JaWyk8jgamyn+T8c4WrI=;
 b=h20afirnpJNUX7+D+eM0pG5oFD4/SIXMZuHAWT/V1iEb6yu4ksLNTyMnbzczbfB0ed
 3WcdgmEgcpa73RKNNukdUHx4IwpxhO1qmT5CuTTqXpiQZE6A9dKuJQyFgmXwt7gezJPV
 YhUmXcQmItO5g2TRpkvClFNhMun5xFNiQHjnkteaBkgrhh/5baaAfp1HqmG+/3nrN+j2
 so8VismIKvUicSmIx1A3+zp9Zn6+2Mu+8bB7ORy6UAamDuRARsfWkTEI4CoPhuivaCQt
 lbHawfniVQWGQzb7/ugVRBFlspmMiP0aziiQ0GaAUqnxHycgtGeuZlt9Prsr56BbHVU+
 rfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778554668; x=1779159468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ehxRJJAIOpui0vhKNEMat8JaWyk8jgamyn+T8c4WrI=;
 b=kBp1RG4kda5ZoITCfNOqBds0EhcPyF60ARBGI64T1zcEnHgZKB43e8aZQ8oui6t2EB
 rM6oUpu3x3gZzfakCNwtgbkk3fK3ILm2bnqznZuUcuCq3Ul8Oqxha/ItaKqnPvPE/GJn
 x01DDaFuy1CDCYGHBp+DHwF8AG+qMZC94jw3orunoq6C2ty1//XCrrj3QGhp8DMwFxDb
 5XXfAYctTkoYSOyG+hC+x1PHT6nG/F5hFak48sBpGZusksnD574G1QHFSLbu4LQeLKrR
 Eo5SpZuNPWhz+YtNNOzoQrFkud4R5ZQarT3QOgKWMPuPgHUCVyeJTIBWb9nVC8sbpVgM
 YULw==
X-Gm-Message-State: AOJu0YzGKps1Ri6TrL9+O+ssqwsCy479Afot6UCDlqbvaxoy/TV9iGr0
 PekoxaRdUifgWsX6Yg6pWOCURNLSSN6AHTwmDs7tZmkhUPxDkvMaiH5ap4tVgQ==
X-Gm-Gg: Acq92OHl/unySvDKBDrrf8eRDI4FFg+AgCI2AhF/ju72+q1Ky6IDtSGOshsVTEoEFPV
 1JtkLAMLTh7qtyjmfehiS8zIWRrzERH/qp4APajznWm4QwVGPw0za4DYvw5z88tFH1q75ZEmu1R
 Cqu6kG99EmLw5RAbqB3rycmyDYiADu1rk9MmcMD7TqspVX/qsCBi/E+0J5JBIBLtJzNO9JDT5rL
 XdamZWewmP/0k7usFekXLUP1qCpAQc2PrFAT09kCw41vM1Dg4rbQB0TXLgTpZl9BMoZu30XVj4r
 FIiYveyaUq/wsew9q82eVAL8pJjp1wt/PQ5azfm6S891z0ywlW7DisKjeq+O7he/pe2r+zGW4jx
 g6qbprs/nGEWB3GWMayx4idA2wiGQu5yi7JOTfCxWOocp/CKvDESVbX+OO7umY3Yq/cigaJwC/Y
 Y7GkDHsZeVrcHxkhgvhbL2VPzriqZJuILLHe2aQjFQNT1R
X-Received: by 2002:a17:902:bf49:b0:2b0:ac1e:9737 with SMTP id
 d9443c01a7336-2baf0d23ef6mr130848945ad.12.1778554667922; 
 Mon, 11 May 2026 19:57:47 -0700 (PDT)
Received: from lhc-Computer.mioffice.cn
 ([2408:8607:1b00:c:f202:a9a3:a60a:7ccd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1eac3afsm126905855ad.71.2026.05.11.19.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 19:57:47 -0700 (PDT)
From: Hongchao Liu <liuhongchao006@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Hongchao Liu <liuhongchao@xiaomi.com>
Subject: [RFC PATCH v2 1/1] ui/sdl2: replace SDL relative mouse mode with
 manual warp-to-center
Date: Tue, 12 May 2026 10:57:26 +0800
Message-Id: <20260512025726.1842622-2-liuhongchao006@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3d86e8cfc12040eca14364739b0a35db@xiaomi.com>
References: <3d86e8cfc12040eca14364739b0a35db@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=liuhongchao006@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:48 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hongchao Liu <liuhongchao@xiaomi.com>

SDL2's SDL_SetRelativeMouseMode(SDL_TRUE) is the standard way to handle
relative pointing devices in grab mode: SDL itself warps the host pointer
back to the window center every frame, so xrel/yrel values in
SDL_MOUSEMOTION events always remain meaningful and the guest cursor
never gets stuck at an edge.

However, under X11 with XInput2 (the default on most Linux desktops) this
relative mode switches SDL to consume only XI_RawMotion events.
Pointer-injection servers such as VNC (via XTestFakeMotionEvent), nested
X servers and some remote desktop setups never produce XI_RawMotion, so
mouse input breaks completely under those environments as soon as the
guest enters relative-input grab mode. SDL does not expose a way to
detect this at runtime (both local X11 and a VNC-forwarded X session
report "x11" from SDL_GetCurrentVideoDriver), and upstream SDL issues
tracking this (libsdl-org/SDL#1116, #4206) have stayed open for years.

Stop enabling SDL_SetRelativeMouseMode on the grab paths and replace
the automatic warping it provides with the approach already used by
the GTK backend (ui/gtk.c gd_motion_event): when the host pointer
reaches the window edge, warp it back to the window center explicitly,
letting subsequent motion events again produce non-zero xrel/yrel.

Specifically:

 - sdl_hide_cursor() is no longer called from sdl_grab_start() or
   sdl_mouse_warp(); both paths open-code the cursor hide so we never
   enter SDL_SetRelativeMouseMode(SDL_TRUE). sdl_hide_cursor() is
   retained as the counterpart of sdl_show_cursor() and marked
   G_GNUC_UNUSED.

 - In handle_mousemotion(), when we are in a grab for a relative
   pointing device, detect edge contact using the window coordinates
   (ev->motion.x/y vs scr_w/h) and SDL_WarpMouseInWindow() the pointer
   to the window center. Window coordinates are used regardless of
   the window-to-surface scaling applied to the sent event, because
   we need to detect the host pointer hitting the SDL window edge.

 - Absolute pointing devices and absolute_enabled paths are untouched.

Tested on Linux/X11 with a relative virtio-mouse: the guest cursor can
be pushed in every direction after repeatedly entering and exiting
grab, and quick drags to the window edge remain responsive. Behavior
for absolute pointing devices (virtio-tablet, qemu-keymap kbd) is
unchanged.

Signed-off-by: Hongchao Liu <liuhongchao@xiaomi.com>
---
 ui/sdl2.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 5dd612d9a6..faf610281c 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -212,7 +212,19 @@ static void sdl_update_caption(struct sdl2_console *scon)
     }
 }
 
-static void sdl_hide_cursor(struct sdl2_console *scon)
+/*
+ * sdl_hide_cursor - hide cursor and optionally enable SDL relative mouse mode.
+ *
+ * NOTE: This function is intentionally NOT called from sdl_grab_start() or
+ * sdl_mouse_warp() because SDL_SetRelativeMouseMode(SDL_TRUE) switches SDL2
+ * on XI2-based X servers to consume only XI_RawMotion events. Pointer-
+ * injection servers (VNC via XTestFakeMotionEvent, nested X, some remote
+ * desktop setups) never produce XI_RawMotion, so mouse input would break
+ * under those servers. Those call sites set the cursor state inline
+ * instead. This function is retained as the counterpart of
+ * sdl_show_cursor() and for potential future use.
+ */
+static void G_GNUC_UNUSED sdl_hide_cursor(struct sdl2_console *scon)
 {
     if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
         return;
@@ -267,7 +279,16 @@ static void sdl_grab_start(struct sdl2_console *scon)
             SDL_WarpMouseInWindow(scon->real_window, guest_x, guest_y);
         }
     } else {
-        sdl_hide_cursor(scon);
+        /*
+         * Directly set cursor state, avoid calling sdl_hide_cursor
+         * which would enable SDL_SetRelativeMouseMode(SDL_TRUE) and
+         * break mouse input under XI2-based pointer-injection X servers
+         * (see the note on sdl_hide_cursor).
+         */
+        if (!(scon->opts->has_show_cursor && scon->opts->show_cursor)) {
+            SDL_ShowCursor(SDL_DISABLE);
+            SDL_SetCursor(sdl_cursor_hidden);
+        }
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
@@ -526,6 +547,34 @@ static void handle_mousemotion(SDL_Event *ev)
     dy = (int64_t)ev->motion.yrel * surf_h / scr_h;
     if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
         sdl_send_mouse_event(scon, dx, dy, x, y, ev->motion.state);
+
+        /*
+         * For relative pointing devices in grab mode we do not enable
+         * SDL_SetRelativeMouseMode, because under XI2-based X servers
+         * that switches SDL to consume only XI_RawMotion events, which
+         * some pointer-injection servers (VNC via XTestFakeMotionEvent,
+         * nested X, ...) never produce.
+         *
+         * Without relative mode, SDL_SetWindowGrab clamps the host
+         * pointer at the window edge without wrapping, so xrel/yrel
+         * become zero once the pointer hits a side and the guest
+         * cursor gets stuck in that direction.
+         *
+         * Mirror the approach used by the GTK backend (ui/gtk.c):
+         * when the pointer reaches any window edge, warp it back to
+         * the window center so subsequent motion can generate deltas
+         * in every direction again. Edge detection uses window
+         * coordinates (ev->motion.x/y, scr_w/h) regardless of the
+         * window-to-surface scaling applied above.
+         */
+        if (!qemu_input_is_absolute(scon->dcl.con) && !absolute_enabled
+            && gui_grab) {
+            if (ev->motion.x <= 0 || ev->motion.x >= scr_w - 1 ||
+                ev->motion.y <= 0 || ev->motion.y >= scr_h - 1) {
+                SDL_WarpMouseInWindow(scon->real_window,
+                                      scr_w / 2, scr_h / 2);
+            }
+        }
     }
 }
 
@@ -748,7 +797,16 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
             }
         }
     } else if (gui_grab) {
-        sdl_hide_cursor(scon);
+        /*
+         * Directly set cursor state, avoid calling sdl_hide_cursor
+         * which would enable SDL_SetRelativeMouseMode(SDL_TRUE) and
+         * break mouse input under XI2-based pointer-injection X servers
+         * (see the note on sdl_hide_cursor).
+         */
+        if (!(scon->opts->has_show_cursor && scon->opts->show_cursor)) {
+            SDL_ShowCursor(SDL_DISABLE);
+            SDL_SetCursor(sdl_cursor_hidden);
+        }
     }
     guest_cursor = on;
     guest_x = x, guest_y = y;
-- 
2.34.1


