Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C104C3ABC9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 13:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDkUu-0003Ii-Sp; Sat, 10 May 2025 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uDkUs-0003IR-EP
 for qemu-devel@nongnu.org; Sat, 10 May 2025 09:44:10 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uDkUp-0006Dh-Dh
 for qemu-devel@nongnu.org; Sat, 10 May 2025 09:44:10 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad1d1f57a01so555426866b.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884645; x=1747489445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLKM4/9CA+lLlmZ5o9CLCHoytr0dfGBTXAX79a6etQY=;
 b=PHhacbQk2qj6ee+2gZilQeT2YntANREBQ4net6ikLWm1GLmBGNA6hK/y3z7gdyoKBN
 RrNSiKAXOJ+sZB9nl9frRz4ZVpPtdHtg1qFoDOlTf9yGJHxdOOaXuQVl9wR54ujirrbu
 jy1RflMjQSqMU8wqb7UgdD8LXzxUhbun2wDyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884645; x=1747489445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLKM4/9CA+lLlmZ5o9CLCHoytr0dfGBTXAX79a6etQY=;
 b=bOmI6Qb9H5Et4gHUYoK2y1dFZP09cYCCgB3r+i1fgsDE3pxq3vm0+JaXeWGaCknlMw
 NNyZvymoCmUfziWBq6cl5YEwi2mxIhNATz3XA0LMyG/u6TnFyxHrOUpJWdmljsJkKLhE
 Jlwr7f9jSCvtGjYmubP0E6q29vRV2mXiRsN5Mzrvvttxkt8QrgHfPFcdrOmu/XWeCmip
 gue8eAR6hsWo39qHJYKEzRfByD7MrM3nZY5qSiW+3dpzoCNmWGLtnAqxf6gPhkFa/kZt
 fDSgOJMTTjY2KOv/wvw2Yxg1fyA9ymyBgQiZv+AbCA6zhMHBImMJzFIrIvuuLKn82Kql
 QyEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlv0gHCBwoHnSBrNCN7lxkd1MYLmQB5ZrgyTksWLKG90nFpdAFVGU67axvg2A9sYTNJBO8UXFcsX9j@nongnu.org
X-Gm-Message-State: AOJu0YwqQ0L1fQKdGo8MoVq+gfy5Oo+TH098gqJQwAOR7KRiHy/X9gBC
 2BEX4M+iR2ko9CbTGouwaVOcrMtcQccrdkk22jihxKFXdgRVt13ipH3sXbq/nw==
X-Gm-Gg: ASbGncvCtWd9ct0GvKPQ57yCn5X/Mih9yAy5ZY5hw6T492KyFyBlg1d0V+y0d+BbNps
 0FgKvtNXyT9j4ZPCCxN9tX+kbcvcjvGxhW/wm8L+w9JejxO/dn24afq0Ntx0z9/mVIl9/ZGxwtp
 R0y56kSFj3tAPbtuIYiQXV959DUt3Q39DcCOGHgAXU5iNufC2t8tXeYpLIOfgDzW4rjSjxrOsfw
 im0haJ1mSGK9AbHYp81G3wYABRCpNcARJH1stpxS0Phr8ErYBTAO4teyZltmp6ZgQSgiu5+MhW2
 QwPjjpzcdkXWjIHkB4gRMegNXGwKis2IcsFz48mfm83MkQcEfowqkqAihL2+Ufavoj5k3idigSw
 Q3n4=
X-Google-Smtp-Source: AGHT+IEkdNjh1Dwwbi7FGTZMj54cXD9L1129JPY5XVMOeKyNAbqIxsoj02ui97Svoo4NLzf161eAuQ==
X-Received: by 2002:a17:907:8b8a:b0:ace:c416:4231 with SMTP id
 a640c23a62f3a-ad218e92f99mr709802766b.12.1746884644944; 
 Sat, 10 May 2025 06:44:04 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 14/22] arm: qemu: Add an SPL build
Date: Sat, 10 May 2025 15:42:12 +0200
Message-ID: <20250510134253.1581164-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=sjg@chromium.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add an SPL build for qemu so we can test the standard passage feature.

Include a binman definition so that SPL and U-Boot are in the same image.
This requires adding a proper devicetree file for qemu_arm. It is only
used for the SPL build.

Avoid using the QEMU devicetree in U-Boot proper, so we can obtain it
from standard passage.

For now this just boots and hangs in SPL as there is no bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Drop common.h
- Refresh the U-Boot output in the documentation
- Use bootph tags

 arch/arm/dts/qemu-arm-u-boot.dtsi    |  22 ++
 arch/arm/dts/qemu-arm.dts            | 393 ++++++++++++++++++++++++++-
 arch/arm/mach-qemu/Kconfig           |  12 +-
 board/emulation/qemu-arm/Kconfig     |  26 +-
 board/emulation/qemu-arm/MAINTAINERS |  13 +-
 board/emulation/qemu-arm/Makefile    |   1 +
 board/emulation/qemu-arm/qemu-arm.c  |   3 +
 board/emulation/qemu-arm/spl.c       |  26 ++
 configs/qemu_arm_spl_defconfig       |  82 ++++++
 doc/board/emulation/qemu-arm.rst     |  47 ++++
 10 files changed, 617 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/qemu-arm-u-boot.dtsi
 create mode 100644 board/emulation/qemu-arm/spl.c
 create mode 100644 configs/qemu_arm_spl_defconfig

diff --git a/arch/arm/dts/qemu-arm-u-boot.dtsi b/arch/arm/dts/qemu-arm-u-boot.dtsi
new file mode 100644
index 00000000000..abf69272afb
--- /dev/null
+++ b/arch/arm/dts/qemu-arm-u-boot.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Sample device tree for qemu_arm
+
+ * Copyright 2021 Google LLC
+ */
+
+/ {
+	binman {
+		u-boot-spl {
+			size = <0x10000>;
+		};
+
+		u-boot {
+		};
+	};
+
+	pl011@9000000 {
+		bootph,pre-ram;
+	};
+
+};
diff --git a/arch/arm/dts/qemu-arm.dts b/arch/arm/dts/qemu-arm.dts
index 230c630f04f..5743902b41b 100644
--- a/arch/arm/dts/qemu-arm.dts
+++ b/arch/arm/dts/qemu-arm.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm
+ * Sample device tree for qemu_arm
 
  * Copyright 2021 Google LLC
  */
@@ -8,4 +8,395 @@
 /dts-v1/;
 
 / {
+	interrupt-parent = <0x8001>;
+	#size-cells = <0x02>;
+	#address-cells = <0x02>;
+	compatible = "linux,dummy-virt";
+
+	psci {
+		migrate = <0x84000005>;
+		cpu_on = <0x84000003>;
+		cpu_off = <0x84000002>;
+		cpu_suspend = <0x84000001>;
+		method = "hvc";
+		compatible = "arm,psci-0.2\0arm,psci";
+	};
+
+	memory@40000000 {
+		reg = <0x00 0x40000000 0x00 0x8000000>;
+		device_type = "memory";
+	};
+
+	platform@c000000 {
+		interrupt-parent = <0x8001>;
+		ranges = <0x00 0x00 0xc000000 0x2000000>;
+		#address-cells = <0x01>;
+		#size-cells = <0x01>;
+		compatible = "qemu,platform\0simple-bus";
+	};
+
+	fw-cfg@9020000 {
+		dma-coherent;
+		reg = <0x00 0x9020000 0x00 0x18>;
+		compatible = "qemu,fw-cfg-mmio";
+	};
+
+	virtio_mmio@a000000 {
+		dma-coherent;
+		interrupts = <0x00 0x10 0x01>;
+		reg = <0x00 0xa000000 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000200 {
+		dma-coherent;
+		interrupts = <0x00 0x11 0x01>;
+		reg = <0x00 0xa000200 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000400 {
+		dma-coherent;
+		interrupts = <0x00 0x12 0x01>;
+		reg = <0x00 0xa000400 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000600 {
+		dma-coherent;
+		interrupts = <0x00 0x13 0x01>;
+		reg = <0x00 0xa000600 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000800 {
+		dma-coherent;
+		interrupts = <0x00 0x14 0x01>;
+		reg = <0x00 0xa000800 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000a00 {
+		dma-coherent;
+		interrupts = <0x00 0x15 0x01>;
+		reg = <0x00 0xa000a00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000c00 {
+		dma-coherent;
+		interrupts = <0x00 0x16 0x01>;
+		reg = <0x00 0xa000c00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a000e00 {
+		dma-coherent;
+		interrupts = <0x00 0x17 0x01>;
+		reg = <0x00 0xa000e00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001000 {
+		dma-coherent;
+		interrupts = <0x00 0x18 0x01>;
+		reg = <0x00 0xa001000 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001200 {
+		dma-coherent;
+		interrupts = <0x00 0x19 0x01>;
+		reg = <0x00 0xa001200 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001400 {
+		dma-coherent;
+		interrupts = <0x00 0x1a 0x01>;
+		reg = <0x00 0xa001400 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001600 {
+		dma-coherent;
+		interrupts = <0x00 0x1b 0x01>;
+		reg = <0x00 0xa001600 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001800 {
+		dma-coherent;
+		interrupts = <0x00 0x1c 0x01>;
+		reg = <0x00 0xa001800 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001a00 {
+		dma-coherent;
+		interrupts = <0x00 0x1d 0x01>;
+		reg = <0x00 0xa001a00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001c00 {
+		dma-coherent;
+		interrupts = <0x00 0x1e 0x01>;
+		reg = <0x00 0xa001c00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a001e00 {
+		dma-coherent;
+		interrupts = <0x00 0x1f 0x01>;
+		reg = <0x00 0xa001e00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002000 {
+		dma-coherent;
+		interrupts = <0x00 0x20 0x01>;
+		reg = <0x00 0xa002000 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002200 {
+		dma-coherent;
+		interrupts = <0x00 0x21 0x01>;
+		reg = <0x00 0xa002200 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002400 {
+		dma-coherent;
+		interrupts = <0x00 0x22 0x01>;
+		reg = <0x00 0xa002400 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002600 {
+		dma-coherent;
+		interrupts = <0x00 0x23 0x01>;
+		reg = <0x00 0xa002600 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002800 {
+		dma-coherent;
+		interrupts = <0x00 0x24 0x01>;
+		reg = <0x00 0xa002800 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002a00 {
+		dma-coherent;
+		interrupts = <0x00 0x25 0x01>;
+		reg = <0x00 0xa002a00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002c00 {
+		dma-coherent;
+		interrupts = <0x00 0x26 0x01>;
+		reg = <0x00 0xa002c00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a002e00 {
+		dma-coherent;
+		interrupts = <0x00 0x27 0x01>;
+		reg = <0x00 0xa002e00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003000 {
+		dma-coherent;
+		interrupts = <0x00 0x28 0x01>;
+		reg = <0x00 0xa003000 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003200 {
+		dma-coherent;
+		interrupts = <0x00 0x29 0x01>;
+		reg = <0x00 0xa003200 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003400 {
+		dma-coherent;
+		interrupts = <0x00 0x2a 0x01>;
+		reg = <0x00 0xa003400 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003600 {
+		dma-coherent;
+		interrupts = <0x00 0x2b 0x01>;
+		reg = <0x00 0xa003600 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003800 {
+		dma-coherent;
+		interrupts = <0x00 0x2c 0x01>;
+		reg = <0x00 0xa003800 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003a00 {
+		dma-coherent;
+		interrupts = <0x00 0x2d 0x01>;
+		reg = <0x00 0xa003a00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003c00 {
+		dma-coherent;
+		interrupts = <0x00 0x2e 0x01>;
+		reg = <0x00 0xa003c00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	virtio_mmio@a003e00 {
+		dma-coherent;
+		interrupts = <0x00 0x2f 0x01>;
+		reg = <0x00 0xa003e00 0x00 0x200>;
+		compatible = "virtio,mmio";
+	};
+
+	gpio-keys {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		compatible = "gpio-keys";
+
+		poweroff {
+			gpios = <0x8003 0x03 0x00>;
+			linux,code = <0x74>;
+			label = "GPIO Key Poweroff";
+		};
+	};
+
+	pl061@9030000 {
+		phandle = <0x8003>;
+		clock-names = "apb_pclk";
+		clocks = <0x8000>;
+		interrupts = <0x00 0x07 0x04>;
+		gpio-controller;
+		#gpio-cells = <0x02>;
+		compatible = "arm,pl061", "arm,primecell";
+		reg = <0x00 0x9030000 0x00 0x1000>;
+	};
+
+	pcie@10000000 {
+		interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
+		interrupt-map = <0x00 0x00 0x00 0x01 0x8001 0x00 0x00 0x00
+			0x03 0x04 0x00 0x00 0x00 0x02 0x8001 0x00
+			0x00 0x00 0x04 0x04 0x00 0x00 0x00 0x03
+			0x8001 0x00 0x00 0x00 0x05 0x04 0x00 0x00
+			0x00 0x04 0x8001 0x00 0x00 0x00 0x06 0x04
+			0x800 0x00 0x00 0x01 0x8001 0x00 0x00 0x00
+			0x04 0x04 0x800 0x00 0x00 0x02 0x8001 0x00
+			0x00 0x00 0x05 0x04 0x800 0x00 0x00 0x03
+			0x8001 0x00 0x00 0x00 0x06 0x04 0x800 0x00
+			0x00 0x04 0x8001 0x00 0x00 0x00 0x03 0x04
+			0x1000 0x00 0x00 0x01 0x8001 0x00 0x00 0x00
+			0x05 0x04 0x1000 0x00 0x00 0x02 0x8001 0x00
+			0x00 0x00 0x06 0x04 0x1000 0x00 0x00 0x03
+			0x8001 0x00 0x00 0x00 0x03 0x04 0x1000 0x00
+			0x00 0x04 0x8001 0x00 0x00 0x00 0x04 0x04
+			0x1800 0x00 0x00 0x01 0x8001 0x00 0x00 0x00
+			0x06 0x04 0x1800 0x00 0x00 0x02 0x8001 0x00
+			0x00 0x00 0x03 0x04 0x1800 0x00 0x00 0x03
+			0x8001 0x00 0x00 0x00 0x04 0x04 0x1800 0x00
+			0x00 0x04 0x8001 0x00 0x00 0x00 0x05 0x04>;
+		#interrupt-cells = <0x01>;
+		ranges = <0x1000000 0x00 0x00 0x00
+			0x3eff0000 0x00 0x10000 0x2000000
+			0x00 0x10000000 0x00 0x10000000
+			0x00 0x2eff0000 0x3000000 0x80
+			0x00 0x80 0x00 0x80
+			0x00>;
+		reg = <0x00000000 0x3f000000 0x00000000 0x01000000>;
+		msi-parent = <0x8002>;
+		dma-coherent;
+		bus-range = <0x00 0x0f>;
+		linux,pci-domain = <0x00>;
+		#size-cells = <0x02>;
+		#address-cells = <0x03>;
+		device_type = "pci";
+		compatible = "pci-host-ecam-generic";
+	};
+
+	pl031@9010000 {
+		clock-names = "apb_pclk";
+		clocks = <0x8000>;
+		interrupts = <0x00 0x02 0x04>;
+		reg = <0x00 0x9010000 0x00 0x1000>;
+		compatible = "arm,pl031", "arm,primecell";
+	};
+
+	pl011@9000000 {
+		clock-names = "uartclk", "apb_pclk";
+		clocks = <0x8000 0x8000>;
+		interrupts = <0x00 0x01 0x04>;
+		reg = <0x00 0x9000000 0x00 0x1000>;
+		compatible = "arm,pl011", "arm,primecell";
+	};
+
+	pmu {
+	};
+
+	intc@8000000 {
+		phandle = <0x8001>;
+		reg = <0x00 0x8000000 0x00 0x10000 0x00 0x8010000 0x00 0x10000>;
+		compatible = "arm,cortex-a15-gic";
+		ranges;
+		#size-cells = <0x02>;
+		#address-cells = <0x02>;
+		interrupt-controller;
+		#interrupt-cells = <0x03>;
+
+		v2m@8020000 {
+			phandle = <0x8002>;
+			reg = <0x00 0x8020000 0x00 0x1000>;
+			msi-controller;
+			compatible = "arm,gic-v2m-frame";
+		};
+	};
+
+	flash@0 {
+		bank-width = <0x04>;
+		reg = <0x00 0x00 0x00 0x4000000 0x00 0x4000000 0x00 0x4000000>;
+		compatible = "cfi-flash";
+	};
+
+	cpus {
+		#size-cells = <0x00>;
+		#address-cells = <0x01>;
+
+		cpu@0 {
+			reg = <0x00>;
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+		};
+	};
+
+	timer {
+		interrupts = <0x01 0x0d 0x104 0x01 0x0e 0x104 0x01 0x0b 0x104 0x01 0x0a 0x104>;
+		always-on;
+		compatible = "arm,armv7-timer";
+	};
+
+	apb-pclk {
+		phandle = <0x8000>;
+		clock-output-names = "clk24mhz";
+		clock-frequency = <0x16e3600>;
+		#clock-cells = <0x00>;
+		compatible = "fixed-clock";
+	};
+
+	chosen {
+		stdout-path = "/pl011@9000000";
+	};
 };
diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 9c06c6a3a5c..292c5f65c8e 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -14,6 +14,15 @@ config TARGET_QEMU_ARM_32BIT
 	select CPU_V7A
 	select SYS_ARCH_TIMER
 
+config TARGET_QEMU_ARM_32BIT_SPL
+	bool "ARMv7-A, 32bit with SPL"
+	select ARCH_SUPPORT_PSCI
+	select BOARD_LATE_INIT
+	select CPU_V7A
+	select SYS_ARCH_TIMER
+	select SPL
+	select BINMAN
+
 config TARGET_QEMU_ARM_64BIT
 	bool "ARMv8, 64bit"
 	select ARM64
@@ -26,9 +35,10 @@ config TARGET_QEMU_ARM_SBSA
 	select BOARD_LATE_INIT
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select MISC_INIT_R
+
 endchoice
 
-if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || TARGET_QEMU_ARM_32BIT_SPL
 
 config SYS_BOARD
 	default "qemu-arm"
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 80ab9d8e1c3..2a8f052c0da 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -1,7 +1,4 @@
-if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
-
-config TEXT_BASE
-	default 0x00000000
+if ARCH_QEMU && !TARGET_QEMU_ARM_SBSA
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
@@ -12,6 +9,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
+	select SUPPORT_SPL
 
 config PRE_CON_BUF_ADDR
 	hex
@@ -19,10 +17,28 @@ config PRE_CON_BUF_ADDR
 
 endif
 
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
+
+config TEXT_BASE
+	default 0x00000000
+
+endif
+
 if TARGET_QEMU_ARM_64BIT && !TFABOOT
 config BOARD_SPECIFIC_OPTIONS
 	imply SYS_MTDPARTS_RUNTIME
 	imply SET_DFU_ALT_INFO
 
-source "board/emulation/common/Kconfig"
 endif
+
+if TARGET_QEMU_ARM_32BIT_SPL
+
+config SPL_TEXT_BASE
+	default 0x00000000
+
+config TEXT_BASE
+	default 0x00010000
+
+endif
+
+source "board/emulation/common/Kconfig"
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 538769f8040..54682d6c0af 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,5 +5,16 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm*
+F:	configs/qemu_arm_defconfig
+F:	configs/qemu_arm64_acpi_defconfig
+F:	configs/qemu_arm64_defconfig
 F:	configs/qemu-arm-sbsa_defconfig
+
+QEMU ARM 'VIRT' BOARD
+M:	Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
+S:	Maintained
+F:	board/emulation/qemu-arm/
+F:	board/emulation/common/
+F:	include/configs/qemu-arm.h
+F:	include/configs/qemu-sbsa.h
+F:	configs/qemu_arm_spl_defconfig
diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
index a22d1237ff4..54635646e07 100644
--- a/board/emulation/qemu-arm/Makefile
+++ b/board/emulation/qemu-arm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y	+= qemu-arm.o
+obj-$(CONFIG_SPL_BUILD)	+= spl.o
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 31f5a775137..5d73d02bee2 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -152,6 +152,9 @@ int dram_init_banksize(void)
 int board_fdt_blob_setup(void **fdtp)
 {
 	/* QEMU loads a generated DTB for us at the start of RAM. */
+	if (CONFIG_IS_ENABLED(OF_PASSAGE))
+		return -EEXIST;
+
 	*fdtp = (void *)CFG_SYS_SDRAM_BASE;
 
 	return 0;
diff --git a/board/emulation/qemu-arm/spl.c b/board/emulation/qemu-arm/spl.c
new file mode 100644
index 00000000000..afef76b90f2
--- /dev/null
+++ b/board/emulation/qemu-arm/spl.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <cpu_func.h>
+#include <spl.h>
+#include <asm/spl.h>
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_BOARD;
+}
+
+static int spl_qemu_load_image(struct spl_image_info *spl_image,
+			       struct spl_boot_device *bootdev)
+{
+	spl_image->name = "U-Boot";
+	spl_image->load_addr = spl_get_image_pos();
+	spl_image->entry_point = spl_get_image_pos();
+	flush_cache(spl_image->load_addr, spl_get_image_size());
+
+	return 0;
+}
+SPL_LOAD_IMAGE_METHOD("QEMU", 0, BOOT_DEVICE_BOARD, spl_qemu_load_image);
diff --git a/configs/qemu_arm_spl_defconfig b/configs/qemu_arm_spl_defconfig
new file mode 100644
index 00000000000..9c4408dc73c
--- /dev/null
+++ b/configs/qemu_arm_spl_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SYS_ICACHE_OFF=y
+CONFIG_SYS_DCACHE_OFF=y
+CONFIG_ARM_SMCCC=y
+CONFIG_ARCH_QEMU=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_BLOBLIST_SIZE_RELOC=0x2000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-arm"
+CONFIG_TARGET_QEMU_ARM_32BIT_SPL=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x40200000
+CONFIG_DEBUG_UART_BASE=0x9000000
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_ARMV7_LPAE=y
+CONFIG_ENV_ADDR=0x4000000
+CONFIG_QEMU_MANUAL_DTB=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_BOARD=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_SPL_DM=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_CFI_FLASH=y
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=256
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
+CONFIG_E1000=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_MMIO=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+CONFIG_TPM=y
+CONFIG_UNIT_TEST=y
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac6..a8a1ba0e0f9 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -38,6 +38,11 @@ Set the CROSS_COMPILE environment variable as usual, and run:
     make qemu_arm64_defconfig
     make
 
+- for ARM with SPL::
+
+    make qemu_arm_spl_defconfig
+    make
+
 Running U-Boot
 --------------
 The minimal QEMU command line to get U-Boot up and running is:
@@ -50,6 +55,10 @@ The minimal QEMU command line to get U-Boot up and running is:
 
     qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios u-boot.bin
 
+- For ARM with SPL::
+
+    qemu-system-arm -machine virt -nographic -bios image.bin
+
 Note that for some odd reason qemu-system-aarch64 needs to be explicitly
 told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic argument
 ensures that output appears on the terminal. Use Ctrl-A X to quit.
@@ -191,6 +200,44 @@ Enable the TPM on U-Boot's command line with::
 
     tpm autostart
 
+SPL Description
+---------------
+
+As you see above, running the SPL build is a little different, since there are
+two binaries to load into memory: SPL and U-Boot proper. Binman is used to
+produce the combined `image.bin` containing these. See
+`arch/arm/dts/qemu-arm-u-boot.dtsi` for the definition. A custom loader called
+`spl_qemu_load_image()` is used to access the U-Boot binary from within SPL.
+
+A sample run is shown below, using the build-qemu-sh script. Note that the
+devicetree is passed via standard passage::
+
+    $ ./scripts/build-qemu.sh -a arm  -rsxw
+    Running qemu-system-arm  -machine virt -accel tcg -display none -serial mon:stdio
+
+    U-Boot SPL 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 09:39:51 -0600)
+    Trying to boot from QEMU
+
+
+    U-Boot 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 09:39:51 -0600)
+
+    DRAM:  128 MiB
+    using memory 0x466aa000-0x476ea000 for malloc()
+    Core:  48 devices, 12 uclasses, devicetree: passage
+    Flash: 64 MiB
+    Loading Environment from Flash... *** Warning - bad CRC, using default environment
+
+    In:    serial,usbkbd
+    Out:   serial,vidconsole
+    Err:   serial,vidconsole
+    No USB controllers found
+    Net:   No ethernet found.
+
+    starting USB...
+    No USB controllers found
+    Hit any key to stop autoboot:  0
+    =>
+
 Debug UART
 ----------
 
-- 
2.43.0


