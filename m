Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC27D25032
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 02:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vel2S-0001U3-0H; Sat, 10 Jan 2026 21:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vel2Q-0001Tn-AX
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 21:18:42 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vel2O-0005WE-NC
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 21:18:42 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8b2148ca40eso777068085a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 18:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768097919; x=1768702719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3U3CXAAL0glLs/4yD1rg7oZdMqEps18KkmBFC3bdYhA=;
 b=sVxEMuWH1FD/eL5gY2+QBXZbKd8cEXeyLTqW8JwgSdUFRL6ZAa8YlguoxdhYA07Xeg
 PTcRVIJlQLZCN3XpPR0BqQ/oL7gftxQZC9gCZSHql10PAqejyy40j3pXEnJQB7Ie9IO2
 /LgG+VIVgP54A1Djeo8ooTL1sibL8gyjkxphY7pdHsC08d5xzGMim/UEPJnO1Ky/YceL
 KgLoAaJf29PSxGE76Rw04/3LpEUO05MWw8bYd0WTKkh4NOxwNx4luOQpXH0WRWfMBX/T
 +/k96nzyfIdQYWf08d4W3RhItO6T4xtnh3mIqMpCAO3jB1nAY44j1r5VH02HMgZqYJVq
 OKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768097919; x=1768702719;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3U3CXAAL0glLs/4yD1rg7oZdMqEps18KkmBFC3bdYhA=;
 b=eWhS6G1i4+F+Np19KzsLWB46GCXDzrKRvu9GhwWO3N27Jpn180P9/Fol2Qa8N6n+wW
 z2YuZUVOQkrL9wYv+NeM5w7BH4B4VGmmZriZZTHiLhwDSfXOzday/l84fcDRj1Fe7Um8
 ntsjarwcEDT2F90+zSwADxzxDi6NKwhsFjQlIjhcBGDDqNVUkgG10uFq82TtMlwVcojM
 2etCeukqyPOTJeREUMlPmX5NDQ3sIdgD5BqDLYNX8wYlW2ziqI8qazAm8iwvwaxXf1R3
 MFPo09Ejn8w6uR14lRoiwD58uz1L5Ma45SaCLMwJGMnYsV745QdFj5ldG7h7ytVNcrO5
 HXDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVThKKkhxIXtjY+X7a8A5aFrXdzRBpV261qbjAQdlUFfIzVTZpXMCkf6m6M/RPDxboy8Ge5hCAfrddz@nongnu.org
X-Gm-Message-State: AOJu0YxW7Corj4T2myZ9cfuDoxJYn4H558/yrheVLBFkVAQ9UgYOM6VI
 G1NCuw18hEW8bt7kuSgVwhP1P7buZz4y9IFWDLsOKMh+ESXBie8X1Eg676dT1Pcldi06lavLoJr
 UsSYSeuA=
X-Gm-Gg: AY/fxX5DqqZN7i/i9yxmCq9Xe1Ux9hO1kC/KwrYcu9UKqzVVG1mgrTDVhfOqD9CSIjn
 ZFw9TlfV/uNhjuNGeNjXJoII9jrutjgmb4h+ypKxyAKnGc4hymvmTzcUDFO8t1p+45Pf4si5XkT
 5RknzFqIc3690EQq59EcSA+LyAs5aGxyAygmWBQThEvXUJZw2dpWlmAt+d9QKkvgNg3roWChGUj
 /6aTDYIHM93HNSTYg4gU8TbYscUVIJESChSAcjgaPmA4ABryPxlAMLeynxigbHKgj0WvwPTFxmg
 +kFqXn6o94WgxIL6wN7m4VALx0kp43BfVlj+jra1Sa2iNNXi9xYq1ul/MVNRMbHKmJNUtvomS1y
 Q3jwT7eJBm3ros/s0CF+iyhp26c48jFt38dY37ZQYe6O8/miHjljR5hCYh9yUKD+/qv0bPoEwVu
 RCiQSJCtJV1/qF1VKC3nykd8+I8ASC7hvlFkODOjzn+dkLz/AGw5M=
X-Google-Smtp-Source: AGHT+IHqbxlW2om4SgINWKZVypwd17haAfE2HfVZtebs0VpeFmaGrvdLQVuyQqhfcPWfXaZ8GLbxXQ==
X-Received: by 2002:a05:620a:6ccd:b0:8b2:e17a:37 with SMTP id
 af79cd13be357-8c3893f239bmr1993280885a.43.1768097919092; 
 Sat, 10 Jan 2026 18:18:39 -0800 (PST)
Received: from [10.244.221.227] ([172.56.17.242])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm1177417785a.29.2026.01.10.18.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 18:18:38 -0800 (PST)
Message-ID: <9f980a91-91a0-4869-9aee-7338fa3c04ef@linaro.org>
Date: Sun, 11 Jan 2026 13:18:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user: fix several mremap bugs
To: Matthew Lugg <mlugg@mlugg.co.uk>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org
References: <20251117170954.31451-1-mlugg@mlugg.co.uk>
 <6d599944-329b-434a-bac3-1f9917f4cc2c@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6d599944-329b-434a-bac3-1f9917f4cc2c@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/6/26 23:04, Matthew Lugg wrote:
> On 11/17/25 17:09, Matthew Lugg wrote:
>> This version of the series should address all feedback I received. The original
>> cover letter is replicated below.
>>
>> I was recently debugging a strange crash in a downstream project which turned
>> out to be a QEMU bug related to the `mremap` implementation in linux-user. In
>> practice, this bug essentially led to arbitrary memory regions being unmapped
>> when a 32-bit guest, running on a 64-bit host, uses `mremap` to shrink a memory
>> mapping.
>>
>> The first patch in this set resolves that bug. Since the patch is very simple,
>> and the bug is quite likely to be hit, I suspect that that commit is a good
>> candidate for qemu-stable.
>>
>> The following two patches just resolve two more bugs I became aware of whilst
>> working on this code. I believe the messages in those patches contain all
>> necessary context. They are less critical and the fixes more complex, so are
>> likely not suitable for backporting into qemu-stable.
>>
>> The final commits adds tcg tests for the fixed `mremap` behavior. The third fix
>> is unfortunately difficult to test programmatically, but I have confirmed that
>> it behaves as expected by observing the output of `strace qemu-i386 repro`,
>> where `repro` is the following C program:
>>
>>      #define _GNU_SOURCE
>>      #include <stddef.h>
>>      #include <sys/mman.h>
>>      int main(void) {
>>          char *a = mmap(NULL, 4097, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 
>> -1, 0);
>>          char *b = mmap(NULL, 4097, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 
>> -1, 0);
>>          mremap(b, 4097, 4097, MREMAP_FIXED | MREMAP_MAYMOVE, a);
>>          // QEMU has now leaked a page of its memory reservation!
>>          return 0;
>>      }
>>
>> Prior to the patch, as the comment says, QEMU leaks a page of its address space
>> reservation (i.e. the page becomes unmapped). After the patch, QEMU correctly
>> reclaims that page with `mmap`.
>>
>> Matthew Lugg (4):
>>    linux-user: fix mremap unmapping adjacent region
>>    linux-user: fix mremap errors for invalid ranges
>>    linux-user: fix reserved_va page leak in do_munmap
>>    tests: add tcg coverage for fixed mremap bugs
>>
>>   linux-user/mmap.c               | 16 ++++++++-----
>>   tests/tcg/multiarch/test-mmap.c | 42 +++++++++++++++++++++++++++++++--
>>   2 files changed, 50 insertions(+), 8 deletions(-)
>>
> 
> Hey everyone, just bumping this series since I suspect it got lost. It should be fairly 
> straightforward to get this in: patches 1 and 3 were already approved here, and 2 and 4 
> only have small changes since v1 to account for feedback.
> 
> Let me know if anything else is needed on my end---and happy new year!
> 

Queued, thanks.

r~

