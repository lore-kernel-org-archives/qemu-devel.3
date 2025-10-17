Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF5ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gsw-0002U3-U8; Fri, 17 Oct 2025 05:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsw-0002Tr-2r
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:30 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsr-0004xy-Tl
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760693786; x=1792229786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cn0j4PnV0diFou5JBicpvm8/IDJS/tOTYRmC+1DwupM=;
 b=YEpn26UXaDBSs+JbvU898A38kMKqssGjBEPrHibK9w46V4b/vfQ6U5dm
 pey8ZFNv2Q2OTVKQwvSb5jkwWZlRdoFhQvqz3Lf8QQWJeOoTeyQVlJmKB
 NNWAN8yjaPOjS9x1yX5epLw85unV+8aNBZBuoqez4yO5zLO75Wqh1Zbn7
 dRH2/o5JTx5aaqNIbBjvx3370O7Ey/DQU5pVwlRmunmJvHLYdcM0eP/qK
 EEQswi0DTaW8xLs8cZGW6+jTN1OmYVYX7XBOaVvzhnxcVan0kaBOb3VxZ
 lW5p1RomqXJClLQjJ13jITedbgjmHJvyv5MxLbbqrO3r4/FF/tdqvOjJh Q==;
X-CSE-ConnectionGUID: eUnSOhxTQLaeIaSFyZT0MA==
X-CSE-MsgGUID: tajG2GfTQ8qxyxDbRLwi+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62805646"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="62805646"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:18 -0700
X-CSE-ConnectionGUID: SMWODPelQ96HLHILqVan0Q==
X-CSE-MsgGUID: KWRZiB7YSIWDCaIsL32NSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="186720569"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 3/3] intel_iommu: Fix DMA failure when guest switches IOMMU
 domain
Date: Fri, 17 Oct 2025 05:36:02 -0400
Message-ID: <20251017093602.525338-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251017093602.525338-1-zhenzhong.duan@intel.com>
References: <20251017093602.525338-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

Kernel allows user to switch IOMMU domain, e.g., switch between DMA
and identity domain. When this happen in IOMMU scalable mode, a pasid
cache invalidation request is sent, this request is ignored by vIOMMU
which leads to device binding to wrong address space, then DMA fails.

This issue exists in scalable mode with both first stage and second
stage translations, both emulated and passthrough devices.

Take network device for example, below sequence trigger issue:

1. start a guest with iommu=pt
2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
3. echo DMA > /sys/kernel/iommu_groups/6/type
4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
5. Ping test

Fix it by switching address space in invalidation handler.

Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 07bc0a749c..c402643b56 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3087,6 +3087,11 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
     return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
+static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return memcmp(p1, p2, sizeof(*p1));
+}
+
 /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
 static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
                                         gpointer user_data)
@@ -3095,15 +3100,28 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDAddressSpace *vtd_as = value;
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
     VTDPASIDEntry pe;
+    IOMMUNotifier *n;
     uint16_t did;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        if (!pc_entry->valid) {
+            return;
+        }
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
         pc_entry->valid = false;
+
+        /*
+         * When a pasid entry isn't valid any more, we should unmap all
+         * mappings in shadow pages instantly to ensure DMA security.
+         */
+        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+            vtd_address_space_unmap(vtd_as, n);
+        }
+        vtd_switch_address_space(vtd_as);
         return;
     }
 
@@ -3129,8 +3147,15 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
         }
     }
 
-    pc_entry->pasid_entry = pe;
-    pc_entry->valid = true;
+    if (!pc_entry->valid) {
+        pc_entry->pasid_entry = pe;
+        pc_entry->valid = true;
+    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        return;
+    }
+
+    vtd_switch_address_space(vtd_as);
+    vtd_address_space_sync(vtd_as);
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
-- 
2.47.1


