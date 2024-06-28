Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21328C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6WG-0003aY-Aa; Fri, 28 Jun 2024 03:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6WD-0003a5-TH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6WB-0003Hk-UM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:59:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SWs2k03z4w2Q;
 Fri, 28 Jun 2024 17:59:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SWr1xRnz4w2K;
 Fri, 28 Jun 2024 17:59:35 +1000 (AEST)
Message-ID: <a0dd5ede-e9e7-4648-a298-b88edd82c5d4@kaod.org>
Date: Fri, 28 Jun 2024 09:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 49/98] hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler
 (CMD8)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-50-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-50-philmd@linaro.org>
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
>   hw/sd/sd.c | 43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 6ad98db981..e2f7e99ea2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
> +                                             [9]    = "SEND_CSD",
>           [10]    = "SEND_CID",
>           [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
>                                               [15]    = "GO_INACTIVE_STATE",
> @@ -1303,6 +1303,27 @@ static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
>       return sd_invalid_state_for_cmd(sd, req);
>   }
>   
> +/* CMD8 */
> +static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
> +{
> +    if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
> +        return sd_cmd_illegal(sd, req);
> +    }
> +    if (sd->state != sd_idle_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    sd->vhs = 0;
> +
> +    /* No response if not exactly one VHS bit is set.  */
> +    if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
> +        return sd_is_spi(sd) ? sd_r7 : sd_r0;
> +    }
> +
> +    /* Accept.  */
> +    sd->vhs = req.arg;
> +    return sd_r7;
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1369,24 +1390,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Basic commands (Class 0 and Class 1) */
> -    case 8:  /* CMD8:   SEND_IF_COND */
> -        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
> -            break;
> -        }
> -        if (sd->state != sd_idle_state) {
> -            break;
> -        }
> -        sd->vhs = 0;
> -
> -        /* No response if not exactly one VHS bit is set.  */
> -        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
> -            return sd_is_spi(sd) ? sd_r7 : sd_r0;
> -        }
> -
> -        /* Accept.  */
> -        sd->vhs = req.arg;
> -        return sd_r7;
> -
>       case 9:  /* CMD9:   SEND_CSD */
>           rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
> @@ -2278,6 +2281,7 @@ static const SDProto sd_proto_spi = {
>           [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>           [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
>           [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
> +        [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2302,6 +2306,7 @@ static const SDProto sd_proto_sd = {
>           [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
>           [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
>           [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
> +        [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
>           [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},


