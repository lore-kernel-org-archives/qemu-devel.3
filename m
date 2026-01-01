Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864ECEED609
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJ8w-0006Wb-5i; Thu, 01 Jan 2026 08:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJ8m-0006Vz-Ik
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 08:55:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJ8k-0008KK-JJ
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 08:55:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8D3F596A03;
 Thu, 01 Jan 2026 14:54:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xmlwuoqsdFMF; Thu,  1 Jan 2026 14:54:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9FAC85969FF; Thu, 01 Jan 2026 14:54:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E3B55969F6;
 Thu, 01 Jan 2026 14:54:51 +0100 (CET)
Date: Thu, 1 Jan 2026 14:54:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/7] ati-vga: Extract ati_reg_write() from
 ati_mm_write()
In-Reply-To: <20260101035555.1300511-2-chad@jablonski.xyz>
Message-ID: <da45694f-3c2f-ff3f-1364-1cccf1c46c05@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-2-chad@jablonski.xyz>
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

On Wed, 31 Dec 2025, Chad Jablonski wrote:
> Move register write logic into its own function. This is in preparation
> for CCE engine support for register writes. MMIO writes will have their
> own distinct policy that doesn't apply to writes made by the CCE engine.
>
> Note: Because of the recursion in the MM_DATA handler the calls to
> ati_mm_write needed to be changed to ati_reg_write. This means that
> tracing output changes slightly for MM_DATA writes. Otherwise, this
> is purely a refactor and does not change behavior.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 25 ++++++++++++++++---------
> hw/display/ati_int.h |  2 ++
> 2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e9c3ad2cd1..33f8e211dc 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -530,14 +530,9 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
>     }
> }
>
> -static void ati_mm_write(void *opaque, hwaddr addr,
> -                           uint64_t data, unsigned int size)
> +void ati_reg_write(ATIVGAState *s, hwaddr addr,
> +                   uint64_t data, unsigned int size)
> {
> -    ATIVGAState *s = opaque;
> -
> -    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
> -        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
> -    }
>     switch (addr) {
>     case MM_INDEX:
>         s->regs.mm_index = data & ~3;
> @@ -550,10 +545,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>                 stn_le_p(s->vga.vram_ptr + idx, size, data);
>             }
>         } else if (s->regs.mm_index > MM_DATA + 3) {
> -            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
> +            ati_reg_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
>         } else {
>             qemu_log_mask(LOG_GUEST_ERROR,
> -                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
> +                "ati_reg_write: mm_index too small: %u\n", s->regs.mm_index);
>         }
>         break;

Is it possible to access MM_INDEX and MM_DATA through CCE? If not maybe it 
needs to be cut here instead?

>     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
> @@ -942,6 +937,18 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     }
> }
>
> +
> +static void ati_mm_write(void *opaque, hwaddr addr,
> +                         uint64_t data, unsigned int size)
> +{
> +    ATIVGAState *s = opaque;
> +
> +    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
> +        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
> +    }
> +    ati_reg_write(s, addr, data, size);
> +}
> +
> static const MemoryRegionOps ati_mm_ops = {
>     .read = ati_mm_read,
>     .write = ati_mm_write,
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..ea1a8bceab 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -105,5 +105,7 @@ struct ATIVGAState {
> const char *ati_reg_name(int num);
>
> void ati_2d_blt(ATIVGAState *s);
> +void ati_reg_write(ATIVGAState *s, hwaddr addr,
> +                   uint64_t data, unsigned int size);

Move this up next to ati_reg_name just so they are grouped together. 
Otherwise

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

>
> #endif /* ATI_INT_H */
>

