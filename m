Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01646C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Xx-0007lh-4H; Fri, 28 Jun 2024 04:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Xv-0007aH-Qu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:27 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Xt-0004jK-KC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:27 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SYv4NsRz4wb7;
 Fri, 28 Jun 2024 18:01:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SYt3pl0z4w2N;
 Fri, 28 Jun 2024 18:01:22 +1000 (AEST)
Message-ID: <cf4b0d01-73e6-416e-b868-80670f34afbf@kaod.org>
Date: Fri, 28 Jun 2024 10:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 56/98] hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK
 handler (CMD17)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-57-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-57-philmd@linaro.org>
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
>   hw/sd/sd.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d731c3df58..e2a7ed8b45 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -                                            [17]    = "READ_SINGLE_BLOCK",
>           [18]    = "READ_MULTIPLE_BLOCK",
>                                               [21]    = "DPS_spec",
>           [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
> @@ -1441,6 +1440,24 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* CMD17 */
> +static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
> +{
> +    uint64_t addr;
> +
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    addr = sd_req_get_address(sd, req);
> +    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
> +        return sd_r1;
> +    }
> +
> +    sd_blk_read(sd, addr, sd->blk_len);
> +    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
> +}
> +
>   /* CMD19 */
>   static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
>   {
> @@ -1507,22 +1524,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Block read commands (Class 2) */
> -    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
> -        addr = sd_req_get_address(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -
> -            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
> -                return sd_r1;
> -            }
> -            sd_blk_read(sd, addr, sd->blk_len);
> -            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
>           addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
> @@ -2306,6 +2307,7 @@ static const SDProto sd_proto_spi = {
>           [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
>           [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
>           [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
> +        [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2338,6 +2340,7 @@ static const SDProto sd_proto_sd = {
>           [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
>           [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
>           [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
> +        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},


