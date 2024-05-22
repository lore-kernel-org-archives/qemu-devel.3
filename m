Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF8C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fRO-0005hh-Rp; Wed, 22 May 2024 02:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fR2-00052A-MP
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fR0-0006eK-S9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359207; x=1747895207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PywuVHJo6MudZYuNud+3f7D1VlMyEmDMUVp3O2ronZo=;
 b=Msb04GtLO4iVLkxaShzeq1h6Dnkn0sgdflApO2WoyjHK6KZsNeafkguJ
 tM+BOI8qJN1XpG4xIGXp4TiteqLT8G4wN/AM7E2BXduLpnhkPZ2y0m0LT
 edd1E9ZMjdK7te+MIP0OhvKB9mTI3JIoHbG9x2a65N4h4Hl2T94pj1LC3
 Yunba1JP1rvfUrxizNblMGZ1r/s7SroEwEshuesIu735Vtq6ZQABh1v7o
 B1rN350mc1RZm3cGLBJJZF83YSgKB64n+Q6Nr2OIilxTEdJwcwHdqHmmg
 OomN5K0Wa1h2Agf4HewkXuotL3UNtr+au76otXsa3iqZXtqXSUibDS4AZ g==;
X-CSE-ConnectionGUID: K8x6VxAeR0y/qDdFISIPUQ==
X-CSE-MsgGUID: CkGkJQpfRIioEdfd5OaiPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972598"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972598"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:45 -0700
X-CSE-ConnectionGUID: sK/wx7g0RHuybRbUvu6qhg==
X-CSE-MsgGUID: HK9q6lR9S4aiY1zhbTU+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597830"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 11/17] intel_iommu: Extract device IOTLB invalidation
 logic
Date: Wed, 22 May 2024 14:23:07 +0800
Message-Id: <20240522062313.453317-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This piece of code can be shared by both IOTLB invalidation and
PASID-based IOTLB invalidation

No functional changes intended.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 57 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f6c429ae4c..3c14fd85cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2955,13 +2955,43 @@ static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
     return true;
 }
 
+static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
+                                     bool size, hwaddr addr)
+{
+    /*
+     * According to ATS spec table 2.4:
+     * S = 0, bits 15:12 = xxxx     range size: 4K
+     * S = 1, bits 15:12 = xxx0     range size: 8K
+     * S = 1, bits 15:12 = xx01     range size: 16K
+     * S = 1, bits 15:12 = x011     range size: 32K
+     * S = 1, bits 15:12 = 0111     range size: 64K
+     * ...
+     */
+
+    IOMMUTLBEvent event;
+    uint64_t sz;
+
+    if (size) {
+        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
+        addr &= ~(sz - 1);
+    } else {
+        sz = VTD_PAGE_SIZE;
+    }
+
+    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
+    event.entry.target_as = &vtd_dev_as->as;
+    event.entry.addr_mask = sz - 1;
+    event.entry.iova = addr;
+    event.entry.perm = IOMMU_NONE;
+    event.entry.translated_addr = 0;
+    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
     VTDAddressSpace *vtd_dev_as;
-    IOMMUTLBEvent event;
     hwaddr addr;
-    uint64_t sz;
     uint16_t sid;
     bool size;
 
@@ -2986,28 +3016,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         goto done;
     }
 
-    /* According to ATS spec table 2.4:
-     * S = 0, bits 15:12 = xxxx     range size: 4K
-     * S = 1, bits 15:12 = xxx0     range size: 8K
-     * S = 1, bits 15:12 = xx01     range size: 16K
-     * S = 1, bits 15:12 = x011     range size: 32K
-     * S = 1, bits 15:12 = 0111     range size: 64K
-     * ...
-     */
-    if (size) {
-        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
-        addr &= ~(sz - 1);
-    } else {
-        sz = VTD_PAGE_SIZE;
-    }
-
-    event.type = IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
-    event.entry.target_as = &vtd_dev_as->as;
-    event.entry.addr_mask = sz - 1;
-    event.entry.iova = addr;
-    event.entry.perm = IOMMU_NONE;
-    event.entry.translated_addr = 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
+    do_invalidate_device_tlb(vtd_dev_as, size, addr);
 
 done:
     return true;
-- 
2.34.1


