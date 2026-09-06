Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3D0C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Int-0002aR-JZ; Sun, 06 Sep 2026 15:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Inq-0002ZX-2s; Sun, 06 Sep 2026 15:45:22 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Inn-0007C8-Vz; Sun, 06 Sep 2026 15:45:21 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdLJB45q2z7x2S;
 Sun,  6 Sep 2026 21:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723882;
 bh=NaWpkP/1SKB4VLL4CRiJanz7RMKk9041lGKzRnE8TQM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TUIlxoxzRs6S8A+oX+oHg8iYMz+OiUKGX8cjYqRTlm6Uymxd4AEs5Mw91GeA5k6aJ
 FqvYgEZzUfZjHth5UscDuMGhKGqWOugf6cv0OHVjq5Mr9u9rSXKktQa85DkJpd7hka
 ZIPnGT1+NLwXjV4eQAj2TpbPEMgwfiDyNuBdeHFieOhgZ8QgAUe8W63Z8lILHLoyIT
 L2IjjdQHti8GVfzkEBDPD/b7T9znWvemEhpnwWd12Qdc+klH02eZWE8Vzd0eJ53wrH
 Cy5JLICAQn6VqABUKqrbQTYfw6zQxYSUyZziaWFYQn2zD7s3sJT2MjTTaRbAJ5ANmc
 meDNhV+A/m3Rg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJB1svMz7wXp;
 Sun,  6 Sep 2026 21:44:42 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/36] hw/misc: add RP2040 SYSINFO
Date: Sun,  6 Sep 2026 21:44:08 +0200
Message-ID: <20260906194438.93046-10-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
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

Model the read-only RP2040 identification and platform registers. The
platform register reports an ASIC implementation, while CHIP_ID and the Git
revision retain stable zero values.

Add a focused qtest for the documented register values.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                   |   8 ++-
 hw/misc/meson.build               |   1 +
 hw/misc/rp2040_sysinfo.c          | 102 ++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h           |   2 +
 include/hw/misc/rp2040_sysinfo.h  |  25 ++++++++
 tests/qtest/meson.build           |   2 +
 tests/qtest/rp2040-sysinfo-test.c |  37 +++++++++++
 7 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_sysinfo.c
 create mode 100644 include/hw/misc/rp2040_sysinfo.h
 create mode 100644 tests/qtest/rp2040-sysinfo-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 7844932e05..a6d1ff75f8 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -49,7 +49,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.sysinfo",  0x40000000, 0x4000 },
     { "rp2040.syscfg",   0x40004000, 0x4000 },
     { "rp2040.clocks",   0x40008000, 0x4000 },
     { "rp2040.resets",   0x4000c000, 0x4000 },
@@ -110,6 +109,8 @@ static void rp2040_soc_init(Object *obj)
                                   "chardev");
     }
 
+    object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+
     s->sysclk = clock_new(obj, "sysclk");
     clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
 }
@@ -222,6 +223,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
+
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 54e07aacda..cd5970bb84 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_sysinfo.c b/hw/misc/rp2040_sysinfo.c
new file mode 100644
index 0000000000..a35b867698
--- /dev/null
+++ b/hw/misc/rp2040_sysinfo.c
@@ -0,0 +1,102 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_sysinfo.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define SYSINFO_CHIP_ID        0x00
+#define SYSINFO_PLATFORM       0x04
+#define SYSINFO_GITREF_RP2040  0x40
+
+#define SYSINFO_PLATFORM_ASIC  BIT(1)
+
+static uint64_t rp2040_sysinfo_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case SYSINFO_CHIP_ID:
+    case SYSINFO_GITREF_RP2040:
+        value = 0;
+        break;
+    case SYSINFO_PLATFORM:
+        value = SYSINFO_PLATFORM_ASIC;
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
+static void rp2040_sysinfo_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+
+    qemu_log_mask(LOG_GUEST_ERROR, "rp2040.sysinfo: write to read-only "
+                  "register (size %d, addr 0x%08" HWADDR_PRIx
+                  ", offset 0x%04" HWADDR_PRIx
+                  ", value 0x%0*" PRIx64 ")\n",
+                  size, RP2040_SYSINFO_BASE + addr, offset, size << 1, value);
+}
+
+static const MemoryRegionOps rp2040_sysinfo_ops = {
+    .read = rp2040_sysinfo_read,
+    .write = rp2040_sysinfo_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_sysinfo_init(Object *obj)
+{
+    RP2040SysInfoState *s = RP2040_SYSINFO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_sysinfo_ops, s,
+                          "rp2040.sysinfo", RP2040_SYSINFO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_sysinfo_vmstate = {
+    .name = TYPE_RP2040_SYSINFO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_sysinfo_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &rp2040_sysinfo_vmstate;
+}
+
+static const TypeInfo rp2040_sysinfo_info = {
+    .name          = TYPE_RP2040_SYSINFO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040SysInfoState),
+    .instance_init = rp2040_sysinfo_init,
+    .class_init    = rp2040_sysinfo_class_init,
+};
+
+static void rp2040_sysinfo_register_types(void)
+{
+    type_register_static(&rp2040_sysinfo_info);
+}
+type_init(rp2040_sysinfo_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index ccab548275..7e7d8f5c95 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,6 +13,7 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/rp2040_sysinfo.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -35,6 +36,7 @@ struct RP2040State {
 
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
+    RP2040SysInfoState sysinfo;
 
     MemoryRegion *board_memory;
     MemoryRegion cpu_memory[RP2040_NUM_CORES];
diff --git a/include/hw/misc/rp2040_sysinfo.h b/include/hw/misc/rp2040_sysinfo.h
new file mode 100644
index 0000000000..d521659488
--- /dev/null
+++ b/include/hw/misc/rp2040_sysinfo.h
@@ -0,0 +1,25 @@
+/*
+ * RP2040 sysinfo emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_SYSINFO_H
+#define HW_MISC_RP2040_SYSINFO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_SYSINFO "rp2040-sysinfo"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysInfoState, RP2040_SYSINFO)
+
+#define RP2040_SYSINFO_BASE 0x40000000
+#define RP2040_SYSINFO_SIZE 0x4000
+
+struct RP2040SysInfoState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bf563cdc6a..3cfda5a40d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -248,6 +248,8 @@ qtests_stm32l4x5 = \
    'stm32l4x5_usart-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_RP2040') ?
+   ['rp2040-sysinfo-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ARM_VIRT') and
    config_all_devices.has_key('CONFIG_PL011_C') ? ['pl011-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
diff --git a/tests/qtest/rp2040-sysinfo-test.c b/tests/qtest/rp2040-sysinfo-test.c
new file mode 100644
index 0000000000..7775842420
--- /dev/null
+++ b/tests/qtest/rp2040-sysinfo-test.c
@@ -0,0 +1,37 @@
+/*
+ * QTest testcase for the RP2040 SYSINFO block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define SYSINFO_BASE          0x40000000
+#define SYSINFO_CHIP_ID       0x00
+#define SYSINFO_PLATFORM      0x04
+#define SYSINFO_GITREF_RP2040 0x40
+#define SYSINFO_PLATFORM_ASIC BIT(1)
+
+static void test_sysinfo_read_values(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico");
+
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_CHIP_ID), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_PLATFORM), ==,
+                    SYSINFO_PLATFORM_ASIC);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_GITREF_RP2040),
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-sysinfo/read-values", test_sysinfo_read_values);
+
+    return g_test_run();
+}
-- 
2.55.0


