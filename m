Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE07AC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpe-0003Ff-Hd; Wed, 08 May 2024 19:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpc-0003DY-T6; Wed, 08 May 2024 19:36:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpb-0002Vj-5C; Wed, 08 May 2024 19:36:16 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0035A4E6426;
 Thu, 09 May 2024 01:36:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x081mn3izBGZ; Thu,  9 May 2024 01:36:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 12A2D4E6030; Thu, 09 May 2024 01:36:11 +0200 (CEST)
Message-Id: <71aafa52bdf95e4c82e0ed2f6ca045eaccb56abe.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 08/33] target/ppc/mmu_common.c: Drop cases for
 unimplemented MPC8xx MMU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:11 +0200 (CEST)
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

Drop MPC8xx cases from get_physical_address_wtlb() and ppc_jumbo_xlate().
The default case would still catch this and abort the same way and
there is still a warning about it in ppc_tlb_invalidate_all() which is
called in ppc_cpu_reset_hold() so likely we never get here but to make
sure add a case to ppc_xlate() to the same effect.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 886fb6a657..3391df61cb 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1219,10 +1219,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
         ret = mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
                                                mmu_idx);
         break;
-    case POWERPC_MMU_MPC8xx:
-        /* XXX: TODO */
-        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n");
-        break;
     case POWERPC_MMU_REAL:
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
@@ -1353,8 +1349,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_BOOKE_DEAR] = eaddr;
                     env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
                     break;
-                case POWERPC_MMU_MPC8xx:
-                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_REAL:
                     cpu_abort(cs, "PowerPC in real mode should never raise "
                               "any MMU exceptions\n");
@@ -1427,9 +1421,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                         env->spr[SPR_40x_ESR] = 0x00000000;
                     }
                     break;
-                case POWERPC_MMU_MPC8xx:
-                    /* XXX: TODO */
-                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n");
                 case POWERPC_MMU_BOOKE206:
                     booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
                     /* fall through */
@@ -1539,7 +1530,8 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_32B:
         return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
-
+    case POWERPC_MMU_MPC8xx:
+        cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
         return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
-- 
2.30.9


