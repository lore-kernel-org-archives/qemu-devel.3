Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D26FC02181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 02:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta4O9-0002VY-Jh; Mon, 20 Jan 2025 21:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4O7-0002UX-Q6; Mon, 20 Jan 2025 21:53:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4O2-0006Wn-KF; Mon, 20 Jan 2025 21:53:11 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5D1114E6039;
 Tue, 21 Jan 2025 03:53:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wLkXKXDOPwAX; Tue, 21 Jan 2025 03:52:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D0154E6036; Tue, 21 Jan 2025 03:52:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A79974577C;
 Tue, 21 Jan 2025 03:52:58 +0100 (CET)
Date: Tue, 21 Jan 2025 03:52:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 08/21] hw/arm/fsl-imx8mp: Add USDHC storage controllers
In-Reply-To: <20250120203748.4687-9-shentey@gmail.com>
Message-ID: <3e6208b1-7d70-5205-a92f-549d7d2fff13@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-9-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 Jan 2025, Bernhard Beschow wrote:
> The USDHC emulation allows for running real-world images such as those generated
> by Buildroot. Convert the board documentation accordingly instead of running a
> Linux kernel with ephemeral storage.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> docs/system/arm/imx8mp-evk.rst | 39 +++++++++++++++++++++++-----------
> include/hw/arm/fsl-imx8mp.h    |  7 ++++++
> hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++
> hw/arm/imx8mp-evk.c            | 18 ++++++++++++++++
> hw/arm/Kconfig                 |  1 +
> 5 files changed, 81 insertions(+), 12 deletions(-)
>
> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
> index d7d08cc198..1514bc5864 100644
> --- a/docs/system/arm/imx8mp-evk.rst
> +++ b/docs/system/arm/imx8mp-evk.rst
> @@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
>  * Up to 4 Cortex-A53 Cores
>  * Generic Interrupt Controller (GICv3)
>  * 4 UARTs
> + * 3 USDHC Storage Controllers
>  * Secure Non-Volatile Storage (SNVS) including an RTC
>  * Clock Tree
>
> @@ -25,25 +26,39 @@ for loading a Linux kernel.
> Direct Linux Kernel Boot
> ''''''''''''''''''''''''
>
> -Linux mainline v6.12 release is tested at the time of writing. To build a Linux
> -mainline kernel that can be booted by the ``imx8mp-evk`` machine, simply
> -configure the kernel using the defconfig configuration:
> +Probably the easiest way to get started with a whole Linux system on the machine
> +is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
> +of writing and involves three steps. First run the following command in the
> +toplevel directory of the Buildroot source tree:
>
> .. code-block:: bash
>
> -  $ export ARCH=arm64
> -  $ export CROSS_COMPILE=aarch64-linux-gnu-
> -  $ make defconfig
> +  $ make freescale_imx8mpevk_defconfig
>   $ make

Adding documentation that is removed a few patches later seems 
unnecessary. Maybe you could keep the bare kernel docs as that could also 
be useful or not add it in the first place? But if this is already written 
keeping it may make more sense than dropping it.

Regards,
BALATON Zoltan

>
> -To boot the newly built Linux kernel in QEMU with the ``imx8mp-evk`` machine,
> -run:
> +Once finished successfully there is an ``output/image`` subfolder. Navigate into
> +it and resize the SD card image to a power of two:
> +
> +.. code-block:: bash
> +
> +  $ qemu-img resize sdcard.img 256M
> +
> +Finally, the device tree needs to be patched with the following commands which
> +will remove the ``cpu-idle-states`` properties from CPU nodes:
> +
> +.. code-block:: bash
> +
> +  $ dtc imx8mp-evk.dtb | sed '/cpu-idle-states/d' > imx8mp-evk-patched.dts
> +  $ dtc imx8mp-evk-patched.dts -o imx8mp-evk-patched.dtb
> +
> +Now that everything is prepared the newly built image can be run in the QEMU
> +``imx8mp-evk`` machine:
>
> .. code-block:: bash
>
>   $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
>       -display none -serial null -serial stdio \
> -      -kernel arch/arm64/boot/Image \
> -      -dtb arch/arm64/boot/dts/freescale/imx8mp-evk.dtb \
> -      -initrd /path/to/rootfs.ext4 \
> -      -append "root=/dev/ram"
> +      -kernel Image \
> +      -dtb imx8mp-evk-patched.dtb \
> +      -append "root=/dev/mmcblk2p2" \
> +      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
> diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
> index 9d2a757c2a..9832c05e8c 100644
> --- a/include/hw/arm/fsl-imx8mp.h
> +++ b/include/hw/arm/fsl-imx8mp.h
> @@ -14,6 +14,7 @@
> #include "hw/intc/arm_gicv3_common.h"
> #include "hw/misc/imx7_snvs.h"
> #include "hw/misc/imx8mp_ccm.h"
> +#include "hw/sd/sdhci.h"
> #include "qom/object.h"
> #include "qemu/units.h"
>
> @@ -27,6 +28,7 @@ enum FslImx8mpConfiguration {
>     FSL_IMX8MP_NUM_CPUS         = 4,
>     FSL_IMX8MP_NUM_IRQS         = 160,
>     FSL_IMX8MP_NUM_UARTS        = 4,
> +    FSL_IMX8MP_NUM_USDHCS       = 3,
> };
>
> struct FslImx8mpState {
> @@ -38,6 +40,7 @@ struct FslImx8mpState {
>     IMX8MPAnalogState  analog;
>     IMX7SNVSState      snvs;
>     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
> +    SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
> };
>
> enum FslImx8mpMemoryRegions {
> @@ -183,6 +186,10 @@ enum FslImx8mpMemoryRegions {
> };
>
> enum FslImx8mpIrqs {
> +    FSL_IMX8MP_USDHC1_IRQ   = 22,
> +    FSL_IMX8MP_USDHC2_IRQ   = 23,
> +    FSL_IMX8MP_USDHC3_IRQ   = 24,
> +
>     FSL_IMX8MP_UART1_IRQ    = 26,
>     FSL_IMX8MP_UART2_IRQ    = 27,
>     FSL_IMX8MP_UART3_IRQ    = 28,
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 0abde2b1fc..612ea7bf93 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -210,6 +210,11 @@ static void fsl_imx8mp_init(Object *obj)
>         snprintf(name, NAME_SIZE, "uart%d", i + 1);
>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
>     }
> +
> +    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
> +        snprintf(name, NAME_SIZE, "usdhc%d", i + 1);
> +        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
> +    }
> }
>
> static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
> @@ -350,6 +355,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
>     }
>
> +    /* USDHCs */
> +    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
> +        static const struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } usdhc_table[FSL_IMX8MP_NUM_USDHCS] = {
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC1].addr, FSL_IMX8MP_USDHC1_IRQ },
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC2].addr, FSL_IMX8MP_USDHC2_IRQ },
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
> +        };
> +
> +        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
> +                                 SDHCI_VENDOR_IMX, &error_abort);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
> +                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
> +    }
> +
>     /* SNVS */
>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
>         return;
> @@ -367,6 +394,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>         case FSL_IMX8MP_RAM:
>         case FSL_IMX8MP_SNVS_HP:
>         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
> +        case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
>             /* device implemented and treated above */
>             break;
>
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index 2756d4c21c..27d9e9e8ee 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -11,6 +11,7 @@
> #include "hw/arm/boot.h"
> #include "hw/arm/fsl-imx8mp.h"
> #include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> #include "system/qtest.h"
> #include "qemu/error-report.h"
> #include "qapi/error.h"
> @@ -40,6 +41,23 @@ static void imx8mp_evk_init(MachineState *machine)
>     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
>                                 machine->ram);
>
> +    for (int i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
> +        BusState *bus;
> +        DeviceState *carddev;
> +        BlockBackend *blk;
> +        DriveInfo *di = drive_get(IF_SD, i, 0);
> +
> +        if (!di) {
> +            continue;
> +        }
> +
> +        blk = blk_by_legacy_dinfo(di);
> +        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
> +        carddev = qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
> +        qdev_realize_and_unref(carddev, bus, &error_fatal);
> +    }
> +
>     if (!qtest_enabled()) {
>         arm_load_kernel(&s->cpu[0], machine, &boot_info);
>     }
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index adb4ed8076..f880c03d35 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -582,6 +582,7 @@ config FSL_IMX8MP
>     imply TEST_DEVICES
>     select ARM_GIC
>     select IMX
> +    select SDHCI
>     select UNIMP
>
> config FSL_IMX8MP_EVK
>

