Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C048C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPCz-0005Fu-BQ; Tue, 23 Jan 2024 17:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPCw-0005BS-KB
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPCv-0000kL-0Q
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:25:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so26335165e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048723; x=1706653523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHwCEbu45pXTY5w3owTg7wqVENSPbbC1Vt4bbpMAXmk=;
 b=HOJUGhsOxe/2GABOH1pVWch/rp3Vcb/yfxMUHNiUg8gvDd3t8TZqeuhpC6A4f8XI5W
 ggBULe+/6eFXTayWATeBcoMQLEDZbaNUsuxJkltoyKcrwvb9P2YUe52gF/qXsUZEQr5K
 76b6UJzNJwZxJ+4egMMbNCZNYXi4tCp3FlRGoG7W0TlWIIEy6fAopz9Md1RXHL23ZF7H
 YTGb6YNRnWacOtU9G1sw8mNnAGy2VL0DO9jm59/Y42HvuGfmuvLgIGNbtn+Nz2AKwRBU
 /LRxFnxMw4f1zeIf3DV/LICKjLOm330QpzxQtZFfoAYrPc2cyVR2bBlt4N/JuovFWCNk
 lvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048723; x=1706653523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHwCEbu45pXTY5w3owTg7wqVENSPbbC1Vt4bbpMAXmk=;
 b=rwPoDjJIlnGVr+oRjZcqeUE63EtQXzCEUeaX6dwkf0zQysm3yE2frVgkOz7QrsVUNg
 M3tpJe2ElKw9y8pdS3AZwGj7GM0eqM/d3Ou0p6AlPtM0DyJr2d79wSzYu8gqDswbF91h
 Nm5q2Tm1NPxUystdQhkjFzC0Lnpa2cOmh6mVOqk8oPXasDe3raXQ/MQzVVHYUpQZfAeM
 OjDQRRz/aIwZOEr4ec0Zo84QhvypB82j035kKOt4fJjFxo2roWtJ/3nDk/TFvyHsb22O
 McdKJHz4MWtzmiE0HsZ2aZ896rNYLJ3QPnGz0IteA2k6WZat8VbjelvcLxuLw2LJPZWL
 ag9Q==
X-Gm-Message-State: AOJu0Ywm12yIulxllAIQ2H1fmyyee3dJmZ4Li2tXXHX30UJnvneHaLBR
 QDnndc9JK7Opj5iBY3zsELogjzHky4wEUKhQgoReqRbFMD3rx/Y/YvtQenR+WpsgGWr8U0Yeqg1
 l
X-Google-Smtp-Source: AGHT+IGvWXSGaIR4KVD2ZQ53edAPu1y5cUoNP/JjdlAS2LQPRnT3ju2BNQSFzl8YKnbTgnZlwhaslQ==
X-Received: by 2002:a05:600c:5118:b0:40e:a7cf:10e0 with SMTP id
 o24-20020a05600c511800b0040ea7cf10e0mr585083wms.20.1706048723393; 
 Tue, 23 Jan 2024 14:25:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a170906090d00b00a2c11a438a8sm14779574ejd.25.2024.01.23.14.25.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:25:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/arm/exynos: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 23:25:04 +0100
Message-ID: <20240123222508.13826-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123222508.13826-1-philmd@linaro.org>
References: <20240123222508.13826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
valid CPU type.

Instead of ignoring invalid CPU type requested by the user:

  $ qemu-system-arm -M nuri -cpu cortex-a7 -S -monitor stdio
  QEMU 8.2.50 monitor - type 'help' for more information
  (qemu) info qom-tree
  /machine (nuri-machine)
    /soc (exynos4210)
      /cpu[0] (cortex-a9-arm-cpu)
      ...

We now display an error:

  $ qemu-system-arm -M nuri -cpu cortex-a7
  qemu-system-arm: Invalid CPU model: cortex-a7
  The only valid type is: cortex-a9

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4_boards.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b0e13eb4f0..01c7618a67 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -34,6 +34,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "target/arm/cpu-qom.h"
 
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
 
@@ -150,12 +151,18 @@ static void smdkc210_init(MachineState *machine)
     arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a9"),
+    NULL
+};
+
 static void nuri_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Samsung NURI board (Exynos4210)";
     mc->init = nuri_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = EXYNOS4210_NCPUS;
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
@@ -174,6 +181,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Samsung SMDKC210 board (Exynos4210)";
     mc->init = smdkc210_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = EXYNOS4210_NCPUS;
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
-- 
2.41.0


