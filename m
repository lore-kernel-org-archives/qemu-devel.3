Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77831CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RRI-00010b-5R; Mon, 29 Sep 2025 23:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RRF-00010Q-PS
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:54:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RR9-0001rc-Tk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:54:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXNJBVNto12sQAA--.34770S3;
 Tue, 30 Sep 2025 11:53:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S12;
 Tue, 30 Sep 2025 11:53:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 10/13] target/loongarch: Add field tlb_index to record TLB
 search info
Date: Tue, 30 Sep 2025 11:53:29 +0800
Message-Id: <20250930035332.2609520-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S12
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

With hardware PTW function, TLB entry will be searched at first.
If there is odd/even page on one TLB entry, and odd page is valid and
even page is none. When software access memory with address in even
page, hardware PTW will happen and fill new entry in the same TLB entry.

Here add field tlb_index to record TLB index when search TLB tables.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        | 2 ++
 target/loongarch/cpu_helper.c     | 3 +++
 target/loongarch/tcg/tlb_helper.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 865800fc0a..c3e869234a 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -25,6 +25,8 @@ typedef struct MMUContext {
     hwaddr        physical;
     int           ps;  /* page size shift */
     int           prot;
+    int           tlb_index;
+    int           mmu_index;
     uint64_t      pte_buddy[2];
 } MMUContext;
 
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 09fb1e46d4..e2d66f4c86 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -97,6 +97,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
     context->prot = PAGE_READ;
+    context->mmu_index = tlb_plv;
     if (tlb_d) {
         context->prot |= PAGE_WRITE;
     }
@@ -216,6 +217,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     if (da & !pg) {
         context->physical = address & TARGET_PHYS_MASK;
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        context->mmu_index = MMU_DA_IDX;
         return TLBRET_MATCH;
     }
 
@@ -235,6 +237,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
             context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
             context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+            context->mmu_index = MMU_DA_IDX;
             return TLBRET_MATCH;
         }
     }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 465d2885e1..e5ed46bfd6 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -743,6 +743,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     n = (context->addr >> tlb_ps) & 0x1;/* Odd or even */
     context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
     context->ps = tlb_ps;
+    context->tlb_index = index;
     return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
-- 
2.39.3


