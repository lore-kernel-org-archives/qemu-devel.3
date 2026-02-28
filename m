Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2028CFEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 16:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwNbx-0002IL-0Z; Sat, 28 Feb 2026 11:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwNbv-0002HI-KH
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 11:56:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwNbs-0006Ly-89
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 11:56:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 79A915969FC;
 Sat, 28 Feb 2026 17:56:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HnfirlW65GCT; Sat, 28 Feb 2026 17:56:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 496E15969F6; Sat, 28 Feb 2026 17:56:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47DF95969F2;
 Sat, 28 Feb 2026 17:56:01 +0100 (CET)
Date: Sat, 28 Feb 2026 17:56:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 13/18] ati-vga: Split ati_2d_do_blt from ati_2d_blt
In-Reply-To: <20260227203944.746471-14-chad@jablonski.xyz>
Message-ID: <e345b72c-20db-f1b5-3b98-bff462c96b40@eik.bme.hu>
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-14-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> ati_2d_blt remains the public interface to the blitter but the bulk of
> the implementation is moved down into ati_2d_do_blt which is passed an
> ATI2DCtx.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/display/ati_2d.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index ebcec07334..a93a267465 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -123,15 +123,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>             (ctx->top_to_bottom ? 'v' : '^'));
> }
>
> -void ati_2d_blt(ATIVGAState *s)
> +static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
>     bool use_pixman_fill = s->use_pixman & BIT(0);
>     bool use_pixman_blt = s->use_pixman & BIT(1);
> -    ATI2DCtx ctx_;
> -    ATI2DCtx *ctx = &ctx_;
> -    setup_2d_blt_ctx(s, ctx);
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
> @@ -264,8 +261,13 @@ void ati_2d_blt(ATIVGAState *s)
>     default:
>         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
>                       ctx->rop3 >> 16);
> -        return;
>     }
> +}
>
> -    ati_set_dirty(&s->vga, ctx);
> +void ati_2d_blt(ATIVGAState *s)
> +{
> +    ATI2DCtx ctx;
> +    setup_2d_blt_ctx(s, &ctx);
> +    ati_2d_do_blt(s, &ctx);
> +    ati_set_dirty(&s->vga, &ctx);
> }

I've noticed that if ati_2d_do_blt returns early due to failing a check 
(e.g. blt outside vram is not implemented that I see with MorphOS TVPaint 
after clicking on OK in the initial requester that changes resolution; I 
did not investigate why this happens but it seems to still use old 
resolution for some values for some reason) after this patch it will still 
call ati_set_dirty unnecessarily. So either the set dirty may need to stay 
in do_blt or ati_2d_do_blt should return a bool to say if it changed the 
frame buffer so the caller should call set_dirty.

Regards,
BALATON Zoltan

