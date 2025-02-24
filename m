Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B0EC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVG4-0003tD-SO; Mon, 24 Feb 2025 05:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tmVFy-0003rM-Mb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:00:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tmVFr-0003JO-Ht
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 05:00:10 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxrOIZQ7xnVbCAAA--.50548S3;
 Mon, 24 Feb 2025 17:59:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx7MQXQ7xnZxomAA--.9069S2;
 Mon, 24 Feb 2025 17:59:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
Subject: [PATCH v3] target/loongarch: fix 'make check-functional failed'
Date: Mon, 24 Feb 2025 17:38:27 +0800
Message-Id: <20250224093828.3337991-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx7MQXQ7xnZxomAA--.9069S2
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
v3:
remove some tlb instruction chek MMU on PG model, because on DA model
also can use tlb instructions.
v2:
check-tlb_ps when write CSR_PWCL and CSR_STLBPS;
some tlb instructions check CRMD PG model when clear/read/write the tlb.

 target/loongarch/helper.h                     |  2 +
 target/loongarch/internals.h                  |  2 +
 target/loongarch/tcg/csr_helper.c             | 62 ++++++++++++++++++-
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +
 4 files changed, 67 insertions(+), 1 deletion(-)

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
-- 
2.34.1


