Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93830CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 00:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdHeJ-000402-1O; Tue, 06 Jan 2026 19:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHeF-0003ww-UT
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:43:40 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHeD-0008Ly-Na
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:43:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6B19596A0A;
 Wed, 07 Jan 2026 01:43:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OebyvAYiX4Yy; Wed,  7 Jan 2026 01:43:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D6A225969FD; Wed, 07 Jan 2026 01:43:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D19065969F6;
 Wed, 07 Jan 2026 01:43:32 +0100 (CET)
Date: Wed, 7 Jan 2026 01:43:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <20260106185700.2102742-10-chad@jablonski.xyz>
Message-ID: <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-10-chad@jablonski.xyz>
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
> Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
> text rendering in X. Currently supports only the monochrome
> foreground/background datatype with the SRCCOPY ROP.
>
> The flush is broken up into two steps for clarity. First, expansion of the
> monochrome bits to the destination color depth. Then the expanded pixels
> are clipped and copied into VRAM.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     |   4 +-
> hw/display/ati_2d.c  | 124 +++++++++++++++++++++++++++++++++++++++++++
> hw/display/ati_int.h |   3 ++
> 3 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 88d30bf532..cc5899981b 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1064,13 +1064,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
> index 6c36e55412..19130ed291 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -117,6 +117,11 @@ static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
>
> void ati_2d_blt(ATIVGAState *s)
> {
> +    if (s->regs.dp_src_source == GMC_SRC_SOURCE_HOST_DATA) {
> +        /* HOST_DATA blits are handled separately by ati_flush_host_data() */
> +        return;
> +    }
> +

I wonder if we could reuse the existing blt function here and keep pixman 
optimisations and avoid duplicating code by filling a src buffer with the 
expanded data after we accumulated the 128 bits and we need to flush and 
then call ati_2d_blt with that as src and dst modified to match where it 
should go instead of the full blit area that the registers describe. That 
needs to split ati_2d_blt or it should take a blit state instead of 
ATIVGAState that can either be filled from regs for a regular blit or for 
a smaller part for a host data blit so that way host data is just split 
into smaller 128 bit blits which I think is how the actual GPU works as 
well. Does that make sense? Do you think that could work?

Regards,
BALATON Zoltan

