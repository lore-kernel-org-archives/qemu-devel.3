Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVu3-0008LF-FV; Thu, 18 Apr 2024 13:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtp-0008Gg-Nj; Thu, 18 Apr 2024 13:50:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVtn-0007Xl-E6; Thu, 18 Apr 2024 13:50:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F0595FD68;
 Thu, 18 Apr 2024 20:50:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BF3BCB933E;
 Thu, 18 Apr 2024 20:49:58 +0300 (MSK)
Received: (nullmailer pid 947827 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keith Packard <keithp@keithp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 095/116] target/m68k: Map FPU exceptions to FPSR
 register
Date: Thu, 18 Apr 2024 20:49:25 +0300
Message-Id: <20240418174955.947730-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Keith Packard <keithp@keithp.com>

Add helpers for reading/writing the 68881 FPSR register so that
changes in floating point exception state can be seen by the
application.

Call these helpers in pre_load/post_load hooks to synchronize
exception state.

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230803035231.429697-1-keithp@keithp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 5888357942da1fd5a50efb6e4a6af8b1a27a5af8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 11c7e0a790..d95deaafcd 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -396,12 +396,19 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
-static int fpu_post_load(void *opaque, int version)
+static int fpu_pre_save(void *opaque)
 {
     M68kCPU *s = opaque;
 
-    cpu_m68k_restore_fp_status(&s->env);
+    s->env.fpsr = cpu_m68k_get_fpsr(&s->env);
+    return 0;
+}
+
+static int fpu_post_load(void *opaque, int version)
+{
+    M68kCPU *s = opaque;
 
+    cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
 
@@ -410,6 +417,7 @@ const VMStateDescription vmmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
+    .pre_save = fpu_pre_save,
     .post_load = fpu_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 6cfc696d2b..4d78da9d5f 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -199,7 +199,8 @@ void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
 void cpu_m68k_restore_fp_status(CPUM68KState *env);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
-
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env);
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val);
 
 /*
  * Instead of computing the condition codes after each m68k instruction,
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index ab120b5f59..8314791f50 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -164,6 +164,78 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
 }
 
+/* Convert host exception flags to cpu_m68k form.  */
+static int cpu_m68k_exceptbits_from_host(int host_bits)
+{
+    int target_bits = 0;
+
+    if (host_bits & float_flag_invalid) {
+        target_bits |= 0x80;
+    }
+    if (host_bits & float_flag_overflow) {
+        target_bits |= 0x40;
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
+        target_bits |= 0x20;
+    }
+    if (host_bits & float_flag_divbyzero) {
+        target_bits |= 0x10;
+    }
+    if (host_bits & float_flag_inexact) {
+        target_bits |= 0x08;
+    }
+    return target_bits;
+}
+
+/* Convert cpu_m68k exception flags to target form.  */
+static int cpu_m68k_exceptbits_to_host(int target_bits)
+{
+    int host_bits = 0;
+
+    if (target_bits & 0x80) {
+        host_bits |= float_flag_invalid;
+    }
+    if (target_bits & 0x40) {
+        host_bits |= float_flag_overflow;
+    }
+    if (target_bits & 0x20) {
+        host_bits |= float_flag_underflow;
+    }
+    if (target_bits & 0x10) {
+        host_bits |= float_flag_divbyzero;
+    }
+    if (target_bits & 0x08) {
+        host_bits |= float_flag_inexact;
+    }
+    return host_bits;
+}
+
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
+{
+    int host_flags = get_float_exception_flags(&env->fp_status);
+    int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
+    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    return except;
+}
+
+uint32_t HELPER(get_fpsr)(CPUM68KState *env)
+{
+    return cpu_m68k_get_fpsr(env);
+}
+
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val)
+{
+    env->fpsr = val;
+
+    int host_flags = cpu_m68k_exceptbits_to_host((int) env->fpsr);
+    set_float_exception_flags(host_flags, &env->fp_status);
+}
+
+void HELPER(set_fpsr)(CPUM68KState *env, uint32_t val)
+{
+    cpu_m68k_set_fpsr(env, val);
+}
+
 #define PREC_BEGIN(prec)                                        \
     do {                                                        \
         FloatX80RoundPrec old =                                 \
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 0a1544cd68..beab4b96bc 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -118,7 +118,7 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
     case 8: /* fpcontrol */
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, env->fpsr);
+        return gdb_get_reg32(mem_buf, cpu_m68k_get_fpsr(env));
     case 10: /* fpiar, not implemented */
         return gdb_get_reg32(mem_buf, 0);
     }
@@ -137,7 +137,7 @@ static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
         cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 2bbe0dc032..95aa5e53bb 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,6 +54,8 @@ DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
+DEF_HELPER_2(set_fpsr, void, env, i32)
+DEF_HELPER_1(get_fpsr, i32, env)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4a0b0b2703..f8eeb70379 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4686,7 +4686,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
         tcg_gen_movi_i32(res, 0);
         break;
     case M68K_FPSR:
-        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_get_fpsr(res, tcg_env);
         break;
     case M68K_FPCR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpcr));
@@ -4700,7 +4700,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
     case M68K_FPIAR:
         break;
     case M68K_FPSR:
-        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_set_fpsr(tcg_env, val);
         break;
     case M68K_FPCR:
         gen_helper_set_fpcr(tcg_env, val);
-- 
2.39.2


