Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86414CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7Qy-0000oP-4x; Thu, 21 Aug 2025 11:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7Qx-0000nP-6F
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:42:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7Qv-00076D-9H
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:42:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c51f0158d8so518388f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755790951; x=1756395751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JeASHUX7ghK1asv5wNN7bhhBQ2qCHLmTt5uVBqMdUwg=;
 b=ktR7lQIX7eZ/zL04DB0ulO2O2ryJqNeguAb9Dq2YslmUzy1Pb37xMXCnuzBShUuamH
 Bdc4Z3+MgQOPe7SWE2sqP55lILLKyt4+5mgnHAT5ToUacTnQN6GRkXuniLkVjiXIg95t
 FrTcR6UW835m4OIoa/FeJw3hf2TnH7nSRFFgvFwmSBABdQds0bM3iLcb6L+187DQFMLu
 t/4/oYZ2h5YmmL76Gv9pq+Q88CKN3ZdUEcjacxfJBPHFqR4mgJp6CtbLwMEDJDE+G872
 qRmqqbe35G7uxqvxv6019xivICr6qrNFhzEEP2Dsz2FjoDxVidr9kzt9gc9xWl2MkCKA
 RTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790951; x=1756395751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeASHUX7ghK1asv5wNN7bhhBQ2qCHLmTt5uVBqMdUwg=;
 b=lqoPytTxGG54FtnjGKY9k6H5O4mkgYFVabZe/CSnPDvsZqBUkkmXLEAfgXV+cN3fDe
 R4jvoFGbSSUIQsdIvye9NJTnWO3by89NQgGdFaZdLntsBjYoRZmXQBZANNy3MP8YYo7s
 IZlpRY67bWqNZhuFczQM7ftL1KcMk+I/IMy9K1sSnWEVbZZn5pIUUqhkCmJVC5xY2BCh
 9zh6K/JEs6GslUF8O7y/geJVSUsnnilBvOJDoO8Q2kC1onh43BnYUZl91qhMNN4hasvt
 QFiXcATEQrwU1VcSn4lkkbzak+9zkg8pNNrDuvTLHDcRfkk/a5ToUAx8IeB7IPZIJYJZ
 qcdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbXw611xx/h1U5ZLNQFd4jiJlfIK6VTnF2Nbjpjcriy2wRbek1yIirKtVNsGzN6NrOiYWRnUbc1kzm@nongnu.org
X-Gm-Message-State: AOJu0Yx1WpsUyBzE0cThJFt5fdcuVzoa0P9gLU/hKRuY+X20/7tjA5zT
 zX4QDuV4PQvxvDxYGqizZu5uehxWEw6WYdXMr4qL30Nx1GlWMcnfQ5Yyd9UqkZqJCzLH9Zp+O2r
 +AlA3
X-Gm-Gg: ASbGncunWsN2nw1QMSNdJ+dIR6wkujcipeQZWctP6YAyn5EWMMqCmDFa5gNhKUf0Es6
 HYa1nnsrCmddzRjcc+VVW0RWtUZr5Pm3arlda3yrh2vyN8DGo4kgZEnbn0dvSGpr86SvxYt2u2j
 6fOOvsu1VJamc0kCHXrNHfOiSrHlMAFwLE0pYz1NndRULiH3pSl9L25Hvp2CR3hCcjdm96VIA6G
 YAZJLc3uQQ/S8CAWxkRXXBNJ0a1b3ry9j/+wa6QG/6YI+seT8jW0HD14yPxtOkCK235xhHQDYeL
 l6bassjaeCuM5AhdEx/SPg4sAqE1BL8XyAtulzNm24/57Vt4CxP+fvctaLP2YAJ18bRzYd5aba8
 b8hfv4BPJxPD4TlpNcDgVLk/xFJ5GeAB4cGGABOI=
X-Google-Smtp-Source: AGHT+IGyHjuUuXQBRY7szaWVHtubVY9omspzr+A4WzUI4iXvZJ9nFG6lOjbdMuwdXWMYQlod6xWEdQ==
X-Received: by 2002:a05:6000:4205:b0:3c0:49b1:2a1 with SMTP id
 ffacd0b85a97d-3c4953a8041mr2162848f8f.21.1755790951145; 
 Thu, 21 Aug 2025 08:42:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0771c166bsm12206801f8f.33.2025.08.21.08.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:42:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
Date: Thu, 21 Aug 2025 16:42:29 +0100
Message-ID: <20250821154229.2417453-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In stm32f250_soc_initfn() we mostly use the standard pattern
for child objects of calling object_initialize_child(). However
for s->adc_irqs we call object_new() and then later qdev_realize(),
and we never unref the object on deinit. This causes a leak,
detected by ASAN on the device-introspect-test:

Indirect leak of 10 byte(s) in 1 object(s) allocated from:
    #0 0x5b9fc4789de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 267a2619a026ed91c78a07b1eb2ef15381538efe)
    #1 0x740de3f28b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x740de3f3e4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x5b9fc70159e1 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x5b9fc70159e1 in object_property_try_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1276:18
    #5 0x5b9fc7015f94 in object_property_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1294:12
    #6 0x5b9fc701b900 in object_add_link_prop /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2021:10
    #7 0x5b9fc701b3fc in object_property_add_link /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2037:12
    #8 0x5b9fc4c299fb in qdev_init_gpio_out_named /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:90:9
    #9 0x5b9fc4c29b26 in qdev_init_gpio_out /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:101:5
    #10 0x5b9fc4c0f77a in or_irq_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/or-irq.c:70:5
    #11 0x5b9fc70257e1 in object_init_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:428:9
    #12 0x5b9fc700cd4b in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:570:5
    #13 0x5b9fc700e66d in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:774:5
    #14 0x5b9fc700e750 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #15 0x5b9fc68b2162 in stm32f205_soc_initfn /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/stm32f205_soc.c:69:26

Switch to using object_initialize_child() like all our
other child objects for this SoC object.

Cc: qemu-stable@nongnu.org
Fixes: b63041c8f6b ("STM32F205: Connect the ADC devices")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32f205_soc.h |  2 +-
 hw/arm/stm32f205_soc.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 4f4c8bbebc1..46eda3403a9 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -59,7 +59,7 @@ struct STM32F205State {
     STM32F2XXADCState adc[STM_NUM_ADCS];
     STM32F2XXSPIState spi[STM_NUM_SPIS];
 
-    OrIRQState *adc_irqs;
+    OrIRQState adc_irqs;
 
     MemoryRegion sram;
     MemoryRegion flash;
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 229af7fb108..e3c7203c6e7 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -66,7 +66,7 @@ static void stm32f205_soc_initfn(Object *obj)
                                 TYPE_STM32F2XX_TIMER);
     }
 
-    s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));
+    object_initialize_child(obj, "adc-irq-orgate", &s->adc_irqs, TYPE_OR_IRQ);
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         object_initialize_child(obj, "adc[*]", &s->adc[i], TYPE_STM32F2XX_ADC);
@@ -171,12 +171,12 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* ADC 1 to 3 */
-    object_property_set_int(OBJECT(s->adc_irqs), "num-lines", STM_NUM_ADCS,
+    object_property_set_int(OBJECT(&s->adc_irqs), "num-lines", STM_NUM_ADCS,
                             &error_abort);
-    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, errp)) {
+    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, errp)) {
         return;
     }
-    qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
+    qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
                           qdev_get_gpio_in(armv7m, ADC_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
@@ -187,7 +187,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, adc_addr[i]);
         sysbus_connect_irq(busdev, 0,
-                           qdev_get_gpio_in(DEVICE(s->adc_irqs), i));
+                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
     }
 
     /* SPI 1 and 2 */
-- 
2.43.0


