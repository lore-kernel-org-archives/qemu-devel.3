Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4F7D2629F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 01:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viMcj-0001tM-6k; Tue, 20 Jan 2026 20:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viMch-0001qo-Pz
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:03:03 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viMcf-0004M7-P7
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:03:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 853A4596ABD;
 Wed, 21 Jan 2026 02:02:59 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 1f9SW8MsTltx; Wed, 21 Jan 2026 02:02:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 71AB1596A03; Wed, 21 Jan 2026 02:02:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6CD6F5969E4;
 Wed, 21 Jan 2026 02:02:57 +0100 (CET)
Date: Wed, 21 Jan 2026 02:02:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
In-Reply-To: <20260116024258.1487173-7-chad@jablonski.xyz>
Message-ID: <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-7-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 15 Jan 2026, Chad Jablonski wrote:
> A large amount of the common setup involved in a blit deals with the
> destination. This moves that setup to a helper function which
> initializes a struct (ATIBltDst) holding all of the dst state. This setup
> will be shared between blits from memory as well as from HOST_DATA.
>
> Otherwise this is a pure refactor of the ati_2d_blt function to make use
> of the setup_2d_blt_dst helper and the struct it initializes. There should
> be no change in behavior in this patch.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 195 +++++++++++++++++++++++++-------------------
> 1 file changed, 112 insertions(+), 83 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index a8c4c534b9..75bd38e9b0 100644
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
> @@ -24,7 +25,16 @@
>  * possible.
>  */
>
> -static int ati_bpp_from_datatype(ATIVGAState *s)
> +typedef struct {
> +    QemuRect rect;
> +    int bpp;
> +    int stride;
> +    bool top_to_bottom;
> +    bool left_to_right;
> +    uint8_t *bits;
> +} ATIBltDst;

I'll need to look at this and further patches in more detail but I wonder 
if we need separate types for BltDst and BltSrc or could we use a single 
type for both maybe not using some fields for Src. But if that would not 
simplify things then these can be separate too.

> +
> +static int ati_bpp_from_datatype(const ATIVGAState *s)
> {
>     switch (s->regs.dp_datatype & 0xf) {
>     case 2:
> @@ -43,57 +53,76 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> +static void setup_2d_blt_dst(const ATIVGAState *s, ATIBltDst *dst)
> +{
> +    unsigned dst_x, dst_y;
> +    dst->bpp = ati_bpp_from_datatype(s);
> +    dst->stride = s->regs.dst_pitch;
> +    dst->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
> +    dst->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> +    dst->bits = s->vga.vram_ptr + s->regs.dst_offset;
> +    dst_x = (dst->left_to_right ?
> +            s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> +    dst_y = (dst->top_to_bottom ?
> +            s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    qemu_rect_init(&dst->rect, dst_x, dst_y,
> +                   s->regs.dst_width, s->regs.dst_height);
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        dst->bits += s->regs.crtc_offset & 0x07ffffff;
> +        dst->stride *= dst->bpp;
> +    }
> +}
> +
> void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
>     DisplaySurface *ds = qemu_console_surface(s->vga.con);
> +    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> +    int dst_stride_words;
> +    ATIBltDst _dst; /* TEMP: avoid churn in future patches */
> +    ATIBltDst *dst = &_dst;

These will be removed but names beginning with _ are reserved and should 
not be used so maybe this (and _src in next patch) should be dst_ or 
something else? Can the churn be avoided by reorganising changes or moving 
converting to pointer in a separate patch? This patch is quite long and 
mixes pointer conversion with other refactoring so separating those may 
help in review.

Regards,
BALATON Zoltan

