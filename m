Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD8DC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T0T-0004CO-V3; Fri, 18 Sep 2026 03:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x7T0H-0004B0-JB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:27:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x7T0F-0006Hq-2p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:27:25 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx69HP56xqvFYNAA--.38818S3;
 Fri, 18 Sep 2026 15:27:12 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBxpMzP56xqXyIiAA--.46206S2;
 Fri, 18 Sep 2026 15:27:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Preserve PTW dirty tracking on read fills
Date: Fri, 18 Sep 2026 15:28:33 +0800
Message-ID: <20260918072833.265906-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMzP56xqXyIiAA--.46206S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW7XF43CF1xXF4fAry7Arc_yoW8Kr4kpF
 Z7CF4Sva1ktrZ3A3sIq3W0vF15urs7Cay7Was3tryS9ws8Xrykur4vk34YyFW8XF48Xw1j
 qF1qyF15ZFn5X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

with LoongArch hardware page table walking (PTW) enabled, a PTE
can be writable (W=1) but still clean (D=0). A load or instruction fetch
can install PAGE_WRITE in QEMU's software TLB based on W alone. A later
store then bypasses loongarch_cpu_tlb_fill() and PTW, dirty bit of PTE
will not be set with the later store operation.

Here remove PAGE_WRITE for clean PTEs on read/fetch fills at the common
software TLB fill point. The next store must re-enter PTW to set D before
using a writable cached translation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 40cc076424..dae04854ad 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -652,15 +652,6 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             need_update = false;
         } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
             need_update = false;
-
-            /*
-             * FIXME: should context.prot be set without PAGE_WRITE with
-             * pte_write(context.pte) && !pte_dirty(context.pte)??
-             *
-             * Otherwise there will be no loongarch_cpu_tlb_fill() function call
-             * for MMU_DATA_STORE access_type in future since QEMU TLB with
-             * prot PAGE_WRITE is added already
-             */
         }
 
         if (need_update) {
@@ -684,6 +675,19 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (ret == TLBRET_MATCH) {
         physical = context.physical;
         prot = context.prot;
+
+        /*
+         * Loads or instruction fetches must not cache write access to a
+         * clean PTE. The first store must enter PTW to set D, whether this
+         * translation came from the LoongArch TLB or a page table walk.
+         * Store walks have already handled D, but context.pte may still
+         * contain its old value. Direct mappings have no PTE to check.
+         */
+        if (cpu_has_ptw(env) && context.mmu_index != MMU_DA_IDX &&
+            access_type != MMU_DATA_STORE && !pte_dirty(context.pte)) {
+            prot &= ~PAGE_WRITE;
+        }
+
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot,
                      mmu_idx, TARGET_PAGE_SIZE);

base-commit: c66824ffb01931be0ddfe49a1642a78570abf44b
-- 
2.54.0


