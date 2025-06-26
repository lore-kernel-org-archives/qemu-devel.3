Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2BBC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 12:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUlPn-0005oH-PA; Thu, 26 Jun 2025 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUlPl-0005ny-Gd
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUlPi-0003I3-LH
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750939745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGiikhQc6BjXOvur+q0gNphqtYKl4iRq/TkbBUP+fLw=;
 b=L9GHr96Ynp5wdOqgJuuch/veE/uk8y8Yw1rdy7m95QyElgn90nzeBTLTXDU+IWP+vKt68O
 cH+CXtI/bC95JrORipmqkn391YUiaVUk6NUf9waju7LExIGLNWnLMcJLN1Pks8Dwfvlef+
 DdUEFLe/1Lj75VLq0TUrriuClmvfmbk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-GxHYYhvuPy-_cZvynP0M7A-1; Thu,
 26 Jun 2025 08:09:01 -0400
X-MC-Unique: GxHYYhvuPy-_cZvynP0M7A-1
X-Mimecast-MFC-AGG-ID: GxHYYhvuPy-_cZvynP0M7A_1750939739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B281933FB8; Thu, 26 Jun 2025 12:08:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA11118002B6; Thu, 26 Jun 2025 12:08:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3ED7021E6A27; Thu, 26 Jun 2025 14:08:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  qemu-devel@nongnu.org,
 eperezma@redhat.com,  peterx@redhat.com,  mst@redhat.com,
 lvivier@redhat.com,  dtatulea@nvidia.com,  leiyang@redhat.com,
 parav@mellanox.com,  sgarzare@redhat.com,  lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com,  Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com> (Jonah Palmer's
 message of "Fri, 6 Jun 2025 12:21:59 -0400")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
Date: Thu, 26 Jun 2025 14:08:56 +0200
Message-ID: <87o6uau2lj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Jonah Palmer <jonah.palmer@oracle.com> writes:

> On 6/2/25 4:29 AM, Markus Armbruster wrote:
>> Butterfingers...  let's try this again.
>>
>> Markus Armbruster<armbru@redhat.com> writes:
>>
>>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>>
>>>> On 5/26/2025 2:16 AM, Markus Armbruster wrote:
>>>>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>>>>
>>>>>> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>>>>>>> Jason Wang<jasowang@redhat.com> writes:
>>>>>>>
>>>>>>>> On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer<jonah.palmer@o=
racle.com> wrote:
>>>>>>>>> Current memory operations like pinning may take a lot of time at =
the
>>>>>>>>> destination.  Currently they are done after the source of the mig=
ration is
>>>>>>>>> stopped, and before the workload is resumed at the destination.  =
This is a
>>>>>>>>> period where neigher traffic can flow, nor the VM workload can co=
ntinue
>>>>>>>>> (downtime).
>>>>>>>>>
>>>>>>>>> We can do better as we know the memory layout of the guest RAM at=
 the
>>>>>>>>> destination from the moment that all devices are initializaed.  So
>>>>>>>>> moving that operation allows QEMU to communicate the kernel the m=
aps
>>>>>>>>> while the workload is still running in the source, so Linux can s=
tart
>>>>>>>>> mapping them.
>>>>>>>>>
>>>>>>>>> As a small drawback, there is a time in the initialization where =
QEMU
>>>>>>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>>>>>>> 0.2seconds.
>>>>>>>> Adding Markus to see if this is a real problem or not.
>>>>>>> I guess the answer is "depends", and to get a more useful one, we n=
eed
>>>>>>> more information.
>>>>>>>
>>>>>>> When all you care is time from executing qemu-system-FOO to guest
>>>>>>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>>>>>>> won't matter much.
>>>>>> There's no such delay of an extra 0.2s or higher per se, it's just s=
hifting around the page pinning hiccup, no matter it is 0.2s or something e=
lse, from the time of guest booting up to before guest is booted. This save=
s back guest boot time or start up delay, but in turn the same delay effect=
ively will be charged to VM launch time. We follow the same model with VFIO=
, which would see the same hiccup during launch (at an early stage where no=
 real mgmt software would care about).
>>>>>>
>>>>>>> When a management application runs qemu-system-FOO several times to
>>>>>>> probe its capabilities via QMP, then even milliseconds can hurt.
>>>>>>>
>>>>>> Not something like that, this page pinning hiccup is one time only t=
hat occurs in the very early stage when launching QEMU, i.e. there's no con=
sistent delay every time when QMP is called. The delay in QMP response at t=
hat very point depends on how much memory the VM has, but this is just spec=
if to VM with VFIO or vDPA devices that have to pin memory for DMA. Having =
said, there's no extra delay at all if QEMU args has no vDPA device assignm=
ent, on the other hand, there's same delay or QMP hiccup when VFIO is aroun=
d in QEMU args.
>>>>>>
>>>>>>> In what scenarios exactly is QMP delayed?
>>>>>> Having said, this is not a new problem to QEMU in particular, this Q=
MP delay is not peculiar, it's existent on VFIO as well.
>>>>>
>>>>> In what scenarios exactly is QMP delayed compared to before the patch?
>>>>
>>>> The page pinning process now runs in a pretty early phase at
>>>> qemu_init() e.g. machine_run_board_init(),
>>>
>>> It runs within
>>>
>>>      qemu_init()
>>>          qmp_x_exit_preconfig()
>>>              qemu_init_board()
>>>                  machine_run_board_init()
>>>
>>> Except when --preconfig is given, it instead runs within QMP command
>>> x-exit-preconfig.
>>>
>>> Correct?
>>>
>>>> before any QMP command can be serviced, the latter of which typically
>>>> would be able to get run from qemu_main_loop() until the AIO gets
>>>> chance to be started to get polled and dispatched to bh.
>>>
>>> We create the QMP monitor within qemu_create_late_backends(), which runs
>>> before qmp_x_exit_preconfig(), but commands get processed only in the
>>> main loop, which we enter later.
>>>
>>> Correct?
>>>
>>>> Technically it's not a real delay for specific QMP command, but rather
>>>> an extended span of initialization process may take place before the
>>>> very first QMP request, usually qmp_capabilities, will be
>>>> serviced. It's natural for mgmt software to expect initialization
>>>> delay for the first qmp_capabilities response if it has to immediately
>>>> issue one after launching qemu, especially when you have a large guest
>>>> with hundred GBs of memory and with passthrough device that has to pin
>>>> memory for DMA e.g. VFIO, the delayed effect from the QEMU
>>>> initialization process is very visible too.
>>
>> The work clearly needs to be done.  Whether it needs to be blocking
>> other things is less clear.
>>
>> Even if it doesn't need to be blocking, we may choose not to avoid
>> blocking for now.  That should be an informed decision, though.
>>
>> All I'm trying to do here is understand the tradeoffs, so I can give
>> useful advice.
>>
>>>>                                              On the other hand, before
>>>> the patch, if memory happens to be in the middle of being pinned, any
>>>> ongoing QMP can't be serviced by the QEMU main loop, either.
>>
>> When exactly does this pinning happen before the patch?  In which
>> function?
>
> Before the patches, the memory listener was registered in
> vhost_vdpa_dev_start(), well after device initialization.
>
> And by device initialization here I mean the
> qemu_create_late_backends() function.
>
> With these patches, the memory listener is now being
> registered in vhost_vdpa_set_owner(), called from
> vhost_dev_init(), which is part of the device
> initialization phase.
>
> However, even though the memory_listener_register() is
> called during the device initialization phase, the actual
> pinning happens (very shortly) after
> qemu_create_late_backends() returns (due to RAM being
> initialized later).
>
> ---
>
> So, without these patches, and based on my measurements,
> memory pinning starts ~2.9s after qemu_create_late_backends()
> returns.
>
> With these patches, memory pinning starts ~0.003s after
> qemu_create_late_backends() returns.

So, we're registering the memory listener earlier, which makes it do its
expensive work (pinning) earlier ("very shortly after
qemu_create_late_backends()).  I still don't understand where exactly
the pinning happens (where at runtime and where in the code).  Not sure
I have to.

>>>> I'd also like to highlight that without this patch, the pretty high
>>>> delay due to page pinning is even visible to the guest in addition to
>>>> just QMP delay, which largely affected guest boot time with vDPA
>>>> device already. It is long standing, and every VM user with vDPA
>>>> device would like to avoid such high delay for the first boot, which
>>>> is not seen with similar device e.g. VFIO passthrough.
>>
>> I understand that hiding the delay from the guest could be useful.
>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>> You told us an absolute delay you observed.  What's the relative de=
lay,
>>>>>>> i.e. what's the delay with and without these patches?
>>>>>
>>>>> Can you answer this question?
>>>>
>>>> I thought I already got that answered in earlier reply. The relative
>>>> delay is subject to the size of memory. Usually mgmt software won't be
>>>> able to notice, unless the guest has more than 100GB of THP memory to
>>>> pin, for DMA or whatever reason.
>>
>> Alright, what are the delays you observe with and without these patches
>> for three test cases that pin 50 / 100 / 200 GiB of THP memory
>> respectively?
>
> So with THP memory specifically, these are my measurements below.
> For these measurements, I simply started up a guest, traced the
> vhost_vdpa_listener_region_add() calls, and found the difference
> in time between the first and last calls. In other words, this is
> roughly the time it took to pin all of guest memory. I did 5 runs
> for each memory size:
>
> Before patches:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 50G:   7.652s,  7.992s,  7.981s,  7.631s,  7.953s (Avg.  7.841s)
> 100G:  8.990s,  8.656s,  9.003s,  8.683s,  8.669s (Avg.  8.800s)
> 200G: 10.705s, 10.841s, 10.816s, 10.772s, 10.818s (Avg. 10.790s)
>
> After patches:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 50G:  12.091s, 11.685s, 11.626s, 11.952s, 11.656s (Avg. 11.802s)
> 100G: 14.121s, 14.079s, 13.700s, 14.023s, 14.130s (Avg. 14.010s)
> 200G: 18.134s, 18.350s, 18.387s, 17.800s, 18.401s (Avg. 18.214s)
>
> The reason we're seeing a jump here may be that with the memory
> pinning happening earlier, the pinning happens before Qemu has
> fully faulted in the guest's RAM.
>
> As far as I understand, before these patches, by the time we
> reached vhost_vdpa_dev_start(), all pages were already resident
> (and THP splits already happened with the prealloc=3Don step), so
> get_user_pages() pinned "warm" pages much faster.
>
> With these patches, the memory listener is running on cold memory.
> Every get_user_pages() call would fault in its 4KiB subpage (and
> if THP was folded, split a 2MiB hugepage) before handing in a
> 'struct page'.

Let's see whether I understand...  Please correct my mistakes.

Memory pinning takes several seconds for large guests.

Your patch makes pinning much slower.  You're theorizing this is because
pinning cold memory is slower than pinning warm memory.

I suppose the extra time is saved elsewhere, i.e. the entire startup
time remains roughly the same.  Have you verified this experimentally?

Your stated reason for moving the pinning is moving it from within
migration downtime to before migration downtime.  I understand why
that's useful.

You mentioned "a small drawback [...] a time in the initialization where
QEMU cannot respond to QMP".  Here's what I've been trying to figure out
about this drawback since the beginning:

* Under what circumstances is QMP responsiveness affected?  I *guess*
  it's only when we start a guest with plenty of memory and a certain
  vhost-vdpa configuration.  What configuration exactly?

* How is QMP responsiveness affected?  Delay until the QMP greeting is
  sent?  Delay until the first command gets processed?  Delay at some
  later time?

* What's the absolute and the relative time of QMP non-responsiveness?
  0.2s were mentioned.  I'm looking for something like "when we're not
  pinning, it takes 0.8s until the first QMP command is processed, and
  when we are, it takes 1.0s".

> I believe this to be the case since in my measurements I noticed
> some larger time gaps (fault + split overhead) in between some of
> the vhost_vdpa_listener_region_add() calls.
>
> However I'm still learning some of these memory pinning details,
> so please let me know if I'm misunderstanding anything here.

Thank you!

[...]


