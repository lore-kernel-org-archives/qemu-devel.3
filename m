Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98652C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljaG-0007Nn-5X; Mon, 20 Jul 2026 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlihZ-0001fS-Oh; Mon, 20 Jul 2026 03:46:15 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlihV-0005S9-PM; Mon, 20 Jul 2026 03:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=r0
 jAeRmeX6OgKpkedoidgh05noVyOAy4fykHKI6+jZY=; b=TTYtx35nawPi8wh18/
 1gozj9jZNNnd+mlOAl1C2e2nMVz1mDdoVqf+NowunHOE+/y8ke8MH2XB4Y20ZakZ
 F2GXtiDDbCU61mcibfcLBevZ+WS6+8ASX1FYFu1SthdwUMdnzQhTO02JyXP1D64U
 JW3AjX4C5DaBHCQr2jQtPsxFA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3sFop0l1qwlRuKw--.5096S3; 
 Mon, 20 Jul 2026 15:45:46 +0800 (CST)
From: Jian Cai <lingqian_gi@163.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: [RFC PATCH 1/3] hw/riscv: add K230 SRAM device model
Date: Mon, 20 Jul 2026 15:45:43 +0800
Message-ID: <20260720074545.8987-2-lingqian_gi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720074545.8987-1-lingqian_gi@163.com>
References: <20260720074545.8987-1-lingqian_gi@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3sFop0l1qwlRuKw--.5096S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF47JF13CFyfZFWfCw4Durg_yoW7Cr4UpF
 ykCrn5Cr4xXrWfA3WSgF4xXa4F9an3Cr4UCws7uryvv39rKry8tr4Dt340ya47Jr48G3yY
 9FyaqF1F9w1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_yCXUUUUU=
X-Originating-IP: [42.193.175.155]
X-CM-SenderInfo: 5olqw15ldqswrl6rljoofrz/xtbCwQuwpmpd0ivodAAA3O
Received-SPF: pass client-ip=220.197.31.5; envelope-from=lingqian_gi@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2026 04:42:40 -0400
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

The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
controller registers: it is a pure on-chip RAM block accessed via
the AXI bus. This patch wraps it as a SysBusDevice so that it appears
in the QOM tree, supports VMState migration, and can be introspected
by management tools.

Clock gating (CMU at 0x91100000, offset 0x5c) and reset control
(RMU at 0x91101000, offsets 0x60/0x64) are handled by separate
system-controller peripherals and are not modelled here.

Reference:
K230 TRM V0.3.1 (2024-11-18), Section 5.2 Sram

Signed-off-by: Jian Cai <lingqian_gi@163.com>
---
 MAINTAINERS                  |  5 +++
 hw/riscv/k230_sram.c         | 81 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/k230_sram.h | 35 ++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 hw/riscv/k230_sram.c
 create mode 100644 include/hw/riscv/k230_sram.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..3567563ba6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1825,6 +1825,11 @@ L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
+F: hw/riscv/k230_sram.c
+F: include/hw/riscv/k230_sram.h
+F: hw/riscv/k230_sram.c
+F: include/hw/riscv/k230_sram.h
+F: tests/qtest/k230-sram-test.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
diff --git a/hw/riscv/k230_sram.c b/hw/riscv/k230_sram.c
new file mode 100644
index 0000000000..1d960e733e
--- /dev/null
+++ b/hw/riscv/k230_sram.c
@@ -0,0 +1,81 @@
+/*
+ * K230 SRAM Controller
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
+ * controller registers.  This device wraps the SRAM as a SysBusDevice
+ * so that it appears in the QOM tree, supports migration (VMState),
+ * and can be introspected by management tools.
+ *
+ * Clock gating is controlled by the CMU at 0x91100000 (shrm_CLK_CFG,
+ * offset 0x5c, bit 10: sram_aclk_enable).  Reset is controlled by the
+ * RMU at 0x91101000 (SRAM_RST_TIM/SRAM_RST_CTL, offsets 0x60/0x64).
+ * Those peripherals are not modelled yet, so SRAM is always enabled
+ * in the current QEMU implementation.
+ *
+ * Copyright (c) 2026 Jian Cai <lingqian_gi@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/riscv/k230_sram.h"
+
+static void k230_sram_realize(DeviceState *dev, Error **errp)
+{
+    K230SramState *s = K230_SRAM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_ram(&s->sram, OBJECT(dev), "k230.sram",
+                           2 * MiB, &error_fatal);
+    sysbus_init_mmio(sbd, &s->sram);
+}
+
+static void k230_sram_reset_hold(Object *obj, ResetType type)
+{
+    /*
+     * No software-visible registers to reset.  SRAM content is preserved
+     * across warm reset on real hardware; a cold reset would clear it,
+     * but QEMU memory_region_init_ram already zeroes the region on init.
+     */
+}
+
+static const VMStateDescription vmstate_k230_sram = {
+    .name = "k230.sram",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_sram_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = k230_sram_realize;
+    rc->phases.hold = k230_sram_reset_hold;
+    dc->vmsd = &vmstate_k230_sram;
+    dc->desc = "K230 SRAM";
+}
+
+static const TypeInfo k230_sram_info = {
+    .name          = TYPE_K230_SRAM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230SramState),
+    .class_init    = k230_sram_class_init,
+};
+
+static void k230_sram_register_type(void)
+{
+    type_register_static(&k230_sram_info);
+}
+
+type_init(k230_sram_register_type)
diff --git a/include/hw/riscv/k230_sram.h b/include/hw/riscv/k230_sram.h
new file mode 100644
index 0000000000..6d15970ab9
--- /dev/null
+++ b/include/hw/riscv/k230_sram.h
@@ -0,0 +1,35 @@
+/*
+ * K230 SRAM Controller
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
+ * controller registers: it is a pure on-chip RAM block accessed directly
+ * via the AXI bus.  Clock gating (CMU at 0x91100000, offset 0x5c) and
+ * reset control (RMU at 0x91101000, offsets 0x60/0x64) are handled by
+ * separate system-controller peripherals and are not modelled here yet.
+ *
+ * Copyright (c) 2026 Jian Cai <lingqian_gi@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef K230_SRAM_H
+#define K230_SRAM_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_SRAM "riscv.k230.sram"
+OBJECT_DECLARE_SIMPLE_TYPE(K230SramState, K230_SRAM)
+
+struct K230SramState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion sram;          /* 2 MB SRAM storage */
+};
+
+#endif /* K230_SRAM_H */
-- 
2.43.0


