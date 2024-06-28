Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23293C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6ZM-0003tx-Sm; Fri, 28 Jun 2024 04:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ZK-0003sQ-Mg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6ZI-0005oC-NC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:02:54 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SbZ2yRMz4wc8;
 Fri, 28 Jun 2024 18:02:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SbY1JZNz4wcS;
 Fri, 28 Jun 2024 18:02:48 +1000 (AEST)
Message-ID: <6ba77425-6fe1-48a6-9ae6-25f577813a8b@kaod.org>
Date: Fri, 28 Jun 2024 10:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 65/98] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-66-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-66-philmd@linaro.org>
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
>   hw/sd/sd.c | 36 +++++++++++++++++-------------------
>   1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5461e56e17..50cee5ac40 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>                                               [25]    = "WRITE_MULTIPLE_BLOCK",
>           [26]    = "MANUF_RSVD",
>           [40]    = "DPS_spec",
> -        [56]    = "GEN_CMD",
>           [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
>           [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
>       };
> @@ -910,9 +909,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>       }
>   }
>   
> -#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
> -#define APP_WRITE_BLOCK(a, len)
> -
>   static void sd_erase(SDState *sd)
>   {
>       uint64_t erase_start = sd->erase_start;
> @@ -1649,6 +1645,21 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
>       return sd_r1;
>   }
>   
> +/* CMD56 */
> +static sd_rsp_type_t sd_cmd_GEN_CMD(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    if (req.arg & 1) {
> +        return sd_cmd_to_sendingdata(sd, req, 0,
> +                                     sd->vendor_data, sizeof(sd->vendor_data));
> +    } else {
> +        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
> +    }
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1737,21 +1748,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
>   
>       /* Application specific commands (Class 8) */
> -    case 56:  /* CMD56:  GEN_CMD */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            if (req.arg & 1) {
> -                return sd_cmd_to_sendingdata(sd, req, 0,
> -                                             sd->vendor_data,
> -                                             sizeof(sd->vendor_data));
> -            }
> -            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 58:    /* CMD58:   READ_OCR (SPI) */
>           return sd_r3;
>   
> @@ -2323,6 +2319,7 @@ static const SDProto sd_proto_spi = {
>           [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
>           [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
>           [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
> +        [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
>           [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
>       },
>       .acmd = {
> @@ -2376,6 +2373,7 @@ static const SDProto sd_proto_sd = {
>           [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
>           [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
>           [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
> +        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
>           [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
>           [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
>           [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},


