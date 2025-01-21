Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1CFC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxZ-0000QU-6s; Tue, 21 Jan 2025 11:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxU-0000Nd-K1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxS-000609-Kl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso40350745e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476309; x=1738081109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AQT8m8tl5nDLX+ETLTSG96DbyWQcasjgSWfLcAwrhg=;
 b=bQ+0j9EPkOxrwWI0iG8ILlSOQOO6MEezvOWBdCTEvDx2MfCk3nhFgbPH/blP7D2XUn
 HjI43qUl6VlIM8zY0opQDdPVSlAYjbVfeDp4ge7DUW2JBiXwjNN4RJxLxh52eJZIAGuA
 ULeLO44SrMl8q035e7y2+KYLLL06RDfUy7d/3xQXwZ7ltK/3fkGWOw2u1X3BTLyEdb6M
 kg7NVwlGImNF0TWUhmSre5D1dq5Y+9lp8ll5DOvmALb4iS5/SQX/2ZXVOi0yvrjcmUmY
 O0m/+SXtfu4MUncvDAHJzz5om2hpJ1DCv2C19GSZ+IAjiMSQSQlQ1shCY0ejN0JaI2Bm
 ssHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476309; x=1738081109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AQT8m8tl5nDLX+ETLTSG96DbyWQcasjgSWfLcAwrhg=;
 b=ntnwGaAgsVDdL2HC6kJvh7IsIIVGetgMMmyJjIrBXisMBhr/BHSaVW4MJMbVzj874f
 r4unWkXbvwvIquSA0PSTGnF6ws5JGhd+YdCq03LpGBPLVeVrqshgGzIIk4r5DjPhV/PA
 fxN5VCVzQgiXRk+TIrjqvMiHb+SU5xLtcjuali1Je+Zn3QZyfmc7NS9+pgomvg5wXxTw
 m7znswO7bIHLjsGQ2cIanJ0FfsPPsQWlpqd83ivS04i4pcfQTDhRxlDp4Biqz1906BHR
 WyOwwO3M7NTKd/ex+jY6LurqBd0UYwsb03c922nbuhogj8Ez77q9eXwC61CGntkfmFD3
 OjRg==
X-Gm-Message-State: AOJu0YwrGnpYeUyffDRgXH8HOxACoFVBwx8A3JsgeBjjdXDOVAUp1Ibc
 XGil54YTQFMI6Wvfx5foAkk17ql7lpVKmzOmxu4Rh+3T6Nt9mALy8X6jZq2T+HlP8e+AHPSMlt8
 Cl+4=
X-Gm-Gg: ASbGnctsb1cLzx3iZEzzmqG/OPS59saXkiqLnZkVc09f+qyxpBOKrnkp6jKCybMzeZY
 n3XRNGIMAhVfdMNs4xxvRKV8ku5wvvxfW8hCDjmF4OUGc0SEkCBRgqLpXsfjI6CxhEr8GFjJDxW
 qGVhwAiau0y6oT3sJWWR1u5xf//DyZoAG1R3GGTA8/rKmDd3IVyVETWSIYCY2ZfJYmQLMB9/7i/
 nA0ZAAmU1/lKi/yDmUGjrmVw08d3B8C7e2brLl0EsBe6Ogv2kMAaXpn1LnPnA2TGDH3QV4tYJBn
 w9PfDvmMDPdhQpU1A5rQLiXqUrL03PUclNCAEaVDoqUB
X-Google-Smtp-Source: AGHT+IGxC/Y3dOIvCvZZz1/tVy6LDHduH8KEbQ/91AQXvuWOks2izhVM+gNaeze66ac0fs1klldjWg==
X-Received: by 2002:a05:6000:1a8c:b0:38a:888c:6786 with SMTP id
 ffacd0b85a97d-38bf57c063fmr16833268f8f.52.1737476308711; 
 Tue, 21 Jan 2025 08:18:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322aa0asm14022691f8f.50.2025.01.21.08.18.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] target/mips: Create clock *after* accelerator vCPU is
 realized
Date: Tue, 21 Jan 2025 17:18:13 +0100
Message-ID: <20250121161817.33654-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Architecture specific hardware doesn't have a particular dependency
on the accelerator vCPU (created with cpu_exec_realizefn), and can
be initialized *after* the vCPU is realized.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0b3ac4e60a3..028a3c91afb 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -462,20 +462,6 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    if (!clock_get(cpu->clock)) {
-#ifndef CONFIG_USER_ONLY
-        if (!qtest_enabled()) {
-            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
-
-            warn_report("CPU input clock is not connected to any output clock, "
-                        "using default frequency of %s.", cpu_freq_str);
-        }
-#endif
-        /* Initialize the frequency in case the clock remains unconnected. */
-        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
-    }
-    mips_cp0_period_set(cpu);
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -490,6 +476,20 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     fpu_init(env, env->cpu_model);
     mvp_init(env);
 
+    if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        if (!qtest_enabled()) {
+            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+            warn_report("CPU input clock is not connected to any output clock, "
+                        "using default frequency of %s.", cpu_freq_str);
+        }
+#endif
+        /* Initialize the frequency in case the clock remains unconnected. */
+        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
+    }
+    mips_cp0_period_set(cpu);
+
     cpu_reset(cs);
     qemu_init_vcpu(cs);
 
-- 
2.47.1


