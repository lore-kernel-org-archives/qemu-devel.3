Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE54CC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZFR-0002IT-KT; Thu, 30 Jan 2025 13:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFD-00021a-D9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZF9-0001FU-7D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:26:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso8246305e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261579; x=1738866379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94QBa4qt+xo//a/TAZxbNnQCwPiwQSuLzPc2Zl2fPdo=;
 b=XBtH51ix7t/gO2fFedpKQso+LwDR+J++z2cSPHGW7/WLsIrhYLaUWIRwbFi8fHq0Pa
 xN4pJDASngTubW5LmReEu+KBqmvZbzoKLjqspRzh7vbQRU3eN1R2hD9qoGamchL8bPwU
 lnspeU/OA48qhTIrbyxLH2UWlBsQ2aUfNDXNUzqhrfdzNEoDN82JJkpscQlSbgMQ+8Jc
 EoWdWNrDlLmRb8ahEcsbNi6I3E2Fm7GiCOloPaMqzgoFwKdgA5FBHjMl3/QwOHwsw2mS
 tSB+TTLQTA6jW4jwAKsoCwQA1YDuyw8F61bLtz+lrFpPW9Bfjj1czr3VP7pTjXV6Ijeg
 4JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261579; x=1738866379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94QBa4qt+xo//a/TAZxbNnQCwPiwQSuLzPc2Zl2fPdo=;
 b=E0/h4Hc+hRbWlKayaGnRjrffoBN9iQkUeL3b/ApJ0Us0y7kNPfpW2w5+sRp5DaJYS0
 +5Y8srBgbI6fHfVk3EC7RGF8HWwsY9Wl3hHAaiQ6uldL8670ee2mOmnTP5bDlPKU/fNY
 eoboUPOU7/vzN/zwPY3z9iVskTiL5cbhzwwY9NdEUNxsfV7xdwmj6D6Anyo/YWy8oHUG
 9T/ulen1fo9WAzwNY+lpbKPHxt6sxL3AGHtgoRGh2HQ3OU9MYdl+CCkinWPMwwMAZdUJ
 epa2WWBbdSAJxP2kil+/4+mFLt6pfobHj6sWtK1gYjirO2fNEHZAe5x106M4TpPZ85Aa
 vHKw==
X-Gm-Message-State: AOJu0YxuxtwHu8b/6XNynL1jUTA+oa0Tp0vq0fEa8cq2/91/hFjGwmty
 kC7I8MYAYsSQ3HEKCIQbUIi1qT1HX3b0rMAlyBOKey/XTxMgaMuuvbyprFpqWFni0lzFrZeLuJR
 JPQ4=
X-Gm-Gg: ASbGncuG9rLGnGJ3Y4nEKNcgWjTqLGFnCGcitPa1IvwL05bfF0LwGH0Njh7rRmqYre0
 6gF65KUzOILK1O6L7aup8xo8+eFY5bc3kbJSV0IG63QGPdj5Rtb+4g/pqfJPzhmBG4G1S9zjWsi
 4EWuhD+v1GxxHYX+LVYepAvNuU2oZHbqR3vml2jJVlT71J0WEeCLhpNKFAAeBPqrD075+HlQBdN
 OKgaBagUmLHaXNN+WID2/B9kfqNnwlf34fXufmmfEcTvJHrfTuADJEyCEOcfQa7cspzTBTaWBlr
 T7S1gOmVnVYTNY6SyfFKI19l6tCt6iZg2GjR4jytOA8OAjxOpPRwVz69rQORv6wmhg==
X-Google-Smtp-Source: AGHT+IGsdUfAeFeg5x6bjTqFAaJWFFBl8Vb+CvNmRzeSdOcjaISqRtsMtFqcW+Ud/PXQiHhuUoSQJA==
X-Received: by 2002:a05:600c:4e45:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-438dc3c7c5cmr81958365e9.14.1738261579203; 
 Thu, 30 Jan 2025 10:26:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2ede0sm67053955e9.21.2025.01.30.10.26.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:26:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] hw/arm/xilinx_zynq: Explicit number of GIC external IRQs
Date: Thu, 30 Jan 2025 19:24:38 +0100
Message-ID: <20250130182441.40480-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 18051458945..dbb003e906a 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -57,6 +57,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
 #define MPCORE_PERIPHBASE 0xF8F00000
 #define ZYNQ_BOARD_MIDR 0x413FC090
 
+/*
+ * The Cortex-A9MP may have anything from 0 to 224 external interrupt
+ * IRQ lines (with another 32 internal). We default to 64+32, which
+ * is the number provided by the Cortex-A9MP test chip in the
+ * Realview PBX-A9 and Versatile Express A9 development boards.
+ */
+#define GIC_EXT_IRQS 64
+
 static const int dma_irqs[8] = {
     46, 47, 48, 49, 72, 73, 74, 75
 };
@@ -205,7 +213,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
     SysBusDevice *busdev;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -261,6 +269,7 @@ static void zynq_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
@@ -275,7 +284,7 @@ static void zynq_init(MachineState *machine)
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
     }
 
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-- 
2.47.1


