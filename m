Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0CECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9H-0006GC-Px; Mon, 29 Sep 2025 12:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7t-00032R-7M
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7k-0002q0-IA
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDOIgBzZ8TjNKnVSJQWMRdksQuCdUEEIWoi7a0tldLc=;
 b=iCTE3IfEX+/K8TgCn4tuoODt/1v1RaLEaCneW5/x02R3blwqEPYtTGYiyEGCWCVcFMDud0
 qwYlpoKLJpdlJQgN7/WJmUlNK1AJ4XRmloRiStolpMeYz8WLgEvkZ4Lo7B1OQokPrlZY+Y
 KGhC9Q1MnPpvJGCBt2RQV9n/qE1BUIg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-qi7tNyVLPQOvMMuY4CRQag-1; Mon,
 29 Sep 2025 12:53:11 -0400
X-MC-Unique: qi7tNyVLPQOvMMuY4CRQag-1
X-Mimecast-MFC-AGG-ID: qi7tNyVLPQOvMMuY4CRQag_1759164790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A27841956089; Mon, 29 Sep 2025 16:53:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A5BA1800446; Mon, 29 Sep 2025 16:53:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/32] hw/pci-host/aspeed: Add AST2600 PCIe PHY model
Date: Mon, 29 Sep 2025 18:52:13 +0200
Message-ID: <20250929165230.797471-16-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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
index 000000000000..d9fb829048a0
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
index 000000000000..4c74520052a4
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
index 3baa6c6c7477..b44b85f43612 100644
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
index 9824fa188d6b..8cbb8304a3ff 100644
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
index 937a0f72acf9..86b754d0b0d9 100644
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
index 0a816b9aa129..3438516756db 100644
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
2.51.0


