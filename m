Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B04C48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPs-0007mp-KK; Mon, 29 Jan 2024 10:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPq-0007lA-H0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:18 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPo-0007Vw-V0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:18 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5102b43035eso3444988e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541555; x=1707146355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFN/VSnR85vSlwmoZKq2ZY9d+Yj3Zr7afXCJn+FdH7U=;
 b=ZuckoVuLyhw8hX5WxonFAIZb5MbI/q1oa5w/jpkjMyq3CRGeHEj3RBeO0RriWpWk8c
 C8ZuKghBmuCITAsEL2LT6geDyKHaf3u4yEP5pa8aDl7WBrJNCgxsMrjCM/pLC3wRWZcE
 AiA6n104kHvqySgSSVI9zdR8Tuo7HC1br7bO6oq3cfjU74YWNPvHNw8vGfpiT+Iqvkmx
 XBTOjaFDLz4rW8XXaoUpPd1BZAhgKrEyEAc9P37OP/WJvq8T0N+ZH0aoW359ZukWsT52
 1kj1deIbD/NnEg8Bbo8Jhu2ciWbz52zDU3ouCFIXDECwFK1jeOMLbgo63nPhWjdCmBwy
 EFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541555; x=1707146355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFN/VSnR85vSlwmoZKq2ZY9d+Yj3Zr7afXCJn+FdH7U=;
 b=neXCv8WBAJcDTCuuWa8tL7IcQQOFkYuZG0NWpyoiu+/xyTGGffpMjtBJMBQIt9rjxR
 JR8bLv6rYeaKEh4XbonDSZ9rd7cj5U4fep3RHNpkAK5yKGLkugeA6DAskSwNO+UADc/8
 XInjKsMUEcPahFJfpOd4vohIKfS1+mraFELchKzAJNfuWtE2TKUZOuRYH9HcXzJ83IsC
 CfHO0gtH2Og3gjS4FDRvI1D9nbHTBBI6Hcxjxr01ChW86+2vNQZgnPjTHXuhtF8tNpiP
 ieHK40iFKfYfaXr+j7pp8JIWh3JsG7kGppzZO/UKDqox9eHWqFBFssM9MQqMFZH72WHd
 MgbA==
X-Gm-Message-State: AOJu0YzIWlDKq7YUiI/XY0TUoWgaYEcDoxbFNLhwl8m5mym/pmp62EkH
 4NgmiqW/te6uYJT1QNTOCPvSthGaxDX4+d/PEa5MnpFxsxtZxRiclgoUHRw6lQuDAv2qUzS37QP
 7
X-Google-Smtp-Source: AGHT+IFVV0TKqCJNa6I7lj2Gk/1zL0MV8sp6Y7+TPcMXX9GAGujPpkTpZ0hVA3T0rlkLk4WnRAFzGQ==
X-Received: by 2002:a05:6512:2209:b0:50e:4098:3798 with SMTP id
 h9-20020a056512220900b0050e40983798mr4357536lfu.60.1706541555036; 
 Mon, 29 Jan 2024 07:19:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c199400b0040ef702a338sm3288794wmq.25.2024.01.29.07.19.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:19:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/9] hw/arm/npcm7xx_boards: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Mon, 29 Jan 2024 16:18:26 +0100
Message-ID: <20240129151828.59544-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

The npcm7xx Soc is created with a Cortex-A9 core, see in
hw/arm/npcm7xx.c:

  static void npcm7xx_init(Object *obj)
  {
      NPCM7xxState *s = NPCM7XX(obj);

      for (int i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
          object_initialize_child(obj, "cpu[*]", &s->cpu[i],
                                  ARM_CPU_TYPE_NAME("cortex-a9"));
      }

The MachineClass::default_cpu_type field is ignored: delete it.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/npcm7xx_boards.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 2999b8b96d..e229efb447 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -465,7 +465,6 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-- 
2.41.0


