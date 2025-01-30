Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACE7C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUq5-0000nb-R3; Thu, 30 Jan 2025 08:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUq3-0000mF-G7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUq1-0003Qi-SL
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738244649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FM1aV6MzsAqHFjNF3oHXP4B1XEDixjmcvXIfFMNaGSU=;
 b=IhgtTR+S5ogZ7eP8uhvN9AJr0Dz60GzPpjNsgFqBgyai3a9rYPI90JsHUpAnld+ID8SZ46
 5ma/Majr6QpDCFykklunWGRvAuG+xjjR2Lqg9VAfyCdz4/45MbjqLWK20YwHsxBRGzU2V0
 gWK0cP7okPjUEPHgFwhb0Zof6nb5bZ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-DhHiTB77M7myqCZuTRfLqA-1; Thu,
 30 Jan 2025 08:44:07 -0500
X-MC-Unique: DhHiTB77M7myqCZuTRfLqA-1
X-Mimecast-MFC-AGG-ID: DhHiTB77M7myqCZuTRfLqA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745D81801F0E
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:44:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E834180096D; Thu, 30 Jan 2025 13:44:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU address
 space width
Date: Thu, 30 Jan 2025 14:43:45 +0100
Message-ID: <20250130134346.1754143-9-clg@redhat.com>
In-Reply-To: <20250130134346.1754143-1-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Print a warning if IOMMU address space width is smaller than the
physical address width. In this case, PCI peer-to-peer transactions on
BARs are not supported and failures of device MMIO regions are to be
expected.

This can occur with the 39-bit IOMMU address space width as found on
consumer grade processors or when using a vIOMMU device with default
settings.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5c9d8657d746ce30af5ae8f9122101e086a61ef5..e5ef93c589b2bed68f790608868ec3c7779d4cb8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,8 @@
 #include "migration/qemu-file.h"
 #include "system/tpm.h"
 
+#include "hw/core/cpu.h"
+
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
@@ -1546,12 +1548,28 @@ retry:
     return info;
 }
 
+static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
+{
+    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);
+    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
+
+    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
+        error_setg(errp, "Host physical address space (%u) is larger than "
+                   "the host IOMMU address space (%u).", cpu_aw_bits,
+                   iommu_aw_bits);
+        vfio_device_error_append(vbasedev, errp);
+        return false;
+    }
+    return true;
+}
+
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp)
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
+    Error *local_err = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1571,6 +1589,9 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (!vfio_device_check_address_space(vbasedev, &local_err)) {
+        warn_report_err(local_err);
+    }
     return true;
 }
 
-- 
2.48.1


