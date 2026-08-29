Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B3C61DE5
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiU-00087D-2k; Sat, 29 Aug 2026 19:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiT-00086u-44; Sat, 29 Aug 2026 19:44:05 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiQ-0006EL-9u; Sat, 29 Aug 2026 19:44:04 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXWzc5mwFz837k;
 Sun, 30 Aug 2026 01:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047020;
 bh=Lbwd6FIBHGDSpDurf65+aYtzdyAu4MeoLmODMhgCQMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IJi1AG50TRbMc15RdmzFo2ZUbvfL0UCZQ3vdtLM70bK/zmV5JVGui1njYWs5gQ/wv
 SLjj1Yl2AYoGnKXx2n4+11USxK3wQYNhiXHthWJJw9/A1BRJxHET99dxw3zR7w4D9Q
 sRhh+zCLx5jmBny988nzORyE3/vUscByu/kKwZ0h2KMa3RU5xJZkMFe7oG9Cc816xY
 9QAl6muA67Sgli1vn+iIuaswQRZBsIi4FSkBzABLMp5hP9ZyrimNfFKvxXmJmKKqIB
 ZZAdOLCMAcGRZlZMe5H8KpbIZ4BjC+aCY+lmxKnwYG4ultiDkY4jca6FNhvIbsEfNs
 yPA04fhUJFAOA==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzc3bMNz7vrV;
 Sun, 30 Aug 2026 01:43:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 07/30] hw/misc: add RP2040 TBMAN and voltage regulator
Date: Sun, 30 Aug 2026 01:42:41 +0200
Message-ID: <20260829234308.33725-8-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
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

Replace the TBMAN and VREG/chip-reset placeholders with the RP2040 register models from the development tree. Expose the ASIC platform indication, documented reset values, write masks, regulator status, and APB atomic aliases.\n\nAdd focused qtests for both blocks.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                  |   2 +
 hw/arm/rp2040.c                 |  14 ++-
 hw/misc/Kconfig                 |   6 ++
 hw/misc/meson.build             |   2 +
 hw/misc/rp2040_tbman.c          |  92 +++++++++++++++++
 hw/misc/rp2040_vreg.c           | 178 ++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h         |   4 +
 include/hw/misc/rp2040_tbman.h  |  25 +++++
 include/hw/misc/rp2040_vreg.h   |  28 +++++
 tests/qtest/meson.build         |   4 +-
 tests/qtest/rp2040-tbman-test.c |  32 ++++++
 tests/qtest/rp2040-vreg-test.c  |  79 ++++++++++++++
 12 files changed, 463 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/rp2040_tbman.c
 create mode 100644 hw/misc/rp2040_vreg.c
 create mode 100644 include/hw/misc/rp2040_tbman.h
 create mode 100644 include/hw/misc/rp2040_vreg.h
 create mode 100644 tests/qtest/rp2040-tbman-test.c
 create mode 100644 tests/qtest/rp2040-vreg-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5d55ca06fd..89c479ab6d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -381,6 +381,8 @@ config RP2040
     select RP2040_NYI
     select RP2040_SYSCFG
     select RP2040_SYSINFO
+    select RP2040_TBMAN
+    select RP2040_VREG
     select UNIMP
 
 config STM32F100_SOC
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index a184d527e1..f2a6613aa3 100644
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
@@ -179,6 +177,8 @@ static void rp2040_soc_init(Object *obj)
 
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+    object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
+    object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
     s->sysclk = clock_new(obj, "sysclk");
@@ -325,6 +325,16 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
     rp2040_syscfg_update(s);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->tbman), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->tbman), 0, RP2040_TBMAN_BASE);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vreg), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
+
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index f6f344ab51..597559186f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -110,6 +110,12 @@ config RP2040_SYSCFG
 config RP2040_SYSINFO
     bool
 
+config RP2040_TBMAN
+    bool
+
+config RP2040_VREG
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7be9f45c78..9191b16360 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -101,6 +101,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
+system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.c'))
+system_ss.add(when: 'CONFIG_RP2040_VREG', if_true: files('rp2040_vreg.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_tbman.c b/hw/misc/rp2040_tbman.c
new file mode 100644
index 0000000000..a60dd83848
--- /dev/null
+++ b/hw/misc/rp2040_tbman.c
@@ -0,0 +1,92 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_tbman.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+#define TBMAN_PLATFORM      0x00
+#define TBMAN_PLATFORM_ASIC BIT(0)
+
+static uint64_t rp2040_tbman_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case TBMAN_PLATFORM:
+        value = TBMAN_PLATFORM_ASIC;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("tbman", size,
+                                      RP2040_TBMAN_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_tbman_write(void *opaque, hwaddr addr,
+                               uint64_t value64, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+
+    rp2040_log_unimplemented_write("tbman", size, RP2040_TBMAN_BASE + addr,
+                                   offset, value64);
+}
+
+static const MemoryRegionOps rp2040_tbman_ops = {
+    .read = rp2040_tbman_read,
+    .write = rp2040_tbman_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_tbman_init(Object *obj)
+{
+    RP2040TbmanState *s = RP2040_TBMAN(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_tbman_ops, s,
+                          "rp2040.tbman", RP2040_TBMAN_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_tbman_vmstate = {
+    .name = TYPE_RP2040_TBMAN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_tbman_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &rp2040_tbman_vmstate;
+}
+
+static const TypeInfo rp2040_tbman_info = {
+    .name          = TYPE_RP2040_TBMAN,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040TbmanState),
+    .instance_init = rp2040_tbman_init,
+    .class_init    = rp2040_tbman_class_init,
+};
+
+static void rp2040_tbman_register_types(void)
+{
+    type_register_static(&rp2040_tbman_info);
+}
+type_init(rp2040_tbman_register_types)
diff --git a/hw/misc/rp2040_vreg.c b/hw/misc/rp2040_vreg.c
new file mode 100644
index 0000000000..e8480fc258
--- /dev/null
+++ b/hw/misc/rp2040_vreg.c
@@ -0,0 +1,178 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_vreg.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+#define VREG_VREG          0x00
+#define VREG_BOD           0x04
+#define VREG_CHIP_RESET    0x08
+
+#define VREG_ROK           BIT(12)
+#define VREG_VSEL_MASK     0x000000f0
+#define VREG_HIZ           BIT(1)
+#define VREG_EN            BIT(0)
+#define VREG_RW_MASK       (VREG_VSEL_MASK | VREG_HIZ | VREG_EN)
+#define VREG_RESET         0x000000b1
+
+#define BOD_VSEL_MASK      0x000000f0
+#define BOD_EN             BIT(0)
+#define BOD_RW_MASK        (BOD_VSEL_MASK | BOD_EN)
+#define BOD_RESET          0x00000091
+
+#define CHIP_RESET_RW_MASK 0x01000000
+
+#define ATOMIC_ALIAS_MASK  0x3000
+#define ATOMIC_XOR         0x1000
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static uint32_t rp2040_vreg_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
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
+static uint32_t rp2040_vreg_read_vreg(RP2040VregState *s)
+{
+    uint32_t value = s->vreg;
+
+    if ((value & VREG_EN) && !(value & VREG_HIZ)) {
+        value |= VREG_ROK;
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
+    case VREG_VREG:
+        value = rp2040_vreg_read_vreg(s);
+        break;
+    case VREG_BOD:
+        value = s->bod;
+        break;
+    case VREG_CHIP_RESET:
+        value = s->chip_reset;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("vreg_and_chip_reset", size,
+                                      RP2040_VREG_BASE + addr, offset,
+                                      value);
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
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case VREG_VREG:
+        s->vreg = rp2040_vreg_apply_alias(s->vreg, value, alias) &
+                  VREG_RW_MASK;
+        break;
+    case VREG_BOD:
+        s->bod = rp2040_vreg_apply_alias(s->bod, value, alias) & BOD_RW_MASK;
+        break;
+    case VREG_CHIP_RESET:
+        s->chip_reset =
+            rp2040_vreg_apply_alias(s->chip_reset, value, alias) &
+            CHIP_RESET_RW_MASK;
+        break;
+    default:
+        rp2040_log_unimplemented_write("vreg_and_chip_reset", size,
+                                       RP2040_VREG_BASE + addr, offset,
+                                       value64);
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
+    s->vreg = VREG_RESET;
+    s->bod = BOD_RESET;
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
index caa1f9127f..86037dd0d7 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -15,6 +15,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_sysinfo.h"
+#include "hw/misc/rp2040_tbman.h"
+#include "hw/misc/rp2040_vreg.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -38,6 +40,8 @@ struct RP2040State {
     PL011State uart[2];
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
+    RP2040TbmanState tbman;
+    RP2040VregState vreg;
 
     MemoryRegion *board_memory;
     MemoryRegion rom;
diff --git a/include/hw/misc/rp2040_tbman.h b/include/hw/misc/rp2040_tbman.h
new file mode 100644
index 0000000000..50b55039ce
--- /dev/null
+++ b/include/hw/misc/rp2040_tbman.h
@@ -0,0 +1,25 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_TBMAN_H
+#define HW_MISC_RP2040_TBMAN_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_TBMAN "rp2040-tbman"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040TbmanState, RP2040_TBMAN)
+
+#define RP2040_TBMAN_BASE 0x4006c000
+#define RP2040_TBMAN_SIZE 0x4000
+
+struct RP2040TbmanState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_vreg.h b/include/hw/misc/rp2040_vreg.h
new file mode 100644
index 0000000000..9f1723b7d5
--- /dev/null
+++ b/include/hw/misc/rp2040_vreg.h
@@ -0,0 +1,28 @@
+/*
+ * RP2040 voltage regulator and chip reset emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_VREG_H
+#define HW_MISC_RP2040_VREG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_VREG "rp2040-vreg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040VregState, RP2040_VREG)
+
+#define RP2040_VREG_BASE 0x40064000
+#define RP2040_VREG_SIZE 0x4000
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
index 692d51a78a..8916f68bad 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -255,7 +255,9 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
+                                                       'rp2040-tbman-test',
+                                                       'rp2040-vreg-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-tbman-test.c b/tests/qtest/rp2040-tbman-test.c
new file mode 100644
index 0000000000..a05eb3c3e2
--- /dev/null
+++ b/tests/qtest/rp2040-tbman-test.c
@@ -0,0 +1,32 @@
+/*
+ * QTest testcase for the RP2040 testbench manager block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define TBMAN_BASE          0x4006c000
+#define TBMAN_PLATFORM      0x00
+#define TBMAN_PLATFORM_ASIC BIT(0)
+
+static void test_tbman_platform(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico");
+
+    g_assert_cmphex(qtest_readl(qts, TBMAN_BASE + TBMAN_PLATFORM), ==,
+                    TBMAN_PLATFORM_ASIC);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-tbman/platform", test_tbman_platform);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-vreg-test.c b/tests/qtest/rp2040-vreg-test.c
new file mode 100644
index 0000000000..b08bb16765
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
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define VREG_BASE           0x40064000
+#define VREG_VREG           0x00
+#define VREG_BOD            0x04
+#define VREG_CHIP_RESET     0x08
+
+#define VREG_ROK            BIT(12)
+#define VREG_RESET          0x000000b1
+#define BOD_RESET           0x00000091
+#define CHIP_RESET_RESCUE   BIT(24)
+
+#define ATOMIC_SET_ALIAS    0x2000
+#define ATOMIC_CLR_ALIAS    0x3000
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
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_VREG), ==,
+                    VREG_RESET | VREG_ROK);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, BOD_RESET);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_CHIP_RESET), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, VREG_BASE + VREG_VREG, 0xffffffff);
+    qtest_writel(qts, VREG_BASE + VREG_BOD, 0xffffffff);
+    qtest_writel(qts, VREG_BASE + VREG_CHIP_RESET, 0xffffffff);
+
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_VREG), ==, 0x000000f3);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, 0x000000f1);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_CHIP_RESET), ==,
+                    CHIP_RESET_RESCUE);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, VREG_BASE + VREG_BOD, 0);
+    qtest_writel(qts, VREG_BASE + ATOMIC_SET_ALIAS + VREG_BOD, 0x00000011);
+    qtest_writel(qts, VREG_BASE + ATOMIC_CLR_ALIAS + VREG_BOD, 0x00000010);
+
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, 0x00000001);
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


