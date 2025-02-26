Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27D9C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDJW-00054L-3M; Wed, 26 Feb 2025 04:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tnDJG-00052z-Bf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:02:37 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tnDJB-0008S4-RJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:02:29 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxaeCU2L5n9UCDAA--.30058S3;
 Wed, 26 Feb 2025 17:02:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8eS2L5nAJYpAA--.24302S2;
 Wed, 26 Feb 2025 17:02:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v4] target/loongarch: fix 'make check-functional failed'
Date: Wed, 26 Feb 2025 16:40:45 +0800
Message-Id: <20250226084045.24156-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8eS2L5nAJYpAA--.24302S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

For LoongArch th min tlb_ps is 12(4KB), for TLB code,
the tlb_ps may be 0,this may case UndefinedBehavior
Add a check-tlb_ps fuction to check tlb_ps,
to make sure the tlb_ps is avalablie.we need
1. check the tlb_ps when first MMU model change to PG model;
   check the CSR_PWCL.PTBASE bits, and CSR_STLBPS.PS bits.
2. cpu reset
   set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
   from CSR_PRCFG2;
3. tlb instructions
   some tlb instructions get  the tlb_ps from tlb->misc but the
   value may has been initialized to 0. we need check  tlb->misc.PS
   bits value.
4. csrwr instructions.
   to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable when
   write these registers,
   check theses registers and set a default value from CSR_PRCFG2.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
V4:
1.Get the default tlb_ps value from env->CSR_PRCFG2. 
2.Sometlbinstrucions check the tlb_ps such as tlbfill/tlbwr/invtlb.
3.check_tlb_ps()just check CSR_PWCL.PTBASE bits and CSR_STLBPS.PS bits.
don't check all tlb->misc.
v3:
remove some tlb instruction chek MMU on PG model, because on DA model
also can use tlb instructions.
v2:
check-tlb_ps when write CSR_PWCL and CSR_STLBPS;
some tlb instructions check CRMD PG model when clear/read/write the tlb.
link to patch: https://patchew.org/QEMU/20250220012226.2182174-1-gaosong@loongson.cn/

 target/loongarch/cpu.c                        | 10 ++-
 target/loongarch/helper.h                     |  2 +
 target/loongarch/internals.h                  |  2 +
 target/loongarch/tcg/csr_helper.c             | 63 ++++++++++++++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +
 target/loongarch/tcg/tlb_helper.c             | 55 +++++++++++++++-
 6 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e91f4a5239..162a227d52 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -585,13 +585,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
      */
     env->CSR_PGDH = 0;
     env->CSR_PGDL = 0;
-    env->CSR_PWCL = 0;
     env->CSR_PWCH = 0;
-    env->CSR_STLBPS = 0;
     env->CSR_EENTRY = 0;
     env->CSR_TLBRENTRY = 0;
     env->CSR_MERRENTRY = 0;
-
+    /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
+    if (env->CSR_PRCFG2 == 0) {
+        env->CSR_PRCFG2 =0x3fffff000;
+    }
+    int tlb_ps = clz32(env->CSR_PRCFG2);
+    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+    env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
     for (n = 0; n < 4; n++) {
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV1, 0);
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 943517b5f2..2968b255bc 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -100,6 +100,8 @@ DEF_HELPER_1(rdtime_d, i64, env)
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
+DEF_HELPER_2(csrwr_crmd, i64, env, tl)
+DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 7b254c5f49..5d98581e7f 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -43,6 +43,8 @@ enum {
     TLBRET_PE = 7,
 };
 
+void check_tlb_ps(CPULoongArchState *env);
+
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 6c95be9910..e3a3751c18 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -17,6 +17,60 @@
 #include "hw/irq.h"
 #include "cpu-csr.h"
 
+
+void check_tlb_ps(CPULoongArchState *env)
+{
+    uint8_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
+
+    /* check  CSR_PWCL.PTBASE bits */
+    if (ptbase < default_ps) {
+         qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attrmpted set ptbase 2^%d\n", ptbase);
+         env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, default_ps);
+    }
+
+    /* check CSR_STLBPS.PS bits */
+    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+
+    if (tlb_ps < default_ps) {
+        env->CSR_STLBPS= FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, default_ps);
+    }
+}
+
+target_ulong helper_csrwr_crmd(CPULoongArchState *env, target_ulong val)
+{
+    uint8_t pg,old_pg;
+    int64_t old_v = env->CSR_CRMD;
+
+    pg = FIELD_EX64(val, CSR_CRMD, PG);
+    old_pg = FIELD_EX64(old_v, CSR_CRMD,PG);
+    if (pg&& !old_pg) {
+        check_tlb_ps(env);
+    }
+    env->CSR_CRMD = val;
+    return old_v;
+}
+
+target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v = env->CSR_STLBPS;
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
+
+    /*
+     * The real hardware only supports the min tlb_ps is 12
+     * tlb_ps=0 may cause undefined-behavior.
+     */
+    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    if (tlb_ps  < default_ps) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attempted set ps %d\n",tlb_ps);
+        val = FIELD_DP64(val, CSR_STLBPS, PS, default_ps);
+    }
+    env->CSR_STLBPS = val;
+    return old_v;
+}
+
 target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 {
     int64_t v;
@@ -99,19 +153,26 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
-    int shift;
+    int shift, ptbase;
     int64_t old_v = env->CSR_PWCL;
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
     /*
      * The real hardware only supports 64bit PTE width now, 128bit or others
      * treated as illegal.
      */
     shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
+    ptbase = FIELD_EX64(val, CSR_PWCL, PTBASE);
     if (shift) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attempted set pte width with %d bit\n", 64 << shift);
         val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
     }
+    if (ptbase < default_ps) {
+         qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attrmpted set ptbase 2^%d\n", ptbase);
+         val = FIELD_DP64(val, CSR_PWCL, PTBASE, default_ps);
+    }
 
     env->CSR_PWCL = val;
     return old_v;
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 3afa23af79..4b5656d6a6 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -74,6 +74,8 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
 
 void loongarch_csr_translate_init(void)
 {
+    SET_CSR_FUNC(CRMD, NULL, gen_helper_csrwr_crmd);
+    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr_stlbps);
     SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
     SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
     SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a323606e5a..7a1b7d7de8 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -118,6 +118,7 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
     int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
@@ -126,8 +127,16 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
 
     if (index >= LOONGARCH_STLB) {
         tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+	if (tlb_ps < default_ps) {
+            tlb_ps = default_ps;
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, tlb_ps);
+	}
     } else {
         tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+	if(tlb_ps < default_ps) {
+            tlb_ps = default_ps;
+	    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+	}
     }
     pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
     mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
@@ -166,9 +175,14 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
     uint64_t lo0, lo1, csr_vppn;
     uint16_t csr_asid;
     uint8_t csr_ps;
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        if (csr_ps < default_ps) {
+           csr_ps = default_ps;
+           env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, csr_ps);
+        }
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
         } else {
@@ -178,6 +192,10 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
         lo1 = env->CSR_TLBRELO1;
     } else {
         csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+        if (csr_ps < default_ps) {
+           csr_ps = default_ps;
+            env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS, csr_ps);
+        }
         if (is_la64(env)) {
             csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
         } else {
@@ -187,8 +205,10 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
         lo1 = env->CSR_TLBELO1;
     }
 
-    if (csr_ps == 0) {
-        qemu_log_mask(CPU_LOG_MMU, "page size is 0\n");
+    /*check */
+    if (csr_ps  < default_ps) {
+        qemu_log_mask(CPU_LOG_MMU, "page size < 12\n");
+        csr_ps = default_ps;
     }
 
     /* Only MTLB has the ps fields */
@@ -289,16 +309,29 @@ void helper_tlbfill(CPULoongArchState *env)
     uint64_t address, entryhi;
     int index, set, stlb_idx;
     uint16_t pagesize, stlb_ps;
+    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
         pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+        if (pagesize < default_ps){
+            pagesize = default_ps;
+            env->CSR_TLBREHI =FIELD_DP64(env->CSR_TLBREHI,CSR_TLBREHI,PS, pagesize);
+        }
     } else {
         entryhi = env->CSR_TLBEHI;
         pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+	if (pagesize < default_ps){
+            pagesize = default_ps;
+            env->CSR_TLBIDX =FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS,pagesize);
+	}
     }
 
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    if (stlb_ps < default_ps) {
+         stlb_ps = default_ps;
+         env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS,  CSR_STLBPS, PS ,stlb_ps);
+    }
 
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
@@ -427,11 +460,20 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+	uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+	    if(tlb_ps < default_ps) {
+	        tlb_ps = default_ps;
+                tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, tlb_ps);
+	    }
         } else {
             tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+	    if(tlb_ps < default_ps) {
+	       tlb_ps = default_ps;
+	       env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+	    }
         }
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
@@ -456,11 +498,20 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+	uint8_t default_ps = ctz32(env->CSR_PRCFG2);
 
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
+	    if (tlb_ps < default_ps) {
+	         tlb_ps = default_ps;
+	         tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, tlb_ps);
+	    }
         } else {
             tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+	    if(tlb_ps < default_ps) {
+	       tlb_ps =  default_ps;
+	       env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+	    }
         }
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
-- 
2.34.1


