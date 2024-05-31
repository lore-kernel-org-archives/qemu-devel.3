Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C886C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zf-0004Mi-Rn; Fri, 31 May 2024 08:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0za-0004Jh-07
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zR-0003P2-FJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42108856c33so12120405e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157046; x=1717761846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ZBIBm/wN+aeUH7Z5g50kbmtejeR3zmSdK/oN4Zmw2k=;
 b=E7hi7ePViFL7P+5tvRUxtukwVb8t1qRm97y4Z0B/qM0kpQuWwHzwzF9jn4filPg8Hj
 cAY6MBNzQtFSqag47JLJ6sTuAYYCiq34TSa0uC6qqYgfv2hUnVePXfUGDIu/Mb/AaLaR
 hra6j1ey8E8kC48E0XjuCLpxAcvEosh+kwFe8O3Ec6hmTJYlMr5JxU+9R8nQLmwJn0tP
 zeuPWpmpVrPw6eliBczgtbsW8NZ3mszjP8ClLL7MM96L9narxha/kjzSCW79vcZnXQHv
 g4LahULKHqww3c7e4HzJOfBBFHZL28Hls+Gz5oD+8iE5lLU6OkkQE0QduRKp081ieLhO
 pWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157046; x=1717761846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZBIBm/wN+aeUH7Z5g50kbmtejeR3zmSdK/oN4Zmw2k=;
 b=rUw4FXQIa3aGmR1IT/50uBaloR9MOhQtc+aBE30qU7LQqcNslLlUIq0IJL90UB8bqT
 L4yR79qnrkT3JNKnXKNq8phuUxU+C1STYZWxKzaPHYewyv1PdjQFUIc+6iAK7FnkhAQb
 hPgPTC9V9jpp3RSVeQ47mv2okM5EZXSYOhhScRPCdmb8NSdLJZA7YnJL/jmCCzsWBkPa
 ItOG3ZRcj9YfqHtMYlJhCuIJrL/XPR1qZ8ObyFHMivDYNYuSVPlVdS4EC3K73RRxLARg
 Oi23repvP8hKqROcwc3I6fWKmq8M4YyVjcMDKEk6XxmIMpl8fv179J+zHebkaiA2MkvQ
 nKgQ==
X-Gm-Message-State: AOJu0YxMq1c3UnYNuuhrAHNbdWdorzXl+XPT7PZRUT+6/A+3mQ5Xwoxz
 d0vJXiJXV+bPNzgWIxL2unZJ1y25MlYe9jEeqwX9MNLQT3zrmhwKUh50yFn2iW/Fmy+8nkanico
 I
X-Google-Smtp-Source: AGHT+IHbtOwqyEI4NTQqIB1clLCOvOpxX9Ho51dwaYKoxqg1TZSzWyur7LU3qJA0JouzOcBEVpbpYA==
X-Received: by 2002:a05:600c:5119:b0:419:f4d6:463b with SMTP id
 5b1f17b1804b1-42128115145mr43612495e9.14.1717157045844; 
 Fri, 31 May 2024 05:04:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/43] hw/arm/xilinx_zynq: Add cache controller
Date: Fri, 31 May 2024 13:03:21 +0100
Message-Id: <20240531120401.394550-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

The Zynq 7000 SoCs contain a CoreLink L2C-310 cache controller.  Add the
corresponding Qemu device to the xilinx-zynq-a9 machine.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-id: 20240524120837.10057-2-sebastian.huber@embedded-brains.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 1 +
 hw/arm/Kconfig       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fc3abcbe88b..0abb62f131d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -241,6 +241,7 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
+    sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(busdev, 1,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8b97683a45e..1ad60da7aa2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -370,6 +370,7 @@ config ZYNQ
     select A9MPCORE
     select CADENCE # UART
     select PFLASH_CFI02
+    select PL310 # cache controller
     select PL330
     select SDHCI
     select SSI_M25P80
-- 
2.34.1


