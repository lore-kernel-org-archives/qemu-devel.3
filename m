Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7C0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UC1-0006V1-61; Mon, 13 May 2024 07:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6UBy-0006Sf-9J; Mon, 13 May 2024 07:50:06 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6UBv-0004qi-8Y; Mon, 13 May 2024 07:50:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VdHps4tBTz4wcR;
 Mon, 13 May 2024 21:49:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VdHpq2S3xz4wb2;
 Mon, 13 May 2024 21:49:55 +1000 (AEST)
Message-ID: <cf991fe4-046e-435f-973b-3a27bd6eba6a@kaod.org>
Date: Mon, 13 May 2024 13:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240510143026.109098-1-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240510143026.109098-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=xtei=MQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 5/10/24 16:30, Nicholas Piggin wrote:
> The POWER8 LPC ISA device irqs all get combined and reported to the line
> connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
> host controller irqs use that line, and the device irqs get routed to
> 4 new lines connected to PSI SERIRQ0-3.
> 
> POWER9 also introduced a new feature that automatically clears the irq
> status in the LPC host controller when EOI'ed, so software does not have
> to.
> 
> The powernv OPAL (skiboot) firmware managed to work because the LPCHC
> irq handler scanned all LPC irqs and handled those including clearing
> status even on POWER9 systems. So LPC irqs worked despite OPAL thinking
> it was running in POWER9 mode. After this change, UART interrupts show
> up on serirq1 which is where OPAL routes them to:
> 
>   cat /proc/interrupts
>   ...
>   20:          0  XIVE-IRQ 1048563 Level     opal-psi#0:lpchc
>   ...
>   25:         34  XIVE-IRQ 1048568 Level     opal-psi#0:lpc_serirq_mux1
> 
> Whereas they previously turn up on lpchc.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_lpc.h |  12 ++++-
>   hw/ppc/pnv.c             |  38 +++++++++++++--
>   hw/ppc/pnv_lpc.c         | 100 +++++++++++++++++++++++++++++++++++----
>   3 files changed, 136 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 5d22c45570..57e324b4dc 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -84,8 +84,18 @@ struct PnvLpcController {
>       /* XSCOM registers */
>       MemoryRegion xscom_regs;
>   
> +    /*
> +     * In P8, ISA irqs are combined with internal sources to drive the
> +     * LPCHC interrupt output. P9 ISA irqs raise one of 4 lines that
> +     * drive PSI SERIRQ irqs, routing according to OPB routing registers.
> +     */
> +    bool psi_serirq;
> +
>       /* PSI to generate interrupts */
> -    qemu_irq psi_irq;
> +    qemu_irq psi_irq_lpchc;
> +
> +    /* P9 introduced a serirq mode */
> +    qemu_irq psi_irq_serirq[4];
>   };
>   
>   struct PnvLpcClass {
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..3b1c05a1d8 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -744,18 +744,48 @@ static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
>   static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
>   {
>       Pnv9Chip *chip9 = PNV9_CHIP(chip);
> -    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPCHC);
>   
> -    qdev_connect_gpio_out(DEVICE(&chip9->lpc), 0, irq);

The pnv_chip_power8*_isa_create() routines also need an update.

> +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "LPCHC", 0,
> +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                PSIHB9_IRQ_LPCHC));
> +
> +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 0,
> +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ0));
> +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 1,
> +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ1));
> +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 2,
> +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ2));
> +    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 3,
> +                                qdev_get_gpio_in(DEVICE(&chip9->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ3));
> +
>       return pnv_lpc_isa_create(&chip9->lpc, false, errp);
>   }
>   
>   static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
>   {
>       Pnv10Chip *chip10 = PNV10_CHIP(chip);
> -    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPCHC);
>   
> -    qdev_connect_gpio_out(DEVICE(&chip10->lpc), 0, irq);
> +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "LPCHC", 0,
> +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                PSIHB9_IRQ_LPCHC));
> +
> +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 0,
> +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ0));
> +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 1,
> +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ1));
> +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 2,
> +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ2));
> +    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 3,
> +                                qdev_get_gpio_in(DEVICE(&chip10->psi),
> +                                PSIHB9_IRQ_LPC_SIRQ3));
> +
>       return pnv_lpc_isa_create(&chip10->lpc, false, errp);
>   }
>   
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d692858bee..e28eae672f 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -64,6 +64,7 @@ enum {
>   #define   LPC_HC_IRQSER_START_4CLK      0x00000000
>   #define   LPC_HC_IRQSER_START_6CLK      0x01000000
>   #define   LPC_HC_IRQSER_START_8CLK      0x02000000
> +#define   LPC_HC_IRQSER_AUTO_CLEAR      0x00800000
>   #define LPC_HC_IRQMASK          0x34    /* same bit defs as LPC_HC_IRQSTAT */
>   #define LPC_HC_IRQSTAT          0x38
>   #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to ... */
> @@ -420,6 +421,34 @@ static const MemoryRegionOps pnv_lpc_mmio_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +/* POWER9 serirq routing, see below */
> +static int irq_to_serirq_route[ISA_NUM_IRQS];

This static is not friendly for multichip machines. Could we avoid it and
move the IRQ routes under PnvLpcController ?



Thanks,

C.


> +
> +/* Program the POWER9 LPC irq to PSI serirq routing */
> +static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
> +{
> +    int irq;
> +
> +    if (!lpc->psi_serirq) {
> +        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
> +            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "OPB: setting serirq routing on POWER8 system, ignoring.\n");
> +        }
> +        return;
> +    }
> +
> +    for (irq = 0; irq <= 13; irq++) {
> +        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
> +        irq_to_serirq_route[irq] = serirq;
> +    }
> +
> +    for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
> +        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
> +        irq_to_serirq_route[irq] = serirq;
> +    }
> +}
> +
>   static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>   {
>       bool lpc_to_opb_irq = false;
> @@ -445,7 +474,33 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>       lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
>   
>       /* Reflect the interrupt */
> -    qemu_set_irq(lpc->psi_irq, lpc->opb_irq_stat != 0);
> +    if (!lpc->psi_serirq) {
> +        /*
> +         * POWER8 ORs all irqs together (also with LPCHC internal interrupt
> +         * sources) and outputs a single line that raises the PSI LPCHC irq.
> +         */
> +        qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
> +    } else {
> +        /*
> +         * POWER9 and POWER10 have routing fields in OPB master registers that
> +         * send LPC irqs to 4 output lines that raise the PSI SERIRQ irqs. The
> +         * LPCHC internal interrupts still go to the PSI LPCHC irq line,
> +         * although no such internal sources are implemented yet.
> +         */
> +        bool serirq_out[4] = { false, false, false, false };
> +        int irq;
> +
> +        for (irq = 0; irq < ISA_NUM_IRQS; irq++) {
> +            if (lpc->lpc_hc_irqstat & (LPC_HC_IRQ_SERIRQ0 >> irq)) {
> +                serirq_out[irq_to_serirq_route[irq]] = true;
> +            }
> +        }
> +
> +        qemu_set_irq(lpc->psi_irq_serirq[0], serirq_out[0]);
> +        qemu_set_irq(lpc->psi_irq_serirq[1], serirq_out[1]);
> +        qemu_set_irq(lpc->psi_irq_serirq[2], serirq_out[2]);
> +        qemu_set_irq(lpc->psi_irq_serirq[3], serirq_out[3]);
> +    }
>   }
>   
>   static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
> @@ -536,10 +591,10 @@ static uint64_t opb_master_read(void *opaque, hwaddr addr, unsigned size)
>       uint64_t val = 0xfffffffffffffffful;
>   
>       switch (addr) {
> -    case OPB_MASTER_LS_ROUTE0: /* TODO */
> +    case OPB_MASTER_LS_ROUTE0:
>           val = lpc->opb_irq_route0;
>           break;
> -    case OPB_MASTER_LS_ROUTE1: /* TODO */
> +    case OPB_MASTER_LS_ROUTE1:
>           val = lpc->opb_irq_route1;
>           break;
>       case OPB_MASTER_LS_IRQ_STAT:
> @@ -568,11 +623,15 @@ static void opb_master_write(void *opaque, hwaddr addr,
>       PnvLpcController *lpc = opaque;
>   
>       switch (addr) {
> -    case OPB_MASTER_LS_ROUTE0: /* TODO */
> +    case OPB_MASTER_LS_ROUTE0:
>           lpc->opb_irq_route0 = val;
> +        pnv_lpc_eval_serirq_routes(lpc);
> +        pnv_lpc_eval_irqs(lpc);
>           break;
> -    case OPB_MASTER_LS_ROUTE1: /* TODO */
> +    case OPB_MASTER_LS_ROUTE1:
>           lpc->opb_irq_route1 = val;
> +        pnv_lpc_eval_serirq_routes(lpc);
> +        pnv_lpc_eval_irqs(lpc);
>           break;
>       case OPB_MASTER_LS_IRQ_STAT:
>           lpc->opb_irq_stat &= ~val;
> @@ -583,6 +642,10 @@ static void opb_master_write(void *opaque, hwaddr addr,
>           pnv_lpc_eval_irqs(lpc);
>           break;
>       case OPB_MASTER_LS_IRQ_POL:
> +        if (val != 0) {
> +            qemu_log_mask(LOG_UNIMP, "OPBM: interrupt polarity register "
> +                                     "unimplemented\n");
> +        }
>           lpc->opb_irq_pol = val;
>           pnv_lpc_eval_irqs(lpc);
>           break;
> @@ -657,6 +720,8 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
>       PnvLpcClass *plc = PNV_LPC_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +    object_property_set_bool(OBJECT(lpc), "psi-serirq", true, &error_abort);
> +
>       plc->parent_realize(dev, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> @@ -666,6 +731,9 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
>       /* P9 uses a MMIO region */
>       memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
>                             lpc, "lpcm", PNV9_LPCM_SIZE);
> +
> +    /* P9 LPC roues ISA irqs to 4 PSI SERIRQ lines */
> +    qdev_init_gpio_out_named(dev, lpc->psi_irq_serirq, "SERIRQ", 4);
>   }
>   
>   static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
> @@ -744,13 +812,19 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>                                   &lpc->lpc_hc_regs);
>   
> -    qdev_init_gpio_out(dev, &lpc->psi_irq, 1);
> +    qdev_init_gpio_out_named(dev, &lpc->psi_irq_lpchc, "LPCHC", 1);
>   }
>   
> +static Property pnv_lpc_properties[] = {
> +    DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_serirq, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> +    device_class_set_props(dc, pnv_lpc_properties);
>       dc->realize = pnv_lpc_realize;
>       dc->desc = "PowerNV LPC Controller";
>       dc->user_creatable = false;
> @@ -796,7 +870,7 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
>       }
>   
>       if (pnv->cpld_irqstate != old_state) {
> -        qemu_set_irq(lpc->psi_irq, pnv->cpld_irqstate != 0);
> +        qemu_set_irq(lpc->psi_irq_lpchc, pnv->cpld_irqstate != 0);
>       }
>   }
>   
> @@ -804,9 +878,16 @@ static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
>   {
>       PnvLpcController *lpc = PNV_LPC(opaque);
>   
> -    /* The Naples HW latches the 1 levels, clearing is done by SW */
> +    /*
> +     * Naples and later hardware latches the 1 levels, clearing is done by SW.
> +     * POWER9 introduced an auto-clear mode so software can avoid clearing.
> +     */
>       if (level) {
> -        lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SERIRQ0 >> n;
> +        lpc->lpc_hc_irqstat |= (LPC_HC_IRQ_SERIRQ0 >> n);
> +        pnv_lpc_eval_irqs(lpc);
> +    } else if (lpc->psi_serirq &&
> +               (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_AUTO_CLEAR)) {
> +        lpc->lpc_hc_irqstat &= ~(LPC_HC_IRQ_SERIRQ0 >> n);
>           pnv_lpc_eval_irqs(lpc);
>       }
>   }
> @@ -838,6 +919,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
>           handler = pnv_lpc_isa_irq_handler;
>       }
>   
> +    /* POWER has a 17th irq, QEMU only implements the 16 regular device irqs */
>       irqs = qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
>   
>       isa_bus_register_input_irqs(isa_bus, irqs);


