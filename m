Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD118C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEuM-0004gw-LL; Wed, 12 Feb 2025 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuL-0004g9-4H
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:13 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEuF-0006xP-R6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:44:12 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dcf8009f0so2687824f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375045; x=1739979845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oliSOJgGRKuXOia3Ki/Ch9S5/flKCg89pdGUC7H+JA=;
 b=epen3vHfZRjgsWbgkYYsIDFfE8J9rT9YJzSwSZ5Jtqs1Sd3g9Wq12BegHyNvMnXpGd
 RRTaGRNVqwfU0GRf4vH4WNvBxz8vPwek4R0HnkWxuhp0X9CBx9Z+vBH5OnHPACBmhfZ+
 ywlpTBs76J9MMcDggphHB8qXj1WsuCqsrzpFv0GVc74puVDqYMoQnkNC+xVJsSum/DnH
 ehql6jsoYSvX1FRILOiLq40bDLb4OqCXRfsQdLaZbTuQcQz28kTmBH3wrzomHIjVkR/5
 2KQUoxvqsCO9lf1+fUDXcIRTM26aStAiW4kBcwF2G9vKHaNOzWSMlEkfcr79Rfg6Wvuo
 6mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375045; x=1739979845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oliSOJgGRKuXOia3Ki/Ch9S5/flKCg89pdGUC7H+JA=;
 b=lB1GzsCLSg7XBQSloTD6uSGeVk5XVgbVj6MhabEMRZmNF7L07ODSZ+s10lye2KaMkZ
 jglsaAaqqfkUXr5B3MqsIcZsdEWjIZbIrQmqDHrBhyTHHOuxiX52o/YJDcbHilE9Mrck
 UWKrZJrk4n/l3ySL0/5/ouBrJDtWR9WeuCAHD3XwJe5HElVEMV/jdxNW5XRNv/MaQ3yC
 7VKcAGTVtYS5jGxqzGhVG90Z55TqJjzuomDu/7Pu8pbh/T4X1ohfzpS0iGxvWVOTeyeI
 jEcNQx5/oG+iflpxH0lgvrI9tmIkTfOPSyPsPDoBCaOep3GwGEzsI0ym205E1AaWefKP
 +zxg==
X-Gm-Message-State: AOJu0YxvwLgMJ/DkC09pxo7eoik+P2a0gKnjI8+tsQqM1t0bTQZ+h1/Y
 JxBhCgu/N/y0kwuSP8Ff+uqdHUyIba7M300PpB5qxcR3d57x/s8zzlHSK+PmoWkwyS/vwL/8JCh
 kgY4=
X-Gm-Gg: ASbGncuw9OUwCyQWGtlQpAxiOiF4Z0G1WLe/XJo0SjnhgTPMcMRdttGGqdDoWAHM+6v
 v+18L7IAti9hqMn9ObuOjUPPmwBMpRvV7flX/O7kBdDBbo/ohuvgFXOX4woTqGNEXGnNgoPPVwN
 s3fX+IPYzE8+UZa1M7X7A51jC2SA1nQojjmDXAQIxJeZQ1CCSvBr1KyFWQEGzeDGOSaB0zRNg1n
 zVWONF/nlzR/d4+52CBfuJX4sAIIoEOO2HFyGulyLDu2l244Stnt5wX9Fw/BpLPU/F9Ia6zKSev
 hT39DycxuRE8retehgWH2xjLHFS9zwZM/I7PzE7Oh0/vKLuxz+khAbEz6SoqNqHZPEeZtZY=
X-Google-Smtp-Source: AGHT+IHd5R2VpNQr7AG588XaDShZiuUUZydEUfpM2bAEijmVJVEm7DQrwQDNp72pEk7iWKl70FKrAQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:de92:adab with SMTP id
 ffacd0b85a97d-38dea28c762mr2953973f8f.29.1739375045483; 
 Wed, 12 Feb 2025 07:44:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f22fe1dffsm328860f8f.98.2025.02.12.07.44.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:44:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] hw/arm/vexpress: Specify explicitly the GIC has 64
 external IRQs
Date: Wed, 12 Feb 2025 16:43:31 +0100
Message-ID: <20250212154333.28644-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212154333.28644-1-philmd@linaro.org>
References: <20250212154333.28644-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
IRQs, (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"), and Cortex-15MP to 128 (see commit  528622421eb
"hw/cpu/a15mpcore: Correct default value for num-irq").
The Versatile Express board however expects a fixed set of 64
interrupts (see the fixed IRQ length when this board was added in
commit 2055283bcc8 ("hw/vexpress: Add model of ARM Versatile Express
board"). Add the GIC_EXT_IRQS definition (with a comment) to make
that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/vexpress.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index b886d16c023..9676fc770fb 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -51,6 +51,8 @@
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
 #define VEXPRESS_FLASH_SECT_SIZE (256 * 1024)
 
+#define GIC_EXT_IRQS 64 /* Versatile Express A9 development board */
+
 /* Number of virtio transports to create (0..8; limited by
  * number of available IRQ lines).
  */
@@ -241,6 +243,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      */
     dev = qdev_new(privdev);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, periphbase);
@@ -251,7 +254,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * external interrupts starting from 32 (because there
      * are internal interrupts 0..31).
      */
-    for (n = 0; n < 64; n++) {
+    for (n = 0; n < GIC_EXT_IRQS; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
@@ -543,7 +546,7 @@ static void vexpress_common_init(MachineState *machine)
     VexpressMachineClass *vmc = VEXPRESS_MACHINE_GET_CLASS(machine);
     VEDBoardInfo *daughterboard = vmc->daughterboard;
     DeviceState *dev, *sysctl, *pl041;
-    qemu_irq pic[64];
+    qemu_irq pic[GIC_EXT_IRQS];
     uint32_t sys_id;
     DriveInfo *dinfo;
     PFlashCFI01 *pflash0;
-- 
2.47.1


