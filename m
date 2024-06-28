Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072FEC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6So-00077J-Ko; Fri, 28 Jun 2024 03:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Sh-0006yz-49
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Sf-0001gG-58
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:02 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SRg1Nz2z4wc8;
 Fri, 28 Jun 2024 17:55:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SRf1Bl6z4wb7;
 Fri, 28 Jun 2024 17:55:57 +1000 (AEST)
Message-ID: <6f0d2e9b-55be-4151-a7d2-6115494d5d29@kaod.org>
Date: Fri, 28 Jun 2024 09:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 42/98] hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-43-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-43-philmd@linaro.org>
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
> The CSD::CSR_IMP bit defines whether the Driver Stage
> Register (DSR) is implemented or not. We do not set
> this bit in CSD:
> 
>      static void sd_set_csd(SDState *sd, uint64_t size)
>      {
>          ...
>          if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
>              ...
>              sd->csd[6] = 0xe0 |     /* Partial block for read allowed */
>                  ((csize >> 10) & 0x03);
>              ...
>          } else {                    /* SDHC */
>              ...
>              sd->csd[6] = 0x00;
>              ...
>          }
>          ...
>      }
> 
> The sd_normal_command() switch case for the SEND_DSR
> command do nothing and fallback to "illegal command".
> Since the command is mandatory (although the register
> isn't...) call the sd_cmd_unimplemented() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a816493d37..097cb0f2e2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
> +                                             [5]    = "IO_SEND_OP_COND",
>            [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
>            [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
>           [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
> @@ -1153,7 +1153,6 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
>   }
>   
>   /* Commands that are recognised but not yet implemented. */
> -__attribute__((unused))
>   static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   {
>       qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
> @@ -1312,16 +1311,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Basic commands (Class 0 and Class 1) */
> -    case 4:  /* CMD4:   SEND_DSR */
> -        switch (sd->state) {
> -        case sd_standby_state:
> -            break;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
>           if (sd->mode != sd_data_transfer_mode) {
>               return sd_invalid_mode_for_cmd(sd, req);
> @@ -2289,6 +2278,7 @@ static const SDProto sd_proto_sd = {
>           [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
>           [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
>           [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
> +        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>       },


