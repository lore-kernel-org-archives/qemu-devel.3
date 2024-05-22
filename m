Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C1FC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQo-0004mR-Ft; Wed, 22 May 2024 02:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQh-0004iR-Fw
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:29 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQf-0006eK-P9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359186; x=1747895186;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=goZvInl61uVRC5qKvio5oLdRwdDHhcN/OMVw305hMug=;
 b=a9TJ5Qlkr/voEC+gePR92P4GbNgWXnpElFhRAkUqMiYrbXCac2eLIJuE
 aPaH0Q1fLdTeHJ9QBz34lurtcA36xzwV+idzNFdSMge/pJz4lyUHpJuSh
 YTkJdK7y5aB/RyxxxFGzM6Fossa5ajlUsvGKpP/Ka0XcgR+Zq9NmF9h0O
 UmLtLBHHHHuKhItWpfpw5isNJb7Fgc9dxm36Qr5eAj/8evWHiiEXv/8X2
 aNvXQvaKtPm33y/ftQUHh/eVQFT3AoCbuswKEP7xBZcuF8NtFHYOb1l6v
 x/7K/Z/KGk9F96V5BL3BKQqi3Q7Nm4+gfhpUsocSDOTyeyfdmT1NDUSob Q==;
X-CSE-ConnectionGUID: sHxjPf7QRcyliJKCu5I5Iw==
X-CSE-MsgGUID: A1z4N+euSeGh0k73ruxJNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972523"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972523"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:25 -0700
X-CSE-ConnectionGUID: xjgoX4U7T9ifzGtiKMVNwQ==
X-CSE-MsgGUID: JK3yOzy5SLy5PmdbPFcSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597772"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 07/17] intel_iommu: check if the input address is
 canonical
Date: Wed, 22 May 2024 14:23:03 +0800
Message-Id: <20240522062313.453317-8-zhenzhong.duan@intel.com>
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

First stage translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index abfdbd5f65..b6820dbca3 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -323,6 +323,8 @@ typedef enum VTDFaultReason {
     VTD_FR_PASID_ENTRY_P = 0x59,
     VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
+
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
     VTD_FR_MAX,                 /* Guard */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cf29809bc1..1ea030bfbe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1801,6 +1801,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_ENTRY_P] = true,
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1912,6 +1913,20 @@ static inline uint64_t vtd_get_flpte_addr(uint64_t flpte, uint8_t aw)
     return flpte & VTD_FL_PT_BASE_ADDR_MASK(aw);
 }
 
+/* Return true if IOVA is canonical, otherwise false. */
+static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
+                                        VTDContextEntry *ce, uint32_t pasid)
+{
+    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
+    uint64_t upper_bits_mask = ~(iova_limit - 1);
+    uint64_t upper_bits = iova & upper_bits_mask;
+    bool msb = ((iova & (iova_limit >> 1)) != 0);
+    return !(
+             (!msb && (upper_bits != 0)) ||
+             (msb && (upper_bits != upper_bits_mask))
+            );
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1927,6 +1942,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t flpte;
 
+    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
+        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
+                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
+        return -VTD_FR_FS_NON_CANONICAL;
+    }
+
     while (true) {
         offset = vtd_iova_fl_level_offset(iova, level);
         flpte = vtd_get_flpte(addr, offset);
-- 
2.34.1


