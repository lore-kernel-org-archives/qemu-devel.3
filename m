Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 10:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzDZM-0000jb-BO; Tue, 23 Apr 2024 06:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzDZJ-0000jC-AN
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzDZH-00043h-DA
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713868805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JPHyrsfFDSxFQiWLP4yrBUx6mCRdBYySR6nbNt7QYE=;
 b=cqckrusLHxJCEHGwFCf7JOlvuSp8t58Saf38OOONLKJvAOxVlBpDshgoVF1RyhK/n86E2Y
 9Vkdwrjqa2acXc3bhbIXU8abn5NUe8SplFlcocH9Emn7xaiJBgj6Sjm6z3bWHsVHroAcRP
 NGBsrkebdyt4hfXCKFC0LcS/We9RyjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-jLJfri6AMqKT1FkaV2L5bg-1; Tue, 23 Apr 2024 06:40:01 -0400
X-MC-Unique: jLJfri6AMqKT1FkaV2L5bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1598380D6E1;
 Tue, 23 Apr 2024 10:40:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA4B112132A;
 Tue, 23 Apr 2024 10:40:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE69D21E66E5; Tue, 23 Apr 2024 12:39:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  thuth@redhat.com,
 lvivier@redhat.com,  qemu-arm@nongnu.org,  alex.bennee@linaro.org,
 pbonzini@redhat.com,  anton.kochkov@proton.me,
 richard.henderson@linaro.org,  peter.maydell@linaro.org,  Bill Mills
 <bill.mills@linaro.org>
Subject: Re: [PATCH 0/6] Add ivshmem-flat device
In-Reply-To: <a28f3657-c827-7a0d-a8da-b82d17d17577@linaro.org> (Gustavo
 Romero's message of "Mon, 22 Apr 2024 13:47:07 -0300")
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
 <87wmqp3xug.fsf@pond.sub.org>
 <a28f3657-c827-7a0d-a8da-b82d17d17577@linaro.org>
Date: Tue, 23 Apr 2024 12:39:59 +0200
Message-ID: <87sezc8irk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Markus,
>
> Thanks for interesting in the ivshmem-flat device.
>
> Bill Mills (cc:ed) is the best person to answer your question,
> so please find his answer below.
>
> On 2/28/24 3:29 AM, Markus Armbruster wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>> 
>> [...]
>> 
>>> This patchset introduces a new device, ivshmem-flat, which is similar to the
>>> current ivshmem device but does not require a PCI bus. It implements the ivshmem
>>> status and control registers as MMRs and the shared memory as a directly
>>> accessible memory region in the VM memory layout. It's meant to be used on
>>> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
>>> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
>>> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
>>> memory-constrained resource targets.
>>>
>>> The patchset includes a QTest for the ivshmem-flat device, however, it's also
>>> possible to experiment with it in two ways:
>>>
>>> (a) using two Cortex-M VMs running Zephyr; or
>>> (b) using one aarch64 VM running Linux with the ivshmem PCI device and another
>>>      arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>>>
>>> Please note that for running the ivshmem-flat QTests the following patch, which
>>> is not committed to the tree yet, must be applied:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html
>> 
>> What problem are you trying to solve with ivshmem?
>> 
>> Shared memory is not a solution to any communication problem, it's
>> merely a building block for building such solutions: you invariably have
>> to layer some protocol on top.  What do you intend to put on top of
>> ivshmem?
>
> Actually ivshmem is shared memory and bi-direction notifications (in this case a doorbell register and an irq).

Yes, ivshmem-doorbell supports interrupts.  Doesn't change my argument.

> This is the fundamental requirement for many types of communication but our interest is for the OpenAMP project [1].
>
> All the OpenAMP project's communication is based on shared memory and bi-directional notification.  Often this is on a AMP SOC with Cortex-As and Cortex-Ms or Rs.  However we are now expanding into PCIe based AMP. One example of this is an x86 host computer and a PCIe card with an ARM SOC.  Other examples include two systems with PCIe root complex connected via a non-transparent bridge.
>
> The existing PCI based ivshmem lets us model these types of systems in a simple generic way without worrying about the details of the RC/EP relationship or the details of a specific non-transparent bridge.  In fact the ivshmem looks to the two (or more) systems like a non-transparent bridge with its own memory (and no other memory access is allowed).
>
> Right now we are testing this with RPMSG between two QEMU system where both systems are cortex-a53 and both running Zephyr. [2]
>
> We will expand this by switching one of the QEMU systems to either arm64 Linux or x86 Linux.

So you want to simulate a heterogeneous machine by connecting multiple
qemu-system-FOO processes via ivshmem, correct?

> We (and others) are also working on a generic virtio transport that will work between any two systems as long as they have shared memory and bi-directional notifications.

On top of or adjacent to ivshmem?

> Now for ivshmem-flat.  We want to expand this model to include MCU like CPUs and RTOS'es that don't have PCIe.  We focus on Cortex-M because every open source RTOS has an existing port for one of the Cortex-M machines already in QEMU.  However they don't normally pick the same one.  If we added our own custom machine for this, the QEMU project would push back and even if accepted we would have to do a port for each RTOS.  This would mean we would not test as many RTOSes.
>
> The ivshmem-flat is actually a good model for what a Cortex-M based PCIe card would look like.  The host system would see the connection as PCIe but to the Cortex-M it would just appear as memory, MMR's for the doorbell, and an IRQ.
>
> So even after we have a "roll your own machine definition from a file", I expect ivshmem and ivshmem-flat to still be very useful.
>
> [1] https://www.openampproject.org/
> [2] Work in progress here: https://github.com/OpenAMP/openamp-system-reference/tree/main/examples/zephyr/dual_qemu_ivshmem


