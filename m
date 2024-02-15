Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576FBC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag4U-0007if-13; Thu, 15 Feb 2024 13:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4S-0007XB-55
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:52 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4P-0002x2-4Z
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:51 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3392b12dd21so605783f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020167; x=1708624967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HBz0BFjRQZpbPfXihx7764F0fJuLimkLS/XesyXUFE=;
 b=mKiYRlPpADzQBmNc45OY9EOpJfg2T+u2OEIE9HllBb6vx6JXBI8LD/8vtXX4KHOzfP
 EJh4APbB8jiDMqhvdQD5xHU/tUFzmpYejE5eFQjAtnl/aWV/WMrNAepDeghAbXZurS2V
 TORvrts5V2gAhxmBsclx1G1Ojl3OzdgfSgX3QomShOqj4HhGmcoZydHK2R6vthNmC5pX
 g1vvXMoBrEwA7eQNxm1BRqV2RQ4hHDQZK/hyKOEPIvS+VUZkg/vEhK1K2eSmzFavVcau
 qZpP5/R5D1hoorKDEPd423Hk/PrCFuvFEphSBgZ7Dk+77nD5YnviJQEy2WErfxiBSpBc
 TeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020167; x=1708624967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HBz0BFjRQZpbPfXihx7764F0fJuLimkLS/XesyXUFE=;
 b=lLkbXmQwcOBe4gL9AD2JAARDKurnK+LpIyuoovbEPMotzvqIqcuZDI8GzG8vPUC2MR
 KJtGIcByA6o7+PZSZhKxJJWQpPny2d4D2Iq9AsFfZEEnOvk0GpSN6Oa6Z1KqF06NFJIt
 2mhsElugmKpEcH9czbQezGkDsLTzuRoGsFmtWnPfvKNdDyONr/2rgxUHro9U12kkncOm
 BBvZYoGL4eSkoTaNmYJcOmR+5nY9Wa8WlCUsLM2TfA8X7mdI6aBRGhOHCN7QpomTF225
 J73owFKpDApaBqD9RZgYA1KgseXSt5np/S59V/+cMuKwRQZHZVPPH/wFwJvlWjO0sv5i
 ynAQ==
X-Gm-Message-State: AOJu0YyHMdTpx6UJ1cl4izbU7yYPmxUjeTfiP13URorzUc1mnv2A+xEX
 trB95lrvt98Dix0TDM46IC7/VBr87UpJiIMDxKupgh+KnFSF1PlIXXzboPc4VBZPlFOHIcClL9Y
 aAts=
X-Google-Smtp-Source: AGHT+IHmmBr0t7earR6aONHg4OJvxrWjR7P7ZyjCIIHKwiluG1KkNcSbVAeu/6pFludmhD5fF17Mmg==
X-Received: by 2002:a5d:6dad:0:b0:33b:13a8:81b with SMTP id
 u13-20020a5d6dad000000b0033b13a8081bmr2075908wrs.0.1708020167254; 
 Thu, 15 Feb 2024 10:02:47 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a5d51d0000000b0033cefb84b16sm2440537wrv.52.2024.02.15.10.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 43/56] hw/sparc/leon3: Initialize GPIO before realizing CPU
 devices
Date: Thu, 15 Feb 2024 18:57:37 +0100
Message-ID: <20240215175752.82828-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Inline cpu_create() in order to call qdev_init_gpio_in_named()
before the CPU is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240215144623.76233-4-philmd@linaro.org>
---
 hw/sparc/leon3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 44fca1487d..4873b59b6c 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -277,7 +277,10 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     for (i = 0; i < machine->smp.cpus; i++) {
         /* Init CPU */
-        cpu = SPARC_CPU(cpu_create(machine->cpu_type));
+        cpu = SPARC_CPU(object_new(machine->cpu_type));
+        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu", 1);
+        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
         env = &cpu->env;
 
         cpu_sparc_set_id(env, i);
@@ -311,11 +314,9 @@ static void leon3_generic_hw_init(MachineState *machine)
     for (i = 0; i < machine->smp.cpus; i++) {
         cpu = reset_info->info[i].cpu;
         env = &cpu->env;
-        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu", 1);
         qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "start_cpu", 0));
-        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
         qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
                                     qdev_get_gpio_in_named(DEVICE(cpu),
                                                            "pil", 0));
-- 
2.41.0


