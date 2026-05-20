Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9EFCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPako-0004GY-85; Wed, 20 May 2026 02:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak1-0003Zt-Ar; Wed, 20 May 2026 02:49:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajv-0001Qo-Pk; Wed, 20 May 2026 02:49:17 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbU096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SmOzT1tzVsm840SlcbexDUMWU/BgO6nizuI/QepFgCA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259695; v=1;
 b=Ql5+ZkMCwLSkSDtoNONa69L8wiVBhF37cOMe2FH24suDgtEVlQ+jvlAfePRwvgeK
 YS7WSQZQQQ9MjBlpAOl386c6b6dGrMVVDjt1lgcqrZhk8cWjVR4FkjBAPAIL/UwV
 yfER0hYdJkCpI/kRX2uJXQqbKpenPxJy7yE/k0Tiw8gEJWlwjwugZ7iF0SxGWzM7
 W6EU68NbicsXtj5vpscKWGrco/JKi1N29F4ZfUfL3hlsCZLrrY+aqEwYXYWpCDBR
 RoCXknqFH3ybhjGlHkQm2C/ysdwytKJpIRx5uQJ/XLWxmpuso4xEahakW1eQMPu6
 AHGfm9iEuCq/ne1s0UcQBw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:50 +0900
Subject: [PATCH v3 07/29] ui/kbd-state: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-7-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16197;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=1/ttdJ8afuo70sBJyciEQUnvrEDxIZy6EV46w4sp1ro=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpGw6i/qtn8FW+/7+NpAsmHB0Wv5n3nuRdil7J1g0X
 tjM/f1SRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESkAhj+cJQbaKm8mpq+vuKo
 OmtNvJLfVq7npWdu8p39nGCzKMbwMMNfsYS9D1q/ypk/n5f089G/vxG+1rcUS0ovP1Ni3jfJ9jE
 LKwA=
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
 include/ui/kbd-state.h | 12 +++++----
 ui/dbus-console.c      |  4 +--
 ui/gtk.c               |  7 +++---
 ui/kbd-state.c         | 61 +++++++++++++++++++++++++--------------------
 ui/keymaps.c           |  3 ++-
 ui/sdl2-input.c        |  3 ++-
 ui/vnc.c               | 10 +++++---
 ui/cocoa.m             | 67 +++++++++++++++++++++++++++++++++++++-------------
 8 files changed, 108 insertions(+), 59 deletions(-)

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index 1f37b932eb62..a70d5b5746b5 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -52,11 +52,13 @@ void qkbd_state_free(QKbdState *kbd);
  * This function takes care to not send suspious events (keyup event
  * for a key not pressed for example).
  *
+ * This function drops events with key codes outside the defined range.
+ *
  * @kbd: state tracker state.
- * @qcode: the key pressed or released.
+ * @lnx: the key pressed or released.
  * @down: true for key down events, false otherwise.
  */
-void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
+void qkbd_state_key_event(QKbdState *kbd, unsigned int lnx, bool down);
 
 /**
  * qkbd_state_set_delay: set key press delay.
@@ -72,12 +74,12 @@ void qkbd_state_set_delay(QKbdState *kbd, int delay_ms);
 /**
  * qkbd_state_key_get: get key state.
  *
- * Returns true when the key is down.
+ * Returns true when the key code is in the defined range and the key is down.
  *
  * @kbd: state tracker state.
- * @qcode: the key to query.
+ * @lnx: the key to query.
  */
-bool qkbd_state_key_get(QKbdState *kbd, QKeyCode qcode);
+bool qkbd_state_key_get(QKbdState *kbd, unsigned int lnx);
 
 /**
  * qkbd_state_modifier_get: get modifier state.
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index b8e5c57b148c..24f4542f3121 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -343,7 +343,7 @@ dbus_kbd_press(DBusDisplayConsole *ddc,
 
     trace_dbus_kbd_press(arg_keycode);
 
-    qkbd_state_key_event(ddc->kbd, qcode, true);
+    qkbd_state_key_event(ddc->kbd, qemu_input_map_qcode_to_linux[qcode], true);
 
     qemu_dbus_display1_keyboard_complete_press(ddc->iface_kbd, invocation);
 
@@ -359,7 +359,7 @@ dbus_kbd_release(DBusDisplayConsole *ddc,
 
     trace_dbus_kbd_release(arg_keycode);
 
-    qkbd_state_key_event(ddc->kbd, qcode, false);
+    qkbd_state_key_event(ddc->kbd, qemu_input_map_qcode_to_linux[qcode], false);
 
     qemu_dbus_display1_keyboard_complete_release(ddc->iface_kbd, invocation);
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 2c61b601f781..757ee80fa6a6 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1343,7 +1343,8 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         || key->hardware_keycode == VK_PAUSE
 #endif
         ) {
-        qkbd_state_key_event(vc->gfx.kbd, Q_KEY_CODE_PAUSE,
+        qkbd_state_key_event(vc->gfx.kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_PAUSE],
                              key->type == GDK_KEY_PRESS);
         return TRUE;
     }
@@ -1351,10 +1352,10 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     keycode = gd_get_keycode(key);
     qcode = gd_map_keycode(keycode);
 
-    trace_gd_key_event(vc->label, keycode, qcode,
+    trace_gd_key_event(vc->label, keycode, qemu_input_map_qcode_to_linux[qcode],
                        (key->type == GDK_KEY_PRESS) ? "down" : "up");
 
-    qkbd_state_key_event(vc->gfx.kbd, qcode,
+    qkbd_state_key_event(vc->gfx.kbd, qemu_input_map_qcode_to_linux[qcode],
                          key->type == GDK_KEY_PRESS);
 
     return TRUE;
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index 52ed28b8a89b..c407327da59e 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -5,6 +5,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitmap.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/kbd-state.h"
@@ -12,15 +13,15 @@
 struct QKbdState {
     QemuConsole *con;
     int key_delay_ms;
-    DECLARE_BITMAP(keys, Q_KEY_CODE__MAX);
+    DECLARE_BITMAP(keys, KEY_CNT);
     DECLARE_BITMAP(mods, QKBD_MOD__MAX);
 };
 
 static void qkbd_state_modifier_update(QKbdState *kbd,
-                                      QKeyCode qcode1, QKeyCode qcode2,
+                                       unsigned int lnx1, unsigned int lnx2,
                                       QKbdModifier mod)
 {
-    if (test_bit(qcode1, kbd->keys) || test_bit(qcode2, kbd->keys)) {
+    if (test_bit(lnx1, kbd->keys) || test_bit(lnx2, kbd->keys)) {
         set_bit(mod, kbd->mods);
     } else {
         clear_bit(mod, kbd->mods);
@@ -32,14 +33,20 @@ bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod)
     return test_bit(mod, kbd->mods);
 }
 
-bool qkbd_state_key_get(QKbdState *kbd, QKeyCode qcode)
+bool qkbd_state_key_get(QKbdState *kbd, unsigned int lnx)
 {
-    return test_bit(qcode, kbd->keys);
+    return lnx < KEY_CNT && test_bit(lnx, kbd->keys);
 }
 
-void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
+void qkbd_state_key_event(QKbdState *kbd, unsigned int lnx, bool down)
 {
-    bool state = test_bit(qcode, kbd->keys);
+    bool state;
+
+    if (lnx >= KEY_CNT) {
+        return;
+    }
+
+    state = test_bit(lnx, kbd->keys);
 
     if (down == false  /* got key-up event   */ &&
         state == false /* key is not pressed */) {
@@ -59,35 +66,35 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
 
     /* update key and modifier state */
     if (down) {
-        set_bit(qcode, kbd->keys);
+        set_bit(lnx, kbd->keys);
     } else {
-        clear_bit(qcode, kbd->keys);
+        clear_bit(lnx, kbd->keys);
     }
-    switch (qcode) {
-    case Q_KEY_CODE_SHIFT:
-    case Q_KEY_CODE_SHIFT_R:
-        qkbd_state_modifier_update(kbd, Q_KEY_CODE_SHIFT, Q_KEY_CODE_SHIFT_R,
+    switch (lnx) {
+    case KEY_LEFTSHIFT:
+    case KEY_RIGHTSHIFT:
+        qkbd_state_modifier_update(kbd, KEY_LEFTSHIFT, KEY_RIGHTSHIFT,
                                    QKBD_MOD_SHIFT);
         break;
-    case Q_KEY_CODE_CTRL:
-    case Q_KEY_CODE_CTRL_R:
-        qkbd_state_modifier_update(kbd, Q_KEY_CODE_CTRL, Q_KEY_CODE_CTRL_R,
+    case KEY_LEFTCTRL:
+    case KEY_RIGHTCTRL:
+        qkbd_state_modifier_update(kbd, KEY_LEFTCTRL, KEY_RIGHTCTRL,
                                    QKBD_MOD_CTRL);
         break;
-    case Q_KEY_CODE_ALT:
-        qkbd_state_modifier_update(kbd, Q_KEY_CODE_ALT, Q_KEY_CODE_ALT,
+    case KEY_LEFTALT:
+        qkbd_state_modifier_update(kbd, KEY_LEFTALT, KEY_LEFTALT,
                                    QKBD_MOD_ALT);
         break;
-    case Q_KEY_CODE_ALT_R:
-        qkbd_state_modifier_update(kbd, Q_KEY_CODE_ALT_R, Q_KEY_CODE_ALT_R,
+    case KEY_RIGHTALT:
+        qkbd_state_modifier_update(kbd, KEY_RIGHTALT, KEY_RIGHTALT,
                                    QKBD_MOD_ALTGR);
         break;
-    case Q_KEY_CODE_CAPS_LOCK:
+    case KEY_CAPSLOCK:
         if (down) {
             change_bit(QKBD_MOD_CAPSLOCK, kbd->mods);
         }
         break;
-    case Q_KEY_CODE_NUM_LOCK:
+    case KEY_NUMLOCK:
         if (down) {
             change_bit(QKBD_MOD_NUMLOCK, kbd->mods);
         }
@@ -99,7 +106,7 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
 
     /* send to guest */
     if (qemu_console_is_graphic(kbd->con)) {
-        qemu_input_event_send_key_qcode(kbd->con, qcode, down);
+        qemu_input_event_send_key_linux(kbd->con, lnx, down);
         if (kbd->key_delay_ms) {
             qemu_input_event_send_key_delay(kbd->key_delay_ms);
         }
@@ -108,11 +115,11 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
 
 void qkbd_state_lift_all_keys(QKbdState *kbd)
 {
-    int qcode;
+    unsigned int lnx;
 
-    for (qcode = 0; qcode < Q_KEY_CODE__MAX; qcode++) {
-        if (test_bit(qcode, kbd->keys)) {
-            qkbd_state_key_event(kbd, qcode, false);
+    for (lnx = 0; lnx < KEY_CNT; lnx++) {
+        if (test_bit(lnx, kbd->keys)) {
+            qkbd_state_key_event(kbd, lnx, false);
         }
     }
 }
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6822c097be72..a448efab3202 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -257,7 +257,8 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
         for (i = 0; i < keysym2code->count; i++) {
             QKeyCode qcode = qemu_input_key_number_to_qcode
                 (keysym2code->keycodes[i]);
-            if (kbd && qkbd_state_key_get(kbd, qcode)) {
+            unsigned int lnx = qemu_input_map_qcode_to_linux[qcode];
+            if (kbd && qkbd_state_key_get(kbd, lnx)) {
                 return keysym2code->keycodes[i];
             }
         }
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 2286df4223dc..fdbdc427dc9e 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -41,7 +41,8 @@ void sdl2_process_key(struct sdl2_console *scon,
     qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
     trace_sdl2_process_key(ev->keysym.scancode, qcode,
                            ev->type == SDL_KEYDOWN ? "down" : "up");
-    qkbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
+    qkbd_state_key_event(scon->kbd, qemu_input_map_qcode_to_linux[qcode],
+                         ev->type == SDL_KEYDOWN);
 
     if (QEMU_IS_TEXT_CONSOLE(con)) {
         QemuTextConsole *s = QEMU_TEXT_CONSOLE(con);
diff --git a/ui/vnc.c b/ui/vnc.c
index 56dd43d53ff2..4269b19d1489 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1799,8 +1799,11 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
 
 static void press_key(VncState *vs, QKeyCode qcode)
 {
-    qkbd_state_key_event(vs->vd->kbd, qcode, true);
-    qkbd_state_key_event(vs->vd->kbd, qcode, false);
+    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
+                         true);
+
+    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
+                         false);
 }
 
 static void vnc_led_state_change(VncState *vs)
@@ -1907,7 +1910,8 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
         }
     }
 
-    qkbd_state_key_event(vs->vd->kbd, qcode, down);
+    qkbd_state_key_event(vs->vd->kbd, qemu_input_map_qcode_to_linux[qcode],
+                         down);
     if (QEMU_IS_TEXT_CONSOLE(vs->vd->dcl.con)) {
         QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 98394cdc507c..ee53e7c72ed1 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -767,7 +767,8 @@ - (void) setFullGrab:(id)sender
 }
 
 - (void) toggleKey: (int)keycode {
-    qkbd_state_key_event(kbd, keycode, !qkbd_state_key_get(kbd, keycode));
+    unsigned int lnx = qemu_input_map_qcode_to_linux[keycode];
+    qkbd_state_key_event(kbd, lnx, !qkbd_state_key_get(kbd, lnx));
 }
 
 // Does the work of sending input to the monitor
@@ -889,34 +890,62 @@ - (bool) handleEventLocked:(NSEvent *)event
      */
     if (!!(modifiers & NSEventModifierFlagCapsLock) !=
         qkbd_state_modifier_get(kbd, QKBD_MOD_CAPSLOCK)) {
-        qkbd_state_key_event(kbd, Q_KEY_CODE_CAPS_LOCK, true);
-        qkbd_state_key_event(kbd, Q_KEY_CODE_CAPS_LOCK, false);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CAPS_LOCK],
+                             true);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CAPS_LOCK],
+                             false);
     }
 
     if (!(modifiers & NSEventModifierFlagShift)) {
-        qkbd_state_key_event(kbd, Q_KEY_CODE_SHIFT, false);
-        qkbd_state_key_event(kbd, Q_KEY_CODE_SHIFT_R, false);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_SHIFT],
+                             false);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_SHIFT_R],
+                             false);
     }
     if (!(modifiers & NSEventModifierFlagControl)) {
-        qkbd_state_key_event(kbd, Q_KEY_CODE_CTRL, false);
-        qkbd_state_key_event(kbd, Q_KEY_CODE_CTRL_R, false);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CTRL],
+                             false);
+        qkbd_state_key_event(kbd,
+                             qemu_input_map_qcode_to_linux[Q_KEY_CODE_CTRL_R],
+                             false);
     }
     if (!(modifiers & NSEventModifierFlagOption)) {
         if (swap_opt_cmd) {
-            qkbd_state_key_event(kbd, Q_KEY_CODE_META_L, false);
-            qkbd_state_key_event(kbd, Q_KEY_CODE_META_R, false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_L],
+                                 false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_R],
+                                 false);
         } else {
-            qkbd_state_key_event(kbd, Q_KEY_CODE_ALT, false);
-            qkbd_state_key_event(kbd, Q_KEY_CODE_ALT_R, false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT],
+                                 false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT_R],
+                                 false);
         }
     }
     if (!(modifiers & NSEventModifierFlagCommand)) {
         if (swap_opt_cmd) {
-            qkbd_state_key_event(kbd, Q_KEY_CODE_ALT, false);
-            qkbd_state_key_event(kbd, Q_KEY_CODE_ALT_R, false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT],
+                                 false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_ALT_R],
+                                 false);
         } else {
-            qkbd_state_key_event(kbd, Q_KEY_CODE_META_L, false);
-            qkbd_state_key_event(kbd, Q_KEY_CODE_META_R, false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_L],
+                                 false);
+            qkbd_state_key_event(kbd,
+                                 qemu_input_map_qcode_to_linux[Q_KEY_CODE_META_R],
+                                 false);
         }
     }
 
@@ -1023,7 +1052,9 @@ - (bool) handleEventLocked:(NSEvent *)event
             }
 
             if (qemu_console_is_graphic(dcl.con)) {
-                qkbd_state_key_event(kbd, keycode, true);
+                qkbd_state_key_event(kbd,
+                                     qemu_input_map_qcode_to_linux[keycode],
+                                     true);
             } else {
                 [self handleMonitorInput: event];
             }
@@ -1038,7 +1069,9 @@ - (bool) handleEventLocked:(NSEvent *)event
             }
 
             if (qemu_console_is_graphic(dcl.con)) {
-                qkbd_state_key_event(kbd, keycode, false);
+                qkbd_state_key_event(kbd,
+                                     qemu_input_map_qcode_to_linux[keycode],
+                                     false);
             }
             return true;
         case NSEventTypeScrollWheel:

-- 
2.54.0


