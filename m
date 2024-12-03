Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55293E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY6B-0006ap-09; Tue, 03 Dec 2024 13:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIY60-0006Xn-TF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:58:07 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIY5z-0001TH-7o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:58:04 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71d40573d03so2310621a34.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733252282; x=1733857082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=poNrNExscsXwxtD6kDXWsRUQV5BUH2LZGLsZtVrNoNY=;
 b=Io4bfV6QyFp2b+L3FEPMcQz+qg9o2HAKydyKYEpvRRsy2zvehOIltbctY+VAVUDHv0
 THZV6tZ+tS7Zu+rOSfFmxs+xCg1jlVPxZubipqCeL44Zxq4zo3fo/40ewwra3dmEY7ps
 XEC/vSYc3Rtq2jGJi0jux96clkxvWzNPUx549wgt7BZWomO26vnKu5uQChKAv1/XH9Ki
 g2i50VJeBYu0zssHp7JcFgVGsgky06nET5m1pzX13W3yl9ggArYH3W2uE1uh8ZfsMW6W
 +JZDIz+JehRPGVf/mVFumyRysmezrUlpUTIMJEcEvb/iPOaESRIjLAxTyfC0IKpscDNC
 eUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733252282; x=1733857082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=poNrNExscsXwxtD6kDXWsRUQV5BUH2LZGLsZtVrNoNY=;
 b=jS3/SQ9nRAqUphifvFI9rznk8KdphpGBE1Ke0JfALF0zvCw9+3ZhdUb9tSsRdzndWD
 +CE+Sc8QkbdvGBY94h5DZvmVaH7A3jStNjwYXILEr8vpBzpDUvcT3N8wVpb+nCEN2a9n
 VG0PKpqUolqMW+H1m78hsmA3iQT8/kJvrYAbCvROEzMs3Ym5cKrnAGPemUdIcBMViXHi
 tFh8xin9JTQWZRorCFxjCZN8w7iWt+KlQk9jw3vR2zfNLgNcNXtyaioqCeJny7HsqOMR
 qh1XaKPUFBdekdqEcrZG5xlvKcMdtQFqpqii7656vsGhPxsaFFPJz1MvVqH/p/09IANd
 yxOw==
X-Gm-Message-State: AOJu0YzUvKT1fNc1Ae9vRdFUwr2ajIQg3HcwqdaBWXs9o0H9M7IA3Pdp
 a+QR5XM2zIkRlutjdMIGss7xJW2do5yQ1+qgG5JJEk2NArGnWIaRUomvcc1jc9s=
X-Gm-Gg: ASbGncvtqEdX849jjjFyYyCHSmf/8CgAc8r1Fnk5+Qw8kM6ASPK1xAaQ5OjONZ8UpFo
 ZAAuSNOGTsSGgInMxXy35slXFYn/81ahVn6rfh65rK8zflVUWWhw6JChpJkbI0Vo/7EZ+RHBmLr
 HSoN+uQ1Pf4BkvJ4lUq9Kyw0x/2T+8VUI2iA492W8npWyVvdDlHR3j5InTSbz/FrjQNvp3pCTaO
 bBIYcaiDIKixHNOSheT3YHoh3bzndDCgyJxfAjNq6DruzZm58AcpIx1KXD+7ZFNYpyN/4pBCr0b
 FtTBUQ/Bq5ygbfZ5HWji8ZvocUt+
X-Google-Smtp-Source: AGHT+IF6HWctgt56VQM4lTU+FBWAoNg6y8pPAFSJlbOchi4Yf7b4N0Mu/EV6nwR9O85pVmYf9fKaqg==
X-Received: by 2002:a05:6830:370c:b0:718:9bac:58a5 with SMTP id
 46e09a7af769-71db57d5700mr1038050a34.11.1733252281775; 
 Tue, 03 Dec 2024 10:58:01 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a312c6fsm2907824eaf.2.2024.12.03.10.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 10:58:01 -0800 (PST)
Message-ID: <e4910c71-8220-404b-bb43-0b885914e183@linaro.org>
Date: Tue, 3 Dec 2024 12:57:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/43] accel/tcg: Add gvec size changing operations
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com,
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-4-anjo@rev.ng>
 <b2986b74-2c74-491b-90a1-9ec79367c2e8@linaro.org>
 <v5pkpmxto7vtshg7a5mifaozrzn6n5d7raknvydad3oxk67jeu@i4jydb4wylpb>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <v5pkpmxto7vtshg7a5mifaozrzn6n5d7raknvydad3oxk67jeu@i4jydb4wylpb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/3/24 12:08, Anton Johansson wrote:
> On 22/11/24, Richard Henderson wrote:
>> On 11/20/24 19:49, Anton Johansson wrote:
>>> Adds new functions to the gvec API for truncating, sign- or zero
>>> extending vector elements.  Currently implemented as helper functions,
>>> these may be mapped onto host vector instructions in the future.
>>>
>>> For the time being, allows translation of more complicated vector
>>> instructions by helper-to-tcg.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    accel/tcg/tcg-runtime-gvec.c     | 41 +++++++++++++++++
>>>    accel/tcg/tcg-runtime.h          | 22 +++++++++
>>>    include/tcg/tcg-op-gvec-common.h | 18 ++++++++
>>>    tcg/tcg-op-gvec.c                | 78 ++++++++++++++++++++++++++++++++
>>>    4 files changed, 159 insertions(+)
>>>
>>> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
>>> index afca89baa1..685c991e6a 100644
>>> --- a/accel/tcg/tcg-runtime-gvec.c
>>> +++ b/accel/tcg/tcg-runtime-gvec.c
>>> @@ -1569,3 +1569,44 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
>>>        }
>>>        clear_high(d, oprsz, desc);
>>>    }
>>> +
>>> +#define DO_SZ_OP1(NAME, DSTTY, SRCTY)                                      \
>>> +void HELPER(NAME)(void *d, void *a, uint32_t desc)                         \
>>> +{                                                                          \
>>> +    intptr_t oprsz = simd_oprsz(desc);                                     \
>>> +    intptr_t elsz = oprsz/sizeof(DSTTY);                                   \
>>> +    intptr_t i;                                                            \
>>> +                                                                           \
>>> +    for (i = 0; i < elsz; ++i) {                                           \
>>> +        SRCTY aa = *((SRCTY *) a + i);                                     \
>>> +        *((DSTTY *) d + i) = aa;                                           \
>>> +    }                                                                      \
>>> +    clear_high(d, oprsz, desc);                                            \
>>
>> This formulation is not valid.
>>
>> (1) Generic forms must *always* operate strictly on columns.  This
>> formulation is either expanding a narrow vector to a wider vector or
>> compressing a wider vector to a narrow vector.
>>
>> (2) This takes no care for byte ordering of the data between columns.  This
>> is where sticking strictly to columns helps, in that we can assume that data
>> is host-endian *within the column*, but we cannot assume anything about the
>> element indexing of ptr + i.
> 
> Concerning (1) and (2), is this a limitation imposed on generic vector
> ops. to simplify mapping to host vector instructions where
> padding/alignment of elements might differ?  From my understanding, the
> helper above should be fine since we can assume contiguous elements?

This is a limitation imposed on generic vector ops, because different target/arch/ 
represent their vectors in different ways.

For instance, Arm and RISC-V chunk the vector in to host-endian uint64_t, with the chunks 
indexed little-endian.  But PPC puts the entire 128-bit vector in host-endian bit 
ordering, so the uint64_t chunks are host-endian.

On a big-endian host, ptr+1 may be addressing element i-1 or i-7 instead of i+1.

> I see, I don't think we can make this work for Hexagon vector ops., as
> an example consider V6_vadduwsat which performs an unsigned saturated
> add of 32-bit elements, currently we emit
> 
>      void emit_V6_vadduwsat(intptr_t vec2, intptr_t vec7, intptr_t vec6) {
>          VectorMem mem = {0};
>          intptr_t vec5 = temp_new_gvec(&mem, 256);
>          tcg_gen_gvec_zext(MO_64, MO_32, vec5, vec7, 256, 128, 256);
> 
>          intptr_t vec1 = temp_new_gvec(&mem, 256);
>          tcg_gen_gvec_zext(MO_64, MO_32, vec1, vec6, 256, 128, 256);
> 
>          tcg_gen_gvec_add(MO_64, vec1, vec1, vec5, 256, 256);
> 
>          intptr_t vec3 = temp_new_gvec(&mem, 256);
>          tcg_gen_gvec_dup_imm(MO_64, vec3, 256, 256, 4294967295ull);
> 
>          tcg_gen_gvec_umin(MO_64, vec1, vec1, vec3, 256, 256);
> 
>          tcg_gen_gvec_trunc(MO_32, MO_64, vec2, vec1, 128, 256, 128);
>      }
> 
> so we really do rely on the size-changing property of zext here, the
> input vectors are 128-byte and we expand them to 256-byte.  We could
> expand vector operations within the instruction to the largest vector
> size, but would need to zext and trunc to destination and source
> registers anyway.
Yes, well, this is the output of llvm though, yes?

Did you forget to describe TCG's native saturating operations to the compiler? 
tcg_gen_gvec_usadd performs exactly this operation.

And if you'd like to improve llvm, usadd(a, b) equals umin(a, ~b) + b.
Fewer operations without having to change vector sizes.
Similarly for unsigned saturating subtract: ussub(a, b) equals umax(a, b) - b.


r~

