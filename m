Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C8C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwfe-0003Fw-H1; Fri, 28 Feb 2025 04:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tnwfb-0003Aa-BQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:28:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tnwfY-0001Uw-H4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:28:35 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxG6y8gcFnz9OFAA--.399S3;
 Fri, 28 Feb 2025 17:28:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxLse5gcFnnJYtAA--.40662S4;
 Fri, 28 Feb 2025 17:28:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v5 2/2] target/loongarch: check tlb_ps
Date: Fri, 28 Feb 2025 17:06:59 +0800
Message-Id: <20250228090659.2434568-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250228090659.2434568-1-gaosong@loongson.cn>
References: <20250228090659.2434568-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLse5gcFnnJYtAA--.40662S4
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
to make sure the tlb_ps is avalablie. we check tlb_ps
when get the tlb_ps from tlb->misc or CSR bits.
1. cpu reset
   set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
   from CSR_PRCFG2;
2. tlb instructions.
   some tlb instructions get  the tlb_ps from tlb->misc but the
   value may  has been initialized to 0. we need just check the tlb_ps
   skip the function and write a guest log.
3. csrwr instructions.
   to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable,
   cheke theses bits and set a default value from CSR_PRCFG2.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c                        | 10 ++--
 target/loongarch/cpu_helper.c                 |  8 +++-
 target/loongarch/helper.h                     |  1 +
 target/loongarch/internals.h                  |  2 +
 target/loongarch/tcg/csr_helper.c             | 30 +++++++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
 target/loongarch/tcg/tlb_helper.c             | 46 ++++++++++++++++++-
 7 files changed, 90 insertions(+), 8 deletions(-)

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
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 930466ca48..a81a610a1d 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -117,7 +117,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
                 *index = i * 256 + stlb_idx;
                 return true;
             }
-        }
+        } else {
+	    continue;
+	}
     }
 
     /* Search MTLB */
@@ -136,7 +138,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
                 *index = i;
                 return true;
             }
-        }
+        } else {
+	    continue;
+	}
     }
     return false;
 }
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 943517b5f2..1d5cb0198c 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -100,6 +100,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
 DEF_HELPER_1(csrrd_pgd, i64, env)
 DEF_HELPER_1(csrrd_cpuid, i64, env)
 DEF_HELPER_1(csrrd_tval, i64, env)
+DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
 DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 7b254c5f49..1cd959a766 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -43,6 +43,8 @@ enum {
     TLBRET_PE = 7,
 };
 
+bool check_ps(CPULoongArchState *ent, int ps);
+
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 6c95be9910..1c8a234b16 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -17,6 +17,27 @@
 #include "hw/irq.h"
 #include "cpu-csr.h"
 
+
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
+    if (!check_ps(env, tlb_ps)) {
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
@@ -99,19 +120,26 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 
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
+    if (!check_ps(env, ptbase)) {
+         qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attrmpted set ptbase 2^%d\n", ptbase);
+         val = FIELD_DP64(val, CSR_PWCL, PTBASE, default_ps);
+    }
 
     env->CSR_PWCL = val;
     return old_v;
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 3afa23af79..ecbfe23b63 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -74,6 +74,7 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
 
 void loongarch_csr_translate_init(void)
 {
+    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr_stlbps);
     SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
     SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
     SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 1c603b2903..27f0653a5a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -18,6 +18,14 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
+bool check_ps(CPULoongArchState *env, int tlb_ps)
+{
+     if(tlb_ps > 64){
+         return false;
+     }
+     return BIT_ULL(tlb_ps) && (env->CSR_PRCFG2);
+}
+
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level)
 {
@@ -123,12 +131,21 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
     uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+    uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+
+    if (!tlb_e){
+        return;
+    }
 
     if (index >= LOONGARCH_STLB) {
         tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     } else {
         tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
     }
+    if (!check_ps(env,tlb_ps)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
+        return;
+    }
     pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
     mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
 
@@ -187,8 +204,10 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
         lo1 = env->CSR_TLBELO1;
     }
 
-    if (csr_ps == 0) {
-        qemu_log_mask(CPU_LOG_MMU, "page size is 0\n");
+    /*check csr_ps */
+    if (!check_ps(env, csr_ps)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "csr_ps %d is illegal\n", csr_ps);
+        return;
     }
 
     /* Only MTLB has the ps fields */
@@ -249,6 +268,10 @@ void helper_tlbrd(CPULoongArchState *env)
     }
     tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+    if (!check_ps(env, tlb_ps)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
+        return;
+    }
     if (!tlb_e) {
         /* Invalid TLB entry */
         env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
@@ -298,7 +321,16 @@ void helper_tlbfill(CPULoongArchState *env)
         pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
+    if (!check_ps(env, pagesize)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "pagesize %d is illegal\n", pagesize);
+        return;
+    }
+
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    if (!check_ps(env, stlb_ps)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "stlb_ps %d is illegal\n", stlb_ps);
+        return;
+    }
 
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
@@ -437,6 +469,10 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         } else {
             tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
         }
+        if (!check_ps(env, tlb_ps)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
+            return;
+        }
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
         compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
@@ -470,6 +506,12 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         } else {
             tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
         }
+        if (!check_ps(env, tlb_ps)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
+            return;
+        }
+
+
         tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
         vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
         compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
-- 
2.34.1


