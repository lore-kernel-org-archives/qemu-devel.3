Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF7CA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNP-0000MX-7R; Mon, 12 Oct 2026 12:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMV-00080N-Vm; Mon, 12 Oct 2026 12:58:58 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMT-0006D6-T7; Mon, 12 Oct 2026 12:58:55 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw22n5JzBqmm;
 Mon, 12 Oct 2026 18:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824322;
 bh=GdzwaCUEbqkr6BJ+PYfkIGMYuR2E6mJzYvUTYXJ8ue0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FrtBXjnhD2YcbFwo1du0k3vFY3Fcm95IrgTa1kEWI8XwZJ/xmhlRvDaBANi5dfuij
 o1gi/efG6F5y1eNGFzPDQx3VLqG0ISFZ5vNzg9BjjXJVzTzARQfZkSbYM4doxHL2Vp
 bpMJ6YfIKcT4FZWpQfJFGuFzo884r7KeHg8Fhgzr4G3uUGrXS9xQz5+eC6FIFSeirT
 Q+DJKqjVUMHzgg0nUF9E/kQ4nqQUf8DAebiRle/o1K/yLwE8ns6/KSPvrxrMOtn+GB
 gFhryCaH41j0YMVtyNLB/wBk1mCvaIM8wXZ9KHV1xv2XLYdY6ujyyjMvHZrs2sOXEP
 FRc3kRz4tz/xA==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw20tsJz83nb;
 Mon, 12 Oct 2026 18:58:42 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 6/9] hw/misc: add RP2040 SYSINFO
Date: Mon, 12 Oct 2026 18:58:36 +0200
Message-ID: <20261012165840.99050-7-gilles.grimaud@univ-lille.fr>
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
index d5398e67e4..55554f72e9 100644
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
index 9790afa104..ca9b951e3e 100644
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
index 200abf6f36..8079fcee28 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -253,6 +253,8 @@ qtests_exynos4210 = \
   ['exynos4210_uart_fifo-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_RP2040') ?
+   ['rp2040-sysinfo-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
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


