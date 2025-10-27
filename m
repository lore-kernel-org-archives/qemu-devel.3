Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29718CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMNW-0007ob-3k; Mon, 27 Oct 2025 08:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNS-0007mU-MZ; Mon, 27 Oct 2025 08:31:10 -0400
Received: from forward101d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNM-0005GW-EP; Mon, 27 Oct 2025 08:31:10 -0400
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2dcb:0:640:715b:0])
 by forward101d.mail.yandex.net (Yandex) with ESMTPS id 43283C0031;
 Mon, 27 Oct 2025 15:30:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id nUbd1g4LwiE0-MzQKrJ87; 
 Mon, 27 Oct 2025 15:30:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1761568253; bh=Qnyvcck3T2kdtVf9S8+oX8aQrBkc+Ncdlv8/tAVGnBU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QG1SuR8C1J5kI56GngqCi+Cg1kf9JJU+t9oxIcWUiEzjhoeeDeih4yudIwjG0tbVU
 CsQUAWQ9pCE0qRU2cMvEFGUe6JqPuCjaTjHfCph3m0bJAAk6+28TaWSTERZL03APJV
 9j5zcMNjjGfCzdJnYlhYuo5o91RFC+QPNo7VLRTg=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Chinmay Rath <rathc@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH v4 3/4] target/ppc: Add support for LE pages on PowerPC
 booke206 mmu
Date: Mon, 27 Oct 2025 15:30:47 +0300
Message-ID: <20251027123049.32038-4-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
References: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d101;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward101d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for passing TLB_BSWAP flag from powerpc booke206 MMU
Fix instruction fetches from LE pages being treated as MMIO
This change should not affect SPARC, as its instruction fetches are always BE

Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
---
 accel/tcg/cputlb.c     | 26 +++++++++++++++-----------
 target/ppc/mmu-booke.c |  4 ++++
 target/ppc/translate.c | 42 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 81f002cf25..843c56b3c7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1399,7 +1399,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY
+                           | TLB_CHECK_ALIGNED | TLB_BSWAP))
         || (access_type != MMU_INST_FETCH && force_mmio)) {
         *phost = NULL;
         return TLB_MMIO;
@@ -1793,12 +1794,19 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
             mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
         }
 
-        /*
-         * Since target/sparc is the only user of TLB_BSWAP, and all
-         * Sparc accesses are aligned, any treatment across two pages
-         * would be arbitrary.  Refuse it until there's a use.
-         */
-        tcg_debug_assert((flags & TLB_BSWAP) == 0);
+        if (unlikely(flags & TLB_BSWAP)) {
+            /*
+             * TLB_BSWAP is relevant to SPARC and powerPC e500.
+             * SPARC never ends up here, as all its accesses are aligned
+             * cross-page accesses do work for e500, but crossing boundary
+             * between different endian pages should generate an exception
+             * Adding this would require another callback for a cpu for
+             * *just* this case, and such accesses are not correct anyway,
+             * so it just fails.
+             */
+            assert(!(TLB_BSWAP & (l->page[0].flags ^ l->page[1].flags)));
+            l->memop ^= MO_BSWAP;
+        }
     }
 
     return crosspage;
@@ -1896,10 +1904,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     if (unlikely(tlb_addr & TLB_BSWAP)) {
-        assert(!( (  full->slow_flags[MMU_DATA_STORE]
-            ^ full->slow_flags[MMU_DATA_LOAD ])
-            & TLB_BSWAP));
-
         mop ^= MO_BSWAP;
     }
 
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 10ba8052d4..172e9604e0 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -362,6 +362,10 @@ found_tlb:
     uint8_t *prot = &(full->prot);
     *prot = 0;
 
+    if (tlb->mas2 & MAS2_E) {
+        full->tlb_fill_flags |= TLB_BSWAP;
+    }
+
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
             *prot |= PAGE_READ;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c..ccb1224b3a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -24,7 +24,9 @@
 #include "exec/target_page.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "accel/tcg/probe.h"
 #include "qemu/host-utils.h"
+#include "exec/tlb-flags.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -171,7 +173,7 @@ struct DisasContext {
     target_ulong cia;  /* current instruction address */
     uint32_t opcode;
     /* Routine used to access memory */
-    bool pr, hv, dr, le_mode;
+    bool pr, hv, dr, le_mode, insn_le_mode;
     bool lazy_tlb_flush;
     bool need_access_type;
     int mem_idx;
@@ -214,16 +216,42 @@ static inline bool is_ppe(const DisasContext *ctx)
     return !!(ctx->flags & POWERPC_FLAG_PPE42);
 }
 
-/* Return true iff byteswap is needed in a scalar memop */
+/* Return true iff byteswap is needed in instruction fetch */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
 #if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
+     return ctx->insn_le_mode;
 #else
-     return !ctx->le_mode;
+     return !ctx->insn_le_mode;
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool is_page_little_endian(CPUPPCState *env, vaddr addr)
+{
+    /* booke206 is the only MMU supporting LE pages for now */
+    if (env->mmu_model != POWERPC_MMU_BOOKE206) {
+        return false;
+    }
+
+    CPUTLBEntryFull *full;
+    void *host;
+    int mmu_idx = ppc_env_mmu_index(env, true);
+    int flags;
+
+    flags = probe_access_full_mmu(env, addr, 0, MMU_INST_FETCH, mmu_idx,
+                                  &host, &full);
+    assert(!(flags & TLB_INVALID_MASK));
+
+    return full->tlb_fill_flags & TLB_BSWAP;
+}
+#else
+static bool is_page_little_endian(CPUPPCState *env, vaddr addr)
+{
+    return false;
+}
+#endif
+
 /* True when active word size < size of target_long.  */
 #ifdef TARGET_PPC64
 # define NARROW_MODE(C)  (!(C)->sf_mode)
@@ -6521,6 +6549,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUPPCState *env = cpu_env(cs);
+
     uint32_t hflags = ctx->base.tb->flags;
 
     ctx->spr_cb = env->spr_cb;
@@ -6532,7 +6561,9 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->insns_flags2 = env->insns_flags2;
     ctx->access_type = -1;
     ctx->need_access_type = !mmu_is_64bit(env->mmu_model);
-    ctx->le_mode = (hflags >> HFLAGS_LE) & 1;
+    ctx->le_mode = ((hflags >> HFLAGS_LE) & 1);
+    ctx->insn_le_mode = ctx->le_mode ^
+                        is_page_little_endian(env, ctx->base.pc_next);
     ctx->default_tcg_memop_mask = ctx->le_mode ? MO_LE : MO_BE;
     ctx->flags = env->flags;
 #if defined(TARGET_PPC64)
@@ -6597,6 +6628,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
     ctx->cia = pc = ctx->base.pc_next;
+
     insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
     ctx->base.pc_next = pc += 4;
 
-- 
2.47.3


