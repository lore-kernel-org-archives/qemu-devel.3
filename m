Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H97-0005qT-5O; Mon, 29 Sep 2025 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7z-000365-Ko
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7p-0002r1-1y
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMQ09e9vXh5/byIKtF+KkYbM5QrTWVZAKyzfEhkyjlU=;
 b=bWfrQ6ACDnrv6HFffbgcoUEBrAmtX3ESjy8ai3jxDMPfMW7V0D6OY4WdLbzDYmAZ2XHSTv
 uJs+wPzIWkGAJoPCM4EqK0TXjU9hY0+Zh5++XweDuVNhYkffSg4Zgs2VdoWVI1Ko0GCKJv
 r+C1HaarMDGNbRYsH/RZifPIQ3md9cA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-Fwu6cq77PbWCGStKNblhiw-1; Mon,
 29 Sep 2025 12:53:16 -0400
X-MC-Unique: Fwu6cq77PbWCGStKNblhiw-1
X-Mimecast-MFC-AGG-ID: Fwu6cq77PbWCGStKNblhiw_1759164795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325F91800366; Mon, 29 Sep 2025 16:53:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F10F1800446; Mon, 29 Sep 2025 16:53:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/32] hw/pci-host/aspeed: Add AST2600 PCIe Root Device support
Date: Mon, 29 Sep 2025 18:52:15 +0200
Message-ID: <20250929165230.797471-18-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h | 11 ++++++
 hw/pci-host/aspeed_pcie.c         | 56 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 850d579189eb..fe30ac02aeee 100644
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
index c3e92ee44926..6e563a07a3f2 100644
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
2.51.0


