Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC9CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPalD-0004mo-KM; Wed, 20 May 2026 02:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak4-0003eo-Kz; Wed, 20 May 2026 02:49:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajw-0001T5-BM; Wed, 20 May 2026 02:49:19 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbP096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BpQW9AVRYkQ765Zs6xqZabFS3/BzVCHPEjaxd4rCcxQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259694; v=1;
 b=BTPlVbpVzAXuLmHPhE/CNBHmbonOyyp0ks33ka9Udyd4VJYkZEl5QlW/nL+yUzk6
 2oOiaPZ0Xvzv7vx5hMFbdK70W3HFNu1DFXVlS9Csc3+GoxTX8GxQBOT+ed183PyC
 V8o0AAr4gTjfMbi9c3wn6cZlSgGCwcZEqp1Ow9QqeSnLFMMvrZYxXCOzOkzxthPy
 zgPboPkhkGqPP86PVda2bwRnbQkM8013rt6MBdn968j1KLhzS//s2w94uHZRo9QQ
 PkJb+qvEF83OjKsEXCQNBnGp8u66wKVLWX4WoF6wIklD9cgUFaW6HJx5BqUJDYNq
 pROUGQ8BhTVZFlNUdCXh9w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:45 +0900
Subject: [PATCH v3 02/29] ui/input: Remove QAPI wrappers from
 QemuInputEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-2-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=59087;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=plYYaF/nozWhqTKACzzm98y1T+ByOBdyLyE34XFYMm4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpJSo1oUT+rNTGprOc/wXOBecmZi4TdzIn+1QhmPyb
 NV/Uic7SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJmL3lOGfZtTdk7sTuaSOJDMu
 4J59eX343auRV7kyn1VMctmcbv7qISPDnLTDvowVhTunXipuPpi8sO/KpKvcArwh78p6JtapLfH
 kBwA=
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

QAPI represents union members with wrapper structs and pointer
indirections. They are useful at the QMP boundary, but unnecessary for
QEMU's internal input events and make handlers more verbose.

Define QemuInputEvent as a plain internal tagged union and convert input
handlers, queues, and replay code to access payloads directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/typedefs.h      |   2 +-
 include/ui/input.h           |  16 ++++
 chardev/msmouse.c            |  10 +--
 chardev/wctablet.c           |   8 +-
 hw/arm/musicpal.c            |  11 ++-
 hw/char/escc.c               |  32 ++++----
 hw/display/xenfb.c           |  32 ++++----
 hw/input/adb-kbd.c           |   4 +-
 hw/input/adb-mouse.c         |  20 ++---
 hw/input/hid.c               |  36 ++++-----
 hw/input/ps2.c               |  67 ++++++++--------
 hw/input/stellaris_gamepad.c |   9 +--
 hw/input/virtio-input-hid.c  |  53 ++++++-------
 hw/m68k/next-kbd.c           |   9 +--
 replay/replay-events.c       |   2 +-
 replay/replay-input.c        | 101 ++++++++++--------------
 ui/input-legacy.c            |  23 +++---
 ui/input.c                   | 177 +++++++++++++++++++++++++------------------
 ui/vdagent.c                 |  18 ++---
 19 files changed, 299 insertions(+), 331 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index da7097c54401..2344c92182ea 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -94,7 +94,7 @@ typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
-typedef struct InputEvent QemuInputEvent;
+typedef struct QemuInputEvent QemuInputEvent;
 typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuMutex QemuMutex;
diff --git a/include/ui/input.h b/include/ui/input.h
index c455abdec6af..0b8c439fca74 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -18,6 +18,22 @@
 typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
 
+typedef struct QemuInputKeyEvent {
+    KeyValue key;
+    bool down;
+} QemuInputKeyEvent;
+
+typedef struct QemuInputEvent {
+    InputEventKind type;
+    union {
+        QemuInputKeyEvent key;
+        InputBtnEvent btn;
+        InputMoveEvent rel;
+        InputMoveEvent abs;
+        InputMultiTouchEvent mtt;
+    };
+} QemuInputEvent;
+
 typedef void (*QemuInputHandlerEvent)(DeviceState *dev, QemuConsole *src,
                                       QemuInputEvent *evt);
 typedef void (*QemuInputHandlerSync)(DeviceState *dev);
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 146457661f9e..d72a16a28335 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -125,8 +125,6 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 QemuInputEvent *evt)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(dev);
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
 
     /* Ignore events if serial mouse powered down. */
     if (!MSMOUSE_PWR(mouse->tiocm)) {
@@ -135,14 +133,12 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        mouse->axis[move->axis] += move->value;
+        mouse->axis[evt->rel.axis] += evt->rel.value;
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        mouse->btns[btn->button] = btn->down;
-        mouse->btnc[btn->button] = true;
+        mouse->btns[evt->btn.button] = evt->btn.down;
+        mouse->btnc[evt->btn.button] = true;
         break;
 
     default:
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 05d2333fb0c7..3ad24cce1752 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -149,18 +149,14 @@ static void wctablet_input_event(DeviceState *dev, QemuConsole *src,
                                  QemuInputEvent *evt)
 {
     TabletChardev *tablet = (TabletChardev *)dev;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
-        tablet->axis[move->axis] = move->value;
+        tablet->axis[evt->abs.axis] = evt->abs.value;
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        tablet->btns[btn->button] = btn->down;
+        tablet->btns[evt->btn.button] = evt->btn.down;
         break;
 
     default:
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ae171710e349..43c93cb72d75 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1069,8 +1069,7 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
-    InputKeyEvent *key = evt->u.key.data;
-    int qcode = qemu_input_key_value_to_qcode(key->key);
+    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     uint32_t event = 0;
     int i;
 
@@ -1113,14 +1112,14 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
      * but do not repeat already-pressed buttons for the other key inputs.
      */
     if (!(event & (MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_VOL))) {
-        if (key->down && (s->pressed_keys & event)) {
+        if (evt->key.down && (s->pressed_keys & event)) {
             event = 0;
         }
     }
 
     if (event) {
         /* Raise GPIO pin first if repeating a key */
-        if (key->down && (s->pressed_keys & event)) {
+        if (evt->key.down && (s->pressed_keys & event)) {
             for (i = 0; i <= 7; i++) {
                 if (event & (1 << i)) {
                     qemu_set_irq(s->out[i], 1);
@@ -1129,10 +1128,10 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
         }
         for (i = 0; i <= 7; i++) {
             if (event & (1 << i)) {
-                qemu_set_irq(s->out[i], !key->down);
+                qemu_set_irq(s->out[i], !evt->key.down);
             }
         }
-        if (key->down) {
+        if (evt->key.down) {
             s->pressed_keys |= event;
         } else {
             s->pressed_keys &= ~event;
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 677c3a120e13..c88b2d54ebe0 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -798,16 +798,14 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
 {
     ESCCChannelState *s = (ESCCChannelState *)dev;
     int qcode, keycode;
-    InputKeyEvent *key;
 
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    key = evt->u.key.data;
-    qcode = qemu_input_key_value_to_qcode(key->key);
+    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     trace_escc_sunkbd_event_in(qcode, QKeyCode_str(qcode),
-                               key->down);
+                               evt->key.down);
 
     if (qcode == Q_KEY_CODE_CAPS_LOCK) {
-        if (key->down) {
+        if (evt->key.down) {
             s->caps_lock_mode ^= 1;
             if (s->caps_lock_mode == 2) {
                 return; /* Drop second press */
@@ -821,7 +819,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     }
 
     if (qcode == Q_KEY_CODE_NUM_LOCK) {
-        if (key->down) {
+        if (evt->key.down) {
             s->num_lock_mode ^= 1;
             if (s->num_lock_mode == 2) {
                 return; /* Drop second press */
@@ -839,7 +837,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     }
 
     keycode = qemu_input_map_qcode_to_sun[qcode];
-    if (!key->down) {
+    if (!evt->key.down) {
         keycode |= 0x80;
     }
     trace_escc_sunkbd_event_out(keycode);
@@ -957,8 +955,6 @@ static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
                                   QemuInputEvent *evt)
 {
     ESCCChannelState *s = (ESCCChannelState *)dev;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]   = 0x4,
         [INPUT_BUTTON_MIDDLE] = 0x2,
@@ -967,21 +963,19 @@ static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        if (move->axis == INPUT_AXIS_X) {
-            s->sunmouse_dx += move->value;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            s->sunmouse_dy -= move->value;
+        if (evt->rel.axis == INPUT_AXIS_X) {
+            s->sunmouse_dx += evt->rel.value;
+        } else if (evt->rel.axis == INPUT_AXIS_Y) {
+            s->sunmouse_dy -= evt->rel.value;
         }
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (bmap[btn->button]) {
-            if (btn->down) {
-                s->sunmouse_buttons |= bmap[btn->button];
+        if (bmap[evt->btn.button]) {
+            if (evt->btn.down) {
+                s->sunmouse_buttons |= bmap[evt->btn.button];
             } else {
-                s->sunmouse_buttons &= ~bmap[btn->button];
+                s->sunmouse_buttons &= ~bmap[evt->btn.button];
             }
             /* Indicate we have a supported button event */
             s->sunmouse_buttons |= 0x80;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index c71174e13762..82d2cbae7cc5 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -203,16 +203,15 @@ static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    InputKeyEvent *key = evt->u.key.data;
-    int qcode = qemu_input_key_value_to_qcode(key->key);
+    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     int lnx;
 
     if (qcode < qemu_input_map_qcode_to_linux_len) {
         lnx = qemu_input_map_qcode_to_linux[qcode];
 
         if (lnx) {
-            trace_xenfb_key_event(xenfb, lnx, key->down);
-            xenfb_send_key(xenfb, key->down, lnx);
+            trace_xenfb_key_event(xenfb, lnx, evt->key.down);
+            xenfb_send_key(xenfb, evt->key.down, lnx);
         }
     }
 }
@@ -230,32 +229,29 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
                               QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    InputBtnEvent *btn;
-    InputMoveEvent *move;
     QemuConsole *con;
     DisplaySurface *surface;
     int scale;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        switch (btn->button) {
+        switch (evt->btn.button) {
         case INPUT_BUTTON_LEFT:
-            xenfb_send_key(xenfb, btn->down, BTN_LEFT);
+            xenfb_send_key(xenfb, evt->btn.down, BTN_LEFT);
             break;
         case INPUT_BUTTON_RIGHT:
-            xenfb_send_key(xenfb, btn->down, BTN_LEFT + 1);
+            xenfb_send_key(xenfb, evt->btn.down, BTN_LEFT + 1);
             break;
         case INPUT_BUTTON_MIDDLE:
-            xenfb_send_key(xenfb, btn->down, BTN_LEFT + 2);
+            xenfb_send_key(xenfb, evt->btn.down, BTN_LEFT + 2);
             break;
         case INPUT_BUTTON_WHEEL_UP:
-            if (btn->down) {
+            if (evt->btn.down) {
                 xenfb->wheel--;
             }
             break;
         case INPUT_BUTTON_WHEEL_DOWN:
-            if (btn->down) {
+            if (evt->btn.down) {
                 xenfb->wheel++;
             }
             break;
@@ -265,9 +261,8 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
         if (xenfb->raw_pointer_wanted) {
-            xenfb->axis[move->axis] = move->value;
+            xenfb->axis[evt->abs.axis] = evt->abs.value;
         } else {
             con = qemu_console_lookup_by_index(0);
             if (!con) {
@@ -275,7 +270,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
                 return;
             }
             surface = qemu_console_surface(con);
-            switch (move->axis) {
+            switch (evt->abs.axis) {
             case INPUT_AXIS_X:
                 scale = surface_width(surface) - 1;
                 break;
@@ -285,13 +280,12 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
             default:
                 g_assert_not_reached();
             }
-            xenfb->axis[move->axis] = move->value * scale / 0x7fff;
+            xenfb->axis[evt->abs.axis] = evt->abs.value * scale / 0x7fff;
         }
         break;
 
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        xenfb->axis[move->axis] += move->value;
+        xenfb->axis[evt->rel.axis] += evt->rel.value;
         break;
 
     default:
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 5ba6c9a7b5df..5911e7139257 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -311,7 +311,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     KBDState *s = (KBDState *)dev;
     int qcode, keycode;
 
-    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
+    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
         return;
     }
@@ -321,7 +321,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
         trace_adb_device_kbd_no_key();
         return;
     }
-    if (evt->u.key.data->down == false) { /* if key release event */
+    if (evt->key.down == false) { /* if key release event */
         keycode = keycode | 0x80;   /* create keyboard break code */
     }
 
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index c37ccf26c169..5dcdc851fcdf 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -59,8 +59,6 @@ static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
                                    QemuInputEvent *evt)
 {
     MouseState *s = (MouseState *)dev;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]   = ADB_MOUSE_BUTTON_LEFT,
         [INPUT_BUTTON_RIGHT]  = ADB_MOUSE_BUTTON_RIGHT,
@@ -68,21 +66,19 @@ static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        if (move->axis == INPUT_AXIS_X) {
-            s->dx += move->value;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            s->dy += move->value;
+        if (evt->rel.axis == INPUT_AXIS_X) {
+            s->dx += evt->rel.value;
+        } else if (evt->rel.axis == INPUT_AXIS_Y) {
+            s->dy += evt->rel.value;
         }
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (bmap[btn->button]) {
-            if (btn->down) {
-                s->buttons_state |= bmap[btn->button];
+        if (bmap[evt->btn.button]) {
+            if (evt->btn.down) {
+                s->buttons_state |= bmap[evt->btn.button];
             } else {
-                s->buttons_state &= ~bmap[btn->button];
+                s->buttons_state &= ~bmap[evt->btn.button];
             }
         }
         break;
diff --git a/hw/input/hid.c b/hw/input/hid.c
index 53afb1d43405..90b29682a254 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -119,42 +119,37 @@ static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
     };
     HIDState *hs = (HIDState *)dev;
     HIDPointerEvent *e;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
 
     assert(hs->n < QUEUE_LENGTH);
     e = &hs->ptr.queue[(hs->head + hs->n) & QUEUE_MASK];
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        if (move->axis == INPUT_AXIS_X) {
-            e->xdx += move->value;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            e->ydy += move->value;
+        if (evt->rel.axis == INPUT_AXIS_X) {
+            e->xdx += evt->rel.value;
+        } else if (evt->rel.axis == INPUT_AXIS_Y) {
+            e->ydy += evt->rel.value;
         }
         break;
 
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
-        if (move->axis == INPUT_AXIS_X) {
-            e->xdx = move->value;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            e->ydy = move->value;
+        if (evt->abs.axis == INPUT_AXIS_X) {
+            e->xdx = evt->abs.value;
+        } else if (evt->abs.axis == INPUT_AXIS_Y) {
+            e->ydy = evt->abs.value;
         }
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (btn->down) {
-            e->buttons_state |= bmap[btn->button];
-            if (btn->button == INPUT_BUTTON_WHEEL_UP) {
+        if (evt->btn.down) {
+            e->buttons_state |= bmap[evt->btn.button];
+            if (evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
                 e->dz--;
-            } else if (btn->button == INPUT_BUTTON_WHEEL_DOWN) {
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
                 e->dz++;
             }
         } else {
-            e->buttons_state &= ~bmap[btn->button];
+            e->buttons_state &= ~bmap[evt->btn.button];
         }
         break;
 
@@ -231,10 +226,9 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
     HIDState *hs = (HIDState *)dev;
     int scancodes[3], i, count;
     int slot;
-    InputKeyEvent *key = evt->u.key.data;
 
-    count = qemu_input_key_value_to_scancode(key->key,
-                                             key->down,
+    count = qemu_input_key_value_to_scancode(&evt->key.key,
+                                             evt->key.down,
                                              scancodes);
     if (hs->n + count > QUEUE_LENGTH) {
         trace_hid_kbd_queue_full();
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 90bcbcdff889..3e553176ef6e 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -313,7 +313,6 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     PS2KbdState *s = (PS2KbdState *)dev;
-    InputKeyEvent *key = evt->u.key.data;
     int qcode;
     uint16_t keycode = 0;
     int mod;
@@ -325,12 +324,12 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = qemu_input_key_value_to_qcode(key->key);
+    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
 
     mod = ps2_modifier_bit(qcode);
-    trace_ps2_keyboard_event(s, qcode, key->down, mod,
+    trace_ps2_keyboard_event(s, qcode, evt->key.down, mod,
                              s->modifiers, s->scancode_set, s->translate);
-    if (key->down) {
+    if (evt->key.down) {
         s->modifiers |= mod;
     } else {
         s->modifiers &= ~mod;
@@ -339,14 +338,14 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     if (s->scancode_set == 1) {
         if (qcode == Q_KEY_CODE_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x46);
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0xc6);
                 }
             } else {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe1);
                     ps2_put_keycode(s, 0x1d);
                     ps2_put_keycode(s, 0x45);
@@ -357,7 +356,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
             }
         } else if (qcode == Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xb8);
                     ps2_put_keycode(s, 0x38);
                     ps2_put_keycode(s, 0x54);
@@ -367,7 +366,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x38);
                 }
             } else if (s->modifiers & MOD_ALT_R) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0xb8);
                     ps2_put_keycode(s, 0xe0);
@@ -382,7 +381,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 }
             } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
                                        MOD_SHIFT_R | MOD_CTRL_R)) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x37);
                 } else {
@@ -390,7 +389,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0xb7);
                 }
             } else {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x2a);
                     ps2_put_keycode(s, 0xe0);
@@ -403,7 +402,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 }
             }
         } else if ((qcode == Q_KEY_CODE_LANG1 || qcode == Q_KEY_CODE_LANG2)
-                   && !key->down) {
+                   && !evt->key.down) {
             /* Ignore release for these keys */
         } else {
             if (qcode < qemu_input_map_qcode_to_atset1_len) {
@@ -413,7 +412,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 if (keycode & 0xff00) {
                     ps2_put_keycode(s, keycode >> 8);
                 }
-                if (!key->down) {
+                if (!evt->key.down) {
                     keycode |= 0x80;
                 }
                 ps2_put_keycode(s, keycode & 0xff);
@@ -425,7 +424,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     } else if (s->scancode_set == 2) {
         if (qcode == Q_KEY_CODE_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x7e);
                     ps2_put_keycode(s, 0xe0);
@@ -433,7 +432,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x7e);
                 }
             } else {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe1);
                     ps2_put_keycode(s, 0x14);
                     ps2_put_keycode(s, 0x77);
@@ -446,7 +445,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
             }
         } else if (qcode == Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xf0);
                     ps2_put_keycode(s, 0x11);
                     ps2_put_keycode(s, 0x11);
@@ -459,7 +458,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x11);
                 }
             } else if (s->modifiers & MOD_ALT_R) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0xf0);
                     ps2_put_keycode(s, 0x11);
@@ -477,7 +476,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 }
             } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
                                        MOD_SHIFT_R | MOD_CTRL_R)) {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x7c);
                 } else {
@@ -486,7 +485,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x7c);
                 }
             } else {
-                if (key->down) {
+                if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
                     ps2_put_keycode(s, 0x12);
                     ps2_put_keycode(s, 0xe0);
@@ -501,7 +500,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 }
             }
         } else if ((qcode == Q_KEY_CODE_LANG1 || qcode == Q_KEY_CODE_LANG2) &&
-                   !key->down) {
+                   !evt->key.down) {
             /* Ignore release for these keys */
         } else {
             if (qcode < qemu_input_map_qcode_to_atset2_len) {
@@ -511,7 +510,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 if (keycode & 0xff00) {
                     ps2_put_keycode(s, keycode >> 8);
                 }
-                if (!key->down) {
+                if (!evt->key.down) {
                     ps2_put_keycode(s, 0xf0);
                 }
                 ps2_put_keycode(s, keycode & 0xff);
@@ -526,7 +525,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
         }
         if (keycode) {
             /* FIXME: break code should be configured on a key by key basis */
-            if (!key->down) {
+            if (!evt->key.down) {
                 ps2_put_keycode(s, 0xf0);
             }
             ps2_put_keycode(s, keycode);
@@ -797,8 +796,6 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
         [INPUT_BUTTON_EXTRA]  = PS2_MOUSE_BUTTON_EXTRA,
     };
     PS2MouseState *s = (PS2MouseState *)dev;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
 
     /* check if deltas are recorded when disabled */
     if (!(s->mouse_status & MOUSE_STATUS_ENABLED)) {
@@ -807,31 +804,29 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        if (move->axis == INPUT_AXIS_X) {
-            s->mouse_dx += move->value;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            s->mouse_dy -= move->value;
+        if (evt->rel.axis == INPUT_AXIS_X) {
+            s->mouse_dx += evt->rel.value;
+        } else if (evt->rel.axis == INPUT_AXIS_Y) {
+            s->mouse_dy -= evt->rel.value;
         }
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (btn->down) {
-            s->mouse_buttons |= bmap[btn->button];
-            if (btn->button == INPUT_BUTTON_WHEEL_UP) {
+        if (evt->btn.down) {
+            s->mouse_buttons |= bmap[evt->btn.button];
+            if (evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
                 s->mouse_dz--;
-            } else if (btn->button == INPUT_BUTTON_WHEEL_DOWN) {
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
                 s->mouse_dz++;
             }
 
-            if (btn->button == INPUT_BUTTON_WHEEL_RIGHT) {
+            if (evt->btn.button == INPUT_BUTTON_WHEEL_RIGHT) {
                 s->mouse_dw--;
-            } else if (btn->button == INPUT_BUTTON_WHEEL_LEFT) {
+            } else if (evt->btn.button == INPUT_BUTTON_WHEEL_LEFT) {
                 s->mouse_dw++;
             }
         } else {
-            s->mouse_buttons &= ~bmap[btn->button];
+            s->mouse_buttons &= ~bmap[evt->btn.button];
         }
         break;
 
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index db35905554d5..7d8ec38e8885 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -19,14 +19,13 @@ static void stellaris_gamepad_event(DeviceState *dev, QemuConsole *src,
                                     QemuInputEvent *evt)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
-    InputKeyEvent *key = evt->u.key.data;
-    int qcode = qemu_input_key_value_to_qcode(key->key);
+    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     int i;
 
     for (i = 0; i < s->num_buttons; i++) {
-        if (s->keycodes[i] == qcode && s->pressed[i] != key->down) {
-            s->pressed[i] = key->down;
-            qemu_set_irq(s->irqs[i], key->down);
+        if (s->keycodes[i] == qcode && s->pressed[i] != evt->key.down) {
+            s->pressed[i] = evt->key.down;
+            qemu_set_irq(s->irqs[i], evt->key.down);
         }
     }
 }
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 5b9f407c546d..3f8a1bc249e0 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -84,80 +84,71 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     virtio_input_event event;
     int qcode;
-    InputKeyEvent *key;
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
-    InputMultiTouchEvent *mtt;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
-        qcode = qemu_input_key_value_to_qcode(key->key);
+        qcode = qemu_input_key_value_to_qcode(&evt->key.key);
         if (qcode < qemu_input_map_qcode_to_linux_len &&
             qemu_input_map_qcode_to_linux[qcode]) {
             event.type  = cpu_to_le16(EV_KEY);
             event.code  = cpu_to_le16(qemu_input_map_qcode_to_linux[qcode]);
-            event.value = cpu_to_le32(key->down ? 1 : 0);
+            event.value = cpu_to_le32(evt->key.down ? 1 : 0);
             virtio_input_send(vinput, &event);
         } else {
-            if (key->down) {
+            if (evt->key.down) {
                 fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
                         qcode, QKeyCode_str(qcode));
             }
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if ((btn->button == INPUT_BUTTON_WHEEL_UP ||
-             btn->button == INPUT_BUTTON_WHEEL_DOWN) &&
-            btn->down) {
+        if ((evt->btn.button == INPUT_BUTTON_WHEEL_UP ||
+             evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) &&
+            evt->btn.down) {
             event.type  = cpu_to_le16(EV_REL);
             event.code  = cpu_to_le16(REL_WHEEL);
-            event.value = cpu_to_le32(btn->button == INPUT_BUTTON_WHEEL_UP
+            event.value = cpu_to_le32(evt->btn.button == INPUT_BUTTON_WHEEL_UP
                                       ? 1 : -1);
             virtio_input_send(vinput, &event);
-        } else if (keymap_button[btn->button]) {
+        } else if (keymap_button[evt->btn.button]) {
             event.type  = cpu_to_le16(EV_KEY);
-            event.code  = cpu_to_le16(keymap_button[btn->button]);
-            event.value = cpu_to_le32(btn->down ? 1 : 0);
+            event.code  = cpu_to_le16(keymap_button[evt->btn.button]);
+            event.value = cpu_to_le32(evt->btn.down ? 1 : 0);
             virtio_input_send(vinput, &event);
         } else {
-            if (btn->down) {
+            if (evt->btn.down) {
                 fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func__,
-                        btn->button,
-                        InputButton_str(btn->button));
+                        evt->btn.button,
+                        InputButton_str(evt->btn.button));
             }
         }
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
         event.type  = cpu_to_le16(EV_REL);
-        event.code  = cpu_to_le16(axismap_rel[move->axis]);
-        event.value = cpu_to_le32(move->value);
+        event.code  = cpu_to_le16(axismap_rel[evt->rel.axis]);
+        event.value = cpu_to_le32(evt->rel.value);
         virtio_input_send(vinput, &event);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
         event.type  = cpu_to_le16(EV_ABS);
-        event.code  = cpu_to_le16(axismap_abs[move->axis]);
-        event.value = cpu_to_le32(move->value);
+        event.code  = cpu_to_le16(axismap_abs[evt->abs.axis]);
+        event.value = cpu_to_le32(evt->abs.value);
         virtio_input_send(vinput, &event);
         break;
     case INPUT_EVENT_KIND_MTT:
-        mtt = evt->u.mtt.data;
-        if (mtt->type == INPUT_MULTI_TOUCH_TYPE_DATA) {
+        if (evt->mtt.type == INPUT_MULTI_TOUCH_TYPE_DATA) {
             event.type  = cpu_to_le16(EV_ABS);
-            event.code  = cpu_to_le16(axismap_tch[mtt->axis]);
-            event.value = cpu_to_le32(mtt->value);
+            event.code  = cpu_to_le16(axismap_tch[evt->mtt.axis]);
+            event.value = cpu_to_le32(evt->mtt.value);
             virtio_input_send(vinput, &event);
         } else {
             event.type  = cpu_to_le16(EV_ABS);
             event.code  = cpu_to_le16(ABS_MT_SLOT);
-            event.value = cpu_to_le32(mtt->slot);
+            event.value = cpu_to_le32(evt->mtt.slot);
             virtio_input_send(vinput, &event);
             event.type  = cpu_to_le16(EV_ABS);
             event.code  = cpu_to_le16(ABS_MT_TRACKING_ID);
-            event.value = cpu_to_le32(mtt->tracking_id);
+            event.value = cpu_to_le32(evt->mtt.tracking_id);
             virtio_input_send(vinput, &event);
         }
         break;
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 9dbedac6479e..f3110ea0bca4 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -247,16 +247,15 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
 {
     NextKBDState *s = NEXTKBD(dev);
     int qcode, keycode;
-    bool key_down = evt->u.key.data->down;
 
-    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
+    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
     if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
         return;
     }
 
     /* Shift key currently has no keycode, so handle separately */
     if (qcode == Q_KEY_CODE_SHIFT) {
-        if (key_down) {
+        if (evt->key.down) {
             s->shift |= KD_LSHIFT;
         } else {
             s->shift &= ~KD_LSHIFT;
@@ -264,7 +263,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
     }
 
     if (qcode == Q_KEY_CODE_SHIFT_R) {
-        if (key_down) {
+        if (evt->key.down) {
             s->shift |= KD_RSHIFT;
         } else {
             s->shift &= ~KD_RSHIFT;
@@ -277,7 +276,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
     }
 
     /* If key release event, create keyboard break code */
-    if (!key_down) {
+    if (!evt->key.down) {
         keycode |= 0x80;
     }
 
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 20df810279e2..3ff42acb06bf 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -42,7 +42,7 @@ static void replay_run_event(Event *event)
         break;
     case REPLAY_ASYNC_EVENT_INPUT:
         qemu_input_event_send_impl(NULL, (QemuInputEvent *)event->opaque);
-        qapi_free_InputEvent((InputEvent *)event->opaque);
+        g_free(event->opaque);
         break;
     case REPLAY_ASYNC_EVENT_INPUT_SYNC:
         qemu_input_event_sync_impl();
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 3f506f2338a3..0995b125f244 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -19,25 +19,20 @@
 
 void replay_save_input_event(QemuInputEvent *evt)
 {
-    InputKeyEvent *key;
-    InputBtnEvent *btn;
-    InputMoveEvent *move;
-    InputMultiTouchEvent *mtt;
     replay_put_dword(evt->type);
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
-        replay_put_dword(key->key->type);
+        replay_put_dword(evt->key.key.type);
 
-        switch (key->key->type) {
+        switch (evt->key.key.type) {
         case KEY_VALUE_KIND_NUMBER:
-            replay_put_qword(key->key->u.number.data);
-            replay_put_byte(key->down);
+            replay_put_qword(evt->key.key.u.number.data);
+            replay_put_byte(evt->key.down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            replay_put_dword(key->key->u.qcode.data);
-            replay_put_byte(key->down);
+            replay_put_dword(evt->key.key.u.qcode.data);
+            replay_put_byte(evt->key.down);
             break;
         case KEY_VALUE_KIND__MAX:
             /* keep gcc happy */
@@ -45,27 +40,23 @@ void replay_save_input_event(QemuInputEvent *evt)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        replay_put_dword(btn->button);
-        replay_put_byte(btn->down);
+        replay_put_dword(evt->btn.button);
+        replay_put_byte(evt->btn.down);
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        replay_put_dword(move->axis);
-        replay_put_qword(move->value);
+        replay_put_dword(evt->rel.axis);
+        replay_put_qword(evt->rel.value);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
-        replay_put_dword(move->axis);
-        replay_put_qword(move->value);
+        replay_put_dword(evt->abs.axis);
+        replay_put_qword(evt->abs.value);
         break;
     case INPUT_EVENT_KIND_MTT:
-        mtt = evt->u.mtt.data;
-        replay_put_dword(mtt->type);
-        replay_put_qword(mtt->slot);
-        replay_put_qword(mtt->tracking_id);
-        replay_put_dword(mtt->axis);
-        replay_put_qword(mtt->value);
+        replay_put_dword(evt->mtt.type);
+        replay_put_qword(evt->mtt.slot);
+        replay_put_qword(evt->mtt.tracking_id);
+        replay_put_dword(evt->mtt.axis);
+        replay_put_qword(evt->mtt.value);
         break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
@@ -75,29 +66,21 @@ void replay_save_input_event(QemuInputEvent *evt)
 
 QemuInputEvent *replay_read_input_event(void)
 {
-    QemuInputEvent evt;
-    KeyValue keyValue;
-    InputKeyEvent key;
-    key.key = &keyValue;
-    InputBtnEvent btn;
-    InputMoveEvent rel;
-    InputMoveEvent abs;
-    InputMultiTouchEvent mtt;
+    QemuInputEvent *evt = g_new(QemuInputEvent, 1);
 
-    evt.type = replay_get_dword();
-    switch (evt.type) {
+    evt->type = replay_get_dword();
+    switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        evt.u.key.data = &key;
-        evt.u.key.data->key->type = replay_get_dword();
+        evt->key.key.type = replay_get_dword();
 
-        switch (evt.u.key.data->key->type) {
+        switch (evt->key.key.type) {
         case KEY_VALUE_KIND_NUMBER:
-            evt.u.key.data->key->u.number.data = replay_get_qword();
-            evt.u.key.data->down = replay_get_byte();
+            evt->key.key.u.number.data = replay_get_qword();
+            evt->key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND_QCODE:
-            evt.u.key.data->key->u.qcode.data = (QKeyCode)replay_get_dword();
-            evt.u.key.data->down = replay_get_byte();
+            evt->key.key.u.qcode.data = (QKeyCode)replay_get_dword();
+            evt->key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND__MAX:
             /* keep gcc happy */
@@ -105,34 +88,30 @@ QemuInputEvent *replay_read_input_event(void)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        evt.u.btn.data = &btn;
-        evt.u.btn.data->button = (InputButton)replay_get_dword();
-        evt.u.btn.data->down = replay_get_byte();
+        evt->btn.button = (InputButton)replay_get_dword();
+        evt->btn.down = replay_get_byte();
         break;
     case INPUT_EVENT_KIND_REL:
-        evt.u.rel.data = &rel;
-        evt.u.rel.data->axis = (InputAxis)replay_get_dword();
-        evt.u.rel.data->value = replay_get_qword();
+        evt->rel.axis = (InputAxis)replay_get_dword();
+        evt->rel.value = replay_get_qword();
         break;
     case INPUT_EVENT_KIND_ABS:
-        evt.u.abs.data = &abs;
-        evt.u.abs.data->axis = (InputAxis)replay_get_dword();
-        evt.u.abs.data->value = replay_get_qword();
+        evt->abs.axis = (InputAxis)replay_get_dword();
+        evt->abs.value = replay_get_qword();
         break;
     case INPUT_EVENT_KIND_MTT:
-        evt.u.mtt.data = &mtt;
-        evt.u.mtt.data->type = (InputMultiTouchType)replay_get_dword();
-        evt.u.mtt.data->slot = replay_get_qword();
-        evt.u.mtt.data->tracking_id = replay_get_qword();
-        evt.u.mtt.data->axis = (InputAxis)replay_get_dword();
-        evt.u.mtt.data->value = replay_get_qword();
+        evt->mtt.type = (InputMultiTouchType)replay_get_dword();
+        evt->mtt.slot = replay_get_qword();
+        evt->mtt.tracking_id = replay_get_qword();
+        evt->mtt.axis = (InputAxis)replay_get_dword();
+        evt->mtt.value = replay_get_qword();
         break;
     case INPUT_EVENT_KIND__MAX:
         /* keep gcc happy */
         break;
     }
 
-    return QAPI_CLONE(InputEvent, &evt);
+    return evt;
 }
 
 void replay_input_event(QemuConsole *src, QemuInputEvent *evt)
@@ -140,7 +119,9 @@ void replay_input_event(QemuConsole *src, QemuInputEvent *evt)
     if (replay_mode == REPLAY_MODE_PLAY) {
         /* Nothing */
     } else if (replay_mode == REPLAY_MODE_RECORD) {
-        replay_add_input_event(QAPI_CLONE(InputEvent, evt));
+        QemuInputEvent *clone = g_new(QemuInputEvent, 1);
+        *clone = *evt;
+        replay_add_input_event(clone);
     } else {
         qemu_input_event_send_impl(src, evt);
     }
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 5467010c3713..e2b48dd8f0aa 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -118,39 +118,36 @@ static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
         [INPUT_BUTTON_RIGHT]  = MOUSE_EVENT_RBUTTON,
     };
     QEMUPutMouseEntry *s = (QEMUPutMouseEntry *)dev;
-    InputBtnEvent *btn;
-    InputMoveEvent *move;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (btn->down) {
-            s->buttons |= bmap[btn->button];
+        if (evt->btn.down) {
+            s->buttons |= bmap[evt->btn.button];
         } else {
-            s->buttons &= ~bmap[btn->button];
+            s->buttons &= ~bmap[evt->btn.button];
         }
-        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_UP) {
+        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_UP) {
             s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
                                     s->axis[INPUT_AXIS_X],
                                     s->axis[INPUT_AXIS_Y],
                                     -1,
                                     s->buttons);
         }
-        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_DOWN) {
+        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_DOWN) {
             s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
                                     s->axis[INPUT_AXIS_X],
                                     s->axis[INPUT_AXIS_Y],
                                     1,
                                     s->buttons);
         }
-        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_RIGHT) {
+        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_RIGHT) {
             s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
                                     s->axis[INPUT_AXIS_X],
                                     s->axis[INPUT_AXIS_Y],
                                     -2,
                                     s->buttons);
         }
-        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_LEFT) {
+        if (evt->btn.down && evt->btn.button == INPUT_BUTTON_WHEEL_LEFT) {
             s->qemu_put_mouse_event(s->qemu_put_mouse_event_opaque,
                                     s->axis[INPUT_AXIS_X],
                                     s->axis[INPUT_AXIS_Y],
@@ -159,12 +156,10 @@ static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
         }
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
-        s->axis[move->axis] = move->value;
+        s->axis[evt->abs.axis] = evt->abs.value;
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
-        s->axis[move->axis] += move->value;
+        s->axis[evt->rel.axis] += evt->rel.value;
         break;
     default:
         break;
diff --git a/ui/input.c b/ui/input.c
index 759855c67e8a..97c473f40a2b 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -30,7 +30,7 @@ struct QemuInputEventQueue {
     QEMUTimer *timer;
     uint32_t delay_ms;
     QemuConsole *src;
-    QemuInputEvent *evt;
+    QemuInputEvent evt;
     QTAILQ_ENTRY(QemuInputEventQueue) node;
 };
 
@@ -159,16 +159,54 @@ void qmp_input_send_event(const char *device,
     }
 
     for (e = events; e != NULL; e = e->next) {
-        InputEvent *evt = e->value;
+        InputEvent *qapi = e->value;
+        QemuInputEvent evt;
+
+        evt.type = qapi->type;
+
+        switch (qapi->type) {
+        case INPUT_EVENT_KIND_KEY: {
+            KeyValue *key = qapi->u.key.data->key;
+            QKeyCode code;
+
+            switch (key->type) {
+            case KEY_VALUE_KIND_NUMBER:
+                code = qemu_input_key_number_to_qcode(key->u.number.data);
+                break;
+            case KEY_VALUE_KIND_QCODE:
+                code = key->u.qcode.data;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            evt.key.key.type = KEY_VALUE_KIND_QCODE;
+            evt.key.key.u.qcode.data = code;
+            evt.key.down = qapi->u.key.data->down;
+            break;
+        }
 
-        if (evt->type == INPUT_EVENT_KIND_KEY &&
-            evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER) {
-            KeyValue *key = evt->u.key.data->key;
-            QKeyCode code = qemu_input_key_number_to_qcode(key->u.number.data);
-            qemu_input_event_send_key_qcode(con, code, evt->u.key.data->down);
-        } else {
-            qemu_input_event_send(con, evt);
+        case INPUT_EVENT_KIND_BTN:
+            evt.btn = *qapi->u.btn.data;
+            break;
+
+        case INPUT_EVENT_KIND_REL:
+            evt.rel = *qapi->u.rel.data;
+            break;
+
+        case INPUT_EVENT_KIND_ABS:
+            evt.abs = *qapi->u.abs.data;
+            break;
+
+        case INPUT_EVENT_KIND_MTT:
+            evt.mtt = *qapi->u.mtt.data;
+            break;
+
+        default:
+            g_assert_not_reached();
         }
+
+        qemu_input_event_send(con, &evt);
     }
 
     qemu_input_event_sync();
@@ -178,7 +216,7 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
 {
     const char *name;
     int qcode, idx = -1;
-    InputKeyEvent *key;
+    QemuInputKeyEvent *key;
     InputBtnEvent *btn;
     InputMoveEvent *move;
     InputMultiTouchEvent *mtt;
@@ -188,16 +226,16 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
     }
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        key = evt->u.key.data;
-        switch (key->key->type) {
+        key = &evt->key;
+        switch (evt->key.key.type) {
         case KEY_VALUE_KIND_NUMBER:
-            qcode = qemu_input_key_number_to_qcode(key->key->u.number.data);
+            qcode = qemu_input_key_number_to_qcode(key->key.u.number.data);
             name = QKeyCode_str(qcode);
-            trace_input_event_key_number(idx, key->key->u.number.data,
+            trace_input_event_key_number(idx, key->key.u.number.data,
                                          name, key->down);
             break;
         case KEY_VALUE_KIND_QCODE:
-            name = QKeyCode_str(key->key->u.qcode.data);
+            name = QKeyCode_str(key->key.u.qcode.data);
             trace_input_event_key_qcode(idx, name, key->down);
             break;
         case KEY_VALUE_KIND__MAX:
@@ -206,22 +244,22 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
         }
         break;
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
+        btn = &evt->btn;
         name = btn->button < INPUT_BUTTON__MAX ? InputButton_str(btn->button) : "invalid";
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
-        move = evt->u.rel.data;
+        move = &evt->rel;
         name = move->axis < INPUT_AXIS__MAX ? InputAxis_str(move->axis) : "invalid";
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
+        move = &evt->abs;
         name = move->axis < INPUT_AXIS__MAX ? InputAxis_str(move->axis) : "invalid";
         trace_input_event_abs(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_MTT:
-        mtt = evt->u.mtt.data;
+        mtt = &evt->mtt;
         name = mtt->axis < INPUT_AXIS__MAX ? InputAxis_str(mtt->axis) : "invalid";
         trace_input_event_mtt(idx, name, mtt->value);
         break;
@@ -251,8 +289,7 @@ static void qemu_input_queue_process(void *opaque)
                       + item->delay_ms);
             return;
         case QEMU_INPUT_QUEUE_EVENT:
-            qemu_input_event_send(item->src, item->evt);
-            qapi_free_InputEvent(item->evt);
+            qemu_input_event_send(item->src, &item->evt);
             break;
         case QEMU_INPUT_QUEUE_SYNC:
             qemu_input_event_sync();
@@ -289,7 +326,7 @@ static void qemu_input_queue_event(QemuInputEventQueueHead *queue,
 
     item->type = QEMU_INPUT_QUEUE_EVENT;
     item->src = src;
-    item->evt = evt;
+    item->evt = *evt;
     QTAILQ_INSERT_TAIL(queue, item, node);
     queue_count++;
 }
@@ -323,7 +360,7 @@ void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
     /* Expect all parts of QEMU to send events with QCodes exclusively.
      * Key numbers are only supported as end-user input via QMP */
     assert(!(evt->type == INPUT_EVENT_KIND_KEY &&
-             evt->u.key.data->key->type == KEY_VALUE_KIND_NUMBER));
+             evt->key.key.type == KEY_VALUE_KIND_NUMBER));
 
 
     /*
@@ -335,8 +372,8 @@ void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
      * need to deal with this mistake
      */
     if (evt->type == INPUT_EVENT_KIND_KEY &&
-        evt->u.key.data->key->u.qcode.data == Q_KEY_CODE_SYSRQ) {
-        evt->u.key.data->key->u.qcode.data = Q_KEY_CODE_PRINT;
+        evt->key.key.u.qcode.data == Q_KEY_CODE_SYSRQ) {
+        evt->key.key.u.qcode.data = Q_KEY_CODE_PRINT;
     }
 
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
@@ -372,29 +409,24 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-static QemuInputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
-{
-    QemuInputEvent *evt = g_new0(QemuInputEvent, 1);
-    evt->u.key.data = g_new0(InputKeyEvent, 1);
-    evt->type = INPUT_EVENT_KIND_KEY;
-    evt->u.key.data->key = key;
-    evt->u.key.data->down = down;
-    return evt;
-}
-
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
 {
-    QemuInputEvent *evt;
-    evt = qemu_input_event_new_key(key, down);
+    QemuInputEvent evt = {
+        .type = INPUT_EVENT_KIND_KEY,
+        .key = {
+            .key = *key,
+            .down = down,
+        },
+    };
+
+    g_free(key);
+
     if (QTAILQ_EMPTY(&kbd_queue)) {
-        qemu_input_event_send(src, evt);
+        qemu_input_event_send(src, &evt);
         qemu_input_event_sync();
-        qapi_free_InputEvent(evt);
     } else if (queue_count < queue_limit) {
-        qemu_input_queue_event(&kbd_queue, src, evt);
+        qemu_input_queue_event(&kbd_queue, src, &evt);
         qemu_input_queue_sync(&kbd_queue);
-    } else {
-        qapi_free_InputEvent(evt);
     }
 }
 
@@ -431,13 +463,12 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
 
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
 {
-    InputBtnEvent bevt = {
-        .button = btn,
-        .down = down,
-    };
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_BTN,
-        .u.btn.data = &bevt,
+        .btn = {
+            .button = btn,
+            .down = down,
+        }
     };
 
     qemu_input_event_send(src, &evt);
@@ -482,13 +513,12 @@ int qemu_input_scale_axis(int value,
 
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
 {
-    InputMoveEvent move = {
-        .axis = axis,
-        .value = value,
-    };
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_REL,
-        .u.rel.data = &move,
+        .rel = {
+            .axis = axis,
+            .value = value,
+        },
     };
 
     qemu_input_event_send(src, &evt);
@@ -497,15 +527,14 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
 void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                           int min_in, int max_in)
 {
-    InputMoveEvent move = {
-        .axis = axis,
-        .value = qemu_input_scale_axis(value, min_in, max_in,
-                                       INPUT_EVENT_ABS_MIN,
-                                       INPUT_EVENT_ABS_MAX),
-    };
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_ABS,
-        .u.abs.data = &move,
+        .abs = {
+            .axis = axis,
+            .value = qemu_input_scale_axis(value, min_in, max_in,
+                                           INPUT_EVENT_ABS_MIN,
+                                           INPUT_EVENT_ABS_MAX),
+        },
     };
 
     qemu_input_event_send(src, &evt);
@@ -514,14 +543,13 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
 void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type,
                           int slot, int tracking_id)
 {
-    InputMultiTouchEvent mtt = {
-        .type = type,
-        .slot = slot,
-        .tracking_id = tracking_id,
-    };
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_MTT,
-        .u.mtt.data = &mtt,
+        .mtt = {
+            .type = type,
+            .slot = slot,
+            .tracking_id = tracking_id,
+        },
     };
 
     qemu_input_event_send(src, &evt);
@@ -530,18 +558,17 @@ void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type,
 void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
                               int min_in, int max_in, int slot, int tracking_id)
 {
-    InputMultiTouchEvent mtt = {
-        .type = INPUT_MULTI_TOUCH_TYPE_DATA,
-        .slot = slot,
-        .tracking_id = tracking_id,
-        .axis = axis,
-        .value = qemu_input_scale_axis(value, min_in, max_in,
-                                       INPUT_EVENT_ABS_MIN,
-                                       INPUT_EVENT_ABS_MAX),
-    };
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_MTT,
-        .u.mtt.data = &mtt,
+        .mtt = {
+            .type = INPUT_MULTI_TOUCH_TYPE_DATA,
+            .slot = slot,
+            .tracking_id = tracking_id,
+            .axis = axis,
+            .value = qemu_input_scale_axis(value, min_in, max_in,
+                                           INPUT_EVENT_ABS_MIN,
+                                           INPUT_EVENT_ABS_MAX),
+        }
     };
 
     qemu_input_event_send(src, &evt);
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 28a83c7c389c..8fa325bffa32 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -241,22 +241,19 @@ static void vdagent_pointer_event(DeviceState *dev, QemuConsole *src,
     };
 
     VDAgentChardev *vd = container_of(dev, struct VDAgentChardev, mouse_dev);
-    InputMoveEvent *move;
-    InputBtnEvent *btn;
     uint32_t xres, yres;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_ABS:
-        move = evt->u.abs.data;
         xres = qemu_console_get_width(src, 1024);
         yres = qemu_console_get_height(src, 768);
-        if (move->axis == INPUT_AXIS_X) {
-            vd->mouse_x = qemu_input_scale_axis(move->value,
+        if (evt->abs.axis == INPUT_AXIS_X) {
+            vd->mouse_x = qemu_input_scale_axis(evt->abs.value,
                                                 INPUT_EVENT_ABS_MIN,
                                                 INPUT_EVENT_ABS_MAX,
                                                 0, xres);
-        } else if (move->axis == INPUT_AXIS_Y) {
-            vd->mouse_y = qemu_input_scale_axis(move->value,
+        } else if (evt->abs.axis == INPUT_AXIS_Y) {
+            vd->mouse_y = qemu_input_scale_axis(evt->abs.value,
                                                 INPUT_EVENT_ABS_MIN,
                                                 INPUT_EVENT_ABS_MAX,
                                                 0, yres);
@@ -265,11 +262,10 @@ static void vdagent_pointer_event(DeviceState *dev, QemuConsole *src,
         break;
 
     case INPUT_EVENT_KIND_BTN:
-        btn = evt->u.btn.data;
-        if (btn->down) {
-            vd->mouse_btn |= bmap[btn->button];
+        if (evt->btn.down) {
+            vd->mouse_btn |= bmap[evt->btn.button];
         } else {
-            vd->mouse_btn &= ~bmap[btn->button];
+            vd->mouse_btn &= ~bmap[evt->btn.button];
         }
         break;
 

-- 
2.54.0


