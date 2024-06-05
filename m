Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BCBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5r-0001VW-SA; Wed, 05 Jun 2024 04:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5p-0001KG-F6
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:01 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5n-00062T-N5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576440; x=1749112440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FWbylNxAQ434hFdFDc8zDiF5R2B5qgy7xarWZmS2DWo=;
 b=g3nSk/sH0tH+Xg0IED3Cke21MSjsKE+PBIL87tmf6bVHyEMUJJOK4DbO
 rdIUoPptehWfof8u99ebRoD0c/m3JF5ZyMYBqFrNjvjwwOsoZkibfTWXi
 pK/FvmdzuOcGWv1UeicaSReL4fqp3k4NJdEGav/crY4JLacD0wc3fIChw
 9pnjNrhYx1Nxd4HMT0/Tt4SQmJ1rWEmcjGWICVyxbxppzPKg7ymtOubzd
 02Wel2Sdhy5AsvyRjTPl7afEO98Ek7kBs0BADloQdM8QgzkYOxO6eyOkW
 U0rRWruR99vyeGY6Judt3UkD7UoszIYkmTvWMi++CUTEzob1GiL+JXAzV w==;
X-CSE-ConnectionGUID: JaLw/bA1TzmYGhVuKVCnXA==
X-CSE-MsgGUID: K9K3E9jCTz+1rGjn2Iwy8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575391"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:34:00 -0700
X-CSE-ConnectionGUID: ETJ6bPiBQJGUeE2QKiev+w==
X-CSE-MsgGUID: c4GGLqbhRP+ZAMRYCqQQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954836"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 11/17] vfio: Create host IOMMU device instance
Date: Wed,  5 Jun 2024 16:30:37 +0800
Message-Id: <20240605083043.317831-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Create host IOMMU device instance in vfio_attach_device() and call
.realize() to initialize it further.

Introuduce attribute VFIOIOMMUClass::hiod_typename and initialize
it based on VFIO backend type. It will facilitate HostIOMMUDevice
creation in vfio_attach_device().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  3 +++
 hw/vfio/common.c                      | 16 +++++++++++++++-
 hw/vfio/container.c                   |  2 ++
 hw/vfio/iommufd.c                     |  2 ++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 105b8b7e80..776de8064f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -127,6 +127,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
 } VFIODevice;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 2776481fc9..442c0dfc4c 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,9 @@ DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
 struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
+    /* Properties */
+    const char *hiod_typename;
+
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f9619a1dfb..f20a7b5bba 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1528,6 +1528,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1535,7 +1536,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    return ops->attach_device(name, vbasedev, as, errp);
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        return false;
+    }
+
+    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        ops->detach_device(vbasedev);
+        return false;
+    }
+    vbasedev->hiod = hiod;
+
+    return true;
 }
 
 void vfio_detach_device(VFIODevice *vbasedev)
@@ -1543,5 +1556,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
+    object_unref(vbasedev->hiod);
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 99beeba422..26e6f7fb4f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1126,6 +1126,8 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO;
+
     vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 1674c61227..409ed3dcc9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -612,6 +612,8 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
+
     vioc->dma_map = iommufd_cdev_map;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
-- 
2.34.1


