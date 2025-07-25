Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1259C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7Q3-00032D-0z; Thu, 24 Jul 2025 21:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uf7Ov-0001bg-PI
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:39:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uf7Ot-0002qw-E8
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:39:09 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxDGvq34JooJAxAQ--.34903S3;
 Fri, 25 Jul 2025 09:37:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxdOTk34Joz5wlAA--.62171S16;
 Fri, 25 Jul 2025 09:37:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 14/17] target/loongarch: Use mmu idx bitmap method when
 flush tlb
Date: Fri, 25 Jul 2025 09:37:36 +0800
Message-Id: <20250725013739.994437-15-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250725013739.994437-1-maobibo@loongson.cn>
References: <20250725013739.994437-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOTk34Joz5wlAA--.62171S16
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

With API tlb_flush_range_by_mmuidx(), bitmap method of mmu idx should
be used rather than itself. And mmu idx comes from page table entry
information rather current running mode.

Also field KM in TLB misc records bitmap mask of TLB entry which
is access in kernel mode. If set, MMU_KERNEL_IDX should be added
to flush tlb.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 61cc19610e..d18b382e56 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -110,12 +110,12 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     target_ulong addr, mask, pagesize;
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
-
-    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    int mmu_idx;
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
     uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+    uint16_t tlb_g, tlb_km;
 
     if (!tlb_e) {
         return;
@@ -125,13 +125,28 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
     mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
     addr = __vaddr((tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask);
+    tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+    tlb_km = FIELD_EX64(tlb->tlb_misc, TLB_MISC, KM);
+    if (tlb_g) {
+        mmu_idx = BIT(MMU_KERNEL_IDX);
+    } else {
+        mmu_idx = BIT(MMU_USER_IDX);
+    }
 
     if (tlb_v0) {
+        /* Even page is accessed in kernel mode */
+        if (tlb_km & 0x1) {
+            mmu_idx |= BIT(MMU_KERNEL_IDX);
+        }
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
 
     if (tlb_v1) {
+        /* Odd page is accessed in kernel mode */
+        if (tlb_km & 0x2) {
+            mmu_idx |= BIT(MMU_KERNEL_IDX);
+        }
         tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   mmu_idx, TARGET_LONG_BITS);
     }
-- 
2.39.3


