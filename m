Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfU-0003N8-PE; Tue, 30 Apr 2024 12:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf6-0002RG-LU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0005eA-NT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41c7ac6f635so13902115e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495735; x=1715100535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LtC2ukBtLcznvbta9ngdt1XG65ofiBEXAwt4ErQnTsE=;
 b=QlTid0pqp/gDoerwPSDbR1SxmxYs11ITV8+S98/CLb2exJZFs6MVrPPfTKHwj2aeDt
 QMGIY/D9qlkHiPVApJHHUSeu5/JJaWeOUhoYQGix9z2DODcixhmX6tYPP3oBDopXqPuC
 1/VIAN/2Uy1xM4fiQ/4p4rgo84C/zxpV90Xeudy5vRd2wIb3usD3v4gLGTaGNYiTo8BQ
 01PIOa1wnw0K8fS2FFAibM2IxPzoqML2v/IYuP25DIzGiWrbd6+Y9gBatQ89SFG9WtrI
 4A2DNOaR2akg3Yvs0SiMSqONuwk81ArSxEN2MHbwnQNMcXwMOt0TYeafsmPZeIraGIk+
 N2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495735; x=1715100535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtC2ukBtLcznvbta9ngdt1XG65ofiBEXAwt4ErQnTsE=;
 b=DpLxeGacyMzjAysVXtGRXO7hjvtPbqUjv06mPviS2yJH1vsd6q5+/7Hp0bhexo7+oO
 LRBo5JVW1GiT4q7khPd5vvHLSIlkT7JwAo1oAKfWNTfAgmV1OIbyeZ4OdK73iWtEP7ij
 kaYo294ZSLB0PotJwiRx4X+1m3eA6Nry96ZGBraSQa4AN6PsuqQUFTpXNAWTU5Vgn4S0
 +FtebyjYZeAZhhHOkoJQ/VZMqFiu6sxJIu8EQ8xjP7PET1pSjAbj4jVUoL14Qtm/XgtF
 NWdK7jcpqNVgugFWn6MT6CmVOKrR2JQAcLHJC1IjNXjXQiQ5vJlLkvkhFtPzor0wxp3Y
 w9ew==
X-Gm-Message-State: AOJu0Yx4GvNpbs66yNN/CGUtQot3jFTJ3zuxYviCyl3einqBQWUbYdim
 c92L+WWsjsR4EOJyozjq4S4Mv0RVhdZQ4ztyloOG63Ac7a1XMGJLW8YnYGckTjp26v/nUlWl3yN
 d
X-Google-Smtp-Source: AGHT+IGYRQFagYFuPWLDEpgQQdE76fhLexVI+ZKnP9bXizSA8elBeoOzqs+K2x/C3cZQFGKUi1Woyg==
X-Received: by 2002:a05:600c:46c5:b0:416:7b2c:df0f with SMTP id
 q5-20020a05600c46c500b004167b2cdf0fmr77880wmo.7.1714495735347; 
 Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] hw/arm : Create Bl475eMachineState
Date: Tue, 30 Apr 2024 17:48:40 +0100
Message-Id: <20240430164842.4074734-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240424200929.240921-4-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/b-l475e-iot01a.c | 46 ++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index d862aa43fc3..970c637ce61 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -2,8 +2,8 @@
  * B-L475E-IOT01A Discovery Kit machine
  * (B-L475E-IOT01A IoT Node)
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2023-2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023-2024 Inès Varhol <ines.varhol@telecom-paris.fr>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
@@ -32,33 +32,51 @@
 
 /* B-L475E-IOT01A implementation is derived from netduinoplus2 */
 
-static void b_l475e_iot01a_init(MachineState *machine)
+#define TYPE_B_L475E_IOT01A MACHINE_TYPE_NAME("b-l475e-iot01a")
+OBJECT_DECLARE_SIMPLE_TYPE(Bl475eMachineState, B_L475E_IOT01A)
+
+typedef struct Bl475eMachineState {
+    MachineState parent_obj;
+
+    Stm32l4x5SocState soc;
+} Bl475eMachineState;
+
+static void bl475e_init(MachineState *machine)
 {
+    Bl475eMachineState *s = B_L475E_IOT01A(machine);
     const Stm32l4x5SocClass *sc;
-    DeviceState *dev;
 
-    dev = qdev_new(TYPE_STM32L4X5XG_SOC);
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_STM32L4X5XG_SOC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    sc = STM32L4X5_SOC_GET_CLASS(dev);
-    armv7m_load_kernel(ARM_CPU(first_cpu),
-                       machine->kernel_filename,
-                       0, sc->flash_size);
+    sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
+                       sc->flash_size);
 }
 
-static void b_l475e_iot01a_machine_init(MachineClass *mc)
+static void bl475e_machine_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     static const char *machine_valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"),
         NULL
     };
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
-    mc->init = b_l475e_iot01a_init;
+    mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
+static const TypeInfo bl475e_machine_type[] = {
+    {
+        .name           = TYPE_B_L475E_IOT01A,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(Bl475eMachineState),
+        .class_init     = bl475e_machine_init,
+    }
+};
+
+DEFINE_TYPES(bl475e_machine_type)
-- 
2.34.1


