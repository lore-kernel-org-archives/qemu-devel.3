Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEB5EE020C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFs6-0002N4-1e; Wed, 11 Sep 2024 01:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFs3-0002Ls-TF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:27 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFs2-0004Mp-6k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032386; x=1757568386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yqWqyth2P/d3i3FGK/vIH9NaHNh3ZvisTnQJSetWMNY=;
 b=jVw6KgDodf34ytw+040CUWcHc2tZZo5GLL1amOMsJQY1j8jlGzBs80f2
 oGdZT6I29v8qMCLh/qYpMgFMMf7WeYlE3lXUeYpvTtfacTMKh6OBg8TvR
 8PyLOjmvKe+42UOybfNcI+9jQFTyFaMBJ/+slk5bpvEWrC67AqLtk1irf
 AQBeODB8mDclHyFzvIBbeHttRYQerHr8r6BG/M9A3DUFfZzAmSbasCJ+G
 yaXoJbEQ0aKRcn8NW14/3iB19AX4/xUOeoyuc8owPxXdIUPT7+QKOyuQk
 9zj7NVGsJzEafld1rwAgQ0NT8rVGld8jIzNj8Xnoe3b4YHbUwr9c50xvW Q==;
X-CSE-ConnectionGUID: Sc1jmhrKTtOMfJiGuLgSXA==
X-CSE-MsgGUID: 5s1de0RRTLKPOsunCEQ8Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403537"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403537"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:25 -0700
X-CSE-ConnectionGUID: oXRRSOrYT9qyWBD6rZl1iA==
X-CSE-MsgGUID: 0U8jvKd3Sb+Loa/IcKN2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536453"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:21 -0700
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
Subject: [PATCH v3 07/17] intel_iommu: Check if the input address is canonical
Date: Wed, 11 Sep 2024 13:22:45 +0800
Message-Id: <20240911052255.1294071-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

First stage translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 51e9b1fc43..668583aeca 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -320,6 +320,8 @@ typedef enum VTDFaultReason {
     VTD_FR_PASID_ENTRY_P = 0x59,
     VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
+
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
     VTD_FR_MAX,                 /* Guard */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6e31a8d383..be73366a64 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1821,6 +1821,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_ENTRY_P] = true,
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1924,6 +1925,22 @@ static inline bool vtd_flpte_present(uint64_t flpte)
     return !!(flpte & VTD_FL_P);
 }
 
+/* Return true if IOVA is canonical, otherwise false. */
+static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
+                                        VTDContextEntry *ce, uint32_t pasid)
+{
+    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
+    uint64_t upper_bits_mask = ~(iova_limit - 1);
+    uint64_t upper_bits = iova & upper_bits_mask;
+    bool msb = ((iova & (iova_limit >> 1)) != 0);
+
+    if (msb) {
+        return upper_bits == upper_bits_mask;
+    } else {
+        return !upper_bits;
+    }
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1939,6 +1956,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t flpte;
 
+    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
+        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
+                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
+        return -VTD_FR_FS_NON_CANONICAL;
+    }
+
     while (true) {
         offset = vtd_iova_level_offset(iova, level);
         flpte = vtd_get_pte(addr, offset);
-- 
2.34.1


