Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D7AC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNYQ-0006At-DI; Mon, 29 Jul 2024 06:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYNYM-00069s-PM; Mon, 29 Jul 2024 06:24:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYNYJ-00027K-9C; Mon, 29 Jul 2024 06:24:29 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WXZGX4xyrz4x7G;
 Mon, 29 Jul 2024 20:24:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WXZGW3nPzz4x1V;
 Mon, 29 Jul 2024 20:24:19 +1000 (AEST)
Message-ID: <996fc202-e6ba-4241-90ed-29f90bd9a05d@kaod.org>
Date: Mon, 29 Jul 2024 12:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/96] ppc/pnv: Implement ADU access to LPC space
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-18-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240725235410.451624-18-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=joD8=O5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/26/24 01:52, Nicholas Piggin wrote:
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
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv.c             |  4 ++
>   hw/ppc/pnv_adu.c         | 95 ++++++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_lpc.c         | 12 ++---
>   include/hw/ppc/pnv_adu.h |  7 +++
>   include/hw/ppc/pnv_lpc.h |  5 +++
>   5 files changed, 117 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 689197cbb7..91ff1be21f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1663,6 +1663,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* ADU */
> +    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9->lpc),
> +                             &error_abort);
>       if (!qdev_realize(DEVICE(&chip9->adu), NULL, errp)) {
>           return;
>       }
> @@ -1929,6 +1931,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* ADU */
> +    object_property_set_link(OBJECT(&chip10->adu), "lpc", OBJECT(&chip10->lpc),
> +                             &error_abort);
>       if (!qdev_realize(DEVICE(&chip10->adu), NULL, errp)) {
>           return;
>       }
> diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
> index 8279bc8b26..81b7d6e526 100644
> --- a/hw/ppc/pnv_adu.c
> +++ b/hw/ppc/pnv_adu.c
> @@ -21,11 +21,18 @@
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
> +    PnvADU *adu = PNV_ADU(opaque);
>       uint32_t offset = addr >> 3;
>       uint64_t val = 0;
>   
> @@ -34,6 +41,24 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
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
> @@ -45,9 +70,30 @@ static uint64_t pnv_adu_xscom_read(void *opaque, hwaddr addr, unsigned width)
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
> +    PnvADU *adu = PNV_ADU(opaque);
>       uint32_t offset = addr >> 3;
>   
>       trace_pnv_adu_xscom_write(addr, val);
> @@ -58,6 +104,47 @@ static void pnv_adu_xscom_write(void *opaque, hwaddr addr, uint64_t val,
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
> +            pnv_lpc_opb_read(adu->lpc, lpc_addr, (void *)&data, lpc_size);


Coverity reports an issue :

>>>     CID 1558830:    (OVERRUN)
>>>     Overrunning buffer pointed to by "(void *)&data" of 8 bytes by passing it to a function which accesses it at byte offset 126 using argument "lpc_size" (which evaluates to 127).


I think we should change the type of variable 'data' to allow reading
a maximum of 128 bytes to cover all possible LPC access. Also, possible
sizes should be limited to power of 2.

Thanks,

C.




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
> +            pnv_lpc_opb_write(adu->lpc, lpc_addr, (void *)&data, lpc_size);
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
> @@ -78,18 +165,26 @@ static void pnv_adu_realize(DeviceState *dev, Error **errp)
>   {
>       PnvADU *adu = PNV_ADU(dev);
>   
> +    assert(adu->lpc);
> +
>       /* XScom regions for ADU registers */
>       pnv_xscom_region_init(&adu->xscom_regs, OBJECT(dev),
>                             &pnv_adu_xscom_ops, adu, "xscom-adu",
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
> index 0f14e180af..f8aad955b5 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -236,16 +236,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset, uint64_t lpcm_addr,
>    * TODO: rework to use address_space_stq() and address_space_ldq()
>    * instead.
>    */
> -static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
> -                     int sz)
> +bool pnv_lpc_opb_read(PnvLpcController *lpc, uint32_t addr,
> +                      uint8_t *data, int sz)
>   {
>       /* XXX Handle access size limits and FW read caching here */
>       return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
>                                  data, sz);
>   }
>   
> -static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
> -                      int sz)
> +bool pnv_lpc_opb_write(PnvLpcController *lpc, uint32_t addr,
> +                       uint8_t *data, int sz)
>   {
>       /* XXX Handle access size limits here */
>       return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> @@ -277,7 +277,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>       }
>   
>       if (cmd & ECCB_CTL_READ) {
> -        success = opb_read(lpc, opb_addr, data, sz);
> +        success = pnv_lpc_opb_read(lpc, opb_addr, data, sz);
>           if (success) {
>               lpc->eccb_stat_reg = ECCB_STAT_OP_DONE |
>                       (((uint64_t)data[0]) << 24 |
> @@ -294,7 +294,7 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
>           data[2] = lpc->eccb_data_reg >>  8;
>           data[3] = lpc->eccb_data_reg;
>   
> -        success = opb_write(lpc, opb_addr, data, sz);
> +        success = pnv_lpc_opb_write(lpc, opb_addr, data, sz);
>           lpc->eccb_stat_reg = ECCB_STAT_OP_DONE;
>       }
>       /* XXX Which error bit (if any) to signal OPB error ? */
> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> index b5f308627b..f9dbd8c8b3 100644
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
> +
>       MemoryRegion xscom_regs;
>   };
>   
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index e0fd5e4130..174add4c53 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -109,6 +109,11 @@ struct PnvLpcClass {
>       DeviceRealize parent_realize;
>   };
>   
> +bool pnv_lpc_opb_read(PnvLpcController *lpc, uint32_t addr,
> +                      uint8_t *data, int sz);
> +bool pnv_lpc_opb_write(PnvLpcController *lpc, uint32_t addr,
> +                       uint8_t *data, int sz);
> +
>   ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp);
>   int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset,
>                  uint64_t lpcm_addr, uint64_t lpcm_size);


