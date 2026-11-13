Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A472606BDFF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=an5twB6K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwF6-0007D8-Vh; Fri, 13 Nov 2026 13:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwEy-00076h-EX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwEw-0005N8-OC
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYmz55K1mxZSDbD/poMIYWasVkJuIlsanoxTzDDkf5I=;
 b=an5twB6KTftT8XaiTg9PMp1AQiYQTYR02QLek8sdh3Eh+EBo3sYyYwB8GFfDt5Hmigy3IF
 wDJUAotr+U26RrDp+P+25Ql3HJ57m7cR4lzA3ImxfcIG/7TUWK0iqiIfvg5iC4rfrj6Xow
 o083Fhvf+hh+6G58ODBu2ilN83292I8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-ocRNYjuzOyGno7z_mgv41w-1; Fri,
 13 Nov 2026 13:43:08 -0500
X-MC-Unique: ocRNYjuzOyGno7z_mgv41w-1
X-Mimecast-MFC-AGG-ID: ocRNYjuzOyGno7z_mgv41w_1794595387
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C9F5180049F
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:07 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4F291955DB9; Fri, 13 Nov 2026 18:43:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 05/26] hw/vfio: mark all VFIO object classes as secure
Date: Fri, 13 Nov 2026 18:42:33 +0000
Message-ID: <20261113184254.2524253-6-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The VFIO subsystem is about securely passing host PCI devices
to a guest, so all the classes should be presumed to be offering
a security boundary.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com> #s390 types
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/vfio-user/pci.c | 1 +
 hw/vfio/ap.c       | 1 +
 hw/vfio/ccw.c      | 1 +
 hw/vfio/igd.c      | 1 +
 hw/vfio/iommufd.c  | 2 ++
 hw/vfio/pci.c      | 2 ++
 hw/vfio/spapr.c    | 1 +
 7 files changed, 9 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c749ff149f8..e3749cdd393 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -489,6 +489,7 @@ static const TypeInfo vfio_user_pci_info = {
     .class_init = vfio_user_pci_class_init,
     .instance_init = vfio_user_pci_init,
     .instance_finalize = vfio_user_pci_finalize,
+    .secure = true,
 };
 
 static void register_vfio_user_dev_type(void)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 2926e04ad49..45d67b8ba70 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -356,6 +356,7 @@ static const TypeInfo vfio_ap_info = {
     .instance_size = sizeof(VFIOAPDevice),
     .instance_init = vfio_ap_instance_init,
     .class_init = vfio_ap_class_init,
+    .secure = true,
 };
 
 static void vfio_ap_type_init(void)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8e29a3ae613..6d71e196ee0 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -723,6 +723,7 @@ static const TypeInfo vfio_ccw_info = {
     .instance_size = sizeof(VFIOCCWDevice),
     .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
+    .secure = true,
 };
 
 static void register_vfio_ccw_type(void)
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 728b60d3d4a..46ad988ee68 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -321,6 +321,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
     .name = "vfio-pci-igd-lpc-bridge",
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 90ddb54f4c3..97f6470643f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -1061,10 +1061,12 @@ static const TypeInfo types[] = {
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
index 0da2e143b88..96078660777 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -4115,6 +4115,7 @@ static const TypeInfo vfio_pci_info = {
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
+    .secure = true,
 };
 
 static const Property vfio_pci_nohotplug_properties[] = {
@@ -4151,6 +4152,7 @@ static const TypeInfo vfio_pci_nohotplug_info = {
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_class_init,
+    .secure = true,
 };
 
 static void register_vfio_pci_dev_type(void)
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 42690e4323d..1027c434c07 100644
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
2.56.1


