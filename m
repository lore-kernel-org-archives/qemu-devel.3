Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E10CC6B09
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTAq-00028g-47; Mon, 12 Oct 2026 23:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xGTAi-00027Y-Ej
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:27:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xGTAe-0004mc-Hm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:27:24 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Axj9EUpc1qYDYVAA--.61848S3;
 Tue, 13 Oct 2026 11:27:16 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAx3c4Spc1qcK0rAA--.26881S5;
 Tue, 13 Oct 2026 11:27:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 SignKirigami <prcups@krgm.moe>
Subject: [PATCH 3/3] target/loongarch: Replace address_space_ldq_le ->
 cpu_ldq_le_mmuidx_ra in loongarch_ptw
Date: Tue, 13 Oct 2026 11:28:41 +0800
Message-ID: <20261013032841.2482079-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013032841.2482079-1-maobibo@loongson.cn>
References: <20261013032841.2482079-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c4Spc1qcK0rAA--.26881S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw45GF4rtr1UJFWfAr4xAFc_yoWrXr45pF
 Z3Cr93tr18tFs8uasFyw1Yvrn5Cw1kKw43WFWUK34vyr98Wrn2v3yjy34jvFyDXrWIqryj
 qF4UAF45uF13ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8U
 UUUU=
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

In function loongarch_ptw(), page table entry is accessed with physical
address, so it is similar with DA mode. Replace API address_space_ldq_le()
with cpu_ldq_le_mmuidx_ra(), and mmu_idx is MMU_DA_IDX rather than
current CPU running mode, since there is QEMU CPU TLB with the latter API.
And in future if LVZ is supported, the latter API will call the second MMU
page table walk.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c | 60 ++++++++---------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 8a4f8ebc4d..d1d66742d8 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -7,10 +7,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "system/memory.h"
 #include "system/tcg.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/getpc.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "internals.h"
@@ -111,55 +112,18 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
-static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
-                                          uint64_t old, uint64_t new)
-{
-    hwaddr addr1, l = 8;
-    MemoryRegion *mr;
-    uint8_t *ram_ptr;
-    uint64_t old1;
-    MemTxResult ret;
-
-    rcu_read_lock();
-    mr = address_space_translate(cs->as, phys, &addr1, &l,
-                                 false, MEMTXATTRS_UNSPECIFIED);
-    if (!memory_region_is_ram(mr)) {
-        /*
-         * Misconfigured PTE in ROM (AD bits are not preset) or
-         * PTE is in IO space and can't be updated atomically.
-         */
-         rcu_read_unlock();
-         return MEMTX_ACCESS_ERROR;
-    }
-
-    ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-    old1 = qatomic_cmpxchg((uint64_t *)ram_ptr, cpu_to_le64(old),
-                           cpu_to_le64(new));
-    old1 = le64_to_cpu(old1);
-    if (old1 == old) {
-        ret = MEMTX_OK;
-    } else {
-        ret = MEMTX_DECODE_ERROR;
-    }
-    rcu_read_unlock();
-
-    return ret;
-}
-
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
-    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    CPUState *cs = env_cpu(env);
     hwaddr index = 0, phys = 0;
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
-    uint64_t base, pte;
-    int level;
+    uint64_t base, pte, old;
+    int level, ptw_idx = MMU_DA_IDX;
     vaddr address;
     TLBRet ret;
-    MemTxResult ret1;
     CPUSysState *sys = env_sys(env);
+    MemOpIdx oi;
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -179,7 +143,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+        base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -213,8 +177,8 @@ restart:
 
         index &= 1;
         context->pte_buddy[index] = base;
-        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
-                                   attrs, NULL);
+        val = cpu_ldq_le_mmuidx_ra(env, phys + 8 * (1 - 2 * index),
+                                   ptw_idx, GETPC());
         context->pte_buddy[1 - index] = val;
     }
 
@@ -244,10 +208,12 @@ restart:
         if (access_type == MMU_DATA_STORE) {
             base = pte_mkdirty(base);
         }
-        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
+
+        oi = make_memop_idx(MO_LEUQ | MO_64, ptw_idx);
+        old = cpu_atomic_cmpxchgq_le_mmu(env, phys, pte, base, oi, GETPC());
         /* PTE updated by other CPU, reload PTE entry */
-        if (ret1 == MEMTX_DECODE_ERROR) {
-            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
+        if (le64_to_cpu(old) != pte) {
+            base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
             goto restart;
         }
 
-- 
2.54.0


