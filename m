Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C04DC25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5p-0007i3-Vr; Sun, 26 May 2024 19:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5D-0005nz-MG; Sun, 26 May 2024 19:15:20 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN52-0003md-Um; Sun, 26 May 2024 19:15:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D022A4E6503;
 Mon, 27 May 2024 01:13:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LfHZguIPtDtZ; Mon, 27 May 2024 01:13:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E942C4E650C; Mon, 27 May 2024 01:13:11 +0200 (CEST)
Message-Id: <c6424ad0d838c2e72e6801544b38ed682aa081ed.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 35/43] target/ppc/mmu-hash32.c: Change parameter type of
 ppc_hash32_bat_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:11 +0200 (CEST)
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

This function takes PowerPCCPU but only needs the env from it. Change
its parameter to CPUPPCState *env.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 44b16142ab..a2c0ac05d2 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -48,11 +48,10 @@ static target_ulong hash32_bat_size(int mmu_idx,
     return BATU32_BEPI & ~((batu & BATU32_BL) << 15);
 }
 
-static hwaddr ppc_hash32_bat_lookup(PowerPCCPU *cpu, target_ulong ea,
+static hwaddr ppc_hash32_bat_lookup(CPUPPCState *env, target_ulong ea,
                                     MMUAccessType access_type, int *prot,
                                     int mmu_idx)
 {
-    CPUPPCState *env = &cpu->env;
     target_ulong *BATlt, *BATut;
     bool ifetch = access_type == MMU_INST_FETCH;
     int i;
@@ -316,7 +315,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     /* 2. Check Block Address Translation entries (BATs) */
     if (env->nb_BATs != 0) {
-        raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
+        raddr = ppc_hash32_bat_lookup(env, eaddr, access_type, protp, mmu_idx);
         if (raddr != -1) {
             if (!check_prot_access_type(*protp, access_type)) {
                 if (guest_visible) {
-- 
2.30.9


