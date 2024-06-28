Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDADC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6O2-0006vV-6L; Fri, 28 Jun 2024 03:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Nz-0006sn-RZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Ny-0006nJ-6N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SL41QzNz4w2K;
 Fri, 28 Jun 2024 17:51:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SL31JnFz4w2H;
 Fri, 28 Jun 2024 17:51:06 +1000 (AEST)
Message-ID: <ed0da84e-5e01-4ad5-bd33-86c8ea0995d8@kaod.org>
Date: Fri, 28 Jun 2024 09:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 31/98] hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to
 generic_write_byte (CMD24)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-32-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-32-philmd@linaro.org>
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
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5dbfc8000b..4a03f41086 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1101,7 +1101,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>   }
>   
>   /* Configure fields for following sd_generic_write_byte() calls */
> -__attribute__((unused))
>   static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
>                                                uint64_t start, size_t size)
>   {
> @@ -1470,10 +1469,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>                   return sd_r1;
>               }
>   
> -            sd->state = sd_receivingdata_state;
> -            sd->data_start = addr;
> -            sd->data_offset = 0;
> -
>               if (sd->size <= SDSC_MAX_CAPACITY) {
>                   if (sd_wp_addr(sd, sd->data_start)) {
>                       sd->card_status |= WP_VIOLATION;
> @@ -1483,7 +1478,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>                   sd->card_status |= WP_VIOLATION;
>               }
>               sd->blk_written = 0;
> -            return sd_r1;
> +            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
>   
>           default:
>               break;
> @@ -1999,7 +1994,6 @@ send_response:
>   }
>   
>   /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
> -__attribute__((unused))
>   static bool sd_generic_write_byte(SDState *sd, uint8_t value)
>   {
>       sd->data[sd->data_offset] = value;
> @@ -2045,8 +2039,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>                               sd->current_cmd, sd->data_offset, value);
>       switch (sd->current_cmd) {
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
> -        sd->data[sd->data_offset ++] = value;
> -        if (sd->data_offset >= sd->blk_len) {
> +        if (sd_generic_write_byte(sd, value)) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
>               sd_blk_write(sd, sd->data_start, sd->data_offset);


