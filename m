Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51795C5474C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 04:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skFKp-00027I-HL; Sat, 31 Aug 2024 00:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1skFKn-000248-BB
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 00:03:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1skFKi-0002l3-Fq
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 00:03:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71423704ef3so1913130b3a.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1725077007; x=1725681807;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8kqeesjr4KxfkBFXoIbB4lpZGpxEEMOuCylIbToiN4=;
 b=yD6yntLuT+3HE20+D+8wqrqAd/nvIIMaoDvG6ZEp63gOsXnC+fsyN+IbeSUMA2n3Hd
 r49lTL0KzMjkipdX3NQtEEtjcc8oly7YTXs8fBgS7lKpq3Kum6OFBX/Rz5X1xtMMKhXZ
 NzZvOTbJvLsS0AKO7Cj7vUo64iqyKDZi8N3iWMYs2kX21KECevFswBvY/9W+rOiyW4lq
 cmgMTUxNe5xgG1vjMPdUNfTB4NGJjK8nQHR8FM8W6PrKdZ9yC0eXIEL+7grgr79XKI1d
 UpAWLxQHi4l8JkXJLQBHWmDhgmP3oCFVsHMkTOG1EaPJBhhz2i36ESAb1c54jPrOyZDm
 HMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725077007; x=1725681807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8kqeesjr4KxfkBFXoIbB4lpZGpxEEMOuCylIbToiN4=;
 b=dNVW7c8LPcbB2UhWc5IWAPWJwgAsjQzB0GnHByh4D/9MmfB6jGdF0RraF55hbKTOsh
 9M/PuSqLRW5D5dfGa7xJB9D2kPDOMqF5oCjGFdXSDr++Mj4xk7M0osPZhgK2qPj7jNt4
 bCBu41COiPMdwBGCE1gFje2AT9Nipz4vI1lo5sVNLNxwXXFoaSrKwAtmWejAh58WEO9F
 lTe3dSh9rA8+w14tSWdWONb+x/gVfDow2riH1Sjg9t20f5szmE2iGVQKEzOSMS7X8VCR
 s4fh002SBrvTv+EmmprJAxCfSaZ2a/BvbgLU8STh6bd1e4CZ93+p1iJ4CHSjR5dLlr5I
 5NjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTCf36lkcMs2TLO31kHlJ1LMNkG7nba6/FnekkQOZHOjzVL/bPKiluZRRfS9dZ4i/agvuWcSBQmi/o@nongnu.org
X-Gm-Message-State: AOJu0YxO1UBstPdWziVQaG94FJZ/8L8fNdWLEiESoEKy2sQaM1D5iR5G
 8tM43fxjJ45Z38riTkaiMrg8C+7d44NSGZBfNYrBoeu6qaZLa0DdZ64Tfkg3Z/s=
X-Google-Smtp-Source: AGHT+IErnxeHuCd+Pc3Cdi40XtXSGzXG8LgRqJaahr7CLufKgq/t1URxAQjS7v0sS5Ogq7oVbYp50A==
X-Received: by 2002:a05:6a00:919b:b0:704:2696:d08e with SMTP id
 d2e1a72fcca58-7173b607623mr1892127b3a.13.1725077006536; 
 Fri, 30 Aug 2024 21:03:26 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e5576ca6sm3588457b3a.13.2024.08.30.21.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 21:03:26 -0700 (PDT)
Message-ID: <1f3297a5-bf29-493b-a321-620565a107bc@daynix.com>
Date: Sat, 31 Aug 2024 13:03:19 +0900
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
References: <Zszain3SH5cl9ohH@x1n>
 <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com> <Zs36od036pyxvQlZ@x1n>
 <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com> <Zs8hcLPU62Hj8x-W@x1n>
 <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com> <Zs9IxoRdu6CcZRrx@x1n>
 <9bbdbee7-ef13-42b9-9594-fba1d0a634e4@daynix.com> <ZtDQoqWNBoe9Zxt6@x1n>
 <c4f1c3ba-30e7-4775-8647-8753112d885d@daynix.com> <ZtHf1MXTRxqMsLLT@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZtHf1MXTRxqMsLLT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/08/31 0:05, Peter Xu wrote:
> On Fri, Aug 30, 2024 at 03:11:38PM +0900, Akihiko Odaki wrote:
>> On 2024/08/30 4:48, Peter Xu wrote:
>>> On Thu, Aug 29, 2024 at 01:39:36PM +0900, Akihiko Odaki wrote:
>>>>>> I am calling the fact that embedded memory regions are accessible in
>>>>>> instance_finalize() "live". A device can perform operations on its memory
>>>>>> regions during instance_finalize() and we should be aware of that.
>>>>>
>>>>> This part is true.  I suppose we should still suggest device finalize() to
>>>>> properly detach MRs, and that should normally be done there.
>>>>
>>>> It is better to avoid manual resource deallocation in general because it is
>>>> too error-prone.
>>>
>>> I had an impression that you mixed up "finalize()" and "free()" in the
>>> context of our discussion.. let us clarify this first before everything
>>> else below, just in case I overlook stuff..
>> I am aware of that distinction. I dealt with it with patch "virtio-gpu:
>> Handle resource blob commands":
>> https://lore.kernel.org/r/20240822185110.1757429-12-dmitry.osipenko@collabora.com
>>
>>>
>>> MR is very special as an object, in that it should have no free() hook,
>>> hence by default nothing is going to be freed when mr->refcount==0.  It
>>> means MRs need to be freed manually always.
>>>
>>> For example:
>>>
>>> (gdb) p system_memory->parent_obj->free
>>> $2 = (ObjectFree *) 0x0
>>>
>>> It plays perfect because the majority of QEMU device model is using MR as a
>>> field (rather than a pointer) of another structure, so that's exactly what
>>> we're looking for: we don't want to free() the MR as it's allocated
>>> together with the owner device.  That'll be released when the owner free().
>>>
>>> When dynamic allocation gets into the picture for MR, it's more complicated
>>> for sure, because it means the user (like VFIOQuirk) will need to manually
>>> allocate the MRs, then it requires explicit object_unparent() to detach
>>> that from the device / owner when finalize().  NOTE!  object_unparent()
>>> will NOT free the MR yet so far.  The MR still need to be manually freed
>>> with an explicit g_free(), normally.  Again, I'd suggest you refer to the
>>> VFIOQuirk code just as an example.  In that case this part is done with
>>> e.g. vfio_bar_quirk_finalize().
>>>
>>>           for (i = 0; i < quirk->nr_mem; i++) {
>>>               object_unparent(OBJECT(&quirk->mem[i]));
>>>           }
>>>           g_free(quirk->mem);
>>>
>>> Here quirk->mem is a pointer to an array of MR which can contain one or
>>> more MRs, but the idea is the same.
>>>
>>>>
>>>> I have an impression with QEMU code base that it is failing manual resource
>>>> deallocation so frequently although such deallocation can be easily
>>>> automated by binding resources to objects and free them when objects die by
>>>> providing a function like Linux's devm_kmalloc(). Unfortunately I haven't
>>>> found time to do that though.
>>>
>>> AFAICT, the property list is exactly what you're saying.  IIUC normally an
>>> object will be properly finalized()ed + free()ed when the parent object is
>>> finalize()ed.  Here MR is just special as it bypasses all the free() part.
>>>
>>>>
>>>> So my opinion here is 1) we should automate resource deallocation as much as
>>>> possible but 2) we shouldn't disturb code that performs manual resource
>>>> management.
>>>
>>> Agree.  However note again that in whatever case cross-device MR links will
>>> still require explicit detachment or it's prone to memory leak.
>>
>> I am not sure what you refer to with cross-device MR links so can you
>> clarify it?
> 
> I was referring to Peter Maydell's example, where the MR can be used
> outside of its owner.  In that case manual operation is a must before
> finalize(), as finalize() can only make sense to resolve internal links
> automatically.
> 
> But now knowing that you're explicitly mentioning "deallocation" rather
> than "finalize()", and you're aware of diff between deallocation
> v.s. finalize(), I suppose I misunderstood what you meant, and now I'm not
> sure I get what you're suggesting.

I referred to both of finalize() and free() with "resource 
deallocation"; actually I referred to any resource that requires some 
operation after its use finishes.

Ideally, any resource should be automatically released. It should be 
also possible to manually release resource to enforce ordering.

> 
>>
>>>
>>>>
>>>> instance_finalize() is for manual resource management. It is better to have
>>>> less code in instance_finalize() and fortunately MemoryRegion don't require
>>>> any code in instance_finalize() in most cases. If instance_finalize() still
>>>> insists to call object_unparent(), we shouldn't prevent that. (I changed my
>>>> mind regarding this particular case of object_unparent() however as I
>>>> describe below.)
>>>>
>>>>>
>>>>>>
>>>>>> object_unparent() is such an example. instance_finalize() of a device can
>>>>>> call object_unparent() for a subregion and for its container. If we
>>>>>> automatically finalize the container when calling object_unparent() for the
>>>>>> subregion, calling object_unparent() for its container will result in the
>>>>>> second finalization, which is not good.
>>>>>
>>>>> IMHO we don't finalize the container at all - what I suggested was we call
>>>>> del_subregion() for the case where container != NULL.  Since in this case
>>>>> both container & mr belong to the same owner, it shouldn't change any
>>>>> refcount, but only remove the link.
>>>>>
>>>>> However I think I see what you pointed out.  I wonder why we remove all
>>>>> properties now before reaching instance_finalze(): shouldn't finalize() be
>>>>> allowed to access some of the properties?
>>>>>
>>>>> It goes back to this commit:
>>>>>
>>>>> commit 76a6e1cc7cc3ad022e7159b37b291b75bc4615bf
>>>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Date:   Wed Jun 11 11:58:30 2014 +0200
>>>>>
>>>>>        qom: object: delete properties before calling instance_finalize
>>>>>        This ensures that the children's unparent callback will still
>>>>>        have a usable parent.
>>>>>        Reviewed-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>>>>>        Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>
>>>>>    From this series (as the 1st patch there):
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/1406716032-21795-1-git-send-email-pbonzini@redhat.com/
>>>>>
>>>>> I can't say I fully understand the commit yet so far.. because it seems
>>>>> this patch was trying to pave way so that MR's unparent() can have a usable
>>>>> parent.  However... I don't think mr implemented unparent() at all..
>>>>> while it just sounds more reasonable that properties shouldn't be
>>>>> auto-removed before calling instance_finalize() from my gut feeling.
>>>>>
>>>>> I tried to revert 76a6e1cc7c ("qom: object: delete properties before
>>>>> calling instance_finalize"), "make check" all passes here.  I am a bit
>>>>> confused on where it applies, and whether we should revert it.
>>>>>
>>>>> If with 76a6e1cc7cc reverted, I think your concern should go away because
>>>>> then properties (including MRs) will only be detached after owner's
>>>>> instance_finalize().  Again, I wished Paolo could chime in as he should
>>>>> know the best.
>>>>
>>>> I didn't know QOM deletes properties before instance_finalize().
>>>>
>>>> I think it is a bad idea to delete properties before instance_finalize().
>>>> The intention is that to keep a usable parent during unparenting, but it is
>>>> inevitable that an object is in a semi-finalized state during finalization.
>>>> If the order of finalization matters, it should be explicitly described in
>>>> instance_finalize(). Deleting properties before instance_finalize() prevents
>>>> that.
>>>>
>>>> That said, I think it is too late to revert that change. "make check" works
>>>> as a preliminary check, but ultimately we need manual tree-wide review,
>>>> which is too costly.
>>>
>>> I don't think it's too late. :)
>>>
>>> IMHO if that statement is true, then QEMU will gradually become not
>>> maintainable anymore with tons of such code nobody understands and nobody
>>> can touch.  To me it can destine its death soon afterwards if so, sooner or
>>> later.
>>>
>>> OTOH, it'll be harder to justify or change indeed if some piece of code
>>> stays longer in-tree.  So I agree with you even if we want to change
>>> anything around this we should be with extreme cautions, and I don't think
>>> we should merge anything like this too late of a release, just to give it
>>> time to expose and break things.
>>>
>>>>
>>>> Going back to the original topic, I had the (incorrect) assumption that QOM
>>>> deletes properties *after* instance_finalize(). Under such an assumption, it
>>>
>>> Let's stick with this model; so far I still think this is the right thing
>>> to do, and I'm happy to know that you seem to at least agree (irrelevant of
>>> whether we should move on with a change).
>>>
>>>> would be unsafe to remove a subregion from its container when a subregion is
>>>> gone. As you said, we don't have to object_unparent(mr->container) and
>>>
>>> IMHO we need to do this. Please recheck this after reading above on
>>> finalize() v.s. free().  Here object_unparent() is needed because the MR is
>>> allocated by the owner, it means only the owner knows how to free() it
>>> (again: MR's own free()==NULL).  Then if we want to free it properly, we
>>> need to detach it from the owner object first, hence object_unparent().
>>>
>>>> instead we can just call memory_region_del_subregion() instead to keep
>>>> object_unparent() functional. However, strictly speaking,
>>>
>>> I think we can do that, or we don't.  It's the same as whether we want to
>>> explicitly detach links for an embeded MR: if it's not explicitly done, we
>>> can rely on the finalize() of the MR to do so. >
>>> In all cases, object_unparent() will still be needed because it will do
>>> more things than memory_region_del_subregion(): it removes the property
>>> link itself.
>>>
>>> This is also one reason why I keep thinking what I suggested might be good:
>>> it covers not only mr->subregions and also mr->container, it means the
>>> detachment has no ordering constraints on which mr is finalize()ed first
>>> (in this case, either the container mr or the child mr).
>>
>> I referred to the following statement you made by saying we don't have to
>> object_unparent(mr->container):
>>> IMHO we don't finalize the container at all - what I suggested was we
>>> call del_subregion() for the case where container != NULL.  Since in
>>> this case both container & mr belong to the same owner, it shouldn't
>>> change any refcount, but only remove the link.
>>
>> I discussed calling del_subregion() is still problematic below.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>> memory_region_del_subregion() is also a side effect and may affect
>>>> operations with the container later. Such a side effect is better to be
>>>> avoided whenever possible.
>>>>
>>>> My point in this discussion is that the device has a control of its memory
>>>> region even during finalization. We shouldn't call object_unparent(),
> 
> I assume we're talking about embeded MRs, then I agree until here.
> 
>>>> memory_region_del_subregion(), or perform whatever operation on another
>>>> memory region; otherwise the device may see an unexpected side effect.
> 
> I don't get it here.
> 
> We're still taking in the context of calling finalize() before property
> list being detached, right?
> 
> In that case detachment of the property list should be the last thing we
> do.  What unexpected side effect do we worry about?
> 
> To be explicit, IMHO the right sequence of doing it is (which remove
> property later):
> 
>          static void object_finalize(void *data)
>          {
>                  Object *obj = data;
>                  TypeImpl *ti = obj->class->type;
> 
>                  object_deinit(obj, ti);
>                  object_property_del_all(obj); <------------ [1]
> 
>                  g_assert(obj->ref == 0);
>                  g_assert(obj->parent == NULL);
>                  if (obj->free) {
>                          obj->free(obj);
>                  }
>          }
> 
> We're talking about MR automatically unlink both mr->container and
> mr->subregions at [1] (comparing to the old world where we only auto detach
> mr->subregions).  After that it calls obj->free() and memory is freed.
> I don't see what can be the side effect you mentioned.
> 
> The only side effect I can think of is when the container MR finalize() is
> called later than the subregion's, then the container will see empty
> mr->subregions on its own, but that's exactly what we want to work out
> here: we want to make sure mr finalize() work in random order.

We have full control when the scenario where the MR is automatically 
unparented so it is not really a problem. It is safe to automatically 
call memory_region_del_subregion() in such a case.

I am talking about side effects caused by automatically calling 
memory_region_del_subregion() when instance_finalize() of the owner 
calls object_unparent() for the subregion. This mutates the state of the 
container although object_unparent() is called for the subregion. This 
is a side effect a device does not expect.

So there is a tradeoff. There is no such side effect in my patch. My 
patch strictly keeps the direction of reference (a container refers to 
its subregion) so a subregion does not have to mutate the state of its 
container. However it makes use of the reference counter.

What you propose on the other hand does not use the reference counter, 
but it goes against the direction of reference and changes the state of 
container when the subregion gets unparented, which can be surprising 
for the device.

I argue that my patch makes the good tradeoff because the logic is so 
simple that it can be trivially adapted even if the reference counter 
gets removed. On the other hand, having a side effect when finalizing 
subregions makes an assumption on devices, and there are plenty of 
devices in QEMU. Comparing the numbers, it makes more sense to maintain 
one simple logic of reference tracking.

Regards,
Akihiko Odaki

