Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXcWI-0003Dl-7a; Tue, 14 Jan 2025 03:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXcWH-0003DU-4X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:43:29 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXcWE-0004qS-22
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:43:28 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2161eb95317so91278985ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736844196; x=1737448996;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62OObn9rABlloDy5pbaTMiRCN8fEkWiG+kT5CEOiIik=;
 b=ebGTdtuvSGZ9cf2IuLYGZVy4nmCO4m+ZO6xUKLR0SHlZioD/Up1+HYwQq8M4xUaSLj
 RM7xOvpQ8/LXqA+tLoNt905T87sXx0Mmt7DUpijP1cynYZFLKlsLTdub8BGITi4pjORL
 6zuw/LYARS3yzr2GYqZy3AgGJLB6QgdIFpQd0STYpRCyLwFsusrpg31FZqwesQjteKp+
 cWqik0e0EAE8bulAPBC3dDc9RQwVvWcED3i5J1jxHyf85O7+9IVmkefR+/16OMoKyhPu
 D/wNaV8CWaQjXSF0YZu/5Rlopdtj3KbQOa/cOI0wiFPmBEj2o02ZU88/NQvIeMpaEqio
 vI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736844196; x=1737448996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62OObn9rABlloDy5pbaTMiRCN8fEkWiG+kT5CEOiIik=;
 b=ic4qxZt2Oo73anXmJ0FndDRGz+/hTioHvVENhQnvL/1zIEuf7O6bVxKEqDJV3cZqfU
 YqPRllHgdl2AiYoEVqmpN8aP6j9tVXtkRCnaCci60WVdQ8HYEdXQlSRHNBv3MBPCuwH/
 xhYHwF4GUqeUHtmiVDrCu/ij47KieHsQFZI5yP3NynkXRU+BtkX77mRBCMbVx3fCmNTO
 5x6tj02i/vX4Q8sDALm1xAbe+UFIsrBu7VlDOJ/KGO8Z4Otc/ACq0L7Vgb1J+tP340BJ
 A3wdPb1Hm4wXs+pnbaNgedFayxe1ySxQ3DWr1/aMxQnvyIeqvwn5f2FLw9dso9fCewHn
 qspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU97NLN3o8rXNI4pXdF155GwWa+hIag3n8P7n8c5cX8TFOeSNN0Uh9fflrVk7tSjTvxk2sb7ZIhTxyu@nongnu.org
X-Gm-Message-State: AOJu0YzI0TdyEPnB9xluT11MFj4Pvq7zbas49L0l8HvCSrvIaSbOh09x
 d3fpaMwlpsTEZeDeaiIQ4l1FTPC2iFudVt2x+DPn+CHBqnZKEnwt0ZzE0m7Fswk=
X-Gm-Gg: ASbGncsvYOBkaQXgAxS1GWtOawbL/JBD02YGN2A7PxzjYMiHyepBnJHAtZvaPJjnFp8
 b+xbnQoeFGYPO4P6AhJ6HuOuXQQUUhP3Zjoa37nOBP9FbhW/TqLkiaGBCULn1zmmfWEFd3sjdC2
 Tp9390Cj1fES8geLUOi4FFMQ/am9a72MICyDPfEukHQ+IWl3qDNj6+yZVdl2ArOIVlIRVQthmoT
 WMSqpdjdyU/+tiRV8grFDZlefYPL7wYBNROZ9a/5YLqowToijMoYHrmbNCeaGAspcM=
X-Google-Smtp-Source: AGHT+IEqNXVjwBlQd7bEY85eKuWcqLpq6CAwqm8hV0mUKsYoPUjWFQd6jzRiNmAuEzErA6wm2AViTw==
X-Received: by 2002:a05:6a21:6d9d:b0:1e1:a9dd:5a68 with SMTP id
 adf61e73a8af0-1e88cf7bfacmr36016688637.1.1736844196333; 
 Tue, 14 Jan 2025 00:43:16 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40567624sm6962775b3a.41.2025.01.14.00.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 00:43:15 -0800 (PST)
Message-ID: <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
Date: Tue, 14 Jan 2025 17:43:09 +0900
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
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu> <Z4AjkXbZeu3T94Y1@x1n>
 <Z4AldAcucTyqZ0HJ@x1n> <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n> <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4U30j9w1kPnKX9U@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/14 0:57, Peter Xu wrote:
> On Sat, Jan 11, 2025 at 01:15:24PM +0900, Akihiko Odaki wrote:
>> On 2025/01/11 0:18, Peter Xu wrote:
>>> On Fri, Jan 10, 2025 at 05:43:15PM +0900, Akihiko Odaki wrote:
>>>> On 2025/01/10 4:37, Peter Xu wrote:
>>>>> On Thu, Jan 09, 2025 at 02:29:21PM -0500, Peter Xu wrote:
>>>>>> On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
>>>>>>> On Thu, 9 Jan 2025, Akihiko Odaki wrote:
>>>>>>>> Do not refer to "memory region's reference count"
>>>>>>>> -------------------------------------------------
>>>>>>>>
>>>>>>>> Now MemoryRegions do have their own reference counts, but they will not
>>>>>>>> be used when their owners are not themselves. However, the documentation
>>>>>>>> of memory_region_ref() says it adds "1 to a memory region's reference
>>>>>>>> count", which is confusing. Avoid referring to "memory region's
>>>>>>>> reference count" and just say: "Add a reference to a memory region".
>>>>>>>> Make a similar change to memory_region_unref() too.
>>>>>>>>
>>>>>>>> Refer to docs/devel/memory.rst for "owner"
>>>>>>>> ------------------------------------------
>>>>>>>>
>>>>>>>> memory_region_ref() and memory_region_unref() used to have their own
>>>>>>>> descriptions of "owner", but they are somewhat out-of-date and
>>>>>>>> misleading.
>>>>>>>>
>>>>>>>> In particular, they say "whenever memory regions are accessed outside
>>>>>>>> the BQL, they need to be preserved against hot-unplug", but protecting
>>>>>>>> against hot-unplug is not mandatory if it is known that they will never
>>>>>>>> be hot-unplugged. They also say "MemoryRegions actually do not have
>>>>>>>> their own reference count", but they actually do. They just will not be
>>>>>>>> used unless their owners are not themselves.
>>>>>>>>
>>>>>>>> Refer to docs/devel/memory.rst as the single source of truth instead of
>>>>>>>> maintaining duplicate descriptions of "owner".
>>>>>>>>
>>>>>>>> Clarify that owner may be missing
>>>>>>>>
>>>>>>>> ---------------------------------
>>>>>>>> A memory region may not have an owner, and memory_region_ref() and
>>>>>>>> memory_region_unref() do nothing for such.
>>>>>>>>
>>>>>>>> memory: Clarify owner must not call memory_region_ref()
>>>>>>>> --------------------------------------------------------
>>>>>>>>
>>>>>>>> The owner must not call this function as it results in a circular
>>>>>>>> reference.
>>>>>>>>
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>>>> ---
>>>>>>>> include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
>>>>>>>> 1 file changed, 28 insertions(+), 31 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>>>>>> index 9458e2801d50..ca247343f433 100644
>>>>>>>> --- a/include/exec/memory.h
>>>>>>>> +++ b/include/exec/memory.h
>>>>>>>> @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
>>>>>>>>     * memory_region_add_subregion() to add subregions.
>>>>>>>>     *
>>>>>>>>     * @mr: the #MemoryRegion to be initialized
>>>>>>>> - * @owner: the object that tracks the region's reference count
>>>>>>>> + * @owner: the object that keeps the region alive
>>>>>>>>     * @name: used for debugging; not visible to the user or ABI
>>>>>>>>     * @size: size of the region; any subregions beyond this size will be clipped
>>>>>>>>     */
>>>>>>>> @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
>>>>>>>>                            uint64_t size);
>>>>>>>>
>>>>>>>> /**
>>>>>>>> - * memory_region_ref: Add 1 to a memory region's reference count
>>>>>>>> + * memory_region_ref: Add a reference to the owner of a memory region
>>>>>>>>     *
>>>>>>>> - * Whenever memory regions are accessed outside the BQL, they need to be
>>>>>>>> - * preserved against hot-unplug.  MemoryRegions actually do not have their
>>>>>>>> - * own reference count; they piggyback on a QOM object, their "owner".
>>>>>>>> - * This function adds a reference to the owner.
>>>>>>>> - *
>>>>>>>> - * All MemoryRegions must have an owner if they can disappear, even if the
>>>>>>>> - * device they belong to operates exclusively under the BQL.  This is because
>>>>>>>> - * the region could be returned at any time by memory_region_find, and this
>>>>>>>> - * is usually under guest control.
>>>>>>>> + * This function adds a reference to the owner of a memory region to keep the
>>>>>>>> + * memory region alive. It does nothing if the owner is not present as a memory
>>>>>>>> + * region without owner will never die.
>>>>>>>> + * For references internal to the owner, use object_ref() instead to avoid a
>>>>>>>> + * circular reference.
>>>>>>>
>>>>>>> Reading this again I'm still confused by this last sentence. Do you mean
>>>>>>> references internal to the memory region should use object_ref on the memory
>>>>>>> region or that other references to the owner should use object_ref on the
>>>>>>> owner? This sentence is still not clear about that.
>>>>>>
>>>>>> Having two refcounts are definitely confusing.. especially IIRC all MRs'
>>>>>> obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
>>>>>> its g_free() on its own.
>>>>
>>>> We still have instance_finalize that will fire when the MR's refcount gets
>>>> zero so it has its own use cases.
>>>>
>>>>>>
>>>>>> I acked both patches, but maybe it could indeed be slightly better we drop
>>>>>> this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
>>>>>> means for parent/child MRs that share the same owner, QEMU does nothing on
>>>>>> the child MRs when add subregion, because it assumes the child MR will
>>>>>> never go away when the parent is there who shares the owner.
>>>>>>
>>>>>> So maybe we try not to touch MR's refcount manually, but fix what can be
>>>>>> problematic for owner->ref only.
>>>>>
>>>>> As an attached comment: I may have forgot some context on this issue, but I
>>>>> still remember I used to have a patch that simply detach either parent or
>>>>> child MR links when finalize().  It's here:
>>>>>
>>>>> https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
>>>>>
>>>>> I see this issue was there for a long time so maybe we want to fix it one
>>>>> way or another.  I don't strongly feel which way to go, but personally I
>>>>> still prefer that way (I assume that can fix the same issue), and it
>>>>> doesn't have MR's refcount involved at all, meanwhile I don't see an issue
>>>>> yet with it..
>>>>>
>>>>
>>>> For this particular topic I have somewhat a strong opinion that we should
>>>> care the two reference counters.
>>>>
>>>> Indeed, dealing with two reference counters is not fun, but sometimes it is
>>>> necessary to do reference counting correctly. Your patch is to avoid
>>>> reference counting for tracking dependencies among regions with the same
>>>> owner, and it does so by ignoring the reference from container to subregion.
>>>
>>> I don't think so?  When with that patch, container will reference subregion
>>> the same way as others, which is to take a refcount on the owner.  That
>>> kept at least the refcount behavior consistent within memory_region_ref().
>>
>> memory_region_ref() is not the only place that is responsible for reference
>> management. memory_region_do_init() also calls object_property_add_child(),
>> which in turn calls object_ref() to create a reference from the owner to the
>> memory region. We should keep using object_ref() for object references
>> originating from the owner.
> 
> What I meant is we keep the refcount behavior consistent whenever a caller
> uses memory_region_ref(), so that we always stick with 1 refcount for 99%
> of users.
> 
> Yes, we have that property link that holds the MR's own refcount, but
> that's the whole point of what I was trying to propose: I want to keep that
> internal as of now so I hope 99% of the people may not even be aware that
> such refcount existed.  I hope people stick with using memory_region_ref()
> to refcount any MRs, then we only have 1 refcount which is the owner's.
> And that easily makes sense because the MR is part of the owner object as a
> struct field.
> 
> What your patch did is extending that single usage out to normal
> memory_region_ref() callers, which I personally not prefer.
> 
> So far if with my proposal, the property link will be a solo point where
> the owner says "ok I'm going to be destroyed, let's notify all the children
> properties" and that includes the MR.  So that my hope was mr->refcount was
> sololy for that purpose, and if for that purpose we do not need to have
> that refcount to be bigger than 1 at all and it can actually be a boolean
> saying whether the link existed.  I'm not saying that we need to change
> that to bool but I was trying to express my point, that I want to limit
> mr->refcount to minimum usage, and we stick with one refcount model by
> default, rather than spreading the "there're two refcounts" idea all over.
> I still think functionally they're identical but trying to stick with 1
> refcount is definitely easier to follow.

The advantage of my patch is it does not require further knowledge 
beyond the two reference counters. Even now, if someone is going to 
change system/memory.c, they need to know there are two reference 
counters, and that is sufficient to understand my patch too. However, if 
we add some workaround specific to subregion, they will need to 
understand the specifics of subregion as well.

> 
>>
>>>
>>> That patch removes the circular reference by always properly release the
>>> circular reference due to sub-regioning internally.
>>
>> Calling memory_region_del_subregion() is not consistent with the direction
>> of object references. A container references its subregion so the container
>> should remove references to its subregion when appropriate. A subregion
>> should not remove the reference its container holds.
> 
> Call memory_region_del_subregion() from the child says "I'm the child, now
> my owner is leaving, so I need to go".  As simple as that.  Any future
> reference to parent MR will keep working but not finding that child MR
> anymore.  I think it's like when a device is unplugged, then the device
> needs to report to its bus it's gone.  We don't have such limitation that
> because a device is under a bus so only the bus can proactively unplug it.
> The device can also decide to go or being unplugged by a human.  It's
> pretty common thing that notifications can come from bottom, no matter why
> the child needs to go.

memory_region_finalize() is not a function to tell the owner is leaving, 
but the memory region itself is being destroyed. It should not happen 
when a container is still referencing it. That is also why it has 
memory_region_ref(subregion) in 
memory_region_update_container_subregions() and assert(!mr->container) 
in memory_region_finalize().

> 
> In reality, I don't think this path is needed at all if all the owner
> properly does all subregion removals..  It's more of a safety belt.
> Because if there's a cross-device subregion, it means the owner must not
> have been released its last refcount anyway, so the owner (together with
> this child MR) must be alive.  As long as we stick with "always ref owner's
> refcount" idea with my patch, this path (of addition of my patch) can only
> happen when the subregion is on top of the owner's own parent MR.  It means
> the link is owned by the owner and if the owner (across QEMU's tree..) does
> proper removal of subregion of itself, my that path can be removed.

I really do not want owners to remove subregions manually. We should 
automate the finalization procedure as much as possible.

> 
>>
>>>
>>>>
>>>> I prefer to keep reference counting correct instead of having an additional
>>>> ad-hoc measure that breaks reference relationships.
>>>
>>> Your patch added more complexity to me on refcounting, meanwhile it's also
>>> not always "correct".  It can boil down to how you define "correct" - if
>>> you mean one should always boost a refcount somewhere if it references one
>>> MR, then it's still not 100% correct at least when mr->owner==NULL.  We
>>> never yet did it alright, so to me it's a matter of working around current
>>> sanitizer issue, and that's only about it yet so far.
>>
>> mr->owner == NULL is an exceptional case that we allow for performance
>> reasons. We have luxury to spend more time in our case.
> 
> Fair enough.  We don't need to add that into the current discussion.
> 
> But if you see, what you're doing with this patch is actually not needed
> either: when the owner of parent/child is the same, it's destined that the
> added refcount on top of mr->refcount won't help to me, because the parent
> needs to be alive first and that means the owner needs to be alive too.  In
> general, I do think any refcount within the owner object (against any of
> its own MRs as part of struct fields) do not help but waste some atomic
> cycles, there's only one makes sense which is the owner<->MR property link
> that takes the MR->refcount so far.

Let's keep the discussion away from the subtle details. The waste of 
cycles is virtually imperceptible in the slow path we are caring now.

> 
>>
>>>
>>> Meanwhile I _think_ adding such complexity also means MR's finalize() will
>>> be called in specific order when parent/child MRs belong to the same owner.
>>> In my patch the order shouldn't matter, IIUC, which I preferred because
>>> that reduces details that we may not care much (or I could have overlooked
>>> why we need to care about it).  Basically that's simpler to maintain to me,
>>> but again, I don't feel strongly until someone would like / be able to
>>> rework MR refcounting completely.
>>
>> We need to take care of the semantics of subregion. A container needs its
>> subregions to satisfy accesses to the memory it represents. So it refers to
>> the subregions, and the reference must keep the subregions alive; that's why
>> we must keep the ordering.
> 
> Again, we're only talking about when owner is the same between
> parent/child.  I don't think that order matters, then, because in that case
> as long as the parent MR is alive, owner and child MR must alive.
 > > To me, it's still easier we always take a refcount on the owner 
whenever we
> want to take a reference on a MR (except the only case of owner<->MR
> property link), it is still easy to understand when there's the struct
> field relationship between the owner and the MRs under it.  When taking
> MR->refcount into the picture of memory_region_ref(), it's much harder to
> understand and it's much harder to define what is MR->refcount.

You should take MR->refcount into the picture of memory_region_ref(). 
Otherwise you will not understand why memory regions get finalized 
during the finalization of the owner. The understanding of the timing is 
essential to understand why your patch is necessary too.

I have no idea to save people from the trouble of understanding the 
owner and memory region objects when dealing with references and 
finalization.

> 
> So I mentioned that I can ACK this patch, but only because it looks like no
> one yet agree with me, and I also agree at least with you that we should
> still fix it first when there's no quorum.  I'm ok merging this one because
> the changeset is small - worst case is whoever rework refcount can revert
> it.  But again, that's not my preference, and I'm not convinced this is
> better..
> 
> Thanks,
> 


