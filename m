Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB843CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJZq-0006Ag-TQ; Wed, 27 Aug 2025 13:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZp-00068t-9O; Wed, 27 Aug 2025 13:04:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZh-0007fb-4x; Wed, 27 Aug 2025 13:04:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 83A6B14C72A;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 931142698F0;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 08/18] target/arm/sme: Rebuild hflags in
 aarch64_set_svcr()
Date: Wed, 27 Aug 2025 20:03:43 +0300
Message-ID: <20250827170356.2698446-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-7-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f4318557149184d6dac99e561acabcb602a84ee1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 5e93d27d8f..2e2f7cf218 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,14 +89,8 @@ void cpu_loop(CPUARMState *env)
 
         switch (trapnr) {
         case EXCP_SWI:
-            /*
-             * On syscall, PSTATE.ZA is preserved, along with the ZA matrix.
-             * PSTATE.SM is cleared, per SMSTOP, which does ResetSVEState.
-             */
+            /* On syscall, PSTATE.ZA is preserved, PSTATE.SM is cleared. */
             aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-            if (FIELD_EX64(env->svcr, SVCR, SM)) {
-                arm_rebuild_hflags(env);
-            }
             ret = do_syscall(env,
                              env->xregs[8],
                              env->xregs[0],
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index a326a6def5..b265cfd470 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -667,9 +667,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     /* Invoke the signal handler with both SM and ZA disabled. */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
-    if (env->svcr) {
-        arm_rebuild_hflags(env);
-    }
 
     if (info) {
         tswap_siginfo(&frame->info, info);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 000632fe2b..4628b192f9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6442,6 +6442,9 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 {
     uint64_t change = (env->svcr ^ new) & mask;
 
+    if (change == 0) {
+        return;
+    }
     env->svcr ^= change;
 
     if (change & R_SVCR_SM_MASK) {
@@ -6459,6 +6462,8 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
     if (change & new & R_SVCR_ZA_MASK) {
         memset(env->zarray, 0, sizeof(env->zarray));
     }
+
+    arm_rebuild_hflags(env);
 }
 
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6467,7 +6472,6 @@ static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
     helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
     aarch64_set_svcr(env, value, -1);
-    arm_rebuild_hflags(env);
 }
 
 static void smcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 247c2823ac..bbda651974 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -31,20 +31,12 @@
 
 void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
 {
-    if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
-        return;
-    }
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-    arm_rebuild_hflags(env);
 }
 
 void helper_set_pstate_za(CPUARMState *env, uint32_t i)
 {
-    if (i == FIELD_EX64(env->svcr, SVCR, ZA)) {
-        return;
-    }
     aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
-    arm_rebuild_hflags(env);
 }
 
 void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
-- 
2.47.2


