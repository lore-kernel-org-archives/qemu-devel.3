Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CA606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZSes4SJB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPxG-0000N8-1G; Thu, 29 Oct 2026 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwN-0007oe-7U
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwI-00069h-Kc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUHDFtmD2AxYr0qJKEf3cRq+FMxh1PVcZ5Jcb6U4YtE=;
 b=ZSes4SJBEqEBNBVvRmLw1H6GWbBtRxJr3nV1tPfffwSkDA6Y+RivVWFuZ4EUOHInn3rfXs
 LndQz8GccuMCWn/Ubnj0gFVzRBQkGOolCUBXid3UJTuErdk+mCcZOPW6jsZ1KVEM9HZpTF
 PiMIGUW8uxz6yf8duWw42LOuNEP0naI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-2lbC_tfjMHmF9YyRC2MMQQ-1; Thu,
 29 Oct 2026 09:13:01 -0400
X-MC-Unique: 2lbC_tfjMHmF9YyRC2MMQQ-1
X-Mimecast-MFC-AGG-ID: 2lbC_tfjMHmF9YyRC2MMQQ_1793279580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5935C19560B3; Thu, 29 Oct 2026 13:13:00 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A81683000723; Thu, 29 Oct 2026 13:12:57 +0000 (UTC)
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
Subject: [PATCH v2 05/28] hw/vfio: mark all VFIO object classes as secure
Date: Thu, 29 Oct 2026 13:12:18 +0000
Message-ID: <20261029131241.2275706-6-berrange@redhat.com>
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

The VFIO subsystem is about securely passing host PCI devices
to a guest, so all the classes should be presumed to be offering
a security boundary.

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
index 983e1d4ad47..d8965fd02ee 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -487,6 +487,7 @@ static const TypeInfo vfio_user_pci_info = {
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
index 4c7d6545924..df70cdd9403 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -313,6 +313,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
     .name = "vfio-pci-igd-lpc-bridge",
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index de482128bf1..ab466b513ec 100644
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
index 428ab2f0698..03ab5bd0f48 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -4110,6 +4110,7 @@ static const TypeInfo vfio_pci_info = {
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
+    .secure = true,
 };
 
 static const Property vfio_pci_nohotplug_properties[] = {
@@ -4146,6 +4147,7 @@ static const TypeInfo vfio_pci_nohotplug_info = {
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
2.56.0


