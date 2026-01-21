Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA4CD262AF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 01:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viMoO-0002WG-0I; Tue, 20 Jan 2026 20:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viMo2-0002QN-SD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:14:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1viMnz-0006sR-DE
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 20:14:46 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF80B596ABF;
 Wed, 21 Jan 2026 02:14:40 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wVXNa3RLTC8g; Wed, 21 Jan 2026 02:14:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EFE92596ABD; Wed, 21 Jan 2026 02:14:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EE69F5969E4;
 Wed, 21 Jan 2026 02:14:38 +0100 (CET)
Date: Wed, 21 Jan 2026 02:14:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 10/12] ati-vga: Implement scissor rectangle clipping
 for 2D operations
In-Reply-To: <20260116024258.1487173-11-chad@jablonski.xyz>
Message-ID: <9fd1e0dd-a8e1-6548-d62b-cac163e621ce@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-11-chad@jablonski.xyz>
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

On Thu, 15 Jan 2026, Chad Jablonski wrote:
> Use scissor registers to clip blit operations. This is required
> for text rendering in X using the r128 driver. Without it overly-wide
> glyphs are drawn and create all sorts of chaos.
>
> The visible destination rectangle (vis_dst) is the intersection of the
> scissor rectangle and the destination rectangle (dst.rect).
>
> The src also needs to be offset if clipped on the top and/or
> left sides to ensure that src data is read correctly and appears
> clipped when drawn rather than shifted.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 81 ++++++++++++++++++++++++++++-----------------
> 1 file changed, 50 insertions(+), 31 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 691e0f0702..a5dc5ba98e 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -86,7 +86,8 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
>     /* rewritten but for now as a start just to get some output: */
>     DisplaySurface *ds = qemu_console_surface(s->vga.con);
>     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> -    int dst_stride_words, src_stride_words;
> +    int dst_stride_words, src_stride_words, vis_src_x, vis_src_y;
> +    QemuRect scissor, vis_dst;
>
>     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
>             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
> @@ -108,14 +109,32 @@ static void ati_2d_do_blt(ATIVGAState *s, const ATIBltSrc *src, ATIBltDst *dst)
>         return;
>     }
>
> +    qemu_rect_init(&scissor,
> +                   s->regs.sc_left, s->regs.sc_top,
> +                   s->regs.sc_right - s->regs.sc_left + 1,
> +                   s->regs.sc_bottom - s->regs.sc_top + 1);
> +    qemu_rect_intersect(&dst->rect, &scissor, &vis_dst);

Is there a bit somewhere that enables clipping that needs to be checked 
here? Or are the sc regs always expected to have meaningful values and 
clipping is always done?

> +    if (!vis_dst.height || !vis_dst.width) {
> +        /* Nothing to do, completely clipped */

It's less clear what vis means so maybe this comment could clarify by 
saying Nothing is visible, completely clipped.

Regards,
BALATON Zoltan

