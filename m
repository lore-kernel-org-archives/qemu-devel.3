Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5D3C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id4-0002UT-Qa; Sun, 12 May 2024 19:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icf-00021C-2s; Sun, 12 May 2024 19:28:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icb-0000RI-G6; Sun, 12 May 2024 19:28:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0CA4D4E678B;
 Mon, 13 May 2024 01:28:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mlbtngsYEV8L; Mon, 13 May 2024 01:28:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1D1BB4E678C; Mon, 13 May 2024 01:28:26 +0200 (CEST)
Message-Id: <0a6a9c230fd4a941dec8b13a0845b3dcbba75f13.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 51/61] target/ppc: Add function to get protection key for
 hash32 MMU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:26 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Add a function to get key bit from SR and use it instead of open coded
version.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 9 ++++++---
 target/ppc/mmu-hash32.h | 5 +++++
 target/ppc/mmu_common.c | 3 +--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index d5f2057eb1..8e5e83f46a 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -42,7 +42,7 @@ static int ppc_hash32_pte_prot(int mmu_idx,
 {
     unsigned pp, key;
 
-    key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
+    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
     pp = pte.pte1 & HPTE32_R_PP;
 
     return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
@@ -145,7 +145,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    int key = !!(mmuidx_pr(mmu_idx) ? (sr & SR32_KP) : (sr & SR32_KS));
 
     qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
 
@@ -206,7 +205,11 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
         cpu_abort(cs, "ERROR: insn should not need address translation\n");
     }
 
-    *prot = key ? PAGE_READ | PAGE_WRITE : PAGE_READ;
+    if (ppc_hash32_key(mmuidx_pr(mmu_idx), sr)) {
+        *prot = PAGE_READ | PAGE_WRITE;
+    } else {
+        *prot = PAGE_READ;
+    }
     if (check_prot_access_type(*prot, access_type)) {
         *raddr = eaddr;
         return true;
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index bf99161858..6e5796d7cb 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -102,6 +102,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
+static inline bool ppc_hash32_key(bool pr, target_ulong sr)
+{
+    return pr ? (sr & SR32_KP) : (sr & SR32_KS);
+}
+
 static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
 {
     int prot;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f09f7417c2..3d028a2008 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -310,8 +310,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     pr = FIELD_EX64(env->msr, MSR, PR);
 
     sr = env->sr[eaddr >> 28];
-    ctx->key = (((sr & 0x20000000) && pr) ||
-                ((sr & 0x40000000) && !pr)) ? 1 : 0;
+    ctx->key = ppc_hash32_key(pr, sr);
     ds = sr & SR32_T;
     nx = sr & SR32_NX;
     vsid = sr & SR32_VSID;
-- 
2.30.9


