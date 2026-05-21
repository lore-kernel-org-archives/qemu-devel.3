Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073A0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3ua-0003x1-HO; Thu, 21 May 2026 09:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3uX-0003b3-3B
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3uU-0001Zh-RX
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQ54XMaiAgfFL8G0tzhmo5Nowz0ljDTt98jhBbihl7Q=;
 b=Ib27vMTOGmsJI0PvtkjpUtoWf2hagrfcxrHZj9vHmr19Wg9h3cEUcqIxC96CXAF+KPfe5+
 R3jbPMVRmvnVDPr86aoNg2M/BatcTF+sUj910lNNtjHh4kCUDX8W5Q9gQ3M+CdA3RPO7f/
 /7ZN45rtQ8Und8fYZc2YhmLDH/tqjD4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-70XnbHzlOUCfUiEvheR2SQ-1; Thu,
 21 May 2026 09:57:58 -0400
X-MC-Unique: 70XnbHzlOUCfUiEvheR2SQ-1
X-Mimecast-MFC-AGG-ID: 70XnbHzlOUCfUiEvheR2SQ_1779371877
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB6819560A2; Thu, 21 May 2026 13:57:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 967FD1800352; Thu, 21 May 2026 13:57:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL v2 21/38] hw/input/ps2: Use Linux key codes
Date: Thu, 21 May 2026 17:55:32 +0400
Message-ID: <20260521135551.1752945-22-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
Message-ID: <20260520-input-v3-13-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/input/ps2.c        | 51 +++++++++++++++++++++----------------------
 hw/input/trace-events |  2 +-
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 93c3c737205..f2523ff4bc7 100644
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
index 1484625565b..43900914be2 100644
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


