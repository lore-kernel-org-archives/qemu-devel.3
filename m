Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD6CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ233-0006nv-G2; Thu, 21 May 2026 07:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ22y-0006iU-FP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ22w-0004DO-19
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXJCyBYPJ2LyljuxM9u8r6lghDNX43DPRG6Wz80yJRQ=;
 b=RphmcnsHdRn6H04qbGo23H1J11kOgK4jQ9JAgvry9mRb4Xbkk2JUg+Z3nJIxXj/YoHouMB
 QO+lVkZdWKgeJZYTO73eUAvceGwif1Co4ZWZjM1bNWRtq11xSETLjbNyu9kJ/xSlKH/aSr
 KBaSIDlg52HI3YobwmcTnmW/rC7Smag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-LviHhN-9PVWfPi1oLTxAYQ-1; Thu,
 21 May 2026 07:58:32 -0400
X-MC-Unique: LviHhN-9PVWfPi1oLTxAYQ-1
X-Mimecast-MFC-AGG-ID: LviHhN-9PVWfPi1oLTxAYQ_1779364710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 377BF18002E8; Thu, 21 May 2026 11:58:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18CC81800352; Thu, 21 May 2026 11:58:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org (open list:Musicpal),
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-ppc@nongnu.org (open list:New World (mac99))
Subject: [PULL 11/38] ui/input: Store QKeyCode directly in QemuInputKeyEvent
Date: Thu, 21 May 2026 15:56:48 +0400
Message-ID: <20260521115717.1701482-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since commit af07e5ff02ae ("ui: convert key events to QKeyCodes
immediately"), all internal key events are expected to be represented as
QKeyCode. Replace KeyValue in QemuInputKeyEvent with QKeyCode to enforce
that and simplify key code retrieval.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-3-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/input.h           |  5 ++---
 hw/arm/musicpal.c            |  2 +-
 hw/char/escc.c               |  2 +-
 hw/display/xenfb.c           |  2 +-
 hw/input/adb-kbd.c           |  2 +-
 hw/input/hid.c               |  5 ++---
 hw/input/ps2.c               |  2 +-
 hw/input/stellaris_gamepad.c |  2 +-
 hw/input/virtio-input-hid.c  |  2 +-
 hw/m68k/next-kbd.c           |  2 +-
 replay/replay-input.c        | 29 ++++++-----------------------
 ui/input-keymap.c            |  9 ++++-----
 ui/input.c                   | 34 +++++++---------------------------
 ui/trace-events              |  1 -
 14 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 0b8c439fca7..3c3dfa7b59d 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -19,7 +19,7 @@ typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
 
 typedef struct QemuInputKeyEvent {
-    KeyValue key;
+    QKeyCode key;
     bool down;
 } QemuInputKeyEvent;
 
@@ -65,8 +65,7 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
 int qemu_input_key_value_to_number(const KeyValue *value);
 int qemu_input_key_value_to_qcode(const KeyValue *value);
-int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
-                                     int *codes);
+int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 43c93cb72d7..f436bd13d91 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1069,7 +1069,7 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
-    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    int qcode = evt->key.key;
     uint32_t event = 0;
     int i;
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index c88b2d54ebe..3ad803537e5 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -800,7 +800,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     int qcode, keycode;
 
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    qcode = evt->key.key;
     trace_escc_sunkbd_event_in(qcode, QKeyCode_str(qcode),
                                evt->key.down);
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 82d2cbae7cc..176796cbf62 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -203,7 +203,7 @@ static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    int qcode = evt->key.key;
     int lnx;
 
     if (qcode < qemu_input_map_qcode_to_linux_len) {
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 5911e713925..db3c7777500 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -311,7 +311,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     KBDState *s = (KBDState *)dev;
     int qcode, keycode;
 
-    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    qcode = evt->key.key;
     if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
         return;
     }
diff --git a/hw/input/hid.c b/hw/input/hid.c
index 90b29682a25..31f6331c7d7 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -227,9 +227,8 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
     int scancodes[3], i, count;
     int slot;
 
-    count = qemu_input_key_value_to_scancode(&evt->key.key,
-                                             evt->key.down,
-                                             scancodes);
+    count = qemu_input_qcode_to_scancode(evt->key.key, evt->key.down,
+                                         scancodes);
     if (hs->n + count > QUEUE_LENGTH) {
         trace_hid_kbd_queue_full();
         return;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 3e553176ef6..9090a0427bd 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -324,7 +324,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    qcode = evt->key.key;
 
     mod = ps2_modifier_bit(qcode);
     trace_ps2_keyboard_event(s, qcode, evt->key.down, mod,
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 7d8ec38e888..6f42c46ddad 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -19,7 +19,7 @@ static void stellaris_gamepad_event(DeviceState *dev, QemuConsole *src,
                                     QemuInputEvent *evt)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
-    int qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    int qcode = evt->key.key;
     int i;
 
     for (i = 0; i < s->num_buttons; i++) {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 3f8a1bc249e..d48be1ea211 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -87,7 +87,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+        qcode = evt->key.key;
         if (qcode < qemu_input_map_qcode_to_linux_len &&
             qemu_input_map_qcode_to_linux[qcode]) {
             event.type  = cpu_to_le16(EV_KEY);
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index f3110ea0bca..39f223d0211 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -248,7 +248,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
     NextKBDState *s = NEXTKBD(dev);
     int qcode, keycode;
 
-    qcode = qemu_input_key_value_to_qcode(&evt->key.key);
+    qcode = evt->key.key;
     if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
         return;
     }
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 0995b125f24..f1ee678ef72 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -23,21 +23,9 @@ void replay_save_input_event(QemuInputEvent *evt)
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        replay_put_dword(evt->key.key.type);
-
-        switch (evt->key.key.type) {
-        case KEY_VALUE_KIND_NUMBER:
-            replay_put_qword(evt->key.key.u.number.data);
-            replay_put_byte(evt->key.down);
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            replay_put_dword(evt->key.key.u.qcode.data);
-            replay_put_byte(evt->key.down);
-            break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
-        }
+        replay_put_dword(KEY_VALUE_KIND_QCODE);
+        replay_put_dword(evt->key.key);
+        replay_put_byte(evt->key.down);
         break;
     case INPUT_EVENT_KIND_BTN:
         replay_put_dword(evt->btn.button);
@@ -71,20 +59,15 @@ QemuInputEvent *replay_read_input_event(void)
     evt->type = replay_get_dword();
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        evt->key.key.type = replay_get_dword();
-
-        switch (evt->key.key.type) {
+        switch (replay_get_dword()) {
         case KEY_VALUE_KIND_NUMBER:
-            evt->key.key.u.number.data = replay_get_qword();
+            evt->key.key = qemu_input_key_number_to_qcode(replay_get_qword());
             evt->key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND_QCODE:
-            evt->key.key.u.qcode.data = (QKeyCode)replay_get_dword();
+            evt->key.key = (QKeyCode)replay_get_dword();
             evt->key.down = replay_get_byte();
             break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
         }
         break;
     case INPUT_EVENT_KIND_BTN:
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 1b756a6970c..2f6d431c824 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -61,14 +61,13 @@ int qemu_input_key_value_to_qcode(const KeyValue *value)
     }
 }
 
-int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
-                                     int *codes)
+int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes)
 {
-    int keycode = qemu_input_key_value_to_number(value);
+    int keycode = qcode < qemu_input_map_qcode_to_qnum_len ?
+                  qemu_input_map_qcode_to_qnum[qcode] : 0;
     int count = 0;
 
-    if (value->type == KEY_VALUE_KIND_QCODE &&
-        value->u.qcode.data == Q_KEY_CODE_PAUSE) {
+    if (qcode == Q_KEY_CODE_PAUSE) {
         /* specific case */
         int v = down ? 0 : 0x80;
         codes[count++] = 0xe1;
diff --git a/ui/input.c b/ui/input.c
index 97c473f40a2..9232dd7fdae 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -180,8 +180,7 @@ void qmp_input_send_event(const char *device,
                 g_assert_not_reached();
             }
 
-            evt.key.key.type = KEY_VALUE_KIND_QCODE;
-            evt.key.key.u.qcode.data = code;
+            evt.key.key = code;
             evt.key.down = qapi->u.key.data->down;
             break;
         }
@@ -215,7 +214,7 @@ void qmp_input_send_event(const char *device,
 static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
 {
     const char *name;
-    int qcode, idx = -1;
+    int idx = -1;
     QemuInputKeyEvent *key;
     InputBtnEvent *btn;
     InputMoveEvent *move;
@@ -227,21 +226,8 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         key = &evt->key;
-        switch (evt->key.key.type) {
-        case KEY_VALUE_KIND_NUMBER:
-            qcode = qemu_input_key_number_to_qcode(key->key.u.number.data);
-            name = QKeyCode_str(qcode);
-            trace_input_event_key_number(idx, key->key.u.number.data,
-                                         name, key->down);
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            name = QKeyCode_str(key->key.u.qcode.data);
-            trace_input_event_key_qcode(idx, name, key->down);
-            break;
-        case KEY_VALUE_KIND__MAX:
-            /* keep gcc happy */
-            break;
-        }
+        name = QKeyCode_str(key->key);
+        trace_input_event_key_qcode(idx, name, key->down);
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = &evt->btn;
@@ -357,12 +343,6 @@ void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
 
 void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
 {
-    /* Expect all parts of QEMU to send events with QCodes exclusively.
-     * Key numbers are only supported as end-user input via QMP */
-    assert(!(evt->type == INPUT_EVENT_KIND_KEY &&
-             evt->key.key.type == KEY_VALUE_KIND_NUMBER));
-
-
     /*
      * 'sysrq' was mistakenly added to hack around the fact that
      * the ps2 driver was not generating correct scancodes sequences
@@ -372,8 +352,8 @@ void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
      * need to deal with this mistake
      */
     if (evt->type == INPUT_EVENT_KIND_KEY &&
-        evt->key.key.u.qcode.data == Q_KEY_CODE_SYSRQ) {
-        evt->key.key.u.qcode.data = Q_KEY_CODE_PRINT;
+        evt->key.key == Q_KEY_CODE_SYSRQ) {
+        evt->key.key = Q_KEY_CODE_PRINT;
     }
 
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
@@ -414,7 +394,7 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_KEY,
         .key = {
-            .key = *key,
+            .key = qemu_input_key_value_to_qcode(key),
             .down = down,
         },
     };
diff --git a/ui/trace-events b/ui/trace-events
index c1ea56874ee..1c0d96a92c3 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -127,7 +127,6 @@ vnc_tight_zlib_init(void *state, int stream_id, const void *opaque) "VNC tight z
 
 
 # input.c
-input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number 0x%x [%s], down %d"
 input_event_key_qcode(int conidx, const char *qcode, bool down) "con %d, key qcode %s, down %d"
 input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down %d"
 input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
-- 
2.54.0


