Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139C6D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIne-00077c-5p; Fri, 23 Jan 2026 10:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInG-00071w-W3
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInE-00030q-Ag
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so1789582f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180986; x=1769785786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZNP6KP85dajoQNFC5dSv+ufczUFqWljygvZZe+JtVzc=;
 b=rxhMrSuElgmAKBNBTY1Aa5a0ieypPpHum85xaYIRFcC531SZKyL9eV+5aO+KX/AGp9
 A176XpdxIBqTaqWHHWtAB2Pkgb7pfoKnRGqluky96ixbTjE6pw22/XwrlRB0RooHX7fs
 YelhJqmiRYgrfRgmjm+JZ9qjPd93lniUtFKKZy3h0dzbuDIbSq9/biIKJQe9QMGGBz6M
 u7jdBr3etHQ1Tbl50isJWAlUVqb78qWbI2jUdEbA74L8fXm05536K+4gfDU66vRf9qbU
 wXZ74MpIC8AinKCydj2z2NkgWCxPCrsWzE/MmQRsNAN5KpgeI8tyzMH+5oOiM3bFYGSc
 utzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180986; x=1769785786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZNP6KP85dajoQNFC5dSv+ufczUFqWljygvZZe+JtVzc=;
 b=is2F+2iamLdxorx8sBv43zFDq34d4dG+AxKxk18DkbK73uriWOMbSPWWd7+1PKfD39
 WUtUgNHuVhoXPneG77O+1lVWieCcFbCTuS7httQI4yhyQN75u6GvjmKGagHNUn+VZEuZ
 tQaB65aBzYcDnJzXB2EUbkM7ZEZ/hio4hmShpWjVwalTnyBFdT7hO7LdXDO+EbNR23wh
 WPxxbq+awxXPxBJH3mDCie7h30u1cj4it0Mh7gws1B3PKwEitDf7N57je3ekFnFCH0Yu
 HH2Om5Ey/IkDok0Ooad9/LGoTRCSkx+RZ6NTWYVhZlYGUd6STtBSs/tHD/L6gIX9AZCZ
 yntw==
X-Gm-Message-State: AOJu0YzkF7RsSgkTFqHWsdORkyg8xb8QKocrTCnyZ0qqHHjymoi9SgIf
 AUzAUl+k0Mp6MGcYpzv8+3ja/x02R2Cglv5uuOYFp0y7L+yIO0T4LQ+kWYEtnJd2lYIX3bGEGrT
 yCQrxJSE=
X-Gm-Gg: AZuq6aKGTBiAzSgcU3fFDu7rxk1OyPSsrsXZZy175ovAD3oFEzeQHDBsTDFaPhdwND1
 61kBq6mvA+KhjghPJp4V9wvvpEZNY5FsM01CNXfLahECNvfzxgX0B0sXs7aFv/OHm/kyyPdN0XK
 V9S0eGu8RP76jZAqDnCNs7ZYgEPEB6d+ydbDkdVcHgWmI7q6IBJpwpMdgddJPt6mX0iE0WHsdHl
 AfNMN5xhJsILJzGEfpBHXi3VFLS0IERPONW/O3/nZ8O8IiD8L9Uof5txzbjHi385lYjFi9OptuF
 tM6noS6J0vhh0YGxDSU9pWDrA1ECvVzgXoOqrxh/XbQbA9KI+VLgN3JhIved+2mKFmlAvEZWUZI
 lgMFNB/dGb1TMg4i/X0ztCdnfGbf+2ZIziDZgzV1xb2T5lUcO6WjNPnyKsNZYV+UDNsFSxBDNEL
 Q1RiP1ACo5Nyte6py1AAiTHkLfj6tqOeB2WGbbE+MLMPxYjynLgapI
X-Received: by 2002:a05:6000:2dc8:b0:435:9cf1:2833 with SMTP id
 ffacd0b85a97d-435b1587944mr6717384f8f.12.1769180986217; 
 Fri, 23 Jan 2026 07:09:46 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/22] docs: Be consistent about capitalization of 'Arm' (again)
Date: Fri, 23 Jan 2026 15:09:22 +0000
Message-ID: <20260123150941.1877768-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

The company 'Arm' went through a rebranding many years back
involving a recapitalization from 'ARM' to 'Arm'. As a result
our documentation is a bit inconsistent between the two forms.
It's not worth trying to update everywhere in QEMU, but it's
easy enough to make docs/ consistent.

We last did this in commit 6fe6d6c9a in 2020, but a few new
uses of the wrong capitalization have crept back in since.

As before, "ARMv8" and similar architecture names, and
older CPU names like "ARM926" still retain all-caps.

In a few places we make minor grammar fixups as we touch
the sentences we're fixing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260115150545.669444-1-peter.maydell@linaro.org
---
 docs/devel/testing/qgraph.rst        |  8 ++++----
 docs/devel/vfio-iommufd.rst          |  2 +-
 docs/specs/fsi.rst                   |  2 +-
 docs/system/arm/aspeed.rst           |  6 +++---
 docs/system/arm/b-l475e-iot01a.rst   |  2 +-
 docs/system/arm/nrf.rst              |  4 ++--
 docs/system/arm/stm32.rst            | 12 ++++++------
 docs/system/arm/xlnx-versal-virt.rst | 16 ++++++++--------
 docs/system/guest-loader.rst         |  2 +-
 docs/system/replay.rst               |  2 +-
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/docs/devel/testing/qgraph.rst b/docs/devel/testing/qgraph.rst
index 43342d9d65..ca63d1ea98 100644
--- a/docs/devel/testing/qgraph.rst
+++ b/docs/devel/testing/qgraph.rst
@@ -8,7 +8,7 @@ take care of booting QEMU with the right machine and devices.
 This makes each test "hardcoded" for a specific configuration, reducing
 the possible coverage that it can reach.
 
-For example, the sdhci device is supported on both x86_64 and ARM boards,
+For example, the sdhci device is supported on both x86_64 and Arm boards,
 therefore a generic sdhci test should test all machines and drivers that
 support that device.
 Using only libqos APIs, the test has to manually take care of
@@ -195,7 +195,7 @@ there.
 The ``arm/raspi2b`` machine node is listed as "UNAVAILABLE". Although it is
 reachable from the root via '' -> 'arm/raspi2b' the node is unavailable because
 the QEMU binary did not list it when queried by the framework. This is expected
-because we used the ``qemu-system-x86_64`` binary which does not support ARM
+because we used the ``qemu-system-x86_64`` binary which does not support Arm
 machine types.
 
 If a test is unexpectedly listed as "UNAVAILABLE", first check that the "ALL
@@ -214,9 +214,9 @@ Here we continue the ``sdhci`` use case, with the following scenario:
 
 - ``sdhci-test`` aims to test the ``read[q,w], writeq`` functions
   offered by the ``sdhci`` drivers.
-- The current ``sdhci`` device is supported by both ``x86_64/pc`` and ``ARM``
+- The current ``sdhci`` device is supported by both ``x86_64/pc`` and Arm
   (in this example we focus on the ``arm-raspi2b``) machines.
-- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for ``ARM`` and
+- QEMU offers 2 types of drivers: ``QSDHCI_MemoryMapped`` for Arm and
   ``QSDHCI_PCI`` for ``x86_64/pc``. Both implement the
   ``read[q,w], writeq`` functions.
 
diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 6928b47643..78bcdffac7 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -122,7 +122,7 @@ container:
 Supported platform
 ==================
 
-Supports x86, ARM and s390x currently.
+Supports x86, Arm and s390x currently.
 
 Caveats
 =======
diff --git a/docs/specs/fsi.rst b/docs/specs/fsi.rst
index af87822531..f7d86d3e37 100644
--- a/docs/specs/fsi.rst
+++ b/docs/specs/fsi.rst
@@ -40,7 +40,7 @@ for the implementation are: (see the `FSI specification`_ for more details)
    MMIO-mapping of the CFAM address straight onto a sub-region of the OPB
    address space.
 
-5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in the
+5. An APB-to-OPB bridge enabling access to the OPB from the Arm core in the
    AST2600. Hardware limitations prevent the OPB from being directly mapped
    into APB, so all accesses are indirect through the bridge.
 
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 4fa1739cb5..97e14b7d33 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -5,7 +5,7 @@ The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
 Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
 AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
-with dual cores ARM Cortex-A7 CPUs (1.2GHz).
+with dual cores Arm Cortex-A7 CPUs (1.2GHz).
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -279,7 +279,7 @@ Aspeed 2700 family boards (``ast2700-evb``, ``ast2700fc``)
 
 The QEMU Aspeed machines model BMCs of Aspeed evaluation boards.
 They are based on different releases of the Aspeed SoC :
-the AST2700 with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz).
+the AST2700 with quad cores Arm Cortex-A35 64 bits CPUs (1.6GHz).
 
 The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
 etc.
@@ -453,7 +453,7 @@ Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb
 
 The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
 evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
-and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
+and AST1060 (Platform Root of Trust Processor), both integrating an Arm Cortex M4F CPU (200MHz).
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 2adcc4b4c1..31a40e3b3b 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -2,7 +2,7 @@ B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
 ============================================
 
 The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
-ARM Cortex-M4F core. It is part of STMicroelectronics
+an Arm Cortex-M4F core. It is part of STMicroelectronics
 :doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L4
 ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
 integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A board
diff --git a/docs/system/arm/nrf.rst b/docs/system/arm/nrf.rst
index eda87bd760..e0ea6a8b7e 100644
--- a/docs/system/arm/nrf.rst
+++ b/docs/system/arm/nrf.rst
@@ -1,7 +1,7 @@
 Nordic nRF boards (``microbit``)
 ================================
 
-The `Nordic nRF`_ chips are a family of ARM-based System-on-Chip that
+The `Nordic nRF`_ chips are a family of Arm-based System-on-Chip that
 are designed to be used for low-power and short-range wireless solutions.
 
 .. _Nordic nRF: https://www.nordicsemi.com/Products
@@ -18,7 +18,7 @@ supported by QEMU.
 Supported devices
 -----------------
 
- * ARM Cortex-M0 (ARMv6-M)
+ * Arm Cortex-M0 (ARMv6-M)
  * Serial ports (UART)
  * Clock controller
  * Timers
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 511e3eb9ac..23b03f9029 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -1,24 +1,24 @@
 STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
 ===============================================================================================================
 
-The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
+The `STM32`_ chips are a family of 32-bit Arm-based microcontrollers by
 STMicroelectronics.
 
 .. _STM32: https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
 
-The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F1 series is based on an Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
 
-The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
+The STM32F2 series is based on an Arm Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
 
-The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
+The STM32F4 series is based on an Arm Cortex-M4F core, as well as the STM32L4
 ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
-The following machines are based on this ARM Cortex-M4F chip :
+The following machines are based on this Arm Cortex-M4F chip :
 
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
@@ -29,7 +29,7 @@ There are many other STM32 series that are currently not supported by QEMU.
 Supported devices
 -----------------
 
- * ARM Cortex-M3, Cortex M4F
+ * Arm Cortex-M3, Cortex-M4F
  * Analog to Digital Converter (ADC)
  * EXTI interrupt
  * Serial ports (USART)
diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 640cc07f80..8d31369f71 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -27,12 +27,12 @@ Versal
 """"""
 Implemented CPU cores:
 
-- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
-- 2 RCPUs (ARM Cortex-R5F) with their GICv2
+- 2 ACPUs (Arm Cortex-A72) with their GICv3 and ITS
+- 2 RCPUs (Arm Cortex-R5F) with their GICv2
 
 Implemented devices:
 
-- 2 UARTs (ARM PL011)
+- 2 UARTs (Arm PL011)
 - An RTC (Versal built-in)
 - 2 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
@@ -51,12 +51,12 @@ Versal Gen 2
 """"""""""""
 Implemented CPU cores:
 
-- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
-- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
+- 8 ACPUs (Arm Cortex-A78AE) with their GICv3 and ITS
+- 10 RCPUs (Arm Cortex-R52) with their GICv3 (one per cluster)
 
 Implemented devices:
 
-- 2 UARTs (ARM PL011)
+- 2 UARTs (Arm PL011)
 - An RTC (Versal built-in)
 - 3 GEMs (Cadence MACB Ethernet MACs)
 - 8 ADMA (Xilinx zDMA) channels
@@ -134,7 +134,7 @@ Direct Linux boot of PetaLinux 2019.2:
       -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
       -object rng-random,filename=/dev/urandom,id=rng0
 
-Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
+Boot PetaLinux 2019.2 via Arm Trusted Firmware (2018.3 because the 2019.2
 version of ATF tries to configure the CCI which we don't model) and U-boot:
 
 .. code-block:: bash
@@ -188,7 +188,7 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
-Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
+Boot Linux as Dom0 on Xen via Arm Trusted Firmware and U-Boot:
 
 .. code-block:: bash
 
diff --git a/docs/system/guest-loader.rst b/docs/system/guest-loader.rst
index 304ee5d531..12436cc791 100644
--- a/docs/system/guest-loader.rst
+++ b/docs/system/guest-loader.rst
@@ -32,7 +32,7 @@ size. Additional information can be passed with by using additional
 arguments.
 
 Currently the only supported machines which use FDT data to boot are
-the ARM and RiscV ``virt`` machines.
+the Arm and RiscV ``virt`` machines.
 
 Arguments
 ^^^^^^^^^
diff --git a/docs/system/replay.rst b/docs/system/replay.rst
index 28e5772a2b..fd78bd1f73 100644
--- a/docs/system/replay.rst
+++ b/docs/system/replay.rst
@@ -23,7 +23,7 @@ Deterministic replay has the following features:
    the memory, state of the hardware devices, clocks, and screen of the VM.
  * Writes execution log into the file for later replaying for multiple times
    on different machines.
- * Supports i386, x86_64, ARM, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
+ * Supports i386, x86_64, Arm, AArch64, Risc-V, MIPS, MIPS64, S390X, Alpha,
    PowerPC, PowerPC64, M68000, Microblaze, OpenRISC, SPARC,
    and Xtensa hardware platforms.
  * Performs deterministic replay of all operations with keyboard and mouse
-- 
2.47.3


