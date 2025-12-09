Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF05D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyAA-0000Qa-Sg; Tue, 09 Dec 2025 08:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9X-00007j-Fa
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9U-0002cT-KV
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=YDrHHlS00KR9cgLAc08zrXeue6HMnDH9zKMdv1cxuvs=; b=n+HisMm4jjE1pPf
 Sxa+lFOzKxjUuWAz/+6Ek3bamL9Tiq5GWvM5BKPb4CLMXel/M/RdELRCfXGF+1imN0JFcIEXD+TYP
 m/yprmEFRftKjHxjaGHq3h3rnU+JSA0NREfoXgEDLgUJuDHV+F0vghzHnSWXqgl+H+3qe1ge6oCJL
 w4=;
Date: Tue, 09 Dec 2025 14:56:05 +0100
Subject: [PATCH 4/7] target/loongarch: Introduce loongarch_palen_mask()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-phys_addr-v1-4-c387f3e72d77@rev.ng>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
In-Reply-To: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, define a
runtime function to construct a mask from the PALEN cpucfg field.
The mask is then used when converting from virtual to physical
addresses.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/internals.h      |  1 -
 target/loongarch/cpu_helper.c     | 14 +++++++++++---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++----
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2259de9d36..3286accc14 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -98,5 +98,6 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 8793bd9df6..e01dbed40f 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -13,7 +13,6 @@
 #define FCMP_UN   0b0100  /* unordered */
 #define FCMP_GT   0b1000  /* fp0 > fp1 */
 
-#define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
 #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
 
 void loongarch_translate_init(void);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index a6eba4f416..6497b454a6 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -147,6 +147,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
 {
     CPUState *cs = env_cpu(env);
     target_ulong index = 0, phys = 0;
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint64_t base, pte;
     int level;
@@ -154,13 +155,14 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     TLBRet ret;
     MemTxResult ret1;
 
+
     address = context->addr;
     if ((address >> 63) & 0x1) {
         base = env->CSR_PGDH;
     } else {
         base = env->CSR_PGDL;
     }
-    base &= TARGET_PHYS_MASK;
+    base &= palen_mask;
 
     for (level = 4; level >= 0; level--) {
         get_dir_base_width(env, &dir_base, &dir_width, level);
@@ -181,7 +183,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                 break;
             } else {
                 /* Discard high bits with page directory table */
-                base &= TARGET_PHYS_MASK;
+                base &= palen_mask;
             }
         }
     }
@@ -315,7 +317,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     /* Check PG and DA */
     address = context->addr;
     if (da & !pg) {
-        context->physical = address & TARGET_PHYS_MASK;
+        context->physical = address & loongarch_palen_mask(env);
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         context->mmu_index = MMU_DA_IDX;
         return TLBRET_MATCH;
@@ -364,3 +366,9 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return context.physical;
 }
+
+uint64_t loongarch_palen_mask(CPULoongArchState *env)
+{
+    uint64_t phys_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN);
+    return MAKE_64BIT_MASK(0, phys_bits);
+}
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 01e0a27f0b..30107f3e3f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -691,8 +691,10 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 {
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys;
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
 
+
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attepted LDDIR with level %u\n", level);
@@ -714,11 +716,11 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     }
 
     badvaddr = env->CSR_TLBRBADV;
-    base = base & TARGET_PHYS_MASK;
+    base = base & palen_mask;
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    return ldq_phys(cs->as, phys) & palen_mask;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -728,9 +730,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint8_t  ps;
 
+
     /*
      * The parameter "base" has only two types,
      * one is the page table base address,
@@ -738,7 +742,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
      * and the other is the huge page entry,
      * whose bit 6 should be 1.
      */
-    base = base & TARGET_PHYS_MASK;
+    base = base & palen_mask;
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /*
          * Gets the huge page level and Gets huge page size.
@@ -779,7 +783,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        tmp0 = ldq_phys(cs->as, phys) & palen_mask;
         ps = ptbase;
     }
 

-- 
2.51.0


