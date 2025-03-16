Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F538C282DE
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 14:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttpDU-0004Ns-H1; Sun, 16 Mar 2025 10:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttpDS-0004NY-DK; Sun, 16 Mar 2025 10:43:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttpDQ-0003of-CQ; Sun, 16 Mar 2025 10:43:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34F1C4E6019;
 Sun, 16 Mar 2025 15:43:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id k2YiFDmHoV-f; Sun, 16 Mar 2025 15:43:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 39E6F4E6014; Sun, 16 Mar 2025 15:43:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] target/ppc: Add PIR to ppc_cpu_dump_state() for debug print
 out
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20250316144341.39E6F4E6014@zero.eik.bme.hu>
Date: Sun, 16 Mar 2025 15:43:41 +0100 (CET)
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

Some CPU variants have a Processor Identification Register which was
not printed in register dump. Add it to ppc_cpu_dump_state() which is
used by debug options to print CPU register values.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu_init.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17..b1f32662ed 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7606,9 +7606,14 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     int i;
 
     qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
-                 TARGET_FMT_lx " XER " TARGET_FMT_lx " CPU#%d\n",
-                 env->nip, env->lr, env->ctr, cpu_read_xer(env),
-                 cs->cpu_index);
+                 TARGET_FMT_lx " XER " TARGET_FMT_lx,
+                 env->nip, env->lr, env->ctr, cpu_read_xer(env));
+    if (env->spr_cb[SPR_PIR].name) {
+        qemu_fprintf(f, " PIR " TARGET_FMT_lx, env->spr[SPR_PIR]);
+    } else if (env->spr_cb[SPR_BOOKE_PIR].name) {
+        qemu_fprintf(f, " PIR " TARGET_FMT_lx, env->spr[SPR_BOOKE_PIR]);
+    }
+    qemu_fprintf(f, " CPU#%d\n", cs->cpu_index);
     qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
                  "%08x iidx %d didx %d\n",
                  env->msr, env->spr[SPR_HID0], env->hflags,
-- 
2.41.3


