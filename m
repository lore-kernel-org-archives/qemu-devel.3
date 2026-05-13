Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3396BCD4F39
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70y-0004WA-EF; Wed, 13 May 2026 06:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70T-00040k-0T; Wed, 13 May 2026 06:40:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70N-0002Qr-Dz; Wed, 13 May 2026 06:39:59 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdb044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=np+DDHtPXccYUqkjVcTnB/XI0jqPO74kxFNXv7P7G5A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668737; v=1;
 b=vT0JG0CpBPmnY9cdIzCwYXqXlPxp8WZkvD9sGKyKeGldZR0fPNHk5QFdQBh+fGVN
 F1VdUfZQ4SMFIIOsCzDOYJYWOeJWbibVoaqbgKrhu652I6kqZbU16stcpe+f50Wg
 H9fqO1IbQWMxXok/yD9Kpr5GNeZIOn3zcLGtD7Cr2LyTA9f8jhNhTPjiB2FOrNTY
 yOdT2NqrfIYwOUKXGVcpQxjtz4WlTehfYJyBN55dS2cWAwdSohengA7roziE5kDB
 0D0RuFpAKdFwcTyL6AHmATqlU1iHn453AizjPdtV92V/E0b5c7jQTSSFoIStVlyE
 3ubD2AdmmhCQmdziKB6z1A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:29 +0900
Subject: [PATCH v2 13/29] hw/input/ps2: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-13-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7874;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Ae9vuWLzKV99hiDeipjG2FLc+ZAAXG2DeDzyFVZrokg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyAbXjEe6yddUHupyKUZn8P9YVnZpj93Xc5f+hxsfe
 3rCbMW1jlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgInccWT4Z9Yunui6d53nnvh0
 ttonapNPC2oYli2ROhnPL7et4Oj3WkaGO8fE71zZt1HgxeJJL3ZVVhZOjvZ98qf+4rGje87GPJa
 z4gEA
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
 hw/input/ps2.c        | 51 +++++++++++++++++++++++++--------------------------
 hw/input/trace-events |  2 +-
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 93c3c7372054..f2523ff4bc78 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -28,6 +28,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/input/ps2.h"
 #include "migration/vmstate.h"
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "system/reset.h"
@@ -123,20 +124,20 @@ static uint8_t translate_table[256] = {
     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
 };
 
-static unsigned int ps2_modifier_bit(QKeyCode key)
+static unsigned int ps2_modifier_bit(unsigned int key)
 {
     switch (key) {
-    case Q_KEY_CODE_CTRL:
+    case KEY_LEFTCTRL:
         return MOD_CTRL_L;
-    case Q_KEY_CODE_CTRL_R:
+    case KEY_RIGHTCTRL:
         return MOD_CTRL_R;
-    case Q_KEY_CODE_SHIFT:
+    case KEY_LEFTSHIFT:
         return MOD_SHIFT_L;
-    case Q_KEY_CODE_SHIFT_R:
+    case KEY_RIGHTSHIFT:
         return MOD_SHIFT_R;
-    case Q_KEY_CODE_ALT:
+    case KEY_LEFTALT:
         return MOD_ALT_L;
-    case Q_KEY_CODE_ALT_R:
+    case KEY_RIGHTALT:
         return MOD_ALT_R;
     default:
         return 0;
@@ -313,7 +314,6 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                                QemuInputEvent *evt)
 {
     PS2KbdState *s = (PS2KbdState *)dev;
-    int qcode;
     uint16_t keycode = 0;
     int mod;
 
@@ -324,10 +324,9 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
-    qcode = qemu_input_linux_to_qcode(evt->key.key);
 
-    mod = ps2_modifier_bit(qcode);
-    trace_ps2_keyboard_event(s, qcode, evt->key.down, mod,
+    mod = ps2_modifier_bit(evt->key.key);
+    trace_ps2_keyboard_event(s, evt->key.key, evt->key.down, mod,
                              s->modifiers, s->scancode_set, s->translate);
     if (evt->key.down) {
         s->modifiers |= mod;
@@ -336,7 +335,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     }
 
     if (s->scancode_set == 1) {
-        if (qcode == Q_KEY_CODE_PAUSE) {
+        if (evt->key.key == KEY_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
                 if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
@@ -354,7 +353,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0xc5);
                 }
             }
-        } else if (qcode == Q_KEY_CODE_PRINT) {
+        } else if (evt->key.key == KEY_SYSRQ) {
             if (s->modifiers & MOD_ALT_L) {
                 if (evt->key.down) {
                     ps2_put_keycode(s, 0xb8);
@@ -401,12 +400,12 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0xaa);
                 }
             }
-        } else if ((qcode == Q_KEY_CODE_LANG1 || qcode == Q_KEY_CODE_LANG2)
+        } else if ((evt->key.key == KEY_HANGEUL || evt->key.key == KEY_HANJA)
                    && !evt->key.down) {
             /* Ignore release for these keys */
         } else {
-            if (qcode < qemu_input_map_qcode_to_atset1_len) {
-                keycode = qemu_input_map_qcode_to_atset1[qcode];
+            if (evt->key.key < qemu_input_map_linux_to_atset1_len) {
+                keycode = qemu_input_map_linux_to_atset1[evt->key.key];
             }
             if (keycode) {
                 if (keycode & 0xff00) {
@@ -418,11 +417,11 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 ps2_put_keycode(s, keycode & 0xff);
             } else {
                 qemu_log_mask(LOG_UNIMP,
-                              "ps2: ignoring key with qcode %d\n", qcode);
+                              "ps2: ignoring key %u\n", evt->key.key);
             }
         }
     } else if (s->scancode_set == 2) {
-        if (qcode == Q_KEY_CODE_PAUSE) {
+        if (evt->key.key == KEY_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
                 if (evt->key.down) {
                     ps2_put_keycode(s, 0xe0);
@@ -443,7 +442,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x77);
                 }
             }
-        } else if (qcode == Q_KEY_CODE_PRINT) {
+        } else if (evt->key.key == KEY_SYSRQ) {
             if (s->modifiers & MOD_ALT_L) {
                 if (evt->key.down) {
                     ps2_put_keycode(s, 0xf0);
@@ -499,12 +498,12 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                     ps2_put_keycode(s, 0x12);
                 }
             }
-        } else if ((qcode == Q_KEY_CODE_LANG1 || qcode == Q_KEY_CODE_LANG2) &&
+        } else if ((evt->key.key == KEY_HANGEUL || evt->key.key == KEY_HANJA) &&
                    !evt->key.down) {
             /* Ignore release for these keys */
         } else {
-            if (qcode < qemu_input_map_qcode_to_atset2_len) {
-                keycode = qemu_input_map_qcode_to_atset2[qcode];
+            if (evt->key.key < qemu_input_map_linux_to_atset2_len) {
+                keycode = qemu_input_map_linux_to_atset2[evt->key.key];
             }
             if (keycode) {
                 if (keycode & 0xff00) {
@@ -516,12 +515,12 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
                 ps2_put_keycode(s, keycode & 0xff);
             } else {
                 qemu_log_mask(LOG_UNIMP,
-                              "ps2: ignoring key with qcode %d\n", qcode);
+                              "ps2: ignoring key %u\n", evt->key.key);
             }
         }
     } else if (s->scancode_set == 3) {
-        if (qcode < qemu_input_map_qcode_to_atset3_len) {
-            keycode = qemu_input_map_qcode_to_atset3[qcode];
+        if (evt->key.key < qemu_input_map_linux_to_atset3_len) {
+            keycode = qemu_input_map_linux_to_atset3[evt->key.key];
         }
         if (keycode) {
             /* FIXME: break code should be configured on a key by key basis */
@@ -531,7 +530,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
             ps2_put_keycode(s, keycode);
         } else {
             qemu_log_mask(LOG_UNIMP,
-                          "ps2: ignoring key with qcode %d\n", qcode);
+                          "ps2: ignoring key %u\n", evt->key.key);
         }
     }
 }
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 1484625565b5..43900914be28 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -30,7 +30,7 @@ pckbd_kbd_write_data(uint64_t val) "0x%02"PRIx64
 
 # ps2.c
 ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
-ps2_keyboard_event(void *opaque, int qcode, int down, unsigned int modifier, unsigned int modifiers, int set, int xlate) "%p qcode %d down %d modifier 0x%x modifiers 0x%x set %d xlate %d"
+ps2_keyboard_event(void *opaque, unsigned int lnx, int down, unsigned int modifier, unsigned int modifiers, int set, int xlate) "%p lnx %u down %d modifier 0x%x modifiers 0x%x set %d xlate %d"
 ps2_read_data(void *opaque) "%p"
 ps2_set_ledstate(void *s, int ledstate) "%p ledstate %d"
 ps2_reset_keyboard(void *s) "%p"

-- 
2.54.0


