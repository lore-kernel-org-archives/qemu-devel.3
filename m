Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DC7C25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5P-0006Nr-DB; Sun, 26 May 2024 19:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5C-0005m4-BX; Sun, 26 May 2024 19:15:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN55-0003oY-Qk; Sun, 26 May 2024 19:15:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B7524E654F;
 Mon, 27 May 2024 01:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id P9gle9qPYjkE; Mon, 27 May 2024 01:13:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 16EA34E6550; Mon, 27 May 2024 01:13:16 +0200 (CEST)
Message-Id: <1fdc0583f2e14924123c9a99c250710129b61dfb.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 39/43] target/ppc: Change parameter type of some inline
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:16 +0200 (CEST)
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

These functions take PowerPCCPU but only need the env from it. Change
their parameter to CPUPPCState *env.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 13 +++++++------
 target/ppc/mmu-hash32.h | 12 ++++++------
 target/ppc/mmu_common.c | 20 +++++++++-----------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 6d0adf3357..f18faf0f46 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -244,10 +244,11 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
                                      target_ulong sr, target_ulong eaddr,
                                      ppc_hash_pte32_t *pte)
 {
+    CPUPPCState *env = &cpu->env;
     hwaddr hpt_base, pteg_off, pte_addr, hash;
     uint32_t vsid, pgidx, ptem;
 
-    hpt_base = ppc_hash32_hpt_base(cpu);
+    hpt_base = ppc_hash32_hpt_base(env);
     vsid = sr & SR32_VSID;
     pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
@@ -256,21 +257,21 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
     /* Page address translation */
     qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
                   HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
-                  hpt_base, ppc_hash32_hpt_mask(cpu), hash);
+                  hpt_base, ppc_hash32_hpt_mask(env), hash);
 
     /* Primary PTEG lookup */
     qemu_log_mask(CPU_LOG_MMU, "0 htab=" HWADDR_FMT_plx "/" HWADDR_FMT_plx
                   " vsid=%" PRIx32 " ptem=%" PRIx32 " hash=" HWADDR_FMT_plx
-                  "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, ptem, hash);
-    pteg_off = get_pteg_offset32(cpu, hash);
+                  "\n", hpt_base, ppc_hash32_hpt_mask(env), vsid, ptem, hash);
+    pteg_off = get_pteg_offset32(env, hash);
     pte_addr = ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 0, ptem, pte);
     if (pte_addr == -1) {
         /* Secondary PTEG lookup */
         qemu_log_mask(CPU_LOG_MMU, "1 htab=" HWADDR_FMT_plx "/" HWADDR_FMT_plx
                       " vsid=%" PRIx32 " api=%" PRIx32 " hash=" HWADDR_FMT_plx
-                      "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, ptem,
+                      "\n", hpt_base, ppc_hash32_hpt_mask(env), vsid, ptem,
                       ~hash);
-        pteg_off = get_pteg_offset32(cpu, ~hash);
+        pteg_off = get_pteg_offset32(env, ~hash);
         pte_addr = ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 1, ptem,
                                           pte);
     }
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 4db55fb0a0..ec8d881def 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -59,19 +59,19 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 #define HPTE32_R_WIMG           0x00000078
 #define HPTE32_R_PP             0x00000003
 
-static inline hwaddr ppc_hash32_hpt_base(PowerPCCPU *cpu)
+static inline hwaddr ppc_hash32_hpt_base(CPUPPCState *env)
 {
-    return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
+    return env->spr[SPR_SDR1] & SDR_32_HTABORG;
 }
 
-static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
+static inline hwaddr ppc_hash32_hpt_mask(CPUPPCState *env)
 {
-    return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
+    return ((env->spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
 }
 
-static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
+static inline hwaddr get_pteg_offset32(CPUPPCState *env, hwaddr hash)
 {
-    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
+    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(env);
 }
 
 static inline bool ppc_hash32_key(bool pr, target_ulong sr)
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 60f8736210..b45eb64f6e 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -166,8 +166,8 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
 #if defined(DUMP_PAGE_TABLES)
     if (qemu_loglevel_mask(CPU_LOG_MMU)) {
         CPUState *cs = env_cpu(env);
-        hwaddr base = ppc_hash32_hpt_base(env_archcpu(env));
-        hwaddr len = ppc_hash32_hpt_mask(env_archcpu(env)) + 0x80;
+        hwaddr base = ppc_hash32_hpt_base(env);
+        hwaddr len = ppc_hash32_hpt_mask(env) + 0x80;
         uint32_t a0, a1, a2, a3;
 
         qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
@@ -263,7 +263,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
                                        hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
     bool key, ds, nx;
@@ -305,7 +304,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
         /* Page address translation */
         qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
                       HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
-                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
+                      ppc_hash32_hpt_base(env), ppc_hash32_hpt_mask(env), hash);
         *hashp = hash;
 
         /* Software TLB search */
@@ -499,13 +498,12 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
 
 static void mmu6xx_dump_mmu(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
     ppc6xx_tlb_t *tlb;
     target_ulong sr;
     int type, way, entry, i;
 
-    qemu_printf("HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(cpu));
-    qemu_printf("HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(cpu));
+    qemu_printf("HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(env));
+    qemu_printf("HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(env));
 
     qemu_printf("\nSegment registers:\n");
     for (i = 0; i < 32; i++) {
@@ -743,10 +741,10 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eaddr,
             env->spr[SPR_DCMP] |= 0x80000000;
 tlb_miss:
             env->error_code |= key << 19;
-            env->spr[SPR_HASH1] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, hash);
-            env->spr[SPR_HASH2] = ppc_hash32_hpt_base(cpu) +
-                                  get_pteg_offset32(cpu, ~hash);
+            env->spr[SPR_HASH1] = ppc_hash32_hpt_base(env) +
+                                  get_pteg_offset32(env, hash);
+            env->spr[SPR_HASH2] = ppc_hash32_hpt_base(env) +
+                                  get_pteg_offset32(env, ~hash);
             break;
         case -2:
             /* Access rights violation */
-- 
2.30.9


