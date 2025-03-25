Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05830C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQk-0007oR-3p; Tue, 25 Mar 2025 01:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOI-0004DW-51
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:54 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOE-00060e-KW
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so8530652a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878789; x=1743483589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5iaiuFfQwHaUV+YhyGFcKHMq0HGbFMqwt0CSvqtQT8=;
 b=fjhXNS26EugQwHsohACAoLklNQ4a/5HpExirrleFsyFk5PKsQvtq63zavBq/OfFDoD
 w6f7tmB3R0PzXchAvm7a0FUkL9HSVeaXSeiIMY+6KG6POnDdkSVOpwE31gHKTFAcW517
 OmLAsfrvqNP2D7h2rAlQE5ofuOfBFeoZtNAnY6u+jybCdxNrZNm/0j0P46pccwviVflH
 825bIeGJUlYozh12Yig0Y5rNJgcAOvGowlq88pQzS04fop3NMTGOCwY2ToJDvt9NDJFV
 FgdB0VsRXs1m+SAALyRBodscQSXoJ6GHv/2Gh0F7h5jyHVBNGXjgtMcZdL+IYKho/5gO
 T+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878789; x=1743483589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5iaiuFfQwHaUV+YhyGFcKHMq0HGbFMqwt0CSvqtQT8=;
 b=QilomCOzhc8tytnp9dYsdiG07nu4mHNzDbnEEHvBEOF9bHaQLI1gfG560xH3jN1KaM
 kyA7HKk0dNeNkb3hUrFxSMIHmWWq9nNzPKlwAMwYk35zTTnLZPjLVTkoslzIkXe6MDZj
 udiqylFolDdqRcaQ6cMJyAhYOdpnIpWYpBAeisa3Q25sKF6XCZOng+E1MzgoiLitTKFB
 42EtxMP2wOlkf2ul8fgT1iHUg7VmvWayZZ51x/eOGzQOOk2OwWOMkkRzJ8Bv9mCP+X+a
 ITzVUseQVJ3PWLWPDvoaud1UAlpJQy26nvcv3bsQJggdZyO+in9XuZ0+RVG95Shh66Kl
 HZhA==
X-Gm-Message-State: AOJu0Yyfk3l6FWFR71FdfYXpFuxdtyNMaipc2d/5dNk/pTwTvu8RyGJI
 TtTWX05IWcg+6EVcYDGxvn/Z2VTItmSTIkUK9lStV3ne9/K6xx6oB+G/kHgfIdI9pwUYT7i6R1f
 S
X-Gm-Gg: ASbGncvGtM9vZA/wntZGHcXOfsKQcg9nzkDmxmbppVLbtQ03B3kYr/CpYw3lhUrbGia
 qQMyhscbM/9lzNSCxeQ/t02RhzqI2XnNH1a0VDa9vdzqrCWkYXEUz+cf1B4uSEpKRl/6XuAjXj8
 LsJ9d1w5BAL7H3HBjPDOh0yO3GjuuCHXGvoOlgnk7PQENN4C3KjsECb0/xqTMScn0kpTJsXECqr
 tdq1dkQouRr5r6oZNCkyyt5ebBfLhXjkDehfbpe/2bi5FsurexDbgRD49UEzCbMiuteL0UVwV+M
 3UH28TVoSVJjpf/fLwuHXjO0JyRFMzkZBetqbxfPfYtT
X-Google-Smtp-Source: AGHT+IGQpJbiRQAVb3v453plqKLTvvPi+By/fp7ijm5/h9t46fIIypvcmFznZtBz8S0M8ZOkQc/5Dg==
X-Received: by 2002:a17:90b:28cc:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-3030fe93e6emr27765660a91.10.1742878789061; 
 Mon, 24 Mar 2025 21:59:49 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 29/29] hw/arm: make most of the compilation units common
Date: Mon, 24 Mar 2025 21:59:14 -0700
Message-Id: <20250325045915.994760-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 112 ++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9e8c96059eb..09b1cfe5b57 100644
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
2.39.5


