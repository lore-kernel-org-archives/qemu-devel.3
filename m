Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0853BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293g-0006vi-Dq; Fri, 26 Sep 2025 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293c-0006sz-TX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293P-0004sv-AZ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaduB1l9EVSWfjwC3wQO3lTWrvM0XkEeEU8nymRvCOk=;
 b=HMZDEFxcIPnPY8J3LUHSdq16BIogTZFN+dqBXbGRFa38P5AexQsi561xGZQqgahQVh8GY8
 qRf1wGJ3Wa4i6ut5Rbs/QyAq5miQtc83uG8dIXenhSS31lwmH3sOetDhu6qmC9DxdpNGSy
 vKEoMOexJrP5Ka/qfjvT6FOcWAzdFCs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-ZWl2oFHiO1abbyBF9vcApg-1; Fri,
 26 Sep 2025 10:03:58 -0400
X-MC-Unique: ZWl2oFHiO1abbyBF9vcApg-1
X-Mimecast-MFC-AGG-ID: ZWl2oFHiO1abbyBF9vcApg_1758895437
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99220195E916; Fri, 26 Sep 2025 14:03:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8228D195419F; Fri, 26 Sep 2025 14:03:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 22/32] hw/vfio: mark all VFIO object classes as secure
Date: Fri, 26 Sep 2025 15:01:33 +0100
Message-ID: <20250926140144.1998694-23-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The VFIO subsystem is about securely passing host PCI devices
to a guest, so all the classes should be presumed to be offering
a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/vfio/ap.c        | 1 +
 hw/vfio/ccw.c       | 1 +
 hw/vfio/container.c | 2 ++
 hw/vfio/igd.c       | 1 +
 hw/vfio/iommufd.c   | 2 ++
 hw/vfio/pci.c       | 3 +++
 hw/vfio/spapr.c     | 1 +
 7 files changed, 11 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7719f24579..811866876c 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -361,6 +361,7 @@ static const TypeInfo vfio_ap_info = {
     .instance_size = sizeof(VFIOAPDevice),
     .instance_init = vfio_ap_instance_init,
     .class_init = vfio_ap_class_init,
+    .secure = true,
 };
 
 static void vfio_ap_type_init(void)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9560b8d851..bddeb5dffd 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -729,6 +729,7 @@ static const TypeInfo vfio_ccw_info = {
     .instance_size = sizeof(VFIOCCWDevice),
     .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
+    .secure = true,
 };
 
 static void register_vfio_ccw_type(void)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89..a4d89cadcc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1265,10 +1265,12 @@ static const TypeInfo types[] = {
         .instance_init = vfio_iommu_legacy_instance_init,
         .instance_size = sizeof(VFIOContainer),
         .class_init = vfio_iommu_legacy_class_init,
+        .secure = true,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
         .class_init = hiod_legacy_vfio_class_init,
+        .secure = true,
     }
 };
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4bfa2e0fcd..53d7dea87e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -312,6 +312,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
     .name = "vfio-pci-igd-lpc-bridge",
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..2d6168a90e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -958,10 +958,12 @@ static const TypeInfo types[] = {
         .parent = TYPE_VFIO_IOMMU,
         .instance_size = sizeof(VFIOIOMMUFDContainer),
         .class_init = vfio_iommu_iommufd_class_init,
+        .secure = true,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .class_init = hiod_iommufd_vfio_class_init,
+        .secure = true,
     }
 };
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bc0b4c4d56..f98384da93 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3673,6 +3673,7 @@ static const TypeInfo vfio_pci_base_dev_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
+    .secure = true,
     .class_init = vfio_pci_base_dev_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
@@ -3918,6 +3919,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
+    .secure = true,
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3954,6 +3956,7 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
+    .secure = true,
 };
 
 static void register_vfio_pci_dev_type(void)
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c41e4588d6..a926faa0aa 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -571,6 +571,7 @@ static const TypeInfo types[] = {
         .parent = TYPE_VFIO_IOMMU_LEGACY,
         .instance_size = sizeof(VFIOSpaprContainer),
         .class_init = vfio_iommu_spapr_class_init,
+        .secure = true,
     },
 };
 
-- 
2.50.1


