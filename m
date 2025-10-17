Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06104CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9m5H-0004y5-9A; Fri, 17 Oct 2025 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9m5D-0004xj-RT
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:09:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9m5A-0005bU-5I
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:09:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0EF85972EB;
 Fri, 17 Oct 2025 17:09:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id QyKr-9-unNkD; Fri, 17 Oct 2025 17:09:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CDDD55972E9; Fri, 17 Oct 2025 17:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBF4D5972EF;
 Fri, 17 Oct 2025 17:09:19 +0200 (CEST)
Date: Fri, 17 Oct 2025 17:09:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v3 1/1] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
In-Reply-To: <20251017145012.1948363-2-chad@jablonski.xyz>
Message-ID: <29d6945e-4e55-4ded-a1a5-33e614a3145f@eik.bme.hu>
References: <20251017145012.1948363-1-chad@jablonski.xyz>
 <20251017145012.1948363-2-chad@jablonski.xyz>
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

On Fri, 17 Oct 2025, Chad Jablonski wrote:
> Rage 128 cards always request 64MB for their linear (framebuffer)
> aperture and R100 cards always request 128MB. This is regardless
> of the amount of physical VRAM on the board. The following are results
> from real hardware tests:
>
> Card                              VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
> -----------------------           ----    --------   --------------  ----------------  ---------------
> Rage 128 Pro Ultra TF             32MB     64MB       0x02000000      0x02000000        0x02000000
> Rage 128 RF/SG AGP                16MB     64MB       0x01000000      0x02000000        0x02000000
> Radeon R100 QD [Radeon 7200]      64MB    128MB       0x04000000      0x04000000        N/A
> Radeon RV100 QY [Radeon 7000/VE]  32MB    128MB       0x02000000      0x04000000        N/A
>
> Previously the linear aperture (BAR0) would match the VRAM size.
> This discrepancy caused issues with the X.org and XFree86 r128 drivers.
> These drivers apply a mask of 0xfc000000 (2^26 = 64MB) to the linear
> aperture address. If that address is not on a 64MB boundary the
> framebuffer points to an incorrect memory location.
>
> Testing shows that the Radeon R100 also has a BAR0 larger than VRAM
> (128MB in this case) and the X.org radeon driver also masks to 64MB.
>
> For Rage 128, CONFIG_APER_SIZE also differs from the previous value and
> the behavior stated in the documentation. The Rage 128 register guide
> states that it should contain the size of the VRAM + AGP memory. The cards
> tested above show that this isn't the case. These tests also included
> enabling/disabling AGP with 8MB of memory. It didn't change the
> contents of CONFIG_APER_SIZE.
>
> For both Rage 128 and R100 the CONFIG_APER_SIZE is half of the PCI BAR0 size.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 17 +++++++++++++++--
> hw/display/ati_int.h |  5 +++++
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a87..54a067c243 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -361,7 +361,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
>         break;
>     case CONFIG_APER_SIZE:
> -        val = s->vga.vram_size / 2;
> +        val = (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +               ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE) / 2;

So can't we just use here memory_region_size(&s->linear_aper) / 2 like for 
CONFIG_REG_APER_SIZE? With that

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thank you for testing and finding out all this.

Regards,
BALATON Zoltan

>         break;
>     case CONFIG_REG_1_BASE:
>         val = pci_default_read_config(&s->dev,
> @@ -952,6 +953,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
> {
>     ATIVGAState *s = ATI_VGA(dev);
>     VGACommonState *vga = &s->vga;
> +    uint64_t aper_size;
>
> #ifndef CONFIG_PIXMAN
>     if (s->use_pixman != 0) {
> @@ -1011,7 +1013,18 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     /* io space is alias to beginning of mmregs */
>     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
>
> -    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
> +    /*
> +     * The framebuffer is at the beginning of the linear aperture. For
> +     * Rage128 the upper half of the aperture is reserved for an AGP
> +     * window (which we do not emulate.)
> +     */
> +    aper_size = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +                ATI_RAGE128_LINEAR_APER_SIZE : ATI_R100_LINEAR_APER_SIZE;
> +    memory_region_init(&s->linear_aper, OBJECT(dev), "ati-linear-aperture0",
> +                       aper_size);
> +    memory_region_add_subregion(&s->linear_aper, 0, &vga->vram);
> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->linear_aper);
>     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
>     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
>
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..708cc1dd3a 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -10,6 +10,7 @@
> #define ATI_INT_H
>
> #include "qemu/timer.h"
> +#include "qemu/units.h"
> #include "hw/pci/pci_device.h"
> #include "hw/i2c/bitbang_i2c.h"
> #include "vga_int.h"
> @@ -29,6 +30,9 @@
> /* Radeon RV100 (VE) */
> #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
>
> +#define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
> +#define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
> +
> #define TYPE_ATI_VGA "ati-vga"
> OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
>
> @@ -97,6 +101,7 @@ struct ATIVGAState {
>     QEMUCursor *cursor;
>     QEMUTimer vblank_timer;
>     bitbang_i2c_interface bbi2c;
> +    MemoryRegion linear_aper;
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
>

