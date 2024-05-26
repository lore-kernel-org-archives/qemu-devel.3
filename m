Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7123CC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4l-0004PV-SW; Sun, 26 May 2024 19:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4j-0004Ln-Ba; Sun, 26 May 2024 19:14:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4h-0003iP-Cf; Sun, 26 May 2024 19:14:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D73454E6543;
 Mon, 27 May 2024 01:13:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id uHS7dTEC5Kfy; Mon, 27 May 2024 01:13:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DECF14E6503; Mon, 27 May 2024 01:13:10 +0200 (CEST)
Message-Id: <db36621d9dd2a7d354ffac78e28e332cd0d70735.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 34/43] target/ppc/internal.h: Consolidate ifndef
 CONFIG_USER_ONLY blocks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:10 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A few pte related definitions are between two ifndef CONFIG_USER_ONLY
blocks but these are not needed for user only and should also be
within these blocks. Consolidate the ifndef blocks so all user only and
not user only definitions are in one #ifdef #else at the end of the file.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 8e5a241f74..66ce22bbe9 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -224,6 +224,10 @@ void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
 
+FIELD(GER_MSK, XMSK, 0, 4)
+FIELD(GER_MSK, YMSK, 4, 4)
+FIELD(GER_MSK, PMSK, 8, 8)
+
 /* translate.c */
 
 int ppc_fixup_cpu(PowerPCCPU *cpu);
@@ -234,8 +238,11 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
 void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
 const gchar *ppc_gdb_arch_name(CPUState *cs);
 
-#ifndef CONFIG_USER_ONLY
-
+#ifdef CONFIG_USER_ONLY
+void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
+                            MMUAccessType access_type,
+                            bool maperr, uintptr_t ra);
+#else
 /* Check if permission bit required for the access_type is set in prot */
 static inline int check_prot_access_type(int prot, MMUAccessType access_type)
 {
@@ -252,7 +259,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
 
-#endif /* !CONFIG_USER_ONLY */
 
 /* Common routines used by software and hardware TLBs emulation */
 static inline int pte_is_valid(target_ulong pte0)
@@ -268,11 +274,6 @@ static inline void pte_invalidate(target_ulong *pte0)
 #define PTE_PTEM_MASK 0x7FFFFFBF
 #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
 
-#ifdef CONFIG_USER_ONLY
-void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
-                            MMUAccessType access_type,
-                            bool maperr, uintptr_t ra);
-#else
 bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
@@ -287,10 +288,6 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 void ppc_cpu_debug_excp_handler(CPUState *cs);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
-#endif
-
-FIELD(GER_MSK, XMSK, 0, 4)
-FIELD(GER_MSK, YMSK, 4, 4)
-FIELD(GER_MSK, PMSK, 8, 8)
+#endif /* !CONFIG_USER_ONLY */
 
 #endif /* PPC_INTERNAL_H */
-- 
2.30.9


