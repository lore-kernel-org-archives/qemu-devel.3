Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C3D79769
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm81Q-000301-B4; Sat, 31 Jan 2026 05:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm81I-0002zh-Fa
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:16:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm81F-0000Ou-8b
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:15:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D3F1C596A3F;
 Sat, 31 Jan 2026 11:15:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lojhhyzPnuQx; Sat, 31 Jan 2026 11:15:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 41BA55969FD; Sat, 31 Jan 2026 11:15:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 400F75969F2;
 Sat, 31 Jan 2026 11:15:47 +0100 (CET)
Date: Sat, 31 Jan 2026 11:15:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 01/20] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
In-Reply-To: <20260130145005.731129-2-chad@jablonski.xyz>
Message-ID: <aba150f3-4c27-72a9-ff42-25231a186502@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-2-chad@jablonski.xyz>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Jan 2026, Chad Jablonski wrote:
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
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/display/ati.c     | 16 ++++++++++++++--
> hw/display/ati_int.h |  5 +++++
> 2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e9c3ad2cd1..8438a77de0 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -361,7 +361,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
>         break;
>     case CONFIG_APER_SIZE:
> -        val = s->vga.vram_size / 2;
> +        val = memory_region_size(&s->linear_aper) / 2;
>         break;
>     case CONFIG_REG_1_BASE:
>         val = pci_default_read_config(&s->dev,
> @@ -952,6 +952,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
> {
>     ATIVGAState *s = ATI_VGA(dev);
>     VGACommonState *vga = &s->vga;
> +    uint64_t aper_size;
>
> #ifndef CONFIG_PIXMAN
>     if (s->use_pixman != 0) {
> @@ -1011,7 +1012,18 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
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

This breaks pmon firmware of the mips64el fuloong2e machine which now 
prints:

PCIS
PCIR
PCIW
PCI bus 0 slot 6/0: not enough PCI mem space (134217728 requested)
NETI

and stops after

radeon init done
FRBI
cfb_console init,fb=b0000000

without display. Since that firmware is not included in QEMU and not quite 
available generally I think it's not critical to fix this but I'm not sure 
if it shows that the on board ATI chip on this machine behaves differently 
or there's some problem with modeling PCI in this machine. It seems to 
have these mappings:

     0000000010000000-0000000013ffffff (prio 0, i/o): alias pci.lomem0 @pci.mem 0000000000000000-0000000003ffffff
     0000000014000000-0000000017ffffff (prio 0, i/o): alias pci.lomem1 @pci.mem 0000000004000000-0000000007ffffff
     0000000018000000-000000001bffffff (prio 0, i/o): alias pci.lomem2 @pci.mem 0000000008000000-000000000bffffff

     0000000020000000-000000007fffffff (prio 0, i/o): alias pci.mem.alias @pci.mem 0000000000000000-000000005fffffff
     0000000080000000-00000000ffffffff (prio -1000, i/o): PCI_2

It seems likely that on the real machine the ATI chip is on the 
unimplemented PCI_2 bus which has more memory space mapped? In that case 
it probably should be fixed in hw/pci-host/bonito.c.

Using 64MiB for ATI_R100_LINEAR_APER_SIZE would also fix this but that may 
break other drivers on other systems so as this was verified on real cards 
I'd account this as a problem with the fuloong2e model and not try to work 
around it in ati-vga. Can mips maintainers please Ack if that's OK with 
you?

Regards,
BALATON Zoltan

