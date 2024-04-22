Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B98C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvDR-00012s-1Z; Mon, 22 Apr 2024 11:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jzPN=L3=kaod.org=clg@ozlabs.org>)
 id 1ryvDK-0000x2-FV; Mon, 22 Apr 2024 11:04:15 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jzPN=L3=kaod.org=clg@ozlabs.org>)
 id 1ryvDH-0006cB-OI; Mon, 22 Apr 2024 11:04:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VNT6N1bsYz4x0v;
 Tue, 23 Apr 2024 01:03:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNT6J5JGSz4wyQ;
 Tue, 23 Apr 2024 01:03:52 +1000 (AEST)
Message-ID: <5cd0d411-a723-4324-b706-913ac936f77b@kaod.org>
Date: Mon, 22 Apr 2024 17:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/ppc: SPI controller wiring to P10 chip and
 create seeprom device
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
 <20240409175700.27535-6-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240409175700.27535-6-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=jzPN=L3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/24 19:56, Chalapathi V wrote:
> In this commit
> Creates SPI controller on p10 chip.
> Create the keystore seeprom of type "seeprom-25csm04"
> Connect the cs of seeprom to PIB_SPIC[2] cs irq.
> 
> The QOM tree of spi controller and seeprom are.
> /machine (powernv10-machine)
>    /chip[0] (power10_v2.0-pnv-chip)
>      /pib_spic[2] (pnv-spi-controller)
>        /bus (pnv-spi-bus)
>          /pnv-spi-bus.2 (SSI)
>        /xscom-spi-controller-regs[0] (memory-region)
> 
> /machine (powernv10-machine)
>    /unattached (container)
>      /device[7] (seeprom-25csm04)
>        /ssi-gpio-cs[0] (irq)
> 
> (qemu) qom-get /machine/unattached/device[7] "parent_bus"
> "/machine/chip[0]/pib_spic[2]/bus/pnv-spi-bus.2"
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_chip.h |  3 +++
>   hw/ppc/pnv.c              | 36 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291e..3edf13e8f9 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -6,6 +6,7 @@
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
>   #include "hw/ppc/pnv_n1_chiplet.h"
> +#include "hw/ppc/pnv_spi_controller.h"
>   #include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_occ.h"
>   #include "hw/ppc/pnv_psi.h"
> @@ -118,6 +119,8 @@ struct Pnv10Chip {
>       PnvSBE       sbe;
>       PnvHomer     homer;
>       PnvN1Chiplet     n1_chiplet;
> +#define PNV10_CHIP_MAX_PIB_SPIC 6
> +    PnvSpiController pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
>   
>       uint32_t     nr_quads;
>       PnvQuad      *quads;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..eeb2d650bd 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -46,6 +46,7 @@
>   #include "hw/pci-host/pnv_phb.h"
>   #include "hw/pci-host/pnv_phb3.h"
>   #include "hw/pci-host/pnv_phb4.h"
> +#include "hw/ssi/ssi.h"
>   
>   #include "hw/ppc/xics.h"
>   #include "hw/qdev-properties.h"
> @@ -1829,6 +1830,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
>       for (i = 0; i < pcc->i2c_num_engines; i++) {
>           object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
>       }
> +
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC ; i++) {
> +        object_initialize_child(obj, "pib_spic[*]", &chip10->pib_spic[i],
> +                                TYPE_PNV_SPI_CONTROLLER);
> +    }
>   }
>   
>   static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
> @@ -2043,7 +2049,35 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>                                 qdev_get_gpio_in(DEVICE(&chip10->psi),
>                                                  PSIHB9_IRQ_SBE_I2C));
>       }
> -
> +    /* PIB SPI Controller */
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
> +                                i , &error_fatal);
> +        /*
> +         * The TPM attached SPIC needs to reverse the bit order in each byte
> +         * it sends to the TPM.
> +         */
> +        if (i == 4) {
> +            object_property_set_bool(OBJECT(&chip10->pib_spic[i]),
> +                    "reverse_bits", true, &error_fatal);
> +        }

or

           object_property_set_bool(OBJECT(&chip10->pib_spic[i]),
                     "reverse_bits", (i == 4) , &error_fatal);


That said. This setting looks weird to me.

Why do we need to reverse the bits ? is it an endian issue ?

Are there other SPI devices on the buses ?

> +        if (!qdev_realize(DEVICE(&chip10->pib_spic[i]), NULL, errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
> +                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
> +                                &chip10->pib_spic[i].xscom_spic_regs);
> +    }


The devices below belong to the rainer machine it seems. We should introduce
a per-machine handler to create them like it was done for the I2C devices.
For this purpose, the PnvMachineClass::i2c_init) handler could be changed
to create all machine specific devices.

> +    /* Primary MEAS/MVPD/Keystore SEEPROM connected to pib_spic[2] */
> +    DeviceState *seeprom = qdev_new("seeprom-25csm04");
> +    qdev_prop_set_string(seeprom, "filename",
> +                         "sbe_measurement_seeprom.bin.ecc");

This should be done differently. Here is a command line example :

$ qemu-system-arm -M ast2600-evb \
       -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
       -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
       -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
       -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
       -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
       -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
       ...

Please try to rework "seeprom-25csm04" on top of "m25p80". It should help.


> +    ssi_realize_and_unref(seeprom, ((&chip10->pib_spic[2])->bus).ssi_bus,
> +                          &error_fatal);
> +    qemu_irq seeprom_cs = qdev_get_gpio_in_named(seeprom, SSI_GPIO_CS, 0);
> +    Object *bus = OBJECT(&(&chip10->pib_spic[2])->bus);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(bus), 0, seeprom_cs);

Could you please slightly change the models to connect the IRQ line using
qdev_connect_gpio_out instead ?  See pnv_rainier_i2c_init.

Thanks,

C.

>   }
>   
>   static void pnv_rainier_i2c_init(PnvMachineState *pnv)


