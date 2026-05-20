Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82B2CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPalM-0005bU-Nq; Wed, 20 May 2026 02:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak5-0003f4-Rk; Wed, 20 May 2026 02:49:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPak0-0001XD-6O; Wed, 20 May 2026 02:49:21 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64K6lnbR096590
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 May 2026 15:48:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Gex7w1F8YpPNOazIywx6B3BqCZ8bGRVEHA+CamBGkpY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1779259694; v=1;
 b=kCpR2PzVfWSs/e+jYN5MjXl6rULQkeSS9SyGYa2d1LoterZaxZTNLvvbVS2JitBP
 Y8qrnFpTlQ37DJRi32xo2+BWnCBZgW3nyPBcKAlnDo8Vft6eINRkCsph54+SkNuz
 WWK48M86eVDS4eK0Wo7OEKWjTHkDnuoLFiBG0mLi+5VaMVV5VRAytywdyx/rYyZ8
 /UhWskYHraTAHghLvi1nrEU7xbCdvS2irr6SVTMEE4XuDrLelkX5eRJBwLo7OTTI
 Rt2h5JBueVg/i1wHSrpM3c0irVSlr9u3h3w0hHzK1fCBib1E8vfkYUlM33pxKvu2
 pJO9c9ANg8QQOkOHrmUFnw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 15:47:47 +0900
Subject: [PATCH v3 04/29] ui/input: Use Linux key codes for internal key events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-input-v3-4-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23847;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=yvvxfrLqGcPJano8bhactXJ6BBYMXYm+PRaHhsH3cHI=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZvpLSR2YQrdv4fvN9vMDHiWraW8bqHPvfUvqUqmpEHf
 dSmfc/pKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMj5mwx/JQuib1i8/p2e9f7x
 hi73J07ei/7HTTiw7XTICRu79rK39gz/i8SqJnNJfnkt8X7+PEmfi1qrvV/qTG6qEbvqGXV3VvV
 jBgA=
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

Linux input key codes are a better internal representation than
QKeyCode:

- With Linux input key codes as the internal representation, keys
  previously lost solely because the middle layer between event sources
  and sinks used QKeyCode will be preserved, since Linux key codes
  cover all keys that those sources and sinks use. For example,
  KEY_KPJPCOMMA cannot be represented with QKeyCode, but it is widely
  supported by event sources and sinks since it is included in linux,
  atset1, atset2, usb, x11, osx, qnum (derived from atset1),
  xorgxquartz, and xorgevdev (derived from linux).

- They make it possible to pass through Linux host key codes to Linux
  guests to preserve all key inputs.

- They simplify consumers by avoiding QKeyCode aliases, namely
  asterisk/kp_multiply and sysrq/print.

This matches the approach used by virtio and Xen.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/input.h           | 49 +++++++++++++++++++++++++++++++++++++-
 hw/arm/musicpal.c            |  2 +-
 hw/char/escc.c               |  2 +-
 hw/display/xenfb.c           |  2 +-
 hw/input/adb-kbd.c           |  2 +-
 hw/input/hid.c               |  3 ++-
 hw/input/ps2.c               |  2 +-
 hw/input/stellaris_gamepad.c |  2 +-
 hw/input/virtio-input-hid.c  |  2 +-
 hw/m68k/next-kbd.c           |  2 +-
 replay/replay-input.c        | 11 ++++++---
 tools/qemu-vnc/input.c       | 13 +++++++---
 ui/input-keymap.c            | 56 +++++++++++++++++++++++++++++++++++---------
 ui/input.c                   | 51 ++++++++++++----------------------------
 tools/qemu-vnc/trace-events  |  2 +-
 ui/meson.build               | 14 +++++++++++
 16 files changed, 151 insertions(+), 64 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 3c3dfa7b59df..e76dd4b172aa 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -19,7 +19,7 @@ typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
 
 typedef struct QemuInputKeyEvent {
-    QKeyCode key;
+    unsigned int key;
     bool down;
 } QemuInputKeyEvent;
 
@@ -59,13 +59,18 @@ void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
+void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
+                                     bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
 void qemu_input_event_send_key_delay(uint32_t delay_ms);
 int qemu_input_key_number_to_qcode(unsigned int nr);
+unsigned int qemu_input_key_number_to_linux(unsigned int nr);
 int qemu_input_key_value_to_number(const KeyValue *value);
 int qemu_input_key_value_to_qcode(const KeyValue *value);
+unsigned int qemu_input_key_value_to_linux(const KeyValue *value);
 int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes);
+int qemu_input_linux_to_scancode(unsigned int lnx, bool down, int *codes);
 int qemu_input_linux_to_qcode(unsigned int lnx);
 
 void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
@@ -107,52 +112,94 @@ void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 extern const guint qemu_input_map_atset1_to_qcode_len;
 extern const guint16 qemu_input_map_atset1_to_qcode[];
 
+extern const guint qemu_input_map_atset1_to_linux_len;
+extern const guint16 qemu_input_map_atset1_to_linux[];
+
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
 extern const guint qemu_input_map_qcode_to_atset1_len;
 extern const guint16 qemu_input_map_qcode_to_atset1[];
 
+extern const guint qemu_input_map_linux_to_atset1_len;
+extern const guint16 qemu_input_map_linux_to_atset1[];
+
 extern const guint qemu_input_map_qcode_to_atset2_len;
 extern const guint16 qemu_input_map_qcode_to_atset2[];
 
+extern const guint qemu_input_map_linux_to_atset2_len;
+extern const guint16 qemu_input_map_linux_to_atset2[];
+
 extern const guint qemu_input_map_qcode_to_atset3_len;
 extern const guint16 qemu_input_map_qcode_to_atset3[];
 
+extern const guint qemu_input_map_linux_to_atset3_len;
+extern const guint16 qemu_input_map_linux_to_atset3[];
+
 extern const guint qemu_input_map_qcode_to_linux_len;
 extern const guint16 qemu_input_map_qcode_to_linux[];
 
 extern const guint qemu_input_map_qcode_to_qnum_len;
 extern const guint16 qemu_input_map_qcode_to_qnum[];
 
+extern const guint qemu_input_map_linux_to_qnum_len;
+extern const guint16 qemu_input_map_linux_to_qnum[];
+
 extern const guint qemu_input_map_qcode_to_sun_len;
 extern const guint16 qemu_input_map_qcode_to_sun[];
 
+extern const guint qemu_input_map_linux_to_sun_len;
+extern const guint16 qemu_input_map_linux_to_sun[];
+
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
 
+extern const guint qemu_input_map_qnum_to_linux_len;
+extern const guint16 qemu_input_map_qnum_to_linux[];
+
 extern const guint qemu_input_map_usb_to_qcode_len;
 extern const guint16 qemu_input_map_usb_to_qcode[];
 
+extern const guint qemu_input_map_usb_to_linux_len;
+extern const guint16 qemu_input_map_usb_to_linux[];
+
 extern const guint qemu_input_map_win32_to_qcode_len;
 extern const guint16 qemu_input_map_win32_to_qcode[];
 
+extern const guint qemu_input_map_win32_to_linux_len;
+extern const guint16 qemu_input_map_win32_to_linux[];
+
 extern const guint qemu_input_map_x11_to_qcode_len;
 extern const guint16 qemu_input_map_x11_to_qcode[];
 
+extern const guint qemu_input_map_x11_to_linux_len;
+extern const guint16 qemu_input_map_x11_to_linux[];
+
 extern const guint qemu_input_map_xorgevdev_to_qcode_len;
 extern const guint16 qemu_input_map_xorgevdev_to_qcode[];
 
 extern const guint qemu_input_map_xorgkbd_to_qcode_len;
 extern const guint16 qemu_input_map_xorgkbd_to_qcode[];
 
+extern const guint qemu_input_map_xorgkbd_to_linux_len;
+extern const guint16 qemu_input_map_xorgkbd_to_linux[];
+
 extern const guint qemu_input_map_xorgxquartz_to_qcode_len;
 extern const guint16 qemu_input_map_xorgxquartz_to_qcode[];
 
+extern const guint qemu_input_map_xorgxquartz_to_linux_len;
+extern const guint16 qemu_input_map_xorgxquartz_to_linux[];
+
 extern const guint qemu_input_map_xorgxwin_to_qcode_len;
 extern const guint16 qemu_input_map_xorgxwin_to_qcode[];
 
+extern const guint qemu_input_map_xorgxwin_to_linux_len;
+extern const guint16 qemu_input_map_xorgxwin_to_linux[];
+
 extern const guint qemu_input_map_osx_to_qcode_len;
 extern const guint16 qemu_input_map_osx_to_qcode[];
 
+extern const guint qemu_input_map_osx_to_linux_len;
+extern const guint16 qemu_input_map_osx_to_linux[];
+
 #endif /* INPUT_H */
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f436bd13d912..c8985a58f993 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1069,7 +1069,7 @@ static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     musicpal_key_state *s = MUSICPAL_KEY(dev);
-    int qcode = evt->key.key;
+    int qcode = qemu_input_linux_to_qcode(evt->key.key);
     uint32_t event = 0;
     int i;
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3ad803537e5e..39483ca03bf2 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -800,7 +800,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     int qcode, keycode;
 
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = evt->key.key;
+    qcode = qemu_input_linux_to_qcode(evt->key.key);
     trace_escc_sunkbd_event_in(qcode, QKeyCode_str(qcode),
                                evt->key.down);
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 176796cbf62f..218f37f07400 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -203,7 +203,7 @@ static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    int qcode = evt->key.key;
+    int qcode = qemu_input_linux_to_qcode(evt->key.key);
     int lnx;
 
     if (qcode < qemu_input_map_qcode_to_linux_len) {
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index db3c77775009..060481d0db6d 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -311,7 +311,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     KBDState *s = (KBDState *)dev;
     int qcode, keycode;
 
-    qcode = evt->key.key;
+    qcode = qemu_input_linux_to_qcode(evt->key.key);
     if (qcode >= ARRAY_SIZE(qcode_to_adb_keycode)) {
         return;
     }
diff --git a/hw/input/hid.c b/hw/input/hid.c
index 31f6331c7d7e..013840562f60 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -224,10 +224,11 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     HIDState *hs = (HIDState *)dev;
+    int qcode = qemu_input_linux_to_qcode(evt->key.key);
     int scancodes[3], i, count;
     int slot;
 
-    count = qemu_input_qcode_to_scancode(evt->key.key, evt->key.down,
+    count = qemu_input_qcode_to_scancode(qcode, evt->key.down,
                                          scancodes);
     if (hs->n + count > QUEUE_LENGTH) {
         trace_hid_kbd_queue_full();
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 9090a0427bd8..93c3c7372054 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -324,7 +324,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = evt->key.key;
+    qcode = qemu_input_linux_to_qcode(evt->key.key);
 
     mod = ps2_modifier_bit(qcode);
     trace_ps2_keyboard_event(s, qcode, evt->key.down, mod,
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 6f42c46ddad3..25769fc26168 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -19,7 +19,7 @@ static void stellaris_gamepad_event(DeviceState *dev, QemuConsole *src,
                                     QemuInputEvent *evt)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
-    int qcode = evt->key.key;
+    int qcode = qemu_input_linux_to_qcode(evt->key.key);
     int i;
 
     for (i = 0; i < s->num_buttons; i++) {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index d48be1ea211e..1d2e922567ab 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -87,7 +87,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        qcode = evt->key.key;
+        qcode = qemu_input_linux_to_qcode(evt->key.key);
         if (qcode < qemu_input_map_qcode_to_linux_len &&
             qemu_input_map_qcode_to_linux[qcode]) {
             event.type  = cpu_to_le16(EV_KEY);
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 39f223d02114..7efbd806b7c8 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -248,7 +248,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src,
     NextKBDState *s = NEXTKBD(dev);
     int qcode, keycode;
 
-    qcode = evt->key.key;
+    qcode = qemu_input_linux_to_qcode(evt->key.key);
     if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
         return;
     }
diff --git a/replay/replay-input.c b/replay/replay-input.c
index f1ee678ef726..acf0993c7285 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -24,7 +24,7 @@ void replay_save_input_event(QemuInputEvent *evt)
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         replay_put_dword(KEY_VALUE_KIND_QCODE);
-        replay_put_dword(evt->key.key);
+        replay_put_dword(qemu_input_linux_to_qcode(evt->key.key));
         replay_put_byte(evt->key.down);
         break;
     case INPUT_EVENT_KIND_BTN:
@@ -55,20 +55,25 @@ void replay_save_input_event(QemuInputEvent *evt)
 QemuInputEvent *replay_read_input_event(void)
 {
     QemuInputEvent *evt = g_new(QemuInputEvent, 1);
+    int qcode;
 
     evt->type = replay_get_dword();
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         switch (replay_get_dword()) {
         case KEY_VALUE_KIND_NUMBER:
-            evt->key.key = qemu_input_key_number_to_qcode(replay_get_qword());
+            qcode = qemu_input_key_number_to_qcode(replay_get_qword());
             evt->key.down = replay_get_byte();
             break;
         case KEY_VALUE_KIND_QCODE:
-            evt->key.key = (QKeyCode)replay_get_dword();
+            qcode = (QKeyCode)replay_get_dword();
             evt->key.down = replay_get_byte();
             break;
+        default:
+            g_assert_not_reached();
         }
+        evt->key.key = qcode < qemu_input_map_qcode_to_linux_len ?
+                       qemu_input_map_qcode_to_linux[qcode] : 0;
         break;
     case INPUT_EVENT_KIND_BTN:
         evt->btn.button = (InputButton)replay_get_dword();
diff --git a/tools/qemu-vnc/input.c b/tools/qemu-vnc/input.c
index 2313b0a7c771..90e2e79d1ea7 100644
--- a/tools/qemu-vnc/input.c
+++ b/tools/qemu-vnc/input.c
@@ -82,11 +82,18 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
 }
 
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
+{
+    unsigned int lnx = qemu_input_map_qcode_to_linux[q];
+    qemu_input_event_send_key_linux(src, lnx, down);
+}
+
+void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
+                                     bool down)
 {
     QemuDBusDisplay1Keyboard *kbd;
     guint qnum;
 
-    trace_qemu_vnc_key_event(q, down);
+    trace_qemu_vnc_key_event(lnx, down);
 
     if (!src) {
         return;
@@ -96,10 +103,10 @@ void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
         return;
     }
 
-    if (q >= qemu_input_map_qcode_to_qnum_len) {
+    if (lnx >= qemu_input_map_linux_to_qnum_len) {
         return;
     }
-    qnum = qemu_input_map_qcode_to_qnum[q];
+    qnum = qemu_input_map_linux_to_qnum[lnx];
 
     if (down) {
         qemu_dbus_display1_keyboard_call_press(
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 2f6d431c8246..2b77ef09fd66 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -5,22 +5,36 @@
 #include "standard-headers/linux/input.h"
 
 #include "ui/input-keymap-atset1-to-qcode.c.inc"
+#include "ui/input-keymap-atset1-to-linux.c.inc"
 #include "ui/input-keymap-linux-to-qcode.c.inc"
 #include "ui/input-keymap-qcode-to-atset1.c.inc"
+#include "ui/input-keymap-linux-to-atset1.c.inc"
 #include "ui/input-keymap-qcode-to-atset2.c.inc"
+#include "ui/input-keymap-linux-to-atset2.c.inc"
 #include "ui/input-keymap-qcode-to-atset3.c.inc"
+#include "ui/input-keymap-linux-to-atset3.c.inc"
 #include "ui/input-keymap-qcode-to-linux.c.inc"
 #include "ui/input-keymap-qcode-to-qnum.c.inc"
+#include "ui/input-keymap-linux-to-qnum.c.inc"
 #include "ui/input-keymap-qcode-to-sun.c.inc"
+#include "ui/input-keymap-linux-to-sun.c.inc"
 #include "ui/input-keymap-qnum-to-qcode.c.inc"
+#include "ui/input-keymap-qnum-to-linux.c.inc"
 #include "ui/input-keymap-usb-to-qcode.c.inc"
+#include "ui/input-keymap-usb-to-linux.c.inc"
 #include "ui/input-keymap-win32-to-qcode.c.inc"
+#include "ui/input-keymap-win32-to-linux.c.inc"
 #include "ui/input-keymap-x11-to-qcode.c.inc"
+#include "ui/input-keymap-x11-to-linux.c.inc"
 #include "ui/input-keymap-xorgevdev-to-qcode.c.inc"
 #include "ui/input-keymap-xorgkbd-to-qcode.c.inc"
+#include "ui/input-keymap-xorgkbd-to-linux.c.inc"
 #include "ui/input-keymap-xorgxquartz-to-qcode.c.inc"
+#include "ui/input-keymap-xorgxquartz-to-linux.c.inc"
 #include "ui/input-keymap-xorgxwin-to-qcode.c.inc"
+#include "ui/input-keymap-xorgxwin-to-linux.c.inc"
 #include "ui/input-keymap-osx-to-qcode.c.inc"
+#include "ui/input-keymap-osx-to-linux.c.inc"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
@@ -45,29 +59,49 @@ int qemu_input_key_value_to_number(const KeyValue *value)
 
 int qemu_input_key_number_to_qcode(unsigned int nr)
 {
-    if (nr >= qemu_input_map_qnum_to_qcode_len) {
-        return 0;
+    return qemu_input_linux_to_qcode(qemu_input_key_number_to_linux(nr));
+}
+
+unsigned int qemu_input_key_number_to_linux(unsigned int nr)
+{
+    if (nr >= qemu_input_map_qnum_to_linux_len) {
+        return KEY_RESERVED;
     }
-    return qemu_input_map_qnum_to_qcode[nr];
+    return qemu_input_map_qnum_to_linux[nr];
 }
 
 int qemu_input_key_value_to_qcode(const KeyValue *value)
 {
-    if (value->type == KEY_VALUE_KIND_QCODE) {
-        return value->u.qcode.data;
-    } else {
-        assert(value->type == KEY_VALUE_KIND_NUMBER);
-        return qemu_input_key_number_to_qcode(value->u.number.data);
+    return qemu_input_linux_to_qcode(qemu_input_key_value_to_linux(value));
+}
+
+unsigned int qemu_input_key_value_to_linux(const KeyValue *value)
+{
+    switch (value->type) {
+    case KEY_VALUE_KIND_NUMBER:
+        return qemu_input_key_number_to_linux(value->u.number.data);
+
+    case KEY_VALUE_KIND_QCODE:
+        return qemu_input_map_qcode_to_linux[value->u.qcode.data];
+
+    default:
+        g_assert_not_reached();
     }
 }
 
 int qemu_input_qcode_to_scancode(QKeyCode qcode, bool down, int *codes)
 {
-    int keycode = qcode < qemu_input_map_qcode_to_qnum_len ?
-                  qemu_input_map_qcode_to_qnum[qcode] : 0;
+    return qemu_input_linux_to_scancode(qemu_input_map_qcode_to_linux[qcode],
+                                        down, codes);
+}
+
+int qemu_input_linux_to_scancode(unsigned int lnx, bool down, int *codes)
+{
+    int keycode = lnx < qemu_input_map_linux_to_qnum_len ?
+                  qemu_input_map_linux_to_qnum[lnx] : 0;
     int count = 0;
 
-    if (qcode == Q_KEY_CODE_PAUSE) {
+    if (lnx == KEY_PAUSE) {
         /* specific case */
         int v = down ? 0 : 0x80;
         codes[count++] = 0xe1;
diff --git a/ui/input.c b/ui/input.c
index 9232dd7fdae9..aeb7bf35e196 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -165,25 +165,10 @@ void qmp_input_send_event(const char *device,
         evt.type = qapi->type;
 
         switch (qapi->type) {
-        case INPUT_EVENT_KIND_KEY: {
-            KeyValue *key = qapi->u.key.data->key;
-            QKeyCode code;
-
-            switch (key->type) {
-            case KEY_VALUE_KIND_NUMBER:
-                code = qemu_input_key_number_to_qcode(key->u.number.data);
-                break;
-            case KEY_VALUE_KIND_QCODE:
-                code = key->u.qcode.data;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
-            evt.key.key = code;
+        case INPUT_EVENT_KIND_KEY:
+            evt.key.key = qemu_input_key_value_to_linux(qapi->u.key.data->key);
             evt.key.down = qapi->u.key.data->down;
             break;
-        }
 
         case INPUT_EVENT_KIND_BTN:
             evt.btn = *qapi->u.btn.data;
@@ -226,7 +211,7 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
         key = &evt->key;
-        name = QKeyCode_str(key->key);
+        name = QKeyCode_str(qemu_input_linux_to_qcode(key->key));
         trace_input_event_key_qcode(idx, name, key->down);
         break;
     case INPUT_EVENT_KIND_BTN:
@@ -343,19 +328,6 @@ void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
 
 void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
 {
-    /*
-     * 'sysrq' was mistakenly added to hack around the fact that
-     * the ps2 driver was not generating correct scancodes sequences
-     * when 'alt+print' was pressed. This flaw is now fixed and the
-     * 'sysrq' key serves no further purpose. We normalize it to
-     * 'print', so that downstream receivers of the event don't
-     * need to deal with this mistake
-     */
-    if (evt->type == INPUT_EVENT_KIND_KEY &&
-        evt->key.key == Q_KEY_CODE_SYSRQ) {
-        evt->key.key = Q_KEY_CODE_PRINT;
-    }
-
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
         return;
     }
@@ -390,17 +362,24 @@ void qemu_input_event_sync(void)
 }
 
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
+{
+    unsigned int lnx = qemu_input_key_value_to_linux(key);
+
+    g_free(key);
+    qemu_input_event_send_key_linux(src, lnx, down);
+}
+
+void qemu_input_event_send_key_linux(QemuConsole *src, unsigned int lnx,
+                                     bool down)
 {
     QemuInputEvent evt = {
         .type = INPUT_EVENT_KIND_KEY,
         .key = {
-            .key = qemu_input_key_value_to_qcode(key),
+            .key = lnx,
             .down = down,
         },
     };
 
-    g_free(key);
-
     if (QTAILQ_EMPTY(&kbd_queue)) {
         qemu_input_event_send(src, &evt);
         qemu_input_event_sync();
@@ -412,8 +391,8 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
 
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
 {
-    QKeyCode code = qemu_input_key_number_to_qcode(num);
-    qemu_input_event_send_key_qcode(src, code, down);
+    unsigned int lnx = qemu_input_key_number_to_linux(num);
+    qemu_input_event_send_key_linux(src, lnx, down);
 }
 
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
diff --git a/tools/qemu-vnc/trace-events b/tools/qemu-vnc/trace-events
index e3b550de10e3..570062984a42 100644
--- a/tools/qemu-vnc/trace-events
+++ b/tools/qemu-vnc/trace-events
@@ -12,7 +12,7 @@ qemu_vnc_cursor_define(int width, int height, int hot_x, int hot_y) "w=%d h=%d h
 qemu_vnc_input_abs(uint32_t x, uint32_t y) "x=%u y=%u"
 qemu_vnc_input_btn(int button, bool press) "button=%d press=%d"
 qemu_vnc_input_rel(int dx, int dy) "dx=%d dy=%d"
-qemu_vnc_key_event(int qcode, bool down) "qcode=%d down=%d"
+qemu_vnc_key_event(unsigned int lnx, bool down) "lnx=%u down=%d"
 qemu_vnc_owner_appeared(const char *name) "peer=%s"
 qemu_vnc_owner_vanished(const char *name) "peer=%s"
 qemu_vnc_scanout(uint32_t width, uint32_t height, uint32_t stride, uint32_t format) "w=%u h=%u stride=%u fmt=0x%x"
diff --git a/ui/meson.build b/ui/meson.build
index 1b8f71796e40..1504e27248f3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,21 +1,35 @@
 keymaps = [
   ['atset1', 'qcode'],
+  ['atset1', 'linux'],
   ['linux', 'qcode'],
   ['qcode', 'atset1'],
+  ['linux', 'atset1'],
   ['qcode', 'atset2'],
+  ['linux', 'atset2'],
   ['qcode', 'atset3'],
+  ['linux', 'atset3'],
   ['qcode', 'linux'],
   ['qcode', 'qnum'],
+  ['linux', 'qnum'],
   ['qcode', 'sun'],
+  ['linux', 'sun'],
   ['qnum', 'qcode'],
+  ['qnum', 'linux'],
   ['usb', 'qcode'],
+  ['usb', 'linux'],
   ['win32', 'qcode'],
+  ['win32', 'linux'],
   ['x11', 'qcode'],
+  ['x11', 'linux'],
   ['xorgevdev', 'qcode'],
   ['xorgkbd', 'qcode'],
+  ['xorgkbd', 'linux'],
   ['xorgxquartz', 'qcode'],
+  ['xorgxquartz', 'linux'],
   ['xorgxwin', 'qcode'],
+  ['xorgxwin', 'linux'],
   ['osx', 'qcode'],
+  ['osx', 'linux'],
 ]
 
 if have_system or xkbcommon.found()

-- 
2.54.0


