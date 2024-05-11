Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD303C25B10
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpa-0006UU-7N; Fri, 10 May 2024 21:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boS-0004zN-K5; Fri, 10 May 2024 21:46:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boB-0003O3-Nj; Fri, 10 May 2024 21:46:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 51E624E6786;
 Sat, 11 May 2024 03:45:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id i9aHRlJlCy3K; Sat, 11 May 2024 03:45:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 60EA84E6787; Sat, 11 May 2024 03:45:52 +0200 (CEST)
Message-Id: <b10fd9ac35318a384623f0f258465265f01897e5.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 13/48] target/ppc/mmu_common.c: Inline and remove
 check_physical()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:45:52 +0200 (CEST)
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

This function just does two assignments and and unnecessary check that
is always true so inline it in the only caller left and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b13150ce23..2f412dd7c5 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1145,28 +1145,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-static int check_physical(CPUPPCState *env, mmu_ctx_t *ctx, target_ulong eaddr,
-                          MMUAccessType access_type)
-{
-    ctx->raddr = eaddr;
-    ctx->prot = PAGE_READ | PAGE_EXEC;
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-    case POWERPC_MMU_SOFT_4xx:
-    case POWERPC_MMU_REAL:
-    case POWERPC_MMU_BOOKE:
-        ctx->prot |= PAGE_WRITE;
-        break;
-
-    default:
-        /* Caller's checks mean we should never get here for other models */
-        g_assert_not_reached();
-    }
-
-    return 0;
-}
-
 int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      target_ulong eaddr,
                                      MMUAccessType access_type, int type,
@@ -1186,7 +1164,9 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
                       env->mmu_model == POWERPC_MMU_SOFT_4xx ||
                       env->mmu_model == POWERPC_MMU_REAL)) {
-        return check_physical(env, ctx, eaddr, access_type);
+        ctx->raddr = eaddr;
+        ctx->prot = PAGE_RWX;
+        return 0;
     }
 
     switch (env->mmu_model) {
-- 
2.30.9


