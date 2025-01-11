Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C90E7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 04:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWSuT-0005zw-Ij; Fri, 10 Jan 2025 23:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWSuP-0005zJ-Hw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 23:15:37 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWSuL-00078k-VG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 23:15:36 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so4404286a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 20:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736568932; x=1737173732;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2SXN9gQHTz1bX8NLnUkBiqFYesqGRs/l6/R7Cdug1aI=;
 b=2FBvejzRLwmgMMFsmmN0e05HTqVd4g8i6aZmGYlV2+SHSUXehe9nzpsXXlAzCpZX5X
 Yk2OW+FSFgoeZM2Jj3Vr0kIJGv7RabujrvYScmv9HBelibs/7mIUeTctAYHKg1IyFHON
 smHQCH9NacA1lb8g+2tRc7XnCBJCTvpHCp8hbu+39TUC6qQ3H+ui/8pAgt2OiJGApz/A
 c7q9/7eEKjUGQatHkTX68FdJnHIP6tSggFpNkSant4Ux4pU1J7NTw++twHIMK1POHnEX
 G9pnU2yXepTJIHJUcaDSkVBYMbMRE5ARPjXsKuu8AvRlvvyLePX9wXOoeU9ZPTjZTN2N
 15+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736568932; x=1737173732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SXN9gQHTz1bX8NLnUkBiqFYesqGRs/l6/R7Cdug1aI=;
 b=Bx5JYTG9iWrUHYGGT0hEIIotOHtugvNCmSFSMK7Jq9kVwSdZfASdhk7vXJNVnJNJvk
 sxr7y6rAyQwEcBC757vXd3T2wLH54XZm4d1hLC/gsU8JCedx4KTXwsgK5U1cTbQiKrOV
 6B0DsDafXfwo1t8z4Chh+DjphOHcIFmoQH+Gl3qPmwLdzBk1UNUJ15khlVbji2ULo2MO
 2UOZNWeS21zVH090yG21nnqbJDcHCuopeWf5n0e0/6Hb66paxAchuwuLeGIKtJ7c1ial
 IPbQutCJCFpqd8QKua3asvzMXxwYcZduLlerqjNRb2nGjkYDOd7nRwX4/Av8t556b2+P
 NuHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxs+1XnHi8wKZWmMq0vqxAVgoSnnCks/07WVORJDi/MP9+y703CcaJCCes8wqYc6Jch4bFEgmbctcT@nongnu.org
X-Gm-Message-State: AOJu0YzYMBazm7alzCPIqG/MkYOeoO31vHcnYAeAwxrxdzIarDsf1ekY
 KWndHYMx9H561613eOSeYbNBTezmloA6UvjMIHhWf9mPArwZhQnck/Dz+PUO83M=
X-Gm-Gg: ASbGncta0uNqpZmg0nOMh8VtYTHIjgKU/EHzGD0kwd8fYNvk3n+NzjYYHL6X/lH558K
 gGUcWZCDppuWf1aHBxj9jtZ1dca5zKL5W5zVc1SSm+XQ2Dbv6Z0Apb9GCy+WnrjKor8BUe/ibqv
 7+CBxQoTQWQohAzXguIZKc2Sbs9c6KOHQu0ExrdXkuToPVRRslTUqNafwFUaMEXr7e87W6dbscC
 oGLWvo/Bf51NTFKwIAqhnu26/veMzwB//zS8E9lmiXkzZZjUCANEaPPuzdN16p2/Lg=
X-Google-Smtp-Source: AGHT+IEcSH4ZfFDASytx+Q99KVsX4O4zA3wZF5PextsCSEjZEIh4kKThAQEHwahHsIFbKNClHFFsuQ==
X-Received: by 2002:a05:6a20:7f8b:b0:1e0:d6ef:521a with SMTP id
 adf61e73a8af0-1e88d0e6390mr17977529637.1.1736568932299; 
 Fri, 10 Jan 2025 20:15:32 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40564bdasm2235066b3a.38.2025.01.10.20.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 20:15:31 -0800 (PST)
Message-ID: <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
Date: Sat, 11 Jan 2025 13:15:24 +0900
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
 <Z4E6TnKaUt8FMWIv@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4E6TnKaUt8FMWIv@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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

On 2025/01/11 0:18, Peter Xu wrote:
> On Fri, Jan 10, 2025 at 05:43:15PM +0900, Akihiko Odaki wrote:
>> On 2025/01/10 4:37, Peter Xu wrote:
>>> On Thu, Jan 09, 2025 at 02:29:21PM -0500, Peter Xu wrote:
>>>> On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
>>>>> On Thu, 9 Jan 2025, Akihiko Odaki wrote:
>>>>>> Do not refer to "memory region's reference count"
>>>>>> -------------------------------------------------
>>>>>>
>>>>>> Now MemoryRegions do have their own reference counts, but they will not
>>>>>> be used when their owners are not themselves. However, the documentation
>>>>>> of memory_region_ref() says it adds "1 to a memory region's reference
>>>>>> count", which is confusing. Avoid referring to "memory region's
>>>>>> reference count" and just say: "Add a reference to a memory region".
>>>>>> Make a similar change to memory_region_unref() too.
>>>>>>
>>>>>> Refer to docs/devel/memory.rst for "owner"
>>>>>> ------------------------------------------
>>>>>>
>>>>>> memory_region_ref() and memory_region_unref() used to have their own
>>>>>> descriptions of "owner", but they are somewhat out-of-date and
>>>>>> misleading.
>>>>>>
>>>>>> In particular, they say "whenever memory regions are accessed outside
>>>>>> the BQL, they need to be preserved against hot-unplug", but protecting
>>>>>> against hot-unplug is not mandatory if it is known that they will never
>>>>>> be hot-unplugged. They also say "MemoryRegions actually do not have
>>>>>> their own reference count", but they actually do. They just will not be
>>>>>> used unless their owners are not themselves.
>>>>>>
>>>>>> Refer to docs/devel/memory.rst as the single source of truth instead of
>>>>>> maintaining duplicate descriptions of "owner".
>>>>>>
>>>>>> Clarify that owner may be missing
>>>>>>
>>>>>> ---------------------------------
>>>>>> A memory region may not have an owner, and memory_region_ref() and
>>>>>> memory_region_unref() do nothing for such.
>>>>>>
>>>>>> memory: Clarify owner must not call memory_region_ref()
>>>>>> --------------------------------------------------------
>>>>>>
>>>>>> The owner must not call this function as it results in a circular
>>>>>> reference.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>> ---
>>>>>> include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
>>>>>> 1 file changed, 28 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>>>> index 9458e2801d50..ca247343f433 100644
>>>>>> --- a/include/exec/memory.h
>>>>>> +++ b/include/exec/memory.h
>>>>>> @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
>>>>>>    * memory_region_add_subregion() to add subregions.
>>>>>>    *
>>>>>>    * @mr: the #MemoryRegion to be initialized
>>>>>> - * @owner: the object that tracks the region's reference count
>>>>>> + * @owner: the object that keeps the region alive
>>>>>>    * @name: used for debugging; not visible to the user or ABI
>>>>>>    * @size: size of the region; any subregions beyond this size will be clipped
>>>>>>    */
>>>>>> @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
>>>>>>                           uint64_t size);
>>>>>>
>>>>>> /**
>>>>>> - * memory_region_ref: Add 1 to a memory region's reference count
>>>>>> + * memory_region_ref: Add a reference to the owner of a memory region
>>>>>>    *
>>>>>> - * Whenever memory regions are accessed outside the BQL, they need to be
>>>>>> - * preserved against hot-unplug.  MemoryRegions actually do not have their
>>>>>> - * own reference count; they piggyback on a QOM object, their "owner".
>>>>>> - * This function adds a reference to the owner.
>>>>>> - *
>>>>>> - * All MemoryRegions must have an owner if they can disappear, even if the
>>>>>> - * device they belong to operates exclusively under the BQL.  This is because
>>>>>> - * the region could be returned at any time by memory_region_find, and this
>>>>>> - * is usually under guest control.
>>>>>> + * This function adds a reference to the owner of a memory region to keep the
>>>>>> + * memory region alive. It does nothing if the owner is not present as a memory
>>>>>> + * region without owner will never die.
>>>>>> + * For references internal to the owner, use object_ref() instead to avoid a
>>>>>> + * circular reference.
>>>>>
>>>>> Reading this again I'm still confused by this last sentence. Do you mean
>>>>> references internal to the memory region should use object_ref on the memory
>>>>> region or that other references to the owner should use object_ref on the
>>>>> owner? This sentence is still not clear about that.
>>>>
>>>> Having two refcounts are definitely confusing.. especially IIRC all MRs'
>>>> obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
>>>> its g_free() on its own.
>>
>> We still have instance_finalize that will fire when the MR's refcount gets
>> zero so it has its own use cases.
>>
>>>>
>>>> I acked both patches, but maybe it could indeed be slightly better we drop
>>>> this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
>>>> means for parent/child MRs that share the same owner, QEMU does nothing on
>>>> the child MRs when add subregion, because it assumes the child MR will
>>>> never go away when the parent is there who shares the owner.
>>>>
>>>> So maybe we try not to touch MR's refcount manually, but fix what can be
>>>> problematic for owner->ref only.
>>>
>>> As an attached comment: I may have forgot some context on this issue, but I
>>> still remember I used to have a patch that simply detach either parent or
>>> child MR links when finalize().  It's here:
>>>
>>> https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
>>>
>>> I see this issue was there for a long time so maybe we want to fix it one
>>> way or another.  I don't strongly feel which way to go, but personally I
>>> still prefer that way (I assume that can fix the same issue), and it
>>> doesn't have MR's refcount involved at all, meanwhile I don't see an issue
>>> yet with it..
>>>
>>
>> For this particular topic I have somewhat a strong opinion that we should
>> care the two reference counters.
>>
>> Indeed, dealing with two reference counters is not fun, but sometimes it is
>> necessary to do reference counting correctly. Your patch is to avoid
>> reference counting for tracking dependencies among regions with the same
>> owner, and it does so by ignoring the reference from container to subregion.
> 
> I don't think so?  When with that patch, container will reference subregion
> the same way as others, which is to take a refcount on the owner.  That
> kept at least the refcount behavior consistent within memory_region_ref().

memory_region_ref() is not the only place that is responsible for 
reference management. memory_region_do_init() also calls 
object_property_add_child(), which in turn calls object_ref() to create 
a reference from the owner to the memory region. We should keep using 
object_ref() for object references originating from the owner.

> 
> That patch removes the circular reference by always properly release the
> circular reference due to sub-regioning internally.

Calling memory_region_del_subregion() is not consistent with the 
direction of object references. A container references its subregion so 
the container should remove references to its subregion when 
appropriate. A subregion should not remove the reference its container 
holds.

> 
>>
>> I prefer to keep reference counting correct instead of having an additional
>> ad-hoc measure that breaks reference relationships.
> 
> Your patch added more complexity to me on refcounting, meanwhile it's also
> not always "correct".  It can boil down to how you define "correct" - if
> you mean one should always boost a refcount somewhere if it references one
> MR, then it's still not 100% correct at least when mr->owner==NULL.  We
> never yet did it alright, so to me it's a matter of working around current
> sanitizer issue, and that's only about it yet so far.

mr->owner == NULL is an exceptional case that we allow for performance 
reasons. We have luxury to spend more time in our case.

> 
> Meanwhile I _think_ adding such complexity also means MR's finalize() will
> be called in specific order when parent/child MRs belong to the same owner.
> In my patch the order shouldn't matter, IIUC, which I preferred because
> that reduces details that we may not care much (or I could have overlooked
> why we need to care about it).  Basically that's simpler to maintain to me,
> but again, I don't feel strongly until someone would like / be able to
> rework MR refcounting completely.

We need to take care of the semantics of subregion. A container needs 
its subregions to satisfy accesses to the memory it represents. So it 
refers to the subregions, and the reference must keep the subregions 
alive; that's why we must keep the ordering.

Regards,
Akihiko Odaki

