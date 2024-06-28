Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBAC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN64X-00080O-6E; Fri, 28 Jun 2024 03:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN64R-0007yE-2y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:30:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN64M-0007YM-35
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:30:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Rth0HPmz4wcC;
 Fri, 28 Jun 2024 17:30:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Rtg0Bcyz4wc8;
 Fri, 28 Jun 2024 17:30:50 +1000 (AEST)
Message-ID: <4e026c16-4f08-46fa-a3ca-4a43591c81b9@kaod.org>
Date: Fri, 28 Jun 2024 09:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 03/98] hw/sd/sdcard: Track last command used to help
 logging
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-4-philmd@linaro.org>
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> The command is selected on the I/O lines, and further
> processing might be done on the DAT lines via the
> sd_read_byte() and sd_write_byte() handlers. Since
> these methods can't distinct between normal and APP
> commands, keep the name of the current command in
> the SDState and use it in the DAT handlers. This
> fixes a bug that all normal commands were displayed
> as APP commands.
> 
> Fixes: 2ed61fb57b ("sdcard: Display command name when tracing CMD/ACMD")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d0a1d5db18..bc87807793 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -133,6 +133,7 @@ struct SDState {
>       uint32_t pwd_len;
>       uint8_t function_group[6];
>       uint8_t current_cmd;
> +    const char *last_cmd_name;
>       /* True if we will handle the next command as an ACMD. Note that this does
>        * *not* track the APP_CMD status bit!
>        */
> @@ -1154,12 +1155,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       uint16_t rca;
>       uint64_t addr;
>   
> +    sd->last_cmd_name = sd_cmd_name(req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.
>        * However there is no ACMD55, so we want to trace this particular case.
>        */
>       if (req.cmd != 55 || sd->expecting_acmd) {
>           trace_sdcard_normal_command(sd_proto(sd)->name,
> -                                    sd_cmd_name(req.cmd), req.cmd,
> +                                    sd->last_cmd_name, req.cmd,
>                                       req.arg, sd_state_name(sd->state));
>       }
>   
> @@ -1620,7 +1622,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_app_command(SDState *sd,
>                                       SDRequest req)
>   {
> -    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
> +    sd->last_cmd_name = sd_acmd_name(req.cmd);
> +    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
>                                req.cmd, req.arg, sd_state_name(sd->state));
>       sd->card_status |= APP_CMD;
>   
> @@ -1913,7 +1916,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           return;
>   
>       trace_sdcard_write_data(sd_proto(sd)->name,
> -                            sd_acmd_name(sd->current_cmd),
> +                            sd->last_cmd_name,
>                               sd->current_cmd, value);
>       switch (sd->current_cmd) {
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
> @@ -2069,7 +2072,7 @@ uint8_t sd_read_byte(SDState *sd)
>       io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
>   
>       trace_sdcard_read_data(sd_proto(sd)->name,
> -                           sd_acmd_name(sd->current_cmd),
> +                           sd->last_cmd_name,
>                              sd->current_cmd, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
> @@ -2214,6 +2217,7 @@ static void sd_instance_init(Object *obj)
>   {
>       SDState *sd = SD_CARD(obj);
>   
> +    sd->last_cmd_name = "UNSET";
>       sd->enable = true;
>       sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
>   }


