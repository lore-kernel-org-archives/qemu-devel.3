Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924EFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Z1-0002he-7M; Fri, 28 Jun 2024 04:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Ys-0002Yn-B5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Yp-0005lV-Qf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sb15s1bz4wcg;
 Fri, 28 Jun 2024 18:02:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Sb03r16z4w2N;
 Fri, 28 Jun 2024 18:02:20 +1000 (AEST)
Message-ID: <d1ef4e52-4120-4578-ac83-e18371829afb@kaod.org>
Date: Fri, 28 Jun 2024 10:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 61/98] hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END
 handlers (CMD32 & CMD33)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-62-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-62-philmd@linaro.org>
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
>   hw/sd/sd.c | 47 ++++++++++++++++++++++++-----------------------
>   1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bf9975e9b1..4e31dfe18f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [21]    = "DPS_spec",
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
> -        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
>           [38]    = "ERASE",
>           [40]    = "DPS_spec",
>           [42]    = "LOCK_UNLOCK",
> @@ -1583,6 +1582,26 @@ static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
>       return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
>   }
>   
> +/* CMD32 */
> +static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_START(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    sd->erase_start = req.arg;
> +    return sd_r1;
> +}
> +
> +/* CMD33 */
> +static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_END(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    sd->erase_end = req.arg;
> +    return sd_r1;
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> @@ -1672,28 +1691,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
>       /* Erase commands (Class 5) */
> -    case 32:  /* CMD32:  ERASE_WR_BLK_START */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            sd->erase_start = req.arg;
> -            return sd_r1;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
> -    case 33:  /* CMD33:  ERASE_WR_BLK_END */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            sd->erase_end = req.arg;
> -            return sd_r1;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 38:  /* CMD38:  ERASE */
>           switch (sd->state) {
>           case sd_transfer_state:
> @@ -2315,6 +2312,8 @@ static const SDProto sd_proto_spi = {
>           [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
>           [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
>           [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
> +        [32] = {5,  sd_spi, "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
> +        [33] = {5,  sd_spi, "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2356,6 +2355,8 @@ static const SDProto sd_proto_sd = {
>           [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
>           [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
>           [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
> +        [32] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
> +        [33] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
>           [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},


