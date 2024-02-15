Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB4C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag4R-0007NL-0z; Thu, 15 Feb 2024 13:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4M-00074b-EW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:46 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4I-0002vB-3W
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:46 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5118290fcd8so1378929e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020160; x=1708624960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eUytsGHATYIyA0fQpy7VGo8DQbigcP7jFUNZajn3yY=;
 b=JEOpKvPRjp/zPhXzEhhoaqaf23aTOEn5XdyEKztOmVWAmylAwDr5RraNGwULw1OxjG
 DZhExAR1Z0Q12Ianwyc7pJ0ZeCA5ifcIV/FV4325S5U2YwzdF99uEJnh3EH879+pNNsr
 71CEyRI8F5xqOU7Srb2kpv66SCikTP3aAhybI3W31WzRUucUIIKgbT5Hdtn4Gmmy4ZRC
 lqRLfsw+7axmWTbqNHO+lbb1niX3TmXMBfYttaicjtcIR1aHJzA6An1eOXX51wzZFzrz
 Cul5eU7TSw4IrjMGkBJPRBtT7NRCEjJhcfXBm1uVfcSy13T8NrTZfcyvmVX/cjh/NkEQ
 5LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020160; x=1708624960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3eUytsGHATYIyA0fQpy7VGo8DQbigcP7jFUNZajn3yY=;
 b=MVcNEORp4T9GsngQzYsk+JA5NmwzCSNiREvUJ0sz+g59etCX3H7clD5ICs3xermUhe
 iFI2v4HtmAnVowOKl5ts1FtNtJEnZJXnoXWkQ5CWSc33nt6VtjEsPBF7cr4uNvKDHx85
 R1Y13erQuiznEuuRaMN80SUbn1E3u7Z7ExBfuVFPvHJg4EYQ7UjmyytH/jWFJ80kOmmY
 TDKjNI1+2Gw1HIOLx1uIVSJcw8WKTI65YMfnb0g7fz/cWlymxp+Wtq61r3ZWPPcYgQ2y
 FdvZxjUxgGGlH4k4VTg7aLPve/Z/Bo2jWPvpyRCdltfm22YYGR0MI4kstCujv5bLnVJu
 Yaew==
X-Gm-Message-State: AOJu0Yxby8gefhV8iGBptHwnwP4z5ynaH6PO2vlQL6/iceuohVl64B41
 0+fm1SqFXaUuDPHiaQwDgOigQlrx9Fv520nSeGePIH70LmcKCa99HwoIWb3qNZLI2Ltv1PqiLjk
 v65c=
X-Google-Smtp-Source: AGHT+IG6bme2fPIVugpPjnKH6g37ACyEL7fBTxa/snmrq1yp8X1Nu5GmZOyYRf9N5uEHTsMVhUdpMQ==
X-Received: by 2002:ac2:5964:0:b0:511:8e03:c91e with SMTP id
 h4-20020ac25964000000b005118e03c91emr1965716lfp.7.1708020159713; 
 Thu, 15 Feb 2024 10:02:39 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bi20-20020a05600c3d9400b004103e15441dsm2693413wmb.6.2024.02.15.10.02.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 42/56] hw/sparc/leon3: Pass DeviceState opaque argument to
 leon3_start_cpu()
Date: Thu, 15 Feb 2024 18:57:36 +0100
Message-ID: <20240215175752.82828-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240215144623.76233-3-philmd@linaro.org>
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


