Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DB7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6WO-00044n-Tn; Fri, 28 Jun 2024 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6WM-0003v9-Up
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:50 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6WK-0003dW-PJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SX2588yz4w2Q;
 Fri, 28 Jun 2024 17:59:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SX155krz4w2K;
 Fri, 28 Jun 2024 17:59:45 +1000 (AEST)
Message-ID: <3f065fa6-d022-4f16-a15f-f79b6800795a@kaod.org>
Date: Fri, 28 Jun 2024 09:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 50/98] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-51-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-51-philmd@linaro.org>
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
>   hw/sd/sd.c | 36 ++++++++++++++++++++++--------------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index e2f7e99ea2..bd7c7cf518 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,8 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -                                             [9]    = "SEND_CSD",
> -        [10]    = "SEND_CID",
>           [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
>                                               [15]    = "GO_INACTIVE_STATE",
>           [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
> @@ -1324,6 +1322,26 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
>       return sd_r7;
>   }
>   
> +/* CMD9 */
> +static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_standby_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    return sd_req_rca_same(sd, req) ? sd_r2_s : sd_r0;
> +}
> +
> +/* CMD10 */
> +static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_standby_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1393,12 +1411,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 9:  /* CMD9:   SEND_CSD */
>           rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
> -        case sd_standby_state:
> -            if (sd->rca != rca)
> -                return sd_r0;
> -
> -            return sd_r2_s;
> -
>           case sd_transfer_state:
>               if (!sd_is_spi(sd)) {
>                   break;
> @@ -1414,12 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 10:  /* CMD10:  SEND_CID */
>           rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
> -        case sd_standby_state:
> -            if (sd->rca != rca)
> -                return sd_r0;
> -
> -            return sd_r2_i;
> -
>           case sd_transfer_state:
>               if (!sd_is_spi(sd)) {
>                   break;
> @@ -2307,6 +2313,8 @@ static const SDProto sd_proto_sd = {
>           [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
>           [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
>           [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
> +        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
> +        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
>           [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},


