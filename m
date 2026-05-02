Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99518CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 14:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJAv7-0004t3-OS; Sat, 02 May 2026 10:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wJAv1-0004rS-61
 for qemu-devel@nongnu.org; Sat, 02 May 2026 10:02:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wJAuy-0007rQ-K4
 for qemu-devel@nongnu.org; Sat, 02 May 2026 10:02:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01125596967;
 Sat, 02 May 2026 16:02:01 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JLWz0MBExucb; Sat,  2 May 2026 16:01:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C9FDE59695A; Sat, 02 May 2026 16:01:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C826C596958;
 Sat, 02 May 2026 16:01:58 +0200 (CEST)
Date: Sat, 2 May 2026 16:01:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <20260429175434.474429-1-chad@jablonski.xyz>
Message-ID: <98ad9ff8-7227-fc11-a221-22fc73f75f47@eik.bme.hu>
References: <20260429175434.474429-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Wed, 29 Apr 2026, Chad Jablonski wrote:
> This fixes three bugs with the ati_set_dirty address calculation.

Good catch, thanks for finding this.

> First, vbe_start_addr is a word offset. All other values in the
> calculation are byte offsets. It must be converted to bytes.
>
> Second, when setting the dirty region with memory_region_set_dirty
> the vbe_start_addr is used to calculate the start of the dirty region.
> This is a problem because the vbe_start_addr is the offset at which scan out
> begins. This puts it in the visible screen coordinate system. The dirty
> region however is in the virtual screen coordinate system. This can cause both
> overmarking and missed updates. This is removed from the calculation.
>
> Third, when the start address of a blit is outside of the bounds check
> the entire blit is missed and not set to dirty. This happens even if the
> blit does partially overlap with the visible screen. The fix here is to
> find the intersection of the visible screen and the blit and mark only
> that region as dirty.
>
> This does not attempt to apply clipping to the blit. So there will be
> overmarking in some cases.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 26 +++++++++++++++++++-------
> 1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 504d1c5708..3192b864fd 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -69,19 +69,31 @@ typedef struct {
> static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
> {
>     DisplaySurface *ds = qemu_console_surface(vga->con);
> +    unsigned int bypp = ctx->bpp / 8;
> +    unsigned long dirty_size = ((ctx->dst.height - 1) * ctx->dst_stride) +
> +                               (ctx->dst.width * bypp);

dirty_size is only used once below for dirty_end so maybe it does not need 
a separate variable just do the calculation on one line similar to 
vis_end and inline this in dirty_end.

> +    uint8_t *dirty_start = ctx->dst_bits + (ctx->dst.y * ctx->dst_stride) +
> +                           (ctx->dst.x * bypp);
> +    uint8_t *dirty_end = dirty_start + dirty_size;
> +    /*
> +     * The blit may be outside of the visible screen (e.g. virtual desktops.)
> +     * Dirty only the intersection of the visible screen and the blit.
> +     */
> +    uint8_t *vis_start = vga->vram_ptr + (vga->vbe_start_addr * 4);

There are excessive parenthesis in above formulas, these are not needed 
around multiplications. I see the intent but it's not usually done in 
QEMU so these could be dropped.

Instead of adding vga->vram_ptr here and then substracting it in 
memory_region_set_dirty below again maybe keep these offsets and substract 
vga->vram_ptr from ctx->dst_bits in dirty_start once instead.

> +    uint8_t *vis_end = vis_start + vga->vbe_regs[VBE_DISPI_INDEX_YRES] *
> +                       vga->vbe_line_offset;
> +    uint8_t *start = MAX(vis_start, dirty_start);
> +    uint8_t *end = MIN(vis_end, dirty_end);
>
>     (void)ds;
>     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
>             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
>             ctx->rop3 >> 16);
> -    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
> -        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
> -        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
> -        memory_region_set_dirty(&vga->vram,
> -                                vga->vbe_start_addr + ctx->dst_offset +
> -                                ctx->dst.y * ctx->dst_stride,
> -                                ctx->dst.height * ctx->dst_stride);
> +
> +    if (start >= end) {
> +        return;
>     }
> +    memory_region_set_dirty(&vga->vram, start - vga->vram_ptr, end - start);

I'm never sure about sizes and off by one errors so can't tell if that's 
correct but I've tested it and it still fixes my reproducer so this seems 
to work. Please also cc qemu-stable for the next version of the patch.

Regards,
BALATON Zoltan

> }
>
> static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>

