Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA372CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxM-00055I-3q; Fri, 31 Oct 2025 14:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxK-00054g-MY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwc-0006Fu-FT
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429b7eecf7cso1756847f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935619; x=1762540419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hur19iUUYNUgD6AtJZs6/SDmdazLc6Uv6UNAGUuwO6E=;
 b=MoL1qEIBNtDh1p3bkjg6ITWelw+zU9D6wYM6XO19enlEeJOX1jIx8lWoe79YkUzw+h
 bGeKF/jjs5QK1FdJH34kT4ySdRIPjf+m/oJC7Ul2pCWzrfAoMpEDpSykVhzVIauRLSfJ
 ESfGcfYxcFgXk9S5q1+HzRs7fBZSL0CUbTXEZAQ15wJTMWnC6rWJmpUDMWR5sm59HiXH
 5Hr1dp7nEYiWl60H2gljQFQOxp0rorFJbOC4+BVI9aFUxMzFkWRCj7TLUFxB5w3nf5ur
 IbRTyzdC24ml4LBgxwzihQa14nMbyN8w07x8CEEa17TT2DofnXcnA+TcnNhUBu1SYhnr
 a7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935619; x=1762540419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hur19iUUYNUgD6AtJZs6/SDmdazLc6Uv6UNAGUuwO6E=;
 b=TtnAjWiJiuShZbQCuAij0TDa+53PwrB3szMGGKPxpZQZzGboANVKHrCvYLBdeqHLZx
 x03JyoAV0cxB3h3CzSJZWv35N+TisqQ7H0aG5qJWCeJI2nLMHC0eRCjOOWy2Kmnqi5Cs
 rYghCgVSpY2iQ59ZvTTkoJflpaOQfieMWapcniEXp96G1RrY4RznzrvDb1MMs2dDLwI5
 /3dxLFsYQvoiKVdkUjD20+J+mKhuRUJoQNF2v6Smnh3lkTTUshU7A0jywPizFWvZdMjw
 69LiwlfiJj/bgvlkbw2GebhHjT66vASNhA2QymeCq2VfOH/OwubLlAFRmCZerdB9iRfW
 e9CA==
X-Gm-Message-State: AOJu0YxBZJe9CL1tppDN6pd6X9izU+s6Bii8KxvzD0L7Xq0Oeo475FS8
 5uVd77H5OFzXLfiEcdQr+0Ju2nxbggd4pi/DHkYpaYdmQJlWpOpe/YSwIwDIu/Qc+OVx9JFVTtc
 KVsH4
X-Gm-Gg: ASbGnctt7NDgybiH3r3ibqbWbgZLXRgcE+70GlB0va84GJUCdQPmXmnFyt5srfywy7A
 hkTKp9AmzP95IGi2d/LozxZTD86UH8C2p6XXAL41qVmyjdIhqzQy/vd4vzbh2qBKXWkbOZKD4M6
 +UkS8UmPu0dmcYjhL8OLwrG7jFjeCZqBN1BfR7l8eGtrG6CnUqQBTk4lrX23Cj3QXqTBOuZlXpa
 ntk+PBbAmKsmQYHa7049iZVT0WlcgDZ6wh8KGeUdu0qtW49VUmvkkp5qKwtv9nD6P0rK3Vn1tmd
 uExkdDhGlmmpW5f21w236fWyaEbn3TFrAdVRC5yxA5Ypd8A50U9mUMJQ3Bu6J3Al5nEdjZ+2Cnb
 n5UqQMQpxpUWjV0pv+rTu8gExQDYEjT8h0mYBKAUBODj3Ot0vppRVBprCBP6bE7RyeM0iR2JV0J
 UFVe5+dw==
X-Google-Smtp-Source: AGHT+IFfzx3BdHDCAUWhUm4zPhzqiBrLAOChxXi6Iu2dpZyHUxvu4GEqQkyu0jsROwnMCYAiqlHp3w==
X-Received: by 2002:a05:6000:2204:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-429bcccf175mr4701743f8f.6.1761935618791; 
 Fri, 31 Oct 2025 11:33:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] target/arm/hvf: Factor hvf_handle_vmexit() out
Date: Fri, 31 Oct 2025 18:32:59 +0000
Message-ID: <20251031183310.3778349-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Factor hvf_handle_vmexit() out of hvf_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 50 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8553ce6adc2..27c600148f9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1984,10 +1984,33 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     return ret;
 }
 
+static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
+{
+    ARMCPU *arm_cpu = env_archcpu(cpu_env(cpu));
+    int ret = 0;
+
+    switch (exit->reason) {
+    case HV_EXIT_REASON_EXCEPTION:
+        hvf_sync_vtimer(cpu);
+        ret = hvf_handle_exception(cpu, &exit->exception);
+        break;
+    case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+        cpu->accel->vtimer_masked = true;
+        break;
+    case HV_EXIT_REASON_CANCELED:
+        /* we got kicked, no exit to process */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return ret;
+}
+
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
+    int ret;
     hv_return_t r;
 
     if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
@@ -2006,6 +2029,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     bql_lock();
     switch (r) {
     case HV_SUCCESS:
+        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
         break;
     case HV_ILLEGAL_GUEST_STATE:
         trace_hvf_illegal_guest_state();
@@ -2014,27 +2038,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         g_assert_not_reached();
     }
 
-    /* handle VMEXIT */
-    uint64_t exit_reason = hvf_exit->reason;
-
-    switch (exit_reason) {
-    case HV_EXIT_REASON_EXCEPTION:
-        /* This is the main one, handle below. */
-        break;
-    case HV_EXIT_REASON_VTIMER_ACTIVATED:
-        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
-        cpu->accel->vtimer_masked = true;
-        return 0;
-    case HV_EXIT_REASON_CANCELED:
-        /* we got kicked, no exit to process */
-        return 0;
-    default:
-        g_assert_not_reached();
-    }
-
-    hvf_sync_vtimer(cpu);
-
-    return hvf_handle_exception(cpu, &hvf_exit->exception);
+    return ret;
 }
 
 static const VMStateDescription vmstate_hvf_vtimer = {
-- 
2.43.0


