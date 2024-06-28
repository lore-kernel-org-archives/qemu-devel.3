Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95192C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6ZG-0003ox-0h; Fri, 28 Jun 2024 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ZE-0003mJ-LI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ZC-0005nk-Ic
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:48 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SbS44ncz4wcS;
 Fri, 28 Jun 2024 18:02:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SbR1qDrz4wb7;
 Fri, 28 Jun 2024 18:02:42 +1000 (AEST)
Message-ID: <71b5e734-da14-417b-8876-cc0fde7c2dbd@kaod.org>
Date: Fri, 28 Jun 2024 10:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 64/98] hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-65-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-65-philmd@linaro.org>
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
>   hw/sd/sd.c | 53 ++++++++++++++++++++++++++++-------------------------
>   1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 4d78ac5b59..5461e56e17 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
>           [40]    = "DPS_spec",
> -        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
>           [56]    = "GEN_CMD",
>           [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
>           [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
> @@ -1624,9 +1623,34 @@ static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
>       return sd_cmd_to_receivingdata(sd, req, 0, 0);
>   }
>   
> +/* CMD55 */
> +static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
> +{
> +    switch (sd->state) {
> +    case sd_ready_state:
> +    case sd_identification_state:
> +    case sd_inactive_state:
> +        return sd_invalid_state_for_cmd(sd, req);
> +    case sd_idle_state:
> +        if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
> +        }
> +        /* fall-through */
> +    default:
> +        break;
> +    }
> +    if (!sd_is_spi(sd) && !sd_req_rca_same(sd, req)) {
> +        return sd_r0;
> +    }
> +    sd->expecting_acmd = true;
> +    sd->card_status |= APP_CMD;
> +
> +    return sd_r1;
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
> -    uint16_t rca;
>       uint64_t addr;
>   
>       sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
> @@ -1713,29 +1737,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
>       /* Application specific commands (Class 8) */
> -    case 55:  /* CMD55:  APP_CMD */
> -        rca = sd_req_get_rca(sd, req);
> -        switch (sd->state) {
> -        case sd_ready_state:
> -        case sd_identification_state:
> -            return sd_illegal;
> -        case sd_idle_state:
> -            if (rca) {
> -                qemu_log_mask(LOG_GUEST_ERROR,
> -                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
> -            }
> -        default:
> -            break;
> -        }
> -        if (!sd_is_spi(sd)) {
> -            if (sd->rca != rca) {
> -                return sd_r0;
> -            }
> -        }
> -        sd->expecting_acmd = true;
> -        sd->card_status |= APP_CMD;
> -        return sd_r1;
> -
>       case 56:  /* CMD56:  GEN_CMD */
>           switch (sd->state) {
>           case sd_transfer_state:
> @@ -2321,6 +2322,7 @@ static const SDProto sd_proto_spi = {
>           [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
>           [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
>           [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
> +        [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
>           [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
>       },
>       .acmd = {
> @@ -2373,6 +2375,7 @@ static const SDProto sd_proto_sd = {
>           [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
>           [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
>           [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
> +        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
>           [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
>           [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
>           [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},


