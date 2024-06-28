Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32146C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6KI-0002Qk-DZ; Fri, 28 Jun 2024 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6K9-0002OY-Al
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:47:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6K7-0004v0-9N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:47:13 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SFS59qPz4w2N;
 Fri, 28 Jun 2024 17:47:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SFR2MKFz4w2K;
 Fri, 28 Jun 2024 17:47:06 +1000 (AEST)
Message-ID: <0d8342a5-72a0-4cd5-8fd5-a9f72f57e9cf@kaod.org>
Date: Fri, 28 Jun 2024 09:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 23/98] hw/sd/sdcard: Convert SEND_TUNING_BLOCK to
 generic_read_byte (CMD19)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-24-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 48 +++++++++++++++++++-----------------------------
>   1 file changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 605269163d..eece33194a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -568,6 +568,21 @@ static void sd_set_sdstatus(SDState *sd)
>       memset(sd->sd_status, 0, 64);
>   }
>   
> +static const uint8_t sd_tuning_block_pattern4[64] = {
> +    /*
> +     * See: Physical Layer Simplified Specification Version 3.01,
> +     * Table 4-2.
> +     */
> +    0xff, 0x0f, 0xff, 0x00,     0x0f, 0xfc, 0xc3, 0xcc,
> +    0xc3, 0x3c, 0xcc, 0xff,     0xfe, 0xff, 0xfe, 0xef,
> +    0xff, 0xdf, 0xff, 0xdd,     0xff, 0xfb, 0xff, 0xfb,
> +    0xbf, 0xff, 0x7f, 0xff,     0x77, 0xf7, 0xbd, 0xef,
> +    0xff, 0xf0, 0xff, 0xf0,     0x0f, 0xfc, 0xcc, 0x3c,
> +    0xcc, 0x33, 0xcc, 0xcf,     0xff, 0xef, 0xff, 0xee,
> +    0xff, 0xfd, 0xff, 0xfd,     0xdf, 0xff, 0xbf, 0xff,
> +    0xbb, 0xff, 0xf7, 0xff,     0xf7, 0x7f, 0x7b, 0xde
> +};
> +
>   static int sd_req_crc_validate(SDRequest *req)
>   {
>       uint8_t buffer[5];
> @@ -1161,14 +1176,9 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>           return sd_cmd_illegal(sd, req);
>       }
>   
> -    if (sd->state != sd_transfer_state) {
> -        return sd_invalid_state_for_cmd(sd, req);
> -    }
> -
> -    sd->state = sd_sendingdata_state;
> -    sd->data_offset = 0;
> -
> -    return sd_r1;
> +    return sd_cmd_to_sendingdata(sd, req, 0,
> +                                 sd_tuning_block_pattern4,
> +                                 sizeof(sd_tuning_block_pattern4));
>   }
>   
>   /* CMD23 */
> @@ -2100,20 +2110,6 @@ void sd_write_byte(SDState *sd, uint8_t value)
>       }
>   }
>   
> -#define SD_TUNING_BLOCK_SIZE    64
> -
> -static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
> -    /* See: Physical Layer Simplified Specification Version 3.01, Table 4-2 */
> -    0xff, 0x0f, 0xff, 0x00,         0x0f, 0xfc, 0xc3, 0xcc,
> -    0xc3, 0x3c, 0xcc, 0xff,         0xfe, 0xff, 0xfe, 0xef,
> -    0xff, 0xdf, 0xff, 0xdd,         0xff, 0xfb, 0xff, 0xfb,
> -    0xbf, 0xff, 0x7f, 0xff,         0x77, 0xf7, 0xbd, 0xef,
> -    0xff, 0xf0, 0xff, 0xf0,         0x0f, 0xfc, 0xcc, 0x3c,
> -    0xcc, 0x33, 0xcc, 0xcf,         0xff, 0xef, 0xff, 0xee,
> -    0xff, 0xfd, 0xff, 0xfd,         0xdf, 0xff, 0xbf, 0xff,
> -    0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
> -};
> -
>   uint8_t sd_read_byte(SDState *sd)
>   {
>       /* TODO: Append CRCs */
> @@ -2142,6 +2138,7 @@ uint8_t sd_read_byte(SDState *sd)
>       case 9:  /* CMD9:   SEND_CSD */
>       case 10: /* CMD10:  SEND_CID */
>       case 17: /* CMD17:  READ_SINGLE_BLOCK */
> +    case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
>           sd_generic_read_byte(sd, &ret);
>           break;
>   
> @@ -2176,13 +2173,6 @@ uint8_t sd_read_byte(SDState *sd)
>           }
>           break;
>   
> -    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
> -        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
> -            sd->state = sd_transfer_state;
> -        }
> -        ret = sd_tuning_block_pattern[sd->data_offset++];
> -        break;
> -
>       case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
>           ret = sd->data[sd->data_offset ++];
>   


