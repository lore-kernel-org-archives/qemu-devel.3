Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C486ACF07B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syn32-00018x-BL; Thu, 10 Oct 2024 02:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1syn30-000183-Ch
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1syn2y-00040t-BZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:53:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxUejUeQdn8eIRAA--.25707S3;
 Thu, 10 Oct 2024 14:53:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXuTTeQdnBiAiAA--.41709S4;
 Thu, 10 Oct 2024 14:53:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH v2 2/5] target/loongarch: Add do_lddir/ldpte()
Date: Thu, 10 Oct 2024 14:35:33 +0800
Message-Id: <20241010063536.2276871-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241010063536.2276871-1-gaosong@loongson.cn>
References: <20241010063536.2276871-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTTeQdnBiAiAA--.41709S4
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

do_lddir is used for accessing directory entries during page table
walking, do_ldpte is used for page table entry accesses during page
table walking.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 53 ++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..3c3452b316 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -507,11 +507,11 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
-                          target_ulong level, uint32_t mem_idx)
+static target_ulong do_lddir(CPULoongArchState *env, target_ulong base,
+                             target_ulong badvaddr, target_ulong level)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong badvaddr, index, phys, ret;
+    target_ulong index, phys, ret;
     int shift;
     uint64_t dir_base, dir_width;
 
@@ -535,7 +535,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
         }
     }
 
-    badvaddr = env->CSR_TLBRBADV;
     base = base & TARGET_PHYS_MASK;
 
     /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
@@ -549,11 +548,18 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     return ret;
 }
 
-void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
-                  uint32_t mem_idx)
+target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
+                          target_ulong level, uint32_t mem_idx)
+{
+    return do_lddir(env, base, env->CSR_TLBRBADV, level);
+}
+
+static void do_ldpte(CPULoongArchState *env, target_ulong base,
+                     target_ulong badvaddr, target_ulong *ptval0,
+                     target_ulong *ptval1, target_ulong *ps)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
+    target_ulong  ptindex, ptoffset0, ptoffset1, phys0, phys1;
     int shift;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
@@ -584,34 +590,43 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
             base = FIELD_DP64(base, TLBENTRY, G, 1);
         }
 
-        ps = dir_base + dir_width - 1;
+        *ps = dir_base + dir_width - 1;
         /*
          * Huge pages are evenly split into parity pages
          * when loaded into the tlb,
          * so the tlb page size needs to be divided by 2.
          */
-        tmp0 = base;
-        if (odd) {
-            tmp0 += MAKE_64BIT_MASK(ps, 1);
-        }
+        *ptval0 = base;
+        *ptval1 = base + MAKE_64BIT_MASK(*ps, 1);
     } else {
         /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
         shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
         shift = (shift + 1) * 3;
-        badv = env->CSR_TLBRBADV;
 
-        ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
-        ptindex = ptindex & ~0x1;   /* clear bit 0 */
+        ptindex = (badvaddr >> ptbase) & ((1 << ptwidth) - 1);
+        ptindex = ptindex & ~0x1;  /* clear bit 0 */
         ptoffset0 = ptindex << shift;
         ptoffset1 = (ptindex + 1) << shift;
 
-        phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
-        ps = ptbase;
+        phys0 = base | ptoffset0;
+        phys1 = base | ptoffset1;
+        *ptval0 = ldq_phys(cs->as, phys0) & TARGET_PHYS_MASK;
+        *ptval1 = ldq_phys(cs->as, phys1) & TARGET_PHYS_MASK;
+        *ps = ptbase;
     }
 
+    return;
+}
+
+void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
+                  uint32_t mem_idx)
+{
+    target_ulong tmp0, tmp1, ps;
+
+    do_ldpte(env, base, env->CSR_TLBRBADV, &tmp0, &tmp1, &ps);
+
     if (odd) {
-        env->CSR_TLBRELO1 = tmp0;
+        env->CSR_TLBRELO1 = tmp1;
     } else {
         env->CSR_TLBRELO0 = tmp0;
     }
-- 
2.33.0


