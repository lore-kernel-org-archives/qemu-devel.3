Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9132C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpzu-0001rr-MH; Tue, 30 Jan 2024 10:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUpzq-0001r7-A1
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:25:58 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUpzm-00062d-Ns
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:25:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ee9e21f89so36751775e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706628352; x=1707233152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5fUS+DS9RUe0KM5QBvaxTm+3CyQrNHjvnhg9wQ9/00Q=;
 b=nXKSi5cW7++1knHgDFssO1V/RNnJ04Xrtbh2ZEITeGReCrznCdPqSZXuc9EC7YD5m8
 ByghZKxux4iRFPMqhOTHEck4OxETgUWRVL38MA/gGWi4wnOv7KwlTSJCau1C5pTsOxU5
 bPvDPgGq7C5iSTDVQoBtMc9t9imVBTMZqSq+1/RvVthFnBSVaqbbyf2tN1wFj+favndg
 cQieZehD4IDZGfI35xG3rSzdGmIqRb0BDO5FTv9ldccsjv4HcZ9pvT1G875SgTjf6ijB
 5qTfkYc2GvoCYuiMbe13B2ksT4Ji7cn5paxpO6JY0QK7kFWwl+a9FqGkpiTQ95bCw3Iy
 XMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706628352; x=1707233152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fUS+DS9RUe0KM5QBvaxTm+3CyQrNHjvnhg9wQ9/00Q=;
 b=eelMnRolaDccjnx5r/0zeD0ZsZiA4RvjNcYQnBz/+t8Vf1jc1TwyRdzERA4TPjVi84
 az0NvK9qQYY1K4U+RSsNyp2qXV9Ed/li4cljQLZHFTTYU/zHlADX4jO74awxG25LxhCc
 BxPdytDEUB6BJFh8O///gAyYM5yUcBI1P8E01MVqezje3k9lhY72upm9EKy3MnWM39Bj
 HFLzIjmTKjzhHHbe6AAgRN75sx0e/uIINpwVP3Z9W5ZKSgH5MM4woiEE1YiApS2ZF38h
 o7uafgt7rTUEZmITJgQb6uDgXCWYJ2zJBy1ppdA890FfEyh1+tjeEL9nbG4gzH+X++rP
 qewA==
X-Gm-Message-State: AOJu0Yyg7NxSCQv+vb3fYEAg6leBiZ+glM7g5Cki1/sWkMMxkGkCl4v0
 XB9v889T3zKVzQKGLoMyhmSDU4p15X8d9FOlzu/jik/Gv3/MFZ8XCqK4TXkL9UJc8sC8nyvPnj/
 3
X-Google-Smtp-Source: AGHT+IFUeD8eSdz5DDTUVU8z2BUermZQoqpYLGUwbck0YZeFY7r/jQyLduYpvU1C+6gfh41i109Yqg==
X-Received: by 2002:a05:6000:78d:b0:33a:f681:699e with SMTP id
 bu13-20020a056000078d00b0033af681699emr2348018wrb.21.1706628351679; 
 Tue, 30 Jan 2024 07:25:51 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05600c444300b0040ebfbff33csm17508462wmn.36.2024.01.30.07.25.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 07:25:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
Date: Tue, 30 Jan 2024 16:25:48 +0100
Message-ID: <20240130152548.17855-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Similarly to commits dadbb58f59..5ae79fe825 for other ARM boards,
connect FIQ output of the GIC CPU interfaces to the CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f..ffad058107 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -246,6 +246,8 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(busdev, 1,
+                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ));
 
     for (n = 0; n < 64; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
-- 
2.41.0


