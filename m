Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29349EF06E7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 20:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpBSo-0002tw-5P; Sun, 08 Feb 2026 15:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBST-0002Tp-KW
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:32:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBSR-0001S3-PH
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:32:41 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8CB4A5969F6;
 Sun, 08 Feb 2026 21:32:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ludxHiTychVe; Sun,  8 Feb 2026 21:32:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8C7EC5969F3; Sun, 08 Feb 2026 21:32:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AF215969F2;
 Sun, 08 Feb 2026 21:32:36 +0100 (CET)
Date: Sun, 8 Feb 2026 21:32:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 15/18] ati-vga: Move source bounds validation to
 ati_2d_blt
In-Reply-To: <20260204164606.3425246-16-chad@jablonski.xyz>
Message-ID: <358c1758-be3e-31ba-58ef-98f2049ddd6e@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-16-chad@jablonski.xyz>
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

On Wed, 4 Feb 2026, Chad Jablonski wrote:
> A call to ati_2d_blt implies that the source will be vram. Checking
> bounds is useful in that case. Other sources (HOST_DATA) will not make
> sense to check against vram bounds.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 13 ++++++-------
> 1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 8a820bc91f..463da001d9 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
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
> @@ -267,6 +260,12 @@ void ati_2d_blt(ATIVGAState *s)
> {
>     ATI2DCtx ctx;
>     setup_2d_blt_ctx(s, &ctx);
> +    if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
> +        || ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x
> +         + (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end) {

Maybe a good opportunity to move || and + from beginning of line to 
previous line as it is more usually wrapped elsewhere. But anyway:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> +        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +        return;
> +    }
>     ati_2d_do_blt(&ctx, s->use_pixman);
>     ati_set_dirty(&s->vga, &ctx);
> }
>

