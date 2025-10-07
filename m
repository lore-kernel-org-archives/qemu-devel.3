Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB20CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EgF-0008TJ-7y; Tue, 07 Oct 2025 16:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6EgC-0008R6-OO
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:53:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v6Eg9-0003pl-39
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:53:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 378BC56F2A3;
 Tue, 07 Oct 2025 22:52:58 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 34cFsxGMkeQv; Tue,  7 Oct 2025 22:52:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 249D356F29E; Tue, 07 Oct 2025 22:52:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22AB156F2CA;
 Tue, 07 Oct 2025 22:52:56 +0200 (CEST)
Date: Tue, 7 Oct 2025 22:52:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
In-Reply-To: <20251001034616.3017119-1-chad@jablonski.xyz>
Message-ID: <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
References: <20251001034616.3017119-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Hello,

Thanks for the contribution.

On Tue, 30 Sep 2025, Chad Jablonski wrote:
> Real Rage 128 cards always request 64MB for their linear (framebuffer)
> aperture. This is regardless of the amount of physical VRAM on the
> board. This is required for 64MB alignment which is important given the
> 26-bit addressing in src and dst registers.
>
> This discrepancy caused X to segfault or display garbage depending on
> the version tested. X expects this 64MB alignment.

The documentation does not mention 64MB alignment. It says apertures must 
be on a 32MB boundary and src and dst offsets are 128 bit aligned but 
maybe I don't have the right documentation for these chips or don't get 
what it means.

> This was confirmed by testing against the behavior of real 16MB and 32MB
> Rage 128 cards.
>
> Real Radeon R100 cards request 128MB for linear aperture. This was
> tested against a Radeon 7200 with 64MB of VRAM.

Can you check what the CONFIG_APER_SIZE register contains on these cards? 
Do all Rage 128 (and Pro) cards have 64MB and Radeon 7xxx/M6 have 128MB? 
The documentation is again not clear on this because it lists default 
value of 0x2000000 for CONFIG_APER_SIZE on Rage 128 Pro and nothing for 
Radeon but in a figure it shows this should contain both VRAM and AGP 
areas that suggests 64MB but it's possible that the documentation is 
wrong.

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 26 ++++++++++++++++++++++++--
> hw/display/ati_int.h |  1 +
> 2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a87..db189e0767 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -30,9 +30,13 @@
> #include "ui/console.h"
> #include "hw/display/i2c-ddc.h"
> #include "trace.h"
> +#include "qemu/units.h"
>
> #define ATI_DEBUG_HW_CURSOR 0
>
> +#define ATI_RAGE128_LINEAR_APERTURE_SIZE (64 * MiB)
> +#define ATI_RADEON_LINEAR_APERTURE_SIZE (128 * MiB)

Maybe these should go in ati_int.h and may try to make it shorter like 
ATI_*_LINEAR_APER_SIZE.

> +
> #ifdef CONFIG_PIXMAN
> #define DEFAULT_X_PIXMAN 3
> #else
> @@ -361,7 +365,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
>         break;
>     case CONFIG_APER_SIZE:
> -        val = s->vga.vram_size / 2;
> +        val = memory_region_size(&s->linear_aper);

This was changed in commit f7ecde051dd73 to be half the memory size 
because at least a Radeon FCocde ROM seemed to detect VRAM size that way. 
I should test that again but it needed OpenBIOS patches that were not 
merged so I had to find those again as I don't have that setup any more. 
Checking on real card may be the best source of what this should be but I 
think this might break that FCode ROM which is from a PowerMac card. This 
suggests it should be half the aper size.

>         break;
>     case CONFIG_REG_1_BASE:
>         val = pci_default_read_config(&s->dev,
> @@ -1011,7 +1015,25 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     /* io space is alias to beginning of mmregs */
>     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
>
> -    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
> +    uint64_t aperture_size;

Coding style says variables should be defined at the beginning of blocks 
so in this case at the beginning of the funcion.

> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {

I usually check for Rage128Pro against everything else (in case more 
Radeon models will be added in the future, but I broke that in a few 
places). So you could write this as

aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RADEON_PF ?
             ATI_RAGE128_LINEAR_APER_SIZE : ATI_RADEON_LINEAR_APER_SIZE;

> +        aperture_size = ATI_RADEON_LINEAR_APERTURE_SIZE;
> +    } else {
> +        aperture_size = ATI_RAGE128_LINEAR_APERTURE_SIZE;
> +    }
> +    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
> +                       aperture_size);
> +

No new line needed here, it's still setting up BAR0 so should be in one 
block.

Regards,
BALATON Zoltan

> +    /*
> +     * Rage 128: Framebuffer inhabits the bottom 32MB of the linear aperture.
> +     *           The top 32MB is reserved for AGP (not implemented).
> +     *
> +     * Radeon: The entire linear aperture is used for VRAM.
> +     *         AGP is mapped separately.
> +     */
> +    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
>     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
>     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
>
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..ff2a69a0a5 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -97,6 +97,7 @@ struct ATIVGAState {
>     QEMUCursor *cursor;
>     QEMUTimer vblank_timer;
>     bitbang_i2c_interface bbi2c;
> +    MemoryRegion linear_aper;
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
>

