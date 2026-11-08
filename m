Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62F606A321
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ2NV-0006wc-Lf; Sun, 08 Nov 2026 07:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ2NR-0006up-DH
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 07:52:05 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ2NN-0006cv-JI
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 07:52:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4679B60C53B;
 Sun, 08 Nov 2026 13:51:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JkefxCCz8psT; Sun,  8 Nov 2026 13:51:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1A19460C43E; Sun, 08 Nov 2026 13:51:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 184F513991F;
 Sun, 08 Nov 2026 13:51:55 +0100 (CET)
Date: Sun, 8 Nov 2026 13:51:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/9] ati-vga: r100 does not latch defaults on
 DP_GUI_MASTER_CNTL
In-Reply-To: <20260719161536.774061-3-chad@jablonski.xyz>
Message-ID: <00c92bc9-d3b6-c58b-9e3f-7444f1f19300@eik.bme.hu>
References: <20260719161536.774061-1-chad@jablonski.xyz>
 <20260719161536.774061-3-chad@jablonski.xyz>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Sun, 19 Jul 2026, Chad Jablonski wrote:

> The r128 latches the default values of src/dst clipping, pitch, and
> offset when the default flags are set on DP_GUI_MASTER_CNTL. The r100
> does not do this and instead uses the default values at blit time without
> updating the registers.
>
> Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
> Radeon QY (RV100) (PCI 1002:5159).

Does the R100 do the same for other defaults? In that case we might need 
to revert or fix 3ab35ff519b95cb too.

This patch

Fixes: 1b079e183d4 (ati-vga: Add scissor clipping register support)

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c    | 36 +++++++++++++++++++-----------------
> hw/display/ati_2d.c | 41 ++++++++++++++++++++++++++++++-----------
> 2 files changed, 49 insertions(+), 28 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index db7e08a462..76070d76a7 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -895,23 +895,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>                               (data & 0x4000) << 16;
>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
>
> -        if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
> -            s->regs.src_offset = s->regs.default_offset;
> -            s->regs.src_pitch = s->regs.default_pitch;
> -        }
> -        if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
> -            s->regs.dst_offset = s->regs.default_offset;
> -            s->regs.dst_pitch = s->regs.default_pitch;
> -        }
> -        if (!(data & GMC_SRC_CLIPPING)) {
> -            s->regs.src_sc_right = s->regs.default_sc_right;
> -            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
> -        }
> -        if (!(data & GMC_DST_CLIPPING)) {
> -            s->regs.sc_top = 0;
> -            s->regs.sc_left = 0;
> -            s->regs.sc_right = s->regs.default_sc_right;
> -            s->regs.sc_bottom = s->regs.default_sc_bottom;
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            if (!(data & GMC_SRC_PITCH_OFFSET_CNTL)) {
> +                s->regs.src_offset = s->regs.default_offset;
> +                s->regs.src_pitch = s->regs.default_pitch;
> +            }
> +            if (!(data & GMC_DST_PITCH_OFFSET_CNTL)) {
> +                s->regs.dst_offset = s->regs.default_offset;
> +                s->regs.dst_pitch = s->regs.default_pitch;
> +            }
> +            if (!(data & GMC_SRC_CLIPPING)) {
> +                s->regs.src_sc_right = s->regs.default_sc_right;
> +                s->regs.src_sc_bottom = s->regs.default_sc_bottom;
> +            }
> +            if (!(data & GMC_DST_CLIPPING)) {
> +                s->regs.sc_top = 0;
> +                s->regs.sc_left = 0;
> +                s->regs.sc_right = s->regs.default_sc_right;
> +                s->regs.sc_bottom = s->regs.default_sc_bottom;
> +            }
>         }
>         break;
>     case DST_WIDTH_X:
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 3b27917bf4..f51ecb747a 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -104,18 +104,26 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
>     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
>     ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
>     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
> -    ctx->dst_offset = s->regs.dst_offset;
>
>     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
>         /* r128 scissor values are inclusive */
>         ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
>         ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
> +        ctx->scissor.x = s->regs.sc_left;
> +        ctx->scissor.y = s->regs.sc_top;
>     } else {
> -        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
> -        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;
> +        if (s->regs.dp_gui_master_cntl & GMC_DST_CLIPPING) {
> +            ctx->scissor.x = s->regs.sc_left;
> +            ctx->scissor.y = s->regs.sc_top;
> +            ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
> +            ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;

Here it could be simplified the same way as in previous patch by splitting 
out common part and fixing up in a device specific if.

> +        } else {
> +            ctx->scissor.x = 0;
> +            ctx->scissor.y = 0;
> +            ctx->scissor.width = s->regs.default_sc_right;
> +            ctx->scissor.height = s->regs.default_sc_bottom;
> +        }
>     }
> -    ctx->scissor.x = s->regs.sc_left;
> -    ctx->scissor.y = s->regs.sc_top;
>
>     ctx->dst.width = s->regs.dst_width;
>     ctx->dst.height = s->regs.dst_height;
> @@ -123,20 +131,30 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
>                  s->regs.dst_x : s->regs.dst_x + 1 - ctx->dst.width);
>     ctx->dst.y = (ctx->top_to_bottom ?
>                  s->regs.dst_y : s->regs.dst_y + 1 - ctx->dst.height);
> -    ctx->dst_stride = s->regs.dst_pitch;
> -    ctx->dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
>     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -        ctx->dst_stride *= ctx->bpp;
> +        ctx->dst_stride = s->regs.dst_pitch * ctx->bpp;
> +        ctx->dst_offset = s->regs.dst_offset;
> +    } else {
> +        ctx->dst_stride = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
> +                          ? s->regs.dst_pitch : s->regs.default_pitch;
> +        ctx->dst_offset = s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL
> +                          ? s->regs.dst_offset : s->regs.default_offset;

Previously we had macros for this. Would it look simpler to bring those 
back?

Regards,
BALATON Zoltan

>     }
> +    ctx->dst_bits = s->vga.vram_ptr + ctx->dst_offset;
>
>     ctx->src.x = (ctx->left_to_right ?
>                  s->regs.src_x : s->regs.src_x + 1 - ctx->dst.width);
>     ctx->src.y = (ctx->top_to_bottom ?
>                  s->regs.src_y : s->regs.src_y + 1 - ctx->dst.height);
> -    ctx->src_stride = s->regs.src_pitch;
> -    ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
>     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -        ctx->src_stride *= ctx->bpp;
> +        ctx->src_stride = s->regs.src_pitch * ctx->bpp;
> +        ctx->src_bits = s->vga.vram_ptr + s->regs.src_offset;
> +    } else {
> +        ctx->src_stride = s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
> +                          ? s->regs.src_pitch : s->regs.default_pitch;
> +        ctx->src_bits = s->vga.vram_ptr +
> +                        (s->regs.dp_gui_master_cntl & GMC_SRC_PITCH_OFFSET_CNTL
> +                        ? s->regs.src_offset : s->regs.default_offset);
>     }
>     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
>             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
> @@ -181,6 +199,7 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
>     qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
>     if (!vis_dst.height || !vis_dst.width) {
>         /* Nothing is visible, completely clipped */
> +        DPRINTF("entire blt clipped, nothing drawn\n");
>         return false;
>     }
>     /*
>

