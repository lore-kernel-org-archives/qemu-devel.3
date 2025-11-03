Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFud3-0000yk-PW; Mon, 03 Nov 2025 08:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFud0-0000yE-QU
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:29:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFucl-0003Nm-Jv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:29:45 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C924F5972F3;
 Mon, 03 Nov 2025 14:29:26 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NacjBq-eSNoe; Mon,  3 Nov 2025 14:29:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D1355972E3; Mon, 03 Nov 2025 14:29:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B64C5972E2;
 Mon, 03 Nov 2025 14:29:24 +0100 (CET)
Date: Mon, 3 Nov 2025 14:29:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/7] ati-vga: Implement scissor rectangle clipping
 for 2D operations
In-Reply-To: <20251103033608.120908-3-chad@jablonski.xyz>
Message-ID: <c083bd27-f105-1837-2dfe-0ea60a0f49de@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-3-chad@jablonski.xyz>
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
> Use scissor registers to clip blit operations. This is required
> for text rendering in X using the r128 driver. Without it overly-wide
> glyphs are drawn and create all sorts of chaos.
>
> Use QemuRect helpers for calculating the intersection of the
> destination and scissor rectangles. Source coordinates are
> also updated to reflect clipping. The original destination dimensions
> are stored in 'dst' while the clipped rectangle is in 'clipped' for
> clear distinction between the two.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 110 +++++++++++++++++++++++++++-----------------
> 1 file changed, 69 insertions(+), 41 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6..15cf29a061 100644
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
> @@ -54,10 +55,35 @@ void ati_2d_blt(ATIVGAState *s)
>             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
>             surface_bits_per_pixel(ds),
>             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> -    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> -    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +
> +    QemuRect dst;
> +    {
> +        unsigned dst_width = s->regs.dst_width;
> +        unsigned dst_height = s->regs.dst_height;
> +        unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                          s->regs.dst_x : s->regs.dst_x + 1 - dst_width);
> +        unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                          s->regs.dst_y : s->regs.dst_y + 1 - dst_height);
> +        qemu_rect_init(&dst, dst_x, dst_y, dst_width, dst_height);
> +    }

This is a bit unusual style putting variable init in a block. I'm not sure 
it's acceptable for QEMU, maybe you could put it in a static helper 
function which is more usual style.

> +
> +    QemuRect scissor;
> +    {
> +        uint16_t sc_left = s->regs.sc_top_left & 0x3fff;
> +        uint16_t sc_top = (s->regs.sc_top_left >> 16) & 0x3fff;
> +        uint16_t sc_right = s->regs.sc_bottom_right & 0x3fff;
> +        uint16_t sc_bottom = (s->regs.sc_bottom_right >> 16) & 0x3fff;
> +        qemu_rect_init(&scissor, sc_left, sc_top,
> +                       sc_right - sc_left + 1, sc_bottom - sc_top + 1);
> +    }

This could be checked on real hardware too what happens if you store 
something in reserved bits (the docs may suggest that e.g. SC_BOTTOM, 
SC_RIGHT and SC_BOTTOM_RIGHT might be the same register so writing 
reserved bits may overwrite others or masked out by hardware but it's not 
clear from docs; the rage128pro docs aren't even clear on what the limits 
are as the summary text in the section 3.28 gives different limits than 
individual register descriptions right after that). To simplify using 
these values I generally tried to apply reserved bits mask on write so no 
need to do that at read and using the values. Maybe these should do the 
same?

Regards,
BALATON Zoltan

> +
> +    QemuRect clipped;
> +    if (!qemu_rect_intersect(&dst, &scissor, &clipped)) {
> +        return;
> +    }
> +    uint32_t clip_left = clipped.x - dst.x;
> +    uint32_t clip_top = clipped.y - dst.y;
> +
>     int bpp = ati_bpp_from_datatype(s);
>     if (!bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> @@ -76,17 +102,16 @@ void ati_2d_blt(ATIVGAState *s)
>         dst_stride *= bpp;
>     }
>     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> -    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
> -        || dst_bits + dst_x
> -         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
> +    if (clipped.x > 0x3fff || clipped.y > 0x3fff || dst_bits >= end
> +        || dst_bits + clipped.x
> +         + (clipped.y + clipped.height) * dst_stride >= end) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
>     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
>             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
>             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
> -            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
> -            s->regs.dst_width, s->regs.dst_height,
> +            s->regs.src_x, s->regs.src_y, dst.x, dst.y, dst.width, dst.height,
>             (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
>             (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
>     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> @@ -94,9 +119,11 @@ void ati_2d_blt(ATIVGAState *s)
>     {
>         bool fallback = false;
>         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> +                         s->regs.src_x + clip_left :
> +                         s->regs.src_x + 1 - dst.width + clip_left);
>         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
> +                         s->regs.src_y + clip_top :
> +                         s->regs.src_y + 1 - dst.height + clip_top);
>         int src_stride = DEFAULT_CNTL ?
>                          s->regs.src_pitch : s->regs.default_pitch;
>         if (!src_stride) {
> @@ -112,7 +139,7 @@ void ati_2d_blt(ATIVGAState *s)
>         }
>         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
>             || src_bits + src_x
> -             + (src_y + s->regs.dst_height) * src_stride >= end) {
> +             + (src_y + clipped.height) * src_stride >= end) {
>             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>             return;
>         }
> @@ -121,31 +148,31 @@ void ati_2d_blt(ATIVGAState *s)
>         dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
>                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> -                src_x, src_y, dst_x, dst_y,
> -                s->regs.dst_width, s->regs.dst_height);
> +                src_x, src_y, clipped.x, clipped.y,
> +                clipped.width, clipped.height);
> #ifdef CONFIG_PIXMAN
>         if ((s->use_pixman & BIT(1)) &&
>             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
>             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
>             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
>                                    src_stride, dst_stride, bpp, bpp,
> -                                   src_x, src_y, dst_x, dst_y,
> -                                   s->regs.dst_width, s->regs.dst_height);
> +                                   src_x, src_y, clipped.x, clipped.y,
> +                                   clipped.width, clipped.height);
>         } else if (s->use_pixman & BIT(1)) {
>             /* FIXME: We only really need a temporary if src and dst overlap */
> -            int llb = s->regs.dst_width * (bpp / 8);
> +            int llb = clipped.width * (bpp / 8);
>             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
>             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
> -                                     s->regs.dst_height);
> +                                     clipped.height);
>             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
>                                    src_stride, tmp_stride, bpp, bpp,
>                                    src_x, src_y, 0, 0,
> -                                   s->regs.dst_width, s->regs.dst_height);
> +                                   clipped.width, clipped.height);
>             if (!fallback) {
>                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
>                                        tmp_stride, dst_stride, bpp, bpp,
> -                                       0, 0, dst_x, dst_y,
> -                                       s->regs.dst_width, s->regs.dst_height);
> +                                       0, 0, clipped.x, clipped.y,
> +                                       clipped.width, clipped.height);
>             }
>             g_free(tmp);
>         } else
> @@ -158,17 +185,17 @@ void ati_2d_blt(ATIVGAState *s)
>             unsigned int src_pitch = src_stride * sizeof(uint32_t);
>             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
>
> -            for (y = 0; y < s->regs.dst_height; y++) {
> -                i = dst_x * bypp;
> +            for (y = 0; y < clipped.height; y++) {
> +                i = clipped.x * bypp;
>                 j = src_x * bypp;
>                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> -                    i += (dst_y + y) * dst_pitch;
> +                    i += (clipped.y + y) * dst_pitch;
>                     j += (src_y + y) * src_pitch;
>                 } else {
> -                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
> -                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
> +                    i += (clipped.y + clipped.height - 1 - y) * dst_pitch;
> +                    j += (src_y + clipped.height - 1 - y) * src_pitch;
>                 }
> -                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
> +                memmove(&dst_bits[i], &src_bits[j], clipped.width * bypp);
>             }
>         }
>         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> @@ -176,13 +203,13 @@ void ati_2d_blt(ATIVGAState *s)
>             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
>             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
>                                     s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> +                                    clipped.y * surface_stride(ds),
> +                                    clipped.height * surface_stride(ds));
>         }
>         s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                         dst_x + s->regs.dst_width : dst_x);
> +                         clipped.x + clipped.width : clipped.x);
>         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
> +                         clipped.y + clipped.height : clipped.y);
>         break;
>     }
>     case ROP3_PATCOPY:
> @@ -207,20 +234,21 @@ void ati_2d_blt(ATIVGAState *s)
>
>         dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> -                dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                s->regs.dst_width, s->regs.dst_height, filler);
> +                dst_bits, dst_stride, bpp, clipped.x, clipped.y,
> +                clipped.width, clipped.height, filler);
> #ifdef CONFIG_PIXMAN
>         if (!(s->use_pixman & BIT(0)) ||
> -            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                    s->regs.dst_width, s->regs.dst_height, filler))
> +            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
> +                         clipped.x, clipped.y, clipped.width, clipped.height,
> +                         filler))
> #endif
>         {
>             /* fallback when pixman failed or we don't want to call it */
>             unsigned int x, y, i, bypp = bpp / 8;
>             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
> -            for (y = 0; y < s->regs.dst_height; y++) {
> -                i = dst_x * bypp + (dst_y + y) * dst_pitch;
> -                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
> +            for (y = 0; y < clipped.height; y++) {
> +                i = clipped.x * bypp + (clipped.y + y) * dst_pitch;
> +                for (x = 0; x < clipped.width; x++, i += bypp) {
>                     stn_he_p(&dst_bits[i], bypp, filler);
>                 }
>             }
> @@ -230,11 +258,11 @@ void ati_2d_blt(ATIVGAState *s)
>             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
>             memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
>                                     s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> +                                    clipped.y * surface_stride(ds),
> +                                    clipped.height * surface_stride(ds));
>         }
>         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
> +                         clipped.y + clipped.height : clipped.y);
>         break;
>     }
>     default:
>

