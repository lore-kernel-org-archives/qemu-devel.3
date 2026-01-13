Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73641D29DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaq0-00075s-Lx; Tue, 13 Jan 2026 04:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapy-00070Z-Nl
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapx-0003Ja-5x
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAAkMjBnQviAul+PLoRMDnmUXLCTqeSYmGEpKt8bFvo=;
 b=chvPSV45VacHaqQ0HnZO2Dv4WfZYCpCjC6T1vR7Ycj2XeamulVGJ7fXQT1hqe16Gu6Ob/9
 hx1xr6EpcdzcuwRgpUYE3EFxnqxmN4a2PxPaHnciEODHQsvvvBrZNLKwRia2I9v8mr8S74
 RNHP1Bu34FZHt2Zt8Zj9OOI6qdX3GOM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-N2dWqaezO2qsIr4-xrTfgg-1; Tue,
 13 Jan 2026 04:37:13 -0500
X-MC-Unique: N2dWqaezO2qsIr4-xrTfgg-1
X-Mimecast-MFC-AGG-ID: N2dWqaezO2qsIr4-xrTfgg_1768297032
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CF62195609E; Tue, 13 Jan 2026 09:37:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5912530001A8; Tue, 13 Jan 2026 09:37:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/41] vfio/iommufd: Force creating nesting parent HWPT
Date: Tue, 13 Jan 2026 10:36:06 +0100
Message-ID: <20260113093637.1549214-11-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Call pci_device_get_viommu_flags() to get if vIOMMU supports
VIOMMU_FLAG_WANT_NESTING_PARENT.

If yes, create a nesting parent HWPT and add it to the container's hwpt_list,
letting this parent HWPT cover the entire second stage mappings (GPA=>HPA).

This allows a VFIO passthrough device to directly attach to this default HWPT
and then to use the system address space and its listener.

Introduce a vfio_device_get_viommu_flags_want_nesting() helper to facilitate
this implementation.

It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
call, if something else related to the VFIO device or vIOMMU isn't compatible.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-9-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 12 ++++++++++++
 hw/vfio/iommufd.c             |  9 +++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0fe6c60ba2d65b0ef5de5ef0c75c43cfa8e89352..0bc877ff62f9473d49782ce7c2ee1eb943175821 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 19d1236ed750d482280225b1db3e4f5c13a39a89..100532f35d9ad14bf14c8d6d783f7b06aa85245a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/core/iommu.h"
 #include "hw/core/hw-error.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -515,6 +516,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_NESTING_PARENT);
+    }
+    return false;
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 32e8615ad3b41bdbeb6426c2542f445d9f31f2f5..e5328c63a366076199015b25f55d273b91a4327a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -361,6 +361,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
+    /*
+     * If vIOMMU requests VFIO's cooperation to create nesting parent HWPT,
+     * force to create it so that it could be reused by vIOMMU to create
+     * nested HWPT.
+     */
+    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.52.0


