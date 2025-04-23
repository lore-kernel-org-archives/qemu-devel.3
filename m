Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC0FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uas-0006wl-KN; Wed, 23 Apr 2025 03:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uaj-0006jM-GN
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:22 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uah-0002Yx-BQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393539; x=1776929539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4aYU2aYrGZv6Ifhv0cwF9ZzIZVaej/rWoKf+nIOTJao=;
 b=U4eZxYrrNZF99p55XV7NBz0jysihY1cm/4B10NlW1mi984rWAJEAX9Cm
 Osu+cAbXhypf7w7flv2LVDCaa4ekKR6WUp1yr20TvyqtgQmmhiw0SZ1Dn
 FNqMl9960eE6sT8UiOQHHmZQ0x5o0kMh9UaC1Ke12qrw3XSp/T3LK4ati
 WkhUfXS3dc4fYjtjQhM2l/UxazTCSzhbEPL3uB2gm7jXfmpG154C4BXdf
 qCGHuQlGD+Vkf5Aio4+8nWHdcgGrtg4ETGaPmFsbCxHK8BOVRTz6tzXUu
 Dp1OOnLQuSF8Pw/lBSd8VWna1zIJ//RWLwqV9GMCza2hzDO5JzW66qhmT g==;
X-CSE-ConnectionGUID: ixl9HH4SR+yAgM5wPQFcHg==
X-CSE-MsgGUID: RJ58yXmMQNG+oZkuPI5dsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959270"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:18 -0700
X-CSE-ConnectionGUID: EEGeXqPYR1KTGTUsIKWUQg==
X-CSE-MsgGUID: sze0xJy/Qeew13k5jgDuYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025390"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 4/5] vfio: Cleanup host IOMMU device creation
Date: Wed, 23 Apr 2025 15:28:23 +0800
Message-Id: <20250423072824.3647952-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

realize() is now moved after attachment, do the same for hiod creation.
Introduce a new function vfio_device_hiod_create_and_realize() to do
them all in one go.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  3 ++-
 hw/vfio/container.c           |  5 ++++-
 hw/vfio/device.c              | 33 ++++++++++++++-------------------
 hw/vfio/iommufd.c             |  4 +++-
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 66797b4c92..65fa67e65a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -123,7 +123,8 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 
 void vfio_device_reset_handler(void *opaque);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
+                                         const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1bb8e2de6c..2de20692d1 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -898,7 +898,9 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto group_put_exit;
     }
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+                                             TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
+                                             errp)) {
         goto device_put_exit;
     }
 
@@ -924,6 +926,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
+    object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
 }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4de6948cf4..d625a7c4db 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -347,15 +347,24 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
 }
 
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
+bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
+                                         const char *typename, Error **errp)
 {
-    HostIOMMUDevice *hiod = vbasedev->hiod;
+    HostIOMMUDevice *hiod;
 
-    if (!hiod) {
+    if (vbasedev->mdev) {
         return true;
     }
 
-    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
+    hiod = HOST_IOMMU_DEVICE(object_new(typename));
+
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        return false;
+    }
+
+    vbasedev->hiod = hiod;
+    return true;
 }
 
 VFIODevice *vfio_get_vfio_device(Object *obj)
@@ -372,7 +381,6 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -380,19 +388,7 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-
-    if (!vbasedev->mdev) {
-        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-        vbasedev->hiod = hiod;
-    }
-
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        object_unref(hiod);
-        vbasedev->hiod = NULL;
-        return false;
-    }
-
-    return true;
+    return ops->attach_device(name, vbasedev, as, errp);
 }
 
 void vfio_device_detach(VFIODevice *vbasedev)
@@ -400,6 +396,5 @@ void vfio_device_detach(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
-    object_unref(vbasedev->hiod);
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f273dc8712..8a010a51ea 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -574,7 +574,8 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vfio_device_hiod_create_and_realize(vbasedev,
+                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
         goto err_hiod_realize;
     }
 
@@ -630,6 +631,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
+    object_unref(vbasedev->hiod);
     vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
-- 
2.34.1


