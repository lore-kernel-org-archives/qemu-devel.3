Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD83BC25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfW-0003dC-Ng; Tue, 30 Apr 2024 12:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf7-0002Rl-W0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf4-0005eR-9s
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa2fso37243395e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495736; x=1715100536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a3ql+Sv9E+Sy8+XId1piSDPF0ch2YZ5MielkNrE48ng=;
 b=fxR/iMgLMal83ghTgzBfGjTNbMJUGDemF8sHYTa8kBPyE+2ZIrVnI5+dWhFKFTJmO2
 ++nG7Ck98e91bfEJIDxvgje6fvdubxiINv0YnqRd96Cdavq25fce2dC2sDwZ81bzNPyp
 9oH8EHuL9e+JVdXyayph8YSnIqjfajIUODUCxVkBJrLkeXmG0qxYXmw/sH1QAjzSNUb4
 6+cM4fsU0Df6a65ZbXIFzl5A/yc7nsrnrOAXqNEYCNnUFIKg1vlG6f33TUvPG4XMPjGZ
 iHVyoFfnSJp/81VDOUoYN7lUK1yR4y3A6r+TtlKCZQVR/Dq4dsmPxXpoOhKzqoz58zUh
 w1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495736; x=1715100536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3ql+Sv9E+Sy8+XId1piSDPF0ch2YZ5MielkNrE48ng=;
 b=XwdEWYeng1uKqkmewOQvYw1g5sFp7MqCDvlCEmjJ4LpXJK5zNNDAXLtJ94vtOm2OIr
 CiuSk+g8nb3IDyT3t5XjzbcD6Wjlp7D/yycd/Yn0UgJDCCUuG+oYSeoCKQaLF4PG3J6k
 weanYbXcDis9EcnxT9+P6AdYdMHnk3lAdjXkg4GCPTNuQl/MydwbNKLmoZySAwa9o9+9
 hoU9fu0wVCN7OcmCVNEwZKLT/oqO2K8Dbk9FZdEbfTn/wC2FuBD9DFokLwoGC15SCGp4
 rrDV+Ab2H0rI/21x1ppEOjnm0qG3zLKIFbjAm6Hi2B5kM3CX/JLZAm3aUObvDmOYGM1x
 Ir+A==
X-Gm-Message-State: AOJu0YyXgwdsa3CTRfsRxd4LGimIud9OvYYit2+1aVZTT6rtyr1jU6Un
 Vk3oe2olBHXl2JUtgjVAzo8a5BVSgtt8dl7GfMroPDcp411ogabz4dkNaSr5LNuYG2CZrGx1+9y
 H
X-Google-Smtp-Source: AGHT+IEmOvi969v6he6Yz3buGLv91uDWrLzxlcrjfwQLplgsnSuqPSkxTeBvbaSWsJfspBjwJsDPnA==
X-Received: by 2002:a05:600c:458d:b0:41a:9a6a:41e1 with SMTP id
 r13-20020a05600c458d00b0041a9a6a41e1mr70042wmo.29.1714495735820; 
 Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] hw/arm : Connect DM163 to B-L475E-IOT01A
Date: Tue, 30 Apr 2024 17:48:41 +0100
Message-Id: <20240430164842.4074734-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240424200929.240921-5-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/b-l475e-iot01a.c | 59 +++++++++++++++++++++++++++++++++++++++--
 hw/arm/Kconfig          |  1 +
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 970c637ce61..5002a40f06d 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -27,10 +27,37 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-#include "hw/arm/stm32l4x5_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/core/split-irq.h"
+#include "hw/arm/stm32l4x5_soc.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/display/dm163.h"
 
-/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
+/* B-L475E-IOT01A implementation is inspired from netduinoplus2 and arduino */
+
+/*
+ * There are actually 14 input pins in the DM163 device.
+ * Here the DM163 input pin EN isn't connected to the STM32L4x5
+ * GPIOs as the IM120417002 colors shield doesn't actually use
+ * this pin to drive the RGB matrix.
+ */
+#define NUM_DM163_INPUTS 13
+
+static const unsigned dm163_input[NUM_DM163_INPUTS] = {
+    1 * GPIO_NUM_PINS + 2,  /* ROW0  PB2       */
+    0 * GPIO_NUM_PINS + 15, /* ROW1  PA15      */
+    0 * GPIO_NUM_PINS + 2,  /* ROW2  PA2       */
+    0 * GPIO_NUM_PINS + 7,  /* ROW3  PA7       */
+    0 * GPIO_NUM_PINS + 6,  /* ROW4  PA6       */
+    0 * GPIO_NUM_PINS + 5,  /* ROW5  PA5       */
+    1 * GPIO_NUM_PINS + 0,  /* ROW6  PB0       */
+    0 * GPIO_NUM_PINS + 3,  /* ROW7  PA3       */
+    0 * GPIO_NUM_PINS + 4,  /* SIN (SDA) PA4   */
+    1 * GPIO_NUM_PINS + 1,  /* DCK (SCK) PB1   */
+    2 * GPIO_NUM_PINS + 3,  /* RST_B (RST) PC3 */
+    2 * GPIO_NUM_PINS + 4,  /* LAT_B (LAT) PC4 */
+    2 * GPIO_NUM_PINS + 5,  /* SELBK (SB)  PC5 */
+};
 
 #define TYPE_B_L475E_IOT01A MACHINE_TYPE_NAME("b-l475e-iot01a")
 OBJECT_DECLARE_SIMPLE_TYPE(Bl475eMachineState, B_L475E_IOT01A)
@@ -39,12 +66,16 @@ typedef struct Bl475eMachineState {
     MachineState parent_obj;
 
     Stm32l4x5SocState soc;
+    SplitIRQ gpio_splitters[NUM_DM163_INPUTS];
+    DM163State dm163;
 } Bl475eMachineState;
 
 static void bl475e_init(MachineState *machine)
 {
     Bl475eMachineState *s = B_L475E_IOT01A(machine);
     const Stm32l4x5SocClass *sc;
+    DeviceState *dev, *gpio_out_splitter;
+    unsigned gpio, pin;
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_STM32L4X5XG_SOC);
@@ -53,6 +84,30 @@ static void bl475e_init(MachineState *machine)
     sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
                        sc->flash_size);
+
+    if (object_class_by_name(TYPE_DM163)) {
+        object_initialize_child(OBJECT(machine), "dm163",
+                                &s->dm163, TYPE_DM163);
+        dev = DEVICE(&s->dm163);
+        qdev_realize(dev, NULL, &error_abort);
+
+        for (unsigned i = 0; i < NUM_DM163_INPUTS; i++) {
+            object_initialize_child(OBJECT(machine), "gpio-out-splitters[*]",
+                                    &s->gpio_splitters[i], TYPE_SPLIT_IRQ);
+            gpio_out_splitter = DEVICE(&s->gpio_splitters[i]);
+            qdev_prop_set_uint32(gpio_out_splitter, "num-lines", 2);
+            qdev_realize(gpio_out_splitter, NULL, &error_fatal);
+
+            qdev_connect_gpio_out(gpio_out_splitter, 0,
+                qdev_get_gpio_in(DEVICE(&s->soc), dm163_input[i]));
+            qdev_connect_gpio_out(gpio_out_splitter, 1,
+                qdev_get_gpio_in(dev, i));
+            gpio = dm163_input[i] / GPIO_NUM_PINS;
+            pin = dm163_input[i] % GPIO_NUM_PINS;
+            qdev_connect_gpio_out(DEVICE(&s->soc.gpio[gpio]), pin,
+                qdev_get_gpio_in(DEVICE(gpio_out_splitter), 0));
+        }
+    }
 }
 
 static void bl475e_machine_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e8b6e5e5ebc..fe1f9643bd9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -468,6 +468,7 @@ config B_L475E_IOT01A
     default y
     depends on TCG && ARM
     select STM32L4X5_SOC
+    imply DM163
 
 config STM32L4X5_SOC
     bool
-- 
2.34.1


