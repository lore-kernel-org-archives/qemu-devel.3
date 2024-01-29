Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E8C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPY-0007VQ-UQ; Mon, 29 Jan 2024 10:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPL-0007He-7E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPJ-0007R9-Lq
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33926ccbc80so1804778f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541524; x=1707146324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+KuOhvBtJ6ncQuNPO3pijGi7HTXapiP3L5g0Ir3MJk=;
 b=R4kZi0YQ+OmsBqq0ExBud+W+VOfWZjR8vOe2UAXGyPNZwkJRKEdoC9GQbZcW26Fk24
 qK0KPhV0KT7Mt20IqiG5b/gUdMKT3YmagLCx84goOTr30Ktn21PSYB7HcHHbaXYSayX2
 497ugYmH8bRSfU319pjqB7e1j7rXaK9RRfA5siB7GwI92s9w2iUskQ8hXWDvdHUgXS0l
 Ah+NY1kNpmmxtumPPXwoa/g7wzOELrVgNSCVJNLXJ6FezLV3XRYacazV7WaMhiAMmv2H
 dL+0jYh58+YQ4UlDzuyzOZ+yZRJq/ut1Pdz1oiLl4L/yOqA5RTiDewDXtVNEhp495TQ+
 PjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541524; x=1707146324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+KuOhvBtJ6ncQuNPO3pijGi7HTXapiP3L5g0Ir3MJk=;
 b=pW0geze4a0muR3/Hu7xKRruLG50qcQaedMk5TruywrclU5+9vnDpo3QhflyaxJmJAB
 ra+njZ5esHr23zVjBfbS+pRJXZSIR/XIot1nZTbh8b3vUfD1VNam4xyFjJ2f3GaoNrvj
 DSe8rDFpq9Is9g5CjGf/NfdmXP3TcfY5WQL/fmgeUZJJrwm0e5SkSPfKcexTIWRKESIo
 iGjvVKMxibUc/L4IxFFx2Bveb7ury3nu5eTThS81FDcu3VaGFZEBAYQ8LTckswuy8Bi/
 0BIGPSA2fEtl/Ey650ZguxAGUL3+DW5vvoYjZIxgGlmE4nQAc6KbMe+cgbcXChSmBhpl
 i4GA==
X-Gm-Message-State: AOJu0Yw6a1+5Rs30NWW1QBRbwwUKqMsQ6CjSF9UljtZip7KEe6EgSd/R
 EDobqNtDfOwd11c/mAUWH/6FuehfJTxlYGzxLdBhGUqZO1FWbcKcFwqPqyiMIM4XtsB6dDyYYNC
 Z
X-Google-Smtp-Source: AGHT+IEeODkxxpbrCPljFNWp1VHM8RuudqPMG2/D1j2eRJm7r3D1RA1bzUyhPy5F55qoCSDy8cpa7A==
X-Received: by 2002:a05:6000:184d:b0:33a:f2a8:fcc4 with SMTP id
 c13-20020a056000184d00b0033af2a8fcc4mr1572589wri.59.1706541523722; 
 Mon, 29 Jan 2024 07:18:43 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bs14-20020a056000070e00b0033aeba36b7csm3661786wrb.57.2024.01.29.07.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:18:43 -0800 (PST)
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
Subject: [PATCH v3 2/9] hw/arm/exynos: Check for CPU types in
 machine_run_board_init()
Date: Mon, 29 Jan 2024 16:18:21 +0100
Message-ID: <20240129151828.59544-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
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


