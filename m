Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C1D5E158
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MT1-0004Op-GO; Fri, 08 Nov 2024 05:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSy-0004GH-23
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSw-0006AC-7M
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJOS9Ag53Kv/GbDr7S6/91HkLwymBcQX1jpDo1XmfPQ=;
 b=RNq8Bgz/Cjghq87yApNbvhMsTAbg+Ot6CKxUYrgysfDtRAgY8vILrXZ63E7uxdRbWy5NDf
 u3TF2UcbmTZstntBLLMz/PZfjDq+MnkvapdoFvSVKEtpZjaeSSTPyOOgvqAz5UKY+zoTBV
 Ew6ocube3Zle7ssn/ELMQEMO9fSZsmA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382--9fu7frRP1SMi8sFx9MnxA-1; Fri,
 08 Nov 2024 05:43:44 -0500
X-MC-Unique: -9fu7frRP1SMi8sFx9MnxA-1
X-Mimecast-MFC-AGG-ID: -9fu7frRP1SMi8sFx9MnxA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98D51955DC1; Fri,  8 Nov 2024 10:43:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 918451953880; Fri,  8 Nov 2024 10:43:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/10] next-kbd: convert to use qemu_input_handler_register()
Date: Fri,  8 Nov 2024 11:43:09 +0100
Message-ID: <20241108104312.534448-10-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
function to use qemu_input_handler_register().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
[thuth: Removed the NEXTKBD_NO_KEY definition - replaced by 0 now]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/next-kbd.c | 158 +++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 55 deletions(-)

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index bc67810f31..dacc26413f 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -68,7 +68,6 @@ struct NextKBDState {
     uint16_t shift;
 };
 
-static void queue_code(void *opaque, int code);
 
 /* lots of magic numbers here */
 static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
@@ -166,68 +165,70 @@ static const MemoryRegionOps kbd_ops = {
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
+static const int qcode_to_nextkbd_keycode[] = {
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
@@ -241,6 +242,53 @@ static void queue_code(void *opaque, int code)
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
+    /* Shift key currently has no keycode, so handle separately */
+    if (qcode == Q_KEY_CODE_SHIFT) {
+        if (key_down) {
+            s->shift |= KD_LSHIFT;
+        } else {
+            s->shift &= ~KD_LSHIFT;
+        }
+    }
+
+    if (qcode == Q_KEY_CODE_SHIFT_R) {
+        if (key_down) {
+            s->shift |= KD_RSHIFT;
+        } else {
+            s->shift &= ~KD_RSHIFT;
+        }
+    }
+
+    keycode = qcode_to_nextkbd_keycode[qcode];
+    if (!keycode) {
+        return;
+    }
+
+    /* If key release event, create keyboard break code */
+    if (!key_down) {
+        keycode |= 0x80;
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
2.47.0


