Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F48C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCq2-00061a-4C; Wed, 15 Jan 2025 18:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpr-0005rY-I4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpk-0004ky-Q8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso164628f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983799; x=1737588599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAnsUgZcwbLVJsP/XsIEi+0G7e096dCuqBuVIP59Z6k=;
 b=U38IV2GEb/wluFa0/+zkSWXPjq3nsrV0j0XsryBu2FxqXqxctc/5+7lAwE8BJts0x6
 IXhZ1eL74lsQTTYOn6LYaL6NJ3/iihOg+c8oOh+W06pAW6df3cHGGfV9JK9TaD4aqlhP
 ihZOZ06icQfGjHPyF5jDA/OEXMzYEe6BKVafnx2nvzCRAwQKDGEhbqPque0Pt5ccof9D
 Q0CMCQdFA7Xw90TB+D8B2PjL/OIkAp6+1s2Sjiae0frGkIn/swoBEltj3bH8/fy0uTKh
 doqEN1hD4osZSFb0DTXWj6sb7sqdwKsTwCv9Iirs2/ZsLlwte/eRPcAsJRMqzHr8WY7z
 tm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983799; x=1737588599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAnsUgZcwbLVJsP/XsIEi+0G7e096dCuqBuVIP59Z6k=;
 b=g9zGvFgfz+a9+UvP3NPhVxfl/y0pqb/CDlF4FyPW/G07camhrU5XYabaGpL3k2TtuW
 pQ9MCAOTFMuxMKLRz4MofN9mxeFE7PnKlHs8daia4LsyBP4AfHuRd1oint8WbSN0U/uS
 aydy1bbzsMEzCfaJGpg4IK7unrruYy1Rf4xL2qQ1oW8Z0xR8YstItQBBNSGHDWn6itpZ
 iWykNrGg/onFqBNwF1HBpOWXv2YpwhytEbxEzQxSKnKFMLcEv1ysn4Y1M0bxb2zb9hD9
 w5ho6FOr3jFf+cMwuVgd0QLyC1Bt7H4uSoMRN1tve5eWVCjYPxgBBVeBII+SyaIMNiZh
 A++w==
X-Gm-Message-State: AOJu0YwnmZKvq/Jo8Z0fVsbgGpTXiAB2irY9we5yTkjVssGWrpQpHkoW
 AkSavXuntJk6/fVPCfRdzuspzDt8ffgdjLbH31jHqmDasQDJfiOUut0uf/+aDZIDv/jhA0Ol+zg
 vUnw=
X-Gm-Gg: ASbGnctVur+PXVpz9bI/GBNaoI9SRJSCI+/MU4k9sCfY058V7gyU8oQjwziEecz0qvX
 56htgLqiMGlVv4DXucdNjG0xf6z5+3vrzUPQD7fDXcdpyYwfx4lWz6YaUtQOyVH9iqBHjPA8YKm
 wgh4mMGk7rfGTOkS9YokC4nV1Il06W18bevGibGJLzStG7BxwvZB79GVVSzzc35+ACqOifmaGeC
 E6v6buRT8n+iHrfmFGWRQuhUZgFxbWXt2VyRYuqQcZyQj+tfaINA0cJLUUS9wcNRvEb5LVXJthO
 e8OhgnU87S0M5ppo5nBwARQJ56Fsats=
X-Google-Smtp-Source: AGHT+IHb1KTnaXuK6ME5yCwJClco1y813M6gd98dhSCAyEDFU76dOcyH/7eug+1THIJpaDVs7fIiPg==
X-Received: by 2002:a5d:6da4:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-38a8730e04amr26216975f8f.36.1736983798887; 
 Wed, 15 Jan 2025 15:29:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7f79sm19196267f8f.69.2025.01.15.15.29.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:29:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 01/11] hw/mips/loongson3_virt: Factor generic_cpu_reset()
 out
Date: Thu, 16 Jan 2025 00:29:41 +0100
Message-ID: <20250115232952.31166-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

main_cpu_reset() is misleadingly named "main": it resets
all vCPUs, with a special case for the first vCPU.

Factor generic_cpu_reset() out of main_cpu_reset(),
allowing to remove one &first_cpu use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/loongson3_virt.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3cc7a8376f..47d112981a2 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -399,25 +399,33 @@ static uint64_t load_kernel(CPUMIPSState *env)
     return kernel_entry;
 }
 
-static void main_cpu_reset(void *opaque)
+static void generic_cpu_reset(void *opaque)
 {
     MIPSCPU *cpu = opaque;
     CPUMIPSState *env = &cpu->env;
 
     cpu_reset(CPU(cpu));
 
-    /* Loongson-3 reset stuff */
     if (loaderparams.kernel_filename) {
-        if (cpu == MIPS_CPU(first_cpu)) {
-            env->active_tc.gpr[4] = loaderparams.a0;
-            env->active_tc.gpr[5] = loaderparams.a1;
-            env->active_tc.gpr[6] = loaderparams.a2;
-            env->active_tc.PC = loaderparams.kernel_entry;
-        }
         env->CP0_Status &= ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
     }
 }
 
+static void main_cpu_reset(void *opaque)
+{
+    generic_cpu_reset(opaque);
+
+    if (loaderparams.kernel_filename) {
+        MIPSCPU *cpu = opaque;
+        CPUMIPSState *env = &cpu->env;
+
+        env->active_tc.gpr[4] = loaderparams.a0;
+        env->active_tc.gpr[5] = loaderparams.a1;
+        env->active_tc.gpr[6] = loaderparams.a2;
+        env->active_tc.PC = loaderparams.kernel_entry;
+    }
+}
+
 static inline void loongson3_virt_devices_init(MachineState *machine,
                                                DeviceState *pic)
 {
@@ -572,7 +580,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
         cpu_mips_clock_init(cpu);
-        qemu_register_reset(main_cpu_reset, cpu);
+        qemu_register_reset(i ? generic_cpu_reset : main_cpu_reset, cpu);
 
         if (!kvm_enabled()) {
             hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
-- 
2.47.1


