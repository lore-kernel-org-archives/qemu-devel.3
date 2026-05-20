Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7610CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPale-0007Tv-C2; Wed, 20 May 2026 02:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak5-0003f2-Rl; Wed, 20 May 2026 02:49:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPajz-0001Wx-MY; Wed, 20 May 2026 02:49:20 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbQ096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V2vpcZGcvosxBrWzNCTMDzqaSpzXJBuutR9ILf7Q9sE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259694; v=1;
 b=TJt46w5spzy31YrL2nBQWOjvceFt2TI84gdbhc+WR1+QvYqrl0DIAwUArG1uI5fJ
 1Nqw065xa6lDj6tBPzcl1mZ5ui3SCM6eFBkozmGikbNk6taFrJBdpxMchvXheXD8
 nkymzMrkebWK4SFz6Rv7Qu3JDgu9haabOh5tKi7CjWPfb82hI4+wc7cOXMFlmYrY
 AX54Z//P2XMZ0X3LEmiWPjHVPYgaRZfudza2ySdOtEl8ks5fiuETnuFYDcAOvhSM
 LE/rzhrTLE10Khtu1q1LqUTbudUY5oWaiCFhH2TP4j0j6JXKv2Gv63lVIlJNuxM9
 DpJ6Ll3/x65mtQqaMkhp9A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:46 +0900
Subject: [PATCH v3 03/29] ui/input: Store QKeyCode directly in
 QemuInputKeyEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-3-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13419;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ICg9/MxMUzQMb7xW3IgqjRSRtj/aZoiEPGWid0YCexg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpHTcty3NHA3X1f3OzCn+yX6jNfnbNLMVsh77zJ8zt
 k2SZbvcUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJH+14wM635XchxccnrLrQ/7
 Xys0XbRql9L438s6P0CF00/z/Rond0aGhg0rojytZb5MejSv4cp/4axpP89tqan8Z+TUN6ua7cl
 mNgA=
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

Since commit af07e5ff02ae ("ui: convert key events to QKeyCodes
immediately"), all internal key events are expected to be represented as
QKeyCode. Replace KeyValue in QemuInputKeyEvent with QKeyCode to enforce
that and simplify key code retrieval.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
index 0b8c439fca74..3c3dfa7b59df 100644
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
index 43c93cb72d75..f436bd13d912 100644
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
index c88b2d54ebe0..3ad803537e5e 100644
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
index 82d2cbae7cc5..176796cbf62f 100644
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
index 5911e7139257..db3c77775009 100644
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
index 90b29682a254..31f6331c7d7e 100644
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
index 3e553176ef6e..9090a0427bd8 100644
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
index 7d8ec38e8885..6f42c46ddad3 100644
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
index 3f8a1bc249e0..d48be1ea211e 100644
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
index f3110ea0bca4..39f223d02114 100644
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
index 0995b125f244..f1ee678ef726 100644
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
index 1b756a6970c0..2f6d431c8246 100644
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
index 97c473f40a2b..9232dd7fdae9 100644
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
index c1ea56874ee9..1c0d96a92c39 100644
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


