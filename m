Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B3EE209D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLai-0005sh-Om; Fri, 06 Feb 2026 08:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voLac-0005s3-KC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voLaU-0003u7-CY
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770383367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JlJdHheWUH60uns2qEpK41jJlsH14qkH1xN4MzBEETc=;
 b=Zfcx8ew2o/qgvIT3J3oBWJMJDrHATumklFbkooo+thamsGOyQWU7GeaWj4K2Ymbcxec/Tw
 InUDG6lkRGu/0P4yN/uxAT6lsf3bPIgopte0HihmsJoN1nN9s16T7siBLaBeLDPEn/RLsu
 ODqSqyuwO3ggUoXJdGjk28Q26bWZN24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-bj8_TQTINRKz4YNQV1QgsA-1; Fri, 06 Feb 2026 08:09:26 -0500
X-MC-Unique: bj8_TQTINRKz4YNQV1QgsA-1
X-Mimecast-MFC-AGG-ID: bj8_TQTINRKz4YNQV1QgsA_1770383365
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435db9425ebso2140256f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770383365; x=1770988165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JlJdHheWUH60uns2qEpK41jJlsH14qkH1xN4MzBEETc=;
 b=AgMkve8+0UxvazAdlrInsoynUMca6kjusSVm0dnIYsITNwubIHDDuZYA42KGG0IIsj
 Y2WypH5T8LYVKk+cN3YS7OFDvlo9DfDZWd8PRVgyCKNs2c+x47zB6x98IJJm8c6rdscY
 1eeApGt3xvlnHup58Sxx9Z8BWw8bs8l9LsCWtXvckQlkHEcXxb465TPzNz9/gZheUa4F
 ZaLwWIWVPmciYo4yf1rFkVD9HgjsYGKKi/Ij9mYBvA9CZAZuzSKS9Dy3H+Qw4JfOjgdT
 aiTmE82AVJYwTDa+RsK1hY/0mpy/uNMwYXNBgwzolaXsMZ1w60kYH+sZpR/X3yGdZbk0
 q/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770383365; x=1770988165;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlJdHheWUH60uns2qEpK41jJlsH14qkH1xN4MzBEETc=;
 b=HGLkG4cIwFTnIfIPB74Z/qzDPfP8HVdR4o8xAIcav2yqE6j6E8ZI2JCrDNK6OeyOhm
 11eXhK0PL3sC0D0cCvd6gUOi7qiK1moEVKotFxxLGXVBJ+ta3UHY4ERh06Kpbz2pZFKU
 Hxl643uQsEBjceJXXNdua1lGYbDi52W5KAkD85agFQ0YJYttvwWnMyblxUOURQ8NMY/v
 C3BkJM3NmfVWzxl5ToVhVKpMr2Itoqj7WCf513zb8dJ7JNtyzodESRqCqVanfBVYrSrf
 VwNu1uKgBT9+Ut/3D/fmaUYHesZH7qTfX/Fu/BBvcjergBh/SKmyN5k/qOEkhF6AoNNB
 MLBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0VVZR6nwHxByQtVRy9d92u9GzYaq5XN8YUbnywNud8p1CZIUFy+Qia/S6Miu9COhqQk1gVptXDLb6@nongnu.org
X-Gm-Message-State: AOJu0Yys28FuZ+IO45PqsuM7ymCj6kWATsODH9Il+6BZsfVaLg5ErULP
 iaM+41j+ALmtJaPQGWkzXiFx2rrQyiA5TdJRpsI3sKMYEUfkC4LgS9tnZbYO9ebn37cbhIwLGj+
 q93hYFUxFKRkGnBEvMTY10i+7R01e3nYPkBl1xERs2iEK9g6LlEQzV9gT
X-Gm-Gg: AZuq6aLnW1RjciE47WB2s/F7pSZt0hhnUDUUMaXlmfdTbuRIjlYuwIJb1iWZN587H9K
 7V4igNkAvfcmA5IEQUDIT+gvW3q7q+5pdRZ/xhBPFcgm6l97yEhQzQGVMDkxTgSIWCMJs5/HES5
 lnzIrKDZKHRGDppnZKLOs5wrLOvQjo8PIZPzGUcC/GH4O7mwm6QdA0uagfENE+gyELOY9/mqGoK
 p558pS4TKxCAJfI7zNRJz2hACBRMCIbmmjPHmL4K9pOr2ysZEGSTBKFlDqCnJ5jzC2uZdbIvEjT
 6IYu9bj5/HU76RktQm3OzqiVSHs1SuO1SUgdE4YxoBEouD1Iztd6wAejL+tu/cVDvrHNAUQ2Ctt
 AzxFdDjE=
X-Received: by 2002:a5d:5d02:0:b0:436:213c:7784 with SMTP id
 ffacd0b85a97d-43629381b5amr4068879f8f.30.1770383364969; 
 Fri, 06 Feb 2026 05:09:24 -0800 (PST)
X-Received: by 2002:a5d:5d02:0:b0:436:213c:7784 with SMTP id
 ffacd0b85a97d-43629381b5amr4068825f8f.30.1770383364476; 
 Fri, 06 Feb 2026 05:09:24 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc1bsm5905715f8f.28.2026.02.06.05.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 05:09:24 -0800 (PST)
Message-ID: <665666b9-69a8-4b47-b706-341295d96371@redhat.com>
Date: Fri, 6 Feb 2026 14:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/s390x: Replace %target_ulong -> %vaddr
 where appropriate
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-4-philmd@linaro.org>
 <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
 <4eb5b630-dad5-4cd8-97a6-d1d4a3499400@linaro.org>
 <1c30cbc9f0c04b3da5a48bc20f8d9cacfeb11911.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1c30cbc9f0c04b3da5a48bc20f8d9cacfeb11911.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/02/2026 22.49, Eric Farman wrote:
> On Thu, 2026-02-05 at 22:37 +0100, Philippe Mathieu-Daudé wrote:
>> Hi Eric,
>>
>> On 5/2/26 22:23, Eric Farman wrote:
>>> On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daudé wrote:
>>>> Use the %vaddr type for virtual addresses.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    target/s390x/s390x-internal.h  | 5 +++--
>>>>    target/s390x/helper.c          | 2 +-
>>>>    target/s390x/mmu_helper.c      | 6 +++---
>>>>    target/s390x/tcg/excp_helper.c | 3 ++-
>>>>    4 files changed, 9 insertions(+), 7 deletions(-)
>>
>>
>>>> @@ -376,9 +377,9 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
>>>>    bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
>>>>    /* Special access mode only valid for mmu_translate() */
>>>>    #define MMU_S390_LRA        -1
>>>> -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>>>> +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
>>>>                      target_ulong *raddr, int *flags, uint64_t *tec);
>>>> -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>>>> +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
>>>
>>> I think this one should remain target_ulong, and become hwaddr in the next patch, no?
>>
>> Without s390x background, I don't understand well what real addresses
>> are. IFAICT the single caller s390_cpu_tlb_fill() provides a virtual
>> address. But then indeed mmu_real2abs() consumes a hwaddr as real addr.
> 
> Hi Philippe,
> 
> Ah, I didn't go the other direction (my bad). The usage of "real" here is kind of halfway between
> virtual and -really- real.

Yes, real addresses are like physical addresses in s390 land - except for 
the two so-called low-core pages that might be swapped with two other pages 
in memory.

> I suspect the caller is mistaken here, but I think that's a research
> project for tomorrow.

The caller s390_cpu_tlb_fill() seems to deal with both, real a virtual 
addresses, and uses the same variable for both, so I think that's fine there.
But I agree with Eric mmu_translate_real() should use "hwaddr" for the raddr 
parameter instead. Philippe, could you please adjust the patch?

  Thanks,
   Thomas


