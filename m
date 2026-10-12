Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F223CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNL-0000CQ-J0; Mon, 12 Oct 2026 12:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJN7-0008Fd-NE; Mon, 12 Oct 2026 12:59:34 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJN4-0006JP-Hg; Mon, 12 Oct 2026 12:59:32 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw36C6qz8BVL;
 Mon, 12 Oct 2026 18:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824323;
 bh=vz13J9qe9FL7TAPGBQHYiICwl3Y6kaxotqUC9vUcfmw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vQpHiybypuDa9gLEY2dGD/bcomR56NX/Naz8MyEqqf9ybfZPreuSR7KT+2sjEu6A6
 BdvPlH1dHymiy9FyU9ADHCmtWh+yEiFDJiPG2v49iPncw84ztsC9akjtV0rn0amodl
 3sCWadh4r22r/eF9I8ULxSUb1JK56WSZcP8DMpVJW+8rOkoWHQHGFVkN7S1tWzQ6s1
 /BpHBHXshkK4gXLs5PuNl+uz9L9HWuutN7JLpd3bUpZEWjdaFjR6fkPr1u5TPU8JlK
 Qd3pMN4fFCb7A41uAqkbIQ1k+RD2uLws100o/ufbEL1VBfxtw7L8hJxvd2i4OaTLbv
 tcoCAOYQ3tShw==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw34ljHz83nY;
 Mon, 12 Oct 2026 18:58:43 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 9/9] hw/misc: add RP2040 testbench manager
Date: Mon, 12 Oct 2026 18:58:39 +0200
Message-ID: <20261012165840.99050-10-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 testbench manager PLATFORM register.

Return the documented ASIC platform value.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                 |  6 +++
 hw/misc/meson.build             |  1 +
 hw/misc/rp2040_tbman.c          | 88 +++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h         |  2 +
 include/hw/misc/rp2040_tbman.h  | 29 +++++++++++
 tests/qtest/meson.build         |  1 +
 tests/qtest/rp2040-tbman-test.c | 29 +++++++++++
 7 files changed, 156 insertions(+)
 create mode 100644 hw/misc/rp2040_tbman.c
 create mode 100644 include/hw/misc/rp2040_tbman.h
 create mode 100644 tests/qtest/rp2040-tbman-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 0af99aed7e..f5ee31392e 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -143,6 +143,7 @@ static void rp2040_soc_init(Object *obj)
 
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+    object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
@@ -277,6 +278,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->tbman), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->tbman), 0, RP2040_TBMAN_BASE);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->vreg), errp)) {
         return;
     }
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ea89f26b88..349b6c126e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_tbman.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_vreg.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/rp2040_tbman.c b/hw/misc/rp2040_tbman.c
new file mode 100644
index 0000000000..f55a80e514
--- /dev/null
+++ b/hw/misc/rp2040_tbman.c
@@ -0,0 +1,88 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_tbman.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static uint64_t rp2040_tbman_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case A_RP2040_TBMAN_PLATFORM:
+        value = R_RP2040_TBMAN_PLATFORM_ASIC_MASK;
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
+static void rp2040_tbman_write(void *opaque, hwaddr addr,
+                               uint64_t value64, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented write at offset 0x%"
+                  HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 4b6f7c2faa..e4370b90fd 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -15,6 +15,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_syscfg.h"
+#include "hw/misc/rp2040_tbman.h"
 #include "hw/misc/rp2040_vreg.h"
 #include "qom/object.h"
 
@@ -40,6 +41,7 @@ struct RP2040State {
     PL011State uart[2];
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
+    RP2040TbmanState tbman;
     RP2040VregState vreg;
 
     MemoryRegion *board_memory;
diff --git a/include/hw/misc/rp2040_tbman.h b/include/hw/misc/rp2040_tbman.h
new file mode 100644
index 0000000000..d89deb726c
--- /dev/null
+++ b/include/hw/misc/rp2040_tbman.h
@@ -0,0 +1,29 @@
+/*
+ * RP2040 testbench manager emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_TBMAN_H
+#define HW_MISC_RP2040_TBMAN_H
+
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_TBMAN "rp2040-tbman"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040TbmanState, RP2040_TBMAN)
+
+#define RP2040_TBMAN_BASE 0x4006c000
+#define RP2040_TBMAN_SIZE 0x4000
+
+REG32(RP2040_TBMAN_PLATFORM, 0x00)
+    FIELD(RP2040_TBMAN_PLATFORM, ASIC, 0, 1)
+
+struct RP2040TbmanState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4e8b753536..ad5c877bb5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -268,6 +268,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_RP2040') ?
    ['rp2040-syscfg-test',
     'rp2040-sysinfo-test',
+    'rp2040-tbman-test',
     'rp2040-vreg-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
diff --git a/tests/qtest/rp2040-tbman-test.c b/tests/qtest/rp2040-tbman-test.c
new file mode 100644
index 0000000000..d654aabba3
--- /dev/null
+++ b/tests/qtest/rp2040-tbman-test.c
@@ -0,0 +1,29 @@
+/*
+ * QTest testcase for the RP2040 testbench manager block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_tbman.h"
+#include "libqtest.h"
+
+static void test_tbman_platform(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico");
+
+    g_assert_cmphex(qtest_readl(qts,
+                    RP2040_TBMAN_BASE + A_RP2040_TBMAN_PLATFORM), ==,
+                    R_RP2040_TBMAN_PLATFORM_ASIC_MASK);
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
-- 
2.55.0


