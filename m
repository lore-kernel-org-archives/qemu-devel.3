Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA4DD2E9C2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwv-0004xc-Fk; Mon, 11 Nov 2024 03:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwY-0004uj-Ts
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:42 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwX-0003UY-9i
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314321; x=1762850321;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RbiGaYj5YCAoPO0UeCvl+7AhZLlMKJrF1a/kTbZur5M=;
 b=Z0ZVvyHFvG4V6icDRRYznaKS/VWU1da5MWoH5K58YSOB/hYI5+Vj4Gyd
 B2ZvvYM21YzWOXCRMh2Ka0LFK75O5yaTpklV+XOZPtJL9r4EaVlNrDjJr
 4EMAuREzz3QF4qAsEXWRawrTWAQbmlfzVPI4sXxGEdMQ9OR8DD3hP7W6A
 hP4Df2/asdtNupgT+BJJWjOwy/1vSR0CWiaJY+f20uAORSAFc1rnV5SY1
 pny3mA1KGOOReoxGWbbNduoycWl/tj6qu3IrfCSIFx7yP6M6NgFzFfvxj
 EwE18CuUxU80DgoheDfjVbD1dikRxXlfyHg9NLzMl7t7+zcqk/3pcASQJ A==;
X-CSE-ConnectionGUID: aQ1QBgiPSxqfDeuvD2gguw==
X-CSE-MsgGUID: 5EH4Q/IpSR+WgmUjH6gZnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334432"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:40 -0800
X-CSE-ConnectionGUID: BgAOVj8mSd+gzI59FmQcOQ==
X-CSE-MsgGUID: bUmxvMMBQBmmhCUvAsj/BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608306"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:37 -0800
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
Subject: [PATCH v5 08/20] intel_iommu: Check stage-1 translation result with
 interrupt range
Date: Mon, 11 Nov 2024 16:34:45 +0800
Message-Id: <20241111083457.2090664-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Per VT-d spec 4.1 section 3.15, "Untranslated requests and translation
requests that result in an address in the interrupt range will be
blocked with condition code LGN.4 or SGN.8."

This applies to both stage-1 and stage-2 IOMMU page table, move the
check from vtd_iova_to_slpte() to vtd_do_iommu_translate() so stage-1
page table could also be checked.

By this chance, update the comment with correct section number.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 48 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4cc4d668fc..e651401db1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1138,7 +1138,6 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t slpte;
     uint64_t access_right_check;
-    uint64_t xlat, size;
 
     if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
         error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
@@ -1191,28 +1190,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
         level--;
     }
 
-    xlat = vtd_get_pte_addr(*slptep, aw_bits);
-    size = ~vtd_pt_level_page_mask(level) + 1;
-
-    /*
-     * From VT-d spec 3.14: Untranslated requests and translation
-     * requests that result in an address in the interrupt range will be
-     * blocked with condition code LGN.4 or SGN.8.
-     */
-    if ((xlat > VTD_INTERRUPT_ADDR_LAST ||
-         xlat + size - 1 < VTD_INTERRUPT_ADDR_FIRST)) {
-        return 0;
-    } else {
-        error_report_once("%s: xlat address is in interrupt range "
-                          "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
-                          "slpte=0x%" PRIx64 ", write=%d, "
-                          "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
-                          "pasid=0x%" PRIx32 ")",
-                          __func__, iova, level, slpte, is_write,
-                          xlat, size, pasid);
-        return s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
-                                  -VTD_FR_INTERRUPT_ADDR;
-    }
+    return 0;
 }
 
 typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
@@ -2064,6 +2042,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     uint8_t access_flags;
     bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
+    uint64_t xlat, size;
 
     /*
      * We have standalone memory region for interrupt addresses, we
@@ -2173,6 +2152,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
     }
+    if (!ret_fr) {
+        xlat = vtd_get_pte_addr(pte, s->aw_bits);
+        size = ~vtd_pt_level_page_mask(level) + 1;
+
+        /*
+         * Per VT-d spec 4.1 section 3.15: Untranslated requests and translation
+         * requests that result in an address in the interrupt range will be
+         * blocked with condition code LGN.4 or SGN.8.
+         */
+        if ((xlat <= VTD_INTERRUPT_ADDR_LAST &&
+             xlat + size - 1 >= VTD_INTERRUPT_ADDR_FIRST)) {
+            error_report_once("%s: xlat address is in interrupt range "
+                              "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
+                              "pte=0x%" PRIx64 ", write=%d, "
+                              "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
+                              "pasid=0x%" PRIx32 ")",
+                              __func__, addr, level, pte, is_write,
+                              xlat, size, pasid);
+            ret_fr = s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
+                                        -VTD_FR_INTERRUPT_ADDR;
+        }
+    }
+
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
-- 
2.34.1


