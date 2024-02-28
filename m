Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97C3C5475B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSpm-0005Vg-3P; Wed, 28 Feb 2024 17:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpW-0005Qx-Q6; Wed, 28 Feb 2024 17:55:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpT-0000WW-Ho; Wed, 28 Feb 2024 17:55:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B61C75180B;
 Thu, 29 Feb 2024 01:55:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1A7CF8BB3E;
 Thu, 29 Feb 2024 01:54:56 +0300 (MSK)
Received: (nullmailer pid 274131 invoked by uid 1000);
 Wed, 28 Feb 2024 22:54:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 66/78] target/ppc: Fix crash on machine check caused by
 ifetch
Date: Thu, 29 Feb 2024 01:54:42 +0300
Message-Id: <20240228225455.274062-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

is_prefix_insn_excp() loads the first word of the instruction address
which caused an exception, to determine whether or not it was prefixed
so the prefix bit can be set in [H]SRR1.

This works if the instruction image can be loaded, but if the exception
was caused by an ifetch, this load could fail and cause a recursive
exception and crash. Machine checks caused by ifetch are not excluded
from the prefix check and can crash (see issue 2108 for an example).

Fix this by excluding machine checks caused by ifetch from the prefix
check.

Cc: qemu-stable@nongnu.org
Acked-by: Cédric Le Goater <clg@kaod.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2108
Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit c8fd9667e5975fe2e70a906e125a758737eab707)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a42743a3e0..9b8fd69b85 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1312,6 +1312,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
 
+    if (!(env->insns_flags2 & PPC2_ISA310)) {
+        return false;
+    }
+
     if (!tcg_enabled()) {
         /*
          * This does not load instructions and set the prefix bit correctly
@@ -1322,6 +1326,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     }
 
     switch (excp) {
+    case POWERPC_EXCP_MCHECK:
+        if (!(env->error_code & PPC_BIT(42))) {
+            /*
+             * Fetch attempt caused a machine check, so attempting to fetch
+             * again would cause a recursive machine check.
+             */
+            return false;
+        }
+        break;
     case POWERPC_EXCP_HDSI:
         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
@@ -1332,10 +1345,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
              * instruction at NIP would cause recursive faults with the same
              * translation).
              */
-            break;
+            return false;
         }
-        /* fall through */
-    case POWERPC_EXCP_MCHECK:
+        break;
+
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
     case POWERPC_EXCP_ALIGN:
@@ -1346,17 +1359,13 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPU:
     case POWERPC_EXCP_VSXU:
     case POWERPC_EXCP_FU:
-    case POWERPC_EXCP_HV_FU: {
-        uint32_t insn = ppc_ldl_code(env, env->nip);
-        if (is_prefix_insn(env, insn)) {
-            return true;
-        }
+    case POWERPC_EXCP_HV_FU:
         break;
-    }
     default:
-        break;
+        return false;
     }
-    return false;
+
+    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
 }
 #else
 static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
@@ -3224,6 +3233,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 
     switch (env->excp_model) {
 #if defined(TARGET_PPC64)
+    case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
         /*
@@ -3245,6 +3255,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
             env->error_code |= PPC_BIT(42);
 
         } else { /* Fetch */
+            /*
+             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
+             * the instruction, so that must always be clear for fetches.
+             */
             env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
         }
         break;
-- 
2.39.2


