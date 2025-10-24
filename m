Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B50CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRP-0006Z1-LC; Fri, 24 Oct 2025 04:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQx-0006E2-JC
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:04 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQt-0006be-Qn
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295560; x=1792831560;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7BU4pEb3H3f407uooYJQf52IS8ieUjb+FQAxUIr5PTw=;
 b=nrqxRB/HkPhDhrbtvyaIxunG1EW+A6LdHWsY/GluRddmcLYyHW1AbfgF
 k/pqQJY2xds+hgTtqzqT4PUHAVGJQ+7vIItADramRgsPJ9lQTNqLFt+XC
 /Szg1pCTqxctRLCHlMkifnoXRZSQj/N+0OBBTLmD1VKRmZz7e7BjJWIfy
 cKNrDln566MH7GDyQ4YO/YwS2WxLFYEq7Nt5ny+5APdQVzzRR3zxDiGNi
 cr0KdluflgNjSVDd/hVJJb4R+KwqLJ7cnLZnjyDGvUB4TyAt7GbSos3kw
 7GDOanxnWLaz4ROnGbjrnnlXjXnIMNQZ8QlRMc4gLbEtGX/bWKKuGoOIZ Q==;
X-CSE-ConnectionGUID: cQzN9bGDRFu5qAfvaIzciQ==
X-CSE-MsgGUID: B65tgJhpQV27knqdZ5PVVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504898"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:47 -0700
X-CSE-ConnectionGUID: ec/oKx0oS6e/Lg56v50fTA==
X-CSE-MsgGUID: gxMCIjgVRMCP4l+CLhW0iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986039"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 18/23] vfio: Add a new element bypass_ro in VFIOContainer
Date: Fri, 24 Oct 2025 04:43:42 -0400
Message-ID: <20251024084349.102322-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

When bypass_ro is true, readonly memory section is bypassed from mapping
in the container.

This is a preparing patch to workaround Intel ERRATA_772415, see changelog
in next patch for details about the errata.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  1 +
 hw/vfio/listener.c               | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 9f6e8cedfc..a7d5c5ed67 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -52,6 +52,7 @@ struct VFIOContainer {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
+    bool bypass_ro;
 };
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2109101158..0862b2b834 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
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
@@ -368,9 +373,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
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
@@ -497,7 +502,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
     int ret;
     Error *err = NULL;
 
-    if (!vfio_listener_valid_section(section, "region_add")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_add")) {
         return;
     }
 
@@ -663,7 +669,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
     int ret;
     bool try_unmap = true;
 
-    if (!vfio_listener_valid_section(section, "region_del")) {
+    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
+                                     "region_del")) {
         return;
     }
 
@@ -821,7 +828,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
+    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
@@ -1215,7 +1222,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     int ret;
     Error *local_err = NULL;
 
-    if (vfio_listener_skipped_section(section)) {
+    if (vfio_listener_skipped_section(section, false)) {
         return;
     }
 
-- 
2.47.1


