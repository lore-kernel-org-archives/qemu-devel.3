Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0718C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ZxC-0001po-VG; Thu, 17 Apr 2025 20:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxA-0001pW-KM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zx7-0005u9-8F
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso11923295e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937491; x=1745542291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj/SXX9ORqUNqwaIUFCu3a62k7kjC1ko71xFmGry47g=;
 b=FyV6x8S+M6eW+TM3EL1NvIw9mB/3USlRwLJuMYXTFNFskIc35zUGQW4mQZYaVcZIPV
 qA3BGwyKe5CdAnHFburvLnQSldVwhsxOubk+ODjCuWNcnfnolAmioBVuGuoUXGho9UV+
 LoqExbNvnSxrHgt8vl56UQ4U02t0mzsT6W0u7CDKchZ/DkbzOz9qahQzVyfGHxUJijiU
 RDz564xyr+8S0Lm0A+rHkhf62xjtihNqZxIcATDcrokPCrLTFHWu+YDIUlEfZO/oxjfk
 A+li4POtqm8QtkuJFHQ405iPGyNIe6JMyUCWohzPaGP1+KIQ3PDYzelSW0/Kd8h3TmDZ
 7kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937491; x=1745542291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uj/SXX9ORqUNqwaIUFCu3a62k7kjC1ko71xFmGry47g=;
 b=HRTSvX3OihvtIoEpnuy/0q5MiTA5FxQxLXv6cLnIO4uzNb0/ZZ9OQgZvNUFiW4sphW
 NkkZNELzqtqNw+uIJ7H3zbehgJYWfn3nttLVSrqtBKJGSqwjJ+zBnvEWnsm8xbEHlZGc
 sXxhHW087nU0ABmVEvAaz/hsdse3Oy37WMGY87EOL4TTf/CxU0zU1ksnKPlVwT6uMVX/
 cDc2qm4elF69NopsMAlAFmIe69AjA3MYMa8T8QfgysAiVG0l4Rctvo35rNnXYzwtV0Mi
 PX6VOqy+px094C60q8/fvyW5j0jOjEe/VflP9EOfMwcUneZt9IS9IEe7hAB3gbP6GqET
 wpGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXep0wb6YF6nqltCH6QNguwhBJ1gPjhPW9X6LLalsYrTaY3tOz+HFiviN9WlGQBBdQsyuZ2QKkLDiiU@nongnu.org
X-Gm-Message-State: AOJu0YyR5q+DZKauwLUCUsmB+qexZ2kFfx5Rf1y+cBwqxlAhg14jZj2D
 mQ75JtgHSfhOknnXr639kMEONrJpu89amPPpk7KN/X8/Lmu2Z8hoyqORKhtLA+k=
X-Gm-Gg: ASbGncsO9ss9bqar9Ru1aUoEzPbFdk9AOZCutw0v5EK48Jkkb+s8iQ2vzO83fdgpMsS
 TIclTDoOP3Jus9vwdluRS0dvldRG2Fmc9SmFfvI4skqmfoHIJShaixONvxJ7ZY/AlT4Bc5RhZzT
 tHmUxyEUuZMke46PMhgtdgmIqn1ZJm4vigeyK63HMlplAxyy3MIRTIFCn3bJaiiKA9I/aw+Gzo+
 8UnZmdli/4swEbqVMXLa79GJpwsHZEuYClVZ2ZvhTh+vDOzEBg3YKdklO6RbHd39qLa3JqfqHXD
 PXk36SOJAIyWiN2M7nPsSy3+4b7gBiLwrMT3QyNrVX/xIV03XSLRNwQQFjLOk5ZlE1GyB2RWUX1
 Xpj5fToNr4sCV7pLYC6zT
X-Google-Smtp-Source: AGHT+IG/YhGjTzKfc5SHNjrydlihfFUTAO4v2B9FGnNAGFf6gjI0rRI0tOckKTr4Ks7PUsYMqPP8uA==
X-Received: by 2002:a05:600c:154f:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-4406abfabe7mr4550895e9.26.1744937491505; 
 Thu, 17 Apr 2025 17:51:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207e6sm1159350f8f.7.2025.04.17.17.51.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 06/11] hw/arm: Filter machine types for qemu-system-arm
 binary
Date: Fri, 18 Apr 2025 02:50:54 +0200
Message-ID: <20250418005059.4436-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/arm/aspeed.c            | 20 ++++++++++++++++++++
 hw/arm/b-l475e-iot01a.c    |  1 +
 hw/arm/bananapi_m2u.c      |  1 +
 hw/arm/collie.c            |  1 +
 hw/arm/cubieboard.c        |  1 +
 hw/arm/digic_boards.c      |  1 +
 hw/arm/exynos4_boards.c    |  2 ++
 hw/arm/fby35.c             |  1 +
 hw/arm/highbank.c          |  2 ++
 hw/arm/imx25_pdk.c         |  1 +
 hw/arm/integratorcp.c      |  1 +
 hw/arm/kzm.c               |  1 +
 hw/arm/mcimx6ul-evk.c      |  1 +
 hw/arm/mcimx7d-sabre.c     |  1 +
 hw/arm/microbit.c          |  1 +
 hw/arm/mps2-tz.c           |  4 ++++
 hw/arm/mps2.c              |  4 ++++
 hw/arm/mps3r.c             |  1 +
 hw/arm/msf2-som.c          |  1 +
 hw/arm/musca.c             |  2 ++
 hw/arm/musicpal.c          |  1 +
 hw/arm/netduino2.c         |  1 +
 hw/arm/netduinoplus2.c     |  1 +
 hw/arm/npcm7xx_boards.c    |  5 +++++
 hw/arm/olimex-stm32-h405.c |  1 +
 hw/arm/omap_sx1.c          |  2 ++
 hw/arm/orangepi.c          |  1 +
 hw/arm/raspi.c             |  3 +++
 hw/arm/realview.c          |  4 ++++
 hw/arm/sabrelite.c         |  1 +
 hw/arm/stellaris.c         |  2 ++
 hw/arm/stm32vldiscovery.c  |  1 +
 hw/arm/versatilepb.c       |  2 ++
 hw/arm/vexpress.c          |  2 ++
 hw/arm/virt.c              |  1 +
 hw/arm/xilinx_zynq.c       |  1 +
 36 files changed, 77 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ca7004c335a..d54ee2d4b53 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1761,6 +1761,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1769,6 +1770,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1777,6 +1779,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1785,6 +1788,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1793,6 +1797,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1801,6 +1806,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1809,6 +1815,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1817,6 +1824,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1825,6 +1833,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1833,6 +1842,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1841,6 +1851,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1849,6 +1860,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1857,6 +1869,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1865,6 +1878,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fp5280g2_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1873,6 +1887,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1881,6 +1896,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1889,6 +1905,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1897,6 +1914,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1905,6 +1923,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -1913,6 +1932,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index cc4b9d6c3b5..ec838f59c13 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -132,6 +132,7 @@ static const TypeInfo bl475e_machine_type[] = {
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index d9871a796bb..2d844af8fd3 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -151,6 +151,7 @@ static const TypeInfo bananapi_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = bpim2u_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 16e862e15b6..bb7cd26c28c 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -87,6 +87,7 @@ static const TypeInfo collie_machine_typeinfo = {
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index dd40d65554d..55d869e815e 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -132,6 +132,7 @@ static const TypeInfo cubieboard_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = cubieboard_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index f55309082ac..a8a59644f4c 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -153,6 +153,7 @@ static const TypeInfo digic_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = digic_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b55e364d962..cff2a52e3ff 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -173,6 +173,7 @@ static const TypeInfo nuri_type = {
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -197,6 +198,7 @@ static const TypeInfo smdkc210_type = {
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index de6b32ce532..d9584b57e83 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -188,6 +188,7 @@ static const TypeInfo fby35_types[] = {
         .instance_size = sizeof(Fby35State),
         .instance_init = fby35_instance_init,
         .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index e517cf3c7f6..6009f22f201 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -364,6 +364,7 @@ static const TypeInfo highbank_type = {
     .parent = TYPE_MACHINE,
     .class_init = highbank_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -392,6 +393,7 @@ static const TypeInfo midway_type = {
     .parent = TYPE_MACHINE,
     .class_init = midway_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index da8479ca608..669e126bfc9 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -158,6 +158,7 @@ static const TypeInfo imx25_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = imx25_pdk_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5599cf60707..d982df8fe45 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -761,6 +761,7 @@ static const TypeInfo integratorcp_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = integratorcp_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 208546205be..b2d7a312581 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -147,6 +147,7 @@ static const TypeInfo kzm_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = kzm_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 65e6134862e..2cf124ca2b5 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -85,6 +85,7 @@ static const TypeInfo imx6_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx6ul_evk_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 1f88dc03915..1a8d3e453cd 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -85,6 +85,7 @@ static const TypeInfo imx7_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx7d_sabre_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index e537735e247..ad4fe9febd0 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -75,6 +75,7 @@ static const TypeInfo microbit_info = {
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 6cd36ee4037..0676102612d 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1464,6 +1464,7 @@ static const TypeInfo mps2tz_an505_info = {
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -1474,6 +1475,7 @@ static const TypeInfo mps2tz_an521_info = {
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -1484,6 +1486,7 @@ static const TypeInfo mps3tz_an524_info = {
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -1494,6 +1497,7 @@ static const TypeInfo mps3tz_an547_info = {
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 709d7d0a08e..e61566a0316 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -564,6 +564,7 @@ static const TypeInfo mps2_an385_info = {
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -574,6 +575,7 @@ static const TypeInfo mps2_an386_info = {
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -584,6 +586,7 @@ static const TypeInfo mps2_an500_info = {
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -594,6 +597,7 @@ static const TypeInfo mps2_an511_info = {
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index d1a72c7775b..16e4deec7b3 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -635,6 +635,7 @@ static const TypeInfo mps3r_machine_types[] = {
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
         .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 11988b6aa6d..c0feff92fbd 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -115,6 +115,7 @@ static const TypeInfo msf2_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = emcraft_sf2_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 3a11b3d1cd6..e5e9950d008 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -658,6 +658,7 @@ static const TypeInfo musca_a_info = {
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -668,6 +669,7 @@ static const TypeInfo musca_b1_info = {
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9cf8eec8b13..cb352512807 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1382,6 +1382,7 @@ static const TypeInfo musicpal_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = musicpal_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index e6e140ed6bf..9443b5615e5 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -72,6 +72,7 @@ static const TypeInfo netduino_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = netduino2_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index b54e990b5bd..2003b43ad10 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -72,6 +72,7 @@ static const TypeInfo netduino_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = netduinoplus2_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 4d2c52f3422..6189509a3f9 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -550,6 +550,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
                 { TYPE_TARGET_AARCH64_MACHINE },
                 { },
         },
@@ -558,6 +559,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
                 { TYPE_TARGET_AARCH64_MACHINE },
                 { },
         },
@@ -566,6 +568,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
                 { TYPE_TARGET_AARCH64_MACHINE },
                 { },
         },
@@ -574,6 +577,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
                 { TYPE_TARGET_AARCH64_MACHINE },
                 { },
         },
@@ -582,6 +586,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_ARM_MACHINE },
                 { TYPE_TARGET_AARCH64_MACHINE },
                 { },
         },
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4344bef4db1..9ff1239a127 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -78,6 +78,7 @@ static const TypeInfo olimex_stm32_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = olimex_stm32_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 9f90f95b9ee..a4b65d1b623 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -220,6 +220,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -243,6 +244,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index f539b2fc3a4..bbd9082cff1 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -131,6 +131,7 @@ static const TypeInfo orangepi_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = orangepi_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index b8b947bc29e..8a2da650087 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -395,6 +395,7 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -403,6 +404,7 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
@@ -411,6 +413,7 @@ static const TypeInfo raspi_machine_types[] = {
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2ccee583117..c925d1483f6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -432,6 +432,7 @@ static const TypeInfo realview_eb_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -457,6 +458,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -480,6 +482,7 @@ static const TypeInfo realview_pb_a8_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -504,6 +507,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index a4c1dd7edc1..1bd82c404af 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -121,6 +121,7 @@ static const TypeInfo sabrelite_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = sabrelite_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1e696e25c42..2cb93a6d3af 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1428,6 +1428,7 @@ static const TypeInfo lm3s811evb_type = {
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -1453,6 +1454,7 @@ static const TypeInfo lm3s6965evb_type = {
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 7c267fd880b..f0881b3c8ea 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -75,6 +75,7 @@ static const TypeInfo stm32vldiscovery_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = stm32vldiscovery_machine_class_init,
         .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 4c71a73b3b1..e353ef025d9 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -432,6 +432,7 @@ static const TypeInfo versatilepb_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -457,6 +458,7 @@ static const TypeInfo versatileab_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fad4a9b8cfa..aade41d0317 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -851,6 +851,7 @@ static const TypeInfo vexpress_a9_info = {
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
@@ -862,6 +863,7 @@ static const TypeInfo vexpress_a15_info = {
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 41918eb760b..b2534a3c43e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -124,6 +124,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
         .interfaces = (InterfaceInfo[]) { \
+            { TYPE_TARGET_ARM_MACHINE }, \
             { TYPE_TARGET_AARCH64_MACHINE }, \
             { }, \
         }, \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index efcbddffda0..e8f43e193c0 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -481,6 +481,7 @@ static const TypeInfo zynq_machine_type = {
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_ARM_MACHINE },
         { TYPE_TARGET_AARCH64_MACHINE },
         { },
     },
-- 
2.47.1


