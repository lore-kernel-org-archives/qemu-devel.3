Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844F5C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8w9e-00072s-Ox; Mon, 20 May 2024 02:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8w94-0006y6-IX; Mon, 20 May 2024 02:05:15 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8w92-0000ep-7U; Mon, 20 May 2024 02:05:14 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VjRqn1W5Cz4wjF;
 Mon, 20 May 2024 16:05:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjRqh6k4yz4wb0;
 Mon, 20 May 2024 16:05:04 +1000 (AEST)
Message-ID: <03454ced-31ad-4585-9b99-a04da4a4bf33@kaod.org>
Date: Mon, 20 May 2024 08:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/ppc: SPI controller wiring to P10 chip
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-5-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240515174149.17713-5-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3Db1=MX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

+ Phil

On 5/15/24 19:41, Chalapathi V wrote:
> In this commit, create SPI controller on p10 chip and connect cs irq.
> 
> The QOM tree of spi controller and seeprom are.
> /machine (powernv10-machine)
>    /chip[0] (power10_v2.0-pnv-chip)
>      /pib_spic[2] (pnv-spi-controller)
>        /pnv-spi-bus.2 (SSI)
>        /xscom-spi-controller-regs[0] (memory-region)
> 
> /machine (powernv10-machine)
>    /peripheral-anon (container)
>      /device[0] (25csm04)
>        /WP#[0] (irq)
>        /ssi-gpio-cs[0] (irq)
> 
> (qemu) qom-get /machine/peripheral-anon /device[76] "parent_bus"
> "/machine/chip[0]/pib_spic[2]/pnv-spi-bus.2"
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_chip.h   |  3 +++
>   hw/ppc/pnv.c                | 21 ++++++++++++++++++++-
>   hw/ppc/pnv_spi_controller.c |  8 ++++++++
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291e..d464858f79 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -6,6 +6,7 @@
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_homer.h"
>   #include "hw/ppc/pnv_n1_chiplet.h"
> +#include "hw/ssi/pnv_spi.h"
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
> index 6e3a5ccdec..6850592a85 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1829,6 +1829,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
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
> @@ -2043,7 +2048,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>                                 qdev_get_gpio_in(DEVICE(&chip10->psi),
>                                                  PSIHB9_IRQ_SBE_I2C));
>       }
> -
> +    /* PIB SPI Controller */
> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
> +                                i, &error_fatal);
> +        /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
> +                                (i == 2) ? 1 : 4, &error_fatal);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
> +                                        (&chip10->pib_spic[i])), errp)) {
> +            return;
> +        }
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
> +                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
> +                                &chip10->pib_spic[i].xscom_spic_regs);
> +    }
>   }
>   
>   static void pnv_rainier_i2c_init(PnvMachineState *pnv)
> diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
> index e87f583074..3d47e932de 100644
> --- a/hw/ppc/pnv_spi_controller.c
> +++ b/hw/ppc/pnv_spi_controller.c
> @@ -1067,9 +1067,17 @@ static void operation_sequencer(PnvSpiController *s)
>   static void do_reset(DeviceState *dev)
>   {
>       PnvSpiController *s = PNV_SPICONTROLLER(dev);
> +    DeviceState *ssi_dev;
>   
>       trace_pnv_spi_reset();
>   
> +    /* Connect cs irq */
> +    ssi_dev = ssi_get_cs(s->ssi_bus, 0);
> +    if (ssi_dev) {
> +        qemu_irq cs_line = qdev_get_gpio_in_named(ssi_dev, SSI_GPIO_CS, 0);
> +        qdev_connect_gpio_out_named(DEVICE(s), "cs", 0, cs_line);
> +    }
> +
>       /* Reset all N1 and N2 counters, and other constants */
>       s->N2_bits = 0;
>       s->N2_bytes = 0;

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


