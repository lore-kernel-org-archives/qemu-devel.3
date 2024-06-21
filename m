Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F78C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh0i-0003Oo-CL; Fri, 21 Jun 2024 12:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh09-00031d-HQ; Fri, 21 Jun 2024 12:20:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh07-0003XV-S0; Fri, 21 Jun 2024 12:20:37 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5Mz41xjTz4wc5;
 Sat, 22 Jun 2024 02:20:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Mz16k5Yz4wbr;
 Sat, 22 Jun 2024 02:20:29 +1000 (AEST)
Message-ID: <fa5c5fda-dc40-4750-b7d9-5c59027721b3@kaod.org>
Date: Fri, 21 Jun 2024 18:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] hw/sd/sdcard: Factor sd_req_get_rca() method out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-15-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-15-philmd@linaro.org>
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
> Extract sd_req_get_rca() so we can re-use it in various
> SDProto handlers. Return a 16-bit value since RCA is 16-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 510784fc82..bc47ae36bc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -471,6 +471,14 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>       sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
>   }
>   
> +static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
> +{
> +    if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
> +        return req.arg >> 16;
> +    }
> +    return 0;
> +}
> +
>   FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
>   FIELD(CSR, APP_CMD,                     5,  1)
>   FIELD(CSR, FX_EVENT,                    6,  1)
> @@ -1094,7 +1102,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
> -    uint32_t rca = 0x0000;
> +    uint16_t rca = sd_req_get_rca(sd, req);
>       uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
>   
>       sd->last_cmd_name = sd_cmd_name(req.cmd);
> @@ -1110,11 +1118,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       /* Not interpreting this as an app command */
>       sd->card_status &= ~APP_CMD;
>   
> -    if (sd_cmd_type[req.cmd] == sd_ac
> -        || sd_cmd_type[req.cmd] == sd_adtc) {
> -        rca = req.arg >> 16;
> -    }
> -
>       /* CMD23 (set block count) must be immediately followed by CMD18 or CMD25
>        * if not, its effects are cancelled */
>       if (sd->multi_blk_cnt != 0 && !(req.cmd == 18 || req.cmd == 25)) {


