Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA30EC61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yro-0002vm-2p; Sun, 30 Aug 2026 02:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrm-0002sB-Lp; Sun, 30 Aug 2026 02:18:06 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrk-0005KE-1B; Sun, 30 Aug 2026 02:18:06 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXhjp6N3Nz8340;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070638;
 bh=cFM2jfrPyndQJ8QXbCLiQuVny0z7mWKjr5OK4mBueLU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dCIJKpd8itCacyAw/R+SbIBrjKo73Bj7W145RvhxTZSBoKzOanXqyHZ6iOy3C8PzS
 bs5224WdcY48RGmbA2EKjpuDIELSolZpx4WMrKGo2MJJfaiDs7OqKTVVmGpvhyh/iA
 mISVKgtOa+6SrxoKh+EcsN5dDzRsbKVqYUtT/yvuaOL3xnu9HAds1L1zWXzrIugVxn
 Z2nLF+yfqi18FMvNMpg3ZrRB8M5w8kiKFjdXgsJ0ND2L+OMGkLdRHtkNkXT9/3rnQe
 g0/ECvVrpfgx9ug+V0ivB2rRxWIjglzYbUP5k3Potz582FkJjlIVAWLUiye3zQNIYQ
 LbxuRHLIa43RQ==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjp4yKCz7swM;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 25/30] hw/misc: add RP2040 bus controller
Date: Sun, 30 Aug 2026 08:15:56 +0200
Message-ID: <20260830061601.52136-11-gilles.grimaud@univ-lille.fr>
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                    |   1 +
 hw/arm/rp2040.c                   |   8 +-
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 hw/misc/rp2040_busctrl.c          | 208 ++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h           |   2 +
 include/hw/misc/rp2040_busctrl.h  |  29 +++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/rp2040-busctrl-test.c |  92 +++++++++++++
 9 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_busctrl.c
 create mode 100644 include/hw/misc/rp2040_busctrl.h
 create mode 100644 tests/qtest/rp2040-busctrl-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 30965e9ede..517e39d81b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -378,6 +378,7 @@ config RP2040
     bool
     select ARM_V7M
     select PL011
+    select RP2040_BUSCTRL
     select RP2040_CLOCKS
     select RP2040_DMA
     select RP2040_IOBANK0
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index e7ba55bd1f..ca27b3c8ef 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -142,7 +142,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.busctrl",  0x40030000, 0x4000 },
     { "rp2040.spi0",     0x4003c000, 0x4000 },
     { "rp2040.spi1",     0x40040000, 0x4000 },
     { "rp2040.i2c0",     0x40044000, 0x4000 },
@@ -368,6 +367,8 @@ static void rp2040_soc_init(Object *obj)
     }
 
     object_initialize_child(obj, "xip", &s->xip, TYPE_RP2040_XIP);
+    object_initialize_child(obj, "busctrl", &s->busctrl,
+                            TYPE_RP2040_BUSCTRL);
 
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
     object_initialize_child(obj, "dma", &s->dma, TYPE_RP2040_DMA);
@@ -531,6 +532,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
                                 RP2040_XIP_NOCACHE_NOALLOC_BASE,
                                 &s->xip.xip_nocache_noalloc);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->busctrl), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->busctrl), 0, RP2040_BUSCTRL_BASE);
+
     object_property_set_link(OBJECT(&s->dma), "memory",
                              OBJECT(s->board_memory), &err);
     if (err) {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d98b8a4674..228b313da0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config RP2040_BUSCTRL
+    bool
+
 config RP2040_CLOCKS
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ba2e9489ee..96b5fb9c46 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040_BUSCTRL', if_true: files('rp2040_busctrl.c'))
 system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
 system_ss.add(when: 'CONFIG_RP2040_IOBANK0', if_true: files('rp2040_iobank0.c'))
 system_ss.add(when: 'CONFIG_RP2040_IOQSPI', if_true: files('rp2040_ioqspi.c'))
diff --git a/hw/misc/rp2040_busctrl.c b/hw/misc/rp2040_busctrl.c
new file mode 100644
index 0000000000..505047609c
--- /dev/null
+++ b/hw/misc/rp2040_busctrl.c
@@ -0,0 +1,208 @@
+/*
+ * RP2040 bus fabric control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_busctrl.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+
+#define BUSCTRL_PRIORITY        0x00
+#define BUSCTRL_PRIORITY_ACK    0x04
+#define BUSCTRL_PERFCTR_BASE    0x08
+#define BUSCTRL_PERFSEL_BASE    0x0c
+#define BUSCTRL_PERF_STRIDE     0x08
+#define BUSCTRL_NUM_COUNTERS    4
+
+#define BUSCTRL_PRIORITY_MASK   0x00001111
+#define BUSCTRL_PRIORITY_ACKED  BIT(0)
+#define BUSCTRL_PERFCTR_MASK    0x00ffffff
+#define BUSCTRL_PERFSEL_RESET   0x1f
+#define BUSCTRL_PERFSEL_MASK    0x1f
+
+#define ATOMIC_ALIAS_MASK       0x3000
+#define ATOMIC_XOR              0x1000
+#define ATOMIC_SET              0x2000
+#define ATOMIC_CLR              0x3000
+
+static uint32_t rp2040_busctrl_apply_alias(uint32_t old, uint32_t value,
+                                           hwaddr alias)
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
+static uint32_t rp2040_busctrl_read_counter(RP2040BusCtrlState *s,
+                                            unsigned index)
+{
+    if (s->perfsel[index] != BUSCTRL_PERFSEL_RESET &&
+        s->perfctr[index] != BUSCTRL_PERFCTR_MASK) {
+        s->perfctr[index]++;
+    }
+
+    return s->perfctr[index];
+}
+
+static uint64_t rp2040_busctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040BusCtrlState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    if (offset >= BUSCTRL_PERFCTR_BASE &&
+        offset < BUSCTRL_PERFCTR_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFCTR_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFCTR_BASE) / BUSCTRL_PERF_STRIDE;
+        return rp2040_busctrl_read_counter(s, index);
+    }
+
+    if (offset >= BUSCTRL_PERFSEL_BASE &&
+        offset < BUSCTRL_PERFSEL_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFSEL_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFSEL_BASE) / BUSCTRL_PERF_STRIDE;
+        return s->perfsel[index];
+    }
+
+    switch (offset) {
+    case BUSCTRL_PRIORITY:
+        value = s->priority;
+        break;
+    case BUSCTRL_PRIORITY_ACK:
+        value = BUSCTRL_PRIORITY_ACKED;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("busctrl", size,
+                                      RP2040_BUSCTRL_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_busctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t value64, unsigned size)
+{
+    RP2040BusCtrlState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    if (offset >= BUSCTRL_PERFCTR_BASE &&
+        offset < BUSCTRL_PERFCTR_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFCTR_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFCTR_BASE) / BUSCTRL_PERF_STRIDE;
+        s->perfctr[index] =
+            rp2040_busctrl_apply_alias(s->perfctr[index], value, alias) &
+            BUSCTRL_PERFCTR_MASK;
+        return;
+    }
+
+    if (offset >= BUSCTRL_PERFSEL_BASE &&
+        offset < BUSCTRL_PERFSEL_BASE + BUSCTRL_NUM_COUNTERS *
+        BUSCTRL_PERF_STRIDE &&
+        (offset - BUSCTRL_PERFSEL_BASE) % BUSCTRL_PERF_STRIDE == 0) {
+        index = (offset - BUSCTRL_PERFSEL_BASE) / BUSCTRL_PERF_STRIDE;
+        s->perfsel[index] =
+            rp2040_busctrl_apply_alias(s->perfsel[index], value, alias) &
+            BUSCTRL_PERFSEL_MASK;
+        return;
+    }
+
+    switch (offset) {
+    case BUSCTRL_PRIORITY:
+        s->priority = rp2040_busctrl_apply_alias(s->priority, value, alias) &
+                      BUSCTRL_PRIORITY_MASK;
+        break;
+    case BUSCTRL_PRIORITY_ACK:
+        break;
+    default:
+        rp2040_log_unimplemented_write("busctrl", size,
+                                       RP2040_BUSCTRL_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_busctrl_ops = {
+    .read = rp2040_busctrl_read,
+    .write = rp2040_busctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_busctrl_reset(DeviceState *dev)
+{
+    RP2040BusCtrlState *s = RP2040_BUSCTRL(dev);
+    int i;
+
+    s->priority = 0;
+    for (i = 0; i < BUSCTRL_NUM_COUNTERS; i++) {
+        s->perfctr[i] = 0;
+        s->perfsel[i] = BUSCTRL_PERFSEL_RESET;
+    }
+}
+
+static void rp2040_busctrl_init(Object *obj)
+{
+    RP2040BusCtrlState *s = RP2040_BUSCTRL(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_busctrl_ops, s,
+                          "rp2040.busctrl", RP2040_BUSCTRL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_busctrl_vmstate = {
+    .name = TYPE_RP2040_BUSCTRL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(priority, RP2040BusCtrlState),
+        VMSTATE_UINT32_ARRAY(perfctr, RP2040BusCtrlState, 4),
+        VMSTATE_UINT32_ARRAY(perfsel, RP2040BusCtrlState, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_busctrl_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_busctrl_reset);
+    dc->vmsd = &rp2040_busctrl_vmstate;
+}
+
+static const TypeInfo rp2040_busctrl_info = {
+    .name          = TYPE_RP2040_BUSCTRL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040BusCtrlState),
+    .instance_init = rp2040_busctrl_init,
+    .class_init    = rp2040_busctrl_class_init,
+};
+
+static void rp2040_busctrl_register_types(void)
+{
+    type_register_static(&rp2040_busctrl_info);
+}
+type_init(rp2040_busctrl_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index d52c8856b0..eeec45efbe 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -14,6 +14,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/dma/rp2040_dma.h"
+#include "hw/misc/rp2040_busctrl.h"
 #include "hw/misc/rp2040_clocks.h"
 #include "hw/misc/rp2040_iobank0.h"
 #include "hw/misc/rp2040_ioqspi.h"
@@ -56,6 +57,7 @@ struct RP2040State {
 
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
+    RP2040BusCtrlState busctrl;
     RP2040ClocksState clocks;
     RP2040DmaState dma;
     RP2040IoBank0State iobank0;
diff --git a/include/hw/misc/rp2040_busctrl.h b/include/hw/misc/rp2040_busctrl.h
new file mode 100644
index 0000000000..5c4a6d6d2b
--- /dev/null
+++ b/include/hw/misc/rp2040_busctrl.h
@@ -0,0 +1,29 @@
+/*
+ * RP2040 bus fabric control emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_BUSCTRL_H
+#define HW_MISC_RP2040_BUSCTRL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_BUSCTRL "rp2040-busctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040BusCtrlState, RP2040_BUSCTRL)
+
+#define RP2040_BUSCTRL_BASE 0x40030000
+#define RP2040_BUSCTRL_SIZE 0x4000
+
+struct RP2040BusCtrlState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t priority;
+    uint32_t perfctr[4];
+    uint32_t perfsel[4];
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 89e8f3ac32..c11f35e427 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -256,6 +256,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
+                                                       'rp2040-busctrl-test',
                                                        'rp2040-clocks-test',
                                                        'rp2040-dma-test',
                                                        'rp2040-iobank0-test',
diff --git a/tests/qtest/rp2040-busctrl-test.c b/tests/qtest/rp2040-busctrl-test.c
new file mode 100644
index 0000000000..a86fd8a20e
--- /dev/null
+++ b/tests/qtest/rp2040-busctrl-test.c
@@ -0,0 +1,92 @@
+/*
+ * QTest testcase for the RP2040 bus fabric control block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define BUSCTRL_BASE           0x40030000
+#define BUSCTRL_PRIORITY       0x00
+#define BUSCTRL_PRIORITY_ACK   0x04
+#define BUSCTRL_PERFCTR0       0x08
+#define BUSCTRL_PERFSEL0       0x0c
+#define BUSCTRL_PERFCTR1       0x10
+#define BUSCTRL_PERFSEL1       0x14
+#define BUSCTRL_PRIORITY_MASK  0x00001111
+#define BUSCTRL_PERFCTR_MASK   0x00ffffff
+#define BUSCTRL_PERFSEL_RESET  0x1f
+#define BUSCTRL_PERFSEL_SRAM5  0x05
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_busctrl_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY_ACK),
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0),
+                    ==, BUSCTRL_PERFSEL_RESET);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL1),
+                    ==, BUSCTRL_PERFSEL_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_busctrl_priority(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY),
+                    ==, BUSCTRL_PRIORITY_MASK);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY_ACK),
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_busctrl_perf_counter(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t first;
+    uint32_t second;
+
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0),
+                    ==, 0);
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0,
+                 BUSCTRL_PERFSEL_SRAM5);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0),
+                    ==, BUSCTRL_PERFSEL_SRAM5);
+
+    first = qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0);
+    second = qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0);
+    g_assert_cmphex(first, ==, 1);
+    g_assert_cmphex(second, ==, 2);
+
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0,
+                 BUSCTRL_PERFCTR_MASK);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0),
+                    ==, BUSCTRL_PERFCTR_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-busctrl/reset-values",
+                   test_busctrl_reset_values);
+    qtest_add_func("/rp2040-busctrl/priority", test_busctrl_priority);
+    qtest_add_func("/rp2040-busctrl/perf-counter",
+                   test_busctrl_perf_counter);
+
+    return g_test_run();
+}
-- 
2.55.0


