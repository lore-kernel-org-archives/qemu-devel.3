Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242BCC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Wc-0004TJ-Nj; Fri, 28 Jun 2024 04:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Wb-0004Sz-FW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:00:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6WZ-00046A-3Q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:00:05 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SXJ46CSz4wc8;
 Fri, 28 Jun 2024 18:00:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SXH45sTz4w2K;
 Fri, 28 Jun 2024 17:59:59 +1000 (AEST)
Message-ID: <eeee6a85-c20b-4e26-867f-0e99f08dc1af@kaod.org>
Date: Fri, 28 Jun 2024 09:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-52-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-52-philmd@linaro.org>
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
>   hw/sd/sd.c | 50 ++++++++++++++++++++------------------------------
>   1 file changed, 20 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bd7c7cf518..564e08709b 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1323,6 +1323,15 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
>   }
>   
>   /* CMD9 */
> +static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_standby_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> +                                 sd->csd, 16);
> +}
> +
>   static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   {
>       if (sd->state != sd_standby_state) {
> @@ -1333,6 +1342,15 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   }
>   
>   /* CMD10 */
> +static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_standby_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> +                                 sd->cid, 16);
> +}
> +
>   static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
>   {
>       if (sd->state != sd_standby_state) {
> @@ -1408,36 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       switch (req.cmd) {
>       /* Basic commands (Class 0 and Class 1) */
> -    case 9:  /* CMD9:   SEND_CSD */
> -        rca = sd_req_get_rca(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (!sd_is_spi(sd)) {
> -                break;
> -            }
> -            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> -                                         sd->csd, 16);
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
> -    case 10:  /* CMD10:  SEND_CID */
> -        rca = sd_req_get_rca(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (!sd_is_spi(sd)) {
> -                break;
> -            }
> -            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> -                                         sd->cid, 16);
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 12:  /* CMD12:  STOP_TRANSMISSION */
>           switch (sd->state) {
>           case sd_sendingdata_state:
> @@ -2288,6 +2276,8 @@ static const SDProto sd_proto_spi = {
>           [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
>           [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
>           [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
> +        [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
> +        [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},


