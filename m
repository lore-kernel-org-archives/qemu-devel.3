Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5874DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6L2-0003vh-9W; Fri, 28 Jun 2024 03:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6L0-0003t4-1A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:48:06 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Ky-0005vI-2l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:48:05 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SGV0KhXz4wb7;
 Fri, 28 Jun 2024 17:48:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SGT06qcz4w2K;
 Fri, 28 Jun 2024 17:48:00 +1000 (AEST)
Message-ID: <314d514d-2a65-497f-a59b-ae4f8241f116@kaod.org>
Date: Fri, 28 Jun 2024 09:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 26/98] hw/sd/sdcard: Convert SD_STATUS to
 generic_read_byte (ACMD13)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-27-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-27-philmd@linaro.org>
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ccf81b9e59..1c4811f410 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1703,10 +1703,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       case 13:  /* ACMD13: SD_STATUS */
>           switch (sd->state) {
>           case sd_transfer_state:
> -            sd->state = sd_sendingdata_state;
> -            sd->data_start = 0;
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            return sd_cmd_to_sendingdata(sd, req, 0,
> +                                         sd->sd_status,
> +                                         sizeof(sd->sd_status));
>   
>           default:
>               break;
> @@ -2136,6 +2135,7 @@ uint8_t sd_read_byte(SDState *sd)
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
>       case 9:  /* CMD9:   SEND_CSD */
>       case 10: /* CMD10:  SEND_CID */
> +    case 13: /* ACMD13: SD_STATUS */
>       case 17: /* CMD17:  READ_SINGLE_BLOCK */
>       case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
>       case 30: /* CMD30:  SEND_WRITE_PROT */
> @@ -2143,13 +2143,6 @@ uint8_t sd_read_byte(SDState *sd)
>           sd_generic_read_byte(sd, &ret);
>           break;
>   
> -    case 13:  /* ACMD13: SD_STATUS */
> -        ret = sd->sd_status[sd->data_offset ++];
> -
> -        if (sd->data_offset >= sizeof(sd->sd_status))
> -            sd->state = sd_transfer_state;
> -        break;
> -
>       case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
>           if (sd->data_offset == 0) {
>               if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",


