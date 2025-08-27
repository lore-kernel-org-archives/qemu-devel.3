Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1ADCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urIZz-0007RR-Hr; Wed, 27 Aug 2025 12:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1urHx9-00010G-Sz
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:20:48 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1urHx6-00007x-Ln
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 11:20:47 -0400
DKIM-Signature: a=rsa-sha256; bh=lwgO4wuYTDZYlQLKz6nExelABgFzOlv+JADLQtsVvjw=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1756308040; v=1;
 b=V/jyymE2/vgT7r03pmFMYTClY6bumU1zzppFD5En8lbTlCDkYYcLTNoxE3r8AVyic5G99cTX
 edGfhI/YFILdbBLhamrZYPVq13YcjOKMMiXjDo8uNY2gfkq/Qx/pxIEagIgaDmSIKELDPxZhwPu
 v/5P9K1Umm3E6MDS8fwhIGSJ/BAoqTfNAK11sxTwzvRFTa0YNCpu/50geKlfJapsFDv0ZX0Bux1
 X4RyuaRnT8JGjs0JMAju0Xz0ap2buNbkFwo8uL78ssABu5wM+Zu69FpDka2wKBonDWRPJ0x+yTn
 hCOIXaojiiG1t3F0BZaX4Dc0LJ+N9J8KKKRX8k9psxSgw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 301B821FEF;
 Wed, 27 Aug 2025 15:20:40 +0000 (UTC)
From: ~miller2018 <miller2018@git.sr.ht>
Date: Wed, 27 Aug 2025 07:04:19 -0400
Subject: [PATCH V1] hw/input/ps2: Enqueue keycodes atomically for PS/2 keyboard
Message-ID: <175630804016.9599.15141616547711036567-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yu Hao <miller.yuhao@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 20
X-Spam_score: 2.0
X-Spam_bar: ++
X-Spam_report: (2.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Aug 2025 12:00:44 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~miller2018 <miller.yuhao@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yu Hao <miller.yuhao@gmail.com>

The current PS/2 keyboard's keycode enqueue mechanism is not atomic
for multi-byte keycodes. If the queue's free space is insufficient,
individual bytes of a single keycode might be dropped. This can
cause the guest OS to receive only a partial sequence, potentially
interpreting it as a valid but incorrect key event.

For example, the keycode for the Up Arrow is 0xE0, 0x48(a two-byte
sequence). If the first byte (0xE0) is dropped, the guest would
receive only 0x48. This byte could be misinterpreted as a different
key press (e.g., the 'H' key or a numeric '8'), leading to unintended
input behavior in the VM.

Signed-off-by: Yu Hao <miller.yuhao@gmail.com>
---
 hw/input/ps2.c | 266 +++++++++++++++++++++++++++++--------------------
 1 file changed, 160 insertions(+), 106 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 7f7b1fce2e..b9b9e8dc09 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -287,26 +287,54 @@ static void ps2_cqueue_reset(PS2State *s)
 }
=20
 /* keycode is the untranslated scancode in the current scancode set. */
-static void ps2_put_keycode(void *opaque, int keycode)
+static void ps2_put_keycodes_atomic(void *opaque, int cnt, int keycode[])
 {
     PS2KbdState *s =3D opaque;
     PS2State *ps =3D PS2_DEVICE(s);
+    int i =3D 0;
+    int idx =3D 0;
+    int atomic_key[PS2_QUEUE_SIZE] =3D {0};
+
+    if (cnt > PS2_QUEUE_SIZE) {
+        return;
+    }
+
+    for (i =3D 0; i < cnt; i++) {
+        trace_ps2_put_keycode(opaque, keycode[i]);
+    }
=20
-    trace_ps2_put_keycode(opaque, keycode);
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
=20
-    if (s->translate) {
-        if (keycode =3D=3D 0xf0) {
-            s->need_high_bit =3D true;
-        } else if (s->need_high_bit) {
-            ps2_queue(ps, translate_table[keycode] | 0x80);
-            s->need_high_bit =3D false;
+    for (i =3D 0; i < cnt; i++) {
+        if (s->translate) {
+            if (keycode[i] =3D=3D 0xf0) {
+                s->need_high_bit =3D true;
+            } else if (s->need_high_bit) {
+                s->need_high_bit =3D false;
+                atomic_key[idx++] =3D translate_table[keycode[i]] | 0x80;
+            } else {
+                atomic_key[idx++] =3D translate_table[keycode[i]];
+            }
         } else {
-            ps2_queue(ps, translate_table[keycode]);
+            atomic_key[idx++] =3D keycode[i];
         }
-    } else {
-        ps2_queue(ps, keycode);
     }
+
+    if (idx =3D=3D 0) {
+        return;
+    }
+
+    if (PS2_QUEUE_SIZE - ps->queue.count < idx) {
+        qemu_log_mask(LOG_UNIMP,
+                 "ps2: drop key due to insufficient queue space (%d < %d)\n",
+                  PS2_QUEUE_SIZE - ps->queue.count, idx);
+        return;
+    }
+
+    for (i =3D 0; i < idx; i++) {
+        ps2_queue_noirq(ps, atomic_key[i]);
+    }
+    ps2_raise_irq(ps);
 }
=20
 static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
@@ -317,6 +345,8 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCons=
ole *src,
     int qcode;
     uint16_t keycode =3D 0;
     int mod;
+    int atomic_key[PS2_QUEUE_SIZE] =3D {0};
+    int idx =3D 0;
=20
     /* do not process events while disabled to prevent stream corruption */
     if (!s->scan_enabled) {
@@ -340,66 +370,76 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,
         if (qcode =3D=3D Q_KEY_CODE_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x46);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xc6);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x46;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xc6;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe1);
-                    ps2_put_keycode(s, 0x1d);
-                    ps2_put_keycode(s, 0x45);
-                    ps2_put_keycode(s, 0xe1);
-                    ps2_put_keycode(s, 0x9d);
-                    ps2_put_keycode(s, 0xc5);
+                    atomic_key[idx++] =3D 0xe1;
+                    atomic_key[idx++] =3D 0x1d;
+                    atomic_key[idx++] =3D 0x45;
+                    atomic_key[idx++] =3D 0xe1;
+                    atomic_key[idx++] =3D 0x9d;
+                    atomic_key[idx++] =3D 0xc5;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             }
         } else if (qcode =3D=3D Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xb8);
-                    ps2_put_keycode(s, 0x38);
-                    ps2_put_keycode(s, 0x54);
+                    atomic_key[idx++] =3D 0xb8;
+                    atomic_key[idx++] =3D 0x38;
+                    atomic_key[idx++] =3D 0x54;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xd4);
-                    ps2_put_keycode(s, 0xb8);
-                    ps2_put_keycode(s, 0x38);
+                    atomic_key[idx++] =3D 0xd4;
+                    atomic_key[idx++] =3D 0xb8;
+                    atomic_key[idx++] =3D 0x38;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else if (s->modifiers & MOD_ALT_R) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xb8);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x38);
-                    ps2_put_keycode(s, 0x54);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xb8;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x38;
+                    atomic_key[idx++] =3D 0x54;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xd4);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xb8);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x38);
+                    atomic_key[idx++] =3D 0xd4;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xb8;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x38;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
                                        MOD_SHIFT_R | MOD_CTRL_R)) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x37);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x37;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xb7);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xb7;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x2a);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x37);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x2a;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x37;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xb7);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xaa);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xb7;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xaa;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             }
         } else if ((qcode =3D=3D Q_KEY_CODE_LANG1 || qcode =3D=3D Q_KEY_CODE=
_LANG2)
@@ -411,12 +451,14 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,
             }
             if (keycode) {
                 if (keycode & 0xff00) {
-                    ps2_put_keycode(s, keycode >> 8);
+                    atomic_key[idx++] =3D keycode >> 8;
                 }
+
                 if (!key->down) {
                     keycode |=3D 0x80;
                 }
-                ps2_put_keycode(s, keycode & 0xff);
+                atomic_key[idx++] =3D keycode & 0xff;
+                ps2_put_keycodes_atomic(s, idx, atomic_key);
             } else {
                 qemu_log_mask(LOG_UNIMP,
                               "ps2: ignoring key with qcode %d\n", qcode);
@@ -426,78 +468,88 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,
         if (qcode =3D=3D Q_KEY_CODE_PAUSE) {
             if (s->modifiers & (MOD_CTRL_L | MOD_CTRL_R)) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x7e);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x7e);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x7e;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x7e;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe1);
-                    ps2_put_keycode(s, 0x14);
-                    ps2_put_keycode(s, 0x77);
-                    ps2_put_keycode(s, 0xe1);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x14);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x77);
+                    atomic_key[idx++] =3D 0xe1;
+                    atomic_key[idx++] =3D 0x14;
+                    atomic_key[idx++] =3D 0x77;
+                    atomic_key[idx++] =3D 0xe1;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x14;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x77;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             }
         } else if (qcode =3D=3D Q_KEY_CODE_PRINT) {
             if (s->modifiers & MOD_ALT_L) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0x84);
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0x84;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x84);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0x11);
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x84;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0x11;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else if (s->modifiers & MOD_ALT_R) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0x84);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0x84;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x84);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x11);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x11);
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x84;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x11;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x11;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else if (s->modifiers & (MOD_SHIFT_L | MOD_CTRL_L |
                                        MOD_SHIFT_R | MOD_CTRL_R)) {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x7c);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x7c;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x7c);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x7c;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             } else {
                 if (key->down) {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x12);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0x7c);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x12;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0x7c;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 } else {
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x7c);
-                    ps2_put_keycode(s, 0xe0);
-                    ps2_put_keycode(s, 0xf0);
-                    ps2_put_keycode(s, 0x12);
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x7c;
+                    atomic_key[idx++] =3D 0xe0;
+                    atomic_key[idx++] =3D 0xf0;
+                    atomic_key[idx++] =3D 0x12;
+                    ps2_put_keycodes_atomic(s, idx, atomic_key);
                 }
             }
         } else if ((qcode =3D=3D Q_KEY_CODE_LANG1 || qcode =3D=3D Q_KEY_CODE=
_LANG2) &&
@@ -509,12 +561,13 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,
             }
             if (keycode) {
                 if (keycode & 0xff00) {
-                    ps2_put_keycode(s, keycode >> 8);
+                    atomic_key[idx++] =3D keycode >> 8;
                 }
                 if (!key->down) {
-                    ps2_put_keycode(s, 0xf0);
+                    atomic_key[idx++] =3D 0xf0;
                 }
-                ps2_put_keycode(s, keycode & 0xff);
+                atomic_key[idx++] =3D keycode & 0xff;
+                ps2_put_keycodes_atomic(s, idx, atomic_key);
             } else {
                 qemu_log_mask(LOG_UNIMP,
                               "ps2: ignoring key with qcode %d\n", qcode);
@@ -527,9 +580,10 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCon=
sole *src,
         if (keycode) {
             /* FIXME: break code should be configured on a key by key basis =
*/
             if (!key->down) {
-                ps2_put_keycode(s, 0xf0);
+                atomic_key[idx++] =3D 0xf0;
             }
-            ps2_put_keycode(s, keycode);
+            atomic_key[idx++] =3D keycode;
+            ps2_put_keycodes_atomic(s, idx, atomic_key);
         } else {
             qemu_log_mask(LOG_UNIMP,
                           "ps2: ignoring key with qcode %d\n", qcode);
--=20
2.49.1

