Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515E2C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQt-0006mX-V4; Wed, 19 Feb 2025 03:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQQ-0005sh-76
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:22 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQK-0004ec-4k
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953636; x=1771489636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sOBnLHCFTP5L2Gm+1vdPakaLuqtDi38bAAMzuIlq5Bk=;
 b=RGOP6m2QVfBUc09y2fcPd6ZQPbSKhFSF34hPLhpfrowGJRS+KgkkfZLd
 irdF+1d14HQ23GA1Bmq88t2zwk0SZaJDWwvBNIyuFjfPrxHqcZVsKtX7+
 J85zmoRJ3HsqbLqA9Vbmyl6iLj/IzbxA1XfHGdoc6j3o99coP+fRAF/mp
 YaGicGLnC+cXGSxdQdv1y89VcseXuhXT6st/YTnJu5oxWzUduubzy1S+l
 EoMhcy5OIQEra8vmHHjwObUWlZv88Bu723RPFYVS6exEB6eZSUMsdxI0c
 nE6fO6/AVu+aaMK1nFBiv44tPpvSkarun+lKbHyqeixdCtFaCbUq7PNNY w==;
X-CSE-ConnectionGUID: 1dH22jbcTCuKV4sdR3R2Bg==
X-CSE-MsgGUID: rPBF+nK7TRq2Tpn1vm/KqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544255"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544255"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:14 -0800
X-CSE-ConnectionGUID: M7CLyQkvSJ+XPAwJj2Gj5w==
X-CSE-MsgGUID: /XdgePEQT4ef7gROyQWwrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851314"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:08 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 14/20] intel_iommu: Bind/unbind guest page table to host
Date: Wed, 19 Feb 2025 16:22:22 +0800
Message-Id: <20250219082228.3303163-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This captures the guest PASID table entry modifications and
propagates the changes to host to attach a hwpt with type determined
per guest PGTT configuration.

When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
the hwpt on host side is a nested page table.

The guest page table is configured as stage-1 page table (gIOVA->GPA)
whose translation result would further go through host VT-d stage-2
page table(GPA->HPA) under nested translation mode. This is the key
to support gIOVA over stage-1 page table for Intel VT-d in
virtualization environment.

Stage-2 page table could be shared by different devices if there is
no conflict and devices link to same iommufd object, i.e. devices
under same host IOMMU can share same stage-2 page table. If there
is conflict, i.e. there is one device under non cache coherency
mode which is different from others, it requires a separate
stage-2 page table in non-CC mode.

See below example diagram:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->...
    |    (iommufd0)    |    |    (iommufd1)    |
    .------------------.    .------------------.
             |                       |
             |                       .-->...
             V
      .-------------------.    .-------------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...
      .-------------------.    .-------------------.
          |            |               |
          |            |               |
    .-----------.  .-----------.  .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |
    |           |  |           |  | (iommufd0) |
    .-----------.  .-----------.  .------------.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  11 +
 include/hw/i386/intel_iommu.h  |  24 ++
 hw/i386/intel_iommu.c          | 581 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   8 +
 4 files changed, 604 insertions(+), 20 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 632fda2853..23b7e236b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -563,6 +563,13 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UPDATE,
+    VTD_PASID_UNBIND,
+    VTD_OP_NUM
+} VTDPASIDOp;
+
 typedef enum VTDPCInvType {
     /* force reset all */
     VTD_PASID_CACHE_FORCE_RESET = 0,
@@ -578,6 +585,7 @@ typedef struct VTDPASIDCacheInfo {
     uint32_t pasid;
     PCIBus *bus;
     uint16_t devfn;
+    bool error_happened;
 } VTDPASIDCacheInfo;
 
 /* PASID Table Related Definitions */
@@ -606,6 +614,9 @@ typedef struct VTDPASIDCacheInfo {
 
 #define VTD_SM_PASID_ENTRY_FLPM          3ULL
 #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
+#define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
 
 /* First Level Paging Structure */
 /* Masks for First Level Paging Entry */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fbc9da903a..594281c1d3 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -100,10 +100,32 @@ typedef struct VTDPASIDCacheEntry {
     bool cache_filled;
 } VTDPASIDCacheEntry;
 
+typedef struct VTDIOASContainer {
+    struct IOMMUFDBackend *iommufd;
+    uint32_t ioas_id;
+    MemoryListener listener;
+    QLIST_HEAD(, VTDS2Hwpt) s2_hwpt_list;
+    QLIST_ENTRY(VTDIOASContainer) next;
+    Error *error;
+} VTDIOASContainer;
+
+typedef struct VTDS2Hwpt {
+    uint32_t users;
+    uint32_t hwpt_id;
+    VTDIOASContainer *container;
+    QLIST_ENTRY(VTDS2Hwpt) next;
+} VTDS2Hwpt;
+
+typedef struct VTDHwpt {
+    uint32_t hwpt_id;
+    VTDS2Hwpt *s2_hwpt;
+} VTDHwpt;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
     uint32_t pasid;
+    VTDHwpt hwpt;
     AddressSpace as;
     IOMMUMemoryRegion iommu;
     MemoryRegion root;          /* The root container of the device */
@@ -303,6 +325,8 @@ struct IntelIOMMUState {
 
     GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
 
+    QLIST_HEAD(, VTDIOASContainer) containers;
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b8f3b85803..e36ac44110 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
@@ -40,6 +41,9 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "system/iommufd.h"
+#ifdef CONFIG_IOMMUFD
+#include <linux/iommufd.h>
+#endif
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -838,11 +842,40 @@ static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
     return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
 }
 
+static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+}
+
+static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
+{
+    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if pgtt is first stage translation */
+static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
 }
 
+static inline void pasid_cache_info_set_error(VTDPASIDCacheInfo *pc_info)
+{
+    if (pc_info->error_happened) {
+        return;
+    }
+    pc_info->error_happened = true;
+}
+
 /**
  * Caller of this function should check present bit if wants
  * to use pdir entry for further usage except for fpd bit check.
@@ -1774,7 +1807,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -2409,6 +2442,497 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+#ifdef CONFIG_IOMMUFD
+static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
+{
+    return !memory_region_is_ram(section->mr) ||
+           memory_region_is_protected(section->mr) ||
+           /*
+            * Sizing an enabled 64-bit BAR can cause spurious mappings to
+            * addresses in the upper part of the 64-bit address space.  These
+            * are never accessed by the CPU and beyond the address width of
+            * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
+            */
+           section->offset_within_address_space & (1ULL << 63);
+}
+
+static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
+                                                 MemoryRegionSection *section)
+{
+    VTDIOASContainer *container = container_of(listener,
+                                               VTDIOASContainer, listener);
+    IOMMUFDBackend *iommufd = container->iommufd;
+    uint32_t ioas_id = container->ioas_id;
+    hwaddr iova;
+    Int128 llend, llsize;
+    void *vaddr;
+    Error *err = NULL;
+    int ret;
+
+    if (iommufd_listener_skipped_section(section)) {
+        return;
+    }
+    iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(qemu_real_host_page_mask()));
+    llsize = int128_sub(llend, int128_make64(iova));
+    vaddr = memory_region_get_ram_ptr(section->mr) +
+            section->offset_within_region +
+            (iova - section->offset_within_address_space);
+
+    memory_region_ref(section->mr);
+
+    ret = iommufd_backend_map_dma(iommufd, ioas_id, iova, int128_get64(llsize),
+                                  vaddr, section->readonly);
+    if (!ret) {
+        return;
+    }
+
+    error_setg(&err,
+               "iommufd_listener_region_add_s2domain(%p, 0x%"HWADDR_PRIx", "
+               "0x%"HWADDR_PRIx", %p) = %d (%s)",
+               container, iova, int128_get64(llsize), vaddr, ret,
+               strerror(-ret));
+
+    if (memory_region_is_ram_device(section->mr)) {
+        /* Allow unexpected mappings not to be fatal for RAM devices */
+        error_report_err(err);
+        return;
+    }
+
+    if (!container->error) {
+        error_propagate_prepend(&container->error, err, "Region %s: ",
+                                memory_region_name(section->mr));
+    } else {
+        error_free(err);
+    }
+}
+
+static void iommufd_listener_region_del_s2domain(MemoryListener *listener,
+                                                 MemoryRegionSection *section)
+{
+    VTDIOASContainer *container = container_of(listener,
+                                               VTDIOASContainer, listener);
+    IOMMUFDBackend *iommufd = container->iommufd;
+    uint32_t ioas_id = container->ioas_id;
+    hwaddr iova;
+    Int128 llend, llsize;
+    int ret;
+
+    if (iommufd_listener_skipped_section(section)) {
+        return;
+    }
+    iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(qemu_real_host_page_mask()));
+    llsize = int128_sub(llend, int128_make64(iova));
+
+    ret = iommufd_backend_unmap_dma(iommufd, ioas_id,
+                                    iova, int128_get64(llsize));
+    if (ret) {
+        error_report("iommufd_listener_region_del_s2domain(%p, "
+                     "0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx") = %d (%s)",
+                     container, iova, int128_get64(llsize), ret,
+                     strerror(-ret));
+    }
+
+    memory_region_unref(section->mr);
+}
+
+static const MemoryListener iommufd_s2domain_memory_listener = {
+    .name = "iommufd_s2domain",
+    .priority = 1000,
+    .region_add = iommufd_listener_region_add_s2domain,
+    .region_del = iommufd_listener_region_del_s2domain,
+};
+
+static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
+                                  VTDPASIDEntry *pe)
+{
+    memset(vtd, 0, sizeof(*vtd));
+
+    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_SRE : 0) |
+                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_WPE : 0) |
+                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_EAFE : 0);
+    vtd->addr_width = vtd_pe_get_fl_aw(pe);
+    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
+}
+
+static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                              VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
+                              VTDPASIDEntry *pe, Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd;
+    uint32_t hwpt_id, s2_hwpt_id = s2_hwpt->hwpt_id;
+
+    vtd_init_s1_hwpt_data(&vtd, pe);
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    s2_hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                    sizeof(vtd), &vtd, &hwpt_id, errp)) {
+        return -EINVAL;
+    }
+
+    hwpt->hwpt_id = hwpt_id;
+
+    return 0;
+}
+
+static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev, VTDHwpt *hwpt)
+{
+    iommufd_backend_free_id(idev->iommufd, hwpt->hwpt_id);
+}
+
+static VTDS2Hwpt *vtd_ioas_container_get_s2_hwpt(VTDIOASContainer *container,
+                                                 uint32_t hwpt_id)
+{
+    VTDS2Hwpt *s2_hwpt;
+
+    QLIST_FOREACH(s2_hwpt, &container->s2_hwpt_list, next) {
+        if (s2_hwpt->hwpt_id == hwpt_id) {
+            return s2_hwpt;
+        }
+    }
+
+    s2_hwpt = g_malloc0(sizeof(*s2_hwpt));
+
+    s2_hwpt->hwpt_id = hwpt_id;
+    s2_hwpt->container = container;
+    QLIST_INSERT_HEAD(&container->s2_hwpt_list, s2_hwpt, next);
+
+    return s2_hwpt;
+}
+
+static void vtd_ioas_container_put_s2_hwpt(VTDS2Hwpt *s2_hwpt)
+{
+    VTDIOASContainer *container = s2_hwpt->container;
+
+    if (s2_hwpt->users) {
+        return;
+    }
+
+    QLIST_REMOVE(s2_hwpt, next);
+    iommufd_backend_free_id(container->iommufd, s2_hwpt->hwpt_id);
+    g_free(s2_hwpt);
+}
+
+static void vtd_ioas_container_destroy(VTDIOASContainer *container)
+{
+    if (!QLIST_EMPTY(&container->s2_hwpt_list)) {
+        return;
+    }
+
+    QLIST_REMOVE(container, next);
+    memory_listener_unregister(&container->listener);
+    iommufd_backend_free_id(container->iommufd, container->ioas_id);
+    g_free(container);
+}
+
+static int vtd_device_attach_hwpt(VTDHostIOMMUDevice *vtd_hiod,
+                                  uint32_t pasid, VTDPASIDEntry *pe,
+                                  VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
+                                  Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    int ret;
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        ret = vtd_create_s1_hwpt(idev, s2_hwpt, hwpt, pe, errp);
+        if (ret) {
+            return ret;
+        }
+    } else {
+        hwpt->hwpt_id = s2_hwpt->hwpt_id;
+    }
+
+    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt->hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt->hwpt_id, ret);
+    if (ret) {
+        if (vtd_pe_pgtt_is_flt(pe)) {
+            vtd_destroy_s1_hwpt(idev, hwpt);
+        }
+        hwpt->hwpt_id = 0;
+        error_report("devid %d pasid %d failed to attach hwpt %d",
+                     idev->devid, pasid, hwpt->hwpt_id);
+        return ret;
+    }
+
+    s2_hwpt->users++;
+    hwpt->s2_hwpt = s2_hwpt;
+
+    return 0;
+}
+
+static void vtd_device_detach_hwpt(VTDHostIOMMUDevice *vtd_hiod,
+                                   uint32_t pasid, VTDPASIDEntry *pe,
+                                   VTDHwpt *hwpt, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    int ret;
+
+    if (vtd_hiod->iommu_state->dmar_enabled) {
+        ret = !host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+    } else {
+        ret = !host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+                                           ret);
+    }
+
+    if (ret) {
+        error_report("devid %d pasid %d failed to attach hwpt %d",
+                     idev->devid, pasid, hwpt->hwpt_id);
+    }
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        vtd_destroy_s1_hwpt(idev, hwpt);
+    }
+
+    hwpt->s2_hwpt->users--;
+    hwpt->s2_hwpt = NULL;
+    hwpt->hwpt_id = 0;
+}
+
+static int vtd_device_attach_container(VTDHostIOMMUDevice *vtd_hiod,
+                                       VTDIOASContainer *container,
+                                       uint32_t pasid, VTDPASIDEntry *pe,
+                                       VTDHwpt *hwpt, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IOMMUFDBackend *iommufd = idev->iommufd;
+    VTDS2Hwpt *s2_hwpt;
+    uint32_t s2_hwpt_id;
+    Error *err = NULL;
+    int ret;
+
+    /* try to attach to an existing hwpt in this container */
+    QLIST_FOREACH(s2_hwpt, &container->s2_hwpt_list, next) {
+        ret = vtd_device_attach_hwpt(vtd_hiod, pasid, pe, s2_hwpt, hwpt, &err);
+        if (ret) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vtd_device_fail_attach_existing_hwpt(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            goto found_hwpt;
+        }
+    }
+
+    if (!iommufd_backend_alloc_hwpt(iommufd, idev->devid, container->ioas_id,
+                                    IOMMU_HWPT_ALLOC_NEST_PARENT,
+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
+                                    &s2_hwpt_id, errp)) {
+        return -EINVAL;
+    }
+
+    s2_hwpt = vtd_ioas_container_get_s2_hwpt(container, s2_hwpt_id);
+
+    /* Attach vtd device to a new allocated hwpt within iommufd */
+    ret = vtd_device_attach_hwpt(vtd_hiod, pasid, pe, s2_hwpt, hwpt, errp);
+    if (ret) {
+        goto err_attach_hwpt;
+    }
+
+found_hwpt:
+    trace_vtd_device_attach_container(iommufd->fd, idev->devid, pasid,
+                                      container->ioas_id, hwpt->hwpt_id);
+    return 0;
+
+err_attach_hwpt:
+    vtd_ioas_container_put_s2_hwpt(s2_hwpt);
+    return ret;
+}
+
+static void vtd_device_detach_container(VTDHostIOMMUDevice *vtd_hiod,
+                                        uint32_t pasid, VTDPASIDEntry *pe,
+                                        VTDHwpt *hwpt, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IOMMUFDBackend *iommufd = idev->iommufd;
+    VTDS2Hwpt *s2_hwpt = hwpt->s2_hwpt;
+
+    trace_vtd_device_detach_container(iommufd->fd, idev->devid, pasid);
+    vtd_device_detach_hwpt(vtd_hiod, pasid, pe, hwpt, errp);
+    vtd_ioas_container_put_s2_hwpt(s2_hwpt);
+}
+
+static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     uint32_t pasid, VTDPASIDEntry *pe,
+                                     VTDHwpt *hwpt, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IOMMUFDBackend *iommufd = idev->iommufd;
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    VTDIOASContainer *container;
+    Error *err = NULL;
+    uint32_t ioas_id;
+    int ret;
+
+    /* try to attach to an existing container in this space */
+    QLIST_FOREACH(container, &s->containers, next) {
+        if (container->iommufd != iommufd) {
+            continue;
+        }
+
+        if (vtd_device_attach_container(vtd_hiod, container, pasid, pe, hwpt,
+                                        &err)) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vtd_device_fail_attach_existing_container(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            return 0;
+        }
+    }
+
+    /* Need to allocate a new dedicated container */
+    ret = iommufd_backend_alloc_ioas(iommufd, &ioas_id, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    trace_vtd_device_alloc_ioas(iommufd->fd, ioas_id);
+
+    container = g_malloc0(sizeof(*container));
+    container->iommufd = iommufd;
+    container->ioas_id = ioas_id;
+    QLIST_INIT(&container->s2_hwpt_list);
+
+    if (vtd_device_attach_container(vtd_hiod, container, pasid, pe, hwpt,
+                                    errp)) {
+        goto err_attach_container;
+    }
+
+    container->listener = iommufd_s2domain_memory_listener;
+    memory_listener_register(&container->listener, &address_space_memory);
+
+    if (container->error) {
+        ret = -1;
+        error_propagate_prepend(errp, container->error,
+                                "memory listener initialization failed: ");
+        goto err_listener_register;
+    }
+
+    QLIST_INSERT_HEAD(&s->containers, container, next);
+
+    return 0;
+
+err_listener_register:
+    vtd_device_detach_container(vtd_hiod, pasid, pe, hwpt, errp);
+err_attach_container:
+    iommufd_backend_free_id(iommufd, container->ioas_id);
+    g_free(container);
+    return ret;
+}
+
+static void vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                      uint32_t pasid, VTDPASIDEntry *pe,
+                                      VTDHwpt *hwpt, Error **errp)
+{
+    VTDIOASContainer *container = hwpt->s2_hwpt->container;
+
+    vtd_device_detach_container(vtd_hiod, pasid, pe, hwpt, errp);
+    vtd_ioas_container_destroy(container);
+}
+
+static int vtd_device_attach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
+                                   VTDAddressSpace *vtd_as, VTDPASIDEntry *pe)
+{
+    /*
+     * If pe->gptt != FLT, should be go ahead to do bind as host only
+     * accepts guest FLT under nesting. If pe->pgtt==PT, should setup
+     * the pasid with GPA page table. Otherwise should return failure.
+     */
+    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        return -EINVAL;
+    }
+
+    /* Should fail if the FLPT base is 0 */
+    if (vtd_pe_pgtt_is_flt(pe) && !vtd_pe_get_flpt_base(pe)) {
+        return -EINVAL;
+    }
+
+    return vtd_device_attach_iommufd(vtd_hiod, vtd_as->pasid, pe,
+                                     &vtd_as->hwpt, &error_abort);
+}
+
+static int vtd_device_detach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
+                                   VTDAddressSpace *vtd_as)
+{
+    VTDPASIDEntry *cached_pe = vtd_as->pasid_cache_entry.cache_filled ?
+                       &vtd_as->pasid_cache_entry.pasid_entry : NULL;
+
+    if (!cached_pe ||
+        (!vtd_pe_pgtt_is_flt(cached_pe) && !vtd_pe_pgtt_is_pt(cached_pe))) {
+        return 0;
+    }
+
+    vtd_device_detach_iommufd(vtd_hiod, vtd_as->pasid, cached_pe,
+                              &vtd_as->hwpt, &error_abort);
+
+    return 0;
+}
+
+/**
+ * Caller should hold iommu_lock.
+ */
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDHostIOMMUDevice *vtd_hiod;
+    int devfn = vtd_as->devfn;
+    int ret = -EINVAL;
+    struct vtd_as_key key = {
+        .bus = vtd_as->bus,
+        .devfn = devfn,
+    };
+
+    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+    if (!vtd_hiod || !vtd_hiod->hiod) {
+        /* means no need to go further, e.g. for emulated devices */
+        return 0;
+    }
+
+    if (vtd_as->pasid != PCI_NO_PASID) {
+        error_report("Non-rid_pasid %d not supported yet", vtd_as->pasid);
+        return ret;
+    }
+
+    switch (op) {
+    case VTD_PASID_UPDATE:
+    case VTD_PASID_BIND:
+    {
+        ret = vtd_device_attach_pgtbl(vtd_hiod, vtd_as, pe);
+        break;
+    }
+    case VTD_PASID_UNBIND:
+    {
+        ret = vtd_device_detach_pgtbl(vtd_hiod, vtd_as);
+        break;
+    }
+    default:
+        error_report_once("Unknown VTDPASIDOp!!!\n");
+        break;
+    }
+
+    return ret;
+}
+#else
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    return 0;
+}
+#endif
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -3151,21 +3675,27 @@ static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
  * This function fills in the pasid entry in &vtd_as. Caller
  * of this function should hold iommu_lock.
  */
-static void vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
-                                 VTDPASIDEntry *pe)
+static int vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe)
 {
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    int ret;
 
-    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
-        /* No need to go further as cached pasid entry is latest */
-        return;
+    if (pc_entry->cache_filled) {
+        if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+            /* No need to go further as cached pasid entry is latest */
+            return 0;
+        }
+        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_UPDATE);
+    } else {
+        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_BIND);
     }
 
-    pc_entry->pasid_entry = *pe;
-    pc_entry->cache_filled = true;
-    /*
-     * TODO: send pasid bind to host for passthru devices
-     */
+    if (!ret) {
+        pc_entry->pasid_entry = *pe;
+        pc_entry->cache_filled = true;
+    }
+    return ret;
 }
 
 /*
@@ -3231,14 +3761,20 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         goto remove;
     }
 
-    vtd_fill_pe_in_cache(s, vtd_as, &pe);
+    if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
+        pasid_cache_info_set_error(pc_info);
+    }
     return false;
 
 remove:
-    /*
-     * TODO: send pasid unbind to host for passthru devices
-     */
-    pc_entry->cache_filled = false;
+    if (pc_entry->cache_filled) {
+        if (vtd_bind_guest_pasid(vtd_as, NULL, VTD_PASID_UNBIND)) {
+            pasid_cache_info_set_error(pc_info);
+            return false;
+        } else {
+            pc_entry->cache_filled = false;
+        }
+    }
 
     /*
      * Don't remove address space of PCI_NO_PASID which is created by PCI
@@ -3253,7 +3789,7 @@ remove:
 /* Caller of this function should hold iommu_lock */
 static void vtd_pasid_cache_reset(IntelIOMMUState *s)
 {
-    VTDPASIDCacheInfo pc_info;
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
 
     trace_vtd_pasid_cache_reset();
 
@@ -3308,7 +3844,9 @@ static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
                 pasid = pasid_next;
                 continue;
             }
-            vtd_fill_pe_in_cache(s, vtd_as, &pe);
+            if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
+                pasid_cache_info_set_error(info);
+            }
         }
         pasid = pasid_next;
     }
@@ -3416,6 +3954,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
         walk_info.devfn = vtd_hiod->devfn;
         vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
     }
+    if (walk_info.error_happened) {
+        pasid_cache_info_set_error(pc_info);
+    }
 }
 
 /*
@@ -3485,9 +4026,9 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
     uint16_t domain_id;
     uint32_t pasid;
-    VTDPASIDCacheInfo pc_info;
     uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
 
@@ -3526,7 +4067,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     }
 
     vtd_pasid_cache_sync(s, &pc_info);
-    return true;
+    return !pc_info.error_happened ? true : false;
 }
 
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a26b38b52c..22559eb787 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -72,6 +72,14 @@ vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low
 vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
+vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
+vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_device_fail_attach_existing_hwpt(const char *msg) " %s"
+vtd_device_attach_container(int fd, uint32_t dev_id, uint32_t pasid, uint32_t ioas_id, uint32_t hwpt_id) "iommufd %d dev_id %d pasid %d ioas_id %d hwpt_id %d"
+vtd_device_detach_container(int fd, uint32_t dev_id, uint32_t pasid) "iommufd %d dev_id %d pasid %d"
+vtd_device_fail_attach_existing_container(const char *msg) " %s"
+vtd_device_alloc_ioas(int fd, uint32_t ioas_id) "iommufd %d ioas_id %d"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.34.1


