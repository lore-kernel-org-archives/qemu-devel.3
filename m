Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45967C25B10
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bon-00055Y-Bw; Fri, 10 May 2024 21:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boQ-0004wd-6j; Fri, 10 May 2024 21:46:10 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boA-0003Nd-30; Fri, 10 May 2024 21:46:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 216DC4E6780;
 Sat, 11 May 2024 03:45:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mS9vT3ItT9ez; Sat, 11 May 2024 03:45:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 336F34E6782; Sat, 11 May 2024 03:45:48 +0200 (CEST)
Message-Id: <03f2316f1a16506170b0d81599d73bffcd19fec3.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 09/48] target/ppc/mmu_common.c: Move some debug logging
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:45:48 +0200 (CEST)
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

Move the debug logging within ppc6xx_tlb_check() from after its only
call to simplify the caller.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 54 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index ba60b4902b..89bfd9aa45 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -225,17 +225,14 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
                       access_type == MMU_INST_FETCH ? 'I' : 'D');
         switch (ppc6xx_tlb_pte_check(ctx, tlb->pte0, tlb->pte1,
                                      0, access_type)) {
-        case -3:
-            /* TLB inconsistency */
-            return -1;
         case -2:
             /* Access violation */
             ret = -2;
             best = nr;
             break;
-        case -1:
+        case -1: /* No match */
+        case -3: /* TLB inconsistency */
         default:
-            /* No match */
             break;
         case 0:
             /* access granted */
@@ -251,14 +248,34 @@ static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
         }
     }
     if (best != -1) {
-    done:
+done:
         qemu_log_mask(CPU_LOG_MMU, "found TLB at addr " HWADDR_FMT_plx
                       " prot=%01x ret=%d\n",
                       ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
         /* Update page flags */
         pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_type);
     }
-
+#if defined(DUMP_PAGE_TABLES)
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        CPUState *cs = env_cpu(env);
+        hwaddr base = ppc_hash32_hpt_base(env_archcpu(env));
+        hwaddr len = ppc_hash32_hpt_mask(env_archcpu(env)) + 0x80;
+        uint32_t a0, a1, a2, a3;
+
+        qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
+                 base, len);
+        for (hwaddr curaddr = base; curaddr < base + len; curaddr += 16) {
+            a0 = ldl_phys(cs->as, curaddr);
+            a1 = ldl_phys(cs->as, curaddr + 4);
+            a2 = ldl_phys(cs->as, curaddr + 8);
+            a3 = ldl_phys(cs->as, curaddr + 12);
+            if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
+                qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
+                         curaddr, a0, a1, a2, a3);
+            }
+        }
+    }
+#endif
     return ret;
 }
 
@@ -420,29 +437,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
         ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
-#if defined(DUMP_PAGE_TABLES)
-        if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-            CPUState *cs = env_cpu(env);
-            hwaddr curaddr;
-            uint32_t a0, a1, a2, a3;
-
-            qemu_log("Page table: " HWADDR_FMT_plx " len " HWADDR_FMT_plx "\n",
-                     ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu) + 0x80);
-            for (curaddr = ppc_hash32_hpt_base(cpu);
-                 curaddr < (ppc_hash32_hpt_base(cpu)
-                            + ppc_hash32_hpt_mask(cpu) + 0x80);
-                 curaddr += 16) {
-                a0 = ldl_phys(cs->as, curaddr);
-                a1 = ldl_phys(cs->as, curaddr + 4);
-                a2 = ldl_phys(cs->as, curaddr + 8);
-                a3 = ldl_phys(cs->as, curaddr + 12);
-                if (a0 != 0 || a1 != 0 || a2 != 0 || a3 != 0) {
-                    qemu_log(HWADDR_FMT_plx ": %08x %08x %08x %08x\n",
-                             curaddr, a0, a1, a2, a3);
-                }
-            }
-        }
-#endif
     } else {
         qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
         /* Direct-store segment : absolutely *BUGGY* for now */
-- 
2.30.9


