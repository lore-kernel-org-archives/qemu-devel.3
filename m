Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDE3C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pX9-0002Kj-BL; Fri, 18 Apr 2025 13:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pX7-0002K9-4Y
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pX2-0008Ki-EG
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so15567165e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997378; x=1745602178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wt4qKJ0+qbDFtV5JdYISjNhnPLXIq7IfaAn6j0T22LM=;
 b=PQjdQNTv7K8GbVozuz79KzY32hjApliJlStALZ1ScgXviXQe6pai3PJDohBs8Rtenn
 8GdaCCatZKKynqJndEqQu19kHPUx1RrlGTTmu6pu7+FfwQMiOYnG9ZInGMlBtbETM3Da
 xE9P1Burjb6MAru2CgZeKq1uS5Dv82VHG+194gVnkIxhY7kz8Uf1GSVemUracewlbiQT
 uAy7Iiag+qF9a704Olem9pVJWDnyv3uWa1L/43+JFSCdiMDXGB7DHQaCWu9BTSq5HOyW
 7n/FlX7G0glNSetIG/S/8XsBJGD9FXRetz3xvz8terngyh1Egy7QIAgVhyfKBNFcmc/1
 z5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997378; x=1745602178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wt4qKJ0+qbDFtV5JdYISjNhnPLXIq7IfaAn6j0T22LM=;
 b=Wns6x3BZGTi5G/vG+YFUkH1CKmtiPVfurzRnlJG9Ay7bdJGnMpQ5SIwk0kHOJL619i
 4cgTyo46cALE1WTdV03ZkUXE1zivWOl07HE7V4E3robtNPO5N1Wvx59R7lP7AjOsO1wk
 VB/I8r6aC0VF00gDeES6RXiuqgJoGgLf4TG98efn5WcG5f1fNsh1T1ScBmDlYE6+bHKj
 NaGsFCSvm6r9zWcGWl1hpAYhUUvqtlxpAieQURfKoUl+qfXVZKADdtU5g8iEoUbAFFOv
 SXfFPwtfYcPJ8qZ/BVR2DmELfvEIg0T8L+ryNuf04dLM5hEqjvVLDE4m/y/X7FEJ0taa
 fKfg==
X-Gm-Message-State: AOJu0YzIXYFqlJB1FECSWaQTeWbMSh8khqjmR1s9dCGjzPX0CwzNqFu6
 Z4M0ExC8osYhNoEOtwDv7QqhX6MwoAkwcPPOlrVwKynwF6yZ28N2W4ZuCpXHjDjFMJAdXk0cyk+
 8
X-Gm-Gg: ASbGncupxnDevim6MxfsYV6VPoL53xEHOm6wFUuyV5la0SJRw4YApWiwTZFrOsMUrvj
 Fa96RvjMAYbfLAPEx+hLdWe0jL3PljwbFofrc2+v5LO9/uEj2XbopCGzf0SDurvPmTWUAfJsyxB
 EfTZWqJuSSh0joq/wZ2ftF6W+1MrSB3qKD9iTtnwg2t7V/nvUxs5atcFMdTLNAzjSu6Yj2mCvbJ
 yVKxX4LpH+P/96Pq7ZMcYA9o+lkesWvr8T1fyoOLvuDkUv4X3OQmmdM1pI5a3Md+2NWRWTlGpvP
 DwXeyT2uAQlm1Bd7VCvpXt+W2v4oZllTndFLAf1b7p08ObgiKkwcqD7wOCVqAUocfHqsJW0rv4C
 5ZLmm2077mwkc+y8=
X-Google-Smtp-Source: AGHT+IH/YtjAT3WjVtZkBd5Fue8WgBBsBWzugHeQ+H8XqNwNu+jBS6C2e4kHzuC+C6TTkWx78fhueg==
X-Received: by 2002:a05:600c:3487:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-4406abfab7dmr31180825e9.24.1744997378092; 
 Fri, 18 Apr 2025 10:29:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd7fsm29288815e9.21.2025.04.18.10.29.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 06/14] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Date: Fri, 18 Apr 2025 19:29:00 +0200
Message-ID: <20250418172908.25147-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since the qemu-system-aarch64 binary is able to run
all machines indistinctly, simply register the
TYPE_TARGET_AARCH64_MACHINE interface for all
existing machines under the hw/arm/ directory.

Very few machines are restricted to the qemu-system-aarch64
binary:

  $ git grep TARGET_AARCH64 hw/arm/meson.build
  hw/arm/meson.build:31:arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
  hw/arm/meson.build:50:arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))

  $ git grep -W AARCH64 hw/arm/Kconfig
  hw/arm/Kconfig=185=config SBSA_REF
  hw/arm/Kconfig-186-    bool
  hw/arm/Kconfig-187-    default y
  hw/arm/Kconfig:188:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=413=config XLNX_ZYNQMP_ARM
  hw/arm/Kconfig-414-    bool
  hw/arm/Kconfig-415-    default y if PIXMAN
  hw/arm/Kconfig:416:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=435=config XLNX_VERSAL
  hw/arm/Kconfig-436-    bool
  hw/arm/Kconfig-437-    default y
  hw/arm/Kconfig:438:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=475=config NPCM8XX
  hw/arm/Kconfig-476-    bool
  hw/arm/Kconfig-477-    default y
  hw/arm/Kconfig:478:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=605=config FSL_IMX8MP_EVK
  hw/arm/Kconfig-606-    bool
  hw/arm/Kconfig-607-    default y
  hw/arm/Kconfig:608:    depends on TCG && AARCH64

  $ git grep -wW TARGET_AARCH64 hw/arm | fgrep -4 MACHINE_TYPE_NAME
  ...
  hw/arm/aspeed.c:1939:#ifdef TARGET_AARCH64
  hw/arm/aspeed.c-1940-    }, {
  hw/arm/aspeed.c-1941-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),

  hw/arm/aspeed.c-1949-        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),

  hw/arm/raspi.c:420:#ifdef TARGET_AARCH64
  hw/arm/raspi.c-421-    }, {
  hw/arm/raspi.c-422-        .name           = MACHINE_TYPE_NAME("raspi3ap"),

  hw/arm/raspi.c-429-    }, {
  hw/arm/raspi.c-430-        .name           = MACHINE_TYPE_NAME("raspi3b"),

This can be verified as:

$ diff -u0 <(qemu-system-arm -M help) <(qemu-system-aarch64 -M help)
  @@ -5,3 +4,0 @@
  -ast2700-evb          Aspeed AST2700 A0 EVB (Cortex-A35) (alias of ast2700a0-evb)
  -ast2700a0-evb        Aspeed AST2700 A0 EVB (Cortex-A35)
  -ast2700a1-evb        Aspeed AST2700 A1 EVB (Cortex-A35)
  @@ -22 +18,0 @@
  -imx8mp-evk           NXP i.MX 8M Plus EVK Board
  @@ -49 +44,0 @@
  -npcm845-evb          Nuvoton NPCM845 Evaluation Board (Cortex-A35)
  @@ -63,3 +57,0 @@
  -raspi3ap             Raspberry Pi 3A+ (revision 1.0)
  -raspi3b              Raspberry Pi 3B (revision 1.2)
  -raspi4b              Raspberry Pi 4B (revision 1.5)
  @@ -72 +63,0 @@
  -sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
  @@ -116,2 +106,0 @@
  -xlnx-versal-virt     Xilinx Versal Virtual development board
  -xlnx-zcu102          Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs based on the value of smp

Register the TYPE_TARGET_ARM_MACHINE interface for all
the machines not listed previously.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/aspeed.c            | 109 +++++++++++++++++++++++++++++++++++++
 hw/arm/b-l475e-iot01a.c    |   6 ++
 hw/arm/bananapi_m2u.c      |   6 ++
 hw/arm/bcm2836.c           |   1 +
 hw/arm/collie.c            |   6 ++
 hw/arm/cubieboard.c        |   6 ++
 hw/arm/digic_boards.c      |   6 ++
 hw/arm/exynos4_boards.c    |  11 ++++
 hw/arm/fby35.c             |   6 ++
 hw/arm/highbank.c          |  11 ++++
 hw/arm/imx25_pdk.c         |   6 ++
 hw/arm/imx8mp-evk.c        |   5 ++
 hw/arm/integratorcp.c      |   6 ++
 hw/arm/kzm.c               |   6 ++
 hw/arm/mcimx6ul-evk.c      |   6 ++
 hw/arm/mcimx7d-sabre.c     |   6 ++
 hw/arm/microbit.c          |   6 ++
 hw/arm/mps2-tz.c           |  21 +++++++
 hw/arm/mps2.c              |  21 +++++++
 hw/arm/mps3r.c             |   6 ++
 hw/arm/msf2-som.c          |   6 ++
 hw/arm/musca.c             |  11 ++++
 hw/arm/musicpal.c          |   6 ++
 hw/arm/netduino2.c         |   6 ++
 hw/arm/netduinoplus2.c     |   6 ++
 hw/arm/npcm7xx_boards.c    |  26 +++++++++
 hw/arm/npcm8xx_boards.c    |   5 ++
 hw/arm/olimex-stm32-h405.c |   6 ++
 hw/arm/omap_sx1.c          |  11 ++++
 hw/arm/orangepi.c          |   6 ++
 hw/arm/raspi.c             |  24 ++++++++
 hw/arm/raspi4b.c           |   5 ++
 hw/arm/realview.c          |  21 +++++++
 hw/arm/sabrelite.c         |   6 ++
 hw/arm/sbsa-ref.c          |   5 ++
 hw/arm/stellaris.c         |  11 ++++
 hw/arm/stm32vldiscovery.c  |   6 ++
 hw/arm/versatilepb.c       |  11 ++++
 hw/arm/vexpress.c          |  11 ++++
 hw/arm/virt.c              |   6 ++
 hw/arm/xilinx_zynq.c       |   6 ++
 hw/arm/xlnx-versal-virt.c  |   5 ++
 hw/arm/xlnx-zcu102.c       |   5 ++
 43 files changed, 468 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 82f42582fa3..ce4d49a9f59 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -15,6 +15,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_eeprom.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -1760,91 +1761,199 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fp5280g2_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a0_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
         }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c9a5209216c..7af7db3dbb3 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/core/split-irq.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/display/dm163.h"
@@ -131,6 +132,11 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 724ee4b05e5..5104a45390b 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
@@ -150,6 +151,11 @@ static const TypeInfo bananapi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("bpim2u"),
         .parent         = TYPE_MACHINE,
         .class_init     = bpim2u_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 95e16806fa1..f60489983ba 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index e83aee58c6b..458ed53f0f6 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -15,6 +15,7 @@
 #include "hw/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
@@ -86,6 +87,11 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 36062ac7037..00656169b72 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
 static struct arm_boot_info cubieboard_binfo = {
@@ -131,6 +132,11 @@ static const TypeInfo cubieboard_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("cubieboard"),
         .parent         = TYPE_MACHINE,
         .class_init     = cubieboard_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 3c0cc6e4370..7b9fbb5524b 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -29,6 +29,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/arm/digic.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/loader.h"
 #include "system/qtest.h"
@@ -152,6 +153,11 @@ static const TypeInfo digic_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("canon-a1100"),
         .parent         = TYPE_MACHINE,
         .class_init     = digic_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2d8f2d73265..71601a0d6f0 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "system/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
@@ -172,6 +173,11 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void smdkc210_class_init(ObjectClass *oc, void *data)
@@ -192,6 +198,11 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 6d3663f14a1..84b65844b34 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -14,6 +14,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 #define TYPE_FBY35 MACHINE_TYPE_NAME("fby35")
 OBJECT_DECLARE_SIMPLE_TYPE(Fby35State, FBY35);
@@ -187,6 +188,11 @@ static const TypeInfo fby35_types[] = {
         .class_init = fby35_class_init,
         .instance_size = sizeof(Fby35State),
         .instance_init = fby35_instance_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 0f3c207d548..d26346ea8ad 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/loader.h"
 #include "net/net.h"
 #include "system/runstate.h"
@@ -363,6 +364,11 @@ static const TypeInfo highbank_type = {
     .name = MACHINE_TYPE_NAME("highbank"),
     .parent = TYPE_MACHINE,
     .class_init = highbank_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void midway_class_init(ObjectClass *oc, void *data)
@@ -387,6 +393,11 @@ static const TypeInfo midway_type = {
     .name = MACHINE_TYPE_NAME("midway"),
     .parent = TYPE_MACHINE,
     .class_init = midway_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void calxeda_machines_init(void)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a90def7f1a2..86f0855c929 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
@@ -157,6 +158,11 @@ static const TypeInfo imx25_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("imx25-pdk"),
         .parent         = TYPE_MACHINE,
         .class_init     = imx25_pdk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index c7d87d99230..44f704b9bd3 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -10,6 +10,7 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "system/qtest.h"
@@ -79,6 +80,10 @@ static const TypeInfo imx8_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("imx8mp-evk"),
         .parent         = TYPE_MACHINE,
         .class_init     = imx8mp_evk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f95916b517d..efe1075ecc0 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -13,6 +13,7 @@
 #include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
@@ -760,6 +761,11 @@ static const TypeInfo integratorcp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("integratorcp"),
         .parent         = TYPE_MACHINE,
         .class_init     = integratorcp_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b56cabe9f94..02ece3c0139 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
@@ -146,6 +147,11 @@ static const TypeInfo kzm_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("kzm"),
         .parent         = TYPE_MACHINE,
         .class_init     = kzm_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index d947836d2be..ea636fa2e7c 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -84,6 +85,11 @@ static const TypeInfo imx6_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("mcimx6ul-evk"),
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx6ul_evk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index f5dc9c211dd..b236a6587eb 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -84,6 +85,11 @@ static const TypeInfo imx7_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("mcimx7d-sabre"),
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx7d_sabre_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index ade363daaa4..d34b1c675e5 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
 
@@ -74,6 +75,11 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index b0633a5a69e..12512477977 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -52,6 +52,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "system/address-spaces.h"
@@ -1463,24 +1464,44 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 6958485a668..f39176c0005 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "system/address-spaces.h"
@@ -563,24 +564,44 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4dd1e8a7180..8bcf5a4d69f 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
@@ -634,6 +635,11 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 6ce47eaa27a..3f7aefc0ba4 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -32,6 +32,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/qdev-clock.h"
 #include "system/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
@@ -114,6 +115,11 @@ static const TypeInfo msf2_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("emcraft-sf2"),
         .parent         = TYPE_MACHINE,
         .class_init     = emcraft_sf2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index a4f43f1992b..608f16f69b2 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -26,6 +26,7 @@
 #include "system/system.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
@@ -657,12 +658,22 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f7c488cd1d6..e2a65f72095 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/boards.h"
@@ -1381,6 +1382,11 @@ static const TypeInfo musicpal_types[] = {
         .name           = MACHINE_TYPE_NAME("musicpal"),
         .parent         = TYPE_MACHINE,
         .class_init     = musicpal_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 52c30055d44..2e615276902 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (120MHz) */
 #define SYSCLK_FRQ 120000000ULL
@@ -71,6 +72,11 @@ static const TypeInfo netduino_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("netduino2"),
         .parent         = TYPE_MACHINE,
         .class_init     = netduino2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 2735d3a0e2b..e12f78599c4 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (168MHz) */
 #define SYSCLK_FRQ 168000000ULL
@@ -71,6 +72,11 @@ static const TypeInfo netduino_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("netduinoplus2"),
         .parent         = TYPE_MACHINE,
         .class_init     = netduinoplus2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index eb28b97ad83..4b6d3443d53 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/npcm7xx.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -549,22 +550,47 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 3fb8478e72e..919c14dd809 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -19,6 +19,7 @@
 #include "chardev/char.h"
 #include "hw/boards.h"
 #include "hw/arm/npcm8xx.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
 #include "hw/qdev-core.h"
@@ -248,6 +249,10 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     },
 };
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 795218c93cf..f81f4094149 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* olimex-stm32-h405 implementation is derived from netduinoplus2 */
 
@@ -77,6 +78,11 @@ static const TypeInfo olimex_stm32_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("olimex-stm32-h405"),
         .parent         = TYPE_MACHINE,
         .class_init     = olimex_stm32_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index aa1e96b3ad7..2537045c1ac 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -32,6 +32,7 @@
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/qtest.h"
 #include "system/address-spaces.h"
@@ -219,6 +220,11 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
@@ -238,6 +244,11 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 6821033bfd7..4e333d428a2 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info orangepi_binfo;
 
@@ -130,6 +131,11 @@ static const TypeInfo orangepi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("orangepi-pc"),
         .parent         = TYPE_MACHINE,
         .class_init     = orangepi_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dce35ca11aa..69cccdbb6b1 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
@@ -394,23 +395,46 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index f6de103a3e1..8fda6d3b0ca 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -11,6 +11,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/registerfields.h"
@@ -127,6 +128,10 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .interfaces     = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 008eeaf049a..aed864bcd4f 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/split-irq.h"
 #include "hw/net/lan9118.h"
 #include "hw/net/smc91c111.h"
@@ -431,6 +432,11 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
@@ -452,6 +458,11 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
@@ -471,6 +482,11 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
@@ -491,6 +507,11 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ea59ba301e7..bc472dcad2c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -120,6 +121,11 @@ static const TypeInfo sabrelite_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("sabrelite"),
         .parent         = TYPE_MACHINE,
         .class_init     = sabrelite_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index aa09d7a0917..6584097fc25 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -34,6 +34,7 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/ide/ide-bus.h"
@@ -920,6 +921,10 @@ static const TypeInfo sbsa_ref_info = {
     .instance_init = sbsa_ref_instance_init,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index cbe914c93e9..8dc68c145c1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -15,6 +15,7 @@
 #include "hw/sd/sd.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -1427,6 +1428,11 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 /*
@@ -1448,6 +1454,11 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 3a9728ca719..b7eb948bc2d 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* stm32vldiscovery implementation is derived from netduinoplus2 */
 
@@ -74,6 +75,11 @@ static const TypeInfo stm32vldiscovery_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("stm32vldiscovery"),
         .parent         = TYPE_MACHINE,
         .class_init     = stm32vldiscovery_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 35766445fa4..defc4d7d170 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -12,6 +12,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "system/system.h"
@@ -431,6 +432,11 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versatileab_class_init(ObjectClass *oc, void *data)
@@ -452,6 +458,11 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 76c6107766c..38b203b52da 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -850,6 +851,11 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -857,6 +863,11 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a4..a3c9ffe29eb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -37,6 +37,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
@@ -123,6 +124,11 @@ static void arm_virt_compat_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .interfaces = (InterfaceInfo[]) { \
+            { TYPE_TARGET_ARM_MACHINE }, \
+            { TYPE_TARGET_AARCH64_MACHINE }, \
+            { }, \
+        }, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index b8916665ed6..433907093fa 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -20,6 +20,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/boards.h"
@@ -480,6 +481,11 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0c6f0359e3d..cb7466f7250 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 
@@ -833,6 +834,10 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
     .instance_finalize = versal_virt_machine_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4fdb153e4d8..f730dbbd908 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -303,6 +304,10 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.47.1


