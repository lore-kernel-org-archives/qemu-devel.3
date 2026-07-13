Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAO2-00048f-4K; Mon, 13 Jul 2026 02:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjANy-00047s-4G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjANu-0002hj-So
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783925001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9vYIB74rM68BpOWfIuu0QmU0qqoQaQGhMQ6kywzOWY=;
 b=AD9b5Fwy92AnWT3xd7GBIbq7pUZr/++dyi14Uc5KchOpmqVc/7YZhvBr408LedarsvoQ2o
 Xdo+tZQHrZyjyMX6vPk5h/aANAnyGMBeifXA/qgyJeMdGfB3M8W+UY6F9OedS8Yl+MVAQ+
 8Bd2slgysq4UbY9d3tr07R9G+g/7EY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-fBD_d9cYOBC8fv5i4lp8mw-1; Mon,
 13 Jul 2026 02:43:18 -0400
X-MC-Unique: fBD_d9cYOBC8fv5i4lp8mw-1
X-Mimecast-MFC-AGG-ID: fBD_d9cYOBC8fv5i4lp8mw_1783924993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0844118009EF; Mon, 13 Jul 2026 06:43:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5BB830001A1; Mon, 13 Jul 2026 06:43:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4564C21E6920; Mon, 13 Jul 2026 08:43:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  Aditya Gupta <adityag@linux.ibm.com>,  Alexander
 Graf <graf@amazon.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Alexey
 Kardashevskiy <aik@ozlabs.ru>,  Alistair Francis
 <Alistair.Francis@wdc.com>,  Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Bernhard Beschow <shentey@gmail.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Chao
 Liu <chao.liu@processmission.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  =?utf-8?Q?Cl=C3=A9ment?= Chigot
 <chigot@adacore.com>,  =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@kaod.org>,  Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Eric Farman
 <farman@linux.ibm.com>,  Farhan Ali <alifm@linux.ibm.com>,  Felipe Balbi
 <balbi@kernel.org>,  Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,  Gaurav Sharma
 <gaurav.sharma_7@nxp.com>,  Gautam Gala <ggala@linux.ibm.com>,  Glenn
 Miles <milesg@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,  Hao Wu
 <wuhaotsh@google.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Helge
 Deller <deller@gmx.de>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,  Huacai Chen
 <chenhuacai@kernel.org>,  Jan Kiszka <jan.kiszka@web.de>,  Jared Rossi
 <jrossi@linux.ibm.com>,  Joel Stanley <joel@jms.id.au>,  Laurent Vivier
 <laurent@vivier.eu>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,  Michael Rolnik <mrolnik@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Niek Linnenbank <nieklinnenbank@gmail.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@mailo.com>,  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ran Wang <wangran@bosc.ac.cn>,  Richard Henderson
 <richard.henderson@linaro.org>,  Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>,  Samuel Tardieu <sam@rfc1149.net>,  Sergio
 Lopez <slp@redhat.com>,  Song Gao <17746591750@163.com>,  Stafford Horne
 <shorne@gmail.com>,  Subbaraya Sundeep <sundeep.lkml@gmail.com>,  Thomas
 Huth <th.huth+qemu@posteo.eu>,  Tyrone Ting <kfting@nuvoton.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: Call to clean up QOM onboard devices lacking a parent
In-Reply-To: <69d31293-b6db-a411-141b-234c7d823bbe@eik.bme.hu> (BALATON
 Zoltan's message of "Fri, 10 Jul 2026 14:13:13 +0200 (CEST)")
References: <87se5scipx.fsf@pond.sub.org>
 <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
 <87a4rzxr1q.fsf@pond.sub.org>
 <69d31293-b6db-a411-141b-234c7d823bbe@eik.bme.hu>
Date: Mon, 13 Jul 2026 08:43:04 +0200
Message-ID: <874ii3wft3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Fri, 10 Jul 2026, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> On Thu, 9 Jul 2026, Markus Armbruster wrote:
>>>> A QOM object must be the child of exactly one parent.  This defines the
>>>> QOM composition tree.  The link from parent to child is a property of
>>>> the parent, and therefore has a name that is unique within its parent.
>>>> An object's canonical QOM path is these names on the path from root to
>>>> object in the QOM composition tree separated by '/'.
>>>>
>>>> For devices:
>>>>
>>>> * If a device is plugged in with -device / device_add, and it has an ID,
>>>>   we make it a child of /machine/peripheral/ with name ID.  If it
>>>>   doesn't have an ID, we make it a child of /machine/peripheral-anon/
>>>>   with name device[N], where N counts up from zero.  The canonical QOM
>>>>   path /machine/peripheral/ID is stable.  The canonical QOM path
>>>>   /machine/peripheral-anon/device[N] isn't: it depends on the number of
>>>>   devices already there.
>>>>
>>>> * If a device is part of another device, it should be its child.  The
>>>>   child's canonical QOM path is the parent's plus '/CHILD-NAME'.  Stable
>>>>   as long as the parent's path and the child name are.
>>>>
>>>> * "Should" because we have a lot of code that fails to pick the parent.
>>>>   When such a device gets realized, we make it a child of
>>>>   /machine/unattached/ orphanage with name device[N], where N counts up
>>>>   from zero.  The canonical QOM path /machine/unattached/device[N]
>>>>   depends on the number of children already in the orphanage, which
>>>>   makes it unstable.
>>>>
>>>>   Letting code get away with not picking a parent was a mistake.  I
>>>>   guess it "saved" us some thinking about what's part of what when
>>>>   converting existing devices to QOM.  In other words, it enabled sloppy
>>>>   hardware modeling.  We've been "saving" thinking ever since.
>>>>
>>>>   I want /machine/unattached/ to be empty.  If an onboard device isn't
>>>>   part of another device, put it into /machine/ with a sensible name.
>>>
>>> The last time this came up I've asked a few questions but did not get an answer:
>>>
>>> 1. What's the use of the QOM composition tree? I never needed it and apart from being able to admire it in info qom-tree I don't know if it's used for anything. For a long time I did not even know about info qom-tree because I only needed info qtree and info mtree and rarely if ever need to look at the qom-tree. If it has no real use I'm happy to not think about it.
>>>
>>> 2. What is a QOM parent? There were proposals to parent devices to their bus if they have any, that's what qtree shows anyway. If it's something else it should be better defined somewhere.
>>>
>>> Without getting answers for these questions I don't think I'm able to fix the machines I maintain.
>>
>> Unfortunately, I don't have the time to teach a class on QOM basics
>> today.  The text you quoted explains what QOM parent and canonical QOM
>> path are, albeit briefly.  It also explains how to pick the QOM parent
>> properly, what happens when you neglect to pick one, and why that's
>> undesirable.  I'm going to elaborate a bit.
>
> I read that text but understood it describes what is done now and missed the part where it says how to pick a parent.
>
>> A fully constructed QOM object is part of the QOM composition tree.
>> This is a fundamental property of QOM's design.
>>
>> A QOM object can be composed of sub-objects.  Its sub-objects are its
>> children in the composition tree.  That's why it's named *composition*
>> tree.
>
> OK so this is clear for a SoC or a multifunction device where we mostly do that now, for example hw/isa/vt82c686.c has object_initialize_child for its parts (which is the only reason we need an init method and could do without it otherwise). For PPC460EX we don't model the SoC as this is old code that was cleaned up a bit but never completed to convert everything so the machine still creates the SoC parts and wires them as a lot of older machines did. I intended to improve the PCIe emulation on sam460ex and clean up that part during that but haven't got to it yet. I guess other devices like isa have the same problem that they predate even QOM so was not fully converted yet.

Yes, many of the early conversions were superficial.

Once problematic code exists, it gets imitated.  We shouldn't blame the
victims.

> What should own sysbus devices? The machine? Or is it the bus which owns the devices connected to it?

If the sysbus device is part of another device, it should be below it in
the composition tree.  Whether to connect it directly or via its bus is
arguably a matter of taste.  Would be nice if we could agree on a
convention there.

If it's not part of another device (say a chip soldered onto the
mainboard), then put it into /machine with a sensible name.

> Another problem is that machines usually use convenience functions to create devices such as sysbus_create_simple and pci_create_simple so if these devices need to be attached to the machine then these convenience functions should take care of that not the board code. It's rare that a device does object_new or object_initialize to get a device and it would be inconvenient to then cast the result to object and parent it somewhere where the functions that created the device could do this.

Alex Graf just posted RFC patches "qom: Make composition-tree parenting
mandatory".  I haven't hat a chance to examine them, but patch titles
suggest the series takes care of that.

>> Canonical QOM paths are visible at external interfaces both as input and
>> as output.  A few quick examples:
>>
>> * QMP command query-cpus-fast reports a CPU's canonical QOM path.  For
>>   some machines, we get something like "/machine/unattached/device[0]".
>>   Fine as long as the client treats it as an opaque handle.  For other
>>   machines, we get something like "/machine/soc/cpu", which is clearly
>>   better.
>
> As you say does not matter what is it called if it's just a handle.

True!  Still, nice names help humans with debugging and such.  We should
go for them whenever practical.

>> * Error messages use canonical QOM paths to identify devices.  With
>>   properly modeled hardware, these paths are actually helpful for
>>   humans.  Something like "/machine/unattached/device[7]" not so much.
>
> Never seen such error message. Usually errors also say what device it is from so usually straightforward to know where it comes from.

Such error messages definitely exist.  Random pick,
hw/net/can/flexcan.c:

            error_setg(errp, "%s: flexcan_connect_to_bus failed",
                       dev->canonical_path);

Many trace points and log entries show canonical QOM paths, too.

>> * QMP command device-sync-config accepts a QOM path argument.  With
>>   properly modeled hardware, you can use a stable canonical QOM path.
>>   But when the device is in the /machine/unattached orphanage, its
>>   canonical QOM path is unstable.  A client has to first search the
>>   orphanage to find today's path.
>
> Never needed to use device-sync-config. It's not even documented at https://www.qemu.org/docs/master/system/monitor.html#qemu-monitor so I have no idea what this command does. Found some info here:
> https://www.qemu.org/docs/master/devel/qdev-api.html but I don't know about any device implementing that so it's probably a rare thing.

To learn what a QMP command does, start with the "QEMU QMP Reference
Manual".  All commands are documented there, or else QEMU fails to
build.  Can't enforce the documentation to be *good*, though.  So if you
find something that's bad, post a patch or file a bug.

If my point was "device-sync-config needs this", an argument "who cares
for device-sync-config" could perhaps be made.  It is not.  My point is
that canonical QOM paths are part of external interfaces *by design*.
device-sync-config is merely the first example I found for use of QOM
paths in QMP input.

>> Further questions?
>
> Basically the question was why should I think about this if things work now and nobody complained about it so it looked like it just bothers you that there are some unparented objects that could be put in some other category, but it's not a real issue for any common problem other than esthetics. I'm OK with solving that within QOM or qdev or somewhere where I don't have to think about it when writing board code. Imposing it on the board code looks like additional complexity and yet another thing to confuse new people trying to create a machine so unless there's a good reason to require that I'd do without it.
>
> Where are stable QOM paths needed?

Once again: they are part of external interfaces.

> If you can't predict them and still need to query it first then it likely does not matter what is the path as it's just used to query and refer to a device as a handle so in that case we may just forget the path hierarchy and make it flat and that would also solve your issue with unparented devices.

That's not how QOM works.

You are welcome to propose a redesign of QOM.


