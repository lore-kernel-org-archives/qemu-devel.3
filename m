Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE83C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5hi-00031l-Om; Wed, 15 Jan 2025 10:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5hg-00031L-74
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:53:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5ha-00030n-5H
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:53:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21619108a6bso123448285ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736956384; x=1737561184;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxtZLWNGp+DxEnaIF466BWA7uZAzZckEP+91dXByQ68=;
 b=qbPkg8g0aIh/DJGM+wW7urAdzFzCqXbp5uet7uvAsfmtzEEWfBlXg8cgfWMJkzYZpV
 pNLRLLTZhBVw9iyvKd6NBb5a67czRYh4NolO9Un7hp5FMzd/7HlgPCvCQlemKwGknBcu
 cpKWh3w8mR11N3Nf86OwvS6NwIWXLv8isYfZvOFTUCPBsUbycCp23Mo09paR8V2inmPd
 P7go8J7Ev8tScc/ExBoy6xCmAgqMCKMIw8HX1KUfkSDhwcYfwqLaUlESqZD5n+X/MgyC
 gW2MHvqGx3hWOY3yk+A2d3hZ6961g0Vr1ndFiq1wweUmTQ60CK5vVN1gTraxSN9nC3Bu
 5d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736956384; x=1737561184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxtZLWNGp+DxEnaIF466BWA7uZAzZckEP+91dXByQ68=;
 b=lNQ3lVa2uUJYMsGk//ynf6htmCP97+S9vzoFjN8Gu+twDErK98e240Ea/odsSOwB2l
 0wItI+JNmIDrbQfCQWJi1Gb6/Jm064OnEoMt1JPLr4k9L38BPOOKFp0PCLJhaabptBO0
 VQcVwjwXgms1Pz3hz8zjYGFSOwdORbsoOCYQTv2l4PcZKP2VGVwtvB8m3puB440udU6g
 m1mwJWZ05u4zJ5n4FVNIik6hlWRMG+GlCCYSNpjKd90Wu2h/vl2P0ZiRj8Of3S8cpnc4
 ylMbta5rvRK5iICYU4vQ57XYAMh+3AF2gQRV3zgkA67mUcaE8kZ2oadBGXCtwYGFRVLk
 fXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQEeBeyxasKYzHxPcL1tLx4HE/XQTzI/i6sJgRQL5Xu9YZgQcnh+Vhmac9obJ8mayLIEijWu0llJP@nongnu.org
X-Gm-Message-State: AOJu0YwvywGlrT3MgbSYPWPjW8g8yfd87//xguVh4+9BKd3AuEUAEv3v
 cKBsQUdYr64XdlIcJKqz7T5Vm94ERgBkLWF0lxxWeyy6PAEZ/z9VjqB9iAo+LLM=
X-Gm-Gg: ASbGnctvXzYMRWRE5hrETuVm8FsYWlXKFILRd97Z5X4EJ18b8xNiyjI2pYJx45AwguJ
 +LkaEMRDg6mWfn028Geu0eSd196OJETvjUfVXOgdlLkdxIyyxuzAWEKqywiZKgmG79/Z4MJV0RD
 PCFMjopDnst0L8CXspxaCJ8P9et5b8W/1Jm/Hl331j635kTE0pCsKSSMUPgxyGlNGsXm2Kohq0H
 wDrFha0iiTd5T9HEbTMoif9itQqNDcOYQ/kOKXnrWOfskPQSyLS9aCHQg+oTH4VgLYACbM3bKZ/
 UdeCfzfKAOeOK04VAQSMK1drpp2qxvsYQKA=
X-Google-Smtp-Source: AGHT+IGJUGXiKbCp2mkm4vFPJPbEmtaDIFd5tQJLAULlAuS82XwTTSgHxQiewb/4iOXuY9UPMyi8/A==
X-Received: by 2002:a05:6a00:2e1b:b0:729:1b8f:9645 with SMTP id
 d2e1a72fcca58-72d21feb6damr47080535b3a.24.1736956384337; 
 Wed, 15 Jan 2025 07:53:04 -0800 (PST)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406a528dsm9256495b3a.160.2025.01.15.07.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 07:53:03 -0800 (PST)
Message-ID: <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
Date: Thu, 16 Jan 2025 00:52:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com> <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com> <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com> <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com> <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com> <Z4fW_rI7Mfrtc1Fg@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4fW_rI7Mfrtc1Fg@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/01/16 0:40, Peter Xu wrote:
> On Wed, Jan 15, 2025 at 11:54:56PM +0900, Akihiko Odaki wrote:
>> On 2025/01/15 22:43, Peter Xu wrote:
>>> On Wed, Jan 15, 2025 at 01:46:29PM +0900, Akihiko Odaki wrote:
>>>> On 2025/01/15 2:02, Peter Xu wrote:
>>>>> On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
>>>>>> memory_region_finalize() is not a function to tell the owner is leaving, but
>>>>>> the memory region itself is being destroyed.
>>>>>
>>>>> It is when the lifecycle of the MR is the same as the owner.  That holds
>>>>> true I suppose if without this patch, and that's why I don't prefer this
>>>>> patch because it makes that part more complicated.
>>>>
>>>> The lifecycle of the MR is not the same as the owner. The MR gets finalized
>>>> during the finalization of the owner, and the owner is still alive at the
>>>> moment. It is something you should always care when having a child object.
>>>
>>> What is the benefit of having such explicit layering of different lifecycle
>>> between the owner and the MRs that it owns?
>>>
>>> To ask in another way, what's the functional benefit that we order the
>>> destruction of MRs within the same owner, paying that with explicit two
>>> refcounts concept in memory core?
> 
> [1]
> 
>>>
>>> AFAICT, that's the only purpose MR->refcount is servicing for in this
>>> patchset besides the property link.
>>>
>>> Currently, memory_region_ref() takes the refcount _only_ from the host.
>>> Considering that's the only memory API to take a reference on a MR, it kind
>>> of implies to everyone that the MR and the owner shares the lifetime.
>>>
>>> In reality, it's not 100% shared indeed, but almost.  We even have those
>>> document for dynamic MRs to make sure that is true even there.
>>>
>>> Then it's about the "virtual lifecycle" which triggers a finalize(), or
>>> "real lifecycle" which triggers a free() that may make a difference to a
>>> MR.  And that's the part on whether we should try to not expose too much at
>>> all on these.  I want to keep the concept simple if possible that we stick
>>> with sharing lifetime between owner and all MRs underneath.  I want to see
>>> whether we can avoid complicating that part.
>>
>> I would rather avoid virtual or real lifecycles notions because it's more
>> than free(). Memory regions constructed with functions like
>> memory_region_init_io() and memory_region_init_ram_ptr() requires the owner
>> to retain the backend resource to keep functioning. In other words, the
>> memory region refers to the owner, and that is no different from other kind
>> of references.
>>
>> The uniqueness of this relationship is that the owner also refers to the
>> memory region. Memory regions avoid a circular reference by omitting the
>> reference from them to the owner and instruct others to refer to the owner
>> instead.
>>
>>>
>>> I can see why you want to clearly separate the lifetimes, because it's
>>> cleaner to you.  But IMHO we already made a decision from that starting
>>> from when memory_region_ref() does not take MR->refcount, otherwise you
>>> should at least need something like this to make the lifecycle completely
>>> separate in your this patch:
>>>> diff --git a/system/memory.c b/system/memory.c
>>> index b17b5538ff..d4b88c389a 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -1843,15 +1843,23 @@ void memory_region_ref(MemoryRegion *mr)
>>>         * Memory regions without an owner are supposed to never go away;
>>>         * we do not ref/unref them because it slows down DMA sensibly.
>>>         */
>>> -    if (mr && mr->owner) {
>>> -        object_ref(mr->owner);
>>> +    if (mr) {
>>> +        /* The MR has its own lifecycle.. even if in most cases, virtually */
>>> +        object_ref(mr);
>>> +        if (mr->owner) {
>>> +            object_ref(mr->owner);
>>> +        }
>>>        }
>>>    }
>>>    void memory_region_unref(MemoryRegion *mr)
>>>    {
>>> -    if (mr && mr->owner) {
>>> -        object_unref(mr->owner);
>>> +    if (mr) {
>>> +        /* The MR has its own lifecycle.. even if in most cases, virtually */
>>> +        object_unref(mr);
>>> +        if (mr->owner) {
>>> +            object_unref(mr->owner);
>>> +        }
>>>        }
>>>    }
>>>
>>> To me, QEMU already went the other way.  So I sincerely don't know how that
>>> extra mr->refcount usage it could bring us.  It only makes it harder to
>>> understand to me.
>>
>> The owner refers to the memory region in turn so it is fine omitting
>> object_ref(mr).
> 
> So you decided to "sometimes" take mr->refcount because it needs to, then
> "sometimes" don't take mr->refcounts because it doesn't need to..
> 
> Normally such complexity is ok, but to me it's ok only when it services,
> for example, a major performance improvements, so that it's justified to
> add complexity.  The pay is done whoever going to maintain this code.
> 
> In this case, no, I don't yet see how important this idea is yet to
> introduce such difference into mr refcounts, which is already complicated
> as hell..  We're paying such complexity with some "technical cleanest",
> while when with different treatment of mr->refcount in different context,
> it isn't that clean either.
> 
>> If you draw an object graph that originates from the
>> referrer, you can still reach the memory region. That is not true for your
>> patch; you cannot reach to the subregion from the container.
>>
>> The separate lifetimes still matter even with your patch. In a hypothetical
>> world that the lifetime of owner and memory regions completely match, the
>> ordering of finalization of memory regions owned by one object simply does
>> not happen because they occur simultaneously. It is simply not true, and
>> even your patch does not make sense in such a hypothetical world.
> 
> I hope that's obvious goal since start, yes, that patch will make
> finalize() in any order works for MRs under the same owner, as I don't know
> why that order matters.. taking that chance of almost still sticking with
> one refcount.
> 
> I suppose you finally need to answer my above question [1] to say whether
> it makes sense.  To me, it doesn't make sense only if there's a functional
> difference on that order of finalize().

I have been discussed about semantics, not functionality and both of 
them matter.

Functionally, the ordering of container/subregion finalization matters 
if some device tries to a container during finalization. In such a case, 
removing subregions from the container at random timing can result in an 
unexpected behavior. There is little chance to have such a scenario but 
we should stay the safe side if possible.

> 
>>
>>>
>>>>
>>>>>
>>>>>> It should not happen when a container is still referencing it. That is
>>>>>> also why it has memory_region_ref(subregion) in
>>>>>> memory_region_update_container_subregions() and assert(!mr->container) in
>>>>>> memory_region_finalize().
>>>>>
>>>>> Again, the line I added was sololy for what you said "automation" elsewhere
>>>>> and only should work within MR-links within the same owner.  Otherwise
>>>>> anyone referencing the MR would hold the owner ref then this finalize()
>>>>> will never happen.
>>>>>
>>>>> Now, if I could go back to your original purpose of this work, quotting
>>>>> from your cover letter:
>>>>>
>>>>>> I saw various sanitizer errors when running check-qtest-ppc64. While
>>>>>> I could just turn off sanitizers, I decided to tackle them this time.
>>>>>>
>>>>>> Unfortunately, GLib versions older than 2.81.0 do not free test data in
>>>>>> some cases so some sanitizer errors remain. All sanitizer errors will be
>>>>>> gone with this patch series combined with the following change for GLib:
>>>>>> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
>>>>>
>>>>> Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
>>>>> mean that most of the devices will do proper removal of device-owned
>>>>> subregions (hence, not prone to circular reference of owner refcount)
>>>>> except some devices in ppc64?
>>>>>
>>>>
>>>> Searching for memory_region_add_subregion() gives 1078 instances where there
>>>> are 142 instances of memory_region_del_subregion(). This is a rough estimate
>>>> but there are potentially 936 instances of subregions without explicit
>>>> deletion.
>>>>
>>>> For example, hw/audio/intel-hda.c adds subregions immediately after their
>>>> containers never deletes the subregions. I think that's fine because their
>>>> lifetimes are obvious with reference counters.
>>>
>>> OK, let's try to figure out a best way to move forward then.
>>>
>>> Let me try to summarize the two approaches so far.
>>>
>>> So in general I think I don't prefer this patch because this patch is kind
>>> of in the middle of something.
>>>
>>> It neither provides 100% separation of MR lifecycle: as discussed above, on
>>> not referencing MR->refcount on memory_region_ref/unref at least yet so far
>>> together in this patch, but suddenly started considering it in MR links.
>>> To me, that's abuse if ordering of such finalize() is not justified.
>>>
>>> Nor it provides best efficiency: needing to take a MR->refcount when
>>> linking two MRs, even if we essentially don't need to guarded by the fact
>>> that owner must exist already, which must hold true anyway for QEMU to work
>>> so far.
>>>
>>> What I think the best is we either go one way or another: either we make MR
>>> lifecycle clearly separate, or we make it clearly efficient (meanwhile we
>>> still keep the concept easy, and we at least try to always stick with one
>>> refcount which is easier to maintain too).
>>>
>>> IMHO that's what the other older patch does (plus my fixup squashed in):
>>>
>>> https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
>>>
>>> That avoids taking a refcount for internal MRs, always stick with owner
>>> shares the same lifecycle with MRs, just like the same assumption we have
>>> already had in memory_region_ref().  The bad side effect is we need
>>> something slightly hackish in mr finalize(), but we can provide some better
>>> doc, and keep the comlexity there only (which I think is better than always
>>> having two refcounts all over).
>>
>> Again, please forget about efficiency. It does not matter and makes noises
>> in our thoughts.
> 
> It's not only about efficiency, that's pretty much side effect.
> 
> It's more about how we should define refcount in the future, then if we
> stick with owner sharing lifetime with all MRs then taking that subregion
> refcount doesn't help anything except introducing a circular reference.  It
> solves the circular reference with even a good side effect of reducing one
> atomic op from that pov, even if in a slow path.
> 
>>
>>>
>>> If we worry about removal of that container assertion, we could assert
>>> instead on the owner.  I've attached a slightly modified full version of
>>> such alternative patch below, with the best comment I see suite.
>>
>> This is better as it tells the lifetimes of memory regions need to be dealt
>> with, but why don't you deal them with reference counters in that case?
> 
> We discussed plenty in this area, obviously you don't care about keep
> having two refcounts on MRs but I do my best to avoid it.. that's all about
> it so far..
> 
>> Reference counters are tools specifically designed for this.
> 
> I hope I was trying to help.  We could wait for a 2nd opinion.
> 
>>
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index b17b5538ff..7b2d91ca6b 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -1803,7 +1803,6 @@ static void memory_region_finalize(Object *obj)
>>>    {
>>>        MemoryRegion *mr = MEMORY_REGION(obj);
>>> -    assert(!mr->container);
>>>        /* We know the region is not visible in any address space (it
>>>         * does not have a container and cannot be a root either because
>>> @@ -1813,6 +1812,17 @@ static void memory_region_finalize(Object *obj)
>>>         */
>>>        mr->enabled = false;
>>>        memory_region_transaction_begin();
>>> +    if (mr->container) {
>>> +        /*
>>> +         * If this happens, it must be when MRs share the same owner,
>>> +         * because only share-owner-ed links doesn't take a refcount.  In
>>> +         * this specific case, we allow random order of finalize() on the
>>> +         * MRs the owner owns, so it's possible the child finalize()s
>>> +         * before a parent.  When it happens, unlink from the child.
>>> +         */
>>> +        assert(mr->container->owner == mr->owner);
>>> +        memory_region_del_subregion(mr->container, mr);
>>> +    }
>>>        while (!QTAILQ_EMPTY(&mr->subregions)) {
>>>            MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
>>>            memory_region_del_subregion(mr, subregion);
>>> @@ -2644,7 +2654,15 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>>>        memory_region_transaction_begin();
>>> -    memory_region_ref(subregion);
>>> +    if (mr->owner != subregion->owner) {
>>> +        /*
>>> +         * MRs always have the same lifecycle of its owner, so that when
>>> +         * adding a subregion that shares the same owner of the parent, we
>>> +         * don't need any refcounting, because the two MRs share the
>>> +         * lifecycle with owner, so they share between each other too.
>>> +         */
>>> +        memory_region_ref(subregion);
>>> +    }
>>>        QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>>>            if (subregion->priority >= other->priority) {
>>>                QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
>>> @@ -2702,7 +2720,10 @@ void memory_region_del_subregion(MemoryRegion *mr,
>>>            assert(alias->mapped_via_alias >= 0);
>>>        }
>>>        QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
>>> -    memory_region_unref(subregion);
>>> +    /* See the corresponding comment in add subregion path */
>>> +    if (mr->owner != subregion->owner) {
>>> +        memory_region_unref(subregion);
>>> +    }
>>>        memory_region_update_pending |= mr->enabled && subregion->enabled;
>>>        memory_region_transaction_commit();
>>>    }
>>
> 


