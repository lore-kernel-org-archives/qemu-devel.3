Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C357EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6J1-0008LM-N0; Fri, 28 Jun 2024 03:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6J0-0008I3-3u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:46:02 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Iy-0004ni-GK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:46:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SD53c1qz4wc8;
 Fri, 28 Jun 2024 17:45:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SD41GGjz4wb7;
 Fri, 28 Jun 2024 17:45:55 +1000 (AEST)
Message-ID: <2f5c0c44-2f33-480e-aa1f-ca5ecce5ef55@kaod.org>
Date: Fri, 28 Jun 2024 09:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 20/98] hw/sd/sdcard: Convert SEND_CSD/SEND_CID to
 generic_read_byte (CMD9 & 10)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-21-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-21-philmd@linaro.org>
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
>   hw/sd/sd.c | 24 ++++++------------------
>   1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f7735c39a8..8201f3245c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1312,11 +1312,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>               if (!sd_is_spi(sd)) {
>                   break;
>               }
> -            sd->state = sd_sendingdata_state;
> -            memcpy(sd->data, sd->csd, 16);
> -            sd->data_start = sd_req_get_address(sd, req);
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> +                                         sd->csd, 16);
>   
>           default:
>               break;
> @@ -1336,11 +1333,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>               if (!sd_is_spi(sd)) {
>                   break;
>               }
> -            sd->state = sd_sendingdata_state;
> -            memcpy(sd->data, sd->cid, 16);
> -            sd->data_start = sd_req_get_address(sd, req);
> -            sd->data_offset = 0;
> -            return sd_r1;
> +            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> +                                         sd->cid, 16);
>   
>           default:
>               break;
> @@ -2130,15 +2124,9 @@ uint8_t sd_read_byte(SDState *sd)
>                              sd->current_cmd, sd->data_offset, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
> -        sd_generic_read_byte(sd, &ret);
> -        break;
> -
>       case 9:  /* CMD9:   SEND_CSD */
> -    case 10:  /* CMD10:  SEND_CID */
> -        ret = sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >= 16)
> -            sd->state = sd_transfer_state;
> +    case 10: /* CMD10:  SEND_CID */
> +        sd_generic_read_byte(sd, &ret);
>           break;
>   
>       case 13:  /* ACMD13: SD_STATUS */


