Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27776CDE021
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1str2s-00070P-Os; Thu, 26 Sep 2024 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2p-0006qf-9q; Thu, 26 Sep 2024 12:08:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org>)
 id 1str2n-00043w-3z; Thu, 26 Sep 2024 12:08:43 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XDz6T4Vmjz4xQr;
 Fri, 27 Sep 2024 02:08:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XDz6Q046nz4xQN;
 Fri, 27 Sep 2024 02:08:29 +1000 (AEST)
Message-ID: <100c8bbf-1a9e-429a-b49a-b96d123f753b@kaod.org>
Date: Thu, 26 Sep 2024 18:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/gpio/aspeed: Support to set the different
 memory size
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240926074535.1286209-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Z/Ab=QY=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 9/26/24 09:45, Jamin Lin wrote:
> According to the datasheet of ASPEED SOCs,
> a GPIO controller owns 4KB of register space for AST2700,
> AST2500, AST2400 and AST1030; owns 2KB of register space
> for AST2600 1.8v and owns 2KB of register space for AST2600 3.3v.
> 
> It set the memory region size 2KB by default and it does not compatible
> register space for AST2700.
> 
> Introduce a new class attribute to set the GPIO controller memory size
> for different ASPEED SOCs.
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
> index 00fb72a509..564459ad4f 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -1047,7 +1047,7 @@ static void aspeed_gpio_realize(DeviceState *dev, Error **errp)
>       }
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_gpio_ops, s,
> -            TYPE_ASPEED_GPIO, 0x800);
> +                          TYPE_ASPEED_GPIO, agc->mem_size);
>   
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
> @@ -1130,6 +1130,7 @@ static void aspeed_gpio_ast2400_class_init(ObjectClass *klass, void *data)
>       agc->nr_gpio_sets = 7;
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
> +    agc->mem_size = 0x1000;
>   }
>   
>   static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
> @@ -1141,6 +1142,7 @@ static void aspeed_gpio_2500_class_init(ObjectClass *klass, void *data)
>       agc->nr_gpio_sets = 8;
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
> +    agc->mem_size = 0x1000;
>   }
>   
>   static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
> @@ -1152,6 +1154,7 @@ static void aspeed_gpio_ast2600_3_3v_class_init(ObjectClass *klass, void *data)
>       agc->nr_gpio_sets = 7;
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
> +    agc->mem_size = 0x800;
>   }
>   
>   static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
> @@ -1163,6 +1166,7 @@ static void aspeed_gpio_ast2600_1_8v_class_init(ObjectClass *klass, void *data)
>       agc->nr_gpio_sets = 2;
>       agc->reg_table = aspeed_1_8v_gpios;
>       agc->reg_table_count = GPIO_1_8V_REG_ARRAY_SIZE;
> +    agc->mem_size = 0x800;
>   }
>   
>   static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
> @@ -1174,6 +1178,7 @@ static void aspeed_gpio_1030_class_init(ObjectClass *klass, void *data)
>       agc->nr_gpio_sets = 6;
>       agc->reg_table = aspeed_3_3v_gpios;
>       agc->reg_table_count = GPIO_3_3V_REG_ARRAY_SIZE;
> +    agc->mem_size = 0x1000;
>   }
>   
>   static const TypeInfo aspeed_gpio_info = {
> diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
> index 39febda9ea..8cd2ff5496 100644
> --- a/include/hw/gpio/aspeed_gpio.h
> +++ b/include/hw/gpio/aspeed_gpio.h
> @@ -76,6 +76,7 @@ struct AspeedGPIOClass {
>       uint32_t nr_gpio_sets;
>       const AspeedGPIOReg *reg_table;
>       unsigned reg_table_count;
> +    uint64_t mem_size;
>   };
>   
>   struct AspeedGPIOState {


