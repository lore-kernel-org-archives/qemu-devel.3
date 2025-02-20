Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E397AC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JD-000748-5q; Thu, 20 Feb 2025 11:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JB-00070i-0R
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J9-0008Do-9g
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439a1e8ba83so11053335e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068510; x=1740673310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2xzlx3968bfdrpUp2Jk8ctNVyMvRf/G0SSZ1PJAAEec=;
 b=PP0EEca3MtJMh7jJhT8V0T9Wp27rwr8f8gpE4EOAYwCjpejPZC0apXcUxNckm4kdQY
 jwDPf0Yuv8G5pg9qPY6NKcTXwuZziJoafopSm1WvC2dHl7HgSXF3enIX/xx4BNmYKwiE
 wNs1ScAgfjfbuCbPcdqq+A7eMjzHZ4YJr8uICJVybxbcRJOyT0yW5DKLY31UDscL2CCv
 CQT8r+rAgHBsBTGy7qtg8RCIJFWnGoTPiKwXmuRPVBBPpO+FfbtmkTAhcIMHeHgDtwc1
 7YR+gkBUbIu2gac/4FUaJMWMbLX1tzvtrQx1T83ey0h3QCUrORdzNIr2fhuNzr34piF5
 1FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068510; x=1740673310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xzlx3968bfdrpUp2Jk8ctNVyMvRf/G0SSZ1PJAAEec=;
 b=FOo/+0O+vBt8yU6Xu27lhhK7w79zy5ytPSx5liGVjmPGteRqsA4akkdgVLoFA+pkV2
 L70VfeCKJHFP/bgHT3QtzRxpEMQwj8LUozyFWeRNHMdalpAICfpq3T7k5+37Tk7IhGkn
 5yF4Lz+dxXU661Xqg28tR589bFd8q1yEK81ShlWmEr44BI8h2oa2xNtJy2Hrh5b91umf
 7Et5/PTTpt17lPV7w859U6UseB6TZCBRrSI8tKpy6eMvrRHqqkaTHMcU7AaaMTHQXuT3
 Ov5u/8JETo4whJb++uTDKBsbE5fH6w8+K+5R8KNd0tCKj43r7IkMucxbXat+p6dexEyp
 IS6Q==
X-Gm-Message-State: AOJu0Yz3BHYUljT91KfT2TXP8en1h6GTEntHrZjetf1gVAUEIbCqNKbw
 IPNtmKNEieLV4cDdlYoXqOCYZ16n/XClMqYVGe53vw6ZBYCfJi/SWTVbIazCR3Qd8UQ6TwCkHN/
 H
X-Gm-Gg: ASbGncuv4B/7nOFD2DULJlaG611NjjutJFhTtP1LPeB5STjvWVMI6yD+pER5oWh94Su
 o+G91o8PVVs2SSETyZA+dbDWKvGbv31dfUW0DKUdaS10NRPRZn4iaF+u3pIr3c2iwUqFM1k3EZn
 2UlooL6xuHMSRuy02N5CAImM1MuDMyfeohY++IVKZWNwgYZ0v7UcsGtLlYjRYObYj2uSCeTFBMi
 ngb5SUmVrEE/W6d6Gv2En9QhV1oOvah3LxAT3d8oDN60anFeAW+CCTnJdTRy2OnlS37QW4EcSfL
 Yjj8PS4F7nRMpmpTL5MHQQ==
X-Google-Smtp-Source: AGHT+IGyl1UzFofGQlFjoPOORT3KqH3oKWOyVEIqVCSjQfeMtvqn0MI7+QrL5MqI6CQiH+zGWnqZFg==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7326 with SMTP id
 5b1f17b1804b1-43986fb7498mr141178345e9.22.1740068509560; 
 Thu, 20 Feb 2025 08:21:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] hw/arm/xilinx_zynq: Specify explicitly the GIC has 64
 external IRQs
Date: Thu, 20 Feb 2025 16:21:00 +0000
Message-ID: <20250220162123.626941-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Looking at the Zynq 7000 SoC Technical Reference Manual (UG585 v1.14)
on Appendix A: Register Details, the mpcore Interrupt Controller Type
Register (ICDICTR) has the IT_Lines_Number field read-only with value
0x2, described as:

  IT_Lines_Number

          b00010 = the distributor provides 96 interrupts,
                   64 external interrupt lines.

Add a GIC_EXT_IRQS definition (with a comment) to make the number of
GIC external IRQs explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 22c0bb17262..b8916665ed6 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -57,6 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
 #define MPCORE_PERIPHBASE 0xF8F00000
 #define ZYNQ_BOARD_MIDR 0x413FC090
 
+#define GIC_EXT_IRQS 64 /* Zynq 7000 SoC */
+
 static const int dma_irqs[8] = {
     46, 47, 48, 49, 72, 73, 74, 75
 };
@@ -205,7 +207,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
     SysBusDevice *busdev;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -261,6 +263,7 @@ static void zynq_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
@@ -275,7 +278,7 @@ static void zynq_init(MachineState *machine)
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
     }
 
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
@@ -458,7 +461,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     };
     MachineClass *mc = MACHINE_CLASS(oc);
     ObjectProperty *prop;
-    mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
+    mc->desc = "Xilinx Zynq 7000 Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
     mc->ignore_memory_transaction_failures = true;
-- 
2.43.0


