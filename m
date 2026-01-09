Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A389ED1D487
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBIK-0005XF-Ub; Fri, 09 Jan 2026 07:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veBHZ-0005KI-La
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:07:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veBHU-0000ss-Q4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4FD46596AC0;
 Fri, 09 Jan 2026 13:07:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4B32v69LYEaF; Fri,  9 Jan 2026 13:07:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8E2C596ABD; Fri, 09 Jan 2026 13:07:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6B7C5969E4;
 Fri, 09 Jan 2026 13:07:47 +0100 (CET)
Date: Fri, 9 Jan 2026 13:07:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] ati-vga: Refactor ati_2d_blt to accept src and dst
 parameters
In-Reply-To: <20260109045035.2931091-1-chad@jablonski.xyz>
Message-ID: <3fb14280-960b-d923-dd5d-3748450acc70@eik.bme.hu>
References: <20260109045035.2931091-1-chad@jablonski.xyz>
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

On Thu, 8 Jan 2026, Chad Jablonski wrote:
> My attempt at implementing HOST_DATA blits resulted in a lot of
> duplicated logic (pointed out by BALATON). This separates the src and

https://en.wikipedia.org/wiki/Eastern_name_order#Hungary
That's what capitalisation is meant to show but not many seem to know 
about that convention. No worries though not many got it at first.

> dst blit configuration from the actual mechanics of the blit.
>
> ati_2d_blt accepts an ATIBlitSrc and ATIBlitDst. What remains in ati_2d_blt is
> the logic for writing to VRAM both in the pixman and fallback cases.
>
> ati_2d_blt_from_memory becomes the public interface for memory-based
> blits. All existing calls to ati_2d_blt are replaced with it. It is
> responsible for setting up the src and dst for memory blits and then
> calling the blitter. It could be that the setup_2d_blt_src and/or
> setup_2d_blt_dst end up inlined here also but for the time being keeping
> that separation has been helpful. I think the differences will become
> much more clear with the HOST_DATA implementation.
>
> Without getting too much into HOST_DATA implementation its blits work
> differently. They progressively flush an accumulator and do color expansion
> instead of blitting an entire rectangular region. This refactor will
> allow the future HOST_DATA implementation to flush and expand and then
> pass the resulting bits along in the src to ati_2d_blt. ati_2d_blt
> doesn't need to care about the actual source.
>
> I realize this is a large change. If this looks like a good direction my plan
> would be to present this in either a standalone series or part of the
> existing HOST_DATA series. Either way this would obviously be some work so I'm
> presenting the final result here as an RFC first.

I'll need to look at it in more detail but some quick comments at first 
glance.

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      |   8 +-
> hw/display/ati_2d.c   | 310 +++++++++++++++++++++++++-----------------
> hw/display/ati_int.h  |   2 +-
> hw/display/ati_regs.h |   1 +
> 4 files changed, 189 insertions(+), 132 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e9c3ad2cd1..8f2f9cba95 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -805,7 +805,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         break;
>     case DST_WIDTH:
>         s->regs.dst_width = data & 0x3fff;
> -        ati_2d_blt(s);
> +        ati_2d_blt_from_memory(s);

We could save this churn by keeping the ati_2d_blt name for the full 
functionality and split off the core into ati_2d_do_blt or something else 
if you can invent a better name.

>         break;
>     case DST_HEIGHT:
>         s->regs.dst_height = data & 0x3fff;
> @@ -855,7 +855,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_HEIGHT_WIDTH:
>         s->regs.dst_width = data & 0x3fff;
>         s->regs.dst_height = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        ati_2d_blt_from_memory(s);
>         break;
>     case DP_GUI_MASTER_CNTL:
>         s->regs.dp_gui_master_cntl = data & 0xf800000f;
> @@ -866,7 +866,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_WIDTH_X:
>         s->regs.dst_x = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        ati_2d_blt_from_memory(s);
>         break;
>     case SRC_X_Y:
>         s->regs.src_y = data & 0x3fff;
> @@ -879,7 +879,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_WIDTH_HEIGHT:
>         s->regs.dst_height = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        ati_2d_blt_from_memory(s);
>         break;
>     case DST_HEIGHT_Y:
>         s->regs.dst_y = data & 0x3fff;
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6..1296bf822e 100644
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
> @@ -24,6 +25,24 @@
>  * possible.
>  */
>
> +typedef struct {
> +    int x;
> +    int y;
> +    int stride;
> +    bool valid;
> +    uint8_t *bits;
> +} ATIBlitSrc;
> +
> +typedef struct {
> +    QemuRect rect;
> +    int bpp;
> +    int stride;
> +    bool top_to_bottom;
> +    bool left_to_right;
> +    bool valid;
> +    uint8_t *bits;
> +} ATIBlitDst;
> +
> static int ati_bpp_from_datatype(ATIVGAState *s)
> {
>     switch (s->regs.dp_datatype & 0xf) {
> @@ -45,107 +64,152 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>
> #define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
>
> -void ati_2d_blt(ATIVGAState *s)
> +static ATIBlitDst setup_2d_blt_dst(ATIVGAState *s)
> {
> -    /* FIXME it is probably more complex than this and may need to be */
> -    /* rewritten but for now as a start just to get some output: */
> -    DisplaySurface *ds = qemu_console_surface(s->vga.con);
> -    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
> -            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
> -            surface_bits_per_pixel(ds),
> -            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> -    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> -    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> -    int bpp = ati_bpp_from_datatype(s);
> -    if (!bpp) {
> +    ATIBlitDst dst = {
> +        .valid = false,
> +        .bpp = ati_bpp_from_datatype(s),
> +        .stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch,
> +        .left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT,
> +        .top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM,
> +        .bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> +                s->regs.dst_offset : s->regs.default_offset),
> +    };
> +    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> +    unsigned dst_x = (dst.left_to_right ?
> +                     s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> +    unsigned dst_y = (dst.top_to_bottom ?
> +                     s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    qemu_rect_init(&dst.rect, dst_x, dst_y,
> +                   s->regs.dst_width, s->regs.dst_height);
> +
> +    if (!dst.bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> -        return;
> +        return dst;

Does this work? I think you can't return a pointer to a local so this 
might need to take an ATIBlitDst * and init the struct passed to it by 
that then it could return bool and remove the valid field from the struct 
which seems to be confusing and may be better returned directly.

>     }
> -    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
> -    if (!dst_stride) {
> +    if (!dst.stride) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
> -        return;
> +        return dst;
>     }
> -    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> -                        s->regs.dst_offset : s->regs.default_offset);
> -
>     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -        dst_bits += s->regs.crtc_offset & 0x07ffffff;
> -        dst_stride *= bpp;
> +        dst.bits += s->regs.crtc_offset & 0x07ffffff;
> +        dst.stride *= dst.bpp;
> +    }
> +    if (dst.rect.x > 0x3fff || dst.rect.y > 0x3fff || dst.bits >= end
> +        || dst.bits + dst.rect.x
> +         + (dst.rect.y + dst.rect.height) * dst.stride >= end) {
> +        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +        return dst;
>     }
> +
> +    dst.valid = true;
> +
> +    return dst;
> +}
> +
> +static ATIBlitSrc setup_2d_blt_src(ATIVGAState *s, const ATIBlitDst *dst)
> +{
> +    ATIBlitSrc src = {
> +        .valid = false,
> +        .x = (dst->left_to_right ?
> +             s->regs.src_x : s->regs.src_x + 1 - dst->rect.width),
> +        .y = (dst->top_to_bottom ?
> +             s->regs.src_y : s->regs.src_y + 1 - dst->rect.height),
> +        .stride = DEFAULT_CNTL ? s->regs.src_pitch : s->regs.default_pitch,
> +        .bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> +                s->regs.src_offset : s->regs.default_offset),
> +    };
>     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> -    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
> -        || dst_bits + dst_x
> -         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
> +
> +    if (!src.stride) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
> +        return src;

Likewise here.

> +    }
> +
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        src.bits += s->regs.crtc_offset & 0x07ffffff;
> +        src.stride *= dst->bpp;
> +    }
> +
> +    if (src.x > 0x3fff || src.y > 0x3fff || src.bits >= end
> +        || src.bits + src.x
> +         + (src.y + dst->rect.height) * src.stride >= end) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> -        return;
> +        return src;
>     }
> +
> +    src.valid = true;
> +
> +    return src;
> +}
> +
> +static void ati_set_dirty(ATIVGAState *s, const ATIBlitDst *dst)
> +{
> +    DisplaySurface *ds = qemu_console_surface(s->vga.con);
> +    if (dst->bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> +        dst->bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> +        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> +        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> +                                s->regs.dst_offset +
> +                                dst->rect.y * surface_stride(ds),
> +                                dst->rect.height * surface_stride(ds));
> +    }
> +}
> +
> +static void ati_2d_blt(ATIVGAState *s, ATIBlitSrc src, ATIBlitDst dst)
> +{
> +    /* FIXME it is probably more complex than this and may need to be */
> +    /* rewritten but for now as a start just to get some output: */
> +    uint32_t rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
> +    bool use_pixman = s->use_pixman & BIT(1);
> +    int dst_stride_words = dst.stride / sizeof(uint32_t);
> +    int src_stride_words = src.stride / sizeof(uint32_t);
> +
> +    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
> +            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
> +            surface_bits_per_pixel(ds), rop3 >> 16);
>     DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
>             s->regs.src_offset, s->regs.dst_offset, s->regs.default_offset,
>             s->regs.src_pitch, s->regs.dst_pitch, s->regs.default_pitch,
> -            s->regs.src_x, s->regs.src_y, dst_x, dst_y,
> -            s->regs.dst_width, s->regs.dst_height,
> -            (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
> -            (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
> -    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +            s->regs.src_x, s->regs.src_y,
> +            dst.rect.x, dst.rect.y, dst.rect.width, dst.rect.height,
> +            (dst.left_to_right ? '>' : '<'),
> +            (dst.top_to_bottom ? 'v' : '^'));
> +
> +    switch (rop3) {
>     case ROP3_SRCCOPY:
>     {
>         bool fallback = false;
> -        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> -        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
> -        int src_stride = DEFAULT_CNTL ?
> -                         s->regs.src_pitch : s->regs.default_pitch;
> -        if (!src_stride) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
> -            return;
> -        }
> -        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> -                            s->regs.src_offset : s->regs.default_offset);
>
> -        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -            src_bits += s->regs.crtc_offset & 0x07ffffff;
> -            src_stride *= bpp;
> -        }
> -        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
> -            || src_bits + src_x
> -             + (src_y + s->regs.dst_height) * src_stride >= end) {
> -            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> -            return;
> -        }
> -
> -        src_stride /= sizeof(uint32_t);
> -        dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
> -                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> -                src_x, src_y, dst_x, dst_y,
> -                s->regs.dst_width, s->regs.dst_height);
> +                src.bits, dst.bits, src_stride_words, dst_stride_words,
> +                dst.bpp, dst.bpp, src.x, src.y,
> +                dst.rect.x, dst.rect.y,
> +                dst.rect.width, dst.rect.height);
> #ifdef CONFIG_PIXMAN
> -        if ((s->use_pixman & BIT(1)) &&
> -            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
> -            s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> -            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
> -                                   src_stride, dst_stride, bpp, bpp,
> -                                   src_x, src_y, dst_x, dst_y,
> -                                   s->regs.dst_width, s->regs.dst_height);
> -        } else if (s->use_pixman & BIT(1)) {
> +        if (use_pixman &&
> +            dst.left_to_right && dst.top_to_bottom) {
> +            fallback = !pixman_blt((uint32_t *)src.bits, (uint32_t *)dst.bits,
> +                                   src_stride_words, dst_stride_words,
> +                                   dst.bpp, dst.bpp,
> +                                   src.x, src.y, dst.rect.x, dst.rect.y,
> +                                   dst.rect.width, dst.rect.height);
> +        } else if (use_pixman) {
>             /* FIXME: We only really need a temporary if src and dst overlap */
> -            int llb = s->regs.dst_width * (bpp / 8);
> +            int llb = dst.rect.width * (dst.bpp / 8);
>             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
>             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
> -                                     s->regs.dst_height);
> -            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
> -                                   src_stride, tmp_stride, bpp, bpp,
> -                                   src_x, src_y, 0, 0,
> -                                   s->regs.dst_width, s->regs.dst_height);
> +                                     dst.rect.height);
> +            fallback = !pixman_blt((uint32_t *)src.bits, tmp,
> +                                   src_stride_words, tmp_stride, dst.bpp, dst.bpp,
> +                                   src.x, src.y, 0, 0,
> +                                   dst.rect.width, dst.rect.height);
>             if (!fallback) {
> -                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
> -                                       tmp_stride, dst_stride, bpp, bpp,
> -                                       0, 0, dst_x, dst_y,
> -                                       s->regs.dst_width, s->regs.dst_height);
> +                fallback = !pixman_blt(tmp, (uint32_t *)dst.bits,
> +                                       tmp_stride, dst_stride_words,
> +                                       dst.bpp, dst.bpp,
> +                                       0, 0, dst.rect.x, dst.rect.y,
> +                                       dst.rect.width, dst.rect.height);
>             }
>             g_free(tmp);
>         } else
> @@ -154,35 +218,25 @@ void ati_2d_blt(ATIVGAState *s)
>             fallback = true;
>         }
>         if (fallback) {
> -            unsigned int y, i, j, bypp = bpp / 8;
> -            unsigned int src_pitch = src_stride * sizeof(uint32_t);
> -            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
> -
> -            for (y = 0; y < s->regs.dst_height; y++) {
> -                i = dst_x * bypp;
> -                j = src_x * bypp;
> -                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> -                    i += (dst_y + y) * dst_pitch;
> -                    j += (src_y + y) * src_pitch;
> +            unsigned int y, i, j, bypp = dst.bpp / 8;
> +            for (y = 0; y < dst.rect.height; y++) {
> +                i = dst.rect.x * bypp;
> +                j = src.x * bypp;
> +                if (dst.top_to_bottom) {
> +                    i += (dst.rect.y + y) * dst.stride;
> +                    j += (src.y + y) * src.stride;
>                 } else {
> -                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
> -                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
> +                    i += (dst.rect.y + dst.rect.height - 1 - y) * dst.stride;
> +                    j += (src.y + dst.rect.height - 1 - y) * src.stride;
>                 }
> -                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
> +                memmove(&dst.bits[i], &src.bits[j], dst.rect.width * bypp);
>             }
>         }
> -        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> -            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> -            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> -            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> -                                    s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> -        }
> -        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                         dst_x + s->regs.dst_width : dst_x);
> -        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
> +        ati_set_dirty(s, &dst);
> +        s->regs.dst_x = (dst.left_to_right ?
> +                         dst.rect.x + dst.rect.width : dst.rect.x);
> +        s->regs.dst_y = (dst.top_to_bottom ?
> +                         dst.rect.y + dst.rect.height : dst.rect.y);
>         break;
>     }
>     case ROP3_PATCOPY:
> @@ -191,7 +245,7 @@ void ati_2d_blt(ATIVGAState *s)
>     {
>         uint32_t filler = 0;
>
> -        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +        switch (rop3) {
>         case ROP3_PATCOPY:
>             filler = s->regs.dp_brush_frgd_clr;
>             break;
> @@ -205,40 +259,42 @@ void ati_2d_blt(ATIVGAState *s)
>             break;
>         }
>
> -        dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> -                dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                s->regs.dst_width, s->regs.dst_height, filler);
> +                dst.bits, dst_stride_words, dst.bpp, dst.rect.x, dst.rect.y,
> +                dst.rect.width, dst.rect.height, filler);
> #ifdef CONFIG_PIXMAN
> -        if (!(s->use_pixman & BIT(0)) ||
> -            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                    s->regs.dst_width, s->regs.dst_height, filler))
> +        if (!use_pixman ||
> +            !pixman_fill((uint32_t *)dst.bits, dst_stride_words, dst.bpp,
> +                         dst.rect.x, dst.rect.y,
> +                         dst.rect.width, dst.rect.height, filler))
> #endif
>         {
>             /* fallback when pixman failed or we don't want to call it */
> -            unsigned int x, y, i, bypp = bpp / 8;
> -            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
> -            for (y = 0; y < s->regs.dst_height; y++) {
> -                i = dst_x * bypp + (dst_y + y) * dst_pitch;
> -                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
> -                    stn_he_p(&dst_bits[i], bypp, filler);
> +            unsigned int x, y, i, bypp = dst.bpp / 8;
> +            for (y = 0; y < dst.rect.height; y++) {
> +                i = dst.rect.x * bypp + (dst.rect.y + y) * dst.stride;
> +                for (x = 0; x < dst.rect.width; x++, i += bypp) {
> +                    stn_he_p(&dst.bits[i], bypp, filler);
>                 }
>             }
>         }
> -        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> -            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> -            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> -            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> -                                    s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> -        }
> -        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
> +        ati_set_dirty(s, &dst);
> +        s->regs.dst_y = (dst.top_to_bottom ?
> +                         dst.rect.y + dst.rect.height : dst.rect.y);
>         break;
>     }
>     default:
>         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
> -                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +                      rop3 >> 16);
> +    }
> +}
> +
> +void ati_2d_blt_from_memory(ATIVGAState *s)
> +{
> +    if ((s->regs.dp_mix & DP_SRC_SOURCE) != DP_SRC_RECT) {
> +        return;
>     }
> +    ATIBlitDst dst = setup_2d_blt_dst(s);
> +    ATIBlitSrc src = setup_2d_blt_src(s, &dst);
> +    ati_2d_blt(s, src, dst);
> }
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..0a3013d657 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -104,6 +104,6 @@ struct ATIVGAState {
>
> const char *ati_reg_name(int num);
>
> -void ati_2d_blt(ATIVGAState *s);
> +void ati_2d_blt_from_memory(ATIVGAState *s);
>
> #endif /* ATI_INT_H */
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..2b86dcdf46 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -434,6 +434,7 @@
> #define DST_POLY_EDGE                           0x00040000
>
> /* DP_MIX bit constants */
> +#define DP_SRC_SOURCE                           0x00000700
> #define DP_SRC_RECT                             0x00000200
> #define DP_SRC_HOST                             0x00000300
> #define DP_SRC_HOST_BYTEALIGN                   0x00000400

Keep these sorted by value rather than name.

Regards,
BALATON Zoltan

