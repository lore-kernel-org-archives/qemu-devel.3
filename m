Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAD8D43341
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90R4-0006mH-D9; Thu, 07 Nov 2024 06:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t90R1-0006m0-UB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t90R0-00037z-9O
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730977936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2wqDeV1Qpz0fvd9HvyBAYczWy3MVuSZhQJP7XT82CU=;
 b=AJ0EJjR0umZCjVgSiwvS+TjLYh9c/NOCjhL7vZLge7wVnD3zXLzms9gOmKFC019JR7E3K2
 kWk3YU+916nvTw1O36pcPyvVjBcz6S1qGnoyRrkYQ6RP4JPSM+qADXVolFn/z17COeTdKL
 z88YiJmHMdWXgH0eC3kAKzOEcTMJ5w8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-2J1LqFMTP92C6ZSvY75EDg-1; Thu,
 07 Nov 2024 06:12:15 -0500
X-MC-Unique: 2J1LqFMTP92C6ZSvY75EDg-1
X-Mimecast-MFC-AGG-ID: 2J1LqFMTP92C6ZSvY75EDg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14BD719560B8; Thu,  7 Nov 2024 11:12:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78276195E480; Thu,  7 Nov 2024 11:12:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4AE6F21E6A28; Thu,  7 Nov 2024 12:12:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Igor Mammedov
 <imammedo@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
In-Reply-To: <ZxwYBeLGDLkTL0PJ@x1n> (Peter Xu's message of "Fri, 25 Oct 2024
 18:13:25 -0400")
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
 <87jzdwlekc.fsf@pond.sub.org> <ZxwT79JG0NzsDmPn@x1n>
 <ZxwYBeLGDLkTL0PJ@x1n>
Date: Thu, 07 Nov 2024 12:12:10 +0100
Message-ID: <87jzdfl2lx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Oct 25, 2024 at 05:55:59PM -0400, Peter Xu wrote:
>> On Fri, Oct 25, 2024 at 11:25:23AM +0200, Markus Armbruster wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> > 
>> > > X86 IOMMUs cannot be created more than one on a system yet.  Make it a
>> > > singleton so it guards the system from accidentally create yet another
>> > > IOMMU object when one already presents.
>> > >
>> > > Now if someone tries to create more than one, e.g., via:
>> > >
>> > >   ./qemu -M q35 -device intel-iommu -device intel-iommu
>> > >
>> > > The error will change from:
>> > >
>> > >   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
>> > >
>> > > To:
>> > >
>> > >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
>> > >
>> > > Unfortunately, yet we can't remove the singleton check in the machine
>> > > hook (pc_machine_device_pre_plug_cb), because there can also be
>> > > virtio-iommu involved, which doesn't share a common parent class yet.
>> > >
>> > > But with this, it should be closer to reach that goal to check singleton by
>> > > QOM one day.
>> > >
>> > > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > 
>> > $ qemu-system-x86_64 -device amd-iommu,help
>> > /work/armbru/qemu/include/hw/boards.h:24:MACHINE: Object 0x56473906f960 is not an instance of type machine
>> > Aborted (core dumped)

[...]

>> Thanks for the report!
>> 
>> It turns out that qdev_get_machine() cannot be invoked too early, and the
>> singleton code can make it earlier..
>> 
>> We may want a pre-requisite patch to allow qdev_get_machine() to be invoked
>> anytime, like:
>> 
>> ===8<===
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index db36f54d91..7ceae47139 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -831,6 +831,16 @@ Object *qdev_get_machine(void)
>>  {
>>      static Object *dev;
>>  
>> +    if (!phase_check(PHASE_MACHINE_CREATED)) {
>> +        /*
>> +         * When the machine is not created, below can wrongly create
>> +         * /machine to be a container.. this enables qdev_get_machine() to
>> +         * be used at any time and return NULL properly when machine is not
>> +         * created.
>> +         */
>> +        return NULL;
>> +    }
>> +
>>      if (dev == NULL) {
>>          dev = container_get(object_get_root(), "/machine");
>>      }
>> ===8<===
>> 
>> I hope it makes sense on its own.
>
> My apologies, spoke too soon here.  This helper is used too after machine
> is created, but right before switching to PHASE_MACHINE_CREATE stage..

container_get() is a trap.

When the object to be gotten is always "container", it merely
complicates container creation: it's implicitly created on first get.
Which of the calls creates may be less than obvious.

When the object to be gotten is something else, such as a machine,
container_get() before creation is *wrong*, and will lead to trouble
later.

In my opinion:

* Hiding creation in getters is a bad idea unless creation has no
  material side effects.

* Getting anything but a container with container_get() is in bad taste.


> So we need another way, like:
>
> ===8<===
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index db36f54d91..36a9fdb428 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -832,7 +832,13 @@ Object *qdev_get_machine(void)
>      static Object *dev;
>  
>      if (dev == NULL) {
> -        dev = container_get(object_get_root(), "/machine");
> +        /*
> +         * NOTE: dev can keep being NULL if machine is not yet created!
> +         * In which case the function will properly return NULL.
> +         *
> +         * Whenever machine object is created and found once, we cache it.
> +         */
> +        dev = object_resolve_path_component(object_get_root(), "machine");
>      }
>  
>      return dev;

Now returns null instead of a bogus container when called before machine
creation.  Improvement of sorts.  But none of the callers expect null...
shouldn't we assert(dev) here?

Hmm, below you add a caller that checks for null.

Another nice mess.

> ===8<===
>
> The idea is still the same.  Meanwhile I'll test more to see whether it has
> other issues.
>
> Thanks,
>
>> Then callers who can be invoked earlier
>> could then handle NULL properly, in this case..
>> 
>> ===8<===
>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
>> index 4bfeb08705..fceb7adfe0 100644
>> --- a/hw/i386/x86-iommu.c
>> +++ b/hw/i386/x86-iommu.c
>> @@ -80,9 +80,15 @@ void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
>>  
>>  X86IOMMUState *x86_iommu_get_default(void)
>>  {
>> -    MachineState *ms = MACHINE(qdev_get_machine());
>> -    PCMachineState *pcms =
>> -        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
>> +    Object *machine = qdev_get_machine();
>> +    PCMachineState *pcms;
>> +
>> +    /* If machine has not been created, so is the vIOMMU */
>> +    if (!machine) {
>> +        return NULL;
>> +    }
>> +
>> +    pcms = PC_MACHINE(object_dynamic_cast(machine, TYPE_PC_MACHINE));
>>  
>>      if (pcms &&
>>          object_dynamic_cast(OBJECT(pcms->iommu), TYPE_X86_IOMMU_DEVICE)) {
>> ===8<===
>> 
>> I'll make sure this works if I'll repost.
>> 
>> Thanks,
>> 
>> -- 
>> Peter Xu


