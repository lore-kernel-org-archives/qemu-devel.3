Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx4Mx-0000Mp-QN; Wed, 17 Apr 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=26d5=LW=kaod.org=clg@ozlabs.org>)
 id 1rx4Mg-0000ME-Tk; Wed, 17 Apr 2024 08:26:16 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=26d5=LW=kaod.org=clg@ozlabs.org>)
 id 1rx4Mc-0001Df-A1; Wed, 17 Apr 2024 08:26:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VKKrX0Hc0z4wx5;
 Wed, 17 Apr 2024 22:26:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKKrT2bnMz4wxf;
 Wed, 17 Apr 2024 22:26:01 +1000 (AEST)
Message-ID: <f8b689f4-50b0-4f96-bd64-21b9eda6862e@kaod.org>
Date: Wed, 17 Apr 2024 14:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ppc/pnv: Implement ADU access to LPC space
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Saif Abrar <saif.abrar@linux.vnet.ibm.com>
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-3-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240417110215.808926-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=26d5=LW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/17/24 13:02, Nicholas Piggin wrote:
> One of the functions of the ADU is indirect memory access engines that
> send and receive data via ADU registers.
> 
> This implements the ADU LPC memory access functionality sufficiently
> for IBM proprietary firmware to access the UART and print characters
> to the serial port as it does on real hardware.
> 
> This requires a linkage between adu and lpc, which allows adu to
> perform memory access in the lpc space.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_adu.h |  7 ++++
>   include/hw/ppc/pnv_lpc.h |  5 +++
>   hw/ppc/pnv.c             |  4 ++
>   hw/ppc/pnv_adu.c         | 91 ++++++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_lpc.c         | 12 +++---
>   5 files changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> index 9dc91857a9..b7b5d1bb21 100644
> --- a/include/hw/ppc/pnv_adu.h
> +++ b/include/hw/ppc/pnv_adu.h
> @@ -10,6 +10,7 @@
>   #define PPC_PNV_ADU_H
>   
>   #include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_lpc.h"
>   #include "hw/qdev-core.h"
>   
>   #define TYPE_PNV_ADU "pnv-adu"
> @@ -19,6 +20,12 @@ OBJECT_DECLARE_TYPE(PnvADU, PnvADUClass, PNV_ADU)
>   struct PnvADU {
>       DeviceState xd;
>   
> +    /* LPCMC (LPC Master Controller) access engine */
> +    PnvLpcController *lpc;
> +    uint64_t     lpc_base_reg;
> +    uint64_t     lpc_cmd_reg;
> +    uint64_t     lpc_data_reg;

I don't see reset values for these registers. Is that ok ?

>       MemoryRegion xscom_regs;
>   };
>   
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 5d22c45570..016e2998a8 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -94,6 +94,11 @@ struct PnvLpcClass {
>       DeviceRealize parent_realize;
>   };
>   
> +bool pnv_opb_lpc_read(PnvLpcController *lpc, uint32_t addr,
> +                      uint8_t *data, int sz);
> +bool pnv_opb_lpc_write(PnvLpcController *lpc, uint32_t addr,
> +                       uint8_t *data, int sz);

May be rename to pnv_lpc_opb_read/write ?

>   ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp);
>   int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset,
>                  uint64_t lpcm_addr, uint64_t lpcm_size);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5869aac89a..eb9dbc62dd 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1642,6 +1642,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* ADU */
> +    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9->lpc),
> +                             &error_abort);

I would add an assert on the lpc pointer in the ADU realize routine.

Thanks,

C.

>       if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
>           return;
>       }
> @@ -1908,6 +1910,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* ADU */
> +    object_property_set_link(OBJECT(&chip10->adu), "lpc", OBJECT(&chip10->lpc),
> +                             &error_abort);
>       if (!qdev_realize(DEVICE(&chip10->adu), NULL, errp)) {
>           return;
>       }
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> index 5bd33a3841..d5570c23e2 100644
> --- a/hw/ppc/pnv_adu.c
> +++ b/hw/ppc/pnv_adu.c
> @@ -21,9 +21,15 @@
>   #include "hw/ppc/pnv.h"
>   #include "hw/ppc/pnv_adu.h"
>   #include "hw/ppc/pnv_chip.h"
> +#include "hw/ppc/pnv_lpc.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "trace.h"
>   
> +#define ADU_LPC_BASE_REG     0x40
> +#define ADU_LPC_CMD_REG      0x41
> +#define ADU_LPC_DATA_REG     0x42
> +#define ADU_LPC_STATUS_REG   0x43
> +
>   static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
>   {
>       PnvADU *adu = PNV_ADU(opaque);
> @@ -35,6 +41,24 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
>       case 0x12:     /* log register */
>       case 0x13:     /* error register */
>           break;
> +    case ADU_LPC_BASE_REG:
> +        /*
> +         * LPC Address Map in Pervasive ADU Workbook
> +         *
> +         * return PNV10_LPCM_BASE(chip) & PPC_BITMASK(8, 31);
> +         * XXX: implement as class property, or get from LPC?
> +         */
> +        qemu_log_mask(LOG_UNIMP, "ADU: LPC_BASE_REG is not implemented\n");
> +        break;
> +    case ADU_LPC_CMD_REG:
> +        val = adu->lpc_cmd_reg;
> +        break;
> +    case ADU_LPC_DATA_REG:
> +        val = adu->lpc_data_reg;
> +        break;
> +    case ADU_LPC_STATUS_REG:
> +        val = PPC_BIT(0); /* ack / done */
> +        break;
>   
>       default:
>           qemu_log_mask(LOG_UNIMP, "ADU Unimplemented read register: Ox%08x\n",
> @@ -46,6 +70,26 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
>       return val;
>   }
>   
> +static bool lpc_cmd_read(PnvADU *adu)
> +{
> +    return !!(adu->lpc_cmd_reg & PPC_BIT(0));
> +}
> +
> +static bool lpc_cmd_write(PnvADU *adu)
> +{
> +    return !lpc_cmd_read(adu);
> +}
> +
> +static uint32_t lpc_cmd_addr(PnvADU *adu)
> +{
> +    return (adu->lpc_cmd_reg & PPC_BITMASK(32, 63)) >> PPC_BIT_NR(63);
> +}
> +
> +static uint32_t lpc_cmd_size(PnvADU *adu)
> +{
> +    return (adu->lpc_cmd_reg & PPC_BITMASK(5, 11)) >> PPC_BIT_NR(11);
> +}
> +
>   static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>                                   unsigned width)
>   {
> @@ -60,6 +104,47 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>       case 0x13:     /* error register */
>           break;
>   
> +    case ADU_LPC_BASE_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "ADU: Changing LPC_BASE_REG is not implemented\n");
> +        break;
> +
> +    case ADU_LPC_CMD_REG:
> +        adu->lpc_cmd_reg = val;
> +        if (lpc_cmd_read(adu)) {
> +            uint32_t lpc_addr = lpc_cmd_addr(adu);
> +            uint32_t lpc_size = lpc_cmd_size(adu);
> +            uint64_t data = 0;
> +
> +            pnv_opb_lpc_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);
> +
> +            /*
> +             * ADU access is performed within 8-byte aligned sectors. Smaller
> +             * access sizes don't get formatted to the least significant byte,
> +             * but rather appear in the data reg at the same offset as the
> +             * address in memory. This shifts them into that position.
> +             */
> +            adu->lpc_data_reg = be64_to_cpu(data) >> ((lpc_addr & 7) * 8);
> +        }
> +        break;
> +
> +    case ADU_LPC_DATA_REG:
> +        adu->lpc_data_reg = val;
> +        if (lpc_cmd_write(adu)) {
> +            uint32_t lpc_addr = lpc_cmd_addr(adu);
> +            uint32_t lpc_size = lpc_cmd_size(adu);
> +            uint64_t data;
> +
> +            data = cpu_to_be64(val) >> ((lpc_addr & 7) * 8); /* See above */
> +            pnv_opb_lpc_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
> +        }
> +        break;
> +
> +    case ADU_LPC_STATUS_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "ADU: Changing LPC_STATUS_REG is not implemented\n");
> +        break;
> +
>       default:
>           qemu_log_mask(LOG_UNIMP, "ADU Unimplemented write register: Ox%08x\n",
>                                                                        offset);
> @@ -86,12 +171,18 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
>                             PNV9_XSCOM_ADU_SIZE);
>   }
>   
> +static Property pnv_adu_properties[] = {
> +    DEFINE_PROP_LINK("lpc", PnvADU, lpc, TYPE_PNV_LPC, PnvLpcController *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void pnv_adu_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->realize = pnv_adu_realize;
>       dc->desc = "PowerNV ADU";
> +    device_class_set_props(dc, pnv_adu_properties);
>       dc->user_creatable = false;
>   }
>   
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d692858bee..743bd66fc0 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -235,16 +235,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
>    * TODO: rework to use address_space_stq() and address_space_ldq()
>    * instead.
>    */
> -static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
> -                     int sz)
> +bool pnv_opb_lpc_read(PnvLpcController *lpc, uint32_t addr,
> +                      uint8_t *data, int sz)
>   {
>       /* XXX Handle access size limits and FW read caching here */
>       return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
>                                  data, sz);
>   }
>   
> -static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
> -                      int sz)
> +bool pnv_opb_lpc_write(PnvLpcController *lpc, uint32_t addr,
> +                       uint8_t *data, int sz)
>   {
>       /* XXX Handle access size limits here */
>       return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> @@ -276,7 +276,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>       }
>   
>       if (cmd & ECCB_CTL_READ) {
> -        success = opb_read(lpc, opb_addr, data, sz);
> +        success = pnv_opb_lpc_read(lpc, opb_addr, data, sz);
>           if (success) {
>               lpc->eccb_stat_reg = ECCB_STAT_OP_DONE |
>                       (((uint64_t)data[0]) << 24 |
> @@ -293,7 +293,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>           data[2] = lpc->eccb_data_reg >>  8;
>           data[3] = lpc->eccb_data_reg;
>   
> -        success = opb_write(lpc, opb_addr, data, sz);
> +        success = pnv_opb_lpc_write(lpc, opb_addr, data, sz);
>           lpc->eccb_stat_reg = ECCB_STAT_OP_DONE;
>       }
>       /* XXX Which error bit (if any) to signal OPB error ? */


