Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C02C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52QO-0004em-R4; Fri, 11 Sep 2026 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NA-0002NT-Kp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52N4-0007uU-Cl
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYxcms/b3tvYKg41L3PAN6QuGuhC66PDVuW5tlA0LrY=;
 b=ivNClDuvI1qee2PaRc+5VJiHmxB2rg36Dj/ZCm+LmdX1WyxMF3GOFqKAHUnQt88k4nWb8N
 4GEvqVjzIBnrdqfq6fvkLze9MiioqVql/thTdhw4Bzs64gg47EanxSKEtXi6KmSoKRZBpr
 GIbgheT0Vu5nrnNlUxxETV74yGD/XGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-5ZpW9R8YOlqZCbyG5RZybg-1; Fri,
 11 Sep 2026 10:36:47 -0400
X-MC-Unique: 5ZpW9R8YOlqZCbyG5RZybg-1
X-Mimecast-MFC-AGG-ID: 5ZpW9R8YOlqZCbyG5RZybg_1789137406
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D34A18011D5; Fri, 11 Sep 2026 14:36:46 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66E99300022B; Fri, 11 Sep 2026 14:36:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/28] hw/vfio: mark all VFIO object classes as secure
Date: Fri, 11 Sep 2026 15:36:06 +0100
Message-ID: <20260911143627.2743803-8-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The VFIO subsystem is about securely passing host PCI devices
to a guest, so all the classes should be presumed to be offering
a security boundary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/vfio-user/pci.c  | 1 +
 hw/vfio/ap.c        | 1 +
 hw/vfio/ccw.c       | 1 +
 hw/vfio/container.c | 1 +
 hw/vfio/igd.c       | 1 +
 hw/vfio/iommufd.c   | 2 ++
 hw/vfio/pci.c       | 3 +++
 hw/vfio/spapr.c     | 1 +
 8 files changed, 11 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e7573d4a9f..ae26160f72 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -482,6 +482,7 @@ static const TypeInfo vfio_user_pci_info = {
     .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_pci_init,
     .instance_finalize = vfio_user_pci_finalize,
+    .secure = true,
 };
 
 static void register_vfio_user_dev_type(void)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e2a1223ea..4b9d522f7b 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -352,6 +352,7 @@ static const TypeInfo vfio_ap_info = {
     .instance_size = sizeof(VFIOAPDevice),
     .instance_init = vfio_ap_instance_init,
     .class_init = vfio_ap_class_init,
+    .secure = true,
 };
 
 static void vfio_ap_type_init(void)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c3dc7c1962..7a241aa02a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -721,6 +721,7 @@ static const TypeInfo vfio_ccw_info = {
     .instance_size = sizeof(VFIOCCWDevice),
     .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
+    .secure = true,
 };
 
 static void register_vfio_ccw_type(void)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d09a663732..d4f20c6c81 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -336,6 +336,7 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(VFIOContainer),
         .class_size = sizeof(VFIOIOMMUClass),
         .abstract = true,
+        .secure = true,
     },
 };
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9..e9cef355f9 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -311,6 +311,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
     .name = "vfio-pci-igd-lpc-bridge",
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 242644aa00..64e588fe51 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -1051,10 +1051,12 @@ static const TypeInfo types[] = {
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
index 428ab2f069..b38877a1a8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3854,6 +3854,7 @@ static const TypeInfo vfio_pci_device_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
+    .secure = true,
     .class_init = vfio_pci_device_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
@@ -4110,6 +4111,7 @@ static const TypeInfo vfio_pci_info = {
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
+    .secure = true,
 };
 
 static const Property vfio_pci_nohotplug_properties[] = {
@@ -4146,6 +4148,7 @@ static const TypeInfo vfio_pci_nohotplug_info = {
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_class_init,
+    .secure = true,
 };
 
 static void register_vfio_pci_dev_type(void)
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 42690e4323..1027c434c0 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -544,6 +544,7 @@ static const TypeInfo types[] = {
         .parent = TYPE_VFIO_IOMMU_LEGACY,
         .instance_size = sizeof(VFIOSpaprContainer),
         .class_init = vfio_iommu_spapr_class_init,
+        .secure = true,
     },
 };
 
-- 
2.55.0


