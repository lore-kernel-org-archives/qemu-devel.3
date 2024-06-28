Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6aR-0007KN-ND; Fri, 28 Jun 2024 04:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6aP-00077t-Tq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6aN-0005ws-Mj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:04:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Scs4rwHz4wcS;
 Fri, 28 Jun 2024 18:03:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Scr4Wgdz4w2N;
 Fri, 28 Jun 2024 18:03:56 +1000 (AEST)
Message-ID: <fd8e18cd-b5ee-480b-b6f7-770c7525d74f@kaod.org>
Date: Fri, 28 Jun 2024 10:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 72/98] hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND
 handler (ACMD41)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-73-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-73-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 82 ++++++++++++++++++++++++++++++------------------------
>   1 file changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index cd207a3090..167e1c517a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1704,6 +1704,50 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* ACMD41 */
> +static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_idle_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    /*
> +     * If it's the first ACMD41 since reset, we need to decide
> +     * whether to power up. If this is not an enquiry ACMD41,
> +     * we immediately report power on and proceed below to the
> +     * ready state, but if it is, we set a timer to model a
> +     * delay for power up. This works around a bug in EDK2
> +     * UEFI, which sends an initial enquiry ACMD41, but
> +     * assumes that the card is in ready state as soon as it
> +     * sees the power up bit set.
> +     */
> +    if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
> +        if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
> +            timer_del(sd->ocr_power_timer);
> +            sd_ocr_powerup(sd);
> +        } else {
> +            trace_sdcard_inquiry_cmd41();
> +            if (!timer_pending(sd->ocr_power_timer)) {
> +                timer_mod_ns(sd->ocr_power_timer,
> +                             (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> +                              + OCR_POWER_DELAY_NS));
> +            }
> +        }
> +    }
> +
> +    if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
> +        /*
> +         * We accept any voltage.  10000 V is nothing.
> +         *
> +         * Once we're powered up, we advance straight to ready state
> +         * unless it's an enquiry ACMD41 (bits 23:0 == 0).
> +         */
> +        sd->state = sd_ready_state;
> +    }
> +
> +    return sd_r3;
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1812,43 +1856,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       }
>   
>       switch (req.cmd) {
> -    case 41:  /* ACMD41: SD_APP_OP_COND */
> -        if (sd->state != sd_idle_state) {
> -            break;
> -        }
> -        /* If it's the first ACMD41 since reset, we need to decide
> -         * whether to power up. If this is not an enquiry ACMD41,
> -         * we immediately report power on and proceed below to the
> -         * ready state, but if it is, we set a timer to model a
> -         * delay for power up. This works around a bug in EDK2
> -         * UEFI, which sends an initial enquiry ACMD41, but
> -         * assumes that the card is in ready state as soon as it
> -         * sees the power up bit set. */
> -        if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
> -            if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
> -                timer_del(sd->ocr_power_timer);
> -                sd_ocr_powerup(sd);
> -            } else {
> -                trace_sdcard_inquiry_cmd41();
> -                if (!timer_pending(sd->ocr_power_timer)) {
> -                    timer_mod_ns(sd->ocr_power_timer,
> -                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> -                                  + OCR_POWER_DELAY_NS));
> -                }
> -            }
> -        }
> -
> -        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
> -            /* We accept any voltage.  10000 V is nothing.
> -             *
> -             * Once we're powered up, we advance straight to ready state
> -             * unless it's an enquiry ACMD41 (bits 23:0 == 0).
> -             */
> -            sd->state = sd_ready_state;
> -        }
> -
> -        return sd_r3;
> -
>       case 42:  /* ACMD42: SET_CLR_CARD_DETECT */
>           switch (sd->state) {
>           case sd_transfer_state:
> @@ -2379,6 +2386,7 @@ static const SDProto sd_proto_sd = {
>           [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
>           [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
>           [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
> +        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
>       },
>   };
>   


