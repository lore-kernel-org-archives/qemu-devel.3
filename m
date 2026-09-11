Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFB1C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52TT-0000aW-2U; Fri, 11 Sep 2026 10:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nj-0002rw-V6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NL-000864-Mo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3BKmIpd6uP7elhTJltd1MfpWu1daHpYwrEoIxNMRtY=;
 b=bFhON2eL0UbV945q6SqkTagj1DSeVvuG+W24kqIq+lj/lhw9tb8/kAF344GHj6DOQeejQ2
 QkLrxFibAHA2N5zNFmBVYn2maurO6/9tOB2gYKP8DHpeHstDRz384gCFpRzG65iZh4g9+Q
 aBpu246VVN5vIplbm9LGwO0OPx/kABc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-4ojkFmHhPTO60Js_E0hGWQ-1; Fri,
 11 Sep 2026 10:37:08 -0400
X-MC-Unique: 4ojkFmHhPTO60Js_E0hGWQ-1
X-Mimecast-MFC-AGG-ID: 4ojkFmHhPTO60Js_E0hGWQ_1789137426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9836D1955BE0; Fri, 11 Sep 2026 14:37:06 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCA7C3000229; Fri, 11 Sep 2026 14:37:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/28] hw/pci-host: mark common x86, ppc,
 arm and s390 PCI hosts as secure
Date: Fri, 11 Sep 2026 15:36:15 +0100
Message-ID: <20260911143627.2743803-17-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark the PCI hosts secure if they are used from machine types
that are considered for the virtualization use case.

There is also a special case for the 'remote' type and the
Xen passthrough type.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-host/gpex.c          | 2 ++
 hw/pci-host/i440fx.c        | 2 ++
 hw/pci-host/pnv_phb.c       | 2 ++
 hw/pci-host/pnv_phb3.c      | 3 +++
 hw/pci-host/pnv_phb3_msi.c  | 1 +
 hw/pci-host/pnv_phb3_pbcq.c | 1 +
 hw/pci-host/pnv_phb4.c      | 4 +++-
 hw/pci-host/pnv_phb4_pec.c  | 1 +
 hw/pci-host/q35.c           | 2 ++
 hw/pci-host/remote.c        | 1 +
 hw/pci-host/xen_igd_pt.c    | 1 +
 hw/ppc/spapr_pci.c          | 1 +
 hw/s390x/s390-pci-bus.c     | 4 ++++
 13 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e66784ce51..38197a8945 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -220,6 +220,7 @@ static const TypeInfo gpex_host_info = {
     .instance_size = sizeof(GPEXHost),
     .instance_init = gpex_host_initfn,
     .class_init = gpex_host_class_init,
+    .secure = true,
 };
 
 /****************************************************************************
@@ -259,6 +260,7 @@ static const TypeInfo gpex_root_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(GPEXRootState),
     .class_init = gpex_root_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index c1982f7962..1c5a4aba1b 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -352,6 +352,7 @@ static const TypeInfo i440fx_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = i440fx_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -410,6 +411,7 @@ static const TypeInfo i440fx_pcihost_info = {
     .instance_size = sizeof(I440FXState),
     .instance_init = i440fx_pcihost_initfn,
     .class_init    = i440fx_pcihost_class_init,
+    .secure        = true,
 };
 
 static void i440fx_register_types(void)
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 0b556d1bf5..bc8313d2cd 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -333,6 +333,7 @@ static const TypeInfo pnv_phb_type_info = {
     .parent        = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(PnvPHB),
     .class_init    = pnv_phb_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo pnv_phb_root_port_info = {
@@ -340,6 +341,7 @@ static const TypeInfo pnv_phb_root_port_info = {
     .parent        = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(PnvPHBRootPort),
     .class_init    = pnv_phb_root_port_class_init,
+    .secure        = true,
 };
 
 static void pnv_phb_register_types(void)
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index db061c134e..abf43e3226 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -910,6 +910,7 @@ static const TypeInfo pnv_phb3_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
     .class_init = pnv_phb3_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 /*
@@ -1123,6 +1124,7 @@ static const TypeInfo pnv_phb3_type_info = {
     .instance_size = sizeof(PnvPHB3),
     .class_init    = pnv_phb3_class_init,
     .instance_init = pnv_phb3_instance_init,
+    .secure        = true,
 };
 
 static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
@@ -1186,6 +1188,7 @@ static const TypeInfo pnv_phb3_root_bus_info = {
     .parent = TYPE_PCIE_BUS,
     .instance_size = sizeof(PnvPHB3RootBus),
     .class_init = pnv_phb3_root_bus_class_init,
+    .secure = true,
 };
 
 static void pnv_phb3_register_types(void)
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 66ba7b7913..5edc0d43eb 100644
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
index 9acaf4c0c2..9706208473 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1374,6 +1374,7 @@ static const TypeInfo pnv_phb4_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
     .class_init = pnv_phb4_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 /*
@@ -1715,13 +1716,13 @@ static const TypeInfo pnv_phb4_type_info = {
     .instance_init = pnv_phb4_instance_init,
     .instance_size = sizeof(PnvPHB4),
     .class_init    = pnv_phb4_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_NOTIFIER },
             { },
     }
 };
 
-
 static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
                                        const char *name,
                                        void *opaque, Error **errp)
@@ -1783,6 +1784,7 @@ static const TypeInfo pnv_phb4_root_bus_info = {
     .parent = TYPE_PCIE_BUS,
     .instance_size = sizeof(PnvPHB4RootBus),
     .class_init = pnv_phb4_root_bus_class_init,
+    .secure = true,
 };
 
 static void pnv_phb4_register_types(void)
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ee5cdc3e45..280a15e8df 100644
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
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index f4556ad03a..be38841df9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -268,6 +268,7 @@ static const TypeInfo q35_host_info = {
     .instance_size = sizeof(Q35PCIHost),
     .instance_init = q35_host_initfn,
     .class_init = q35_host_class_init,
+    .secure = true,
 };
 
 /****************************************************************************
@@ -718,6 +719,7 @@ static const TypeInfo mch_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MCHPCIState),
     .class_init = mch_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index 9ea95fac6e..a58fc39bde 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -63,6 +63,7 @@ static const TypeInfo remote_pcihost_info = {
     .parent = TYPE_PCIE_HOST_BRIDGE,
     .instance_size = sizeof(RemotePCIHost),
     .class_init = remote_pcihost_class_init,
+    .secure = true,
 };
 
 static void remote_pcihost_register(void)
diff --git a/hw/pci-host/xen_igd_pt.c b/hw/pci-host/xen_igd_pt.c
index f6016f2cd5..abc68849b9 100644
--- a/hw/pci-host/xen_igd_pt.c
+++ b/hw/pci-host/xen_igd_pt.c
@@ -110,6 +110,7 @@ static const TypeInfo igd_passthrough_i440fx_info = {
     .parent        = TYPE_I440FX_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = igd_passthrough_i440fx_class_init,
+    .secure        = true,
 };
 
 static void igd_pt_i440fx_register_types(void)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c1d4b7806e..711c37878b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2174,6 +2174,7 @@ static const TypeInfo spapr_phb_info = {
     .instance_size = sizeof(SpaprPhbState),
     .instance_finalize = spapr_phb_finalizefn,
     .class_init    = spapr_phb_class_init,
+    .secure        = true,
     .interfaces    = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe..5356d13624 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1406,6 +1406,7 @@ static const TypeInfo s390_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(S390pciState),
     .class_init    = s390_pcihost_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1416,6 +1417,7 @@ static const TypeInfo s390_pcibus_info = {
     .name = TYPE_S390_PCI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(S390PCIBus),
+    .secure = true,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -1588,12 +1590,14 @@ static const TypeInfo s390_pci_device_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(S390PCIBusDevice),
     .class_init = s390_pci_device_class_init,
+    .secure = true,
 };
 
 static const TypeInfo s390_pci_iommu_info = {
     .name = TYPE_S390_PCI_IOMMU,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(S390PCIIOMMU),
+    .secure = true,
 };
 
 static void s390_iommu_memory_region_class_init(ObjectClass *klass,
-- 
2.55.0


