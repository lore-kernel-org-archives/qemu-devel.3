Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A4CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJZb-0005zL-19; Wed, 27 Aug 2025 13:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZZ-0005yL-Ax; Wed, 27 Aug 2025 13:04:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJZV-0007dp-63; Wed, 27 Aug 2025 13:04:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D4AD14C727;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5CE772698ED;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 05/18] target/arm/sme: Introduce aarch64_set_svcr()
Date: Wed, 27 Aug 2025 20:03:40 +0300
Message-ID: <20250827170356.2698446-5-mjt@tls.msk.ru>
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
Message-id: 20230112102436.1913-4-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2a8af3825958e5d8c98b3ca92ac42a10e25db9e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 9875d609a9..d53742e10b 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -93,8 +93,8 @@ void cpu_loop(CPUARMState *env)
              * On syscall, PSTATE.ZA is preserved, along with the ZA matrix.
              * PSTATE.SM is cleared, per SMSTOP, which does ResetSVEState.
              */
+            aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
             if (FIELD_EX64(env->svcr, SVCR, SM)) {
-                env->svcr = FIELD_DP64(env->svcr, SVCR, SM, 0);
                 arm_rebuild_hflags(env);
                 arm_reset_sve_state(env);
             }
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 6a2c6e06d2..b6e4dcb494 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -669,11 +669,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
      * Invoke the signal handler with both SM and ZA disabled.
      * When clearing SM, ResetSVEState, per SMSTOP.
      */
+    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
     if (FIELD_EX64(env->svcr, SVCR, SM)) {
         arm_reset_sve_state(env);
     }
     if (env->svcr) {
-        env->svcr = 0;
         arm_rebuild_hflags(env);
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 32b0bf8e2d..8acfd3af4c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1118,6 +1118,7 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask);
 void arm_reset_sve_state(CPUARMState *env);
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6cffbcb276..86b97daf7e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6429,11 +6429,19 @@ static CPAccessResult access_esm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
+{
+    uint64_t change = (env->svcr ^ new) & mask;
+
+    env->svcr ^= change;
+}
+
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
     helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
     helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
+    aarch64_set_svcr(env, value, -1);
     arm_rebuild_hflags(env);
 }
 
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 8ba3f3a247..7717dab64f 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -43,7 +43,7 @@ void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
     if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
         return;
     }
-    env->svcr ^= R_SVCR_SM_MASK;
+    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
     arm_reset_sve_state(env);
     arm_rebuild_hflags(env);
 }
@@ -53,7 +53,7 @@ void helper_set_pstate_za(CPUARMState *env, uint32_t i)
     if (i == FIELD_EX64(env->svcr, SVCR, ZA)) {
         return;
     }
-    env->svcr ^= R_SVCR_ZA_MASK;
+    aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
 
     /*
      * ResetSMEState.
-- 
2.47.2


