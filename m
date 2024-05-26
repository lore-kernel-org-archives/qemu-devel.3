Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B46DC25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5p-0007dk-0u; Sun, 26 May 2024 19:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5k-00078B-Pr; Sun, 26 May 2024 19:15:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5d-000483-94; Sun, 26 May 2024 19:15:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F2544E65C0;
 Mon, 27 May 2024 01:13:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id paQQXJX6DR2D; Mon, 27 May 2024 01:13:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 410724E65B8; Mon, 27 May 2024 01:13:20 +0200 (CEST)
Message-Id: <89743dc082d33b8bed06d5574b8916005c0b47a8.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 43/43] target/ppc/mmu-hash32.c: Change parameter type of
 ppc_hash32_direct_store
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:20 +0200 (CEST)
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

This function needs CPUState and env but takes PowerPCCPU and cast
that. We already have the right types in the caller so pass them to
this function to avoid casting.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 0f9c61bf89..3588f8f8de 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -109,15 +109,12 @@ static hwaddr ppc_hash32_bat_lookup(CPUPPCState *env, target_ulong ea,
     return -1;
 }
 
-static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
-                                    target_ulong eaddr,
+static bool ppc_hash32_direct_store(CPUState *cs, CPUPPCState *env,
+                                    target_ulong sr, target_ulong eaddr,
                                     MMUAccessType access_type,
                                     hwaddr *raddr, int *prot, int mmu_idx,
                                     bool guest_visible)
 {
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
-
     qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
 
     if (access_type == MMU_INST_FETCH) {
@@ -336,7 +333,7 @@ bool ppc_hash32_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
 
     /* 4. Handle direct store segments */
     if (sr & SR32_T) {
-        return ppc_hash32_direct_store(cpu, sr, eaddr, access_type,
+        return ppc_hash32_direct_store(cs, env, sr, eaddr, access_type,
                                        raddrp, protp, mmu_idx, guest_visible);
     }
 
-- 
2.30.9


