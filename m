Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50F0C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7x9-0002rJ-3X; Fri, 11 Jul 2025 03:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ua7we-0002a6-5b
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ua7wa-00044N-CS
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:19 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxbKyFuXBo9QUnAQ--.17449S3;
 Fri, 11 Jul 2025 15:13:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+R_uXBoo28SAA--.39054S6;
 Fri, 11 Jul 2025 15:13:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL v2 4/4] target/loongarch: Remove unnecessary page size validity
 checking
Date: Fri, 11 Jul 2025 15:13:02 +0800
Message-Id: <20250711071302.742014-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711071302.742014-1-maobibo@loongson.cn>
References: <20250711071302.742014-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+R_uXBoo28SAA--.39054S6
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

Page size of TLB entry comes from CSR STLBPS and pwcl register. With
huge page, it is dir_base + dir_width from pwcl register. With normal
page, it is field of PTBASE from pwcl register.

So it is ok to check validity in function helper_ldpte() and function
helper_csrwr_stlbps(). And it is unnecessary in tlb entry fill path.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index dc48b0f4d2..8872593ff0 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -173,12 +173,6 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
         lo1 = env->CSR_TLBELO1;
     }
 
-    /*check csr_ps */
-    if (!check_ps(env, csr_ps)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "csr_ps %d is illegal\n", csr_ps);
-        return;
-    }
-
     /* Only MTLB has the ps fields */
     if (index >= LOONGARCH_STLB) {
         tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
@@ -340,23 +334,16 @@ void helper_tlbfill(CPULoongArchState *env)
 
     if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
         entryhi = env->CSR_TLBREHI;
+        /* Validity of pagesize is checked in helper_ldpte() */
         pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
     } else {
         entryhi = env->CSR_TLBEHI;
+        /* Validity of pagesize is checked in helper_tlbrd() */
         pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
     }
 
-    if (!check_ps(env, pagesize)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "pagesize %d is illegal\n", pagesize);
-        return;
-    }
-
+    /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
-    if (!check_ps(env, stlb_ps)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "stlb_ps %d is illegal\n", stlb_ps);
-        return;
-    }
-
     if (pagesize == stlb_ps) {
         /* Only write into STLB bits [47:13] */
         address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
@@ -611,10 +598,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
+    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
+    uint8_t  ps;
 
     /*
      * The parameter "base" has only two types,
@@ -651,6 +639,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
+
+        if (!check_ps(env, ps)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %d\n", ps);
+            return;
+        }
     } else {
         badv = env->CSR_TLBRBADV;
 
-- 
2.43.5


