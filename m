Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCD0C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjOf-0003Rp-OO; Mon, 08 Jul 2024 04:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQjOe-0003Pn-Jc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:06:52 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQjOc-0007i5-FR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:06:52 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so357757266b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720426008; x=1721030808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDqB/azdToPkhF1YzlwOU9UMXOcw/FPiIy9ag2e+qu4=;
 b=bEousIS/7wkiDsEmbFlRUEoc9/QfSUe29n/Scc9//uMWfZYD4tifJky4lkNToxxpJn
 Zxxd6JJoHa01zISwT1He+b5QDg3RgRQ72fc3OMjD89YiRKBfEYi+mp083gXwzg6ADNpL
 +Li9gdbYorZ89A0NEYH5wkPIxaH+xOKBzPgmG/pynqr1IKuSfR6qDbStouKQMDVpnxHi
 dyufVUXgCeJ6oUKMDDGsXhOtla9INcDAVZDJawia/hZcxHP7LBRtFy7CmDtOpusHD2ff
 mbjlS/jpRaFhuFpDHLLVbX7WUiE9dvk1eLQG8BbQFcmdyjspUjtjy7U3VqKU/OAAR8Av
 ybRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720426008; x=1721030808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDqB/azdToPkhF1YzlwOU9UMXOcw/FPiIy9ag2e+qu4=;
 b=FFNXy9Z1dhGTYRsVTXnsdCXE1KSeJQskJ2sovjObPRBTzeOQoqxBoRvLe/95ZuPx1r
 mlXxlaWwqL8W5qPLTemD15WkcU+rnuqONEzIgUIrN98Jxol3C31HiwdbfcBMtdLgzWpO
 2vhFpsRRfJQJ5sLQgEouSGpZo+vJUtxW8BC3jtWkhmRveySahLyOyAk670qkrj9F5UVJ
 o9PmBQ7anG7+hnHTWK19cMLmN5oo0uC5e6qyYX+mWmgeWkAV1qoisLvtoSSCcDiuSxJa
 JQq0LMVw+I6aCCSM4GIsyxoPEptqUx7nNi/14oZ8t+68TU6oPr1ny5At4GLFFyIGYXG2
 LtXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUEzni9ickpnpM8Jl1xgIdU4riPZ/NUa9J2B+/Ijo4awLGwY43LzCV7bc+9KXgM70cjDXbyQxgj/t5in42eiSyAvGKe+8=
X-Gm-Message-State: AOJu0YzMJeDuh6UCehpn9NfQlksRIvhMPvWN6ngElhUhbncznP9QRUe7
 ahKgfmeAVX1QI/iGpM+DCYKicqfivSZ84GXRbNmCttQtpKE8ILWaJ+beKJALqpM=
X-Google-Smtp-Source: AGHT+IFNVeGkzZeWIeQ9AQB9O19sA2LWQ6DXxeZjMSpbcQEL3rNw5B3Xftdlen22gkgT+SCcDnXC1g==
X-Received: by 2002:a17:906:f1d0:b0:a77:deb2:8af2 with SMTP id
 a640c23a62f3a-a77deb2b7fdmr373921866b.16.1720426008203; 
 Mon, 08 Jul 2024 01:06:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.151])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a40a6d4bsm8783443f8f.51.2024.07.08.01.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 01:06:47 -0700 (PDT)
Message-ID: <f52c6660-3a1c-449e-93c0-07e4cefebef3@linaro.org>
Date: Mon, 8 Jul 2024 10:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Peter Xu <peterx@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com> <ZoQ8cCrPXgK8I6b6@x1n>
 <84a7b513-228c-4c8e-8519-6ab465d4e8c8@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84a7b513-228c-4c8e-8519-6ab465d4e8c8@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/7/24 13:59, Akihiko Odaki wrote:
> On 2024/07/03 2:44, Peter Xu wrote:
>> On Thu, Jun 27, 2024 at 10:37:52PM +0900, Akihiko Odaki wrote:
>>> A memory region does not use their own reference counters, but instead
>>> piggybacks on another QOM object, "owner" (unless the owner is not the
>>> memory region itself). When creating a subregion, a new reference to the
>>> owner of the container must be created. However, if the subregion is
>>> owned by the same QOM object, this result in a self-reference, and make
>>> the owner immortal. Avoid such a self-reference.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   system/memory.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 74cd73ebc78b..949f5016a68d 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -2638,7 +2638,10 @@ static void 
>>> memory_region_update_container_subregions(MemoryRegion *subregion)
>>>       memory_region_transaction_begin();
>>> -    memory_region_ref(subregion);
>>> +    if (mr->owner != subregion->owner) {
>>> +        memory_region_ref(subregion);
>>> +    }
>>> +
>>>       QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>>>           if (subregion->priority >= other->priority) {
>>>               QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
>>> @@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion 
>>> *mr,
>>>           assert(alias->mapped_via_alias >= 0);
>>>       }
>>>       QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
>>> -    memory_region_unref(subregion);
>>> +
>>> +    if (mr->owner != subregion->owner) {
>>> +        memory_region_unref(subregion);
>>> +    }
>>> +
>>>       memory_region_update_pending |= mr->enabled && subregion->enabled;
>>>       memory_region_transaction_commit();
>>>   }
>>
>> This does look like a real issue.. the patch looks reasonable to me, 
>> but I
>> wonder whether we should start to add some good comments in code to 
>> reflect
>> that complexity starting from this one.  The MR refcount isn't easy to
>> understand to me.
>>
>> It also lets me start to wonder how MR refcount went through until it 
>> looks
>> like today..  It's definitely not extremely intuitive to use mr->owner as
>> the object to do refcounting if mr itself does has its own QObject,
>> meanwhile it has other tricks around.
>>
>> E.g. the first thing I stumbled over when looking was the optimization
>> where we will avoid refcounting the mr when there's no owner, and IIUC it
>> was for the case when the "guest memory" (which will never be freed) used
>> to have no owner so we can speedup DMA if we know it won't go away.
>>
>> https://lore.kernel.org/qemu-devel/1450263601-2828-5-git-send-email-pbonzini@redhat.com/
>>
>> commit 612263cf33062f7441a5d0e3b37c65991fdc3210
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Wed Dec 9 11:44:25 2015 +0100
>>
>>      memory: avoid unnecessary object_ref/unref
>>      For the common case of DMA into non-hotplugged RAM, it is 
>> unnecessary
>>      but expensive to do object_ref/unref.  Add back an owner field to
>>      MemoryRegion, so that these memory regions can skip the reference
>>      counting.
>>
>> If so, it looks like it will stop working with memory-backends get
>> involved?  As I think those MRs will have owner set always, and I wonder
>> whether memory-backends should be the major way to specify guest 
>> memory now
>> and in the future.  So I'm not sure how important that optimization is as
>> of now, and whether we could "simplify" it back to always do the refcount
>> if the major scenarios will not adopt it.
>>
>> The other issue is we used owner refcount from the start of
>> memory_region_ref() got introduced, since:
>>
>> commit 46637be269aaaceb9867ffdf176e906401138fff
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:   Tue May 7 09:06:00 2013 +0200
>>
>>      memory: add ref/unref
>>
>> And we still have that in our document, even though I don't think it's 
>> true
>> anymore:
>>
>>   * ...  MemoryRegions actually do not have their
>>   * own reference count; they piggyback on a QOM object, their "owner".
>>   * This function adds a reference to the owner.
>>
>> It looks like what happened is when introduced the change, MR is not a 
>> QOM
>> object yet.  But it later is..
>>
>> I mentioned all these only because I found that _if_ we can keep mr
>> refcounting as simple as other objects:
>>
>> memory_region_ref(mr)
>> {
>>      object_ref(OBJECT(mr));
>> }
>>
>> Then looks like this "recursive refcount" problem can also go away.  I'm
>> curious whether you or anyone tried to explore that path, or whether 
>> above
>> doesn't make sense at all.
> 
> It unfortunately does not solve the problem.
> 
> The underlying problem is that the whole device must be kept alive while 
> its memory region are. Indeed MemoryRegions do have refcounts, but 
> incrementing them do not extend the lifetime of the devices (i.e., the 
> owners). The refcount of the owners must be incremented for correctness.
> 
> Referencing a subregion MemoryRegion from its container MemoryRegion 
> owned by the same device is an exceptional case. Incrementing the 
> refcount of the owner extends the owner's lifetime to forever.

Is it really an exceptional case?

What I'm seeing are a lot of devices creating MR and never bother
to destroy them, so indeed owner (device) refcount never reaches 0.

Most of the time when we create MR in .instance_init/.realize,
we neglect to implement the undo path (.instance_finalize or
.unrealize).

