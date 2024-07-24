Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E9AC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWaeF-00033K-Aw; Wed, 24 Jul 2024 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sWaeC-00030M-EQ; Wed, 24 Jul 2024 07:59:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sWae9-0000U6-AO; Wed, 24 Jul 2024 07:59:08 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7DB004E601B;
 Wed, 24 Jul 2024 13:58:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UJFcjy1cN0aD; Wed, 24 Jul 2024 13:58:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3BC474E6000; Wed, 24 Jul 2024 13:58:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39766746E3B;
 Wed, 24 Jul 2024 13:58:56 +0200 (CEST)
Date: Wed, 24 Jul 2024 13:58:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks
In-Reply-To: <8EA0DE3E-ACC4-4164-BAEE-C1AF2FB0F9A0@gmail.com>
Message-ID: <f0d3ea3a-1bcc-b1db-0e8e-6a34712225ef@eik.bme.hu>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240720143745-mutt-send-email-mst@kernel.org>
 <184E18CE-C4DF-4DEA-A20A-84B31833093F@gmail.com>
 <20240722202107-mutt-send-email-mst@kernel.org>
 <8EA0DE3E-ACC4-4164-BAEE-C1AF2FB0F9A0@gmail.com>
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

On Wed, 24 Jul 2024, Bernhard Beschow wrote:
> Am 23. Juli 2024 00:21:32 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
>> On Mon, Jul 22, 2024 at 10:21:30PM +0000, Bernhard Beschow wrote:
>>>
>>>
>>> Am 20. Juli 2024 18:38:42 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
>>>> On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
>>>>> This series first turns vt82c686's "INTR" pin into a named GPIO for better
>>>>> comprehensibility. It then continues fixing qemu_irq memory leaks in vt82c686
>>>>> and piix4 by connecting out IRQs of the south bridges before they get realized.
>>>>> This approach is already used in the pc machines after it had been discussed at
>>>>> KVM forum `23.
>>>>>
>>>>> Observe that out IRQs are callbacks such as an INTR IRQ handler in a CPU which a
>>>>> south bridge wants to trigger. If, as an implementation detail, the south bridge
>>>>> wants to pass this callback to a child device, such as the PIC, then this
>>>>> callback must be known to the south bridge before it gets realized. Otherwise
>>>>> board code had to wire the PIC device itself, breaking encapsulation. This means
>>>>> that qdev_connect_gpio_out*() has to be called before realize() which this
>>>>> series implements. Another way to look at it is that callbacks apparently are
>>>>> resouces such as memory regions which are also populated before realize().
>>>>>
>>>>> Please check if above paragraph makes sense.
>>>>>
>>>>> Best regards,
>>>>> Bernhard
>>>>
>>>>
>>>> Bernhard, do you intend to resolve Zoltan's comments on this
>>>> patchset?
>>>
>>> Hi Michael,
>>>
>>> I was hoping for some more comments on the last two commits. These resolve various issues in one go, some of which have been addressed in the past. Since this is apparently a new style to handle out-GPIOs, I'd like to get an OK from the community.
>>>
>>> As Zoltan writes the ideal solution might be to qdev'ify the PIC. This is a bigger task which is more than I intended to do in this series.
>>>
>>> Best regards,
>>> Bernhard
>>
>>
>> ATM I'm just looking at whether we can fix any bugs for the coming
>> release.
>
> Yes, makes sense. Both Zoltan's and my proposal qualify for bug fixing 
> IMO, and both are an improvement over the current code (fixing memory 
> leaks). I'm not too attached to either proposal, but I'd prefer a third

Maybe there is no real bugs to fix. We don't allocate these devices other 
than creating it once in the beginning with the machine that lives 
throughout the QEMU session. So plugging memory leaks is only to silence 
some analysers that complain about this but it won't fix any real bug. 
It's still good to silence the warnings which may even lead to failed 
compilation with some compilers.

> opinion on the matter. @Phil: As maintainer and one who worked on the 
> very same issues before you look like a good candidate. Though I'm not 
> sure if your time and focus allows for that right now.

I already said that my problem with your approach is that it relies on 
confusing rules for using gpio outs and gpio ins (one would need to be 
connected before realize and the other one after). I think qemu_irq is 
already a confusing part of QEMU hiding a pointer, qemu_gpio adds another 
level of complexity to thar and adding more rules making it inconsistent 
and behave differently in hard to remember ways is too much for anybody to 
use it correctly. So instead of making this more complex for users and 
changing all the call sites, it's better to fix it at the root and allow 
users to simply use it. Currently closest to the root is within vt82c686 
as i8259 isn't yet completely QDev-ified (some very old code that is used 
by a lot of other devices like i8259 is still pre QDev using legacy init).

The qemu_gpio is a QDev thing and QDev is meant to model devices so they 
can eventually be combined into a machine without board code just using a 
declarative description. So gpios should be used for outside facing pins 
of the device and it's more intuitive to connect these pins after the 
device is realized than to connect some of them before realize and some of 
them after. Using gpio for internal connections just because it's freed 
with the device is also wrong. For that embedding qemu_irq would be the 
way that's currently used for similar cases of one device internally using 
another (like SoCs). (I have a problem with embedding devices too as that 
exposes their state struct and thus implementation details outside of 
object implementation but that's another issue. Maybe the best solution 
would be creating resources and objects as children of the device so it 
would be freed with the device but some of these can be used outside of 
the device so then those places would need to reatain/release or ref/unref 
them which we likely forget to do so it would break either way.)

Regards,
BALATON Zoltan

> Best regards,
> Bernhard
>
>>
>>>>
>>>> Thanks!
>>>>
>>>>
>>>>> See also:
>>>>> * https://lore.kernel.org/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@gmail.
>>>>> com/
>>>>> * "Remove intermediate IRQ forwarder" patches in
>>>>> https://lore.kernel.org/qemu-devel/20230210163744.32182-1-philmd@linaro.org/
>>>>>
>>>>> Testing done:
>>>>> * Boot amigaone machine into Linux
>>>>> * Boot pegasos2 machine into MorphOS
>>>>> * Start fuloong2e machine and check that it doesn't abort
>>>>> * Boot malta machine with https://people.debian.org/~gio/dqib/
>>>>>
>>>>> Bernhard Beschow (3):
>>>>>   hw/isa/vt82c686: Turn "intr" irq into a named gpio
>>>>>   hw/isa/vt82c686: Resolve intermediate IRQ forwarder
>>>>>   hw/isa/piix: Resolve intermediate IRQ forwarder
>>>>>
>>>>>  hw/isa/piix.c       | 13 ++-----------
>>>>>  hw/isa/vt82c686.c   | 12 ++----------
>>>>>  hw/mips/fuloong2e.c |  2 +-
>>>>>  hw/mips/malta.c     |  4 +---
>>>>>  hw/ppc/amigaone.c   |  8 ++++----
>>>>>  hw/ppc/pegasos2.c   |  4 ++--
>>>>>  6 files changed, 12 insertions(+), 31 deletions(-)
>>>>>
>>>>> --
>>>>> 2.45.2
>>>>>
>>>>
>>
>
>

