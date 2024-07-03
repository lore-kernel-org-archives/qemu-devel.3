Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14970C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 00:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnZT-0004bB-0a; Tue, 02 Jul 2024 20:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOnZO-0004aU-VO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 20:09:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOnZM-0007bc-AJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 20:09:58 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 71C9D4E6005;
 Wed, 03 Jul 2024 02:09:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id CFhLBmPDO3zA; Wed,  3 Jul 2024 02:09:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2A6A14E6001; Wed, 03 Jul 2024 02:09:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28A1D746E3B;
 Wed, 03 Jul 2024 02:09:45 +0200 (CEST)
Date: Wed, 3 Jul 2024 02:09:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 2/2] hw/isa/vt82c686.c: Embed i8259 irq in device state
 instead of allocating
In-Reply-To: <00311AC8-D02C-4C3A-85A7-8FB3B51DDE9C@gmail.com>
Message-ID: <cf46b29f-b36f-37b8-373f-72ad487ee749@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
 <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
 <CAFEAcA_tBjQrJMpjbzVUVcrTWghr4v=MHB0qpWx=xjML6ek9mg@mail.gmail.com>
 <4CBF639B-CC3E-4644-9F87-481B9147F2A9@gmail.com>
 <00311AC8-D02C-4C3A-85A7-8FB3B51DDE9C@gmail.com>
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

On Tue, 2 Jul 2024, Bernhard Beschow wrote:
> Am 2. Juli 2024 18:42:23 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>> Am 1. Juli 2024 12:58:15 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>>> On Sat, 29 Jun 2024 at 21:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>
>>>> To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
>>>> device state instead of allocating it.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>  hw/isa/vt82c686.c | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>>> index 8582ac0322..834051abeb 100644
>>>> --- a/hw/isa/vt82c686.c
>>>> +++ b/hw/isa/vt82c686.c
>>>> @@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
>>>>
>>>>  struct ViaISAState {
>>>>      PCIDevice dev;
>>>> +
>>>> +    IRQState i8259_irq;
>>>>      qemu_irq cpu_intr;
>>>>      qemu_irq *isa_irqs_in;
>>>>      uint16_t irq_state[ISA_NUM_IRQS];
>>>> @@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>>>>      ViaISAState *s = VIA_ISA(d);
>>>>      DeviceState *dev = DEVICE(d);
>>>>      PCIBus *pci_bus = pci_get_bus(d);
>>>> -    qemu_irq *isa_irq;
>>>>      ISABus *isa_bus;
>>>>      int i;
>>>>
>>>>      qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>>>      qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>>>> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>>>> +    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
>>>>      isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>>>>                            errp);
>>>
>>> So if I understand correctly, this IRQ line isn't visible
>>> from outside this chip,
>>
>> Actally it is, in the form of the INTR pin. Assuming similar naming

The INTR pin corresponds to qemu_irq cpu_intr not the i8259_irq.

>> conventions in vt82xx and piix, one can confirm this by consulting the 
>> piix4 datasheet, "Figure 5. Interrupt Controller Block Diagram". 
>> Moreover, the pegasos2 schematics (linked in the QEMU documentation) 
>> suggest that this pin is actually used there, although not modeled in 
>> QEMU.
>
> Well, QEMU does actually wire the intr pin in the pegasos2 board code, 
> except that it isn't a named gpio like in piix4. If we allow this pin to

I could make that named to make it clearer, now it's the only output gpio 
so did not name it as usually devices that only have one output don't use 
named gpios for that.

> be wired before the south bridge's realize we might be able to eliminate 
> the "intermediate irq forwarder" as Phil used to name it, resulting in 
> less and more efficient code. This solution would basically follow the 
> pattern I outlined under below link.

I think the problem here is that i8259 does not provide an output gpio for 
this interrupt that the VT82xx could pass on but instead i8259_init() 
needs a qemu_irq to be passed rhat the i8259 model will set. This seems to 
be a legacy init function so the fix may be to Qdev-ify i8259 and add an 
output irq to it then its users could instantiate and connect its IRQs as 
usual and we don't need to create a qemu_irq to pass it to i8259_init().

Regards,
BALATON Zoltan

> Best regards,
> Bernhard
>
>> Compare this to how the "intr" pin is exposed by the piix4 device model and wired in the Malta board.
>>
>>> we're just trying to wire together
>>> two internal components of the chip? If so, I agree that
>>> this seems a better way than creating a named GPIO that
>>> we then have to document as a "not really an external
>>> connection, don't try to use this" line. (We've done that
>>> before I think in other devices, and it works but it's
>>> a bit odd-looking.)
>>>
>>> That said, I do notice that the via_isa_request_i8259_irq()
>>> function doesn't do anything except pass the level onto
>>> another qemu_irq, so I think the theoretical ideal would be
>>> if we could arrange to plumb things directly through rather
>>> than needing this extra qemu_irq and function. There's
>>> probably a reason (order of device creation/connection?)
>>> that doesn't work though.
>>
>> I think there could be a general pattern of device creation/connection which I've outlined here: https://lore.kernel.org/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@gmail.com/
>>
>> Best regards,
>> Bernhard
>>
>>>
>>> -- PMM
>>>
>
>

