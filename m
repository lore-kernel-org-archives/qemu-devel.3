Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166DCCFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMct0-0007h4-3F; Fri, 21 Nov 2025 20:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbpT-00036Z-PE; Fri, 21 Nov 2025 19:50:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbnR-0008KF-7M; Fri, 21 Nov 2025 19:50:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C3F716CA5B;
 Fri, 21 Nov 2025 21:44:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC2DB321C97;
 Fri, 21 Nov 2025 21:44:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 32/81] target/microblaze: div: Break out
 raise_divzero()
Date: Fri, 21 Nov 2025 21:43:31 +0300
Message-ID: <20251121184424.1137669-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
index 85ba8c9b89..0e9b725c1b 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -70,38 +70,36 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
+/* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
+static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
-    if (unlikely(b == 0)) {
-        env->msr |= MSR_DZ;
+    env->msr |= MSR_DZ;
 
-        if ((env->msr & MSR_EE) &&
-            env_archcpu(env)->cfg.div_zero_exception) {
-            CPUState *cs = env_cpu(env);
+    if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
+        CPUState *cs = env_cpu(env);
 
-            env->esr = ESR_EC_DIVZERO;
-            cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, ra);
-        }
-        return false;
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
index b54e5ac4b2..88904fc728 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -467,16 +467,8 @@ DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
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


