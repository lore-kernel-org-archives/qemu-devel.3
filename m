Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6E8E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmryv-0006hi-G9; Mon, 02 Feb 2026 06:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmryt-0006hH-SL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:20:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmryr-0001xY-JO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:20:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so4151379f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770031232; x=1770636032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBFirCWvd4NiNRnXJ2dvlbq1DQ8TBxs9IRukCSqUTA4=;
 b=e0tLWvYV+b8pA3S+qxlIyQtGiD2zkJZWAMcd8ZKnlqybvpizF1Mjh9li/kYa6jVnUS
 78iBQvMUxTjoxpa7BNbasXZBYSOQ3hNCr8zqvlBMjMtQ6++iojQ2uKt61eOkEtfmUI22
 UHe92WqDHq8v5C4AU+LYHHx4fAvm+LO83moOr5M5Sfckd7Py0aPCGO23nGfa5uFkihJK
 +sTbShu2Furkg5hikehyH/LYT9UN3wM2+QR6DpXedegZ1+vlO1TuwO6+6/27a2tyOY9j
 NgJ2GxjL5SFPiA86ZQw+/IB4ZxL9WUSWcEWjWG31vL9b7ncEvTfNVXPXx6VcUb4mwJHQ
 Tu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031232; x=1770636032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DBFirCWvd4NiNRnXJ2dvlbq1DQ8TBxs9IRukCSqUTA4=;
 b=W63F4LZgD+0c/NOIWSQlgX5R443dohCaWqEF9cpIy+5wzMlK4Um7mGxU5LrbrOGsYm
 u5tfKPUMorL0OtO0U5yhSt2Gc8wLI07ugEADlydEqxopUYfEhzaeKH/xqgrZHf+d9rIL
 6NBif2dWoE0cL4lNSylk/RQN55Lu6KCeJxRYex2UDHEQH52nJavW0wZrKrnSUxN4ECiF
 J/SJgYR7q4I6pbPXhtBbrkI4sSv/vUr0MOt5JcFHOd59zkV9rmgoqD5g9N3u80/Eu/TE
 oGAFxbuIslfeKPeTPETvGnF1yfkrHp4a0Eh6VHsM8cVJfnJlCzwDPc0ZWfWqj2rmJTsu
 UF/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8na1HfDAo6TyFtlBg0rvTRaldVW0OlONMXPeDQ9UcRBhwLEW+Dm0Nf1oxg4wNEEXZdTBHz5ntTKFG@nongnu.org
X-Gm-Message-State: AOJu0Ywc1lje56oYN/Gp3Sd3mM7iv7TXff2UI0HJZliL6Bj2G+hHfOl1
 JrnqbIarC4ERqIMFPB3wWnxoNtDpYoFv3p1F+tLR6O/4Y3BlUT76Lj/ndy5aHcAw8ag=
X-Gm-Gg: AZuq6aI3D6xDkGHOqoT5aP4YL60HuXMTcXuBUzp+xipTKzKoPFxARXRh814kT1jyMr7
 ZXr+9aBuYo4vtggb1VRNuzj0BbhFEMF9xJmTmse+SG444NfYIgquqYH3AQcoXcHjw9Usm0nlKwz
 TqwJVcy3vD1hELMC1aRp7Wq+nRtalsUqeXMhMcQ9UM4WZ1XbzVoECGYdSu6+3HUzsqdeAafTBHg
 JL5VtmUtGc+Z0cpuTSbajtakAmFhct4gVE7jJzEAQMSY6c0pO4BtPwdyQ+tiVx94ARN/CSTRkW8
 RcT/gwc/bqa6zfO+iTyA8+iaCDM9oIZl2uta9vd/q/Ci8y+wH+8E1CpblD+zfj+Rr/LntzJ89Qr
 zV3CvC9QJgsE6ns3iwhg2CVcf+pyrWlTRdZilLJG0dho0Kt0H0QTVV2ObTOWcoxF9j7r/TaQSOv
 2P2V8PMsv1gMy1eyCfUYVF9cN4cwV4peUDfQLfaDzRFC6n2I6Jek0qtQ==
X-Received: by 2002:a5d:634a:0:b0:436:684:b94a with SMTP id
 ffacd0b85a97d-4360684b9a6mr4190890f8f.4.1770031231594; 
 Mon, 02 Feb 2026 03:20:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee078sm43424642f8f.16.2026.02.02.03.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 03:20:31 -0800 (PST)
Message-ID: <6f175d60-6544-4dc9-99eb-71f60c305017@linaro.org>
Date: Mon, 2 Feb 2026 12:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mjt@tls.msk.ru,
 whollins@google.com, jansene@google.com, jpcottin@google.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
 <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
 <0954062c-c032-42be-ad0d-df2559360963@linaro.org>
 <CAFEAcA-ShmtJ2tOO_bz+d_oKJaDTG15bc9s775mND=FLWQdRpw@mail.gmail.com>
 <aYCD4g7x8DDH4tyW@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aYCD4g7x8DDH4tyW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/2/26 12:00, Daniel P. Berrangé wrote:
> On Fri, Jan 30, 2026 at 09:19:32AM +0000, Peter Maydell wrote:
>> On Thu, 29 Jan 2026 at 21:44, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Hi Peter,
>>>
>>> (+Paolo / Eric)
>>>
>>> On 29/1/26 21:31, Peter Maydell wrote:
>>>>
>>>> What are we trying to achieve here, and why does it benefit
>>>> us as an upstream project ?
>>>>
>>>> cf previous email thread from 2024
>>>> https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
>>>> about "drip-feeding" of this kind of patch with no clear take
>>>> on what the end state is or how much churn it's going to induce.
>>>
>>> I clearly know QEMU is not a C++ project. Now I don't see why we should
>>> be reluctant to have headers being usable by a C++ compiler, as long as
>>> it doesn't make our project worst to maintain.
>>
>> Every bit of code that is written by some downstream in C++ is
>> some thing that will essentially then never be upstreamed without
>> a big rewrite. So making it easier for downstreams to use C++
>> reduces our chances of seeing them contribute what they do back to us.
>>
>> It's also extra work for us (for instance in this thread you
>> proposed adding a CI job, which is more CI minutes cost to
>> the project, more work for maintainers when something that
>> builds fine locally falls over in the CI, and so on).
>>
>> Each individual fix might be trivial, but they add up.
>> So it matters whether this one is "this is the only thing
>> we tripped over since 2024" or "we just rebased to a new
>> QEMU version and are going to be submitting dozens of these
>> over the next few weeks".
>>
>>> See for example non-invasive commit 7246c4cc470 ("exec: don't use void*
>>> in pointer arithmetic in headers"):
>>
>>> or commit 17c7df806b3 ("exec: avoid using C++ keywords in function
>>> parameters"):
>>
>> For the record, I wasn't really enthusiastic about those changes
>> either, for essentially the same reasons.
>>
>>> In this particular case, I always have been confused about what would be
>>> the size of forward-declared enums. The C99 standard chapter §6.7.2.2
>>> point 4 mentions:
>>>
>>>     Each enumerated type shall be compatible with char, a signed
>>>     integer type, or an unsigned integer type. The choice of type
>>>     is implementation-defined, but shall be capable of representing
>>>     the values of all the members of the enumeration.
>>>
>>> When compiling this file with -Werror=pedantic we get:
>>>
>>> In file included from ../../ui/kbd-state.c:10:
>>> include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to
>>> 'enum' types [-Werror,-Wpedantic]
>>>      12 | typedef enum QKbdModifier QKbdModifier;
>>>         |              ^
>>>
>>> So arguably this could be fixed for C.
>>
>> Yes, I actually like the specific change in the patch
>> on style grounds.
> 
> The *current* code style, however, matches the style we use for the
> struct declaration & typedefs, and it is natural to be consistent
> in this way.

Per the ISO C standard, maybe we should considerate following the same
structure style for enum typedefs was a mistake, and update our coding
style. This is what I suggested here:

https://lore.kernel.org/qemu-devel/20260130211746.46667-3-philmd@linaro.org/

> 
> Even within this one file we have this example:
> 
>    typedef enum QKbdModifier QKbdModifier;
>    typedef struct QKbdState QKbdState;
> 
> And so personally I think the current code is preferrable to this patch.
> 
> IMHO, if downstream users/developers of a fork really strongly don't want
> to be writing new devices in C, then the focus should be on Rust as the
> next generation language, not the C++.
> 
> With regards,
> Daniel


