Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A34C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzuZ-00020X-Ek; Mon, 05 Feb 2024 09:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWzuW-0001yN-CV; Mon, 05 Feb 2024 09:25:24 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWzuT-0004N0-IS; Mon, 05 Feb 2024 09:25:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TT7vH3vF3z4wxx;
 Tue,  6 Feb 2024 01:25:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TT7vF2nZ7z4wp3;
 Tue,  6 Feb 2024 01:25:13 +1100 (AEDT)
Message-ID: <30e7e323-369b-4ee3-994e-a6cb9205a4f9@kaod.org>
Date: Mon, 5 Feb 2024 15:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
In-Reply-To: <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=XBpg=JO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/5/24 11:46, Cédric Le Goater wrote:
> Hello Jamin,
> 
> On 2/5/24 10:14, Jamin Lin wrote:
>> According to the design of ASPEED SOCS, the uart controller
>> is 1 base for ast10x0, ast2600, ast2500 and ast2400.
>>
>> However, the uart controller is 0 base for ast2700.
>> To support uart controller both 0 and 1 base,
>> adds uasrt_bases parameter in AspeedSoCClass
>> and set the default uart controller 1 base
>> for ast10x0, astt2600, ast2500 and ast2400.
> 
> The board definition can set 'amc->uart_default' to choose a different
> default serial port for the console, or use the "bmc-console" machine
> option . Isn't it enough ? May be I am misunderstanding the need.
> 
> To clarify,
> 
> ASPEED_DEV_UART1 is in the first serial port on the boards.
> 
> I think we chose to start the indexing at 1 because the Aspeed QEMU
> modeling began first with the UART model (console) and for simplicity,
> we copied the definitions of the device tree from Linux :
> 
>      serial0 = &uart1;
>      serial1 = &uart2;
>      serial2 = &uart3;
>      serial3 = &uart4;
>      serial4 = &uart5;
>      serial5 = &vuart;

The uart definitions on the AST2700 are different :
   
   https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

	serial0 = &uart0;
	serial1 = &uart1;
	serial2 = &uart2;
	serial3 = &uart3;
	serial4 = &uart4;
	serial5 = &uart5;
	serial6 = &uart6;
	serial7 = &uart7;
	serial8 = &uart8;
         ...

I think the names in the DT (and consequently in the QEMU models)
follow the IP names in the datasheet.

I don't think we care in QEMU, so I would be inclined to change the
indexing of the device names in QEMU and start at 0, which would
introduce a discrepancy for the AST2400, AST2600, AST2600 SoC.

Let's see what the other maintainers have to say.

Thanks,

C.

