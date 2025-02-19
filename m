Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E1C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQo-0006Fr-Dx; Wed, 19 Feb 2025 03:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQR-0005tS-Ca
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:23 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQN-0004eO-Pm
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953640; x=1771489640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e1ZoscbXzm2c5PiXufM2JI3ZULck95SCPA/nxqF9N3o=;
 b=F+E8ZtqXTjZB9F8nepYHLtMiupki9lFl3anZ0Fn0IxvYR2y1YSgFGLeJ
 77ANMUiyA5RBE0B9k2pIT5vaz3YTLq7rISKQjGGCvx95p6h7CaqLZsbQG
 BjU5PdaCjGK9BCwspsGaaL4khyg8gJ5lr43aO6yE+XZH7MHL1SkeILGsm
 WRsf44LOQU2vixpQdGPNHJyK6piRiBlMcaLxEl96FdXAXsc/eWrcyat7d
 WWzNUoVAgwkL3mzNwBXGxI7kHDcmiJArLSQAp6CqAciqf+HOevZgLSYHO
 tlkWEX+VooB2vZxx7cTr0gHPh0WqvoDXN8gbvVfr3BQRgBa+LIaUN0Hve Q==;
X-CSE-ConnectionGUID: TIAzrPTOT8eKzDmg+h/sQA==
X-CSE-MsgGUID: +xZfryd/TqeR8CKydeOoCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544269"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544269"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:19 -0800
X-CSE-ConnectionGUID: ShIrIk7VSU+LIMYgGF3efQ==
X-CSE-MsgGUID: jcMoocxfTTm8iXKV3FEq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851359"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 15/20] intel_iommu: ERRATA_772415 workaround
Date: Wed, 19 Feb 2025 16:22:23 +0800
Message-Id: <20250219082228.3303163-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

[0] https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update

We utilize the new added IOMMUFD container/ioas/hwpt management framework in
VTD. Add a check to create new VTDIOASContainer to hold RW-only mappings,
then this VTDIOASContainer can be used as backend for device with
ERRATA_772415. See below diagram for details:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.    .-------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
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
 hw/i386/intel_iommu.c          | 26 +++++++++++++++++++-------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 23b7e236b0..8558781af8 100644
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
index e36ac44110..dae1716629 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2443,7 +2443,8 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
 }
 
 #ifdef CONFIG_IOMMUFD
-static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
+static bool iommufd_listener_skipped_section(VTDIOASContainer *container,
+                                             MemoryRegionSection *section)
 {
     return !memory_region_is_ram(section->mr) ||
            memory_region_is_protected(section->mr) ||
@@ -2453,7 +2454,8 @@ static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
             * are never accessed by the CPU and beyond the address width of
             * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
             */
-           section->offset_within_address_space & (1ULL << 63);
+           section->offset_within_address_space & (1ULL << 63) ||
+           (container->errata && section->readonly);
 }
 
 static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
@@ -2469,7 +2471,7 @@ static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
     Error *err = NULL;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2520,7 +2522,7 @@ static void iommufd_listener_region_del_s2domain(MemoryListener *listener,
     Int128 llend, llsize;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2776,7 +2778,8 @@ static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(container, &s->containers, next) {
-        if (container->iommufd != iommufd) {
+        if (container->iommufd != iommufd ||
+            container->errata != vtd_hiod->errata) {
             continue;
         }
 
@@ -2803,6 +2806,7 @@ static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     container = g_malloc0(sizeof(*container));
     container->iommufd = iommufd;
     container->ioas_id = ioas_id;
+    container->errata = vtd_hiod->errata;
     QLIST_INIT(&container->s2_hwpt_list);
 
     if (vtd_device_attach_container(vtd_hiod, container, pasid, pe, hwpt,
@@ -5329,9 +5333,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -5388,6 +5393,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
+    ret = hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_ERRATA, errp);
+    if (ret < 0) {
+        return false;
+    }
+    vtd_hiod->errata = ret;
+
     error_setg(errp, "host device is uncompatible with stage-1 translation");
     return false;
 }
@@ -5419,7 +5430,8 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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


