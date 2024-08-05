Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFY-0003U0-2l; Mon, 05 Aug 2024 02:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFR-0003AF-O6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFO-0002DM-RJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839470; x=1754375470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HxQt+ElF7mrJns/ADRBCw0L2nr7XnpTAqOvZ+vtE2kc=;
 b=J5kys9jundmYx0Xj2D/DSaRoR222fZg/RHSHoLg65M6aGBJNyabT3GZM
 0eNyegVJusUlUW55I2WsK1z7N6elb3UALlQ7jVuJr9FluSYiQY9zPHU+5
 XrKifLVotZnl5R7bB/RsvIww/vuuXh7gmNx8kvY9reok2xWxLF1fdBsb0
 qRHXh1gQSMjVpCT3V+YQr6ckdLdMZTAEM1FAMY5xjaEvX+mgWr2wO219h
 a0GlTG9EpUdU9Sjyt+G3mKLWLNaleo+LY1nPhFoawMZ4hHlIOPWAmIkGl
 1jsWCeAcgySrBDrTnKghzG8Bi6Mo4s4ydhH6FwvsS1sfDOKoUdhyCkbmQ g==;
X-CSE-ConnectionGUID: fCNk2XqMQW2x7RH2zQLDJw==
X-CSE-MsgGUID: nizyGoaDTMCS4qldAHzNSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282843"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282843"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:08 -0700
X-CSE-ConnectionGUID: 0hEBrKbXShiaff6cLz561g==
X-CSE-MsgGUID: eymxisgBTLK8ERjwX12Cuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56787015"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify unmap
Date: Mon,  5 Aug 2024 14:27:23 +0800
Message-Id: <20240805062727.2307552-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fa00f85fd7..317e630e08 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2907,7 +2907,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                 continue;
             }
 
-            if (!s->scalable_modern) {
+            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
                 vtd_address_space_sync(vtd_as);
             }
         }
@@ -2919,6 +2919,9 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                                        bool ih)
 {
     VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -2929,6 +2932,36 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
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


