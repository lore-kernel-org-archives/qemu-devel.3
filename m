Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29AFCA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKV-00075t-GT; Sun, 04 Oct 2026 08:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKL-0006rU-4A
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:25 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKH-0007F1-0n
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:23 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so5943265e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116899; x=1791721699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xfP7wTAv2WhBCYlgvZMsia69pAgAyPp5a43/FeAWsIo=;
 b=XSFm5PHqxxzlPQpGbgoonPqNQLrrMvj2DOWLy1gD28VDmYplNmN03Dde4jCmJ3i9S1
 bYgojbaKt5Wj6K3e7Fc63TR5nX4CBPUx6B39KuxtjNl27PpggLe5Yyx5LGO8MZuf8LzQ
 D0g8ieNrStaf9nNGzlK+NywXk/KfBhKDGOyZcvqxv7+emr00p05JWEKQ7H+GHqrw40Wt
 Lqu0DsC6i7RfYd9ip16xiGt1G7mhGG6+fNb58zM++TMIoSYpasdEdmsbIdtFSjWo/QpT
 78l3H+SYl1WQpCwocgt8rU0sXWchvILcNksUA73fdfscTLdqvqDUrbm8UFY1nAP9svab
 4Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116899; x=1791721699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xfP7wTAv2WhBCYlgvZMsia69pAgAyPp5a43/FeAWsIo=;
 b=TUORFKEo1jejG1Qq04aUxwl0lzizx0P6HwVfOW7ir1H2QdFLGpxoO+RFbXk2YuHA/c
 mCPwpWZSUe43BbgOvJYzdSTwTgLzc7otfDORdeXKLslZBQmqV0j0qniPGzJOXUjhrhQY
 UM4hLUomqkcvAuSse4pTyRanCzs58LCCyVmEUgo+LbB4J4tXeI+gkEA1B7RdVhP7Blwq
 XIMxPme8b0ITWr5ez5cChBJ7HV+RBQdmyg38PhA+jmfarKZRqvtODgSX99CJU5aJfufG
 c3untpNTZQhRn+Fkfi35LaWlxWo/lM0Q2EM6HWcK37hU3cREm+1xzS+PHbGU+unePk6R
 YtUg==
X-Gm-Message-State: AFuF++lzM1vGLNig/Ns/z9cQwPdbcB5CWdYHOFQvk44eWsQLFwwBUIZe
 pwPl/yHmkrHyGJH84bs3SBOyduf67KBBPfuMKrbeHXqnnpfExMB4B47JIO6J4g==
X-Gm-Gg: AYBFou0SD5rxRXeeN97MGcuKne4smc11GyKawiJdDTleB+sfn2SJ69grs+OqoogWd3e
 EE9Y5ygv6I8UDi8uVAYV99aSF255vJNjC4RGYaiqRlHxL2MQ01kXDjhjgtogepv8zgzOjY5EXDg
 kdzfovLgGJWVTz62PvRaNKt0OUt44qd6ObGzrOQ2/OtHVjVrJKI20KqBBUxpOSZ4KgxZTO4m5XR
 A4K43ZDsZZPcxUed9Fnkw8CaZZOHY/nJfLqrFHKzg9BUoj9TPQPzjpfFCOGI+J8fb3craBEELLH
 AxH1RaMP2IPB/2kRau5QD4YfDvI8RKTjAnZZ5LVAwflaJRm5VRPkm/lAll6pji/qBAloL2z3Nik
 0m7vGglS6oPFY9vPeirPDm0fctNLNE2nq8CfGCuulEk5Ex/lMTWHgbQi3nJqfmQLHs/5R0WAjrq
 GbvP11l5mFBespEAleEJCDHqgWkkOBT4ThO1juKK46XaPFdk++eXcRcWbZg5sbHHBQuuasSmedl
 sNcq7SNmpIuixokjygblBwsnGEclgKPixKOkw==
X-Received: by 2002:a05:600c:3b2a:b0:4a1:6af4:c6be with SMTP id
 5b1f17b1804b1-4a16af4c9damr57729125e9.34.1791116898893; 
 Sun, 04 Oct 2026 05:28:18 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 28/30] Kconfig: Extract config IMX_SERIAL from config IMX
Date: Sun,  4 Oct 2026 14:26:44 +0200
Message-ID: <20261004122647.3913-29-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
config IMX_SERIAL to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/char/Kconfig     | 3 +++
 hw/char/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3f502685f4..543220be6b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -488,6 +488,7 @@ config FSL_IMX25
     select IMX_GPT
     select IMX_I2C
     select IMX_RNG
+    select IMX_SERIAL
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
@@ -505,6 +506,7 @@ config FSL_IMX31
     select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select WDT_IMX2
     select LAN9118
 
@@ -522,6 +524,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -605,6 +608,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -627,6 +631,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -656,6 +661,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select SDHCI
@@ -701,6 +707,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..54f9936534 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config IMX_SERIAL
+    bool
+
 config MAX78000_UART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..65351c39de 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -3,7 +3,7 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+system_ss.add(when: 'CONFIG_IMX_SERIAL', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
-- 
2.56.0


