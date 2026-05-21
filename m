Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B11CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3u8-0000L8-El; Thu, 21 May 2026 09:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3tT-0008Bm-TV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3tR-0000tQ-7O
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jnkl+SY9AP2/RSV/S8/BJ98fQdY44M9KF+GDVrKUz1s=;
 b=SJztJAySk613ijx33SmVZ72+7AUVP7tCPku155YnDRt40Ejf+6jp3y/Tc57QOkq3kxfhhC
 7puZrc/WDudgqBb0bHE8InXnrR8sVAmQevg6ub8weTMk0aUxVU7OTJJEKjKVy/ZEz1jXwH
 uawDQ84qYkzmzpwjCczCGFLMw5bnikM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-4FEXOXU8PuSzqWFVrhfUzA-1; Thu,
 21 May 2026 09:56:52 -0400
X-MC-Unique: 4FEXOXU8PuSzqWFVrhfUzA-1
X-Mimecast-MFC-AGG-ID: 4FEXOXU8PuSzqWFVrhfUzA_1779371810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 209A418002E9; Thu, 21 May 2026 13:56:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 030781800357; Thu, 21 May 2026 13:56:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org (open list:Musicpal),
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-ppc@nongnu.org (open list:Old World (g3beige))
Subject: [PULL v2 09/38] ui/input: Introduce QemuInputEvent typedef
Date: Thu, 21 May 2026 17:55:20 +0400
Message-ID: <20260521135551.1752945-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add QemuInputEvent as the input subsystem's name for InputEvent and use
it in input handler, queue, and replay interfaces.

This prepares for decoupling QEMU's internal input event representation
from the QAPI InputEvent type.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-1-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
index 07f2ae7c9f1..da7097c5440 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -94,6 +94,7 @@ typedef struct QBool QBool;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
+typedef struct InputEvent QemuInputEvent;
 typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuMutex QemuMutex;
diff --git a/include/system/replay.h b/include/system/replay.h
index 19fb6dbb396..3b00386821b 100644
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
index 52c164bde57..c455abdec6a 100644
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
index 643b357da12..42c393542eb 100644
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
index 365f04546e9..146457661f9 100644
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
index 214d5ca2e28..05d2333fb0c 100644
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
index 83676eb7fea..ae171710e34 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1066,7 +1066,7 @@ struct musicpal_key_state {
 };
 
 static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
-                               InputEvent *evt)
+                               QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
     InputKeyEvent *key = evt->u.key.data;
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3b46818ecc9..677c3a120e1 100644
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
index 8e9953bda43..c71174e1376 100644
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
index 507557deecc..5ba6c9a7b5d 100644
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
index 373ef3f953c..c37ccf26c16 100644
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
index de24cd0ef04..53afb1d4340 100644
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
index 10ac7324030..90bcbcdff88 100644
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
index 42d43f9af51..db35905554d 100644
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
index 14dde90a48b..5b9f407c546 100644
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
index 571a9555040..9dbedac6479 100644
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
index 9e5af5e8495..20df810279e 100644
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
index 562bbf37175..3f506f2338a 100644
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
index b2c52bc4043..f8e17dcf1ce 100644
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
index ca4bccb4113..5467010c371 100644
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
index 966023d4f4d..759855c67e8 100644
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
index bb55cbefc9c..28a83c7c389 100644
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


