Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C8C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6OC-0007NQ-W5; Fri, 28 Jun 2024 03:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6OB-0007LJ-U2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:23 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6OA-0006wy-6V
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SLJ1Qxcz4wb7;
 Fri, 28 Jun 2024 17:51:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SLG3M5fz4w2H;
 Fri, 28 Jun 2024 17:51:18 +1000 (AEST)
Message-ID: <59e5fa54-e0df-43a0-bdd5-7bd507086b05@kaod.org>
Date: Fri, 28 Jun 2024 09:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 32/98] hw/sd/sdcard: Convert PROGRAM_CID to
 generic_write_byte (CMD26)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-33-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-33-philmd@linaro.org>
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 4a03f41086..b9c72a0128 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1515,17 +1515,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 26:  /* CMD26:  PROGRAM_CID */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            sd->state = sd_receivingdata_state;
> -            sd->data_start = 0;
> -            sd->data_offset = 0;
> -            return sd_r1;
> -
> -        default:
> -            break;
> -        }
> -        break;
> +        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
>       case 27:  /* CMD27:  PROGRAM_CSD */
>           switch (sd->state) {
> @@ -2088,8 +2078,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 26:  /* CMD26:  PROGRAM_CID */
> -        sd->data[sd->data_offset ++] = value;
> -        if (sd->data_offset >= sizeof(sd->cid)) {
> +        if (sd_generic_write_byte(sd, value)) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               for (i = 0; i < sizeof(sd->cid); i ++)


