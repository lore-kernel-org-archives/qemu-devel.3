Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAOV-0000vH-JN; Mon, 04 Mar 2024 10:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAOS-0000tx-AZ; Mon, 04 Mar 2024 10:38:20 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAOP-00007o-5y; Mon, 04 Mar 2024 10:38:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpNBW3tKzz4wnq;
 Tue,  5 Mar 2024 02:38:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpNBS2V60z4wcF;
 Tue,  5 Mar 2024 02:37:48 +1100 (AEDT)
Message-ID: <c73539b2-179c-4eb2-87d0-8d06af144715@kaod.org>
Date: Mon, 4 Mar 2024 16:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] aspeed/scu: Add AST2700 support
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240304092934.1953198-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=daq9=KK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 3/4/24 10:29, Jamin Lin wrote:
> AST2700 have two SCU controllers which are SCU and SCUIO.
> Both SCU and SCUIO registers are not compatible previous SOCs
> , introduces new registers and adds ast2700 scu, sucio class init handler.
> 
> The pclk divider selection of SCUIO is defined in SCUIO280[20:18] and
> the pclk divider selection of SCU is defined in SCU280[25:23].
> Both of them are not compatible AST2600 SOCs, adds a get_apb_freq function
> and trace-event for AST2700 SCU and SCUIO.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/misc/aspeed_scu.c         | 306 ++++++++++++++++++++++++++++++++++-
>   hw/misc/trace-events         |   4 +
>   include/hw/misc/aspeed_scu.h |  47 +++++-
>   3 files changed, 351 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 1ac04b6cb0..eb38ea8e19 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -134,6 +134,48 @@
>   
>   #define AST2600_CLK TO_REG(0x40)
>   
> +#define AST2700_SILICON_REV       TO_REG(0x00)
> +#define AST2700_HW_STRAP1         TO_REG(0x10)
> +#define AST2700_HW_STRAP1_CLR     TO_REG(0x14)
> +#define AST2700_HW_STRAP1_LOCK    TO_REG(0x20)
> +#define AST2700_HW_STRAP1_SEC1    TO_REG(0x24)
> +#define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)
> +#define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)
> +
> +#define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
> +#define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
> +#define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)
> +#define AST2700_SCU_DPLL_PARAM      TO_REG(0x308)
> +#define AST2700_SCU_DPLL_EXT_PARAM  TO_REG(0x30c)
> +#define AST2700_SCU_MPLL_PARAM      TO_REG(0x310)
> +#define AST2700_SCU_MPLL_EXT_PARAM  TO_REG(0x314)
> +#define AST2700_SCU_D1CLK_PARAM     TO_REG(0x320)
> +#define AST2700_SCU_D2CLK_PARAM     TO_REG(0x330)
> +#define AST2700_SCU_CRT1CLK_PARAM   TO_REG(0x340)
> +#define AST2700_SCU_CRT2CLK_PARAM   TO_REG(0x350)
> +#define AST2700_SCU_MPHYCLK_PARAM   TO_REG(0x360)
> +#define AST2700_SCU_FREQ_CNTR       TO_REG(0x3b0)
> +#define AST2700_SCU_CPU_SCRATCH_0   TO_REG(0x780)
> +#define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)
> +
> +#define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)
> +#define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)
> +#define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)
> +#define AST2700_SCUIO_CLK_STOP_CLR_2    TO_REG(0x264)
> +#define AST2700_SCUIO_CLK_SEL_1         TO_REG(0x280)
> +#define AST2700_SCUIO_CLK_SEL_2         TO_REG(0x284)
> +#define AST2700_SCUIO_HPLL_PARAM        TO_REG(0x300)
> +#define AST2700_SCUIO_HPLL_EXT_PARAM    TO_REG(0x304)
> +#define AST2700_SCUIO_APLL_PARAM        TO_REG(0x310)
> +#define AST2700_SCUIO_APLL_EXT_PARAM    TO_REG(0x314)
> +#define AST2700_SCUIO_DPLL_PARAM        TO_REG(0x320)
> +#define AST2700_SCUIO_DPLL_EXT_PARAM    TO_REG(0x324)
> +#define AST2700_SCUIO_DPLL_PARAM_READ   TO_REG(0x328)
> +#define AST2700_SCUIO_DPLL_EXT_PARAM_READ TO_REG(0x32c)
> +#define AST2700_SCUIO_UARTCLK_GEN       TO_REG(0x330)
> +#define AST2700_SCUIO_HUARTCLK_GEN      TO_REG(0x334)
> +#define AST2700_SCUIO_CLK_DUTY_MEAS_RST TO_REG(0x388)
> +
>   #define SCU_IO_REGION_SIZE 0x1000
>   
>   static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] = {
> @@ -244,6 +286,25 @@ static uint32_t aspeed_1030_scu_get_apb_freq(AspeedSCUState *s)
>           / asc->apb_divider;
>   }
>   
> +static uint32_t aspeed_2700_scu_get_apb_freq(AspeedSCUState *s)
> +{
> +    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(s);
> +    uint32_t hpll = asc->calc_hpll(s, s->regs[AST2700_SCU_HPLL_PARAM]);
> +
> +    return hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[AST2700_SCU_CLK_SEL_1]) + 1)
> +           / asc->apb_divider;
> +}
> +
> +static uint32_t aspeed_2700_scuio_get_apb_freq(AspeedSCUState *s)
> +{
> +    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(s);
> +    uint32_t hpll = asc->calc_hpll(s, s->regs[AST2700_SCUIO_HPLL_PARAM]);
> +
> +    return hpll /
> +        (SCUIO_AST2700_CLK_GET_PCLK_DIV(s->regs[AST2700_SCUIO_CLK_SEL_1]) + 1)
> +        / asc->apb_divider;
> +}
> +
>   static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       AspeedSCUState *s = ASPEED_SCU(opaque);
> @@ -258,7 +319,8 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
>   
>       switch (reg) {
>       case RNG_DATA:
> -        /* On hardware, RNG_DATA works regardless of
> +        /*
> +         * On hardware, RNG_DATA works regardless of
>            * the state of the enable bit in RNG_CTRL
>            */
>           s->regs[RNG_DATA] = aspeed_scu_get_random();
> @@ -494,6 +556,9 @@ static uint32_t aspeed_silicon_revs[] = {
>       AST2600_A3_SILICON_REV,
>       AST1030_A0_SILICON_REV,
>       AST1030_A1_SILICON_REV,
> +    AST2700_A0_SILICON_REV,
> +    AST2720_A0_SILICON_REV,
> +    AST2750_A0_SILICON_REV,
>   };
>   
>   bool is_supported_silicon_rev(uint32_t silicon_rev)
> @@ -783,6 +848,243 @@ static const TypeInfo aspeed_2600_scu_info = {
>       .class_init = aspeed_2600_scu_class_init,
>   };
>   
> +static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
> +                                        unsigned size)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(opaque);
> +    int reg = TO_REG(offset);
> +
> +    if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                __func__, offset);
> +        return 0;
> +    }
> +
> +    switch (reg) {
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +    }
> +
> +    trace_aspeed_ast2700_scu_read(offset, size, s->regs[reg]);
> +    return s->regs[reg];
> +}
> +
> +static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
> +                                     uint64_t data64, unsigned size)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(opaque);
> +    int reg = TO_REG(offset);
> +    /* Truncate here so bitwise operations below behave as expected */
> +    uint32_t data = data64;
> +
> +    if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                __func__, offset);
> +        return;
> +    }
> +
> +    trace_aspeed_ast2700_scu_write(offset, size, data);
> +
> +    switch (reg) {
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unhandeled write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        break;
> +    }
> +
> +    s->regs[reg] = data;
> +}
> +
> +static const MemoryRegionOps aspeed_ast2700_scu_ops = {
> +    .read = aspeed_ast2700_scu_read,
> +    .write = aspeed_ast2700_scu_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 8,
> +    .valid.unaligned = false,
> +};
> +
> +static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
> +    [AST2700_SILICON_REV]           = AST2700_A0_SILICON_REV,
> +    [AST2700_HW_STRAP1]             = 0x00000800,
> +    [AST2700_HW_STRAP1_CLR]         = 0xFFF0FFF0,
> +    [AST2700_HW_STRAP1_LOCK]        = 0x00000FFF,
> +    [AST2700_HW_STRAP1_SEC1]        = 0x000000FF,
> +    [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
> +    [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
> +    [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
> +    [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
> +    [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
> +    [AST2700_SCU_DPLL_EXT_PARAM]    = 0x8000004f,
> +    [AST2700_SCU_MPLL_PARAM]        = 0x00000040,
> +    [AST2700_SCU_MPLL_EXT_PARAM]    = 0x80000000,
> +    [AST2700_SCU_D1CLK_PARAM]       = 0x00050002,
> +    [AST2700_SCU_D2CLK_PARAM]       = 0x00050002,
> +    [AST2700_SCU_CRT1CLK_PARAM]     = 0x00050002,
> +    [AST2700_SCU_CRT2CLK_PARAM]     = 0x00050002,
> +    [AST2700_SCU_MPHYCLK_PARAM]     = 0x0000004c,
> +    [AST2700_SCU_FREQ_CNTR]         = 0x000375eb,
> +    [AST2700_SCU_CPU_SCRATCH_0]     = 0x00000000,
> +    [AST2700_SCU_CPU_SCRATCH_1]     = 0x00000004,
> +};
> +
> +static void aspeed_ast2700_scu_reset(DeviceState *dev)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(dev);
> +    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
> +
> +    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
> +}
> +
> +static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 System Control Unit";
> +    dc->reset = aspeed_ast2700_scu_reset;
> +    asc->resets = ast2700_a0_resets;
> +    asc->calc_hpll = aspeed_2600_scu_calc_hpll;
> +    asc->get_apb = aspeed_2700_scu_get_apb_freq;
> +    asc->apb_divider = 4;
> +    asc->nr_regs = ASPEED_AST2700_SCU_NR_REGS;
> +    asc->clkin_25Mhz = true;
> +    asc->ops = &aspeed_ast2700_scu_ops;
> +}
> +
> +static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
> +                                        unsigned size)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(opaque);
> +    int reg = TO_REG(offset);
> +    if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                __func__, offset);
> +        return 0;
> +    }
> +
> +    switch (reg) {
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +    }
> +
> +    trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);
> +    return s->regs[reg];
> +}
> +
> +static void aspeed_ast2700_scuio_write(void *opaque, hwaddr offset,
> +                                     uint64_t data64, unsigned size)
> +{
> +    AspeedSCUState *s = ASPEED_SCU(opaque);
> +    int reg = TO_REG(offset);
> +    /* Truncate here so bitwise operations below behave as expected */
> +    uint32_t data = data64;
> +    bool updated = false;
> +
> +    if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                __func__, offset);
> +        return;
> +    }
> +
> +    trace_aspeed_ast2700_scuio_write(offset, size, data);
> +
> +    switch (reg) {
> +    case AST2700_SCUIO_CLK_STOP_CTL_1:
> +    case AST2700_SCUIO_CLK_STOP_CTL_2:
> +        s->regs[reg] |= data;
> +        updated = true;
> +        break;
> +    case AST2700_SCUIO_CLK_STOP_CLR_1:
> +    case AST2700_SCUIO_CLK_STOP_CLR_2:
> +        s->regs[reg - 1] ^= data;
> +        updated = true;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Unhandeled write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        break;
> +    }
> +
> +    if (!updated) {
> +        s->regs[reg] = data;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
> +    .read = aspeed_ast2700_scuio_read,
> +    .write = aspeed_ast2700_scuio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 8,
> +    .valid.unaligned = false,
> +};
> +
> +static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
> +    [AST2700_SILICON_REV]               = 0x06000003,
> +    [AST2700_HW_STRAP1]                 = 0x00000504,
> +    [AST2700_HW_STRAP1_CLR]             = 0xFFF0FFF0,
> +    [AST2700_HW_STRAP1_LOCK]            = 0x00000FFF,
> +    [AST2700_HW_STRAP1_SEC1]            = 0x000000FF,
> +    [AST2700_HW_STRAP1_SEC2]            = 0x00000000,
> +    [AST2700_HW_STRAP1_SEC3]            = 0x1000408F,
> +    [AST2700_SCUIO_CLK_STOP_CTL_1]      = 0xffff8400,
> +    [AST2700_SCUIO_CLK_STOP_CTL_2]      = 0x00005f30,
> +    [AST2700_SCUIO_CLK_SEL_1]           = 0x86900000,
> +    [AST2700_SCUIO_CLK_SEL_2]           = 0x00400000,
> +    [AST2700_SCUIO_HPLL_PARAM]          = 0x10000027,
> +    [AST2700_SCUIO_HPLL_EXT_PARAM]      = 0x80000014,
> +    [AST2700_SCUIO_APLL_PARAM]          = 0x1000001f,
> +    [AST2700_SCUIO_APLL_EXT_PARAM]      = 0x8000000f,
> +    [AST2700_SCUIO_DPLL_PARAM]          = 0x106e42ce,
> +    [AST2700_SCUIO_DPLL_EXT_PARAM]      = 0x80000167,
> +    [AST2700_SCUIO_DPLL_PARAM_READ]     = 0x106e42ce,
> +    [AST2700_SCUIO_DPLL_EXT_PARAM_READ] = 0x80000167,
> +    [AST2700_SCUIO_UARTCLK_GEN]         = 0x00014506,
> +    [AST2700_SCUIO_HUARTCLK_GEN]        = 0x000145c0,
> +    [AST2700_SCUIO_CLK_DUTY_MEAS_RST]   = 0x0c9100d2,
> +};
> +
> +static void aspeed_2700_scuio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 System Control Unit I/O";
> +    dc->reset = aspeed_ast2700_scu_reset;
> +    asc->resets = ast2700_a0_resets_io;
> +    asc->calc_hpll = aspeed_2600_scu_calc_hpll;
> +    asc->get_apb = aspeed_2700_scuio_get_apb_freq;
> +    asc->apb_divider = 2;
> +    asc->nr_regs = ASPEED_AST2700_SCU_NR_REGS;
> +    asc->clkin_25Mhz = true;
> +    asc->ops = &aspeed_ast2700_scuio_ops;
> +}
> +
> +static const TypeInfo aspeed_2700_scu_info = {
> +    .name = TYPE_ASPEED_2700_SCU,
> +    .parent = TYPE_ASPEED_SCU,
> +    .instance_size = sizeof(AspeedSCUState),
> +    .class_init = aspeed_2700_scu_class_init,
> +};
> +
> +static const TypeInfo aspeed_2700_scuio_info = {
> +    .name = TYPE_ASPEED_2700_SCUIO,
> +    .parent = TYPE_ASPEED_SCU,
> +    .instance_size = sizeof(AspeedSCUState),
> +    .class_init = aspeed_2700_scuio_class_init,
> +};
> +
>   static const uint32_t ast1030_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
>       [AST2600_SYS_RST_CTRL]      = 0xFFC3FED8,
>       [AST2600_SYS_RST_CTRL2]     = 0x09FFFFFC,
> @@ -841,6 +1143,8 @@ static void aspeed_scu_register_types(void)
>       type_register_static(&aspeed_2500_scu_info);
>       type_register_static(&aspeed_2600_scu_info);
>       type_register_static(&aspeed_1030_scu_info);
> +    type_register_static(&aspeed_2700_scu_info);
> +    type_register_static(&aspeed_2700_scuio_info);
>   }
>   
>   type_init(aspeed_scu_register_types);
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 07010a7ea6..5e5cd77420 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -93,6 +93,10 @@ slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
>   # aspeed_scu.c
>   aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_ast2700_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_ast2700_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_ast2700_scuio_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> +aspeed_ast2700_scuio_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
>   
>   # mps2-scc.c
>   mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 7cb6018dbc..58db28db45 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -19,10 +19,13 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEED_SCU)
>   #define TYPE_ASPEED_2400_SCU TYPE_ASPEED_SCU "-ast2400"
>   #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
>   #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"
> +#define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"
> +#define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"
>   #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"
>   
>   #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
>   #define ASPEED_AST2600_SCU_NR_REGS (0xE20 >> 2)
> +#define ASPEED_AST2700_SCU_NR_REGS (0xE20 >> 2)
>   
>   struct AspeedSCUState {
>       /*< private >*/
> @@ -31,7 +34,7 @@ struct AspeedSCUState {
>       /*< public >*/
>       MemoryRegion iomem;
>   
> -    uint32_t regs[ASPEED_AST2600_SCU_NR_REGS];
> +    uint32_t regs[ASPEED_AST2700_SCU_NR_REGS];
>       uint32_t silicon_rev;
>       uint32_t hw_strap1;
>       uint32_t hw_strap2;
> @@ -48,6 +51,9 @@ struct AspeedSCUState {
>   #define AST2600_A3_SILICON_REV   0x05030303U
>   #define AST1030_A0_SILICON_REV   0x80000000U
>   #define AST1030_A1_SILICON_REV   0x80010000U
> +#define AST2700_A0_SILICON_REV   0x06000103U
> +#define AST2720_A0_SILICON_REV   0x06000203U
> +#define AST2750_A0_SILICON_REV   0x06000003U
>   
>   #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
>   
> @@ -87,7 +93,8 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>    *       1. 2012/12/29 Ryan Chen Create
>    */
>   
> -/* SCU08   Clock Selection Register
> +/*
> + * SCU08   Clock Selection Register
>    *
>    *  31     Enable Video Engine clock dynamic slow down
>    *  30:28  Video Engine clock slow down setting
> @@ -109,7 +116,8 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>    */
>   #define SCU_CLK_GET_PCLK_DIV(x)                    (((x) >> 23) & 0x7)
>   
> -/* SCU24   H-PLL Parameter Register (for Aspeed AST2400 SOC)
> +/*
> + * SCU24   H-PLL Parameter Register (for Aspeed AST2400 SOC)
>    *
>    *  18     H-PLL parameter selection
>    *           0: Select H-PLL by strapping resistors
> @@ -127,7 +135,8 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>   #define SCU_AST2400_H_PLL_BYPASS_EN                (0x1 << 17)
>   #define SCU_AST2400_H_PLL_OFF                      (0x1 << 16)
>   
> -/* SCU24   H-PLL Parameter Register (for Aspeed AST2500 SOC)
> +/*
> + * SCU24   H-PLL Parameter Register (for Aspeed AST2500 SOC)
>    *
>    *  21     Enable H-PLL reset
>    *  20     Enable H-PLL bypass mode
> @@ -144,7 +153,8 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>   #define SCU_H_PLL_BYPASS_EN                        (0x1 << 20)
>   #define SCU_H_PLL_OFF                              (0x1 << 19)
>   
> -/* SCU70  Hardware Strapping Register definition (for Aspeed AST2400 SOC)
> +/*
> + * SCU70  Hardware Strapping Register definition (for Aspeed AST2400 SOC)
>    *
>    * 31:29  Software defined strapping registers
>    * 28:27  DRAM size setting (for VGA driver use)
> @@ -361,4 +371,31 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
>    */
>   #define SCU_AST1030_CLK_GET_PCLK_DIV(x)                    (((x) >> 8) & 0xf)
>   
> +/*
> + * SCU280   Clock Selection 1 Register (for Aspeed AST2700 SCUIO)
> + *
> + *  31:29  MHCLK_DIV
> + *  28     Reserved
> + *  27:25  RGMIICLK_DIV
> + *  24     Reserved
> + *  23:21  RMIICLK_DIV
> + *  20:18  PCLK_DIV
> + *  17:14  SDCLK_DIV
> + *  13     SDCLK_SEL
> + *  12     UART13CLK_SEL
> + *  11     UART12CLK_SEL
> + *  10     UART11CLK_SEL
> + *  9      UART10CLK_SEL
> + *  8      UART9CLK_SEL
> + *  7      UART8CLK_SEL
> + *  6      UART7CLK_SEL
> + *  5      UART6CLK_SEL
> + *  4      UARTDBCLK_SEL
> + *  3      UART4CLK_SEL
> + *  2      UART3CLK_SEL
> + *  1      UART2CLK_SEL
> + *  0      UART1CLK_SEL
> + */
> +#define SCUIO_AST2700_CLK_GET_PCLK_DIV(x)                    (((x) >> 18) & 0x7)
> +
>   #endif /* ASPEED_SCU_H */


