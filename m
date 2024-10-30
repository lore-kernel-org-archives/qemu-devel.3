Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479FCD2AB2C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 09:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64qK-0004t9-9Q; Wed, 30 Oct 2024 05:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t64qH-0004su-Tj
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 05:18:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t64qG-0005KS-1W
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 05:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=n6f2/O7DlRyDlg0M6jzWm/1lLESkuEBJWRofCl1Lobk=; b=Jr5/AAOE47l3KM5q2EFPO8gbcb
 O/unU2E+JBhl+qM6yMLWNDUZfHpz/bjRfAWJkZ/PHVSB8WCSjvffih7s64QbxmVEkbMerOK8fzmM3
 e409xklccJka+U6UUtKxWcdpugXhKKXQjjMmcbxRtdTGD+ojfYHazA1PT8V8deVEEhMqNz1dQr2m9
 DCH0sjjFUczkqcpIx+Eje7px8mTSly/gW0FfizOCavIiYOgDBg4UEer+7vpZzZVr4m2RcP5OLYt2n
 NzORNiVkpADEMQouKLOitSY5ekMLcE6Iye7c7WBd0+Yrj0MvjWv8uL8XpbOdXNDAnzu0jgLEukDQG
 vYkucRx8Q4etZpQbx2rJvEHpypRAVbleM8BfiEtbw4zMIBZtrPyML+NE4DabVY37Sz4f+H6khCZmK
 c4gf7CsrLP4Z7B6LAU1vuwTbR2WCrLoGWcj0KSreuOiQoCri1IWklwCcj5r17IRrEWBzAsMN1HNcH
 pQYXJJ9QVS0R51VoIna528qOxcQQ4npcs/mewO31pv6kU6yJGHrYjyCyLgTsyJotjYrddCKk9UxQJ
 QxtGjyGS88YZWUr2slc+tULj17dhyEnjpXZH7N53iHkTqLi4s80To51VAMItuxt0wZIwW98xp1qUF
 QcH1Qq63OrbedXbK4jLWbTcSfLUaVK2MZopEQWyjY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t64pp-0008ew-7K; Wed, 30 Oct 2024 09:17:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 30 Oct 2024 09:18:03 +0000
Message-Id: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] next-kbd: convert to use qemu_input_handler_register()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
function to use qemu_input_handler_register().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-kbd.c | 158 +++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 55 deletions(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index bc67810f31..85ef784491 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -68,7 +68,6 @@ struct NextKBDState {
     uint16_t shift;
 };
 
-static void queue_code(void *opaque, int code);
 
 /* lots of magic numbers here */
 static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
@@ -166,68 +165,79 @@ static const MemoryRegionOps kbd_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void nextkbd_event(void *opaque, int ch)
-{
-    /*
-     * Will want to set vars for caps/num lock
-     * if (ch & 0x80) -> key release
-     * there's also e0 escaped scancodes that might need to be handled
-     */
-    queue_code(opaque, ch);
-}
-
-static const unsigned char next_keycodes[128] = {
-    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
-    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
-    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
-    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
-    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
-    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
-    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
-    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+#define NEXTKDB_NO_KEY 0xff
+
+static const int qcode_to_nextkbd_keycode[] = {
+    /* Make sure future additions are automatically set to NEXTKDB_NO_KEY */
+    [0 ... 0xff]               = NEXTKDB_NO_KEY,
+
+    [Q_KEY_CODE_ESC]           = 0x49,
+    [Q_KEY_CODE_1]             = 0x4a,
+    [Q_KEY_CODE_2]             = 0x4b,
+    [Q_KEY_CODE_3]             = 0x4c,
+    [Q_KEY_CODE_4]             = 0x4d,
+    [Q_KEY_CODE_5]             = 0x50,
+    [Q_KEY_CODE_6]             = 0x4f,
+    [Q_KEY_CODE_7]             = 0x4e,
+    [Q_KEY_CODE_8]             = 0x1e,
+    [Q_KEY_CODE_9]             = 0x1f,
+    [Q_KEY_CODE_0]             = 0x20,
+    [Q_KEY_CODE_MINUS]         = 0x1d,
+    [Q_KEY_CODE_EQUAL]         = 0x1c,
+    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
+    [Q_KEY_CODE_TAB]           = 0x00,
+
+    [Q_KEY_CODE_Q]             = 0x42,
+    [Q_KEY_CODE_W]             = 0x43,
+    [Q_KEY_CODE_E]             = 0x44,
+    [Q_KEY_CODE_R]             = 0x45,
+    [Q_KEY_CODE_T]             = 0x48,
+    [Q_KEY_CODE_Y]             = 0x47,
+    [Q_KEY_CODE_U]             = 0x46,
+    [Q_KEY_CODE_I]             = 0x06,
+    [Q_KEY_CODE_O]             = 0x07,
+    [Q_KEY_CODE_P]             = 0x08,
+    [Q_KEY_CODE_RET]           = 0x2a,
+    [Q_KEY_CODE_A]             = 0x39,
+    [Q_KEY_CODE_S]             = 0x3a,
+
+    [Q_KEY_CODE_D]             = 0x3b,
+    [Q_KEY_CODE_F]             = 0x3c,
+    [Q_KEY_CODE_G]             = 0x3d,
+    [Q_KEY_CODE_H]             = 0x40,
+    [Q_KEY_CODE_J]             = 0x3f,
+    [Q_KEY_CODE_K]             = 0x3e,
+    [Q_KEY_CODE_L]             = 0x2d,
+    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
+    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
+    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
+    [Q_KEY_CODE_SHIFT]         = 0x00,
+    [Q_KEY_CODE_BACKSLASH]     = 0x00,
+    [Q_KEY_CODE_Z]             = 0x31,
+    [Q_KEY_CODE_X]             = 0x32,
+    [Q_KEY_CODE_C]             = 0x33,
+    [Q_KEY_CODE_V]             = 0x34,
+
+    [Q_KEY_CODE_B]             = 0x35,
+    [Q_KEY_CODE_N]             = 0x37,
+    [Q_KEY_CODE_M]             = 0x36,
+    [Q_KEY_CODE_COMMA]         = 0x2e,
+    [Q_KEY_CODE_DOT]           = 0x2f,
+    [Q_KEY_CODE_SLASH]         = 0x30,
+    [Q_KEY_CODE_SHIFT_R]       = 0x00,
+
+    [Q_KEY_CODE_SPC]           = 0x38,
 };
 
-static void queue_code(void *opaque, int code)
+static void nextkbd_put_keycode(NextKBDState *s, int keycode)
 {
-    NextKBDState *s = NEXTKBD(opaque);
     KBDQueue *q = &s->queue;
-    int key = code & KD_KEYMASK;
-    int release = code & 0x80;
-    static int ext;
-
-    if (code == 0xE0) {
-        ext = 1;
-    }
-
-    if (code == 0x2A || code == 0x1D || code == 0x36) {
-        if (code == 0x2A) {
-            s->shift = KD_LSHIFT;
-        } else if (code == 0x36) {
-            s->shift = KD_RSHIFT;
-            ext = 0;
-        } else if (code == 0x1D && !ext) {
-            s->shift = KD_LCOMM;
-        } else if (code == 0x1D && ext) {
-            ext = 0;
-            s->shift = KD_RCOMM;
-        }
-        return;
-    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
-               code == (0x36 | 0x80)) {
-        s->shift = 0;
-        return;
-    }
 
     if (q->count >= KBD_QUEUE_SIZE) {
         return;
     }
 
-    q->data[q->wptr] = next_keycodes[key] | release;
-
+    q->data[q->wptr] = keycode;
     if (++q->wptr == KBD_QUEUE_SIZE) {
         q->wptr = 0;
     }
@@ -241,6 +251,44 @@ static void queue_code(void *opaque, int code)
     /* s->update_irq(s->update_arg, 1); */
 }
 
+static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
+{
+    NextKBDState *s = NEXTKBD(dev);
+    int qcode, keycode;
+    bool key_down = evt->u.key.data->down;
+
+    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
+    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
+        return;
+    }
+
+    keycode = qcode_to_nextkbd_keycode[qcode];
+    if (keycode == NEXTKDB_NO_KEY) {
+        return;
+    }
+
+    if (qcode == Q_KEY_CODE_SHIFT) {
+        s->shift = key_down ? KD_LSHIFT : 0;
+    }
+
+    if (qcode == Q_KEY_CODE_SHIFT_R) {
+        s->shift = key_down ? KD_RSHIFT : 0;
+    }
+
+    /* If key release event, create keyboard break code */
+    if (!key_down) {
+        keycode = keycode | 0x80;
+    }
+
+    nextkbd_put_keycode(s, keycode);
+}
+
+static const QemuInputHandler nextkbd_handler = {
+    .name  = "QEMU NeXT Keyboard",
+    .mask  = INPUT_EVENT_MASK_KEY,
+    .event = nextkbd_event,
+};
+
 static void nextkbd_reset(DeviceState *dev)
 {
     NextKBDState *nks = NEXTKBD(dev);
@@ -256,7 +304,7 @@ static void nextkbd_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
-    qemu_add_kbd_event_handler(nextkbd_event, s);
+    qemu_input_handler_register(dev, &nextkbd_handler);
 }
 
 static const VMStateDescription nextkbd_vmstate = {
-- 
2.39.5


