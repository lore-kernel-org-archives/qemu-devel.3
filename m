Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB4BEEE25C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 21:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbQDT-0003jE-2c; Thu, 01 Jan 2026 16:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQDQ-0003iz-W7
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 16:28:17 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQDN-0007A9-Ev
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 16:28:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 203BF5969FF;
 Thu, 01 Jan 2026 22:28:10 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id tfrOddjlIjyZ; Thu,  1 Jan 2026 22:28:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26DD85969FA; Thu, 01 Jan 2026 22:28:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2532E5969F6;
 Thu, 01 Jan 2026 22:28:08 +0100 (CET)
Date: Thu, 1 Jan 2026 22:28:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/11] ati-vga: Fix DST_PITCH and SRC_PITCH reads
In-Reply-To: <20251118154812.57861-2-chad@jablonski.xyz>
Message-ID: <a9e63ff7-3fe4-f7a7-566f-b1cfbe3476dd@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-2-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Reading DST_PITCH and SRC_PITCH on the Rage 128 is broken. The read
> handlers attempt to construct the value from pitch and tile bits in
> the register state but mistakenly AND them instead of ORing them. This
> means the pitch is always zero on read.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 0b4298d078..66fad6459a 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -438,7 +438,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case DST_PITCH:
>         val = s->regs.dst_pitch;
>         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -            val &= s->regs.dst_tile << 16;
> +            val |= s->regs.dst_tile << 16;
>         }
>         break;
>     case DST_WIDTH:
> @@ -468,7 +468,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case SRC_PITCH:
>         val = s->regs.src_pitch;
>         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -            val &= s->regs.src_tile << 16;
> +            val |= s->regs.src_tile << 16;
>         }
>         break;
>     case DP_BRUSH_BKGD_CLR:
>

