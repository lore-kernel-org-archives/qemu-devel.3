Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510BDD3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVvT-0006mJ-3A; Mon, 08 Dec 2025 02:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvR-0006lX-8I; Mon, 08 Dec 2025 02:44:53 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvP-0008LH-8u; Mon, 08 Dec 2025 02:44:52 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 01/18] hw/misc: Add LTPI controller
Date: Mon, 8 Dec 2025 15:44:13 +0800
Message-ID: <20251208074436.1871180-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
2.0 specification:
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf

LTPI is a protocol and physical interface for tunneling various low-speed
signals between the HPM and SCM. As shown in Figure 2, the AST27x0 (left)
integrates two LTPI controllers, allowing it to connect to up to two
extended boards.

This commit introduces a simple device model for the ASPEED LTPI
controller in QEMU.

The model includes basic MMIO read/write operations and sets default
register values during reset to emulate a link-up state.

Implements register space with read/write callbacks.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ltpi.h |  32 ++++++
 hw/misc/aspeed_ltpi.c         | 194 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 3 files changed, 227 insertions(+)
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 hw/misc/aspeed_ltpi.c

diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltpi.h
new file mode 100644
index 0000000000..cb1a9f4bd8
--- /dev/null
+++ b/include/hw/misc/aspeed_ltpi.h
@@ -0,0 +1,32 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_LTPI_H
+#define ASPEED_LTPI_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)
+
+#define ASPEED_LTPI_CTRL_SIZE   0x200
+#define ASPEED_LTPI_PHY_SIZE    0x100
+#define ASPEED_LTPI_TOP_SIZE    0x100
+
+struct AspeedLTPIState {
+    SysBusDevice parent;
+    MemoryRegion mmio;
+    MemoryRegion mmio_ctrl;
+    MemoryRegion mmio_phy;
+    MemoryRegion mmio_top;
+
+    uint32_t ctrl_regs[ASPEED_LTPI_CTRL_SIZE >> 2];
+    uint32_t phy_regs[ASPEED_LTPI_PHY_SIZE >> 2];
+    uint32_t top_regs[ASPEED_LTPI_TOP_SIZE >> 2];
+};
+
+#endif /* ASPEED_LTPI_H */
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
new file mode 100644
index 0000000000..a94ed804a3
--- /dev/null
+++ b/hw/misc/aspeed_ltpi.c
@@ -0,0 +1,194 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/misc/aspeed_ltpi.h"
+
+#define ASPEED_LTPI_TOTAL_SIZE  0x900
+#define ASPEED_LTPI_CTRL_BASE   0x000
+#define ASPEED_LTPI_PHY_BASE    0x200
+#define ASPEED_LTPI_TOP_BASE    0x800
+
+#define LTPI_CTRL_LINK_MNG 0x42
+#define LTPI_PHY_MODE 0x0
+
+static uint64_t aspeed_ltpi_top_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->top_regs[idx];
+}
+
+static void aspeed_ltpi_top_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->top_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_top_ops = {
+    .read = aspeed_ltpi_top_read,
+    .write = aspeed_ltpi_top_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aspeed_ltpi_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->phy_regs[idx];
+}
+
+static void aspeed_ltpi_phy_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->phy_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_phy_ops = {
+    .read = aspeed_ltpi_phy_read,
+    .write = aspeed_ltpi_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aspeed_ltpi_ctrl_read(void *opaque,
+                                      hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->ctrl_regs[idx];
+}
+
+static void aspeed_ltpi_ctrl_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->ctrl_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_ctrl_ops = {
+    .read = aspeed_ltpi_ctrl_read,
+    .write = aspeed_ltpi_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_ltpi_reset(DeviceState *dev)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+
+    memset(s->ctrl_regs, 0, sizeof(s->ctrl_regs));
+    memset(s->phy_regs, 0, sizeof(s->phy_regs));
+    memset(s->top_regs, 0, sizeof(s->top_regs));
+    /* set default values */
+    s->ctrl_regs[LTPI_CTRL_LINK_MNG] = 0x11900007;
+    s->phy_regs[LTPI_PHY_MODE] = 0x2;
+}
+
+
+static const VMStateDescription vmstate_aspeed_ltpi = {
+    .name = TYPE_ASPEED_LTPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl_regs, AspeedLTPIState,
+                             ASPEED_LTPI_CTRL_SIZE >> 2),
+        VMSTATE_UINT32_ARRAY(phy_regs, AspeedLTPIState,
+                             ASPEED_LTPI_PHY_SIZE >> 2),
+        VMSTATE_UINT32_ARRAY(top_regs, AspeedLTPIState,
+                             ASPEED_LTPI_TOP_SIZE >> 2),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void aspeed_ltpi_realize(DeviceState *dev, Error **errp)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+
+    memory_region_init(&s->mmio, OBJECT(s), TYPE_ASPEED_LTPI,
+                       ASPEED_LTPI_TOTAL_SIZE);
+
+    memory_region_init_io(&s->mmio_ctrl, OBJECT(s),
+                          &aspeed_ltpi_ctrl_ops, s,
+                          "aspeed-ltpi-ctrl", ASPEED_LTPI_CTRL_SIZE);
+
+    memory_region_init_io(&s->mmio_phy, OBJECT(s),
+                          &aspeed_ltpi_phy_ops, s,
+                          "aspeed-ltpi-phy", ASPEED_LTPI_PHY_SIZE);
+
+    memory_region_init_io(&s->mmio_top, OBJECT(s),
+                          &aspeed_ltpi_top_ops, s,
+                          "aspeed-ltpi-top", ASPEED_LTPI_TOP_SIZE);
+
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_CTRL_BASE, &s->mmio_ctrl);
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_PHY_BASE, &s->mmio_phy);
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_TOP_BASE, &s->mmio_top);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
+}
+
+static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_ltpi_realize;
+    dc->vmsd = &vmstate_aspeed_ltpi;
+    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);
+}
+
+static const TypeInfo aspeed_ltpi_info = {
+    .name          = TYPE_ASPEED_LTPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedLTPIState),
+    .class_init    = aspeed_ltpi_class_init,
+};
+
+static void aspeed_ltpi_register_types(void)
+{
+    type_register_static(&aspeed_ltpi_info);
+}
+
+type_init(aspeed_ltpi_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..45b16e7797 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
   'aspeed_i3c.c',
   'aspeed_lpc.c',
+  'aspeed_ltpi.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
-- 
2.43.0


