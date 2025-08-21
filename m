Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA727CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5JE-0000zH-Bf; Thu, 21 Aug 2025 09:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3YV-00075L-Ux; Thu, 21 Aug 2025 07:34:07 -0400
Received: from forward102a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:d102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1up3YO-0008Ke-QO; Thu, 21 Aug 2025 07:34:06 -0400
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ba25:0:640:6c71:0])
 by forward102a.mail.yandex.net (Yandex) with ESMTPS id B3276C00B7;
 Thu, 21 Aug 2025 14:33:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id mXRF5KIMdSw0-drlzVLBJ; 
 Thu, 21 Aug 2025 14:33:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1755776031; bh=S5qocysp9rn6PF15wrmedXeRPPht07oTCPHs/xiDtnk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fnTxfGaAQM4fJ+PAvWsS1wK3dszZltTUMkLiwNhBVKYTUiR/BssEYDeBQjYqiw97b
 zL3mXLEPjaDTBq7ViEWBaMF968xiUMYYohbuPR36L14jsL33JUO2KK65LNBJUtLTGG
 xQnAZDwItk4HxA4JBo2ymLOzxNCOOVH4D61/F3N8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH 2/3] target/ppc: Add support for LE pages on PowerPC booke206
 mmu
Date: Thu, 21 Aug 2025 14:33:46 +0300
Message-ID: <20250821113348.91339-3-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:d102;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward102a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Aug 2025 09:26:25 -0400
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
 accel/tcg/cputlb.c      | 12 +++++-------
 target/ppc/cpu.h        |  4 ++++
 target/ppc/mmu-booke.c  |  5 +++++
 target/ppc/mmu_helper.c | 17 +++++++++++++++--
 target/ppc/translate.c  | 29 ++++++++++++++++++++++++++++-
 5 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 841b54e41d..396e510f1b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1401,7 +1401,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY
+                           | TLB_CHECK_ALIGNED | TLB_BSWAP))
         || (access_type != MMU_INST_FETCH && force_mmio)) {
         *phost = NULL;
         return TLB_MMIO;
@@ -1792,12 +1793,9 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
             mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
         }
 
-        /*
-         * Since target/sparc is the only user of TLB_BSWAP, and all
-         * Sparc accesses are aligned, any treatment across two pages
-         * would be arbitrary.  Refuse it until there's a use.
-         */
-        tcg_debug_assert((flags & TLB_BSWAP) == 0);
+        if (unlikely(flags & TLB_BSWAP)) {
+            l->memop ^= MO_BSWAP;
+        }
     }
 
     return crosspage;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811..127b05c865 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1186,6 +1186,10 @@ struct ppc_radix_page_info {
     uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
 };
 
+/*****************************************************************************/
+/* PowerPC usage of the PAGE_TARGET_1 bit for TLB little-endian bit */
+#define PAGE_LE  PAGE_TARGET_1
+
 /*****************************************************************************/
 /* Dynamic Execution Control Register */
 
diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
index 55e5dd7c6b..dc72bbf21f 100644
--- a/target/ppc/mmu-booke.c
+++ b/target/ppc/mmu-booke.c
@@ -357,6 +357,11 @@ found_tlb:
     }
 
     *prot = 0;
+
+    if (tlb->mas2 & MAS2_E) {
+        *prot |= PAGE_LE;
+    }
+
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
             *prot |= PAGE_READ;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac60705402..20282edaaa 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -27,6 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
+#include "exec/tlb-flags.h"
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
@@ -1368,8 +1369,20 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
 
     if (ppc_xlate(cpu, eaddr, access_type, &raddr,
                   &page_size, &prot, mmu_idx, !probe)) {
-        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
-                     prot, mmu_idx, 1UL << page_size);
+        if (prot & PAGE_LE) {
+            CPUTLBEntryFull full = {
+                .phys_addr = raddr & TARGET_PAGE_MASK,
+                .attrs = MEMTXATTRS_UNSPECIFIED,
+                .prot = prot,
+                .lg_page_size = ctz64(1UL << page_size),
+                .tlb_fill_flags = TLB_BSWAP
+            };
+            tlb_set_page_full(cs, mmu_idx, eaddr & TARGET_PAGE_MASK, &full);
+
+        } else {
+            tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
+                         prot, mmu_idx, 1UL << page_size);
+        }
         return true;
     }
     if (probe) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 27f90c3cc5..8cf50a0221 100644
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
@@ -219,6 +221,27 @@ static inline bool need_byteswap(const DisasContext *ctx)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool is_page_little_endian(CPUPPCState *env, vaddr addr)
+{
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
@@ -6577,7 +6600,11 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
     ctx->cia = pc = ctx->base.pc_next;
-    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+    bool tlb_is_le = is_page_little_endian(env, ctx->base.pc_next);
+
+
+    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx)
+                                                || tlb_is_le);
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
-- 
2.47.2


