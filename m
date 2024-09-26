Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D756ECDE021
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1str31-0007J5-CH; Thu, 26 Sep 2024 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2y-0007EG-KS; Thu, 26 Sep 2024 12:08:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2w-00044q-Ln; Thu, 26 Sep 2024 12:08:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XDz6l6zx1z4xQN;
 Fri, 27 Sep 2024 02:08:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XDz6h2YfGz4xGl;
 Fri, 27 Sep 2024 02:08:44 +1000 (AEST)
Message-ID: <8a587e5e-ea37-49d0-86af-59bbf01ddb80@kaod.org>
Date: Thu, 26 Sep 2024 18:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] hw/gpio/aspeed: Support different memory region ops
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240926074535.1286209-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.246, SPF_HELO_PASS=-0.001,
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

On 9/26/24 09:45, Jamin Lin wrote:
> It set "aspeed_gpio_ops" struct which containing
> read and write callbacks to be used when I/O is performed
> on the GPIO region.
> 
> Besides, in the previous design of ASPEED SOCs,
> one register is used for setting one function for 32 GPIO pins.
> ex: GPIO000 is used for setting data value for GPIO A, B, C and D in AST2600.
> ex: GPIO004 is used for setting direction for GPIO A, B, C and D in AST2600.
> 
> However, the register set have a significant change in AST2700.
> Each GPIO pin has their own control register. In other words, users are able to
> set one GPIO pin’s direction, interrupt enable, input mask and so on
> in one register. The aspeed_gpio_read/aspeed_gpio_write callback functions
> are not compatible AST2700.
> 
> Introduce a new "const MemoryRegionOps *" attribute in AspeedGPIOClass and
> use it in aspeed_gpio_realize function.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/gpio/aspeed_gpio.c         | 7 ++++++-
>   include/hw/gpio/aspeed_gpio.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 564459ad4f..8725606aec 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -1046,7 +1046,7 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
> +    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
>                             TYPE_ASPEED_GPIO, agc->mem_size);
>   
>       sysbus_init_mmio(sbd, &s->iomem);
> @@ -1131,6 +1131,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
>       agc->mem_size = 0x1000;
> +    agc->reg_ops = &aspeed_gpio_ops;
>   }
>   
>   static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
> @@ -1143,6 +1144,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
>       agc->mem_size = 0x1000;
> +    agc->reg_ops = &aspeed_gpio_ops;
>   }
>   
>   static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
> @@ -1155,6 +1157,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
>       agc->mem_size = 0x800;
> +    agc->reg_ops = &aspeed_gpio_ops;
>   }
>   
>   static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
> @@ -1167,6 +1170,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
>       agc->reg_table = aspeed_1_8v_gpios;
>       agc->reg_table_count = GPIO_1_8V_REG_ARRAY_SIZE;
>       agc->mem_size = 0x800;
> +    agc->reg_ops = &aspeed_gpio_ops;
>   }
>   
>   static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
> @@ -1179,6 +1183,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
>       agc->mem_size = 0x1000;
> +    agc->reg_ops = &aspeed_gpio_ops;
>   }
>   
>   static const TypeInfo aspeed_gpio_info = {
> diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
> index 8cd2ff5496..e1e6c54333 100644
> --- a/include/hw/gpio/aspeed_gpio.h
> +++ b/include/hw/gpio/aspeed_gpio.h
> @@ -77,6 +77,7 @@ struct AspeedGPIOClass {
>       const AspeedGPIOReg *reg_table;
>       unsigned reg_table_count;
>       uint64_t mem_size;
> +    const MemoryRegionOps *reg_ops;
>   };
>   
>   struct AspeedGPIOState {


