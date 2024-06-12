Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD4C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHKwo-0005Ow-Er; Wed, 12 Jun 2024 06:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHKwm-0005Ol-Qe
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:11:16 -0400
Received: from 59-120-53-16.hinet-ip.hinet.net ([59.120.53.16]
 helo=mail.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHKwk-0001nJ-K0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:11:16 -0400
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Jun
 2024 18:11:08 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <peterx@redhat.com>, <david@redhat.com>, <philmd@linaro.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [RFC PATCH] system/physmem: Support IOMMU granularity smaller than
 TARGET_PAGE size
Date: Wed, 12 Jun 2024 18:10:59 +0800
Message-ID: <20240612101059.3647556-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
Received-SPF: pass client-ip=59.120.53.16; envelope-from=ethan84@andestech.com;
 helo=mail.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If the IOMMU granularity is smaller than TARGET_PAGE size, there may have
multiple entries in the same page. Pass the origin address to IOMMU to get
correct result

Similar to the RISCV PMP solution, TLB_INVALID_MASK will be set when there have
multiple entries in the same page to check the IOMMU on every access.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 accel/tcg/cputlb.c | 17 ++++++++++++++++-
 system/physmem.c   |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..9c0db4d9e2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1062,8 +1062,23 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     prot = full->prot;
     asidx = cpu_asidx_from_attrs(cpu, full->attrs);
-    section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
+    section = address_space_translate_for_iotlb(cpu, asidx, full->phys_addr,
                                                 &xlat, &sz, full->attrs, &prot);
+    /* Update page size */
+    full->lg_page_size = ctz64(sz);
+    if (full->lg_page_size > TARGET_PAGE_BITS) {
+        full->lg_page_size = TARGET_PAGE_BITS;
+    } else {
+        sz = TARGET_PAGE_SIZE;
+    }
+
+    is_ram = memory_region_is_ram(section->mr);
+    is_romd = memory_region_is_romd(section->mr);
+    /* If the translated mr is ram/rom, make xlat align the TARGET_PAGE */
+    if (is_ram || is_romd) {
+        xlat &= TARGET_PAGE_MASK;
+    }
+
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
diff --git a/system/physmem.c b/system/physmem.c
index b7847db1a2..0fd0326714 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -702,6 +702,10 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
         iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
+        /* Update size */
+        if (iotlb.addr_mask != -1 && *plen > iotlb.addr_mask + 1) {
+            *plen = iotlb.addr_mask + 1;
+        }
         /* Update the caller's prot bits to remove permissions the IOMMU
          * is giving us a failure response for. If we get down to no
          * permissions left at all we can give up now.
-- 
2.34.1


