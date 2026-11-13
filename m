Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227E606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvg-0002z1-12; Fri, 13 Nov 2026 03:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvb-0002wd-3j
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:35 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvZ-0007TK-EE
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:34 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 69C7F82B;
 Fri, 13 Nov 2026 14:16:31 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 15/26] target/loongarch: add 2-level address mapping to
 loongarch_cpu_tlb_fill()
Date: Fri, 13 Nov 2026 16:45:30 +0800
Message-ID: <14b28f2cbc2437f5fab44d9e476bfda533ec8185.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use a while loop to map GVA to HPA.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/tlb_helper.c | 49 +++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 0c93d0fcb4..82b4ef4333 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -695,7 +695,42 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     /* Data access */
     context.addr = address;
     context.tlb_index = -1;
-    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
+    context.prot = PAGE_RWX;
+    int curr_mmu_idx = mmu_idx;
+
+    while (1) {
+        prot = context.prot;
+        ret = get_physical_address(env, &context, access_type, curr_mmu_idx, 0,
+                                   retaddr);
+        if (ret != TLBRET_MATCH) {
+            address = context.addr;
+            ret += TLBRET_HOST_MATCH *
+            (mmu_idx_vm_level(mmu_idx) - mmu_idx_vm_level(curr_mmu_idx));
+            break;
+        } else {
+            /*
+            * Loads or instruction fetches must not cache write access to a
+            * clean PTE. The first store must enter PTW to set D, whether this
+            * translation came from the LoongArch TLB or a page table walk.
+            * Store walks have already handled D, but context.pte may still
+            * contain its old value. Direct mappings have no PTE to check.
+            */
+            if (cpu_has_ptw(env, mmu_idx_vm_level(curr_mmu_idx)) &&
+                context.mmu_index != MMU_DA_IDX &&
+                access_type != MMU_DATA_STORE && !pte_dirty(context.pte)) {
+                prot &= ~PAGE_WRITE;
+            }
+        }
+        context.addr = context.physical;
+        context.tlb_index = -1;
+        context.prot &= prot;
+        if (mmu_idx_vm_level(curr_mmu_idx)) {
+            curr_mmu_idx = (mmu_idx_vm_level(curr_mmu_idx) - 1) * MMU_KERNEL_IDX;
+        } else {
+            break;
+        }
+    }
+
     if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
         && cpu_has_ptw(env, env_vm_level(env))) {
         bool need_update = true;
@@ -728,18 +763,6 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         physical = context.physical;
         prot = context.prot;
 
-        /*
-         * Loads or instruction fetches must not cache write access to a
-         * clean PTE. The first store must enter PTW to set D, whether this
-         * translation came from the LoongArch TLB or a page table walk.
-         * Store walks have already handled D, but context.pte may still
-         * contain its old value. Direct mappings have no PTE to check.
-         */
-        if (cpu_has_ptw(env, env_vm_level(env)) && context.mmu_index != MMU_DA_IDX &&
-            access_type != MMU_DATA_STORE && !pte_dirty(context.pte)) {
-            prot &= ~PAGE_WRITE;
-        }
-
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);
-- 
2.56.0


