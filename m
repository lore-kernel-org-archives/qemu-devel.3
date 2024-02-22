Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B121BC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7LH-0005Jt-01; Thu, 22 Feb 2024 06:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd7L6-00051P-Me; Thu, 22 Feb 2024 06:34:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd7L4-0006ON-Ns; Thu, 22 Feb 2024 06:34:08 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 278334E6049;
 Thu, 22 Feb 2024 12:34:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BWTa0H36FGNM; Thu, 22 Feb 2024 12:34:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3E2434E6039; Thu, 22 Feb 2024 12:34:03 +0100 (CET)
Message-Id: <7939a0638ac30b06d4c336bb04d72fdf48fb4c13.1708601065.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1708601065.git.balaton@eik.bme.hu>
References: <cover.1708601065.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 9/9] target/ppc: Remove interrupt handler wrapper functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Thu, 22 Feb 2024 12:34:03 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

These wrappers call out to handle POWER7 and newer in separate
functions but reduce to the generic case when TARGET_PPC64 is not
defined. It is easy enough to include the switch in the beginning of
the generic functions to branch out to the specific functions and get
rid of these wrappers. This avoids one indirection and entirely
compiles out the switch without TARGET_PPC64.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 67 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 5124c3e6b5..a23dd43437 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1921,8 +1921,21 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
 }
 #endif /* TARGET_PPC64 */
 
-static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
+static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
+#ifdef TARGET_PPC64
+    switch (env->excp_model) {
+    case POWERPC_EXCP_POWER7:
+        return p7_next_unmasked_interrupt(env);
+    case POWERPC_EXCP_POWER8:
+        return p8_next_unmasked_interrupt(env);
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        return p9_next_unmasked_interrupt(env);
+    default:
+        break;
+    }
+#endif
     bool async_deliver;
 
     /* External reset */
@@ -2033,23 +2046,6 @@ static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
     return 0;
 }
 
-static int ppc_next_unmasked_interrupt(CPUPPCState *env)
-{
-    switch (env->excp_model) {
-#ifdef TARGET_PPC64
-    case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env);
-    case POWERPC_EXCP_POWER8:
-        return p8_next_unmasked_interrupt(env);
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
-        return p9_next_unmasked_interrupt(env);
-#endif
-    default:
-        return ppc_next_unmasked_interrupt_generic(env);
-    }
-}
-
 /*
  * Sets CPU_INTERRUPT_HARD if there is at least one unmasked interrupt to be
  * delivered and clears CPU_INTERRUPT_HARD otherwise.
@@ -2279,8 +2275,21 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 }
 #endif /* TARGET_PPC64 */
 
-static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
+static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
+#ifdef TARGET_PPC64
+    switch (env->excp_model) {
+    case POWERPC_EXCP_POWER7:
+        return p7_deliver_interrupt(env, interrupt);
+    case POWERPC_EXCP_POWER8:
+        return p8_deliver_interrupt(env, interrupt);
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        return p9_deliver_interrupt(env, interrupt);
+    default:
+        break;
+    }
+#endif
     PowerPCCPU *cpu = env_archcpu(env);
 
     switch (interrupt) {
@@ -2383,26 +2392,6 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
     }
 }
 
-static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
-{
-    switch (env->excp_model) {
-#ifdef TARGET_PPC64
-    case POWERPC_EXCP_POWER7:
-        p7_deliver_interrupt(env, interrupt);
-        break;
-    case POWERPC_EXCP_POWER8:
-        p8_deliver_interrupt(env, interrupt);
-        break;
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
-        p9_deliver_interrupt(env, interrupt);
-        break;
-#endif
-    default:
-        ppc_deliver_interrupt_generic(env, interrupt);
-    }
-}
-
 void ppc_cpu_do_system_reset(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-- 
2.30.9


