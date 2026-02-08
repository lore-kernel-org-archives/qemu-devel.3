Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C97EF06EA
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 20:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpBa6-00063h-TZ; Sun, 08 Feb 2026 15:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBa2-00060m-LL
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:40:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBZy-0004Dj-W7
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:40:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19BCC5969F6;
 Sun, 08 Feb 2026 21:40:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Rw8g1G_krrFH; Sun,  8 Feb 2026 21:40:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1A4A15969F2; Sun, 08 Feb 2026 21:40:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18BE35969F1;
 Sun, 08 Feb 2026 21:40:22 +0100 (CET)
Date: Sun, 8 Feb 2026 21:40:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 16/18] ati-vga: Implement scissor rectangle clipping
 for 2D operations
In-Reply-To: <20260204164606.3425246-17-chad@jablonski.xyz>
Message-ID: <00aade99-9ce2-3679-5171-8899d8fbb524@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-17-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 4 Feb 2026, Chad Jablonski wrote:
> Use scissor registers to clip blit operations. This is required
> for text rendering in X using the r128 driver. Without it overly-wide
> glyphs are drawn and create all sorts of chaos.
>
> The visible destination rectangle (vis_dst) is the intersection of the
> scissor rectangle and the destination rectangle (dst).
>
> The src also needs to be offset if clipped on the top and/or
> left sides to ensure that src data is read correctly and appears
> clipped when drawn rather than shifted.

This is true for top to bottom left to right but what happens for other 
direction blits?

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 75 +++++++++++++++++++++++++++++----------------
> 1 file changed, 49 insertions(+), 26 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 463da001d9..53f00e07ec 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -52,6 +52,7 @@ typedef struct {
>     uint32_t frgd_clr;
>     const uint8_t *palette;
>     const uint8_t *vram_end;
> +    QemuRect scissor;
>
>     QemuRect dst;
>     int dst_stride;
> @@ -91,6 +92,11 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>     ctx->dst_offset = s->regs.dst_offset;
>     ctx->vram_end = s->vga.vram_ptr + s->vga.vram_size;
>
> +    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
> +    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
> +    ctx->scissor.x = s->regs.sc_left;
> +    ctx->scissor.y = s->regs.sc_top;

Does this need to be computed as src and dst coordinates when not top to 
bottom left to right?

> +
>     ctx->dst.width = s->regs.dst_width;
>     ctx->dst.height = s->regs.dst_height;
>     ctx->dst.x = (ctx->left_to_right ?
> @@ -129,6 +135,7 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>     /* rewritten but for now as a start just to get some output: */
>     bool use_pixman_fill = use_pixman & BIT(0);
>     bool use_pixman_blt = use_pixman & BIT(1);
> +    QemuRect vis_src, vis_dst;
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
> @@ -144,6 +151,22 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
> +    qemu_rect_intersect(&ctx->dst, &ctx->scissor, &vis_dst);
> +    if (!vis_dst.height || !vis_dst.width) {
> +        /* Nothing is visible, completely clipped */
> +        return;
> +    }
> +    /*
> +     * The src must be offset if clipping is applied to the dst.
> +     * This is so that when the source is blit to a dst clipped
> +     * on the top or left the src image is not shifted into the
> +     * clipped region but actually clipped.
> +     */
> +    vis_src.x = ctx->src.x + (vis_dst.x - ctx->dst.x);
> +    vis_src.y = ctx->src.y + (vis_dst.y - ctx->dst.y);
> +    vis_src.width = vis_dst.width;
> +    vis_src.height = vis_dst.height;

These may also need to be calculated differently.

> +
>     switch (ctx->rop3) {
>     case ROP3_SRCCOPY:
>     {
> @@ -156,30 +179,30 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
>                 ctx->src_bits, ctx->dst_bits, src_stride_words,
> -                dst_stride_words, ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y,
> -                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height);
> +                dst_stride_words, ctx->bpp, ctx->bpp, vis_src.x, vis_src.y,
> +                vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);

Maybe log visible rect in addition of src and dst not replacing it here so 
we can debug if clipping was correctly done.

If you don't want to consider different directions than top to bottom left 
to right that's OK but then we probably need a check and a LOG_UNIMP in 
that case and keep using unclipped  dst and src (just copying to vis rects 
I guess) in that case.

> #ifdef CONFIG_PIXMAN
>         if (use_pixman_blt && ctx->left_to_right && ctx->top_to_bottom) {
>             fallback = !pixman_blt((uint32_t *)ctx->src_bits,
>                                    (uint32_t *)ctx->dst_bits, src_stride_words,
>                                    dst_stride_words, ctx->bpp, ctx->bpp,
> -                                   ctx->src.x, ctx->src.y, ctx->dst.x,
> -                                   ctx->dst.y, ctx->dst.width, ctx->dst.height);
> +                                   vis_src.x, vis_src.y, vis_dst.x, vis_dst.y,
> +                                   vis_dst.width, vis_dst.height);
>         } else if (use_pixman_blt) {
>             /* FIXME: We only really need a temporary if src and dst overlap */
> -            int llb = ctx->dst.width * (ctx->bpp / 8);
> +            int llb = vis_dst.width * (ctx->bpp / 8);
>             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
>             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
> -                                     ctx->dst.height);
> +                                     vis_dst.height);
>             fallback = !pixman_blt((uint32_t *)ctx->src_bits, tmp,
>                                    src_stride_words, tmp_stride, ctx->bpp,
> -                                   ctx->bpp, ctx->src.x, ctx->src.y, 0, 0,
> -                                   ctx->dst.width, ctx->dst.height);
> +                                   ctx->bpp, vis_src.x, vis_src.y, 0, 0,
> +                                   vis_dst.width, vis_dst.height);
>             if (!fallback) {
>                 fallback = !pixman_blt(tmp, (uint32_t *)ctx->dst_bits,
>                                        tmp_stride, dst_stride_words, ctx->bpp,
> -                                       ctx->bpp, 0, 0, ctx->dst.x, ctx->dst.y,
> -                                       ctx->dst.width, ctx->dst.height);
> +                                       ctx->bpp, 0, 0, vis_dst.x, vis_dst.y,
> +                                       vis_dst.width, vis_dst.height);
>             }
>             g_free(tmp);
>         } else
> @@ -189,20 +212,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>         }
>         if (fallback) {
>             unsigned int y, i, j, bypp = ctx->bpp / 8;
> -            for (y = 0; y < ctx->dst.height; y++) {
> -                i = ctx->dst.x * bypp;
> -                j = ctx->src.x * bypp;
> +            for (y = 0; y < vis_dst.height; y++) {
> +                i = vis_dst.x * bypp;
> +                j = vis_src.x * bypp;
>                 if (ctx->top_to_bottom) {
> -                    i += (ctx->dst.y + y) * ctx->dst_stride;
> -                    j += (ctx->src.y + y) * ctx->src_stride;
> +                    i += (vis_dst.y + y) * ctx->dst_stride;
> +                    j += (vis_src.y + y) * ctx->src_stride;
>                 } else {
> -                    i += (ctx->dst.y + ctx->dst.height - 1 - y)
> +                    i += (vis_dst.y + vis_dst.height - 1 - y)
>                          * ctx->dst_stride;
> -                    j += (ctx->src.y + ctx->dst.height - 1 - y)
> +                    j += (vis_src.y + vis_dst.height - 1 - y)
>                          * ctx->src_stride;
>                 }
>                 memmove(&ctx->dst_bits[i], &ctx->src_bits[j],
> -                        ctx->dst.width * bypp);
> +                        vis_dst.width * bypp);
>             }
>         }
>         break;
> @@ -230,20 +253,20 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>         }
>
>         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> -                ctx->dst_bits, dst_stride_words, ctx->bpp, ctx->dst.x,
> -                ctx->dst.y, ctx->dst.width, ctx->dst.height, filler);
> +                ctx->dst_bits, dst_stride_words, ctx->bpp, vis_dst.x,
> +                vis_dst.y, vis_dst.width, vis_dst.height, filler);
> #ifdef CONFIG_PIXMAN
>         if (!use_pixman_fill ||
> -            !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
> -                         ctx->dst.x, ctx->dst.y,
> -                         ctx->dst.width, ctx->dst.height, filler))
> +             !pixman_fill((uint32_t *)ctx->dst_bits, dst_stride_words, ctx->bpp,
> +                          vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height,
> +                          filler))
> #endif
>         {
>             /* fallback when pixman failed or we don't want to call it */
>             unsigned int x, y, i, bypp = ctx->bpp / 8;
> -            for (y = 0; y < ctx->dst.height; y++) {
> -                i = ctx->dst.x * bypp + (ctx->dst.y + y) * ctx->dst_stride;
> -                for (x = 0; x < ctx->dst.width; x++, i += bypp) {
> +            for (y = 0; y < vis_dst.height; y++) {
> +                i = vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stride;
> +                for (x = 0; x < vis_dst.width; x++, i += bypp) {
>                     stn_he_p(&ctx->dst_bits[i], bypp, filler);
>                 }
>             }
>

