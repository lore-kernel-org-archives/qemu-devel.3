Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5703E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurFk-0005h4-8S; Tue, 24 Feb 2026 07:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFJ-0005aR-B9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:34 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vurFG-0005tH-Ju
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:10:32 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65a40f3f048so10057571a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771935021; x=1772539821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdm/FWJYafm9q16YplQfONC7aZ1Ud4UCye6jBHBX6zg=;
 b=FW6NUDS6QM0b0x1/xPGux5nI4/l7zolm44WoSHD6jHNEnpFMGNka1UcbLmW7SrG4ne
 6pvzjyVVRRFMFo7fHzKDUJeHV0P7lXXho2kN9tqSYafFHxZhnqotBBQffCxzXVxQ4LhA
 TEnH2g1OPZ4GGd+29xsDrFxQl52VG+xcFmKS0kYetzQRwCVakU6PMLnYHXZ3oIem7nOp
 8/h5FK3HtA6s31Euh4G03ASFTlcwpZXUg7VWJM1CIlZ8izbt4VaC56XWo1Bv71TIk/3s
 NRgWsvDZy3Gkcd1TfBfqaJEav1yLa1J5MmAfZOpgO0UrRUyPBq2SryTpAmnl0rWT2Q4y
 Pj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771935021; x=1772539821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdm/FWJYafm9q16YplQfONC7aZ1Ud4UCye6jBHBX6zg=;
 b=rXkrjexXoZyngcv77WSCXSzNauKbxmNdSu9dC8F0O+BF2RntvcWnQxFDmp+4CWs1eq
 P8IsSb3n8sB6zScxa0odllI78wO6bgOuHcdl6ncF+evabd3IEML99NvVXWhx6VRQNtBs
 DwmaEWpcVl13Q9YW39mFZ8rjIYcPvDfrkbZRGwgLAhRNhOBhW9/E81/C95JqQwt2lSS+
 fYFcWOUOaqggCbX8aGAGtDOb5kyqS6M8SrXbu6zbtGVL9fgNUtYmufcKRDV5DqjZXSTw
 9h5GoUruqKT7VkZUyXON98MBloh2V20Y4hv0+EcO+FlXlfVmFhmwUFNf6jPKaBSaNwSF
 Ke6w==
X-Gm-Message-State: AOJu0YwfJipkdH8DB6chVpwKnlOPY3o7vB5jbURidHKfyE9h3e608mrM
 TLrSD/eW3bnZe8j2fkuVBlRQMvpcakHeEkMAAQGBb1OeTGrqMDyqE4LDo1l3AKfU7rg=
X-Gm-Gg: ATEYQzwkwqGnxe7YGyrKHOVWbIyY5R/5UieF1G5VxOl2kULXeOJWlU6zeoIqOXt4yYW
 rlrSmAhX1JRqSlyxk7fINQJp16nKvDUi1qtyAOeuYaJ3JbUScW+K1oH6+tpwe2aJlGCksqWP+h5
 zDH4AIOTB5YEGPWs+czMlwE14TclfZji9m9qEolhSjmh29ucZNcwpbJ8XdLYqglEY1Ea5wLGMGL
 JRsmO7pZmP4clw7HelJ/WIlbKxfMHF/hYuOENLg2Wwe6By87fYS5juCbzO3aOulVOYS7moBuDR4
 V4HJUStaJE1PlRlNOXzjMnhzYYUyPWS/arRzNQRtbWkFytMHlmyUeBhZ6e4gedb14rXC/X/4lr7
 0pqOwgoe2/Zg/tQPIqMnU7zk4/Ei49z5USp2KE556MynJRbdb7UQxawlH/eogmyv5XmNHNZMJTc
 YNEGd7c9KZlTMJiR7C9QwnTScAal3TBKIQPA==
X-Received: by 2002:a05:6402:399b:b0:65b:bd9d:731a with SMTP id
 4fb4d7f45d1cf-65ea4ec7eebmr5431890a12.13.1771935021335; 
 Tue, 24 Feb 2026 04:10:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eaba3f967sm3618611a12.31.2026.02.24.04.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 04:10:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EE9D5F8D3;
 Tue, 24 Feb 2026 12:10:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 eca <noreply@eca.dev>
Subject: [PATCH 5/8] target/arm: extend WFX support for A-profile
Date: Tue, 24 Feb 2026 12:10:11 +0000
Message-ID: <20260224121014.279248-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224121014.279248-1-alex.bennee@linaro.org>
References: <20260224121014.279248-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit extends support for WFI, WFE, WFIT, and WFET instructions
for A-profile ARM CPUs, ensuring proper architectural semantics and
full ISS (Instruction Specific Syndrome) field support for traps.

Key changes:
- Update `syn_wfx` in `target/arm/syndrome.h` to include `RN` (register
  number) and `RV` (register valid) fields using `registerfields.h`
  macros.
- Refactor `HELPER(wfi)` and `HELPER(wfit)` to use correct AArch64
  syndrome values (CV=0, COND=0xf).
- Implement `HELPER(wfet)` and update `trans_WFET` to support the new
  Wait For Event with Timeout instruction.
- Update `HELPER(wfe)` to implement proper A-profile semantics,
  including trap checks and event register handling.
- Extend `event_register` handling to all ARM CPUs (not just M-profile)
  by updating `HELPER(sev)` and `arm_cpu_has_work`.
- Declare WFxT helpers as `TCG_CALL_NO_WG` as they can raise
  exceptions.

🤖 Generated with [eca](https://eca.dev)

Co-Authored-By: eca <noreply@eca.dev>

---
ajb
  - this commit is a bit big, it didn't follow the instructions to
  keep the commits small
  - I had to add DEF_HELPER_FLAGS_3 to the helpers as it didn't
  realise we need to ensure rd is potentially rectified.
---
 target/arm/syndrome.h          |  24 ++++++--
 target/arm/tcg/helper-defs.h   |   3 +-
 target/arm/cpu.c               |   6 +-
 target/arm/tcg/op_helper.c     | 101 +++++++++++++++++++++++----------
 target/arm/tcg/translate-a64.c |  17 +++---
 5 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bff61f052cc..49861758262 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -26,6 +26,7 @@
 #define TARGET_ARM_SYNDROME_H
 
 #include "qemu/bitops.h"
+#include "hw/core/registerfields.h"
 
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
@@ -352,11 +353,26 @@ static inline uint32_t syn_breakpoint(int same_el)
         | ARM_EL_IL | 0x22;
 }
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 14, 1)
+FIELD(WFX_ISS, RN, 15, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
+static inline uint32_t syn_wfx(int cv, int cond, int rd, int rv, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = (EC_WFX_TRAP << ARM_EL_EC_SHIFT);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, RN, rd);
+    res = FIELD_DP32(res, WFX_ISS, RV, rv);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    if (!is_16bit) {
+        res |= ARM_EL_IL;
+    }
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 5a10a9fba3b..d54eb63eef6 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -55,7 +55,8 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
-DEF_HELPER_2(wfit, void, env, i64)
+DEF_HELPER_FLAGS_3(wfit, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_3(wfet, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10f8280eef2..bc789515af9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,10 +144,8 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        if (cpu->env.event_register) {
-            return true;
-        }
+    if (cpu->env.event_register) {
+        return true;
     }
 
     return (cpu->power_state != PSCI_OFF)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..37538daea74 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -393,13 +393,17 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     if (target_el) {
-        if (env->aarch64) {
+        int cv = 1, cond = 0xe;
+
+        if (is_a64(env)) {
             env->pc -= insn_len;
+            cv = 0;
+            cond = 0xf;
         } else {
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(cv, cond, 0, 0, 0, insn_len == 2),
                         target_el);
     }
 
@@ -409,7 +413,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
-void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
+void HELPER(wfit)(CPUARMState *env, uint64_t timeout, uint32_t rd)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -448,7 +452,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
+        raise_exception(env, excp, syn_wfx(0, 0xf, rd, 1, 2, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
@@ -469,14 +473,50 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #endif
 }
 
+void HELPER(wfet)(CPUARMState *env, uint64_t timeout, uint32_t rd)
+{
+#ifdef CONFIG_USER_ONLY
+    return;
+#else
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, true, &excp);
+    uint64_t cntval = gt_get_countervalue(env);
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    uint64_t cntvct = cntval - offset;
+    uint64_t nexttick;
+
+    if (env->event_register || cpu_has_work(cs) || cntvct >= timeout) {
+        env->event_register = false;
+        return;
+    }
+
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, excp, syn_wfx(0, 0xf, rd, 1, 3, false), target_el);
+    }
+
+    if (uadd64_overflow(timeout, offset, &nexttick)) {
+        nexttick = UINT64_MAX;
+    }
+    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+        timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
+    } else {
+        timer_mod(cpu->wfxt_timer, nexttick);
+    }
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+#endif
+}
+
 void HELPER(sev)(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register = true;
-        }
+        target_cpu->env.event_register = true;
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
         }
@@ -493,33 +533,34 @@ void HELPER(wfe)(CPUARMState *env)
      */
     return;
 #else
-    /*
-     * WFE (Wait For Event) is a hint instruction.
-     * For Cortex-M (M-profile), we implement the strict architectural behavior:
-     * 1. Check the Event Register (set by SEV or SEVONPEND).
-     * 2. If set, clear it and continue (consume the event).
-     */
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        CPUState *cs = env_cpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, true, &excp);
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
+    if (env->event_register) {
+        env->event_register = false;
+        return;
+    }
+
+    if (target_el) {
+        bool is_16bit = false;
+        if (is_a64(env)) {
+            env->pc -= 4;
+        } else {
+            is_16bit = env->thumb;
+            env->regs[15] -= (is_16bit ? 2 : 4);
         }
 
-        cs->exception_index = EXCP_HLT;
-        cs->halted = 1;
-        cpu_loop_exit(cs);
-    } else {
-        /*
-         * For A-profile and others, we rely on the existing "yield" behavior.
-         * Don't actually halt the CPU, just yield back to top
-         * level loop. This is not going into a "low power state"
-         * (ie halting until some event occurs), so we never take
-         * a configurable trap to a different exception level
-         */
-        HELPER(yield)(env);
+        raise_exception(env, excp,
+                        syn_wfx(is_a64(env) ? 0 : 1,
+                                is_a64(env) ? 0xf : 0xe,
+                                0, 0, 1, is_16bit),
+                        target_el);
     }
+
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..f76a00d1329 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2064,7 +2064,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *a)
     }
 
     gen_a64_update_pc(s, 4);
-    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
+    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd), tcg_constant_i32(a->rd));
     /* Go back to the main loop to check for interrupts */
     s->base.is_jmp = DISAS_EXIT;
     return true;
@@ -2076,14 +2076,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
         return false;
     }
 
-    /*
-     * We rely here on our WFE implementation being a NOP, so we
-     * don't need to do anything different to handle the WFET timeout
-     * from what trans_WFE does.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        s->base.is_jmp = DISAS_WFE;
+    if (s->ss_active) {
+        /* Act like a NOP under architectural singlestep */
+        return true;
     }
+
+    gen_a64_update_pc(s, 4);
+    gen_helper_wfet(tcg_env, cpu_reg(s, a->rd), tcg_constant_i32(a->rd));
+    /* Go back to the main loop to check for interrupts */
+    s->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
-- 
2.47.3


