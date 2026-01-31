Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0959D79769
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm8A1-0008K8-LU; Sat, 31 Jan 2026 05:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm89y-0008JF-3D
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:24:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm89v-0001Be-Vq
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:24:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BFE9E596A42;
 Sat, 31 Jan 2026 11:24:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id dup1mmPX-1P5; Sat, 31 Jan 2026 11:24:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B80B4596A41; Sat, 31 Jan 2026 11:24:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B66B9596A3F;
 Sat, 31 Jan 2026 11:24:51 +0100 (CET)
Date: Sat, 31 Jan 2026 11:24:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 15/20] ati-vga: Extract ati_set_dirty helper
 function
In-Reply-To: <20260130145005.731129-16-chad@jablonski.xyz>
Message-ID: <1aebc5db-0a01-1707-75dd-32015df49b2d@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-16-chad@jablonski.xyz>
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

On Fri, 30 Jan 2026, Chad Jablonski wrote:
> This is done in preparation for the removal of the ATIVGAState *s
> parameter. It will also be used by the HOST_DATA implementation.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 24 ++++++++++++++----------
> 1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 39ea67aeb7..5c15c3ec70 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -64,6 +64,19 @@ typedef struct {
>     const uint8_t *src_bits;
> } ATI2DCtx;
>
> +static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
> +{
> +    DisplaySurface *ds = qemu_console_surface(vga->con);
> +    unsigned dst_offset = ctx->dst_bits - vga->vram_ptr;
> +    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
> +        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
> +        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
> +        memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
> +                                dst_offset + ctx->dst.y * surface_stride(ds),
> +                                ctx->dst.height * surface_stride(ds));
> +    }
> +}

Could this be done in patch 8 when consolidating the duplicate? That seems 
to be a good place to also introduce this function.

Regards,
BALATON Zoltan

> +
> static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
> {
>     ctx->bpp = ati_bpp_from_datatype(s);
> @@ -105,14 +118,12 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
> -    DisplaySurface *ds = qemu_console_surface(s->vga.con);
>     bool use_pixman_fill = use_pixman & BIT(0);
>     bool use_pixman_blt = use_pixman & BIT(1);
>     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
>             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
>             surface_bits_per_pixel(ds),
>             ctx->rop3 >> 16);
> -    unsigned dst_offset = s->regs.dst_offset;
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
> @@ -261,14 +272,6 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
>                       ctx->rop3 >> 16);
>         return;
>     }
> -
> -    if (ctx->dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> -        ctx->dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> -        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> -        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> -                                dst_offset + ctx->dst.y * surface_stride(ds),
> -                                ctx->dst.height * surface_stride(ds));
> -    }
> }
>
> void ati_2d_blt(ATIVGAState *s)
> @@ -276,4 +279,5 @@ void ati_2d_blt(ATIVGAState *s)
>     ATI2DCtx ctx;
>     setup_2d_blt_ctx(s, &ctx);
>     ati_2d_do_blt(s, &ctx, s->use_pixman);
> +    ati_set_dirty(&s->vga, &ctx);
> }
>

