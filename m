Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF684C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVn-0002jb-UT; Fri, 11 Apr 2025 06:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0002bb-1I
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:18 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVT-0005Op-4m
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366867; x=1775902867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZALbs/dbjCI0xMs0gD6081Unyv17rpEdGJH3ZlKWYPs=;
 b=jYpnrTeqNf8NM6udXhDg55MNnwR9V3il5GQfpAHB5vXl/6+hgNgYNppf
 TtgaHMdHboTNBVzSlJOBikh2UhuKwFy9GgwqyjHHGLvETw5ry98HIClCC
 wzILOOCl5kcCrbrH5y0vt/nyK2MHP37V8ZYR0Z8zvnsGrlyPk6meGAWIL
 2QCEK/FpflxONN75JkkWNVAwKK1Hs1hCLgahOHNqBFu+WV35Zyp3JJiHf
 xNNkmTYPOLc8Jd+iGIHc1UXr8Svt51IW7wHZxT/viQavjYsJOTGSdpklD
 3BkonD0cqEbSUxJLDitGTVOXtTZRyCdJ60Kg3th/YyHzWrmsn48F+Ov0W Q==;
X-CSE-ConnectionGUID: euIePaKvQfie1XeE6Wo85Q==
X-CSE-MsgGUID: f6psmTnOSoqhANMdPfNhwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566790"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:51 -0700
X-CSE-ConnectionGUID: F4JueCLbR1uihvjZ7OCpRg==
X-CSE-MsgGUID: ax4RPBrBRte8OW+i6C7t/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917413"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Donald Dutile <ddutile@redhat.com>
Subject: [PATCH 2/5] vfio: Move realize() after attach_device()
Date: Fri, 11 Apr 2025 18:17:04 +0800
Message-Id: <20250411101707.3460429-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously device attaching depends on realize() getting host iommu
capabilities to check dirty tracking support.

Now we save a caps copy in VFIODevice and check that copy for dirty
tracking support, there is no dependency any more, move realize()
call after attach_device() call in vfio_device_attach().

Drop vfio_device_hiod_realize() which looks redundant now.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Donald Dutile <ddutile@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  1 -
 hw/vfio/container.c           |  4 ----
 hw/vfio/device.c              | 28 +++++++++++-----------------
 hw/vfio/iommufd.c             |  4 ----
 4 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 09a7af891a..14559733c6 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -124,7 +124,6 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 
 void vfio_device_reset_handler(void *opaque);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 23a3373470..676e88cef4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -883,10 +883,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_device_attach(vbasedev->name, groupid);
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        return false;
-    }
-
     group = vfio_group_get(groupid, as, errp);
     if (!group) {
         return false;
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4de6948cf4..6154d3f443 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -347,17 +347,6 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
 
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
-{
-    HostIOMMUDevice *hiod = vbasedev->hiod;
-
-    if (!hiod) {
-        return true;
-    }
-
-    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
-}
-
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
@@ -372,6 +361,7 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDeviceClass *hiodc;
     HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
@@ -380,16 +370,20 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        return false;
+    }
 
     if (!vbasedev->mdev) {
         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-        vbasedev->hiod = hiod;
-    }
+        hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
 
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        object_unref(hiod);
-        vbasedev->hiod = NULL;
-        return false;
+        if (!hiodc->realize(hiod, vbasedev, errp)) {
+            object_unref(hiod);
+            ops->detach_device(vbasedev);
+            return false;
+        }
+        vbasedev->hiod = hiod;
     }
 
     return true;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 530cde6740..e05b472e35 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -502,10 +502,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
      * FD to be connected and having a devid to be able to successfully call
      * iommufd_backend_get_device_info().
      */
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        goto err_alloc_ioas;
-    }
-
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &caps->type, &caps->vendor_caps,
                                          sizeof(VendorCaps), &caps->hw_caps,
-- 
2.34.1


