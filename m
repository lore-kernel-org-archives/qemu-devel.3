Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B88C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Tne-0006gq-RI; Thu, 17 Apr 2025 14:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1u5TnZ-0006g2-GC
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:17:17 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1u5TnT-0004MT-Kj
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:17:16 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d5eb0ec2bdso3712365ab.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913829; x=1745518629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj/s+//JHWRW5/Fl3HmXqKR2IaOMDUexwfbLc5IEV6A=;
 b=YUOe+KRvvK2cyVCnsDhBoJoU3QDY6Bi03iCdYyHCaqo3mH65qr84D6iXdlWlqXj8yT
 sqTG8EiBpqKlWRtl2jONW88Smf3ZxqEh2QIS1cBWxH/ycREW3/tvEiQ+pNlV62/xHON4
 oy8nFL99GDPaIEYvhPYeBlSLwPhaWA2Aab0kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913829; x=1745518629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gj/s+//JHWRW5/Fl3HmXqKR2IaOMDUexwfbLc5IEV6A=;
 b=CwIkMijol1XKYs0y/jqzKTFdH+0uQ+C6ut90oSUwHHGoJSK+Bfy349oML7GQDjpb7s
 O8hrXhAHytNUGbaA93OJMcmmqqfYNWPHIit3gYoF40MgsUpZRrdH6qQpIYUaUrcVnUf+
 8qgnN0L9MMZ3f48GEQR64zvukbcKUGTT4/ARU/Yn1nwaBOSBu2YB0B1Seg8+gtm86BXs
 ZLOVo+M1pgguVApUoK4P62s0HVNfpwlCnAWva9iEbzB/VKdN4+gjz8kkk50QTgUiNk3m
 cSJYILoDRrygFqpaMZRnJzzhkJb9gNErZZvjMg49OjAvSWWGcSGzqPLKFwujYKDhY9zn
 TpGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkZyUSSM7hZrL/FFnX2MR1z6aXel8gxf4DZjm51FDesePruK6z8jwOBqoG1No9x6DWHWaEG8ZdtIvX@nongnu.org
X-Gm-Message-State: AOJu0YwHETaVPKnrXWTubiS1KpOpAkK+DerLacpaDJwMYS++kkv9dH+j
 +eATr9MDq72C12BeW9QBFusgRQmjHgg/dBlpGSvIkeEasTEiIuYZmNrIeZsDaQ==
X-Gm-Gg: ASbGncuS7RpkU6qDvdVaHwAq1v9XhNJFUT+6Md671qb7JvG1rLjgSk0l4y8pbZV9TPl
 hEiDdiK8Ng2buOyWObN0Ds4rqZXfbE+jpV7n0KZrWyDY2UQNlCjeM98ngTt4K8CYQia6kSRSB7W
 06B1wY8WGfzMpjcE9k89TWSkO286mHzcY+kKL1+eLjaUzWRWWklHn3Lr/SM3ubZlIFdwnZ/QwwI
 h42Vt4ZDpsKdXMDnBVv8X2PBjthRJuk3M9h69NGSnlNVwJO7Ryu/5bjbvLQJbwyEPJbC2HaGh3t
 vQwf256O54Cy3K6xdPqFxaLQsWJL1VLK8OMt20yaQcFJ7wRLsuvF5MAXXrqwiL61Zt37vRHOWY1
 thA==
X-Google-Smtp-Source: AGHT+IGoXtSRPzbUzjDz5Z/EU3yJaZIUaTmpHWk0AOHGwj2Dd1i/bVRxOd0xNgI6g77kcxe0IeN2GQ==
X-Received: by 2002:a05:6e02:1646:b0:3d3:d994:e92e with SMTP id
 e9e14a558f8ab-3d89417e585mr531985ab.17.1744913829461; 
 Thu, 17 Apr 2025 11:17:09 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, qemu-devel@nongnu.org
Subject: [PATCH v3 15/22] arm: qemu: Add a 64-bit SPL build
Date: Thu, 17 Apr 2025 12:15:57 -0600
Message-ID: <20250417181613.1355024-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=sjg@chromium.org; helo=mail-il1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Changes in v3:
- Add a build for aarch64 as well

 arch/arm/dts/qemu-arm64-u-boot.dtsi  |  29 +++
 arch/arm/dts/qemu-arm64.dts          | 338 ++++++++++++++++++++++++++-
 arch/arm/mach-qemu/Kconfig           |  10 +-
 board/emulation/qemu-arm/Kconfig     |   5 +-
 board/emulation/qemu-arm/MAINTAINERS |   1 +
 configs/qemu_arm64_spl_defconfig     |  90 +++++++
 doc/board/emulation/qemu-arm.rst     |  41 +++-
 scripts/build-qemu.sh                |   6 +-
 8 files changed, 514 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/qemu-arm64-u-boot.dtsi
 create mode 100644 configs/qemu_arm64_spl_defconfig

diff --git a/arch/arm/dts/qemu-arm64-u-boot.dtsi b/arch/arm/dts/qemu-arm64-=
u-boot.dtsi
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
+			size =3D <0x10000>;
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
index 95fcf53ed74..69a0e856acc 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Device tree for qemu_arm64
=20
  * Copyright 2021 Google LLC
  */
@@ -13,3 +13,339 @@
=20
 / {
 };
+
+#ifdef CONFIG_TARGET_QEMU_ARM_64BIT_SPL
+
+/ {
+	interrupt-parent =3D <0x00008002>;
+	model =3D "linux,dummy-virt";
+	#size-cells =3D <0x00000002>;
+	#address-cells =3D <0x00000002>;
+	compatible =3D "linux,dummy-virt";
+	psci {
+		migrate =3D <0xc4000005>;
+		cpu_on =3D <0xc4000003>;
+		cpu_off =3D <0x84000002>;
+		cpu_suspend =3D <0xc4000001>;
+		method =3D "hvc";
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
+	};
+	memory@40000000 {
+		reg =3D <0x00000000 0x40000000 0x00000000 0x08000000>;
+		device_type =3D "memory";
+	};
+	platform-bus@c000000 {
+		interrupt-parent =3D <0x00008002>;
+		ranges =3D <0x00000000 0x00000000 0x0c000000 0x02000000>;
+		#address-cells =3D <0x00000001>;
+		#size-cells =3D <0x00000001>;
+		compatible =3D "qemu,platform", "simple-bus";
+	};
+	fw-cfg@9020000 {
+		dma-coherent;
+		reg =3D <0x00000000 0x09020000 0x00000000 0x00000018>;
+		compatible =3D "qemu,fw-cfg-mmio";
+	};
+	virtio_mmio@a000000 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000010 0x00000001>;
+		reg =3D <0x00000000 0x0a000000 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000200 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000011 0x00000001>;
+		reg =3D <0x00000000 0x0a000200 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000400 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000012 0x00000001>;
+		reg =3D <0x00000000 0x0a000400 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000600 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000013 0x00000001>;
+		reg =3D <0x00000000 0x0a000600 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000800 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000014 0x00000001>;
+		reg =3D <0x00000000 0x0a000800 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000a00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000015 0x00000001>;
+		reg =3D <0x00000000 0x0a000a00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000c00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000016 0x00000001>;
+		reg =3D <0x00000000 0x0a000c00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a000e00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000017 0x00000001>;
+		reg =3D <0x00000000 0x0a000e00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001000 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000018 0x00000001>;
+		reg =3D <0x00000000 0x0a001000 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001200 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000019 0x00000001>;
+		reg =3D <0x00000000 0x0a001200 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001400 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001a 0x00000001>;
+		reg =3D <0x00000000 0x0a001400 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001600 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001b 0x00000001>;
+		reg =3D <0x00000000 0x0a001600 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001800 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001c 0x00000001>;
+		reg =3D <0x00000000 0x0a001800 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001a00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001d 0x00000001>;
+		reg =3D <0x00000000 0x0a001a00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001c00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001e 0x00000001>;
+		reg =3D <0x00000000 0x0a001c00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a001e00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000001f 0x00000001>;
+		reg =3D <0x00000000 0x0a001e00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002000 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000020 0x00000001>;
+		reg =3D <0x00000000 0x0a002000 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002200 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000021 0x00000001>;
+		reg =3D <0x00000000 0x0a002200 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002400 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000022 0x00000001>;
+		reg =3D <0x00000000 0x0a002400 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002600 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000023 0x00000001>;
+		reg =3D <0x00000000 0x0a002600 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002800 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000024 0x00000001>;
+		reg =3D <0x00000000 0x0a002800 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002a00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000025 0x00000001>;
+		reg =3D <0x00000000 0x0a002a00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002c00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000026 0x00000001>;
+		reg =3D <0x00000000 0x0a002c00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a002e00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000027 0x00000001>;
+		reg =3D <0x00000000 0x0a002e00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003000 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000028 0x00000001>;
+		reg =3D <0x00000000 0x0a003000 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003200 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x00000029 0x00000001>;
+		reg =3D <0x00000000 0x0a003200 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003400 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002a 0x00000001>;
+		reg =3D <0x00000000 0x0a003400 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003600 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002b 0x00000001>;
+		reg =3D <0x00000000 0x0a003600 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003800 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002c 0x00000001>;
+		reg =3D <0x00000000 0x0a003800 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003a00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002d 0x00000001>;
+		reg =3D <0x00000000 0x0a003a00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003c00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002e 0x00000001>;
+		reg =3D <0x00000000 0x0a003c00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	virtio_mmio@a003e00 {
+		dma-coherent;
+		interrupts =3D <0x00000000 0x0000002f 0x00000001>;
+		reg =3D <0x00000000 0x0a003e00 0x00000000 0x00000200>;
+		compatible =3D "virtio,mmio";
+	};
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		poweroff {
+			gpios =3D <0x00008004 0x00000003 0x00000000>;
+			linux,code =3D <0x00000074>;
+			label =3D "GPIO Key Poweroff";
+		};
+	};
+	pl061@9030000 {
+		phandle =3D <0x00008004>;
+		clock-names =3D "apb_pclk";
+		clocks =3D <0x00008000>;
+		interrupts =3D <0x00000000 0x00000007 0x00000004>;
+		gpio-controller;
+		#gpio-cells =3D <0x00000002>;
+		compatible =3D "arm,pl061", "arm,primecell";
+		reg =3D <0x00000000 0x09030000 0x00000000 0x00001000>;
+	};
+	pcie@10000000 {
+		interrupt-map-mask =3D <0x00001800 0x00000000 0x00000000 0x00000007>;
+		interrupt-map =3D <0x00000000 0x00000000 0x00000000 0x00000001 0x0000800=
2 0x00000000 0x00000000 0x00000000 0x00000003 0x00000004 0x00000000 0x00000=
000 0x00000000 0x00000002 0x00008002 0x00000000 0x00000000 0x00000000 0x000=
00004 0x00000004 0x00000000 0x00000000 0x00000000 0x00000003 0x00008002 0x0=
0000000 0x00000000 0x00000000 0x00000005 0x00000004 0x00000000 0x00000000 0=
x00000000 0x00000004 0x00008002 0x00000000 0x00000000 0x00000000 0x00000006=
 0x00000004 0x00000800 0x00000000 0x00000000 0x00000001 0x00008002 0x000000=
00 0x00000000 0x00000000 0x00000004 0x00000004 0x00000800 0x00000000 0x0000=
0000 0x00000002 0x00008002 0x00000000 0x00000000 0x00000000 0x00000005 0x00=
000004 0x00000800 0x00000000 0x00000000 0x00000003 0x00008002 0x00000000 0x=
00000000 0x00000000 0x00000006 0x00000004 0x00000800 0x00000000 0x00000000 =
0x00000004 0x00008002 0x00000000 0x00000000 0x00000000 0x00000003 0x0000000=
4 0x00001000 0x00000000 0x00000000 0x00000001 0x00008002 0x00000000 0x00000=
000 0x00000000 0x00000005 0x00000004 0x00001000 0x00000000 0x00000000 0x000=
00002 0x00008002 0x00000000 0x00000000 0x00000000 0x00000006 0x00000004 0x0=
0001000 0x00000000 0x00000000 0x00000003 0x00008002 0x00000000 0x00000000 0=
x00000000 0x00000003 0x00000004 0x00001000 0x00000000 0x00000000 0x00000004=
 0x00008002 0x00000000 0x00000000 0x00000000 0x00000004 0x00000004 0x000018=
00 0x00000000 0x00000000 0x00000001 0x00008002 0x00000000 0x00000000 0x0000=
0000 0x00000006 0x00000004 0x00001800 0x00000000 0x00000000 0x00000002 0x00=
008002 0x00000000 0x00000000 0x00000000 0x00000003 0x00000004 0x00001800 0x=
00000000 0x00000000 0x00000003 0x00008002 0x00000000 0x00000000 0x00000000 =
0x00000004 0x00000004 0x00001800 0x00000000 0x00000000 0x00000004 0x0000800=
2 0x00000000 0x00000000 0x00000000 0x00000005 0x00000004>;
+		#interrupt-cells =3D <0x00000001>;
+		ranges =3D <0x01000000 0x00000000 0x00000000 0x00000000 0x3eff0000 0x000=
00000 0x00010000 0x02000000 0x00000000 0x10000000 0x00000000 0x10000000 0x0=
0000000 0x2eff0000 0x03000000 0x00000080 0x00000000 0x00000080 0x00000000 0=
x00000080 0x00000000>;
+		reg =3D <0x00000040 0x10000000 0x00000000 0x10000000>;
+		msi-map =3D <0x00000000 0x00008003 0x00000000 0x00010000>;
+		dma-coherent;
+		bus-range =3D <0x00000000 0x000000ff>;
+		linux,pci-domain =3D <0x00000000>;
+		#size-cells =3D <0x00000002>;
+		#address-cells =3D <0x00000003>;
+		device_type =3D "pci";
+		compatible =3D "pci-host-ecam-generic";
+	};
+	pl031@9010000 {
+		clock-names =3D "apb_pclk";
+		clocks =3D <0x00008000>;
+		interrupts =3D <0x00000000 0x00000002 0x00000004>;
+		reg =3D <0x00000000 0x09010000 0x00000000 0x00001000>;
+		compatible =3D "arm,pl031", "arm,primecell";
+	};
+	pl011@9000000 {
+		clock-names =3D "uartclk", "apb_pclk";
+		clocks =3D <0x00008000 0x00008000>;
+		interrupts =3D <0x00000000 0x00000001 0x00000004>;
+		reg =3D <0x00000000 0x09000000 0x00000000 0x00001000>;
+		compatible =3D "arm,pl011", "arm,primecell";
+	};
+	pmu {
+		interrupts =3D <0x00000001 0x00000007 0x00000104>;
+		compatible =3D "arm,armv8-pmuv3";
+	};
+	intc@8000000 {
+		phandle =3D <0x00008002>;
+		reg =3D <0x00000000 0x08000000 0x00000000 0x00010000 0x00000000 0x080100=
00 0x00000000 0x00010000>;
+		compatible =3D "arm,cortex-a15-gic";
+		ranges;
+		#size-cells =3D <0x00000002>;
+		#address-cells =3D <0x00000002>;
+		interrupt-controller;
+		#interrupt-cells =3D <0x00000003>;
+		v2m@8020000 {
+			phandle =3D <0x00008003>;
+			reg =3D <0x00000000 0x08020000 0x00000000 0x00001000>;
+			msi-controller;
+			compatible =3D "arm,gic-v2m-frame";
+		};
+	};
+	flash@0 {
+		bank-width =3D <0x00000004>;
+		reg =3D <0x00000000 0x00000000 0x00000000 0x04000000 0x00000000 0x040000=
00 0x00000000 0x04000000>;
+		compatible =3D "cfi-flash";
+	};
+	cpus {
+		#size-cells =3D <0x00000000>;
+		#address-cells =3D <0x00000001>;
+		cpu-map {
+			socket0 {
+				cluster0 {
+					core0 {
+						cpu =3D <0x00008001>;
+					};
+				};
+			};
+		};
+		cpu@0 {
+			phandle =3D <0x00008001>;
+			reg =3D <0x00000000>;
+			compatible =3D "arm,cortex-a57";
+			device_type =3D "cpu";
+		};
+	};
+	timer {
+		interrupts =3D <0x00000001 0x0000000d 0x00000104 0x00000001 0x0000000e 0=
x00000104 0x00000001 0x0000000b 0x00000104 0x00000001 0x0000000a 0x00000104=
>;
+		always-on;
+		compatible =3D "arm,armv8-timer", "arm,armv7-timer";
+	};
+	apb-pclk {
+		phandle =3D <0x00008000>;
+		clock-output-names =3D "clk24mhz";
+		clock-frequency =3D <0x016e3600>;
+		#clock-cells =3D <0x00000000>;
+		compatible =3D "fixed-clock";
+	};
+	chosen {
+		stdout-path =3D "/pl011@9000000";
+		rng-seed =3D <0x5c62d159 0x4f1ac320 0x51089618 0xfa6e4367 0x5cb012b5 0xf=
e4e6a54 0x8c970c5d 0xeb9bec3c>;
+		kaslr-seed =3D <0x358a89d6 0x32217e8d>;
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
=20
+config TARGET_QEMU_ARM_64BIT_SPL
+	bool "ARMv8, 64bit with SPL"
+	select ARM64
+	select BOARD_LATE_INIT
+	select SPL
+	select BINMAN
+
 endchoice
=20
-if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || TARGET_QEMU_ARM_32BIT=
_SPL
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
+	TARGET_QEMU_ARM_32BIT_SPL || TARGET_QEMU_ARM_64BIT_SPL
=20
 config SYS_BOARD
 	default "qemu-arm"
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kc=
onfig
index 2a8f052c0da..d35caa16d8f 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -31,7 +31,7 @@ config BOARD_SPECIFIC_OPTIONS
=20
 endif
=20
-if TARGET_QEMU_ARM_32BIT_SPL
+if TARGET_QEMU_ARM_32BIT_SPL || TARGET_QEMU_ARM_64BIT_SPL
=20
 config SPL_TEXT_BASE
 	default 0x00000000
@@ -39,6 +39,9 @@ config SPL_TEXT_BASE
 config TEXT_BASE
 	default 0x00010000
=20
+config SPL_MAX_SIZE
+	default 0x00010000
+
 endif
=20
 source "board/emulation/common/Kconfig"
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-ar=
m/MAINTAINERS
index f8377c4cc0b..21ee1016f6d 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -8,4 +8,5 @@ F:	include/configs/qemu-sbsa.h
 F:	configs/qemu_arm_defconfig
 F:	configs/qemu_arm_spl_defconfig
 F:	configs/qemu_arm64_defconfig
+F:	configs/qemu_arm64_spl_defconfig
 F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_spl_defc=
onfig
new file mode 100644
index 00000000000..a9ed47c8d3b
--- /dev/null
+++ b/configs/qemu_arm64_spl_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=3Dy
+CONFIG_POSITION_INDEPENDENT=3Dy
+CONFIG_ARCH_QEMU=3Dy
+CONFIG_SYS_MALLOC_LEN=3D0x1000000
+CONFIG_BLOBLIST_SIZE_RELOC=3D0x2000
+CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
+CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x40200000
+CONFIG_ENV_SIZE=3D0x40000
+CONFIG_ENV_SECT_SIZE=3D0x40000
+CONFIG_DEFAULT_DEVICE_TREE=3D"qemu-arm64"
+CONFIG_TARGET_QEMU_ARM_64BIT_SPL=3Dy
+CONFIG_SPL_SERIAL=3Dy
+CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x9000
+CONFIG_SYS_LOAD_ADDR=3D0x40200000
+CONFIG_DEBUG_UART_BASE=3D0x9000000
+CONFIG_DEBUG_UART_CLOCK=3D0
+CONFIG_ARMV8_CRYPTO=3Dy
+CONFIG_ENV_ADDR=3D0x4000000
+CONFIG_QEMU_MANUAL_DTB=3Dy
+CONFIG_PCI=3Dy
+CONFIG_DEBUG_UART=3Dy
+CONFIG_AHCI=3Dy
+CONFIG_EFI_HTTP_BOOT=3Dy
+CONFIG_FIT=3Dy
+CONFIG_FIT_SIGNATURE=3Dy
+CONFIG_FIT_VERBOSE=3Dy
+CONFIG_FIT_BEST_MATCH=3Dy
+CONFIG_BOOTSTD_FULL=3Dy
+CONFIG_LEGACY_IMAGE_FORMAT=3Dy
+CONFIG_USE_PREBOOT=3Dy
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_PCI_INIT_R=3Dy
+CONFIG_BLOBLIST=3Dy
+CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=3Dy
+CONFIG_SPL_NO_BSS_LIMIT=3Dy
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_CMD_SMBIOS=3Dy
+CONFIG_CMD_BOOTZ=3Dy
+CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
+CONFIG_CMD_NVEDIT_EFI=3Dy
+CONFIG_CMD_DFU=3Dy
+CONFIG_CMD_MTD=3Dy
+CONFIG_CMD_PCI=3Dy
+CONFIG_CMD_EFIDEBUG=3Dy
+CONFIG_CMD_TPM=3Dy
+CONFIG_CMD_MTDPARTS=3Dy
+CONFIG_SPL_OF_CONTROL=3Dy
+CONFIG_OF_BOARD=3Dy
+CONFIG_ENV_IS_IN_FLASH=3Dy
+CONFIG_SPL_DM=3Dy
+CONFIG_SCSI_AHCI=3Dy
+CONFIG_AHCI_PCI=3Dy
+CONFIG_DFU_TFTP=3Dy
+CONFIG_DFU_MTD=3Dy
+CONFIG_DFU_RAM=3Dy
+# CONFIG_MMC is not set
+CONFIG_MTD=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_MTD_NOR_FLASH=3Dy
+CONFIG_FLASH_SHOW_PROGRESS=3D0
+CONFIG_CFI_FLASH=3Dy
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=3Dy
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
+CONFIG_FLASH_CFI_MTD=3Dy
+CONFIG_SYS_FLASH_CFI=3Dy
+CONFIG_SYS_MAX_FLASH_SECT=3D256
+CONFIG_SYS_MAX_FLASH_BANKS=3D2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=3Dy
+CONFIG_E1000=3Dy
+CONFIG_NVME_PCI=3Dy
+CONFIG_PCIE_ECAM_GENERIC=3Dy
+CONFIG_SCSI=3Dy
+CONFIG_DEBUG_UART_PL011=3Dy
+CONFIG_DEBUG_UART_SHIFT=3D2
+CONFIG_SYSINFO=3Dy
+CONFIG_SYSINFO_SMBIOS=3Dy
+CONFIG_SYSRESET=3Dy
+CONFIG_SPL_SYSRESET=3Dy
+CONFIG_SYSRESET_CMD_POWEROFF=3Dy
+CONFIG_SYSRESET_PSCI=3Dy
+CONFIG_TPM2_MMIO=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_PCI=3Dy
+CONFIG_SEMIHOSTING=3Dy
+CONFIG_MBEDTLS_LIB=3Dy
+CONFIG_TPM=3Dy
+CONFIG_TPM_PCR_ALLOCATE=3Dy
+CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=3Dy
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-ar=
m.rst
index a8a1ba0e0f9..b03cb882c86 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -43,6 +43,11 @@ Set the CROSS_COMPILE environment variable as usual, and=
 run:
     make qemu_arm_spl_defconfig
     make
=20
+- for AArch64 with SPL::
+
+    make qemu_arm64_spl_defconfig
+    make
+
 Running U-Boot
 --------------
 The minimal QEMU command line to get U-Boot up and running is:
@@ -59,6 +64,10 @@ The minimal QEMU command line to get U-Boot up and runni=
ng is:
=20
     qemu-system-arm -machine virt -nographic -bios image.bin
=20
+- For AArch64 with SPL::
+
+    qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios ima=
ge.bin
+
 Note that for some odd reason qemu-system-aarch64 needs to be explicitly
 told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic ar=
gument
 ensures that output appears on the terminal. Use Ctrl-A X to quit.
@@ -215,11 +224,39 @@ devicetree is passed via standard passage::
     $ ./scripts/build-qemu.sh -a arm  -rsxw
     Running qemu-system-arm  -machine virt -accel tcg -display none -seria=
l mon:stdio
=20
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
+    Loading Environment from Flash... *** Warning - bad CRC, using default=
 environment
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
+    =3D>
+
+The aarch64 build is similar::
+
+    $ ./scripts/build-qemu.sh -a arm  -rsxw
+    Running qemu-system-arm  -machine virt -accel tcg -display none -seria=
l mon:stdio
+
+    U-Boot SPL 2025.04-01115-g38a16f456571 (Apr 17 2025 - 06:43:50 -0600)
     Trying to boot from QEMU
=20
=20
-    U-Boot 2025.04-01115-g0b14f5ab2aa1 (Apr 17 2025 - 09:39:51 -0600)
+    U-Boot 2025.04-01115-g38a16f456571 (Apr 17 2025 - 06:43:50 -0600)
=20
     DRAM:  128 MiB
     using memory 0x466aa000-0x476ea000 for malloc()
diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index 678116d1cc7..c23e50e91a6 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -178,7 +178,11 @@ arm)
 	extra+=3D" -machine virt -accel tcg"
 	suffix=3D"arm"
 	if [[ "${bitness}" =3D=3D "64" ]]; then
-		BOARD=3D"qemu_arm64"
+		if [ -n "${xpl}" ]; then
+			BOARD=3D"qemu_arm64_spl"
+		else
+			BOARD=3D"qemu_arm64"
+		fi
 		qemu=3Dqemu-system-aarch64
 		extra+=3D" -cpu cortex-a57"
 		suffix=3D"arm64"
--=20
2.43.0


