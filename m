Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB44DE7FDE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 00:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn40y-0003vZ-5s; Mon, 02 Feb 2026 19:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn40v-0003up-NP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:11:29 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn40t-0003dx-Bz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:11:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A6AD85969F3;
 Tue, 03 Feb 2026 01:11:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LM9ldPBDUd54; Tue,  3 Feb 2026 01:11:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9A7C75969F2; Tue, 03 Feb 2026 01:11:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 98F855969F1;
 Tue, 03 Feb 2026 01:11:23 +0100 (CET)
Date: Tue, 3 Feb 2026 01:11:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 09/19] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
In-Reply-To: <20260202204738.3080092-10-chad@jablonski.xyz>
Message-ID: <fe0a8ccb-d19c-2b22-daa4-7332245da4ea@eik.bme.hu>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
 <20260202204738.3080092-10-chad@jablonski.xyz>
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

On Mon, 2 Feb 2026, Chad Jablonski wrote:
> Pixman requires stride in words. So over the course of the ati_2d_blt
> function both src and dst stride were mutated before being passed to
> pixman and then back afterwards.
>
> This creates local variables holding src and dst stride in words
> avoiding the potentially confusing mutation.

Originally we had pixman only so storing it the way that needs it made 
sense. Then we realized that pixman can fail (e.g. on macOS ARM it had no 
implementation so just returned error) and later pixman was also made 
optional dependency in QEMU so fallbacks were added but I did not change 
original just added locals for the fallback. This could now be cleaned up 
as you propose.

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 43 +++++++++++++++++++++++--------------------
> 1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 5d24d11d7a..f6c65ef3cc 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -86,6 +86,7 @@ void ati_2d_blt(ATIVGAState *s)
>         dst_bits += s->regs.crtc_offset & 0x07ffffff;
>         dst_stride *= bpp;
>     }
> +    int dst_stride_words = dst_stride / sizeof(uint32_t);
>     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
>     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
>         || dst_bits + dst_x
> @@ -119,6 +120,7 @@ void ati_2d_blt(ATIVGAState *s)
>             src_bits += s->regs.crtc_offset & 0x07ffffff;
>             src_stride *= bpp;
>         }
> +        int src_stride_words = src_stride / sizeof(uint32_t);
>         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
>             || src_bits + src_x
>              + (src_y + s->regs.dst_height) * src_stride >= end) {
> @@ -126,18 +128,18 @@ void ati_2d_blt(ATIVGAState *s)
>             return;
>         }
>
> -        src_stride /= sizeof(uint32_t);
> -        dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
> -                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> -                src_x, src_y, dst_x, dst_y,
> +                src_bits, dst_bits,
> +                src_stride_words, dst_stride_words,
> +                bpp, bpp, src_x, src_y, dst_x, dst_y,
>                 s->regs.dst_width, s->regs.dst_height);
> #ifdef CONFIG_PIXMAN
>         if ((s->use_pixman & BIT(1)) &&
>             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
>             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
>             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
> -                                   src_stride, dst_stride, bpp, bpp,
> +                                   src_stride_words, dst_stride_words,
> +                                   bpp, bpp,
>                                    src_x, src_y, dst_x, dst_y,

No extra lines please, I like more lines to fit on one screen for easier 
reading without scrolling back and forth which I think is more important 
than grouping variables on one line so keep it vertically short and change 
it to

bpp, bpp, src_x, src_y, dst_x, dst_y,

now to avoid adding extra lines. Same in above DPRINTF and below in 
similar pixman_blt calls.

>                                    s->regs.dst_width, s->regs.dst_height);
>         } else if (s->use_pixman & BIT(1)) {
> @@ -147,12 +149,14 @@ void ati_2d_blt(ATIVGAState *s)
>             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
>                                      s->regs.dst_height);
>             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
> -                                   src_stride, tmp_stride, bpp, bpp,
> +                                   src_stride_words, tmp_stride,
> +                                   bpp, bpp,
>                                    src_x, src_y, 0, 0,
>                                    s->regs.dst_width, s->regs.dst_height);
>             if (!fallback) {
>                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
> -                                       tmp_stride, dst_stride, bpp, bpp,
> +                                       tmp_stride, dst_stride_words,
> +                                       bpp, bpp,
>                                        0, 0, dst_x, dst_y,
>                                        s->regs.dst_width, s->regs.dst_height);
>             }
> @@ -164,18 +168,17 @@ void ati_2d_blt(ATIVGAState *s)
>         }
>         if (fallback) {
>             unsigned int y, i, j, bypp = bpp / 8;
> -            unsigned int src_pitch = src_stride * sizeof(uint32_t);
> -            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
> -
>             for (y = 0; y < s->regs.dst_height; y++) {
>                 i = dst_x * bypp;
>                 j = src_x * bypp;
>                 if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> -                    i += (dst_y + y) * dst_pitch;
> -                    j += (src_y + y) * src_pitch;
> +                    i += (dst_y + y) * dst_stride;
> +                    j += (src_y + y) * src_stride;
>                 } else {
> -                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
> -                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
> +                    i += (dst_y + s->regs.dst_height - 1 - y)
> +                         * dst_stride;
> +                    j += (src_y + s->regs.dst_height - 1 - y)
> +                         * src_stride;

Here too as long as it fits the 80 columnt limit.

>                 }
>                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
>             }
> @@ -202,21 +205,21 @@ void ati_2d_blt(ATIVGAState *s)
>             break;
>         }
>
> -        dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> -                dst_bits, dst_stride, bpp, dst_x, dst_y,
> +                dst_bits, dst_stride_words, bpp,
> +                dst_x, dst_y,

Likewise.

>                 s->regs.dst_width, s->regs.dst_height, filler);
> #ifdef CONFIG_PIXMAN
>         if (!(s->use_pixman & BIT(0)) ||
> -            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
> -                    s->regs.dst_width, s->regs.dst_height, filler))
> +            !pixman_fill((uint32_t *)dst_bits, dst_stride_words,
> +                         bpp, dst_x, dst_y,
> +                         s->regs.dst_width, s->regs.dst_height, filler))

Written as

             !pixman_fill((uint32_t *)dst_bits, dst_stride_words, bpp, dst_x,
                          dst_y, s->regs.dst_width, s->regs.dst_height, filler))

I think would fit in 80 chars.

Regards,
BALATON Zoltan

> #endif
>         {
>             /* fallback when pixman failed or we don't want to call it */
>             unsigned int x, y, i, bypp = bpp / 8;
> -            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
>             for (y = 0; y < s->regs.dst_height; y++) {
> -                i = dst_x * bypp + (dst_y + y) * dst_pitch;
> +                i = dst_x * bypp + (dst_y + y) * dst_stride;
>                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
>                     stn_he_p(&dst_bits[i], bypp, filler);
>                 }
>

