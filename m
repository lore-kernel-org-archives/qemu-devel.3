Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87945C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh17-00040D-Ei; Fri, 21 Jun 2024 12:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh0i-0003RB-DH; Fri, 21 Jun 2024 12:21:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh0g-0003cV-QH; Fri, 21 Jun 2024 12:21:12 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5Mzm1qJQz4wc5;
 Sat, 22 Jun 2024 02:21:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Mzj6b2Vz4w2Q;
 Sat, 22 Jun 2024 02:21:05 +1000 (AEST)
Message-ID: <7d0b77a3-2b61-4b7b-96ad-530833f01c23@kaod.org>
Date: Fri, 21 Jun 2024 18:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] hw/sd/sdcard: Factor sd_req_get_address() method out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-17-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-17-philmd@linaro.org>
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
> Extract sd_cmd_get_address() so we can re-use it
> in various SDProto handlers. Use CARD_CAPACITY and
> HWBLOCK_SHIFT definitions instead of magic values.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index cb9d85bb11..a0193a46ea 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -579,6 +579,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
>       stl_be_p(response, sd->vhs);
>   }
>   
> +static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
> +{
> +    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
> +        return (uint64_t) req.arg << HWBLOCK_SHIFT;
> +    }
> +    return req.arg;
> +}
> +
>   static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
>   {
>       return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
> @@ -1103,7 +1111,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> -    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
> +    uint64_t addr = sd_req_get_address(sd, req);
>   
>       sd->last_cmd_name = sd_cmd_name(req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.


