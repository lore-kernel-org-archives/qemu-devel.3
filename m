Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD22EF06EC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 21:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpC3v-0004ZE-Na; Sun, 08 Feb 2026 16:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpC3t-0004WV-Lh
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 16:11:21 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpC3q-0004vl-Ls
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 16:11:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B989B5969F6;
 Sun, 08 Feb 2026 22:11:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id he35kP3z-11h; Sun,  8 Feb 2026 22:11:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8138F5969F3; Sun, 08 Feb 2026 22:11:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F39F5969F2;
 Sun, 08 Feb 2026 22:11:11 +0100 (CET)
Date: Sun, 8 Feb 2026 22:11:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 18/18] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <20260204164606.3425246-19-chad@jablonski.xyz>
Message-ID: <59be57d3-df89-e534-ff17-d176b109deb2@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-19-chad@jablonski.xyz>
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
> Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
> text rendering in X. Currently supports only the monochrome
> foreground/background datatype.
>
> The flush is broken up into two steps. First, expansion of the
> monochrome bits to the destination color depth. Then the expanded pixels
> are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
> clips and performs the blit.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      |  4 +--
> hw/display/ati_2d.c   | 84 +++++++++++++++++++++++++++++++++++++++++++
> hw/display/ati_int.h  |  3 ++
> hw/display/ati_regs.h |  4 +++
> 4 files changed, 93 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index fd717044b0..514935e510 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1045,13 +1045,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case HOST_DATA7:
>         s->host_data.acc[s->host_data.next++] = data;
>         if (s->host_data.next >= 4) {
> -            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +            ati_flush_host_data(s);
>             s->host_data.next = 0;
>         }
>         break;
>     case HOST_DATA_LAST:
>         s->host_data.acc[s->host_data.next] = data;
> -        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +        ati_flush_host_data(s);
>         ati_host_data_reset(&s->host_data);
>         break;
>     default:
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 53f00e07ec..fc18ed4384 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -282,6 +282,11 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
> void ati_2d_blt(ATIVGAState *s)
> {
>     ATI2DCtx ctx;
> +    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
> +    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
> +        /* HOST_DATA sources are handled by ati_flush_host_data() */
> +        return;
> +    }
>     setup_2d_blt_ctx(s, &ctx);
>     if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
>         || ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x
> @@ -292,3 +297,82 @@ void ati_2d_blt(ATIVGAState *s)
>     ati_2d_do_blt(&ctx, s->use_pixman);
>     ati_set_dirty(&s->vga, &ctx);
> }
> +
> +void ati_flush_host_data(ATIVGAState *s)
> +{
> +    ATI2DCtx ctx, chunk;
> +    uint32_t fg = s->regs.dp_src_frgd_clr;
> +    uint32_t bg = s->regs.dp_src_bkgd_clr;
> +    unsigned bypp, row, col, idx;
> +    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
> +    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
> +    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
> +    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
> +
> +    if (src_source != DP_SRC_HOST) {
> +        qemu_log_mask(LOG_UNIMP, "host_data_blt: only DP_SRC_HOST supported\n");
> +        return;
> +    }

Instead of logging what's supported it's more useful to log the value 
that's unsupported, e.g. "unsupported src_source %x" because that's what 
we want to look at if we see this message not what works that we don't 
care about any more now that it's implemented.

> +    if (src_datatype != SRC_MONO_FRGD_BKGD) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "host_data_blt: only SRC_MONO_FRGD_BKGD supported\n");
> +        return;
> +    }
> +
> +    setup_2d_blt_ctx(s, &ctx);
> +
> +    if (!ctx.left_to_right || !ctx.top_to_bottom) {
> +        qemu_log_mask(LOG_UNIMP, "host_data_blt: only L->R, T->B supported\n");
> +        return;
> +    }
> +
> +    bypp = ctx.bpp / 8;
> +
> +    /* Expand monochrome bits to color pixels */
> +    idx = 0;
> +    for (int word = 0; word < 4; word++) {
> +        for (int byte = 0; byte < 4; byte++) {
> +            uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
> +            for (int i = 0; i < 8; i++) {
> +                int bit = byte_pix_order ? i : (7 - i);
> +                bool is_fg = extract8(byte_val, bit, 1);

I don't like extract/deposit functions especially in code that should be 
fast because they have a useless assert adding overhead. This is just a 
single bit mask shifted at each step so can you just write it as that e.g.
byte & BIT(byte_pix_order ? i : 7 - i) or even two separate loops 
depending on byte_pix_order to avoid having the if within loop one doing 
mask=1 then mask <<= 1 in each step and the other mask=7 and mask >>= 1

> +                uint32_t color = is_fg ? fg : bg;

(although we already have this condition here so separate loops may not 
save much).

> +                stn_he_p(&pix_buf[idx * bypp], bypp, color);
> +                idx += 1;
> +            }
> +        }
> +    }

Supporting other src_datatypes is easy. SRC_COLOR is just writing the 
value unchanged to the frame buffer and for SRC_MONO_FRGD we could do the 
same as SRC_MONO_FRGD_BKGD (we do that in hw/display/sm501.c::803) and 
with that MorphOS is actually usable and better than missing text. For 
that this color extraction could be moved to separate function and called 
from here if needed.

If you don't want to fix these here I can send patches on top later as 
this at least works for Xorg.

Please cc the next version to maintainers (Gerd Hoffmann 
<kraxel@redhat.com> and marcandre.lureau@redhat.com) too as they are the 
ones who can merge this.

Regards,
BALATON Zoltan

> +
> +    /* Copy and then modify blit ctx for use in a chunked blit */
> +    chunk = ctx;
> +    chunk.src_bits = pix_buf;
> +    chunk.src.y = 0;
> +    chunk.src_stride = ATI_HOST_DATA_ACC_BITS * bypp;
> +
> +    /* Blit one scanline chunk at a time */
> +    row = s->host_data.row;
> +    col = s->host_data.col;
> +    idx = 0;
> +    while (idx < ATI_HOST_DATA_ACC_BITS && row < ctx.dst.height) {
> +        unsigned pix_in_scanline = MIN(ATI_HOST_DATA_ACC_BITS - idx,
> +                                       ctx.dst.width - col);
> +        chunk.src.x = idx;
> +        /* Build a rect for this scanline chunk */
> +        chunk.dst.x = ctx.dst.x + col;
> +        chunk.dst.y = ctx.dst.y + row;
> +        chunk.dst.width = pix_in_scanline;
> +        chunk.dst.height = 1;
> +        ati_2d_do_blt(&chunk, s->use_pixman);
> +        ati_set_dirty(&s->vga, &chunk);
> +        idx += pix_in_scanline;
> +        col += pix_in_scanline;
> +        if (col >= ctx.dst.width) {
> +            col = 0;
> +            row += 1;
> +        }
> +    }
> +
> +    /* Track state of the overall blit for use by the next flush */
> +    s->host_data.row = row;
> +    s->host_data.col = col;
> +}
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index ef474e366e..32d1e628d3 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -33,6 +33,8 @@
> #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
> #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
>
> +#define ATI_HOST_DATA_ACC_BITS 128
> +
> #define TYPE_ATI_VGA "ati-vga"
> OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
>
> @@ -125,5 +127,6 @@ struct ATIVGAState {
> const char *ati_reg_name(int num);
>
> void ati_2d_blt(ATIVGAState *s);
> +void ati_flush_host_data(ATIVGAState *s);
>
> #endif /* ATI_INT_H */
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 48f15e9b1d..9d08d3e956 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -397,7 +397,11 @@
> #define DST_32BPP                               0x00000006
> #define DP_DST_DATATYPE                         0x0000000f
> #define DP_BRUSH_DATATYPE                       0x00000f00
> +#define SRC_MONO_FRGD_BKGD                      0x00000000
> +#define SRC_MONO_FRGD                           0x00010000
> +#define SRC_COLOR                               0x00020000
> #define DP_SRC_DATATYPE                         0x00030000
> +#define DP_BYTE_PIX_ORDER                       0x40000000
>
> #define BRUSH_SOLIDCOLOR                        0x00000d00
>
>

