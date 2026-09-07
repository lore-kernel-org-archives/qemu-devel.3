Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D7C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3RqS-0004sC-Ev; Mon, 07 Sep 2026 01:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqR-0004rz-4q; Mon, 07 Sep 2026 01:24:39 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3RqO-0007so-KH; Mon, 07 Sep 2026 01:24:38 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdb980VdfzBqYt;
 Mon,  7 Sep 2026 07:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758668;
 bh=80YDUYN4awspHUDV8we1+tPBmUwtQoRMSid+Hb/JMQ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jrxUNr481y9UD8hYbguK2zCmZ6bK+lvvA/dpI6RbJaKm1cFrIl+yeLNb55KiSO7DE
 bLzrEQCats6EmYqxtFC5CyrpzxSqlw88fF7ebmiHTi9pMJUCjIQU0R9PprfUukkec4
 NW9I/5nv6ftpynU3ccWPHWuHOlqi0Za/3zltMl3yeG6X7FsO6xRjnF6nX2yRGQ+7NW
 mBgRuK8CP1aAXuYYMiANI6afkVWwr6jdWKgvqLCE6sSFPpyJZuoZ6rUAKWhydSRc5L
 S+demcGPZbGd+ASLVeLJZwbMt3UPTP+aqYmpvqQ0qvZRPWgUrJi+TbPnuif/AvsnsY
 Md5KiyoVnazaw==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb975Bjpz7xqd;
 Mon,  7 Sep 2026 07:24:27 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 19/36] hw/misc: add RP2040 IO_QSPI
Date: Mon,  7 Sep 2026 07:24:07 +0200
Message-ID: <20260907052426.24849-3-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
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

Model the six QSPI GPIO control pairs and the PROC0, PROC1 and dormant-wake
interrupt registers, including atomic aliases and documented masks. Wire
the register block into the RP2040 SoC and add focused qtests for reset,
atomic control updates and forced interrupt status. The QSPI chip-select
connection is deferred to the XIP controller patch.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                  |   8 +-
 hw/misc/meson.build              |   1 +
 hw/misc/rp2040_ioqspi.c          | 243 +++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h          |   2 +
 include/hw/misc/rp2040_ioqspi.h  |  33 +++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/rp2040-ioqspi-test.c |  81 +++++++++++
 7 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_ioqspi.c
 create mode 100644 include/hw/misc/rp2040_ioqspi.h
 create mode 100644 tests/qtest/rp2040-ioqspi-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index a52738b3e2..aa1407b4dd 100644
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
@@ -132,6 +131,8 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
     object_initialize_child(obj, "iobank0", &s->iobank0,
                             TYPE_RP2040_IOBANK0);
+    object_initialize_child(obj, "ioqspi", &s->ioqspi,
+                            TYPE_RP2040_IOQSPI);
     object_initialize_child(obj, "pads-bank0", &s->pads_bank0,
                             TYPE_RP2040_PADS_BANK0);
     object_initialize_child(obj, "pads-qspi", &s->pads_qspi,
@@ -329,6 +330,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 18a0afdc93..5534cba1a8 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_clocks.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_iobank0.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_ioqspi.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_pads.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_pll.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_psm.c'))
diff --git a/hw/misc/rp2040_ioqspi.c b/hw/misc/rp2040_ioqspi.c
new file mode 100644
index 0000000000..f4d1a1f329
--- /dev/null
+++ b/hw/misc/rp2040_ioqspi.c
@@ -0,0 +1,243 @@
+/*
+ * RP2040 QSPI IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040.h"
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
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned index;
+    uint32_t value = value64;
+
+    if (rp2040_ioqspi_ctrl_offset(offset, &index)) {
+        s->ctrl[index] =
+            rp2040_atomic_update(s->ctrl[index], value, alias) &
+            IOQSPI_CTRL_RW_MASK;
+    } else {
+        switch (offset) {
+        case IOQSPI_INTR:
+            s->intr &= ~(value & IOQSPI_INTR_EDGE_MASK);
+            break;
+        case IOQSPI_PROC0_INTE:
+            s->proc0_inte =
+                rp2040_atomic_update(s->proc0_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC0_INTF:
+            s->proc0_intf =
+                rp2040_atomic_update(s->proc0_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTE:
+            s->proc1_inte =
+                rp2040_atomic_update(s->proc1_inte, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_PROC1_INTF:
+            s->proc1_intf =
+                rp2040_atomic_update(s->proc1_intf, value, alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTE:
+            s->dormant_wake_inte =
+                rp2040_atomic_update(s->dormant_wake_inte, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        case IOQSPI_DORMANT_INTF:
+            s->dormant_wake_intf =
+                rp2040_atomic_update(s->dormant_wake_intf, value,
+                                          alias) &
+                IOQSPI_IRQ_MASK;
+            break;
+        default:
+            if (!rp2040_ioqspi_status_offset(offset)) {
+                qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
index ae393195d3..fdfcf28f3b 100644
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
@@ -50,6 +51,7 @@ struct RP2040State {
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
index 9cf40e50ec..8009ec7f8d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -267,6 +267,7 @@ qtests_arm = \
      'rp2040-sysinfo-test',
     'rp2040-clocks-test',
     'rp2040-iobank0-test',
+    'rp2040-ioqspi-test',
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


