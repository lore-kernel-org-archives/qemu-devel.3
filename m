Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5118E7FDE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 00:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn4TH-0001Zn-UL; Mon, 02 Feb 2026 19:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn4TF-0001ZW-S6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:40:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn4TE-0006aS-7B
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 19:40:45 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 716E15969F6;
 Tue, 03 Feb 2026 01:40:42 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id j1jLvJ2vSWZB; Tue,  3 Feb 2026 01:40:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6BD4C5969F3; Tue, 03 Feb 2026 01:40:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6A84A5969F1;
 Tue, 03 Feb 2026 01:40:40 +0100 (CET)
Date: Tue, 3 Feb 2026 01:40:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 15/19] ati-vga: Remove ATIVGAState param from
 ati_2d_do_blt
In-Reply-To: <20260202204738.3080092-16-chad@jablonski.xyz>
Message-ID: <52289cd5-a4a3-5af3-bee1-bf2cc48ce0aa@eik.bme.hu>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
 <20260202204738.3080092-16-chad@jablonski.xyz>
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
> This completes the decoupling from the ATIVGAState struct.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 8397a4d1bb..e1e48ac81f 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -121,7 +121,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>             (ctx->top_to_bottom ? 'v' : '^'));
> }
>
> -static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
> +static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
> @@ -269,13 +269,12 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
>                       ctx->rop3 >> 16);
>         return;

This return is not needed any more

>     }
> -
> -    ati_set_dirty(&s->vga, ctx);

after moving ati_set_dirty to ati_2d_blt. This part moving ati_set_dirty 
could be squashed into patch 13 and the remaining two lines that remove 
ATIVGAState from ati_2d_do_blt can go into patch 14.

Regards,
BALATON Zoltan

> }
>
> void ati_2d_blt(ATIVGAState *s)
> {
>     ATI2DCtx ctx;
>     setup_2d_blt_ctx(s, &ctx);
> -    ati_2d_do_blt(s, &ctx, s->use_pixman);
> +    ati_2d_do_blt(&ctx, s->use_pixman);
> +    ati_set_dirty(&s->vga, &ctx);
> }
>

