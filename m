Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D0AC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6SP-0006Mo-Cg; Fri, 28 Jun 2024 03:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6SM-0006Lo-HN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:42 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6SJ-0001CL-9r
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SRD4kFmz4w2K;
 Fri, 28 Jun 2024 17:55:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SRC3zjFz4w2Q;
 Fri, 28 Jun 2024 17:55:35 +1000 (AEST)
Message-ID: <454be083-c7fa-40aa-b18e-50aea6be0e62@kaod.org>
Date: Fri, 28 Jun 2024 09:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 41/98] hw/sd/sdcard: Store command class in SDProto
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-42-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-42-philmd@linaro.org>
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
> Store the command class altogether with the other command
> fields (handler, name and type).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c4cc48926d..a816493d37 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
>   typedef struct SDProto {
>       const char *name;
>       struct {
> +        const unsigned class;
>           const sd_cmd_type_t type;
>           const char *name;
>           sd_cmd_handler handler;
> @@ -352,13 +353,6 @@ static void sd_set_mode(SDState *sd)
>       }
>   }
>   
> -static const int sd_cmd_class[SDMMC_CMD_MAX] = {
> -    0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
> -    2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
> -    5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
> -    7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
> -};
> -
>   static uint8_t sd_crc7(const void *message, size_t width)
>   {
>       int i, bit;
> @@ -1306,7 +1300,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           sd->multi_blk_cnt = 0;
>       }
>   
> -    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
> +    if (sd->proto->cmd[req.cmd].class == 6 && FIELD_EX32(sd->ocr, OCR,
> +                                                         CARD_CAPACITY)) {
>           /* Only Standard Capacity cards support class 6 commands */
>           return sd_illegal;
>       }
> @@ -1891,6 +1886,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>   
>   static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
>   {
> +    unsigned cmd_class;
> +
>       /* Valid commands in locked state:
>        * basic class (0)
>        * lock card class (7)
> @@ -1905,7 +1902,12 @@ static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
>       if (cmd == 16 || cmd == 55) {
>           return true;
>       }
> -    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
> +    if (!sd->proto->cmd[cmd].handler) {
> +        return false;
> +    }
> +    cmd_class = sd->proto->cmd[cmd].class;
> +
> +    return cmd_class == 0 || cmd_class == 7;
>   }
>   
>   int sd_do_command(SDState *sd, SDRequest *req,
> @@ -2273,22 +2275,22 @@ void sd_enable(SDState *sd, bool enable)
>   static const SDProto sd_proto_spi = {
>       .name = "SPI",
>       .cmd = {
> -        [0]  = {    sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> -        [1]  = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> +        [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>       .acmd = {
> -        [41] = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> +        [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>   };
>   
>   static const SDProto sd_proto_sd = {
>       .name = "SD",
>       .cmd = {
> -        [0]  = {    sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> -        [2]  = {    sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
> -        [3]  = {    sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> -        [19] = {    sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> -        [23] = {    sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
> +        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
> +        [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> +        [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> +        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>       },
>   };
>   


