Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5897BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6YT-00015h-Mq; Fri, 28 Jun 2024 04:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6YS-00014f-7S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6YQ-00051U-2I
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:01:59 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SZX0n3zz4wb7;
 Fri, 28 Jun 2024 18:01:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SZW0kCrz4w2N;
 Fri, 28 Jun 2024 18:01:54 +1000 (AEST)
Message-ID: <97277489-030a-4aca-b783-e8964904675a@kaod.org>
Date: Fri, 28 Jun 2024 10:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 59/98] hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT
 handler (CMD28 & CMD29)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-60-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-60-philmd@linaro.org>
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
>   hw/sd/sd.c | 91 +++++++++++++++++++++++++++---------------------------
>   1 file changed, 46 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9d33113f11..a63213613b 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [21]    = "DPS_spec",
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
> -        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
>           [30]    = "SEND_WRITE_PROT",
>           [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
>           [38]    = "ERASE",
> @@ -1520,6 +1519,48 @@ static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
>       return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
>   }
>   
> +static sd_rsp_type_t sd_cmd_SET_CLR_WRITE_PROT(SDState *sd, SDRequest req,
> +                                               bool is_write)
> +{
> +    uint64_t addr;
> +
> +    if (sd->size > SDSC_MAX_CAPACITY) {
> +        return sd_illegal;
> +    }
> +
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    addr = sd_req_get_address(sd, req);
> +    if (!address_in_range(sd, is_write ? "SET_WRITE_PROT" : "CLR_WRITE_PROT",
> +                          addr, 1)) {
> +        return sd_r1b;
> +    }
> +
> +    sd->state = sd_programming_state;
> +    if (is_write) {
> +        set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
> +    } else {
> +        clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
> +    }
> +    /* Bzzzzzzztt .... Operation complete.  */
> +    sd->state = sd_transfer_state;
> +    return sd_r1;
> +}
> +
> +/* CMD28 */
> +static sd_rsp_type_t sd_cmd_SET_WRITE_PROT(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, true);
> +}
> +
> +/* CMD29 */
> +static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
> +{
> +    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> @@ -1610,50 +1651,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
>       /* Write protection (Class 6) */
> -    case 28:  /* CMD28:  SET_WRITE_PROT */
> -        if (sd->size > SDSC_MAX_CAPACITY) {
> -            return sd_illegal;
> -        }
> -        addr = sd_req_get_address(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
> -                return sd_r1b;
> -            }
> -
> -            sd->state = sd_programming_state;
> -            set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
> -            /* Bzzzzzzztt .... Operation complete.  */
> -            sd->state = sd_transfer_state;
> -            return sd_r1b;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
> -    case 29:  /* CMD29:  CLR_WRITE_PROT */
> -        if (sd->size > SDSC_MAX_CAPACITY) {
> -            return sd_illegal;
> -        }
> -        addr = sd_req_get_address(sd, req);
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
> -                return sd_r1b;
> -            }
> -
> -            sd->state = sd_programming_state;
> -            clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
> -            /* Bzzzzzzztt .... Operation complete.  */
> -            sd->state = sd_transfer_state;
> -            return sd_r1b;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 30:  /* CMD30:  SEND_WRITE_PROT */
>           if (sd->size > SDSC_MAX_CAPACITY) {
>               return sd_illegal;
> @@ -2314,6 +2311,8 @@ static const SDProto sd_proto_spi = {
>           [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
>           [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
>           [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
> +        [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
> +        [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
>           [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
> @@ -2352,6 +2351,8 @@ static const SDProto sd_proto_sd = {
>           [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
>           [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
>           [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
> +        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
> +        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
>           [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
>           [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
>           [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},


