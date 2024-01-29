Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3C0C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPj-0007d1-7H; Mon, 29 Jan 2024 10:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPa-0007Xd-Gl
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:04 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPW-0007ST-G3
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:00 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51028fadfe2so3118860e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541536; x=1707146336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcxTw0DrdmCPot2iJuF6Ul0G9M2q8XR4FUwWiq3hCFw=;
 b=Kx01oTFgCyTWmyW3LEUdvqAl4WHKUbrvMjaEyiZxNW9xIsriFzf2PLjvdPlLLSQlmW
 78lEMjdO6StqJ9vk7H3fV9RuO8LF2yVPTEDuR0Mzum6AcWsO5ZdllN+6LYoW69f7u8y3
 1O32nSXOpPAZgy0cHk9pVoJhB+hVJA4AbaVuuYhK0DpuRfKi41rGXYxp1H7jBdroGosh
 qCytnTWqtiT6WbsrU0x3lKVox6cXMuK8kGJfCN6g0Rk8zDJzhDwasmIem6cxf+7XxHB9
 6HdViVIuQAygjZGFbeqwr/6B8C0UlyemGje84RU7EajvOHgSZdfzZjgkr8PzQOT2bqlm
 xqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541536; x=1707146336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcxTw0DrdmCPot2iJuF6Ul0G9M2q8XR4FUwWiq3hCFw=;
 b=OYLUsrOU3agbSPsP1POF546o8n/QG2+xMvc2FbLhBaC7FoCvX47yIqgQrzQd0yIgaY
 BTUnkQsb1MXYDds3y3nE025AhCQwkJHagEDwD7FMiMcw3Itc28dbCrKUlNCbZkUAUq9H
 3ki3tLpcYz4IEotOVcyYRc2QeifPu1pl0dKDwk8raCjfRFjoeVB+t+F5SGtphmKxgmNo
 Age7MLJqjaBGPHyjHDQ6pWnSBvBttIfaQXBQer6jjiqgXhWgGCCtmbFlpTKPEl/zd1sF
 Scp6QT1AIm7AZ+39xtf5H7+maLumpnoI4ihltSmp8MrCmCFjjWsHUaVkH/USX5eV3K28
 Km2A==
X-Gm-Message-State: AOJu0YzrNfKpdoBmvMUbWcmWBJabPRgTgvzJ0TGsweuSn2tCcw72ZRVb
 1PnjXsDAZelzwyoNZujjZCkYyaaXi6Ru+aVimBwLANSQdi657ibdJbv/sG6Y2Wicx9JX1QRdQnr
 9
X-Google-Smtp-Source: AGHT+IGJ+K2soQbrnFpE0uHIy3dUelT8wTnsBiwb6mjdWdSQoGzDAWhvlSaahpYUovWRPHn8Lfw8Vg==
X-Received: by 2002:a05:6512:1194:b0:511:f63:142d with SMTP id
 g20-20020a056512119400b005110f63142dmr2403017lfr.29.1706541536685; 
 Mon, 29 Jan 2024 07:18:56 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b0040ec6d7420csm14208710wmb.14.2024.01.29.07.18.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:18:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 4/9] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Date: Mon, 29 Jan 2024 16:18:23 +0100
Message-ID: <20240129151828.59544-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU types.

Instead of ignoring invalid CPU type requested by the user:

  $ qemu-system-arm -M midway -cpu cortex-a7 -S -monitor stdio
  QEMU 8.2.50 monitor - type 'help' for more information
  (qemu) info qom-tree
  /machine (midway-machine)
    /cpu[0] (cortex-a15-arm-cpu)
    ...

we now display an error:

  $ qemu-system-arm -M midway -cpu cortex-a7
  qemu-system-arm: Invalid CPU model: cortex-a7
  The only valid type is: cortex-a15

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/highbank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index b8d702c82c..0367050697 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -345,10 +345,15 @@ static void midway_init(MachineState *machine)
 
 static void highbank_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Highbank (ECX-1000)";
     mc->init = highbank_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
@@ -364,10 +369,15 @@ static const TypeInfo highbank_type = {
 
 static void midway_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Midway (ECX-2000)";
     mc->init = midway_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
-- 
2.41.0


