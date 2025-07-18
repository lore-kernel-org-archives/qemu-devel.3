Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D002C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 07:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfjj-0003SJ-7d; Fri, 18 Jul 2025 03:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW4-0002db-6c
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfVz-0002jp-2o
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:23 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxrnKO93lo0cksAQ--.27523S3;
 Fri, 18 Jul 2025 15:28:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S11;
 Fri, 18 Jul 2025 15:28:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] target/loongarch: Use fine-grained tlb flush method
Date: Fri, 18 Jul 2025 15:28:07 +0800
Message-Id: <20250718072807.3585466-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250718072807.3585466-1-maobibo@loongson.cn>
References: <20250718072807.3585466-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S11
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

Qemu TCG provides some tlb flushing API, tlb can be flushed with
specified mmu idx and virtual address. Here fine-grained tlb flush
method is used.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 47eb3ee318..0842b067b1 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -385,7 +385,8 @@ void helper_tlbclr(CPULoongArchState *env)
         }
     }
 
-    tlb_flush(env_cpu(env));
+    /* Flush all user tlb entries */
+    tlb_flush_by_mmuidx(env_cpu(env), BIT(MMU_USER_IDX));
 }
 
 void helper_tlbflush(CPULoongArchState *env)
@@ -447,7 +448,9 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
-    tlb_flush(env_cpu(env));
+
+    /* Flush all user tlb entries */
+    tlb_flush_by_mmuidx(env_cpu(env), BIT(MMU_USER_IDX));
 }
 
 void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
@@ -475,15 +478,19 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         if (!tlb_g && (tlb_asid == asid) &&
            (vpn == (tlb_vppn >> compare_shift))) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
+            tlb_flush_range_by_mmuidx(env_cpu(env), vpn << (tlb_ps + 1),
+                                      BIT_ULL(tlb_ps + 1),
+                                      BIT(MMU_USER_IDX), TARGET_LONG_BITS);
+            break;
         }
     }
-    tlb_flush(env_cpu(env));
 }
 
 void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     uint16_t asid = info & 0x3ff;
+    int mmu_idx;
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -505,9 +512,13 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         if ((tlb_g || (tlb_asid == asid)) &&
             (vpn == (tlb_vppn >> compare_shift))) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
+            mmu_idx = BIT(FIELD_EX64(tlb->tlb_entry0, TLBENTRY, PLV));
+            tlb_flush_range_by_mmuidx(env_cpu(env), vpn << (tlb_ps + 1),
+                                      BIT_ULL(tlb_ps + 1),
+                                      mmu_idx, TARGET_LONG_BITS);
+            break;
         }
     }
-    tlb_flush(env_cpu(env));
 }
 
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.39.3


