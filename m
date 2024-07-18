Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D149C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMNI-0000gW-Pm; Thu, 18 Jul 2024 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNG-0000Yg-Dw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:26 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNE-00004t-KE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290825; x=1752826825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1REM4hDnglxLml0FWZ70ufSi/Q7DJqRcsAjSpIA4GCk=;
 b=hAF5b1gfc6mztqly5Pns267+oZIzgALvD7iCJvmvDMNIgYDQIiw2wCLw
 gcbeYLPKLLdSoknh8s7SolG6fQKJmjnxqqvNWRhX3VoLpDYUjIau8NYRT
 kouuyoxtExaDaLhDiMPAENdedk1D8IYgGbRT17Dh9enFdczBcJ6ylfmra
 ybC+TyRJv/HG0C1Amt2C3a1fcWRTUll+W52LP+LgSSf5Nub263I+dWhzO
 2/63nKRHUAKSXLS0Ysn/uvWPmPt2rmM0SdtYh+vT5Vk6e/lIksOGh2AfV
 7ZHoO3Kb8DO8HfLoQMHl/nUAmEX68SPBTu5RJ3XOLLCToGd61Odc3AP4T Q==;
X-CSE-ConnectionGUID: CLjzwT7WRK2QIG1ovN28RQ==
X-CSE-MsgGUID: 6w4P7GJhTZKHzwFU/iPz1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996395"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:23 -0700
X-CSE-ConnectionGUID: EN2qi5DNQGGRdSHjZJPW8w==
X-CSE-MsgGUID: ezsDpr69TTyLnlYMHVrA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717514"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:18 -0700
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
Subject: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify unmap
Date: Thu, 18 Jul 2024 16:16:33 +0800
Message-Id: <20240718081636.879544-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8b66d6cfa5..c0116497b1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2910,7 +2910,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                 continue;
             }
 
-            if (!s->scalable_modern) {
+            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
                 vtd_address_space_sync(vtd_as);
             }
         }
@@ -2922,6 +2922,9 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                                        bool ih)
 {
     VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -2932,6 +2935,36 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
     vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+            IOMMUTLBEvent event;
+
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+                vtd_as->pasid != pasid) {
+                continue;
+            }
+
+            /*
+             * Page-Selective-within-PASID PASID-based-IOTLB Invalidation
+             * does not flush stage-2 entries. See spec section 6.5.2.4
+             */
+            if (!s->scalable_modern) {
+                continue;
+            }
+
+            event.type = IOMMU_NOTIFIER_UNMAP;
+            event.entry.target_as = &address_space_memory;
+            event.entry.iova = addr;
+            event.entry.perm = IOMMU_NONE;
+            event.entry.addr_mask = size - 1;
+            event.entry.translated_addr = 0;
+            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
+        }
+    }
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
-- 
2.34.1


