Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71771C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5x-0000JC-UK; Sun, 26 May 2024 19:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5g-0006zp-DR; Sun, 26 May 2024 19:15:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5a-00045v-8M; Sun, 26 May 2024 19:15:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1417C4E6550;
 Mon, 27 May 2024 01:13:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id zbROn7g7TIro; Mon, 27 May 2024 01:13:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2482E4E6551; Mon, 27 May 2024 01:13:17 +0200 (CEST)
Message-Id: <4cdbb66fc918f00f51e6fb6266e1b0714496b266.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 40/43] target/ppc: Change parameter type of ppc64_v3_radix()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:17 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This function takes PowerPCCPU but only needs the env from it. Change
its parameter to CPUPPCState *env.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/spapr_rtas.c        | 2 +-
 target/ppc/mmu-book3s-v3.h | 4 ++--
 target/ppc/mmu_common.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index f329693c55..38e94fc0d7 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -177,7 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
          * New cpus are expected to start in the same radix/hash mode
          * as the existing CPUs
          */
-        if (ppc64_v3_radix(callcpu)) {
+        if (ppc64_v3_radix(&callcpu->env)) {
             lpcr |= LPCR_UPRT | LPCR_GTSE | LPCR_HR;
         } else {
             lpcr &= ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index be66e26604..e52129ff7f 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -75,9 +75,9 @@ bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid,
  * dig out the partition table in the fast path. This is
  * also how the HW uses it.
  */
-static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
+static inline bool ppc64_v3_radix(CPUPPCState *env)
 {
-    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
+    return !!(env->spr[SPR_LPCR] & LPCR_HR);
 }
 
 #endif /* TARGET_PPC64 */
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b45eb64f6e..ab055ca96b 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -565,7 +565,7 @@ void dump_mmu(CPUPPCState *env)
         dump_slb(env_archcpu(env));
         break;
     case POWERPC_MMU_3_00:
-        if (ppc64_v3_radix(env_archcpu(env))) {
+        if (ppc64_v3_radix(env)) {
             qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU is unsupported\n",
                           __func__);
         } else {
@@ -810,7 +810,7 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     switch (cpu->env.mmu_model) {
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_3_00:
-        if (ppc64_v3_radix(cpu)) {
+        if (ppc64_v3_radix(&cpu->env)) {
             return ppc_radix64_xlate(cpu, eaddr, access_type, raddrp,
                                      psizep, protp, mmu_idx, guest_visible);
         }
-- 
2.30.9


