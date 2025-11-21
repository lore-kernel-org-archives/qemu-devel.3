Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FB5CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8u-0006Oy-Ge; Fri, 21 Nov 2025 21:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd7c-00055l-DE; Fri, 21 Nov 2025 21:13:08 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd6y-0004XE-6y; Fri, 21 Nov 2025 21:13:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66D1F16C6F6;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BEB9F321993;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 30/76] target/microblaze: div: Break out
 raise_divzero()
Date: Fri, 21 Nov 2025 16:51:08 +0300
Message-ID: <20251121135201.1114964-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Break out raise_divzero() and take the opportunity to rename
and reorder function args to better match with spec and
pseudo code.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 0e46b4d1f13b26c3c0e30eafa2be8eed76548bd3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 470526ee92..fbc9c8ca4f 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,38 +69,36 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
+/* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
+static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
-    if (unlikely(b == 0)) {
-        env->msr |= MSR_DZ;
-
-        if ((env->msr & MSR_EE) &&
-            env_archcpu(env)->cfg.div_zero_exception) {
-            CPUState *cs = env_cpu(env);
-
-            env->esr = ESR_EC_DIVZERO;
-            cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, ra);
-        }
-        return false;
+    env->msr |= MSR_DZ;
+
+    if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
+        CPUState *cs = env_cpu(env);
+
+        env->esr = esr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, unwind_pc);
     }
-    return true;
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return (int32_t)a / (int32_t)b;
+    return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return a / b;
+    return rb / ra;
 }
 
 /* raise FPU exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5098a1db4d..2f5fd5c271 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -450,16 +450,8 @@ DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
 DO_TYPEA0_CFG(fsqrt, use_fpu >= 2, true, gen_fsqrt)
 
-/* Does not use ENV_WRAPPER3, because arguments are swapped as well. */
-static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divs(out, tcg_env, inb, ina);
-}
-
-static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divu(out, tcg_env, inb, ina);
-}
+ENV_WRAPPER3(gen_idiv, gen_helper_divs)
+ENV_WRAPPER3(gen_idivu, gen_helper_divu)
 
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
-- 
2.47.3


