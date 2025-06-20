Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF3FC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW6E-0007CN-Ta; Fri, 20 Jun 2025 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW6C-000708-Pz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW68-0008Ot-Bg
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404220; x=1781940220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VzUt0kb/wH2GYgYNrDND9uyye5VJquaKBiwKH23wriM=;
 b=d0Srf7vY7NkV311DWsbqx1X+XWzchwEkQSb8gfxfGsWqzmyZndkANZr/
 tXjJ3JhLo5ZTWw3i4w8rlN0muRkegU5PXyw4BOY/wcTMvNVg/+30Uh0Ml
 qc4HojIwWtDCSPoVac/H0d8ZByvAq/J5yWDcOkyWY3Z1kKRsUJglGjIpk
 poRuQXeACXfe01bd+NHf8VNbZGJpRsxBCQQ6hDbnpvP+/nwgesIrw4Nr5
 rypSMOmSdIFTUDBJa8s9zTvQws9/wrG9/4Y3ZOagVrMtY0XnqrQK+uoWu
 qW52/IemqCTw4GrKSIXQEePdKvwi+xucYw8+D0yuFoFmWkoCnW9jY5MI+ A==;
X-CSE-ConnectionGUID: mprVRM0NTDioHqo4SpUN3w==
X-CSE-MsgGUID: f8IIv6/iR9iWgkBa1KSHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532550"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:39 -0700
X-CSE-ConnectionGUID: IWNMB03hQsO0t2+mjKmWCg==
X-CSE-MsgGUID: JMfLiqzcSEScfErqv577Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863284"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
Date: Fri, 20 Jun 2025 15:18:12 +0800
Message-Id: <20250620071813.55571-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on stage-2 page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.
https://www.intel.com/content/www/us/en/content-details/772415/content-details.html

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/iommufd.c                     |  8 +++++++-
 hw/vfio/listener.c                    | 13 +++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f0232654ee..e5c51a51ac 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    bool bypass_ro;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 83a632bdee..23839a511a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -306,6 +306,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    struct iommu_hw_info_vtd vtd;
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
@@ -345,10 +346,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, &vtd, sizeof(vtd), &hw_caps,
+                                         errp)) {
         return false;
     }
 
+    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        container->bcontainer.bypass_ro = true;
+    }
+
     if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23a93..c64aa4539e 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -364,7 +364,8 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
     return true;
 }
 
-static bool vfio_listener_valid_section(MemoryRegionSection *section,
+static bool vfio_listener_valid_section(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section,
                                         const char *name)
 {
     if (vfio_listener_skipped_section(section)) {
@@ -375,6 +376,10 @@ static bool vfio_listener_valid_section(MemoryRegionSection *section,
         return false;
     }
 
+    if (bcontainer && bcontainer->bypass_ro && section->readonly) {
+        return false;
+    }
+
     if (unlikely((section->offset_within_address_space &
                   ~qemu_real_host_page_mask()) !=
                  (section->offset_within_region & ~qemu_real_host_page_mask()))) {
@@ -494,7 +499,7 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
     int ret;
     Error *err = NULL;
 
-    if (!vfio_listener_valid_section(section, "region_add")) {
+    if (!vfio_listener_valid_section(bcontainer, section, "region_add")) {
         return;
     }
 
@@ -655,7 +660,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     int ret;
     bool try_unmap = true;
 
-    if (!vfio_listener_valid_section(section, "region_del")) {
+    if (!vfio_listener_valid_section(bcontainer, section, "region_del")) {
         return;
     }
 
@@ -812,7 +817,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
+    if (!vfio_listener_valid_section(NULL, section, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
-- 
2.34.1


