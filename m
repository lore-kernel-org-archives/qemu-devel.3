Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4284FC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyCt-00061o-DT; Fri, 31 Jan 2025 16:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCm-00060l-HC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCl-0007md-00
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1315754f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357532; x=1738962332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuEaxaYNcJ4Nljb6SsKbu7siVHsyMjh90AkH7lAJ1Bc=;
 b=ip2NR8vNb0/rjaRqjVnt2TscmexAV7YFPCyB9zr+nMv9PLLpFhI1Xa1Cbn3NRdRY5k
 1GGP2oUvTNtndfnR5/qLweX3GYlTDiKeGKB9zql8hK4NM4xmeR1/X9YLkZfqQAbzsSqL
 nXxMrvUGMZ1J+SN0lFwgCvsuOYLpyK+601DhjgB2Gng7/UIE0ZHwX/U63amZes9+pSPK
 hZUIZLEQ4AIg4NVZXdCddLYvfPxk4H1MO/oG7j5K3mKL/0/Fy/vYjv+OdKhjVpyifRV8
 xjjgHb+EicATLmVLd31pTjTApJQx2w0HNX6dLwAfpc5RvdcGpxJCDd1AKMjU5ghmMQOa
 bksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357532; x=1738962332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuEaxaYNcJ4Nljb6SsKbu7siVHsyMjh90AkH7lAJ1Bc=;
 b=rYtfTEQ/sgW1QgiwhO2eLsVRs9RwB63v4tPfB3yVng3fI8DE9FajWvFGN/QiJ/LQCf
 ah9z3MVr8QabZfyOeSMXNIx4HqkcUtVttEOTBfto3W/V21P1sUQqimR/DrpDzLV6D93n
 Bg8XWNqpUjEZiLBezTgbKZ3rajAU3boqwGnL99IHj4TjdK0pFGn4dhwomQ8UcIM4ldok
 goVBgkl7XR4Vy52mtA+kceDH2/uOaI6c4NmanT5AdKi8f76LkNO+bOJmoggsvLzMfK1p
 Vql+W3QeZHQbkZyGBuF53TLSCRFMemcWpC5oOIoxefTFcWpmwn93ulGSVX6dQ8TjQMFs
 5V4w==
X-Gm-Message-State: AOJu0YwzBGc3RLyOPtZ1m6Wokv0MhquxEwOfnkm73ZxwNLJtnKn+aw5d
 TxNwGuZamwc78pc1eLomUDqqg+rwP7l73yHiipqkiVUmpf7tvgK7ZMGf4k0ZP5rmXRX6wyiQWC4
 k5ms=
X-Gm-Gg: ASbGncsd1ObP2Rgx3Ww4BpKjlRc3zKB60Nc0x5D7hiAKeDMuFxySxE4yZQ5F4zPU258
 pGvTmN0eUejcNhP14TDorZ3WhlJ7139SulOPe9jAIOYJHjQyD3bWnzG1FHXEWz17gmdxJiPNYUj
 EIbvXwPR0nAWK5jM7YCeO1YghbmO5d0Jiwpflqj4KoJhzp1wS0epwlhdA4aC/hlnvnxeqikwekb
 D62jRceCly+qKs90y8S49nbpqCerWhdFhs1TL6V4qRbYMeihER09y2kHe5ven/rsk/M9IYgsvU+
 fv9UMnPyt6+aYZ7DoiHs1PVrU4IbjLQ2wWM5q7VZL3RnVQHVd6s+sddFZrs/EZbOnQ==
X-Google-Smtp-Source: AGHT+IGbgzBpNyiHtPGHBFTxEQCPeXn+v3DTybvKAT8SYp776/+JHvQYgVXMtkDCy5gju6UpE+ImVA==
X-Received: by 2002:a5d:584a:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38c5209664emr10539820f8f.55.1738357531737; 
 Fri, 31 Jan 2025 13:05:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f5a5sm67853195e9.40.2025.01.31.13.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/36] hw/mips/loongson3_virt: Factor generic_cpu_reset() out
Date: Fri, 31 Jan 2025 22:04:45 +0100
Message-ID: <20250131210520.85874-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20250115232952.31166-2-philmd@linaro.org>
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


