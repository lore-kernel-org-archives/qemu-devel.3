Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE14C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgxV-0007y9-Tt; Fri, 21 Jun 2024 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxT-0007wA-Lk; Fri, 21 Jun 2024 12:17:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgxS-0002zY-2E; Fri, 21 Jun 2024 12:17:51 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5Mvt54rVz4wny;
 Sat, 22 Jun 2024 02:17:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Mvr2mXYz4wcq;
 Sat, 22 Jun 2024 02:17:44 +1000 (AEST)
Message-ID: <4e92f197-315e-4972-9d24-3cdbdee60a59@kaod.org>
Date: Fri, 21 Jun 2024 18:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] hw/sd/sdcard: Use Load/Store API to fill some
 CID/CSD registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-7-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-7-philmd@linaro.org>
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
> The ld/st API helps noticing CID or CSD bytes refer
> to the same field. Multi-bytes fields are stored MSB
> first in CID / CSD.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 24415cb9f0..b0cd30c657 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -393,10 +393,7 @@ static void sd_set_cid(SDState *sd)
>       sd->cid[6] = PNM[3];
>       sd->cid[7] = PNM[4];
>       sd->cid[8] = PRV;       /* Fake product revision (PRV) */
> -    sd->cid[9] = 0xde;      /* Fake serial number (PSN) */
> -    sd->cid[10] = 0xad;
> -    sd->cid[11] = 0xbe;
> -    sd->cid[12] = 0xef;
> +    stl_be_p(&sd->cid[9], 0xdeadbeef); /* Fake serial number (PSN) */
>       sd->cid[13] = 0x00 |    /* Manufacture date (MDT) */
>           ((MDT_YR - 2000) / 10);
>       sd->cid[14] = ((MDT_YR % 10) << 4) | MDT_MON;
> @@ -462,9 +459,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>           sd->csd[4] = 0x5b;
>           sd->csd[5] = 0x59;
>           sd->csd[6] = 0x00;
> -        sd->csd[7] = (size >> 16) & 0xff;
> -        sd->csd[8] = (size >> 8) & 0xff;
> -        sd->csd[9] = (size & 0xff);
> +        st24_be_p(&sd->csd[7], size);
>           sd->csd[10] = 0x7f;
>           sd->csd[11] = 0x80;
>           sd->csd[12] = 0x0a;


