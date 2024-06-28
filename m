Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AE6C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Xm-000760-3N; Fri, 28 Jun 2024 04:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Xk-0006ze-Fq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Xi-0004iL-B2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:16 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SYh25J5z4w2N;
 Fri, 28 Jun 2024 18:01:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SYg26BXz4wc8;
 Fri, 28 Jun 2024 18:01:10 +1000 (AEST)
Message-ID: <973b22fd-b111-4ba0-b887-57bf26850a58@kaod.org>
Date: Fri, 28 Jun 2024 10:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 55/98] hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler
 (CMD16)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-56-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-56-philmd@linaro.org>
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
>   hw/sd/sd.c | 37 +++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7ed8aee73..d731c3df58 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
> +                                            [17]    = "READ_SINGLE_BLOCK",
>           [18]    = "READ_MULTIPLE_BLOCK",
>                                               [21]    = "DPS_spec",
>           [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
> @@ -1425,6 +1425,22 @@ static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
>       return sd_r0;
>   }
>   
> +/* CMD16 */
> +static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    if (req.arg > (1 << HWBLOCK_SHIFT)) {
> +        sd->card_status |= BLOCK_LEN_ERROR;
> +    } else {
> +        trace_sdcard_set_blocklen(req.arg);
> +        sd->blk_len = req.arg;
> +    }
> +
> +    return sd_r1;
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1491,23 +1507,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Block read commands (Class 2) */
> -    case 16:  /* CMD16:  SET_BLOCKLEN */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (req.arg > (1 << HWBLOCK_SHIFT)) {
> -                sd->card_status |= BLOCK_LEN_ERROR;
> -            } else {
> -                trace_sdcard_set_blocklen(req.arg);
> -                sd->blk_len = req.arg;
> -            }
> -
> -            return sd_r1;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 17:  /* CMD17:  READ_SINGLE_BLOCK */
>           addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
> @@ -2306,6 +2305,7 @@ static const SDProto sd_proto_spi = {
>           [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
>           [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
>           [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
> +        [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2337,6 +2337,7 @@ static const SDProto sd_proto_sd = {
>           [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
>           [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
>           [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
> +        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},


