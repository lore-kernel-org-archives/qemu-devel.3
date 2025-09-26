Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD764CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v294D-000880-7v; Fri, 26 Sep 2025 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2946-0007g7-44
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293x-0004y6-9N
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdEZfBJzVpy7Ad5MzBbnijgJmMQ8cW6ZTpvVSOCIqvU=;
 b=FkaZA8o0moqqc5idqD/EQut27kpuVrfE3vVZE2WvlwSyEw6aQAPSL8eH9edSaDC7ApKLmy
 oHryeAWFRoRPYjlqPcCbjPZAbZbtNHJeIDEAw10DU9LmtGySdZrKqJ2J0IVVPp6vMs1tWN
 lfQ9Ssp9mJg6WvbaPUfEqe/YXeb400s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-ezbyWXSDPZez-YOS7vp0aA-1; Fri,
 26 Sep 2025 10:04:30 -0400
X-MC-Unique: ezbyWXSDPZez-YOS7vp0aA-1
X-Mimecast-MFC-AGG-ID: ezbyWXSDPZez-YOS7vp0aA_1758895469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BE621800577; Fri, 26 Sep 2025 14:04:29 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A1C51956095; Fri, 26 Sep 2025 14:04:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 30/32] hw: define most common PCI types as secure
Date: Fri, 26 Sep 2025 15:01:41 +0100
Message-ID: <20250926140144.1998694-31-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Everything except for the simba pci-bridge is relevant to use in
a virtualization use case, so must be considered secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-bridge/cxl_downstream.c      | 1 +
 hw/pci-bridge/cxl_root_port.c       | 1 +
 hw/pci-bridge/cxl_upstream.c        | 1 +
 hw/pci-bridge/gen_pcie_root_port.c  | 1 +
 hw/pci-bridge/i82801b11.c           | 1 +
 hw/pci-bridge/ioh3420.c             | 1 +
 hw/pci-bridge/pci_bridge_dev.c      | 2 ++
 hw/pci-bridge/pci_expander_bridge.c | 8 ++++++++
 hw/pci-bridge/pcie_pci_bridge.c     | 1 +
 hw/pci-bridge/pcie_root_port.c      | 1 +
 hw/pci-bridge/simba.c               | 1 +
 hw/pci-bridge/xio3130_downstream.c  | 1 +
 hw/pci-bridge/xio3130_upstream.c    | 1 +
 hw/pci/pci.c                        | 7 +++++++
 hw/pci/pci_bridge.c                 | 1 +
 hw/pci/pci_host.c                   | 1 +
 hw/pci/pcie_host.c                  | 1 +
 hw/pci/pcie_port.c                  | 1 +
 18 files changed, 32 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1065245a8b..23f6ece002 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -241,6 +241,7 @@ static const TypeInfo cxl_dsp_info = {
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
     .class_init = cxl_dsp_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e6a4035d26..83b34330bc 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -294,6 +294,7 @@ static const TypeInfo cxl_root_port_info = {
     .parent = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(CXLRootPort),
     .class_init = cxl_root_port_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CXL_DEVICE },
         { }
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 208e0c6172..eba6fe2482 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -394,6 +394,7 @@ static const TypeInfo cxl_usp_info = {
     .parent = TYPE_PCIE_PORT,
     .instance_size = sizeof(CXLUpstreamPort),
     .class_init = cxl_upstream_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783b..d9e1ce8d90 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -173,6 +173,7 @@ static const TypeInfo gen_rp_dev_info = {
     .parent        = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(GenPCIERootPort),
     .class_init    = gen_rp_dev_class_init,
+    .secure        = true,
 };
 
  static void gen_rp_register_types(void)
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 1d73c14c1f..f702b20bcd 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -107,6 +107,7 @@ static const TypeInfo i82801b11_bridge_info = {
     .parent        = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(I82801b11Bridge),
     .class_init    = i82801b11_bridge_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index bba640f495..2c4882c4cf 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -120,6 +120,7 @@ static const TypeInfo ioh3420_info = {
     .name          = "ioh3420",
     .parent        = TYPE_PCIE_ROOT_PORT,
     .class_init    = ioh3420_class_init,
+    .secure        = true,
 };
 
 static void ioh3420_register_types(void)
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b328e50ab3..04af66cc35 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -268,6 +268,7 @@ static const TypeInfo pci_bridge_dev_info = {
     .instance_size     = sizeof(PCIBridgeDev),
     .class_init        = pci_bridge_dev_class_init,
     .instance_finalize = pci_bridge_dev_instance_finalize,
+    .secure            = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -294,6 +295,7 @@ static const TypeInfo pci_bridge_dev_seat_info = {
     .parent            = TYPE_PCI_BRIDGE_DEV,
     .instance_size     = sizeof(PCIBridgeDev),
     .class_init        = pci_bridge_dev_seat_class_init,
+    .secure            = true,
 };
 
 static void pci_bridge_dev_register(void)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4..4a85f62be0 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -109,6 +109,7 @@ static const TypeInfo pxb_bus_info = {
     .parent        = TYPE_PCI_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pxb_pcie_bus_info = {
@@ -116,6 +117,7 @@ static const TypeInfo pxb_pcie_bus_info = {
     .parent        = TYPE_PCIE_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pxb_cxl_bus_info = {
@@ -123,6 +125,7 @@ static const TypeInfo pxb_cxl_bus_info = {
     .parent        = TYPE_CXL_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
+    .secure        = true,
 };
 
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
@@ -185,6 +188,7 @@ static const TypeInfo pxb_host_info = {
     .name          = TYPE_PXB_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .class_init    = pxb_host_class_init,
+    .secure        = true,
 };
 
 static void pxb_cxl_realize(DeviceState *dev, Error **errp)
@@ -244,6 +248,7 @@ static const TypeInfo cxl_host_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(CXLHost),
     .class_init    = pxb_cxl_host_class_init,
+    .secure        = true,
 };
 
 /*
@@ -448,6 +453,7 @@ static const TypeInfo pxb_dev_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PXBDev),
     .class_init    = pxb_dev_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -485,6 +491,7 @@ static const TypeInfo pxb_pcie_dev_info = {
     .parent        = TYPE_PXB_DEV,
     .instance_size = sizeof(PXBPCIEDev),
     .class_init    = pxb_pcie_dev_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -535,6 +542,7 @@ static const TypeInfo pxb_cxl_dev_info = {
     .parent        = TYPE_PXB_PCIE_DEV,
     .instance_size = sizeof(PXBCXLDev),
     .class_init    = pxb_cxl_dev_class_init,
+    .secure        = true,
     .interfaces =
         (const InterfaceInfo[]){
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fce292a519..620eb12a64 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -162,6 +162,7 @@ static const TypeInfo pcie_pci_bridge_info = {
         .parent = TYPE_PCI_BRIDGE,
         .instance_size = sizeof(PCIEPCIBridge),
         .class_init = pcie_pci_bridge_class_init,
+        .secure = true,
         .interfaces = (const InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
             { INTERFACE_PCIE_DEVICE },
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 22c2fdb71e..c87fb91e5c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -187,6 +187,7 @@ static const TypeInfo rp_info = {
     .instance_post_init = rp_instance_post_init,
     .class_init    = rp_class_init,
     .abstract      = true,
+    .secure        = true,
     .class_size = sizeof(PCIERootPortClass),
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index bbae594e11..3dbb5bd9c9 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -87,6 +87,7 @@ static const TypeInfo simba_pci_bridge_info = {
     .parent        = TYPE_PCI_BRIDGE,
     .class_init    = simba_pci_bridge_class_init,
     .instance_size = sizeof(SimbaPCIBridge),
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index dc7d1aa7d7..eb217dc7d9 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -175,6 +175,7 @@ static const TypeInfo xio3130_downstream_info = {
     .name          = TYPE_XIO3130_DOWNSTREAM,
     .parent        = TYPE_PCIE_SLOT,
     .class_init    = xio3130_downstream_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749b..9d58105f8b 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -144,6 +144,7 @@ static const TypeInfo xio3130_upstream_info = {
     .name          = "x3130-upstream",
     .parent        = TYPE_PCIE_PORT,
     .class_init    = xio3130_upstream_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c3df9d6656..6ab03074b9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -289,6 +289,7 @@ static const TypeInfo pci_bus_info = {
     .instance_size = sizeof(PCIBus),
     .class_size = sizeof(PCIBusClass),
     .class_init = pci_bus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
@@ -298,16 +299,19 @@ static const TypeInfo pci_bus_info = {
 static const TypeInfo cxl_interface_info = {
     .name          = INTERFACE_CXL_DEVICE,
     .parent        = TYPE_INTERFACE,
+    .secure        = true,
 };
 
 static const TypeInfo pcie_interface_info = {
     .name          = INTERFACE_PCIE_DEVICE,
     .parent        = TYPE_INTERFACE,
+    .secure        = true,
 };
 
 static const TypeInfo conventional_pci_interface_info = {
     .name          = INTERFACE_CONVENTIONAL_PCI_DEVICE,
     .parent        = TYPE_INTERFACE,
+    .secure        = true,
 };
 
 static void pcie_bus_class_init(ObjectClass *klass, const void *data)
@@ -321,12 +325,14 @@ static const TypeInfo pcie_bus_info = {
     .name = TYPE_PCIE_BUS,
     .parent = TYPE_PCI_BUS,
     .class_init = pcie_bus_class_init,
+    .secure = true,
 };
 
 static const TypeInfo cxl_bus_info = {
     .name       = TYPE_CXL_BUS,
     .parent     = TYPE_PCIE_BUS,
     .class_init = pcie_bus_class_init,
+    .secure     = true,
 };
 
 static void pci_update_mappings(PCIDevice *d);
@@ -3336,6 +3342,7 @@ static const TypeInfo pci_device_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(PCIDeviceClass),
     .class_init = pci_device_class_init,
     .class_base_init = pci_device_class_base_init,
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 76255c4cd8..703160a338 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -497,6 +497,7 @@ static const TypeInfo pci_bridge_type_info = {
     .instance_size = sizeof(PCIBridge),
     .class_init = pci_bridge_class_init,
     .abstract = true,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7179d99178..b3bbba3799 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -251,6 +251,7 @@ static const TypeInfo pci_host_type_info = {
     .name = TYPE_PCI_HOST_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(PCIHostBridgeClass),
     .instance_size = sizeof(PCIHostState),
     .class_init = pci_host_class_init,
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 3717e1a086..3cf0769d2a 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -124,6 +124,7 @@ static const TypeInfo pcie_host_type_info = {
     .name = TYPE_PCIE_HOST_BRIDGE,
     .parent = TYPE_PCI_HOST_BRIDGE,
     .abstract = true,
+    .secure = true,
     .instance_size = sizeof(PCIExpressHost),
     .instance_init = pcie_host_init,
 };
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index f3841a2656..abc1dbd470 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -200,6 +200,7 @@ static const TypeInfo pcie_port_type_info = {
     .parent = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(PCIEPort),
     .abstract = true,
+    .secure = true,
     .class_init = pcie_port_class_init,
 };
 
-- 
2.50.1


