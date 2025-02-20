Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A02FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JD-00074T-FV; Thu, 20 Feb 2025 11:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JA-00070B-05
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J8-0008Dg-6T
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso11627715e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068509; x=1740673309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ZK/UAwAiiXexiYgh++fSpDts9LOc2NmPvR8jt53MdU=;
 b=Hseh6pQ7HpooBATOqKZfsNgL6T+WR+RyZH28NWFT2z38x75cBDDJV5XNgncLlkKVzI
 jkXfkaxSVTKn5kwVRnCfbcbZjf3iIeawH37gBJzAI5cdyOCiRSEJ9GVjYyNmsBqJyMRX
 QndKiUUWIfXnW8xDZ4Igf64Sx7Jctc6cuNrxPyBkfcli5eQoEqx1pm1lE3pziOBctrVW
 Yf3eaDca+GXwlMt/j0fbfcFoAooLNmAuVq6ev6mJRJfq9YbrbqIyOtAIFgKWCthVnN7h
 pLRRA3IZYRf9Fk1UDo7HORoJpRzI33Kse1cqFwEKN0OcQ9AYXCyeUzXOh4uzInPBKZNi
 EygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068509; x=1740673309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZK/UAwAiiXexiYgh++fSpDts9LOc2NmPvR8jt53MdU=;
 b=pNOv6z+qD3aNnyqGmrGrgk4bb8QL8spJcip8mVZMjnRTnzhHPGV7Wd/aQJgPS1oMPl
 KNFMFDVbM3EIELDQPydlUMRYZ8JTOcb2d7bd7ZJUDc3qUScOUBVztniAiG1meX5ntwGb
 BvF3yvpESSKDQTwyLU+8UjvGpqHgrMzQnsVCnXI2jFnBz/5orCKCHf+9OrbkD5gqh1ps
 iKn/oV+p8UpmqqagZvnhM53GtvKVIkrJ6F8nJ1drSCBszcXTZPvs8oHxf0ey3/yMvGJ0
 GtogX/T1zfOGGX2BNLQ8Q77e5aSGKgDnRef3kC7+562TgYmL+krCt+/2Ptf5x1Rvejci
 QFsg==
X-Gm-Message-State: AOJu0Ywnpbw3CWBxIK3gkZvUw9wRhN04p2ASJAklcY9jZixmH2HGzyzy
 ir4/PXmTmEZgUxB3DcYYZZ1hx8i3czraqYbu0ETUQ5r2h+m6+CYJgI7aW9wAEWYJUOgc+3NPUxZ
 a
X-Gm-Gg: ASbGncub7T/XH7nyIz8v+lpVaDTaTXzZVnH8zlWZciz8McInqUcLTKt85hj8Ziq3aS7
 FBzxKPo6aXIO5IahBfLVHoz1fyKixv9NiPeCKMJh2GLMwwU8PLot7HPuFs33rUZWKffWAnREIld
 pqgh6cEix9dMlBXyfn7V5KK5nHBJ/sSupLojC+tz3MoxBBTXT9pgoH4yG7UVXpwXKtSBqmxiMaJ
 8m8Z/MKjDRYMriFDaUikB8WE3jNgqPYq5YTH42qe/kOK3zFdvX0HNHw3lXkJdXVkUU3bomjVgeF
 C+hPm8A63aAChvu8QHWHSA==
X-Google-Smtp-Source: AGHT+IHkh9aICFvDR7ULGqcE6cXMY1KJl/fSAurBQn0M+mkVP0Tng6YdL9ccitMN32rEGrAM1tWQJw==
X-Received: by 2002:a05:600c:1910:b0:439:96aa:e502 with SMTP id
 5b1f17b1804b1-43996aae68amr126423965e9.12.1740068508736; 
 Thu, 20 Feb 2025 08:21:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
Date: Thu, 20 Feb 2025 16:20:59 +0000
Message-ID: <20250220162123.626941-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

We already have a definition to distinct GIC internal
IRQs versus external ones, use it. No logical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3c6a4604cc9..22c0bb17262 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -54,8 +54,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
 #define FLASH_SIZE (64 * 1024 * 1024)
 #define FLASH_SECTOR_SIZE (128 * 1024)
 
-#define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
-
 #define MPCORE_PERIPHBASE 0xF8F00000
 #define ZYNQ_BOARD_MIDR 0x413FC090
 
@@ -281,12 +279,12 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - IRQ_OFFSET], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - IRQ_OFFSET], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - IRQ_OFFSET], true, n);
+    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
+    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
+    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
 
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
-    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
 
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
@@ -295,7 +293,7 @@ static void zynq_init(MachineState *machine)
                           qdev_get_clock_out(slcr, "uart0_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0000000);
-    sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[59 - GIC_INTERNAL]);
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
@@ -303,15 +301,15 @@ static void zynq_init(MachineState *machine)
                           qdev_get_clock_out(slcr, "uart1_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0001000);
-    sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[82 - GIC_INTERNAL]);
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
-            pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
+            pic[42-GIC_INTERNAL], pic[43-GIC_INTERNAL], pic[44-GIC_INTERNAL], NULL);
     sysbus_create_varargs("cadence_ttc", 0xF8002000,
-            pic[69-IRQ_OFFSET], pic[70-IRQ_OFFSET], pic[71-IRQ_OFFSET], NULL);
+            pic[69-GIC_INTERNAL], pic[70-GIC_INTERNAL], pic[71-GIC_INTERNAL], NULL);
 
-    gem_init(0xE000B000, pic[54 - IRQ_OFFSET]);
-    gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
+    gem_init(0xE000B000, pic[54 - GIC_INTERNAL]);
+    gem_init(0xE000C000, pic[77 - GIC_INTERNAL]);
 
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
@@ -330,7 +328,7 @@ static void zynq_init(MachineState *machine)
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - IRQ_OFFSET]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - GIC_INTERNAL]);
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
@@ -343,7 +341,7 @@ static void zynq_init(MachineState *machine)
     dev = qdev_new(TYPE_ZYNQ_XADC);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-IRQ_OFFSET]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-GIC_INTERNAL]);
 
     dev = qdev_new("pl330");
     object_property_set_link(OBJECT(dev), "memory",
@@ -363,15 +361,15 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
-    sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
+    sysbus_connect_irq(busdev, 0, pic[45-GIC_INTERNAL]); /* abort irq line */
     for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
-        sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
+        sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - GIC_INTERNAL]);
     }
 
     dev = qdev_new("xlnx.ps7-dev-cfg");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
+    sysbus_connect_irq(busdev, 0, pic[40 - GIC_INTERNAL]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
     /*
-- 
2.43.0


