Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3AACCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 23:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9BOj-0006Va-Fd; Wed, 15 Oct 2025 19:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9BOh-0006VK-VM
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:59:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9BOd-0004vw-2v
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D366C5972E7;
 Thu, 16 Oct 2025 01:59:03 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id CasBHt-G_2iv; Thu, 16 Oct 2025 01:59:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 913AE5972E3; Thu, 16 Oct 2025 01:59:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F12559703F;
 Thu, 16 Oct 2025 01:59:01 +0200 (CEST)
Date: Thu, 16 Oct 2025 01:59:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
In-Reply-To: <20251015173716.1764461-1-chad@jablonski.xyz>
Message-ID: <55dc6bce-c965-2202-f61c-d6bfb2d64820@eik.bme.hu>
References: <20251015173716.1764461-1-chad@jablonski.xyz>
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

On Wed, 15 Oct 2025, Chad Jablonski wrote:
> Rage 128 cards always request 64MB for their linear (framebuffer)
> aperture. This is regardless of the amount of physical VRAM on the
> board. The following are results from real hardware tests:
>
> Card                          VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
> -----------------------       ----    --------   --------------  ----------------  ---------------
> Rage 128 Pro Ultra TF         32MB     64MB       0x02000000      0x02000000        0x02000000
> Rage 128 RF/SG AGP            16MB     64MB       0x01000000      0x02000000        0x02000000
> Radeon R100 QD [Radeon 7200]  64MB    128MB       0x04000000      0x04000000        N/A
>
> Previously the linear aperture (BAR0) would match the VRAM size.
> This discrepancy caused issues with the X.org and XFree86 r128 drivers.
> These drivers apply a mask of 0xfc000000 (2^26 = 64MB) to the linear
> aperture address. If that address is not on a 64MB boundary the
> framebuffer points to an incorrect memory location.
>
> Testing shows that the Radeon R100 also has a BAR0 larger than VRAM
> (128MB in this case) and the X.org driver for Radeon also masks to 64MB.
>
> For Rage 128, CONFIG_APER_SIZE also differs from the previous value and
> the behavior stated in the documentation. The Rage 128 register guide
> states that it should contain the size of the VRAM + AGP memory. The cards
> tested above show that this isn't the case. These tests also included
> enabling/disabling AGP with 8MB of memory. It didn't change the
> contents of CONFIG_APER_SIZE.
>
> For Radeon R100, CONFIG_APER_SIZE behavior remains the same. There is
> some worry that changing it could cause issues for other cards.
> Especially given that I have only a single example here to test.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 20 ++++++++++++++++++--
> hw/display/ati_int.h |  4 ++++
> 2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a87..7af12777c8 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -30,6 +30,7 @@
> #include "ui/console.h"
> #include "hw/display/i2c-ddc.h"
> #include "trace.h"
> +#include "qemu/units.h"

Just some nits. This include now also belongs to ati_int.h where it's 
used.

> #define ATI_DEBUG_HW_CURSOR 0
>
> @@ -361,7 +362,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
>         break;
>     case CONFIG_APER_SIZE:
> -        val = s->vga.vram_size / 2;
> +        val = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +            ATI_RAGE128_LINEAR_APER_SIZE / 2 : s->vga.vram_size / 2;

Should indent below s-> like at other places.

>         break;
>     case CONFIG_REG_1_BASE:
>         val = pci_default_read_config(&s->dev,
> @@ -952,6 +954,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
> {
>     ATIVGAState *s = ATI_VGA(dev);
>     VGACommonState *vga = &s->vga;
> +    uint64_t aper_size;
>
> #ifndef CONFIG_PIXMAN
>     if (s->use_pixman != 0) {
> @@ -1011,7 +1014,20 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     /* io space is alias to beginning of mmregs */
>     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
>
> -    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
> +    /*
> +     * Rage128: Framebuffer inhabits the bottom 32MB of the linear aperture.
> +     *          The top 32MB is reserved for AGP (not implemented).
> +     *
> +     * R100: Linear aperture layout differs from Rage 128. No
> +     *       AGP_APER_OFFSET register exists.
> +     */

We don't use AGP_APER_OFFSET here so this comment isn't that clean. The 
layout does not differ in that VRAM is still at the beginning but only in 
that Radeon has no AGP window.

> +    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +        ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;

Indent.

Regards,
BALATON Zoltan

> +    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
> +                       aper_size);
> +    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
>     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
>     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
>
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..4f66d0df3f 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -29,6 +29,9 @@
> /* Radeon RV100 (VE) */
> #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
>
> +#define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
> +#define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
> +
> #define TYPE_ATI_VGA "ati-vga"
> OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
>
> @@ -97,6 +100,7 @@ struct ATIVGAState {
>     QEMUCursor *cursor;
>     QEMUTimer vblank_timer;
>     bitbang_i2c_interface bbi2c;
> +    MemoryRegion linear_aper;
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
>

