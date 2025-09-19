Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFA2CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXSO-0003UY-DW; Fri, 19 Sep 2025 05:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSM-0003Tg-2H; Fri, 19 Sep 2025 05:31:06 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSJ-0001GX-6u; Fri, 19 Sep 2025 05:31:05 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 17:30:19 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 17:30:19 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 04/14] hw/pci-host/aspeed: Add AST2600 PCIe Root Device
 support
Date: Fri, 19 Sep 2025 17:30:03 +0800
Message-ID: <20250919093017.338309-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
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

Introduce a PCIe Root Device for AST2600 platform.

The AST2600 root complex exposes a PCIe root device at bus 80, devfn 0.
This root device is implemented as a child of the PCIe RC and modeled
as a host bridge PCI function (class_id = PCI_CLASS_BRIDGE_HOST).

Key changes:
- Add a new device type "aspeed.pcie-root-device".
- Instantiate the root device as part of AspeedPCIERcState.
- Initialize it during RC realize() and attach it to the root bus.
- Mark the root device as non-user-creatable.
- Add RC boolean property "has-rd" to control whether the Root Device is
  created (platforms can enable/disable it as needed).

Note: Only AST2600 implements this PCIe root device. AST2700 does not
provide one.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h | 11 ++++++
 hw/pci-host/aspeed_pcie.c         | 56 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 850d579189..fe30ac02ae 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -40,6 +40,13 @@ typedef struct AspeedPCIERegMap {
     AspeedPCIERcRegs rc;
 } AspeedPCIERegMap;
 
+#define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
+
+struct AspeedPCIERootDeviceState {
+    PCIBridge parent_obj;
+};
+
 #define TYPE_ASPEED_PCIE_RC "aspeed.pcie-rc"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
 
@@ -53,7 +60,10 @@ struct AspeedPCIERcState {
 
     uint32_t bus_nr;
     char name[16];
+    bool has_rd;
     qemu_irq irq;
+
+    AspeedPCIERootDeviceState root_device;
 };
 
 /* Bridge between AHB bus and PCIe RC. */
@@ -79,6 +89,7 @@ struct AspeedPCIECfgClass {
 
     uint64_t rc_bus_nr;
     uint64_t nr_regs;
+    bool rc_has_rd;
 };
 
 #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index c3e92ee449..6e563a07a3 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -25,6 +25,44 @@
 #include "hw/pci/msi.h"
 #include "trace.h"
 
+/*
+ * PCIe Root Device
+ * This device exists only on AST2600.
+ */
+
+static void aspeed_pcie_root_device_class_init(ObjectClass *klass,
+                                               const void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "ASPEED PCIe Root Device";
+    k->vendor_id = PCI_VENDOR_ID_ASPEED;
+    k->device_id = 0x2600;
+    k->class_id = PCI_CLASS_BRIDGE_HOST;
+    k->subsystem_vendor_id = k->vendor_id;
+    k->subsystem_id = k->device_id;
+    k->revision = 0;
+
+    /*
+     * PCI-facing part of the host bridge,
+     * not usable without the host-facing part
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo aspeed_pcie_root_device_info = {
+    .name = TYPE_ASPEED_PCIE_ROOT_DEVICE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(AspeedPCIERootDeviceState),
+    .class_init = aspeed_pcie_root_device_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
 /*
  * PCIe Root Complex (RC)
  */
@@ -94,6 +132,18 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
                                      aspeed_pcie_rc_map_irq, rc, &rc->mmio,
                                      &rc->io, 0, 4, TYPE_PCIE_BUS);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
+
+    /* setup root device */
+    if (rc->has_rd) {
+        object_initialize_child(OBJECT(rc), "root_device", &rc->root_device,
+                                TYPE_ASPEED_PCIE_ROOT_DEVICE);
+        qdev_prop_set_int32(DEVICE(&rc->root_device), "addr",
+                            PCI_DEVFN(0, 0));
+        qdev_prop_set_bit(DEVICE(&rc->root_device), "multifunction", false);
+        if (!qdev_realize(DEVICE(&rc->root_device), BUS(pci->bus), errp)) {
+            return;
+        }
+    }
 }
 
 static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
@@ -110,6 +160,7 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
 
 static const Property aspeed_pcie_rc_props[] = {
     DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
+    DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
 };
 
 static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
@@ -401,6 +452,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->rc), "bus-nr",
                             apc->rc_bus_nr,
                             &error_abort);
+    object_property_set_bool(OBJECT(&s->rc), "has-rd",
+                            apc->rc_has_rd,
+                            &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
         return;
     }
@@ -433,6 +487,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->reg_map = &aspeed_regmap;
     apc->nr_regs = 0x100 >> 2;
     apc->rc_bus_nr = 0x80;
+    apc->rc_has_rd = true;
 }
 
 static const TypeInfo aspeed_pcie_cfg_info = {
@@ -570,6 +625,7 @@ static const TypeInfo aspeed_pcie_phy_info = {
 static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
+    type_register_static(&aspeed_pcie_root_device_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
 }
-- 
2.43.0


