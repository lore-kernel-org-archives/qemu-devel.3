Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F6C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArO6-0006Q2-B6; Fri, 02 May 2025 10:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uArO4-0006Pq-IM; Fri, 02 May 2025 10:29:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uArO0-0004i1-NH; Fri, 02 May 2025 10:29:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1106855D26D;
 Fri, 02 May 2025 16:29:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kU7W5eI0teyi; Fri,  2 May 2025 16:29:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8BC0155D267; Fri, 02 May 2025 16:29:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 899C1745682;
 Fri, 02 May 2025 16:29:01 +0200 (CEST)
Date: Fri, 2 May 2025 16:29:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: vfio vs tcg (was: Re: [RFC PATCH] target/ppc: Inline most of dcbz
 helper)
Message-ID: <3949473e-6169-69e3-9521-c535d75701fa@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-69100718-1746196141=:56262"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-69100718-1746196141=:56262
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Adding some vfio people who I hope could give some more insight. The 
question I try to find out is why accessing VRAM of a graphics card passed 
through with vfio-pci to a PPC guest running on x86_64 host with TCG is 
slow.

On Wed, 30 Apr 2025, BALATON Zoltan wrote:
> On Wed, 30 Apr 2025, Alex Bennée wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Wed, 30 Apr 2025, Nicholas Piggin wrote:
>> Any MMIO access has to come via the slow path. Any MMIO also currently
>> has to be the last instruction in a block in case the operation triggers
>> a change in the translation regime that needs to be picked up by the
>> next instruction you execute.
>> 
>> This is a pathological case when modelling VRAM on a device because its
>> going to be slow either way. At least if you model the multiple byte
>> access with a helper you can amortise some of the cost of the MMU lookup
>> with a single probe_() call.
>
> I think there is some mix up here because of all the different scenarios I 
> benchmarked so let me try to clear that up. The goal is to find out why 
> access to vfio-pci passed through graphics card VRAM is slower than expected 
> when the host should be faster than those mostly embedded or old PPCs used on 
> real machines with only 4x PCIe or PCIe to PCI bridges. In this case we are 
> not emulating VRAM but mapping the framebuffer from the real card and access 
> that. To find where the slow down comes from I've benchmarked all the cases 
> upthread but here are the relevant parts again for easier comparison:
>
> First both src and dst are in RAM (just malloced buffers so this is the base 
> line):
>
> src 0xb79c8008 dst 0xb78c7008
> byte loop: 21.16 sec
> memset: 3.85 sec
> memcpy: 5.07 sec
> copyToVRAMNoAltivec: 2.52 sec
> copyToVRAMAltivec: 2.42 sec
> copyFromVRAMNoAltivec: 6.39 sec
> copyFromVRAMAltivec: 7.02 sec
>
> The FromVRAM cases use dcbz to avoid loading RAM contents to cache on real 
> machine that is about to be overwritten so dcbz is never applied to MMIO. 
> (Arguably it should use dcba but for some reason nobody remembers why it uses 
> dcbz instead.) The ToVRAM cases have dcbt which is noop on QEMU. I guess the 
> difference we see here is because of probe_access in dcbz as was shown by 
> previous profiling. Replacing that with dcba (which is noop in QEMU) makes 
> ToVRAM and FromVRAM run the about the same (you can find that case in 
> original message). FromVRAM still a bit slower for some reason but most of 
> this overhead can be accounted to dcbz.
>
> In second test dst is mmapped from emulated ati-vga framebuffer BAR. We can 
> say we emulate vram here but that's just a ram memory region created in vga.c 
> as:
>
> memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size, 
> &local_err);
>
> it also has dirty tracking enabled, I don't know if that has any effect. This 
> is shown in left column here:
>
> dst in emulated ati-vga               | dst in real card vfio vram
> mapping 0x80800000                      mapping 0x80800000
> src 0xb78e0008 dst 0xb77de000         | src 0xb7ec5008 dst 0xb7dc3000
> byte loop: 21.2 sec                   | byte loop: 563.98 sec
> memset: 3.89 sec                      | memset: 39.25 sec
> memcpy: 5.07 sec                      | memcpy: 140.49 sec
> copyToVRAMNoAltivec: 2.53 sec         | copyToVRAMNoAltivec: 72.03 sec
> copyToVRAMAltivec: 12.22 sec          | copyToVRAMAltivec: 78.12 sec
> copyFromVRAMNoAltivec: 6.43 sec       | copyFromVRAMNoAltivec: 728.52 sec
> copyFromVRAMAltivec: 35.33 sec        | copyFromVRAMAltivec: 754.95 sec
>
> Here we see that AltiVec cases have additional overhead which I think is 
> related to vperm as that's the only op that does not seem to be compiled to 
> something sensible but calls an unoptimised helper (although that's also 
> there for RAM so not sure why this is slower). But this shows no other 
> overhead due to MMIO being involved as the NoAltivec cases are the same as 
> with RAM.
>
> Last case, shown in right column above, is when instead of ati-vga I have a 
> real ATI card passed through with vfio-pci which is much slower than what is 
> explained only by PCI overhead and I'm trying to find out the source of that 
> slow down.
[...]
>>> Why do those trap on MMIO on real machine? These routines were tested
>>> on real machines and the reasoning to use the widest possible access
>>> was that PCI transfer has overhead and that is minimised by
>>> transferring more bits in one op. I think they also verifed that it
>>> works at least for the 32 bit CPUs up to G4 that were used on real
>>> AmigaNG machines. There are some benchmark results here:
>>> https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS?start=60 which
>>> is also where the benchmark I used comes from so this should be
>>> similar. I think the MemCopy on that page has plain unoptimised copy
>>> as Copy to/from VRAM and optimised routines similar to this benchmark
>>> as Read/Write Pixel Array, but it's not easy to search. Some of the
>>> machines like Pegasos II and AmigaOne XE were made with both G3 or G4
>>> CPUs so if I find a result from those with same graphics card that
>>> could show if AltiVec is faster (although the G4s were also higher
>>> clock so not directly comparable). Some results there are also from
>>> QEMU, mostly those that are with SiliconMotion 502 but that does not
>>> have this problem only vfio-pci pass through.
>> 
>> They don't - what we need is to have a RAM-like-device model for QEMU
>> where we can relax the translation rules because we know we are writing
>> to RAM like things that don't have registers or other state changing
>> behaviour.
>> 
>> The poor behaviour is because QEMU currently treats all MMIO as
>> potentially system state altering where as for VRAM it doesn't need to.
>
> This does not seem to be the case with emulated ati-vga, and with vfio-pci it 
> should also be mapped memory from the graphics card which technically is MMIO 
> but how does QEMU decides that when it does not seem to consider ati-vga as 
> IO? Typically in QEMU MMIO is an io memory region that goes through memops 
> and that's understandably slow but here we should read/write mapped memory 
> space. Maybe I should try to find out what vfio-pci actually does here but it 
> is used for gaming with KVM and there people get near native performance so I 
> don't think there is an overhead in vfio-pci.

After looking at how vfio creates the BARs it seems to use 
memory_region_io but then also mmaps it but maybe not always. I could not 
find out how this works but there may be MMIO involved here. With KVM this 
may not be a problem but it causes TCG to break the TB at the op accessing 
the IO region and if this is in a loop it can cause freqent exits and 
looking up a new TB at least that's what I think now. Question if this 
seems correct and how could it be avoided? Can TBs be chained here to 
avoid the exit from the loop? Or why do we have io memory regions for the 
PCI memory bars in the first place when these are then mapped in the guest 
address space and accessed directly?. In hw/vfio/region.c the 
vfio_region_{read,write} memop functions seem to do two things: endian 
conversion and calling eoi to maybe ack an interrupt? Why the endian 
conversion is needed when the guest should be aware it's talking to a PCI 
device (and also the memops is defined as DEVICE_LITTLE_ENDIAN so there 
may be double conversion here)? I don't know how the interrupts work but 
this maybe only makes sense for MMIO BARs that contain registers and not 
for VRAM. Typically VRAM is marked as prefetchable so maybe for those BARs 
we could use memory regions instead of io to avoid this problem?

More details can be found in the original thread here:
https://lists.nongnu.org/archive/html/qemu-ppc/2025-04/msg00326.html

Regards,
BALATON Zoltan
--3866299591-69100718-1746196141=:56262--

