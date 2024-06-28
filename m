Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D9C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Pf-00039A-Cq; Fri, 28 Jun 2024 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Pa-000359-Lh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6PY-00082u-Up
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SMy6NNlz4wcS;
 Fri, 28 Jun 2024 17:52:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SMx6Cg3z4wc8;
 Fri, 28 Jun 2024 17:52:45 +1000 (AEST)
Message-ID: <5e86820f-a9f0-45e1-a98b-a981836c21e5@kaod.org>
Date: Fri, 28 Jun 2024 09:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 37/98] hw/sd/sdcard: Pass SDState as argument to
 sd_[a]cmd_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-38-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-38-philmd@linaro.org>
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
> In order to access SDState::SDProto from sd_[a]cmd_name(),
> pass SDState as argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 93a4a4e1b4..f4bdd12b26 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -233,7 +233,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>       return response_name[rsp];
>   }
>   
> -static const char *sd_cmd_name(uint8_t cmd)
> +static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
>            [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
> @@ -272,7 +272,7 @@ static const char *sd_cmd_name(uint8_t cmd)
>       return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
>   }
>   
> -static const char *sd_acmd_name(uint8_t cmd)
> +static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
>            [6] = "SET_BUS_WIDTH",
> @@ -1281,7 +1281,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       uint64_t addr;
>       uint32_t data;
>   
> -    sd->last_cmd_name = sd_cmd_name(req.cmd);
> +    sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.
>        * However there is no ACMD55, so we want to trace this particular case.
>        */
> @@ -1748,7 +1748,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_app_command(SDState *sd,
>                                       SDRequest req)
>   {
> -    sd->last_cmd_name = sd_acmd_name(req.cmd);
> +    sd->last_cmd_name = sd_acmd_name(sd, req.cmd);
>       trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
>                                req.cmd, req.arg, sd_state_name(sd->state));
>       sd->card_status |= APP_CMD;


