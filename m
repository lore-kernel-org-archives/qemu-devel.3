Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06360C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh2G-0005yv-At; Fri, 21 Jun 2024 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1Q-0004Yc-KL; Fri, 21 Jun 2024 12:21:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh1O-0003jb-EJ; Fri, 21 Jun 2024 12:21:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5N0b6yHTz4wcq;
 Sat, 22 Jun 2024 02:21:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5N0Y4jTQz4wc5;
 Sat, 22 Jun 2024 02:21:49 +1000 (AEST)
Message-ID: <64e274c5-b0ff-4be2-bb20-3cccbfa9ddab@kaod.org>
Date: Fri, 21 Jun 2024 18:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report
 invalid mode switch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-19-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> Having the mode switch displayed help to track incomplete
> command implementations.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 75 +++++++++++++++++++++++++++++-------------------------
>   1 file changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 1df16ce6a2..8d63a39a54 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -180,6 +180,17 @@ static const char *sd_version_str(enum SDPhySpecificationVersion version)
>       return sdphy_version[version];
>   }
>   
> +static const char *sd_mode_name(enum SDCardModes mode)
> +{
> +    static const char *mode_name[] = {
> +        [sd_inactive]                   = "inactive",
> +        [sd_card_identification_mode]   = "identification",
> +        [sd_data_transfer_mode]         = "transfer",
> +    };
> +    assert(mode < ARRAY_SIZE(mode_name));
> +    return mode_name[mode];
> +}
> +
>   static const char *sd_state_name(enum SDCardStates state)
>   {
>       static const char *state_name[] = {
> @@ -1015,6 +1026,15 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
>       return sd_illegal;
>   }
>   
> +static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
> +                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
> +                  sd_version_str(sd->spec_version));
> +
> +    return sd_illegal;
> +}
> +
>   static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
> @@ -1154,18 +1174,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
> -        switch (sd->mode) {
> -        case sd_data_transfer_mode:
> -            sd_function_switch(sd, req.arg);
> -            sd->state = sd_sendingdata_state;
> -            sd->data_start = 0;
> -            sd->data_offset = 0;
> -            return sd_r1;
> -
> -        default:
> -            break;
> +        if (sd->mode != sd_data_transfer_mode) {
> +            return sd_invalid_mode_for_cmd(sd, req);
>           }
> -        break;
> +        sd_function_switch(sd, req.arg);
> +        sd->state = sd_sendingdata_state;
> +        sd->data_start = 0;
> +        sd->data_offset = 0;
> +        return sd_r1;
>   
>       case 7:  /* CMD7:   SELECT/DESELECT_CARD */
>           rca = sd_req_get_rca(sd, req);
> @@ -1289,33 +1305,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       case 13:  /* CMD13:  SEND_STATUS */
>           rca = sd_req_get_rca(sd, req);
> -        switch (sd->mode) {
> -        case sd_data_transfer_mode:
> -            if (!sd_is_spi(sd) && sd->rca != rca) {
> -                return sd_r0;
> -            }
> -
> -            return sd_r1;
> -
> -        default:
> -            break;
> +        if (sd->mode != sd_data_transfer_mode) {
> +            return sd_invalid_mode_for_cmd(sd, req);
>           }
> -        break;
> +        if (!sd_is_spi(sd) && sd->rca != rca) {
> +            return sd_r0;
> +        }
> +
> +        return sd_r1;
>   
>       case 15:  /* CMD15:  GO_INACTIVE_STATE */
> -        rca = sd_req_get_rca(sd, req);
> -        switch (sd->mode) {
> -        case sd_data_transfer_mode:
> -            if (sd->rca != rca)
> -                return sd_r0;
> -
> -            sd->state = sd_inactive_state;
> -            return sd_r0;
> -
> -        default:
> -            break;
> +        if (sd->mode != sd_data_transfer_mode) {
> +            return sd_invalid_mode_for_cmd(sd, req);
>           }
> -        break;
> +        rca = sd_req_get_rca(sd, req);
> +        if (sd->rca == rca) {
> +            sd->state = sd_inactive_state;
> +        }
> +        return sd_r0;
>   
>       /* Block read commands (Class 2) */
>       case 16:  /* CMD16:  SET_BLOCKLEN */


