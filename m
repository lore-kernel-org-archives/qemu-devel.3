Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26780EEB57B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbR5y-0001pK-40; Thu, 01 Jan 2026 17:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbR5w-0001pB-Tf
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:24:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbR5v-0004rc-GZ
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:24:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B1BE5969FF;
 Thu, 01 Jan 2026 23:24:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2noXC12Hdd8l; Thu,  1 Jan 2026 23:24:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E3BC75969FA; Thu, 01 Jan 2026 23:24:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE8495969F6;
 Thu, 01 Jan 2026 23:24:31 +0100 (CET)
Date: Thu, 1 Jan 2026 23:24:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 06/11] ati-vga: Create dst and sc rectangle helpers
In-Reply-To: <20251118154812.57861-7-chad@jablonski.xyz>
Message-ID: <2bd6ac1d-124d-639a-f465-df3be5eb377f@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-7-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> This creates helper functions for building QemuRects using the dst and
> sc registers. These are useful during blit setup and the next patch in
> this series will make use of them.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index a8c4c534b9..0695c26b3b 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -13,6 +13,7 @@
> #include "qemu/log.h"
> #include "ui/pixel_ops.h"
> #include "ui/console.h"
> +#include "ui/rect.h"
>
> /*
>  * NOTE:
> @@ -43,6 +44,29 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> +static QemuRect dst_rect(ATIVGAState *s)
> +{
> +    QemuRect dst;
> +    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                     s->regs.dst_x :
> +                     s->regs.dst_x + 1 - s->regs.dst_width);
> +    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                     s->regs.dst_y :
> +                     s->regs.dst_y + 1 - s->regs.dst_height);
> +    qemu_rect_init(&dst, dst_x, dst_y, s->regs.dst_width, s->regs.dst_height);
> +    return dst;
> +}
> +
> +static QemuRect sc_rect(ATIVGAState *s)
> +{
> +    QemuRect sc;
> +    qemu_rect_init(&sc,
> +                   s->regs.sc_left, s->regs.sc_top,
> +                   s->regs.sc_right - s->regs.sc_left + 1,
> +                   s->regs.sc_bottom - s->regs.sc_top + 1);
> +    return sc;
> +}

Also there's nothing special in this sc_rect function so it could just be 
inlined. If it's used only once then maybe isn't worth to put it in a 
function. The only advantage seems to be that you can use it to init at 
defining the variable but calling qemu_rect_init separately is not a big 
deal and actually 4 lines less. The dst_rect hides some ugliness and two 
local variables so that may worth to have a function for.

Regards,
BALATON Zoltan

