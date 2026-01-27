Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230DD2592A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgU-0004GB-K6; Mon, 26 Jan 2026 22:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgS-0004FV-Sz; Mon, 26 Jan 2026 22:24:04 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgR-0003Z2-Ar; Mon, 26 Jan 2026 22:24:04 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 11:23:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 11:23:49 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/7] hw/pci-host/aspeed_pcie: Drop AST2600 PCIe root device
Date: Tue, 27 Jan 2026 11:23:38 +0800
Message-ID: <20260127032348.2238527-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2600 PCIe previously exposed a root bus at 0x80 with both a
root device at 80:00.0 and a root port at 80:08.0.

Recent ASPEED SDK PCIe driver updates decided to remove the root
device and keep only a single root port. This behavior has already
been accepted by the upstream Linux kernel.

Update the QEMU PCIe model accordingly by dropping the root device
implementation and related properties. AST2600 now matches the
AST2700 PCIe topology and no longer supports the legacy RC_L
layout.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/pci-host/aspeed_pcie.h |  9 -----
 hw/pci-host/aspeed_pcie.c         | 57 -------------------------------
 2 files changed, 66 deletions(-)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index e660119a45..fde5816ea3 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -50,13 +50,6 @@ typedef struct AspeedPCIERootPortState {
     PCIESlot parent_obj;
 } AspeedPCIERootPortState;
 
-#define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
-
-struct AspeedPCIERootDeviceState {
-    PCIBridge parent_obj;
-};
-
 #define TYPE_ASPEED_PCIE_RC "aspeed.pcie-rc"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
 
@@ -78,10 +71,8 @@ struct AspeedPCIERcState {
     uint32_t rp_addr;
     uint32_t bus_nr;
     char name[16];
-    bool has_rd;
     qemu_irq irq;
 
-    AspeedPCIERootDeviceState root_device;
     AspeedPCIERootPortState root_port;
 };
 
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 83a1c7075c..4fdda95939 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -26,44 +26,6 @@
 #include "hw/pci/msi.h"
 #include "trace.h"
 
-/*
- * PCIe Root Device
- * This device exists only on AST2600.
- */
-
-static void aspeed_pcie_root_device_class_init(ObjectClass *klass,
-                                               const void *data)
-{
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->desc = "ASPEED PCIe Root Device";
-    k->vendor_id = PCI_VENDOR_ID_ASPEED;
-    k->device_id = 0x2600;
-    k->class_id = PCI_CLASS_BRIDGE_HOST;
-    k->subsystem_vendor_id = k->vendor_id;
-    k->subsystem_id = k->device_id;
-    k->revision = 0;
-
-    /*
-     * PCI-facing part of the host bridge,
-     * not usable without the host-facing part
-     */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo aspeed_pcie_root_device_info = {
-    .name = TYPE_ASPEED_PCIE_ROOT_DEVICE,
-    .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(AspeedPCIERootDeviceState),
-    .class_init = aspeed_pcie_root_device_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 /*
  * PCIe Root Port
  */
@@ -291,18 +253,6 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
                                 &rc->dram_alias);
     pci_setup_iommu(pci->bus, &aspeed_pcie_rc_iommu_ops, rc);
 
-    /* setup root device */
-    if (rc->has_rd) {
-        object_initialize_child(OBJECT(rc), "root_device", &rc->root_device,
-                                TYPE_ASPEED_PCIE_ROOT_DEVICE);
-        qdev_prop_set_int32(DEVICE(&rc->root_device), "addr",
-                            PCI_DEVFN(0, 0));
-        qdev_prop_set_bit(DEVICE(&rc->root_device), "multifunction", false);
-        if (!qdev_realize(DEVICE(&rc->root_device), BUS(pci->bus), errp)) {
-            return;
-        }
-    }
-
     /* setup root port */
     qdev_prop_set_int32(DEVICE(&rc->root_port), "addr", rc->rp_addr);
     qdev_prop_set_uint16(DEVICE(&rc->root_port), "chassis", cfg->id);
@@ -334,7 +284,6 @@ static void aspeed_pcie_rc_instance_init(Object *obj)
 
 static const Property aspeed_pcie_rc_props[] = {
     DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
-    DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
     DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
     DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
     DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
@@ -704,9 +653,6 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->rc), "bus-nr",
                             apc->rc_bus_nr,
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->rc), "has-rd",
-                            apc->rc_has_rd,
-                            &error_abort);
     object_property_set_int(OBJECT(&s->rc), "rp-addr",
                             apc->rc_rp_addr,
                             &error_abort);
@@ -746,7 +692,6 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x1e77005C;
     apc->rc_bus_nr = 0x80;
-    apc->rc_has_rd = true;
     apc->rc_rp_addr = PCI_DEVFN(8, 0);
 }
 
@@ -867,7 +812,6 @@ static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x000000F0;
     apc->rc_bus_nr = 0;
-    apc->rc_has_rd = false;
     apc->rc_rp_addr = PCI_DEVFN(0, 0);
 }
 
@@ -1041,7 +985,6 @@ static const TypeInfo aspeed_2700_pcie_phy_info = {
 static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
-    type_register_static(&aspeed_pcie_root_device_info);
     type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_2700_pcie_cfg_info);
-- 
2.43.0


