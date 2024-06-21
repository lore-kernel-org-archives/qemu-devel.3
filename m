Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FA1C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgzh-0001w5-3n; Fri, 21 Jun 2024 12:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgze-0001nc-6a; Fri, 21 Jun 2024 12:20:06 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgzc-0003ES-DK; Fri, 21 Jun 2024 12:20:05 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5MyT74JJz4wcJ;
 Sat, 22 Jun 2024 02:20:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5MyR3yxjz4w2Q;
 Sat, 22 Jun 2024 02:19:59 +1000 (AEST)
Message-ID: <fa032608-4fe9-4887-a3c4-b1bf6dddb3e6@kaod.org>
Date: Fri, 21 Jun 2024 18:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-13-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> Useful to detect out of bound accesses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c         | 4 ++--
>   hw/sd/trace-events | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 2586d15cbd..c6cc1bab11 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1868,7 +1868,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>   
>       trace_sdcard_write_data(sd_proto(sd)->name,
>                               sd->last_cmd_name,
> -                            sd->current_cmd, value);
> +                            sd->current_cmd, sd->data_offset, value);
>       switch (sd->current_cmd) {
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
>           sd->data[sd->data_offset ++] = value;
> @@ -2024,7 +2024,7 @@ uint8_t sd_read_byte(SDState *sd)
>   
>       trace_sdcard_read_data(sd_proto(sd)->name,
>                              sd->last_cmd_name,
> -                           sd->current_cmd, io_len);
> +                           sd->current_cmd, sd->data_offset, io_len);
>       switch (sd->current_cmd) {
>       case 6:  /* CMD6:   SWITCH_FUNCTION */
>           ret = sd->data[sd->data_offset ++];
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 724365efc3..0eee98a646 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -52,8 +52,8 @@ sdcard_lock(void) ""
>   sdcard_unlock(void) ""
>   sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>   sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
> -sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
> -sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
> +sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
> +sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
>   sdcard_set_voltage(uint16_t millivolts) "%u mV"
>   
>   # pxa2xx_mmci.c


