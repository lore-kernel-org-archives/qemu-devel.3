Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9905C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IdC-00034h-17; Sun, 12 May 2024 19:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icp-0002GY-U9; Sun, 12 May 2024 19:29:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icn-0000Ts-PQ; Sun, 12 May 2024 19:29:03 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6D2AE4E65C3;
 Mon, 13 May 2024 01:28:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id otOxvh6SdfCA; Mon, 13 May 2024 01:28:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 748CB4E601D; Mon, 13 May 2024 01:28:33 +0200 (CEST)
Message-Id: <249c82b0d5ef7d3fa504c6a12aa670dfb8f81fd8.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 58/61] target/ppc: Remove bat_size_prot()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:33 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

There is already a hash32_bat_prot() function that does most if this
and the rest can be inlined. Export hash32_bat_prot() and rename it to
ppc_hash32_bat_prot() to match other functions and use it in
get_bat_6xx_tlb().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 18 +-------------
 target/ppc/mmu-hash32.h | 14 +++++++++++
 target/ppc/mmu_common.c | 52 ++++++++++-------------------------------
 3 files changed, 27 insertions(+), 57 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 9de42713b3..cc19041cc2 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -48,22 +48,6 @@ static target_ulong hash32_bat_size(int mmu_idx,
     return BATU32_BEPI & ~((batu & BATU32_BL) << 15);
 }
 
-static int hash32_bat_prot(PowerPCCPU *cpu,
-                           target_ulong batu, target_ulong batl)
-{
-    int pp, prot;
-
-    prot = 0;
-    pp = batl & BATL32_PP;
-    if (pp != 0) {
-        prot = PAGE_READ | PAGE_EXEC;
-        if (pp == 0x2) {
-            prot |= PAGE_WRITE;
-        }
-    }
-    return prot;
-}
-
 static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
                                     MMUAccessType access_type, int *prot,
                                     int mmu_idx)
@@ -95,7 +79,7 @@ static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
         if (mask && ((ea & mask) == (batu & BATU32_BEPI))) {
             hwaddr raddr = (batl & mask) | (ea & ~mask);
 
-            *prot = hash32_bat_prot(cpu, batu, batl);
+            *prot = ppc_hash32_bat_prot(batu, batl);
 
             return raddr & TARGET_PAGE_MASK;
         }
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 6e5796d7cb..f86ef8dd82 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -143,6 +143,20 @@ static inline int ppc_hash32_pp_prot(bool key, int pp, bool nx)
     return nx ? prot : prot | PAGE_EXEC;
 }
 
+static inline int ppc_hash32_bat_prot(target_ulong batu, target_ulong batl)
+{
+    int prot = 0;
+    int pp = batl & BATL32_PP;
+
+    if (pp) {
+        prot = PAGE_READ | PAGE_EXEC;
+        if (pp == 0x2) {
+            prot |= PAGE_WRITE;
+        }
+    }
+    return prot;
+}
+
 typedef struct {
     uint32_t pte0, pte1;
 } ppc_hash_pte32_t;
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index bfd3787e32..ba54c40048 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -193,40 +193,13 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-/* Perform BAT hit & translation */
-static inline void bat_size_prot(CPUPPCState *env, target_ulong *blp,
-                                 int *validp, int *protp, target_ulong *BATu,
-                                 target_ulong *BATl)
-{
-    target_ulong bl;
-    int pp, valid, prot;
-
-    bl = (*BATu & BATU32_BL) << 15;
-    valid = 0;
-    prot = 0;
-    if ((!FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000002)) ||
-        (FIELD_EX64(env->msr, MSR, PR) && (*BATu & 0x00000001))) {
-        valid = 1;
-        pp = *BATl & 0x00000003;
-        if (pp != 0) {
-            prot = PAGE_READ | PAGE_EXEC;
-            if (pp == 0x2) {
-                prot |= PAGE_WRITE;
-            }
-        }
-    }
-    *blp = bl;
-    *validp = valid;
-    *protp = prot;
-}
-
 static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                           target_ulong eaddr, MMUAccessType access_type)
+                           target_ulong eaddr, MMUAccessType access_type,
+                           bool pr)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
-    int i, valid, prot;
-    int ret = -1;
+    int i, ret = -1;
     bool ifetch = access_type == MMU_INST_FETCH;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT v " TARGET_FMT_lx "\n", __func__,
@@ -243,20 +216,19 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
         BATl = &BATlt[i];
         BEPIu = *BATu & BATU32_BEPIU;
         BEPIl = *BATu & BATU32_BEPIL;
-        bat_size_prot(env, &bl, &valid, &prot, BATu, BATl);
         qemu_log_mask(CPU_LOG_MMU, "%s: %cBAT%d v " TARGET_FMT_lx " BATu "
                       TARGET_FMT_lx " BATl " TARGET_FMT_lx "\n", __func__,
                       ifetch ? 'I' : 'D', i, eaddr, *BATu, *BATl);
-        if ((eaddr & BATU32_BEPIU) == BEPIu &&
-            ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
-            /* BAT matches */
-            if (valid != 0) {
+        bl = (*BATu & BATU32_BL) << 15;
+        if ((!pr && (*BATu & BATU32_VS)) || (pr && (*BATu & BATU32_VP))) {
+            if ((eaddr & BATU32_BEPIU) == BEPIu &&
+                ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
                 /* Get physical address */
                 ctx->raddr = (*BATl & BATU32_BEPIU) |
                     ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
-                ctx->prot = prot;
+                ctx->prot = ppc_hash32_bat_prot(*BATu, *BATl);
                 if (check_prot_access_type(ctx->prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
                                   " prot=%c%c\n", i, ctx->raddr,
@@ -300,16 +272,16 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
-    bool key, pr, ds, nx;
+    bool key, ds, nx;
+    bool pr = FIELD_EX64(env->msr, MSR, PR);
 
     /* First try to find a BAT entry if there are any */
-    if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
+    if (env->nb_BATs &&
+        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) == 0) {
         return 0;
     }
 
     /* Perform segment based translation when no BATs matched */
-    pr = FIELD_EX64(env->msr, MSR, PR);
-
     sr = env->sr[eaddr >> 28];
     key = ppc_hash32_key(pr, sr);
     *keyp = key;
-- 
2.30.9


