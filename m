Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B24CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLUJ-00019H-FR; Fri, 22 Aug 2025 02:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLUA-0000dv-Mn
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:50 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLU8-0000ng-9m
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844968; x=1787380968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mUU9OMMJ/1zTbxE4IweHoAT8lJKpLVKsUXa0W5k5u1I=;
 b=iUB6lacKUJ+As4cF37Yy2kXOV1HfFCbU2HNlhW+u3uZ418KR5JXnLdZe
 IgqeeLcFblna+4lAwAH3eiSbdM9vHttpwP3soTiuXXHekOsnSGWM5U6/0
 RMnTdl8192P23/xrPqWwquICBYMpGSoQMpjkRO+8rwdf1VoRq241+W4DH
 WuXQOLjZoG1EJ0XZGYtmTmnmdNXRvM9KNlmP8QOokcw62eDIlP35EiYc2
 1Ev+V9ZPjJGcf4XUWv9qhsEw1la3irh2qhEXqMmxDQfhj90iOzGmcYiWy
 w6IMQauNo8N7adi1j1OsD7SsdN5EaExQcK3w9GZIQm4aI3tzj2zKo3mwh A==;
X-CSE-ConnectionGUID: I5CCE4pKRoqNpcOxD1YQrQ==
X-CSE-MsgGUID: GJ7xhqbKRa+0fRKDA0G8Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851987"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851987"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:40 -0700
X-CSE-ConnectionGUID: rd1+3vbjTl6RIjUoQMs/Wg==
X-CSE-MsgGUID: ED41qg/dQH2J2sF6wCdOeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168245093"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 19/21] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Date: Fri, 22 Aug 2025 02:40:57 -0400
Message-ID: <20250822064101.123526-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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

When bypass_ro is true, readonly memory section is bypassed from
mapping in the container.

This is a preparing patch to workaround Intel ERRATA_772415.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/listener.c                    | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

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
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 903dfd8bf2..5fa2bb7f1a 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-static bool vfio_listener_skipped_section(MemoryRegionSection *section)
+static bool vfio_listener_skipped_section(MemoryRegionSection *section,
+                                          bool bypass_ro)
 {
+    if (bypass_ro && section->readonly) {
+        return true;
+    }
+
     return (!memory_region_is_ram(section->mr) &&
             !memory_region_is_iommu(section->mr)) ||
            memory_region_is_protected(section->mr) ||
@@ -365,9 +370,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
 }
 
 static bool vfio_listener_valid_section(MemoryRegionSection *section,
-                                        const char *name)
+                                        bool bypass_ro, const char *name)
 {
-    if (vfio_listener_skipped_section(section)) {
+    if (vfio_listener_skipped_section(section, bypass_ro)) {
         trace_vfio_listener_region_skip(name,
                 section->offset_within_address_space,
                 section->offset_within_address_space +
@@ -494,7 +499,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
     int ret;
     Error *err = NULL;
 
-    if (!vfio_listener_valid_section(section, "region_add")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_add")) {
         return;
     }
 
@@ -655,7 +661,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
     int ret;
     bool try_unmap = true;
 
-    if (!vfio_listener_valid_section(section, "region_del")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_del")) {
         return;
     }
 
@@ -812,7 +819,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
+    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
@@ -1206,7 +1213,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     int ret;
     Error *local_err = NULL;
 
-    if (vfio_listener_skipped_section(section)) {
+    if (vfio_listener_skipped_section(section, false)) {
         return;
     }
 
-- 
2.47.1


