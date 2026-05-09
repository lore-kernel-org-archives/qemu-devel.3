Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7CECD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFg-0000k7-Ez; Sat, 09 May 2026 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF0-0008J8-5n; Sat, 09 May 2026 06:49:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEv-0001bV-Va; Sat, 09 May 2026 06:49:01 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY2Q090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:48:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5nVwcoBUMe6NuInaiAkPhWnMmFp6lK3p5hpEA3XbroE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323682; v=1;
 b=XvWsSBeGcADW6BFvNqawo+H/2rF9dExFEwYJSr4ID+K1+jA8klG51WioCjgDfTRu
 GLQZjhvQ3Mshx6rFbwL4oxHBhij/Ze1H1t2Dh5Team7KwaAfJTGDaECNLWjRkdlD
 EISdwjHVMoM9Dh8URZ5C52jRIPoC4UMym2QZumWF8JHSsDfrNimFRGjMy9Us4gr3
 HwjrvtMxzuJtwBe6ehfRcEFH0KCw0aa2uRFAZTibIiYoCMKqLsCo8KcwQ9R3Ll5x
 o4FjXt7lgP+vBhbm+nby7DpCxRb+xEo8zxuoM+W22YtfvAM8kCtKjrRADCy3bf+e
 qw6f/sVAiLiURg/PpkUjhA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:37 +0900
Subject: [PATCH RFC 25/28] ui/vnc: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-25-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=QerukY73VtCo9ipWBLNsjflRN8tp0sdYEDVJmULTugw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gVuNCgeePe6uMpwkVrMyq+69pwSL/aS9ypcy+xQcE
 jXm65/vKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmAjPT4b/rttWTd/2aVffWcXN
 5r9n2j9ebzvh76TqKGH7Q1MecU8UqmNkeFS70ItXTsvCvr358pbJd15f330i3ZPp8L26889WXZF
 w5wEA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/vnc.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 940dae1a0010..8ad24f82f776 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "qapi/qapi-events-ui.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/input.h"
 #include "crypto/hash.h"
 #include "crypto/tlscreds.h"
@@ -1805,13 +1806,10 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
     qemu_input_event_sync();
 }
 
-static void press_key(VncState *vs, QKeyCode qcode)
+static void press_key(VncState *vs, QKeyCode lnx)
 {
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         true);
-
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         false);
+    qkbd_state_key_event(vs->vd->kbd, lnx, true);
+    qkbd_state_key_event(vs->vd->kbd, lnx, false);
 }
 
 static void vnc_led_state_change(VncState *vs)
@@ -1852,15 +1850,15 @@ static void kbd_leds(void *opaque, int ledstate)
 
 static void do_key_event(VncState *vs, int down, int keycode, int sym)
 {
-    QKeyCode qcode = qemu_input_key_number_to_qcode(keycode);
+    QKeyCode lnx = qemu_input_key_number_to_linux(keycode);
 
     /* QEMU console switch */
-    switch (qcode) {
-    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
+    switch (lnx) {
+    case KEY_1 ... KEY_9: /* '1' to '9' keys */
         if (down &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
             qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
-            QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
+            QemuConsole *con = qemu_console_lookup_by_index(lnx - KEY_1);
             if (con) {
                 unregister_displaychangelistener(&vs->vd->dcl);
                 qkbd_state_switch_console(vs->vd->kbd, con);
@@ -1886,12 +1884,12 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
         if (keysym_is_numlock(vs->vd->kbd_layout, sym & 0xFFFF)) {
             if (!qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(true);
-                press_key(vs, Q_KEY_CODE_NUM_LOCK);
+                press_key(vs, KEY_NUMLOCK);
             }
         } else {
             if (qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(false);
-                press_key(vs, Q_KEY_CODE_NUM_LOCK);
+                press_key(vs, KEY_NUMLOCK);
             }
         }
     }
@@ -1909,18 +1907,17 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
         if (capslock) {
             if (uppercase == shift) {
                 trace_vnc_key_sync_capslock(false);
-                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
+                press_key(vs, KEY_CAPSLOCK);
             }
         } else {
             if (uppercase != shift) {
                 trace_vnc_key_sync_capslock(true);
-                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
+                press_key(vs, KEY_CAPSLOCK);
             }
         }
     }
 
-    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
-                         down);
+    qkbd_state_key_event(vs->vd->kbd, lnx, down);
     if (QEMU_IS_TEXT_CONSOLE(vs->vd->dcl.con)) {
         QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);

-- 
2.54.0


