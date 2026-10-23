Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FA606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Oo-00066R-E7; Thu, 22 Oct 2026 21:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xK4OK-0005x1-2E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xK4OG-0005pM-1I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:19 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxUNHcvNpqEZsYAA--.6244S3;
 Fri, 23 Oct 2026 09:48:12 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxGs7avNpqxl8vAA--.7626S5;
 Fri, 23 Oct 2026 09:48:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 07/10] target/loongarch: Preserve PTW dirty tracking on read
 fills
Date: Fri, 23 Oct 2026 09:49:27 +0800
Message-ID: <20261023014931.4055823-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023014931.4055823-1-maobibo@loongson.cn>
References: <20261023014931.4055823-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxGs7avNpqxl8vAA--.7626S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW7XF43CF1xWw1DAw43Arc_yoW8Kr4rpF
 Z7CF4S9a1ktrZxA3sIq3W0vFy5urs3Cay7Was3tryF9ws8Xrykur4kKrWYyFWUXF48Xw1Y
 qF1qyF15ZFn5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU=
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

with LoongArch hardware page table walking (PTW) enabled, a PTE
can be writable (W=1) but still clean (D=0). A load or instruction fetch
can install PAGE_WRITE in QEMU's software TLB based on W alone. A later
store then bypasses loongarch_cpu_tlb_fill() and PTW, dirty bit of PTE
will not be set with the later store operation.

Here remove PAGE_WRITE for clean PTEs on read/fetch fills at the common
software TLB fill point. The next store must re-enter PTW to set D before
using a writable cached translation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index b6381f7cd3..f5b4dc5c58 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -651,15 +651,6 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
@@ -683,6 +674,19 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
-- 
2.54.0


