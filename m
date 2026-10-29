Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63040606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JibhmSYJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPxp-0000xb-5z; Thu, 29 Oct 2026 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwj-000839-IV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwf-0006If-Q6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqvFAlHBBdzci0WB+ufjXYPcJTgtNRQmm5ybFSnF37s=;
 b=JibhmSYJoW2wsbeS1kRKiPr1BHY4OOTeHrvCV8KKh2ZaASg4HfGemu7J3yIPrx5wf1DPcB
 rjp31RQKCmGa4ux7Dy1vLLa98YIzOuHJa4sdUSm3oNIkEDa0skzLAnxdSBfmxRh0T+ubHl
 vKBpMTHUHDw72/R82Yjt3I68ryCRIZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-hWAsStChPaCgRIXLFxlqsw-1; Thu,
 29 Oct 2026 09:13:23 -0400
X-MC-Unique: hWAsStChPaCgRIXLFxlqsw-1
X-Mimecast-MFC-AGG-ID: hWAsStChPaCgRIXLFxlqsw_1793279602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A0F1955F44; Thu, 29 Oct 2026 13:13:22 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B50323000723; Thu, 29 Oct 2026 13:13:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/28] hw: define most common PCI types as secure
Date: Thu, 29 Oct 2026 13:12:26 +0000
Message-ID: <20261029131241.2275706-14-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Essentially all PCI infrastructure is in scope for the virtualization
use case, aside from the niche simba bridge and the CXL related pieces.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-bridge/gen_pcie_root_port.c  | 1 +
 hw/pci-bridge/i82801b11.c           | 1 +
 hw/pci-bridge/ioh3420.c             | 1 +
 hw/pci-bridge/pci_bridge_dev.c      | 2 ++
 hw/pci-bridge/pci_expander_bridge.c | 5 +++++
 hw/pci-bridge/pcie_pci_bridge.c     | 1 +
 hw/pci-bridge/xio3130_downstream.c  | 1 +
 hw/pci-bridge/xio3130_upstream.c    | 1 +
 hw/pci/pci.c                        | 4 ++++
 9 files changed, 17 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 5434d693d92..65d29eab38e 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -161,6 +161,7 @@ static const TypeInfo gen_rp_dev_info = {
     .parent        = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(GenPCIERootPort),
     .class_init    = gen_rp_dev_class_init,
+    .secure        = true,
 };
 
  static void gen_rp_register_types(void)
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 1d73c14c1f8..f702b20bcd5 100644
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
index bba640f495b..2c4882c4cf1 100644
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
index bc53bcb69d8..86e8daaa068 100644
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
index 40ffbc4e082..b6df3f89ca4 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -114,6 +114,7 @@ static const TypeInfo pxb_bus_info = {
     .parent        = TYPE_PCI_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pxb_pcie_bus_info = {
@@ -121,6 +122,7 @@ static const TypeInfo pxb_pcie_bus_info = {
     .parent        = TYPE_PCIE_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pxb_cxl_bus_info = {
@@ -190,6 +192,7 @@ static const TypeInfo pxb_host_info = {
     .name          = TYPE_PXB_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .class_init    = pxb_host_class_init,
+    .secure        = true,
 };
 
 static void pxb_cxl_realize(DeviceState *dev, Error **errp)
@@ -453,6 +456,7 @@ static const TypeInfo pxb_dev_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PXBDev),
     .class_init    = pxb_dev_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -490,6 +494,7 @@ static const TypeInfo pxb_pcie_dev_info = {
     .parent        = TYPE_PXB_DEV,
     .instance_size = sizeof(PXBPCIEDev),
     .class_init    = pxb_pcie_dev_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index e826fb2829f..03b6b1c0f54 100644
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
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053b..ded948ebd0f 100644
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
index 40057b749bf..9d58105f8bd 100644
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
index 0efb4eb4bb0..f5af3e743d9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -319,6 +319,7 @@ static const TypeInfo pci_bus_info = {
     .instance_size = sizeof(PCIBus),
     .class_size = sizeof(PCIBusClass),
     .class_init = pci_bus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
@@ -333,11 +334,13 @@ static const TypeInfo cxl_interface_info = {
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
@@ -351,6 +354,7 @@ static const TypeInfo pcie_bus_info = {
     .name = TYPE_PCIE_BUS,
     .parent = TYPE_PCI_BUS,
     .class_init = pcie_bus_class_init,
+    .secure = true,
 };
 
 static const TypeInfo cxl_bus_info = {
-- 
2.56.0


