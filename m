Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E1DC282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNeP-0007Tw-3k; Thu, 06 Mar 2025 21:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tqNeM-0007T4-VO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tqNeJ-0006iv-Sr
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:22 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxrnLKXMpnVQaNAA--.44577S3;
 Fri, 07 Mar 2025 10:41:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxLsfAXMpnQro6AA--.23941S4;
 Fri, 07 Mar 2025 10:41:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 2/2] target/loongarch: check tlb_ps
Date: Fri,  7 Mar 2025 10:19:34 +0800
Message-Id: <20250307021934.1080115-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250307021934.1080115-1-gaosong@loongson.cn>
References: <20250307021934.1080115-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfAXMpnQro6AA--.23941S4
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250305063311.830674-3-gaosong@loongson.cn>
---
 target/loongarch/cpu.c                        | 11 +++++---
 target/loongarch/helper.h                     |  1 +
 target/loongarch/internals.h                  |  2 ++
 target/loongarch/tcg/csr_helper.c             | 26 ++++++++++++++++---
 .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
 target/loongarch/tcg/tlb_helper.c             | 23 ++++++++++++++--
 6 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ac514a15fb..0486853048 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -544,6 +544,7 @@ static void loongarch_max_initfn(Object *obj)
 
 static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 {
+    uint8_t tlb_ps;
     CPUState *cs = CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
@@ -592,13 +593,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
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
+        env->CSR_PRCFG2 = 0x3fffff000;
+    }
+    tlb_ps = ctz32(env->CSR_PRCFG2);
+    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+    env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
     for (n = 0; n < 4; n++) {
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
         env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV1, 0);
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
index 6c95be9910..289d89266e 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -17,6 +17,22 @@
 #include "hw/irq.h"
 #include "cpu-csr.h"
 
+target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
+{
+    int64_t old_v = env->CSR_STLBPS;
+
+    /*
+     * The real hardware only supports the min tlb_ps is 12
+     * tlb_ps=0 may cause undefined-behavior.
+     */
+    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    if (!check_ps(env, tlb_ps)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attempted set ps %d\n", tlb_ps);
+    }
+    return old_v;
+}
+
 target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 {
     int64_t v;
@@ -99,7 +115,7 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
-    int shift;
+    int shift, ptbase;
     int64_t old_v = env->CSR_PWCL;
 
     /*
@@ -107,12 +123,16 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
      * treated as illegal.
      */
     shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
+    ptbase = FIELD_EX64(val, CSR_PWCL, PTBASE);
     if (shift) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attempted set pte width with %d bit\n", 64 << shift);
         val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
     }
-
-    env->CSR_PWCL = val;
+    if (!check_ps(env, ptbase)) {
+         qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attrmpted set ptbase 2^%d\n", ptbase);
+    }
+    env->CSR_PWCL =val;
     return old_v;
 }
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
index 27c729b5b5..5a426691bc 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -18,6 +18,14 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 
+bool check_ps(CPULoongArchState *env, int tlb_ps)
+{
+     if (tlb_ps > 64) {
+         return false;
+     }
+     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
+}
+
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                                uint64_t *dir_width, target_ulong level)
 {
@@ -191,8 +199,10 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
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
@@ -302,7 +312,16 @@ void helper_tlbfill(CPULoongArchState *env)
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
-- 
2.34.1


