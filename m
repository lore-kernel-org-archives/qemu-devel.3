Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BACECCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 19:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACHU-0006jr-AW; Sat, 18 Oct 2025 15:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACHB-0006Z7-0Z; Sat, 18 Oct 2025 15:07:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACH9-00017f-44; Sat, 18 Oct 2025 15:07:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41BF415F7A2;
 Sat, 18 Oct 2025 22:06:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 091122F060B;
 Sat, 18 Oct 2025 22:07:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 21/23] accel/tcg: Hoist first page lookup above
 pointer_wrap
Date: Sat, 18 Oct 2025 22:06:56 +0300
Message-ID: <20251018190702.1178893-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Richard Henderson <richard.henderson@linaro.org>

For strict alignment targets we registered cpu_pointer_wrap_notreached,
but generic code used it before recognizing the alignment exception.
Hoist the first page lookup, so that the alignment exception happens first.

Cc: qemu-stable@nongnu.org
Buglink: https://bugs.debian.org/1112285
Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit ec03dd9723781c7e9d4b4f70c7f54d12da9459d5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 87e14bde4f..b063a572e7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1744,6 +1744,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     bool crosspage;
+    vaddr last;
     int flags;
 
     l->memop = get_memop(oi);
@@ -1753,13 +1754,15 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     l->page[0].addr = addr;
     l->page[0].size = memop_size(l->memop);
-    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
+    l->page[1].addr = 0;
     l->page[1].size = 0;
-    crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
-    if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+    /* Lookup and recognize exceptions from the first page. */
+    mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
 
+    last = addr + l->page[0].size - 1;
+    crosspage = (addr ^ last) & TARGET_PAGE_MASK;
+    if (likely(!crosspage)) {
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
             mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
@@ -1769,18 +1772,18 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         }
     } else {
         /* Finish compute of page crossing. */
-        int size0 = l->page[1].addr - addr;
+        vaddr addr1 = last & TARGET_PAGE_MASK;
+        int size0 = addr1 - addr;
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
-
         l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
-                                                         l->page[1].addr, addr);
+                                                         addr1, addr);
 
         /*
-         * Lookup both pages, recognizing exceptions from either.  If the
-         * second lookup potentially resized, refresh first CPUTLBEntryFull.
+         * Lookup and recognize exceptions from the second page.
+         * If the lookup potentially resized the table, refresh the
+         * first CPUTLBEntryFull pointer.
          */
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
         if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
-- 
2.47.3


