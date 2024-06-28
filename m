Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753A7C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6W7-0003By-RF; Fri, 28 Jun 2024 03:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6W2-0003BN-T1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6W0-000363-5P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SWf16nQz4w2Q;
 Fri, 28 Jun 2024 17:59:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SWd0RXdz4w2K;
 Fri, 28 Jun 2024 17:59:24 +1000 (AEST)
Message-ID: <52027774-6f66-418d-bb10-501449090a1c@kaod.org>
Date: Fri, 28 Jun 2024 09:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 48/98] hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler
 (CMD7)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-49-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-49-philmd@linaro.org>
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
>   hw/sd/sd.c | 85 ++++++++++++++++++++++++++++++------------------------
>   1 file changed, 47 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 61c9aff2fb..6ad98db981 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -                                             [7]    = "SELECT/DESELECT_CARD",
>            [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
>           [10]    = "SEND_CID",
>           [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
> @@ -558,6 +557,11 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
>       }
>   }
>   
> +static bool sd_req_rca_same(SDState *s, SDRequest req)
> +{
> +    return sd_req_get_rca(s, req) == s->rca;
> +}
> +
>   /* Card Status register */
>   
>   FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
> @@ -1258,6 +1262,47 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
>       return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
>   }
>   
> +/* CMD7 */
> +static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
> +{
> +    bool same_rca = sd_req_rca_same(sd, req);
> +
> +    switch (sd->state) {
> +    case sd_standby_state:
> +        if (!same_rca) {
> +            return sd_r0;
> +        }
> +        sd->state = sd_transfer_state;
> +        return sd_r1b;
> +
> +    case sd_transfer_state:
> +    case sd_sendingdata_state:
> +        if (same_rca) {
> +            break;
> +        }
> +        sd->state = sd_standby_state;
> +        return sd_r1b;
> +
> +    case sd_disconnect_state:
> +        if (!same_rca) {
> +            return sd_r0;
> +        }
> +        sd->state = sd_programming_state;
> +        return sd_r1b;
> +
> +    case sd_programming_state:
> +        if (same_rca) {
> +            break;
> +        }
> +        sd->state = sd_disconnect_state;
> +        return sd_r1b;
> +
> +    default:
> +        break;
> +    }
> +    return sd_invalid_state_for_cmd(sd, req);
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1324,43 +1369,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Basic commands (Class 0 and Class 1) */
> -    case 7:  /* CMD7:   SELECT/DESELECT_CARD */
> -        rca = sd_req_get_rca(sd, req);
> -        switch (sd->state) {
> -        case sd_standby_state:
> -            if (sd->rca != rca)
> -                return sd_r0;
> -
> -            sd->state = sd_transfer_state;
> -            return sd_r1b;
> -
> -        case sd_transfer_state:
> -        case sd_sendingdata_state:
> -            if (sd->rca == rca)
> -                break;
> -
> -            sd->state = sd_standby_state;
> -            return sd_r1b;
> -
> -        case sd_disconnect_state:
> -            if (sd->rca != rca)
> -                return sd_r0;
> -
> -            sd->state = sd_programming_state;
> -            return sd_r1b;
> -
> -        case sd_programming_state:
> -            if (sd->rca == rca)
> -                break;
> -
> -            sd->state = sd_disconnect_state;
> -            return sd_r1b;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 8:  /* CMD8:   SEND_IF_COND */
>           if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
>               break;
> @@ -2293,6 +2301,7 @@ static const SDProto sd_proto_sd = {
>           [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
>           [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
>           [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
> +        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
>           [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},


