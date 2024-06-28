Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E2AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Z5-0002ya-H0; Fri, 28 Jun 2024 04:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Z3-0002rY-Vz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Z2-0005mz-89
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:37 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SbF3gP3z4w2Q;
 Fri, 28 Jun 2024 18:02:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SbD31TGz4w2N;
 Fri, 28 Jun 2024 18:02:32 +1000 (AEST)
Message-ID: <c6c6db3c-62ff-4373-9f6b-74ffff934feb@kaod.org>
Date: Fri, 28 Jun 2024 10:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 63/98] hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler
 (CMD42)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-64-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-64-philmd@linaro.org>
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
>   hw/sd/sd.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 17fec612eb..4d78ac5b59 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
>           [40]    = "DPS_spec",
> -        [42]    = "LOCK_UNLOCK",
>           [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
>           [56]    = "GEN_CMD",
>           [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
> @@ -1619,6 +1618,12 @@ static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
>       return sd_r1b;
>   }
>   
> +/* CMD42 */
> +static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_to_receivingdata(sd, req, 0, 0);
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> @@ -1707,10 +1712,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       case 26:  /* CMD26:  PROGRAM_CID */
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
> -    /* Lock card commands (Class 7) */
> -    case 42:  /* CMD42:  LOCK_UNLOCK */
> -        return sd_cmd_to_receivingdata(sd, req, 0, 0);
> -
>       /* Application specific commands (Class 8) */
>       case 55:  /* CMD55:  APP_CMD */
>           rca = sd_req_get_rca(sd, req);
> @@ -2316,6 +2317,7 @@ static const SDProto sd_proto_spi = {
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
>           [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
>           [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
> +        [42] = {7,  sd_spi, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
>           [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
>           [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
>           [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
> @@ -2360,6 +2362,7 @@ static const SDProto sd_proto_sd = {
>           [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
>           [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
>           [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
> +        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
>           [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
>           [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
>           [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},


