Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77435CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3Z-0001gy-9K; Sat, 30 Aug 2025 10:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpH3-0008PS-Hb
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpGs-00079W-Ov
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:33 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxRNCXFrFosm4EAA--.8612S3;
 Fri, 29 Aug 2025 10:55:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S10;
 Fri, 29 Aug 2025 10:55:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/14] target/loongarch: Add common function
 loongarch_check_pte()
Date: Fri, 29 Aug 2025 10:55:01 +0800
Message-Id: <20250829025507.2315073-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S10
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Common function loongarch_check_pte() is to check tlb entry, return
the physical address and access priviledge if found. Also it can be
used with page table entry, which is used in page table walker.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu-mmu.h        | 10 +++++
 target/loongarch/cpu_helper.c     | 61 ++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 66 ++++++-------------------------
 3 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index dffc12820f..be3d11d3c1 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -19,7 +19,17 @@ typedef enum TLBRet {
     TLBRET_PE,
 } TLBRet;
 
+typedef struct MMUContext {
+    vaddr         addr;
+    uint64_t      pte;
+    hwaddr        physical;
+    int           ps;  /* page size shift */
+    int           prot;
+} MMUContext;
+
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
+TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
+                           MMUAccessType access_type, int mmu_idx);
 TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
                             int *prot, vaddr address,
                             MMUAccessType access_type, int mmu_idx,
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 0c037ef163..739cdab5aa 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -44,6 +44,67 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
     }
 }
 
+TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
+                           MMUAccessType access_type, int mmu_idx)
+{
+    uint64_t plv = mmu_idx;
+    uint64_t tlb_entry, tlb_ppn;
+    uint8_t tlb_ps, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+
+    tlb_entry = context->pte;
+    tlb_ps = context->ps;
+    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
+    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
+    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
+    if (is_la64(env)) {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
+        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
+        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
+        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
+    } else {
+        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
+        tlb_nx = 0;
+        tlb_nr = 0;
+        tlb_rplv = 0;
+    }
+
+    /* Remove sw bit between bit12 -- bit PS*/
+    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) - 1));
+
+    /* Check access rights */
+    if (!tlb_v) {
+        return TLBRET_INVALID;
+    }
+
+    if (access_type == MMU_INST_FETCH && tlb_nx) {
+        return TLBRET_XI;
+    }
+
+    if (access_type == MMU_DATA_LOAD && tlb_nr) {
+        return TLBRET_RI;
+    }
+
+    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
+        ((tlb_rplv == 1) && (plv != tlb_plv))) {
+        return TLBRET_PE;
+    }
+
+    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
+        return TLBRET_DIRTY;
+    }
+
+    context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
+                        (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
+    context->prot = PAGE_READ;
+    if (tlb_d) {
+        context->prot |= PAGE_WRITE;
+    }
+    if (!tlb_nx) {
+        context->prot |= PAGE_EXEC;
+    }
+    return TLBRET_MATCH;
+}
+
 static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
                                           hwaddr *physical,
                                           int *prot, vaddr address)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 915b1aadb5..10322da62e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -654,64 +654,22 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
                                       int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
-    uint64_t plv = mmu_idx;
-    uint64_t tlb_entry, tlb_ppn;
-    uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+    uint8_t tlb_ps, n;
+    MMUContext context;
+    TLBRet ret;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     n = (address >> tlb_ps) & 0x1;/* Odd or even */
+    context.pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
+    context.addr = address;
+    context.ps = tlb_ps;
+    ret = loongarch_check_pte(env, &context, access_type, mmu_idx);
+    if (ret == TLBRET_MATCH) {
+        *physical = context.physical;
+        *prot = context.prot;
+     }
 
-    tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
-    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
-    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
-    tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
-    if (is_la64(env)) {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
-        tlb_nx = FIELD_EX64(tlb_entry, TLBENTRY_64, NX);
-        tlb_nr = FIELD_EX64(tlb_entry, TLBENTRY_64, NR);
-        tlb_rplv = FIELD_EX64(tlb_entry, TLBENTRY_64, RPLV);
-    } else {
-        tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_32, PPN);
-        tlb_nx = 0;
-        tlb_nr = 0;
-        tlb_rplv = 0;
-    }
-
-    /* Remove sw bit between bit12 -- bit PS*/
-    tlb_ppn = tlb_ppn & ~(((0x1UL << (tlb_ps - 12)) - 1));
-
-    /* Check access rights */
-    if (!tlb_v) {
-        return TLBRET_INVALID;
-    }
-
-    if (access_type == MMU_INST_FETCH && tlb_nx) {
-        return TLBRET_XI;
-    }
-
-    if (access_type == MMU_DATA_LOAD && tlb_nr) {
-        return TLBRET_RI;
-    }
-
-    if (((tlb_rplv == 0) && (plv > tlb_plv)) ||
-        ((tlb_rplv == 1) && (plv != tlb_plv))) {
-        return TLBRET_PE;
-    }
-
-    if ((access_type == MMU_DATA_STORE) && !tlb_d) {
-        return TLBRET_DIRTY;
-    }
-
-    *physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
-                (address & MAKE_64BIT_MASK(0, tlb_ps));
-    *prot = PAGE_READ;
-    if (tlb_d) {
-        *prot |= PAGE_WRITE;
-    }
-    if (!tlb_nx) {
-        *prot |= PAGE_EXEC;
-    }
-    return TLBRET_MATCH;
+    return ret;
 }
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-- 
2.43.5


