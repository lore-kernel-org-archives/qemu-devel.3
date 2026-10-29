Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bNBrjWCa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPzh-0003XO-4B; Thu, 29 Oct 2026 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwr-0008CV-F1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwp-0006Lu-Bb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh6xU1JvhH1vqcCiCy4q2YvGZjc21RnnFt/+rNrPduk=;
 b=bNBrjWCanqfBE1mQvVJBGt5KsSb+40oaK/aRJmZk+hzYbBkABRqZFr2UhByzDWp91hSy+g
 gJuMSolODp/+i4xBC/og8/SvVs0471iCtm7iluYptDuodAzXSeNKp8aL8C1GZsRwcOeIlm
 KLYvgZrz4HGONm4Zn+32Pna5mC33GF0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-mnsoXUb0Pt-3vIIiE1OlfA-1; Thu,
 29 Oct 2026 09:13:27 -0400
X-MC-Unique: mnsoXUb0Pt-3vIIiE1OlfA-1
X-Mimecast-MFC-AGG-ID: mnsoXUb0Pt-3vIIiE1OlfA_1793279605
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C7401802164; Thu, 29 Oct 2026 13:13:25 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 607033000723; Thu, 29 Oct 2026 13:13:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 14/28] hw/pci-host: mark common x86, ppc,
 arm and s390 PCI hosts as secure
Date: Thu, 29 Oct 2026 13:12:27 +0000
Message-ID: <20261029131241.2275706-15-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark the PCI hosts secure if they are used from machine types
that are considered for the virtualization use case.

There is also a special case for the 'remote' type and the
Xen passthrough type.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com> #s390
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
index e66784ce516..38197a89454 100644
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
index c1982f7962a..1c5a4aba1b3 100644
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
index 0b556d1bf5c..bc8313d2cd0 100644
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
index db061c134e9..abf43e3226d 100644
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
index 66ba7b79134..5edc0d43eb0 100644
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
index 1f7a149580d..687c8325158 100644
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
index ac09a0b034d..1a652110f5d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1388,6 +1388,7 @@ static const TypeInfo pnv_phb4_iommu_memory_region_info = {
     .parent = TYPE_IOMMU_MEMORY_REGION,
     .name = TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
     .class_init = pnv_phb4_iommu_memory_region_class_init,
+    .secure = true,
 };
 
 /*
@@ -1729,13 +1730,13 @@ static const TypeInfo pnv_phb4_type_info = {
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
@@ -1797,6 +1798,7 @@ static const TypeInfo pnv_phb4_root_bus_info = {
     .parent = TYPE_PCIE_BUS,
     .instance_size = sizeof(PnvPHB4RootBus),
     .class_init = pnv_phb4_root_bus_class_init,
+    .secure = true,
 };
 
 static void pnv_phb4_register_types(void)
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ee5cdc3e450..280a15e8df1 100644
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
index f4556ad03a0..be38841df9e 100644
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
index 9ea95fac6e6..a58fc39bded 100644
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
index f6016f2cd53..abc68849b9e 100644
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
index f7fc544d35c..ea323fa0989 100644
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
index cdd75cdfd2f..7c64397c33c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1678,6 +1678,7 @@ static const TypeInfo s390_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(S390pciState),
     .class_init    = s390_pcihost_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1711,6 +1712,7 @@ static const TypeInfo s390_pcibus_info = {
      * if a device is unplugged and plugged back, preventing migration.
      */
     .class_init = s390_pcibus_class_init,
+    .secure = true,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -2033,12 +2035,14 @@ static const TypeInfo s390_pci_device_info = {
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
2.56.0


