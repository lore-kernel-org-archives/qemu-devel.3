Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06053CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFutg-00038A-IB; Mon, 03 Nov 2025 08:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFute-00037l-86
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:46:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFutW-0005vX-TK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:46:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 259715972E4;
 Mon, 03 Nov 2025 14:46:45 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GUsgYxOJP_ma; Mon,  3 Nov 2025 14:46:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 139DF5972E3; Mon, 03 Nov 2025 14:46:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 124E45972E2;
 Mon, 03 Nov 2025 14:46:43 +0100 (CET)
Date: Mon, 3 Nov 2025 14:46:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/7] ati-vga: Fix DP_GUI_MASTER_CNTL register mask
In-Reply-To: <20251103033608.120908-5-chad@jablonski.xyz>
Message-ID: <7101bbf2-5ffb-ffaf-f3f6-771916acdb4e@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-5-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
> Change the register mask from 0xf800000f to 0xff00000f to preserve bits
> 24-26. This is the GMC_SRC_SOURCE field which is needed to determine
> the type of source for the blit operation.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index bf7a037e64..4ff17209c4 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -867,7 +867,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         ati_2d_blt(s);
>         break;
>     case DP_GUI_MASTER_CNTL:
> -        s->regs.dp_gui_master_cntl = data & 0xf800000f;
> +        s->regs.dp_gui_master_cntl = data & 0xff00000f;
>         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
>                               (data & 0x4000) << 16;
>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
>

