Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2709DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuXD-00012f-Kb; Thu, 23 Oct 2025 08:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUK-0005Wp-93
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:33 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBuUI-0008QX-4D
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:32:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so7083395e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761222731; x=1761827531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQ2Eh2V7b9Wp5VhIUqDSe6OaTHE71wRbrMgAmX2CIig=;
 b=om0RGH/GFlFkxbAGm1QtrhhvpiL79nFtbVlyBD0pt2M7S3W7LDH9xWl3rPytpgBFCi
 SnMNakYgpmgbA67M3xshUeJr2mktLeG/ZwjCo96aowyRcaK4uF2a52GrEJ+hlh5WgbZZ
 A6oi8USAkAgi8ioCE01v3ybOkukixR5aE8rQMVLL5Sx+r3pfWXG0bzTaw3zxrapLyfRc
 pvAQ7M80TbnNG9XJNK7Bj65O2P7In4nNh/RcEoIqYbCIp6RdZ96AtTtxKvh8EjM7nsjj
 gGhQM6iP0iZs8kX91dZcrY7j7kU9uX8Tu2tBqIhAblX4HHcCi7+/gWsuZoqc6q9vyGf4
 UOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222731; x=1761827531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ2Eh2V7b9Wp5VhIUqDSe6OaTHE71wRbrMgAmX2CIig=;
 b=hNruF7E6vPJf33t3QRJ5WH0+puZXKe9YrhH4bSsVd3Y/z+5UFoI3y+qsHhUfKK/YCq
 ib7lc+StoD0fNEOW/sy5bWnXi6dvKeGw66wR3ClSLOsM2CorIrjV9ukj5PLp6zXmyx6T
 09kotUQBBefpf9V2kRLY7nGidZpjrwXfc48W33YSYlgvSTR0BiCbsNorzz7TBrKYu7ZN
 bdo2OQv1V3xy2l0nFggZFa57U2uvzlVeC7yBXqERv06o7DoCtnXSaj1uZJtKO77i+Zeb
 XLy816sWfaPCLyN4V+vAMB4S24a0YDxR4wOkON9XUy6GHZndvy4sf2UAQ4gbgsDuOvoo
 UkuQ==
X-Gm-Message-State: AOJu0Yx4ujVcuJsotdnTjUFj/8u+7KM90L2WmqDg7ZAlESFy/hpNdTqH
 SZkpRKL/CI0yb+xBhnwv1TPiGohGj6fsCrHOpb+eAgW22YU4WxPaJyYTyxgMfNIDB2sPPczoxHs
 RC9Liyos=
X-Gm-Gg: ASbGncsDNCxrKkj48K9UsUv0iI3eYKA7zJbHRAwnwH6OXiO0e1/4rRw8u1MvzTZb1eC
 zcIcI+ImSXpmp/r/cvhihqlYajdDwD+6RWNhF1u602V2jGOTyl5qaoKbusJgVFFeWYlQFqnz9i3
 jDkH5rHaSjCk0Cf7YwMg3QsRfcmiq9jfBu6sCra70k0YI0bVFDTWxpOobTKJ+Rtg0GILi4RQHx5
 U8z60imIUH/COSjqOnwPCmdDLU6hdt1AqMGqk6Tfsmp4OXyY4/UFLlIaQlgdFDXPf4FvFAGOrzS
 slSzT5mmdeKkDhREgXtz2hFoHNjmHAP6BYF2UH0MqHptYVz1bcrVaYc425XgKC1UkLqq30iKAZM
 +zlxCvsP/jRaPmxFsHwPdzn1XjdtPMMR4PgB4hizGzM2LNJ9k7zCDain1mFEJJ6RAfbwgIeLx3s
 zVofMPt5puEJvSo5X/4JEVD/lzwZBP9g8o/8ICvKAq4KEUM4pYZIsri+wmnD9x
X-Google-Smtp-Source: AGHT+IHdLIabaXeqHr9Ts4VbsGbGYrlcJVb829CWbLCMNsHjme7sJzZscGlOyqbJYpq2gUpVBbCLyw==
X-Received: by 2002:a05:600c:4fc2:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4711791299amr163823875e9.20.1761222731365; 
 Thu, 23 Oct 2025 05:32:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae924a1sm44072925e9.2.2025.10.23.05.32.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 05:32:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 55/58] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Thu, 23 Oct 2025 14:31:39 +0200
Message-ID: <20251023123142.8062-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 759fa2e4d7d..f3cf5793ba5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -904,6 +904,13 @@ cleanup:
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
@@ -915,7 +922,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -981,6 +990,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
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


