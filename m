Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28FCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkQp-0003u8-6e; Wed, 03 Sep 2025 06:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQm-0003k0-P7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQk-0008Q4-P1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3d19699240dso506039f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894169; x=1757498969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk+PXZY+OrSjxbTyUUyA5YAPF4yrrrJhYOPYVhpA5O0=;
 b=dNv17TQtmJ0yRYB6rGAl7uTFO8JdptIzhMJ/zOrz526eOfswt3cN4wYlUHDyzbKXvA
 S4CDqhPjc6AdAMzGJusstZsKFHmyROKws1/qpEWOjDMHerCVQVwduuzRV3tmbqvycIAq
 +7RkSA6PWTJ2fPZN1v2mhIz8+B+0IWppFYeQ3w00Iv5EVcyoFQeBZDAQkkaNmp869dLs
 w5DKmWD5cLOSKWVPIu4JV1G1T49FmfmjoD6H17IQk6jYDdjrgJHqbp4YyHuNFZeHuCby
 awL8U6fMpgda5iqqxtWnjb0WoG01GYuqZmtKTi58xXtgzOD7CDqEkud0hf2Nh+eCUr61
 vnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894169; x=1757498969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xk+PXZY+OrSjxbTyUUyA5YAPF4yrrrJhYOPYVhpA5O0=;
 b=MtSZjljksx7vbZ3cZC0IBTYGftukJae1ClRivMsOoBsqzsK7I0C6AfHZfeUKn4umvF
 6HZl8u/rWw6oNqPbbeoMcam/NRLbio3G3hjF0aTTUdlgRKtOD0ggE9GPcROKo9o4thtD
 y2zCfMemXH46saDTaUzp502WPYkaMmxS8Mm48A2YDv+34dv7fCF6RLqYy98eyCKTQOJe
 C9rL1A9smTANaBX6+ZzkDa4uMe2m6TRt8XOGR+cdX7AkB0VRcci+Xc2M1b7qEANxdFWX
 oybQulY3soi+qpipOT1bTadXX023cSJexwjQgn2Pac8N/WoKzZEf2u6339P/YhCeDZqX
 iUwg==
X-Gm-Message-State: AOJu0Yy8WGdhfjMew61Ci+0+3stm2RvOJlPctcQy3e5cG3GcTR9GxAwu
 njJ7QDwQ7rgnW0lok3P0Jg4rLKAN9dcNYHmebGoW6syV3W2Ne9VNnhqpiPq9V4k3hOZ4KfVGi/g
 d/9Inb+gW3g==
X-Gm-Gg: ASbGncvaD9NaUdC+nQneq7ZZB64REjvOrVmOU791NManBbPag53HBxKAg4JHwmfp12V
 wyZn77GSsD01wgRrH/1CvWlf3ciJ3JnMZez2AKpRT0doFAn7JP9OV+PMtAF0Zix3mxulj9rBd3R
 ZV6Q7S0OaN/6ziXjTlB+Sl4HgeuNPQ5lascoC/IUw9pBfVw/OGkHQrc3OFxEZS84txVwXTpz3+w
 awEZt0Cda6OkObzBvN5SRrJde3/lOtbaNwsA1RVFpVZ2wGCsH5PCl0YOUJtWmnnhDQMOOdqrH71
 82hQlc/JOjlIDX4mCjI24qArms63FJXlKNFT/VAE51iXxz8RU2GTMDucfInYTcoR7mTJx3bMJAo
 xp32bs1ruB3fT1dL1YwlzJytxFaAYVZq5FSppa+XrWcUMOyKMdG7JWVHFE/lGwRjaRW6yaB7RBT
 S6Km4yLQ==
X-Google-Smtp-Source: AGHT+IECavjnrCt4eWovNHrsbc5jQxIYbAKH52HtSTbO27IG9KcuJv52dSkqE+aS1chsEUyFy4lwDg==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id
 ffacd0b85a97d-3d1dd04e24bmr13123241f8f.10.1756894168836; 
 Wed, 03 Sep 2025 03:09:28 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9db4sm23044416f8f.47.2025.09.03.03.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 16/24] target/arm/hvf: Factor hvf_handle_exception() out
Date: Wed,  3 Sep 2025 12:06:52 +0200
Message-ID: <20250903100702.16726-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Factor hvf_handle_exception() out of hvf_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 120 +++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 56 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fd209d23c1e..3db0a8e288c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1928,61 +1928,16 @@ static void hvf_sync_vtimer(CPUState *cpu)
     }
 }
 
-int hvf_arch_vcpu_exec(CPUState *cpu)
+/* Must be called by the owning thread */
+static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    int ret;
-    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
-    hv_return_t r;
-    bool advance_pc = false;
-
-    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
-        hvf_inject_interrupts(cpu)) {
-        return EXCP_INTERRUPT;
-    }
-
-    if (cpu->halted) {
-        return EXCP_HLT;
-    }
-
-    flush_cpu_state(cpu);
-
-    bql_unlock();
-    r = hv_vcpu_run(cpu->accel->fd);
-    bql_lock();
-    switch (r) {
-    case HV_SUCCESS:
-        break;
-    case HV_ILLEGAL_GUEST_STATE:
-        trace_hvf_illegal_guest_state();
-        /* fall through */
-    default:
-        g_assert_not_reached();
-    }
-
-    /* handle VMEXIT */
-    uint64_t exit_reason = hvf_exit->reason;
-    uint64_t syndrome = hvf_exit->exception.syndrome;
+    uint64_t syndrome = excp->syndrome;
     uint32_t ec = syn_get_ec(syndrome);
-
-    ret = 0;
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
+    bool advance_pc = false;
+    hv_return_t r;
+    int ret = 0;
 
     switch (ec) {
     case EC_SOFTWARESTEP: {
@@ -2021,7 +1976,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         cpu_synchronize_state(cpu);
 
         CPUWatchpoint *wp =
-            find_hw_watchpoint(cpu, hvf_exit->exception.virtual_address);
+            find_hw_watchpoint(cpu, excp->virtual_address);
         if (!wp) {
             error_report("EXCP_DEBUG but unknown hw watchpoint");
         }
@@ -2039,8 +1994,8 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
 
-        trace_hvf_data_abort(hvf_exit->exception.virtual_address,
-                             hvf_exit->exception.physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address,
+                             excp->physical_address, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -2054,11 +2009,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
             address_space_write(&address_space_memory,
-                                hvf_exit->exception.physical_address,
+                                excp->physical_address,
                                 MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
             address_space_read(&address_space_memory,
-                               hvf_exit->exception.physical_address,
+                               excp->physical_address,
                                MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
@@ -2156,6 +2111,59 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     return ret;
 }
 
+int hvf_arch_vcpu_exec(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
+    hv_return_t r;
+
+    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+        hvf_inject_interrupts(cpu)) {
+        return EXCP_INTERRUPT;
+    }
+
+    if (cpu->halted) {
+        return EXCP_HLT;
+    }
+
+    flush_cpu_state(cpu);
+
+    bql_unlock();
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    switch (r) {
+    case HV_SUCCESS:
+        break;
+    case HV_ILLEGAL_GUEST_STATE:
+        trace_hvf_illegal_guest_state();
+        /* fall through */
+    default:
+        g_assert_not_reached();
+    }
+
+    /* handle VMEXIT */
+    uint64_t exit_reason = hvf_exit->reason;
+
+    switch (exit_reason) {
+    case HV_EXIT_REASON_EXCEPTION:
+        /* This is the main one, handle below. */
+        break;
+    case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+        cpu->accel->vtimer_masked = true;
+        return 0;
+    case HV_EXIT_REASON_CANCELED:
+        /* we got kicked, no exit to process */
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+
+    hvf_sync_vtimer(cpu);
+
+    return hvf_handle_exception(cpu, &hvf_exit->exception);
+}
+
 static const VMStateDescription vmstate_hvf_vtimer = {
     .name = "hvf-vtimer",
     .version_id = 1,
-- 
2.51.0


