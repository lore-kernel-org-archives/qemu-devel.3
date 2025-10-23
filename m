Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2ECCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw5X-0006WH-AV; Thu, 23 Oct 2025 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw5K-0006EF-Vs
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw5H-0007Rz-3N
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47117e75258so6851105e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228869; x=1761833669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgKVVP81quRHZdasM9p0tFwKU7dqmMROiJUy9ix33mI=;
 b=zmK9+yZIO5dGyv75q3mKda+HdEIhyvyyoTO6/zjxX3qsVobXb55siLrzvoc5jfC1zH
 FeHDJS8JYHM1leajc3QbuKsZPIzshx4ZsCUTg+B/bXqPft3bjibC1v0q/M6dKVIBTbTj
 3ACylSrJtzM9cmAOT9ZlCnh/AWibTROWc7qHNnUBsFAyCiQP7DqjKbbR97ED2vFL/Gnb
 1H16CpcXjqIlM/5AjzDjSlo0GhKZ3ivSUMX3U5JgKghGhSS0ib9ip1wtT24QLIhj+MRb
 1s5/vRNjScWc3UAV8MtATsr2mGnAfKB3LJfD+XoWnILVmQKlByFqCayA/kia6y8K9wUX
 PV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228869; x=1761833669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgKVVP81quRHZdasM9p0tFwKU7dqmMROiJUy9ix33mI=;
 b=IsMh0gg4uqBW9DIBGLwRgymwXYc5NKxdLkAEBF3HQ7GC50sIf5qPy02Oaf0JFi4iAx
 SxBBHWN5kMfSw+860LzhkAV10ZCN5HHayghMTPmNCH/QfBowUSm+auTFvel7EhQpYPco
 6bkzf1+7GLXoioqbmlCCmk4uRTt1tucVlmx4ERToIvCnvb8+KgSAtA5yNUIkVm3uTmU4
 7UWXC4vVR1lvXYFXQUVC5erTGrK3UhHLZ9iyE9LqWn6UtENDvAY863QawJsrzXrpnqJF
 wHbbR8bSC7wH4hvnHZEY2b3P/XRh2FFXb0RJ33KIZ2lSQMG5DKEl5ZC3JK4frre3lrVa
 ofZQ==
X-Gm-Message-State: AOJu0YyXox2hbEhXy1FC+jQQ6hUN8F5ruPg5qZe1SkT+xCQUOnaDG5K8
 dlyaEgwwXkFSssTssGtKRIHbQtU4TbLMRRShu3bAbpgYgQcac5Ye9vjnaEMjknKd6JLM3dm9sDA
 D6xQWe98=
X-Gm-Gg: ASbGncvo2qBMCq3mvkhb7lm8YgW2cnS9XZUCkKs2ZZq0rrlsa3J2heyo0i8EMak/AJr
 beXBhPavvgSHowdqNmFCZvv4fu6BQtbdgK3P+26pPF6ImbIQgMBcLM62QWaXXnqIS3Pe4zzUNvy
 QhhXZ7TA/spNd9ItONt2U9sOK9Rww21nxmhDZlGdcHh/dMrzsyJFl137wmEFgTwVF7XJn6pku/m
 gvp34fFYhjwKTW6QODAwkZbVv4FTIDPcP4HNKdH5y+JLJOJ6HJyE5DscLlQVcrwRdzazr27wlzx
 g6IhVrX6QCqkJbBgTMvXupxfBuYD//2TJzgvO2PybMu4sTI8G4GuxntUXQTLaqYfLIIemlkul/v
 BDvG3uZjRc7OLbiIj3QVwXmG2wQnC6n8cduVQPJPREb5Ix5KDjLvmcbY3UgMXc7nC0pNaNhFDoP
 lI+Kha2wNXqYCH2AG+9t4Q8izWnv8QItbuQqX+7KULgmlK5IyBXJUPIXyD6ukX
X-Google-Smtp-Source: AGHT+IFb/XSWqKHanfFo0JpGugOKs3B2G/i5axTSdAeolnzGHJFkkiz6qvyxK3ppW72qVwNLeyHDww==
X-Received: by 2002:a05:600c:8b74:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-475cafae81emr16050175e9.13.1761228868811; 
 Thu, 23 Oct 2025 07:14:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm117498495e9.17.2025.10.23.07.14.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 19/58] target/arm/hvf: Factor hvf_handle_vmexit() out
Date: Thu, 23 Oct 2025 16:13:38 +0200
Message-ID: <20251023141339.10143-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Factor hvf_handle_vmexit() out of hvf_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
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
2.51.0


