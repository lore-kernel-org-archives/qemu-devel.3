Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA69BC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6RC-0004og-8y; Fri, 28 Jun 2024 03:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6RA-0004nv-Fy
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:54:28 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6R8-0000dC-FM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:54:28 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SPr3B2Cz4wb7;
 Fri, 28 Jun 2024 17:54:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SPp6yMcz4w2H;
 Fri, 28 Jun 2024 17:54:22 +1000 (AEST)
Message-ID: <c2af3123-6dba-4d8f-9879-c9d002401f98@kaod.org>
Date: Fri, 28 Jun 2024 09:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 39/98] hw/sd/sdcard: Store command name in SDProto
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-40-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-40-philmd@linaro.org>
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
> We already have a const array where command handlers
> are listed. Store the command name there too.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 35 ++++++++++++++++++++++-------------
>   1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 558c39419d..97fb3785ee 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
>   typedef struct SDProto {
>       const char *name;
>       struct {
> +        const char *name;
>           sd_cmd_handler handler;
>       } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
>   } SDProto;
> @@ -237,8 +238,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
> -         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
>            [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
>            [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
>            [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
> @@ -246,9 +245,8 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>           [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
>                                               [15]    = "GO_INACTIVE_STATE",
>           [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
> -        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
> +        [18]    = "READ_MULTIPLE_BLOCK",
>           [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
> -                                            [23]    = "SET_BLOCK_COUNT",
>           [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
>           [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
> @@ -270,6 +268,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>           [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
>           [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
>       };
> +    const SDProto *sdp = sd->proto;
> +
> +    if (sdp->cmd[cmd].handler) {
> +        assert(!cmd_abbrev[cmd]);
> +        return sdp->cmd[cmd].name;
> +    }
>       return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
>   }
>   
> @@ -282,7 +286,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>           [16] = "DPS_spec",
>           [18] = "SECU_spec",
>           [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
> -        [41] = "SD_SEND_OP_COND",
>           [42] = "SET_CLR_CARD_DETECT",
>           [51] = "SEND_SCR",
>           [52] = "SECU_spec",                 [53] = "SECU_spec",
> @@ -290,6 +293,12 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>           [56] = "SECU_spec",                 [57] = "SECU_spec",
>           [58] = "SECU_spec",                 [59] = "SECU_spec",
>       };
> +    const SDProto *sdp = sd->proto;
> +
> +    if (sdp->acmd[cmd].handler) {
> +        assert(!acmd_abbrev[cmd]);
> +        return sdp->acmd[cmd].name;
> +    }
>   
>       return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
>   }
> @@ -2268,22 +2277,22 @@ void sd_enable(SDState *sd, bool enable)
>   static const SDProto sd_proto_spi = {
>       .name = "SPI",
>       .cmd = {
> -        [0]  = {sd_cmd_GO_IDLE_STATE},
> -        [1]  = {spi_cmd_SEND_OP_COND},
> +        [0]  = {            "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [1]  = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>       .acmd = {
> -        [41] = {spi_cmd_SEND_OP_COND},
> +        [41] = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>   };
>   
>   static const SDProto sd_proto_sd = {
>       .name = "SD",
>       .cmd = {
> -        [0]  = {sd_cmd_GO_IDLE_STATE},
> -        [2]  = {sd_cmd_ALL_SEND_CID},
> -        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
> -        [19] = {sd_cmd_SEND_TUNING_BLOCK},
> -        [23] = {sd_cmd_SET_BLOCK_COUNT},
> +        [0]  = {             "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [2]  = {             "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
> +        [3]  = {             "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> +        [19] = {             "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> +        [23] = {             "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>       },
>   };
>   


