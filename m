Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2D0C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yra-0002eZ-9t; Sun, 30 Aug 2026 02:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrW-0002cQ-Ar; Sun, 30 Aug 2026 02:17:51 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrR-0005IU-63; Sun, 30 Aug 2026 02:17:50 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXhjp2g3PzBqYg;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070638;
 bh=NU1Br5qRqu26HVA6jGQYVK1RBdnhudyZMVInVkl7YtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f5nri38HYAadpyLvymtsOpMomteOUJRb4deXpwbjaaf8jkQnOgqOfhIllbEihgHcR
 QF5sCYXAv1mI3cq9UEjTmJCb4ZkeaqGBsyq7i7VETprN4yPy9F1n5O2Ik03Q22Biiw
 yRomuH45IWphxpNaJRL0GzyxDAOnKJVCoWQWyloLIl0GDj6+Li7hY/QIfi+10TylnC
 5UeMeE4uzYfllbwUxljB3ql+yMdbyW7uCPf/7FTr5TOgtSZqwnuPS8BBrTSV2NfEYs
 /KLp8Yw0nwGmQ14w1RvxTxcMhhA69oVplbSn0MqyMNiQkwibgYUQSiw09/sOeTiAyr
 Z0Uw2mQnZm2lg==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjp18ZYz7xSW;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 22/30] hw/dma: add RP2040 DMA controller
Date: Sun, 30 Aug 2026 08:15:53 +0200
Message-ID: <20260830061601.52136-8-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Model the twelve RP2040 DMA channels, register aliases, interrupts, chaining, ring wrapping, aborts, sniff checksums and AHB error status. Pace transfers from DREQ inputs and the four virtual DMA timers.\n\nWire the controller to the SoC memory, IRQ lines, XIP controller and both UARTs. Add focused qtests for XIP pacing, rings, aborts, sniffing, errors, timer requests and re-entrant control blocks.\n\nThe model provides deterministic functional behavior rather than bus-cycle accurate timing.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                |    1 +
 hw/arm/rp2040.c               |   37 +-
 hw/dma/Kconfig                |    5 +-
 hw/dma/meson.build            |    1 +
 hw/dma/rp2040_dma.c           | 1032 +++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h       |    2 +
 include/hw/dma/rp2040_dma.h   |   77 +++
 tests/qtest/meson.build       |    1 +
 tests/qtest/rp2040-dma-test.c |  374 ++++++++++++
 9 files changed, 1528 insertions(+), 2 deletions(-)
 create mode 100644 hw/dma/rp2040_dma.c
 create mode 100644 include/hw/dma/rp2040_dma.h
 create mode 100644 tests/qtest/rp2040-dma-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index dad91b368d..30965e9ede 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -379,6 +379,7 @@ config RP2040
     select ARM_V7M
     select PL011
     select RP2040_CLOCKS
+    select RP2040_DMA
     select RP2040_IOBANK0
     select RP2040_IOQSPI
     select RP2040_NYI
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 3a8c8f88af..e7ba55bd1f 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -24,6 +24,8 @@
 #define RP2040_UART0_IRQ  20
 #define RP2040_UART1_BASE 0x40038000
 #define RP2040_UART1_IRQ  21
+#define RP2040_DMA_IRQ_0  11
+#define RP2040_DMA_IRQ_1  12
 #define RP2040_IO_IRQ_BANK0 13
 #define RP2040_SIO_IRQ_PROC0 15
 #define RP2040_SIO_IRQ_PROC1 16
@@ -148,7 +150,6 @@ static const struct {
     { "rp2040.adc",      0x4004c000, 0x4000 },
     { "rp2040.pwm",      0x40050000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
-    { "rp2040.dma",      0x50000000, 0x1000 },
     { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
     { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
     { "rp2040.pio0",     0x50200000, 0x10000 },
@@ -369,6 +370,7 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "xip", &s->xip, TYPE_RP2040_XIP);
 
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
+    object_initialize_child(obj, "dma", &s->dma, TYPE_RP2040_DMA);
     object_initialize_child(obj, "iobank0", &s->iobank0,
                             TYPE_RP2040_IOBANK0);
     object_initialize_child(obj, "ioqspi", &s->ioqspi,
@@ -529,6 +531,29 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
                                 RP2040_XIP_NOCACHE_NOALLOC_BASE,
                                 &s->xip.xip_nocache_noalloc);
 
+    object_property_set_link(OBJECT(&s->dma), "memory",
+                             OBJECT(s->board_memory), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0, RP2040_DMA_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), 0,
+                       s->irq[RP2040_DMA_IRQ_0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), 1,
+                       s->irq[RP2040_DMA_IRQ_1]);
+    qdev_connect_gpio_out_named(DEVICE(&s->xip), "dreq-rx", 0,
+                                qdev_get_gpio_in_named(DEVICE(&s->dma),
+                                                       "dreq",
+                                                       RP2040_DREQ_XIP_SSIRX));
+    qdev_connect_gpio_out_named(DEVICE(&s->xip), "dreq-stream", 0,
+                                qdev_get_gpio_in_named(DEVICE(&s->dma),
+                                                       "dreq",
+                                                       RP2040_DREQ_XIP_STREAM));
+
     for (i = 0; i < ARRAY_SIZE(rp2040_unimplemented); i++) {
         create_unimplemented_device(rp2040_unimplemented[i].name,
                                     rp2040_unimplemented[i].base,
@@ -702,6 +727,16 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
                         uart_base[i] + 0x1000);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
                            s->irq[uart_irq[i]]);
+        qdev_connect_gpio_out_named(
+            DEVICE(&s->uart[i]), "dreq-tx", 0,
+            qdev_get_gpio_in_named(DEVICE(&s->dma), "dreq",
+                                   i ? RP2040_DREQ_UART1_TX :
+                                       RP2040_DREQ_UART0_TX));
+        qdev_connect_gpio_out_named(
+            DEVICE(&s->uart[i]), "dreq-rx", 0,
+            qdev_get_gpio_in_named(DEVICE(&s->dma), "dreq",
+                                   i ? RP2040_DREQ_UART1_RX :
+                                       RP2040_DREQ_UART0_RX));
     }
     rp2040_update_uart_pins(s);
 }
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 0a23e7d7b8..79e36c429e 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -32,4 +32,7 @@ config XLNX_CSU_DMA
     select REGISTER
 
 config K230_GSDMA
-    bool
\ No newline at end of file
+    bool
+
+config RP2040_DMA
+    bool
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index 45db5e7357..43d2e50d0b 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -10,6 +10,7 @@ system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dpdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZDMA', if_true: files('xlnx-zdma.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
+system_ss.add(when: 'CONFIG_RP2040_DMA', if_true: files('rp2040_dma.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
 system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
diff --git a/hw/dma/rp2040_dma.c b/hw/dma/rp2040_dma.c
new file mode 100644
index 0000000000..5a3f720207
--- /dev/null
+++ b/hw/dma/rp2040_dma.c
@@ -0,0 +1,1032 @@
+/*
+ * RP2040 DMA emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/dma/rp2040_dma.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/host-utils.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+#define DMA_CH_SIZE              0x40
+#define DMA_CH_READ_ADDR         0x00
+#define DMA_CH_WRITE_ADDR        0x04
+#define DMA_CH_TRANS_COUNT       0x08
+#define DMA_CH_CTRL_TRIG         0x0c
+#define DMA_CH_AL1_CTRL          0x10
+#define DMA_CH_AL1_READ_ADDR     0x14
+#define DMA_CH_AL1_WRITE_ADDR    0x18
+#define DMA_CH_AL1_TRANS_COUNT   0x1c
+#define DMA_CH_AL2_CTRL          0x20
+#define DMA_CH_AL2_TRANS_COUNT   0x24
+#define DMA_CH_AL2_READ_ADDR     0x28
+#define DMA_CH_AL2_WRITE_ADDR    0x2c
+#define DMA_CH_AL3_CTRL          0x30
+#define DMA_CH_AL3_WRITE_ADDR    0x34
+#define DMA_CH_AL3_TRANS_COUNT   0x38
+#define DMA_CH_AL3_READ_ADDR     0x3c
+
+#define DMA_INTR                 0x400
+#define DMA_INTE0                0x404
+#define DMA_INTF0                0x408
+#define DMA_INTS0                0x40c
+#define DMA_INTE1                0x414
+#define DMA_INTF1                0x418
+#define DMA_INTS1                0x41c
+#define DMA_TIMER0               0x420
+#define DMA_MULTI_CHAN_TRIGGER   0x430
+#define DMA_SNIFF_CTRL           0x434
+#define DMA_SNIFF_DATA           0x438
+#define DMA_FIFO_LEVELS          0x440
+#define DMA_CHAN_ABORT           0x444
+
+#define DMA_CTRL_AHB_ERROR       BIT(31)
+#define DMA_CTRL_READ_ERROR      BIT(30)
+#define DMA_CTRL_WRITE_ERROR     BIT(29)
+#define DMA_CTRL_BUSY            BIT(24)
+#define DMA_CTRL_SNIFF_EN        BIT(23)
+#define DMA_CTRL_BSWAP           BIT(22)
+#define DMA_CTRL_IRQ_QUIET       BIT(21)
+#define DMA_CTRL_TREQ_SEL_SHIFT  15
+#define DMA_CTRL_TREQ_SEL_MASK   (0x3f << DMA_CTRL_TREQ_SEL_SHIFT)
+#define DMA_CTRL_CHAIN_TO_SHIFT  11
+#define DMA_CTRL_CHAIN_TO_MASK   (0xf << DMA_CTRL_CHAIN_TO_SHIFT)
+#define DMA_CTRL_RING_SEL        BIT(10)
+#define DMA_CTRL_RING_SIZE_SHIFT 6
+#define DMA_CTRL_RING_SIZE_MASK  (0xf << 6)
+#define DMA_CTRL_INCR_WRITE      BIT(5)
+#define DMA_CTRL_INCR_READ       BIT(4)
+#define DMA_CTRL_DATA_SIZE_SHIFT 2
+#define DMA_CTRL_DATA_SIZE_MASK  (0x3 << DMA_CTRL_DATA_SIZE_SHIFT)
+#define DMA_CTRL_EN              BIT(0)
+#define DMA_CTRL_ERROR_MASK      (DMA_CTRL_AHB_ERROR | \
+                                  DMA_CTRL_READ_ERROR | \
+                                  DMA_CTRL_WRITE_ERROR)
+
+#define DMA_SNIFF_CTRL_OUT_INV   BIT(11)
+#define DMA_SNIFF_CTRL_OUT_REV   BIT(10)
+#define DMA_SNIFF_CTRL_BSWAP     BIT(9)
+#define DMA_SNIFF_CTRL_CALC_SHIFT 5
+#define DMA_SNIFF_CTRL_CALC_MASK  (0xf << DMA_SNIFF_CTRL_CALC_SHIFT)
+#define DMA_SNIFF_CTRL_DMACH_SHIFT 1
+#define DMA_SNIFF_CTRL_DMACH_MASK (0xf << DMA_SNIFF_CTRL_DMACH_SHIFT)
+#define DMA_SNIFF_CTRL_EN        BIT(0)
+#define DMA_SNIFF_CTRL_MASK      0xfff
+
+#define DMA_SNIFF_CALC_CRC32     0x0
+#define DMA_SNIFF_CALC_CRC32R    0x1
+#define DMA_SNIFF_CALC_CRC16     0x2
+#define DMA_SNIFF_CALC_CRC16R    0x3
+#define DMA_SNIFF_CALC_EVEN      0xe
+#define DMA_SNIFF_CALC_SUM       0xf
+
+#define DMA_CTRL_WRITABLE_MASK   (DMA_CTRL_SNIFF_EN | DMA_CTRL_BSWAP | \
+                                  DMA_CTRL_IRQ_QUIET | \
+                                  DMA_CTRL_TREQ_SEL_MASK | \
+                                  DMA_CTRL_CHAIN_TO_MASK | \
+                                  DMA_CTRL_RING_SEL | \
+                                  DMA_CTRL_RING_SIZE_MASK | \
+                                  DMA_CTRL_INCR_WRITE | \
+                                  DMA_CTRL_INCR_READ | \
+                                  DMA_CTRL_DATA_SIZE_MASK | \
+                                  BIT(1) | DMA_CTRL_EN)
+#define DMA_CHANNEL_MASK         ((1u << RP2040_DMA_NUM_CHANNELS) - 1)
+#define DMA_PACING_SYSCLK_HZ     125000000ULL
+#define DMA_PACING_SYSCLK_NS     8ULL
+
+#define ATOMIC_ALIAS_MASK        0x3000
+#define ATOMIC_XOR               0x1000
+#define ATOMIC_SET               0x2000
+#define ATOMIC_CLR               0x3000
+
+static uint32_t rp2040_dma_apply_alias(uint32_t old, uint32_t value,
+                                       hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint32_t rp2040_dma_ints(RP2040DmaState *s, unsigned irq)
+{
+    return ((s->intr & s->inte[irq]) | s->intf[irq]) & DMA_CHANNEL_MASK;
+}
+
+static void rp2040_dma_update_irq(RP2040DmaState *s)
+{
+    int i;
+
+    for (i = 0; i < RP2040_DMA_NUM_IRQS; i++) {
+        qemu_set_irq(s->irq[i], rp2040_dma_ints(s, i) != 0);
+    }
+}
+
+static unsigned rp2040_dma_transfer_size(RP2040DmaChannel *ch)
+{
+    switch ((ch->ctrl & DMA_CTRL_DATA_SIZE_MASK) >> DMA_CTRL_DATA_SIZE_SHIFT) {
+    case 0:
+        return 1;
+    case 1:
+        return 2;
+    case 2:
+        return 4;
+    default:
+        return 4;
+    }
+}
+
+static void rp2040_dma_request_start(RP2040DmaState *s, unsigned index);
+static void rp2040_dma_dreq(void *opaque, int n, int level);
+static void rp2040_dma_dreq_pulse(RP2040DmaState *s, uint32_t dreq);
+static void rp2040_dma_dreq_bh(void *opaque);
+static bool rp2040_dma_dreq_has_busy_channel(RP2040DmaState *s, uint32_t dreq,
+                                             unsigned except);
+static void rp2040_dma_write_reg(RP2040DmaState *s, hwaddr addr,
+                                 uint64_t value64, unsigned size);
+
+static uint32_t rp2040_dma_treq(RP2040DmaChannel *ch)
+{
+    return (ch->ctrl & DMA_CTRL_TREQ_SEL_MASK) >> DMA_CTRL_TREQ_SEL_SHIFT;
+}
+
+static bool rp2040_dma_treq_is_ready_sink(uint32_t treq)
+{
+    /*
+     * The current XIP/SSI TX model does not have a finite TX FIFO: writes to
+     * its data register are accepted immediately.
+     */
+    return treq == RP2040_DREQ_XIP_SSITX;
+}
+
+static bool rp2040_dma_treq_is_connected_level(uint32_t treq)
+{
+    return treq == RP2040_DREQ_UART0_TX || treq == RP2040_DREQ_UART0_RX ||
+           treq == RP2040_DREQ_UART1_TX || treq == RP2040_DREQ_UART1_RX ||
+           treq == RP2040_DREQ_XIP_STREAM;
+}
+
+static bool rp2040_dma_treq_is_timer(uint32_t treq)
+{
+    return treq >= RP2040_DREQ_DMA_TIMER0 &&
+           treq <= RP2040_DREQ_DMA_TIMER3;
+}
+
+static uint64_t rp2040_dma_timer_period_ns(uint32_t value)
+{
+    uint32_t x = value >> 16;
+    uint32_t y = value & 0xffff;
+    uint64_t period;
+
+    if (x == 0 || y == 0) {
+        return 0;
+    }
+
+    /*
+     * The RP2040 fractional timer emits TREQs at (X/Y) * sys_clk, capped
+     * at one TREQ per sys_clk. Use the Pico's nominal 125 MHz system clock
+     * as the virtual pacing source.
+     */
+    if (x >= y) {
+        return DMA_PACING_SYSCLK_NS;
+    }
+
+    period = DIV_ROUND_UP((uint64_t)y * NANOSECONDS_PER_SECOND,
+                          (uint64_t)x * DMA_PACING_SYSCLK_HZ);
+    return MAX(period, 1);
+}
+
+static void rp2040_dma_timer_update(RP2040DmaState *s, unsigned index)
+{
+    RP2040DmaPacingTimer *pt = &s->pacing_timer[index];
+
+    pt->period_ns = rp2040_dma_timer_period_ns(s->timer[index]);
+    if (pt->period_ns == 0) {
+        timer_del(pt->timer);
+        return;
+    }
+
+    timer_mod(pt->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              pt->period_ns);
+}
+
+static void rp2040_dma_timer_cb(void *opaque)
+{
+    RP2040DmaPacingTimer *pt = opaque;
+    RP2040DmaState *s = pt->dma;
+    uint32_t dreq = RP2040_DREQ_DMA_TIMER0 + pt->index;
+
+    if (rp2040_dma_dreq_has_busy_channel(s, dreq, RP2040_DMA_NUM_CHANNELS)) {
+        rp2040_dma_dreq_pulse(s, dreq);
+    }
+    if (pt->period_ns != 0) {
+        timer_mod(pt->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                  pt->period_ns);
+    }
+}
+
+static uint32_t rp2040_dma_next_addr(RP2040DmaChannel *ch, uint32_t addr,
+                                     unsigned width, bool write)
+{
+    uint32_t ring_size;
+    bool ring_write;
+    uint32_t mask;
+
+    if (!(ch->ctrl & (write ? DMA_CTRL_INCR_WRITE : DMA_CTRL_INCR_READ))) {
+        return addr;
+    }
+
+    ring_size = (ch->ctrl & DMA_CTRL_RING_SIZE_MASK) >>
+                DMA_CTRL_RING_SIZE_SHIFT;
+    ring_write = ch->ctrl & DMA_CTRL_RING_SEL;
+    if (ring_size == 0 || ring_write != write) {
+        return addr + width;
+    }
+
+    mask = (1u << ring_size) - 1;
+    return (addr & ~mask) | ((addr + width) & mask);
+}
+
+static uint32_t rp2040_dma_sniff_word(const uint8_t *buf, unsigned width)
+{
+    uint32_t value = buf[0];
+
+    if (width >= 2) {
+        value |= (uint32_t)buf[1] << 8;
+    }
+    if (width >= 4) {
+        value |= (uint32_t)buf[2] << 16;
+        value |= (uint32_t)buf[3] << 24;
+    }
+    return value;
+}
+
+static void rp2040_dma_sniff_bswap(uint8_t *buf, unsigned width)
+{
+    if (width == 2) {
+        uint8_t t = buf[0];
+        buf[0] = buf[1];
+        buf[1] = t;
+    } else if (width == 4) {
+        uint8_t t = buf[0];
+        buf[0] = buf[3];
+        buf[3] = t;
+        t = buf[1];
+        buf[1] = buf[2];
+        buf[2] = t;
+    }
+}
+
+static uint32_t rp2040_dma_sniff_crc32(uint32_t crc, const uint8_t *buf,
+                                       unsigned width, bool reverse)
+{
+    int i;
+    int bit;
+
+    for (i = 0; i < width; i++) {
+        uint8_t byte = reverse ? revbit8(buf[i]) : buf[i];
+
+        crc ^= (uint32_t)byte << 24;
+        for (bit = 0; bit < 8; bit++) {
+            crc = (crc & BIT(31)) ? (crc << 1) ^ 0x04c11db7 : crc << 1;
+        }
+    }
+    return crc;
+}
+
+static uint32_t rp2040_dma_sniff_crc16(uint32_t crc, const uint8_t *buf,
+                                       unsigned width, bool reverse)
+{
+    uint16_t crc16 = crc;
+    int i;
+    int bit;
+
+    for (i = 0; i < width; i++) {
+        uint8_t byte = reverse ? revbit8(buf[i]) : buf[i];
+
+        crc16 ^= (uint16_t)byte << 8;
+        for (bit = 0; bit < 8; bit++) {
+            crc16 = (crc16 & BIT(15)) ? (crc16 << 1) ^ 0x1021 : crc16 << 1;
+        }
+    }
+    return (crc & 0xffff0000) | crc16;
+}
+
+static void rp2040_dma_sniff_update(RP2040DmaState *s, unsigned index,
+                                    const uint8_t *buf, unsigned width)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint8_t sniff_buf[4] = { 0 };
+    uint32_t channel;
+    uint32_t calc;
+    uint32_t value;
+
+    if (!(s->sniff_ctrl & DMA_SNIFF_CTRL_EN) ||
+        !(ch->ctrl & DMA_CTRL_SNIFF_EN)) {
+        return;
+    }
+
+    channel = (s->sniff_ctrl & DMA_SNIFF_CTRL_DMACH_MASK) >>
+              DMA_SNIFF_CTRL_DMACH_SHIFT;
+    if (channel != index) {
+        return;
+    }
+
+    memcpy(sniff_buf, buf, width);
+    if (s->sniff_ctrl & DMA_SNIFF_CTRL_BSWAP) {
+        rp2040_dma_sniff_bswap(sniff_buf, width);
+    }
+
+    calc = (s->sniff_ctrl & DMA_SNIFF_CTRL_CALC_MASK) >>
+           DMA_SNIFF_CTRL_CALC_SHIFT;
+    switch (calc) {
+    case DMA_SNIFF_CALC_CRC32:
+        s->sniff_data = rp2040_dma_sniff_crc32(s->sniff_data, sniff_buf,
+                                               width, false);
+        break;
+    case DMA_SNIFF_CALC_CRC32R:
+        s->sniff_data = rp2040_dma_sniff_crc32(s->sniff_data, sniff_buf,
+                                               width, true);
+        break;
+    case DMA_SNIFF_CALC_CRC16:
+        s->sniff_data = rp2040_dma_sniff_crc16(s->sniff_data, sniff_buf,
+                                               width, false);
+        break;
+    case DMA_SNIFF_CALC_CRC16R:
+        s->sniff_data = rp2040_dma_sniff_crc16(s->sniff_data, sniff_buf,
+                                               width, true);
+        break;
+    case DMA_SNIFF_CALC_EVEN:
+        value = rp2040_dma_sniff_word(sniff_buf, width);
+        s->sniff_data = (s->sniff_data ^ ctpop32(value)) & 1;
+        break;
+    case DMA_SNIFF_CALC_SUM:
+        s->sniff_data += rp2040_dma_sniff_word(sniff_buf, width);
+        break;
+    default:
+        break;
+    }
+}
+
+static uint32_t rp2040_dma_sniff_read_data(RP2040DmaState *s)
+{
+    uint32_t value = s->sniff_data;
+
+    if (s->sniff_ctrl & DMA_SNIFF_CTRL_OUT_REV) {
+        value = revbit32(value);
+    }
+    if (s->sniff_ctrl & DMA_SNIFF_CTRL_OUT_INV) {
+        value = ~value;
+    }
+    return value;
+}
+
+static void rp2040_dma_finish_channel(RP2040DmaState *s, unsigned index)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint32_t chain_to;
+
+    ch->ctrl &= ~DMA_CTRL_BUSY;
+    if (!(ch->ctrl & DMA_CTRL_IRQ_QUIET)) {
+        s->intr |= BIT(index);
+        rp2040_dma_update_irq(s);
+    }
+
+    chain_to = (ch->ctrl & DMA_CTRL_CHAIN_TO_MASK) >> DMA_CTRL_CHAIN_TO_SHIFT;
+    if (!(ch->ctrl & DMA_CTRL_ERROR_MASK) &&
+        chain_to < RP2040_DMA_NUM_CHANNELS && chain_to != index) {
+        rp2040_dma_request_start(s, chain_to);
+    }
+}
+
+static void rp2040_dma_run_beats(RP2040DmaState *s, unsigned index,
+                                 uint32_t beats)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint32_t count;
+    unsigned width;
+
+    if (!(ch->ctrl & DMA_CTRL_EN) || ch->trans_count == 0) {
+        return;
+    }
+
+    width = rp2040_dma_transfer_size(ch);
+    count = MIN(ch->trans_count, beats);
+
+    while (count--) {
+        uint8_t buf[4] = { 0 };
+        MemTxResult result;
+
+        result = address_space_rw(&s->dma_as, ch->read_addr,
+                                  MEMTXATTRS_UNSPECIFIED, buf, width, false);
+        if (result != MEMTX_OK) {
+            ch->ctrl |= DMA_CTRL_READ_ERROR | DMA_CTRL_AHB_ERROR;
+            break;
+        }
+
+        if (ch->ctrl & DMA_CTRL_BSWAP) {
+            if (width == 2) {
+                uint8_t t = buf[0];
+                buf[0] = buf[1];
+                buf[1] = t;
+            } else if (width == 4) {
+                uint8_t t = buf[0];
+                buf[0] = buf[3];
+                buf[3] = t;
+                t = buf[1];
+                buf[1] = buf[2];
+                buf[2] = t;
+            }
+        }
+        rp2040_dma_sniff_update(s, index, buf, width);
+
+        if (ch->write_addr >= RP2040_DMA_BASE &&
+            ch->write_addr < RP2040_DMA_BASE + RP2040_DMA_SIZE) {
+            if (width == 4) {
+                rp2040_dma_write_reg(s, ch->write_addr - RP2040_DMA_BASE,
+                                     ldl_le_p(buf), width);
+                result = MEMTX_OK;
+            } else {
+                result = MEMTX_ERROR;
+            }
+        } else {
+            result = address_space_rw(&s->dma_as, ch->write_addr,
+                                      MEMTXATTRS_UNSPECIFIED, buf, width,
+                                      true);
+        }
+        if (result != MEMTX_OK) {
+            ch->ctrl |= DMA_CTRL_WRITE_ERROR | DMA_CTRL_AHB_ERROR;
+            break;
+        }
+
+        ch->trans_count--;
+        ch->read_addr = rp2040_dma_next_addr(ch, ch->read_addr, width, false);
+        ch->write_addr = rp2040_dma_next_addr(ch, ch->write_addr, width, true);
+    }
+
+    if ((ch->ctrl & DMA_CTRL_ERROR_MASK) || ch->trans_count == 0) {
+        rp2040_dma_finish_channel(s, index);
+    }
+}
+
+static void rp2040_dma_start_channel(RP2040DmaState *s, unsigned index)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint32_t treq;
+
+    if (!(ch->ctrl & DMA_CTRL_EN)) {
+        return;
+    }
+
+    if (ch->trans_count == 0 && ch->reload_count != 0) {
+        ch->trans_count = ch->reload_count;
+    }
+
+    if (ch->trans_count == 0) {
+        if (ch->ctrl & DMA_CTRL_IRQ_QUIET) {
+            s->intr |= BIT(index);
+            rp2040_dma_update_irq(s);
+        }
+        return;
+    }
+
+    ch->ctrl |= DMA_CTRL_BUSY;
+    ch->ctrl &= ~DMA_CTRL_ERROR_MASK;
+    ch->paced_nyi_logged = false;
+
+    treq = rp2040_dma_treq(ch);
+    if (treq == RP2040_DREQ_FORCE || rp2040_dma_treq_is_ready_sink(treq)) {
+        rp2040_dma_run_beats(s, index, UINT32_MAX);
+    } else if ((rp2040_dma_treq_is_connected_level(treq) ||
+                treq == RP2040_DREQ_XIP_SSIRX) && s->dreq_level[treq]) {
+        rp2040_dma_dreq_pulse(s, treq);
+    } else if (treq != RP2040_DREQ_XIP_SSIRX &&
+               !rp2040_dma_treq_is_connected_level(treq) &&
+               !rp2040_dma_treq_is_timer(treq) &&
+               !ch->paced_nyi_logged) {
+        rp2040_log_nyi("dma", "paced transfer",
+                       "DREQ source is not connected yet");
+        ch->paced_nyi_logged = true;
+    }
+}
+
+static void rp2040_dma_drain_starts(RP2040DmaState *s)
+{
+    if (s->engine_active) {
+        return;
+    }
+
+    s->engine_active = true;
+    while (s->pending_start) {
+        unsigned index = ctz32(s->pending_start);
+
+        s->pending_start &= ~BIT(index);
+        rp2040_dma_start_channel(s, index);
+    }
+    s->engine_active = false;
+}
+
+static void rp2040_dma_request_start(RP2040DmaState *s, unsigned index)
+{
+    if (index >= RP2040_DMA_NUM_CHANNELS) {
+        return;
+    }
+
+    s->pending_start |= BIT(index);
+    rp2040_dma_drain_starts(s);
+}
+
+static void rp2040_dma_dreq_pulse(RP2040DmaState *s, uint32_t dreq)
+{
+    if (dreq >= RP2040_DMA_NUM_DREQS) {
+        return;
+    }
+
+    if (s->pending_dreq[dreq] != UINT32_MAX) {
+        s->pending_dreq[dreq]++;
+    }
+    qemu_bh_schedule(s->dreq_bh);
+}
+
+static void rp2040_dma_dreq(void *opaque, int n, int level)
+{
+    RP2040DmaState *s = opaque;
+
+    if (n < 0 || n >= RP2040_DMA_NUM_DREQS) {
+        return;
+    }
+
+    s->dreq_level[n] = level;
+    if (level) {
+        rp2040_dma_dreq_pulse(s, n);
+        if (rp2040_dma_treq_is_connected_level(n)) {
+            rp2040_dma_dreq_bh(s);
+        }
+    }
+}
+
+static void rp2040_dma_dreq_bh(void *opaque)
+{
+    RP2040DmaState *s = opaque;
+    int i;
+    int dreq;
+
+    if (s->dreq_servicing) {
+        return;
+    }
+
+    s->dreq_servicing = true;
+    for (dreq = 0; dreq < RP2040_DMA_NUM_DREQS; dreq++) {
+        while (s->pending_dreq[dreq] > 0) {
+            s->pending_dreq[dreq]--;
+            for (i = 0; i < RP2040_DMA_NUM_CHANNELS; i++) {
+                RP2040DmaChannel *ch = &s->chan[i];
+
+                if ((ch->ctrl & DMA_CTRL_BUSY) && rp2040_dma_treq(ch) == dreq) {
+                    s->engine_active = true;
+                    rp2040_dma_run_beats(s, i, 1);
+                    s->engine_active = false;
+                    rp2040_dma_drain_starts(s);
+                }
+            }
+            if (s->dreq_level[dreq] &&
+                rp2040_dma_dreq_has_busy_channel(s, dreq,
+                                                 RP2040_DMA_NUM_CHANNELS)) {
+                rp2040_dma_dreq_pulse(s, dreq);
+            }
+        }
+    }
+    s->dreq_servicing = false;
+}
+
+static bool rp2040_dma_dreq_has_busy_channel(RP2040DmaState *s, uint32_t dreq,
+                                             unsigned except)
+{
+    int i;
+
+    for (i = 0; i < RP2040_DMA_NUM_CHANNELS; i++) {
+        RP2040DmaChannel *ch = &s->chan[i];
+
+        if (i != except && (ch->ctrl & DMA_CTRL_BUSY) &&
+            rp2040_dma_treq(ch) == dreq) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void rp2040_dma_abort_channel(RP2040DmaState *s, unsigned index)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint32_t treq = rp2040_dma_treq(ch);
+
+    /*
+     * RP2040 CHAN_ABORT clears the transfer counter and leaves the channel
+     * inactive. QEMU does not model in-flight bus-transfer latency, so the
+     * abort status bit is clear as soon as the write completes.
+     */
+    ch->ctrl &= ~DMA_CTRL_BUSY;
+    ch->trans_count = 0;
+    if (treq < RP2040_DMA_NUM_DREQS &&
+        !rp2040_dma_dreq_has_busy_channel(s, treq, index)) {
+        s->pending_dreq[treq] = 0;
+    }
+}
+
+static uint32_t rp2040_dma_read_channel(RP2040DmaState *s, unsigned index,
+                                        hwaddr offset)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+
+    switch (offset) {
+    case DMA_CH_READ_ADDR:
+    case DMA_CH_AL1_READ_ADDR:
+    case DMA_CH_AL2_READ_ADDR:
+    case DMA_CH_AL3_READ_ADDR:
+        return ch->read_addr;
+    case DMA_CH_WRITE_ADDR:
+    case DMA_CH_AL1_WRITE_ADDR:
+    case DMA_CH_AL2_WRITE_ADDR:
+    case DMA_CH_AL3_WRITE_ADDR:
+        return ch->write_addr;
+    case DMA_CH_TRANS_COUNT:
+    case DMA_CH_AL1_TRANS_COUNT:
+    case DMA_CH_AL2_TRANS_COUNT:
+    case DMA_CH_AL3_TRANS_COUNT:
+        return ch->trans_count;
+    case DMA_CH_CTRL_TRIG:
+    case DMA_CH_AL1_CTRL:
+    case DMA_CH_AL2_CTRL:
+    case DMA_CH_AL3_CTRL:
+        return ch->ctrl;
+    default:
+        return 0;
+    }
+}
+
+static void rp2040_dma_write_ctrl(RP2040DmaState *s, unsigned index,
+                                  uint32_t value, bool trigger)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+    uint32_t errors = ch->ctrl & DMA_CTRL_ERROR_MASK;
+
+    errors &= ~(value & (DMA_CTRL_READ_ERROR | DMA_CTRL_WRITE_ERROR));
+    if (errors & (DMA_CTRL_READ_ERROR | DMA_CTRL_WRITE_ERROR)) {
+        errors |= DMA_CTRL_AHB_ERROR;
+    } else {
+        errors &= ~DMA_CTRL_AHB_ERROR;
+    }
+    ch->ctrl = (value & DMA_CTRL_WRITABLE_MASK) | errors;
+    if (trigger) {
+        rp2040_dma_request_start(s, index);
+    }
+}
+
+static void rp2040_dma_write_channel(RP2040DmaState *s, unsigned index,
+                                     hwaddr offset, uint32_t value)
+{
+    RP2040DmaChannel *ch = &s->chan[index];
+
+    switch (offset) {
+    case DMA_CH_READ_ADDR:
+    case DMA_CH_AL1_READ_ADDR:
+    case DMA_CH_AL2_READ_ADDR:
+        ch->read_addr = value;
+        break;
+    case DMA_CH_AL3_READ_ADDR:
+        ch->read_addr = value;
+        rp2040_dma_request_start(s, index);
+        break;
+    case DMA_CH_WRITE_ADDR:
+    case DMA_CH_AL1_WRITE_ADDR:
+    case DMA_CH_AL3_WRITE_ADDR:
+        ch->write_addr = value;
+        break;
+    case DMA_CH_AL2_WRITE_ADDR:
+        ch->write_addr = value;
+        rp2040_dma_request_start(s, index);
+        break;
+    case DMA_CH_TRANS_COUNT:
+    case DMA_CH_AL2_TRANS_COUNT:
+    case DMA_CH_AL3_TRANS_COUNT:
+        ch->trans_count = value;
+        ch->reload_count = value;
+        break;
+    case DMA_CH_AL1_TRANS_COUNT:
+        ch->trans_count = value;
+        ch->reload_count = value;
+        rp2040_dma_request_start(s, index);
+        break;
+    case DMA_CH_CTRL_TRIG:
+        rp2040_dma_write_ctrl(s, index, value, true);
+        break;
+    case DMA_CH_AL1_CTRL:
+    case DMA_CH_AL2_CTRL:
+    case DMA_CH_AL3_CTRL:
+        rp2040_dma_write_ctrl(s, index, value, false);
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t rp2040_dma_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040DmaState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value;
+
+    if (offset < RP2040_DMA_NUM_CHANNELS * DMA_CH_SIZE) {
+        value = rp2040_dma_read_channel(s, offset / DMA_CH_SIZE,
+                                        offset % DMA_CH_SIZE);
+    } else {
+        switch (offset) {
+        case DMA_INTR:
+            value = s->intr;
+            break;
+        case DMA_INTE0:
+            value = s->inte[0];
+            break;
+        case DMA_INTF0:
+            value = s->intf[0];
+            break;
+        case DMA_INTS0:
+            value = rp2040_dma_ints(s, 0);
+            break;
+        case DMA_INTE1:
+            value = s->inte[1];
+            break;
+        case DMA_INTF1:
+            value = s->intf[1];
+            break;
+        case DMA_INTS1:
+            value = rp2040_dma_ints(s, 1);
+            break;
+        case DMA_TIMER0 ... DMA_TIMER0 + 3 * sizeof(uint32_t):
+            value = s->timer[(offset - DMA_TIMER0) / sizeof(uint32_t)];
+            break;
+        case DMA_SNIFF_CTRL:
+            value = s->sniff_ctrl;
+            break;
+        case DMA_SNIFF_DATA:
+            value = rp2040_dma_sniff_read_data(s);
+            break;
+        case DMA_FIFO_LEVELS:
+            value = 0;
+            break;
+        case DMA_CHAN_ABORT:
+            value = 0;
+            break;
+        default:
+            value = 0;
+            qemu_log_mask(LOG_UNIMP, "rp2040.dma: unimplemented read  "
+                          "(size %d, addr 0x%08" HWADDR_PRIx
+                          ", offset 0x%04" HWADDR_PRIx
+                          ") -> 0x%0*" PRIx32 "\n",
+                          size, RP2040_DMA_BASE + addr, offset,
+                          size << 1, value);
+            break;
+        }
+    }
+
+    return value;
+}
+
+static void rp2040_dma_write_reg(RP2040DmaState *s, hwaddr addr,
+                                 uint64_t value64, unsigned size)
+{
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old;
+    int i;
+
+    if (offset < RP2040_DMA_NUM_CHANNELS * DMA_CH_SIZE) {
+        rp2040_dma_write_channel(s, offset / DMA_CH_SIZE,
+                                 offset % DMA_CH_SIZE, value);
+    } else {
+        switch (offset) {
+        case DMA_INTR:
+            s->intr &= ~(value & DMA_CHANNEL_MASK);
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTE0:
+            s->inte[0] = rp2040_dma_apply_alias(s->inte[0], value, alias) &
+                         DMA_CHANNEL_MASK;
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTF0:
+            s->intf[0] = rp2040_dma_apply_alias(s->intf[0], value, alias) &
+                         DMA_CHANNEL_MASK;
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTS0:
+            s->intr &= ~(value & DMA_CHANNEL_MASK);
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTE1:
+            s->inte[1] = rp2040_dma_apply_alias(s->inte[1], value, alias) &
+                         DMA_CHANNEL_MASK;
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTF1:
+            s->intf[1] = rp2040_dma_apply_alias(s->intf[1], value, alias) &
+                         DMA_CHANNEL_MASK;
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_INTS1:
+            s->intr &= ~(value & DMA_CHANNEL_MASK);
+            rp2040_dma_update_irq(s);
+            break;
+        case DMA_TIMER0 ... DMA_TIMER0 + 3 * sizeof(uint32_t):
+            i = (offset - DMA_TIMER0) / sizeof(uint32_t);
+            s->timer[i] = rp2040_dma_apply_alias(s->timer[i], value, alias);
+            rp2040_dma_timer_update(s, i);
+            break;
+        case DMA_MULTI_CHAN_TRIGGER:
+            value &= DMA_CHANNEL_MASK;
+            for (i = 0; i < RP2040_DMA_NUM_CHANNELS; i++) {
+                if (value & BIT(i)) {
+                    rp2040_dma_request_start(s, i);
+                }
+            }
+            break;
+        case DMA_SNIFF_CTRL:
+            old = s->sniff_ctrl;
+            s->sniff_ctrl = rp2040_dma_apply_alias(old, value, alias) &
+                            DMA_SNIFF_CTRL_MASK;
+            break;
+        case DMA_SNIFF_DATA:
+            s->sniff_data = rp2040_dma_apply_alias(s->sniff_data, value,
+                                                   alias);
+            break;
+        case DMA_CHAN_ABORT:
+            value &= DMA_CHANNEL_MASK;
+            for (i = 0; i < RP2040_DMA_NUM_CHANNELS; i++) {
+                if (value & BIT(i)) {
+                    rp2040_dma_abort_channel(s, i);
+                }
+            }
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "rp2040.dma: unimplemented write "
+                          "(size %d, addr 0x%08" HWADDR_PRIx
+                          ", offset 0x%04" HWADDR_PRIx
+                          ", value 0x%0*" PRIx64 ")\n",
+                          size, RP2040_DMA_BASE + addr, offset, size << 1,
+                          value64);
+            break;
+        }
+    }
+}
+
+static void rp2040_dma_write(void *opaque, hwaddr addr, uint64_t value64,
+                             unsigned size)
+{
+    rp2040_dma_write_reg(opaque, addr, value64, size);
+}
+
+static const MemoryRegionOps rp2040_dma_ops = {
+    .read = rp2040_dma_read,
+    .write = rp2040_dma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_dma_reset(DeviceState *dev)
+{
+    RP2040DmaState *s = RP2040_DMA(dev);
+    int i;
+
+    for (i = 0; i < RP2040_DMA_NUM_CHANNELS; i++) {
+        s->chan[i].read_addr = 0;
+        s->chan[i].write_addr = 0;
+        s->chan[i].trans_count = 0;
+        s->chan[i].reload_count = 0;
+        s->chan[i].ctrl = i << DMA_CTRL_CHAIN_TO_SHIFT;
+        s->chan[i].paced_nyi_logged = false;
+    }
+    s->intr = 0;
+    s->inte[0] = 0;
+    s->inte[1] = 0;
+    s->intf[0] = 0;
+    s->intf[1] = 0;
+    memset(s->timer, 0, sizeof(s->timer));
+    for (i = 0; i < RP2040_DMA_NUM_TIMERS; i++) {
+        s->pacing_timer[i].period_ns = 0;
+        timer_del(s->pacing_timer[i].timer);
+    }
+    memset(s->dreq_level, 0, sizeof(s->dreq_level));
+    memset(s->pending_dreq, 0, sizeof(s->pending_dreq));
+    qemu_bh_cancel(s->dreq_bh);
+    s->engine_active = false;
+    s->pending_start = 0;
+    s->sniff_ctrl = 0;
+    s->sniff_data = 0;
+    rp2040_dma_update_irq(s);
+}
+
+static void rp2040_dma_init(Object *obj)
+{
+    RP2040DmaState *s = RP2040_DMA(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    int i;
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_dma_ops, s,
+                          TYPE_RP2040_DMA, RP2040_DMA_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    for (i = 0; i < RP2040_DMA_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+    s->dreq_bh = qemu_bh_new(rp2040_dma_dreq_bh, s);
+    qdev_init_gpio_in_named(DEVICE(obj), rp2040_dma_dreq, "dreq",
+                            RP2040_DMA_NUM_DREQS);
+    for (i = 0; i < RP2040_DMA_NUM_TIMERS; i++) {
+        s->pacing_timer[i].dma = s;
+        s->pacing_timer[i].index = i;
+        s->pacing_timer[i].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                rp2040_dma_timer_cb,
+                                                &s->pacing_timer[i]);
+    }
+}
+
+static void rp2040_dma_finalize(Object *obj)
+{
+    RP2040DmaState *s = RP2040_DMA(obj);
+    int i;
+
+    for (i = 0; i < RP2040_DMA_NUM_TIMERS; i++) {
+        timer_free(s->pacing_timer[i].timer);
+    }
+    qemu_bh_delete(s->dreq_bh);
+}
+
+static void rp2040_dma_realize(DeviceState *dev, Error **errp)
+{
+    RP2040DmaState *s = RP2040_DMA(dev);
+
+    if (!s->dma_mr) {
+        error_setg(errp, "memory property was not set");
+        return;
+    }
+
+    address_space_init(&s->dma_as, s->dma_mr, "rp2040-dma-memory");
+}
+
+static const VMStateDescription rp2040_dma_vmstate = {
+    .name = TYPE_RP2040_DMA,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_dma_properties[] = {
+    DEFINE_PROP_LINK("memory", RP2040DmaState, dma_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void rp2040_dma_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_dma_realize;
+    device_class_set_legacy_reset(dc, rp2040_dma_reset);
+    dc->vmsd = &rp2040_dma_vmstate;
+    device_class_set_props(dc, rp2040_dma_properties);
+}
+
+static const TypeInfo rp2040_dma_info = {
+    .name          = TYPE_RP2040_DMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040DmaState),
+    .instance_init = rp2040_dma_init,
+    .instance_finalize = rp2040_dma_finalize,
+    .class_init    = rp2040_dma_class_init,
+};
+
+static void rp2040_dma_register_types(void)
+{
+    type_register_static(&rp2040_dma_info);
+}
+type_init(rp2040_dma_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index cb108bd5f1..d52c8856b0 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,6 +13,7 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/dma/rp2040_dma.h"
 #include "hw/misc/rp2040_clocks.h"
 #include "hw/misc/rp2040_iobank0.h"
 #include "hw/misc/rp2040_ioqspi.h"
@@ -56,6 +57,7 @@ struct RP2040State {
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
     RP2040ClocksState clocks;
+    RP2040DmaState dma;
     RP2040IoBank0State iobank0;
     RP2040IoQspiState ioqspi;
     RP2040PadsBank0State pads_bank0;
diff --git a/include/hw/dma/rp2040_dma.h b/include/hw/dma/rp2040_dma.h
new file mode 100644
index 0000000000..4b4dae4097
--- /dev/null
+++ b/include/hw/dma/rp2040_dma.h
@@ -0,0 +1,77 @@
+/*
+ * RP2040 DMA emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_DMA_RP2040_DMA_H
+#define HW_DMA_RP2040_DMA_H
+
+#include "hw/core/sysbus.h"
+#include "system/memory.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_DMA "rp2040-dma"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040DmaState, RP2040_DMA)
+
+#define RP2040_DMA_BASE 0x50000000
+#define RP2040_DMA_SIZE 0x4000
+#define RP2040_DMA_NUM_CHANNELS 12
+#define RP2040_DMA_NUM_IRQS 2
+#define RP2040_DMA_NUM_DREQS 64
+#define RP2040_DMA_NUM_TIMERS 4
+
+#define RP2040_DREQ_UART0_TX 20
+#define RP2040_DREQ_UART0_RX 21
+#define RP2040_DREQ_UART1_TX 22
+#define RP2040_DREQ_UART1_RX 23
+#define RP2040_DREQ_XIP_STREAM 37
+#define RP2040_DREQ_XIP_SSITX 38
+#define RP2040_DREQ_XIP_SSIRX 39
+#define RP2040_DREQ_DMA_TIMER0 59
+#define RP2040_DREQ_DMA_TIMER1 60
+#define RP2040_DREQ_DMA_TIMER2 61
+#define RP2040_DREQ_DMA_TIMER3 62
+#define RP2040_DREQ_FORCE 63
+
+typedef struct RP2040DmaChannel {
+    uint32_t read_addr;
+    uint32_t write_addr;
+    uint32_t trans_count;
+    uint32_t reload_count;
+    uint32_t ctrl;
+    bool paced_nyi_logged;
+} RP2040DmaChannel;
+
+typedef struct RP2040DmaPacingTimer {
+    void *dma;
+    QEMUTimer *timer;
+    uint64_t period_ns;
+    unsigned index;
+} RP2040DmaPacingTimer;
+
+struct RP2040DmaState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
+    qemu_irq irq[RP2040_DMA_NUM_IRQS];
+
+    RP2040DmaChannel chan[RP2040_DMA_NUM_CHANNELS];
+    uint32_t intr;
+    uint32_t inte[RP2040_DMA_NUM_IRQS];
+    uint32_t intf[RP2040_DMA_NUM_IRQS];
+    uint32_t timer[RP2040_DMA_NUM_TIMERS];
+    RP2040DmaPacingTimer pacing_timer[RP2040_DMA_NUM_TIMERS];
+    uint32_t sniff_ctrl;
+    uint32_t sniff_data;
+    QEMUBH *dreq_bh;
+    bool dreq_servicing;
+    bool engine_active;
+    uint32_t pending_start;
+    bool dreq_level[RP2040_DMA_NUM_DREQS];
+    uint32_t pending_dreq[RP2040_DMA_NUM_DREQS];
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 9bc7540aee..89e8f3ac32 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -257,6 +257,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
                                                        'rp2040-clocks-test',
+                                                       'rp2040-dma-test',
                                                        'rp2040-iobank0-test',
                                                        'rp2040-ioqspi-test',
                                                        'rp2040-pads-test',
diff --git a/tests/qtest/rp2040-dma-test.c b/tests/qtest/rp2040-dma-test.c
new file mode 100644
index 0000000000..61ad2fac40
--- /dev/null
+++ b/tests/qtest/rp2040-dma-test.c
@@ -0,0 +1,374 @@
+/*
+ * QTest testcase for the RP2040 DMA block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define DMA_BASE                0x50000000
+#define DMA_CH_READ_ADDR        0x00
+#define DMA_CH_WRITE_ADDR       0x04
+#define DMA_CH_TRANS_COUNT      0x08
+#define DMA_CH_CTRL_TRIG        0x0c
+#define DMA_CH_AL1_CTRL         0x10
+#define DMA_CH_AL3_TRANS_COUNT  0x38
+#define DMA_CH_AL3_READ_ADDR    0x3c
+#define DMA_CH_SIZE             0x40
+#define DMA_INTR                0x400
+#define DMA_INTE0               0x404
+#define DMA_INTS0               0x40c
+#define DMA_TIMER0              0x420
+#define DMA_SNIFF_CTRL          0x434
+#define DMA_SNIFF_DATA          0x438
+#define DMA_CHAN_ABORT          0x444
+
+#define DMA_CTRL_AHB_ERROR      BIT(31)
+#define DMA_CTRL_READ_ERROR     BIT(30)
+#define DMA_CTRL_WRITE_ERROR    BIT(29)
+#define DMA_CTRL_BUSY           BIT(24)
+#define DMA_CTRL_SNIFF_EN       BIT(23)
+#define DMA_CTRL_IRQ_QUIET      BIT(21)
+#define DMA_CTRL_TREQ_SEL_SHIFT 15
+#define DMA_CTRL_CHAIN_TO_SHIFT 11
+#define DMA_CTRL_RING_SEL       BIT(10)
+#define DMA_CTRL_RING_SIZE_SHIFT 6
+#define DMA_CTRL_INCR_WRITE     BIT(5)
+#define DMA_CTRL_INCR_READ      BIT(4)
+#define DMA_CTRL_DATA_SIZE_8    (0 << 2)
+#define DMA_CTRL_DATA_SIZE_32   (2 << 2)
+#define DMA_CTRL_EN             BIT(0)
+
+#define DMA_SNIFF_CTRL_OUT_INV  BIT(11)
+#define DMA_SNIFF_CTRL_OUT_REV  BIT(10)
+#define DMA_SNIFF_CTRL_CALC_SUM (0xf << 5)
+#define DMA_SNIFF_CTRL_EN       BIT(0)
+
+#define DREQ_DMA_TIMER0         59
+#define DREQ_XIP_SSIRX          39
+#define DREQ_FORCE              63
+
+#define XIP_SSI_BASE            0x18000000
+#define XIP_SSI_DR0             0x60
+
+#define SRAM_BASE               0x20000000
+#define BAD_DMA_ADDR            0x60000000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_dma_xip_ssi_rx_dreq(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_XIP_SSIRX << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0xffffffff);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_SSI_BASE + XIP_SSI_DR0);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 4);
+
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x03);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SRAM_BASE), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_write_ring_wrap(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0x10, 0x11, 0x12, 0x13, 0x14, 0x15 };
+    const uint8_t initial[] = { 0xaa, 0xaa, 0xaa, 0xaa };
+    uint8_t dest[sizeof(initial)];
+    uint32_t read_addr = SRAM_BASE + 0x80;
+    uint32_t write_addr = SRAM_BASE + 0x100;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_RING_SEL | DMA_CTRL_DATA_SIZE_8 |
+                    (2 << DMA_CTRL_RING_SIZE_SHIFT) |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    qtest_memwrite(qts, write_addr, initial, sizeof(initial));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmphex(dest[0], ==, 0x14);
+    g_assert_cmphex(dest[1], ==, 0x15);
+    g_assert_cmphex(dest[2], ==, 0x12);
+    g_assert_cmphex(dest[3], ==, 0x13);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_READ_ADDR), ==,
+                    read_addr + sizeof(source));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_WRITE_ADDR), ==,
+                    write_addr + 2);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_channel_abort(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_XIP_SSIRX << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0xffffffff);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_SSI_BASE + XIP_SSI_DR0);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 4);
+
+    qtest_writel(qts, DMA_BASE + DMA_CHAN_ABORT, BIT(0));
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CHAN_ABORT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x03);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+
+    g_assert_cmphex(qtest_readl(qts, SRAM_BASE), ==, 0xffffffff);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_sniff_sum(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 1, 2, 3, 4 };
+    uint32_t read_addr = SRAM_BASE + 0x180;
+    uint32_t write_addr = SRAM_BASE + 0x190;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_SNIFF_EN | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_DATA, 0x100);
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==, 0x10a);
+
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM |
+                 DMA_SNIFF_CTRL_OUT_REV);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==,
+                    0x50800000);
+
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM |
+                 DMA_SNIFF_CTRL_OUT_INV);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==,
+                    0xfffffef5);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_error_status(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_DATA_SIZE_32 |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0x12345678);
+    qtest_writel(qts, DMA_BASE + DMA_INTR, BIT(0));
+    qtest_writel(qts, DMA_BASE + DMA_INTE0, BIT(0));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, BAD_DMA_ADDR);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE + 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 1);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR | DMA_CTRL_BUSY), ==,
+                    DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, BIT(0));
+
+    qtest_writel(qts, DMA_BASE + DMA_INTS0, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, 0);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG,
+                 DMA_CTRL_READ_ERROR | DMA_CTRL_WRITE_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR), ==, 0);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, BAD_DMA_ADDR);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 1);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR | DMA_CTRL_BUSY), ==,
+                    DMA_CTRL_AHB_ERROR | DMA_CTRL_WRITE_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, BIT(0));
+
+    qtest_quit(qts);
+}
+
+static void test_dma_timer_dreq(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0xa1, 0xb2, 0xc3 };
+    uint8_t dest[sizeof(source)];
+    uint32_t read_addr = SRAM_BASE + 0x280;
+    uint32_t write_addr = SRAM_BASE + 0x290;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_DMA_TIMER0 << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    memset(dest, 0, sizeof(dest));
+    qtest_memwrite(qts, write_addr, dest, sizeof(dest));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==,
+                    sizeof(source));
+
+    /*
+     * X/Y = 1/1000 on a nominal 125 MHz sys_clk gives one DREQ every
+     * 8000 ns of QEMU virtual time.
+     */
+    qtest_writel(qts, DMA_BASE + DMA_TIMER0, (1u << 16) | 1000u);
+    qtest_clock_step(qts, 7999);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==,
+                    sizeof(source));
+
+    qtest_clock_step(qts, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 2);
+    g_assert_cmphex(qtest_readb(qts, write_addr), ==, source[0]);
+
+    qtest_clock_step(qts, 8000);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readb(qts, write_addr + 1), ==, source[1]);
+
+    qtest_clock_step(qts, 8000);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmpmem(dest, sizeof(dest), source, sizeof(source));
+
+    qtest_quit(qts);
+}
+
+static void test_dma_control_blocks(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0x44, 0x4d, 0x41 };
+    uint8_t dest[sizeof(source)];
+    uint32_t blocks[] = {
+        sizeof(source), SRAM_BASE + 0x380,
+        0, 0,
+    };
+    uint32_t block_addr = SRAM_BASE + 0x300;
+    uint32_t read_addr = SRAM_BASE + 0x380;
+    uint32_t write_addr = SRAM_BASE + 0x390;
+    uint32_t chan1 = DMA_BASE + DMA_CH_SIZE;
+    uint32_t ctrl_chan_ctrl;
+    uint32_t data_chan_ctrl;
+
+    qtest_memwrite(qts, block_addr, blocks, sizeof(blocks));
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+
+    /*
+     * Channel 0 writes two 32-bit words into channel 1's alias 3
+     * TRANS_COUNT/READ_ADDR registers.  The second write triggers channel 1.
+     */
+    ctrl_chan_ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ |
+                     DMA_CTRL_INCR_WRITE | DMA_CTRL_RING_SEL |
+                     DMA_CTRL_DATA_SIZE_32 |
+                     (3 << DMA_CTRL_RING_SIZE_SHIFT) |
+                     (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    /*
+     * Channel 1 copies the configured block and chains back to channel 0.
+     * The final zero-length control block sets channel 1's interrupt via
+     * IRQ_QUIET, matching the SDK control_blocks example's termination.
+     */
+    data_chan_ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ |
+                     DMA_CTRL_INCR_WRITE | DMA_CTRL_IRQ_QUIET |
+                     (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT) |
+                     (0 << DMA_CTRL_CHAIN_TO_SHIFT);
+
+    qtest_writel(qts, chan1 + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, chan1 + DMA_CH_AL1_CTRL, data_chan_ctrl);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, block_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR,
+                 chan1 + DMA_CH_AL3_TRANS_COUNT);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 2);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl_chan_ctrl);
+
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmpmem(dest, sizeof(dest), source, sizeof(source));
+    g_assert_cmphex(qtest_readl(qts, chan1 + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, chan1 + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR) & BIT(1), ==,
+                    BIT(1));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-dma/xip-ssi-rx-dreq",
+                   test_dma_xip_ssi_rx_dreq);
+    qtest_add_func("/rp2040-dma/write-ring-wrap",
+                   test_dma_write_ring_wrap);
+    qtest_add_func("/rp2040-dma/channel-abort",
+                   test_dma_channel_abort);
+    qtest_add_func("/rp2040-dma/sniff-sum",
+                   test_dma_sniff_sum);
+    qtest_add_func("/rp2040-dma/error-status",
+                   test_dma_error_status);
+    qtest_add_func("/rp2040-dma/timer-dreq",
+                   test_dma_timer_dreq);
+    qtest_add_func("/rp2040-dma/control-blocks",
+                   test_dma_control_blocks);
+
+    return g_test_run();
+}
-- 
2.55.0


