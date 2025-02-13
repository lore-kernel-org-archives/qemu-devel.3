Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D935C02198
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 00:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiMrI-0002WL-CK; Wed, 12 Feb 2025 19:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiMrG-0002Vv-9s; Wed, 12 Feb 2025 19:13:34 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tiMrD-0004v5-PQ; Wed, 12 Feb 2025 19:13:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D4B04E6019;
 Thu, 13 Feb 2025 01:13:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fq7rqZcBf77K; Thu, 13 Feb 2025 01:13:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2C9124E6014; Thu, 13 Feb 2025 01:13:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28E0974577D;
 Thu, 13 Feb 2025 01:13:24 +0100 (CET)
Date: Thu, 13 Feb 2025 01:13:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <4023E866-442D-408B-9BD7-9036694DD8DF@gmail.com>
Message-ID: <a4083d0c-acd5-f9da-66da-d796d09a0808@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
 <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
 <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
 <4023E866-442D-408B-9BD7-9036694DD8DF@gmail.com>
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

On Wed, 12 Feb 2025, Bernhard Beschow wrote:
> Am 7. Februar 2025 01:12:38 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Thu, 6 Feb 2025, Bernhard Beschow wrote:
>>> Am 2. Februar 2025 01:25:22 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>>
>>> I had to apply 
>>> <https://github.com/shentok/qemu/commit/56550cbb2805be2913ad9c12d6d9c6a9a3bf6f2c> 
>>> to have the SPL load the whole U-Boot proper.
>>
>> Is that an alternative to commenting out page_aligned = true?
>
> Well, it's not needed with the patch applied. The patch ensures that all 
> data gets loaded: 
> <https://lore.kernel.org/qemu-devel/D62F06C8-5247-4FBC-82A9-9127352B30A6@gmail.com/>

I think the block layer has a solution for such long running operations 
and uses coroutines for that but I don't know how that works and I could 
not find useful documentation on it. But I don't understand the problem 
either so if you've solved it and submit a patch that can be merged that's 
good enough for me.

>> There are two U-Boot binaries on the card for some reason (I think 
>> maybe the first one runs from cache as RAM and sets up the memory 
>> controller), then the first one loads some env variables and then the 
>> second U-Boot which then loads the bootloader.
>
> Yeah, that's the SPL and U-Boot proper. The first one sets up RAM based 
> on DDR3 data, copies U-Boot proper there (currently broken in QEMU, see 
> above), and passes control to it.

U-Boot proper runs for me too but it may have a bug in the Tabor specific 
patch (maybe revealed by missing emulation) that prevents the bootloader 
to find a device but I can run until U-Boot and enter commands to it, it 
only stops in the bootloader when that calls back to U-Boot. If you 
extract U-Boot proper from the SD card image, convert it to elf and run it 
with -bios you'd get a prompt so it works. That's what I do now for 
experimenting but I'd like it to boot from the SD card the same way as 
real machine does eventually.

> Considering the technical manual it may be possible to compile U-Boot 
> oneself and replace components of the firmware image. That way, one 
> could track down why no bootable devices are found, i.e. check whether 
> and which bootmenu_x variables are populated. That's not on my todo list 
> though.

First of all one would need the source for that which should be available 
because of GPL but it's not, at least I could not find it yet. Eventually 
I'll get it and may look at this but I'd also like to run binary known to 
work on real machine to make sure emulation is correct.

>> These existing machines set up values in PPCE500MachineClass in their 
>> init methods that the e500.c uses to change its behaviour to match the 
>> machine so to continue adding another board in the classic way I'd 
>> continue like that. I've added another similar board file like those 
>> machines setting the values matching P1022. For the additional devices 
>> in e500.c I've just patched them in for experimenting but these could 
>> be optionally created based on new values in the MachineClass, like 
>> has_2nd_i2c or similar to not change existing machines.
>
> The challenge is that different variants of the SoC have the same IP 
> cores mapped at different offsets with possibly (haven't checked) IRQs. 
> These need to be considered when generating the DTB. To avoid dealing 
> with this question -- and at the same time explore data-driven machine 
> creation -- I reversed the process and generated the machine from the 
> DTB. But this question needs to be answered when implementing a P1022.

Yes, your DTB based board code is a nice way to create different machines 
as the DTB already describes these offsets and irq connections and your 
code seems to be quite simple so I think it's a good idea that's worth 
pursuing, that could enhance the ppce500 machine and make it more generic. 
It could then also drop the separate mpc85xx machine and put all of these 
under one ppce500 machine with passing the right dtb to create the 
different machines. As long as these are similar enough and only differ in 
the devices they have, this could emulate a lot of these SoCs with the 
same code.

>> I would not go into more elaborate solutions if your fdt based machine 
>> creation replaces this eventually.
>
> As said before, I'd send an RFC for discussion on how to proceed.

As I wrote before I think one issue to solve as a next step would be avoid 
needing subclasses with comma in names for all compatible devices. I think 
allowing alternative names for the same type in the types hash table could 
be enough but to hide these from users and -device which can't take comma 
names, these might need to go in a separate hash table instead. This could 
work the same as register_type but would be something like 
register_compatible_name_for_type that adds only a name for an existing 
type so it does not need a subclass and duplicate class or type struct 
when all we need is a different name for the existing type. I don't know 
if it's best put in a new hash table or the same one that holds type 
names. E.g. machine names already have aliases for versioned machines for 
example. This could be similar for devices that could have alias names for 
compatible property in the DTB. Putting these in a separate hash table 
might be needed if adding them to the same type name would list them in 
-device help or having names with ',' there would cause a problem but it 
might even work without that.

These are only high level ideas and I don't know how to implement these 
but maybe you can do something with it. In any case, I'm looking forward 
for your RFC and try to help reviewing it but I don't have free time to 
contribute so I'll continue experimenting with the current code upstream 
that's good enough for what I do and it's faw away to try to upstream it 
so by then your changes could be merged. What I may contribute is new 
device emulation for missing parts. I have some dummy sata that does 
nothing but allows the Linux driver to pass detecting no devices, a half 
working DIU I made in the last few days that needs more work but I got 
some image from U-Boot on it and may look at the DMA controller in the 
future. Let me know if you're interested in these or have something for 
these or other parts I could use instead. I've tested your SPI flash 
implementation but it wasn't working with U-Boot for me and may look at 
your USB eventually.

>>> This is implemented on my branch. It pokes the L2 cache registers to 
>>> configure some (but not all) SRAM to load the SPL to. This SPL uses 
>>> cache as RAM which I'm emulating with a modified sparse-mem region 
>>> device.
>>
>> This is new addition from today. I still don't get why you need 
>> sparse-mem when you also have a separate patch for l2cache regs which 
>> could have a memory region itself for this but for now I'm OK with 
>> adding this region from the tabor board code on my branch for 
>> experimenting.
>
> The stack location is specific to U-Boot, not the chip. It resides in 
> cache (used as RAM) rather than in SRAM. Modeling a cache with cache 
> lines etc. was a rabbit hole I didn't want to get into. Hence I extended 
> sparse-mem for this stack region to be user-creatable. When implementing 
> a Tabor machine this stack region could be hardcoded there.

I'm not sure I follow what you say but also not sure if you meant cache 
when writing stack in some places. Sure, the whole cache with all its 
details does not need to be modelled but what I meant is that if you 
emulate l2cache controller registers you could emulate the one that maps 
the cache at some address as sram then the BOOT table at the beginning of 
the SD card should write that to map it at the right place so if you also 
have code to parse that then no sparse-mem should be needed on the command 
line. Or is that some other register not part of l2cache? But this is 
something that can be sorted later so not a big deal, until then adding s 
memory region there either from board code or from command line will do. I 
think I get now that maybe you mean that command line is better because 
different boards have this at different location so you need to specify 
the address and that's easier with -device.

Regards,
BALATON Zoltan

