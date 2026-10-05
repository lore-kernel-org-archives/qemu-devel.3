Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8FCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfqE-0007Eg-9i; Mon, 05 Oct 2026 06:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmn-0002Oe-Ji
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:14 -0400
Received: from mail-wr2-x1e.google.com ([2a00:1450:4864:30::1e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmj-00013G-A7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:09 -0400
Received: by mail-wr2-x1e.google.com with SMTP id
 ffacd0b85a97d-48b0fc598f8so910546f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195539; x=1791800339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8gZfehfi1SGyoLFE26a+mlEe7gKv2x5zNTED0weiJs=;
 b=NMatxSM36+MGNW4KI6CYVGVaotxL8iJ7LmIH7oAKdIfgCaqUSXXuRhMlwEMYZrfDsp
 4WgPBx7cr7LTHgRc/N3u44IDTz47NP7+PP3T5th7LicT9lDYyv8VpaS2lhFMVAUFvqQl
 IM6b7fC3M+UuPFB8Em6absnrNFRZqe+s5GBT9EhIdNdm65ANW8oCfJmrmK8gbKI9rCpr
 384F9vw39NtUIDcV/f2l9JSgIBLPi5DBNkr+17OxSnVYeiWdiSPsftClbGQ380K8E3id
 +JxAMB7MATrKElJ+YuXXQVgv1QQxHjllEddKMosjWwmAPOEZwj1lw6+f7KVzffENc7na
 SncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195539; x=1791800339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j8gZfehfi1SGyoLFE26a+mlEe7gKv2x5zNTED0weiJs=;
 b=I6QsajV/GpYKq1MatbZrt0MOh91QDsHCKNgSgC3RGgPVLcyqArQas1BvYcGsVconzL
 HYhLNK3CZ0TMzZwrm1RgCon1TaHQr+Bh2yHUZ0gzbuZEkJ3S+sCPitacH9esN5lzaSUb
 VGwPfJPyyao5Bhg8j0KRu3QznsNBsucuh/EjQDYKtZJTLn4tpJmp5PU7G9PtFdKsEYvD
 j+MrOLHHg/fxGklaDuc40qnHb0NfXczzPJFdB+orsslfBrGDPGw4YWD0L/Ip068u3AjR
 T8762EgJjdzJ5SRZF9Wd0gudoFseDLovc+VyjP+kIZlHBozaSzqQt2GPv2G3XI/89sid
 AhIw==
X-Gm-Message-State: AFq9FYI2MP5VlZh2TBb2P7y2nyKbcNdrbsx9wmjceok8nY86CN1TImcG
 HE47VBVOfRG2kw2fFHm5BS7HiChED7GjJy8JtRgTUwtxvy+qGDIgUXH5MizQrA==
X-Gm-Gg: AYBFou1PnQ2h533MUFnUUKaqNfX8JfAGF4B16tF7+aBEzURAw7Sa3MjraUC1zCTDbZH
 KMU+1E3NIkaa7Jw3kqWJll2+2XVtmirkOQvwrrRnHcKRTVH7bYBDrYIrkireDNKt0GoSbADv4DX
 rtt1T0dNgo0F9rEKGhIJDg7X+dYUr0riSN0Y/XJxpyFSgL0Aywv8EJFQsG00jhWp2SSTgZ3Nnm5
 obCCB80Xb+pwurh3tVCnLFQywtIbcttltt8TAuK+JN2Yu8s5aAxv1xcWcDLOhdz4J24C6A35Z3l
 jick5f9bx9JgsWLXYqSsYKS9qtrRgbIeYuP+8bSjfz3dLM5v5O7aSSkqrUrB726VOoVV72AnHLD
 nfj3JpRof8KXpuNMyS8w/rnuLwKWYGlv8Cn6qkoyBAUZ2DdQyjfnSvENZDDr6VvDAb2gbrdAu6O
 d96/tApTaM307Vw5bcNYvhMrodYGTHRZAMvPM+R+X/DtDUXnKPE4Uhn0tZ2Fbd70CvUDWR/O1LS
 YU8e+auKa6O1385yjycAK93yLdB7jfDFB1owQ==
X-Received: by 2002:a05:6000:2484:b0:487:40d:af33 with SMTP id
 ffacd0b85a97d-48b12754332mr17214599f8f.13.1791195539505; 
 Mon, 05 Oct 2026 03:18:59 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 27/31] Kconfig: Extract config GPIO_IMX from config IMX
Date: Mon,  5 Oct 2026 12:17:54 +0200
Message-ID: <20261005101800.10821-28-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::1e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x1e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
config GPIO_IMX to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/gpio/Kconfig     | 3 +++
 hw/gpio/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1d3026dea9..c21ad260a1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX25_CCM
+    select GPIO_IMX
     select IMX
     select IMX_AVIC
     select IMX_EPIT
@@ -497,6 +498,7 @@ config FSL_IMX31
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX31_CCM
+    select GPIO_IMX
     select SERIAL_MM
     select IMX
     select IMX_AVIC
@@ -514,6 +516,7 @@ config FSL_IMX6
     select FSL_IMX6_CCM
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX_EPIT
     select IMX_FEC
@@ -594,6 +597,7 @@ config FSL_IMX7
     select FSL_IMX7_GPR
     select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
+    select GPIO_IMX
     select PCI
     select IMX
     select IMX_FEC
@@ -616,6 +620,7 @@ config FSL_IMX8MP
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -643,6 +648,7 @@ config FSL_IMX8MM
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -683,6 +689,7 @@ config FSL_IMX6UL
     select FSL_IMX6_SRC
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index ea0fb72b40..5ea2c5f427 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,6 +1,9 @@
 config PL061
     bool
 
+config GPIO_IMX
+    bool
+
 config GPIO_KEY
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8ede5e88ae..d60dc42ab3 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_GPIO_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
@@ -6,7 +7,6 @@ system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
 system_ss.add(when: 'CONFIG_ZAURUS_SCOOP', if_true: files('zaurus.c'))
 
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
-- 
2.56.0


