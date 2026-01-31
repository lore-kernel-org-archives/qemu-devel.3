Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC6FD79767
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm8Ek-0003Hg-Ad; Sat, 31 Jan 2026 05:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm8Ej-0003HS-3q
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:29:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm8Eh-0001lE-Jj
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:29:52 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA584596A0A;
 Sat, 31 Jan 2026 11:29:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id J_Hd9EH1fDwt; Sat, 31 Jan 2026 11:29:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C92985969FD; Sat, 31 Jan 2026 11:29:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C3CE15969F2;
 Sat, 31 Jan 2026 11:29:47 +0100 (CET)
Date: Sat, 31 Jan 2026 11:29:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 16/20] ati-vga: Remove ATIVGAState param from
 ati_2d_do_blt
In-Reply-To: <20260130145005.731129-17-chad@jablonski.xyz>
Message-ID: <1c2909b5-b682-ea56-2dab-ef2aea8c7727@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-17-chad@jablonski.xyz>
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
> This completes the decoupling from the ATIVGAState struct.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 5c15c3ec70..89a9d006af 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -68,6 +68,10 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
> {
>     DisplaySurface *ds = qemu_console_surface(vga->con);
>     unsigned dst_offset = ctx->dst_bits - vga->vram_ptr;
> +    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr,
> +            vga->vbe_start_addr, surface_data(ds), surface_stride(ds),
> +            surface_bits_per_pixel(ds),
> +            ctx->rop3 >> 16);
>     if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
>         ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
>         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
> @@ -114,16 +118,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>     }
> }
>
> -static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
> +static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
>     bool use_pixman_fill = use_pixman & BIT(0);
>     bool use_pixman_blt = use_pixman & BIT(1);
> -    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
> -            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
> -            surface_bits_per_pixel(ds),
> -            ctx->rop3 >> 16);
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
> @@ -140,9 +140,8 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
> -    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
> -            s->regs.src_offset, dst_offset, s->regs.default_offset,
> -            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
> +    DPRINTF("%d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
> +            ctx->src_stride, ctx->dst_stride,

We lose logging the offsets here. Maybe these debug logs shold be moved to 
setup_2d_blt_ctx instead?

Regards,
BALATON Zoltan

>             ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
>             ctx->dst.width, ctx->dst.height,
>             (ctx->left_to_right ? '>' : '<'),
> @@ -278,6 +277,6 @@ void ati_2d_blt(ATIVGAState *s)
> {
>     ATI2DCtx ctx;
>     setup_2d_blt_ctx(s, &ctx);
> -    ati_2d_do_blt(s, &ctx, s->use_pixman);
> +    ati_2d_do_blt(&ctx, s->use_pixman);
>     ati_set_dirty(&s->vga, &ctx);
> }
>

