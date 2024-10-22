Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC3BD1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37o5-00008X-Q7; Tue, 22 Oct 2024 01:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t37o0-00007k-KS; Tue, 22 Oct 2024 01:51:44 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t37nx-0007U8-Sx; Tue, 22 Oct 2024 01:51:44 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XXhBV5LtMz4wb7;
 Tue, 22 Oct 2024 16:51:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXhBN54Rfz4w2H;
 Tue, 22 Oct 2024 16:51:24 +1100 (AEDT)
Message-ID: <eb69d07f-8114-41e2-bea0-06f0d67a0d6f@kaod.org>
Date: Tue, 22 Oct 2024 07:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 01/16] aspeed/smc: Fix write incorrect data into
 flash in user mode
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018053112.1886173-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=pGrG=RS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Jamin,

On 10/18/24 07:30, Jamin Lin wrote:
> According to the design of ASPEED SPI controllers user mode, users write the
> data to flash, the SPI drivers set the Control Register(0x10) bit 0 and 1
> enter user mode. Then, SPI drivers send flash commands for writing data.
> Finally, SPI drivers set the Control Register (0x10) bit 2 to stop
> active control and restore bit 0 and 1.
> 
> According to the design of ASPEED SMC model, firmware writes the
> Control Register and the "aspeed_smc_flash_update_ctrl" function is called.
> Then, this function verify Control Register(0x10) bit 0 and 1. If it set user
> mode, the value of s->snoop_index is SNOOP_START else SNOOP_OFF.
> If s->snoop_index is SNOOP_START, the "aspeed_smc_do_snoop" function verify
> the first incomming data is a new flash command and writes the corresponding
> dummy bytes if need.
> 
> However, it did not check the current unselect status. If current unselect
> status is "false" and firmware set the IO MODE by Control Register bit 31:28,
> the value of s->snoop_index will be changed to SNOOP_START again and
> "aspeed_smc_do_snoop" misunderstand that the incomming data is the new flash
> command and it causes writing unexpected data into flash.
> 
> Example:
> 1. Firmware set user mode by Control Register bit 0 and 1(0x03)
> 2. SMC model set s->snoop SNOOP_START
> 3. Firmware set Quad Page Program with 4-Byte Address command (0x34)
> 4. SMC model verify this flash command and it needs 4 dummy bytes.
> 5. Firmware send 4 bytes address.
> 6. SMC model receives 4 bytes address
> 7. Firmware set QPI IO MODE by Control Register bit 31. (0x80000003)
> 8. SMC model verify new user mode by Control Register bit 0 and 1.
>     Then, set s->snoop SNOOP_START again. (It is the wrong behavior.)
> 9. Firmware send 0xebd8c134 data and it should be written into flash.
>     However, SMC model misunderstand that the first incoming data, 0x34,
>     is the new command because the value of s->snoop is changed to SNOOP_START.
>     Finally, SMC sned the incorrect data to flash model.
> 
> Introduce a new unselect attribute in AspeedSMCState to save the current
> unselect status for user mode and set it "true" by default.
> Update "aspeed_smc_flash_update_ctrl" function to check the previous unselect
> status. If both new unselect status and previous unselect status is different,
> update s->snoop_index value and call "aspeed_smc_flash_do_select".

It's very difficult and time consuming to debug such issues. Thanks for the
effort !

> Increase VMStateDescription version 1.

"Increase VMStateDescription version" is sufficient.

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/ssi/aspeed_smc.c         | 39 +++++++++++++++++++++++++------------
>   include/hw/ssi/aspeed_smc.h |  1 +
>   2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index e3fdc66cb2..8a6145afe9 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -417,7 +417,7 @@ static void aspeed_smc_flash_do_select(AspeedSMCFlash *fl, bool unselect)
>       AspeedSMCState *s = fl->controller;
>   
>       trace_aspeed_smc_flash_select(fl->cs, unselect ? "un" : "");
> -
> +    s->unselect = unselect;
>       qemu_set_irq(s->cs_lines[fl->cs], unselect);
>   }
>   
> @@ -677,22 +677,35 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {

I would like to add some documentation to this routine. Listing the
different controller state changes seems important to me to understand
how they are handled. In a future patch, no need now. Fixing the issue
is already great !



>   static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
>   {
>       AspeedSMCState *s = fl->controller;
> -    bool unselect;
> +    bool unselect = false;
> +    uint32_t old_mode;
> +    uint32_t new_mode;
> +
> +    old_mode = s->regs[s->r_ctrl0 + fl->cs] & CTRL_CMD_MODE_MASK;
> +    new_mode = value & CTRL_CMD_MODE_MASK;
>   
> -    /* User mode selects the CS, other modes unselect */
> -    unselect = (value & CTRL_CMD_MODE_MASK) != CTRL_USERMODE;
> +    if (old_mode == CTRL_USERMODE) {
> +        if (new_mode != CTRL_USERMODE) {
> +            unselect = true;
> +        }
>   
> -    /* A change of CTRL_CE_STOP_ACTIVE from 0 to 1, unselects the CS */
> -    if (!(s->regs[s->r_ctrl0 + fl->cs] & CTRL_CE_STOP_ACTIVE) &&
> -        value & CTRL_CE_STOP_ACTIVE) {
> -        unselect = true;
> +        /* A change of CTRL_CE_STOP_ACTIVE from 0 to 1, unselects the CS */
> +        if (!(s->regs[s->r_ctrl0 + fl->cs] & CTRL_CE_STOP_ACTIVE) &&
> +            value & CTRL_CE_STOP_ACTIVE) {
> +            unselect = true;
> +        }
> +    } else {
> +        if (new_mode != CTRL_USERMODE) {
> +            unselect = true;
> +        }
>       }
>   
>       s->regs[s->r_ctrl0 + fl->cs] = value;
>   
> -    s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
> -
> -    aspeed_smc_flash_do_select(fl, unselect);
> +    if (unselect != s->unselect) {> +        s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
> +        aspeed_smc_flash_do_select(fl, unselect);
> +    }
>   }
>   
>   static void aspeed_smc_reset(DeviceState *d)
> @@ -737,6 +750,7 @@ static void aspeed_smc_reset(DeviceState *d)
>   
>       s->snoop_index = SNOOP_OFF;
>       s->snoop_dummies = 0;
> +    s->unselect = true;

Please move this assignment below the "/* Unselect all peripherals */"
section.


Thanks,

C.



>   }
>   
>   static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
> @@ -1261,12 +1275,13 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>   
>   static const VMStateDescription vmstate_aspeed_smc = {
>       .name = "aspeed.smc",
> -    .version_id = 2,
> +    .version_id = 3,
>       .minimum_version_id = 2,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
>           VMSTATE_UINT8(snoop_index, AspeedSMCState),
>           VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
> +        VMSTATE_BOOL(unselect, AspeedSMCState),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 234dca32b0..25b95e7406 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -82,6 +82,7 @@ struct AspeedSMCState {
>   
>       uint8_t snoop_index;
>       uint8_t snoop_dummies;
> +    bool unselect;
>   };
>   
>   typedef struct AspeedSegments {


