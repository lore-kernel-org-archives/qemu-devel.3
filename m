Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6FC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASK-0008TP-SL; Sun, 23 Feb 2025 06:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASJ-0008Sb-Ki; Sun, 23 Feb 2025 06:47:31 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASF-0005w1-W1; Sun, 23 Feb 2025 06:47:31 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so575330766b.3; 
 Sun, 23 Feb 2025 03:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311245; x=1740916045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMdcUFDsuQABl9Hx74rd01KYyG0zCzYoiOs30/OJQig=;
 b=eNtHWcRGVlSo4EgAI2kxZOSaB+a5XwfV3zNzfXehtWExi5G9pydmA9b9ig+rkZF5Sv
 QbDkuCDyV/Uty+ktksFx0Zmms0AILPidGi+fnfP5Xqm8BQ1LCSvMjbqqS5buqBU07tqh
 PpZyKcetAVF6Dkq8WwPj+NQ5AeGFZBSZ89i62MoJkA+5Mm6RDwyCHCcwfb4YdovrO50q
 OFZkUcDUfJhF1RbqR5SL+AQfj1PTLRhHS5dD/5PKtG+v/f/aR3+qoa3aCiQzEpdjKaDi
 ERcaOyVTUM2e/ti+RJQtklRg0DKsvH19zTxskx6d3ktkfm0XldMD9HNhZXMHvvEKsUD+
 pfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311245; x=1740916045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMdcUFDsuQABl9Hx74rd01KYyG0zCzYoiOs30/OJQig=;
 b=HswGehw+KVnz3GK4uOMRuDRtLfuTdc473Xe8pW99My6OVF4ld6s56biU+AWvE7+VQE
 JZm2q8b2r4jycTlGXNJhoK3lNCjZjSusL8pZorB8onOyAo7eOCQoaZNjuytGSArkZ7U4
 T6i7WjmZfJmBiv/SsC/hqHC6hB9qKjUy7G9F1itcpSIlt0hgJuPMno49j+exAGfTjeM9
 O4BHtoXMdfT+zw7S7Uyz1pD8IDytFw42pMrVYHkMZoY5wd0EAEINqJ9rOPwUwvq+gTXb
 0x2A7ZhHcNnTpw0/0xEpMW9TlP8lkPeXr8TB0BEgTG+R9NxmdlQSl8Q/Za7JYlA8CD+o
 2lxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDgIaLSOsi0DUN3YC2gAQkBOGuo/amrabBxwX+mJmsDYm9bjWVqvf/M4ZILMeYa2fq8U0zun1uFw==@nongnu.org
X-Gm-Message-State: AOJu0YyJvIxa5ELP6c6iFv1oLYdT04pA5fTb37zF9CGun1QME98tOIDZ
 DRK3eUR3/h0fRJAOAEJsY1spXf6ORU6oP+NJigoLnFI5klylCl8WFGSy1w==
X-Gm-Gg: ASbGncuqHrWYWHVz7plngwYRCJSG6iH0gS1iEERzrHWvdlACMYSb78axJrQSAJKGo0Y
 +fAm3cxH3sxysZudqx8tVReyMeQKE8jo5yYNlGk6l7f5GngQaLSWxWCW3pRqaH7+HtD467B2UrB
 9kM10c+mt5xCR4+V/qPKXjS3B0F7lb5V7YzQNiRdn8plIGwfyuMIiSYc8xgiQEcNHjHoYtDKmUy
 B1v6Bn776DztPFA5sL7Edki8l9irc9bq2/i+njZNJw0NyDaY8cKRwTSc9BpGWdikIdoPqkmICOe
 0vpLZlt/33jfXioTyZhsDhalr4WvKgwzr/cv5DjY/ZRoGfoY6Fw1s3RUqqBDDD1138KJS31Z3QB
 UfWSB0Fy2TnI+
X-Google-Smtp-Source: AGHT+IGGlEYdF78bXuSsK1eNyWViFKQCmQd9e5QFj+KAqrvreG7Zybac//VFc0uwrVGChDE2uC5tBg==
X-Received: by 2002:a17:907:9814:b0:abb:b1a4:b0fe with SMTP id
 a640c23a62f3a-abc099cca23mr966331366b.1.1740311244875; 
 Sun, 23 Feb 2025 03:47:24 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
Date: Sun, 23 Feb 2025 12:46:54 +0100
Message-ID: <20250223114708.1780-5-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
serial. All other devices of the A53 memory map are represented as
TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
for running Linux without it crashing due to invalid memory accesses.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                    |   9 +
 docs/system/arm/imx8mp-evk.rst |  54 +++++
 docs/system/target-arm.rst     |   1 +
 include/hw/arm/fsl-imx8mp.h    | 189 +++++++++++++++++
 hw/arm/fsl-imx8mp.c            | 367 +++++++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            |  55 +++++
 hw/arm/Kconfig                 |  12 ++
 hw/arm/meson.build             |   2 +
 8 files changed, 689 insertions(+)
 create mode 100644 docs/system/arm/imx8mp-evk.rst
 create mode 100644 include/hw/arm/fsl-imx8mp.h
 create mode 100644 hw/arm/fsl-imx8mp.c
 create mode 100644 hw/arm/imx8mp-evk.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1911949526..374fe98724 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -820,6 +820,15 @@ F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
 
+MCIMX8MP-EVK / i.MX8MP
+M: Bernhard Beschow <shentey@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/imx8mp-evk.c
+F: hw/arm/fsl-imx8mp.c
+F: include/hw/arm/fsl-imx8mp.h
+F: docs/system/arm/imx8mp-evk.rst
+
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
new file mode 100644
index 0000000000..b23fdcc743
--- /dev/null
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -0,0 +1,54 @@
+NXP i.MX 8M Plus Evaluation Kit (``imx8mp-evk``)
+================================================
+
+The ``imx8mp-evk`` machine models the i.MX 8M Plus Evaluation Kit, based on an
+i.MX 8M Plus SoC.
+
+Supported devices
+-----------------
+
+The ``imx8mp-evk`` machine implements the following devices:
+
+ * Up to 4 Cortex-A53 cores
+ * Generic Interrupt Controller (GICv3)
+ * 4 UARTs
+
+Boot options
+------------
+
+The ``imx8mp-evk`` machine can start a Linux kernel directly using the standard
+``-kernel`` functionality.
+
+Direct Linux Kernel Boot
+''''''''''''''''''''''''
+
+Probably the easiest way to get started with a whole Linux system on the machine
+is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
+of writing and involves two steps. First run the following commands in the
+toplevel directory of the Buildroot source tree:
+
+.. code-block:: bash
+
+  $ echo "BR2_TARGET_ROOTFS_CPIO=y" >> configs/freescale_imx8mpevk_defconfig
+  $ make freescale_imx8mpevk_defconfig
+  $ make
+
+Once finished successfully there is an ``output/image`` subfolder. Navigate into
+it and patch the device tree with the following commands which will remove the
+``cpu-idle-states`` properties from CPU nodes:
+
+.. code-block:: bash
+
+  $ dtc imx8mp-evk.dtb | sed '/cpu-idle-states/d' > imx8mp-evk-patched.dts
+  $ dtc imx8mp-evk-patched.dts -o imx8mp-evk-patched.dtb
+
+Now that everything is prepared the machine can be started as follows:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
+      -display none -serial null -serial stdio \
+      -kernel Image \
+      -dtb imx8mp-evk-patched.dtb \
+      -initrd rootfs.cpio \
+      -append "root=/dev/ram"
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 9aaa9c414c..a43ec8f10e 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -95,6 +95,7 @@ Board-specific documentation
    arm/imx25-pdk
    arm/mcimx6ul-evk
    arm/mcimx7d-sabre
+   arm/imx8mp-evk
    arm/orangepi
    arm/raspi
    arm/collie
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
new file mode 100644
index 0000000000..57e23d1b69
--- /dev/null
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -0,0 +1,189 @@
+/*
+ * i.MX 8M Plus SoC Definitions
+ *
+ * Copyright (c) 2024, Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef FSL_IMX8MP_H
+#define FSL_IMX8MP_H
+
+#include "cpu.h"
+#include "hw/char/imx_serial.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+
+#define TYPE_FSL_IMX8MP "fsl-imx8mp"
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
+
+#define FSL_IMX8MP_RAM_START        0x40000000
+#define FSL_IMX8MP_RAM_SIZE_MAX     (8 * GiB)
+
+enum FslImx8mpConfiguration {
+    FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_IRQS         = 160,
+    FSL_IMX8MP_NUM_UARTS        = 4,
+};
+
+struct FslImx8mpState {
+    DeviceState    parent_obj;
+
+    ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
+    GICv3State         gic;
+    IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+};
+
+enum FslImx8mpMemoryRegions {
+    FSL_IMX8MP_A53_DAP,
+    FSL_IMX8MP_AIPS1_CONFIGURATION,
+    FSL_IMX8MP_AIPS2_CONFIGURATION,
+    FSL_IMX8MP_AIPS3_CONFIGURATION,
+    FSL_IMX8MP_AIPS4_CONFIGURATION,
+    FSL_IMX8MP_AIPS5_CONFIGURATION,
+    FSL_IMX8MP_ANA_OSC,
+    FSL_IMX8MP_ANA_PLL,
+    FSL_IMX8MP_ANA_TSENSOR,
+    FSL_IMX8MP_APBH_DMA,
+    FSL_IMX8MP_ASRC,
+    FSL_IMX8MP_AUDIO_BLK_CTRL,
+    FSL_IMX8MP_AUDIO_DSP,
+    FSL_IMX8MP_AUDIO_XCVR_RX,
+    FSL_IMX8MP_AUD_IRQ_STEER,
+    FSL_IMX8MP_BOOT_ROM,
+    FSL_IMX8MP_BOOT_ROM_PROTECTED,
+    FSL_IMX8MP_CAAM,
+    FSL_IMX8MP_CAAM_MEM,
+    FSL_IMX8MP_CCM,
+    FSL_IMX8MP_CSU,
+    FSL_IMX8MP_DDR_BLK_CTRL,
+    FSL_IMX8MP_DDR_CTL,
+    FSL_IMX8MP_DDR_PERF_MON,
+    FSL_IMX8MP_DDR_PHY,
+    FSL_IMX8MP_DDR_PHY_BROADCAST,
+    FSL_IMX8MP_ECSPI1,
+    FSL_IMX8MP_ECSPI2,
+    FSL_IMX8MP_ECSPI3,
+    FSL_IMX8MP_EDMA_CHANNELS,
+    FSL_IMX8MP_EDMA_MANAGEMENT_PAGE,
+    FSL_IMX8MP_ENET1,
+    FSL_IMX8MP_ENET2_TSN,
+    FSL_IMX8MP_FLEXCAN1,
+    FSL_IMX8MP_FLEXCAN2,
+    FSL_IMX8MP_GIC_DIST,
+    FSL_IMX8MP_GIC_REDIST,
+    FSL_IMX8MP_GPC,
+    FSL_IMX8MP_GPIO1,
+    FSL_IMX8MP_GPIO2,
+    FSL_IMX8MP_GPIO3,
+    FSL_IMX8MP_GPIO4,
+    FSL_IMX8MP_GPIO5,
+    FSL_IMX8MP_GPT1,
+    FSL_IMX8MP_GPT2,
+    FSL_IMX8MP_GPT3,
+    FSL_IMX8MP_GPT4,
+    FSL_IMX8MP_GPT5,
+    FSL_IMX8MP_GPT6,
+    FSL_IMX8MP_GPU2D,
+    FSL_IMX8MP_GPU3D,
+    FSL_IMX8MP_HDMI_TX,
+    FSL_IMX8MP_HDMI_TX_AUDLNK_MSTR,
+    FSL_IMX8MP_HSIO_BLK_CTL,
+    FSL_IMX8MP_I2C1,
+    FSL_IMX8MP_I2C2,
+    FSL_IMX8MP_I2C3,
+    FSL_IMX8MP_I2C4,
+    FSL_IMX8MP_I2C5,
+    FSL_IMX8MP_I2C6,
+    FSL_IMX8MP_INTERCONNECT,
+    FSL_IMX8MP_IOMUXC,
+    FSL_IMX8MP_IOMUXC_GPR,
+    FSL_IMX8MP_IPS_DEWARP,
+    FSL_IMX8MP_ISI,
+    FSL_IMX8MP_ISP1,
+    FSL_IMX8MP_ISP2,
+    FSL_IMX8MP_LCDIF1,
+    FSL_IMX8MP_LCDIF2,
+    FSL_IMX8MP_MEDIA_BLK_CTL,
+    FSL_IMX8MP_MIPI_CSI1,
+    FSL_IMX8MP_MIPI_CSI2,
+    FSL_IMX8MP_MIPI_DSI1,
+    FSL_IMX8MP_MU_1_A,
+    FSL_IMX8MP_MU_1_B,
+    FSL_IMX8MP_MU_2_A,
+    FSL_IMX8MP_MU_2_B,
+    FSL_IMX8MP_MU_3_A,
+    FSL_IMX8MP_MU_3_B,
+    FSL_IMX8MP_NPU,
+    FSL_IMX8MP_OCOTP_CTRL,
+    FSL_IMX8MP_OCRAM,
+    FSL_IMX8MP_OCRAM_S,
+    FSL_IMX8MP_PCIE1,
+    FSL_IMX8MP_PCIE1_MEM,
+    FSL_IMX8MP_PCIE_PHY1,
+    FSL_IMX8MP_PDM,
+    FSL_IMX8MP_PERFMON1,
+    FSL_IMX8MP_PERFMON2,
+    FSL_IMX8MP_PWM1,
+    FSL_IMX8MP_PWM2,
+    FSL_IMX8MP_PWM3,
+    FSL_IMX8MP_PWM4,
+    FSL_IMX8MP_QOSC,
+    FSL_IMX8MP_QSPI,
+    FSL_IMX8MP_QSPI1_RX_BUFFER,
+    FSL_IMX8MP_QSPI1_TX_BUFFER,
+    FSL_IMX8MP_QSPI_MEM,
+    FSL_IMX8MP_RAM,
+    FSL_IMX8MP_RDC,
+    FSL_IMX8MP_SAI1,
+    FSL_IMX8MP_SAI2,
+    FSL_IMX8MP_SAI3,
+    FSL_IMX8MP_SAI5,
+    FSL_IMX8MP_SAI6,
+    FSL_IMX8MP_SAI7,
+    FSL_IMX8MP_SDMA1,
+    FSL_IMX8MP_SDMA2,
+    FSL_IMX8MP_SDMA3,
+    FSL_IMX8MP_SEMAPHORE1,
+    FSL_IMX8MP_SEMAPHORE2,
+    FSL_IMX8MP_SEMAPHORE_HS,
+    FSL_IMX8MP_SNVS_HP,
+    FSL_IMX8MP_SPBA1,
+    FSL_IMX8MP_SPBA2,
+    FSL_IMX8MP_SRC,
+    FSL_IMX8MP_SYSCNT_CMP,
+    FSL_IMX8MP_SYSCNT_CTRL,
+    FSL_IMX8MP_SYSCNT_RD,
+    FSL_IMX8MP_TCM_DTCM,
+    FSL_IMX8MP_TCM_ITCM,
+    FSL_IMX8MP_TZASC,
+    FSL_IMX8MP_UART1,
+    FSL_IMX8MP_UART2,
+    FSL_IMX8MP_UART3,
+    FSL_IMX8MP_UART4,
+    FSL_IMX8MP_USB1,
+    FSL_IMX8MP_USB2,
+    FSL_IMX8MP_USDHC1,
+    FSL_IMX8MP_USDHC2,
+    FSL_IMX8MP_USDHC3,
+    FSL_IMX8MP_VPU,
+    FSL_IMX8MP_VPU_BLK_CTRL,
+    FSL_IMX8MP_VPU_G1_DECODER,
+    FSL_IMX8MP_VPU_G2_DECODER,
+    FSL_IMX8MP_VPU_VC8000E_ENCODER,
+    FSL_IMX8MP_WDOG1,
+    FSL_IMX8MP_WDOG2,
+    FSL_IMX8MP_WDOG3,
+};
+
+enum FslImx8mpIrqs {
+    FSL_IMX8MP_UART1_IRQ    = 26,
+    FSL_IMX8MP_UART2_IRQ    = 27,
+    FSL_IMX8MP_UART3_IRQ    = 28,
+    FSL_IMX8MP_UART4_IRQ    = 29,
+    FSL_IMX8MP_UART5_IRQ    = 30,
+    FSL_IMX8MP_UART6_IRQ    = 16,
+};
+
+#endif /* FSL_IMX8MP_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
new file mode 100644
index 0000000000..484b45c0d8
--- /dev/null
+++ b/hw/arm/fsl-imx8mp.c
@@ -0,0 +1,367 @@
+/*
+ * i.MX 8M Plus SoC Implementation
+ *
+ * Based on hw/arm/fsl-imx6.c
+ *
+ * Copyright (c) 2024, Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/fsl-imx8mp.h"
+#include "hw/intc/arm_gicv3.h"
+#include "hw/misc/unimp.h"
+#include "hw/boards.h"
+#include "system/system.h"
+#include "target/arm/cpu-qom.h"
+#include "qapi/error.h"
+#include "qobject/qlist.h"
+
+static const struct {
+    hwaddr addr;
+    size_t size;
+    const char *name;
+} fsl_imx8mp_memmap[] = {
+    [FSL_IMX8MP_RAM] = { FSL_IMX8MP_RAM_START, FSL_IMX8MP_RAM_SIZE_MAX, "ram" },
+    [FSL_IMX8MP_DDR_PHY_BROADCAST] = { 0x3dc00000, 4 * MiB, "ddr_phy_broadcast" },
+    [FSL_IMX8MP_DDR_PERF_MON] = { 0x3d800000, 4 * MiB, "ddr_perf_mon" },
+    [FSL_IMX8MP_DDR_CTL] = { 0x3d400000, 4 * MiB, "ddr_ctl" },
+    [FSL_IMX8MP_DDR_BLK_CTRL] = { 0x3d000000, 1 * MiB, "ddr_blk_ctrl" },
+    [FSL_IMX8MP_DDR_PHY] = { 0x3c000000, 16 * MiB, "ddr_phy" },
+    [FSL_IMX8MP_AUDIO_DSP] = { 0x3b000000, 16 * MiB, "audio_dsp" },
+    [FSL_IMX8MP_GIC_DIST] = { 0x38800000, 512 * KiB, "gic_dist" },
+    [FSL_IMX8MP_GIC_REDIST] = { 0x38880000, 512 * KiB, "gic_redist" },
+    [FSL_IMX8MP_NPU] = { 0x38500000, 2 * MiB, "npu" },
+    [FSL_IMX8MP_VPU] = { 0x38340000, 2 * MiB, "vpu" },
+    [FSL_IMX8MP_VPU_BLK_CTRL] = { 0x38330000, 2 * MiB, "vpu_blk_ctrl" },
+    [FSL_IMX8MP_VPU_VC8000E_ENCODER] = { 0x38320000, 2 * MiB, "vpu_vc8000e_encoder" },
+    [FSL_IMX8MP_VPU_G2_DECODER] = { 0x38310000, 2 * MiB, "vpu_g2_decoder" },
+    [FSL_IMX8MP_VPU_G1_DECODER] = { 0x38300000, 2 * MiB, "vpu_g1_decoder" },
+    [FSL_IMX8MP_USB2] = { 0x38200000, 1 * MiB, "usb2" },
+    [FSL_IMX8MP_USB1] = { 0x38100000, 1 * MiB, "usb1" },
+    [FSL_IMX8MP_GPU2D] = { 0x38008000, 32 * KiB, "gpu2d" },
+    [FSL_IMX8MP_GPU3D] = { 0x38000000, 32 * KiB, "gpu3d" },
+    [FSL_IMX8MP_QSPI1_RX_BUFFER] = { 0x34000000, 32 * MiB, "qspi1_rx_buffer" },
+    [FSL_IMX8MP_PCIE1] = { 0x33800000, 4 * MiB, "pcie1" },
+    [FSL_IMX8MP_QSPI1_TX_BUFFER] = { 0x33008000, 32 * KiB, "qspi1_tx_buffer" },
+    [FSL_IMX8MP_APBH_DMA] = { 0x33000000, 32 * KiB, "apbh_dma" },
+
+    /* AIPS-5 Begin */
+    [FSL_IMX8MP_MU_3_B] = { 0x30e90000, 64 * KiB, "mu_3_b" },
+    [FSL_IMX8MP_MU_3_A] = { 0x30e80000, 64 * KiB, "mu_3_a" },
+    [FSL_IMX8MP_MU_2_B] = { 0x30e70000, 64 * KiB, "mu_2_b" },
+    [FSL_IMX8MP_MU_2_A] = { 0x30e60000, 64 * KiB, "mu_2_a" },
+    [FSL_IMX8MP_EDMA_CHANNELS] = { 0x30e40000, 128 * KiB, "edma_channels" },
+    [FSL_IMX8MP_EDMA_MANAGEMENT_PAGE] = { 0x30e30000, 64 * KiB, "edma_management_page" },
+    [FSL_IMX8MP_AUDIO_BLK_CTRL] = { 0x30e20000, 64 * KiB, "audio_blk_ctrl" },
+    [FSL_IMX8MP_SDMA2] = { 0x30e10000, 64 * KiB, "sdma2" },
+    [FSL_IMX8MP_SDMA3] = { 0x30e00000, 64 * KiB, "sdma3" },
+    [FSL_IMX8MP_AIPS5_CONFIGURATION] = { 0x30df0000, 64 * KiB, "aips5_configuration" },
+    [FSL_IMX8MP_SPBA2] = { 0x30cf0000, 64 * KiB, "spba2" },
+    [FSL_IMX8MP_AUDIO_XCVR_RX] = { 0x30cc0000, 64 * KiB, "audio_xcvr_rx" },
+    [FSL_IMX8MP_HDMI_TX_AUDLNK_MSTR] = { 0x30cb0000, 64 * KiB, "hdmi_tx_audlnk_mstr" },
+    [FSL_IMX8MP_PDM] = { 0x30ca0000, 64 * KiB, "pdm" },
+    [FSL_IMX8MP_ASRC] = { 0x30c90000, 64 * KiB, "asrc" },
+    [FSL_IMX8MP_SAI7] = { 0x30c80000, 64 * KiB, "sai7" },
+    [FSL_IMX8MP_SAI6] = { 0x30c60000, 64 * KiB, "sai6" },
+    [FSL_IMX8MP_SAI5] = { 0x30c50000, 64 * KiB, "sai5" },
+    [FSL_IMX8MP_SAI3] = { 0x30c30000, 64 * KiB, "sai3" },
+    [FSL_IMX8MP_SAI2] = { 0x30c20000, 64 * KiB, "sai2" },
+    [FSL_IMX8MP_SAI1] = { 0x30c10000, 64 * KiB, "sai1" },
+    /* AIPS-5 End */
+
+    /* AIPS-4 Begin */
+    [FSL_IMX8MP_HDMI_TX] = { 0x32fc0000, 128 * KiB, "hdmi_tx" },
+    [FSL_IMX8MP_TZASC] = { 0x32f80000, 64 * KiB, "tzasc" },
+    [FSL_IMX8MP_HSIO_BLK_CTL] = { 0x32f10000, 64 * KiB, "hsio_blk_ctl" },
+    [FSL_IMX8MP_PCIE_PHY1] = { 0x32f00000, 64 * KiB, "pcie_phy1" },
+    [FSL_IMX8MP_MEDIA_BLK_CTL] = { 0x32ec0000, 64 * KiB, "media_blk_ctl" },
+    [FSL_IMX8MP_LCDIF2] = { 0x32e90000, 64 * KiB, "lcdif2" },
+    [FSL_IMX8MP_LCDIF1] = { 0x32e80000, 64 * KiB, "lcdif1" },
+    [FSL_IMX8MP_MIPI_DSI1] = { 0x32e60000, 64 * KiB, "mipi_dsi1" },
+    [FSL_IMX8MP_MIPI_CSI2] = { 0x32e50000, 64 * KiB, "mipi_csi2" },
+    [FSL_IMX8MP_MIPI_CSI1] = { 0x32e40000, 64 * KiB, "mipi_csi1" },
+    [FSL_IMX8MP_IPS_DEWARP] = { 0x32e30000, 64 * KiB, "ips_dewarp" },
+    [FSL_IMX8MP_ISP2] = { 0x32e20000, 64 * KiB, "isp2" },
+    [FSL_IMX8MP_ISP1] = { 0x32e10000, 64 * KiB, "isp1" },
+    [FSL_IMX8MP_ISI] = { 0x32e00000, 64 * KiB, "isi" },
+    [FSL_IMX8MP_AIPS4_CONFIGURATION] = { 0x32df0000, 64 * KiB, "aips4_configuration" },
+    /* AIPS-4 End */
+
+    [FSL_IMX8MP_INTERCONNECT] = { 0x32700000, 1 * MiB, "interconnect" },
+
+    /* AIPS-3 Begin */
+    [FSL_IMX8MP_ENET2_TSN] = { 0x30bf0000, 64 * KiB, "enet2_tsn" },
+    [FSL_IMX8MP_ENET1] = { 0x30be0000, 64 * KiB, "enet1" },
+    [FSL_IMX8MP_SDMA1] = { 0x30bd0000, 64 * KiB, "sdma1" },
+    [FSL_IMX8MP_QSPI] = { 0x30bb0000, 64 * KiB, "qspi" },
+    [FSL_IMX8MP_USDHC3] = { 0x30b60000, 64 * KiB, "usdhc3" },
+    [FSL_IMX8MP_USDHC2] = { 0x30b50000, 64 * KiB, "usdhc2" },
+    [FSL_IMX8MP_USDHC1] = { 0x30b40000, 64 * KiB, "usdhc1" },
+    [FSL_IMX8MP_I2C6] = { 0x30ae0000, 64 * KiB, "i2c6" },
+    [FSL_IMX8MP_I2C5] = { 0x30ad0000, 64 * KiB, "i2c5" },
+    [FSL_IMX8MP_SEMAPHORE_HS] = { 0x30ac0000, 64 * KiB, "semaphore_hs" },
+    [FSL_IMX8MP_MU_1_B] = { 0x30ab0000, 64 * KiB, "mu_1_b" },
+    [FSL_IMX8MP_MU_1_A] = { 0x30aa0000, 64 * KiB, "mu_1_a" },
+    [FSL_IMX8MP_AUD_IRQ_STEER] = { 0x30a80000, 64 * KiB, "aud_irq_steer" },
+    [FSL_IMX8MP_UART4] = { 0x30a60000, 64 * KiB, "uart4" },
+    [FSL_IMX8MP_I2C4] = { 0x30a50000, 64 * KiB, "i2c4" },
+    [FSL_IMX8MP_I2C3] = { 0x30a40000, 64 * KiB, "i2c3" },
+    [FSL_IMX8MP_I2C2] = { 0x30a30000, 64 * KiB, "i2c2" },
+    [FSL_IMX8MP_I2C1] = { 0x30a20000, 64 * KiB, "i2c1" },
+    [FSL_IMX8MP_AIPS3_CONFIGURATION] = { 0x309f0000, 64 * KiB, "aips3_configuration" },
+    [FSL_IMX8MP_CAAM] = { 0x30900000, 256 * KiB, "caam" },
+    [FSL_IMX8MP_SPBA1] = { 0x308f0000, 64 * KiB, "spba1" },
+    [FSL_IMX8MP_FLEXCAN2] = { 0x308d0000, 64 * KiB, "flexcan2" },
+    [FSL_IMX8MP_FLEXCAN1] = { 0x308c0000, 64 * KiB, "flexcan1" },
+    [FSL_IMX8MP_UART2] = { 0x30890000, 64 * KiB, "uart2" },
+    [FSL_IMX8MP_UART3] = { 0x30880000, 64 * KiB, "uart3" },
+    [FSL_IMX8MP_UART1] = { 0x30860000, 64 * KiB, "uart1" },
+    [FSL_IMX8MP_ECSPI3] = { 0x30840000, 64 * KiB, "ecspi3" },
+    [FSL_IMX8MP_ECSPI2] = { 0x30830000, 64 * KiB, "ecspi2" },
+    [FSL_IMX8MP_ECSPI1] = { 0x30820000, 64 * KiB, "ecspi1" },
+    /* AIPS-3 End */
+
+    /* AIPS-2 Begin */
+    [FSL_IMX8MP_QOSC] = { 0x307f0000, 64 * KiB, "qosc" },
+    [FSL_IMX8MP_PERFMON2] = { 0x307d0000, 64 * KiB, "perfmon2" },
+    [FSL_IMX8MP_PERFMON1] = { 0x307c0000, 64 * KiB, "perfmon1" },
+    [FSL_IMX8MP_GPT4] = { 0x30700000, 64 * KiB, "gpt4" },
+    [FSL_IMX8MP_GPT5] = { 0x306f0000, 64 * KiB, "gpt5" },
+    [FSL_IMX8MP_GPT6] = { 0x306e0000, 64 * KiB, "gpt6" },
+    [FSL_IMX8MP_SYSCNT_CTRL] = { 0x306c0000, 64 * KiB, "syscnt_ctrl" },
+    [FSL_IMX8MP_SYSCNT_CMP] = { 0x306b0000, 64 * KiB, "syscnt_cmp" },
+    [FSL_IMX8MP_SYSCNT_RD] = { 0x306a0000, 64 * KiB, "syscnt_rd" },
+    [FSL_IMX8MP_PWM4] = { 0x30690000, 64 * KiB, "pwm4" },
+    [FSL_IMX8MP_PWM3] = { 0x30680000, 64 * KiB, "pwm3" },
+    [FSL_IMX8MP_PWM2] = { 0x30670000, 64 * KiB, "pwm2" },
+    [FSL_IMX8MP_PWM1] = { 0x30660000, 64 * KiB, "pwm1" },
+    [FSL_IMX8MP_AIPS2_CONFIGURATION] = { 0x305f0000, 64 * KiB, "aips2_configuration" },
+    /* AIPS-2 End */
+
+    /* AIPS-1 Begin */
+    [FSL_IMX8MP_CSU] = { 0x303e0000, 64 * KiB, "csu" },
+    [FSL_IMX8MP_RDC] = { 0x303d0000, 64 * KiB, "rdc" },
+    [FSL_IMX8MP_SEMAPHORE2] = { 0x303c0000, 64 * KiB, "semaphore2" },
+    [FSL_IMX8MP_SEMAPHORE1] = { 0x303b0000, 64 * KiB, "semaphore1" },
+    [FSL_IMX8MP_GPC] = { 0x303a0000, 64 * KiB, "gpc" },
+    [FSL_IMX8MP_SRC] = { 0x30390000, 64 * KiB, "src" },
+    [FSL_IMX8MP_CCM] = { 0x30380000, 64 * KiB, "ccm" },
+    [FSL_IMX8MP_SNVS_HP] = { 0x30370000, 64 * KiB, "snvs_hp" },
+    [FSL_IMX8MP_ANA_PLL] = { 0x30360000, 64 * KiB, "ana_pll" },
+    [FSL_IMX8MP_OCOTP_CTRL] = { 0x30350000, 64 * KiB, "ocotp_ctrl" },
+    [FSL_IMX8MP_IOMUXC_GPR] = { 0x30340000, 64 * KiB, "iomuxc_gpr" },
+    [FSL_IMX8MP_IOMUXC] = { 0x30330000, 64 * KiB, "iomuxc" },
+    [FSL_IMX8MP_GPT3] = { 0x302f0000, 64 * KiB, "gpt3" },
+    [FSL_IMX8MP_GPT2] = { 0x302e0000, 64 * KiB, "gpt2" },
+    [FSL_IMX8MP_GPT1] = { 0x302d0000, 64 * KiB, "gpt1" },
+    [FSL_IMX8MP_WDOG3] = { 0x302a0000, 64 * KiB, "wdog3" },
+    [FSL_IMX8MP_WDOG2] = { 0x30290000, 64 * KiB, "wdog2" },
+    [FSL_IMX8MP_WDOG1] = { 0x30280000, 64 * KiB, "wdog1" },
+    [FSL_IMX8MP_ANA_OSC] = { 0x30270000, 64 * KiB, "ana_osc" },
+    [FSL_IMX8MP_ANA_TSENSOR] = { 0x30260000, 64 * KiB, "ana_tsensor" },
+    [FSL_IMX8MP_GPIO5] = { 0x30240000, 64 * KiB, "gpio5" },
+    [FSL_IMX8MP_GPIO4] = { 0x30230000, 64 * KiB, "gpio4" },
+    [FSL_IMX8MP_GPIO3] = { 0x30220000, 64 * KiB, "gpio3" },
+    [FSL_IMX8MP_GPIO2] = { 0x30210000, 64 * KiB, "gpio2" },
+    [FSL_IMX8MP_GPIO1] = { 0x30200000, 64 * KiB, "gpio1" },
+    [FSL_IMX8MP_AIPS1_CONFIGURATION] = { 0x301f0000, 64 * KiB, "aips1_configuration" },
+    /* AIPS-1 End */
+
+    [FSL_IMX8MP_A53_DAP] = { 0x28000000, 16 * MiB, "a53_dap" },
+    [FSL_IMX8MP_PCIE1_MEM] = { 0x18000000, 128 * MiB, "pcie1_mem" },
+    [FSL_IMX8MP_QSPI_MEM] = { 0x08000000, 256 * MiB, "qspi_mem" },
+    [FSL_IMX8MP_OCRAM] = { 0x00900000, 576 * KiB, "ocram" },
+    [FSL_IMX8MP_TCM_DTCM] = { 0x00800000, 128 * KiB, "tcm_dtcm" },
+    [FSL_IMX8MP_TCM_ITCM] = { 0x007e0000, 128 * KiB, "tcm_itcm" },
+    [FSL_IMX8MP_OCRAM_S] = { 0x00180000, 36 * KiB, "ocram_s" },
+    [FSL_IMX8MP_CAAM_MEM] = { 0x00100000, 32 * KiB, "caam_mem" },
+    [FSL_IMX8MP_BOOT_ROM_PROTECTED] = { 0x0003f000, 4 * KiB, "boot_rom_protected" },
+    [FSL_IMX8MP_BOOT_ROM] = { 0x00000000, 252 * KiB, "boot_rom" },
+};
+
+static void fsl_imx8mp_init(Object *obj)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    FslImx8mpState *s = FSL_IMX8MP(obj);
+    int i;
+
+    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+
+    for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i + 1);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
+    }
+}
+
+static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    FslImx8mpState *s = FSL_IMX8MP(dev);
+    DeviceState *gicdev = DEVICE(&s->gic);
+    int i;
+
+    if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
+        return;
+    }
+
+    /* CPUs */
+    for (i = 0; i < ms->smp.cpus; i++) {
+        /* On uniprocessor, the CBAR is set to 0 */
+        if (ms->smp.cpus > 1) {
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
+                                    &error_abort);
+        }
+
+        /*
+         * CNTFID0 base frequency in Hz of system counter
+         */
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (i) {
+            /*
+             * Secondary CPUs start in powered-down state (and can be
+             * powered up via the SRC system reset controller)
+             */
+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
+                                     true, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    {
+        SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
+        QList *redist_region_count;
+
+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
+        qdev_prop_set_uint32(gicdev, "num-irq",
+                             FSL_IMX8MP_NUM_IRQS + GIC_INTERNAL);
+        redist_region_count = qlist_new();
+        qlist_append_int(redist_region_count, ms->smp.cpus);
+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
+        object_property_set_link(OBJECT(&s->gic), "sysmem",
+                                 OBJECT(get_system_memory()), &error_fatal);
+        if (!sysbus_realize(gicsbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(gicsbd, 0, fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr);
+        sysbus_mmio_map(gicsbd, 1, fsl_imx8mp_memmap[FSL_IMX8MP_GIC_REDIST].addr);
+
+        /*
+         * Wire the outputs from each CPU's generic timer and the GICv3
+         * maintenance interrupt signal to the appropriate GIC PPI inputs, and
+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+         */
+        for (i = 0; i < ms->smp.cpus; i++) {
+            DeviceState *cpudev = DEVICE(&s->cpu[i]);
+            int intidbase = FSL_IMX8MP_NUM_IRQS + i * GIC_INTERNAL;
+            qemu_irq irq;
+
+            /*
+             * Mapping from the output timer irq lines from the CPU to the
+             * GIC PPI inputs.
+             */
+            static const int timer_irqs[] = {
+                [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+                [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+                [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+                [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            };
+
+            for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
+                irq = qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);
+                qdev_connect_gpio_out(cpudev, j, irq);
+            }
+
+            irq = qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+
+            irq = qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, irq);
+
+            sysbus_connect_irq(gicsbd, i,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        }
+    }
+
+    /* UARTs */
+    for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } serial_table[FSL_IMX8MP_NUM_UARTS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_UART1].addr, FSL_IMX8MP_UART1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_UART2].addr, FSL_IMX8MP_UART2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_UART3].addr, FSL_IMX8MP_UART3_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_UART4].addr, FSL_IMX8MP_UART4_IRQ },
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
+    }
+
+    /* Unimplemented devices */
+    for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
+        switch (i) {
+        case FSL_IMX8MP_GIC_DIST:
+        case FSL_IMX8MP_GIC_REDIST:
+        case FSL_IMX8MP_RAM:
+        case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+            /* device implemented and treated above */
+            break;
+
+        default:
+            create_unimplemented_device(fsl_imx8mp_memmap[i].name,
+                                        fsl_imx8mp_memmap[i].addr,
+                                        fsl_imx8mp_memmap[i].size);
+            break;
+        }
+    }
+}
+
+static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = fsl_imx8mp_realize;
+
+    dc->desc = "i.MX 8M Plus SoC";
+}
+
+static const TypeInfo fsl_imx8mp_types[] = {
+    {
+        .name = TYPE_FSL_IMX8MP,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(FslImx8mpState),
+        .instance_init = fsl_imx8mp_init,
+        .class_init = fsl_imx8mp_class_init,
+    },
+};
+
+DEFINE_TYPES(fsl_imx8mp_types)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
new file mode 100644
index 0000000000..2756d4c21c
--- /dev/null
+++ b/hw/arm/imx8mp-evk.c
@@ -0,0 +1,55 @@
+/*
+ * NXP i.MX 8M Plus Evaluation Kit System Emulation
+ *
+ * Copyright (c) 2024, Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/fsl-imx8mp.h"
+#include "hw/boards.h"
+#include "system/qtest.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+static void imx8mp_evk_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    FslImx8mpState *s;
+
+    if (machine->ram_size > FSL_IMX8MP_RAM_SIZE_MAX) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" PRIx64 ")",
+                     machine->ram_size, FSL_IMX8MP_RAM_SIZE_MAX);
+        exit(1);
+    }
+
+    boot_info = (struct arm_boot_info) {
+        .loader_start = FSL_IMX8MP_RAM_START,
+        .board_id = -1,
+        .ram_size = machine->ram_size,
+        .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
+    };
+
+    s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    qdev_realize(DEVICE(s), NULL, &error_fatal);
+
+    memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
+                                machine->ram);
+
+    if (!qtest_enabled()) {
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+    }
+}
+
+static void imx8mp_evk_machine_init(MachineClass *mc)
+{
+    mc->desc = "NXP i.MX 8M Plus EVK Board";
+    mc->init = imx8mp_evk_init;
+    mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
+    mc->default_ram_id = "imx8mp-evk.ram";
+}
+DEFINE_MACHINE("imx8mp-evk", imx8mp_evk_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 504841ccab..0a7de40861 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -593,6 +593,18 @@ config FSL_IMX7
     select UNIMP
     select USB_CHIPIDEA
 
+config FSL_IMX8MP
+    bool
+    select ARM_GIC
+    select IMX
+    select UNIMP
+
+config FSL_IMX8MP_EVK
+    bool
+    default y
+    depends on TCG && AARCH64
+    select FSL_IMX8MP
+
 config ARM_SMMUV3
     bool
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 465c757f97..ac473ce7cd 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -54,6 +54,8 @@ arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
 arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
 arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-- 
2.48.1


