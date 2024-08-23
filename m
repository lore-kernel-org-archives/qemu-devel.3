Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AFBC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNcQ-0005Tu-FA; Fri, 23 Aug 2024 02:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNcO-0005MI-DX
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:17:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNcL-0003sx-Fz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:17:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-201fba05363so13295535ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393868; x=1724998668;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEhTIxiMdcSFu/oeJwhqekqf80o8895SfqhEvxUoXLw=;
 b=oiHeMAINyXIcE5RWeVChkdvLgArpmsSHmQ9UcIc7ivEDsoDnxi62LtiAgwmqF6rCQm
 wgX+PPGmcj5/rsRelSPXQ5GKcUnl4RWrHe9cA4W3E0xA+FPQlwkQ3x1cWH57oroOvyS3
 6NDF++34Ii9QkmpmeYMuiYmYsmY0dYZTL9uOfxwRmmrpt8Q2YiBHplPmVRz/pGmdJkkv
 fU2in2zrw+Umr8R8anWdP7cYykvwP8Frcsfuoo8YVG8w+DODIUfEktZkNxP5zN9dSIST
 XxpfZVQFHLNg47hkWya2iaMoPqL+IaWv7pFGmHOYmlq0Kq0Pc1vB2lS6XAaG795hf5XK
 IW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393868; x=1724998668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bEhTIxiMdcSFu/oeJwhqekqf80o8895SfqhEvxUoXLw=;
 b=D4wTzIYeeIG9YZ9U1AMu0teMcGQR3ojQ8rUQYTOzKQoQa7lC217ff98mTqThp0wIzE
 58s7YKeH/CpBgbwYLRxHQG6xUzwvYsKW2hVzceaeN/qdRjP0Q2DS4vEtjliEXV/p+xv/
 xZNp35S4Wf2/IyueC2FHApvX8LbnX5AipE+7Dw93Ydqt7WrKMc7I/Ppk1SgPNJLuu9vs
 YMSzAwwlmmtdqYrzRReOp1uNtqlOXAfdHCFibC74i+Y2tpudoSHgNadmIOd6MvSagQXj
 3RiLU7O65jtSKAX7pQ6NLzAmkGpziMxSGZIe8s9nfRAq/+P62rQFD3YXt2VUzT5MYR6o
 bc3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8qI/yb4v5uEMHXQeyPem14NoJXMWSRDT/JNNiMqwNMEaspoVIYAjT7SsjkBP6o06GKDmKRNrJc1zH@nongnu.org
X-Gm-Message-State: AOJu0YzhowIxGoo0BwLV7/+P8fkLvzgqbk+N/kMG19j+dyGLPkHYQOIG
 YlZAeEDNnyv17kLtkpc9IRuRJnzNQ9ICuGHDufdM9DrDECZJRi64CcBfx3ustfY=
X-Google-Smtp-Source: AGHT+IGirgNR8Ji38Pw7rZNWp/qdycpbe6l3foimze7j5FIrQwHvcNGWj+4ED4siWrZXBRKy1DeWrA==
X-Received: by 2002:a17:902:c411:b0:203:a046:c676 with SMTP id
 d9443c01a7336-203a046c87cmr9151025ad.0.1724393868031; 
 Thu, 22 Aug 2024 23:17:48 -0700 (PDT)
Received: from [157.82.207.23] ([157.82.207.23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385567d66sm21717935ad.53.2024.08.22.23.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:17:47 -0700 (PDT)
Message-ID: <067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com>
Date: Fri, 23 Aug 2024 15:17:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com>
 <CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com>
 <ZsenKpu1czQGYz7m@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZsenKpu1czQGYz7m@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2024/08/23 6:01, Peter Xu wrote:
> On Thu, Aug 22, 2024 at 06:10:43PM +0100, Peter Maydell wrote:
>> On Thu, 27 Jun 2024 at 14:40, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> A memory region does not use their own reference counters, but instead
>>> piggybacks on another QOM object, "owner" (unless the owner is not the
>>> memory region itself). When creating a subregion, a new reference to the
>>> owner of the container must be created. However, if the subregion is
>>> owned by the same QOM object, this result in a self-reference, and make
>>> the owner immortal. Avoid such a self-reference.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   system/memory.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 74cd73ebc78b..949f5016a68d 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>>>
>>>       memory_region_transaction_begin();
>>>
>>> -    memory_region_ref(subregion);
>>> +    if (mr->owner != subregion->owner) {
>>> +        memory_region_ref(subregion);
>>> +    }
>>> +
>>>       QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>>>           if (subregion->priority >= other->priority) {
>>>               QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
>>> @@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
>>>           assert(alias->mapped_via_alias >= 0);
>>>       }
>>>       QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
>>> -    memory_region_unref(subregion);
>>> +
>>> +    if (mr->owner != subregion->owner) {
>>> +        memory_region_unref(subregion);
>>> +    }
>>> +
>>>       memory_region_update_pending |= mr->enabled && subregion->enabled;
>>>       memory_region_transaction_commit();
>>>   }
>>
>> I was having another look at leaks this week, and I tried
>> this patch to see how many of the leaks I was seeing it
>> fixed. I found however that for arm it results in an
>> assertion when the device-introspection-test exercises
>> the "imx7.analog" device. By-hand repro:
>>
>> $ ./build/asan/qemu-system-aarch64 -display none -machine none -accel
>> qtest -monitor stdio
>> ==712838==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> QEMU 9.0.92 monitor - type 'help' for more information
>> (qemu) device_add imx7.analog,help
>> qemu-system-aarch64: ../../system/memory.c:1777: void
>> memory_region_finalize(Object *): Assertion `!mr->container' failed.
>> Aborted (core dumped)
>>
>> It may be well be that this is a preexisting bug that's only
>> exposed by this refcount change causing us to actually try
>> to dispose of the memory regions.
>>
>> I think that what's happening here is that the device
>> object has multiple MemoryRegions, each of which is a child
>> QOM property. One of these MRs is a "container MR", and the
>> other three are actual-content MRs which the device put into
>> the container when it created them. When we deref the device,
>> we go through all the child QOM properties unparenting and
>> unreffing them. However, there's no particular ordering
>> here, and it happens that we try to unref one of the
>> actual-content MRs first. That MR is still inside the
>> container MR, so we hit the assert. If we had happened to
>> unref the container MR first then memory_region_finalize()
>> would have removed all the subregions from it, avoiding
>> the problem.
>>
>> I'm not sure what the best fix would be here -- that assert
>> is there as a guard that the region isn't visible in
>> any address space, so maybe it needs to be made a bit
>> cleverer about the condition it checks? e.g. in this
>> example although mr->container is not NULL,
>> mr->container->container is NULL.
> 
> If we keep looking at ->container we'll always see NULL, IIUC, because
> either it's removed from its parent MR so it's NULL already, or at some
> point it can start to point to a root mr of an address space, where should
> also be NULL, afaiu.
> 
>> Or we could check whether the mr->container->owner is the same as the
>> mr->owner and allow a non-NULL mr->container in that case.  I don't know
>> this subsystem well enough so I'm just making random stabs here, though.
> 
> If with the assumption of this patch applied, then looks like it's pretty
> legal a container MR and the child MRs be finalized in any order when the
> owner device is being destroyed.
> 
> IIUC the MR should be destined to be invisible until this point, with or
> without the fact that mr->container is NULL.  It's because anyone who
> references the MR should do memory_region_ref() first, which takes the
> owner's refcount.  Here if MR finalize() is reached I think it means the
> owner refcount must be zero.  So it looks to me the only possible case when
> mr->container is non-NULL is it's used internally like this.  Then it's
> invisible and also safe to be detached even if container != NULL.

It is still nice if we can protect internal uses; it is theoretically 
possible for the owner to remove the subregion at runtime, and we want 
to ensure the subregion will be kept alive while its container is even 
in such a case. We can do so by creating a reference to the subregion 
itself instead of its owner. I sent v4 for this change.

Regards,
Akihiko Odaki

