Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50847FEE4ED
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 17:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwNix-0005Ed-95; Sat, 28 Feb 2026 12:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwNiv-0005EK-3D
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:03:25 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwNis-0007Qq-NJ
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:03:24 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB6745969F6;
 Sat, 28 Feb 2026 18:03:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OYz6f0gPrITz; Sat, 28 Feb 2026 18:03:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AFA955969F2; Sat, 28 Feb 2026 18:03:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AE25F5969E4;
 Sat, 28 Feb 2026 18:03:16 +0100 (CET)
Date: Sat, 28 Feb 2026 18:03:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 15/18] ati-vga: Move source bounds validation to
 ati_2d_blt
In-Reply-To: <20260227203944.746471-16-chad@jablonski.xyz>
Message-ID: <cc1f1a0c-56cc-991c-7d2f-856cf0ff7895@eik.bme.hu>
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-16-chad@jablonski.xyz>
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

On Fri, 27 Feb 2026, Chad Jablonski wrote:
> A call to ati_2d_blt implies that the source will be vram. Checking
> bounds is useful in that case. Other sources (HOST_DATA) will not make
> sense to check against vram bounds.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> ---
>
> Changes from v8:
>
> The source bound validation was being performed in all cases, even for
> blits that weren't using the source. It now limits the validation to the
> ROP3_SRCCOPY case.
> ---
> hw/display/ati_2d.c | 19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 440c1d159a..dbc8791824 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -138,9 +138,9 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>         return;
>     }
>     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
> -    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
> -        || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
> -         + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
> +    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
> +        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
> +        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
> @@ -153,13 +153,6 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>             return;
>         }
>         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
> -        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
> -            || ctx->src_bits >= ctx->vram_end
> -            || ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height)
> -             * ctx->src_stride >= ctx->vram_end) {
> -            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> -            return;
> -        }
>
>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
>                 ctx->src_bits, ctx->dst_bits, src_stride_words,
> @@ -268,6 +261,12 @@ void ati_2d_blt(ATIVGAState *s)
> {
>     ATI2DCtx ctx;
>     setup_2d_blt_ctx(s, &ctx);
> +    if (ctx.rop3 == ROP3_SRCCOPY && (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff ||
> +        ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x +
> +        (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end)) {
> +        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +        return;
> +    }

In second look I'm not sure about this, also because the next patch 
changes src values based on clipping so this check should be done after 
that to make sure it's still within vram. So maybe we should leave it 
where it is and if need to be disabled for host data then add a check at 
the front if (!host_data_is_active && (...)) or so to only do the check 
if source is vram.

Regards,
BALATON Zoltan

>     ati_2d_do_blt(&ctx, s->use_pixman);
>     ati_set_dirty(&s->vga, &ctx);
> }
>

