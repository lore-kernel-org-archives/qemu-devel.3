Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F8E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5yq-0005I7-Fh; Sun, 12 Jan 2025 16:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yo-0005HL-F2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5ym-0003lR-QF
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so42715075e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719123; x=1737323923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBkUIrZmRCcMUfKfE/ttgBZhqdpPPCtj+GtXYZ2keik=;
 b=HZ81YkHd6ZBDNILW4k6trHdBe+yNJLRn8DEAbZUaoRgLVpRfU5VO8sW+h9LM/akZsR
 +MA12x4Ca3bmq6vtRWFLgxOMtHpmYx/bnnGH6fwafUL1CiSCf1nzTczdy4RB7T+O2wnY
 ob0a5/3CYd/YwUwUx5iA+HKcykmQ9b/boAtCe6F/ptT+Ah+Wzk78t/FwflAxATkkhslV
 b9gu6FKuNpXXuqdH4EiNmW2iRFxZnYBdD9s59gGk9HmsqzogSWYC3blAxDbSKPHs8Nxk
 3dxaBmh7OfrjYESSgFjhb544cji/02kmHYLlxQCJgns2XE9VNyW/afuXrSVIdklzsraS
 YHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719123; x=1737323923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBkUIrZmRCcMUfKfE/ttgBZhqdpPPCtj+GtXYZ2keik=;
 b=cMKAkJNBf7VNF9ZB917mn7B6+cpVICmUf8tkmc+uXzJmnXeBdRsRi7K42sWGxTbK3j
 lsKp4mZnZ6bN79bA8t4tN0CPPeEUUdpPbPuaaHviYIU9wuuXoJhSrHRPHr+mqefcSJ+D
 b4Gh6Sl9qSxlLMI7BNkd+/o7iJqojRGgUeLUWwFMcvvEndzh+K4Wyg/zQzc9vvKKyBr4
 l7HcaBXWGpj2vWkuJ5mkaVS7OFoaNgF1Wg3ITHfozzgCEG27EO0ql+rs36pWZWlojStP
 rCL2m097s0YwUEi5xfnUGTFZTJxFaB2wo6C2P3R2ziNSSxJni4dCkdfSefulGCclj/ow
 wtpA==
X-Gm-Message-State: AOJu0Yw3AFJJgtcF5YHmKXzvi22ZbZektPjrR7d+ss7Ojva4gG58s3fA
 aAtPC/d1nLVoA8jnkSjEAp8FlKEf0WkGByPt82yn8CjVAECwlEM27AyK8gFDH+d94nkdCJOUjTm
 oVC0=
X-Gm-Gg: ASbGncsCxS4dPowxkO5kIf0UwzDshfHuiLJt6mD3tGhXyjHEsPjWx5sv/gnSubn2O4U
 ZLl+am2DpAX75kD01tY0LxLEsilzD7j67Ho/UPOt7fuRMutRcrJHNLMQiqR15N3OlXOmIauqJNz
 kBFEUQjpGkMJXuAVvB9hAs8ZoP2Y6b0Mtk1w+jfyLoyB8r6In1N0Z3hw1jIC6hO5vypSs372rvf
 18vFE4Ai91NptlGguT0u7AEIqLC9u8lI78U6EyHsMFysRS/HnfRZagDmsyxGavi7Itlge3tdCi2
 8X4p/HIFlLZNNM0Xhife6fSRVywg9F4=
X-Google-Smtp-Source: AGHT+IFpk7A4J4t8Dh6yTSB5u+NCyhCyQBZimuS0Ln75LbgdGnQdBdDx7SCHCc0AlEJ1UWwllsRZ9g==
X-Received: by 2002:a05:600c:1ca5:b0:436:1971:2a4 with SMTP id
 5b1f17b1804b1-436e26c3efamr178483945e9.17.1736719122610; 
 Sun, 12 Jan 2025 13:58:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddd013sm159325895e9.24.2025.01.12.13.58.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:58:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 01/11] hw/mips/loongson3_virt: Factor generic_cpu_reset() out
Date: Sun, 12 Jan 2025 22:58:25 +0100
Message-ID: <20250112215835.29320-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


