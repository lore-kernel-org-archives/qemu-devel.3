Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0BCA1013
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 03:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzRjy-0001gi-5A; Thu, 18 Sep 2025 23:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzRjw-0001g1-2c; Thu, 18 Sep 2025 23:24:52 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzRjp-000736-Gx; Thu, 18 Sep 2025 23:24:51 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 11:24:32 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 11:24:32 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v4 02/14] hw/pci-host/aspeed: Add AST2600 PCIe PHY model
Date: Fri, 19 Sep 2025 11:24:15 +0800
Message-ID: <20250919032431.3316764-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch introduces an initial ASPEED PCIe PHY/host controller model to
support the AST2600 SoC. It provides a simple register block with MMIO
read/write callbacks, integration into the build system, and trace events
for debugging.

Key changes:

1. PCIe PHY MMIO read/write callbacks
   Implemented aspeed_pcie_phy_read() and aspeed_pcie_phy_write() to
   handle 32-bit register accesses.

2. Build system and Kconfig integration
   Added CONFIG_PCI_EXPRESS_ASPEED in hw/pci-host/Kconfig and meson
   rules.
   Updated ASPEED_SOC in hw/arm/Kconfig to imply PCI_DEVICES and select
   PCI_EXPRESS_ASPEED.

3. Trace events for debug
   New tracepoints aspeed_pcie_phy_read and aspeed_pcie_phy_write allow
   monitoring MMIO accesses.

4. Register space and defaults (AST2600 reference)
   Expose a 0x100 register space, as documented in the AST2600 datasheet.
   On reset, set default values:
   PEHR_ID: Vendor ID = ASPEED, Device ID = 0x1150
   PEHR_CLASS_CODE = 0x06040006
   PEHR_DATALINK = 0xD7040022
   PEHR_LINK: bit[5] set to 1 to indicate link up.

This provides a skeleton device for the AST2600 platform. It enables
firmware to detect the PCIe link as up by default and allows future
extension.

This commit is the starting point of the series to introduce ASPEED PCIe
Root Complex (RC) support. Based on previous work from Cédric Le Goater,
the following commits in this series extend and refine the implementation:

- Add a PCIe Root Port so that devices can be attached without requiring an
extra bridge.
- Restrict the Root Port device instantiation to the AST2600 platform.
- Integrate aspeed_cfg_translate_write() to support both AST2600 and AST2700.
- Add MSI support and a preliminary RC IOMMU address space.
- Fix issues with MSI interrupt clearing.
- Extend support to the AST2700 SoC.
- Drop the AST2600 RC_L support.
- Introduce PCIe RC functional tests covering both AST2600 and AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/pci-host/aspeed_pcie.h |  42 ++++++++
 hw/pci-host/aspeed_pcie.c         | 157 ++++++++++++++++++++++++++++++
 hw/arm/Kconfig                    |   3 +
 hw/pci-host/Kconfig               |   4 +
 hw/pci-host/meson.build           |   1 +
 hw/pci-host/trace-events          |   4 +
 6 files changed, 211 insertions(+)
 create mode 100644 include/hw/pci-host/aspeed_pcie.h
 create mode 100644 hw/pci-host/aspeed_pcie.c

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
new file mode 100644
index 0000000000..d9fb829048
--- /dev/null
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -0,0 +1,42 @@
+/*
+ * ASPEED PCIe Host Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ * Copyright (c) 2022 Cédric Le Goater <clg@kaod.org>
+ *
+ * Authors:
+ *   Cédric Le Goater <clg@kaod.org>
+ *   Jamin Lin <jamin_lin@aspeedtech.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Based on previous work from Cédric Le Goater.
+ * Modifications extend support for the ASPEED AST2600 and AST2700 platforms.
+ */
+
+#ifndef ASPEED_PCIE_H
+#define ASPEED_PCIE_H
+
+#include "hw/sysbus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_host.h"
+#include "qom/object.h"
+
+#define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
+OBJECT_DECLARE_TYPE(AspeedPCIEPhyState, AspeedPCIEPhyClass, ASPEED_PCIE_PHY);
+
+struct AspeedPCIEPhyState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t *regs;
+    uint32_t id;
+};
+
+struct AspeedPCIEPhyClass {
+    SysBusDeviceClass parent_class;
+
+    uint64_t nr_regs;
+};
+
+#endif /* ASPEED_PCIE_H */
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
new file mode 100644
index 0000000000..4c74520052
--- /dev/null
+++ b/hw/pci-host/aspeed_pcie.c
@@ -0,0 +1,157 @@
+/*
+ * ASPEED PCIe Host Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ * Copyright (c) 2022 Cédric Le Goater <clg@kaod.org>
+ *
+ * Authors:
+ *   Cédric Le Goater <clg@kaod.org>
+ *   Jamin Lin <jamin_lin@aspeedtech.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Based on previous work from Cédric Le Goater.
+ * Modifications extend support for the ASPEED AST2600 and AST2700 platforms.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+#include "hw/irq.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci-host/aspeed_pcie.h"
+#include "hw/pci/msi.h"
+#include "trace.h"
+
+/*
+ * PCIe PHY
+ *
+ * PCIe Host Controller (PCIEH)
+ */
+
+/* AST2600 */
+REG32(PEHR_ID,     0x00)
+    FIELD(PEHR_ID, DEV, 16, 16)
+REG32(PEHR_CLASS_CODE,  0x04)
+REG32(PEHR_DATALINK,    0x10)
+REG32(PEHR_PROTECT,     0x7C)
+    FIELD(PEHR_PROTECT, LOCK, 0, 8)
+REG32(PEHR_LINK,        0xC0)
+    FIELD(PEHR_LINK, STS, 5, 1)
+
+#define ASPEED_PCIE_PHY_UNLOCK  0xA8
+
+static uint64_t aspeed_pcie_phy_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(opaque);
+    uint32_t reg = addr >> 2;
+    uint32_t value = 0;
+
+    value = s->regs[reg];
+
+    trace_aspeed_pcie_phy_read(s->id, addr, value);
+
+    return value;
+}
+
+static void aspeed_pcie_phy_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned int size)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(opaque);
+    uint32_t reg = addr >> 2;
+
+    trace_aspeed_pcie_phy_write(s->id, addr, data);
+
+    switch (reg) {
+    case R_PEHR_PROTECT:
+        data &= R_PEHR_PROTECT_LOCK_MASK;
+        s->regs[reg] = !!(data == ASPEED_PCIE_PHY_UNLOCK);
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_pcie_phy_ops = {
+    .read = aspeed_pcie_phy_read,
+    .write = aspeed_pcie_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_pcie_phy_reset(DeviceState *dev)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
+
+    memset(s->regs, 0, apc->nr_regs << 2);
+
+    s->regs[R_PEHR_ID] =
+        (0x1150 << R_PEHR_ID_DEV_SHIFT) | PCI_VENDOR_ID_ASPEED;
+    s->regs[R_PEHR_CLASS_CODE] = 0x06040006;
+    s->regs[R_PEHR_DATALINK] = 0xD7040022;
+    s->regs[R_PEHR_LINK] = R_PEHR_LINK_STS_MASK;
+}
+
+static void aspeed_pcie_phy_realize(DeviceState *dev, Error **errp)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = NULL;
+
+    s->regs = g_new(uint32_t, apc->nr_regs);
+    name = g_strdup_printf(TYPE_ASPEED_PCIE_PHY ".regs.%d", s->id);
+    memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_pcie_phy_ops, s, name,
+                          apc->nr_regs << 2);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void aspeed_pcie_phy_unrealize(DeviceState *dev)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+
+    g_free(s->regs);
+    s->regs = NULL;
+}
+
+static const Property aspeed_pcie_phy_props[] = {
+    DEFINE_PROP_UINT32("id", AspeedPCIEPhyState, id, 0),
+};
+
+static void aspeed_pcie_phy_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_CLASS(klass);
+
+    dc->desc = "ASPEED PCIe Phy";
+    dc->realize = aspeed_pcie_phy_realize;
+    dc->unrealize = aspeed_pcie_phy_unrealize;
+    device_class_set_legacy_reset(dc, aspeed_pcie_phy_reset);
+    device_class_set_props(dc, aspeed_pcie_phy_props);
+
+    apc->nr_regs = 0x100 >> 2;
+}
+
+static const TypeInfo aspeed_pcie_phy_info = {
+    .name       = TYPE_ASPEED_PCIE_PHY,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedPCIEPhyState),
+    .class_init = aspeed_pcie_phy_class_init,
+    .class_size = sizeof(AspeedPCIEPhyClass),
+};
+
+static void aspeed_pcie_register_types(void)
+{
+    type_register_static(&aspeed_pcie_phy_info);
+}
+
+type_init(aspeed_pcie_register_types);
+
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3baa6c6c74..b44b85f436 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -541,6 +541,7 @@ config ASPEED_SOC
     bool
     default y
     depends on TCG && ARM
+    imply PCI_DEVICES
     select DS1338
     select FTGMAC100
     select I2C
@@ -561,6 +562,8 @@ config ASPEED_SOC
     select MAX31785
     select FSI_APB2OPB_ASPEED
     select AT24C
+    select PCI_EXPRESS
+    select PCI_EXPRESS_ASPEED
 
 config MPS2
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9824fa188d..8cbb8304a3 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -46,6 +46,10 @@ config PCI_I440FX
     select PCI
     select PAM
 
+config PCI_EXPRESS_ASPEED
+    bool
+    select PCI_EXPRESS
+
 config PCI_EXPRESS_Q35
     bool
     select PCI_EXPRESS
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 937a0f72ac..86b754d0b0 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -2,6 +2,7 @@ pci_ss = ss.source_set()
 pci_ss.add(when: 'CONFIG_PAM', if_true: files('pam.c'))
 pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
 pci_ss.add(when: 'CONFIG_GT64120', if_true: files('gt64120.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_ASPEED', if_true: files('aspeed_pcie.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
 pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'], if_true: files('gpex-acpi.c'))
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 0a816b9aa1..3438516756 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# aspeed_pcie.c
+aspeed_pcie_phy_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
+aspeed_pcie_phy_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
+
 # bonito.c
 bonito_spciconf_small_access(uint64_t addr, unsigned size) "PCI config address is smaller then 32-bit, addr: 0x%"PRIx64", size: %u"
 
-- 
2.43.0


