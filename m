Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA3606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 11:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1Nn-0004Bv-1g; Sun, 08 Nov 2026 06:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ1Nj-0004Bb-Vf
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:48:19 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ1Ng-0007j4-S1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 06:48:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4B3160C2B6;
 Sun, 08 Nov 2026 12:48:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id P9cnrJZVou2h; Sun,  8 Nov 2026 12:48:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BEA2E60C0F3; Sun, 08 Nov 2026 12:48:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD47D13991F;
 Sun, 08 Nov 2026 12:48:12 +0100 (CET)
Date: Sun, 8 Nov 2026 12:48:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/9] ati-vga: r100 scissor dimensions are exclusive
In-Reply-To: <20260719161536.774061-2-chad@jablonski.xyz>
Message-ID: <1e2c5195-f961-9b81-3380-966d293f068c@eik.bme.hu>
References: <20260719161536.774061-1-chad@jablonski.xyz>
 <20260719161536.774061-2-chad@jablonski.xyz>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 19 Jul 2026, Chad Jablonski wrote:
> The sc_right and sc_bottom registers are inclusive for the r128 but
> exclusive for the r100.
>
> Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
> Radeon QY (RV100) (PCI 1002:5159).
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 7a4a115aee..3b27917bf4 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -106,8 +106,14 @@ static void setup_2d_blt_ctx(ATIVGAState *s, ATI2DCtx *ctx)
>     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
>     ctx->dst_offset = s->regs.dst_offset;
>
> -    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
> -    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        /* r128 scissor values are inclusive */
> +        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
> +        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
> +    } else {
> +        ctx->scissor.width = s->regs.sc_right - s->regs.sc_left;
> +        ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top;
> +    }

It would be a bit shorter to do the common part unconditionally then fix 
up the r128pro case like done elsewhere (i.e. just move the else branch 
before the if and change the if to add 1).

Regards,
BALATON Zoltan

>     ctx->scissor.x = s->regs.sc_left;
>     ctx->scissor.y = s->regs.sc_top;
>
>

