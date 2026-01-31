Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B718D79767
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm8Jo-00046Y-Fv; Sat, 31 Jan 2026 05:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm8Jm-00044w-Uf
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:35:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm8Jl-0002jT-CV
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:35:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C1DAE5969FD;
 Sat, 31 Jan 2026 11:35:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OyQAlYZPo6hb; Sat, 31 Jan 2026 11:35:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A9D465969F6; Sat, 31 Jan 2026 11:35:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A59595969F2;
 Sat, 31 Jan 2026 11:35:01 +0100 (CET)
Date: Sat, 31 Jan 2026 11:35:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 11/20] ati-vga: Introduce ATI2DCtx struct for 2D blit
 context
In-Reply-To: <20260130145005.731129-12-chad@jablonski.xyz>
Message-ID: <cefa265a-714e-3d4d-4d35-c0a8c9d6f080@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-12-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Jan 2026, Chad Jablonski wrote:
> Previously all state derived from registers was moved to locals. Now we
> can mechanically replace those locals with fields on the new ATI2DCtx
> struct.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>
> ---
>
> vram_end feels a little out of place to me in the ATI2DCtx struct but moving
> it into the ctx allows us to eventually remove ATIVGAState entirely. I
> also considered moving the dst validation that requires it outside of
> ati_2d_blt and making it the responsibility of the caller but that has its
> own downsides (forgetting to validate). In the end I left it in the ctx.
> ---
> hw/display/ati_2d.c | 216 +++++++++++++++++++++++++-------------------
> 1 file changed, 122 insertions(+), 94 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index a368950182..bc41ad37f6 100644
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
> @@ -43,6 +44,26 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> +typedef struct {
> +    int bpp;
> +    uint32_t rop3;
> +    bool left_to_right;
> +    bool top_to_bottom;
> +    uint32_t frgd_clr;
> +    const uint8_t *palette;
> +    const uint8_t *vram_end;
> +
> +    /* dst */
> +    QemuRect dst;
> +    int dst_stride;
> +    uint8_t *dst_bits;
> +
> +    /* src */

Since these are already prefixed with src_ and dst_ I'm not sure the 
comments add much.

> +    QemuRect src;
> +    int src_stride;
> +    const uint8_t *src_bits;
> +} ATI2DCtx;
> +
> void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
> @@ -50,105 +71,111 @@ void ati_2d_blt(ATIVGAState *s)
>     DisplaySurface *ds = qemu_console_surface(s->vga.con);
>     bool use_pixman_fill = s->use_pixman & BIT(0);
>     bool use_pixman_blt = s->use_pixman & BIT(1);
> -    int rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
> -    bool left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
> -    bool top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> -    uint32_t frgd_clr = s->regs.dp_brush_frgd_clr;
> -    uint8_t *palette = s->vga.palette;
> +    ATI2DCtx ctx;

To reduce churn later maybe doing the pointer here as you had in the 
previous version could help just not with _name but name_ or similar. Now 
next patches convert these from ctx.something to ctx->something so this 
patch does note help that much.

Regards,
BALATON Zoltan

