Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499CDC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinbj-0002Ar-Gv; Tue, 27 Aug 2024 00:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sinbi-00028W-8G
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 00:15:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sinbf-0007YK-Py
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 00:15:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-715c160e231so424056b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724732098; x=1725336898;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqHqJgbZo0KivzNdU2q5jwvgD2jxYYEOXuDIiJYz5Ow=;
 b=iig2qPxJYPYm8MPoMMl8LQMXG4KWRLeZ4oYfTu3NI6rYr5CCtHNj3qjGqCcH6XnJro
 KXeFk6eZQ+sq+bXbhxtf+1GWyPY8gu+iXInTDKsayb5/HVhI2Zb+C7hGNAJmA+/db/34
 Htwr5JXZtHUCMFZPxIydYwDJJ6IBFn5lkFUYkruWZ0HHIKlPoHvzGMvRORSkpOpQqL9L
 7ci4hYtYMhP038xjBQ1i0Id9MZacULV2V7vk95aDP20BTYm1T4KbXBlDcLZ34WXA2RMZ
 yHPqjSBiNG9FZZCHpRzx+wvXezFx8N86lhVBGKuDoaQtaKLPYQs1uhDxFB6yzb1JjJ/h
 ehRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724732098; x=1725336898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gqHqJgbZo0KivzNdU2q5jwvgD2jxYYEOXuDIiJYz5Ow=;
 b=hLVKJCdbYFrGEHbhAyK92SdIbmt5uxYaSpNKWtIBuXfH0J1qS2Kp4F97/94XCuoQXk
 hkccBWfgt4hPN+fFV/PlcFM+Vk6bjhCRaB/DYe8WW99hMXE0s6PGgh786rywZnZyJWu6
 SYKhH7EDMXkeqxy9DS4Z/vLrfkWoO80y+ltsh6YuAdUudgNDA6IuG/ClngaiIi5kfGwx
 LXz424QOobEH7rA32kG+DcCgmd075IYWwZ5jGdkqu4rfaXij9+hqjTD8rg3m75Eayq/P
 EYNOq7uxmQcsYevBuGYxk2H5c1GQOWO+x6e5l5UsvMTT8vh4WsuxsTLLpkt4+suMvlfH
 vR1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3uju8DLa+cVBrQwA8EaOfF5v61Bu3rW3O+TcPNRF/H5AC266SweGzUi7NpVSHZh0c3Yoy1wZcbccd@nongnu.org
X-Gm-Message-State: AOJu0Yxqq8vZEBH2SmpaPoyazJ7noyon4D46oKWuspbPEl6ib/uIrQy2
 ECsGlZj793FY2E2QhUxn+0DlPS6oYSus4SbN6RrYn6DPSeyM/2j8sD8UPQP4i8vBZK2tusB2ajj
 I+kg=
X-Google-Smtp-Source: AGHT+IEX+vktriqedvW77C7o2NsHfmlTbtnnhXhPVKaFNYcPaGe6FADrQc8GrAK/fmY7ZTpbq+TtWg==
X-Received: by 2002:a05:6a00:3cd1:b0:714:2533:1b82 with SMTP id
 d2e1a72fcca58-714458667a7mr13972730b3a.23.1724732097878; 
 Mon, 26 Aug 2024 21:14:57 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434231362sm8025850b3a.11.2024.08.26.21.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 21:14:57 -0700 (PDT)
Message-ID: <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
Date: Tue, 27 Aug 2024 13:14:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
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
 <Zszain3SH5cl9ohH@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zszain3SH5cl9ohH@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

On 2024/08/27 4:42, Peter Xu wrote:
> On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
>> On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
>>>> memory_region_update_container_subregions() used to call
>>>> memory_region_ref(), which creates a reference to the owner of the
>>>> subregion, on behalf of the owner of the container. This results in a
>>>> circular reference if the subregion and container have the same owner.
>>>>
>>>> memory_region_ref() creates a reference to the owner instead of the
>>>> memory region to match the lifetime of the owner and memory region. We
>>>> do not need such a hack if the subregion and container have the same
>>>> owner because the owner will be alive as long as the container is.
>>>> Therefore, create a reference to the subregion itself instead ot its
>>>> owner in such a case; the reference to the subregion is still necessary
>>>> to ensure that the subregion gets finalized after the container.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   system/memory.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 5e6eb459d5de..e4d3e9d1f427 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>>>>
>>>>       memory_region_transaction_begin();
>>>>
>>>> -    memory_region_ref(subregion);
>>>> +    object_ref(mr->owner == subregion->owner ?
>>>> +               OBJECT(subregion) : subregion->owner);
>>>
>>> The only place that mr->refcount is used so far is the owner with the
>>> object property attached to the mr, am I right (ignoring name-less MRs)?
>>>
>>> I worry this will further complicate refcounting, now we're actively using
>>> two refcounts for MRs..

The actor of object_ref() is the owner of the memory region also in this 
case. We are calling object_ref() on behalf of mr->owner so we use 
mr->refcount iff mr->owner == subregion->owner. In this sense there is 
only one user of mr->refcount even after this change.

>>>
>>> Continue discussion there:
>>>
>>> https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
>>>
>>> What I don't see is how mr->subregions differs from mr->container, so we
>>> allow subregions to be attached but not the container when finalize()
>>> (which is, afaict, the other way round).
>>>
>>> It seems easier to me that we allow both container and subregions to exist
>>> as long as within the owner itself, rather than start heavier use of
>>> mr->refcount.
>>
>> I don't think just "same owner" necessarily will be workable --
>> you can have a setup like:
>>    * device A has a container C_A
>>    * device A has a child-device B
>>    * device B has a memory region R_B
>>    * device A's realize method puts R_B into C_A
>>
>> R_B's owner is B, and the container's owner is A,
>> but we still want to be able to get rid of A (in the process
>> getting rid of B because it gets unparented and unreffed,
>> and R_B and C_A also).
> 
> For cross-device references, should we rely on an explicit call to
> memory_region_del_subregion(), so as to detach the link between C_A and
> R_B?

Yes, I agree.

> 
> My understanding so far: logically when MR finalize() it should guarantee
> both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
> commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
> beginning we don't assert on ->container==NULL yet).  It requires all
> device emulations to do proper unrealize() to unlink all the MRs.
> 
> However what I'm guessing is QEMU probably used to have lots of devices
> that are not following the rules and leaking these links.  Hence we have
> had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
> it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.
> 
> What I was thinking is this comment seems to apply too to mr->container, so
> that it should be safe too to unlink ->container the same way as its own
> subregions. >
> IIUC that means for device-internal MR links we should be fine leaving
> whatever link between MRs owned by such device; the device->refcount
> guarantees none of them will be visible in any AS.  But then we need to
> always properly unlink the MRs when the link is across >1 device owners,
> otherwise it's prone to leak.

There is one principle we must satisfy in general: keep a reference to a 
memory region if it is visible to the guest.

It is safe to call memory_region_del_subregion() and to trigger the 
finalization of subregions when the container is not referenced because 
they are no longer visible. This is not true for the other way around; 
even when subregions are not referenced by anyone else, they are still 
visible to the guest as long as the container is visible to the guest. 
It is not safe to unref and finalize them in such a case.

A memory region and its owner will leak if a memory region kept visible 
for a too long period whether the chain of reference contains a 
container/subregion relationship or not.

Regards,
Akihiko Odaki

