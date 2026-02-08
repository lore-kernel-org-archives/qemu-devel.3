Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E088EF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAka-0006Iq-6O; Sun, 08 Feb 2026 14:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpAkY-0006IS-Le
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:47:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpAkX-0006AD-1M
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:47:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4F715969F1;
 Sun, 08 Feb 2026 20:47:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 8_Tqxxy2Th_C; Sun,  8 Feb 2026 20:47:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8C655969F6; Sun, 08 Feb 2026 20:47:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E76985969F3;
 Sun, 08 Feb 2026 20:47:13 +0100 (CET)
Date: Sun, 8 Feb 2026 20:47:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 09/18] ati-vga: Remove src and dst stride mutation in
 ati_2d_blt
In-Reply-To: <20260204164606.3425246-10-chad@jablonski.xyz>
Message-ID: <f8f49186-f455-720f-c254-779b6cdfdbce@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-10-chad@jablonski.xyz>
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
> Pixman requires stride in words. So over the course of the ati_2d_blt
> function both src and dst stride were mutated before being passed to
> pixman and then back afterwards.
>
> This creates local variables holding src and dst stride in words
> avoiding the potentially confusing mutation.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 35 +++++++++++++++--------------------
> 1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 980cdd6ac0..e8b9bf5f70 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -85,6 +85,7 @@ void ati_2d_blt(ATIVGAState *s)
>         dst_bits += s->regs.crtc_offset & 0x07ffffff;
>         dst_stride *= bpp;
>     }
> +    int dst_stride_words = dst_stride / sizeof(uint32_t);
>     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
>     if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
>         || dst_bits + dst_x
> @@ -118,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
>             src_bits += s->regs.crtc_offset & 0x07ffffff;
>             src_stride *= bpp;
>         }
> +        int src_stride_words = src_stride / sizeof(uint32_t);
>         if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
>             || src_bits + src_x
>              + (src_y + s->regs.dst_height) * src_stride >= end) {
> @@ -125,18 +127,16 @@ void ati_2d_blt(ATIVGAState *s)
>             return;
>         }
>
> -        src_stride /= sizeof(uint32_t);
> -        dst_stride /= sizeof(uint32_t);
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
> -                src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> -                src_x, src_y, dst_x, dst_y,
> +                src_bits, dst_bits, src_stride_words, dst_stride_words,
> +                bpp, bpp, src_x, src_y, dst_x, dst_y,
>                 s->regs.dst_width, s->regs.dst_height);
> #ifdef CONFIG_PIXMAN
>         if ((s->use_pixman & BIT(1)) &&
>             s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
>             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
>             fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
> -                                   src_stride, dst_stride, bpp, bpp,
> +                                   src_stride_words, dst_stride_words, bpp, bpp,
>                                    src_x, src_y, dst_x, dst_y,
>                                    s->regs.dst_width, s->regs.dst_height);
>         } else if (s->use_pixman & BIT(1)) {
> @@ -146,12 +146,12 @@ void ati_2d_blt(ATIVGAState *s)
>             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
>                                      s->regs.dst_height);
>             fallback = !pixman_blt((uint32_t *)src_bits, tmp,
> -                                   src_stride, tmp_stride, bpp, bpp,
> +                                   src_stride_words, tmp_stride, bpp, bpp,
>                                    src_x, src_y, 0, 0,
>                                    s->regs.dst_width, s->regs.dst_height);
>             if (!fallback) {
>                 fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
> -                                       tmp_stride, dst_stride, bpp, bpp,
> +                                       tmp_stride, dst_stride_words, bpp, bpp,

Maybe we should also rename tmp_stride to tmp_stride_words for consistency 
but regardless:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

