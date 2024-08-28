Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FEC5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjJFc-00012O-Rt; Wed, 28 Aug 2024 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjJFZ-000115-UI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:02:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjJFX-0004rX-Cf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:02:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7140ff4b1e9so5362371b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724853734; x=1725458534;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnz04ZWytc/qsqEDSCSyscBZjTtc9cESk8TtYVw3VL0=;
 b=QleVvVhAQWKSMme7R0oyp31JosA313J+oE03buG3Axf5oFjlz8DCYJYWRd2/HesK40
 6njN0HpY/lkVB1SX3ouqjJxkEPWt9C1n8rmMwF5kn1XSMr7fziwaulTvzmPlbddRoMVe
 CfRbPTYiXuoap1d3TPgwcj1wGITWQrsLAg/XppYvqFnn9Vu7BzxwJQo8I3bPzoBWjuWZ
 NalVoLrLC4JAs+ulcdrqTRNOSGMRKJioTqTooiOeexyVUL3Ir8XeEPuusqs/rb6U7pIo
 86YJwEPWHlOXx9Jx5f78OR19OC8qaQiyYpyowoi/0W/UGPr5Rp55+sRE6XiEUcWyKA24
 neBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724853734; x=1725458534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnz04ZWytc/qsqEDSCSyscBZjTtc9cESk8TtYVw3VL0=;
 b=mG2kITtnlAY0M7rvfb80nequd7u/e9n2I8CvNt+BcF8PglABSOKhok7ZU1DvNBs5QH
 QTq/2nmFVKdbv2aju4Ch4Lrr3fbv9ARvgKnx3Tvxwxdohh8JmHwaPC3yilgabrX7+m2F
 V2o51FPW6nwTO8n3t0Q6sFMQzPYuTVXBfn4QFTrzDwnEMx5KfopLVQTOKTqV8CaPTgnp
 ZotmTAR8B5TRikRaehurmWTk0vGYec2L8LCGoz3TxCCrRZJEdH/1l6MbH/ioJNuRf5Zs
 HoJb/DjHRlsYW0G3k7LEvQv5VcThSwcI4RtwbjurdKI7UNPw0adSavIKIrx46X6+ZpLV
 Rq7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJK1ACNVzoKgfxyGgGq/8N+RqP8XmeO8vBh2nlcw0s+hNJLDhjnGpHw8jn2BcLESflhT3uKxFqHKjc@nongnu.org
X-Gm-Message-State: AOJu0YxxTTE1D3HzYDgeLEkERxl8Xqj9YLE2+DGAJaKsNdwMo5bcU+Uv
 i0ruR7CWCCJ8Cd/psHo0Tx/mDFDEFCtGdj96lqa9dqkBvruFLkVJ8fsExlqvcKE=
X-Google-Smtp-Source: AGHT+IFZeV8BNEmXbTyyKiFidX6LX0x7JTs5vxUPD6MlyrOjglDv2xL1ce1WkI4nwKDdhlLSG9aGqw==
X-Received: by 2002:a05:6a21:150b:b0:1c4:8293:76db with SMTP id
 adf61e73a8af0-1ccd28a281amr2024996637.29.1724853733595; 
 Wed, 28 Aug 2024 07:02:13 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434235f77sm10515850b3a.13.2024.08.28.07.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 07:02:13 -0700 (PDT)
Message-ID: <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com>
Date: Wed, 28 Aug 2024 23:02:06 +0900
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
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n> <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
 <Zs36od036pyxvQlZ@x1n> <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
 <Zs8hcLPU62Hj8x-W@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zs8hcLPU62Hj8x-W@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

On 2024/08/28 22:09, Peter Xu wrote:
> On Wed, Aug 28, 2024 at 02:33:59PM +0900, Akihiko Odaki wrote:
>> On 2024/08/28 1:11, Peter Xu wrote:
>>> On Tue, Aug 27, 2024 at 01:14:51PM +0900, Akihiko Odaki wrote:
>>>> On 2024/08/27 4:42, Peter Xu wrote:
>>>>> On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
>>>>>> On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
>>>>>>>
>>>>>>> On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
>>>>>>>> memory_region_update_container_subregions() used to call
>>>>>>>> memory_region_ref(), which creates a reference to the owner of the
>>>>>>>> subregion, on behalf of the owner of the container. This results in a
>>>>>>>> circular reference if the subregion and container have the same owner.
>>>>>>>>
>>>>>>>> memory_region_ref() creates a reference to the owner instead of the
>>>>>>>> memory region to match the lifetime of the owner and memory region. We
>>>>>>>> do not need such a hack if the subregion and container have the same
>>>>>>>> owner because the owner will be alive as long as the container is.
>>>>>>>> Therefore, create a reference to the subregion itself instead ot its
>>>>>>>> owner in such a case; the reference to the subregion is still necessary
>>>>>>>> to ensure that the subregion gets finalized after the container.
>>>>>>>>
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> ---
>>>>>>>>     system/memory.c | 8 ++++++--
>>>>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/system/memory.c b/system/memory.c
>>>>>>>> index 5e6eb459d5de..e4d3e9d1f427 100644
>>>>>>>> --- a/system/memory.c
>>>>>>>> +++ b/system/memory.c
>>>>>>>> @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>>>>>>>>
>>>>>>>>         memory_region_transaction_begin();
>>>>>>>>
>>>>>>>> -    memory_region_ref(subregion);
>>>>>>>> +    object_ref(mr->owner == subregion->owner ?
>>>>>>>> +               OBJECT(subregion) : subregion->owner);
>>>>>>>
>>>>>>> The only place that mr->refcount is used so far is the owner with the
>>>>>>> object property attached to the mr, am I right (ignoring name-less MRs)?
>>>>>>>
>>>>>>> I worry this will further complicate refcounting, now we're actively using
>>>>>>> two refcounts for MRs..
>>>>
>>>> The actor of object_ref() is the owner of the memory region also in this
>>>> case. We are calling object_ref() on behalf of mr->owner so we use
>>>> mr->refcount iff mr->owner == subregion->owner. In this sense there is only
>>>> one user of mr->refcount even after this change.
>>>
>>> Yes it's still one user, but it's not that straightforward to see, also
>>> it's still an extension to how we use mr->refcount right now.  Currently
>>> it's about "true / false" just to describe, now it's a real counter.
>>>
>>> I wished that counter doesn't even exist if we'd like to stick with device
>>> / owner's counter.  Adding this can definitely also make further effort
>>> harder if we want to remove mr->refcount.
>>
>> I don't think it will make removing mr->refcount harder. With this change,
>> mr->refcount will count the parent and container. If we remove mr->refcount,
>> we need to trigger object_finalize() in a way other than checking
>> mr->refcount, which can be achieved by simply evaluating OBJECT(mr)->parent
>> && mr->container.
>>
>>>
>>>>
>>>>>>>
>>>>>>> Continue discussion there:
>>>>>>>
>>>>>>> https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
>>>>>>>
>>>>>>> What I don't see is how mr->subregions differs from mr->container, so we
>>>>>>> allow subregions to be attached but not the container when finalize()
>>>>>>> (which is, afaict, the other way round).
>>>>>>>
>>>>>>> It seems easier to me that we allow both container and subregions to exist
>>>>>>> as long as within the owner itself, rather than start heavier use of
>>>>>>> mr->refcount.
>>>>>>
>>>>>> I don't think just "same owner" necessarily will be workable --
>>>>>> you can have a setup like:
>>>>>>      * device A has a container C_A
>>>>>>      * device A has a child-device B
>>>>>>      * device B has a memory region R_B
>>>>>>      * device A's realize method puts R_B into C_A
>>>>>>
>>>>>> R_B's owner is B, and the container's owner is A,
>>>>>> but we still want to be able to get rid of A (in the process
>>>>>> getting rid of B because it gets unparented and unreffed,
>>>>>> and R_B and C_A also).
>>>>>
>>>>> For cross-device references, should we rely on an explicit call to
>>>>> memory_region_del_subregion(), so as to detach the link between C_A and
>>>>> R_B?
>>>>
>>>> Yes, I agree.
>>>>
>>>>>
>>>>> My understanding so far: logically when MR finalize() it should guarantee
>>>>> both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
>>>>> commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
>>>>> beginning we don't assert on ->container==NULL yet).  It requires all
>>>>> device emulations to do proper unrealize() to unlink all the MRs.
>>>>>
>>>>> However what I'm guessing is QEMU probably used to have lots of devices
>>>>> that are not following the rules and leaking these links.  Hence we have
>>>>> had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
>>>>> it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.
>>>>>
>>>>> What I was thinking is this comment seems to apply too to mr->container, so
>>>>> that it should be safe too to unlink ->container the same way as its own
>>>>> subregions. >
>>>>> IIUC that means for device-internal MR links we should be fine leaving
>>>>> whatever link between MRs owned by such device; the device->refcount
>>>>> guarantees none of them will be visible in any AS.  But then we need to
>>>>> always properly unlink the MRs when the link is across >1 device owners,
>>>>> otherwise it's prone to leak.
>>>>
>>>> There is one principle we must satisfy in general: keep a reference to a
>>>> memory region if it is visible to the guest.
>>>>
>>>> It is safe to call memory_region_del_subregion() and to trigger the
>>>> finalization of subregions when the container is not referenced because they
>>>> are no longer visible. This is not true for the other way around; even when
>>>> subregions are not referenced by anyone else, they are still visible to the
>>>> guest as long as the container is visible to the guest. It is not safe to
>>>> unref and finalize them in such a case.
>>>>
>>>> A memory region and its owner will leak if a memory region kept visible for
>>>> a too long period whether the chain of reference contains a
>>>> container/subregion relationship or not.
>>>
>>> Could you elaborate why it's still visible to the guest if
>>> owner->refcount==0 && mr->container!=NULL?
>>>
>>> Firstly, mr->container != NULL means the MR has an user indeed.  It's the
>>> matter of who's using it.  If that came from outside this device, it should
>>> require memory_region_ref(mr) before hand when adding the subregion, and
>>> that will hold one reference on the owner->refcount.
>>>
>>> Here owner->refcount==0 means there's no such reference, so it seems to me
>>> it's guaranteed to not be visible to anything outside of this device / owner.
>>> Then from that POV it's safe to unlink when the owner is finalizing just
>>> like what we do with mr->subregions, no?
>>
>> An object is alive during instance_finalize even though its refcount == 0.
>> We can't assume all memory regions are dead even if owner->refcount == 0
>> because of that.
> 
> When you referred to "an object", do you mean the MR being finalized here?
> 
> IIUC when the MR reaches its finalize(), it should mean it's not live
> anymore.
> 
> We have two forms of MR usages right now: either embeded in another Object
> / Device, or dynamically, like VFIOQuirk.
> 
> When used embeded, the MR is only finalized when being removed from the
> object's property list, that should only happen when the object / device
> triggered finalize().  Since the MR will use the owner->refcount so I
> suppose it means the MR is not live anymore.
> 
> When used dynamically, object_unparent() is needed but that should only
> happen when the object / owner is during finalize(), per document:
> 
>          If however the memory region is part of a dynamically allocated
>          data structure, you should call object_unparent() to destroy the
>          memory region before the data structure is freed.  For an example
>          see VFIOMSIXInfo and VFIOQuirk in hw/vfio/pci.c.
> 
> Then the MR is also not live.
> 
>> In particular, docs/devel/memory.rst says you can call object_unparent()
>> in the instance_finalize of the owner. This assumes a memory region will
>> not vanish during the execution of the function unless object_unparent()
>> is already called for the memory region.
> 
> Yes, the MR will not vanish during finalize() of the owner object. However
> I don't think it's "live"?  Again, it's based on my definition of
> "liveness" as "taking one refcount of its owner", here the owner refcount
> is zero.  IOW, I don't expect it to be accessible anywhere from any address
> space (e.g. address_space_map()), because they'll all use
> memory_region_ref() and that'll ultimately stops the owner from being
> finalized.

I am calling the fact that embedded memory regions are accessible in 
instance_finalize() "live". A device can perform operations on its 
memory regions during instance_finalize() and we should be aware of that.

object_unparent() is such an example. instance_finalize() of a device 
can call object_unparent() for a subregion and for its container. If we 
automatically finalize the container when calling object_unparent() for 
the subregion, calling object_unparent() for its container will result 
in the second finalization, which is not good.

Regards,
Akihiko Odaki

