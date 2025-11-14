Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3529DCEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0Av-0003fV-HX; Fri, 14 Nov 2025 15:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK04D-0000Fw-0l
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:06:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK04B-0005Al-EA
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:06:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711810948aso16303135e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150801; x=1763755601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvXFIS/LP/8nn2LaWPgW13nQ8RvlKKCfqWkyp2+R/Cs=;
 b=XZd8/J9I74tPJ7JXWuXlYC6HK4auQGD4UUcsJz4qjYu6zrUfeE0N4SKz2FUXIenNVa
 p1xMQjE/aUgA3m0A9aO0lH5Os9/JYRy+B158PFlkK6zYuFIu2P8k9OktH3ECkdKfncSB
 EzkffPr6W5vqHr2DSX93QG/W/ryF2aLGseQDxepYSMpVZLwFexVZbohVkN1iDOaxISK/
 v25rvJdpP6ZIpIdWzY5J1QtEcr52H8GpkvdmfBas8Ex4Wu0Qs9CZTjhy7RENqwUUx9r3
 aKUtqUqNS075IPo1Kxx/t+T1V1KwxrLYboqpnCQqZaXA9+JmVKvi60X27924y/TZBwXF
 CQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150801; x=1763755601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UvXFIS/LP/8nn2LaWPgW13nQ8RvlKKCfqWkyp2+R/Cs=;
 b=vvaPmr+3owWu6YF6ocIYuJF4DavZtzpZL10xAAV8ScKHuKzcTrKJvSabMoR6RzI/vr
 IbfDcN4YD6gLlYQHqEgBTQag//GQqAmXcM7hXJm8Mg3teleAnvk11jM6/k7oKzEPsTyD
 2ysbhFr+UmcAalAncZA9rUZo98Jv0Jui3HauCWJ7vq0HviarBrnb9sMxNoct/gHlxTNN
 kNDam65B0tNcZ8fhbFl+sntAZqXrB0pNJqs3lPAN1fP1+KWkIm93jKW5lWxK/0tOWNu7
 vPx7cFAXXNoxL6UqYDNqs3zwbaXVtE3iflG7f0rEmXkmGsNTQPeC4OexrZpyOguycjTE
 4J3A==
X-Gm-Message-State: AOJu0YxP1lMQdw3hWepIMWlraWdQ0LQFj2CN3acwvezD4QTdhSVwZIx6
 q6ZjG3rXHim6vGiiBqARLKtIli9U21D05aOisEOIa724+mPpvvuhQM9j88vCrX6jDSo08jVm9Bo
 Jm3RNjCBI4w==
X-Gm-Gg: ASbGnctJo5V0xtlI4RcC+5qv0b+PK9StaQUuHm7AiC/UwXZZshKiR2ffdii14lE/xdL
 haFN9aWN5Y8k85zweLzsndFaor1/SmYkaeCcQE01Q/PdE+r48lLg6u8bHPTgHNlveccBCmAzZWN
 4oWEH6FEOJ4gjtPv7Dz3XqOUKA2kjnjudDYyrS48/hwKaQLaS3j9LNTTCJXSgFYnHig0/FeCJ8i
 /QW8XLaZpyxAGdSptXR3mK9hFqb6AQXAYf/x0pMlsovSa8RVnwMpnTt/nnIdUNePWaDHseIurnz
 5rHvv1zmHeOGnEm17S9YQ6eZBPg/5EG5wgpgrGCEzslBV6z3vh8JOOaDtT6hXMdkZh6M/8gHK4Z
 s/X5SRNaNL8Ufl+kD7mK/M6maU4dsNnMDWogwFdNojiDMfXHF+xUT/w7Vmtxv9QLREHiiD4JUEX
 g6o5RXTnf9+ZoAwcbKGV95RlpZSlovzR1UTXF5VlZJB8LEnEpiIw==
X-Google-Smtp-Source: AGHT+IE1x1/y/DyfM5dpDRooQwxZx3pySbIOgh++zsIKbH1Pj5PkFcVqGLIb+7Ef/H7cmMNi2YtXdQ==
X-Received: by 2002:a05:600c:4fd2:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-4778fe62164mr40389765e9.15.1763150800627; 
 Fri, 14 Nov 2025 12:06:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm158847825e9.10.2025.11.14.12.06.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:06:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 18/19] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Fri, 14 Nov 2025 21:04:20 +0100
Message-ID: <20251114200422.4280-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
not correct because the timers have already be initialized
with the default frequency.

Set it earlier in the AccelOpsClass::cpu_target_realize()
handler instead, and assert the value is correct when
reaching hvf_arch_init_vcpu().

Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8208d345daa..e1113e3d6ca 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,6 +897,13 @@ cleanup:
     return ret;
 }
 
+static uint64_t get_cntfrq_el0(void)
+{
+    uint64_t freq_hz = 0;
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(freq_hz));
+    return freq_hz;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -908,7 +915,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -974,6 +983,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /*
+     * We must set the counter frequency HVF will be using
+     * early, before arm_cpu_realizefn initializes the timers
+     * with it.
+     */
+    cpu->gt_cntfrq_hz = get_cntfrq_el0();
+
     return true;
 }
 
-- 
2.51.0


