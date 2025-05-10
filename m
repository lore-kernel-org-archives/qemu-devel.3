Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F014C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 13:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDkUx-0003J8-Fu; Sat, 10 May 2025 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uDkUt-0003Ia-Tk
 for qemu-devel@nongnu.org; Sat, 10 May 2025 09:44:12 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uDkUr-0006Dq-3t
 for qemu-devel@nongnu.org; Sat, 10 May 2025 09:44:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so349381866b.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884647; x=1747489447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO3uBvV7hQKQSqiN6Y6UuQVwEJB4sAZf6rz+JCe1Mw8=;
 b=WmBkVMKAgvFySRkwuUjDPwmvAJ8oTa/RTNb7LRB/hT3IaNCw+7p+bhyM247Yz5fOW9
 JjxuV/sSAECBwptLPBmNORmpwVdCwqndeFGV7St+lq0hstU3SH7WffhvxynlNR3DY8GC
 TEYKZPf41fW6erYumpxxrgajTHIELFhRt4QHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884647; x=1747489447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO3uBvV7hQKQSqiN6Y6UuQVwEJB4sAZf6rz+JCe1Mw8=;
 b=BK1tPiC37NJ1j1bqZTP344iBjM53Wv40rKeCWKYMAfM3jWfrjb5iEJSh7wCMPL54UK
 y/7+kfy6fQmsW5Y+efYLC7jJtUmrE3LVnboRQKMv2+TbP7SxHhUuTK++9lQNvNHlY6/U
 LL+jrdhcPwr684LQKwh58MgQOfc019ay++Yf6I2owkliMXqW8piNr3N9B3tzGZKbR6le
 pnvDfwJ3UP1JL8QqaD1wODsooeJN8UQB7KGpVhdkiU3D4LW/FqA6HW2XRF50vshAQU7D
 jQ65u/+gljBvF9gEw1HNeuUhBabp2RKkaJ54T+H5IwxKG/jwSW9P7kXIt+7kQWUpwMDh
 QNhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyIrxgl91ycgPbx6r7PRLLsWRXcWX5M4Hzbny+lzvYeXGdwse+f84/1ehfxMm7ia4A177wu1Jtwn9@nongnu.org
X-Gm-Message-State: AOJu0YxnJg8a/MMviXOoVr8KDEzwjC4WuM55xAD6+CBI9c2Y8HA+MSbJ
 qCRBY5OPfptDxuc30TpubaYihu+coBn5I1EksSbI05gA9LX13sPGG8LnvDMVZBRCQzHmckd6Ah0
 FWXYEF5yQEA==
X-Gm-Gg: ASbGncvC1tO5/0JjE/+vgdva6EXtwcqc7f1js0/7IRp5CYv8ym5HVda2ClClJFq1QFD
 PN3vdPHq9dFf4ev1lAqfd+Hv0nsCqU8KxI67AOd/ahro9GMHcfdJy1/I1M9jzkwsFSw23qpXbEn
 YJaAkAuYdKGoOjo2YEsUFTVLC1mnbhVIZFkaoKMjLFy421QaQJyV4IcJK+Jw3SWHBS09kkpoEB2
 1RdkI7x6J1dJtRrpUO4IDih26F/LygLXw6xEDgjc7EXWV3U8eASFEp2XJwOE3er968aXZfAn7xG
 nRlheDoqZ8IpbNo34Inx84qNey7xV+yQS15UARtXYv0f3DMn4owQMLxmaihfGwZ/yeC+
X-Google-Smtp-Source: AGHT+IGDlei4zzhJaRcHyxOFsBFVuNURBz8bIQ+mYTzLuhYLpMIqmzWutwgly5yXW+Y66s3Zle8kmQ==
X-Received: by 2002:a17:906:5954:b0:ace:d95f:6582 with SMTP id
 a640c23a62f3a-ad2192d4b2cmr500955566b.53.1746884647411; 
 Sat, 10 May 2025 06:44:07 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:06 -0700 (PDT)
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
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, qemu-devel@nongnu.org
Subject: [PATCH v4 15/22] arm: qemu: Add a 64-bit SPL build
Date: Sat, 10 May 2025 15:42:13 +0200
Message-ID: <20250510134253.1581164-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=sjg@chromium.org; helo=mail-ej1-x62c.google.com
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

Add an 64-bit SPL build for qemu so we can test the standard passage
feature.

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
- Add a build for aarch64 as well

 arch/arm/dts/qemu-arm64-u-boot.dtsi  |  29 ++
 arch/arm/dts/qemu-arm64.dts          | 387 ++++++++++++++++++++++++++-
 arch/arm/mach-qemu/Kconfig           |  10 +-
 board/emulation/qemu-arm/Kconfig     |   5 +-
 board/emulation/qemu-arm/MAINTAINERS |   1 +
 configs/qemu_arm64_spl_defconfig     |  90 +++++++
 doc/board/emulation/qemu-arm.rst     |  41 ++-
 scripts/build-qemu.sh                |   6 +-
 8 files changed, 563 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/qemu-arm64-u-boot.dtsi
 create mode 100644 configs/qemu_arm64_spl_defconfig

diff --git a/arch/arm/dts/qemu-arm64-u-boot.dtsi b/arch/arm/dts/qemu-arm64-u-boot.dtsi
new file mode 100644
index 00000000000..31847e9518e
--- /dev/null
+++ b/arch/arm/dts/qemu-arm64-u-boot.dtsi
@@ -0,0 +1,29 @@
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
+	pl031@9010000 {
+		bootph,pre-ram;
+	};
+
+	pl061@9030000 {
+		bootph,pre-ram;
+	};
+};
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..62e29cb01fb 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Device tree for qemu_arm64
 
  * Copyright 2021 Google LLC
  */
@@ -13,3 +13,388 @@
 
 / {
 };
+
+#ifdef CONFIG_TARGET_QEMU_ARM_64BIT_SPL
+
+/ {
+	interrupt-parent = <0x00008002>;
+	model = "linux,dummy-virt";
+	#size-cells = <0x00000002>;
+	#address-cells = <0x00000002>;
+	compatible = "linux,dummy-virt";
+	psci {
+		migrate = <0xc4000005>;
+		cpu_on = <0xc4000003>;
+		cpu_off = <0x84000002>;
+		cpu_suspend = <0xc4000001>;
+		method = "hvc";
+		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
+	};
+	memory@40000000 {
+		reg = <0x00000000 0x40000000 0x00000000 0x08000000>;
+		device_type = "memory";
+	};
+	platform-bus@c000000 {
+		interrupt-parent = <0x00008002>;
+		ranges = <0x00000000 0x00000000 0x0c000000 0x02000000>;
+		#address-cells = <0x00000001>;
+		#size-cells = <0x00000001>;
+		compatible = "qemu,platform", "simple-bus";
+	};
+	fw-cfg@9020000 {
+		dma-coherent;
+		reg = <0x00000000 0x09020000 0x00000000 0x00000018>;
+		compatible = "qemu,fw-cfg-mmio";
+	};
+	virtio_mmio@a000000 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000010 0x00000001>;
+		reg = <0x00000000 0x0a000000 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000200 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000011 0x00000001>;
+		reg = <0x00000000 0x0a000200 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000400 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000012 0x00000001>;
+		reg = <0x00000000 0x0a000400 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000600 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000013 0x00000001>;
+		reg = <0x00000000 0x0a000600 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000800 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000014 0x00000001>;
+		reg = <0x00000000 0x0a000800 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000a00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000015 0x00000001>;
+		reg = <0x00000000 0x0a000a00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000c00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000016 0x00000001>;
+		reg = <0x00000000 0x0a000c00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a000e00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000017 0x00000001>;
+		reg = <0x00000000 0x0a000e00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001000 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000018 0x00000001>;
+		reg = <0x00000000 0x0a001000 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001200 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000019 0x00000001>;
+		reg = <0x00000000 0x0a001200 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001400 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001a 0x00000001>;
+		reg = <0x00000000 0x0a001400 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001600 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001b 0x00000001>;
+		reg = <0x00000000 0x0a001600 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001800 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001c 0x00000001>;
+		reg = <0x00000000 0x0a001800 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001a00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001d 0x00000001>;
+		reg = <0x00000000 0x0a001a00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001c00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001e 0x00000001>;
+		reg = <0x00000000 0x0a001c00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a001e00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000001f 0x00000001>;
+		reg = <0x00000000 0x0a001e00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002000 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000020 0x00000001>;
+		reg = <0x00000000 0x0a002000 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002200 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000021 0x00000001>;
+		reg = <0x00000000 0x0a002200 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002400 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000022 0x00000001>;
+		reg = <0x00000000 0x0a002400 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002600 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000023 0x00000001>;
+		reg = <0x00000000 0x0a002600 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002800 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000024 0x00000001>;
+		reg = <0x00000000 0x0a002800 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002a00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000025 0x00000001>;
+		reg = <0x00000000 0x0a002a00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002c00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000026 0x00000001>;
+		reg = <0x00000000 0x0a002c00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a002e00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000027 0x00000001>;
+		reg = <0x00000000 0x0a002e00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003000 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000028 0x00000001>;
+		reg = <0x00000000 0x0a003000 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003200 {
+		dma-coherent;
+		interrupts = <0x00000000 0x00000029 0x00000001>;
+		reg = <0x00000000 0x0a003200 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003400 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002a 0x00000001>;
+		reg = <0x00000000 0x0a003400 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003600 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002b 0x00000001>;
+		reg = <0x00000000 0x0a003600 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003800 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002c 0x00000001>;
+		reg = <0x00000000 0x0a003800 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003a00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002d 0x00000001>;
+		reg = <0x00000000 0x0a003a00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003c00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002e 0x00000001>;
+		reg = <0x00000000 0x0a003c00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	virtio_mmio@a003e00 {
+		dma-coherent;
+		interrupts = <0x00000000 0x0000002f 0x00000001>;
+		reg = <0x00000000 0x0a003e00 0x00000000 0x00000200>;
+		compatible = "virtio,mmio";
+	};
+	gpio-keys {
+		compatible = "gpio-keys";
+		poweroff {
+			gpios = <0x00008004 0x00000003 0x00000000>;
+			linux,code = <0x00000074>;
+			label = "GPIO Key Poweroff";
+		};
+	};
+	pl061@9030000 {
+		phandle = <0x00008004>;
+		clock-names = "apb_pclk";
+		clocks = <0x00008000>;
+		interrupts = <0x00000000 0x00000007 0x00000004>;
+		gpio-controller;
+		#gpio-cells = <0x00000002>;
+		compatible = "arm,pl061", "arm,primecell";
+		reg = <0x00000000 0x09030000 0x00000000 0x00001000>;
+	};
+	pcie@10000000 {
+		interrupt-map-mask = <0x00001800 0x00000000 0x00000000 0x00000007>;
+		interrupt-map = <0x00000000 0x00000000 0x00000000 0x00000001
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000003 0x00000004 0x00000000 0x00000000
+			0x00000000 0x00000002 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000004 0x00000004
+			0x00000000 0x00000000 0x00000000 0x00000003
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000005 0x00000004 0x00000000 0x00000000
+			0x00000000 0x00000004 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000006 0x00000004
+			0x00000800 0x00000000 0x00000000 0x00000001
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000004 0x00000004 0x00000800 0x00000000
+			0x00000000 0x00000002 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000005 0x00000004
+			0x00000800 0x00000000 0x00000000 0x00000003
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000006 0x00000004 0x00000800 0x00000000
+			0x00000000 0x00000004 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000003 0x00000004
+			0x00001000 0x00000000 0x00000000 0x00000001
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000005 0x00000004 0x00001000 0x00000000
+			0x00000000 0x00000002 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000006 0x00000004
+			0x00001000 0x00000000 0x00000000 0x00000003
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000003 0x00000004 0x00001000 0x00000000
+			0x00000000 0x00000004 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000004 0x00000004
+			0x00001800 0x00000000 0x00000000 0x00000001
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000006 0x00000004 0x00001800 0x00000000
+			0x00000000 0x00000002 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000003 0x00000004
+			0x00001800 0x00000000 0x00000000 0x00000003
+			0x00008002 0x00000000 0x00000000 0x00000000
+			0x00000004 0x00000004 0x00001800 0x00000000
+			0x00000000 0x00000004 0x00008002 0x00000000
+			0x00000000 0x00000000 0x00000005 0x00000004>;
+		#interrupt-cells = <0x00000001>;
+		ranges = <0x01000000 0x00000000
+			0x00000000 0x00000000 0x3eff0000 0x00000000
+			0x00010000 0x02000000 0x00000000 0x10000000
+			0x00000000 0x10000000 0x00000000 0x2eff0000
+			0x03000000 0x00000080 0x00000000 0x00000080
+			0x00000000 0x00000080 0x00000000>;
+		reg = <0x00000040 0x10000000 0x00000000 0x10000000>;
+		msi-map = <0x00000000 0x00008003 0x00000000 0x00010000>;
+		dma-coherent;
+		bus-range = <0x00000000 0x000000ff>;
+		linux,pci-domain = <0x00000000>;
+		#size-cells = <0x00000002>;
+		#address-cells = <0x00000003>;
+		device_type = "pci";
+		compatible = "pci-host-ecam-generic";
+	};
+	pl031@9010000 {
+		clock-names = "apb_pclk";
+		clocks = <0x00008000>;
+		interrupts = <0x00000000 0x00000002 0x00000004>;
+		reg = <0x00000000 0x09010000 0x00000000 0x00001000>;
+		compatible = "arm,pl031", "arm,primecell";
+	};
+	pl011@9000000 {
+		clock-names = "uartclk", "apb_pclk";
+		clocks = <0x00008000 0x00008000>;
+		interrupts = <0x00000000 0x00000001 0x00000004>;
+		reg = <0x00000000 0x09000000 0x00000000 0x00001000>;
+		compatible = "arm,pl011", "arm,primecell";
+	};
+	pmu {
+		interrupts = <0x00000001 0x00000007 0x00000104>;
+		compatible = "arm,armv8-pmuv3";
+	};
+	intc@8000000 {
+		phandle = <0x00008002>;
+		reg = <0x00000000 0x08000000 0x00000000 0x00010000
+			0x00000000 0x08010000 0x00000000 0x00010000>;
+		compatible = "arm,cortex-a15-gic";
+		ranges;
+		#size-cells = <0x00000002>;
+		#address-cells = <0x00000002>;
+		interrupt-controller;
+		#interrupt-cells = <0x00000003>;
+		v2m@8020000 {
+			phandle = <0x00008003>;
+			reg = <0x00000000 0x08020000 0x00000000 0x00001000>;
+			msi-controller;
+			compatible = "arm,gic-v2m-frame";
+		};
+	};
+	flash@0 {
+		bank-width = <0x00000004>;
+		reg = <0x00000000 0x00000000 0x00000000 0x04000000
+			0x00000000 0x04000000 0x00000000 0x04000000>;
+		compatible = "cfi-flash";
+	};
+	cpus {
+		#size-cells = <0x00000000>;
+		#address-cells = <0x00000001>;
+		cpu-map {
+			socket0 {
+				cluster0 {
+					core0 {
+						cpu = <0x00008001>;
+					};
+				};
+			};
+		};
+		cpu@0 {
+			phandle = <0x00008001>;
+			reg = <0x00000000>;
+			compatible = "arm,cortex-a57";
+			device_type = "cpu";
+		};
+	};
+	timer {
+		interrupts = <0x00000001 0x0000000d 0x00000104 0x00000001
+			0x0000000e 0x00000104 0x00000001 0x0000000b
+			0x00000104 0x00000001 0x0000000a 0x00000104>;
+		always-on;
+		compatible = "arm,armv8-timer", "arm,armv7-timer";
+	};
+	apb-pclk {
+		phandle = <0x00008000>;
+		clock-output-names = "clk24mhz";
+		clock-frequency = <0x016e3600>;
+		#clock-cells = <0x00000000>;
+		compatible = "fixed-clock";
+	};
+	chosen {
+		stdout-path = "/pl011@9000000";
+		rng-seed = <0x5c62d159 0x4f1ac320 0x51089618 0xfa6e4367
+				0x5cb012b5 0xfe4e6a54 0x8c970c5d 0xeb9bec3c>;
+		kaslr-seed = <0x358a89d6 0x32217e8d>;
+	};
+};
+
+#endif
diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 292c5f65c8e..1aea7205da4 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -36,9 +36,17 @@ config TARGET_QEMU_ARM_SBSA
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select MISC_INIT_R
 
+config TARGET_QEMU_ARM_64BIT_SPL
+	bool "ARMv8, 64bit with SPL"
+	select ARM64
+	select BOARD_LATE_INIT
+	select SPL
+	select BINMAN
+
 endchoice
 
-if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || TARGET_QEMU_ARM_32BIT_SPL
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
+	TARGET_QEMU_ARM_32BIT_SPL || TARGET_QEMU_ARM_64BIT_SPL
 
 config SYS_BOARD
 	default "qemu-arm"
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 2a8f052c0da..d35caa16d8f 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -31,7 +31,7 @@ config BOARD_SPECIFIC_OPTIONS
 
 endif
 
-if TARGET_QEMU_ARM_32BIT_SPL
+if TARGET_QEMU_ARM_32BIT_SPL || TARGET_QEMU_ARM_64BIT_SPL
 
 config SPL_TEXT_BASE
 	default 0x00000000
@@ -39,6 +39,9 @@ config SPL_TEXT_BASE
 config TEXT_BASE
 	default 0x00010000
 
+config SPL_MAX_SIZE
+	default 0x00010000
+
 endif
 
 source "board/emulation/common/Kconfig"
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 54682d6c0af..bb3168d47a7 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -8,6 +8,7 @@ F:	include/configs/qemu-sbsa.h
 F:	configs/qemu_arm_defconfig
 F:	configs/qemu_arm64_acpi_defconfig
 F:	configs/qemu_arm64_defconfig
+F:	configs/qemu_arm64_spl_defconfig
 F:	configs/qemu-arm-sbsa_defconfig
 
 QEMU ARM 'VIRT' BOARD
diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_spl_defconfig
new file mode 100644
index 00000000000..a9ed47c8d3b
--- /dev/null
+++ b/configs/qemu_arm64_spl_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_QEMU=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_BLOBLIST_SIZE_RELOC=0x2000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
+CONFIG_TARGET_QEMU_ARM_64BIT_SPL=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SYS_LOAD_ADDR=0x40200000
+CONFIG_DEBUG_UART_BASE=0x9000000
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_ENV_ADDR=0x4000000
+CONFIG_QEMU_MANUAL_DTB=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_EFI_HTTP_BOOT=y
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
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_CMD_SMBIOS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_EFIDEBUG=y
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
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_MMIO=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_TPM=y
+CONFIG_TPM_PCR_ALLOCATE=y
+CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index a8a1ba0e0f9..b03cb882c86 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -43,6 +43,11 @@ Set the CROSS_COMPILE environment variable as usual, and run:
     make qemu_arm_spl_defconfig
     make
 
+- for AArch64 with SPL::
+
+    make qemu_arm64_spl_defconfig
+    make
+
 Running U-Boot
 --------------
 The minimal QEMU command line to get U-Boot up and running is:
@@ -59,6 +64,10 @@ The minimal QEMU command line to get U-Boot up and running is:
 
     qemu-system-arm -machine virt -nographic -bios image.bin
 
+- For AArch64 with SPL::
+
+    qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios image.bin
+
 Note that for some odd reason qemu-system-aarch64 needs to be explicitly
 told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic argument
 ensures that output appears on the terminal. Use Ctrl-A X to quit.
@@ -215,11 +224,39 @@ devicetree is passed via standard passage::
     $ ./scripts/build-qemu.sh -a arm  -rsxw
     Running qemu-system-arm  -machine virt -accel tcg -display none -serial mon:stdio
 
-    U-Boot SPL 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 09:39:51 -0600)
+    U-Boot SPL 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 06:39:51 -0600)
+    Trying to boot from QEMU
+
+
+    U-Boot 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 06:39:51 -0600)
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
+The aarch64 build is similar::
+
+    $ ./scripts/build-qemu.sh -a arm  -rsxw
+    Running qemu-system-arm  -machine virt -accel tcg -display none -serial mon:stdio
+
+    U-Boot SPL 2025.04-01115-g38a16f456571 (Apr 17 2025 - 06:43:50 -0600)
     Trying to boot from QEMU
 
 
-    U-Boot 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 09:39:51 -0600)
+    U-Boot 2025.04-01115-g38a16f456571 (Apr 17 2025 - 06:43:50 -0600)
 
     DRAM:  128 MiB
     using memory 0x466aa000-0x476ea000 for malloc()
diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index 678116d1cc7..c23e50e91a6 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -178,7 +178,11 @@ arm)
 	extra+=" -machine virt -accel tcg"
 	suffix="arm"
 	if [[ "${bitness}" == "64" ]]; then
-		BOARD="qemu_arm64"
+		if [ -n "${xpl}" ]; then
+			BOARD="qemu_arm64_spl"
+		else
+			BOARD="qemu_arm64"
+		fi
 		qemu=qemu-system-aarch64
 		extra+=" -cpu cortex-a57"
 		suffix="arm64"
-- 
2.43.0


