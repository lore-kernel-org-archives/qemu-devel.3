Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87BCCAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1s-0006Cl-Iv; Tue, 16 Sep 2025 21:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1j-0006Ak-NU; Tue, 16 Sep 2025 21:32:09 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1h-0006vf-LT; Tue, 16 Sep 2025 21:32:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/6] hw/arm/aspeed: Add LTPI controller
Date: Wed, 17 Sep 2025 09:31:37 +0800
Message-ID: <20250917013143.1600377-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

AST27x0 platforms support two LTPI controllers. Each LTPI controller
has one set of device registers, one set of PHY register and one OEM
channel for AST1700 connection.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h   |   4 ++
 include/hw/misc/aspeed_ltpi.h |  25 ++++++++
 hw/arm/aspeed_ast27x0.c       |  28 +++++++++
 hw/misc/aspeed_ltpi.c         | 111 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 5 files changed, 169 insertions(+)
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 hw/misc/aspeed_ltpi.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 77263cc6ec..72eefb0327 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -41,6 +41,7 @@
 #include "hw/fsi/aspeed_apb2opb.h"
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/misc/aspeed_ltpi.h"
 
 #define ASPEED_SPIS_NUM  3
 #define ASPEED_EHCIS_NUM 4
@@ -104,6 +105,7 @@ struct AspeedSoCState {
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
+    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
     uint8_t ioexp_num;
 };
 
@@ -287,6 +289,8 @@ enum {
     ASPEED_GIC_REDIST,
     ASPEED_DEV_IPC0,
     ASPEED_DEV_IPC1,
+    ASPEED_DEV_LTPI_CTRL1,
+    ASPEED_DEV_LTPI_CTRL2,
 };
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltpi.h
new file mode 100644
index 0000000000..2c31a555dd
--- /dev/null
+++ b/include/hw/misc/aspeed_ltpi.h
@@ -0,0 +1,25 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_LTPI_H
+#define ASPEED_LTPI_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)
+
+#define ASPEED_LTPI_NR_REGS  (0x900 >> 2)
+
+struct AspeedLTPIState {
+    SysBusDevice parent;
+    MemoryRegion mmio;
+
+    uint32_t regs[ASPEED_LTPI_NR_REGS];
+};
+
+#endif /* ASPEED_LTPI_H */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6aa3841b69..3f93554027 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -80,6 +80,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART10]    =  0x14C33900,
     [ASPEED_DEV_UART11]    =  0x14C33A00,
     [ASPEED_DEV_UART12]    =  0x14C33B00,
+    [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
+    [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_LTPI]      =  0x300000000,
@@ -531,6 +533,12 @@ static void aspeed_soc_ast2700_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
 }
 
+static void aspeed_ast2700_ast1700_init(AspeedSoCState *s, int i)
+{
+    object_initialize_child(OBJECT(s), "ltpi-ctrl[*]",
+                            &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
+}
+
 /*
  * ASPEED ast2700 has 0x0 as cluster ID
  *
@@ -610,6 +618,20 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
     return true;
 }
 
+static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
+                                               AspeedSoCState *s,
+                                               AspeedSoCClass *sc,
+                                               int index, Error **errp)
+{
+    AspeedLTPIState *ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[index]);
+    hwaddr ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + index];
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
+}
+
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -936,6 +958,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
 
+    /* I/O Expander */
+    for (i = 0; i < s->ioexp_num; i++) {
+        aspeed_ast2700_ast1700_init(s, i);
+        aspeed_soc_ast2700_ast1700_realize(a, s, sc, i, errp);
+    }
+
     aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
new file mode 100644
index 0000000000..0c9cf40094
--- /dev/null
+++ b/hw/misc/aspeed_ltpi.c
@@ -0,0 +1,111 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/misc/aspeed_ltpi.h"
+
+#define LTPI_LINK_MNG 0x42
+#define LTPI_PHY_MODE 0x80
+
+static uint64_t ltpi_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    if (idx >= ASPEED_LTPI_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad offset=0x%" HWADDR_PRIx "\n",
+                      TYPE_ASPEED_LTPI, offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void ltpi_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    if (idx >= ASPEED_LTPI_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad offset=0x%" HWADDR_PRIx " val=0x%" PRIx64 "\n",
+                      TYPE_ASPEED_LTPI, offset, val);
+        return;
+    }
+
+    switch (offset) {
+    default:
+        s->regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps ltpi_ops = {
+    .read = ltpi_read,
+    .write = ltpi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void ltpi_reset(DeviceState *dev)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+    memset(s->regs, 0, sizeof(s->regs));
+    /* set default values */
+    s->regs[LTPI_LINK_MNG] = 0x11900007;
+    s->regs[LTPI_PHY_MODE] = 0x2;
+}
+
+
+static const VMStateDescription vmstate_ltpi = {
+    .name = TYPE_ASPEED_LTPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedLTPIState,
+                             ASPEED_LTPI_NR_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ltpi_realize(DeviceState *dev, Error **errp)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &ltpi_ops, s,
+                          TYPE_ASPEED_LTPI, ASPEED_LTPI_NR_REGS);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
+}
+
+static void ltpi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = ltpi_realize;
+    dc->vmsd = &vmstate_ltpi;
+    device_class_set_legacy_reset(dc, ltpi_reset);
+}
+
+static const TypeInfo ltpi_info = {
+    .name          = TYPE_ASPEED_LTPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedLTPIState),
+    .class_init    = ltpi_class_init,
+};
+
+static void ltpi_register_types(void)
+{
+    type_register_static(&ltpi_info);
+}
+
+type_init(ltpi_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..45b16e7797 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
   'aspeed_i3c.c',
   'aspeed_lpc.c',
+  'aspeed_ltpi.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
-- 
2.43.0


