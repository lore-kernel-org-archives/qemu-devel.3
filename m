Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF7CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIJ-0005zx-1u; Wed, 07 Oct 2026 04:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJjJ-0008UD-VU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:58:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJjG-0004LY-Rt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:58:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1857017f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349089; x=1791953889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSgSmbIol/w3uLzkMCO+LFEzRwoP9tuMmsJ3pCoOB1Y=;
 b=aVYzF58XDpvgm0A6GEQNi3s2HjeYiq+gMC0xa3rElGE+Ath+15fu3eP0XXGaT/SfPG
 cMKF7USNEwB3Jja/uAdzk43U5JsmHK4I+6Pgv6wL3M9wd+IDX1nSy73i3GSuqnLcd93R
 aIKHgoUMpBMhJaTZuko95t2RoWTvDwFLzmoiDHKKUUpCjAaDMR2U5m3ne3tUkweamqs+
 +LYidBgY8R47Fdcvp/bPNIC7QsS9Yij4zXu0MCpG+kdWePzGG9QR2mXC9epfZT41aar4
 H9XLzxnU4THNeHdr9AfBT1YVh2zsSuyDN5nZHb14XcBuPeX48541gIVawZb/p7piSX1j
 XOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349089; x=1791953889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSgSmbIol/w3uLzkMCO+LFEzRwoP9tuMmsJ3pCoOB1Y=;
 b=CEQm0FQBy2SmuFebYN7HIlioZ8mr0jFeW+uTErLuxCKSJxRiZRwpLSNg8NYg4yqyld
 ORFte1HGNR99w4ldWUxqV/K/fyXEmimax9bp8BHI1+z6EFxeKrPBCrrvMFsj8Ct/mB4h
 /DSSIfIvO2YkQeEv+xSjOGzJfbr3dLBVzESadLb+OalKAy7W3SIKkFHrXpbT74pb58op
 dWxO8Zj18wQNa5wg1MjakqxzvKQPn0yxjgIHLfaFYtfYBOBL3AE6L5FzXgWymyS+vQ8D
 q+rQ3pXA39Oz+49RchfdteuGNrKjV38AFTpYWm+Mo6oWk8g5SmUM7cea8FeLpmXBjjBu
 en+g==
X-Gm-Message-State: AFq9FYIROW4Q5SQ0uX5tUz3SbSUMS1fz3y+J1BuDNSaG18HP9C7Xmy+J
 ury6Y2Fd4yPA30jWF6w7r/iQyShYLaC1NXlCMaIacM9RmHQjfMs1ndjmA16pwQ==
X-Gm-Gg: AYBFou2qLVaISLDe44VQE0WYW2yb1fM39bpYw2taJzlaGI0lk4rJCL+3Ww3ihXGeWFf
 HzcNCEBYp8G1xjGvfcPnsqLa/ey+85WzJBzIBhNWYIpapn4pLEtdBsWxZGQQxyAINfBO1T5cLNp
 iXthoIlLHnYPQF8gGO8b+evwft0aLst5EKVFZiDyel4ugc0OaT/iNtdM8b4RxpaIrata4DtU+8J
 0Pqb8kSicBiuGOGFpCjo03eQZ9sh+QG8EFUEWWLI7+ILQ+fGaH/QjRo+eCTy+m6jHOj4lF1lqSp
 tKvGh6psLHTgWTcMnkWp1F59qsgEF8zWB03m2Sp7jSVrfLMvOfq3KpZJC58zQVxJ7+eq5BSHKc9
 +oiGZ9EZ3fJbnz1o/HV2+uW8k7it64Yy7RHJGx6nLOGAMO5JMJmqTxdViFjmE++lkat0FajODQ5
 KhUPoh9TNdFVhyjDU+eK3BGnAnwVLTda61XAzCvN2m+HMKrE4/vQE9yRe8YvKel7ZFVQn8PtFhK
 uNFE/tGYLwl7ZOWfVb5u27k48Gu4zBc7C9LWw==
X-Received: by 2002:a05:6000:24c6:b0:48a:f5cb:4356 with SMTP id
 ffacd0b85a97d-48c4801ac46mr17402531f8f.45.1791275754413; 
 Tue, 06 Oct 2026 01:35:54 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 28/31] Kconfig: Extract config IMX_SPI from config IMX
Date: Tue,  6 Oct 2026 10:34:40 +0200
Message-ID: <20261006083445.30362-29-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_SPI to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig     | 5 +++++
 hw/misc/Kconfig    | 1 -
 hw/ssi/Kconfig     | 4 ++++
 hw/ssi/meson.build | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c21ad260a1..3f502685f4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -522,6 +522,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
     select WDT_IMX2
@@ -604,6 +605,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
@@ -625,6 +627,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
@@ -653,6 +656,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select OR_IRQ
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
@@ -697,6 +701,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index dbdef58505..ab238767b8 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,7 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    select SSI
 
 config IMX_CCM
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..d477d20e9b 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config IMX_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..f334e48e2f 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+system_ss.add(when: 'CONFIG_IMX_SPI', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
-- 
2.56.0


