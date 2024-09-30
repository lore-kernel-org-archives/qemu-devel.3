Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A22BCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCjy-0003Cv-4Y; Mon, 30 Sep 2024 05:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjo-0002Vq-22
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:41 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjl-000759-Ou
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688637; x=1759224637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uv3EwOp49dN1Ts3DhCpB+ZiI5HBtex65yynW/uWCjZA=;
 b=mtLOf0MoKDkYUAYOOgkexCeY6IQidzzy428vLnYedhjliIWTTVfzpiTY
 HzrvuxZV5nAIWKRcKkMPEIYr9bEwN89uoLQN9wjVZ86RAFdK6HXCS32/B
 eW0XbzOAoP9d8J+AG4dH2z+CN/nr4FfDLlIMlAoswqV44WAIpJXYrmRUV
 8BeTTUTkKqsk0Qg5I/AgGbRwfRIEg4ZcIyzMABgwBbuR/XgqcwHbFkNZH
 6r4gczO9/EY3VKl+c9Yn01+MDp/x+CCKmUk5zGq6FmxJSlmtbxYjY0EJO
 y+OdeEspc748MO7UiwOu0EdjGEmu8kFq6Vf3EQAPnQrwvZ+PpUzJYpQAO A==;
X-CSE-ConnectionGUID: bH1oLGQSRmG60D/j6IE+cA==
X-CSE-MsgGUID: yBm0cCqmQJiVAmEoIT1nTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721854"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:36 -0700
X-CSE-ConnectionGUID: lfJb0AUvSuWKT8qGunn6mA==
X-CSE-MsgGUID: 65058/OASRqQMrCtWhMVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749872"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:32 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify unmap
Date: Mon, 30 Sep 2024 17:26:27 +0800
Message-Id: <20240930092631.2997543-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is used by some emulated devices which caches address
translation result. When piotlb invalidation issued in guest,
those caches should be refreshed.

For device that does not implement ATS capability or disable
it but still caches the translation result, it is better to
implement ATS cap or enable it if there is need to cache the
translation result.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5ea59167b3..91d7b1abfa 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2908,7 +2908,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                 continue;
             }
 
-            if (!s->scalable_modern) {
+            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
                 vtd_address_space_sync(vtd_as);
             }
         }
@@ -2920,6 +2920,9 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                                        bool ih)
 {
     VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -2930,6 +2933,36 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
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


