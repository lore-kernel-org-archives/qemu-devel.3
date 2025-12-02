Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQJi-0006Qv-1j; Tue, 02 Dec 2025 08:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vQQJg-0006Oj-Eq
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:21:16 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vQQJc-0006Ag-Uc
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:21:16 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6418738efa0so8933354a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764681671; x=1765286471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnjf+Fjd/iMCQRS63hFwu/9T2OuD4eHmdFUCXUnOPrs=;
 b=c9UMI+1cLAXCerDI9kSbXx8oXpOPjSBMV3nnAj4Kl4h79ncyFJxCsQTE29JauYWj7i
 ez/sqAHKIPLO+uWTwEWm4EiKJFms+A/QhvFWekYg/ZLMN80tFSO9CkDZQZtsRfWU0fUJ
 U2/ok755ji8yvFtOm27SbTkkdJOKvWfF8DpspEgClPxh4nELRxjtNq3LqxsJe3qnqH2S
 lhbLOuOWszz5ij2YrM9AS7VUl3IIc7nV50g8P+eTf5YolCndoxFK2UyZMkLiKJDz0amB
 INXAu1/kQ/imQ4Lmzo0Fj9AJrqg0hJIrJgBIMCJDMuc0U6NgI1z0lP/FxpMGPhgVCJ5/
 tJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764681671; x=1765286471;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lnjf+Fjd/iMCQRS63hFwu/9T2OuD4eHmdFUCXUnOPrs=;
 b=eXdGLoGf6WDtH2F1gVfr75L9F77b6qQmd2YNIe6lES7uVttNjfOVk7WptNaSxBcbs3
 fJTSOki18RhPvGZKzs0nKEQ5SpG7j8ECmL5cwPbPmu+BxPZI7iWu3xpzk60kBIY0yM/O
 deLFWDGm3JzCxICPW+x4JMw23g+Mf/Iuabkt8c7mos4k68raABthExAoNKxgC8G2252Z
 pwOuzc6xybIs9ISdFmfEJsh3Lf2Mm9TTfue1ZLC2+D6ytkmrf937Y35SDsI9lx3YsMgF
 BdBevN5DBnlo2yJ3APm+2A33pTLaAjvHcj+ennZV7LG+yCtaP3uP/B3tQLbJwsGOn+vm
 Ug5A==
X-Gm-Message-State: AOJu0YwOxMXug1rFjgxX5zwh3OXrSdtmbfqUHgrImRiF/U8wZlfZWm4Y
 OgnAMeyOQRlbsXp4Pat6GFQQIQjKO75HANvM75gD3pRfgccaPHHd2NQIsItHxA==
X-Gm-Gg: ASbGncv3xShhse7zc0ceyi6sosWFMFQK1Nku3u2lhTMIFavggp7sqMxbtzWMuMGl49j
 j3u82BzbfUHnuvHrrx/Yjm08QPaY2XosYXtGGjbHLs3/knKqgLvpQWF80kcNacqzEbTDfMF3va/
 l4it9H/D1Ou4CulLDOg1IjGXZAwAPKAaPbm0IKSbnf0YhuaVSjUT5x/QI62VLI4QKDVhTuPCetm
 +cqwY9S4PrxgNUAx4ExloC/kQBaF5EcQSHJI+KqOz841UvEEFapfoG967m4DyzbmRpb82zo3H63
 lX9hvnpFg/dtSRlDeRpkWLt3y5NiBAIUjVlykW+TtzFsl9JQOQ4X3Fvr8BmskfF04cGYhxv+Cuv
 Vz+YugW6kj198HReGme4S2qaJVvMjfEmbtNAzlLrqctVQ21QFS9oyDqQ+21wyIQgfSQJgCWl31I
 g4wcAKf23y8c2bkkJMjA==
X-Google-Smtp-Source: AGHT+IEDm8JPHcxbiQ03SrOvM0pxu/gJR+m4Ma0dkm932KAPSNSVEnRrEUHAoBu2ycdnAsY6vdbQLw==
X-Received: by 2002:a17:907:d86:b0:b76:5393:c895 with SMTP id
 a640c23a62f3a-b76715142d4mr4639099866b.11.1764681670161; 
 Tue, 02 Dec 2025 05:21:10 -0800 (PST)
Received: from ehlo.thunderbird.net ([90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59ea334sm1497472766b.47.2025.12.02.05.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 05:21:09 -0800 (PST)
Date: Tue, 02 Dec 2025 11:42:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv3_01/13=5D_hw/arm=3A_Add_the?=
 =?US-ASCII?Q?_i=2EMX_8MM_EVK=28Evaluation_Kit=29_board?=
In-Reply-To: <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
Message-ID: <6A10A018-70A8-4F9B-AF00-66ABA561D5B8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



Am 19=2E November 2025 13:00:15 UTC schrieb Gaurav Sharma <gaurav=2Esharma=
_7@nxp=2Ecom>:
>Implemented CPUs, RAM, UARTs and Interrupt Controller
>Other peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE
>Complete memory map of the SoC is provided=2E
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>---
> docs/system/arm/imx8mm-evk=2Erst |  68 ++++++
> docs/system/target-arm=2Erst     |   1 +
> hw/arm/Kconfig                 |  12 ++
> hw/arm/fsl-imx8mm=2Ec            | 363 +++++++++++++++++++++++++++++++++
> hw/arm/imx8mm-evk=2Ec            | 109 ++++++++++
> hw/arm/meson=2Ebuild             |   2 +
> include/hw/arm/fsl-imx8mm=2Eh    | 156 ++++++++++++++
> 7 files changed, 711 insertions(+)
> create mode 100644 docs/system/arm/imx8mm-evk=2Erst
> create mode 100644 hw/arm/fsl-imx8mm=2Ec
> create mode 100644 hw/arm/imx8mm-evk=2Ec
> create mode 100644 include/hw/arm/fsl-imx8mm=2Eh
>
>diff --git a/docs/system/arm/imx8mm-evk=2Erst b/docs/system/arm/imx8mm-ev=
k=2Erst
>new file mode 100644
>index 0000000000=2E=2E408253193c
>--- /dev/null
>+++ b/docs/system/arm/imx8mm-evk=2Erst
>@@ -0,0 +1,68 @@
>+NXP i=2EMX 8MM Evaluation Kit (``imx8mm-evk``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The ``imx8mm-evk`` machine models the i=2EMX 8M Mini Evaluation Kit, bas=
ed on an
>+i=2EMX 8MM SoC=2E
>+
>+Supported devices
>+-----------------
>+
>+The ``imx8mm-evk`` machine implements the following devices:
>+
>+ * Up to 4 Cortex-A53 cores
>+ * Generic Interrupt Controller (GICv3)
>+ * 4 UARTs
>+
>+Boot options
>+------------
>+
>+The ``imx8mm-evk`` machine can start a Linux kernel directly using the s=
tandard
>+``-kernel`` functionality=2E
>+
>+Direct Linux Kernel Boot
>+''''''''''''''''''''''''
>+
>+Probably the easiest way to get started with a whole Linux system on the=
 machine
>+is to generate an image with Buildroot=2E Version 2024=2E11=2E1 is teste=
d at the time
>+of writing and involves two steps=2E First run the following commands in=
 the
>+toplevel directory of the Buildroot source tree:
>+
>+=2E=2E code-block:: bash
>+
>+  $ make freescale_imx8mmevk_defconfig
>+  $ make
>+
>+Once finished successfully there is an ``output/image`` subfolder=2E Nav=
igate into
>+it and resize the SD card image to a power of two:
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-img resize sdcard=2Eimg 256M
>+
>+Now that everything is prepared the machine can be started as follows:
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
>+      -display none -serial null -serial stdio \
>+      -kernel Image \
>+      -dtb imx8mm-evk=2Edtb \
>+      -append "root=3D/dev/mmcblk2p2" \
>+      -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcbl=
k2
>+
>+
>+KVM Acceleration
>+----------------
>+
>+Be aware of the following limitations:
>+
>+* The ``imx8mm-evk`` machine is not included under the "virtualization u=
se case"
>+  of :doc:`QEMU's security policy </system/security>`=2E This means that=
 you
>+  should not trust that it can contain malicious guests, whether it is r=
un
>+  using TCG or KVM=2E If you don't trust your guests and you're relying =
on QEMU to
>+  be the security boundary, you want to choose another machine such as `=
`virt``=2E
>+* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be u=
sed=2E
>+  This is a limitation of KVM and may not work with guests with a tight
>+  dependency on Cortex-A53=2E
>+* No EL2 and EL3 exception levels are available which is also a KVM limi=
tation=2E
>+  Direct kernel boot should work but running U-Boot, TF-A, etc=2E won't =
succeed=2E
>diff --git a/docs/system/target-arm=2Erst b/docs/system/target-arm=2Erst
>index a96d1867df=2E=2Ed6a4b5bb00 100644
>--- a/docs/system/target-arm=2Erst
>+++ b/docs/system/target-arm=2Erst
>@@ -97,6 +97,7 @@ Board-specific documentation
>    arm/mcimx6ul-evk
>    arm/mcimx7d-sabre
>    arm/imx8mp-evk
>+   arm/imx8mm-evk
>    arm/orangepi
>    arm/raspi
>    arm/collie
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index 0cdeb60f1f=2E=2E7c66f3c3cd 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -626,6 +626,18 @@ config FSL_IMX8MP_EVK
>     depends on TCG || KVM
>     select FSL_IMX8MP
>=20
>+config FSL_IMX8MM
>+    bool
>+    select ARM_GIC
>+    select IMX
>+
>+config FSL_IMX8MM_EVK
>+    bool
>+    default y
>+    depends on AARCH64
>+    depends on TCG || KVM

Please remove the `|| KVM` since that caused `make check` failures in imx8=
mp-evk in KVM-only builds=2E See https://lore=2Ekernel=2Eorg/qemu-devel/CAF=
EAcA893XcTzwwivboB_T252mwFjH8jQYh3PJbkkyXijgV8kg@mail=2Egmail=2Ecom/ =2E

With that fixed the patch LGTM, though I'd form my final opinion when look=
ing at a diff to imx8mp=2E

Best regards,
Bernhard

>+    select FSL_IMX8MM
>+
> config ARM_SMMUV3
>     bool
>=20
>diff --git a/hw/arm/fsl-imx8mm=2Ec b/hw/arm/fsl-imx8mm=2Ec
>new file mode 100644
>index 0000000000=2E=2E0c658141cf
>--- /dev/null
>+++ b/hw/arm/fsl-imx8mm=2Ec
>@@ -0,0 +1,363 @@
>+/*
>+ * i=2EMX 8MM SoC Implementation
>+ *
>+ * Based on hw/arm/fsl-imx6=2Ec
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "system/address-spaces=2Eh"
>+#include "hw/arm/bsa=2Eh"
>+#include "hw/arm/fsl-imx8mm=2Eh"
>+#include "hw/misc/unimp=2Eh"
>+#include "hw/boards=2Eh"
>+#include "system/kvm=2Eh"
>+#include "system/system=2Eh"
>+#include "target/arm/cpu=2Eh"
>+#include "target/arm/cpu-qom=2Eh"
>+#include "target/arm/kvm_arm=2Eh"
>+#include "qapi/error=2Eh"
>+#include "qobject/qlist=2Eh"
>+
>+static const struct {
>+    hwaddr addr;
>+    size_t size;
>+    const char *name;
>+} fsl_imx8mm_memmap[] =3D {
>+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START, FSL_IMX8MM_RAM_SIZE_MAX=
, "ram" },
>+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB, "ddr_phy_b=
roadcast" },
>+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB, "ddr_perf_mon" =
},
>+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
>+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
>+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
>+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" },
>+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
>+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB, "vpu_blk_ctrl" =
},
>+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB, "vpu_g2_decod=
er" },
>+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB, "vpu_g1_decod=
er" },
>+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
>+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
>+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
>+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
>+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
>+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB, "qspi1_rx_b=
uffer" },
>+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
>+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB, "qspi1_tx_b=
uffer" },
>+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
>+
>+    /* AIPS-4 Begin */
>+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
>+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
>+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256, "media_blk_ctl" },
>+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
>+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
>+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
>+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB, "aips4_=
configuration" },
>+    /* AIPS-4 End */
>+
>+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB, "interconnect" =
},
>+
>+    /* AIPS-3 Begin */
>+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
>+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
>+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
>+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
>+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
>+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
>+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB, "semaphore_hs"=
 },
>+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
>+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
>+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
>+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
>+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
>+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
>+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
>+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB, "aips3_=
configuration" },
>+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
>+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
>+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
>+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
>+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
>+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
>+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
>+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
>+    /* AIPS-3 End */
>+
>+    /* AIPS-2 Begin */
>+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
>+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
>+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
>+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
>+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
>+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
>+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl" }=
,
>+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" },
>+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
>+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
>+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
>+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
>+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
>+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB, "aips2_=
configuration" },
>+    /* AIPS-2 End */
>+
>+    /* AIPS-1 Begin */
>+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
>+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
>+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB, "semaphore2" },
>+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB, "semaphore1" },
>+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
>+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
>+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
>+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
>+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
>+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" },
>+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, "iomuxc_gpr" },
>+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
>+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
>+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
>+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
>+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
>+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
>+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
>+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
>+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
>+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
>+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB, "ana_tsensor" }=
,
>+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
>+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
>+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
>+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
>+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
>+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB, "aips1_=
configuration" },
>+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
>+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
>+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
>+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
>+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
>+
>+    /* AIPS-1 End */
>+
>+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
>+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB, "pcie1_mem" },
>+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
>+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
>+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
>+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
>+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
>+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
>+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB, "boot_rom=
_protected" },
>+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom" },
>+};
>+
>+static void fsl_imx8mm_init(Object *obj)
>+{
>+    MachineState *ms =3D MACHINE(qdev_get_machine());
>+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
>+    const char *cpu_type =3D ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a=
53");
>+    int i;
>+
>+    for (i =3D 0; i < MIN(ms->smp=2Ecpus, FSL_IMX8MM_NUM_CPUS); i++) {
>+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>+        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
>+    }
>+
>+    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>+
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
>+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL)=
;
>+    }
>+
>+}
>+
>+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>+{
>+    MachineState *ms =3D MACHINE(qdev_get_machine());
>+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
>+    DeviceState *gicdev =3D DEVICE(&s->gic);
>+    int i;
>+
>+    if (ms->smp=2Ecpus > FSL_IMX8MM_NUM_CPUS) {
>+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)"=
,
>+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms->smp=2Ecpus)=
;
>+        return;
>+    }
>+
>+    /* CPUs */
>+    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>+        /* On uniprocessor, the CBAR is set to 0 */
>+        if (ms->smp=2Ecpus > 1 &&
>+                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) =
{
>+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>+                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIS=
T]=2Eaddr,
>+                                    &error_abort);
>+        }
>+
>+        /*
>+         * CNTFID0 base frequency in Hz of system counter
>+         */
>+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>+                                &error_abort);
>+
>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
>+                                     !kvm_enabled(), &error_abort);
>+        }
>+
>+        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
>+                                     !kvm_enabled(), &error_abort);
>+        }
>+
>+        if (i) {
>+            /*
>+             * Secondary CPUs start in powered-down state (and can be
>+             * powered up via the SRC system reset controller)
>+             */
>+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-=
off",
>+                                     true, &error_abort);
>+        }
>+
>+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>+            return;
>+        }
>+    }
>+
>+    /* GIC */
>+    {
>+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
>+        QList *redist_region_count;
>+        bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu", =
NULL);
>+
>+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp=2Ecpus);
>+        qdev_prop_set_uint32(gicdev, "num-irq",
>+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
>+        redist_region_count =3D qlist_new();
>+        qlist_append_int(redist_region_count, ms->smp=2Ecpus);
>+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region=
_count);
>+        object_property_set_link(OBJECT(&s->gic), "sysmem",
>+                                 OBJECT(get_system_memory()), &error_fat=
al);
>+        if (!sysbus_realize(gicsbd, errp)) {
>+            return;
>+        }
>+        sysbus_mmio_map(gicsbd, 0, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST=
]=2Eaddr);
>+        sysbus_mmio_map(gicsbd, 1, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDI=
ST]=2Eaddr);
>+
>+        /*
>+         * Wire the outputs from each CPU's generic timer and the GICv3
>+         * maintenance interrupt signal to the appropriate GIC PPI input=
s, and
>+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs=2E
>+         */
>+        for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
>+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
>+            qemu_irq irq;
>+
>+            /*
>+             * Mapping from the output timer irq lines from the CPU to t=
he
>+             * GIC PPI inputs=2E
>+             */
>+            static const int timer_irqs[] =3D {
>+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
>+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
>+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>+            };
>+
>+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
>+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irqs[=
j]);
>+                qdev_connect_gpio_out(cpudev, j, irq);
>+            }
>+
>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_=
IRQ);
>+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-inter=
rupt",
>+                                        0, irq);
>+
>+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ=
);
>+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, irq)=
;
>+
>+            sysbus_connect_irq(gicsbd, i,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>+            sysbus_connect_irq(gicsbd, i + ms->smp=2Ecpus,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp=2Ecpus,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp=2Ecpus,
>+                               qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>+
>+            if (kvm_enabled()) {
>+                if (pmu) {
>+                    assert(arm_feature(&s->cpu[i]=2Eenv, ARM_FEATURE_PMU=
));
>+                    if (kvm_irqchip_in_kernel()) {
>+                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ)=
;
>+                    }
>+                    kvm_arm_pmu_init(&s->cpu[i]);
>+                }
>+            }
>+        }
>+    }
>+
>+    /* UARTs */
>+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
>+        static const struct {
>+            hwaddr addr;
>+            unsigned int irq;
>+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1]=2Eaddr, FSL_IMX8MM_UAR=
T1_IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2]=2Eaddr, FSL_IMX8MM_UAR=
T2_IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3]=2Eaddr, FSL_IMX8MM_UAR=
T3_IRQ },
>+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4]=2Eaddr, FSL_IMX8MM_UAR=
T4_IRQ },
>+        };
>+
>+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
>+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>+            return;
>+        }
>+
>+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i]=
=2Eaddr);
>+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>+                           qdev_get_gpio_in(gicdev, serial_table[i]=2Eir=
q));
>+    }
>+
>+    /* Unimplemented devices */
>+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
>+        switch (i) {
>+        case FSL_IMX8MM_GIC_DIST:
>+        case FSL_IMX8MM_GIC_REDIST:
>+        case FSL_IMX8MM_RAM:
>+        case FSL_IMX8MM_UART1 =2E=2E=2E FSL_IMX8MM_UART4:
>+            /* device implemented and treated above */
>+            break;
>+
>+        default:
>+            create_unimplemented_device(fsl_imx8mm_memmap[i]=2Ename,
>+                                        fsl_imx8mm_memmap[i]=2Eaddr,
>+                                        fsl_imx8mm_memmap[i]=2Esize);
>+            break;
>+        }
>+    }
>+}
>+
>+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(oc);
>+
>+    dc->realize =3D fsl_imx8mm_realize;
>+
>+    dc->desc =3D "i=2EMX 8MM SoC";
>+}
>+
>+static const TypeInfo fsl_imx8mm_types[] =3D {
>+    {
>+        =2Ename =3D TYPE_FSL_IMX8MM,
>+        =2Eparent =3D TYPE_SYS_BUS_DEVICE,
>+        =2Einstance_size =3D sizeof(FslImx8mmState),
>+        =2Einstance_init =3D fsl_imx8mm_init,
>+        =2Eclass_init =3D fsl_imx8mm_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(fsl_imx8mm_types)
>diff --git a/hw/arm/imx8mm-evk=2Ec b/hw/arm/imx8mm-evk=2Ec
>new file mode 100644
>index 0000000000=2E=2E82751dad7d
>--- /dev/null
>+++ b/hw/arm/imx8mm-evk=2Ec
>@@ -0,0 +1,109 @@
>+/*
>+ * NXP i=2EMX 8MM Evaluation Kit System Emulation
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "system/address-spaces=2Eh"
>+#include "hw/arm/boot=2Eh"
>+#include "hw/arm/fsl-imx8mm=2Eh"
>+#include "hw/arm/machines-qom=2Eh"
>+#include "hw/boards=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "system/kvm=2Eh"
>+#include "system/qtest=2Eh"
>+#include "qemu/error-report=2Eh"
>+#include "qapi/error=2Eh"
>+#include <libfdt=2Eh>
>+
>+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void=
 *fdt)
>+{
>+    int i, offset;
>+
>+    /* Temporarily disable following nodes until they are implemented */
>+    const char *nodes_to_remove[] =3D {
>+        "nxp,imx8mm-fspi",
>+        "fsl,imx8mm-mipi-csi",
>+        "fsl,imx8mm-mipi-dsim"
>+    };
>+
>+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
>+        const char *dev_str =3D nodes_to_remove[i];
>+
>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
>+        while (offset >=3D 0) {
>+            fdt_nop_node(fdt, offset);
>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_st=
r);
>+        }
>+    }
>+
>+    /* Remove cpu-idle-states property from CPU nodes */
>+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
>+    while (offset >=3D 0) {
>+        fdt_nop_property(fdt, offset, "cpu-idle-states");
>+        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,corte=
x-a53");
>+    }
>+
>+    if (kvm_enabled()) {
>+        /* Use system counter frequency from host CPU to fix time in gue=
st */
>+        offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-tim=
er");
>+        while (offset >=3D 0) {
>+            fdt_nop_property(fdt, offset, "clock-frequency");
>+            offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,a=
rmv8-timer");
>+        }
>+    }
>+}
>+
>+static void imx8mm_evk_init(MachineState *machine)
>+{
>+    static struct arm_boot_info boot_info;
>+    FslImx8mmState *s;
>+
>+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
>+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08=
" PRIx64 ")",
>+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
>+        exit(1);
>+    }
>+
>+    boot_info =3D (struct arm_boot_info) {
>+        =2Eloader_start =3D FSL_IMX8MM_RAM_START,
>+        =2Eboard_id =3D -1,
>+        =2Eram_size =3D machine->ram_size,
>+        =2Epsci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
>+        =2Emodify_dtb =3D imx8mm_evk_modify_dtb,
>+    };
>+
>+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
>+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>+
>+    memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_STAR=
T,
>+                                machine->ram);
>+
>+    if (!qtest_enabled()) {
>+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
>+    }
>+}
>+
>+static const char *imx8mm_evk_get_default_cpu_type(const MachineState *m=
s)
>+{
>+    if (kvm_enabled()) {
>+        return ARM_CPU_TYPE_NAME("host");
>+    }
>+
>+    return ARM_CPU_TYPE_NAME("cortex-a53");
>+}
>+
>+static void imx8mm_evk_machine_init(MachineClass *mc)
>+{
>+    mc->desc =3D "NXP i=2EMX 8MM EVK Board";
>+    mc->init =3D imx8mm_evk_init;
>+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
>+    mc->default_ram_id =3D "imx8mm-evk=2Eram";
>+    mc->get_default_cpu_type =3D imx8mm_evk_get_default_cpu_type;
>+}
>+
>+DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
>diff --git a/hw/arm/meson=2Ebuild b/hw/arm/meson=2Ebuild
>index aeaf654790=2E=2E12ecb824cc 100644
>--- a/hw/arm/meson=2Ebuild
>+++ b/hw/arm/meson=2Ebuild
>@@ -84,6 +84,8 @@ arm_common_ss=2Eadd(when: 'CONFIG_ARMSSE', if_true: fil=
es('armsse=2Ec'))
> arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7=2E=
c', 'mcimx7d-sabre=2Ec'))
> arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8m=
p=2Ec'))
> arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8m=
p-evk=2Ec'))
>+arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX8MM', if_true: files('fsl-imx8m=
m=2Ec'))
>+arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8m=
m-evk=2Ec'))
> arm_common_ss=2Eadd(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3=2E=
c'))
> arm_common_ss=2Eadd(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6u=
l=2Ec', 'mcimx6ul-evk=2Ec'))
> arm_common_ss=2Eadd(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc=
=2Ec'))
>diff --git a/include/hw/arm/fsl-imx8mm=2Eh b/include/hw/arm/fsl-imx8mm=2E=
h
>new file mode 100644
>index 0000000000=2E=2Eaa954ea00b
>--- /dev/null
>+++ b/include/hw/arm/fsl-imx8mm=2Eh
>@@ -0,0 +1,156 @@
>+/*
>+ * i=2EMX 8MM SoC Definitions
>+ *
>+ * Copyright (c) 2025, Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#ifndef FSL_IMX8MM_H
>+#define FSL_IMX8MM_H
>+
>+#include "cpu=2Eh"
>+#include "hw/char/imx_serial=2Eh"
>+#include "hw/intc/arm_gicv3_common=2Eh"
>+#include "qom/object=2Eh"
>+#include "qemu/units=2Eh"
>+
>+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
>+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
>+
>+#define FSL_IMX8MM_RAM_START        0x40000000
>+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
>+
>+enum FslImx8mmConfiguration {
>+    FSL_IMX8MM_NUM_CPUS         =3D 4,
>+    FSL_IMX8MM_NUM_IRQS         =3D 128,
>+    FSL_IMX8MM_NUM_UARTS        =3D 4,
>+};
>+
>+struct FslImx8mmState {
>+    SysBusDevice   parent_obj;
>+
>+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
>+    GICv3State         gic;
>+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
>+};
>+
>+enum FslImx8mmMemoryRegions {
>+    FSL_IMX8MM_A53_DAP,
>+    FSL_IMX8MM_AIPS1_CONFIGURATION,
>+    FSL_IMX8MM_AIPS2_CONFIGURATION,
>+    FSL_IMX8MM_AIPS3_CONFIGURATION,
>+    FSL_IMX8MM_AIPS4_CONFIGURATION,
>+    FSL_IMX8MM_ANA_OSC,
>+    FSL_IMX8MM_ANA_PLL,
>+    FSL_IMX8MM_ANA_TSENSOR,
>+    FSL_IMX8MM_APBH_DMA,
>+    FSL_IMX8MM_BOOT_ROM,
>+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
>+    FSL_IMX8MM_CAAM,
>+    FSL_IMX8MM_CAAM_MEM,
>+    FSL_IMX8MM_CCM,
>+    FSL_IMX8MM_CSU,
>+    FSL_IMX8MM_DDR_CTL,
>+    FSL_IMX8MM_DDR_PERF_MON,
>+    FSL_IMX8MM_DDR_PHY,
>+    FSL_IMX8MM_DDR_PHY_BROADCAST,
>+    FSL_IMX8MM_ECSPI1,
>+    FSL_IMX8MM_ECSPI2,
>+    FSL_IMX8MM_ECSPI3,
>+    FSL_IMX8MM_ENET1,
>+    FSL_IMX8MM_GIC_DIST,
>+    FSL_IMX8MM_GIC_REDIST,
>+    FSL_IMX8MM_GPC,
>+    FSL_IMX8MM_GPIO1,
>+    FSL_IMX8MM_GPIO2,
>+    FSL_IMX8MM_GPIO3,
>+    FSL_IMX8MM_GPIO4,
>+    FSL_IMX8MM_GPIO5,
>+    FSL_IMX8MM_GPT1,
>+    FSL_IMX8MM_GPT2,
>+    FSL_IMX8MM_GPT3,
>+    FSL_IMX8MM_GPT4,
>+    FSL_IMX8MM_GPT5,
>+    FSL_IMX8MM_GPT6,
>+    FSL_IMX8MM_GPU2D,
>+    FSL_IMX8MM_I2C1,
>+    FSL_IMX8MM_I2C2,
>+    FSL_IMX8MM_I2C3,
>+    FSL_IMX8MM_I2C4,
>+    FSL_IMX8MM_INTERCONNECT,
>+    FSL_IMX8MM_IOMUXC,
>+    FSL_IMX8MM_IOMUXC_GPR,
>+    FSL_IMX8MM_MEDIA_BLK_CTL,
>+    FSL_IMX8MM_LCDIF,
>+    FSL_IMX8MM_MIPI_CSI,
>+    FSL_IMX8MM_MIPI_DSI,
>+    FSL_IMX8MM_MU_A,
>+    FSL_IMX8MM_MU_B,
>+    FSL_IMX8MM_OCOTP_CTRL,
>+    FSL_IMX8MM_OCRAM,
>+    FSL_IMX8MM_OCRAM_S,
>+    FSL_IMX8MM_PCIE1,
>+    FSL_IMX8MM_PCIE1_MEM,
>+    FSL_IMX8MM_PCIE_PHY1,
>+    FSL_IMX8MM_PERFMON1,
>+    FSL_IMX8MM_PERFMON2,
>+    FSL_IMX8MM_PWM1,
>+    FSL_IMX8MM_PWM2,
>+    FSL_IMX8MM_PWM3,
>+    FSL_IMX8MM_PWM4,
>+    FSL_IMX8MM_QOSC,
>+    FSL_IMX8MM_QSPI,
>+    FSL_IMX8MM_QSPI1_RX_BUFFER,
>+    FSL_IMX8MM_QSPI1_TX_BUFFER,
>+    FSL_IMX8MM_QSPI_MEM,
>+    FSL_IMX8MM_RAM,
>+    FSL_IMX8MM_RDC,
>+    FSL_IMX8MM_SAI1,
>+    FSL_IMX8MM_SAI2,
>+    FSL_IMX8MM_SAI3,
>+    FSL_IMX8MM_SAI5,
>+    FSL_IMX8MM_SAI6,
>+    FSL_IMX8MM_SDMA1,
>+    FSL_IMX8MM_SDMA2,
>+    FSL_IMX8MM_SDMA3,
>+    FSL_IMX8MM_SEMAPHORE1,
>+    FSL_IMX8MM_SEMAPHORE2,
>+    FSL_IMX8MM_SEMAPHORE_HS,
>+    FSL_IMX8MM_SNVS_HP,
>+    FSL_IMX8MM_SPBA1,
>+    FSL_IMX8MM_SRC,
>+    FSL_IMX8MM_SYSCNT_CMP,
>+    FSL_IMX8MM_SYSCNT_CTRL,
>+    FSL_IMX8MM_SYSCNT_RD,
>+    FSL_IMX8MM_TCM_DTCM,
>+    FSL_IMX8MM_TCM_ITCM,
>+    FSL_IMX8MM_TZASC,
>+    FSL_IMX8MM_UART1,
>+    FSL_IMX8MM_UART2,
>+    FSL_IMX8MM_UART3,
>+    FSL_IMX8MM_UART4,
>+    FSL_IMX8MM_USB1,
>+    FSL_IMX8MM_USB2,
>+    FSL_IMX8MM_USB1_OTG,
>+    FSL_IMX8MM_USB2_OTG,
>+    FSL_IMX8MM_USDHC1,
>+    FSL_IMX8MM_USDHC2,
>+    FSL_IMX8MM_USDHC3,
>+    FSL_IMX8MM_VPU,
>+    FSL_IMX8MM_VPU_BLK_CTRL,
>+    FSL_IMX8MM_VPU_G1_DECODER,
>+    FSL_IMX8MM_VPU_G2_DECODER,
>+    FSL_IMX8MM_WDOG1,
>+    FSL_IMX8MM_WDOG2,
>+    FSL_IMX8MM_WDOG3,
>+};
>+
>+enum FslImx8mmIrqs {
>+    FSL_IMX8MM_UART1_IRQ    =3D 26,
>+    FSL_IMX8MM_UART2_IRQ    =3D 27,
>+    FSL_IMX8MM_UART3_IRQ    =3D 28,
>+    FSL_IMX8MM_UART4_IRQ    =3D 29,
>+};
>+
>+#endif /* FSL_IMX8MM_H */

