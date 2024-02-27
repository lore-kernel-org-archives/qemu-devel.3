Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A13C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexau-00013G-Ds; Tue, 27 Feb 2024 08:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaF-0000hM-5N
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0002q5-5b
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:22 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4129e8bc6c8so23956395e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040799; x=1709645599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HUk8DGkkhSQV5DGWlGNjwA127IMsouq73vscyBxur68=;
 b=GfVPf8nZYAU2zYCoYZOCblCweK7y+fVEhCFDXgomSYrt3w5yyxBDpb2hoh0QM9MOlj
 kw+5uYY+pJ9+hlXMfRLP1ttNZ2G9SDSvYfUYx1AtfpkHP0vL1W1ztpV1Rt1njTtd/RUX
 rtA4swz0JLgESCE0SWV/1yZQyypTSJaMJy1j+1B6eKJw+iHa5eWLqHIWjdl+QGi99sGh
 em8nIQ+qMPJ/ygJ8ozp8ySVO/AC4L93o68hpWMm7rPAXLwXF8l8cUkR/rNk6zNQYNT2a
 Bevuna6LN48+wAIe1gEaFhyFJ3IWZSjgk4hQLRTfXfyacrTHmZ20EYTyi3zrvgHvrLF8
 Ma4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040799; x=1709645599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUk8DGkkhSQV5DGWlGNjwA127IMsouq73vscyBxur68=;
 b=OjTQAucsGoY2uaoZHQZdGxa68ng5kCewMm6TsxBFBtzbzw1ZDZJdWphWhXKIVlONUd
 gfW8remvgxMhv6eTuDLhtiP5o0uoYs3jYiilelChv2KqUa+FYLFKU7QsGIGDn7sTL8G4
 a1epjO4MkBLGqWJOB98KheFiJtxrg84goKXpGtNyfM9dWvREzCCk+5l9RKrhrebBVu+J
 UU2U7/SkvJhnLo3uQ7qsaZt/VBcP5+xe6JCJ3A/EpTUZaclpe+dCsudlZbCm/cxdSntk
 9TwW8ctqAGvg0HnoShmRgIO12ISVveefxJS82Re2aisusk0EPT6It1/eUAqmK/p6F6zc
 pvZw==
X-Gm-Message-State: AOJu0Ywvz0bkbg4mDAzu4K92SESWtjQc6TJEPMAPjbQUzIhE6MtPlgSg
 RWxHft/7PCrG6jia1FfGnkfTw7LcEUC293B7vKpLWP/aogmWT+j8AZzbgq4wi6pTvXy0sX4eTAI
 S
X-Google-Smtp-Source: AGHT+IEPBPR9eCnHznDz/hZiJyVjWPjsEX7q2OyyAR5bmgrImZmkVYYxgvF73FkwffXyJVMESpRV9A==
X-Received: by 2002:adf:f486:0:b0:33d:3089:a840 with SMTP id
 l6-20020adff486000000b0033d3089a840mr7042643wro.49.1709040799527; 
 Tue, 27 Feb 2024 05:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/45] hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI
 fan-in IRQs
Date: Tue, 27 Feb 2024 13:32:36 +0000
Message-Id: <20240227133314.1721857-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Fixes: 52671f69f7a4 ("[PATCH v8 0/3] Add device STM32L4x5 EXTI")
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240220184145.106107-2-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/stm32l4x5_soc.h |  4 ++
 hw/arm/stm32l4x5_soc.c         | 80 +++++++++++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index baf70410b5f..4f314b7a933 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,6 +26,7 @@
 
 #include "exec/memory.h"
 #include "hw/arm/armv7m.h"
+#include "hw/or-irq.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "qom/object.h"
@@ -36,12 +37,15 @@
 #define TYPE_STM32L4X5XG_SOC "stm32l4x5xg-soc"
 OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
 
+#define NUM_EXTI_OR_GATES 4
+
 struct Stm32l4x5SocState {
     SysBusDevice parent_obj;
 
     ARMv7MState armv7m;
 
     Stm32l4x5ExtiState exti;
+    OrIRQState exti_or_gates[NUM_EXTI_OR_GATES];
     Stm32l4x5SyscfgState syscfg;
 
     MemoryRegion sram1;
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index f470ff74ec7..d1786e0da1c 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
+#include "hw/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
@@ -42,21 +43,24 @@
 #define NUM_EXTI_IRQ 40
 /* Match exti line connections with their CPU IRQ number */
 /* See Vector Table (Reference Manual p.396) */
+/*
+ * Some IRQs are connected to the same CPU IRQ (denoted by -1)
+ * and require an intermediary OR gate to function correctly.
+ */
 static const int exti_irq[NUM_EXTI_IRQ] = {
     6,                      /* GPIO[0]                 */
     7,                      /* GPIO[1]                 */
     8,                      /* GPIO[2]                 */
     9,                      /* GPIO[3]                 */
     10,                     /* GPIO[4]                 */
-    23, 23, 23, 23, 23,     /* GPIO[5..9]              */
-    40, 40, 40, 40, 40, 40, /* GPIO[10..15]            */
-    1,                      /* PVD                     */
+    -1, -1, -1, -1, -1,     /* GPIO[5..9] OR gate 23   */
+    -1, -1, -1, -1, -1, -1, /* GPIO[10..15] OR gate 40 */
+    -1,                     /* PVD OR gate 1           */
     67,                     /* OTG_FS_WKUP, Direct     */
     41,                     /* RTC_ALARM               */
     2,                      /* RTC_TAMP_STAMP2/CSS_LSE */
     3,                      /* RTC wakeup timer        */
-    63,                     /* COMP1                   */
-    63,                     /* COMP2                   */
+    -1, -1,                 /* COMP[1..2] OR gate 63   */
     31,                     /* I2C1 wakeup, Direct     */
     33,                     /* I2C2 wakeup, Direct     */
     72,                     /* I2C3 wakeup, Direct     */
@@ -69,18 +73,39 @@ static const int exti_irq[NUM_EXTI_IRQ] = {
     65,                     /* LPTIM1, Direct          */
     66,                     /* LPTIM2, Direct          */
     76,                     /* SWPMI1 wakeup, Direct   */
-    1,                      /* PVM1 wakeup             */
-    1,                      /* PVM2 wakeup             */
-    1,                      /* PVM3 wakeup             */
-    1,                      /* PVM4 wakeup             */
+    -1, -1, -1, -1,         /* PVM[1..4] OR gate 1     */
     78                      /* LCD wakeup, Direct      */
 };
 
+static const int exti_or_gates_out[NUM_EXTI_OR_GATES] = {
+    23, 40, 63, 1,
+};
+
+static const int exti_or_gates_num_lines_in[NUM_EXTI_OR_GATES] = {
+    5, 6, 2, 5,
+};
+
+/* 3 OR gates with consecutive inputs */
+#define NUM_EXTI_SIMPLE_OR_GATES 3
+static const int exti_or_gates_first_line_in[NUM_EXTI_SIMPLE_OR_GATES] = {
+    5, 10, 21,
+};
+
+/* 1 OR gate with non-consecutive inputs */
+#define EXTI_OR_GATE1_NUM_LINES_IN 5
+static const int exti_or_gate1_lines_in[EXTI_OR_GATE1_NUM_LINES_IN] = {
+    16, 35, 36, 37, 38,
+};
+
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
 
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
+    for (unsigned i = 0; i < NUM_EXTI_OR_GATES; i++) {
+        object_initialize_child(obj, "exti_or_gates[*]", &s->exti_or_gates[i],
+                                TYPE_OR_IRQ);
+    }
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SYSCFG);
 
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
@@ -175,8 +200,43 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
     sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+
+    /* IRQs with fan-in that require an OR gate */
+    for (unsigned i = 0; i < NUM_EXTI_OR_GATES; i++) {
+        if (!object_property_set_int(OBJECT(&s->exti_or_gates[i]), "num-lines",
+                                     exti_or_gates_num_lines_in[i], errp)) {
+            return;
+        }
+        if (!qdev_realize(DEVICE(&s->exti_or_gates[i]), NULL, errp)) {
+            return;
+        }
+
+        qdev_connect_gpio_out(DEVICE(&s->exti_or_gates[i]), 0,
+            qdev_get_gpio_in(armv7m, exti_or_gates_out[i]));
+
+        if (i < NUM_EXTI_SIMPLE_OR_GATES) {
+            /* consecutive inputs for OR gates 23, 40, 63 */
+            for (unsigned j = 0; j < exti_or_gates_num_lines_in[i]; j++) {
+                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
+                    exti_or_gates_first_line_in[i] + j,
+                    qdev_get_gpio_in(DEVICE(&s->exti_or_gates[i]), j));
+            }
+        } else {
+            /* non-consecutive inputs for OR gate 1 */
+            for (unsigned j = 0; j < EXTI_OR_GATE1_NUM_LINES_IN; j++) {
+                sysbus_connect_irq(SYS_BUS_DEVICE(&s->exti),
+                    exti_or_gate1_lines_in[j],
+                    qdev_get_gpio_in(DEVICE(&s->exti_or_gates[i]), j));
+            }
+        }
+    }
+
+    /* IRQs that don't require fan-in */
     for (unsigned i = 0; i < NUM_EXTI_IRQ; i++) {
-        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+        if (exti_irq[i] != -1) {
+            sysbus_connect_irq(busdev, i,
+                               qdev_get_gpio_in(armv7m, exti_irq[i]));
+        }
     }
 
     for (unsigned i = 0; i < 16; i++) {
-- 
2.34.1


