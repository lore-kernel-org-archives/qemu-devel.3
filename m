Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF5C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSS-0004SF-TY; Tue, 22 Apr 2025 15:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSA-0003yi-Bz
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS7-0007Jl-OA
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227914acd20so1954045ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350722; x=1745955522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6epK1kHVGM7DWadqrW/21XmOu9df43IQ+8cLDy78ic=;
 b=KyJQB9Oe/bC02ArwjGmULgalAwuA8bYN/wp+PUPVZh9frh4NBtKZ6QtJK0YCMOGKtx
 YZfB1v/66bNOSKGCs8vFpyHzUNjm3HqTxbbEMBVum0WQqfnVajGSc8vsPY58Zr/+NfZ6
 a6FNMBEHqQibrK+XGpkr2vk4lUa4HJEyztedTgEqTJF6l8bVfVqyijusnFrgxhaDW+7+
 /If3UTcae18LCtUZY8B1s2ArlYJ3hAQITjwo0Wz0bzMKjLlr4BMwCrKoGoJlcxHjkknj
 Dv+djeQ6PAsl4Ns4aWqegp2AZSmReOfHksOFWizEyACVgzHCBm3m5f/2duAWkh5sM9Ta
 5oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350722; x=1745955522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6epK1kHVGM7DWadqrW/21XmOu9df43IQ+8cLDy78ic=;
 b=Xshvq7J+6q2oqXHkSqNO7db8Jibzih3w2W0qXe3v0jKRsWYbHFAZhEXh23Hf9FCOk3
 ETmacXyqLDAmF0l/Jb9hEDphRAOvO6+BUs5GdJYTEv0BqNaIVsPToMUHlwqtnegfqHyA
 aaXW5YWmX8EAGip4Bd0MOq2azqBlwrhQjPvW37Cxn/0TsXQqoe+PAASa7yznI2Q+CZdN
 Co1xKkLUkLwXC9UZr0USzrJwuvH3PauGfpIjpCzX81Xx9xAnyFO95/Fw66pbSH1EAjb3
 7rSlYjOiUtL6yNk8AQHXA2vLYzmrXkmUzzcQu/TK1KfkKqKvVo32RmHulWG+TjDDNjyk
 G33Q==
X-Gm-Message-State: AOJu0YyruCNClWwKnafHVhJHUlTMpUNX/PSQQqZA+5/TC6Og4VBS1U2H
 VOOiByOkuhF+ZHvqFW3CyIivVQOVKyO29+eoMrn2dTMHn5bzR2zY6PAJ/BAwV/O7HCsdOJydaQN
 J
X-Gm-Gg: ASbGnctfNj7VlLIKOTIEIzs+wrdXY3JsoJ1zUVRj6EmePzLfmtQAiscVKkyt7DNQuOU
 u1l8RbrWj5+Qz+gNG1v7qKQu6s2OZD2ENAvWItn9Uh+DIsMwqMG2e/ghLEcYlpMxoH81KiyUWjw
 ZNQNbFCrJ+trET3jyDHBdcBXnuitT+RmUU+0A/O8OWyzv/50bO41udAD+QwJNbAgStvy4MpPIMT
 Av8z/PaY0UROU4BboIhgWHPi6B3aWluJHZn9Qwu2NkazGKgo8kfiC/TvHSbpKbum7wZf5uzYe0a
 QvdXIeo+DVhtzIs24wfrbV83TYnth/oAJYTZZ9aTltrG+V22W6zhBk0l69/rJkVn0vGlCyPAK/0
 =
X-Google-Smtp-Source: AGHT+IGbEDoFR3UF3m7U9EZoYtaswA/CRYTBdz5nQ0ZbdxsvuH5Pxh1N4ufIRFGHMEUhlrj+yF/FKw==
X-Received: by 2002:a17:902:ce8c:b0:221:8568:c00f with SMTP id
 d9443c01a7336-22da303cf77mr3948095ad.0.1745350722032; 
 Tue, 22 Apr 2025 12:38:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 124/147] hw/arm: make most of the compilation units common
Date: Tue, 22 Apr 2025 12:27:53 -0700
Message-ID: <20250422192819.302784-125-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-30-pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 112 ++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9e8c96059e..09b1cfe5b5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -2,43 +2,43 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
-arm_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
-arm_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
-arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
-arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
-arm_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
-arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
-arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
-arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
-arm_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
-arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
+arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
+arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
+arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
+arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
+arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
+arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
+arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
+arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
+arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
+arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
+arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
-arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
-arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
-arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
-arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
+arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
+arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
+arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
+arm_common_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
-arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
-arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
-arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
-arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
-arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
-arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
-arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
+arm_common_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
+arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
+arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
+arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
+arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
+arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
-arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
-arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
-arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
-arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
-arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
-arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
+arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_common_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
+arm_common_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
+arm_common_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
+arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
 arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
@@ -47,33 +47,33 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
-arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
-arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
-arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
-arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
-arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
-arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
-arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
+arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
+arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
+arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
+arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
+arm_common_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
+arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
+arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
   'xen-pvh.c',
 ))
 
-system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
-system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
-system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
-system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
-system_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
-system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
-system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
-system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
+arm_common_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
+arm_common_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
+arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
+arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
+arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(fdt, files('boot.c'))
 
-- 
2.43.0


