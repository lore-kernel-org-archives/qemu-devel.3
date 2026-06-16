Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CB8CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVfj-00063e-Ib; Tue, 16 Jun 2026 11:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVfh-00062u-JF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:25:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVff-0001sw-VN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:25:49 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so2357924a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623546; x=1782228346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Paz6w9KHJRAC2epf/+EpUnskrCLkWvVxbOEvjRWFcVU=;
 b=HBWmdH7miO/fO9RgzEyYQSOlnyl3JSmRKQGsiTe8Ccx5/1tm4C2rC8ZMBddh39jGDD
 r04gZ2KsP2NL8eZSEN94dExHSYvqz6dQeLHC3/6KS/GFnbujd0LAzy1TSNL7iiYF/XYR
 AyOS4c8WG+eIpnc2K0k5owmp+91FQhB8vnMAYGQ//My0dxXu3wmY9/rwLjBgD6/rnj6/
 NW2dyDRKLF7X83VYr5kO3vL8FTffG930qKDmxg5Tb8C59hNJM7kVerkIKzNvucj4XncP
 hPQpm6huhJ/Ry/1W2l8JtPzbbJ5e9caTOjusCAgEMeQBRLx91LOCk+tsvvoiezVskBy0
 Q2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623546; x=1782228346;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Paz6w9KHJRAC2epf/+EpUnskrCLkWvVxbOEvjRWFcVU=;
 b=LidfGI0Zz5R7QIra9H1lKk+pzgYfBubXHBgZ45NVP2Ajk62vcu9LEYo/XSoAXtYaop
 PrQ2kMqvS4GU9s863Y1Xv9f2P71jZVwXy1UdpPi+rQ+FuJnY2P4mcw+TpITtsuEGa49a
 J0nzw1sD6J/AlthNKkcEgiDb/IMMWhFfyESivJDeGYNGx9FJKgLT/RMU9s/04KdbQfDw
 OnS1fUmxolC7XAQ4Ost9b5RoULHYmWMesQnBrOyifCg0bdZizO1Q+a9BPAG4YT6zc0Lx
 6wlZJHFPcyaw1Ky6wcRT9jmVAMUTpgF6elZDMCx6xeEm3wcO34WuuDaSM4obLorx7YBJ
 aidA==
X-Gm-Message-State: AOJu0YySdfcKq9RHmVTVdHoFV6fXRipSw8oDeFtb6ymGoTGNjqReNuIV
 bdM+SJguyaXqJfzkou48rMcp+wCX422iRUja3HBETViMPzUZym/r2fXxEx5s94nDHW1GGWEhIE9
 D5beZ
X-Gm-Gg: Acq92OG1d9akr7k4JdNmJxQjA8XF+0y1piU8Y15yIXszuoqbEIpq4x01XrJ3p9vI79Y
 enLv+4ZdIx/HfFP3WBjtzV1z0qXaEy7NbVQDztdGNjqikBl2xvslPgBSUInXz7qDMb0+qOQDo4c
 JV8HBjLVwrleUwzDplqH15YCYLcsiQvVkwQ68JKSt6Jsn674UODNej0hEn2u2VW/lg8bEv1EKNP
 cWB7SCtdLyidFkaM6qYGTOY3WohcOVQ9vwW9ACiZPOlH1dgFl9op1HXdki1kI3Xi84Q5kalFBGs
 QjxMNHZc4/8mjmXgVxdHgU0zGEOo7LxGgHm2MRiARTWUako8RDY4yt8ZkRTGnIzou/xqaAENWSo
 wp8OF+p9UJcf//ad5R7iooFKes1P0p+pove2WTKwdlPE/sWB4qEWF+ySSbgMspENygx3fVANq+d
 6wiakiB3rAqyy4OpH5Vus85r5vOJqrffv3Y/kJRcuQPSqAiRx1pZPKfLgXgHCctaprUsyn
X-Received: by 2002:a17:90b:3a85:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-37c5280307cmr4634880a91.4.1781623545829; 
 Tue, 16 Jun 2026 08:25:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-379e7e217c0sm10723414a91.2.2026.06.16.08.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 08:25:45 -0700 (PDT)
Message-ID: <dbfdc77f-8435-4e9e-90d4-f93a5b8cfa78@linaro.org>
Date: Tue, 16 Jun 2026 08:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/25] target/arm: Generalize sve_compact_[sd]
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-21-richard.henderson@linaro.org>
 <CAFEAcA8Vnncc0dfz8D8DRe0npH9FSRPsNWg+_-PDFdiqyWHSdA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8Vnncc0dfz8D8DRe0npH9FSRPsNWg+_-PDFdiqyWHSdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/16/26 06:35, Peter Maydell wrote:
> On Fri, 5 Jun 2026 at 00:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Implement with a DO_COMPACT macro and general purpose
>> predicate handling.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/sve_helper.c | 51 +++++++++++++++----------------------
>>   1 file changed, 21 insertions(+), 30 deletions(-)
>>
>> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
>> index a13ccf4b85..40cf567b0d 100644
>> --- a/target/arm/tcg/sve_helper.c
>> +++ b/target/arm/tcg/sve_helper.c
>> @@ -3637,39 +3637,30 @@ DO_TRN(sve2_trn_q, Int128, )
>>   #undef DO_UZP
>>   #undef DO_TRN
>>
>> -void HELPER(sve_compact_s)(void *vd, void *vn, void *vg, uint32_t desc)
>> -{
>> -    intptr_t i, j, opr_sz = simd_oprsz(desc) / 4;
>> -    uint32_t *d = vd, *n = vn;
>> -    uint8_t *pg = vg;
>> -
>> -    for (i = j = 0; i < opr_sz; i++) {
>> -        if (pg[H1(i / 2)] & (i & 1 ? 0x10 : 0x01)) {
>> -            d[H4(j)] = n[H4(i)];
>> -            j++;
>> -        }
>> -    }
>> -    for (; j < opr_sz; j++) {
>> -        d[H4(j)] = 0;
>> -    }
>> +#define DO_COMPACT(NAME, TYPE, H)                                     \
>> +void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
>> +{                                                                     \
>> +    intptr_t i = 0, j = 0, oprsz = simd_oprsz(desc);                  \
>> +    do {                                                              \
>> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
>> +        do {                                                          \
>> +            if (pg & 1) {                                             \
>> +                *(TYPE *)(vd + H(j)) = *(TYPE *)(vn + H(i));          \
>> +                j += sizeof(TYPE);                                    \
>> +            }                                                         \
>> +            i += sizeof(TYPE);                                        \
>> +            pg >>= sizeof(TYPE);                                      \
>> +        } while (i & 15);                                             \
>> +    } while (i < oprsz);                                              \
>> +    for (; j < oprsz; j += sizeof(TYPE)) {                            \
>> +        *(TYPE *)(vd + H(j)) = 0;                                     \
>> +    }                                                                 \
>>   }
> 
> Why do we have special versions of the predicated loop for 64-bit operands
> elsewhere (eg DO_ZPZ vs DO_ZPZ_D, DO_ZPZZ vs DO_ZPZZ_D, etc) but we don't
> need to do that for compact ?

Efficiency vs laziness.  64-bit elements are special in that we can write things such that 
we don't need a double-loop, by examining just the lsb each byte of the predicate.  But 
such specialization is not required.  Here the inner loop will iterate twice for 64-bit 
elements.


r~

