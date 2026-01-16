Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98735D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghst-0003QX-3s; Fri, 16 Jan 2026 06:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsU-0002Kp-Ay
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsQ-0006xY-3S
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so12785825e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562424; x=1769167224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LNVsTjccttAt6SRISjcT5M1xP1Gq1uF1qJFqk6djuLU=;
 b=LhtAFG0Zh5xF0LoFqC0dX8+h15b2HL8o52IgbZZKh+8irXabLC7IwmbyyVHH9ID95H
 irH350uqoaZOOhLmyTsjpv7Am/ybjxMbpSgkOcAXDHa8rGbp/AsI/xSjL6My8/fUrsu5
 4sI5yfZHteufSxc6tOmG1LWeWNwz1BMGm5kOn///nxJut43NvwKvx3zbMSDmLSO+yYYz
 Wkedwv4kEzulDOzsbN46pSkZUlW4qYVJJumHg0zdRIgpPQ4CcrzBulU4/76A0oevoWN/
 XtXWDTjLHFLEqng5tgyhWfEPuVCdqJdjj0Hg+5mVFzsOK1Xyahyk9LJGVW5MFY/HUyIc
 qpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562424; x=1769167224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LNVsTjccttAt6SRISjcT5M1xP1Gq1uF1qJFqk6djuLU=;
 b=lomB4ZfVjcggTUQdm+t2YIxm8+YT1JCW2SkoxQt5BAOHQV/DMYQhTqQE04Jf/AAwhw
 aJvVrYKnb3tef5HmuGJI2AeC4ZZaq4i7PnzbGzBF6GyNuLDZJWlaD91JYVcHy+67ilvm
 W5r8sJbjFvYUG+iVy+ic7cmEo6Yrh63DIsw3cwM8sHOm2VbIuS0Kq0CLyfhi86dUk7R9
 Xc/L9s4R0o4ZXhs4vDLN2U/+zRrHt/+xM9uteuuVq2w3uMuPOOA5ETpoqilcJRIKVXwb
 uVDPBFUyEawufSQ6eZc5fasBlLt6lB/Gd/fJnThNc+SqQT7ElIUX+Jfx9WlKIxeAkbWe
 9XgA==
X-Gm-Message-State: AOJu0YxhhAeVaVBHR/ss/5vcRUcYIQA73AWgtEH2RCn5pg042x2uThLu
 RTlYfilwB8JVjepryfVtOtX1TUoNVPqvUtodK/28lvqHJFTxnA9b+eI97zC61OUtABuItalVOx5
 a/VQ0pjQ=
X-Gm-Gg: AY/fxX74hZxWr+t1/HYj7rS80U1I7qVxoBXW+V1ei17PYSOqduICVNAIOYMP2RyJuIm
 C+/TWTdYcuBL6zZkXe4RiCF62S8YSbYrEuqwloCIaZW/nAoTJCsmLVxjIYInmpBhm8QAGtmYvHw
 wrenYsxXRgaPY0olGmINyp1pvUoAj1qmZzNSm1+CmA/28CWwjkWJ01n9GIXPFrCZ4rVVQa0anql
 THCPuGSfjyclh80gbFACrpLIvNEZ5LBSXOQdjou29/WzaGiZJVFAf3DHaRjwpC1epuHHedyrRnH
 M3F03AmmalphWLSQpzpwRpIbE3JDsA+q4fwMTdmrmlgB5r1pUuU96HvW8KtfHHbksQ3Jp9fWSyl
 9p2Ji9oh5u7tOCbZ8XNgWT8LPZl9i426xMOo9jIadV8/nGpTz/nay7i+goKEecTYvi3I3+eFPRH
 XZTHr4tU5T/+sPKvE3lR+LNF5+wbHUYYOMQiE3QtWLQkZXWs0mXYChBio0TJbYjekhnkKwWOE=
X-Received: by 2002:a05:600c:5545:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-47f4289ac05mr44975895e9.3.1768562423583; 
 Fri, 16 Jan 2026 03:20:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm46881045e9.10.2026.01.16.03.20.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/30] accel/hvf: Implement WFI without using pselect()
Date: Fri, 16 Jan 2026 12:17:57 +0100
Message-ID: <20260116111807.36053-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Return to the main loop where we'll be waken again.
This avoid a tricky race with signals introduced in
commit 219c101fa7f ("Add HVF WFI handler").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-14-philmd@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c |  2 --
 target/arm/hvf/hvf.c      | 74 +++------------------------------------
 3 files changed, 5 insertions(+), 72 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d842d4b2b99..c8e407a1463 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -47,7 +47,6 @@ struct AccelCPUState {
 #ifdef __aarch64__
     hv_vcpu_exit_t *exit;
     bool vtimer_masked;
-    sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
 #endif
 };
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d931412975c..ffcfe9663b5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -135,8 +135,6 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigaction(SIG_IPI, &sigact, NULL);
 
 #ifdef __aarch64__
-    pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
-    sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
     cpu->accel->guest_debug_enabled = false;
 
     r = hv_vcpu_create(&cpu->accel->fd,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d74703a3d55..b936098d257 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -301,7 +301,7 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
-static void hvf_wfi(CPUState *cpu);
+static int hvf_wfi(CPUState *cpu);
 
 static uint32_t chosen_ipa_bit_size;
 
@@ -1703,81 +1703,17 @@ static uint64_t hvf_vtimer_val_raw(void)
     return mach_absolute_time() - hvf_state->vtimer_offset;
 }
 
-static uint64_t hvf_vtimer_val(void)
+static int hvf_wfi(CPUState *cpu)
 {
-    if (!runstate_is_running()) {
-        /* VM is paused, the vtimer value is in vtimer.vtimer_val */
-        return vtimer.vtimer_val;
-    }
-
-    return hvf_vtimer_val_raw();
-}
-
-static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
-{
-    /*
-     * Use pselect to sleep so that other threads can IPI us while we're
-     * sleeping.
-     */
-    qatomic_set_mb(&cpu->thread_kicked, false);
-    bql_unlock();
-    pselect(0, 0, 0, 0, ts, &cpu->accel->unblock_ipi_mask);
-    bql_lock();
-}
-
-static void hvf_wfi(CPUState *cpu)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    struct timespec ts;
-    hv_return_t r;
-    uint64_t ctl;
-    uint64_t cval;
-    int64_t ticks_to_sleep;
-    uint64_t seconds;
-    uint64_t nanos;
-    uint32_t cntfrq;
-
     if (cpu_has_work(cpu)) {
         /*
          * Don't bother to go into our "low power state" if
          * we would just wake up immediately.
          */
-        return;
+        return 0;
     }
 
-    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &ctl);
-    assert_hvf_ok(r);
-
-    if (!(ctl & 1) || (ctl & 2)) {
-        /* Timer disabled or masked, just wait for an IPI. */
-        hvf_wait_for_ipi(cpu, NULL);
-        return;
-    }
-
-    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &cval);
-    assert_hvf_ok(r);
-
-    ticks_to_sleep = cval - hvf_vtimer_val();
-    if (ticks_to_sleep < 0) {
-        return;
-    }
-
-    cntfrq = gt_cntfrq_period_ns(arm_cpu);
-    seconds = muldiv64(ticks_to_sleep, cntfrq, NANOSECONDS_PER_SECOND);
-    ticks_to_sleep -= muldiv64(seconds, NANOSECONDS_PER_SECOND, cntfrq);
-    nanos = ticks_to_sleep * cntfrq;
-
-    /*
-     * Don't sleep for less than the time a context switch would take,
-     * so that we can satisfy fast timer requests on the same CPU.
-     * Measurements on M1 show the sweet spot to be ~2ms.
-     */
-    if (!seconds && nanos < (2 * SCALE_MS)) {
-        return;
-    }
-
-    ts = (struct timespec) { seconds, nanos };
-    hvf_wait_for_ipi(cpu, &ts);
+    return EXCP_HLT;
 }
 
 /* Must be called by the owning thread */
@@ -1967,7 +1903,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_WFX_TRAP:
         advance_pc = true;
         if (!(syndrome & WFX_IS_WFE)) {
-            hvf_wfi(cpu);
+            ret = hvf_wfi(cpu);
         }
         break;
     case EC_AA64_HVC:
-- 
2.52.0


