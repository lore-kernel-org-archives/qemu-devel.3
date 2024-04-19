Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1442C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 13:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxoVD-0008Vs-MK; Fri, 19 Apr 2024 09:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0ju7=LY=kaod.org=clg@ozlabs.org>)
 id 1rxoVB-0008Uz-Oe; Fri, 19 Apr 2024 09:42:05 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0ju7=LY=kaod.org=clg@ozlabs.org>)
 id 1rxoV8-00086W-V3; Fri, 19 Apr 2024 09:42:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VLbR75pdZz4x1y;
 Fri, 19 Apr 2024 23:41:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLbR241Hnz4wyY;
 Fri, 19 Apr 2024 23:41:49 +1000 (AEST)
Message-ID: <90a930b9-ec7f-47fc-bfc9-f4ac0958ef83@kaod.org>
Date: Fri, 19 Apr 2024 15:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data length
 issue
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
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416091904.935283-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=0ju7=LY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 4/16/24 11:18, Jamin Lin wrote:
> DMA length is from 1 byte to 32MB for AST2600 and AST10x0
> and DMA length is from 4 bytes to 32MB for AST2500.
> 
> In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
> data for AST2600 and AST10x0 and 4 bytes data for AST2500.
>> To support all ASPEED SOCs, adds dma_start_length parameter to store
> the start length, add helper routines function to compute the dma length
> and update DMA_LENGTH mask to "1FFFFFF" to fix dma moving
> incorrect data length issue.

OK. There are two problems to address, the "zero" length transfer and
the DMA length unit, which is missing today. Newer SoC use a 1 bit / byte
and older ones, AST2400 and AST2500, use 1 bit / 4 bytes.

We can introduce a AspeedSMCClass::dma_len_unit and rework the loop to :

     do {

       ....

        if (s->regs[R_DMA_LEN]) {
             s->regs[R_DMA_LEN] -= 4 / asc->dma_len_unit;
         }
     } while (s->regs[R_DMA_LEN]);

It should fix the current implementation.

I don't think this is necessary to add a Fixes tag because the problem
has been there for ages and no one reported it. Probably because the
only place DMA transfers are used is in U-Boot and transfers have a
non-zero length.

> Currently, only supports dma length 4 bytes aligned.

this looks like a third topic. So the minimum value R_DMA_LEN should
have on the AST2600 SoC and above is '3'. I would opt to replace the
DMA_LENGTH macro with a dma_length_sanitize() helper to fix the software
input of R_DMA_LEN.


Thanks,

C.


  
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/ssi/aspeed_smc.c         | 52 ++++++++++++++++++++++++++++++++-----
>   include/hw/ssi/aspeed_smc.h |  1 +
>   2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 8a8d77b480..71abc7a2d8 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -178,13 +178,17 @@
>    * DMA flash addresses should be 4 bytes aligned and the valid address
>    * range is 0x20000000 - 0x2FFFFFFF.
>    *
> - * DMA length is from 4 bytes to 32MB
> + * DMA length is from 4 bytes to 32MB (AST2500)
>    *   0: 4 bytes
>    *   0x7FFFFF: 32M bytes
> + *
> + * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
> + *   0: 1 byte
> + *   0x1FFFFFF: 32M bytes
>    */
>   #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
>   #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
> -#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
> +#define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
>   
>   /* Flash opcodes. */
>   #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
> @@ -843,6 +847,24 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>       }
>   }
>   
> +static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
> +{
> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> +    uint32_t dma_len;
> +    uint32_t extra;
> +
> +    dma_len = s->regs[R_DMA_LEN] + asc->dma_start_length;
> +
> +    /* dma length 4 bytes aligned */
> +    extra = dma_len % 4;
> +
> +    if (extra != 0) {
> +        dma_len += 4 - extra;
> +    }
> +
> +    return dma_len;
> +}
> +
>   /*
>    * Accumulate the result of the reads to provide a checksum that will
>    * be used to validate the read timing settings.
> @@ -850,6 +872,7 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>   static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>   {
>       MemTxResult result;
> +    uint32_t dma_len;
>       uint32_t data;
>   
>       if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> @@ -861,7 +884,9 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>           aspeed_smc_dma_calibration(s);
>       }
>   
> -    while (s->regs[R_DMA_LEN]) {
> +    dma_len = aspeed_smc_dma_len(s);
> +
> +    while (dma_len) {
>           data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
>                                       MEMTXATTRS_UNSPECIFIED, &result);
>           if (result != MEMTX_OK) {
> @@ -877,7 +902,8 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>            */
>           s->regs[R_DMA_CHECKSUM] += data;
>           s->regs[R_DMA_FLASH_ADDR] += 4;
> -        s->regs[R_DMA_LEN] -= 4;
> +        dma_len -= 4;
> +        s->regs[R_DMA_LEN] = dma_len;
>       }
>   
>       if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
> @@ -889,14 +915,17 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>   static void aspeed_smc_dma_rw(AspeedSMCState *s)
>   {
>       MemTxResult result;
> +    uint32_t dma_len;
>       uint32_t data;
>   
> +    dma_len = aspeed_smc_dma_len(s);
> +
>       trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
>                               "write" : "read",
>                               s->regs[R_DMA_FLASH_ADDR],
>                               s->regs[R_DMA_DRAM_ADDR],
> -                            s->regs[R_DMA_LEN]);
> -    while (s->regs[R_DMA_LEN]) {
> +                            dma_len);
> +    while (dma_len) {
>           if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>               data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
>                                           MEMTXATTRS_UNSPECIFIED, &result);
> @@ -937,7 +966,8 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
>            */
>           s->regs[R_DMA_FLASH_ADDR] += 4;
>           s->regs[R_DMA_DRAM_ADDR] += 4;
> -        s->regs[R_DMA_LEN] -= 4;
> +        dma_len -= 4;
> +        s->regs[R_DMA_LEN] = dma_len;
>           s->regs[R_DMA_CHECKSUM] += data;
>       }
>   }
> @@ -1381,6 +1411,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x1FFFFFFC;
> +    asc->dma_start_length  = 4;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_smc_reg_to_segment;
> @@ -1464,6 +1495,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 4;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_smc_reg_to_segment;
> @@ -1620,6 +1652,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_WDT_CONTROL;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1658,6 +1691,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_DMA_GRANT;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1697,6 +1731,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_DMA_GRANT;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1778,6 +1813,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
> @@ -1815,6 +1851,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1851,6 +1888,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 8e1dda556b..f359ed22cc 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -106,6 +106,7 @@ struct AspeedSMCClass {
>       uint32_t features;
>       hwaddr dma_flash_mask;
>       hwaddr dma_dram_mask;
> +    uint32_t dma_start_length;
>       uint32_t nregs;
>       uint32_t (*segment_to_reg)(const AspeedSMCState *s,
>                                  const AspeedSegments *seg);


