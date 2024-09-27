Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DF2CEBF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 09:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su7IV-0005am-C5; Fri, 27 Sep 2024 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hVAz=QZ=kaod.org=clg@ozlabs.org>)
 id 1su7IP-0005Lu-Mc; Fri, 27 Sep 2024 05:29:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hVAz=QZ=kaod.org=clg@ozlabs.org>)
 id 1su7IC-0002WO-HQ; Fri, 27 Sep 2024 05:29:53 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XFQCc4lhhz4xSZ;
 Fri, 27 Sep 2024 19:29:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XFQCX0MwRz4xRB;
 Fri, 27 Sep 2024 19:29:27 +1000 (AEST)
Message-ID: <a3ae007e-2e82-4370-84a2-63c06719f47d@kaod.org>
Date: Fri, 27 Sep 2024 11:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] aspeed/soc: Support GPIO for AST2700 and correct
 irq 130
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240927083351.2637798-1-jamin_lin@aspeedtech.com>
 <20240927083351.2637798-7-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240927083351.2637798-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=hVAz=QZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.246, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Jamin,

On 9/27/24 10:33, Jamin Lin wrote:
> The register set of GPIO have a significant change since AST2700.
> Each GPIO pin has their own individual control register and users are able to
> set one GPIO pin’s direction, interrupt enable, input mask and so on in the
> same one control register.
> 
> AST2700 does not have GPIO18_XXX registers for GPIO 1.8v, removes
> ASPEED_DEV_GPIO_1_8V. It is enough to only have ASPEED_DEV_GPIO
> device in AST2700.
> 
> Add GPIO model for AST2700 GPIO support. The GPIO controller registers base
> address is start at 0x14C0_B000 and its address space is 0x1000.
> 
> The AST2700 GPIO controller interrupt is connected to GICINT130_INTC at
> bit 18. Therefore, correct GPIO irq 130.

I would prefer 2 patches. One for the IRQ number fix and one for
"Support GPIO for AST2700"

Thanks,

C.


> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 761ee11657..dca660eb6b 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -62,6 +62,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_GIC_REDIST]    =  0x12280000,
>       [ASPEED_DEV_ADC]       =  0x14C00000,
>       [ASPEED_DEV_I2C]       =  0x14C0F000,
> +    [ASPEED_DEV_GPIO]      =  0x14C0B000,
>   };
>   
>   #define AST2700_MAX_IRQ 288
> @@ -87,8 +88,7 @@ static const int aspeed_soc_ast2700_irqmap[] = {
>       [ASPEED_DEV_ADC]       = 130,
>       [ASPEED_DEV_XDMA]      = 5,
>       [ASPEED_DEV_EMMC]      = 15,
> -    [ASPEED_DEV_GPIO]      = 11,
> -    [ASPEED_DEV_GPIO_1_8V] = 130,
> +    [ASPEED_DEV_GPIO]      = 130,
>       [ASPEED_DEV_RTC]       = 13,
>       [ASPEED_DEV_TIMER1]    = 16,
>       [ASPEED_DEV_TIMER2]    = 17,
> @@ -124,7 +124,7 @@ static const int aspeed_soc_ast2700_gic128_intcmap[] = {
>   static const int aspeed_soc_ast2700_gic130_intcmap[] = {
>       [ASPEED_DEV_I2C]        = 0,
>       [ASPEED_DEV_ADC]        = 16,
> -    [ASPEED_DEV_GPIO_1_8V]  = 18,
> +    [ASPEED_DEV_GPIO]       = 18,
>   };
>   
>   /* GICINT 131 */
> @@ -373,6 +373,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>       object_initialize_child(obj, "i2c", &s->i2c, typename);
> +
> +    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
> +    object_initialize_child(obj, "gpio", &s->gpio, typename);
>   }
>   
>   /*
> @@ -658,6 +661,15 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
>       }
>   
> +    /* GPIO */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
> +                    sc->memmap[ASPEED_DEV_GPIO]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
> +
>       create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
>       create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
>       create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);


