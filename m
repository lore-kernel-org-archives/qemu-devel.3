Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E6DD2E9C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPy1-0007Se-4p; Mon, 11 Nov 2024 03:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPx1-00057W-VH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:11 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPx0-0003UY-60
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314350; x=1762850350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cN75kkRrAHwMKhumGPgVChcmVrWw0uEdQ/zpwDNqDSM=;
 b=kr9bUTYJmXfnzsEbaikSuf3vl8t7+JhUnF0mRqWKifkB3oAZaLt6vQ1x
 ucpS45DhCk7zxcdSPi3n69bwaB/V96usOl+KROXKdYFNAw0juPTF/a0ZO
 C/URj7CaUaSB7bvoIHK/zCVZQncggaWBkhwYnzXxctFBFjDzKAVuTOYpO
 4M1QYsXRkq/3/WHNElf+YuYnmXBks1cYD+xqjzgkR5A8HflmHpS8f1A2U
 7b4pL6+cORMV80PUY8w3W1jdfK1fnmj7NZovo6oBX9U+DcXzctuedqWeW
 i+LJBzTYblnm7GJA6bEdJLY4ZSFbKS+IdrweLMSepZbIiMeah7TI10VkH w==;
X-CSE-ConnectionGUID: EWuimuTOR1+03cDsgIRwbg==
X-CSE-MsgGUID: Aiy3s6jTTa6aEIrwVmNegw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334527"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334527"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:09 -0800
X-CSE-ConnectionGUID: Hr6Pryu0RGmF+9i8YyvQJw==
X-CSE-MsgGUID: vP507Px5TA6/Zj9kcku7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608376"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:05 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 14/20] intel_iommu: piotlb invalidation should notify unmap
Date: Mon, 11 Nov 2024 16:34:51 +0800
Message-Id: <20241111083457.2090664-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

This is used by some emulated devices which caches address
translation result. When piotlb invalidation issued in guest,
those caches should be refreshed.

There is already a similar implementation in iotlb invalidation.
So update vtd_iotlb_page_invalidate_notify() to make it work
also for piotlb invalidation.

For device that does not implement ATS capability or disable
it but still caches the translation result, it is better to
implement ATS cap or enable it if there is need to cache the
translation result.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f80d60c16e..b921793c3a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2450,8 +2450,13 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     }
 }
 
+/*
+ * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
+ * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
+ * descriptor is passed which should not be PCI_NO_PASID.
+ */
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
-                                           uint16_t domain_id, hwaddr addr,
+                                             uint16_t domain_id, hwaddr addr,
                                              uint8_t am, uint32_t pasid)
 {
     VTDAddressSpace *vtd_as;
@@ -2460,19 +2465,37 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
-        if (pasid != PCI_NO_PASID && pasid != vtd_as->pasid) {
-            continue;
-        }
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = PCI_NO_PASID;
+
+            if (s->root_scalable) {
+                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+            }
+
+            /*
+             * In legacy mode, vtd_as->pasid == pasid is always true.
+             * In scalable mode, for vtd address space backing a PCI
+             * device without pasid, needs to compare pasid with
+             * rid2pasid of this device.
+             */
+            if (!(vtd_as->pasid == pasid ||
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
+                continue;
+            }
+
             if (vtd_as_has_map_notifier(vtd_as)) {
                 /*
-                 * As long as we have MAP notifications registered in
-                 * any of our IOMMU notifiers, we need to sync the
-                 * shadow page table.
+                 * In non-modern mode, as long as we have MAP notifications
+                 * registered in any of our IOMMU notifiers, we need to
+                 * sync the shadow page table. In scalable modern mode,
+                 * VFIO device attaches to nested page table instead of
+                 * shadow page table, so no need to sync.
                  */
-                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
+                if (!s->scalable_modern || !s->root_scalable) {
+                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
+                }
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -2960,7 +2983,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                 continue;
             }
 
-            if (!s->scalable_modern) {
+            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
                 vtd_address_space_sync(vtd_as);
             }
         }
@@ -2981,6 +3004,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
     vtd_iommu_unlock(s);
+
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
-- 
2.34.1


