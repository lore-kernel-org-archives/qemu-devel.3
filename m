Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F42ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNR-0000bW-Qo; Mon, 12 Oct 2026 12:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMn-00084m-Ll; Mon, 12 Oct 2026 12:59:15 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMe-0006EW-Bq; Mon, 12 Oct 2026 12:59:12 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw34WHMzBqmr;
 Mon, 12 Oct 2026 18:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824323;
 bh=/QnzBLaPi29cfAK622DcsenVTGZKD4K2Pku8zU1gJC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mybcsavC2095F4Bw/apOxUjnCIiocEJRFC/Luo/hqOqc8Pp2fYN1F79TVp+lV1FwY
 dY+ToriSgAdIuUfYgsePozlst8PgF+v+hqOcmfjZXgvgxtCbaC8OGV0dxaKCUvjnMI
 A9EXHiDVrRF0vMuIWvtg1+z7v/YWyQFSsH+THvy9J/yxPFNCk5gdgBTZ4pTueUwIpN
 TRu1zNsQD9VsmGWTcp79O4bm0PGXRVorBnc56gOPU/9iIjJLV976yBWnw40lK8qwiM
 sxOaxJdjksTX27l+F/ajdpB9lSkPz/Q/66Mn8Xdytg7NAVOgBaRZptzQTF1QyNanE0
 Ede0oLxxBHMMg==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw32b6jz83nc;
 Mon, 12 Oct 2026 18:58:43 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 8/9] hw/misc: add RP2040 voltage regulator
Date: Mon, 12 Oct 2026 18:58:38 +0200
Message-ID: <20261012165840.99050-9-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 voltage regulator, brown-out detector, and chip reset.

Include documented reset values, writable masks, and APB atomic aliases.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                |   8 +-
 hw/misc/meson.build            |   1 +
 hw/misc/rp2040_vreg.c          | 149 +++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h        |   2 +
 include/hw/misc/rp2040_vreg.h  |  46 ++++++++++
 tests/qtest/meson.build        |   6 +-
 tests/qtest/rp2040-vreg-test.c |  79 +++++++++++++++++
 7 files changed, 287 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/rp2040_vreg.c
 create mode 100644 include/hw/misc/rp2040_vreg.h
 create mode 100644 tests/qtest/rp2040-vreg-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 47a0ef220f..0af99aed7e 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -73,8 +73,6 @@ static const struct {
     { "rp2040.watchdog", 0x40058000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
     { "rp2040.rosc",     0x40060000, 0x4000 },
-    { "rp2040.vreg_and_chip_reset", 0x40064000, 0x4000 },
-    { "rp2040.tbman",    0x4006c000, 0x4000 },
     { "rp2040.dma",      0x50000000, 0x1000 },
     { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
     { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
@@ -145,6 +143,7 @@ static void rp2040_soc_init(Object *obj)
 
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+    object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
 
@@ -278,6 +277,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vreg), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
+
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c26442fdcc..ea89f26b88 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_vreg.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_vreg.c b/hw/misc/rp2040_vreg.c
new file mode 100644
index 0000000000..2745bddd50
--- /dev/null
+++ b/hw/misc/rp2040_vreg.c
@@ -0,0 +1,149 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040.h"
+#include "hw/misc/rp2040_vreg.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define VREG_RW_MASK \
+    (R_RP2040_VREG_VREG_VSEL_MASK | R_RP2040_VREG_VREG_HIZ_MASK | \
+     R_RP2040_VREG_VREG_EN_MASK)
+#define BOD_RW_MASK \
+    (R_RP2040_VREG_BOD_VSEL_MASK | R_RP2040_VREG_BOD_EN_MASK)
+#define CHIP_RESET_RW_MASK R_RP2040_VREG_CHIP_RESET_PSM_RESTART_FLAG_MASK
+
+static uint32_t rp2040_vreg_read_vreg(RP2040VregState *s)
+{
+    uint32_t value = s->vreg;
+
+    if (FIELD_EX32(value, RP2040_VREG_VREG, EN) &&
+        !FIELD_EX32(value, RP2040_VREG_VREG, HIZ)) {
+        value |= R_RP2040_VREG_VREG_ROK_MASK;
+    }
+
+    return value;
+}
+
+static uint64_t rp2040_vreg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040VregState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case A_RP2040_VREG_VREG:
+        value = rp2040_vreg_read_vreg(s);
+        break;
+    case A_RP2040_VREG_BOD:
+        value = s->bod;
+        break;
+    case A_RP2040_VREG_CHIP_RESET:
+        value = s->chip_reset;
+        break;
+    default:
+        value = 0;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_vreg_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040VregState *s = opaque;
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case A_RP2040_VREG_VREG:
+        s->vreg = rp2040_atomic_update(s->vreg, value, alias) &
+                  VREG_RW_MASK;
+        break;
+    case A_RP2040_VREG_BOD:
+        s->bod = rp2040_atomic_update(s->bod, value, alias) & BOD_RW_MASK;
+        break;
+    case A_RP2040_VREG_CHIP_RESET:
+        s->chip_reset =
+            rp2040_atomic_update(s->chip_reset, value, alias) &
+            CHIP_RESET_RW_MASK;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_vreg_ops = {
+    .read = rp2040_vreg_read,
+    .write = rp2040_vreg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_vreg_reset(DeviceState *dev)
+{
+    RP2040VregState *s = RP2040_VREG(dev);
+
+    s->vreg = RP2040_VREG_VREG_RESET;
+    s->bod = RP2040_VREG_BOD_RESET;
+    s->chip_reset = 0;
+}
+
+static void rp2040_vreg_init(Object *obj)
+{
+    RP2040VregState *s = RP2040_VREG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_vreg_ops, s,
+                          "rp2040.vreg_and_chip_reset", RP2040_VREG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_vreg_vmstate = {
+    .name = TYPE_RP2040_VREG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(vreg, RP2040VregState),
+        VMSTATE_UINT32(bod, RP2040VregState),
+        VMSTATE_UINT32(chip_reset, RP2040VregState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_vreg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_vreg_reset);
+    dc->vmsd = &rp2040_vreg_vmstate;
+}
+
+static const TypeInfo rp2040_vreg_info = {
+    .name          = TYPE_RP2040_VREG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040VregState),
+    .instance_init = rp2040_vreg_init,
+    .class_init    = rp2040_vreg_class_init,
+};
+
+static void rp2040_vreg_register_types(void)
+{
+    type_register_static(&rp2040_vreg_info);
+}
+type_init(rp2040_vreg_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index f6050f255d..4b6f7c2faa 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -15,6 +15,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_syscfg.h"
+#include "hw/misc/rp2040_vreg.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -39,6 +40,7 @@ struct RP2040State {
     PL011State uart[2];
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
+    RP2040VregState vreg;
 
     MemoryRegion *board_memory;
     MemoryRegion cpu_memory[RP2040_NUM_CORES];
diff --git a/include/hw/misc/rp2040_vreg.h b/include/hw/misc/rp2040_vreg.h
new file mode 100644
index 0000000000..eab6cd8221
--- /dev/null
+++ b/include/hw/misc/rp2040_vreg.h
@@ -0,0 +1,46 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_VREG_H
+#define HW_MISC_RP2040_VREG_H
+
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_VREG "rp2040-vreg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040VregState, RP2040_VREG)
+
+#define RP2040_VREG_BASE 0x40064000
+#define RP2040_VREG_SIZE 0x4000
+
+REG32(RP2040_VREG_VREG, 0x00)
+    FIELD(RP2040_VREG_VREG, ROK, 12, 1)
+    FIELD(RP2040_VREG_VREG, VSEL, 4, 4)
+    FIELD(RP2040_VREG_VREG, HIZ, 1, 1)
+    FIELD(RP2040_VREG_VREG, EN, 0, 1)
+REG32(RP2040_VREG_BOD, 0x04)
+    FIELD(RP2040_VREG_BOD, VSEL, 4, 4)
+    FIELD(RP2040_VREG_BOD, EN, 0, 1)
+REG32(RP2040_VREG_CHIP_RESET, 0x08)
+    FIELD(RP2040_VREG_CHIP_RESET, PSM_RESTART_FLAG, 24, 1)
+    FIELD(RP2040_VREG_CHIP_RESET, HAD_PSM_RESTART, 20, 1)
+    FIELD(RP2040_VREG_CHIP_RESET, HAD_RUN, 16, 1)
+    FIELD(RP2040_VREG_CHIP_RESET, HAD_POR, 8, 1)
+
+#define RP2040_VREG_VREG_RESET 0x000000b1
+#define RP2040_VREG_BOD_RESET  0x00000091
+
+struct RP2040VregState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t vreg;
+    uint32_t bod;
+    uint32_t chip_reset;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index dbd2e4f4a7..4e8b753536 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -253,8 +253,6 @@ qtests_exynos4210 = \
   ['exynos4210_uart_fifo-test']
 
 qtests_arm = \
-  (config_all_devices.has_key('CONFIG_RP2040') ?
-   ['rp2040-syscfg-test', 'rp2040-sysinfo-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
@@ -267,6 +265,10 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RP2040') ?
+   ['rp2040-syscfg-test',
+    'rp2040-sysinfo-test',
+    'rp2040-vreg-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-vreg-test.c b/tests/qtest/rp2040-vreg-test.c
new file mode 100644
index 0000000000..cb47d7d527
--- /dev/null
+++ b/tests/qtest/rp2040-vreg-test.c
@@ -0,0 +1,79 @@
+/*
+ * QTest testcase for the RP2040 vreg_and_chip_reset block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040.h"
+#include "hw/misc/rp2040_vreg.h"
+#include "libqtest.h"
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_vreg_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_VREG), ==,
+                    RP2040_VREG_VREG_RESET |
+                    R_RP2040_VREG_VREG_ROK_MASK);
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_BOD), ==,
+                    RP2040_VREG_BOD_RESET);
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_CHIP_RESET), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, RP2040_VREG_BASE + A_RP2040_VREG_VREG, 0xffffffff);
+    qtest_writel(qts, RP2040_VREG_BASE + A_RP2040_VREG_BOD, 0xffffffff);
+    qtest_writel(qts, RP2040_VREG_BASE + A_RP2040_VREG_CHIP_RESET,
+                 0xffffffff);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_VREG), ==, 0x000000f3);
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_BOD), ==, 0x000000f1);
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_CHIP_RESET), ==,
+                    R_RP2040_VREG_CHIP_RESET_PSM_RESTART_FLAG_MASK);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, RP2040_VREG_BASE + A_RP2040_VREG_BOD, 0);
+    qtest_writel(qts, RP2040_VREG_BASE + RP2040_ATOMIC_SET +
+                 A_RP2040_VREG_BOD, 0x00000011);
+    qtest_writel(qts, RP2040_VREG_BASE + RP2040_ATOMIC_CLR +
+                 A_RP2040_VREG_BOD, 0x00000010);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_VREG_BASE + A_RP2040_VREG_BOD), ==, 0x00000001);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-vreg/reset-values", test_vreg_reset_values);
+    qtest_add_func("/rp2040-vreg/rw-masks", test_vreg_rw_masks);
+    qtest_add_func("/rp2040-vreg/atomic-aliases", test_vreg_atomic_aliases);
+
+    return g_test_run();
+}
-- 
2.55.0


