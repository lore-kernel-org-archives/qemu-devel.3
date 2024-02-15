Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903E0C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rad0i-0006oN-H9; Thu, 15 Feb 2024 09:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0f-0006kn-K8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:47 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0e-00073W-2K
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:45 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a389ea940f1so122037166b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708008402; x=1708613202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvJ+w++PMP9Jr9Dkgf+8l14WEtpiGiCahalhYRk1Dhg=;
 b=MXRQCJx1CBNlpvlxY9SUSa2ItkHl0w8YmlS7WW+xTmE/yKfKx9FL0ubFTtROCfAyZb
 9YBxfwD1gsXOIDHNSTwsGpnRMj+Yzx8sKiWk3AYvbi8bQLSXXzq2wKDCxzY9VkXHU9mB
 JBIn5Ay5yLvOMPytdk3rs0pmMI98e/YYR0pQzBEMbWV/oSabessMDXWMz9QnuTtpqXCO
 OsNx7PPgyKlkYCf+od7ebz2v5C/a/fdsmkijNtFqRX27xXTnN7v/gDMlcINL9/65MaHS
 njA1T/L+6qCh8wra+ijCjgQVa1K8WAEMc+u6yu8XDXZ+Ziuv27drbJbia8fpSI4OdH1t
 5Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008402; x=1708613202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvJ+w++PMP9Jr9Dkgf+8l14WEtpiGiCahalhYRk1Dhg=;
 b=Fkl8DyEPfPuIAcb2tJXpHrXIWEp5t1xItsRLwkU0viddGRRKM6/zpUFnUAUqUqbMOK
 BKEL/2TReHCWrWherqx+0eI+o7xbpuerUqTZCQYYqMbWP7QZiLPYpEwF3zDbNLB6TlmD
 HBaeVVeltqfx8XmP/rfCOa70J7TIykfQzclIhpA6pvmrIYqW9AA0gPNuau/BfmRGFJ/z
 lwWKxy+Zlhdzeyc4OAtXBHvwLFpNxf01CY7qWI/31SV1UToYanBNy7bA7RLD/VDgIEVN
 x5A8xNLXz2KOYD6CeoLcAod1u6f5a+j9yvLiMcb8FFmhAott/ki8fA0XJMwMRB0FHmh2
 ut6g==
X-Gm-Message-State: AOJu0YwluocXAbtXSDepwzhLPs7BOmkCFAj5Gp+7EYKVzDUYMh9gP4SO
 msnO0g8npYo6pNj6RJvSce0XMGIDUOvp8F6j0SX/J48oYp1Zgp2OFL6FHPTYUPP18qFX9W7MP8t
 kMhE=
X-Google-Smtp-Source: AGHT+IFzgfrDgkqh5AUbdfbpRMNFkbzwtPT3fXa5Z9u3LaksKb1bjtTljhdvCe4tywCLNr5T922iYw==
X-Received: by 2002:a17:907:76d1:b0:a3d:9435:5805 with SMTP id
 kf17-20020a17090776d100b00a3d94355805mr1425473ejc.13.1708008401884; 
 Thu, 15 Feb 2024 06:46:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 rf14-20020a1709076a0e00b00a3daa068f76sm341597ejc.65.2024.02.15.06.46.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:46:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 3/3] hw/sparc/leon3: Initialize GPIO before realizing CPU
 devices
Date: Thu, 15 Feb 2024 15:46:22 +0100
Message-ID: <20240215144623.76233-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215144623.76233-1-philmd@linaro.org>
References: <20240215144623.76233-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Inline cpu_create() in order to call qdev_init_gpio_in_named()
before the CPU is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


