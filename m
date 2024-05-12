Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A8CC25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IdA-00031y-EK; Sun, 12 May 2024 19:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ict-0002Gl-0v; Sun, 12 May 2024 19:29:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icr-0000Uz-GR; Sun, 12 May 2024 19:29:06 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6ECC84E65C5;
 Mon, 13 May 2024 01:28:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id qTY6aqICWiJk; Mon, 13 May 2024 01:28:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7E8B94E6543; Mon, 13 May 2024 01:28:34 +0200 (CEST)
Message-Id: <be24fd5e89840b061ba438ab9f6a7611386df51e.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 59/61] target/ppc/mmu_common.c: Stop using ctx in
 get_bat_6xx_tlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:34 +0200 (CEST)
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

Pass raddr and prot in function parameters instead

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ba54c40048..6d588b6795 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -193,7 +193,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
+static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
                            target_ulong eaddr, MMUAccessType access_type,
                            bool pr)
 {
@@ -224,16 +224,16 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             if ((eaddr & BATU32_BEPIU) == BEPIu &&
                 ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
                 /* Get physical address */
-                ctx->raddr = (*BATl & BATU32_BEPIU) |
+                *raddr = (*BATl & BATU32_BEPIU) |
                     ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
-                ctx->prot = ppc_hash32_bat_prot(*BATu, *BATl);
-                if (check_prot_access_type(ctx->prot, access_type)) {
+                *prot = ppc_hash32_bat_prot(*BATu, *BATl);
+                if (check_prot_access_type(*prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
-                                  " prot=%c%c\n", i, ctx->raddr,
-                                  ctx->prot & PAGE_READ ? 'R' : '-',
-                                  ctx->prot & PAGE_WRITE ? 'W' : '-');
+                                  " prot=%c%c\n", i, *raddr,
+                                  *prot & PAGE_READ ? 'R' : '-',
+                                  *prot & PAGE_WRITE ? 'W' : '-');
                     ret = 0;
                 } else {
                     ret = -2;
@@ -277,7 +277,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs &&
-        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) == 0) {
+        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
+                        access_type, pr) == 0) {
         return 0;
     }
 
-- 
2.30.9


