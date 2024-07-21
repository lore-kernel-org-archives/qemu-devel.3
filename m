Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B74C3DA61
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 10:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVTk7-0001nu-Gy; Sun, 21 Jul 2024 06:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVTk6-0001mq-34; Sun, 21 Jul 2024 06:24:38 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVTk4-0007G4-2R; Sun, 21 Jul 2024 06:24:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 383B14E6000;
 Sun, 21 Jul 2024 12:22:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id j175YFlbFb1d; Sun, 21 Jul 2024 12:22:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E59F64E600E; Sun, 21 Jul 2024 12:22:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3527746E3B;
 Sun, 21 Jul 2024 12:22:56 +0200 (CEST)
Date: Sun, 21 Jul 2024 12:22:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
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
In-Reply-To: <20240720143745-mutt-send-email-mst@kernel.org>
Message-ID: <98637514-6307-37f3-009d-9b9d55d4a169@eik.bme.hu>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240720143745-mutt-send-email-mst@kernel.org>
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

On Sat, 20 Jul 2024, Michael S. Tsirkin wrote:
> On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
>> This series first turns vt82c686's "INTR" pin into a named GPIO for better
>> comprehensibility. It then continues fixing qemu_irq memory leaks in vt82c686
>> and piix4 by connecting out IRQs of the south bridges before they get realized.
>> This approach is already used in the pc machines after it had been discussed at
>> KVM forum `23.
>>
>> Observe that out IRQs are callbacks such as an INTR IRQ handler in a CPU which a
>> south bridge wants to trigger. If, as an implementation detail, the south bridge
>> wants to pass this callback to a child device, such as the PIC, then this
>> callback must be known to the south bridge before it gets realized. Otherwise
>> board code had to wire the PIC device itself, breaking encapsulation. This means
>> that qdev_connect_gpio_out*() has to be called before realize() which this
>> series implements. Another way to look at it is that callbacks apparently are
>> resouces such as memory regions which are also populated before realize().
>>
>> Please check if above paragraph makes sense.
>>
>> Best regards,
>> Bernhard
>
>
> Bernhard, do you intend to resolve Zoltan's comments on this
> patchset?

You can take this alternative for now:

https://patchew.org/QEMU/cover.1719690591.git.balaton@eik.bme.hu/

I think solving it the right way would need to QDev-ify i8259 and make it 
use gpio out and get rid of the legacy init function but as that's an old 
piece of code used by multiple machines, it's not easily done so maybe not 
for few days before the freeze.

For now I think either embedding the IRQ in the state struct (or 
alternatively adding an unrealize or finalize or whatever is the right 
method to free it) is better than changing all users of this device.

Regards,
BALATON Zoltan

