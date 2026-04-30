Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2855CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt7-0008Mf-PQ; Thu, 30 Apr 2026 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsz-0008Gp-35
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsu-0005LO-Fi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso5117015e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545882; x=1778150682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z/E+NEUk6p/y4Qsh2ZiVobxIRwHiu1lhqMJeWdQLKM=;
 b=uHsO6JMo6sVIpJLRApTlqkt024zQ+YnYE/Vu28o7qPGaFZfYyY84PYPyHY4GiBUQae
 BTQ9mv/r5/WgHQakUVNRgjGh2QS4MQnZUFfXHRAAY7IJ2HfBB6FzEdFMQ1UE0wX4C60Q
 UaqwXV2qNcZpwkPjj7derqRMNENeqPFVNNoqNnr0TxuD8v1XmuRuhmusj05zEX7IBscz
 /rIE5XEu8fQICXmUfGFvcwA5wAOx6mU3Vy3pAExtabexN/kNqMecVsh0+1i6rJ0rUWpL
 hlaTyP9tNd3NqzZ1t1H6RQ5vFQMgZwl6sBcbMCel+wX959hGaa23rh0G6XIxVwhoQ75h
 73tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545882; x=1778150682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5z/E+NEUk6p/y4Qsh2ZiVobxIRwHiu1lhqMJeWdQLKM=;
 b=mbVPxEzZkf4Xvh/JADvzIXuOcZU1U47AG2YAhyW+mWz0/qDtWWF8nKgCrPCZuHv0Y0
 fiqeCRE2KGBWWjKHU3nBm9wvsnGJKAfZqjJUmwq9E7woEir9lL+yBF7k80QtVJBOST+t
 YtcfdZvN14CS3zd1oWR7Ww8jNhqefDlwJG0W3joFBpRGAvyreOoBznkwW/OzVo9ARr0c
 V7KwDPYfLsUSBtlZE7Hv+Vg7LCNjRttl66s+MTYscRT/q+2QS8imMmXSFDp7q8rdzRWf
 rxkwdNU7H6qQIy3Ie+lcKqa0IYccRwjrLWZCJoBtV83S8kWaccUy00kGoP/bAdCB8Uk0
 s47A==
X-Gm-Message-State: AOJu0YwuMjGZKlVHwQnvj99kyG6nmL38v1UFh1HjxywDSeHbyFMjoh8u
 NuqNdE5LUo4g++/7uUN65UXzsE9kgtW+IBrtLwjn4r+vJ/EzSRaYLQ0w35h5rIxFdEWuYj+XKbu
 jRgyXOR7LshUf
X-Gm-Gg: AeBDietQxPNfgCmPfXQWV8JT2NbaOK+yFxeq6yc69CVYDpUD2lP8nXLHcPycA8KkuZk
 tTbU4b7OakCic6aiVrS04dIFDGn3DrOWTSaMDINuNG4cjzK8ujKmycToqC0KeWh13Z5GJ+qOMyQ
 95ikvsnkicVc594KzUfWwdJcv00b3ZxS3OkxqQVfFPFpfq/rMVz+yRel20BNh+1nOx6Ggo3opNf
 dy7eiOW2jZqmaxkcpD/hfUoe02EG6tvCQSKngVESaSlEqMpNeBcsh5H+t1gE5UrqkHqmeU7SMmS
 cDe7IPyczwmPj0Ff9A9uNE/9HNs32GQo08coETxyqFIK8qYGc8noWpJTgddKxQxgLuWl9Cr9XK1
 52Axw6FyAezQ7cNp0C1u+iSJfm0eq0jiYcJV+2qmO481g7xuSyjC9DLuvBOExR9vW76lBVxO+tZ
 Z90/hyav2GQRj2SYPGiFQBG+mZY5qYlq0V5g==
X-Received: by 2002:a5d:5847:0:b0:43f:e791:a347 with SMTP id
 ffacd0b85a97d-4493e982935mr3711927f8f.26.1777545881915; 
 Thu, 30 Apr 2026 03:44:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217afesm12338368f8f.23.2026.04.30.03.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D1855F954;
 Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 7/7] target/arm: implement WFET
Date: Thu, 30 Apr 2026 11:44:34 +0100
Message-ID: <20260430104434.1482407-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

Now we have the event stream and SEV/SEVL implemented we can finally
enable WFET for Aarch64.

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix exception syndrome by using enum value
  - use env->halt_reason
v3
  - fix check_wfx_trap(s/false/true/) as it is a WFE
v4
  - defer expensive calculations until needed
  - treat cs->exclusive_addr as a IMPDEF WFE exit
  - update commit message
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 95 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 +++---
 3 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index ebdf09be38a..5e4d828dd55 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -56,6 +56,7 @@ DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
+DEF_HELPER_2(wfet, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 77ac6161e93..8421c548303 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -640,6 +640,101 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
+void HELPER(wfet)(CPUARMState *env, uint32_t rd)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * As for WFIT make it NOP here, because trying to raise EXCP_HLT
+     * would trigger an abort.
+     */
+    return;
+#else
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el;
+    ARMCPU *cpu;
+    uint64_t cntval, timeout, offset, cntvct, nexttick;
+    int64_t next_event;
+
+    /*
+     * As for WFE if the event register is already set we can consume
+     * the event and return immediately.
+     */
+    if (env->event_register) {
+        env->event_register = false;
+        return;
+    }
+
+    /*
+     * Don't bother to go into our "low power state" if
+     * we would just wake up immediately.
+     *
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    cntval = gt_get_countervalue(env);
+    offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    cntvct = cntval - offset;
+    timeout = env->xregs[rd];
+    if (cpu_has_work(cs) || cntvct >= timeout) {
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFET, false), target_el);
+    }
+
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
+    }
+
+    /*
+     * Finally work out if the timeout or event stream will kick in
+     * earlier.
+     *
+     * The WFET should time out when CNTVCT_EL0 >= the specified value.
+     */
+    cpu = env_archcpu(env);
+    if (uadd64_overflow(timeout, offset, &nexttick)) {
+        nexttick = UINT64_MAX;
+    }
+    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+        nexttick = INT64_MAX;
+    }
+
+    next_event = gt_calc_next_event_stream(env);
+    if (next_event > 0 && next_event < nexttick) {
+        timer_mod(cpu->wfxt_timer, next_event);
+    } else {
+        if (nexttick == INT64_MAX) {
+            timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
+        } else {
+            timer_mod(cpu->wfxt_timer, nexttick);
+        }
+    }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+#endif
+}
+
 void HELPER(yield)(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a6f392a28f8..ead2a7ff81f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2086,14 +2086,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
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
+    gen_helper_wfet(tcg_env, tcg_constant_i32(a->rd));
+    /* Go back to the main loop to check for interrupts */
+    s->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
-- 
2.47.3


