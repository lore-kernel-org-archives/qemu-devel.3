Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F024BCDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtD-0002tn-Jl; Wed, 24 Jun 2026 06:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsm-0002a9-LI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsi-0007hg-C9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso670609f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297054; x=1782901854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDry7jb2dPo9olFf9Nnv4hC92PCKHG9roJXwQDrkWTo=;
 b=jzej/9SvsLUf2rAyI9HOUePzhT9iQMbSjuHq2+e37ToQIxBptcmhVF5NgncRT4sjiR
 cq5p6sQ2KeRQXFUDBEN3MFMuFrQz0CKvBrRNOHdq9uzvAbGpLZujWcmM7c6AFrtFV8Bc
 ExHKLqTFGdEKg2V1ohdUdFkAbBTsoYvTl8R4TEeOLfQ75s1IIJL9ZUpkxNy9cZMz1pLq
 ARTzZ1ZoC/ON5pr7rmObPrXFbPb2fCQRomgXHeWgNUSTWbZU9B5CEetmTw0d97+hwxuc
 5rFia7mfgouYKgSGxEiqCrs6S8mVHhDNVHyZePVLjiyO6OC/natXviWqg/uCn1Rkz72K
 ahzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297054; x=1782901854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vDry7jb2dPo9olFf9Nnv4hC92PCKHG9roJXwQDrkWTo=;
 b=Flb3sccFb+gtsAPOUWFeW++fUnKdyoAAaEjug/dyccbQ3CcOdI0zlsyJ6GimkPWzSU
 g9ZwHDrKKghgEABDPp9hyOlcevLdfQMr4VWrrsTKsjhLhbpuuWpfzWleoxqp+rKlm3rk
 cikJfb6ykdrM88KyeEqpmNrTepUe0fNGc8+DJN2cAF0CzL50eH0WY8emC6Otg+XB5hL0
 yOGnwswELWZBdZ3ldgbm/Khy/yw8lzGdIhQppsoA/NUTCFAMTDJiq5O/EybJVv0zPxYx
 wCM4yCLhahf+FDIIISyx19RTYEJ72snAJ1uJgRXtPbOhd/Hyg3KBfyklJ5nH0CQyMIt/
 /sCQ==
X-Gm-Message-State: AOJu0Yx/ZgNIoabiwEuWnidsBUPZLLlCoKP/tyu0XIYvHW3g4VmbMzJa
 czp9xbYlltXRNRrhbyBnKMcuelHLuMcw4FXnobZvcaHIkoH+aYoTPYPLBbY9HBbTcCs=
X-Gm-Gg: AfdE7clk6ze8SjQOsp0mvXVua/HL5AxPnROPYxJ6aZhYEOliozmJ5b5HFdyptM3BORt
 9TmCRmgGah6oNGksJTU4x+CaWu3+0c5dU4iJgsMFHGXUBtP/CfEyJrZfgJYm1mwmFSm5BwA+APj
 19UVKQ/uBieGMFOKkAcUwYFZJsz/k7Ky7N4ipm4Gcocdg8P4t932lEoGz8UaRzn/+PEhOaKkgjJ
 e2TW0CF4MakYtUWVHkrz8VeEDeZWzRvxgoWVH+2UMLGCGp2HFAawk91kuc++pLKunHDxMA2WZLa
 pnwYZZQ3sBYgZZCA4Y5AjGTQVvL8gvsbK43r4sGLR4YqOFVgm+6g7xPZp7wxy4HaHC5TvrMQuW0
 tsgUNPk3b1rjrN1EUgH08nAf5JP5F23p7coSTqMsTZTasPQbrw1FBo1mUSl6UY6UeIfXFlwrDPF
 dNeZDPs5LWcCne
X-Received: by 2002:a05:6000:22c5:b0:460:71e6:e11 with SMTP id
 ffacd0b85a97d-46c0b3e3bb3mr4577108f8f.24.1782297054018; 
 Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1eef84d7sm6047588f8f.16.2026.06.24.03.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56C8E5FA60;
 Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
Date: Wed, 24 Jun 2026 11:30:48 +0100
Message-ID: <20260624103049.884930-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To enable full architectural behaviour for A-profile we need to do a
number of things:

  - add support for the event stream to wake things up
  - add support for potential trap on sleep
  - handle the global monitor's interactions with WFE
  - remove the M-profile specific gates

Event stream
------------

Two generic timers (K and H) are capable of generating timer event
stream events. Provide a helper to calculate when the nearest one will
happen.

Now we can calculate when the next event stream event is we can re-use
the wfxt_timer and configure it to fire as we enter a WFE that is
going to sleep. Reverse the M-profile logic so we can enter a sleep
state in both profiles.

We also take care to use atomics for accessing env->event_register as
we now have potential access outside the vCPU context.

Traps
-----

A-profile can trap WFE's *if* the instruction would otherwise sleep.
To do this we need to pass the instruction size so we can deal with
the is_16bit syndrome encoding.

Global Monitor
--------------

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - merged target/arm: add gt_calc_next_event_stream
  - update to use halt_reason
  - made arm_wfxt_timer_cb atomically consume halt_reason
v4
  - skip sleep if in the exclusive region
  - update commit message
  - remove the CF_PARALLEL guards so we work in smp
v5
  - use env_archcpu for ARMCPU rather then expensive QOM cast
  - rely on cpu->wfxt_timer to guard event stream leg
v6
  - use atomic_xchg to consume event_register
  - remove extraneous target_el calculation
  - defer calculating target_el until after the early return
v7
  - merged with trap patch
  - rewrite commit message
---
 target/arm/tcg/helper-defs.h   |   2 +-
 target/arm/cpu.c               |  13 +++
 target/arm/tcg/op_helper.c     | 156 ++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  12 +--
 target/arm/tcg/translate.c     |  18 +---
 5 files changed, 156 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 8ec6c163195..99ebd754942 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -54,7 +54,7 @@ DEF_HELPER_2(exception_swstep, noreturn, env, i32)
 DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4b49f8c43ec..b3de399f40c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,10 +883,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
 }
 #endif
 
+/*
+ * Unlike almost everything else that messes with the halt_reason and
+ * event_register details the timer callbacks are not in the vCPU
+ * context.
+ *
+ * To prevent races we atomically consume a HALT_WFE and set the event
+ * register. Either way we trigger the an exit event.
+ */
 static void arm_wfxt_timer_cb(void *opaque)
 {
     ARMCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
+    CPUARMState *env = &cpu->env;
+
+    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
+        qatomic_set(&env->event_register, true);
+    }
 
     /*
      * We expect the CPU to be halted; this will cause arm_cpu_is_work()
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index d15062e155f..3321e29898d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -484,7 +484,98 @@ void HELPER(sev)(CPUARMState *env)
     }
 }
 
-void HELPER(wfe)(CPUARMState *env)
+#ifndef CONFIG_USER_ONLY
+/*
+ * Event Stream events don't do anything apart from wake up sleeping
+ * cores. These helpers calculate the next event stream event time so
+ * the WFE helper can decide when its next wake up tick will be.
+ */
+static int64_t gt_recalc_one_evt(CPUARMState *env, uint32_t control, uint64_t offset)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    bool evnten = FIELD_EX32(control, CNTxCTL, EVNTEN);
+
+    if (evnten) {
+        int evnti = FIELD_EX32(control, CNTxCTL, EVNTI);
+        bool evntis = FIELD_EX32(control, CNTxCTL, EVNTIS);
+        bool evntdir = FIELD_EX32(control, CNTxCTL, EVNTDIR);
+        /*
+         * To figure out when the next event timer should fire we need
+         * to calculate which bit of the counter we want to flip and
+         * which transition counts.
+         *
+         * So we calculate 1 << bit - current lower bits and then add
+         * 1 << bit if the bit needs to flip twice to meet evntdir
+         */
+        int bit = evntis ? evnti + 8 : evnti;
+        uint64_t count = gt_get_countervalue(env) - offset;
+        uint64_t target_bit = BIT_ULL(bit);
+        uint64_t lower_bits = MAKE_64BIT_MASK(0, bit - 1);
+        uint64_t next_tick = target_bit - (count & lower_bits);
+        uint64_t abstick;
+
+        /* do we need to bit flip twice? */
+        if (((count & target_bit) != 0) ^ evntdir) {
+            next_tick += target_bit;
+        }
+
+        /*
+         * Note that the desired next expiry time might be beyond the
+         * signed-64-bit range of a QEMUTimer -- in this case we just
+         * set the timer for as far in the future as possible. When the
+         * timer expires we will reset the timer for any remaining period.
+         */
+        if (uadd64_overflow(next_tick, offset, &abstick)) {
+            abstick = UINT64_MAX;
+        }
+        if (abstick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+            return INT64_MAX;
+        } else {
+            return abstick;
+        }
+    }
+
+    return -1;
+}
+
+/*
+ * Calculate the next event stream time and return it. Returns -1 if
+ * no event streams are enabled. It is up to the WFE helpers to decide
+ * on the next time.
+ */
+static int64_t gt_calc_next_event_stream(CPUARMState *env)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    int64_t next_time = -1;
+    uint64_t offset;
+
+    /* Unless we are missing EL2 this can generate events */
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+        next_time = gt_recalc_one_evt(env, env->cp15.cnthctl_el2, offset);
+    }
+
+    /* Event stream events from virtual counter enabled? */
+    if (!cpu_isar_feature(aa64_vh, cpu) ||
+        !((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE))) {
+        int64_t next_virt_time;
+        offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+        next_virt_time = gt_recalc_one_evt(env, env->cp15.c14_cntkctl, offset);
+
+        /* is this earlier than the next physical event? */
+        if (next_virt_time > 0) {
+            if (next_time < 0 || next_virt_time < next_time) {
+                next_time = next_virt_time;
+            }
+        }
+    }
+
+    return next_time;
+}
+#endif
+
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -496,32 +587,57 @@ void HELPER(wfe)(CPUARMState *env)
 #else
     /*
      * WFE (Wait For Event) is a hint instruction.
-     * For Cortex-M (M-profile), we implement the strict architectural behavior:
+     *
      * 1. Check the Event Register (set by SEV or SEVONPEND).
      * 2. If set, clear it and continue (consume the event).
      */
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        CPUState *cs = env_cpu(env);
+    CPUState *cs = env_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
+    uint32_t excp;
+    int target_el;
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
+    if (qatomic_xchg(&env->event_register, false)) {
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
         }
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFE, insn_len == 2),
+                        target_el);
+    }
 
-        env->halt_reason = HALT_WFE;
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
+    /*
+     * If the CPU has entered the exclusive region we could sleep
+     * until the global monitor moves from Exclusive to Open Access.
+     * However it would be expensive for QEMU to fully model the
+     * global monitor and not doing so would potentially trigger
+     * deadlocks in WFE enabled locking code. However as WFE is a hint
+     * instruction the architecture allows for the PE to leave
+     * low-power state for any reason. QEMU chooses to treat being in
+     * an exclusive region as such and return directly.
+     */
+    if (env->exclusive_addr != -1) {
+        return;
     }
+
+    /* For A-profile we also can be woken by the event stream */
+    if (cpu->wfxt_timer) {
+        int64_t next_event = gt_calc_next_event_stream(env);
+        if (next_event > 0) {
+            timer_mod(cpu->wfxt_timer, next_event);
+        }
+    }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index df5bac22acd..b45aac6d269 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2161,15 +2161,7 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
-    /*
-     * When running in MTTCG we don't generate jumps to the yield and
-     * WFE helpers as it won't affect the scheduling of other vCPUs.
-     * If we wanted to more completely model WFE/SEV so we don't busy
-     * spin unnecessarily we would need to do something more involved.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        s->base.is_jmp = DISAS_WFE;
-    }
+    s->base.is_jmp = DISAS_WFE;
     return true;
 }
 
@@ -11232,7 +11224,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9079458a297..a1fc0506188 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3273,19 +3273,9 @@ static bool trans_SEVL(DisasContext *s, arg_SEV *a)
 
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
-    /*
-     * When running single-threaded TCG code, use the helper to ensure that
-     * the next round-robin scheduled vCPU gets a crack.
-     *
-     * For Cortex-M, we implement the architectural WFE behavior (sleeping
-     * until an event occurs or the Event Register is set).
-     * For other profiles, we currently treat this as a NOP or yield,
-     * to preserve existing performance characteristics.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        gen_update_pc(s, curr_insn_len(s));
-        s->base.is_jmp = DISAS_WFE;
-    }
+    /* For WFE, halt the vCPU until an event. */
+    gen_update_pc(s, curr_insn_len(s));
+    s->base.is_jmp = DISAS_WFE;
     return true;
 }
 
@@ -6857,7 +6847,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
-- 
2.47.3


