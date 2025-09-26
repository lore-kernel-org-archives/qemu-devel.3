Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD0CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v294H-0008DP-2L; Fri, 26 Sep 2025 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2947-0007hy-08
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293y-0004yc-JB
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q62g/KbcRe7YtIuem0CVKfC0XTeagqktRbCs4xq3Gr8=;
 b=OxjRMSiC5pxlGPpV5GNfIBf7fzWlOr6qj2wWY0gUTgE9UnkX0l99cV9Fd4cEUSDRqzJGJw
 u7hpgojZ/0WNhROVviQTOUaR6vVkiP3DakGDT9NOx4hd54GbR12R95pufvAGhYcAqlduRf
 23afVaFXsOYzeNNQijk0CTbC0HlrZeA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-rVkdYpPENbaIT8gMhwU54g-1; Fri,
 26 Sep 2025 10:04:34 -0400
X-MC-Unique: rVkdYpPENbaIT8gMhwU54g-1
X-Mimecast-MFC-AGG-ID: rVkdYpPENbaIT8gMhwU54g_1758895473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F392C18004D4; Fri, 26 Sep 2025 14:04:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D87B1956095; Fri, 26 Sep 2025 14:04:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 31/32] hw/pci-host: define some PCI hosts as secure
Date: Fri, 26 Sep 2025 15:01:42 +0100
Message-ID: <20250926140144.1998694-32-berrange@redhat.com>
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

Most of the PCI host implementations are targetting emulation
use cases. The exceptions to this are i440fx & q35 which are
used commonly on x86, the pnv* which are used on ppc, and
gpex which is used on arm.

There is also a special case for the 'remote' type and the
Xen passthrough type.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-host/articia.c       | 3 +++
 hw/pci-host/astro.c         | 3 +++
 hw/pci-host/bonito.c        | 2 ++
 hw/pci-host/designware.c    | 3 +++
 hw/pci-host/dino.c          | 1 +
 hw/pci-host/fsl_imx8m_phy.c | 1 +
 hw/pci-host/gpex.c          | 2 ++
 hw/pci-host/grackle.c       | 2 ++
 hw/pci-host/gt64120.c       | 2 ++
 hw/pci-host/i440fx.c        | 2 ++
 hw/pci-host/mv64361.c       | 1 +
 hw/pci-host/pnv_phb.c       | 2 ++
 hw/pci-host/pnv_phb3.c      | 3 +++
 hw/pci-host/pnv_phb3_msi.c  | 1 +
 hw/pci-host/pnv_phb3_pbcq.c | 1 +
 hw/pci-host/pnv_phb4.c      | 4 ++++
 hw/pci-host/pnv_phb4_pec.c  | 2 ++
 hw/pci-host/ppc440_pcix.c   | 1 +
 hw/pci-host/ppc4xx_pci.c    | 2 ++
 hw/pci-host/ppce500.c       | 2 ++
 hw/pci-host/q35.c           | 2 ++
 hw/pci-host/raven.c         | 2 ++
 hw/pci-host/remote.c        | 1 +
 hw/pci-host/sabre.c         | 2 ++
 hw/pci-host/sh_pci.c        | 2 ++
 hw/pci-host/uninorth.c      | 2 ++
 hw/pci-host/versatile.c     | 3 +++
 hw/pci-host/xen_igd_pt.c    | 1 +
 hw/pci-host/xilinx-pcie.c   | 1 +
 29 files changed, 56 insertions(+)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index cc65aac2a8..b29fa98d19 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -267,12 +267,14 @@ static const TypeInfo articia_types[] = {
         .parent        = TYPE_PCI_HOST_BRIDGE,
         .instance_size = sizeof(ArticiaState),
         .class_init    = articia_class_init,
+        .secure        = false,
     },
     {
         .name          = TYPE_ARTICIA_PCI_HOST,
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(ArticiaHostState),
         .class_init    = articia_pci_host_class_init,
+        .secure        = false,
         .interfaces = (const InterfaceInfo[]) {
               { INTERFACE_CONVENTIONAL_PCI_DEVICE },
               { },
@@ -283,6 +285,7 @@ static const TypeInfo articia_types[] = {
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(PCIDevice),
         .class_init    = articia_pci_bridge_class_init,
+        .secure        = false,
         .interfaces = (const InterfaceInfo[]) {
               { INTERFACE_CONVENTIONAL_PCI_DEVICE },
               { },
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 1024ede7b6..0685615ecd 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -498,6 +498,7 @@ static const TypeInfo elroy_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(ElroyState),
     .class_init    = elroy_pcihost_class_init,
+    .secure        = false,
 };
 
 static void elroy_register_types(void)
@@ -930,6 +931,7 @@ static const TypeInfo astro_chip_info = {
     .instance_init = astro_init,
     .instance_size = sizeof(AstroState),
     .class_init    = astro_class_init,
+    .secure        = false,
 };
 
 static void astro_iommu_memory_region_class_init(ObjectClass *klass,
@@ -944,6 +946,7 @@ static const TypeInfo astro_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_ASTRO_IOMMU_MEMORY_REGION,
     .class_init = astro_iommu_memory_region_class_init,
+    .secure = false,
 };
 
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7d6251a78d..6d02bde4ee 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -783,6 +783,7 @@ static const TypeInfo bonito_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIBonitoState),
     .class_init    = bonito_pci_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -801,6 +802,7 @@ static const TypeInfo bonito_host_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(BonitoState),
     .class_init    = bonito_host_class_init,
+    .secure        = false,
 };
 
 static void bonito_register_types(void)
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8..ee1205977e 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -757,17 +757,20 @@ static const TypeInfo designware_pcie_types[] = {
         .parent         = TYPE_PCIE_BUS,
         .instance_size  = sizeof(DesignwarePCIERootBus),
         .class_init     = designware_pcie_root_bus_class_init,
+        .secure         = false,
     }, {
         .name           = TYPE_DESIGNWARE_PCIE_HOST,
         .parent         = TYPE_PCI_HOST_BRIDGE,
         .instance_size  = sizeof(DesignwarePCIEHost),
         .instance_init  = designware_pcie_host_init,
         .class_init     = designware_pcie_host_class_init,
+        .secure         = false,
     }, {
         .name           = TYPE_DESIGNWARE_PCIE_ROOT,
         .parent         = TYPE_PCI_BRIDGE,
         .instance_size  = sizeof(DesignwarePCIERoot),
         .class_init     = designware_pcie_root_class_init,
+        .secure         = false,
         .interfaces     = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 924053499c..9b6375661d 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -506,6 +506,7 @@ static const TypeInfo dino_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(DinoState),
     .class_init    = dino_pcihost_class_init,
+    .secure        = false,
 };
 
 static void dino_register_types(void)
diff --git a/hw/pci-host/fsl_imx8m_phy.c b/hw/pci-host/fsl_imx8m_phy.c
index 04da3f99a0..0a0ed10619 100644
--- a/hw/pci-host/fsl_imx8m_phy.c
+++ b/hw/pci-host/fsl_imx8m_phy.c
@@ -92,6 +92,7 @@ static const TypeInfo fsl_imx8m_pcie_phy_types[] = {
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(FslImx8mPciePhyState),
         .class_init = fsl_imx8m_pcie_phy_class_init,
+        .secure = false,
     }
 };
 
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index b806a2286f..d9486c773d 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -221,6 +221,7 @@ static const TypeInfo gpex_host_info = {
     .instance_size = sizeof(GPEXHost),
     .instance_init = gpex_host_initfn,
     .class_init = gpex_host_class_init,
+    .secure = true,
 };
 
 /****************************************************************************
@@ -261,6 +262,7 @@ static const TypeInfo gpex_root_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(GPEXRootState),
     .class_init = gpex_root_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index f9da5a908c..eb23af9f22 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -116,6 +116,7 @@ static const TypeInfo grackle_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = grackle_pci_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -151,6 +152,7 @@ static const TypeInfo grackle_host_info = {
     .instance_size = sizeof(GrackleState),
     .instance_init = grackle_init,
     .class_init    = grackle_class_init,
+    .secure        = false,
 };
 
 static void grackle_register_types(void)
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b1d96f62fe..fbc763e4ef 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1283,6 +1283,7 @@ static const TypeInfo gt64120_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = gt64120_pci_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -1310,6 +1311,7 @@ static const TypeInfo gt64120_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(GT64120State),
     .class_init    = gt64120_class_init,
+    .secure        = false,
 };
 
 static void gt64120_pci_register_types(void)
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e13bb1b53e..163d4b3ec0 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -341,6 +341,7 @@ static const TypeInfo i440fx_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = i440fx_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -399,6 +400,7 @@ static const TypeInfo i440fx_pcihost_info = {
     .instance_size = sizeof(I440FXState),
     .instance_init = i440fx_pcihost_initfn,
     .class_init    = i440fx_pcihost_class_init,
+    .secure        = true,
 };
 
 static void i440fx_register_types(void)
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index e05b677010..5ac0f29ff2 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -46,6 +46,7 @@ static const TypeInfo mv64361_pcibridge_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = mv64361_pcibridge_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 4b0ced79b0..bd7d116720 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -334,6 +334,7 @@ static const TypeInfo pnv_phb_type_info = {
     .parent        = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(PnvPHB),
     .class_init    = pnv_phb_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pnv_phb_root_port_info = {
@@ -341,6 +342,7 @@ static const TypeInfo pnv_phb_root_port_info = {
     .parent        = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(PnvPHBRootPort),
     .class_init    = pnv_phb_root_port_class_init,
+    .secure        = true,
 };
 
 static void pnv_phb_register_types(void)
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 5d8383fac3..ff0ee5be4d 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -900,6 +900,7 @@ static const TypeInfo pnv_phb3_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
     .class_init = pnv_phb3_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 /*
@@ -1113,6 +1114,7 @@ static const TypeInfo pnv_phb3_type_info = {
     .instance_size = sizeof(PnvPHB3),
     .class_init    = pnv_phb3_class_init,
     .instance_init = pnv_phb3_instance_init,
+    .secure        = true,
 };
 
 static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
@@ -1176,6 +1178,7 @@ static const TypeInfo pnv_phb3_root_bus_info = {
     .parent = TYPE_PCIE_BUS,
     .instance_size = sizeof(PnvPHB3RootBus),
     .class_init = pnv_phb3_root_bus_class_init,
+    .secure = true,
 };
 
 static void pnv_phb3_register_types(void)
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 3a83311faf..265b6d155e 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -306,6 +306,7 @@ static const TypeInfo phb3_msi_info = {
     .class_init = phb3_msi_class_init,
     .class_size = sizeof(ICSStateClass),
     .instance_init = phb3_msi_instance_init,
+    .secure = true,
 };
 
 static void pnv_phb3_msi_register_types(void)
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 1f7a149580..687c832515 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -354,6 +354,7 @@ static const TypeInfo pnv_pbcq_type_info = {
     .instance_size = sizeof(PnvPBCQState),
     .instance_init = phb3_pbcq_instance_init,
     .class_init    = pnv_pbcq_class_init,
+    .secure        = true,
     .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 18992054e8..4dc9730740 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1374,6 +1374,7 @@ static const TypeInfo pnv_phb4_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
     .class_init = pnv_phb4_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 /*
@@ -1715,6 +1716,7 @@ static const TypeInfo pnv_phb4_type_info = {
     .instance_init = pnv_phb4_instance_init,
     .instance_size = sizeof(PnvPHB4),
     .class_init    = pnv_phb4_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_NOTIFIER },
             { },
@@ -1725,6 +1727,7 @@ static const TypeInfo pnv_phb5_type_info = {
     .name          = TYPE_PNV_PHB5,
     .parent        = TYPE_PNV_PHB4,
     .instance_size = sizeof(PnvPHB4),
+    .secure        = true,
 };
 
 static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
@@ -1788,6 +1791,7 @@ static const TypeInfo pnv_phb4_root_bus_info = {
     .parent = TYPE_PCIE_BUS,
     .instance_size = sizeof(PnvPHB4RootBus),
     .class_init = pnv_phb4_root_bus_class_init,
+    .secure = true,
 };
 
 static void pnv_phb4_register_types(void)
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 5bac1c42ed..5f437af7a6 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -388,6 +388,7 @@ static const TypeInfo pnv_pec_type_info = {
     .instance_size = sizeof(PnvPhb4PecState),
     .class_init    = pnv_pec_class_init,
     .class_size    = sizeof(PnvPhb4PecClass),
+    .secure        = true,
     .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
@@ -445,6 +446,7 @@ static const TypeInfo pnv_phb5_pec_type_info = {
     .instance_size = sizeof(PnvPhb4PecState),
     .class_init    = pnv_phb5_pec_class_init,
     .class_size    = sizeof(PnvPhb4PecClass),
+    .secure        = true,
     .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
index 744b85e49c..189b375bfa 100644
--- a/hw/pci-host/ppc440_pcix.c
+++ b/hw/pci-host/ppc440_pcix.c
@@ -532,6 +532,7 @@ static const TypeInfo ppc440_pcix_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC440PCIXState),
     .class_init    = ppc440_pcix_class_init,
+    .secure        = false,
 };
 
 static void ppc440_pcix_register_types(void)
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index 2547817688..51fa5cbe74 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -370,6 +370,7 @@ static const TypeInfo ppc4xx_host_bridge_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = ppc4xx_host_bridge_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -389,6 +390,7 @@ static const TypeInfo ppc4xx_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC4xxPCIState),
     .class_init    = ppc4xx_pcihost_class_init,
+    .secure        = false,
 };
 
 static void ppc4xx_pci_register_types(void)
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 975d191ccb..40b89af66d 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -527,6 +527,7 @@ static const TypeInfo e500_pci_types[] = {
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(PPCE500PCIBridgeState),
         .class_init    = e500_host_bridge_class_init,
+        .secure        = false,
         .interfaces    = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
@@ -537,6 +538,7 @@ static const TypeInfo e500_pci_types[] = {
         .parent        = TYPE_PCI_HOST_BRIDGE,
         .instance_size = sizeof(PPCE500PCIState),
         .class_init    = e500_pcihost_class_init,
+        .secure        = false,
     },
 };
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1951ae440c..a5e9f2f59e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -258,6 +258,7 @@ static const TypeInfo q35_host_info = {
     .instance_size = sizeof(Q35PCIHost),
     .instance_init = q35_host_initfn,
     .class_init = q35_host_class_init,
+    .secure = true,
 };
 
 /****************************************************************************
@@ -703,6 +704,7 @@ static const TypeInfo mch_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MCHPCIState),
     .class_init = mch_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index f8c0be5d21..6fd4f4f6df 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -363,6 +363,7 @@ static const TypeInfo raven_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(RavenPCIState),
     .class_init = raven_class_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -384,6 +385,7 @@ static const TypeInfo raven_pcihost_info = {
     .instance_size = sizeof(PREPPCIState),
     .instance_init = raven_pcihost_initfn,
     .class_init = raven_pcihost_class_init,
+    .secure = false,
 };
 
 static void raven_register_types(void)
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index e6d2af4502..b17a4da6fe 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -64,6 +64,7 @@ static const TypeInfo remote_pcihost_info = {
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(RemotePCIHost),
     .class_init = remote_pcihost_class_init,
+    .secure = true,
 };
 
 static void remote_pcihost_register(void)
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 538624c507..d2ae46695c 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -477,6 +477,7 @@ static const TypeInfo sabre_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(SabrePCIState),
     .class_init    = sabre_pci_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -516,6 +517,7 @@ static const TypeInfo sabre_info = {
     .instance_size = sizeof(SabreState),
     .instance_init = sabre_init,
     .class_init    = sabre_class_init,
+    .secure        = false,
 };
 
 static void sabre_register_types(void)
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 62fb945075..d18832ac98 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -180,11 +180,13 @@ static const TypeInfo sh_pcic_types[] = {
         .parent         = TYPE_PCI_HOST_BRIDGE,
         .instance_size  = sizeof(SHPCIState),
         .class_init     = sh_pcic_host_class_init,
+        .secure         = false,
     }, {
         .name           = "sh_pci_host",
         .parent         = TYPE_PCI_DEVICE,
         .instance_size  = sizeof(PCIDevice),
         .class_init     = sh_pcic_pci_class_init,
+        .secure         = false,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 194037d6e7..1aeb008845 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -333,6 +333,7 @@ static const TypeInfo unin_main_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = unin_main_pci_host_class_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -361,6 +362,7 @@ static const TypeInfo u3_agp_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = u3_agp_pci_host_class_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 8ea26e3ff0..a991c21a19 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -492,6 +492,7 @@ static const TypeInfo versatile_pci_host_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = versatile_pci_host_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -519,6 +520,7 @@ static const TypeInfo pci_vpb_info = {
     .instance_size = sizeof(PCIVPBState),
     .instance_init = pci_vpb_init,
     .class_init    = pci_vpb_class_init,
+    .secure        = false,
 };
 
 static void pci_realview_init(Object *obj)
@@ -536,6 +538,7 @@ static const TypeInfo pci_realview_info = {
     .name          = "realview_pci",
     .parent        = TYPE_VERSATILE_PCI,
     .instance_init = pci_realview_init,
+    .secure        = false,
 };
 
 static void versatile_pci_register_types(void)
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
index 5dd17ef236..892e27e32f 100644
--- a/hw/pci-host/xen_igd_pt.c
+++ b/hw/pci-host/xen_igd_pt.c
@@ -110,6 +110,7 @@ static const TypeInfo igd_passthrough_i440fx_info = {
     .parent        = TYPE_I440FX_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = igd_passthrough_i440fx_class_init,
+    .secure        = true,
 };
 
 static void igd_pt_i440fx_register_types(void)
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index c71492de9e..4e88c51ff9 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -183,6 +183,7 @@ static const TypeInfo xilinx_pcie_host_info = {
     .instance_size = sizeof(XilinxPCIEHost),
     .instance_init = xilinx_pcie_host_init,
     .class_init = xilinx_pcie_host_class_init,
+    .secure = false,
 };
 
 static uint32_t xilinx_pcie_root_config_read(PCIDevice *d,
-- 
2.50.1


