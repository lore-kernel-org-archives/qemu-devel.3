Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04516C021AA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 01:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkvbm-0000HH-3E; Wed, 19 Feb 2025 20:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tkvbj-0000H6-Mf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 20:44:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tkvbe-0005dr-EQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 20:44:06 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxG6zViLZnfLh7AA--.50065S3;
 Thu, 20 Feb 2025 09:43:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMDx_MTTiLZnWlMdAA--.42363S2;
 Thu, 20 Feb 2025 09:43:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v2] target/loongarch: fix 'make check-functional failed'
Date: Thu, 20 Feb 2025 09:22:26 +0800
Message-Id: <20250220012226.2182174-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MTTiLZnWlMdAA--.42363S2
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
Add a check-tlb_ps fuction to check tlb_ps, when use
csrwr insn to write CSR_PWCL PTEBASE, check the PTBASE, and when
use csrwr insn to write STLBPS, check the tlb_ps value.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
v2:
check-tlb_ps when write CSR_PWCL and CSR_STLBPS;
some tlb instructions check CRMD PG model when clear/read/write the tlb.

 target/loongarch/helper.h                     |  2 +
 target/loongarch/internals.h                  |  2 +
 target/loongarch/tcg/csr_helper.c             | 62 ++++++++++++++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +
 target/loongarch/tcg/tlb_helper.c             | 58 +++++++++++++++++
 5 files changed, 125 insertions(+), 1 deletion(-)

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
index 6c95be9910..9f87beebb3 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -17,6 +17,60 @@
 #include "hw/irq.h"
 #include "cpu-csr.h"
 
+
+void check_tlb_ps(CPULoongArchState *env)
+{
+    for (int i=0; i < LOONGARCH_TLB_MAX; i++)
+    {
+        LoongArchTLB*tlb =&env->tlb[i];
+        uint8_t tlb_ps;
+        if(i >= LOONGARCH_STLB) {
+            tlb_ps = FIELD_EX64(tlb->tlb_misc,TLB_MISC,PS);
+            if (tlb_ps < 12) {
+                tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, 12);
+            }
+        } else {
+            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+            if (tlb_ps < 12) {
+               env->CSR_STLBPS= FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, 12);
+           }
+       }
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
+    uint8_t tlb_ps;
+    int64_t old_v = env->CSR_STLBPS;
+
+    /*
+     * The real hardware only supports the min tlb_ps is 12
+     * tlb_ps=0 may cause undefined-behavior.
+     */
+    tlb_ps = FIELD_EX64(val, CSR_STLBPS, PS);
+    if (tlb_ps  < 12) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attempted set ps %d\n",tlb_ps);
+        val = FIELD_DP64(val, CSR_STLBPS, PS, 12);
+    }
+    env->CSR_STLBPS = val;
+    return old_v;
+}
+
 target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 {
     int64_t v;
@@ -99,7 +153,7 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
 
 target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
 {
-    int shift;
+    int shift, ptbase;
     int64_t old_v = env->CSR_PWCL;
 
     /*
@@ -107,11 +161,17 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
      * treated as illegal.
      */
     shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
+    ptbase = FIELD_EX64(val, CSR_PWCL, PTBASE);
     if (shift) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attempted set pte width with %d bit\n", 64 << shift);
         val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
     }
+    if (ptbase < 12) {
+         qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attrmpted set ptbase 2^%d\n", ptbase);
+         val = FIELD_DP64(val, CSR_PWCL, PTBASE, 12);
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
index a323606e5a..ee9ec95f39 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -218,6 +218,12 @@ void helper_tlbsrch(CPULoongArchState *env)
 {
     int index, match;
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         match = loongarch_tlb_search(env, env->CSR_TLBREHI, &index);
     } else {
@@ -239,6 +245,12 @@ void helper_tlbrd(CPULoongArchState *env)
     int index;
     uint8_t tlb_ps, tlb_e;
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     tlb = &env->tlb[index];
 
@@ -273,6 +285,12 @@ void helper_tlbwr(CPULoongArchState *env)
 {
     int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     invalidate_tlb(env, index);
 
     if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
@@ -325,6 +343,11 @@ void helper_tlbclr(CPULoongArchState *env)
     LoongArchTLB *tlb;
     int i, index;
     uint16_t csr_asid, tlb_asid, tlb_g;
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
 
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
     index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
@@ -358,6 +381,12 @@ void helper_tlbflush(CPULoongArchState *env)
 {
     int i, index;
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
 
     if (index < LOONGARCH_STLB) {
@@ -380,6 +409,12 @@ void helper_tlbflush(CPULoongArchState *env)
 
 void helper_invtlb_all(CPULoongArchState *env)
 {
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
                                           TLB_MISC, E, 0);
@@ -389,6 +424,12 @@ void helper_invtlb_all(CPULoongArchState *env)
 
 void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
 {
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
@@ -404,6 +445,12 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
@@ -421,6 +468,12 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
 {
     uint16_t asid = info & 0x3ff;
 
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+       return;
+    }
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
@@ -449,6 +502,11 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     uint16_t asid = info & 0x3ff;
+    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+
+    if (!pg) {
+        return;
+    }
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
-- 
2.34.1


