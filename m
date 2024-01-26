Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F04C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHG-0002IP-4O; Fri, 26 Jan 2024 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0002EB-5z
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH7-0007rd-Tq
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-337d58942c9so555691f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279624; x=1706884424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FgvQRpsiH5zpwPcK6Oo54VoqD9iaIo5i9dZssiG51CE=;
 b=SBT0neLZXMm6RIAHCneBrK+3iSFKpED/GNJ6I53FKKgvcVSNmQjbmfFzdW9YfDn1ig
 vVo/UYYBJrTmcl6QOO7vmYmaXipN2mKOPWnl3Sbt8Qh3yf7JxrjL+Fe1Iv9TeRiUXOZt
 Kw00J2HTJ/BllhdTz9DfswhEKPWQnYefSD7Yy7hRXNPBq1lEZQoYatSsMULHVYVeTzjR
 C3+XhNeeOSnKjd9508SAzNLXkeCK+lHVLBeM43/aZBsdb2muIv3BfZLoJHIalpxbUGQM
 pIfeUeUQgY8vCtYNUGAV18Ia0xxvBwHtgUZpRtyzng3Zc8OvDSjOAIbJgPa9xdE7+VDt
 eE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279624; x=1706884424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgvQRpsiH5zpwPcK6Oo54VoqD9iaIo5i9dZssiG51CE=;
 b=F1muW7fU+fgXWbG1SN+yKIfJGWNbNKoYOXEnb1d/yiwvEE7Lho+U8Td1t1ecLf/5w1
 RUlCQceMciPolKUPfFQ/EZ4slm+efzgOt1UgpNlOB1DTjsxF8Hlthl3Ylk3wDGuqSPVl
 EYgthv5z1hCd0tUTT6KD3XbRP522embUKSK50roJuvtAn9oYYvlb41zPpGrwo0kF7Clc
 2BruudnlERm1O+DtV0NQRYE7RJesXTceTlR+AnJNkI9o4jOdN9/UEPsXUhayMMdQotnb
 Tq1r00eUry1YiRds5HcytnO39J223ROWZKMvHjUVg7Qhga6mv1dNW4x+TLMUuXRUJWro
 u0Ww==
X-Gm-Message-State: AOJu0YzpDu64b6yszwfC/JnRtAsyfcXrd6qzPKWdMctX5ie5AqjM0ChH
 loIFfZXbG+lJnVTwHVVvi4D8Mqf5H7FUWwKnbGer4oCYOsmsiQ9EwiHrLk2OXKiR1Zn+2PL7sP2
 5
X-Google-Smtp-Source: AGHT+IFuCtCIzduHGzT+leX+t2nOW3aINUptU1puokYYACpjBbX/lgvHiQpLqBo0DkjT9iVgWo+bwA==
X-Received: by 2002:a5d:6687:0:b0:332:eaa7:56b0 with SMTP id
 l7-20020a5d6687000000b00332eaa756b0mr1031839wru.14.1706279624343; 
 Fri, 26 Jan 2024 06:33:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
Date: Fri, 26 Jan 2024 14:33:09 +0000
Message-Id: <20240126143341.2101237-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert the musicpal key input device to use
qemu_add_kbd_event_handler().  This lets us simplify it because we no
longer need to track whether we're in the middle of a PS/2 multibyte
key sequence.

In the conversion we move the keyboard handler registration from init
to realize, because devices shouldn't disturb the state of the
simulation by doing things like registering input handlers until
they're realized, so that device objects can be introspected
safely.

The behaviour where key-repeat is permitted for the arrow-keys only
is intentional (added in commit 7c6ce4baedfcd0c), so we retain it,
and add a comment to that effect.

This is a migration compatibility break for musicpal.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20231103182750.855577-1-peter.maydell@linaro.org
---
 hw/arm/musicpal.c | 131 +++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3200c9f68ac..6987472871e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1043,20 +1043,6 @@ static const TypeInfo musicpal_gpio_info = {
 };
 
 /* Keyboard codes & masks */
-#define KEY_RELEASED            0x80
-#define KEY_CODE                0x7f
-
-#define KEYCODE_TAB             0x0f
-#define KEYCODE_ENTER           0x1c
-#define KEYCODE_F               0x21
-#define KEYCODE_M               0x32
-
-#define KEYCODE_EXTENDED        0xe0
-#define KEYCODE_UP              0x48
-#define KEYCODE_DOWN            0x50
-#define KEYCODE_LEFT            0x4b
-#define KEYCODE_RIGHT           0x4d
-
 #define MP_KEY_WHEEL_VOL       (1 << 0)
 #define MP_KEY_WHEEL_VOL_INV   (1 << 1)
 #define MP_KEY_WHEEL_NAV       (1 << 2)
@@ -1074,67 +1060,66 @@ struct musicpal_key_state {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    uint32_t kbd_extended;
     uint32_t pressed_keys;
     qemu_irq out[8];
 };
 
-static void musicpal_key_event(void *opaque, int keycode)
+static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
+                               InputEvent *evt)
 {
-    musicpal_key_state *s = opaque;
+    musicpal_key_state *s = MUSICPAL_KEY(dev);
+    InputKeyEvent *key = evt->u.key.data;
+    int qcode = qemu_input_key_value_to_qcode(key->key);
     uint32_t event = 0;
     int i;
 
-    if (keycode == KEYCODE_EXTENDED) {
-        s->kbd_extended = 1;
-        return;
+    switch (qcode) {
+    case Q_KEY_CODE_UP:
+        event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
+        break;
+
+    case Q_KEY_CODE_DOWN:
+        event = MP_KEY_WHEEL_NAV;
+        break;
+
+    case Q_KEY_CODE_LEFT:
+        event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
+        break;
+
+    case Q_KEY_CODE_RIGHT:
+        event = MP_KEY_WHEEL_VOL;
+        break;
+
+    case Q_KEY_CODE_F:
+        event = MP_KEY_BTN_FAVORITS;
+        break;
+
+    case Q_KEY_CODE_TAB:
+        event = MP_KEY_BTN_VOLUME;
+        break;
+
+    case Q_KEY_CODE_RET:
+        event = MP_KEY_BTN_NAVIGATION;
+        break;
+
+    case Q_KEY_CODE_M:
+        event = MP_KEY_BTN_MENU;
+        break;
     }
 
-    if (s->kbd_extended) {
-        switch (keycode & KEY_CODE) {
-        case KEYCODE_UP:
-            event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
-            break;
-
-        case KEYCODE_DOWN:
-            event = MP_KEY_WHEEL_NAV;
-            break;
-
-        case KEYCODE_LEFT:
-            event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
-            break;
-
-        case KEYCODE_RIGHT:
-            event = MP_KEY_WHEEL_VOL;
-            break;
-        }
-    } else {
-        switch (keycode & KEY_CODE) {
-        case KEYCODE_F:
-            event = MP_KEY_BTN_FAVORITS;
-            break;
-
-        case KEYCODE_TAB:
-            event = MP_KEY_BTN_VOLUME;
-            break;
-
-        case KEYCODE_ENTER:
-            event = MP_KEY_BTN_NAVIGATION;
-            break;
-
-        case KEYCODE_M:
-            event = MP_KEY_BTN_MENU;
-            break;
-        }
-        /* Do not repeat already pressed buttons */
-        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
+    /*
+     * We allow repeated wheel-events when the arrow keys are held down,
+     * but do not repeat already-pressed buttons for the other key inputs.
+     */
+    if (!(event & (MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_VOL))) {
+        if (key->down && (s->pressed_keys & event)) {
             event = 0;
         }
     }
 
     if (event) {
         /* Raise GPIO pin first if repeating a key */
-        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
+        if (key->down && (s->pressed_keys & event)) {
             for (i = 0; i <= 7; i++) {
                 if (event & (1 << i)) {
                     qemu_set_irq(s->out[i], 1);
@@ -1143,17 +1128,15 @@ static void musicpal_key_event(void *opaque, int keycode)
         }
         for (i = 0; i <= 7; i++) {
             if (event & (1 << i)) {
-                qemu_set_irq(s->out[i], !!(keycode & KEY_RELEASED));
+                qemu_set_irq(s->out[i], !key->down);
             }
         }
-        if (keycode & KEY_RELEASED) {
-            s->pressed_keys &= ~event;
-        } else {
+        if (key->down) {
             s->pressed_keys |= event;
+        } else {
+            s->pressed_keys &= ~event;
         }
     }
-
-    s->kbd_extended = 0;
 }
 
 static void musicpal_key_init(Object *obj)
@@ -1162,20 +1145,27 @@ static void musicpal_key_init(Object *obj)
     DeviceState *dev = DEVICE(sbd);
     musicpal_key_state *s = MUSICPAL_KEY(dev);
 
-    s->kbd_extended = 0;
     s->pressed_keys = 0;
 
     qdev_init_gpio_out(dev, s->out, ARRAY_SIZE(s->out));
+}
 
-    qemu_add_kbd_event_handler(musicpal_key_event, s);
+static const QemuInputHandler musicpal_key_handler = {
+    .name = "musicpal_key",
+    .mask = INPUT_EVENT_MASK_KEY,
+    .event = musicpal_key_event,
+};
+
+static void musicpal_key_realize(DeviceState *dev, Error **errp)
+{
+    qemu_input_handler_register(dev, &musicpal_key_handler);
 }
 
 static const VMStateDescription musicpal_key_vmsd = {
     .name = "musicpal_key",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(kbd_extended, musicpal_key_state),
         VMSTATE_UINT32(pressed_keys, musicpal_key_state),
         VMSTATE_END_OF_LIST()
     }
@@ -1186,6 +1176,7 @@ static void musicpal_key_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &musicpal_key_vmsd;
+    dc->realize = musicpal_key_realize;
 }
 
 static const TypeInfo musicpal_key_info = {
-- 
2.34.1


