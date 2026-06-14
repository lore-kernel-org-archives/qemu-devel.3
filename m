Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63535CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9m-0007Ol-2A; Sun, 14 Jun 2026 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9k-0007OK-9y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9i-0001dk-IJ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8iQzXqiGfwmNGA+KvR1YcjUM1reh5N0vzFcmIESiSY=;
 b=ZvOa5lL9V/ISlknltm1A+G/lvrWr5ClQIMGO3OLnwRSIinseT7Zm4YRnbXhOTX61bavHdd
 yfNf/Uzq+RxK0lqNVK2gMf9Azpiy7xKrxOmgzQjhUz1W062ZkpTbKrxVrCunWIzglI4+cl
 LfwPhhp17wKPDFRou1h5Ahnp3LWDv58=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-iTj01rE9Mbe6wuUro-Rqeg-1; Sun, 14 Jun 2026 15:06:00 -0400
X-MC-Unique: iTj01rE9Mbe6wuUro-Rqeg-1
X-Mimecast-MFC-AGG-ID: iTj01rE9Mbe6wuUro-Rqeg_1781463959
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so1527969f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463959; x=1782068759; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n8iQzXqiGfwmNGA+KvR1YcjUM1reh5N0vzFcmIESiSY=;
 b=VsNufn+4SmiTFRSyLTNiztT8aTKy9W2O0l/AqekERRgN/CGhG/GNAztCrL6LfdGvNp
 gpuTMVReVWm6c3+MUrjx4o6ZHpwC8iZ2PvDXj2nQDcuM8P9wubOKkeuiWTw7yU1W8y3i
 7kFC5ySI/4v1uK1HAjoWFlsRXjbd4ETSL7HpACKVd4AxJ68NM9zv5RBzSl7718eAN/Vu
 okAguXJHid6hw1efQjc9dwcNxxyjQIhxk9Df4U1ou5/M6v+UPJLzwOuKo/Rs3aU9lZ/c
 4QrM03Uz87jSTcMlffAhfSoA6Ri/T48C6Qy1JTBSs/QZAOH/dy0SNXAUePlULpGhQIok
 LKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463959; x=1782068759;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8iQzXqiGfwmNGA+KvR1YcjUM1reh5N0vzFcmIESiSY=;
 b=cEFBODhvT2mH+fcthe0yi9rvXZrc3TaNO734eic4biDaO0nm4b1fyPZFEF4OmmfbV/
 0JNb9IzM39dJyGDdQ5amBFwHKwMbXIHUjYft6hXlnzuNUyCIztXMh8zS5Fhv/r8qKpBP
 9Ac9glPRF5sHrIrzGF67VT7MaT1cIFS/g1PrPvDWGKdPfv/Uw1DDRtyE/onQ/qRGA7V8
 cPbsHBxfkCbWYdnxbJ7n8UZA02Wst0U7fk/keoHoh3igvXeZ0hTBid6Eelk34n0CwAtr
 KM+b6vdyS2yYAcENHU5nWWTKhYtrB7r0D6JNUYD79Aq3rK8lYohEqy7TcYS179YdD4CH
 ozdw==
X-Gm-Message-State: AOJu0YwSlIer2JmxpBuefc4wg2naJHpBEZiBLpb70UFdLUG6+f0cGkQP
 K2mK+2vj0j1nL2y+RD7ZGugqc0phMh4bCaJbA9kT2NouMjolPREEs2FS5f+ETBNV1tUFhvaxXPo
 otr530M5k3TrCWfKvNn9mSPLvgai6lMO618aicKEqeiCuZxqCHWBEqEuQ4DfhfLGAQOL/deEBgi
 GuFq6bhLJLZrfrCT1v2Ziyj2R8/wMQj7b7HA==
X-Gm-Gg: Acq92OFLgjdNC94KSthZjNbtSYxwJgjCNaq1HaWcg531JjX2QL2xRXsxLq4E6EmDiy3
 uqef66jj/MJP0LTgf/dZLUeIy4QhY0B/ZIuEUCTSKDx507FuBg5VIOJRfmq56wzAEX9t0Yv7Led
 S32WHJD0FxQnroA7rtYQXRpIAQ0gBx93jL6VL5NUnxHJpsnI0ipVA4SXmlEwdeIqLd8+OGSF/LB
 YpOCTDSx/jGlM+lpG3Cvi+nFXamLEgGtic+sYu/uKnwRqKk52sD0o09g0viQqPFrryUmhAv+dnH
 DOlbTY3J8t0QsTrwX34Sx/k0MJTuKHBA+FEB0dJCYX5sPt/8LJqdHjCItOm8q5SlXYReBSktl0e
 kiYVCsZIIQDfKR69bH9Q6lBOXCdqvGGJ6FSq0kd6zp3E=
X-Received: by 2002:a05:6000:2dc2:b0:460:3b5d:43b6 with SMTP id
 ffacd0b85a97d-4606dba0623mr16945381f8f.31.1781463959024; 
 Sun, 14 Jun 2026 12:05:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:460:3b5d:43b6 with SMTP id
 ffacd0b85a97d-4606dba0623mr16945330f8f.31.1781463958442; 
 Sun, 14 Jun 2026 12:05:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm27335928f8f.8.2026.06.14.12.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:58 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Xudong Hao <xudong.hao@intel.com>, Alex Williamson <alex@shazbot.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 006/106] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
Message-ID: <1179c4dfc04915b13fe5c9158a07dce3470c8b3c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For attachment with pasid, pasid together with flag VFIO_DEVICE_ATTACH_PASID
should be passed in.

Define IOMMU_NO_PASID to represent device attachment without pasid same as
in kernel.

The implementation is similar for detachment.

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-2-zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c       | 44 +++++++++++++++++++++++++----------------
 hw/vfio/trace-events    |  4 ++--
 include/hw/core/iommu.h |  3 +++
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df148a49a7..f86f6f0d7b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "system/iommufd.h"
+#include "hw/core/iommu.h"
 #include "hw/core/qdev.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
@@ -305,43 +306,48 @@ out:
     return ret;
 }
 
-static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
-                                         Error **errp)
+static int iommufd_cdev_pasid_attach_ioas_hwpt(VFIODevice *vbasedev,
+                                               uint32_t pasid, uint32_t id,
+                                               Error **errp)
 {
     int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_attach_iommufd_pt attach_data = {
         .argsz = sizeof(attach_data),
-        .flags = 0,
+        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_ATTACH_PASID,
+        .pasid = pasid,
         .pt_id = id,
     };
 
     /* Attach device to an IOAS or hwpt within iommufd */
     if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
         error_setg_errno(errp, errno,
-                         "[iommufd=%d] error attach %s (%d) to id=%d",
-                         iommufd, vbasedev->name, vbasedev->fd, id);
+                         "[iommufd=%d] error attach %s (%d) pasid %d to id=%d",
+                         iommufd, vbasedev->name, vbasedev->fd, pasid, id);
         return -errno;
     }
 
-    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
-                                        vbasedev->fd, id);
+    trace_iommufd_cdev_pasid_attach_ioas_hwpt(iommufd, vbasedev->name,
+                                              vbasedev->fd, pasid, id);
     return 0;
 }
 
-static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
+static bool iommufd_cdev_pasid_detach_ioas_hwpt(VFIODevice *vbasedev,
+                                                uint32_t pasid, Error **errp)
 {
     int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_detach_iommufd_pt detach_data = {
         .argsz = sizeof(detach_data),
-        .flags = 0,
+        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_DETACH_PASID,
+        .pasid = pasid,
     };
 
     if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
-        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
+        error_setg_errno(errp, errno, "detach %s pasid %d failed",
+                         vbasedev->name, pasid);
         return false;
     }
 
-    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
+    trace_iommufd_cdev_pasid_detach_ioas_hwpt(iommufd, vbasedev->name, pasid);
     return true;
 }
 
@@ -363,7 +369,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     /* Try to find a domain */
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
         if (!cpr_is_incoming()) {
-            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+            ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                      hwpt->hwpt_id, errp);
         } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
             ret = 0;
         } else {
@@ -442,7 +449,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, hwpt_id,
+                                              errp);
     if (ret) {
         iommufd_backend_free_id(container->be, hwpt_id);
         return false;
@@ -495,7 +503,8 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
 
     /* If CPR, we are already attached to ioas_id. */
     return cpr_is_incoming() ||
-           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+           !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
@@ -503,7 +512,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 {
     Error *err = NULL;
 
-    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
+    if (!iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, &err)) {
         error_report_err(err);
     }
 
@@ -929,7 +938,8 @@ host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                hwpt_id, errp);
 }
 
 static bool
@@ -938,7 +948,7 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
 }
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..8dbb477298 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -183,8 +183,8 @@ vfio_vmstate_change_prepare(const char *name, int running, const char *reason, c
 
 iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
-iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
-iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_pasid_attach_ioas_hwpt(int iommufd, const char *name, int devfd, uint32_t pasid, int id) " [iommufd=%d] Successfully attached device %s (%d) pasid %u to id=%d"
+iommufd_cdev_pasid_detach_ioas_hwpt(int iommufd, const char *name, uint32_t pasid) " [iommufd=%d] Successfully detached %s pasid %u"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index cd59a367ce..7fb5c81c9f 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -30,4 +30,7 @@ enum host_iommu_quirks {
     HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
 };
 
+/* ABI constant: IOMMU_NO_PASID must always be 0 (keep in sync with kernel) */
+#define IOMMU_NO_PASID 0
+
 #endif /* HW_IOMMU_H */
-- 
MST


