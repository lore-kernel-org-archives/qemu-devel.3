Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E1BC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU0e-00006W-18; Fri, 06 Jun 2025 06:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0c-0008VW-3n
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:10 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0Y-0007c5-Ol
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204547; x=1780740547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q3wormEEGeUh36k5q/SXUPIQBAZnaFNQWqVM/nQtR8A=;
 b=i05ER6RQzbf4A4gNn1iN6t7PW5zV1G9JX64LwaO0+YeUCKQZ5LmpnO7L
 Xna9nyT/NM9lLwAN7MgNVQ5sdgCxAz3qi76hzHZwlP/JqFmOvX/jg5bvs
 c8OT3y/Yk56Q/mDlUq6YjKG3TSi/hGlO206H4phXdgMiAnSml0zllf3ZY
 pogQ16BG2bSHeduyXQRjHJprMnDHHnDJQKkfLlfkTmb5ObVIoU6ORt3Ll
 HY3dVprPowUgcml6EvFT4iuhJjyxIO+2bIrXGafu/bqjaYgsInF3F3VPS
 brABzOY1uPHnCfFwSLd7HVYG/WnWT8IJfqydmtSCDY0h2ucLRU7KkXLc2 w==;
X-CSE-ConnectionGUID: q8lePDPnSXWcv+ZzDkcCCQ==
X-CSE-MsgGUID: OGjJAvHHR5KdpgJeyg+Vfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747328"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:06 -0700
X-CSE-ConnectionGUID: f5TVheyPQcSvKypLWArZBw==
X-CSE-MsgGUID: 1dmiqzibROGr76goTIOcTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759171"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 10/15] intel_iommu: ERRATA_772415 workaround
Date: Fri,  6 Jun 2025 18:04:11 +0800
Message-Id: <20250606100416.346132-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on stage-2 page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.

[0] https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update

We utilize the new added IOMMUFD container/ioas/hwpt management framework in
VTD. Add a check to create new VTDIOASContainer to only hold RW mappings,
then this VTDIOASContainer can be used as backend for device with
ERRATA_772415. See below diagram for details:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.    .-------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,only RW)|
    .------------------.    .------------------.    .-------------------.
             |                       |                              |
             |                       .-->...                        |
             V                                                      V
      .-------------------.    .-------------------.          .---------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
      .-------------------.    .-------------------.          .---------------.
          |            |               |                            |
          |            |               |                            |
    .-----------.  .-----------.  .------------.              .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
    |           |  |           |  | (iommufd0) |              | (iommufd0) |
    .-----------.  .-----------.  .------------.              .------------.

Changed to pass VTDHostIOMMUDevice pointer to vtd_check_hdev() so errata
could be saved.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 hw/i386/intel_iommu.c          | 22 +++++++++++++++-------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e76f43bb8f..75d840f9fe 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -654,5 +654,6 @@ typedef struct VTDHostIOMMUDevice {
     PCIBus *bus;
     uint8_t devfn;
     HostIOMMUDevice *hiod;
+    uint32_t errata;
 } VTDHostIOMMUDevice;
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 594281c1d3..9b156dc32e 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -103,6 +103,7 @@ typedef struct VTDPASIDCacheEntry {
 typedef struct VTDIOASContainer {
     struct IOMMUFDBackend *iommufd;
     uint32_t ioas_id;
+    uint32_t errata;
     MemoryListener listener;
     QLIST_HEAD(, VTDS2Hwpt) s2_hwpt_list;
     QLIST_ENTRY(VTDIOASContainer) next;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7064d19be1..b8c0d0dd2e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2437,7 +2437,8 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
 }
 
 #ifdef CONFIG_IOMMUFD
-static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
+static bool iommufd_listener_skipped_section(VTDIOASContainer *container,
+                                             MemoryRegionSection *section)
 {
     return !memory_region_is_ram(section->mr) ||
            memory_region_is_protected(section->mr) ||
@@ -2447,7 +2448,8 @@ static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
             * are never accessed by the CPU and beyond the address width of
             * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
             */
-           section->offset_within_address_space & (1ULL << 63);
+           section->offset_within_address_space & (1ULL << 63) ||
+           (container->errata && section->readonly);
 }
 
 static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
@@ -2463,7 +2465,7 @@ static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
     Error *err = NULL;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2514,7 +2516,7 @@ static void iommufd_listener_region_del_s2domain(MemoryListener *listener,
     Int128 llend, llsize;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2770,7 +2772,8 @@ static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(container, &s->containers, next) {
-        if (container->iommufd != iommufd) {
+        if (container->iommufd != iommufd ||
+            container->errata != vtd_hiod->errata) {
             continue;
         }
 
@@ -2797,6 +2800,7 @@ static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     container = g_malloc0(sizeof(*container));
     container->iommufd = iommufd;
     container->ioas_id = ioas_id;
+    container->errata = vtd_hiod->errata;
     QLIST_INIT(&container->s2_hwpt_list);
 
     if (vtd_device_attach_container(vtd_hiod, container, pasid, pe, hwpt,
@@ -5355,9 +5359,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -5406,6 +5411,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
         return false;
     }
+
+    vtd_hiod->errata = vtd->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 #endif
 
     error_setg(errp, "host device is uncompatible with stage-1 translation");
@@ -5439,7 +5446,8 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
 
-    if (!vtd_check_hiod(s, hiod, errp)) {
+    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
+        g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
     }
-- 
2.34.1


