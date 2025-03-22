Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C968C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 20:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tw5sh-0007cd-EO; Sat, 22 Mar 2025 16:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tw5sf-0007cI-Fj
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 16:55:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tw5sd-0005RB-A4
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 16:55:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22548a28d0cso46356415ad.3
 for <qemu-devel@nongnu.org>; Sat, 22 Mar 2025 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742676941; x=1743281741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgGmWC6PM5wLnaG1uyNrtF3HfvNjTFidfhpw5ptOU8I=;
 b=YLhJDCFUCgo+Ovh9pKAjOpHBjbaqs6/xJi8j6B52n9bhaKr4BKRV4C+PjYasyhWUhH
 XgRiZQKghXzV1R/NnNdSn9SrsU6sGV/gNW7cAus9QA3axAQ51NS8Y3nKTXiAa2vtmC/b
 kTXjdJ7GmKjyS1es7vWO/GG7reIGrcGYl12FCC+uIIRsjegqLIxrnTbkx9DO6lTC7t4z
 7seCLGUKIuVM6wi2iwgfXNkwgAxpEb0vei5MWduXKTB457QAMS2ugGLwIv3s1hnUrHgz
 iPojjJK99kDuTup4wfqVfVLyxfSXUh8QngIvxeZqEJ8KYbVq+1av3pcXDWtD9or3jStu
 x8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742676941; x=1743281741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgGmWC6PM5wLnaG1uyNrtF3HfvNjTFidfhpw5ptOU8I=;
 b=Ffso4ansKnVE703o0Sr22cQqg1Gd77vlxDw8HKZL/lrln2cVSHCPLQp21BITuNkcVc
 9Wxm48+O93HNKdB3TYTxtCR98+VYh6AKn1hyWI17W8PWK+xjOQtB0C2Q8/2fx26UN4Gd
 Z5ocSHjRpFiZFgx8Bfl9ZlcTYhbktJUsdX+CibOmDOKgVuKOfpMt+3JIL894WppixTj3
 zcmu9Gz+zzM64zxLEPFZR6dUSFQBem+SN1sU0B/TIjtpUXZghn9y0V61v1hztZHbdnfn
 62P/74o/mzyUN+IfABqsE2iQmhV4jQINf76hykWDbeyVa3V3Werpbi2UJc2DzHLUmduK
 qzYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7zI6PETH96xFWvOxES94wXoXOeoedoleoSlioQ3ZI7iMiiFsISPlMzqm6WlqS+wV9W+8A3odPx5xZ@nongnu.org
X-Gm-Message-State: AOJu0YxNSNqBAeCwVb2ORvGuiA4bfhWU/XlXrC249rpDM/Mwj6qW/IR1
 y9T0VAE8h8IkpPv3a4Mz/7BFSoztSqTQkxcI3KhAilEvrQxRGxaGH+b68Zm/DXw=
X-Gm-Gg: ASbGnct0MY0sI0kVK1ZNAytXm6YFQlaHrgIGj2/Ppd+JA0vONDhZ9mPbkAKiwpExluz
 iZnIjqF9QEZHHbyt8rwyC/hQUy6gntnlkLEVK5S/i1tEinZO37hoBJ128c+NcD7lMs3ebog9ler
 RJ+bVRHu99NHCt6hb3r0baYP/T3iuXheh2ZyIS1Tiz8dogCnniBCH6osh74q20JL8pHb97fFve5
 QR4ifKW6SwvGjKk5VaEvazFQjUStlwbLJx+6oSmnIVDz7vsBYkNvfSN0CTfJxaq/NpwC2rzxsDX
 uI9/xti6qOJrn7iW2ED6SvN4CHtYCFR15/ia9+czOI+HX4H7diS80khJgE9jM2r4QJD1j5x8sdE
 CEZPoFqnn
X-Google-Smtp-Source: AGHT+IF8bW/hQCXsQIR/yUOm9ZATK+QQ55egz4OhUwbr//UE3L/jkw+NaL2jvImzW0JB60ZAK94q9g==
X-Received: by 2002:a17:903:298b:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-22780c55886mr145113575ad.5.1742676941062; 
 Sat, 22 Mar 2025 13:55:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b242sm40132835ad.41.2025.03.22.13.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Mar 2025 13:55:40 -0700 (PDT)
Message-ID: <392cd6e5-0c73-4702-8733-d3047db76f77@linaro.org>
Date: Sat, 22 Mar 2025 13:55:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
 <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
 <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
 <ebd25730-1947-4360-af36-cf1131f4155c@linaro.org>
 <c1b7b73e-0a59-46cf-bf33-5712df5d9b75@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c1b7b73e-0a59-46cf-bf33-5712df5d9b75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/21/25 17:20, Pierrick Bouvier wrote:
> On 3/21/25 17:01, Pierrick Bouvier wrote:
>> On 3/21/25 15:19, Richard Henderson wrote:
>>> On 3/21/25 13:11, Pierrick Bouvier wrote:
>>>> On 3/21/25 12:27, Richard Henderson wrote:
>>>>> On 3/21/25 11:09, Pierrick Bouvier wrote:
>>>>>>> Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but
>>>>>>> today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.
>>>>>>>
>>>>>>
>>>>>> When you mention this, do you mean "constant accross all architectures", or a global
>>>>>> (const) variable vs having a function call?
>>>>> The first -- constant across all architectures.
>>>>>
>>>>
>>>> That's great.
>>>> Does choosing the min(set_of(TARGET_PAGE_BITS_MIN)) is what we want there, or is the
>>>> answer more subtle than that?
>>>
>>> It will be, yes.
>>>
>>> This isn't as hard as it seems, because there are exactly two targets with
>>> TARGET_PAGE_BITS < 12: arm and avr.
>>>
>>> Because we still support armv4, TARGET_PAGE_BITS_MIN must be <= 10.
>>>
>>> AVR currently has TARGET_PAGE_BITS == 8, which is a bit of a problem.
>>> My first task is to allow avr to choose TARGET_PAGE_BITS_MIN >= 10.
>>>
>>> Which will leave us with TARGET_PAGE_BITS_MIN == 10.
>>>
>>
>> Ok.
>>
>>   From what I understand, we make sure tlb flags are stored in an
>> immutable position, within virtual addresses related to guest, by using
>> lower bits belonging to address range inside a given page, since page
>> addresses are aligned on page size, leaving those bits free.
>>
>> bits [0..2) are bswap, watchpoint and check_aligned.
>> bits [TARGET_PAGE_BITS_MIN - 5..TARGET_PAGE_BITS_MIN) are slow,
>> discard_write, mmio, notdirty, and invalid mask.
>> And the compile time check we have is to make sure we don't overlap
>> those sets (would happen in TARGET_PAGE_BITS_MIN <= 7).
>>
>> I wonder why we can't use bits [3..8) everywhere, like it's done for
>> AVR, even for bigger page sizes. I noticed the comment about "address
>> alignment bits", but I'm confused why bits [0..2) can be used, and not
>> upper ones.
>>
>> Are we storing something else in the middle on other archs, or did I
>> miss some piece of the puzzle?
>>
> 
> After looking better, TLB_SLOW_FLAGS are not part of address, so we don't use bits [0..2).
> 
> For a given TARGET_PAGE_SIZE, how do we define alignment bits?

Alignment bits are the least significant bits that must be 0 in order to enforce a 
particular alignment.  The specific alignment is requested via MO_ALIGN et al as part of 
the guest memory reference.

I think the piece you're missing is the softmmu fast path test in the generated code.

We begin by indexing the tlb to find an entry.  At that index, the entry may or may not 
match because (1) we have never looked up the page so the entry is empty, (2) we have 
looked up a different page that aliases, or (3) the page is present and (3a) correct, or 
(3b) invalidated, or (3c) some other condition that forces the slow path.

The target address and the comparator have several fields:

   page address   [63 ... TARGET_PAGE_BITS]
   page flags     [TARGET_PAGE_BITS - 1 ... TARGET_PAGE_BITS - 5]
   unused         [TARGET_PAGE_BITS - 6 ... align_bits], or empty.
   alignment      [align_bits - 1 ... 0], or empty

In the comparator, the unused and alignment bits are always zero; the page flags may be 
non-zero in order to force the comparison to fail.

In the target address, we mask the page flags and unused bits; if the alignment bits of 
the address are set, then the address is of course unaligned and so the comparison fails.

In order for all this work, the alignment field cannot overlap the page flags.

The maximum alignment currently used by any guest is 5 bits, for Arm Neon,
which means the minimum value for TARGET_PAGE_BITS_MIN is 10.


r~

