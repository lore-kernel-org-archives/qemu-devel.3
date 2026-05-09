Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B738CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFf-0000dq-Js; Sat, 09 May 2026 06:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF4-0008MZ-0a; Sat, 09 May 2026 06:49:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEw-0001dq-Th; Sat, 09 May 2026 06:49:04 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY22090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:47:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5ggO6w+ivZFTq2fSHCFP6OeJvLpPb3Y3y1XdWbItDyw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323677; v=1;
 b=LORt5Ng1g1B+5j5Ca/OJhSkMqxx9PJ5ppeQJ8NaTBCcOB5QlMZ20wji5dngmVZrH
 YMB4m/3Dw4kev6Yw8knq9dzO+vjBjpXnk7U9C9pTcJGYmSY5QFcmyiSRy0doVx+i
 K8lnD8A14kUfy41VcmdlVTq0biZgKSA96tGjwY/q3lIsldicplo108wr++tNQOyY
 nu+m8q6N0OAIml+QsgAhxpxfuNeKosiI/xf9y1B4IoYpv+5FEa3841jTeJPLShO6
 YUIjihKres95416w3k5n8KwiavI56MYA8EGRzvdAa5AoUX7HkumdF9dKAwtJTOdk
 ICoF0NonayW7qIdTAnct5w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:13 +0900
Subject: [PATCH RFC 01/28] ui/input: Introduce QemuInputEvent typedef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-1-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19238;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=krs/8Duw6kmL+Gr3ZJlgcNsnWXMJ5I2BmT9SAYFTWQM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gVPLp+Wv/il45dOCpBUPJIyKhGU2awvKrz2zqqLD8
 dopHz69jlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgImILWb4Z25c+8PmY6Kij0R8
 wWeFxZ+5j09O+rxzU1yM2JX/qj/THBgZThzvaWc1/Kdx3/vrlp0lXv/mBH+Wm3V6hd+5p9sEJHV
 0OQA=
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

Add QemuInputEvent as the input subsystem's name for InputEvent and use
it in input handler, queue, and replay interfaces.

This prepares for decoupling QEMU's internal input event representation
from the QAPI InputEvent type.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/typedefs.h      |  1 +
 include/system/replay.h      |  2 +-
 include/ui/input.h           |  6 +++---
 replay/replay-internal.h     |  6 +++---
 chardev/msmouse.c            |  2 +-
 chardev/wctablet.c           |  2 +-
 hw/arm/musicpal.c            |  2 +-
 hw/char/escc.c               |  4 ++--
 hw/display/xenfb.c           |  4 ++--
 hw/input/adb-kbd.c           |  2 +-
 hw/input/adb-mouse.c         |  2 +-
 hw/input/hid.c               |  4 ++--
 hw/input/ps2.c               |  4 ++--
 hw/input/stellaris_gamepad.c |  2 +-
 hw/input/virtio-input-hid.c  |  2 +-
 hw/m68k/next-kbd.c           |  3 ++-
 replay/replay-events.c       |  4 ++--
 replay/replay-input.c        |  8 ++++----
 replay/stubs-system.c        |  2 +-
 ui/input-legacy.c            |  2 +-
 ui/input.c                   | 26 +++++++++++++-------------
 ui/vdagent.c                 |  2 +-
 22 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acead..8bd1f3c0f0ea 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -93,6 +93,7 @@ typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
+typedef struct InputEvent QemuInputEvent;
 typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuMutex QemuMutex;
diff --git a/include/system/replay.h b/include/system/replay.h
index 19fb6dbb3963..3b00386821b6 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -126,7 +126,7 @@ void replay_bh_schedule_event(QEMUBH *bh);
 void replay_bh_schedule_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque);
 /*! Adds input event to the queue */
-void replay_input_event(QemuConsole *src, InputEvent *evt);
+void replay_input_event(QemuConsole *src, QemuInputEvent *evt);
 /*! Adds input sync event to the queue */
 void replay_input_sync_event(void);
 /*! Adds block layer event to the queue */
diff --git a/include/ui/input.h b/include/ui/input.h
index 8f9aac562ed2..1f6487a3d376 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -19,7 +19,7 @@ typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
 
 typedef void (*QemuInputHandlerEvent)(DeviceState *dev, QemuConsole *src,
-                                      InputEvent *evt);
+                                      QemuInputEvent *evt);
 typedef void (*QemuInputHandlerSync)(DeviceState *dev);
 
 struct QemuInputHandler {
@@ -37,8 +37,8 @@ void qemu_input_handler_unregister(QemuInputHandlerState *s);
 void qemu_input_handler_bind(QemuInputHandlerState *s,
                              const char *device_id, int head,
                              Error **errp);
-void qemu_input_event_send(QemuConsole *src, InputEvent *evt);
-void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt);
+void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt);
+void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt);
 void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 643b357da121..42c393542eb3 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -171,11 +171,11 @@ void replay_add_event(ReplayAsyncEventKind event_kind, void *opaque,
 /* Input events */
 
 /*! Saves input event to the log */
-void replay_save_input_event(InputEvent *evt);
+void replay_save_input_event(QemuInputEvent *evt);
 /*! Reads input event from the log */
-InputEvent *replay_read_input_event(void);
+QemuInputEvent *replay_read_input_event(void);
 /*! Adds input event to the queue */
-void replay_add_input_event(struct InputEvent *event);
+void replay_add_input_event(QemuInputEvent *event);
 /*! Adds input sync event to the queue */
 void replay_add_input_sync_event(void);
 
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 365f04546e91..146457661f9e 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -122,7 +122,7 @@ static void msmouse_queue_event(MouseChardev *mouse)
 }
 
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
-                                InputEvent *evt)
+                                QemuInputEvent *evt)
 {
     MouseChardev *mouse = MOUSE_CHARDEV(dev);
     InputMoveEvent *move;
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 214d5ca2e282..05d2333fb0c7 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -146,7 +146,7 @@ static void wctablet_queue_event(TabletChardev *tablet)
 }
 
 static void wctablet_input_event(DeviceState *dev, QemuConsole *src,
-                                InputEvent *evt)
+                                 QemuInputEvent *evt)
 {
     TabletChardev *tablet = (TabletChardev *)dev;
     InputMoveEvent *move;
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 441a11100a35..19c12715378b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1065,7 +1065,7 @@ struct musicpal_key_state {
 };
 
 static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
     InputKeyEvent *key = evt->u.key.data;
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3b46818ecc98..677c3a120e13 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -794,7 +794,7 @@ static const VMStateDescription vmstate_escc = {
 };
 
 static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
-                                InputEvent *evt)
+                                QemuInputEvent *evt)
 {
     ESCCChannelState *s = (ESCCChannelState *)dev;
     int qcode, keycode;
@@ -954,7 +954,7 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
 }
 
 static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
-                                  InputEvent *evt)
+                                  QemuInputEvent *evt)
 {
     ESCCChannelState *s = (ESCCChannelState *)dev;
     InputMoveEvent *move;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index ba886a940ee3..598b7682ceb4 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -200,7 +200,7 @@ static int xenfb_send_position(struct XenInput *xenfb,
  * already has code for dealing with this...
  */
 static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
-                            InputEvent *evt)
+                            QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
     InputKeyEvent *key = evt->u.key.data;
@@ -227,7 +227,7 @@ static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
  * the button state.
  */
 static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
-                              InputEvent *evt)
+                              QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
     InputBtnEvent *btn;
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 507557deecc1..5ba6c9a7b5df 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -306,7 +306,7 @@ static bool adb_kbd_has_data(ADBDevice *d)
 
 /* This is where keyboard events enter this file */
 static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     KBDState *s = (KBDState *)dev;
     int qcode, keycode;
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 373ef3f953ca..c37ccf26c169 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -56,7 +56,7 @@ struct ADBMouseClass {
 #define ADB_MOUSE_BUTTON_RIGHT  0x02
 
 static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
-                                   InputEvent *evt)
+                                   QemuInputEvent *evt)
 {
     MouseState *s = (MouseState *)dev;
     InputMoveEvent *move;
diff --git a/hw/input/hid.c b/hw/input/hid.c
index de24cd0ef045..53afb1d43405 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -108,7 +108,7 @@ void hid_set_next_idle(HIDState *hs)
 }
 
 static void hid_pointer_event(DeviceState *dev, QemuConsole *src,
-                              InputEvent *evt)
+                              QemuInputEvent *evt)
 {
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]   = 0x01,
@@ -226,7 +226,7 @@ static void hid_pointer_sync(DeviceState *dev)
 }
 
 static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     HIDState *hs = (HIDState *)dev;
     int scancodes[3], i, count;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 10ac7324030b..90bcbcdff889 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -310,7 +310,7 @@ static void ps2_put_keycode(void *opaque, int keycode)
 }
 
 static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     PS2KbdState *s = (PS2KbdState *)dev;
     InputKeyEvent *key = evt->u.key.data;
@@ -787,7 +787,7 @@ static int ps2_mouse_send_packet(PS2MouseState *s)
 }
 
 static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
-                            InputEvent *evt)
+                            QemuInputEvent *evt)
 {
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]   = PS2_MOUSE_BUTTON_LEFT,
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 42d43f9af51f..db35905554d5 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -16,7 +16,7 @@
 #include "ui/console.h"
 
 static void stellaris_gamepad_event(DeviceState *dev, QemuConsole *src,
-                                    InputEvent *evt)
+                                    QemuInputEvent *evt)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
     InputKeyEvent *key = evt->u.key.data;
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 14dde90a48b3..5b9f407c546d 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -79,7 +79,7 @@ static void virtio_input_extend_config(VirtIOInput *vinput,
 }
 
 static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
-                                      InputEvent *evt)
+                                      QemuInputEvent *evt)
 {
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     virtio_input_event event;
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 571a95550404..9dbedac6479e 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -242,7 +242,8 @@ static void nextkbd_put_keycode(NextKBDState *s, int keycode)
     /* s->update_irq(s->update_arg, 1); */
 }
 
-static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
+static void nextkbd_event(DeviceState *dev, QemuConsole *src,
+                          QemuInputEvent *evt)
 {
     NextKBDState *s = NEXTKBD(dev);
     int qcode, keycode;
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 9e5af5e84954..20df810279e2 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -41,7 +41,7 @@ static void replay_run_event(Event *event)
         ((QEMUBHFunc *)event->opaque)(event->opaque2);
         break;
     case REPLAY_ASYNC_EVENT_INPUT:
-        qemu_input_event_send_impl(NULL, (InputEvent *)event->opaque);
+        qemu_input_event_send_impl(NULL, (QemuInputEvent *)event->opaque);
         qapi_free_InputEvent((InputEvent *)event->opaque);
         break;
     case REPLAY_ASYNC_EVENT_INPUT_SYNC:
@@ -143,7 +143,7 @@ void replay_bh_schedule_oneshot_event(AioContext *ctx,
     }
 }
 
-void replay_add_input_event(struct InputEvent *event)
+void replay_add_input_event(QemuInputEvent *event)
 {
     replay_add_event(REPLAY_ASYNC_EVENT_INPUT, event, NULL, 0);
 }
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 562bbf371751..3f506f2338a3 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -17,7 +17,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-ui.h"
 
-void replay_save_input_event(InputEvent *evt)
+void replay_save_input_event(QemuInputEvent *evt)
 {
     InputKeyEvent *key;
     InputBtnEvent *btn;
@@ -73,9 +73,9 @@ void replay_save_input_event(InputEvent *evt)
     }
 }
 
-InputEvent *replay_read_input_event(void)
+QemuInputEvent *replay_read_input_event(void)
 {
-    InputEvent evt;
+    QemuInputEvent evt;
     KeyValue keyValue;
     InputKeyEvent key;
     key.key = &keyValue;
@@ -135,7 +135,7 @@ InputEvent *replay_read_input_event(void)
     return QAPI_CLONE(InputEvent, &evt);
 }
 
-void replay_input_event(QemuConsole *src, InputEvent *evt)
+void replay_input_event(QemuConsole *src, QemuInputEvent *evt)
 {
     if (replay_mode == REPLAY_MODE_PLAY) {
         /* Nothing */
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index b2c52bc40436..f8e17dcf1ce9 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -2,7 +2,7 @@
 #include "system/replay.h"
 #include "ui/input.h"
 
-void replay_input_event(QemuConsole *src, InputEvent *evt)
+void replay_input_event(QemuConsole *src, QemuInputEvent *evt)
 {
     qemu_input_event_send_impl(src, evt);
 }
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index ca4bccb41134..5467010c3713 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -110,7 +110,7 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
 }
 
 static void legacy_mouse_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]   = MOUSE_EVENT_LBUTTON,
diff --git a/ui/input.c b/ui/input.c
index 147e69c1c3c5..52ab7beb9428 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -30,7 +30,7 @@ struct QemuInputEventQueue {
     QEMUTimer *timer;
     uint32_t delay_ms;
     QemuConsole *src;
-    InputEvent *evt;
+    QemuInputEvent *evt;
     QTAILQ_ENTRY(QemuInputEventQueue) node;
 };
 
@@ -174,7 +174,7 @@ void qmp_input_send_event(const char *device,
     qemu_input_event_sync();
 }
 
-static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
+static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
 {
     const char *name;
     int qcode, idx = -1;
@@ -283,7 +283,7 @@ static void qemu_input_queue_delay(QemuInputEventQueueHead *queue,
 }
 
 static void qemu_input_queue_event(QemuInputEventQueueHead *queue,
-                                   QemuConsole *src, InputEvent *evt)
+                                   QemuConsole *src, QemuInputEvent *evt)
 {
     QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
 
@@ -303,7 +303,7 @@ static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
     queue_count++;
 }
 
-void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
+void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
 {
     QemuInputHandlerState *s;
 
@@ -318,7 +318,7 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
     s->events++;
 }
 
-void qemu_input_event_send(QemuConsole *src, InputEvent *evt)
+void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
 {
     /* Expect all parts of QEMU to send events with QCodes exclusively.
      * Key numbers are only supported as end-user input via QMP */
@@ -372,9 +372,9 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
+static QemuInputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
 {
-    InputEvent *evt = g_new0(InputEvent, 1);
+    QemuInputEvent *evt = g_new0(QemuInputEvent, 1);
     evt->u.key.data = g_new0(InputKeyEvent, 1);
     evt->type = INPUT_EVENT_KIND_KEY;
     evt->u.key.data->key = key;
@@ -384,7 +384,7 @@ static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
 
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
 {
-    InputEvent *evt;
+    QemuInputEvent *evt;
     evt = qemu_input_event_new_key(key, down);
     if (QTAILQ_EMPTY(&kbd_queue)) {
         qemu_input_event_send(src, evt);
@@ -435,7 +435,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
         .button = btn,
         .down = down,
     };
-    InputEvent evt = {
+    QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_BTN,
         .u.btn.data = &bevt,
     };
@@ -486,7 +486,7 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
         .axis = axis,
         .value = value,
     };
-    InputEvent evt = {
+    QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_REL,
         .u.rel.data = &move,
     };
@@ -503,7 +503,7 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
                                        INPUT_EVENT_ABS_MIN,
                                        INPUT_EVENT_ABS_MAX),
     };
-    InputEvent evt = {
+    QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_ABS,
         .u.abs.data = &move,
     };
@@ -519,7 +519,7 @@ void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type,
         .slot = slot,
         .tracking_id = tracking_id,
     };
-    InputEvent evt = {
+    QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_MTT,
         .u.mtt.data = &mtt,
     };
@@ -539,7 +539,7 @@ void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
                                        INPUT_EVENT_ABS_MIN,
                                        INPUT_EVENT_ABS_MAX),
     };
-    InputEvent evt = {
+    QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_MTT,
         .u.mtt.data = &mtt,
     };
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb55cbefc9c3..28a83c7c389c 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -226,7 +226,7 @@ static void vdagent_send_mouse(VDAgentChardev *vd)
 }
 
 static void vdagent_pointer_event(DeviceState *dev, QemuConsole *src,
-                                  InputEvent *evt)
+                                  QemuInputEvent *evt)
 {
     static const int bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]        = VD_AGENT_LBUTTON_MASK,

-- 
2.54.0


