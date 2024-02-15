Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CAEC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rad0k-0006oT-5x; Thu, 15 Feb 2024 09:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0a-0006ic-Hc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:46 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0Y-00072o-Vz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:40 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so131763966b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708008396; x=1708613196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGKg1tIZ8Pmm8o3jSUHHCrdxf28mb3+tuXvQyvyxP5g=;
 b=jk3oC2BoqEi3TVE0K21CLxMOIRISoUrqGSsg+JPjN0adh5acvfLqoDbyfbcFFQ7Xau
 eoDJ2CmBKaUFmbHIDLUvYWFV1T96Kifzl/eEaeX1KFxeiMosNLXS4dSq9TfNfOGr7tmn
 FQ4gojLgp5t+WAitV1M4W/VbiCdQd5yAiW4mrvBnONdc2vWFJTbcwWEoOab6N3nwmhBR
 pDk1gydyClX+aesiNdfnItNmnqpLfxFkcjUCu4+xRrwqscMnZUokV3/5bObN1bqaqDD8
 i/28wMojHyDItpn7tSr3QINMLlO56EYIN1axtEEHihK2SP8rjgSXMDlnkgwpQwVkj0HS
 VkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008396; x=1708613196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGKg1tIZ8Pmm8o3jSUHHCrdxf28mb3+tuXvQyvyxP5g=;
 b=bsfmxZlcudC4nzSWGwReetlznizH+5nVavcTuFc9Ti0MyCjMDYikKJl5Ljne/lcTIx
 qsrbpiHJugfTLyoj/hap3lh9zIxtKl2ZCWd9CpT7SpC0lyA+JzKNADKCIky+hFq+D06F
 cfScU3OD6ipkCEl/hfajecIQE49EhYegr0LawEM8tvVJKySvNazh4k6CxzXwNPBQJHPG
 EcNVmTJvbh66hSXckGacM+up81is/GWIWzFId+5gFoY6mdl+EAtHEBHx2V4ZS8vsv2zJ
 iKP8t4yEObM7ZeOzd+bCb21sXXzwc44ySEdJI5AaryL/gjVlF/t+vSKC/Bx2w3TSG8Dv
 XXlA==
X-Gm-Message-State: AOJu0YzCxOaBeyGPT439I5TT9Rp4QNkCnatTSXdQxnRdDIGHxjqMGUZy
 kUw27lK5s0lCS80J3UPQFrIqZSqmvwZ7bLKS0Nrz4AxRBaCfTXA+wWKgnLas4VAKp++mFOX1qBg
 3KIo=
X-Google-Smtp-Source: AGHT+IGmA0wWedjfejttOQUV3sk2NRjfs/CVAFK+QkK6zX1XEmedaZHF9IAGuxYqclzOHo4ja/r2hQ==
X-Received: by 2002:a17:906:370b:b0:a3d:254d:5aaa with SMTP id
 d11-20020a170906370b00b00a3d254d5aaamr1450284ejc.63.1708008396320; 
 Thu, 15 Feb 2024 06:46:36 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 qk9-20020a170906d9c900b00a3ce60b003asm630467ejb.176.2024.02.15.06.46.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:46:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/3] hw/sparc/leon3: Pass DeviceState opaque argument to
 leon3_start_cpu()
Date: Thu, 15 Feb 2024 15:46:21 +0100
Message-ID: <20240215144623.76233-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215144623.76233-1-philmd@linaro.org>
References: <20240215144623.76233-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

By passing a DeviceState context to a QDev IRQ handler,
we can simplify and use qdev_init_gpio_in_named() instead
of qdev_init_gpio_in_named_with_opaque().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index a15f90e142..44fca1487d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -241,7 +241,8 @@ static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data data)
 
 static void leon3_start_cpu(void *opaque, int n, int level)
 {
-    CPUState *cs = CPU(opaque);
+    DeviceState *cpu = opaque;
+    CPUState *cs = CPU(cpu);
 
     assert(level == 1);
     async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
@@ -310,8 +311,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     for (i = 0; i < machine->smp.cpus; i++) {
         cpu = reset_info->info[i].cpu;
         env = &cpu->env;
-        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_cpu,
-                                            cpu, "start_cpu", 1);
+        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu", 1);
         qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "start_cpu", 0));
-- 
2.41.0


