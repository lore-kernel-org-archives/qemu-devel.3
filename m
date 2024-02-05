Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C28DC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWz7g-0002AQ-6W; Mon, 05 Feb 2024 08:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWz7c-000293-PH; Mon, 05 Feb 2024 08:34:52 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XBpg=JO=kaod.org=clg@ozlabs.org>)
 id 1rWz7Z-000352-Mp; Mon, 05 Feb 2024 08:34:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TT6n02Kfnz4wp3;
 Tue,  6 Feb 2024 00:34:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TT6mx5m1hz4wcC;
 Tue,  6 Feb 2024 00:34:22 +1100 (AEDT)
Message-ID: <7b35d498-0669-4b54-8111-a598b60981a1@kaod.org>
Date: Mon, 5 Feb 2024 14:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240205091415.935686-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/5/24 10:14, Jamin Lin wrote:
> In the previous design of QEMU model for ASPEED SOCs, it set the boot
> address at 0 which was the hardcode setting for ast10x0, ast2600,
> ast2500 and ast2400.
> 
> According to the design of ast2700, it has bootmcu which is used for
> executing SPL and initialize DRAM, then, CPUs(cortex-a35)
> execute u-boot, kernel and rofs. QEMU will only support CPU(coretax-a35)
> parts and the boot address is "0x400000000" for ast2700.

On the previous SoC, the ASPEED_DEV_SPI_BOOT region is an alias, at 0x0,
to the FMC CE0 region, mapped at 0x20000000.

Is 0x400000000 (or 0x40000000 ?) the address for FMC CE0 region on the
ast2700 ? or an alias ?

What is the cortex-a35 reset address ?

It would help to also introduce a basic skeleton of the ast2700 SoC.

Anyhow, this change makes sense. Could you please respin and also
remove ASPEED_SOC_SPI_BOOT_ADDR. ?

Thanks,

C.

> Therefore, fixed hardcode boot address 0.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 218b81298e..82a92e8142 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -289,12 +289,14 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
>                                       uint64_t rom_size)
>   {
>       AspeedSoCState *soc = bmc->soc;
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
>   
>       memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
>                              &error_abort);
>       memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
>                                           &bmc->boot_rom, 1);
> -    write_boot_rom(blk, ASPEED_SOC_SPI_BOOT_ADDR, rom_size, &error_abort);
> +    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
> +                   rom_size, &error_abort);
>   }
>   
>   void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,


