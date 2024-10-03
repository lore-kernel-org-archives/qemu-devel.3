Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD3CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMNx-00049x-30; Thu, 03 Oct 2024 10:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNQ-00046y-Jy
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNL-0002qk-1i
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so9845375e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727964013; x=1728568813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ok18kr1nMkw/0rVgIWp/xbgbnOWA7nawrP/P6cDv6w=;
 b=vH6qJZMeRpJFQuMCeeRbLN8k6DyA/WzBHZ4ffLRirgJrD8cnEfT9wLUklfaQFOXohA
 n5rvrJ6+oKX+VEF/x7J17Q+Qe58X9lFmo3j6V9bFfYa+czvJFm+qTDC/QxfnL8cwpoRF
 wmBR57pc47okkcCGXImzQNBHxhZSZROeLYx3c5FJ1F/XcBMUm6Yvk+W79WgbohwkMEMk
 vsfAnZg3fCHTKmMcpEAe7MP4FBDS5ads/fQDOoTRHwWfM7N/VN6QtnKzHkZ9vS5WRd8E
 zbOREtCZMPVBHF1X237dFgJlSx/077xRcGhw1wsLmFvRUKq1W3EAiirLjyLfQzXTIl/R
 z9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727964013; x=1728568813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ok18kr1nMkw/0rVgIWp/xbgbnOWA7nawrP/P6cDv6w=;
 b=iSzz6pLOXMLqYd663NRjYLPLy/VpA/VlY6SVkC78V0E0PhkMT58lNN2H3yVqXIqyfA
 brp9J9xANgIC45xi7YqOfEMLfbRHzA/BrRtzr28vLOgMoPg9QW4kWIZguVrLgzjaIP0F
 DmIPyaVAw42Qm3BUoI7LNIVgWAS33Zt3AhpR57rZRcU523fADkC6LAFxmnBUAmmHlQ9T
 EjT4ygw47xRMC6wN8M0cjjulXpIWRUKB46v362howEJy/gCL/Cj/VM5f3F7wl5szuFFN
 sfRqlD/Pz/hYzzxA4Jart3zNcGwfSuqIsPd7fvOXri65erMEyf9Pc+1wh1uSwzXi9Mys
 bQlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVn+Z8S6JJvhd7jjuHCOT404xWgOK/BIA8amDKCAVwxLvgqpGlI8Lmb+kLYgDF1drC4qz0vBh4kJxM@nongnu.org
X-Gm-Message-State: AOJu0YzWQJIOOAQc8VzmPJ/6KP+JEVRGFaox7RS3/7cwGKUZpqo5n5Sp
 nHz4MN/9sFJgCD270yLojv/ym+QRnp/UkCx9VFo0UXN9j0VOS1DIyTlXPyQ3Z/Q0duRsYv/spLD
 M
X-Google-Smtp-Source: AGHT+IHpske8n3hvEQn1cGEXNY1S9AanOLZy5w+O54y6Hf7mAdWJ+CUSVeYVkl+fE38CInhQwmpq3Q==
X-Received: by 2002:adf:e643:0:b0:374:c847:852 with SMTP id
 ffacd0b85a97d-37cfb9d024cmr4686638f8f.29.1727964012887; 
 Thu, 03 Oct 2024 07:00:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0822bc38sm1340255f8f.45.2024.10.03.07.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:00:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/6] hw/adc: Remove MAX111X device
Date: Thu,  3 Oct 2024 15:00:05 +0100
Message-Id: <20241003140010.1653808-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003140010.1653808-1-peter.maydell@linaro.org>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The MAX111X ADC device was used only by the XScale-based
Zaurus machine types. Now they have all been removed, we can
drop this device model too.

Because this device is an SSI device, in theory it could be created
by users on the command line for boards with a different SSI
controller, but we don't believe users are doing this -- it would be
impossible on the command line to connect up the GPIO inputs which
correspond to ADC inputs, or the GPIO output which is an interrupt
line.  The only example a web search produces for "device max1111" or
"device max1110" is our own bug report
  https://gitlab.com/qemu-project/qemu/-/issues/2228
where it's used as an example of a bogus command that causes an
assertion in an aspeed machine type that wasn't expecting anything
other than flash devices on its SMC bus.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/adc/max111x.h |  56 ----------
 hw/adc/max111x.c         | 236 ---------------------------------------
 hw/adc/Kconfig           |   3 -
 hw/adc/meson.build       |   1 -
 4 files changed, 296 deletions(-)
 delete mode 100644 include/hw/adc/max111x.h
 delete mode 100644 hw/adc/max111x.c

diff --git a/include/hw/adc/max111x.h b/include/hw/adc/max111x.h
deleted file mode 100644
index beff59c815d..00000000000
--- a/include/hw/adc/max111x.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Maxim MAX1110/1111 ADC chip emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#ifndef HW_MISC_MAX111X_H
-#define HW_MISC_MAX111X_H
-
-#include "hw/ssi/ssi.h"
-#include "qom/object.h"
-
-/*
- * This is a model of the Maxim MAX1110/1111 ADC chip, which for QEMU
- * is an SSI slave device. It has either 4 (max1110) or 8 (max1111)
- * 8-bit ADC channels.
- *
- * QEMU interface:
- *  + GPIO inputs 0..3 (for max1110) or 0..7 (for max1111): set the value
- *    of each ADC input, as an unsigned 8-bit value
- *  + GPIO output 0: interrupt line
- *  + Properties "input0" to "input3" (max1110) or "input0" to "input7"
- *    (max1111): initial reset values for ADC inputs.
- *
- * Known bugs:
- *  + the interrupt line is not correctly implemented, and will never
- *    be lowered once it has been asserted.
- */
-struct MAX111xState {
-    SSIPeripheral parent_obj;
-
-    qemu_irq interrupt;
-    /* Values of inputs at system reset (settable by QOM property) */
-    uint8_t reset_input[8];
-
-    uint8_t tb1, rb2, rb3;
-    int cycle;
-
-    uint8_t input[8];
-    int inputs, com;
-};
-
-#define TYPE_MAX_111X "max111x"
-
-OBJECT_DECLARE_SIMPLE_TYPE(MAX111xState, MAX_111X)
-
-#define TYPE_MAX_1110 "max1110"
-#define TYPE_MAX_1111 "max1111"
-
-#endif
diff --git a/hw/adc/max111x.c b/hw/adc/max111x.c
deleted file mode 100644
index aa51e47245d..00000000000
--- a/hw/adc/max111x.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * Maxim MAX1110/1111 ADC chip emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "hw/adc/max111x.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "hw/qdev-properties.h"
-
-/* Control-byte bitfields */
-#define CB_PD0		(1 << 0)
-#define CB_PD1		(1 << 1)
-#define CB_SGL		(1 << 2)
-#define CB_UNI		(1 << 3)
-#define CB_SEL0		(1 << 4)
-#define CB_SEL1		(1 << 5)
-#define CB_SEL2		(1 << 6)
-#define CB_START	(1 << 7)
-
-#define CHANNEL_NUM(v, b0, b1, b2)	\
-                        ((((v) >> (2 + (b0))) & 4) |	\
-                         (((v) >> (3 + (b1))) & 2) |	\
-                         (((v) >> (4 + (b2))) & 1))
-
-static uint32_t max111x_read(MAX111xState *s)
-{
-    if (!s->tb1)
-        return 0;
-
-    switch (s->cycle ++) {
-    case 1:
-        return s->rb2;
-    case 2:
-        return s->rb3;
-    }
-
-    return 0;
-}
-
-/* Interpret a control-byte */
-static void max111x_write(MAX111xState *s, uint32_t value)
-{
-    int measure, chan;
-
-    /* Ignore the value if START bit is zero */
-    if (!(value & CB_START))
-        return;
-
-    s->cycle = 0;
-
-    if (!(value & CB_PD1)) {
-        s->tb1 = 0;
-        return;
-    }
-
-    s->tb1 = value;
-
-    if (s->inputs == 8)
-        chan = CHANNEL_NUM(value, 1, 0, 2);
-    else
-        chan = CHANNEL_NUM(value & ~CB_SEL0, 0, 1, 2);
-
-    if (value & CB_SGL)
-        measure = s->input[chan] - s->com;
-    else
-        measure = s->input[chan] - s->input[chan ^ 1];
-
-    if (!(value & CB_UNI))
-        measure ^= 0x80;
-
-    s->rb2 = (measure >> 2) & 0x3f;
-    s->rb3 = (measure << 6) & 0xc0;
-
-    /* FIXME: When should the IRQ be lowered?  */
-    qemu_irq_raise(s->interrupt);
-}
-
-static uint32_t max111x_transfer(SSIPeripheral *dev, uint32_t value)
-{
-    MAX111xState *s = MAX_111X(dev);
-    max111x_write(s, value);
-    return max111x_read(s);
-}
-
-static const VMStateDescription vmstate_max111x = {
-    .name = "max111x",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_SSI_PERIPHERAL(parent_obj, MAX111xState),
-        VMSTATE_UINT8(tb1, MAX111xState),
-        VMSTATE_UINT8(rb2, MAX111xState),
-        VMSTATE_UINT8(rb3, MAX111xState),
-        VMSTATE_INT32_EQUAL(inputs, MAX111xState, NULL),
-        VMSTATE_INT32(com, MAX111xState),
-        VMSTATE_ARRAY_INT32_UNSAFE(input, MAX111xState, inputs,
-                                   vmstate_info_uint8, uint8_t),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void max111x_input_set(void *opaque, int line, int value)
-{
-    MAX111xState *s = MAX_111X(opaque);
-
-    assert(line >= 0 && line < s->inputs);
-    s->input[line] = value;
-}
-
-static int max111x_init(SSIPeripheral *d, int inputs)
-{
-    DeviceState *dev = DEVICE(d);
-    MAX111xState *s = MAX_111X(dev);
-
-    qdev_init_gpio_out(dev, &s->interrupt, 1);
-    qdev_init_gpio_in(dev, max111x_input_set, inputs);
-
-    s->inputs = inputs;
-
-    return 0;
-}
-
-static void max1110_realize(SSIPeripheral *dev, Error **errp)
-{
-    max111x_init(dev, 8);
-}
-
-static void max1111_realize(SSIPeripheral *dev, Error **errp)
-{
-    max111x_init(dev, 4);
-}
-
-static void max111x_reset(DeviceState *dev)
-{
-    MAX111xState *s = MAX_111X(dev);
-    int i;
-
-    for (i = 0; i < s->inputs; i++) {
-        s->input[i] = s->reset_input[i];
-    }
-    s->com = 0;
-    s->tb1 = 0;
-    s->rb2 = 0;
-    s->rb3 = 0;
-    s->cycle = 0;
-}
-
-static Property max1110_properties[] = {
-    /* Reset values for ADC inputs */
-    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
-    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
-    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
-    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static Property max1111_properties[] = {
-    /* Reset values for ADC inputs */
-    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
-    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
-    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
-    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
-    DEFINE_PROP_UINT8("input4", MAX111xState, reset_input[4], 0xb0),
-    DEFINE_PROP_UINT8("input5", MAX111xState, reset_input[5], 0xa0),
-    DEFINE_PROP_UINT8("input6", MAX111xState, reset_input[6], 0x90),
-    DEFINE_PROP_UINT8("input7", MAX111xState, reset_input[7], 0x80),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void max111x_class_init(ObjectClass *klass, void *data)
-{
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    k->transfer = max111x_transfer;
-    device_class_set_legacy_reset(dc, max111x_reset);
-    dc->vmsd = &vmstate_max111x;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-}
-
-static const TypeInfo max111x_info = {
-    .name          = TYPE_MAX_111X,
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(MAX111xState),
-    .class_init    = max111x_class_init,
-    .abstract      = true,
-};
-
-static void max1110_class_init(ObjectClass *klass, void *data)
-{
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    k->realize = max1110_realize;
-    device_class_set_props(dc, max1110_properties);
-}
-
-static const TypeInfo max1110_info = {
-    .name          = TYPE_MAX_1110,
-    .parent        = TYPE_MAX_111X,
-    .class_init    = max1110_class_init,
-};
-
-static void max1111_class_init(ObjectClass *klass, void *data)
-{
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    k->realize = max1111_realize;
-    device_class_set_props(dc, max1111_properties);
-}
-
-static const TypeInfo max1111_info = {
-    .name          = TYPE_MAX_1111,
-    .parent        = TYPE_MAX_111X,
-    .class_init    = max1111_class_init,
-};
-
-static void max111x_register_types(void)
-{
-    type_register_static(&max111x_info);
-    type_register_static(&max1110_info);
-    type_register_static(&max1111_info);
-}
-
-type_init(max111x_register_types)
diff --git a/hw/adc/Kconfig b/hw/adc/Kconfig
index a825bd3d343..25d2229fb83 100644
--- a/hw/adc/Kconfig
+++ b/hw/adc/Kconfig
@@ -1,5 +1,2 @@
 config STM32F2XX_ADC
     bool
-
-config MAX111X
-    bool
diff --git a/hw/adc/meson.build b/hw/adc/meson.build
index a4f85b7d468..7f7acc16196 100644
--- a/hw/adc/meson.build
+++ b/hw/adc/meson.build
@@ -2,4 +2,3 @@ system_ss.add(when: 'CONFIG_STM32F2XX_ADC', if_true: files('stm32f2xx_adc.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_adc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_adc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq-xadc.c'))
-system_ss.add(when: 'CONFIG_MAX111X', if_true: files('max111x.c'))
-- 
2.34.1


