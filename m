Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA99G-0005vl-BU; Wed, 30 Apr 2025 11:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA998-0005uL-FU; Wed, 30 Apr 2025 11:14:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA994-0004q4-Rc; Wed, 30 Apr 2025 11:14:50 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 49FDA55D245;
 Wed, 30 Apr 2025 17:14:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id cWMVevgo10n2; Wed, 30 Apr 2025 17:14:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D321A55C592; Wed, 30 Apr 2025 17:14:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CD8B9745682;
 Wed, 30 Apr 2025 17:14:39 +0200 (CEST)
Date: Wed, 30 Apr 2025 17:14:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <871pt93gmo.fsf@draig.linaro.org>
Message-ID: <abac631f-c49e-6410-aea0-77f4ea6cad2f@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
 <875xin3qeh.fsf@draig.linaro.org>
 <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu>
 <87zffy3l4g.fsf@draig.linaro.org>
 <aec151d9-fae2-4bbc-c690-2b68f5906664@eik.bme.hu>
 <D9JJWC1IWEEB.1IA8DSZF98YT4@gmail.com>
 <0386a2ee-e2c3-a1df-f867-c8fcaf9689a4@eik.bme.hu>
 <871pt93gmo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2099078635-1746026079=:92718"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2099078635-1746026079=:92718
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 30 Apr 2025, Alex Bennée wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Wed, 30 Apr 2025, Nicholas Piggin wrote:
>>> On Wed Apr 30, 2025 at 7:09 AM AEST, BALATON Zoltan wrote:
>>>> On Tue, 29 Apr 2025, Alex Bennée wrote:
>>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>>> On Tue, 29 Apr 2025, Alex Bennée wrote:
>>>>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>>>>> On Mon, 28 Apr 2025, Richard Henderson wrote:
>>>>>>>>> On 4/28/25 06:26, BALATON Zoltan wrote:
> <snip>
>>>>>
>>>>> if we've been here before (needing n insn from the base addr) we will
>>>>> have a cached translation we can re-use. It doesn't stop the longer TB
>>>>> being called again as we re-enter a loop.
>>>>
>>>> So then maybe it should at least check if there's already a cached TB
>>>> where it can continue before calling cpu_io_recompile in io_prepare and
>>>> only recompile if needed?
>>>
>>> It basically does do that AFAIKS. cpu_io_recompile() name is misleading
>>> it does not cause a recompile, it just updates cflags and exits. Next
>>> entry will look up TB that has just 1 insn and enter that.
>>
>> After reading it I came to the same conclusion but then I don't
>> understand what causes the problem. Is it just that it will exit the
>> loop for every IO to look up the recompiled TB? It looks like it tries
>> to chain TBs, why does that not work here?
>
> Any MMIO access has to come via the slow path. Any MMIO also currently
> has to be the last instruction in a block in case the operation triggers
> a change in the translation regime that needs to be picked up by the
> next instruction you execute.
>
> This is a pathological case when modelling VRAM on a device because its
> going to be slow either way. At least if you model the multiple byte
> access with a helper you can amortise some of the cost of the MMU lookup
> with a single probe_() call.

I think there is some mix up here because of all the different scenarios I 
benchmarked so let me try to clear that up. The goal is to find out why 
access to vfio-pci passed through graphics card VRAM is slower than 
expected when the host should be faster than those mostly embedded or old 
PPCs used on real machines with only 4x PCIe or PCIe to PCI bridges. In 
this case we are not emulating VRAM but mapping the framebuffer from the 
real card and access that. To find where the slow down comes from I've 
benchmarked all the cases upthread but here are the relevant parts again 
for easier comparison:

First both src and dst are in RAM (just malloced buffers so this is the 
base line):

src 0xb79c8008 dst 0xb78c7008
byte loop: 21.16 sec
memset: 3.85 sec
memcpy: 5.07 sec
copyToVRAMNoAltivec: 2.52 sec
copyToVRAMAltivec: 2.42 sec
copyFromVRAMNoAltivec: 6.39 sec
copyFromVRAMAltivec: 7.02 sec

The FromVRAM cases use dcbz to avoid loading RAM contents to cache on real 
machine that is about to be overwritten so dcbz is never applied to MMIO. 
(Arguably it should use dcba but for some reason nobody remembers why it 
uses dcbz instead.) The ToVRAM cases have dcbt which is noop on QEMU. I 
guess the difference we see here is because of probe_access in dcbz as was 
shown by previous profiling. Replacing that with dcba (which is noop in 
QEMU) makes ToVRAM and FromVRAM run the about the same (you can find that 
case in original message). FromVRAM still a bit slower for some reason but 
most of this overhead can be accounted to dcbz.

In second test dst is mmapped from emulated ati-vga framebuffer BAR. We 
can say we emulate vram here but that's just a ram memory region created 
in vga.c as:

memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size, &local_err);

it also has dirty tracking enabled, I don't know if that has any effect. 
This is shown in left column here:

dst in emulated ati-vga               | dst in real card vfio vram
mapping 0x80800000                      mapping 0x80800000
src 0xb78e0008 dst 0xb77de000         | src 0xb7ec5008 dst 0xb7dc3000
byte loop: 21.2 sec                   | byte loop: 563.98 sec
memset: 3.89 sec                      | memset: 39.25 sec
memcpy: 5.07 sec                      | memcpy: 140.49 sec
copyToVRAMNoAltivec: 2.53 sec         | copyToVRAMNoAltivec: 72.03 sec
copyToVRAMAltivec: 12.22 sec          | copyToVRAMAltivec: 78.12 sec
copyFromVRAMNoAltivec: 6.43 sec       | copyFromVRAMNoAltivec: 728.52 sec
copyFromVRAMAltivec: 35.33 sec        | copyFromVRAMAltivec: 754.95 sec

Here we see that AltiVec cases have additional overhead which I think is 
related to vperm as that's the only op that does not seem to be compiled 
to something sensible but calls an unoptimised helper (although that's 
also there for RAM so not sure why this is slower). But this shows no 
other overhead due to MMIO being involved as the NoAltivec cases are the 
same as with RAM.

Last case, shown in right column above, is when instead of ati-vga I have 
a real ATI card passed through with vfio-pci which is much slower than 
what is explained only by PCI overhead and I'm trying to find out the 
source of that slow down.

I've now also run 1000 iterations (vs. 10000 above so numbers are 10 times 
less here than above in right column) of the last case again (using real 
card with vfio-pci) with qemu-system-ppc vs. qemu-system-ppc64 to see if 
mttcg has any effect:

1000 iterations qemu-system-ppc       | qemu-system-ppc64
mapping 0x80800000                      mapping 0x80800000
src 0xb7dc6008 dst 0xb7cc4000         | src 0xb78b8008 dst 0xb77b6000
byte loop: 58.44 sec                  | byte loop: 57.72 sec
memset: 3.99 sec                      | memset: 3.93 sec
memcpy: 14.43 sec                     | memcpy: 14.24 sec
copyToVRAMNoAltivec: 7.27 sec         | copyToVRAMNoAltivec: 7.15 sec
copyToVRAMAltivec: 7.9 sec            | copyToVRAMAltivec: 7.78 sec
copyFromVRAMNoAltivec: 72.68 sec      | copyFromVRAMNoAltivec: 72.69 sec
copyFromVRAMAltivec: 75.15 sec        | copyFromVRAMAltivec: 75.05 sec

This does not seem to have much effect so maybe not having mttcg does not 
enable icount just uses the same function which were confusing in the 
profile.

Finally I dug up some comparable results from real machine vs QEMU.
These are with QEMU with the default -cpu 7454 and -cpu g3 (to check 
AltiVec overhead but there seems to be only about 1%):

https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/2939
https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/2941

and same card on real machine:

https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/2414

It seems for larger rectangles we approach the same limits but smaller 
transfers (what I think VRAM copy also uses) have some big overhead 
compared to what PCIe communication alone explains.

Another card on QEMU:

https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/2931

and on real machine:

https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/2372

or a similar card (I did not find exactly the same) with slower CPU real 
machine:

https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS/Result/1672

Also on real machine using optimised routines does help so using wider 
transfers is better than default unoptimised case.

>>>> I was thinking maybe we need a flag or counter
>>>> to see if cpu_io_recompile is called more than once and after a limit
>>>> invalidate the TB and create two new ones the first ending at the I/O and
>>>> then what cpu_io_recompile does now which as I understood was what Richard
>>>> suggested but I don't know how to do that.
>>>
>>> memset/cpy routines had kind of the same problem with real hardware.
>>> They wanted to use vector instructions for best performance, but when
>>> those are used on MMIO they would trap and be very slow.
>>
>> Why do those trap on MMIO on real machine? These routines were tested
>> on real machines and the reasoning to use the widest possible access
>> was that PCI transfer has overhead and that is minimised by
>> transferring more bits in one op. I think they also verifed that it
>> works at least for the 32 bit CPUs up to G4 that were used on real
>> AmigaNG machines. There are some benchmark results here:
>> https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS?start=60 which
>> is also where the benchmark I used comes from so this should be
>> similar. I think the MemCopy on that page has plain unoptimised copy
>> as Copy to/from VRAM and optimised routines similar to this benchmark
>> as Read/Write Pixel Array, but it's not easy to search. Some of the
>> machines like Pegasos II and AmigaOne XE were made with both G3 or G4
>> CPUs so if I find a result from those with same graphics card that
>> could show if AltiVec is faster (although the G4s were also higher
>> clock so not directly comparable). Some results there are also from
>> QEMU, mostly those that are with SiliconMotion 502 but that does not
>> have this problem only vfio-pci pass through.
>
> They don't - what we need is to have a RAM-like-device model for QEMU
> where we can relax the translation rules because we know we are writing
> to RAM like things that don't have registers or other state changing
> behaviour.
>
> The poor behaviour is because QEMU currently treats all MMIO as
> potentially system state altering where as for VRAM it doesn't need to.

This does not seem to be the case with emulated ati-vga, and with vfio-pci 
it should also be mapped memory from the graphics card which technically 
is MMIO but how does QEMU decides that when it does not seem to consider 
ati-vga as IO? Typically in QEMU MMIO is an io memory region that goes 
through memops and that's understandably slow but here we should 
read/write mapped memory space. Maybe I should try to find out what 
vfio-pci actually does here but it is used for gaming with KVM and there 
people get near native performance so I don't think there is an overhead 
in vfio-pci.

So I could explain some small overheads with dcbz and maybe vperm but the 
biggest one seems to only happen when accessing real card VRAM with 
vfio-pci that does not seem to happen on real machine and I could not 
reproduce with emulated ati-vga either but that's all I could find out so 
far and still don't get where the biggest overhead comes from.

Regards,
BALATON Zoltan

>> So maybe it's something
>> with how vfio-pci maps PCI memory BARs?
>
> I don't know about vfio-pci but blob resources mapped via virtio-gpu
> just appear as chunks of RAM to the guest - hence no trapping.
>
>>
>>> Problem is we don't know ahead of time if some routine will access
>>> MMIO or not. You could recompile it with fewer instructions but then
>>> it will be slow when used for regular memory.
>>>
>>> Heuristics are tough because you could have e.g., one initial big
>>> memset to clear a MMIO region that iterates many times over inner
>>> loop of dcbz instructions, but then is never used again for MMIO but
>>> important for regular page clearing. Making something that dynamically
>>> decays or periodically would recompile to non-IO case perhaps, but
>>> then complexity goes up.
>
> We can't have heuristics when we must prioritise correctness. However we
> could expand the device model to make the exact behaviour of different
> devices clear and optimise when we know it is safe.
>
>>> I would prefer not like to do that just for a microbenchmark, but if
>>> you think it is reasonable overall win for average workloads of your
>>> users then perhaps.
>>
>> I'm still trying to understand what to optimise. So far it looks like
>> that dcbz has the least impact, then vperm a bit bigger but still only
>> about a few percent and the biggest impact is still not known for sure
>> but we see faster access on real machines that run on slower PCIe
>> (only 4x at best) while CPU benchmarks don't show slower performance
>> on QEMU only accessing passed through card's VRAM is slower than
>> expected. But if there's a trap involved I've found before that
>> exceptions are slower with QEMU but I did not see evidence of that in
>> the profile.
>>
>> Regards,
>> BALATON Zoltan
>
>
--3866299591-2099078635-1746026079=:92718--

