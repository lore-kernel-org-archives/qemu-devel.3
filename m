Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF3CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Rj-0005XS-Mx; Fri, 28 Jun 2024 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Ri-0005XB-5G
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:02 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Rg-0000lL-3j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:55:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SQV0jkHz4wb7;
 Fri, 28 Jun 2024 17:54:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SQT0l5Gz4w2K;
 Fri, 28 Jun 2024 17:54:56 +1000 (AEST)
Message-ID: <f613d956-1627-4c18-988c-3f367511db50@kaod.org>
Date: Fri, 28 Jun 2024 09:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 40/98] hw/sd/sdcard: Store command type in SDProto
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-41-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-41-philmd@linaro.org>
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
> Store the command type altogether with the command handler and name.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/sd/sd.h |  5 +++--
>   hw/sd/sd.c         | 44 ++++++++++++++++++++------------------------
>   2 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 2c8748fb9b..29c76935a0 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -76,8 +76,9 @@ typedef enum  {
>   } sd_uhs_mode_t;
>   
>   typedef enum {
> -    sd_none = -1,
> -    sd_bc = 0, /* broadcast -- no response */
> +    sd_none = 0,
> +    sd_spi,
> +    sd_bc,     /* broadcast -- no response */
>       sd_bcr,    /* broadcast with response */
>       sd_ac,     /* addressed -- no data transfer */
>       sd_adtc,   /* addressed with data transfer */
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 97fb3785ee..c4cc48926d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
>   typedef struct SDProto {
>       const char *name;
>       struct {
> +        const sd_cmd_type_t type;
>           const char *name;
>           sd_cmd_handler handler;
>       } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
> @@ -351,20 +352,6 @@ static void sd_set_mode(SDState *sd)
>       }
>   }
>   
> -static const sd_cmd_type_t sd_cmd_type[SDMMC_CMD_MAX] = {
> -    sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
> -    sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
> -    /* 16 */
> -    sd_ac,   sd_adtc, sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none,
> -    sd_adtc, sd_adtc, sd_adtc, sd_adtc, sd_ac,   sd_ac,   sd_adtc, sd_none,
> -    /* 32 */
> -    sd_ac,   sd_ac,   sd_none, sd_none, sd_none, sd_none, sd_ac,   sd_none,
> -    sd_none, sd_none, sd_bc,   sd_none, sd_none, sd_none, sd_none, sd_none,
> -    /* 48 */
> -    sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_ac,
> -    sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
> -};
> -
>   static const int sd_cmd_class[SDMMC_CMD_MAX] = {
>       0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
>       2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
> @@ -571,10 +558,19 @@ static void sd_set_rca(SDState *sd, uint16_t value)
>   
>   static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
>   {
> -    if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
> +    switch (s->proto->cmd[req.cmd].type) {
> +    case sd_none:
> +        /* Called from legacy code not ported to SDProto array */
> +        assert(!s->proto->cmd[req.cmd].handler);
> +        /* fall-through */
> +    case sd_ac:
> +    case sd_adtc:
>           return req.arg >> 16;
> +    case sd_spi:
> +        g_assert_not_reached();
> +    default:
> +        return 0;
>       }
> -    return 0;
>   }
>   
>   /* Card Status register */
> @@ -2277,22 +2273,22 @@ void sd_enable(SDState *sd, bool enable)
>   static const SDProto sd_proto_spi = {
>       .name = "SPI",
>       .cmd = {
> -        [0]  = {            "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> -        [1]  = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> +        [0]  = {    sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [1]  = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>       .acmd = {
> -        [41] = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> +        [41] = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>   };
>   
>   static const SDProto sd_proto_sd = {
>       .name = "SD",
>       .cmd = {
> -        [0]  = {             "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> -        [2]  = {             "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
> -        [3]  = {             "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> -        [19] = {             "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> -        [23] = {             "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
> +        [0]  = {    sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
> +        [2]  = {    sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
> +        [3]  = {    sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> +        [19] = {    sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
> +        [23] = {    sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>       },
>   };
>   


