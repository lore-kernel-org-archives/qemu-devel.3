Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97F8CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIONp-0006Qr-4a; Sun, 18 Oct 2026 06:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xIONn-0006QZ-3m
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:44:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xIONk-00020g-Tf
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:44:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A85A60C2E3;
 Sun, 18 Oct 2026 12:44:45 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5sBH52vVXhYz; Sun, 18 Oct 2026 12:44:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DFAE960C2B6; Sun, 18 Oct 2026 12:44:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD7781398B4;
 Sun, 18 Oct 2026 12:44:42 +0200 (CEST)
Date: Sun, 18 Oct 2026 12:44:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Quante <christian@quante.one>
cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] hw/display/cirrus_vga: do not coalesce the writes
 that start a BitBLT
In-Reply-To: <20261018050643.9288-4-christian@quante.one>
Message-ID: <63eb396c-26f5-9dc1-a7f1-2adb62968db5@eik.bme.hu>
References: <20261018050643.9288-1-christian@quante.one>
 <20261018050643.9288-4-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Sun, 18 Oct 2026, Christian Quante wrote:
> cirrus_init_common() marks the whole legacy window 0xa0000-0xbffff for
> coalesced MMIO.  This includes the memory-mapped BitBLT registers at
> 0xb8000-0xb80ff (SR17 bit 2 set, bit 6 clear).  With KVM, writes to
> these registers wait in the coalesced MMIO ring until QEMU flushes the
> ring, for example before the next access to a region with
> flush_coalesced_mmio set.
>
> Most of these writes only set parameters, but two of them start a
> BitBLT: the write of GR2A (destination address) with autostart (GR31
> bit 7), and the write of GR31.  For a system-to-screen BitBLT, the guest
> then writes the source data.  If it writes them to the linear frame
> buffer or to the bank window at 0xa0000, they go straight to video
> memory: both are plain RAM until cirrus_bitblt_start() has run and
> unmapped them.  The source data are lost.  When the guest reads GR31 to
> wait for the end of the BitBLT, the ring is flushed, the BitBLT starts
> and waits for data that do not come.  GR31 stays busy until the driver
> gives up.
>
> XFree86 3.3.6 (XF86_SVGA) on the CL-GD5436/46 programs the BitBLT through
> these registers with autostart, and writes the source data for text to
> the linear frame buffer.  In the installer of SuSE Linux 7.0 with KVM,
> the X server runs into the time-out of its wait loop for each piece of
> text, and most text is missing.
>
> Commit f65ed4c1529f ("KVM: Coalesced MMIO support") added the coalescing
> for writes "if those writes do not have side effects".  Keep it for the
> rest of the window and for the parameter registers, but not for the
> bytes of GR2A and GR31.  A write to one of these bytes leaves the guest
> at once; KVM coalesces only writes that lie completely inside one zone
> (virt/kvm/coalesced_mmio.c), so this is also true for a dword write to
> offset 0x10.  The region has flush_coalesced_mmio set, so QEMU first
> processes the parameter writes from the ring and then starts the
> BitBLT.
>
> The two bytes are excluded from coalescing also while the BitBLT
> registers are not mapped at 0xb8000.  In a text mode, 0xb8012 and
> 0xb8040 are then part of the text buffer, and a write to one of them
> leaves the guest at once.
>
> With KVM, a screen-to-screen BitBLT that the guest programs with nine
> writes to these registers takes 12.8 us with this patch, and 8.1 us
> with the coalescing for all registers.  If none of the 256 bytes of the
> registers is coalesced, it takes 26.0 us.
>
> Signed-off-by: Christian Quante <christian@quante.one>
> ---
>
> Notes:
>    Two more guests show this with KVM, but they need other Cirrus patches
>    of mine to get this far, which I will send after this series:
>     - Windows for Workgroups 3.11 with the CL-GD5436/46 display driver for
>       Windows 3.1 (needs "hw/display/cirrus_vga: add the byte swapping PCI
>       apertures 1 and 2"): single characters and the STOP icon are
>       missing, and the hourglass stays.
>     - OS/2 Warp 3 with its Cirrus driver on isa-cirrus-vga (needs
>       "hw/display/cirrus_vga: read back the cursor position bits of
>       SR10/SR11"): the driver hangs while it draws the desktop.
>
> hw/display/cirrus_vga.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index dc216cde56..6f1f9ac82f 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2847,6 +2847,21 @@ static const MemoryRegionOps cirrus_vga_io_ops = {
>     },
> };
>
> +/*
> + * Coalesce the writes to the legacy window 0xa0000-0xbffff, but not to the
> + * two bytes of the memory-mapped BitBLT registers whose write can start a
> + * BitBLT: GR2A (with autostart) and GR31.
> + */
> +static void cirrus_coalesce_low_mem(CirrusVGAState *s)
> +{
> +    hwaddr gr2a = 0x18000 + CIRRUS_MMIO_BLTDESTADDR + 2;
> +    hwaddr gr31 = 0x18000 + CIRRUS_MMIO_BLTSTATUS;
> +
> +    memory_region_add_coalescing(&s->low_mem, 0, gr2a);
> +    memory_region_add_coalescing(&s->low_mem, gr2a + 1, gr31 - gr2a - 1);
> +    memory_region_add_coalescing(&s->low_mem, gr31 + 1, 0x20000 - gr31 - 1);

Should this better use memory_region_size(&s->low_mem) instead of hard 
coding 0x20000 here? Also since you only use s->low_mem and the function 
says that in its name already it could take the MemoryRegion * instead of 
passing the whole CirrusVGAState but I don't mind either way.

Regards,
BALATON Zoltan

> +}
> +
> void cirrus_init_common(CirrusVGAState *s, Object *owner,
>                         int device_id, int is_pci,
>                         MemoryRegion *system_memory, MemoryRegion *system_io)
> @@ -2907,7 +2922,7 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
>                                         0x000a0000,
>                                         &s->low_mem_container,
>                                         1);
> -    memory_region_set_coalescing(&s->low_mem);
> +    cirrus_coalesce_low_mem(s);
>
>     /* I/O handler for LFB */
>     memory_region_init_io(&s->cirrus_linear_io, owner, &cirrus_linear_io_ops, s,
>

