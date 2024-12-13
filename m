Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3BE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2W-0003h4-FK; Fri, 13 Dec 2024 14:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2J-0003Gx-In
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB22-0006bU-HU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e19fee3b3so1670011a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116935; x=1734721735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LscTgJ5P5TtEk/dzbWNj9LwdfZF1GUDxnwbVdr9OdtQ=;
 b=GwK7lDrUTcJ136FmZ6EVvIFdPeYAocA8BmX4vmuH4jcjjMdaE+KW9x1ME3GqGQ4jqN
 luUWsuQgpOYZlxxexTho1ZAU5W8dlGr6Y961bMQP1mItebv+oxby5QVwK+ly/VB6v08f
 c1Vo9T3/9M94pPlxwKajFPc0AoxGyEvofC1PqHaG9S17uoL98OU+ZhK1Zd+96SFIT79g
 fKaVi4wexJbo9fnWAJdnA6fz5E9rCco+5otsdqbGxIkmrk0Ky9U1RJJDgJeMT54jc5FI
 f6eOJhWidJ2QHcU4kp6AldaaB4GlAotSmPeckuFsmgWjgJF1vUg/4rICqXwiBjgyDycP
 NorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116935; x=1734721735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LscTgJ5P5TtEk/dzbWNj9LwdfZF1GUDxnwbVdr9OdtQ=;
 b=hF2wqKbIllYR+SEkIT2x79zGbz64CrSMAedB3XCbLMlBdvfKdBP4OQArKlv77z2OSO
 F+rXTkPO6Mr9iZ/BcjbldhCXGAiXz492603hTQKizCt/MnW/LUaNbeDsvvGQVuSlxjWK
 gZlC4yKMuDIweqCZ1J3G7FPBnN2smyhB9Oy1DPCdJ8aen3EzspRhR5Fueft4WSZ4N6lr
 4IYRDFO1+1vjbjaKWRSBslN7Txh6DNHFF/xF5XQR8CHwK8UjX4B52lrrYgVBWSbUC0Cj
 /opB46pkjW3kH2inkuGsYa7FN7MYxQORwsL6XWdg1Ky9qe6oqX7l7yirldBbRwlMOWLT
 XPrA==
X-Gm-Message-State: AOJu0Yxhhyz0XmJ704932g1H8RIMXcrkeRLnyTfzpe6q/b2gHlEpNrTh
 nGUSjikMShmtpzGicFKrtbdLlxQnF2GSUc6YNF0YCNqh2H1XlQRXBPmIYec8NljgxXane2L3ZVS
 kgBMLo00l
X-Gm-Gg: ASbGncsYvAtEKdey5ZObim3E/Pp/Utf73aQU3oyteRcCb2rpi5WHbHYoUEnyBlrBIMk
 BTtLg0ryHNN6R1flWmHzrLB+LP9gogvTqHiKF+nJAXrEZPjWsqzehWGBrydBGOKtL25WtEwuQvR
 semPEfBRpf82ILqPQtiu9K1QNMwGtW4/6UI8YW4PO22q0jI15SNpaymnkgDxaYln3wdSmKPSIJq
 QscMI+7AumpWzt1afSKp5zodhKRPBPDwwjI69skHZgKusVFeYJpcQrb4xgTg2Dj
X-Google-Smtp-Source: AGHT+IFD1m4jljTLq0is0U9rb732ZxoxOYIBX8G5AduldRL1nx945bZMoojnPoPvGq0WKO3S93Xvow==
X-Received: by 2002:a05:6830:2107:b0:709:3a3d:6cca with SMTP id
 46e09a7af769-71e3be4782fmr1767368a34.11.1734116933764; 
 Fri, 13 Dec 2024 11:08:53 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org (open list:MPS2 / MPS3)
Subject: [PATCH 15/71] hw/arm: Constify all Property
Date: Fri, 13 Dec 2024 13:06:49 -0600
Message-ID: <20241213190750.2513964-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/armsse.c            | 8 ++++----
 hw/arm/armv7m.c            | 4 ++--
 hw/arm/aspeed_soc_common.c | 2 +-
 hw/arm/bcm2836.c           | 2 +-
 hw/arm/fsl-imx25.c         | 2 +-
 hw/arm/fsl-imx6.c          | 2 +-
 hw/arm/fsl-imx6ul.c        | 2 +-
 hw/arm/fsl-imx7.c          | 2 +-
 hw/arm/integratorcp.c      | 2 +-
 hw/arm/msf2-soc.c          | 2 +-
 hw/arm/npcm7xx.c           | 2 +-
 hw/arm/nrf51_soc.c         | 2 +-
 hw/arm/smmu-common.c       | 2 +-
 hw/arm/smmuv3.c            | 2 +-
 hw/arm/stellaris.c         | 2 +-
 hw/arm/strongarm.c         | 2 +-
 hw/arm/xlnx-versal.c       | 2 +-
 hw/arm/xlnx-zynqmp.c       | 2 +-
 18 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 58ed504b2b..1cd6b4a4b2 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -72,12 +72,12 @@ struct ARMSSEInfo {
     bool has_cpu_pwrctrl;
     bool has_sse_counter;
     bool has_tcms;
-    Property *props;
+    const Property *props;
     const ARMSSEDeviceInfo *devinfo;
     const bool *irq_is_common;
 };
 
-static Property iotkit_properties[] = {
+static const Property iotkit_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
@@ -90,7 +90,7 @@ static Property iotkit_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sse200_properties[] = {
+static const Property sse200_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
@@ -107,7 +107,7 @@ static Property sse200_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sse300_properties[] = {
+static const Property sse300_properties[] = {
     DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7c68525a9e..e20f719c9b 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -538,7 +538,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property armv7m_properties[] = {
+static const Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
     DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
@@ -631,7 +631,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
     qemu_register_reset(armv7m_reset, cpu);
 }
 
-static Property bitband_properties[] = {
+static const Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
     DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a5ff33c46d..4221cacd51 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -139,7 +139,7 @@ static bool aspeed_soc_boot_from_emmc(AspeedSoCState *s)
     return false;
 }
 
-static Property aspeed_soc_properties[] = {
+static const Property aspeed_soc_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 40a379bc36..95e16806fa 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -18,7 +18,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-static Property bcm2836_enabled_cores_property =
+static const Property bcm2836_enabled_cores_property =
     DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
 
 static void bcm283x_base_init(Object *obj)
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 5ed87edfe4..48763b03fe 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -309,7 +309,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->iram_alias);
 }
 
-static Property fsl_imx25_properties[] = {
+static const Property fsl_imx25_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 85748cb233..236d15bc9c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -481,7 +481,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->ocram_alias);
 }
 
-static Property fsl_imx6_properties[] = {
+static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 19f443570b..1e0bbbb5d7 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -718,7 +718,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                 FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
 }
 
-static Property fsl_imx6ul_properties[] = {
+static const Property fsl_imx6ul_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslIMX6ULState, phy_num[0], 0),
     DEFINE_PROP_UINT32("fec2-phy-num", FslIMX6ULState, phy_num[1], 1),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX6ULState, phy_connected[0],
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 9f2ef34555..0310c15b0c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -736,7 +736,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 }
 
-static Property fsl_imx7_properties[] = {
+static const Property fsl_imx7_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslIMX7State, phy_num[0], 0),
     DEFINE_PROP_UINT32("fec2-phy-num", FslIMX7State, phy_num[1], 1),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX7State, phy_connected[0],
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index feb0dd63df..ee6c7e0c0d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -694,7 +694,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
 
-static Property core_properties[] = {
+static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index c4999ebce3..5d7c3f2e5a 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -222,7 +222,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("usb", 0x40043000, 0x1000);
 }
 
-static Property m2sxxx_soc_properties[] = {
+static const Property m2sxxx_soc_properties[] = {
     /*
      * part name specifies the type of SmartFusion2 device variant(this
      * property is for information purpose only.
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index af04c4b7ec..2960b63b59 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -810,7 +810,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.spix",         0xfb001000,   4 * KiB);
 }
 
-static Property npcm7xx_properties[] = {
+static const Property npcm7xx_properties[] = {
     DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index ac53441630..43fac8a8db 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -208,7 +208,7 @@ static void nrf51_soc_init(Object *obj)
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
-static Property nrf51_soc_properties[] = {
+static const Property nrf51_soc_properties[] = {
     DEFINE_PROP_LINK("memory", NRF51State, board_memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("sram-size", NRF51State, sram_size, NRF51822_SRAM_SIZE),
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3f82728758..6baa9d0fc3 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -934,7 +934,7 @@ static void smmu_base_reset_hold(Object *obj, ResetType type)
     g_hash_table_remove_all(s->iotlb);
 }
 
-static Property smmu_dev_properties[] = {
+static const Property smmu_dev_properties[] = {
     DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
     DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6e847e8773..026838f9ac 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1976,7 +1976,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     }
 };
 
-static Property smmuv3_properties[] = {
+static const Property smmuv3_properties[] = {
     /*
      * Stages of translation advertised.
      * "1": Stage 1
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..7fc13d96c9 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -438,7 +438,7 @@ static const VMStateDescription vmstate_stellaris_sys = {
     }
 };
 
-static Property stellaris_sys_properties[] = {
+static const Property stellaris_sys_properties[] = {
     DEFINE_PROP_UINT32("user0", ssys_state, user0, 0),
     DEFINE_PROP_UINT32("user1", ssys_state, user1, 0),
     DEFINE_PROP_UINT32("did0", ssys_state, did0, 0),
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 612115ab5b..4c4ff21e80 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1332,7 +1332,7 @@ static const VMStateDescription vmstate_strongarm_uart_regs = {
     },
 };
 
-static Property strongarm_uart_properties[] = {
+static const Property strongarm_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", StrongARMUARTState, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3a1e2e29f1..3adbe7b1fb 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -968,7 +968,7 @@ static void versal_init(Object *obj)
                              "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
 }
 
-static Property versal_properties[] = {
+static const Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ab2d50e31b..1082c62c30 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -857,7 +857,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property xlnx_zynqmp_props[] = {
+static const Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
     DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),
-- 
2.43.0


