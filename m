Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A73C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjlq-0002JU-4I; Fri, 19 Jul 2024 05:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUjlo-0002IQ-3o; Fri, 19 Jul 2024 05:19:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUjlm-0004XJ-0W; Fri, 19 Jul 2024 05:19:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WQPJ03pLPz4x04;
 Fri, 19 Jul 2024 19:19:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQPHw1w3Qz4w2K;
 Fri, 19 Jul 2024 19:19:07 +1000 (AEST)
Message-ID: <f70ae091-151b-476c-a8ef-312952163fac@kaod.org>
Date: Fri, 19 Jul 2024 11:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/15] aspeed/soc: introduce a new API to get the INTC
 orgate information
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-13-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vGMz=OT=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/18/24 08:49, Jamin Lin wrote:
> Currently, users can set the intc mapping table with
> enumerated device id and device irq to get the INTC orgate
> input pins. However, some devices use the continuous bits number in the
> same orgate. To reduce the enumerated device id definition,
> create a new API to get the INTC orgate index and source bit number
> if users only provide the start bus number of device.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4257b5e8af..0bbd66110b 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -164,6 +164,11 @@ struct gic_intc_irq_info {
>       const int *ptr;
>   };
>   
> +struct gic_intc_orgate_info {
> +    int index;
> +    int int_num;
> +};
> +
>   static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
>       {128,  aspeed_soc_ast2700_gic128_intcmap},
>       {129,  NULL},
> @@ -193,6 +198,27 @@ static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
>       return qdev_get_gpio_in(DEVICE(&a->gic), sc->irqmap[dev]);
>   }
>   
> +static void aspeed_soc_ast2700_get_intc_orgate(AspeedSoCState *s, int dev,
> +    struct gic_intc_orgate_info *orgate_info)
> +{
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
> +        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
> +            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
> +            orgate_info->index = i;
> +            orgate_info->int_num = aspeed_soc_ast2700_gic_intcmap[i].ptr[dev];
> +            return;
> +        }
> +    }
> +
> +    /*
> +     * Invalid orgate index, device irq should be 128 to 136.
> +     */
> +    g_assert_not_reached();
> +}


This looks redundant. Couldn't we extend aspeed_soc_ast2700_get_irq() with an
index parameter instead ?

Thanks,

C.




>   static uint64_t aspeed_ram_capacity_read(void *opaque, hwaddr addr,
>                                                       unsigned int size)
>   {


