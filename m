Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F75CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fkL-0001H9-SZ; Fri, 17 Oct 2025 04:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9fkF-0001GR-Qz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:23:28 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9fk3-0001DU-LW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760689396; x=1792225396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B8RsLZ8p+QijWO4o8Awavo9qU6AbRzyIRgV0bwow53E=;
 b=NXwjAYI4Bn4c4UKXO64u2WB8o62yu6LEJBAo4cUGF/8IV2Djczp9DYDb
 nAtgfTLZ/FpICcdSVNv5+Ejq2crEC2u5nrRh2pYFt6A+VmORBn3Mfowvg
 U/YDnrh7d1yVo/ZaAJsHkiBTIpQZxEopGIFceJcUV2LGmLO/26GdtE19S
 YRLwKvBt0rv5XPZx9cRikLoLi25FdGov3h/p1V2u3LbB6vrC1ANFF64/U
 PNFT0wvaXUl11Yyctu6qrYj8rynHKxnQ3nwBAfTTzKlwUrK/QS9GltPHY
 Nm+Yj6Ywl3JPODISDVGVNkfMPtczM0l9U4FCnjFH0ojJVTBDhGHnr39cf A==;
X-CSE-ConnectionGUID: mXs+fq7wTCGGijaW0eQAmw==
X-CSE-MsgGUID: FU5CeVyPRJOsu4f1N6uxTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61927432"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="61927432"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:23:07 -0700
X-CSE-ConnectionGUID: omXMVP9kQN2LttWG4ivX0Q==
X-CSE-MsgGUID: WnjumPZhSw2O/uozIhDAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182484700"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:23:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy VFIO
 backend
Date: Fri, 17 Oct 2025 04:22:31 -0400
Message-ID: <20251017082234.517827-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251017082234.517827-1-zhenzhong.duan@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

If a VFIO device in guest switches from IOMMU domain to block domain,
vtd_address_space_unmap() is called to unmap whole address space.

If that happens during migration, migration fails with legacy VFIO
backend as below:

Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))

Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
ioctl fails.

Fix it by iterating over DMAMap list to unmap each range with active mapping
when migration is active. If migration is not active, unmapping the whole
address space in one go is optimal.

There is no such limitation with iommufd backend, but it's still not optimal
to allocate large bitmap, e.g., there may be large hole between IOVA ranges,
allocating large bitmap and dirty tracking on the hole is time consuming and
useless work.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6a168d5107..f32d4f5a15 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,7 @@
 #include "system/system.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
+#include "migration/misc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -4533,6 +4534,42 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     vtd_iommu_unlock(s);
 }
 
+/*
+ * Unmapping a large range in one go is not optimal during migration because
+ * a large dirty bitmap needs to be allocated while there may be only small
+ * mappings, iterate over DMAMap list to unmap each range with active mapping.
+ */
+static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
+                                                 IOMMUNotifier *n)
+{
+    const DMAMap *map;
+    const DMAMap target = {
+        .iova = n->start,
+        .size = n->end,
+    };
+    IOVATree *tree = as->iova_tree;
+
+    /*
+     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
+     * page size and always a power of 2 in size. So the range of DMAMap could
+     * be used for UNMAP notification directly.
+     */
+    while ((map = iova_tree_find(tree, &target))) {
+        IOMMUTLBEvent event;
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+        event.entry.iova = map->iova;
+        event.entry.addr_mask = map->size;
+        event.entry.target_as = &address_space_memory;
+        event.entry.perm = IOMMU_NONE;
+        /* This field is meaningless for unmap */
+        event.entry.translated_addr = 0;
+        memory_region_notify_iommu_one(n, &event);
+
+        iova_tree_remove(tree, *map);
+    }
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4542,6 +4579,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     IntelIOMMUState *s = as->iommu_state;
     DMAMap map;
 
+    if (migration_is_running()) {
+        vtd_address_space_unmap_in_migration(as, n);
+        return;
+    }
+
     /*
      * Note: all the codes in this function has a assumption that IOVA
      * bits are no more than VTD_MGAW bits (which is restricted by
-- 
2.47.1


