Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03320C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 01:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgCvQ-0007Mk-Vm; Thu, 06 Feb 2025 20:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tgCvJ-0007Lp-H9; Thu, 06 Feb 2025 20:12:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tgCvF-0002GY-B5; Thu, 06 Feb 2025 20:12:49 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 663084E6013;
 Fri, 07 Feb 2025 02:12:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KZYAcaPgC2sd; Fri,  7 Feb 2025 02:12:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1A5954E6000; Fri, 07 Feb 2025 02:12:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17E6174577C;
 Fri, 07 Feb 2025 02:12:38 +0100 (CET)
Date: Fri, 7 Feb 2025 02:12:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
Message-ID: <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
 <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
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

On Thu, 6 Feb 2025, Bernhard Beschow wrote:
> Am 2. Februar 2025 01:25:22 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sat, 1 Feb 2025, Bernhard Beschow wrote:
>>> Am 1. Februar 2025 14:55:15 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>> Am 30. Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>>>> On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>>>>> This allows guests to set the CCSR base address. Also store and return
>>>>>> values of the local access window registers but their functionality
>>>>>> isn't implemented.
>>>>>
>>>>> Ping?
>>>>
>>>> I guess you're trying to boot a real firmware image from SD card?
>>
>> I'm not trying, I've done it. I only needed these patches and 
>> commenting out the page_aligned = true in hw/sd/sdhci.c as I noted in 
>> the previous patch.
>
> I had to apply 
> <https://github.com/shentok/qemu/commit/56550cbb2805be2913ad9c12d6d9c6a9a3bf6f2c> 
> to have the SPL load the whole U-Boot proper.

Is that an alternative to commenting out page_aligned = true? (Previously 
it also needed some tweak on when to set DMA bit but after your fix in 
commit 5df50b8e973 in master resolved it that's no longer needed. Now only 
the interrupt control reset values and commenting page_aligned = true was 
needed to get it work.)

>> U-Boot works and I can run commands in the firmware prompt but I did 
>> not try to boot an OS yet. The amigaos boot loader which U-Boot for 
>> Tabor loads by default crashes somewhere but this may be a bug in the 
>> patched U-Boot. I think I've seen similar with sam460ex U-Boot before, 
>> maybe it's because of not finding some expected devices and not 
>> handling the returned NULL value well but I did not debug it.
>
> Do you use the Tabor U-Boot or something else?

I've tested the firmware image available from this page:
http://eliyahu.org/tabor/setup.html
There's also a technical manual there that has info on the content of the 
SD card image.

> How do you get to the command prompt? For me, the bootloader application 
> started by Tabor U-Boot doesn't crash but then doesn't find bootable 
> devices, not even with an emulated USB stick. Instead of dropping to the 
> command prompt it only offers a restart to the firmware which then 
> starts the bootloader application again...

There are two U-Boot binaries on the card for some reason (I think maybe 
the first one runs from cache as RAM and sets up the memory controller), 
then the first one loads some env variables and then the second U-Boot 
which then loads the bootloader. If you change one byte in the environment 
on the SD card it breaks the checksum and then it does not load the 
bootloader but gives a prompt. You can then look around in U-Boot. 
Alternatively you can extract the U-Boot binaries and convert to elf to 
load it with -bios then you can skip the SD card. Maybe depending on some 
env settings I haven't identified yet, the bootloader either says no 
bootable devices found or crashes when calling back into U-Boot which may 
be something similar that I had to fix for sam460ex here: 
https://gitlab.com/qemu-project/u-boot-sam460ex/-/commit/f6402c160f781145206b2dc0eb4d50738d0531d4/ 
but I don't have the Tabor U-Boot sources yet to check. Presumably it 
works on real machine so maybe it checks for SATA or other devices which 
aren't emulated so it may get an unexpected NULL value. I've tried adding 
dummy SATA emulation that shows an empty bus but it did not fix that. It 
could also be something completely different. With the USB patch, it at 
least finds USB storage devices after usb start in U-Boot but that's all I 
could test. I should find some Linux boot media known to work on real 
machine to test further but haven't had time for it.

>>>> I've implemented that in my e500-fdt branch which I want to send as 
>>>> an RFC. I still need to clean it up. Once it's on the list we could 
>>>> make a plan how to turn it into a p10xx. Would that work for you?
>>
>> Sure, I can try to test your patches once they are submitted to the 
>> list and rebase my changes on top if they still needed. I've just 
>> submitted these so you can incorporate them in your tree so I have less 
>> to rebase but I see you already have most of these. I'm OK to wait 
>> until your tree is cleaned and submitted but it seems there are a lot 
>> of patches so it might take a while. I don't expect that you can get it 
>> merged before the next release. Some of the patches may need several 
>> versions or alternative approaches until they can be merged. For 
>> example I expect problems with allowing ',' in device names as this is 
>> something that was removed before to avoid the need of quoting or 
>> something like that. But I'm not in a hurry as I don't have much free 
>> time for it anyway so only come back to this time to time and it's far 
>> from anything useful yet.
>
> My branch is not a maintainer tree. I neither expect it to be mergeable 
> like this, nor is it my goal. Instead, it's just an experiment to 
> investigate data-driven machine creation which I'd like to share as an 
> RFC with the community.
>
> That said, one could probably turn that branch into a p10xx SoC 
> implemented in the classic way. For this, one would need to decide on 
> how to proceed with the mpc8544ds and e500plat machines. There are

These existing machines set up values in PPCE500MachineClass in their init 
methods that the e500.c uses to change its behaviour to match the machine 
so to continue adding another board in the classic way I'd continue like 
that. I've added another similar board file like those machines setting 
the values matching P1022. For the additional devices in e500.c I've just 
patched them in for experimenting but these could be optionally created 
based on new values in the MachineClass, like has_2nd_i2c or similar to 
not change existing machines. I would not go into more elaborate solutions 
if your fdt based machine creation replaces this eventually.

> Buildroot recipes for the machines, both 32 and 64 bit, which might be 
> nice to keep working -- ideas welcome. Once the p10xx SoC is

I think the e500 machine was originally made for running with KVM and not 
for TCG emulation but it fell out of maintenance for a while and maybe 
Linux dropped some of the support by now so don't know if that still 
works. But it seems to still work for booting Linux in emulation so that 
should definitely be kept working.

> implemented, a tabor machine could be added which uses it.
>
>>
>>>>
>>>> Best regards,
>>>> Bernhard
>>>>
>>>> P.S. The last commit teaches you how to start a firmware from SD card.
>>
>> I did not try your version but looking at the patch looks like you have 
>> some sparse-mem region. (I've added similar one from board code, I did 
>> not know about this device.) Isn't that the l2cache as RAM or on-chip 
>> SRAM or whatever it's called? You seem to have some emulation of that 
>> l2cache in a previous patch so can't that be mapped there? Maybe we'll 
>> eventually need to implement reading the BOOT data from the beginning 
>> of the SD card or flash ROM which may have some initial register values 
>> that set things up that are currently hard coded.
>
> This is implemented on my branch. It pokes the L2 cache registers to 
> configure some (but not all) SRAM to load the SPL to. This SPL uses 
> cache as RAM which I'm emulating with a modified sparse-mem region 
> device.

This is new addition from today. I still don't get why you need sparse-mem 
when you also have a separate patch for l2cache regs which could have a 
memory region itself for this but for now I'm OK with adding this region 
from the tabor board code on my branch for experimenting. I'm a long way 
from this to work or being mergeable so your RFC might be ready and merged 
before that and then I don't need most of my changes, so I try to keep 
them minimal and have no intent trying to clean up the existing machines 
or SoC emulation.

>> Meanwhile I can cherry pick some patches from your tree and test them. 
>> Looks like you have some DDR3 support added, I haven't got to that yet.
>>
>> For USB I had this for now:
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index ee17acdb69..54890d25f3 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -900,6 +900,29 @@ static void ppce500_power_off(void *opaque, int line, int on)
>>     }
>> }
>>
>> +static uint64_t usb_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    switch (addr) {
>> +    case 0:
>> +        return BIT(2) | BIT(17);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void usb_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>> +{
>> +}
>> +
>> +static const MemoryRegionOps usb_ops = {
>> +    .read = usb_read,
>> +    .write = usb_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> void ppce500_init(MachineState *machine)
>> {
>>     MemoryRegion *address_space_mem = get_system_memory();
>> @@ -1118,6 +1141,19 @@ void ppce500_init(MachineState *machine)
>>                                     sysbus_mmio_get_region(s, 0));
>>     }
>>
>> +    /* USB */
>> +    dev = qdev_new("tegra2-ehci-usb");
>> +    s = SYS_BUS_DEVICE(dev);
>> +    sysbus_realize_and_unref(s, &error_fatal);
>> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 12));
>> +    memory_region_add_subregion(ccsr_addr_space, 0x22000,
>> +                                sysbus_mmio_get_region(s, 0));
>> +    {
>> +        MemoryRegion *mr =  g_new(MemoryRegion, 1);
>> +        memory_region_init_io(mr, OBJECT(dev), &usb_ops, s, "fsl-ehci", 4);
>> +        memory_region_add_subregion(ccsr_addr_space, 0x22500, mr);
>> +    }
>> +
>>     /* General Utility device */
>>     dev = qdev_new("mpc8544-guts");
>>     s = SYS_BUS_DEVICE(dev);
>>
>> which is reusing a sufficiently similar existing device just to have 
>> minimal changes. This isn't the right way but since most of these just 
>> differ in the reg offsets I wonder if we could turn these offsets into 
>> properties so we don't need to add a new subclass for every device. I 
>> think subclasses came from the pci version where the PCI IDs are 
>> different and maybe sysbus was modelled after that but we only need 
>> subclasses where additional registers are needed (which may be the case 
>> for this fsl device so this property idea is just unrelated clean up).
>
> My implementation has similar usb_ops but is based on TYPE_CHIPIDEA 
> which also has the "endpoints" registers covered. It is used by some 
> i.MX machines and given that these and p1022 are NXP SoCs I wouldn't be 
> surprised if they shared a relation in the real world.

Yes, the CHIPIDEA maybe is a better idea. I've only picked one that had 
the regs at the right place for a start and it seemed to work enough. But 
you likely have a more complete implementation so if you submit that 
eventually this will also be resolved for me so I can drop the above 
change and use yours instead. I just added it above because you seem to 
not have BIT(2) but I don't remember what that was and if it's really 
needed. Otherwise it looked you have the same.

Regards,
BALATON Zoltan

