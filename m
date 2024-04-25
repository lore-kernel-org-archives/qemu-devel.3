Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2086C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzxkZ-00022D-Nn; Thu, 25 Apr 2024 07:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzxkW-00021f-QN
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzxkU-0008BH-RH
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714046325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R+xFDk2/5ItdOF3n0v7RXkeAPsAbowKOb2jxJkaJNEc=;
 b=LMsFUfpGtdFKaExHRLD4LN8Lk0WFpZWaogw2ocTOldIAf9J6QxelxMI1DAT+29MuOB6WMG
 7j1dQlOYccYa5o2hCYU0O72n5yRGeMAn9CkkyFRGRU11895TYkNUXQCTLiuUZ38pfKlk2/
 MHSbe3fJCDYMixIEsgdojWOTfPZReDw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-DdEDqRNQN2WzslgQebEUdQ-1; Thu, 25 Apr 2024 07:58:42 -0400
X-MC-Unique: DdEDqRNQN2WzslgQebEUdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860FA18065AF;
 Thu, 25 Apr 2024 11:58:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AE481121312;
 Thu, 25 Apr 2024 11:58:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BB6D21E6680; Thu, 25 Apr 2024 13:58:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bill Mills <bill.mills@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 philmd@linaro.org,  thuth@redhat.com,  lvivier@redhat.com,
 qemu-arm@nongnu.org,  alex.bennee@linaro.org,  pbonzini@redhat.com,
 anton.kochkov@proton.me,  richard.henderson@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 0/6] Add ivshmem-flat device
In-Reply-To: <ecf04b2a-2038-43ac-a0bb-38d0baca7a7c@linaro.org> (Bill Mills's
 message of "Tue, 23 Apr 2024 12:00:50 -0400")
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
 <87wmqp3xug.fsf@pond.sub.org>
 <a28f3657-c827-7a0d-a8da-b82d17d17577@linaro.org>
 <87sezc8irk.fsf@pond.sub.org>
 <ecf04b2a-2038-43ac-a0bb-38d0baca7a7c@linaro.org>
Date: Thu, 25 Apr 2024 13:58:40 +0200
Message-ID: <87zfth4psf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Bill Mills <bill.mills@linaro.org> writes:

> Hi Markus,
>
> On 4/23/24 6:39 AM, Markus Armbruster wrote:
>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>> 
>>> Hi Markus,
>>>
>>> Thanks for interesting in the ivshmem-flat device.
>>>
>>> Bill Mills (cc:ed) is the best person to answer your question,
>>> so please find his answer below.
>>>
>>> On 2/28/24 3:29 AM, Markus Armbruster wrote:
>>>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>>>
>>>> [...]
>>>>
>>>>> This patchset introduces a new device, ivshmem-flat, which is similar to the
>>>>> current ivshmem device but does not require a PCI bus. It implements the ivshmem
>>>>> status and control registers as MMRs and the shared memory as a directly
>>>>> accessible memory region in the VM memory layout. It's meant to be used on
>>>>> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
>>>>> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
>>>>> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
>>>>> memory-constrained resource targets.
>>>>>
>>>>> The patchset includes a QTest for the ivshmem-flat device, however, it's also
>>>>> possible to experiment with it in two ways:
>>>>>
>>>>> (a) using two Cortex-M VMs running Zephyr; or
>>>>> (b) using one aarch64 VM running Linux with the ivshmem PCI device and another
>>>>>       arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>>>>>
>>>>> Please note that for running the ivshmem-flat QTests the following patch, which
>>>>> is not committed to the tree yet, must be applied:
>>>>>
>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html
>>>>
>>>> What problem are you trying to solve with ivshmem?
>>>>
>>>> Shared memory is not a solution to any communication problem, it's
>>>> merely a building block for building such solutions: you invariably have
>>>> to layer some protocol on top.  What do you intend to put on top of
>>>> ivshmem?
>>>
>>> Actually ivshmem is shared memory and bi-direction notifications (in this case a doorbell register and an irq).
>>
>> Yes, ivshmem-doorbell supports interrupts.  Doesn't change my argument.
>> 
>>> This is the fundamental requirement for many types of communication but our interest is for the OpenAMP project [1].
>>>
>>> All the OpenAMP project's communication is based on shared memory and bi-directional notification.  Often this is on a AMP SOC with Cortex-As and Cortex-Ms or Rs.  However we are now expanding into PCIe based AMP. One example of this is an x86 host computer and a PCIe card with an ARM SOC.  Other examples include two systems with PCIe root complex connected via a non-transparent bridge.
>>>
>>> The existing PCI based ivshmem lets us model these types of systems in a simple generic way without worrying about the details of the RC/EP relationship or the details of a specific non-transparent bridge.  In fact the ivshmem looks to the two (or more) systems like a non-transparent bridge with its own memory (and no other memory access is allowed).
>>>
>>> Right now we are testing this with RPMSG between two QEMU system where both systems are cortex-a53 and both running Zephyr. [2]
>>>
>>> We will expand this by switching one of the QEMU systems to either arm64 Linux or x86 Linux.
>> So you want to simulate a heterogeneous machine by connecting multiple
>> qemu-system-FOO processes via ivshmem, correct?
>
> An AMP SOC is one use case.  A PCIe card with an embedded Cortex-M would be another.
>
>> 
>>> We (and others) are also working on a generic virtio transport that will work between any two systems as long as they have shared memory and bi-directional notifications.
>> 
>> On top of or adjacent to ivshmem?
>
> On top of ivshmem.  It is not the only use case but it is an important one.

Interesting.

> I just gave a talk on this subject at EOSS.  If you would like to look at the slides they are here:
> https://sched.co/1aBFm

The talk's abstract:

    AMP Virtio: A New Virto Transport for AMP Systems, with Focus on
    Zephyr, Linux, and Xen

    Asymmetric multiprocessing systems are common in automotive,
    Industrial, and mobile markets and are entering the data center
    market as well.  The OpenAMP project strives to make AMP systems
    easier and more standards based.  The OpenAMP project is working on
    a new Virtio transport layer that can be used between cores that do
    not share a hypervisor.  Example systems include: * AMP SOCs running
    running Linux on Cortex-A and Zephyr on Cortex-M, * x86 and Arm
    systems connected via PCIe, both running Linux.  AMP Virtio can also
    be used in Xen and other hypervisors to reduce worse case latency
    and increase freedom of interference (FFI).  These aspects are
    critical in real-time and functionally safe systems.  This
    presentation will cover:
    * Why Virtio for AMP systems
    * What are the problems with the existing virtio transports for AMP
      systems
    * Outline of the transport proposal
    * Prototype software for Zephyr, Linux, and Xen
    * Show various topologies and use cases for Device and Driver
      placement
    * Show portability to other RTOSes and hypervisors.

You're interested in systems that contain multiple cores.  You want to
create a virtio transport to let these cores talk to each other.

Let's talk physical hardware.  The transport needs to go over some kind
of device.  The device could be pretty smart and provide the virtio
transport, or it could be really dumb and provide just enough to let
software running on the core implement the virtio transport.  What do
you have in mind?

You need QEMU to emulate one or more of the devices you have in mind.

Note: emulation is about the guest-facing part of the QEMU device model.
We'll get to the host-facing part in a minute.

Smart device: we know how to emulate virtio devices with various
connectors, such as PCI, CCW, MMIO.

Dumb device: ivshmem-doorbell could serve as a virtual dumb device.
Note that a physical ivshmem would be a bad idea; it's design is rather
poor.  Is this why you're interested in ivshmem?

As is, ivshmem-doorbell comes with a PCI connector.  You want an MMIO
connector.  Fair enough.

Once you have an actual dumb physical device, you're likely better off
emulating that instead of approximating it with ivshmem.

Approximating could still be useful as a stopgap.

I sidestepped an important problem so far: the "asymmetric" in AMP.
When your asymmetric system contains cores with different architectures,
QEMU can't emulate the entire system, because qemu-system-TARGET can
only emulate cores with achitecture TARGET.

I guess you want to work around this limitation by running multiple
qemu-system-TARGETs.  Trouble is you then need to connect them somehow.
ivshmem's host-facing part can connect its qemu-system-TARGET to other
processes, including other qemu-system-TARGETs, and the TARGETs need not
be identical.  Correct?

What if we had a qemu-system that wasn't limited to a single
architecture?  Would you still want to run multiple connected instances
then, or would you simply model your asymmetric system in a single one?

[...]


