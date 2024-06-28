Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19043C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6cB-0005SM-Ff; Fri, 28 Jun 2024 04:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6c9-0005Iz-NX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:05:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6c7-0007Vq-Us
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:05:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Sfx6LTdz4w2H;
 Fri, 28 Jun 2024 18:05:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Sfw6Cl1z4wb7;
 Fri, 28 Jun 2024 18:05:44 +1000 (AEST)
Message-ID: <e56fc8f7-2488-4643-9c68-21a4f2687d8d@kaod.org>
Date: Fri, 28 Jun 2024 10:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v42 79/98] hw/sd/sdcard: Trace length of data read
 on DAT lines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-80-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-80-philmd@linaro.org>
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
> Some commands expect less than BLOCK_LENGTH.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c         | 4 ++--
>   hw/sd/trace-events | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 64621d4340..a0da06e017 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2197,8 +2197,8 @@ uint8_t sd_read_byte(SDState *sd)
>       io_len = sd_blk_len(sd);
>   
>       trace_sdcard_read_data(sd->proto->name,
> -                           sd->last_cmd_name,
> -                           sd->current_cmd, sd->data_offset, io_len);
> +                           sd->last_cmd_name, sd->current_cmd,
> +                           sd->data_offset, sd->data_size, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
>       case 9:  /* CMD9:   SEND_CSD */
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 6a51b0e906..5dfe6be7b7 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -55,7 +55,7 @@ sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PR
>   sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>   sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>   sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
> -sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
> +sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
>   sdcard_set_voltage(uint16_t millivolts) "%u mV"
>   
>   # pxa2xx_mmci.c


