Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3FFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjXf-0007Dr-AV; Fri, 19 Jul 2024 05:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUjXT-00076r-Hg; Fri, 19 Jul 2024 05:04:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vGMz=OT=kaod.org=clg@ozlabs.org>)
 id 1sUjXR-0001NF-Cj; Fri, 19 Jul 2024 05:04:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WQNyz0bZyz4x3p;
 Fri, 19 Jul 2024 19:04:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQNyv0kX9z4wym;
 Fri, 19 Jul 2024 19:04:22 +1000 (AEST)
Message-ID: <04be07a0-286b-4189-99f9-a74eff075fae@kaod.org>
Date: Fri, 19 Jul 2024 11:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/15] hw/i2c/aspeed: support high part dram offset for
 DMA 64 bits
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
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
> ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
> And the base address of dram is "0x4 00000000" which
> is 64bits address.
> 
> The AST2700 support the maximum DRAM size is 8 GB.
> The DRAM physical address range is from "0x4_0000_0000" to
> "0x5_FFFF_FFFF".
> 
> The DRAM offset range is from "0x0_0000_0000" to
> "0x1_FFFF_FFFF" and it is enough to use bits [33:0]
> saving the dram offset.
> 
> Therefore, save the high part physical address bit[1:0]
> of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> It does not need to decrease the dram physical
> high part address for DMA operation.
> (high part physical address bit[7:0] – 4)
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/i2c/aspeed_i2c.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index b48f250e08..e28deadcfc 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -743,6 +743,14 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>                         __func__);
>           break;
>   
> +    /*
> +     * The AST2700 support the maximum DRAM size is 8 GB.
> +     * The DRAM offset range is from 0x0_0000_0000 to
> +     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]
> +     * saving the dram offset.
> +     * Therefore, save the high part physical address bit[1:0]
> +     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].
> +     */
>       case A_I2CM_DMA_TX_ADDR_HI:
>           if (!aic->has_dma64) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
> @@ -752,6 +760,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_TX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_TX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       case A_I2CM_DMA_RX_ADDR_HI:
>           if (!aic->has_dma64) {
> @@ -762,6 +772,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CM_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CM_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       case A_I2CS_DMA_TX_ADDR_HI:
>           qemu_log_mask(LOG_UNIMP,
> @@ -777,6 +789,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
>           bus->regs[R_I2CS_DMA_RX_ADDR_HI] = FIELD_EX32(value,
>                                                         I2CS_DMA_RX_ADDR_HI,
>                                                         ADDR_HI);
> +        bus->dma_dram_offset = deposit64(bus->dma_dram_offset, 32, 32,
> +                                         extract32(value, 0, 2));
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",


