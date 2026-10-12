Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603FBCA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNQ-0000WT-L5; Mon, 12 Oct 2026 12:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMc-00081H-6K; Mon, 12 Oct 2026 12:59:12 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMY-0006De-44; Mon, 12 Oct 2026 12:59:00 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw321G1zBqmn;
 Mon, 12 Oct 2026 18:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824323;
 bh=4nMCyH95a9yeNXw/h8rLUbU/Orduycph7hf1HolxLDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oZHqxF/QUN2qenYpga0YmUWnkEJUlzRGQfcJvCwQKfL2Fuh5nvj2d2Fxo4zrkcDoC
 MhAnOQKhCAfijU4tWgWVITrFltKErTphMf6EYE8RwhbTDG6WSH5ueClKMwo/Kxffs6
 al+9s5M0D1p7HqPnmrPPMPCpKLPQtR15/9JDfZiLcWF5UlM/Dkmvx8lfc6F0ovwblH
 dk33gLJr6gIL9IKeZu8Pbh2UMj0n0mxE9sqeeDE0AcMDlRaEYJ10yRmXbXOV9042Rq
 c5eRQw0WhWr/v0BszHLWaeBfmiG9PJtyxu36AQdfmzMxshjQCb+0Cy2BkFg/c+OXiV
 XZzU7qGhWBpTA==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw22zzsz83nY;
 Mon, 12 Oct 2026 18:58:42 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 7/9] hw/misc: add RP2040 SYSCFG
Date: Mon, 12 Oct 2026 18:58:37 +0200
Message-ID: <20261012165840.99050-8-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 system configuration registers, documented reset and write
masks, and APB atomic aliases.

Route each peripheral interrupt to the normal IRQ input or NMI input of each
Cortex-M0+ according to PROC0_NMI_MASK and PROC1_NMI_MASK. MEMPOWERDOWN
retains its documented register state without inventing behavior for
accesses to powered-down memory banks.

Add focused qtests for reset values, write masks, and atomic aliases.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                  |  57 +++++++-
 hw/misc/meson.build              |   1 +
 hw/misc/rp2040_syscfg.c          | 220 +++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h          |   7 +
 include/hw/misc/rp2040_syscfg.h  |  41 ++++++
 tests/qtest/meson.build          |   2 +-
 tests/qtest/rp2040-syscfg-test.c |  97 ++++++++++++++
 7 files changed, 421 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/rp2040_syscfg.c
 create mode 100644 include/hw/misc/rp2040_syscfg.h
 create mode 100644 tests/qtest/rp2040-syscfg-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 55554f72e9..47a0ef220f 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -13,6 +13,7 @@
 #include "hw/core/loader.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/irq.h"
 #include "hw/misc/unimp.h"
 #include "qemu/datadir.h"
 #include "target/arm/cpu-qom.h"
@@ -49,7 +50,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.syscfg",   0x40004000, 0x4000 },
     { "rp2040.clocks",   0x40008000, 0x4000 },
     { "rp2040.resets",   0x4000c000, 0x4000 },
     { "rp2040.psm",      0x40010000, 0x4000 },
@@ -83,6 +83,40 @@ static const struct {
     { "rp2040.sio",      0xd0000000, 0x1000 },
 };
 
+static void rp2040_update_nmi(RP2040State *s)
+{
+    unsigned core;
+
+    for (core = 0; core < RP2040_NUM_CORES; core++) {
+        uint32_t nmi_mask = rp2040_syscfg_get_nmi_mask(&s->syscfg, core);
+        bool nmi_level = false;
+        int irq;
+
+        for (irq = 0; irq < RP2040_NUM_IRQS; irq++) {
+            bool route_to_nmi = nmi_mask & BIT(irq);
+
+            qemu_set_irq(s->cpu_irq[core][irq],
+                         s->irq_level[irq] && !route_to_nmi);
+            nmi_level |= s->irq_level[irq] && route_to_nmi;
+        }
+        qemu_set_irq(s->nmi_irq[core], nmi_level);
+    }
+}
+
+static void rp2040_syscfg_update(void *opaque)
+{
+    rp2040_update_nmi(opaque);
+}
+
+static void rp2040_set_irq(void *opaque, int irq, int level)
+{
+    RP2040State *s = opaque;
+
+    assert(irq >= 0 && irq < RP2040_NUM_IRQS);
+    s->irq_level[irq] = level;
+    rp2040_update_nmi(s);
+}
+
 static void rp2040_soc_init(Object *obj)
 {
     RP2040State *s = RP2040(obj);
@@ -109,8 +143,11 @@ static void rp2040_soc_init(Object *obj)
                                   "chardev");
     }
 
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
 
+    s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
+
     s->sysclk = clock_new(obj, "sysclk");
     clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
 }
@@ -221,8 +258,21 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m[i]), errp)) {
             return;
         }
+
+        for (int irq = 0; irq < RP2040_NUM_IRQS; irq++) {
+            s->cpu_irq[i][irq] =
+                qdev_get_gpio_in(DEVICE(&s->armv7m[i]), irq);
+        }
+        s->nmi_irq[i] = qdev_get_gpio_in_named(DEVICE(&s->armv7m[i]),
+                                               "NMI", 0);
     }
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscfg), 0, RP2040_SYSCFG_BASE);
+    rp2040_syscfg_set_update_callback(&s->syscfg, rp2040_syscfg_update, s);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
         return;
     }
@@ -235,9 +285,10 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_base[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->armv7m[0]),
-                                            uart_irq[i]));
+                           s->irq[uart_irq[i]]);
     }
+
+    rp2040_update_nmi(s);
 }
 
 static const Property rp2040_soc_properties[] = {
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ca9b951e3e..c26442fdcc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/rp2040_syscfg.c b/hw/misc/rp2040_syscfg.c
new file mode 100644
index 0000000000..9f907194ed
--- /dev/null
+++ b/hw/misc/rp2040_syscfg.c
@@ -0,0 +1,220 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040.h"
+#include "hw/misc/rp2040_syscfg.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SYSCFG_PROC0_NMI_MASK          0x00
+#define SYSCFG_PROC1_NMI_MASK          0x04
+#define SYSCFG_PROC_CONFIG             0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS     0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI  0x10
+#define SYSCFG_DBGFORCE                0x14
+#define SYSCFG_MEMPOWERDOWN            0x18
+
+#define PROC_CONFIG_RW_MASK            0xff000000
+#define PROC_CONFIG_RESET              0x10000000
+#define PROC_IN_SYNC_BYPASS_MASK       0x3fffffff
+#define PROC_IN_SYNC_BYPASS_HI_MASK    0x0000003f
+#define DBGFORCE_RW_MASK               0x000000ee
+#define DBGFORCE_RESET                 0x00000066
+#define MEMPOWERDOWN_MASK              0x000000ff
+
+static void rp2040_syscfg_update(RP2040SysCfgState *s)
+{
+    if (s->update) {
+        s->update(s->update_opaque);
+    }
+}
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque)
+{
+    s->update = update;
+    s->update_opaque = opaque;
+}
+
+uint32_t rp2040_syscfg_get_nmi_mask(RP2040SysCfgState *s, unsigned core)
+{
+    assert(core < 2);
+    return core ? s->proc1_nmi_mask : s->proc0_nmi_mask;
+}
+
+static uint64_t rp2040_syscfg_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        value = s->proc0_nmi_mask;
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        value = s->proc1_nmi_mask;
+        break;
+    case SYSCFG_PROC_CONFIG:
+        value = s->proc_config;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        value = s->proc_in_sync_bypass;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        value = s->proc_in_sync_bypass_hi;
+        break;
+    case SYSCFG_DBGFORCE:
+        value = s->dbgforce;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        value = s->mempowerdown;
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
+static void rp2040_syscfg_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040SysCfgState *s = opaque;
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case SYSCFG_PROC0_NMI_MASK:
+        s->proc0_nmi_mask =
+            rp2040_atomic_update(s->proc0_nmi_mask, value, alias);
+        rp2040_syscfg_update(s);
+        break;
+    case SYSCFG_PROC1_NMI_MASK:
+        s->proc1_nmi_mask =
+            rp2040_atomic_update(s->proc1_nmi_mask, value, alias);
+        rp2040_syscfg_update(s);
+        break;
+    case SYSCFG_PROC_CONFIG:
+        s->proc_config =
+            rp2040_atomic_update(s->proc_config, value, alias) &
+            PROC_CONFIG_RW_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS:
+        s->proc_in_sync_bypass =
+            rp2040_atomic_update(s->proc_in_sync_bypass, value, alias) &
+            PROC_IN_SYNC_BYPASS_MASK;
+        break;
+    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
+        s->proc_in_sync_bypass_hi =
+            rp2040_atomic_update(s->proc_in_sync_bypass_hi, value, alias) &
+            PROC_IN_SYNC_BYPASS_HI_MASK;
+        break;
+    case SYSCFG_DBGFORCE:
+        s->dbgforce =
+            rp2040_atomic_update(s->dbgforce, value, alias) &
+            DBGFORCE_RW_MASK;
+        break;
+    case SYSCFG_MEMPOWERDOWN:
+        s->mempowerdown =
+            rp2040_atomic_update(s->mempowerdown, value, alias) &
+            MEMPOWERDOWN_MASK;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_syscfg_ops = {
+    .read = rp2040_syscfg_read,
+    .write = rp2040_syscfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_syscfg_reset(DeviceState *dev)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(dev);
+
+    s->proc0_nmi_mask = 0;
+    s->proc1_nmi_mask = 0;
+    s->proc_config = PROC_CONFIG_RESET;
+    s->proc_in_sync_bypass = 0;
+    s->proc_in_sync_bypass_hi = 0;
+    s->dbgforce = DBGFORCE_RESET;
+    s->mempowerdown = 0;
+    rp2040_syscfg_update(s);
+}
+
+static int rp2040_syscfg_post_load(void *opaque, int version_id)
+{
+    RP2040SysCfgState *s = opaque;
+
+    rp2040_syscfg_update(s);
+    return 0;
+}
+
+static void rp2040_syscfg_init(Object *obj)
+{
+    RP2040SysCfgState *s = RP2040_SYSCFG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_syscfg_ops, s,
+                          "rp2040.syscfg", RP2040_SYSCFG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_syscfg_vmstate = {
+    .name = TYPE_RP2040_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = rp2040_syscfg_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(proc0_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc1_nmi_mask, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_config, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass, RP2040SysCfgState),
+        VMSTATE_UINT32(proc_in_sync_bypass_hi, RP2040SysCfgState),
+        VMSTATE_UINT32(dbgforce, RP2040SysCfgState),
+        VMSTATE_UINT32(mempowerdown, RP2040SysCfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_syscfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_syscfg_reset);
+    dc->vmsd = &rp2040_syscfg_vmstate;
+}
+
+static const TypeInfo rp2040_syscfg_info = {
+    .name          = TYPE_RP2040_SYSCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysCfgState),
+    .instance_init = rp2040_syscfg_init,
+    .class_init    = rp2040_syscfg_class_init,
+};
+
+static void rp2040_syscfg_register_types(void)
+{
+    type_register_static(&rp2040_syscfg_info);
+}
+type_init(rp2040_syscfg_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 7e7d8f5c95..f6050f255d 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -14,6 +14,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_sysinfo.h"
+#include "hw/misc/rp2040_syscfg.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -36,6 +37,7 @@ struct RP2040State {
 
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
+    RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
 
     MemoryRegion *board_memory;
@@ -45,6 +47,11 @@ struct RP2040State {
     MemoryRegion sram[6];
     char *bootrom_file;
 
+    qemu_irq *irq;
+    qemu_irq cpu_irq[RP2040_NUM_CORES][RP2040_NUM_IRQS];
+    qemu_irq nmi_irq[RP2040_NUM_CORES];
+    bool irq_level[RP2040_NUM_IRQS];
+
     Clock *sysclk;
 };
 
diff --git a/include/hw/misc/rp2040_syscfg.h b/include/hw/misc/rp2040_syscfg.h
new file mode 100644
index 0000000000..0e02e4ad81
--- /dev/null
+++ b/include/hw/misc/rp2040_syscfg.h
@@ -0,0 +1,41 @@
+/*
+ * RP2040 syscfg emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSCFG_H
+#define HW_MISC_RP2040_SYSCFG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSCFG "rp2040-syscfg"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysCfgState, RP2040_SYSCFG)
+
+#define RP2040_SYSCFG_BASE 0x40004000
+#define RP2040_SYSCFG_SIZE 0x4000
+
+typedef void (*RP2040SysCfgUpdateFn)(void *opaque);
+
+struct RP2040SysCfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    RP2040SysCfgUpdateFn update;
+    void *update_opaque;
+    uint32_t proc0_nmi_mask;
+    uint32_t proc1_nmi_mask;
+    uint32_t proc_config;
+    uint32_t proc_in_sync_bypass;
+    uint32_t proc_in_sync_bypass_hi;
+    uint32_t dbgforce;
+    uint32_t mempowerdown;
+};
+
+void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
+                                       RP2040SysCfgUpdateFn update,
+                                       void *opaque);
+uint32_t rp2040_syscfg_get_nmi_mask(RP2040SysCfgState *s, unsigned core);
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8079fcee28..dbd2e4f4a7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -254,7 +254,7 @@ qtests_exynos4210 = \
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_RP2040') ?
-   ['rp2040-sysinfo-test'] : []) + \
+   ['rp2040-syscfg-test', 'rp2040-sysinfo-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
diff --git a/tests/qtest/rp2040-syscfg-test.c b/tests/qtest/rp2040-syscfg-test.c
new file mode 100644
index 0000000000..b1a0738bd2
--- /dev/null
+++ b/tests/qtest/rp2040-syscfg-test.c
@@ -0,0 +1,97 @@
+/*
+ * QTest testcase for the RP2040 SYSCFG block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/rp2040.h"
+#include "qemu/bitops.h"
+
+#define SYSCFG_BASE                   0x40004000
+#define SYSCFG_PROC0_NMI_MASK         0x00
+#define SYSCFG_PROC1_NMI_MASK         0x04
+#define SYSCFG_PROC_CONFIG            0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS    0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI 0x10
+#define SYSCFG_DBGFORCE               0x14
+#define SYSCFG_MEMPOWERDOWN           0x18
+
+#define PROC_CONFIG_RESET             0x10000000
+#define DBGFORCE_RESET                0x00000066
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_syscfg_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC_CONFIG), ==,
+                    PROC_CONFIG_RESET);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_DBGFORCE), ==,
+                    DBGFORCE_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0xa5a5a5a5);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK, 0x5a5a5a5a);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0x5a5a5a5a);
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS, 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI,
+                 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS),
+                    ==, 0x3fffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI),
+                    ==, 0x0000003f);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN), ==,
+                    0x000000ff);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0);
+    qtest_writel(qts, SYSCFG_BASE + RP2040_ATOMIC_SET +
+                 SYSCFG_PROC0_NMI_MASK, 0x0000000f);
+    qtest_writel(qts, SYSCFG_BASE + RP2040_ATOMIC_CLR +
+                 SYSCFG_PROC0_NMI_MASK, 0x00000003);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0x0000000c);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-syscfg/reset-values", test_syscfg_reset_values);
+    qtest_add_func("/rp2040-syscfg/rw-masks", test_syscfg_rw_masks);
+    qtest_add_func("/rp2040-syscfg/atomic-aliases",
+                   test_syscfg_atomic_aliases);
+
+    return g_test_run();
+}
-- 
2.55.0


