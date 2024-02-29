Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D70BC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfalr-00040I-8L; Thu, 29 Feb 2024 02:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfalT-0003lA-MJ; Thu, 29 Feb 2024 02:23:41 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX02.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfalS-0008LL-1X; Thu, 29 Feb 2024 02:23:35 -0500
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Feb
 2024 15:23:19 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Feb 2024 15:23:19 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 6/8] aspeed/intc: Add AST2700 support
Date: Thu, 29 Feb 2024 15:23:13 +0800
Message-ID: <20240229072315.743963-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
References: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX02.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 interrupt controller(INTC) provides hardware interrupt interfaces
to interrupt of processors PSP, SSP and TSP. In INTC, each interrupt of
INT 128 to INT136 combines 32 interrupts.

Introduce a new aspeed_intc class with instance_init and realize handlers.

QEMU supports ARM Generic Interrupt Controller, version 3(GICv3)
but not support Shared Peripheral Interrupt (SPI), yet.
This patch added work around to set GICINT132[18] which was BMC UART interrupt
if it received GICINT132, so users are able to type any key from keyboard to
trigger GICINT132 interrupt until AST2700 boot into login prompt.
It is a temporary solution.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c        | 135 +++++++++++++++++++++++++++++++++++
 hw/intc/meson.build          |   1 +
 include/hw/intc/aspeed_vic.h |  29 ++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 hw/intc/aspeed_intc.c

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
new file mode 100644
index 0000000000..851d43363b
--- /dev/null
+++ b/hw/intc/aspeed_intc.c
@@ -0,0 +1,135 @@
+/*
+ * ASPEED INTC Controller
+ *
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/aspeed_vic.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/intc/arm_gicv3.h"
+#include "trace.h"
+
+#define ASPEED_INTC_NR_IRQS 128
+#define ASPEED_INTC_SIZE 0x4000
+#define TO_REG(N) (N >> 2)
+
+uint64_t regs[ASPEED_INTC_SIZE];
+
+static void aspeed_intc_set_irq(void *opaque, int irq, int level)
+{
+}
+
+static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    GICv3State *gic = ARM_GICV3(s->gic);
+
+    uint64_t value = 0;
+    switch (TO_REG(offset)) {
+    case TO_REG(0x1404):
+        /* BMC UART interript is GICINT132[18] */
+        if (gic && gicv3_gicd_level_test(gic, 164)) {
+            value = BIT(18);
+        }
+        break;
+    default:
+        value = regs[TO_REG(offset)];
+        break;
+    }
+
+    return value;
+}
+
+static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
+                                        unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    GICv3State *gic = ARM_GICV3(s->gic);
+
+    switch (TO_REG(offset)) {
+    case TO_REG(0x1400):
+        regs[TO_REG(offset)] = data;
+        if (regs[TO_REG(offset)]) {
+            gicv3_gicd_enabled_set(gic, 164);
+        } else {
+            gicv3_gicd_enabled_clear(gic, 164);
+        }
+        break;
+    case TO_REG(0x1404):
+        regs[TO_REG(offset)] &= ~(data);
+        gicv3_gicd_level_clear(gic, 164);
+        break;
+    default:
+        regs[TO_REG(offset)] = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_intc_ops = {
+    .read = aspeed_intc_read,
+    .write = aspeed_intc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void aspeed_intc_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedINTCState *s = ASPEED_INTC(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
+                          TYPE_ASPEED_INTC, ASPEED_INTC_SIZE);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    qdev_init_gpio_in(dev, aspeed_intc_set_irq, ASPEED_INTC_NR_IRQS);
+    sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_irq(sbd, &s->fiq);
+}
+
+static void aspeed_intc_reset(DeviceState *dev)
+{
+    AspeedINTCState *s = ASPEED_INTC(dev);
+
+    s->level = 0;
+    s->raw = 0;
+    s->select = 0;
+    s->enable = 0;
+    s->trigger = 0;
+    s->sense = 0x1F07FFF8FFFFULL;
+    s->dual_edge = 0xF800070000ULL;
+    s->event = 0x5F07FFF8FFFFULL;
+}
+
+static void aspeed_intc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_intc_realize;
+    dc->reset = aspeed_intc_reset;
+    dc->desc = "ASPEED Interrupt Controller for AST27x0";
+    dc->vmsd = NULL;
+}
+
+static const TypeInfo aspeed_intc_info = {
+    .name = TYPE_ASPEED_INTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedINTCState),
+    .class_init = aspeed_intc_class_init,
+};
+
+static void aspeed_intc_register_types(void)
+{
+    type_register_static(&aspeed_intc_info);
+}
+
+type_init(aspeed_intc_register_types);
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index ed355941d1..f5c574f584 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_intc.c'))
 system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_pic.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos4210_combiner.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
diff --git a/include/hw/intc/aspeed_vic.h b/include/hw/intc/aspeed_vic.h
index 68d6ab997a..673a11d7fd 100644
--- a/include/hw/intc/aspeed_vic.h
+++ b/include/hw/intc/aspeed_vic.h
@@ -17,6 +17,7 @@
 #include "qom/object.h"
 
 #define TYPE_ASPEED_VIC "aspeed.vic"
+#define TYPE_ASPEED_INTC "aspeed.intc"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedVICState, ASPEED_VIC)
 
 #define ASPEED_VIC_NR_IRQS 51
@@ -46,4 +47,32 @@ struct AspeedVICState {
     uint64_t event;
 };
 
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedINTCState, ASPEED_INTC)
+
+struct AspeedINTCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    DeviceState *gic;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+    qemu_irq fiq;
+
+    uint64_t level;
+    uint64_t raw;
+    uint64_t select;
+    uint64_t enable;
+    uint64_t trigger;
+
+    /* 0=edge, 1=level */
+    uint64_t sense;
+
+    /* 0=single-edge, 1=dual-edge */
+    uint64_t dual_edge;
+
+    /* 0=low-sensitive/falling-edge, 1=high-sensitive/rising-edge */
+    uint64_t event;
+};
+
 #endif /* ASPEED_VIC_H */
-- 
2.25.1


