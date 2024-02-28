Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A92C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfPHb-0000tg-0f; Wed, 28 Feb 2024 14:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfPHZ-0000tS-7k
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:07:57 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfPHX-0004Oz-C6
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:07:56 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A50983F6A7
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709147270;
 bh=05gjVwxtgtg8tptbtRVZmLc2aKIJcWcnZbDNfiiUARI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Q8M3atK298pXicePOa7nycCCI9TYKJ+i9BxrjUSQc/gsvcWhg2m98PKIWvOsgil0f
 DkpNa3tLmFd2M93lBdjv4jJnL20jba21xMXZosvXiI/dMVG8XbTtV7JiGl8rtjiGTl
 0Qo1sOEI4vnrdcHP7e2RlX8EenKwLtYqj3j3NyjNMK3p82T2gn+Tw+GWwxuUxpj+lf
 z7zI1jmlh+ypKERGgJJa4ePqLiAPqoauUeSAU4Uzi9cAW25kFvCFXS6XLJq6N8Mj0V
 kRkS36djCB9p+Jz3DdiXDfguwnT7CejXqHJadj9p/mW4/W8oORrUzN7wHyjn7sQ1sY
 c5RNlc8RDhjmQ==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3fb52f121eso10746866b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 11:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709147270; x=1709752070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05gjVwxtgtg8tptbtRVZmLc2aKIJcWcnZbDNfiiUARI=;
 b=uDe2lDEOb6wM0durOCXopFluhkxxjigrKNAV7oIH5dl1HshbLiPSa93Lqh2tdKuD25
 4tmmZS8o1s1c3fDNwxfk4ElWlz/Xg7snIeWLIbgmgwLiguKrZsZaeF4cOTHzNIqxtp84
 2eAJU8RukZER3dclBYwG9EL/wa3z6A+Sub746aY4COLnGTLV8F4kUKvzWUpOkeA21AO6
 tAVezOoWb4pyDrx//43D8T7r0rIYFWF//NFSXr/uPMpWGxL4ZjvRkfjKSVO/EGp3AQNj
 VpucV5/wEgYu//Ef56R2vIMfOswGkHF55xdti5DpecD7w3ve3uZE35xrJYeopH8KJqzV
 zRSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRYbAkDW1xQREwE5oLuVrhcdXZRaKSwIUZGSawDgVuN5oxxOMaIlkYtAWvbVJKLnUGQGpXUcN69PzsjFsXc1dd6YfwlOQ=
X-Gm-Message-State: AOJu0YwjgmAbS+m/z7zjIEFmCYcXuoHttXEWZYzpCNrSqq/iSzZN+tMe
 t7Gghhxp6Hb0UUWeI0s06++8rrF9Ue+B+n0KGZQESyz9fzU2rb8NfhS8TIB2aQfdQltI/PGuApr
 ocoxqWvQ7n99xoKVxsifGhzPWrEIUcvdIcVW3ee7WJcvrry4204Fp9r9683BD9NILuPS4xPD9A3
 Aa
X-Received: by 2002:a17:906:7c51:b0:a3f:64ce:3a98 with SMTP id
 g17-20020a1709067c5100b00a3f64ce3a98mr463430ejp.10.1709147270212; 
 Wed, 28 Feb 2024 11:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE23cGPKxk9B6vp6nLZKrXX6wLDNEolbq8Ahay5gTVVnfIp6QsfLKGwsEpFiU/l4CGuVE3g/g==
X-Received: by 2002:a17:906:7c51:b0:a3f:64ce:3a98 with SMTP id
 g17-20020a1709067c5100b00a3f64ce3a98mr463408ejp.10.1709147269813; 
 Wed, 28 Feb 2024 11:07:49 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:59d8:16c:6bf7:73e4?
 ([2a00:20:10:8f6:59d8:16c:6bf7:73e4])
 by smtp.gmail.com with ESMTPSA id
 vk3-20020a170907cbc300b00a43a12c6311sm2104021ejc.166.2024.02.28.11.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 11:07:49 -0800 (PST)
Message-ID: <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
Date: Wed, 28 Feb 2024 20:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28.02.24 19:39, Peter Maydell wrote:
> On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 28.02.24 16:06, Philippe Mathieu-Daudé wrote:
>>> Hi Heinrich,
>>>
>>> On 28/2/24 13:59, Heinrich Schuchardt wrote:
>>>> virtqueue_map_desc() is called with values of sz exceeding that may
>>>> exceed
>>>> TARGET_PAGE_SIZE. sz = 0x2800 has been observed.
>>>>
>>>> We only support a single bounce buffer. We have to avoid
>>>> virtqueue_map_desc() calling address_space_map() multiple times.
>>>> Otherwise
>>>> we see an error
>>>>
>>>>       qemu: virtio: bogus descriptor or out of resources
>>>>
>>>> Increase the minimum size of the bounce buffer to 0x10000 which matches
>>>> the largest value of TARGET_PAGE_SIZE for all architectures.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v2:
>>>>      remove unrelated change
>>>> ---
>>>>    system/physmem.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index e3ebc19eef..3c82da1c86 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
>>>>                *plen = 0;
>>>>                return NULL;
>>>>            }
>>>> -        /* Avoid unbounded allocations */
>>>> -        l = MIN(l, TARGET_PAGE_SIZE);
>>>> +        /*
>>>> +         * There is only one bounce buffer. The largest occuring
>>>> value of
>>>> +         * parameter sz of virtqueue_map_desc() must fit into the bounce
>>>> +         * buffer.
>>>> +         */
>>>> +        l = MIN(l, 0x10000);
>>>
>>> Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
>>> TARGETS_BIGGEST_PAGE_SIZE?
>>>
>>> Then along:
>>>     QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <= TARGETS_BIGGEST_PAGE_SIZE);
>>
>> Thank you Philippe for reviewing.
>>
>> TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by the
>> page size.
>> How about MIN_BOUNCE_BUFFER_SIZE?
>> Is include/exec/memory.h the right include for the constant?
>>
>> I don't think that TARGET_PAGE_SIZE has any relevance for setting the
>> bounce buffer size. I only mentioned it to say that we are not
>> decreasing the value on any existing architecture.
>>
>> I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
>> e3127ae0cdcd ("exec: reorganize address_space_map") does not provide a
>> reason for this choice. Maybe Paolo remembers.
> 
> The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> which was the first implementation of this function. I don't think
> there's a particular reason for that value beyond that it was
> probably a convenient value that was assumed to be likely "big enough".
> 
> I think the idea with this bounce-buffer has always been that this
> isn't really a code path we expected to end up in very often --
> it's supposed to be for when devices are doing DMA, which they
> will typically be doing to memory (backed by host RAM), not
> devices (backed by MMIO and needing a bounce buffer). So the
> whole mechanism is a bit "last fallback to stop things breaking
> entirely".
> 
> The address_space_map() API says that it's allowed to return
> a subset of the range you ask for, so if the virtio code doesn't
> cope with the minimum being set to TARGET_PAGE_SIZE then either
> we need to fix that virtio code or we need to change the API
> of this function. (But I think you will also get a reduced
> range if you try to use it across a boundary between normal
> host-memory-backed RAM and a device MemoryRegion.)

If we allow a bounce buffer only to be used once (via the in_use flag), 
why do we allow only a single bounce buffer?

Could address_space_map() allocate a new bounce buffer on every call and 
address_space_unmap() deallocate it?

Isn't the design with a single bounce buffer bound to fail with a 
multi-threaded client as collision can be expected?

Best regards

Heinrich

