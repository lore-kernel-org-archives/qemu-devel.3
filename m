Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D154606A88E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYjt4M0v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFp-0007xZ-29; Fri, 13 Nov 2026 13:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFG-0007If-6c
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwFC-0005Px-Tf
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kId5OuASw/l71DPT4gPH/X3bbUd1cl4yObJudqMX+l0=;
 b=TYjt4M0vc94yFXSskJhrmUzMraQtin1e1D1FYJo/rz+ZLxcPiYyUDsUiTON8ej//uBgfsA
 Xzt7Sro+W8fsdYweQBZTQGGNq7uu0mZzC9bpTV1YJOpYb/UXubiL1+MQ2A5EzrQf7ibOnb
 841rsxKBFTaZTouIAP/gp+TyxFqnYWY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-fBqFIesPM12M8RAh6EwQdQ-1; Fri,
 13 Nov 2026 13:43:24 -0500
X-MC-Unique: fBqFIesPM12M8RAh6EwQdQ-1
X-Mimecast-MFC-AGG-ID: fBqFIesPM12M8RAh6EwQdQ_1794595403
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DCA0180054A
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:23 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24FA31955DB9; Fri, 13 Nov 2026 18:43:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 14/26] hw/pci-host: mark common x86, ppc,
 arm and s390 PCI hosts as secure
Date: Fri, 13 Nov 2026 18:42:42 +0000
Message-ID: <20261113184254.2524253-15-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is also a special case for the Xen passthrough type.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com> #s390
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-host/gpex.c       | 2 ++
 hw/pci-host/i440fx.c     | 2 ++
 hw/pci-host/q35.c        | 2 ++
 hw/pci-host/xen_igd_pt.c | 1 +
 hw/ppc/spapr_pci.c       | 1 +
 hw/s390x/s390-pci-bus.c  | 4 ++++
 6 files changed, 12 insertions(+)

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
index 09513788361..44d059907ff 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -353,6 +353,7 @@ static const TypeInfo i440fx_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = i440fx_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -415,6 +416,7 @@ static const TypeInfo i440fx_pcihost_info = {
     .instance_size = sizeof(I440FXState),
     .instance_init = i440fx_pcihost_initfn,
     .class_init    = i440fx_pcihost_class_init,
+    .secure        = true,
 };
 
 static void i440fx_register_types(void)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index d53441561f5..b50006a5520 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -273,6 +273,7 @@ static const TypeInfo q35_host_info = {
     .instance_size = sizeof(Q35PCIHost),
     .instance_init = q35_host_initfn,
     .class_init = q35_host_class_init,
+    .secure = true,
 };
 
 /****************************************************************************
@@ -723,6 +724,7 @@ static const TypeInfo mch_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MCHPCIState),
     .class_init = mch_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
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
index 1e78dc3b861..742c95aea14 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1680,6 +1680,7 @@ static const TypeInfo s390_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(S390pciState),
     .class_init    = s390_pcihost_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1713,6 +1714,7 @@ static const TypeInfo s390_pcibus_info = {
      * if a device is unplugged and plugged back, preventing migration.
      */
     .class_init = s390_pcibus_class_init,
+    .secure = true,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
@@ -2037,12 +2039,14 @@ static const TypeInfo s390_pci_device_info = {
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
2.56.1


