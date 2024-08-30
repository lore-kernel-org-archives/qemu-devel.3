Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43286CA0EE5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjurY-0000Wy-Oa; Fri, 30 Aug 2024 02:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjurU-0000VP-LQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:11:56 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjurN-0003Vt-Nn
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:11:54 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7c3e1081804so850197a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724998305; x=1725603105;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XDkWrTbvfFH69VD47F2yMNqsI+YiQjBr1oD4HIO5sbU=;
 b=3O7FmNzoGPA8l1T/N8RlwrZFLGAgrZUc/Pfe/AdXDhavbPTYT5/ukfS1X9HuI5iE+X
 CZyhi+k8mub/d5j4wWtHQKUN2yYmhMJTIwtpAXxwVxQphJhS0+ysqpZhduxED2onOjjs
 b5L6ZH/P4YSKQudtLgz1dQuQhssG2WpYac1lW7cTNzxenPHnzQUsqW2JipIdw6plrPAY
 La3A74RE0Xr8RcEIQtlIaLtmzYDqM5BOCFESIAfIZncIcRzKFeCityID7uKjPlNEulCB
 y+KslCqnBxJtNvFoegKN2OUQVtQU1RpRooOJa3iy0KwXD7p4FNolh2Frn0XcACe9nVpt
 /aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724998305; x=1725603105;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XDkWrTbvfFH69VD47F2yMNqsI+YiQjBr1oD4HIO5sbU=;
 b=FCKR9ACtfiagoCLwlvC3eL17a0XE5+D5fr9nj3k5eAiV0sgE2PNpY7ZTXEkS1V+oif
 6UlR133bdFu0VgZ5Jf0wIoIoZTHM6D1f0uMgCCun6bQFiZxqen5K6VoX9JWg6wTxyUKz
 EXDvWl/n6kNzhXaSbZpClzewgPxjQTuurDeuEKgre8sV0AfEjcHPAnV7kkypEXSWVkdk
 Olph4qh7WNC6JcoaD/pvnE+8I4kP3HMp6u6pfMFhIK4gNBQqKvQ/QMtYvrfuq+zy9YKC
 NfcMxdtKOCLwNjkcEFhCFQEYKRwW5U8r0SGeEFg5/zbf+tGDk4+SngCQo4wZffzM9d+5
 xDxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkmaP5rWTCb2AntsqgExlPKa72INGaaQACYgVU3ZOjLCxr6WKVA8f4ovWH85OQ3ZS081nGJB+59292@nongnu.org
X-Gm-Message-State: AOJu0Yy+Oj6md08w8onO4EaiMkKzn/LwzARC63psN+RXAZWygm8tQyvh
 o56grQ0xST/0z+nhW5hLq5M32SIm1uh62ElIsp5KTvXb7jD1zJQPzhQdVw0FdQI=
X-Google-Smtp-Source: AGHT+IEJp70beqqDj+NtnvD6v9IOLB1BcphdL+OtaSySaobVmGRPiFKebIPGvQq7npdkdu50e76dhg==
X-Received: by 2002:a05:6a20:d70f:b0:1c8:fe09:f8cd with SMTP id
 adf61e73a8af0-1cce10147famr5094103637.24.1724998305013; 
 Thu, 29 Aug 2024 23:11:45 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e569e1desm2043466b3a.114.2024.08.29.23.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 23:11:44 -0700 (PDT)
Message-ID: <c4f1c3ba-30e7-4775-8647-8753112d885d@daynix.com>
Date: Fri, 30 Aug 2024 15:11:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n> <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
 <Zs36od036pyxvQlZ@x1n> <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
 <Zs8hcLPU62Hj8x-W@x1n> <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com>
 <Zs9IxoRdu6CcZRrx@x1n> <9bbdbee7-ef13-42b9-9594-fba1d0a634e4@daynix.com>
 <ZtDQoqWNBoe9Zxt6@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZtDQoqWNBoe9Zxt6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/30 4:48, Peter Xu wrote:
> On Thu, Aug 29, 2024 at 01:39:36PM +0900, Akihiko Odaki wrote:
>>>> I am calling the fact that embedded memory regions are accessible in
>>>> instance_finalize() "live". A device can perform operations on its memory
>>>> regions during instance_finalize() and we should be aware of that.
>>>
>>> This part is true.  I suppose we should still suggest device finalize() to
>>> properly detach MRs, and that should normally be done there.
>>
>> It is better to avoid manual resource deallocation in general because it is
>> too error-prone.
> 
> I had an impression that you mixed up "finalize()" and "free()" in the
> context of our discussion.. let us clarify this first before everything
> else below, just in case I overlook stuff..
I am aware of that distinction. I dealt with it with patch "virtio-gpu: 
Handle resource blob commands":
https://lore.kernel.org/r/20240822185110.1757429-12-dmitry.osipenko@collabora.com

> 
> MR is very special as an object, in that it should have no free() hook,
> hence by default nothing is going to be freed when mr->refcount==0.  It
> means MRs need to be freed manually always.
> 
> For example:
> 
> (gdb) p system_memory->parent_obj->free
> $2 = (ObjectFree *) 0x0
> 
> It plays perfect because the majority of QEMU device model is using MR as a
> field (rather than a pointer) of another structure, so that's exactly what
> we're looking for: we don't want to free() the MR as it's allocated
> together with the owner device.  That'll be released when the owner free().
> 
> When dynamic allocation gets into the picture for MR, it's more complicated
> for sure, because it means the user (like VFIOQuirk) will need to manually
> allocate the MRs, then it requires explicit object_unparent() to detach
> that from the device / owner when finalize().  NOTE!  object_unparent()
> will NOT free the MR yet so far.  The MR still need to be manually freed
> with an explicit g_free(), normally.  Again, I'd suggest you refer to the
> VFIOQuirk code just as an example.  In that case this part is done with
> e.g. vfio_bar_quirk_finalize().
> 
>          for (i = 0; i < quirk->nr_mem; i++) {
>              object_unparent(OBJECT(&quirk->mem[i]));
>          }
>          g_free(quirk->mem);
> 
> Here quirk->mem is a pointer to an array of MR which can contain one or
> more MRs, but the idea is the same.
> 
>>
>> I have an impression with QEMU code base that it is failing manual resource
>> deallocation so frequently although such deallocation can be easily
>> automated by binding resources to objects and free them when objects die by
>> providing a function like Linux's devm_kmalloc(). Unfortunately I haven't
>> found time to do that though.
> 
> AFAICT, the property list is exactly what you're saying.  IIUC normally an
> object will be properly finalized()ed + free()ed when the parent object is
> finalize()ed.  Here MR is just special as it bypasses all the free() part.
> 
>>
>> So my opinion here is 1) we should automate resource deallocation as much as
>> possible but 2) we shouldn't disturb code that performs manual resource
>> management.
> 
> Agree.  However note again that in whatever case cross-device MR links will
> still require explicit detachment or it's prone to memory leak.

I am not sure what you refer to with cross-device MR links so can you 
clarify it?

> 
>>
>> instance_finalize() is for manual resource management. It is better to have
>> less code in instance_finalize() and fortunately MemoryRegion don't require
>> any code in instance_finalize() in most cases. If instance_finalize() still
>> insists to call object_unparent(), we shouldn't prevent that. (I changed my
>> mind regarding this particular case of object_unparent() however as I
>> describe below.)
>>
>>>
>>>>
>>>> object_unparent() is such an example. instance_finalize() of a device can
>>>> call object_unparent() for a subregion and for its container. If we
>>>> automatically finalize the container when calling object_unparent() for the
>>>> subregion, calling object_unparent() for its container will result in the
>>>> second finalization, which is not good.
>>>
>>> IMHO we don't finalize the container at all - what I suggested was we call
>>> del_subregion() for the case where container != NULL.  Since in this case
>>> both container & mr belong to the same owner, it shouldn't change any
>>> refcount, but only remove the link.
>>>
>>> However I think I see what you pointed out.  I wonder why we remove all
>>> properties now before reaching instance_finalze(): shouldn't finalize() be
>>> allowed to access some of the properties?
>>>
>>> It goes back to this commit:
>>>
>>> commit 76a6e1cc7cc3ad022e7159b37b291b75bc4615bf
>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>> Date:   Wed Jun 11 11:58:30 2014 +0200
>>>
>>>       qom: object: delete properties before calling instance_finalize
>>>       This ensures that the children's unparent callback will still
>>>       have a usable parent.
>>>       Reviewed-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>>>       Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>>   From this series (as the 1st patch there):
>>>
>>> https://lore.kernel.org/qemu-devel/1406716032-21795-1-git-send-email-pbonzini@redhat.com/
>>>
>>> I can't say I fully understand the commit yet so far.. because it seems
>>> this patch was trying to pave way so that MR's unparent() can have a usable
>>> parent.  However... I don't think mr implemented unparent() at all..
>>> while it just sounds more reasonable that properties shouldn't be
>>> auto-removed before calling instance_finalize() from my gut feeling.
>>>
>>> I tried to revert 76a6e1cc7c ("qom: object: delete properties before
>>> calling instance_finalize"), "make check" all passes here.  I am a bit
>>> confused on where it applies, and whether we should revert it.
>>>
>>> If with 76a6e1cc7cc reverted, I think your concern should go away because
>>> then properties (including MRs) will only be detached after owner's
>>> instance_finalize().  Again, I wished Paolo could chime in as he should
>>> know the best.
>>
>> I didn't know QOM deletes properties before instance_finalize().
>>
>> I think it is a bad idea to delete properties before instance_finalize().
>> The intention is that to keep a usable parent during unparenting, but it is
>> inevitable that an object is in a semi-finalized state during finalization.
>> If the order of finalization matters, it should be explicitly described in
>> instance_finalize(). Deleting properties before instance_finalize() prevents
>> that.
>>
>> That said, I think it is too late to revert that change. "make check" works
>> as a preliminary check, but ultimately we need manual tree-wide review,
>> which is too costly.
> 
> I don't think it's too late. :)
> 
> IMHO if that statement is true, then QEMU will gradually become not
> maintainable anymore with tons of such code nobody understands and nobody
> can touch.  To me it can destine its death soon afterwards if so, sooner or
> later.
> 
> OTOH, it'll be harder to justify or change indeed if some piece of code
> stays longer in-tree.  So I agree with you even if we want to change
> anything around this we should be with extreme cautions, and I don't think
> we should merge anything like this too late of a release, just to give it
> time to expose and break things.
> 
>>
>> Going back to the original topic, I had the (incorrect) assumption that QOM
>> deletes properties *after* instance_finalize(). Under such an assumption, it
> 
> Let's stick with this model; so far I still think this is the right thing
> to do, and I'm happy to know that you seem to at least agree (irrelevant of
> whether we should move on with a change).
> 
>> would be unsafe to remove a subregion from its container when a subregion is
>> gone. As you said, we don't have to object_unparent(mr->container) and
> 
> IMHO we need to do this. Please recheck this after reading above on
> finalize() v.s. free().  Here object_unparent() is needed because the MR is
> allocated by the owner, it means only the owner knows how to free() it
> (again: MR's own free()==NULL).  Then if we want to free it properly, we
> need to detach it from the owner object first, hence object_unparent().
> 
>> instead we can just call memory_region_del_subregion() instead to keep
>> object_unparent() functional. However, strictly speaking,
> 
> I think we can do that, or we don't.  It's the same as whether we want to
> explicitly detach links for an embeded MR: if it's not explicitly done, we
> can rely on the finalize() of the MR to do so. >
> In all cases, object_unparent() will still be needed because it will do
> more things than memory_region_del_subregion(): it removes the property
> link itself.
> 
> This is also one reason why I keep thinking what I suggested might be good:
> it covers not only mr->subregions and also mr->container, it means the
> detachment has no ordering constraints on which mr is finalize()ed first
> (in this case, either the container mr or the child mr).

I referred to the following statement you made by saying we don't have 
to object_unparent(mr->container):
 > IMHO we don't finalize the container at all - what I suggested was we
 > call del_subregion() for the case where container != NULL.  Since in
 > this case both container & mr belong to the same owner, it shouldn't
 > change any refcount, but only remove the link.

I discussed calling del_subregion() is still problematic below.

Regards,
Akihiko Odaki

> 
>> memory_region_del_subregion() is also a side effect and may affect
>> operations with the container later. Such a side effect is better to be
>> avoided whenever possible.
>>
>> My point in this discussion is that the device has a control of its memory
>> region even during finalization. We shouldn't call object_unparent(),
>> memory_region_del_subregion(), or perform whatever operation on another
>> memory region; otherwise the device may see an unexpected side effect.
>>
>> Now, let's consider the correct assumption that QOM deletes properties
>> *before* instance_finalize(). Under this assumption, the statement in
>> docs/devel/memory.rst saying that calling object_unparent() in
>> instance_finalize() is fine is wrong because the memory region is already
>> finalized and we shouldn't call object_unparent() for a finalized object.
>>
>> This also means a device does not have a control of its memory regions
>> during finalization and the device will not see the side effect of calling
>> memory_region_del_subregion(). However, if a device really needs to control
>> the order of memory region finalization, it can still call object_ref() for
>> memory regions to keep them alive until instance_finalize(). The effect of
>> memory_region_del_subregion() will be  visible to the device if a device
>> does such a trick. While it is very unlikely that any device does such a
>> trick, it is still better to avoid having any assumption on devices.
>>
>> With the proposed object_ref(mr->owner == subregion->owner ?
>> OBJECT(subregion) : subregion->owner) call, we don't have to make any
>> assumption on how finalization works, which is too complicated as this
>> discussion shows. It certainly makes the use of two reference counters, but
>> it does not deviate from the current policy on their usage and it is also
>> trivial to adapt when the reference counter in memory region gets removed.
>> Considering all above, I believe my patch is the most straightforward
>> solution.
> 
> Let's see how you thinks after you read above first.  I hope we can get
> more onto the same page at least on the context.
> 
> So far I still prefer using mr->refcount as less as possible.  Now it plays
> the only role as "whether this MR is put onto an owner property list", and
> for all the rest refcounts on MR it should always routes to the owner.  I
> still think we need to be extremely cautious on further complicating this
> refcount.  It's already complicated indeed, but hopefully this model is the
> best we can trivially have right now, and so far it's clear to me, but it's
> always possible I overlooked something.

