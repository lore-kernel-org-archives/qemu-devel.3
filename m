Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2BCC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Q1-0003ai-2L; Fri, 28 Jun 2024 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Pz-0003XQ-OE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:53:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Px-0000GR-Uj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:53:15 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SNK2VH0z4wb7;
 Fri, 28 Jun 2024 17:53:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SNJ2Ppwz4w2H;
 Fri, 28 Jun 2024 17:53:04 +1000 (AEST)
Message-ID: <a4014d4e-738d-4603-903c-7ef3bf9dcf8d@kaod.org>
Date: Fri, 28 Jun 2024 09:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 38/98] hw/sd/sdcard: Prepare SDProto to contain more
 fields
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-39-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-39-philmd@linaro.org>
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
> Convert array of command handlers to array of structures.
> The structure contains the command handler. No logical
> change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f4bdd12b26..558c39419d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -94,8 +94,9 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
>   
>   typedef struct SDProto {
>       const char *name;
> -    sd_cmd_handler cmd[SDMMC_CMD_MAX];
> -    sd_cmd_handler acmd[SDMMC_CMD_MAX];
> +    struct {
> +        sd_cmd_handler handler;
> +    } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
>   } SDProto;
>   
>   struct SDState {
> @@ -1305,8 +1306,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_illegal;
>       }
>   
> -    if (sd->proto->cmd[req.cmd]) {
> -        return sd->proto->cmd[req.cmd](sd, req);
> +    if (sd->proto->cmd[req.cmd].handler) {
> +        return sd->proto->cmd[req.cmd].handler(sd, req);
>       }
>   
>       switch (req.cmd) {
> @@ -1753,8 +1754,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>                                req.cmd, req.arg, sd_state_name(sd->state));
>       sd->card_status |= APP_CMD;
>   
> -    if (sd->proto->acmd[req.cmd]) {
> -        return sd->proto->acmd[req.cmd](sd, req);
> +    if (sd->proto->acmd[req.cmd].handler) {
> +        return sd->proto->acmd[req.cmd].handler(sd, req);
>       }
>   
>       switch (req.cmd) {
> @@ -2267,22 +2268,22 @@ void sd_enable(SDState *sd, bool enable)
>   static const SDProto sd_proto_spi = {
>       .name = "SPI",
>       .cmd = {
> -        [0]         = sd_cmd_GO_IDLE_STATE,
> -        [1]         = spi_cmd_SEND_OP_COND,
> +        [0]  = {sd_cmd_GO_IDLE_STATE},
> +        [1]  = {spi_cmd_SEND_OP_COND},
>       },
>       .acmd = {
> -        [41]        = spi_cmd_SEND_OP_COND,
> +        [41] = {spi_cmd_SEND_OP_COND},
>       },
>   };
>   
>   static const SDProto sd_proto_sd = {
>       .name = "SD",
>       .cmd = {
> -        [0]         = sd_cmd_GO_IDLE_STATE,
> -        [2]         = sd_cmd_ALL_SEND_CID,
> -        [3]         = sd_cmd_SEND_RELATIVE_ADDR,
> -        [19]        = sd_cmd_SEND_TUNING_BLOCK,
> -        [23]        = sd_cmd_SET_BLOCK_COUNT,
> +        [0]  = {sd_cmd_GO_IDLE_STATE},
> +        [2]  = {sd_cmd_ALL_SEND_CID},
> +        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
> +        [19] = {sd_cmd_SEND_TUNING_BLOCK},
> +        [23] = {sd_cmd_SET_BLOCK_COUNT},
>       },
>   };
>   


