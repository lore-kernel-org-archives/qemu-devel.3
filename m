Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4A5D690E3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 07:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGZBj-0005xf-FB; Thu, 28 Nov 2024 02:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGZBe-0005xI-SA
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 02:43:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGZBc-0005im-HF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 02:43:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382325b0508so227302f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 23:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732779817; x=1733384617;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgmSxm0JmJgXnyGHIHcBo3/IjAJ1bPgiNCmB5EwF89o=;
 b=jgyGzJFP5vEGAJ4v7TCf49seonjAEumXWOrLWTtwY3Z3dJ17Io1Sm+CsTBsrYfnbmf
 v38CqUFyerOqiyCNvhUOedKzGBV2CEalxQMs21a4mpoQDizxWG8YBn0A0wXa13YFrLBn
 mc7R3KVjSjUxLFl7hrkqLQ3ZoXfW9438xZwaP0fHXpqLg5fatcZbjUVGDRRi+q4EHsNu
 tD6KpXwn9biKSJ2YcWZxTKiOM7c50ukqLLpWo8Mij+JBTv4htzdWt94clbFTE+NFysTh
 KBZt2BwOgKMRFhowKG/+UBj9Xtn1WekMBAey9idGd9V//+Q/6tGFzBrmfUIRS8YPQC+E
 wC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732779817; x=1733384617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgmSxm0JmJgXnyGHIHcBo3/IjAJ1bPgiNCmB5EwF89o=;
 b=nvirgO199/Ov2VUCkfmYvFZC2XZqE0OZPnGgMHm1jDI94HMHByMJMo5yRyF4Uqod9p
 l0sjN9DF61uVmpMzaN1J/ZJY7Jrd8Q4h5rOB5XhhonQ9GPh6nOzCnHvvP8bwYDKnQj8F
 0FYo+0nBUCEXLjaEbjVnQidup7ODYwjm5aYYzgWbS3NUYxaQCSwdbYjQablFfyLW3K36
 Y7baKYtekZXI9PG+uMA2qU8KaW97QOcJ5J9hBC+g2sX8x8uYTyL+W+y7fmDxZbT2wKyr
 LuqgNTJiKnqSC4ntVfezBls7pyXBF7zTmvbR//3rDIH+Obmirt2YPQauyROb1hJVkFYV
 opmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw0cweCZ5yLxbJtLOGmlWVMShCh4iiFjqyPXlut4BSGoSE1jot3sofa4NxBeUK86Z49Odp9akKNnkb@nongnu.org
X-Gm-Message-State: AOJu0YyeaZMXZwd3awUtFigfCAKig7DIncvpY0im6OaYNeTpzs4oZSDU
 JlvCnwHmKFuiMqLH0V292jm0DYwYwiipWvHdDE0+nJgg14Otmq8AykL2fQ+Uzdo=
X-Gm-Gg: ASbGncvhYaft5SS3iVHhQJeyHfABBUJPpOh/HPQWBG4a6+w9rAJ7mPVhu3HL1CkDTKy
 nle0cUNDQailbg8RcfCzY3joeDATh59rZJv7SZ1W02upyODI/7BC+Cgn0uEox7XWPuKIlDSxeFn
 i952rB/hMP9xzgTbkz4FhaX0/j8WI4sOQFA2aAvmVrKq8LJwT7jcLOatvFRi75fx6sILTAJoJBc
 o7RWJSGg9pP/3R9ZWY7QU0IebneoUcG3QT94NhBIYmHJs3VIBAymHeql69jyEJJMkkcRZxZsBBv
 auQKBTsqut7FfuhCClY=
X-Google-Smtp-Source: AGHT+IHAtovSUYuvmcsPB1uNEdnd6WCAYfCacs6FVylXSa2yDGm32dRmk3hN8PaPMszXDbJBwPMSsQ==
X-Received: by 2002:a5d:5f88:0:b0:382:4a87:6680 with SMTP id
 ffacd0b85a97d-385c6eb7aa0mr4493170f8f.6.1732779817569; 
 Wed, 27 Nov 2024 23:43:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa763aaesm44556265e9.14.2024.11.27.23.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 23:43:37 -0800 (PST)
Message-ID: <87b2e4ca-0ba0-4777-a11d-4dd4d132dbc4@rivosinc.com>
Date: Thu, 28 Nov 2024 08:43:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-2-cleger@rivosinc.com>
 <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
 <7c88eba0-c010-4aef-ad57-ede292129aff@rivosinc.com>
 <CAKmqyKMH_YAgomy325ZmpGCNkDMrb5pwJU9GBgNicFAsAc0J6A@mail.gmail.com>
 <1868e353-6c40-4cfb-a00f-4afdde68baea@rivosinc.com>
 <CAKmqyKPomWUDWAtXSPtFMszRwYggG-sR+_erw4aOyxHRmHMW0A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKPomWUDWAtXSPtFMszRwYggG-sR+_erw4aOyxHRmHMW0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 28/11/2024 02:37, Alistair Francis wrote:
> On Thu, Nov 21, 2024 at 6:28 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>>
>>
>> On 20/11/2024 06:02, Alistair Francis wrote:
>>> On Tue, Nov 19, 2024 at 9:27 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 19/11/2024 05:16, Alistair Francis wrote:
>>>>> On Thu, Nov 14, 2024 at 7:14 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>>>>
>>>>>> With the current implementation, if we had the current scenario:
>>>>>> - set bit x in menvcfg
>>>>>> - set bit x in henvcfg
>>>>>> - clear bit x in menvcfg
>>>>>> then, the internal variable env->henvcfg would still contain bit x due
>>>>>> to both a wrong menvcfg mask used in write_henvcfg() as well as a
>>>>>> missing update of henvcfg upon menvcfg update.
>>>>>> This can lead to some wrong interpretation of the context. In order to
>>>>>> update henvcfg upon menvcfg writing, call write_henvcfg() after writing
>>>>>> menvcfg and fix the mask computation used in write_henvcfg() that is
>>>>>> used to mesk env->menvcfg value (which could still lead to some stale
>>>>>> bits). The same mechanism is also applied for henvcfgh writing.
>>>>>>
>>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>> ---
>>>>>>  target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 35 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>>>>> index b84b436151..73ac4d5449 100644
>>>>>> --- a/target/riscv/csr.c
>>>>>> +++ b/target/riscv/csr.c
>>>>>> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>>>>>>      return RISCV_EXCP_NONE;
>>>>>>  }
>>>>>>
>>>>>> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>>>> +                                    target_ulong val);
>>>>>>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>>>>>                                      target_ulong val)
>>>>>>  {
>>>>>> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>>>>>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>>>>>>      }
>>>>>>      env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>>>>>> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
>>>>>>
>>>>>>      return RISCV_EXCP_NONE;
>>>>>>  }
>>>>>> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
>>>>>>      return RISCV_EXCP_NONE;
>>>>>>  }
>>>>>>
>>>>>> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>>>>>> +                                    target_ulong val);
>>>>>>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>>>>>                                       target_ulong val)
>>>>>>  {
>>>>>> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>>>>>      uint64_t valh = (uint64_t)val << 32;
>>>>>>
>>>>>>      env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>>>>>> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>>>>>>
>>>>>>      return RISCV_EXCP_NONE;
>>>>>>  }
>>>>>> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>>>>                                      target_ulong val)
>>>>>>  {
>>>>>>      uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>>>>>> +    uint64_t henvcfg_mask = mask, menvcfg_mask;
>>>>>>      RISCVException ret;
>>>>>>
>>>>>>      ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>>>>>> @@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>>>>>>      }
>>>>>>
>>>>>>      if (riscv_cpu_mxl(env) == MXL_RV64) {
>>>>>> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>>>>>> +        /*
>>>>>> +         * Since henvcfg depends on a menvcfg subset, we want to clear all the
>>>>>> +         * menvcfg supported feature (whatever their state is) before enabling
>>>>>> +         * some new one using the provided value. Not doing so would result in
>>>>>> +         * keeping stale menvcfg bits in henvcfg value if a bit was enabled in
>>>>>> +         * menvcfg and then disabled before updating henvcfg for instance.
>>>>>> +         */
>>>>>> +        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
>>>>>> +        mask |= env->menvcfg & menvcfg_mask;
>>>>>> +        henvcfg_mask |= menvcfg_mask;
>>>>>>      }
>>>>>>
>>>>>> -    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
>>>>>> +    /*
>>>>>> +     * 'henvcfg_mask' contains all supported bits (both in henvcfg and menvcfg
>>>>>> +     * common bits) and 'mask' contains henvcfg exclusive bits as well as
>>>>>> +     * menvcfg enabled bits only.
>>>>>> +     */
>>>>>> +    env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (val & mask);
>>>>>
>>>>> Won't `env->henvcfg & ~henvcfg_mask` still contain the stale data?
>>>>> `henvcfg_mask` isn't based on the current value of `env->menvcfg`
>>>>
>>>> Hey Alistair,
>>>>
>>>> That's the point, env->henvcfg is cleared with henvcfg_mask which
>>>> contains the set of HENVCFG_* and MENVCFG_* "raw" bits so that the new
>>>> value that is written does not contain any menvcfg stale bits. "mask"
>>>> however is actually masked with menvcfg value to ensure the new bits
>>>> that are going to be written won't contain any incoherent bits.
>>>
>>> I'm not sure I follow...
>>>
>>> The commit message says:
>>>
>>> """
>>> - set bit x in menvcfg
>>> - set bit x in henvcfg
>>> - clear bit x in menvcfg
>>> """
>>>
>>> Which to me means henvcfg should be cleared when a bit in menvcfg is
>>> cleared. But env->henvcfg is instead cleared based on `henvcfg_mask`
>>> which isn't affected by menvcfg.
>>
>> Hey Alistair,
>>
>> Let's take some real example (MENVCFG_PBMTE for instance.) Let's assume
>> menvcfg/henvcfg are 0 and the following sequence:
>>
>> - Set MENVCFG_PBMTE in menvcfg (menvcfg = MENVCFG_PBMTE)
>> - Set HENVCFG_PBMTE in henvcfg (henvcfg = HENVCFG_PBMTE)
>> - Clear MENVCFG_PBMTE in menvcfg (menvcfg = 0)
>>
>> On such sequence, we should clear HENVCFG_PBMTE in henvcfg. When using
>> the existing code, henvcfg_write() does so:
>>
>> mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>> mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>>
>> So our mask = (HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
>> HENVCFG_CBZE) and does not contains HENVCFG_PBMTE.
>>
>> Finally:
>>
>> env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
>>
>> Then env->henvcfg & ~(HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
>> HENVCFG_CBZE | HENVCFG_STCE | HENVCFG_ADUE) will yield henvcfg =
>> HENVCFG_PBMTE (which is obviously not what we want) | val & mask.
>>
>>>
>>> So clearing a bit in menvcfg will only not allow a bit to be set, but
>>> not clear any existing bits
>>
>> Let's take again the current patch and what it does with the same sequence:
>>
>> - Set MENVCFG_PBMTE in menvcfg (menvcfg = MENVCFG_PBMTE)
>> - Set HENVCFG_PBMTE in henvcfg (henvcfg = HENVCFG_PBMTE)
>> - Clear MENVCFG_PBMTE in menvcfg (menvcfg = 0)
>>
>> henvcfg_mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>> mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>>
>> henvcfg_mask |= (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>> /* Only keep the enabled bits from menvcfg */
>> mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>>
>> So mask = (HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE)
>> which rightfully does not contain HENVCFG_PBMTE so the value to be
>> written will be  correctly cleared from that bit.
>>
>> Finally, when it comes to write the final value we'll have the following:
>>
>> env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (val & mask);
>>
>> Which yield
>>
>> henvcfg & ~(HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE |
>> HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) | val & (HENVCFG_FIOM |
>> HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE | HENVCFG_STCE | HENVCFG_ADUE)
>>
>> So henvcfg HENVCFG_PBMTE bit is correctly cleared and not allowed to be
>> set by the written value. But I might be missing something.
> 
> Ah ok!
> 
> That makes sense, sorry I took so long to wrap my head around this one.
> 
> Although now that we are basically clearing henvcfg on each write, do
> we ever need the ` (env->henvcfg & ~henvcfg_mask) | ` can't we just
> overwrite it each time?

Oh god, I basically wrote the most complicated way to clear a
register... so yeah indeed, this can be reduced to just 'env->henvcfg =
val & mask'.

> 
> Also, this will need a rebase on:
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next as there
> are now more operations in write_henvcfg()

Acked,

I'll submit another version.

Thanks,

Clément

> 
> Alistair
> 
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>> Alistair
>>>
>>>>
>>>> I guess this still needs a few more explanations if that is not clear
>>>> enough, sorry for that.
>>>>
>>>> Thanks,
>>>>
>>>> Clément
>>>>>
>>>>> Alistair
>>


