Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E496DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDe8T-0001mC-NE; Sat, 10 May 2025 02:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhm-0006Co-5w
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:54 -0400
Received: from smtpa-outbound2.duck.com ([20.13.235.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcksn@duck.com>) id 1uDbhj-0004nQ-O3
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:20:53 -0400
Subject: [PATCH 3/6] MAX78000 UART implementation
References: <20250510042043.2056265-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) DMARC_POLICY_ALLOW(-0.5)
 R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) MID_RHS_MATCH_TO(1)
X-Rspamd-Score: 0.5
X-Rspamd-Action: no action
To: qemu-devel@nongnu.org
Cc: alistair@alistair.me
Received: by smtp-inbound1.duck.com; Sat, 10 May 2025 00:20:49 -0400
Message-ID: <B389ED9F-EC29-47F0-90DD-93E89826912D.1@smtp-inbound1.duck.com>
Date: Sat, 10 May 2025 00:20:49 -0400
From: jcksn@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: Cc: To: Content-Transfer-Encoding:
 MIME-Version: References: Subject; q=dns/txt; s=postal-KpyQVw;
 t=1746850850; bh=fVsIFeyntioAtwcdlD8dXORb42CjZvcASUdZQYq9GmQ=;
 b=B7JAHYxz/X0vIThJaW1DXJuyBpCe2WBINN6BfAxB0D7g0X/bkwS4L26GcI6hWMfgNf0GuHheG
 x6JOiv9lEsk2388ItOeCh/8jJ9nHfNA0S2ZYz6+qYdLvnQMvPcaSSJbKD7KSEUhXK9IpzB+XHS+
 2q3Ss2ZEEg2CJbJIRiRQj8s=
Received-SPF: pass client-ip=20.13.235.192; envelope-from=jcksn@duck.com;
 helo=smtpa-outbound2.duck.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 10 May 2025 02:56:35 -0400
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

This patch implements UART support for the MAX78000 SOC

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                  |   1 +
 hw/arm/max78000_soc.c           |  27 +++-
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 263 ++++++++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 include/hw/arm/max78000_soc.h   |   3 +
 include/hw/char/max78000_uart.h |  77 ++++++++++
 7 files changed, 370 insertions(+), 5 deletions(-)
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 include/hw/char/max78000_uart.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3f23af3244..59450dc3cb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -368,6 +368,7 @@ config MAX78000_SOC
     bool
     select ARM_V7M
     select MAX78000_ICC
+    select MAX78000_UART
 
 config RASPI
     bool
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 4d598bddd4..6334d8b49b 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -16,7 +16,11 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
-static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+static const uint32_t max78000_icc_addr[] =  {0x4002a000, 0x4002a800};
+static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
+                                              0x40044000};
+
+static const int max78000_uart_irq[] = {30, 31, 50};
 
 static void max78000_soc_initfn(Object *obj)
 {
@@ -29,6 +33,10 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_MAX78000_UART);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -38,6 +46,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
@@ -101,6 +110,18 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
+                                                       max78000_uart_irq[i]));
+    }
+
 
     create_unimplemented_device("globalControl",    0x40000000, 0x400);
     create_unimplemented_device("systemInterface",  0x40000400, 0x400);
@@ -140,10 +161,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("oneWireMaster",    0x4003d000, 0x1000);
     create_unimplemented_device("semaphore",        0x4003e000, 0x1000);
 
-    create_unimplemented_device("uart0",            0x40042000, 0x1000);
-    create_unimplemented_device("uart1",            0x40043000, 0x1000);
-    create_unimplemented_device("uart2",            0x40044000, 0x1000);
-
     create_unimplemented_device("spi1",             0x40046000, 0x2000);
     create_unimplemented_device("trng",             0x4004d000, 0x1000);
     create_unimplemented_device("i2s",              0x40060000, 0x1000);
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
index 0000000000..edd39c5a8b
--- /dev/null
+++ b/hw/char/max78000_uart.c
@@ -0,0 +1,263 @@
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
+#include "trace.h"
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
+    int interrupt_level = 0;
+    uint32_t rx_threshold = s->ctrl & 0xf;
+
+    /*
+     * Because tx is synchronous and we should have no frame errors, the only
+     * possible interrupt is receive fifo threshold
+     */
+    if ((s->int_en & UART_RX_THD) && fifo8_num_used(&s->rx_fifo) >= rx_threshold) {
+        interrupt_level = 1;
+        s->int_fl = s->int_fl & UART_RX_THD;
+    } else{
+        s->int_fl = s->int_fl & ~UART_RX_THD;
+    }
+    qemu_set_irq(s->irq, interrupt_level);
+}
+
+static void max78000_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    Max78000UartState *s = opaque;
+
+    if (size <= fifo8_num_free(&s->rx_fifo)) {
+        fifo8_push_all(&s->rx_fifo, buf, size);
+    } else{
+        fifo8_push_all(&s->rx_fifo, buf, fifo8_num_free(&s->rx_fifo));
+        printf("rx_fifo overrun!\n");
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
+
+    switch (addr) {
+    case UART_CTRL:
+        retvalue = s->ctrl;
+        break;
+    case UART_STATUS:
+        retvalue = (fifo8_num_used(&s->rx_fifo) > 7 ?
+                    8 : (fifo8_num_used(&s->rx_fifo)) << UART_RX_LVL) |
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
+        s->int_fl = value;
+        return;
+    case UART_CLKDIV:
+        s->clkdiv = value;
+        return;
+    case UART_OSR:
+        s->osr = value;
+        return;
+    case UART_TXPEEK:
+        /* UART_TXPEEK is read only */
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
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+            HWADDR_PRIx "\n", TYPE_MAX78000_UART, __func__, addr);
+    }
+}
+
+static const MemoryRegionOps max78000_uart_ops = {
+    .read = max78000_uart_read,
+    .write = max78000_uart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const Property max78000_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Max78000UartState, chr),
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
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 207a4da68a..1ee280b894 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -12,6 +12,7 @@
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/max78000_icc.h"
+#include "hw/char/max78000_uart.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -24,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 
 /* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
 #define MAX78000_NUM_ICC 2
+#define MAX78000_NUM_UART 3
 
 struct MAX78000State {
     SysBusDevice parent_obj;
@@ -34,6 +36,7 @@ struct MAX78000State {
     MemoryRegion flash;
 
     Max78000IccState icc[MAX78000_NUM_ICC];
+    Max78000UartState uart[MAX78000_NUM_UART];
 
     Clock *sysclk;
     Clock *refclk;
diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
new file mode 100644
index 0000000000..0d39a2dd59
--- /dev/null
+++ b/include/hw/char/max78000_uart.h
@@ -0,0 +1,77 @@
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


