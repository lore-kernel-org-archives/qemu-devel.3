Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E7CC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Kd-0002av-8Y; Fri, 28 Jun 2024 03:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6KJ-0002Rx-Fh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:47:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6KH-0004wi-Ra
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:47:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SFg6D7xz4w2N;
 Fri, 28 Jun 2024 17:47:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SFf5DlKz4w2K;
 Fri, 28 Jun 2024 17:47:18 +1000 (AEST)
Message-ID: <0b9e6152-9864-4339-ade6-99f04168b477@kaod.org>
Date: Fri, 28 Jun 2024 09:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 24/98] hw/sd/sdcard: Convert SEND_WRITE_PROT to
 generic_read_byte (CMD30)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-25-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-25-philmd@linaro.org>
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index eece33194a..bf922da2cc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1202,6 +1202,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
>       uint64_t addr;
> +    uint32_t data;
>   
>       sd->last_cmd_name = sd_cmd_name(req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.
> @@ -1555,12 +1556,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>                                     req.arg, sd->blk_len)) {
>                   return sd_r1;
>               }
> -
> -            sd->state = sd_sendingdata_state;
> -            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
> -            sd->data_start = addr;
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            data = sd_wpbits(sd, req.arg);
> +            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
>   
>           default:
>               break;
> @@ -2139,6 +2136,7 @@ uint8_t sd_read_byte(SDState *sd)
>       case 10: /* CMD10:  SEND_CID */
>       case 17: /* CMD17:  READ_SINGLE_BLOCK */
>       case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
> +    case 30: /* CMD30:  SEND_WRITE_PROT */
>           sd_generic_read_byte(sd, &ret);
>           break;
>   
> @@ -2180,13 +2178,6 @@ uint8_t sd_read_byte(SDState *sd)
>               sd->state = sd_transfer_state;
>           break;
>   
> -    case 30:  /* CMD30:  SEND_WRITE_PROT */
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= 4)
> -            sd->state = sd_transfer_state;
> -        break;
> -
>       case 51:  /* ACMD51: SEND_SCR */
>           ret = sd->scr[sd->data_offset ++];
>   


