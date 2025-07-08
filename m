Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C22CC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDi-0003tw-NH; Tue, 08 Jul 2025 16:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsP-0000iS-Sd
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:16 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsK-00082f-Oy
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002469; x=1783538469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=87jeU0Q5s4cmeTgXORj6Zg9qNbO+ELiEuV0x8pWO1/Q=;
 b=ZLyE9pCwc0rp1tSE13nZ7RmsdGl5+gfMCFFa0F/DtX2v/O7Nvb1v9agh
 06vuuzSGcEew2nvngNeqwzYjJV/xP6wIlEhsRKF2N+Gnah3bVxIrPs0PP
 ir/Qd0q+FgLBqjcD9jpuOCUb7Kt0fz6StOq+Bup+O1swao+Jlwi9B6n6J
 xUI5awxxfJFHLWJRbEz5y/aRgRll7J3kk8DAHtmba3pmAq6RkwA7fKZMI
 2ECTJoBJexr8sYreJT2aqVcQFlkkdgkPKUs7QIEdIUcJwbHVGiEz3ZXY/
 nRCZBPi6fCKyiF5zw0eLVYxpm4fWEMWuPwzn4Yp2KZ7DP6G41g9D5RWZC w==;
X-CSE-ConnectionGUID: lEh9z6YnSzeGiwiDC290wQ==
X-CSE-MsgGUID: X8H2FAt+RkWPvblg2AIrVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974091"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:30 -0700
X-CSE-ConnectionGUID: zqMh02LdT7OpYEH8kIqbtw==
X-CSE-MsgGUID: Nn+hzOVxRYCkLvVyGLSM/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192648024"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Date: Tue,  8 Jul 2025 07:05:59 -0400
Message-ID: <20250708110601.633308-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When bypass_ro is true, read only memory section is bypassed from
mapping in the container.

This is a preparing patch to workaround Intel ERRATA_772415.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c                    | 13 +++++++++----
 include/hw/vfio/vfio-container-base.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

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
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index bded6e993f..31fd784d76 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    bool bypass_ro;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
-- 
2.47.1


