Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E379CCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUg5-0007Uo-RT; Tue, 04 Nov 2025 22:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg1-0007Tx-Lb; Tue, 04 Nov 2025 22:59:17 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUfz-0006sZ-Ub; Tue, 04 Nov 2025 22:59:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:00 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:00 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 03/17] hw/arm/aspeed: Add AST1700 LTPI expander device model
Date: Wed, 5 Nov 2025 11:58:41 +0800
Message-ID: <20251105035859.3709907-4-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Introduce a minimal QEMU device model for the ASPEED AST1700, an
MCU-less I/O expander used in the LTPI topology defined by the
DC-SCM 2.0 specification (see figure 2):
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf

This initial implementation includes:

* Definition of aspeed.ast1700 as a SysBusDevice

* Setup of a basic memory region to reserve I/O space for future
  peripheral modeling

This stub establishes the foundation for LTPI-related device emulation,
without implementing any functional peripherals at this stage.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ast1700.h | 32 ++++++++++++++++++
 hw/misc/aspeed_ast1700.c         | 57 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build              |  1 +
 3 files changed, 90 insertions(+)
 create mode 100644 include/hw/misc/aspeed_ast1700.h
 create mode 100644 hw/misc/aspeed_ast1700.c

diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
new file mode 100644
index 0000000000..b7c666eef2
--- /dev/null
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -0,0 +1,32 @@
+/*
+ * ASPEED AST1700 IO Expander
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_AST1700_H
+#define ASPEED_AST1700_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/aspeed_scu.h"
+#include "hw/adc/aspeed_adc.h"
+#include "hw/gpio/aspeed_gpio.h"
+#include "hw/i2c/aspeed_i2c.h"
+#include "hw/misc/aspeed_ltpi.h"
+#include "hw/ssi/aspeed_smc.h"
+#include "hw/watchdog/wdt_aspeed.h"
+#include "hw/char/serial-mm.h"
+#include "hw/misc/unimp.h"
+
+#define TYPE_ASPEED_AST1700 "aspeed.ast1700"
+
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
+
+struct AspeedAST1700SoCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+};
+
+#endif /* ASPEED_AST1700_H */
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
new file mode 100644
index 0000000000..bb05e392f4
--- /dev/null
+++ b/hw/misc/aspeed_ast1700.c
@@ -0,0 +1,57 @@
+/*
+ * ASPEED AST1700 IO Expander
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/misc/aspeed_ast1700.h"
+
+#define AST2700_SOC_LTPI_SIZE        0x01000000
+static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
+{
+    AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Occupy memory space for all controllers in AST1700 */
+    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
+                       AST2700_SOC_LTPI_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+}
+
+static void aspeed_ast1700_instance_init(Object *obj)
+{
+    return;
+}
+
+static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_ast1700_realize;
+}
+
+static const TypeInfo aspeed_ast1700_info = {
+    .name          = TYPE_ASPEED_AST1700,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedAST1700SoCState),
+    .class_init    = aspeed_ast1700_class_init,
+    .instance_init = aspeed_ast1700_instance_init,
+};
+
+
+static void aspeed_ast1700_register_types(void)
+{
+    type_register_static(&aspeed_ast1700_info);
+}
+
+type_init(aspeed_ast1700_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 45b16e7797..9477e63cdf 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -133,6 +133,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+  'aspeed_ast1700.c',
   'aspeed_hace.c',
   'aspeed_i3c.c',
   'aspeed_lpc.c',
-- 
2.43.0


