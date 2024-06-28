Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70451C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Or-0001OE-D0; Fri, 28 Jun 2024 03:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Oq-0001KH-Ak
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Oo-0007LT-Me
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:04 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SM44hVxz4w2K;
 Fri, 28 Jun 2024 17:52:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SM34kWdz4w2H;
 Fri, 28 Jun 2024 17:51:59 +1000 (AEST)
Message-ID: <e067cdb4-e1fa-40d2-968a-4a44eab3ca64@kaod.org>
Date: Fri, 28 Jun 2024 09:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 35/98] hw/sd/sdcard: Convert GEN_CMD to
 generic_write_byte (CMD56)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-36-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-36-philmd@linaro.org>
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
>   hw/sd/sd.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 0cb528b0b2..f9708064d0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1657,14 +1657,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 56:  /* CMD56:  GEN_CMD */
>           switch (sd->state) {
>           case sd_transfer_state:
> -            sd->data_offset = 0;
>               if (req.arg & 1) {
>                   return sd_cmd_to_sendingdata(sd, req, 0,
>                                                sd->vendor_data,
>                                                sizeof(sd->vendor_data));
>               }
> -            sd->state = sd_receivingdata_state;
> -            return sd_r1;
> +            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
>   
>           default:
>               break;
> @@ -2109,9 +2107,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 56:  /* CMD56:  GEN_CMD */
> -        sd->vendor_data[sd->data_offset ++] = value;
> -        if (sd->data_offset >= sizeof(sd->vendor_data)) {
> -            sd->state = sd_transfer_state;
> +        if (sd_generic_write_byte(sd, value)) {
> +            memcpy(sd->vendor_data, sd->data, sizeof(sd->vendor_data));
>           }
>           break;
>   


