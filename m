Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBD4C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxa-00022T-FZ; Tue, 28 Jan 2025 15:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxZ-00021x-BA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxX-0001Xu-Ly
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283dedso64251125e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095198; x=1738699998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=80kAnCOayAaFJolt/KSDHcWzfkBkXaKdOss7q1dLqIo=;
 b=mV8iJSD2AYUsYyapKcVNRrZ6fbKMrSYDO+SHkwAn3/VzkK1qgAH3j90ZKgPPzP4JRp
 xzzP7qDGzgIbGP+57veC3f5ool0iGfE/Atzu4cC9ITRbt7EL/AVWcaH4i5ofucriGfiR
 5R9SKMl4tt0XomrxV9M5X1WMCioapcUqgM7Np2h/YxemaklUikrO+GUt9Q0kC6gxbTzQ
 ova+FIzuFiVIKR04/o4hvQdIumhOWnkQB5xQM3dXlw/P8GuyiJLrgI7kIO7ZrUF3c498
 fnD0mNg5pGNWxyvBLWDKhsHzNRUhsX1WiDVR78hrghZG4mVza+24XZtNXYGYEeyh19vc
 aUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095198; x=1738699998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80kAnCOayAaFJolt/KSDHcWzfkBkXaKdOss7q1dLqIo=;
 b=PTRXpscF3cN/v3U0S8+uCGdZYiwduUsmNm8r7EDq6//ouKYy3p5OfkbRQ3IEOQ21aM
 V3qdcPhHnicezO4AFmtDbL0ePhawF3lz7WDtiOooTclSDB/VJqY87NIGWypU5T5zUYq/
 f3qje3bkMxZbeHYrn1CqiSgn1+OZQaZt1qXxF5fI9jQSYGxGGC/GvzgjKTBA+LuFcaSK
 JUNwf1DuQih/X9cQtDeHi9GZzz1k+iyHw5KlAN9rRH5s3Mb5YZkYPUYpG3sWQ7rErhmx
 P+lsAUAEp3snK61H6zXIgXdg+CPNylJ4Qs3nyad3rIRryQH2214zs2EcisO96WIKLZgN
 Dyvg==
X-Gm-Message-State: AOJu0Yzqya93eNf6iXOFKkfKT5wmPzX50aIHU7dR2i2bsUoOEA3119NK
 /GTLoao/jNjVibblCvvexmLHCKJcnOzWew/hb+tuAh0JhGXxpBpRGq5l++QRlC+VzWtIUl4yHPE
 7
X-Gm-Gg: ASbGncstchY+BWsPhO7FJ7ju8NZUKoLgdagnHcav0u18UOafU/dCH6HfgFVHbIY7iFc
 2P3F9mNU6tSI9f8CI3EtXKP9omYIlg+BpcG0g/u1RkuieD9fo2Ops7MAi/eZ2gyGDAI0vxOLkhn
 YAH71gkPbqWmQNRW/leqqRWpZbZlWzh7kttTM2WE8S4nvSBwrqhraiQMs3SaT/o30UqX72qzwEc
 itvdIKrzTY13DFuuS76kX/ZAmCfKlBhhI9OaOZwF3UgdFan7Nu05djQ2Ql0ohpteJ31xz1t/7SQ
 ibc0Z+k0B0/TBCu+umsM/Q==
X-Google-Smtp-Source: AGHT+IGl6YdEQ5wOiqrSJk39h2G/amrjbFNHlE4Sod4+c6bo3dYfITfca7a0fClRS1PHhJJzAhDCKw==
X-Received: by 2002:a05:600c:3b0e:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-438dc40d6ddmr2284615e9.19.1738095197721; 
 Tue, 28 Jan 2025 12:13:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/36] hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
Date: Tue, 28 Jan 2025 20:12:39 +0000
Message-Id: <20250128201314.44038-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The ARMv7MState object is not simply a CPU, it also
contains the NVIC, SysTick timer, and various MemoryRegions.

Rename the field as 'armv7m', like other Cortex-M boards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20250112225614.33723-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/nrf51_soc.h |  2 +-
 hw/arm/nrf51_soc.c         | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index e52a56e75e0..f88ab1b7d3e 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -30,7 +30,7 @@ struct NRF51State {
     SysBusDevice parent_obj;
 
     /*< public >*/
-    ARMv7MState cpu;
+    ARMv7MState armv7m;
 
     NRF51UARTState uart;
     NRF51RNGState rng;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 37dd4cf5f40..dee06ab5654 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -76,16 +76,16 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     /* This clock doesn't need migration because it is fixed-frequency */
     clock_set_hz(s->sysclk, HCLK_FRQ);
-    qdev_connect_clock_in(DEVICE(&s->cpu), "cpuclk", s->sysclk);
+    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
     /*
      * This SoC has no systick device, so don't connect refclk.
      * TODO: model the lack of systick (currently the armv7m object
      * will always provide one).
      */
 
-    object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
+    object_property_set_link(OBJECT(&s->armv7m), "memory", OBJECT(&s->container),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
@@ -104,7 +104,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
     memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, mr, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
-                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       qdev_get_gpio_in(DEVICE(&s->armv7m),
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
@@ -115,7 +115,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
     memory_region_add_subregion_overlap(&s->container, NRF51_RNG_BASE, mr, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0,
-                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       qdev_get_gpio_in(DEVICE(&s->armv7m),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
     /* UICR, FICR, NVMC, FLASH */
@@ -161,7 +161,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->cpu),
+                           qdev_get_gpio_in(DEVICE(&s->armv7m),
                                             BASE_TO_IRQ(base_addr)));
     }
 
@@ -185,10 +185,10 @@ static void nrf51_soc_init(Object *obj)
 
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX);
 
-    object_initialize_child(OBJECT(s), "armv6m", &s->cpu, TYPE_ARMV7M);
-    qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
+    object_initialize_child(OBJECT(s), "armv6m", &s->armv7m, TYPE_ARMV7M);
+    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m0"));
-    qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
+    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", 32);
 
     object_initialize_child(obj, "uart", &s->uart, TYPE_NRF51_UART);
     object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev");
-- 
2.34.1


