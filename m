Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E11C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENQ0-0000yJ-Pm; Tue, 04 Jun 2024 02:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sENPq-0000ua-TT; Tue, 04 Jun 2024 02:13:03 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sENPo-0002jX-A6; Tue, 04 Jun 2024 02:13:02 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VtgHq0hG8z4x2s;
 Tue,  4 Jun 2024 16:12:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VtgHk2km4z4x2g;
 Tue,  4 Jun 2024 16:12:50 +1000 (AEST)
Message-ID: <f2059eb2-7102-492a-a844-2bcb7067a1aa@kaod.org>
Date: Tue, 4 Jun 2024 08:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/17] aspeed/smc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-11-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240604054438.3424349-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OW7X=NG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 07:44, Jamin Lin wrote:
> AST2700 fmc/spi controller's address decoding unit is 64KB
> and only bits [31:16] are used for decoding. Introduce seg_to_reg
> and reg_to_seg handlers for ast2700 fmc/spi controller.
> In addition, adds ast2700 fmc, spi0, spi1, and spi2 class init handler.
> 
> AST2700 is a 64 bits quad core CPUs(Cortex-a35). Introduce a new
> "aspeed_2700_smc_flash_ops" and set its valid "max_access_size"
> 8 for 64 bits data format access.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ssi/aspeed_smc.c | 234 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 233 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 129d06690d..49205ab76d 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -185,7 +185,7 @@
>    *   0: 4 bytes
>    *   0x1FFFFFC: 32M bytes
>    *
> - * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
> + * DMA length is from 1 byte to 32MB (AST2600, AST10x0 and AST2700)
>    *   0: 1 byte
>    *   0x1FFFFFF: 32M bytes
>    */
> @@ -1938,6 +1938,234 @@ static const TypeInfo aspeed_1030_spi2_info = {
>       .class_init = aspeed_1030_spi2_class_init,
>   };
>   
> +/*
> + * The FMC Segment Registers of the AST2700 have a 64KB unit.
> + * Only bits [31:16] are used for decoding.
> + */
> +#define AST2700_SEG_ADDR_MASK 0xffff0000
> +
> +static uint32_t aspeed_2700_smc_segment_to_reg(const AspeedSMCState *s,
> +                                               const AspeedSegments *seg)
> +{
> +    uint32_t reg = 0;
> +
> +    /* Disabled segments have a nil register */
> +    if (!seg->size) {
> +        return 0;
> +    }
> +
> +    reg |= (seg->addr & AST2700_SEG_ADDR_MASK) >> 16; /* start offset */
> +    reg |= (seg->addr + seg->size - 1) & AST2700_SEG_ADDR_MASK; /* end offset */
> +    return reg;
> +}
> +
> +static void aspeed_2700_smc_reg_to_segment(const AspeedSMCState *s,
> +                                           uint32_t reg, AspeedSegments *seg)
> +{
> +    uint32_t start_offset = (reg << 16) & AST2700_SEG_ADDR_MASK;
> +    uint32_t end_offset = reg & AST2700_SEG_ADDR_MASK;
> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> +
> +    if (reg) {
> +        seg->addr = asc->flash_window_base + start_offset;
> +        seg->size = end_offset + (64 * KiB) - start_offset;
> +    } else {
> +        seg->addr = asc->flash_window_base;
> +        seg->size = 0;
> +    }
> +}
> +
> +static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
> +    [R_CONF] = (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |
> +            CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),
> +    [R_CE_CTRL] = 0x0000aa00,
> +    [R_CTRL0] = 0x406b0641,
> +    [R_CTRL1] = 0x00000400,
> +    [R_CTRL2] = 0x00000400,
> +    [R_CTRL3] = 0x00000400,
> +    [R_SEG_ADDR0] = 0x08000000,
> +    [R_SEG_ADDR1] = 0x10000800,
> +    [R_SEG_ADDR2] = 0x00000000,
> +    [R_SEG_ADDR3] = 0x00000000,
> +    [R_DUMMY_DATA] = 0x00010000,
> +    [R_DMA_DRAM_ADDR_HIGH] = 0x00000000,
> +    [R_TIMINGS] = 0x007b0000,
> +};
> +
> +static const MemoryRegionOps aspeed_2700_smc_flash_ops = {
> +    .read = aspeed_smc_flash_read,
> +    .write = aspeed_smc_flash_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static const AspeedSegments aspeed_2700_fmc_segments[] = {
> +    { 0x0, 128 * MiB }, /* start address is readonly */
> +    { 128 * MiB, 128 * MiB }, /* default is disabled but needed for -kernel */
> +    { 256 * MiB, 128 * MiB }, /* default is disabled but needed for -kernel */
> +    { 0x0, 0 }, /* disabled */
> +};
> +
> +static void aspeed_2700_fmc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
> +
> +    dc->desc               = "Aspeed 2700 FMC Controller";
> +    asc->r_conf            = R_CONF;
> +    asc->r_ce_ctrl         = R_CE_CTRL;
> +    asc->r_ctrl0           = R_CTRL0;
> +    asc->r_timings         = R_TIMINGS;
> +    asc->nregs_timings     = 3;
> +    asc->conf_enable_w0    = CONF_ENABLE_W0;
> +    asc->cs_num_max        = 3;
> +    asc->segments          = aspeed_2700_fmc_segments;
> +    asc->segment_addr_mask = 0xffffffff;
> +    asc->resets            = aspeed_2700_fmc_resets;
> +    asc->flash_window_base = 0x100000000;
> +    asc->flash_window_size = 1 * GiB;
> +    asc->features          = ASPEED_SMC_FEATURE_DMA |
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +    asc->dma_flash_mask    = 0x2FFFFFFC;
> +    asc->dma_dram_mask     = 0xFFFFFFFC;
> +    asc->dma_start_length  = 1;
> +    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
> +    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
> +    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> +}
> +
> +static const TypeInfo aspeed_2700_fmc_info = {
> +    .name =  "aspeed.fmc-ast2700",
> +    .parent = TYPE_ASPEED_SMC,
> +    .class_init = aspeed_2700_fmc_class_init,
> +};
> +
> +static const AspeedSegments aspeed_2700_spi0_segments[] = {
> +    { 0x0, 128 * MiB }, /* start address is readonly */
> +    { 128 * MiB, 128 * MiB }, /* start address is readonly */
> +    { 0x0, 0 }, /* disabled */
> +};
> +
> +static void aspeed_2700_spi0_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
> +
> +    dc->desc               = "Aspeed 2700 SPI0 Controller";
> +    asc->r_conf            = R_CONF;
> +    asc->r_ce_ctrl         = R_CE_CTRL;
> +    asc->r_ctrl0           = R_CTRL0;
> +    asc->r_timings         = R_TIMINGS;
> +    asc->nregs_timings     = 2;
> +    asc->conf_enable_w0    = CONF_ENABLE_W0;
> +    asc->cs_num_max        = 2;
> +    asc->segments          = aspeed_2700_spi0_segments;
> +    asc->segment_addr_mask = 0xffffffff;
> +    asc->flash_window_base = 0x180000000;
> +    asc->flash_window_size = 1 * GiB;
> +    asc->features          = ASPEED_SMC_FEATURE_DMA |
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +    asc->dma_flash_mask    = 0x2FFFFFFC;
> +    asc->dma_dram_mask     = 0xFFFFFFFC;
> +    asc->dma_start_length  = 1;
> +    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
> +    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
> +    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> +}
> +
> +static const TypeInfo aspeed_2700_spi0_info = {
> +    .name =  "aspeed.spi0-ast2700",
> +    .parent = TYPE_ASPEED_SMC,
> +    .class_init = aspeed_2700_spi0_class_init,
> +};
> +
> +static const AspeedSegments aspeed_2700_spi1_segments[] = {
> +    { 0x0, 128 * MiB }, /* start address is readonly */
> +    { 0x0, 0 }, /* disabled */
> +};
> +
> +static void aspeed_2700_spi1_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
> +
> +    dc->desc               = "Aspeed 2700 SPI1 Controller";
> +    asc->r_conf            = R_CONF;
> +    asc->r_ce_ctrl         = R_CE_CTRL;
> +    asc->r_ctrl0           = R_CTRL0;
> +    asc->r_timings         = R_TIMINGS;
> +    asc->nregs_timings     = 2;
> +    asc->conf_enable_w0    = CONF_ENABLE_W0;
> +    asc->cs_num_max        = 2;
> +    asc->segments          = aspeed_2700_spi1_segments;
> +    asc->segment_addr_mask = 0xffffffff;
> +    asc->flash_window_base = 0x200000000;
> +    asc->flash_window_size = 1 * GiB;
> +    asc->features          = ASPEED_SMC_FEATURE_DMA |
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +    asc->dma_flash_mask    = 0x2FFFFFFC;
> +    asc->dma_dram_mask     = 0xFFFFFFFC;
> +    asc->dma_start_length  = 1;
> +    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
> +    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
> +    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> +}
> +
> +static const TypeInfo aspeed_2700_spi1_info = {
> +        .name =  "aspeed.spi1-ast2700",
> +        .parent = TYPE_ASPEED_SMC,
> +        .class_init = aspeed_2700_spi1_class_init,
> +};
> +
> +static const AspeedSegments aspeed_2700_spi2_segments[] = {
> +    { 0x0, 128 * MiB }, /* start address is readonly */
> +    { 0x0, 0 }, /* disabled */
> +};
> +
> +static void aspeed_2700_spi2_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSMCClass *asc = ASPEED_SMC_CLASS(klass);
> +
> +    dc->desc               = "Aspeed 2700 SPI2 Controller";
> +    asc->r_conf            = R_CONF;
> +    asc->r_ce_ctrl         = R_CE_CTRL;
> +    asc->r_ctrl0           = R_CTRL0;
> +    asc->r_timings         = R_TIMINGS;
> +    asc->nregs_timings     = 2;
> +    asc->conf_enable_w0    = CONF_ENABLE_W0;
> +    asc->cs_num_max        = 2;
> +    asc->segments          = aspeed_2700_spi2_segments;
> +    asc->segment_addr_mask = 0xffffffff;
> +    asc->flash_window_base = 0x280000000;
> +    asc->flash_window_size = 1 * GiB;
> +    asc->features          = ASPEED_SMC_FEATURE_DMA |
> +                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;
> +    asc->dma_flash_mask    = 0x0FFFFFFC;
> +    asc->dma_dram_mask     = 0xFFFFFFFC;
> +    asc->dma_start_length  = 1;
> +    asc->nregs             = ASPEED_SMC_R_MAX;
> +    asc->segment_to_reg    = aspeed_2700_smc_segment_to_reg;
> +    asc->reg_to_segment    = aspeed_2700_smc_reg_to_segment;
> +    asc->dma_ctrl          = aspeed_2600_smc_dma_ctrl;
> +    asc->reg_ops           = &aspeed_2700_smc_flash_ops;
> +}
> +
> +static const TypeInfo aspeed_2700_spi2_info = {
> +        .name =  "aspeed.spi2-ast2700",
> +        .parent = TYPE_ASPEED_SMC,
> +        .class_init = aspeed_2700_spi2_class_init,
> +};
> +
>   static void aspeed_smc_register_types(void)
>   {
>       type_register_static(&aspeed_smc_flash_info);
> @@ -1954,6 +2182,10 @@ static void aspeed_smc_register_types(void)
>       type_register_static(&aspeed_1030_fmc_info);
>       type_register_static(&aspeed_1030_spi1_info);
>       type_register_static(&aspeed_1030_spi2_info);
> +    type_register_static(&aspeed_2700_fmc_info);
> +    type_register_static(&aspeed_2700_spi0_info);
> +    type_register_static(&aspeed_2700_spi1_info);
> +    type_register_static(&aspeed_2700_spi2_info);
>   }
>   
>   type_init(aspeed_smc_register_types)


