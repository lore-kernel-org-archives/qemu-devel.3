Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AC3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvAK-0001mP-Ef; Mon, 03 Nov 2025 09:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFvAH-0001m0-Tf
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:04:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFvAB-0002Vs-B9
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:04:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BA4BC5972E4;
 Mon, 03 Nov 2025 15:03:54 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fNRZmQl5LMeQ; Mon,  3 Nov 2025 15:03:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 901835972E3; Mon, 03 Nov 2025 15:03:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8EAE15972E2;
 Mon, 03 Nov 2025 15:03:52 +0100 (CET)
Date: Mon, 3 Nov 2025 15:03:52 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] ati-vga: Add expand_colors() helper for monochrome
 color expansion
In-Reply-To: <20251103033608.120908-7-chad@jablonski.xyz>
Message-ID: <8b027a95-a5d1-3bc9-07be-93fbf8f8b266@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-7-chad@jablonski.xyz>
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
> Convert 1bpp monochrome images to 32bpp ARGB given a foreground and
> background color. This also supports most significant and least
> significant bit ordering.
>
> This is useful for host data transfers of glyphs when drawing text in X.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 15cf29a061..181bf634f0 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -45,6 +45,28 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
> }
>
> #define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
> +/* Convert 1bpp monochrome data to 32bpp ARGB using color expansion */
> +static void expand_colors(uint8_t *color_dst, const uint8_t *mono_src,
> +                          uint32_t width, uint32_t height,
> +                          uint32_t fg_color, uint32_t bg_color,
> +                          bool lsb_to_msb)
> +{
> +    uint32_t byte, color;
> +    uint8_t *pixel;
> +    int i, j, bit;
> +    /* Rows are 32-bit aligned */
> +    int bytes_per_row = ((width + 31) / 32) * 4;

I think there's some QEMU_ALIGN macro for that maybe in qemu/osdep.h?

> +
> +    for (i = 0; i < height; i++) {
> +        for (j = 0; j < width; j++) {
> +            byte = mono_src[i * bytes_per_row + (j / 8)];
> +            bit = lsb_to_msb ? 7 - (j % 8) : j % 8;
> +            color = (byte >> bit) & 0x1 ? fg_color : bg_color;
> +            pixel = &color_dst[(i * width + j) * 4];
> +            memcpy(pixel, &color, sizeof(color));

Since it's just writing a 32 bit value maybe cast and = would be faster 
than calling memcpy for this.

Regards,
BALATON Zoltan

> +        }
> +    }
> +}
>
> void ati_2d_blt(ATIVGAState *s)
> {
>

