Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90166C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN661-0000RQ-LF; Fri, 28 Jun 2024 03:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN65k-00009L-W1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:32:23 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN65j-0007in-2W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:32:20 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9RwH3Nsdz4wcC;
 Fri, 28 Jun 2024 17:32:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9RwG3LFQz4wcg;
 Fri, 28 Jun 2024 17:32:14 +1000 (AEST)
Message-ID: <24f42c6c-c28e-4e23-9d78-aac2f0b315b2@kaod.org>
Date: Fri, 28 Jun 2024 09:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 11/98] hw/sd/sdcard: Simplify sd_inactive_state
 handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-12-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-12-philmd@linaro.org>
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> Card entering sd_inactive_state powers off, and won't respond
> anymore. Handle that once when entering sd_do_command().
> 
> Remove condition always true in sd_cmd_GO_IDLE_STATE().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index fbdfafa3a6..7533a78cf6 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1081,10 +1081,8 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   /* CMD0 */
>   static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_inactive_state) {
> -        sd->state = sd_idle_state;
> -        sd_reset(DEVICE(sd));
> -    }
> +    sd->state = sd_idle_state;
> +    sd_reset(DEVICE(sd));
>   
>       return sd_is_spi(sd) ? sd_r1 : sd_r0;
>   }
> @@ -1579,7 +1577,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           switch (sd->state) {
>           case sd_ready_state:
>           case sd_identification_state:
> -        case sd_inactive_state:
>               return sd_illegal;
>           case sd_idle_state:
>               if (rca) {
> @@ -1800,6 +1797,11 @@ int sd_do_command(SDState *sd, SDRequest *req,
>           return 0;
>       }
>   
> +    if (sd->state == sd_inactive_state) {
> +        rtype = sd_illegal;
> +        goto send_response;
> +    }
> +
>       if (sd_req_crc_validate(req)) {
>           sd->card_status |= COM_CRC_ERROR;
>           rtype = sd_illegal;


