Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEB8C61DE5
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Sj1-0008LF-3G; Sat, 29 Aug 2026 19:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Siz-0008KS-C1; Sat, 29 Aug 2026 19:44:37 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Siw-0006Hy-Nz; Sat, 29 Aug 2026 19:44:37 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXWzg4CYgz838j;
 Sun, 30 Aug 2026 01:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047023;
 bh=+IncyZOzLuaGeKBlStDm8lonLD3YLbuaPl/r4eKXcEE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ck/6+XNnGunfQEx1+3rPfQH+csRPzoX2VOhSvs9ziz8e1VeLmPz76CvPbfsz4IMca
 Fb+WfAHIuPiqUyB1FAd5SUN/8irZltujAGiqOeHxjktrefgFd+fIWhFAkCa3cTf1bf
 q6p3YJZ6Bma8KOIc8VuVj3jZVTejMCy+bVuVMXn6GBYyzrE4hwvlBNnLGXd6ATxzqW
 yFT/xayMpGJ7jT9DsI/zjYaBBDIqPwcbHPC0uIsWXV9YAgo2kajMC9RxOa8jRTIq+y
 s+qqvwszYRcdf+YCpntp+SpqGvLQPz04UaMDTtei4Gv19BMCYwnoisRYNigBkD7t4h
 7vyXV/XXd/lEw==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzg21Kqz7tLT;
 Sun, 30 Aug 2026 01:43:43 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 14/30] hw/misc: add RP2040 IO_QSPI
Date: Sun, 30 Aug 2026 01:42:48 +0200
Message-ID: <20260829234308.33725-15-gilles.grimaud@univ-lille.fr>
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

Model the six QSPI GPIO control pairs and the PROC0, PROC1 and dormant-wake interrupt registers, including atomic aliases and documented masks. Wire the register block into the RP2040 SoC and add focused qtests for reset, atomic control updates and forced interrupt status. The QSPI chip-select connection is deferred to the XIP controller patch.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                   |   1 +
 hw/arm/rp2040.c                  |   8 +-
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/rp2040_ioqspi.c          | 263 +++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h          |   2 +
 include/hw/misc/rp2040_ioqspi.h  |  33 ++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/rp2040-ioqspi-test.c |  81 ++++++++++
 9 files changed, 392 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_ioqspi.c
 create mode 100644 include/hw/misc/rp2040_ioqspi.h
 create mode 100644 tests/qtest/rp2040-ioqspi-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e3d23e81c..a1b94532b4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -380,6 +380,7 @@ config RP2040
     select PL011
     select RP2040_CLOCKS
     select RP2040_IOBANK0
+    select RP2040_IOQSPI
     select RP2040_NYI
     select RP2040_PADS
     select RP2040_PLL
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 4cceec863e..28c17232a5 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -49,7 +49,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.ioqspi",   0x40018000, 0x4000 },
     { "rp2040.busctrl",  0x40030000, 0x4000 },
     { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
     { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
@@ -166,6 +165,8 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
     object_initialize_child(obj, "iobank0", &s->iobank0,
                             TYPE_RP2040_IOBANK0);
+    object_initialize_child(obj, "ioqspi", &s->ioqspi,
+                            TYPE_RP2040_IOQSPI);
     object_initialize_child(obj, "pads-bank0", &s->pads_bank0,
                             TYPE_RP2040_PADS_BANK0);
     object_initialize_child(obj, "pads-qspi", &s->pads_qspi,
@@ -376,6 +377,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 0,
                        s->irq[RP2040_IO_IRQ_BANK0]);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioqspi), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioqspi), 0, RP2040_IOQSPI_BASE);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rosc), errp)) {
         return;
     }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index daf513766c..553a92d4b6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -107,6 +107,9 @@ config RP2040_CLOCKS
 config RP2040_IOBANK0
     bool
 
+config RP2040_IOQSPI
+    bool
+
 config RP2040_NYI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e84cbd735f..5e4910e83d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
 system_ss.add(when: 'CONFIG_RP2040_IOBANK0', if_true: files('rp2040_iobank0.c'))
+system_ss.add(when: 'CONFIG_RP2040_IOQSPI', if_true: files('rp2040_ioqspi.c'))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
 system_ss.add(when: 'CONFIG_RP2040_PADS', if_true: files('rp2040_pads.c'))
 system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
diff --git a/hw/misc/rp2040_ioqspi.c b/hw/misc/rp2040_ioqspi.c
new file mode 100644
index 0000000000..eafd5e9eef
--- /dev/null
+++ b/hw/misc/rp2040_ioqspi.c
@@ -0,0 +1,263 @@
+/*
+ * RP2040 QSPI IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_ioqspi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define IOQSPI_INTR             0x30
+#define IOQSPI_PROC0_INTE       0x34
+#define IOQSPI_PROC0_INTF       0x38
+#define IOQSPI_PROC0_INTS       0x3c
+#define IOQSPI_PROC1_INTE       0x40
+#define IOQSPI_PROC1_INTF       0x44
+#define IOQSPI_PROC1_INTS       0x48
+#define IOQSPI_DORMANT_INTE     0x4c
+#define IOQSPI_DORMANT_INTF     0x50
+#define IOQSPI_DORMANT_INTS     0x54
+
+#define IOQSPI_CTRL_RESET       0x1f
+#define IOQSPI_CTRL_RW_MASK     0x33333f
+#define IOQSPI_INTR_EDGE_MASK   0x00cccccc
+#define IOQSPI_IRQ_MASK         0x00ffffff
+
+#define ATOMIC_ALIAS_MASK       0x3000
+#define ATOMIC_XOR              0x1000
+#define ATOMIC_SET              0x2000
+#define ATOMIC_CLR              0x3000
+
+static uint32_t rp2040_ioqspi_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
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
+static bool rp2040_ioqspi_ctrl_offset(hwaddr offset, unsigned *index)
+{
+    if (offset > 0x2c || (offset & 0x7) != 0x4) {
+        return false;
+    }
+
+    *index = offset / 8;
+    return *index < ARRAY_SIZE(((RP2040IoQspiState *)0)->ctrl);
+}
+
+static bool rp2040_ioqspi_status_offset(hwaddr offset)
+{
+    return offset <= 0x28 && (offset & 0x7) == 0;
+}
+
+static uint32_t rp2040_ioqspi_ints(uint32_t intr, uint32_t inte,
+                                   uint32_t intf)
+{
+    return (intr & inte) | intf;
+}
+
+static uint64_t rp2040_ioqspi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040IoQspiState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint64_t value;
+
+    if (rp2040_ioqspi_status_offset(offset)) {
+        value = 0;
+    } else if (rp2040_ioqspi_ctrl_offset(offset, &index)) {
+        value = s->ctrl[index];
+    } else {
+        switch (offset) {
+        case IOQSPI_INTR:
+            value = s->intr;
+            break;
+        case IOQSPI_PROC0_INTE:
+            value = s->proc0_inte;
+            break;
+        case IOQSPI_PROC0_INTF:
+            value = s->proc0_intf;
+            break;
+        case IOQSPI_PROC0_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->proc0_inte,
+                                       s->proc0_intf);
+            break;
+        case IOQSPI_PROC1_INTE:
+            value = s->proc1_inte;
+            break;
+        case IOQSPI_PROC1_INTF:
+            value = s->proc1_intf;
+            break;
+        case IOQSPI_PROC1_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->proc1_inte,
+                                       s->proc1_intf);
+            break;
+        case IOQSPI_DORMANT_INTE:
+            value = s->dormant_wake_inte;
+            break;
+        case IOQSPI_DORMANT_INTF:
+            value = s->dormant_wake_intf;
+            break;
+        case IOQSPI_DORMANT_INTS:
+            value = rp2040_ioqspi_ints(s->intr, s->dormant_wake_inte,
+                                       s->dormant_wake_intf);
+            break;
+        default:
+            value = 0;
+            rp2040_log_unimplemented_read("ioqspi", size,
+                                          RP2040_IOQSPI_BASE + addr, offset,
+                                          value);
+            break;
+        }
+    }
+
+    return value;
+}
+
+static void rp2040_ioqspi_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040IoQspiState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    if (rp2040_ioqspi_ctrl_offset(offset, &index)) {
+        s->ctrl[index] =
+            rp2040_ioqspi_apply_alias(s->ctrl[index], value, alias) &
+            IOQSPI_CTRL_RW_MASK;
+    } else {
+        switch (offset) {
+        case IOQSPI_INTR:
+            s->intr &= ~(value & IOQSPI_INTR_EDGE_MASK);
+            break;
+        case IOQSPI_PROC0_INTE:
+            s->proc0_inte =
+                rp2040_ioqspi_apply_alias(s->proc0_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC0_INTF:
+            s->proc0_intf =
+                rp2040_ioqspi_apply_alias(s->proc0_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTE:
+            s->proc1_inte =
+                rp2040_ioqspi_apply_alias(s->proc1_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTF:
+            s->proc1_intf =
+                rp2040_ioqspi_apply_alias(s->proc1_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTE:
+            s->dormant_wake_inte =
+                rp2040_ioqspi_apply_alias(s->dormant_wake_inte, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTF:
+            s->dormant_wake_intf =
+                rp2040_ioqspi_apply_alias(s->dormant_wake_intf, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        default:
+            if (!rp2040_ioqspi_status_offset(offset)) {
+                rp2040_log_unimplemented_write("ioqspi", size,
+                                               RP2040_IOQSPI_BASE + addr,
+                                               offset, value64);
+            }
+            break;
+        }
+    }
+}
+
+static const MemoryRegionOps rp2040_ioqspi_ops = {
+    .read = rp2040_ioqspi_read,
+    .write = rp2040_ioqspi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_ioqspi_reset(DeviceState *dev)
+{
+    RP2040IoQspiState *s = RP2040_IOQSPI(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->ctrl); i++) {
+        s->ctrl[i] = IOQSPI_CTRL_RESET;
+    }
+    s->intr = 0;
+    s->proc0_inte = 0;
+    s->proc0_intf = 0;
+    s->proc1_inte = 0;
+    s->proc1_intf = 0;
+    s->dormant_wake_inte = 0;
+    s->dormant_wake_intf = 0;
+}
+
+static void rp2040_ioqspi_init(Object *obj)
+{
+    RP2040IoQspiState *s = RP2040_IOQSPI(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_ioqspi_ops, s,
+                          "rp2040.ioqspi", RP2040_IOQSPI_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_ioqspi_vmstate = {
+    .name = TYPE_RP2040_IOQSPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl, RP2040IoQspiState, 6),
+        VMSTATE_UINT32(intr, RP2040IoQspiState),
+        VMSTATE_UINT32(proc0_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(proc0_intf, RP2040IoQspiState),
+        VMSTATE_UINT32(proc1_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(proc1_intf, RP2040IoQspiState),
+        VMSTATE_UINT32(dormant_wake_inte, RP2040IoQspiState),
+        VMSTATE_UINT32(dormant_wake_intf, RP2040IoQspiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_ioqspi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_ioqspi_reset);
+    dc->vmsd = &rp2040_ioqspi_vmstate;
+}
+
+static const TypeInfo rp2040_ioqspi_info = {
+    .name          = TYPE_RP2040_IOQSPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040IoQspiState),
+    .instance_init = rp2040_ioqspi_init,
+    .class_init    = rp2040_ioqspi_class_init,
+};
+
+static void rp2040_ioqspi_register_types(void)
+{
+    type_register_static(&rp2040_ioqspi_info);
+}
+type_init(rp2040_ioqspi_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 1ed6fa1449..068aab584f 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -15,6 +15,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_clocks.h"
 #include "hw/misc/rp2040_iobank0.h"
+#include "hw/misc/rp2040_ioqspi.h"
 #include "hw/misc/rp2040_pads.h"
 #include "hw/misc/rp2040_pll.h"
 #include "hw/misc/rp2040_psm.h"
@@ -49,6 +50,7 @@ struct RP2040State {
     PL011State uart[2];
     RP2040ClocksState clocks;
     RP2040IoBank0State iobank0;
+    RP2040IoQspiState ioqspi;
     RP2040PadsBank0State pads_bank0;
     RP2040PadsQspiState pads_qspi;
     RP2040PllState pll_sys;
diff --git a/include/hw/misc/rp2040_ioqspi.h b/include/hw/misc/rp2040_ioqspi.h
new file mode 100644
index 0000000000..e671d2a1b5
--- /dev/null
+++ b/include/hw/misc/rp2040_ioqspi.h
@@ -0,0 +1,33 @@
+/*
+ * RP2040 QSPI IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_IOQSPI_H
+#define HW_MISC_RP2040_IOQSPI_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_IOQSPI "rp2040-ioqspi"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040IoQspiState, RP2040_IOQSPI)
+
+#define RP2040_IOQSPI_BASE 0x40018000
+#define RP2040_IOQSPI_SIZE 0x4000
+
+struct RP2040IoQspiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t ctrl[6];
+    uint32_t intr;
+    uint32_t proc0_inte;
+    uint32_t proc0_intf;
+    uint32_t proc1_inte;
+    uint32_t proc1_intf;
+    uint32_t dormant_wake_inte;
+    uint32_t dormant_wake_intf;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 372d412b9b..a232813014 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -258,6 +258,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
                                                        'rp2040-clocks-test',
                                                        'rp2040-iobank0-test',
+                                                       'rp2040-ioqspi-test',
                                                        'rp2040-pads-test',
                                                        'rp2040-resets-test',
                                                        'rp2040-rosc-test',
diff --git a/tests/qtest/rp2040-ioqspi-test.c b/tests/qtest/rp2040-ioqspi-test.c
new file mode 100644
index 0000000000..4f94b5f3a2
--- /dev/null
+++ b/tests/qtest/rp2040-ioqspi-test.c
@@ -0,0 +1,81 @@
+/*
+ * QTest testcase for the RP2040 QSPI IO bank block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define IOQSPI_BASE             0x40018000
+#define IOQSPI_SCLK_STATUS      0x00
+#define IOQSPI_SCLK_CTRL        0x04
+#define IOQSPI_SD1_CTRL         0x1c
+#define IOQSPI_PROC0_INTE       0x34
+#define IOQSPI_PROC0_INTF       0x38
+#define IOQSPI_PROC0_INTS       0x3c
+
+#define IOQSPI_CTRL_RESET       0x1f
+#define IOQSPI_SD1_CTRL_SET     0x201c
+#define IOQSPI_SD1_CTRL_CLR     0x301c
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_ioqspi_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SCLK_STATUS), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SCLK_CTRL), ==,
+                    IOQSPI_CTRL_RESET);
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL), ==,
+                    IOQSPI_CTRL_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_ioqspi_atomic_ctrl_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL, 0);
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_SET, BIT(17));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_CLR, BIT(17));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_SET, BIT(9));
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL), ==,
+                    BIT(9));
+
+    qtest_quit(qts);
+}
+
+static void test_ioqspi_interrupt_force_status(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTE, BIT(1));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTF, BIT(2));
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_PROC0_INTS), ==,
+                    BIT(2));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-ioqspi/reset-values", test_ioqspi_reset_values);
+    qtest_add_func("/rp2040-ioqspi/atomic-ctrl-aliases",
+                   test_ioqspi_atomic_ctrl_aliases);
+    qtest_add_func("/rp2040-ioqspi/interrupt-force-status",
+                   test_ioqspi_interrupt_force_status);
+
+    return g_test_run();
+}
-- 
2.55.0


