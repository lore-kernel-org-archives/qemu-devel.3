Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E9C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZFX-0002eB-9D; Thu, 30 Jan 2025 13:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEu-0001UF-0Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEr-0001Cg-Vo
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so13210015e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261563; x=1738866363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffy+7tyS7lEIAtYpG0ijLba+piKy+IqvYcNHx83E6nQ=;
 b=FgWrhkx7zCaMt3ym1sk1qH8atNJ/fE/1O2jr359mCjU70+Vp9vI27BBbBqZ+7FzJIS
 DV247SNN0Wa5hLNFqbEfFgwu/nCRLhMj06ohdaTvjhuorzuGeHvtc9JTUX2HlmxHlOVT
 bkYZrTEtjh4vdUMotGgZNF84FV4/f5MG9BZ69laxCrFQ6cIrFY7cc/Zws53Uf4oXaP/H
 s/jBU7cRnBMVx4NGgb6gNoc8H//0oqLiYq9E5r8ByO43Z2BFAhE3jZD5Dfnz0w04A8J6
 DbxbytXqL18tsHbkpp/GXjxeDmDH3aDbGjjY9oIWSFrXnnhT5Yyk1zyS6t2CfyrJlzht
 IEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261563; x=1738866363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffy+7tyS7lEIAtYpG0ijLba+piKy+IqvYcNHx83E6nQ=;
 b=TGpUYjuhCGBN25H+DkV1aK9fN2iPaAfBp7sbyqiSlkPtbAphUV2WRo7aF9tRtQTXpE
 Nj8+ITU6x5ccNvJwppGqALkGkN77lIEQeFNMOPuHN9XZWggwqMklDnpfEN7AAAEjSukw
 b9uHqZDIVMMTibK3LOj2ylEUQihqnb3gLySAkJOkPnOpxR1rzhOzwp36HStiEwbLqikS
 n2oGeF9mDSTr8y5l0+N9KAv5aTrMv7zy3l6aV+7nmrGU1Jg27yBV8LVMj2qtUUq1NlP4
 bigV1tdjDAg8RrFH6MutlZjPCMVHKXzHRDoRLPyQOZ+tHJeX7Bwg0NugIf7RYanlAqf0
 KvMg==
X-Gm-Message-State: AOJu0YwdU7WEppp7Tq2l/ogO1cPzUD8RGUrQywu3sLH4WRaTt6rxFx1v
 1u/ioVBxJFSSsWoVTt/bpJ4tlb6lG3hjnx3BXhcIrXmiYcVZUS3yWDpQIDIb9mOFWzq0IEtOEAI
 2iac=
X-Gm-Gg: ASbGnctTtwmKhb/Drdm/cH0qzlwaAD4CPJScHNUaSNslnPuzKYtwB8VVZealOWE9aaY
 ukJ1g4+lM0RKIQKZv156+KJnjAqYFnDcPyFAxR11+8lg3Sycu1qg8HDHYvqgIMDlN77npGUsDVL
 OHktS7QHtNZOjicaS6BcA6EjASsx2XLYcdyzF4s07+1DEf/8J8Ns75AZk1MbCxoGE/kqJgTE9hy
 iZGjrhiaN5e2vRe5juPhKPYRBOSuTrFBoPxIcX5yswm6VuOS1/WXCeVGfryA3quvygVqRHlT46g
 VP+217GWprNBVnqf8oWwlx1YbCnE8FbqmZHIOg7KzgZY2AdSfCzPHe2Bwzg+DW5w+A==
X-Google-Smtp-Source: AGHT+IH7f5XGgaRZ9mieNBeNd9xko/crn78bm2p2v4xerpPBfC+EuocJwyZ5UUbkTUysmpbzMxe9MQ==
X-Received: by 2002:a05:600c:444c:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-438dc3caef4mr93958155e9.16.1738261562727; 
 Thu, 30 Jan 2025 10:26:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6bf8sm31108925e9.23.2025.01.30.10.26.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:26:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
Date: Thu, 30 Jan 2025 19:24:37 +0100
Message-ID: <20250130182441.40480-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

We already have a definition to distinct GIC internal
IRQs versus external ones, use it. No logical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8477b828745..18051458945 100644
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
2.47.1


