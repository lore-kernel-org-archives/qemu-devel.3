Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F218DCCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8x-00055E-NT; Mon, 29 Sep 2025 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7v-000340-Pf
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7r-0002rb-JU
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Vn6nVn2grX6v9kVJ/qtx8Oz9nupBzYh0oWeeiOEkg0=;
 b=IRORjZnVvj98qYf6z3WbOOEWLlCKBG2qjZs6NOm6Nz7e9qiuLjaWvC6GgUsMRXImMmRD/r
 DbDOhZUEKV7oTtQmJICPscrlATJFdutPlLA+fDiQEIsjbyhr/TNnw01lmTaj6A72DiSuCo
 Jh6teiXi1k0HRAAj4PvfKuGGrSs3+FU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-8jg3zkipNoqkanZoRXKmsg-1; Mon,
 29 Sep 2025 12:53:18 -0400
X-MC-Unique: 8jg3zkipNoqkanZoRXKmsg-1
X-Mimecast-MFC-AGG-ID: 8jg3zkipNoqkanZoRXKmsg_1759164797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 549071800451; Mon, 29 Sep 2025 16:53:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B12491800452; Mon, 29 Sep 2025 16:53:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/32] hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make
 address configurable
Date: Mon, 29 Sep 2025 18:52:16 +0200
Message-ID: <20250929165230.797471-19-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce an ASPEED PCIe Root Port and wire it under the RC. The root port
is modeled as TYPE_ASPEED_PCIE_ROOT_PORT (subclass of TYPE_PCIE_ROOT_PORT).

Key changes:
- Add TYPE_ASPEED_PCIE_ROOT_PORT (PCIESlot-based) with vendor/device IDs
  and AER capability offset.
- Extend AspeedPCIERcState to embed a root_port instance and a
  configurable rp_addr.
- Add "rp-addr" property to the RC to place the root port at a specific
  devfn on the root bus.
- Set the root port's "chassis" property to ensure a unique chassis per RC.
- Extend AspeedPCIECfgClass with rc_rp_addr defaulting to PCI_DEVFN(8,0).

Rationale:
- AST2600 places the root port at 80:08.0 (bus 0x80, dev 8, fn 0).
- AST2700 must place the root port at 00:00.0, and it supports three RCs.
  Each root port must therefore be uniquely identifiable; uses the
  PCIe "chassis" ID for that.
- Providing a configurable "rp-addr" lets platforms select the correct
  devfn per SoC family, while the "chassis" property ensures uniqueness
  across multiple RC instances on AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h | 11 +++++++
 hw/pci-host/aspeed_pcie.c         | 50 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index fe30ac02aeee..5346c15c8101 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -20,6 +20,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
 typedef struct AspeedPCIECfgTxDesc {
@@ -40,6 +41,13 @@ typedef struct AspeedPCIERegMap {
     AspeedPCIERcRegs rc;
 } AspeedPCIERegMap;
 
+#define TYPE_ASPEED_PCIE_ROOT_PORT "aspeed.pcie-root-port"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootPortState, ASPEED_PCIE_ROOT_PORT)
+
+typedef struct AspeedPCIERootPortState {
+    PCIESlot parent_obj;
+} AspeedPCIERootPortState;
+
 #define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
 
@@ -58,12 +66,14 @@ struct AspeedPCIERcState {
     MemoryRegion mmio;
     MemoryRegion io;
 
+    uint32_t rp_addr;
     uint32_t bus_nr;
     char name[16];
     bool has_rd;
     qemu_irq irq;
 
     AspeedPCIERootDeviceState root_device;
+    AspeedPCIERootPortState root_port;
 };
 
 /* Bridge between AHB bus and PCIe RC. */
@@ -87,6 +97,7 @@ struct AspeedPCIECfgClass {
     const AspeedPCIERegMap *reg_map;
     const MemoryRegionOps *reg_ops;
 
+    uint32_t rc_rp_addr;
     uint64_t rc_bus_nr;
     uint64_t nr_regs;
     bool rc_has_rd;
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 6e563a07a3f2..dafffbde61b9 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -21,6 +21,7 @@
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/pci-host/aspeed_pcie.h"
 #include "hw/pci/msi.h"
 #include "trace.h"
@@ -63,6 +64,32 @@ static const TypeInfo aspeed_pcie_root_device_info = {
     },
 };
 
+/*
+ * PCIe Root Port
+ */
+
+static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+
+    dc->desc = "ASPEED PCIe Root Port";
+    k->vendor_id = PCI_VENDOR_ID_ASPEED;
+    k->device_id = 0x1150;
+    dc->user_creatable = true;
+
+    rpc->aer_offset = 0x100;
+}
+
+static const TypeInfo aspeed_pcie_root_port_info = {
+    .name = TYPE_ASPEED_PCIE_ROOT_PORT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(AspeedPCIERootPortState),
+    .class_init = aspeed_pcie_root_port_class_init,
+};
+
 /*
  * PCIe Root Complex (RC)
  */
@@ -144,6 +171,13 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    /* setup root port */
+    qdev_prop_set_int32(DEVICE(&rc->root_port), "addr", rc->rp_addr);
+    qdev_prop_set_uint16(DEVICE(&rc->root_port), "chassis", cfg->id);
+    if (!qdev_realize(DEVICE(&rc->root_port), BUS(pci->bus), errp)) {
+        return;
+    }
 }
 
 static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
@@ -158,9 +192,19 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
     return rc->name;
 }
 
+static void aspeed_pcie_rc_instance_init(Object *obj)
+{
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(obj);
+    AspeedPCIERootPortState *root_port = &rc->root_port;
+
+    object_initialize_child(obj, "root_port", root_port,
+                            TYPE_ASPEED_PCIE_ROOT_PORT);
+}
+
 static const Property aspeed_pcie_rc_props[] = {
     DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
     DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
+    DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
 };
 
 static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
@@ -183,6 +227,7 @@ static const TypeInfo aspeed_pcie_rc_info = {
     .name = TYPE_ASPEED_PCIE_RC,
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(AspeedPCIERcState),
+    .instance_init = aspeed_pcie_rc_instance_init,
     .class_init = aspeed_pcie_rc_class_init,
 };
 
@@ -455,6 +500,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->rc), "has-rd",
                             apc->rc_has_rd,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->rc), "rp-addr",
+                            apc->rc_rp_addr,
+                            &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
         return;
     }
@@ -488,6 +536,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->nr_regs = 0x100 >> 2;
     apc->rc_bus_nr = 0x80;
     apc->rc_has_rd = true;
+    apc->rc_rp_addr = PCI_DEVFN(8, 0);
 }
 
 static const TypeInfo aspeed_pcie_cfg_info = {
@@ -626,6 +675,7 @@ static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
     type_register_static(&aspeed_pcie_root_device_info);
+    type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
 }
-- 
2.51.0


