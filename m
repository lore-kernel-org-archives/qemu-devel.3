Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D9C02181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 03:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta4VE-0004Lt-5w; Mon, 20 Jan 2025 22:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4VB-0004LN-S6; Mon, 20 Jan 2025 22:00:29 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ta4V8-0007HT-TF; Mon, 20 Jan 2025 22:00:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 482234E6036;
 Tue, 21 Jan 2025 04:00:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Cn-hwxshkCiv; Tue, 21 Jan 2025 04:00:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BED8C4E6001; Tue, 21 Jan 2025 04:00:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BCBD374577C;
 Tue, 21 Jan 2025 04:00:17 +0100 (CET)
Date: Tue, 21 Jan 2025 04:00:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 17/21] hw/arm/fsl-imx8mp: Add boot ROM
In-Reply-To: <20250120203748.4687-18-shentey@gmail.com>
Message-ID: <e3004582-40cc-e35c-91fe-88947cbb4978@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-18-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 20 Jan 2025, Bernhard Beschow wrote:
> On a real device, the boot ROM contains the very first instructions the CPU
> executes. Also, U-Boot calls into the ROM to determine the boot device. While
> we're not actually implementing this here, let's create the infrastructure and
> add a dummy ROM with all zeros. This allows for implementing a ROM later without
> touching the source code and even allows for users to provide their own ROMs.
>
> The imx8mp-boot.rom was created with
> `dd if=/dev/zero of=imx8mp-boot.rom bs=1 count=258048`.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> MAINTAINERS                 |   1 +
> include/hw/arm/fsl-imx8mp.h |   1 +
> hw/arm/fsl-imx8mp.c         |  18 ++++++++++++++++++
> pc-bios/imx8mp-boot.rom     | Bin 0 -> 258048 bytes
> pc-bios/meson.build         |   1 +
> 5 files changed, 21 insertions(+)
> create mode 100644 pc-bios/imx8mp-boot.rom
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b416831d..d2cdc790ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -830,6 +830,7 @@ F: hw/pci-host/fsl_imx8m_phy.c
> F: include/hw/arm/fsl-imx8mp.h
> F: include/hw/misc/imx8mp_*.h
> F: include/hw/pci-host/fsl_imx8m_phy.h
> +F: pc-bios/imx8mp*
> F: docs/system/arm/imx8mp-evk.rst
>
> MPS2 / MPS3
> diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
> index 1b8a5cbbba..326c4ddf69 100644
> --- a/include/hw/arm/fsl-imx8mp.h
> +++ b/include/hw/arm/fsl-imx8mp.h
> @@ -67,6 +67,7 @@ struct FslImx8mpState {
>     DesignwarePCIEHost pcie;
>     FslImx8mPciePhyState   pcie_phy;
>     OrIRQState         gpt5_gpt6_irq;
> +    MemoryRegion       boot_rom;
>
>     uint32_t           phy_num;
>     bool               phy_connected;
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 5b9781a424..9688e2e962 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -9,12 +9,14 @@
>  */
>
> #include "qemu/osdep.h"
> +#include "qemu/datadir.h"
> #include "exec/address-spaces.h"
> #include "hw/arm/bsa.h"
> #include "hw/arm/fsl-imx8mp.h"
> #include "hw/intc/arm_gicv3.h"
> #include "hw/misc/unimp.h"
> #include "hw/boards.h"
> +#include "hw/loader.h"
> #include "system/system.h"
> #include "target/arm/cpu-qom.h"
> #include "qapi/qmp/qlist.h"
> @@ -266,6 +268,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>     MachineState *ms = MACHINE(qdev_get_machine());
>     FslImx8mpState *s = FSL_IMX8MP(dev);
>     DeviceState *gicdev = DEVICE(&s->gic);
> +    g_autofree char *filename = NULL;
>     int i;
>
>     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
> @@ -648,10 +651,25 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
>                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
>
> +    /* ROM memory */
> +    if (!memory_region_init_ram(&s->boot_rom, OBJECT(dev),
> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].name,
> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].size,
> +                                errp)) {
> +        return;
> +    }

If it's ROM why not memory_region_init_rom?

Regards,
BALATON Zoltan

> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "imx8mp-boot.rom");
> +    load_image_size(filename, memory_region_get_ram_ptr(&s->boot_rom),
> +                    memory_region_size(&s->boot_rom));
> +    memory_region_add_subregion(get_system_memory(),
> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].addr,
> +                                &s->boot_rom);
> +
>     /* Unimplemented devices */
>     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
>         switch (i) {
>         case FSL_IMX8MP_ANA_PLL:
> +        case FSL_IMX8MP_BOOT_ROM:
>         case FSL_IMX8MP_CCM:
>         case FSL_IMX8MP_GIC_DIST:
>         case FSL_IMX8MP_GIC_REDIST:
> diff --git a/pc-bios/imx8mp-boot.rom b/pc-bios/imx8mp-boot.rom
> new file mode 100644
> index 0000000000000000000000000000000000000000..5324b5eed200e723d048f8476e4d96d45622fd4d
> GIT binary patch
> literal 258048
> zcmeIuF#!Mo0K%a4Pi+Q&h(KY$fB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
> zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
> zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
> z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
> z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
> zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
> zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
> zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
> zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
> z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
> z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
> zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
> zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>f$Z
> E2JkHa0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index b68b29cc7d..64d3286fdd 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -60,6 +60,7 @@ blobs = [
>   'efi-virtio.rom',
>   'efi-e1000e.rom',
>   'efi-vmxnet3.rom',
> +  'imx8mp-boot.rom',
>   'qemu-nsis.bmp',
>   'multiboot.bin',
>   'multiboot_dma.bin',
>

