Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7F1C4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOnT-0005SG-7H; Tue, 06 Feb 2024 11:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOnR-0005Rl-33; Tue, 06 Feb 2024 11:59:45 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOnO-0000TR-Qd; Tue, 06 Feb 2024 11:59:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TTqGx0gw4z4wyp;
 Wed,  7 Feb 2024 03:59:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTqGv08ckz4wcB;
 Wed,  7 Feb 2024 03:59:34 +1100 (AEDT)
Message-ID: <21cf49a2-8e3a-4dc5-9b3c-841818b20469@kaod.org>
Date: Tue, 6 Feb 2024 17:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
 <30e7e323-369b-4ee3-994e-a6cb9205a4f9@kaod.org>
 <SI2PR06MB5041FC68062741DB853B979EFC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041FC68062741DB853B979EFC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=f3tV=JP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 2/6/24 04:29, Jamin Lin wrote:
>> -----Original Message-----
>> The uart definitions on the AST2700 are different :
>>
>>
>> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm
>> 64/boot/dts/aspeed/aspeed-g7.dtsi
>>
>> 	serial0 = &uart0;
>> 	serial1 = &uart1;
>> 	serial2 = &uart2;
>> 	serial3 = &uart3;
>> 	serial4 = &uart4;
>> 	serial5 = &uart5;
>> 	serial6 = &uart6;
>> 	serial7 = &uart7;
>> 	serial8 = &uart8;
>>           ...
>>
>> I think the names in the DT (and consequently in the QEMU models) follow the
>> IP names in the datasheet.
>>
>> I don't think we care in QEMU, so I would be inclined to change the indexing of
>> the device names in QEMU and start at 0, which would introduce a
>> discrepancy for the AST2400, AST2600, AST2600 SoC.
>>
>> Let's see what the other maintainers have to say.
>>
>> Thanks,
>>
>> C.
> Hi Cedric,
> 
> Did you mean to change the naming of uart device to 0 base for all ASPEED SOCs?
> If yes, it seems we need to do the following changes.
> 1. add ASPEED_DEV_UART0 in aspeed_soc.h
> 2. Re-defined uart memory map for ast2600, ast10x0, ast2500 and ast2400(uart0 -> ASPEED_DEV_UART0)
> Take ast2600 for example:
> static const hwaddr aspeed_soc_ast2600_memmap[] = {
>      [ASPEED_DEV_UART1]     = 0x1E783000, ---> [ASPEED_DEV_UART0]
>      [ASPEED_DEV_UART2]     = 0x1E78D000, ---> [ASPEED_DEV_UART1]
>      [ASPEED_DEV_UART3]     = 0x1E78E000,
>      [ASPEED_DEV_UART4]     = 0x1E78F000,
>      [ASPEED_DEV_UART5]     = 0x1E784000,
>      [ASPEED_DEV_UART6]     = 0x1E790000,
>      [ASPEED_DEV_UART7]     = 0x1E790100,
>      [ASPEED_DEV_UART8]     = 0x1E790200,
>      [ASPEED_DEV_UART9]     = 0x1E790300,
>      [ASPEED_DEV_UART10]    = 0x1E790400,
>      [ASPEED_DEV_UART11]    = 0x1E790500,
>      [ASPEED_DEV_UART12]    = 0x1E790600,
>      [ASPEED_DEV_UART13]    = 0x1E790700, ---> [ASPEED_DEV_UART12]
> };
> If no, could you please descript it more detail? So, I can change it and re-send this patch series.

Let's keep the datasheet names. I had forgotten the reason initially
and from an HW POV it makes sense to keep them in sync. I will add
some more comments to the patch.
  
> By the way, I will send a new patch series to support AST2700 in two weeks.
> We encountered GIC issues. It seems that QEMU support GIC v3 but SPI did not support, yet.
>
> https://github.com/qemu/qemu/blob/master/hw/intc/arm_gicv3_dist.c#L383
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi#L229

If you did any hacks or workarounds in the QEMU models, please keep them
separate from the other patches so that we can discuss.

> It think that we can discuss it in a new AST2700 patch series.
Sure.

Thanks,

C.



