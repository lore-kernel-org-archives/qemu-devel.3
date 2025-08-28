Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975ECA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraug-0004Fu-5u; Thu, 28 Aug 2025 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauO-0003hf-FJ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauL-00066u-K8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so1637455e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380908; x=1756985708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+JXna42BUY+PHZn26MLXt9OfmKpXLIHJyS7UYzTkIbI=;
 b=t3v5Zqw5hvBWjYgHt2RidzfjlnEpV69wNX6UGIhJ9wEU5NQjTAgxAwUEnINf/vR1Oc
 gWSBgph8YSImu5wvQwEoYM8xqg1wD06fuuaXpFyH4BD5FZ37IAX1/led1ANa8Oi8TzJ2
 uGaAMEmw9deQ5lXm7KmeZs82DQH3WSKVsI2ChK2E4sk+ZVkhGEgeLnIjaSxUkCbXHJId
 hKvzpSGDTAzzDqwyOFpbwiFRitw0fhdshL88DofOf5eXaPjUYCHl2Ozniz7d1qeptGfi
 bj1MzvzMTC0bWQnQT/Glf0vjcfQLHS6S1z/tJAqTlmVDd+vTrIyX0YfxyQ8BAEweF5M1
 YOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380908; x=1756985708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JXna42BUY+PHZn26MLXt9OfmKpXLIHJyS7UYzTkIbI=;
 b=F/Vb3GBubKgJ1rqr+5frKW3lEe2HlPTvXVlepM7EU0WRwBpjb8dqrN6ekKLj474x2P
 HyFw3Y6yhoIqADwotcaRm/dLVsjg+lwi11aIYFtCyxpTZ4WYiXBRr4WdN6rozcr0RdQr
 dzrU7Nrlv2R5Szq9MsqRDPNGmIjbxA6z3vu7YuigDQo6ek17kCAp5fEhtZSrmIBgNSvk
 ddSYjaU6hHakv3ul4PkuGIYAtjWL1wlUuLEMAaYMoUgUPZYSsqcHA05c6Nq5N9ZJLWJb
 xDkIMnnBum9F03hIuavwbmyc8gnwpZDYpLP+9HjjJ1UHYG76Kv2ITDIN58561ER5dg0M
 ENfQ==
X-Gm-Message-State: AOJu0YxpxtKJyVM1iCZcAmKB7AI4bAWYxk6mkzT/XreIHKgVKx8fEk53
 mTNUFJVfwjF6oiQ5u/buYaIzESPlbBFexxZg3pAzOx34v/tKU0BXxfYH1ZK/ToEsO1QX2Gh0e5f
 Eon8g
X-Gm-Gg: ASbGnctK2I07qssCC3YHMcDBlxdTwJ4CEUYWPZ4nnsMJ5LXVpPnwhObimKHl+sR3W92
 E34BXwpZGYa4UucLqMQ20CGx3EsMLg25e3asw01FB0b03I5IoJI1tLbLVKlmuhb/nHC0iTufS6Z
 DbLJ7GXw2/2w0z2frBwYBy81enB80CZMLNFi61ZKSBOpSII2qaXVudVCZzcYbjdeBFMxrypZHEN
 FJz71XVj+J/3ygj01rZz7TbKjC3Ek3WgbjpV1WvnstMR/Zzo71e31gNF+v8NC6p5l93NDZvoCrb
 wNDjo1PIojMYch86iUQCdYwMz1RCCJPUmOleafWlCl7+RqHkWeKFQsTLq5hegGn4/L9im+zzwrM
 FgeyUQda2lSxVYgYJmcJ8uIV2BMtG
X-Google-Smtp-Source: AGHT+IH+Mt5HgjNrIiJ9CXJsxcGEiHIWTrDKtn2bd2Vqhof5yQFUZg8RujOe61lbb4msO4OBgnLZTQ==
X-Received: by 2002:a05:600c:a46:b0:456:1bca:7faf with SMTP id
 5b1f17b1804b1-45b517ad840mr273802455e9.16.1756380907941; 
 Thu, 28 Aug 2025 04:35:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
Date: Thu, 28 Aug 2025 12:34:29 +0100
Message-ID: <20250828113430.3214314-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250821154229.2417453-1-peter.maydell@linaro.org
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


