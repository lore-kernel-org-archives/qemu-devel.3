Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27792CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ23Y-0007Wc-Ow; Thu, 21 May 2026 07:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ23K-000712-Vr
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ23I-0004Fx-NY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUKImSv9PKsnQuxzjs0V+OefpWbsMKdQ4Q/auOwOwFY=;
 b=L9TeEAes+YrxnTIXDeP6zFM+rdH1xEjG/2uWNK/zxzyOyIHBm+RSpn+nR4zx45XQRCoUN7
 Ebpc366GAWfljhl6S8YWoh8daWwL6R95IBSlxnXaxULfJH2+pdIR6OXD0j+Wukx8cRjqGK
 AgtPV743TkPFSGJ9oD/oNDlqo8WQ0KM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-M_EDVNgmO0a12DRmzMltxQ-1; Thu,
 21 May 2026 07:58:55 -0400
X-MC-Unique: M_EDVNgmO0a12DRmzMltxQ-1
X-Mimecast-MFC-AGG-ID: M_EDVNgmO0a12DRmzMltxQ_1779364734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B3C019560BD; Thu, 21 May 2026 11:58:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACE151800347; Thu, 21 May 2026 11:58:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/38] ui/kbd-state: Use Linux key codes
Date: Thu, 21 May 2026 15:56:52 +0400
Message-ID: <20260521115717.1701482-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-7-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/kbd-state.h | 12 ++++----
 ui/dbus-console.c      |  4 +--
 ui/gtk.c               |  7 +++--
 ui/kbd-state.c         | 61 +++++++++++++++++++++-----------------
 ui/keymaps.c           |  3 +-
 ui/sdl2-input.c        |  3 +-
 ui/vnc.c               | 10 +++++--
 ui/cocoa.m             | 67 +++++++++++++++++++++++++++++++-----------
 8 files changed, 108 insertions(+), 59 deletions(-)

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index 1f37b932eb6..a70d5b5746b 100644
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
index b8e5c57b148..24f4542f312 100644
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
index 2c61b601f78..757ee80fa6a 100644
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
index 52ed28b8a89..c407327da59 100644
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
index 6822c097be7..a448efab320 100644
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
index 2286df4223d..fdbdc427dc9 100644
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
index 92b62f62127..f521d9f2ad4 100644
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
index 98394cdc507..ee53e7c72ed 100644
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


