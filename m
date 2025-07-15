Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B059C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6T-0002Fq-4g; Mon, 14 Jul 2025 20:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6Q-000237-MA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:58 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6O-00087B-Fh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:58 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6fa980d05a8so37163526d6.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537655; x=1753142455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWnu/oAAzVkXqcGwl/ibho3UTNb/WrEZ456/ajF/M5o=;
 b=IyBvkQHk35lh6ROESgaJB4YuIWX/RKCg2XgMfstX7P++sjacM5rxmNPu1rP69A8bWT
 fKbPEu8e8dVeaE9GYSsbWlQalf0wRx8BZrMX+cxN4yjpkcmjlxCEjdLSlu7jtoADR4Qm
 Vp6Jyer9anJPcWU0ZXIfjCznpXBn6ZLXbqQYkXP7MbdVyhEIGgxNNYTKAW8B3tAnaP19
 6/thOs+uE2h+f/RMYCWyECuMS4ymtciw2PewzqatKudCaHIG8bqhSbwQStF1VMJiyx1R
 VuYcIYKrHpXV5M36vIAIUY5RIGDmM0xouz5hYtr5pNwrmusbQlIVks+Yv/rTRAXPbntF
 6FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537655; x=1753142455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWnu/oAAzVkXqcGwl/ibho3UTNb/WrEZ456/ajF/M5o=;
 b=cbM2ZFZem7e3xGKYWOkIKiwvUX3I2rsXAfetetCIu1NBs9hl9QhmOC1UvoqvDKkufE
 KE2m3vdhdWEN7y+qEwLhoV1bbU44zouqpc4esk6iOcg8B26R0nrDux34h3KAYek6nWG8
 8V2WPGSJ8YEB6lIl5RTnBt1F47kORTC8qRpn1GAfZnHD59j1WS2vEI0SggC2hMBSbAWE
 UA+AaGraYCNmm9ckNg4A4eJRpxh8CLvjbByFIwsMdwNRCXvcv3r+BQXcWZY/tIK92P1z
 N+D2vmgNdGdxU3JyBMhZGabWZJiGc7ZHfiZIIgZ6/rmWvjr476MnmYTYeMGlduA1MqA+
 9qwA==
X-Gm-Message-State: AOJu0Yw3qXMPLNRHLfBxbbUXkOUKJ72xYDMicyaVVF9ikkdq9E3BoyvU
 w9eHrvbbCd3MZZznD6zDYo9OaGRUvrWB4bikmOC7mfj4vpmrMlKs5jGq7emt+g==
X-Gm-Gg: ASbGncvlNhXJqtaazkjzGCK5abH5USYVrDpwNa54y4GasoH/SSBVJIxWETJe9XovopS
 28QXqHZ/4+RCeIUVx4F7kNujIT4+4oY7uQHT2VlBL9aEoYsxMXOtIFvNPdB2AVltxDUPMVGtVJP
 4OX6t7rc9Fch8U9+903NTjp3o4AqHEPJNUrOSkdNByWwDM6HEtmFRPut6l+44NvVUtfYFDCXJzE
 jL2HWJAIRn6M2ZKdDoPB4vo0v46NBR59wZuprLynQZYZwys+bsVB736oWHOUd2HrmG5po72DuS6
 kZf9m/vLRSog8mv3P/dwONfw96oGPc2K4Ji9k2vEKF5GIwsacZdQ0A44SL4cfSYarGs8ngyEEkj
 Hjqy2LZ5lP8ydzZx8H82fPsMb+4G6hTqsvaq+2VX6QJ9Ojq0=
X-Google-Smtp-Source: AGHT+IFDzn5yyh73VqowkqWRdWvWsy0RPFHfyvi+jaVDCqF2YvSijNxvhEPZdZdzYk3Hlqo9qpLsnA==
X-Received: by 2002:a05:6214:2242:b0:702:bf75:f0bc with SMTP id
 6a1803df08f44-704a7047d5cmr227023226d6.37.1752537650271; 
 Mon, 14 Jul 2025 17:00:50 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:49 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 04/11] MAX78000: UART Implementation
Date: Mon, 14 Jul 2025 20:00:38 -0400
Message-Id: <20250715000045.57332-5-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit implements UART support for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                  |   1 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 include/hw/char/max78000_uart.h |  78 +++++++++
 5 files changed, 368 insertions(+)
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 include/hw/char/max78000_uart.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e3b419b468..031e0bf59e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -367,6 +367,7 @@ config MAX78000_SOC
     bool
     select ARM_V7M
     select MAX78000_ICC
+    select MAX78000_UART
 
 config RASPI
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 9d517f3e28..020c0a84bb 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config MAX78000_UART
+    bool
+
 config STM32F2XX_USART
     bool
 
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
new file mode 100644
index 0000000000..19506d52ef
--- /dev/null
+++ b/hw/char/max78000_uart.c
@@ -0,0 +1,285 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/max78000_uart.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+
+static int max78000_uart_can_receive(void *opaque)
+{
+    Max78000UartState *s = opaque;
+    if (!(s->ctrl & UART_BCLKEN)) {
+        return 0;
+    }
+    return fifo8_num_free(&s->rx_fifo);
+}
+
+static void max78000_update_irq(Max78000UartState *s)
+{
+    int interrupt_level;
+
+    interrupt_level = s->int_fl & s->int_en;
+    qemu_set_irq(s->irq, interrupt_level);
+}
+
+static void max78000_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    Max78000UartState *s = opaque;
+
+    assert(size <= fifo8_num_free(&s->rx_fifo));
+
+    fifo8_push_all(&s->rx_fifo, buf, size);
+
+    uint32_t rx_threshold = s->ctrl & 0xf;
+
+    if (fifo8_num_used(&s->rx_fifo) >= rx_threshold) {
+        s->int_fl |= UART_RX_THD;
+    }
+
+    max78000_update_irq(s);
+}
+
+static void max78000_uart_reset_hold(Object *obj, ResetType type)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+
+    s->ctrl = 0;
+    s->status = UART_TX_EM | UART_RX_EM;
+    s->int_en = 0;
+    s->int_fl = 0;
+    s->osr = 0;
+    s->txpeek = 0;
+    s->pnr = UART_RTS;
+    s->fifo = 0;
+    s->dma = 0;
+    s->wken = 0;
+    s->wkfl = 0;
+    fifo8_reset(&s->rx_fifo);
+}
+
+static uint64_t max78000_uart_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    Max78000UartState *s = opaque;
+    uint64_t retvalue = 0;
+    switch (addr) {
+    case UART_CTRL:
+        retvalue = s->ctrl;
+        break;
+    case UART_STATUS:
+        retvalue = (fifo8_num_used(&s->rx_fifo) << UART_RX_LVL) |
+                    UART_TX_EM |
+                    (fifo8_is_empty(&s->rx_fifo) ? UART_RX_EM : 0);
+        break;
+    case UART_INT_EN:
+        retvalue = s->int_en;
+        break;
+    case UART_INT_FL:
+        retvalue = s->int_fl;
+        break;
+    case UART_CLKDIV:
+        retvalue = s->clkdiv;
+        break;
+    case UART_OSR:
+        retvalue = s->osr;
+        break;
+    case UART_TXPEEK:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_peek(&s->rx_fifo);
+        }
+        break;
+    case UART_PNR:
+        retvalue = s->pnr;
+        break;
+    case UART_FIFO:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_pop(&s->rx_fifo);
+            max78000_update_irq(s);
+        }
+        break;
+    case UART_DMA:
+        /* DMA not implemented */
+        retvalue = s->dma;
+        break;
+    case UART_WKEN:
+        retvalue = s->wken;
+        break;
+    case UART_WKFL:
+        retvalue = s->wkfl;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        break;
+    }
+
+    return retvalue;
+}
+
+static void max78000_uart_write(void *opaque, hwaddr addr,
+                                  uint64_t val64, unsigned int size)
+{
+    Max78000UartState *s = opaque;
+
+    uint32_t value = val64;
+    uint8_t data;
+
+    switch (addr) {
+    case UART_CTRL:
+        if (value & UART_FLUSH_RX) {
+            fifo8_reset(&s->rx_fifo);
+        }
+        if (value & UART_BCLKEN) {
+            value = value | UART_BCLKRDY;
+        }
+        s->ctrl = value & ~(UART_FLUSH_RX | UART_FLUSH_TX);
+
+        /*
+         * Software can manage UART flow control manually by setting hfc_en
+         * in UART_CTRL. This would require emulating uart at a lower level,
+         * and is currently unimplemented.
+         */
+
+        return;
+    case UART_STATUS:
+        /* UART_STATUS is read only */
+        return;
+    case UART_INT_EN:
+        s->int_en = value;
+        return;
+    case UART_INT_FL:
+        s->int_fl = s->int_fl & ~(value);
+        max78000_update_irq(s);
+        return;
+    case UART_CLKDIV:
+        s->clkdiv = value;
+        return;
+    case UART_OSR:
+        s->osr = value;
+        return;
+    case UART_PNR:
+        s->pnr = value;
+        return;
+    case UART_FIFO:
+        data = value & 0xff;
+        /*
+         * XXX this blocks entire thread. Rewrite to use
+         * qemu_chr_fe_write and background I/O callbacks
+         */
+        qemu_chr_fe_write_all(&s->chr, &data, 1);
+
+        /* TX is always empty */
+        s->int_fl |= UART_TX_HE;
+        max78000_update_irq(s);
+
+        return;
+    case UART_DMA:
+        /* DMA not implemented */
+        s->dma = value;
+        return;
+    case UART_WKEN:
+        s->wken = value;
+        return;
+    case UART_WKFL:
+        s->wkfl = value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps max78000_uart_ops = {
+    .read = max78000_uart_read,
+    .write = max78000_uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const Property max78000_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Max78000UartState, chr),
+};
+
+static const VMStateDescription max78000_uart_vmstate = {
+    .name = TYPE_MAX78000_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000UartState),
+        VMSTATE_UINT32(status, Max78000UartState),
+        VMSTATE_UINT32(int_en, Max78000UartState),
+        VMSTATE_UINT32(int_fl, Max78000UartState),
+        VMSTATE_UINT32(clkdiv, Max78000UartState),
+        VMSTATE_UINT32(osr, Max78000UartState),
+        VMSTATE_UINT32(txpeek, Max78000UartState),
+        VMSTATE_UINT32(pnr, Max78000UartState),
+        VMSTATE_UINT32(fifo, Max78000UartState),
+        VMSTATE_UINT32(dma, Max78000UartState),
+        VMSTATE_UINT32(wken, Max78000UartState),
+        VMSTATE_UINT32(wkfl, Max78000UartState),
+        VMSTATE_FIFO8(rx_fifo, Max78000UartState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_uart_init(Object *obj)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+    fifo8_create(&s->rx_fifo, 8);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_uart_ops, s,
+                          TYPE_MAX78000_UART, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void max78000_uart_realize(DeviceState *dev, Error **errp)
+{
+    Max78000UartState *s = MAX78000_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, max78000_uart_can_receive,
+                             max78000_uart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static void max78000_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_uart_reset_hold;
+
+    device_class_set_props(dc, max78000_uart_properties);
+    dc->realize = max78000_uart_realize;
+
+    dc->vmsd = &max78000_uart_vmstate;
+}
+
+static const TypeInfo max78000_uart_info = {
+    .name          = TYPE_MAX78000_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000UartState),
+    .instance_init = max78000_uart_init,
+    .class_init    = max78000_uart_class_init,
+};
+
+static void max78000_uart_register_types(void)
+{
+    type_register_static(&max78000_uart_info);
+}
+
+type_init(max78000_uart_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 4e439da8b9..a9e1dc26c0 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -26,6 +26,7 @@ system_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
 system_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
+system_ss.add(when: 'CONFIG_MAX78000_UART', if_true: files('max78000_uart.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
new file mode 100644
index 0000000000..cf90d51dbf
--- /dev/null
+++ b/include/hw/char/max78000_uart.h
@@ -0,0 +1,78 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_UART_H
+#define HW_MAX78000_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "qemu/fifo8.h"
+#include "qom/object.h"
+
+#define UART_CTRL       0x0
+#define UART_STATUS     0x4
+#define UART_INT_EN     0x8
+#define UART_INT_FL     0xc
+#define UART_CLKDIV     0x10
+#define UART_OSR        0x14
+#define UART_TXPEEK     0x18
+#define UART_PNR        0x1c
+#define UART_FIFO       0x20
+#define UART_DMA        0x30
+#define UART_WKEN       0x34
+#define UART_WKFL       0x38
+
+/* CTRL */
+#define UART_CTF_DIS    (1 << 7)
+#define UART_FLUSH_TX   (1 << 8)
+#define UART_FLUSH_RX   (1 << 9)
+#define UART_BCLKEN     (1 << 15)
+#define UART_BCLKRDY    (1 << 19)
+
+/* STATUS */
+#define UART_RX_LVL     8
+#define UART_TX_EM      (1 << 6)
+#define UART_RX_FULL    (1 << 5)
+#define UART_RX_EM      (1 << 4)
+
+/* PNR (Pin Control Register) */
+#define UART_CTS        1
+#define UART_RTS        (1 << 1)
+
+/* INT_EN / INT_FL */
+#define UART_RX_THD     (1 << 4)
+#define UART_TX_HE      (1 << 6)
+
+#define UART_RXBUFLEN   0x100
+#define TYPE_MAX78000_UART "max78000-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000UartState, MAX78000_UART)
+
+struct Max78000UartState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t int_en;
+    uint32_t int_fl;
+    uint32_t clkdiv;
+    uint32_t osr;
+    uint32_t txpeek;
+    uint32_t pnr;
+    uint32_t fifo;
+    uint32_t dma;
+    uint32_t wken;
+    uint32_t wkfl;
+
+    Fifo8 rx_fifo;
+
+    CharBackend chr;
+    qemu_irq irq;
+};
+#endif /* HW_STM32F2XX_USART_H */
-- 
2.34.1


