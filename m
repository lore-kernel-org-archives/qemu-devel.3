Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB99C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwUj-0000QL-HM; Mon, 05 Feb 2024 05:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWwUi-0000NR-Fv; Mon, 05 Feb 2024 05:46:32 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWwUX-0008Mb-7I; Mon, 05 Feb 2024 05:46:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TT32W2KQsz4wqM;
 Mon,  5 Feb 2024 21:46:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TT32T1TLmz4wcb;
 Mon,  5 Feb 2024 21:46:07 +1100 (AEDT)
Message-ID: <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
Date: Mon, 5 Feb 2024 11:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240205091415.935686-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=XBpg=JO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Jamin,

On 2/5/24 10:14, Jamin Lin wrote:
> According to the design of ASPEED SOCS, the uart controller
> is 1 base for ast10x0, ast2600, ast2500 and ast2400.
>
> However, the uart controller is 0 base for ast2700.
> To support uart controller both 0 and 1 base,
> adds uasrt_bases parameter in AspeedSoCClass
> and set the default uart controller 1 base
> for ast10x0, astt2600, ast2500 and ast2400.

The board definition can set 'amc->uart_default' to choose a different
default serial port for the console, or use the "bmc-console" machine
option . Isn't it enough ? May be I am misunderstanding the need.

To clarify,

ASPEED_DEV_UART1 is in the first serial port on the boards.

I think we chose to start the indexing at 1 because the Aspeed QEMU
modeling began first with the UART model (console) and for simplicity,
we copied the definitions of the device tree from Linux :

     serial0 = &uart1;
     serial1 = &uart2;
     serial2 = &uart3;
     serial3 = &uart4;
     serial4 = &uart5;
     serial5 = &vuart;

We replicated this indexing starting at 1 to nearly all device models :
  
     ASPEED_DEV_UART1 - 13
     ASPEED_DEV_SPI1 -2
     ASPEED_DEV_EHCI1 -2
     ASPEED_DEV_TIMER1 - 8
     ASPEED_DEV_ETH1 -4
     ASPEED_DEV_MII1 - 4
     ASPEED_DEV_JTAG0 - 1      <--- !!
     ASPEED_DEV_FSI1 - 2

I don't know what would be ASPEED_DEV_UART0 in this context.

May be you could send a simplified AST2700 SoC model with definitions
of a minimum address space and IRQ space ?

Or you could change the indexing to start at 0 if you prefer. Just be
careful with the aspeed_set/get_bmc_console routines it you choose to.

Thanks,

C.


>  From datasheet description
> ast2700:
> Base Address of UART0 = 0x14c33000
> ast1030:
> Base Address of UART1 = 0x7e783000
> ast2600:
> Base Address of UART1 = 0x1E78 3000
> ast2500:
> Base Address of UART1 = 0x1E78 3000
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c             | 8 +++++---
>   hw/arm/aspeed_ast10x0.c     | 1 +
>   hw/arm/aspeed_ast2400.c     | 2 ++
>   hw/arm/aspeed_ast2600.c     | 1 +
>   hw/arm/aspeed_soc_common.c  | 4 ++--
>   include/hw/arm/aspeed_soc.h | 1 +
>   6 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 09b1e823ba..218b81298e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -342,7 +342,7 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
>       aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
> -    for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 1, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           if (uart == uart_chosen) {
>               continue;
>           }
> @@ -1092,9 +1092,11 @@ static char *aspeed_get_bmc_console(Object *obj, Error **errp)
>   {
>       AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(obj);
> +
>       int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>   
> -    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1);
> +    return g_strdup_printf("uart%d", uart_chosen - sc->uarts_base + 1);
>   }
>   
>   static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
> @@ -1114,7 +1116,7 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
>           error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uarts_num);
>           return;
>       }
> -    bmc->uart_chosen = ASPEED_DEV_UART1 + val - 1;
> +    bmc->uart_chosen = sc->uarts_base + val - 1;
>   }
>   
>   static void aspeed_machine_class_props_init(ObjectClass *oc)
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index c3b5116a6a..2634e0f654 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -436,6 +436,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, void *data)
>       sc->wdts_num = 4;
>       sc->macs_num = 1;
>       sc->uarts_num = 13;
> +    sc->uarts_base = ASPEED_DEV_UART1;
>       sc->irqmap = aspeed_soc_ast1030_irqmap;
>       sc->memmap = aspeed_soc_ast1030_memmap;
>       sc->num_cpus = 1;
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index 8829561bb6..95da85fee0 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -523,6 +523,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 2;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2400_irqmap;
>       sc->memmap       = aspeed_soc_ast2400_memmap;
>       sc->num_cpus     = 1;
> @@ -551,6 +552,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 3;
>       sc->macs_num     = 2;
>       sc->uarts_num    = 5;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2500_irqmap;
>       sc->memmap       = aspeed_soc_ast2500_memmap;
>       sc->num_cpus     = 1;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 4ee32ea99d..f74561ecdc 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -666,6 +666,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>       sc->wdts_num     = 4;
>       sc->macs_num     = 4;
>       sc->uarts_num    = 13;
> +    sc->uarts_base   = ASPEED_DEV_UART1;
>       sc->irqmap       = aspeed_soc_ast2600_irqmap;
>       sc->memmap       = aspeed_soc_ast2600_memmap;
>       sc->num_cpus     = 2;
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 123a0c432c..3963436c3a 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -36,7 +36,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>       SerialMM *smm;
>   
> -    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
> +    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
>           smm = &s->uart[i];
>   
>           /* Chardev property is set by the machine. */
> @@ -58,7 +58,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
>   void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
>   {
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    int i = dev - ASPEED_DEV_UART1;
> +    int i = dev - sc->uarts_base;
>   
>       g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
>       qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 9d0af84a8c..ce2bb51682 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -140,6 +140,7 @@ struct AspeedSoCClass {
>       int wdts_num;
>       int macs_num;
>       int uarts_num;
> +    int uarts_base;
>       const int *irqmap;
>       const hwaddr *memmap;
>       uint32_t num_cpus;


