Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869BAC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JG-00076K-Rr; Thu, 20 Feb 2025 11:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JF-00075d-Cl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JD-0008EL-M8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso7348385e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068513; x=1740673313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QZTc2oPY4YllPwFk3F0ukTxoRIP/o83PipGK8tU/N6c=;
 b=L01YHopCG24y9H9ovaqcsEwxg800rryQVlvzGUojdEIzKHjbwPcZoC6AU9hvQ9KBH1
 gJgK4I58ZWtX1KstJizF682byhcqdKX03CjmsOBu29wLoCrO2YRia93GDgF5S9w+biRw
 sfKHZUaByhF3EMe66/0Lhen/XtFemxtfo6Zd8hAFYqLlHNp5oLyztg7fdXoCskfYwuYi
 eAiKHoMAyIfC+6Nq2E/TznUyQkFvXw+vwY+Ce7n9sJD8J1pxF9NwhMrd/oofO/LG2c6x
 S1pos+F3X83CeOkPw0KzpA+6P1cARgZw2mjajAXmEpfYHuysTXsqqg2gC1tXSx1bq98i
 vgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068513; x=1740673313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZTc2oPY4YllPwFk3F0ukTxoRIP/o83PipGK8tU/N6c=;
 b=jitpgH3xsoC3CI2t47syZq6EP0CbIZtuCL4HnE60VDOMINwf9XZKJ4F/ZoSXzkhHt7
 TBmGdvMerXLF5jhOHcCMEx8KAUG1LX07kEsxb6bTgKpgy0NFy0MY8aTFcCudC8LzsMTx
 +44byL2UZSEj5OKWAZNNdP7YFdkU0wwsReCeKsjW8eaOiuxVlkqEAulII9pPF7fY+GYU
 xyemdnDnbLiyit4DdjtAgeQMoCwCDPygTAX28VLUv8B1RlAOPC05QzFdP1VaELF4SrZD
 6hONzStlizD5RVJAFD8jOcfXeKiKh3pIqYYGvxDTQ749AR1eMmX64WgScUwfAtecFsTE
 qs9A==
X-Gm-Message-State: AOJu0YzDDilNX+qqeAJAmI14QadGu9s5jAbtQwS5NAmBhrMptq6zFIZG
 BiKOA/mnQVHDGifVt94y1e5iw9/AvDUCwwA6Iv6E8Yo7oZow8Npgdt3Cq7r4lsON7Db/nM77/hZ
 u
X-Gm-Gg: ASbGncs+K1/M6TWE+uHpTgh9wVY0a9VOoRDRcTwiAuDJiSJPoImtq78UNuCoBGM7S/I
 jRSxcdJ1lgiP8sVHUeA2I32Ymgv0nJK7qzXgJLvEkrrjLzNaPJBbu+wgV/KNszaBWajku45eOeo
 Bjl7cVQBie9qncvd5iA54gWt1p6wxhkhhEKn7szK5mOD+iL6L54f2rVgngKgRCc0dkV9lCquhuw
 oqEpE2Qupdd3DqKmSr09Xjl7vn/CGg/OwgoJuGNCC5YJmgn/R5Eb5+KNabUYj5z7ai4SpJiKfqp
 oXNa7Kb3sC0P3x5QE/AIyw==
X-Google-Smtp-Source: AGHT+IFcnYuvEI4lPkQMdPwpLVQWwBwPOvRL4014g2Wjg6zPGRMjp+6Ys7PWJtuDtsHTJphqMyncdw==
X-Received: by 2002:a05:600c:154e:b0:439:a88f:8538 with SMTP id
 5b1f17b1804b1-439a88f85bcmr27780345e9.5.1740068513021; 
 Thu, 20 Feb 2025 08:21:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
Date: Thu, 20 Feb 2025 16:21:04 +0000
Message-ID: <20250220162123.626941-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

TYPE_CHIPIDEA models an IP block which is also used in TYPE_ZYNQ_MACHINE which
itself is not an IMX device. CONFIG_ZYNQ selects CONFIG_USB_EHCI_SYSBUS while
TYPE_CHIPIDEA is a separate compilation unit, so only works by accident if
CONFIG_IMX is given. Fix that by extracting CONFIG_USB_CHIPIDEA from CONFIG_IMX.

cc: qemu-stable@nongnu.org
Fixes: 616ec12d0fcc "hw/arm/xilinx_zynq: Fix USB port instantiation"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250209103604.29545-1-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig     | 6 +++++-
 hw/usb/Kconfig     | 4 ++++
 hw/usb/meson.build | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 256013ca808..7eab3914d4b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -303,7 +303,7 @@ config ZYNQ
     select PL330
     select SDHCI
     select SSI_M25P80
-    select USB_EHCI_SYSBUS
+    select USB_CHIPIDEA
     select XILINX # UART
     select XILINX_AXI
     select XILINX_SPI
@@ -489,6 +489,7 @@ config FSL_IMX25
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
 
@@ -516,6 +517,7 @@ config FSL_IMX6
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select USB_CHIPIDEA
     select OR_IRQ
 
 config ASPEED_SOC
@@ -576,6 +578,7 @@ config FSL_IMX7
     select SDHCI
     select OR_IRQ
     select UNIMP
+    select USB_CHIPIDEA
 
 config ARM_SMMUV3
     bool
@@ -591,6 +594,7 @@ config FSL_IMX6UL
     select IMX_I2C
     select WDT_IMX2
     select SDHCI
+    select USB_CHIPIDEA
     select UNIMP
 
 config MICROBIT
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5fbecd2f43b..69c663be52f 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -143,3 +143,7 @@ config USB_DWC3
 config XLNX_USB_SUBSYS
     bool
     select USB_DWC3
+
+config USB_CHIPIDEA
+    bool
+    select USB_EHCI_SYSBUS
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 1b4d1507e41..17360a5b5a4 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -25,8 +25,8 @@ system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'
 system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
+system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
 
-system_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-regs.c'))
-- 
2.43.0


