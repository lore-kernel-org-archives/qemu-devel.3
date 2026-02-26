Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107BBFD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkIK-0008Ge-4Y; Thu, 26 Feb 2026 17:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvkII-0008GR-5F
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:57:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vvkIF-0003kk-HS
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:57:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28EA3596A29;
 Thu, 26 Feb 2026 23:57:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id V3qePtzIJgkg; Thu, 26 Feb 2026 23:57:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67F445969F6; Thu, 26 Feb 2026 23:57:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 626B55969E4;
 Thu, 26 Feb 2026 23:57:10 +0100 (CET)
Date: Thu, 26 Feb 2026 23:57:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
In-Reply-To: <CAFEAcA8wu0kvL0END0woXp-yTpv-Va708Uytc--ASJBiEi7Yvw@mail.gmail.com>
Message-ID: <6d68c9d1-7015-ed1a-a781-7d115be86a58@eik.bme.hu>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
 <3a72c0f3-ba85-1e98-3964-5f43efb80375@eik.bme.hu>
 <CAFEAcA8wu0kvL0END0woXp-yTpv-Va708Uytc--ASJBiEi7Yvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 26 Feb 2026, Peter Maydell wrote:
> On Wed, 25 Feb 2026 at 01:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Tue, 24 Feb 2026, Mark Cave-Ayland wrote:
>>> The questions I think we need to answer as a starting point:
>>>
>>>  1. Which API shall we converge on: qdev or QOM? Can we come up with a
>>>     code sample(s) showing what we want object/device initialisation to
>>>     look lie? Longer term can we unify the QOM and qdev trees?
>>
>> My first question is why do we have separate qom and qdev names and trees?
>> The docs aren't very helpful. Qdev does not have a Glossary entry and only
>> a brief summary at:
>> https://www.qemu.org/docs/master/devel/qdev-api.html
>> and some confusing info in an old doc here
>> https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html
>>
>> For a long time I did not even know there was info qom-tree command in
>> monitor but I was familiar with and used info qtree. I still don't know
>> what the qom-tree is good for therefore I also don't care when creating
>> machines or devices as I never use it and don't know why I would want to
>> use it. To me it looks like some internal thing of QEMU that I don't have
>> to be concerned with. All the useful info about devices are in info qtree.
>
> The qdev tree is the older of the two. It models the buses:
> devices can own buses, and devices are (mostly) on buses. The classic
> example is something like PCI: the PCI controller device owns a PCI
> bus, and various PCI network devices etc are children of that bus.
> Reset is (currently) done by traversing the this tree.
> The qdev tree represents a real thing in the hardware we're modelling.
> (The "sysbus" is an odd thing that has all the memory-mapped devices
> on it, which is kind of broken in that a memory-mapped subcomponent
> of a PCI device is still on the "sysbus". There are also problems
> with devices that aren't on buses at all, notably the CPUs: they
> don't get reset automatically, for instance.)
>
> The QOM tree is newer, and was introduced when QOM was. It is a
> tree of ownership of objects: the machine owns all the devices it
> creates, including perhaps an SoC object; the SoC object owns all
> the devices that are its subparts (the UART, the I2C controller, etc),
> and so on. It provides a hierarchy that the qdev/qbus one cannot,
> because not all "this object owns this other object" relations
> are ones where the other object is on a bus owned by this one.
> Conversely, not all "device A is on a bus owned by device B"
> relations are "device B owns device A" ones -- consider an SoC
> with a PCI controller and a PCI device that's created via the
> command line: the PCI controller doesn't own that PCI device.
> In that "PCI device with a memory mapped subcomponent" example above,
> the memory-mapped subcomponent is a child of the PCI device in the
> QOM tree, so here QOM gets something right that the qbus tree doesn't.

This probably answers the question of this patch if we should decide the 
qom-tree path based on bus and the answer seems to be no as these are 
different things. But then what is this ownership tree used for? Maybe it 
should be more clearly defined what this ownership relation means and why 
do we want to keep track of it. It looks like it works with most devices 
being unattached so this is just some info we don't really need. In that 
case why do we want to make effort setting it?

Regards,
BALATON Zoltan

