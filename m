Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C5CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuL-0005KO-NV; Tue, 01 Oct 2024 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuK-0005JU-FA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuI-00060z-EN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cdb42b29dso2543343f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800765; x=1728405565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SdOtgHr/+nua97gK3ZJQ6GDFpVZXzSk+ect1AVgDpZ8=;
 b=jLTkPBiaSOzY2l9p3wBXyYYFsT5zeLxHvobdVq8HLWbie7AcmmBZrcJrc7u6T4cTZL
 l4RRL9djnnEoL0x3cXrX7exnsEQNUafFm/g/ccyOr+5p++1z+/TWwzCC2dgU7crelzo+
 xrM8Bj6NXhv/qZhmQ5DOn97C6CHUSzobfoozjj1ms6nJD+SiMfj0iRurSh/keSSbbK0i
 2D+qhecnRLqKaFLlDeuSM3FLZt2DtxZ2YrdgeL40DNrBHLmZbZBQEGJQaKyqxIcYwh26
 xVRYjqtaxb0KKeiuswzLo77x2BzkGcKK6KnGXse8+9HddjFSQ83/MKygZLEuAfTvXTdi
 N2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800765; x=1728405565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdOtgHr/+nua97gK3ZJQ6GDFpVZXzSk+ect1AVgDpZ8=;
 b=DerZCePQHjBw3LZu5TL+pSaYZ+KuazJZ1dXd87GtNkbR0uxF7HHCHEAS6zfs08vqW+
 EEEBj2/dJaIaL46A3VLodXxVyRtAagPohiG+u0zO9IVZgp4mOgm443fJa2+MPgjMjuFQ
 P96cBUqBIofX4jVEKVBcMNT75NiM/OQDUl5+wo/djrzGcZFXnJyfZIY8HQZZrzyHZzP8
 8eYq269oQxgXQLHbw70hAO7erAV3jSlbiIAqZKv/N8Jk4ZYGMXyC2qqVoJb/sgHBC5QX
 K5ixBC9+qAkl/ru8HJdfTuVfoYQzc+zAsnitnRf80LaJdHXux68AG28WernQ+TlOczcG
 4VRw==
X-Gm-Message-State: AOJu0YyL1g2jmGHWSZn1XVtCiPG59eNprPCm8bm+7xQr3MAPgHc1kwcg
 UWSAcYdfDIXsFc0JnXEIpe/sH7xd8qhgDh4v1Y8wUNhIMIU9jw1cZ54syAHV1tXF8CMJO1DVXjH
 t
X-Google-Smtp-Source: AGHT+IFgmZoWBju+UjPBhMPp/GGjuQiBDZePhuWL/Rpxttvcv15Sen5b+FtgWBBlqad9s5AP80/vEA==
X-Received: by 2002:adf:a1c2:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-37cfb8b5378mr177247f8f.4.1727800764840; 
 Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/54] hw/input: Drop ADS7846 device
Date: Tue,  1 Oct 2024 17:38:33 +0100
Message-Id: <20241001163918.1275441-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ADS7846 touchscreen controller device was used only by
the XScale-based PDA machine types. Now that they have been
removed, this device is not used in the tree and can be
deleted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240903160751.4100218-3-peter.maydell@linaro.org
---
 MAINTAINERS          |   1 -
 hw/input/ads7846.c   | 186 -------------------------------------------
 hw/input/Kconfig     |   3 -
 hw/input/meson.build |   1 -
 4 files changed, 191 deletions(-)
 delete mode 100644 hw/input/ads7846.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c03c612cfe..42e37db3b00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -939,7 +939,6 @@ F: hw/*/pxa2xx*
 F: hw/display/tc6393xb.c
 F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
-F: hw/input/ads7846.c
 F: hw/misc/mst_fpga.c
 F: hw/adc/max111x.c
 F: include/hw/adc/max111x.h
diff --git a/hw/input/ads7846.c b/hw/input/ads7846.c
deleted file mode 100644
index cde38922165..00000000000
--- a/hw/input/ads7846.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * TI ADS7846 / TSC2046 chip emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/ssi/ssi.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "ui/console.h"
-#include "qom/object.h"
-
-struct ADS7846State {
-    SSIPeripheral ssidev;
-    qemu_irq interrupt;
-
-    int input[8];
-    int pressure;
-    int noise;
-
-    int cycle;
-    int output;
-};
-
-#define TYPE_ADS7846 "ads7846"
-OBJECT_DECLARE_SIMPLE_TYPE(ADS7846State, ADS7846)
-
-/* Control-byte bitfields */
-#define CB_PD0          (1 << 0)
-#define CB_PD1          (1 << 1)
-#define CB_SER          (1 << 2)
-#define CB_MODE         (1 << 3)
-#define CB_A0           (1 << 4)
-#define CB_A1           (1 << 5)
-#define CB_A2           (1 << 6)
-#define CB_START        (1 << 7)
-
-#define X_AXIS_DMAX     3470
-#define X_AXIS_MIN      290
-#define Y_AXIS_DMAX     3450
-#define Y_AXIS_MIN      200
-
-#define ADS_VBAT        2000
-#define ADS_VAUX        2000
-#define ADS_TEMP0       2000
-#define ADS_TEMP1       3000
-#define ADS_XPOS(x, y)  (X_AXIS_MIN + ((X_AXIS_DMAX * (x)) >> 15))
-#define ADS_YPOS(x, y)  (Y_AXIS_MIN + ((Y_AXIS_DMAX * (y)) >> 15))
-#define ADS_Z1POS(x, y) 600
-#define ADS_Z2POS(x, y) (600 + 6000 / ADS_XPOS(x, y))
-
-static void ads7846_int_update(ADS7846State *s)
-{
-    if (s->interrupt)
-        qemu_set_irq(s->interrupt, s->pressure == 0);
-}
-
-static uint32_t ads7846_transfer(SSIPeripheral *dev, uint32_t value)
-{
-    ADS7846State *s = ADS7846(dev);
-
-    switch (s->cycle ++) {
-    case 0:
-        if (!(value & CB_START)) {
-            s->cycle = 0;
-            break;
-        }
-
-        s->output = s->input[(value >> 4) & 7];
-
-        /* Imitate the ADC noise, some drivers expect this.  */
-        s->noise = (s->noise + 3) & 7;
-        switch ((value >> 4) & 7) {
-        case 1: s->output += s->noise ^ 2; break;
-        case 3: s->output += s->noise ^ 0; break;
-        case 4: s->output += s->noise ^ 7; break;
-        case 5: s->output += s->noise ^ 5; break;
-        }
-
-        if (value & CB_MODE)
-            s->output >>= 4;    /* 8 bits instead of 12 */
-
-        break;
-    case 1:
-        s->cycle = 0;
-        break;
-    }
-    return s->output;
-}
-
-static void ads7846_ts_event(void *opaque,
-                int x, int y, int z, int buttons_state)
-{
-    ADS7846State *s = opaque;
-
-    if (buttons_state) {
-        x = 0x7fff - x;
-        s->input[1] = ADS_XPOS(x, y);
-        s->input[3] = ADS_Z1POS(x, y);
-        s->input[4] = ADS_Z2POS(x, y);
-        s->input[5] = ADS_YPOS(x, y);
-    }
-
-    if (s->pressure == !buttons_state) {
-        s->pressure = !!buttons_state;
-
-        ads7846_int_update(s);
-    }
-}
-
-static int ads7856_post_load(void *opaque, int version_id)
-{
-    ADS7846State *s = opaque;
-
-    s->pressure = 0;
-    ads7846_int_update(s);
-    return 0;
-}
-
-static const VMStateDescription vmstate_ads7846 = {
-    .name = "ads7846",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = ads7856_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_SSI_PERIPHERAL(ssidev, ADS7846State),
-        VMSTATE_INT32_ARRAY(input, ADS7846State, 8),
-        VMSTATE_INT32(noise, ADS7846State),
-        VMSTATE_INT32(cycle, ADS7846State),
-        VMSTATE_INT32(output, ADS7846State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void ads7846_realize(SSIPeripheral *d, Error **errp)
-{
-    DeviceState *dev = DEVICE(d);
-    ADS7846State *s = ADS7846(d);
-
-    qdev_init_gpio_out(dev, &s->interrupt, 1);
-
-    s->input[0] = ADS_TEMP0;    /* TEMP0 */
-    s->input[2] = ADS_VBAT;     /* VBAT */
-    s->input[6] = ADS_VAUX;     /* VAUX */
-    s->input[7] = ADS_TEMP1;    /* TEMP1 */
-
-    /* We want absolute coordinates */
-    qemu_add_mouse_event_handler(ads7846_ts_event, s, 1,
-                    "QEMU ADS7846-driven Touchscreen");
-
-    ads7846_int_update(s);
-
-    vmstate_register_any(NULL, &vmstate_ads7846, s);
-}
-
-static void ads7846_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-
-    k->realize = ads7846_realize;
-    k->transfer = ads7846_transfer;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-}
-
-static const TypeInfo ads7846_info = {
-    .name          = TYPE_ADS7846,
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(ADS7846State),
-    .class_init    = ads7846_class_init,
-};
-
-static void ads7846_register_types(void)
-{
-    type_register_static(&ads7846_info);
-}
-
-type_init(ads7846_register_types)
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index f86e98c8293..acfdba5c4ca 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -1,9 +1,6 @@
 config ADB
     bool
 
-config ADS7846
-    bool
-
 config LM832X
     bool
     depends on I2C
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 3cc8ab85f0c..07a28c2c01c 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(files('hid.c'))
 system_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
-system_ss.add(when: 'CONFIG_ADS7846', if_true: files('ads7846.c'))
 system_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
 system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
-- 
2.34.1


