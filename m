Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B94C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthK-0001vY-1O; Thu, 11 Jul 2024 09:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthD-0001VO-0r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-000640-At
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42795086628so5716135e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703912; x=1721308712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/AMAtOWB0ZxCL+R8J/gNQR8gsTJMYguGEneUen0fd3I=;
 b=Zym+GDJI7yfeUIBQgQmTSha6b3BTo9kV3IshCoSMLHGpqD1twLJx4S8Fz4veygtgGd
 dQ6WDtKPYXeDJLrFrrW2+BcZZQ27ZogP3WFcShHFwp+4jc2Lqc3A7NHdwnBKICVKHBzm
 jpm9eVmFN1Omb+QwgqZhmy1btrWxRHYsrtqkFief3Xi+TBswppzmgWGsgsp1fs5dt2+s
 ID5Mq/O9C0NnlzkZHyjLzQ0oFSchp8vWghjv2aEsn+3RmW84vBzyzB+LD5EbvosPXgKW
 Jhvw8xuKGKF4S2T6t0RDRkHxKWcRBn75jvKgKQWAc9860ZkeVcQMsdxuQy3jXyCRVk44
 RJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703912; x=1721308712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AMAtOWB0ZxCL+R8J/gNQR8gsTJMYguGEneUen0fd3I=;
 b=MQJvzRLtXxL+iaYR4zDsf/bE2FRHnEXBD8ryytjROryl8w/Gn/5iTQ0GlTglm3eFBV
 mSSIFm8FtXAUG6Hz0xnuWCerfNWdnqEWSF2VQWMaEpeSqfDcZ7VXvHsK5khuTZ3KmwCs
 TwXf7VLnHN1ag4AF8JFH4oKiKwOgoTI15+DWIWrHb18CFRwRGhDxoUQGKSBYBTUu4JZL
 AaI75vdE1/VzvxQckjpfP0GLT7nQgsE/PxAL8ETiGlGcN8Ng+pSl+0W0QEsRrAcCu4rZ
 hmOvnMXFN6B2FfyXVLc9piBmNvfHeoZpogaZpbLhLxmHPJfPsvynEaD7VHEdoYEYtDNn
 Y07A==
X-Gm-Message-State: AOJu0Yw99PFIZTSrjaFn03Z2ubeIwqcX/aUCEsyFfmTftmJpoxUCJhsX
 TOcH0Tp2Z7scRaMtKv5E7GbY1CsNWgtBQ0VcaCg+SsAICptBBoNvUCqJz0ImpmTysdyKGM0zxb6
 Ya18=
X-Google-Smtp-Source: AGHT+IFClvo835ukzmEAx4gE2nIA4BKRCj9E+zcj/l3UwEtvoU3DqmFzwS1+IZ96CvAr4/4MLtNvFg==
X-Received: by 2002:a05:600c:6d8:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-426708f9d84mr54498885e9.37.1720703912647; 
 Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/24] hw/misc: In STM32L4x5 EXTI, consolidate 2 constants
Date: Thu, 11 Jul 2024 14:18:14 +0100
Message-Id: <20240711131822.3909903-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Up until now, the EXTI implementation had 16 inbound GPIOs connected to
the 16 outbound GPIOs of STM32L4x5 SYSCFG.
The EXTI actually handles 40 lines (namely 5 from STM32L4x5 USART
devices which are already implemented in QEMU).
In order to connect USART devices to EXTI, this commit consolidates
constants `EXTI_NUM_INTERRUPT_OUT_LINES` (40) and
`EXTI_NUM_GPIO_EVENT_IN_LINES` (16) into `EXTI_NUM_LINES` (40).

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240707085927.122867-2-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/stm32l4x5_exti.h | 4 ++--
 hw/misc/stm32l4x5_exti.c         | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_exti.h
index 55f763fa376..62f79362f28 100644
--- a/include/hw/misc/stm32l4x5_exti.h
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -30,7 +30,7 @@
 #define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
 OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5ExtiState, STM32L4X5_EXTI)
 
-#define EXTI_NUM_INTERRUPT_OUT_LINES 40
+#define EXTI_NUM_LINES 40
 #define EXTI_NUM_REGISTER 2
 
 struct Stm32l4x5ExtiState {
@@ -47,7 +47,7 @@ struct Stm32l4x5ExtiState {
 
     /* used for edge detection */
     uint32_t irq_levels[EXTI_NUM_REGISTER];
-    qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
+    qemu_irq irq[EXTI_NUM_LINES];
 };
 
 #endif
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 6a2ec62d785..b9a69a69f60 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -42,7 +42,6 @@
 #define EXTI_SWIER2 0x30
 #define EXTI_PR2    0x34
 
-#define EXTI_NUM_GPIO_EVENT_IN_LINES 16
 #define EXTI_MAX_IRQ_PER_BANK 32
 #define EXTI_IRQS_BANK0  32
 #define EXTI_IRQS_BANK1  8
@@ -238,7 +237,7 @@ static void stm32l4x5_exti_init(Object *obj)
 {
     Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);
 
-    for (size_t i = 0; i < EXTI_NUM_INTERRUPT_OUT_LINES; i++) {
+    for (size_t i = 0; i < EXTI_NUM_LINES; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
     }
 
@@ -246,8 +245,7 @@ static void stm32l4x5_exti_init(Object *obj)
                           TYPE_STM32L4X5_EXTI, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
-    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq,
-                      EXTI_NUM_GPIO_EVENT_IN_LINES);
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq, EXTI_NUM_LINES);
 }
 
 static const VMStateDescription vmstate_stm32l4x5_exti = {
-- 
2.34.1


