Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A364F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE0-0001Aj-CZ; Wed, 22 Apr 2026 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDv-00017I-JU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDt-00018C-Kt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso56315825e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862952; x=1777467752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
 b=JQlBh8ik7WSE/At3PrBiwZelzKLFv4fDsulauOg5HKq+HUZXz1yxoHvOAIhCJi9zcG
 ikGOObtBtXrk9Qy26KWCsGsekTJMnoytnq+PD//2B5W5QF9haX3oGN0PYu/MxlQyK6Jn
 GfEku76SVcxmck/0t7bLP4PKEI27vUOvOnyzHohUhi0TtlyEBW+BNKeY0YmTqfvDM1Xg
 YOjdU+KXaS5VNvcLU4iI9nBDQicAgCFddPcKJNjPNQf8QW/9V8NePXUFneYxtr8+N58m
 CLpt4jcPbEgOIZSbDE13YHeLoQsgD92nFxdQHZt8qp6RzZnuAzfT4xwskKkEJuI6vfiZ
 joEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862952; x=1777467752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ChBMLZB7W3RWggGvPxQhi9T29Aee3H3wmNETcHJ/8uM=;
 b=JNGoyTw4GAqBNphn4GBwBFwZfSxDzUkxgBqHgIZu5YF2XaMcJ/sKnFsiYJqOrokyZ9
 mEXGvlUBfXTNB/5ltOIWzKfF+KcqdlAg0EyNceaUtWN5xOQjC8xlAPb6dVvlxzMsv39H
 5WPF6K36nKK7x9CY0gfhzCaBJLRPcCACUyp47cU7u+L/cfLeRiMqHJZKE6tsxki8NiSE
 QCe+sAMBwGHmhNZIkof2f0/Mj8vl7sUnKZLHxko/B//U2VhPYui/TylGXTfqeWi2CFKD
 Zo1iA8f3taCmxJ2DtuEYNKk7HMAlJA7/ZU9Ne5NBZD9yFSzrOGj5BKbIe5W83ZUPB3tG
 xoXw==
X-Gm-Message-State: AOJu0YwqZjcmtS4SAsmqhau9rtHbk+4Tr0ejoXp+/TuOKVf9v3Xi9jYG
 tG/4a3ZRlXA1oJx++dcwJLuT4mlJUxRSsp8umkSZjDXUwRpSRKTwtqgw+bYchQKtMTM=
X-Gm-Gg: AeBDiet9t1xbgix2kxbqFD1RuH7BYodDlrnRdcpy25oHiXEbW3SIDtv4sinRs0h8YeP
 vl/IBhBMWP+VZGJUS1Xg952IkE25yM4y8jYnK4D0S1oRxR6nm1Bqbr8Fh76zTCJLZRvTVyHLVP4
 3qa3vJKQKh413FYGOP1V01myzU0A1WLeLQ7g3JDDp6WsuMeuSHJ/z1xXneDlZH+US8NrOn1Tfhm
 RJcF/bukqqoXeEpN3eOBydrTjkhwP+juNvSYchERlMTiFZnWU09o5uVKOsALbEG7cVFheWERSPu
 so0u0kWBiFv6FPNAl68yh45oczJW0LmkvAFNOqRU3QWFqRq8qS1Vh1czUpJiv6aMiupnFwa7kFQ
 nFzo3yX8u9QdBCq/hz1wYgAEz4wg7aub3kg78SDkOeKO4klo9zrVqTiMtr4dYJLNHgvYdjgvdI9
 2c8HNm7HZKscPINu8ICVSw2LIQBLRDUe3LQAJtW0oPggr4
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48a55743e96mr105271025e9.7.1776862951984; 
 Wed, 22 Apr 2026 06:02:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm96183315e9.2.2026.04.22.06.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 753D3617C4;
 Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 30/32] target/arm: enable event stream on WFE instructions
Date: Wed, 22 Apr 2026 13:52:47 +0100
Message-ID: <20260422125250.1303100-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Two generic timers (K and H) are capable of generating timer event
stream events. Provide a helper to calculate when the nearest one will
happen.

Now we can calculate when the next event stream event is we can re-use
the wfxt_timer and configure it to fire as we enter a WFE that is
going to sleep. Reverse the M-profile logic so we can enter a sleep
state in both profiles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - merged target/arm: add gt_calc_next_event_stream
  - update to use halt_reason
  - made arm_wfxt_timer_cb atomically consume halt_reason
---
 target/arm/cpu.c           |  13 ++++
 target/arm/tcg/op_helper.c | 129 +++++++++++++++++++++++++++++++------
 2 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 124be8c401e..7a6ad45ae08 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -799,10 +799,23 @@ bool arm_cpu_exec_halt(CPUState *cs)
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
index 6a2be85fcaa..030209360e8 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -477,6 +477,97 @@ void HELPER(sev)(CPUARMState *env)
     arm_broadcast_event();
 }
 
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
 void HELPER(wfe)(CPUARMState *env)
 {
 #ifdef CONFIG_USER_ONLY
@@ -489,32 +580,30 @@ void HELPER(wfe)(CPUARMState *env)
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
+    ARMCPU *cpu = ARM_CPU(cs);
 
-        if (env->event_register) {
-            env->event_register = false;
-            return;
-        }
+    if (env->event_register) {
+        env->event_register = false;
+        return;
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
+    /* For A-profile we also can be woken by the event stream */
+    if (arm_feature(env, ARM_FEATURE_AARCH64) && cpu->wfxt_timer) {
+        int64_t next_event = gt_calc_next_event_stream(env);
+        if (next_event > 0) {
+            timer_mod(cpu->wfxt_timer, next_event);
+        }
     }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
 #endif
 }
 
-- 
2.47.3


