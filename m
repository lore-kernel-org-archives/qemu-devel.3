Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB096CD6E41
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS786-0006KV-MX; Wed, 27 May 2026 01:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77Z-0006FJ-PT
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77W-0000cT-KC
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860879; x=1811396879;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DQqWg73+HSAK0Zbz5Q/QglIq36UmfkAqE+rFSEm70lE=;
 b=iDlhL2sZs58NW0qYmfYoiKHLJv1p1Jc053f6nLu4ynlRiMACUGNy4O5P
 Uq7vPFuJuORfsCkXQ64kx7y4F8djSE7n8II9uA2sNXqR+khJ/hzEkhW+B
 zaUKNTPv7LL4eGjamiDf8UmMvKdeQ/ZT76xY7n9dyCeWoJjX1FGri3hs2
 8mNDgqk0/1mU+vc0cv+5G4GdyPzVKs+o0q3RT0aw4JDtWu8Qvp/0GbSoP
 KLgLjsczzAnOD7Az/e1QPoRseBXg3PChnsD2PRh97IlnDuCkG7g7jMrLk
 TNXwilhTxQnol1/fk93/siwHMNbPB66MuGgMIg7PvwIpQOYB7//FDTwCy A==;
X-CSE-ConnectionGUID: liQRDLQmSM2+eEJgCUNqwg==
X-CSE-MsgGUID: Ty5A9cNaQPqfRB06bSprwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988117"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988117"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:58 -0700
X-CSE-ConnectionGUID: uq+8dVbFSaGzRce71gBgdA==
X-CSE-MsgGUID: baPiNWXtRbypRiWBkps33Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086742"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 06/17] intel_iommu: make vtd_dev_get_pe_from_pasid() more
 generic
Date: Wed, 27 May 2026 01:46:44 -0400
Message-ID: <20260527054658.1021096-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor vtd_dev_get_pe_from_pasid() to take individual parameters
(IntelIOMMUState, PCIBus, devfn, pasid) instead of VTDAddressSpace.

This makes the function more reusable and prepares it for export to be
used in the acceleration path. Remove inline qualifier as the function
will be exported in a subsequent patch.

No functional changes intended.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cf275b496e..aa27187e02 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3113,10 +3113,10 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
-static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
-                                            VTDPASIDEntry *pe)
+static int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus,
+                                     uint8_t devfn, uint32_t pasid,
+                                     VTDPASIDEntry *pe)
 {
-    IntelIOMMUState *s = vtd_as->iommu_state;
     VTDContextEntry ce;
     int ret;
 
@@ -3124,13 +3124,12 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
         return -VTD_FR_RTADDR_INV_TTM;
     }
 
-    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
-                                   &ce);
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(bus), devfn, &ce);
     if (ret) {
         return ret;
     }
 
-    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
+    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
 }
 
 static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
@@ -3151,7 +3150,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     const char *err_prefix = "Attaching to HWPT failed: ";
     Error *local_err = NULL;
 
-    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+    if (vtd_dev_get_pe_from_pasid(vtd_as->iommu_state, vtd_as->bus,
+                                  vtd_as->devfn, vtd_as->pasid, &pe)) {
         if (!pc_entry->valid) {
             return;
         }
-- 
2.47.3


