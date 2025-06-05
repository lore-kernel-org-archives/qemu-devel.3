Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D98EC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6CO-0006s2-P8; Thu, 05 Jun 2025 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6CD-0006ed-Ul
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6CC-0008I5-89
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qX+tCSJYfWs63N+/z1dQMGx/2W56gRX4Ps/q3xO9Pv8=;
 b=R09NUYeXyIH0qkXpLMoYD5QhUx8cGPDZYSgJb/M0PyAHG+/d7zDKFrO9X+yedAQelQYjrx
 Mkh9lF425Pb6QDEyJLP9ow9KtrPWlXjRhJ4yiYksJOCbKyd0b5aNaDwP/r4Mto2CRWs6er
 EKJH48j2zKb3nSIijvcjbYDZNIDHuTA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-o1ahmAMsMm2aMxYGdt6lww-1; Thu,
 05 Jun 2025 04:43:28 -0400
X-MC-Unique: o1ahmAMsMm2aMxYGdt6lww-1
X-Mimecast-MFC-AGG-ID: o1ahmAMsMm2aMxYGdt6lww_1749113007
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51822195608F; Thu,  5 Jun 2025 08:43:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDCE71954B3C; Thu,  5 Jun 2025 08:43:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/16] vfio/iommufd: Save vendor specific device info
Date: Thu,  5 Jun 2025 10:42:42 +0200
Message-ID: <20250605084245.1520562-14-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
specific. Save them as raw data in a union supporting different vendors,
then vendor IOMMU can query the raw data with its fixed format for
capability directly.

Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
capability related structures with CONFIG_LINUX.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250604062115.4004200-5-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/host_iommu_device.h | 15 +++++++++++++++
 hw/vfio/iommufd.c                  |  8 +++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba5c56263132b474a382e4bd0ffdd3cd..ab849a4a82d5f2a2a09c7924791b93c26d9ff902 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -14,6 +14,13 @@
 
 #include "qom/object.h"
 #include "qapi/error.h"
+#ifdef CONFIG_LINUX
+#include "linux/iommufd.h"
+
+typedef union VendorCaps {
+    struct iommu_hw_info_vtd vtd;
+    struct iommu_hw_info_arm_smmuv3 smmuv3;
+} VendorCaps;
 
 /**
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
@@ -22,11 +29,17 @@
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ *
+ * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
+ *               IOMMUFD this represents a user-space buffer filled by kernel
+ *               with host IOMMU @type specific hardware information data)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+#endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
@@ -38,7 +51,9 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
+#ifdef CONFIG_LINUX
     HostIOMMUDeviceCaps caps;
+#endif
 };
 
 /**
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 59033028373c82a22b1aaf092503d037a6d7e9b6..c4bbf36241d3ee5c46bca9601688afd742e471f7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -839,16 +839,14 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
+    VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
+                                         vendor_caps, sizeof(*vendor_caps),
                                          &hw_caps, errp)) {
         return false;
     }
-- 
2.49.0


