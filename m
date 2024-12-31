Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C19FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 10:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSZAB-0005xk-C5; Tue, 31 Dec 2024 05:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tSZ9x-0005wK-QD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 05:07:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tSZ9v-0003rZ-2Y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 05:07:33 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_65XwnNnZl1cAA--.11726S3;
 Tue, 31 Dec 2024 18:07:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxYMZWwnNnaT8PAA--.9012S2;
 Tue, 31 Dec 2024 18:07:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, Miao Hao <haomiao23s@ict.ac.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/loongarch: Only support 64bit pte width
Date: Tue, 31 Dec 2024 18:07:18 +0800
Message-Id: <20241231100718.2314306-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMZWwnNnaT8PAA--.9012S2
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

With manual pte width can be 64bit, 128bit or more. Instead real
hardware only supports 64bit pte width. For 12bit pte, there is
no detail definition for all 128bit from manual.

Here only 64bit pte width is supported for simplicity, will add
this in later if real hw support it and there is definition for
all the bits from manual.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/helper.h                     |  1 +
 target/loongarch/tcg/csr_helper.c             | 21 +++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/loongarch/tcg/tlb_helper.c             | 17 +++------------
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b3b64a0215..943517b5f2 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -104,6 +104,7 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
+DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefa..5d43b4f2cb 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internals.h"
@@ -95,3 +96,23 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
     }
     return old_v;
 }
+
+target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
+{
+    int shift;
+    int64_t old_v = env->CSR_PWCL;
+
+    /*
+     * The real ardware only supports 64bit PTE width now, 128bit or others
+     * treated as illegal.
+     */
+    shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
+    if (shift) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Attempted set pte width with %d bit\n", 64 << shift);
+        val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
+    }
+
+    env->CSR_PWCL = val;
+    return old_v;
+}
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7e4ec93edb..30f9b83fb2 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -95,7 +95,7 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(PGDL),
     CSR_OFF(PGDH),
     CSR_OFF_FUNCS(PGD, CSRFL_READONLY, gen_helper_csrrd_pgd, NULL),
-    CSR_OFF(PWCL),
+    CSR_OFF_FUNCS(PWCL, 0, NULL, gen_helper_csrwr_pwcl),
     CSR_OFF(PWCH),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..8c61fe728c 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -512,7 +512,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 {
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys, ret;
-    int shift;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -537,14 +536,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
-
-    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-    shift = (shift + 1) * 3;
-
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
-    phys = base | index << shift;
+    phys = base | index << 3;
     ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
     return ret;
 }
@@ -554,7 +548,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
-    int shift;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
@@ -595,16 +588,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
     } else {
-        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
-        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
-        shift = (shift + 1) * 3;
         badv = env->CSR_TLBRBADV;
 
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
-        ptoffset0 = ptindex << shift;
-        ptoffset1 = (ptindex + 1) << shift;
-
+        ptoffset0 = ptindex << 3;
+        ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
         tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
         ps = ptbase;

base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
-- 
2.39.3


