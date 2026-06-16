Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3584ACD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVaq-0004qX-LJ; Tue, 16 Jun 2026 11:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVap-0004qP-9d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:20:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZVak-0007bm-2L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:20:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37c64d34032so302157a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781623240; x=1782228040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7l5nXH0Y56VLvkbCTJDwSQ/agZ8m3Ub62gCgahFuHR8=;
 b=iNLjT4mZG2wujRyVKWTr/4emzdhkz/EGUtL7NyVtF/oMli8OZ/i+Cc8MofBnCSoMBy
 OZELZjPwgM5Hz2avuSmqCLJ+sMM6a4RoAMBZiDiSBL4JCarCTDp4seKQ7qF0Plg8gg2S
 K5iP6IB06jNi5+xVtGRJfS51jbHyy8zCNsZRbm3TMryTkt5L8aO2phAb1I136qYUgIOy
 ImtKtagxcOB/3yTcfxNzNW3MkXvk4LL5u1E7Lh1FENT+1nRsLyorg2YjfoLZtqcwsS/9
 i4NKjaniB+scmK2En/Qsk9eGCSW/hFYFW9t5bRMYStcc+Yb/6xt6604X0jsHYoVqPgvQ
 ClbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781623240; x=1782228040;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7l5nXH0Y56VLvkbCTJDwSQ/agZ8m3Ub62gCgahFuHR8=;
 b=GhM7R5nmUBuHd9qZOWTOFHze9jjjLXecECxuZerWtP9WTfTo1dK0Eji8iyXOsxdTFp
 9e8/HITYJLk/KNtK2Kks2k1IuZ33szus/EvaOPysreloN1MzImJn6Zd+tjOEfCyHGfSe
 9gV+8KL2zB3NQ1sT+Zh9YBrtUe3nvQp2Qa+NBktsKXjf87Q2Mov6uoidLcokSox6UPiO
 SbXQoD750gccDFHNzGHpXDeuCuLldy0eQf7prMbSofHWoqHxHnruTBzhEAitn26lFXf6
 GjCvZfkli7J/o/XpO7rW9jdwZkrMbENCgBOqPYX2x1qeuFPtEShXblVEyqWbQC3Eajdw
 0l2g==
X-Gm-Message-State: AOJu0YwO+JgFkWIKepXnhTRzbdMB3EFTvky73DFFUkgDS9/n46jUURN7
 C46cmcn3VDr5Lwpqa+HXebGL6nHZdspP+4gLw83uADbPXn0lwQYVusjWzZ3Ww9MVR3A=
X-Gm-Gg: Acq92OFH7t92q7+KLYA9Od03G1fXhvJlCWVH4osZXCBXZ8tORFpcZLlxLK16QOeXFMq
 YYFS0gpL3JFJkGzfoRgMOXgY4l1fegf9i1OtdCv9GEvML1R72dcUJvE7Z2GRRURmRph7kf34Q6m
 uiNblmdqPuH4jYAfWVa3jK/nbaVZu1DMw/HaxXilkLlfHuFjhaWqWpG5dA7xXbEjWCEUoDUE07c
 HhEQYu8vjPizMZAmaehIrhNPbLAVkq7yynlXFLkEEx5oWonNL2b9NhFtspeO3VwmDa8WV7zs1zK
 EA+oTCxIehzPppkD9RqgMej+K32DjtyBVBUxeqzfWtpToSQuavTqiD/yBoylZgwBC6dEPXAG1I5
 UYw4B6KI6qmJsZYNItK0n7GR/DvQi2APsAxEyToyvYMI7gey7kQ+4Vfr4jaZQ2mQKn4x1r+m8sM
 0KoSAeyGVwKb4TLq8Hy1Jw3YHzCSU0rEm7blif+gBHL1LZTFoa/PmG+JGpaRyPkl2D1KSFCJt8q
 DswQfw=
X-Received: by 2002:a17:90a:ec8b:b0:369:742a:4259 with SMTP id
 98e67ed59e1d1-37c52225167mr3562422a91.0.1781623240128; 
 Tue, 16 Jun 2026 08:20:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8661b5ccafsm12178196a12.2.2026.06.16.08.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 08:20:39 -0700 (PDT)
Message-ID: <1540ab06-9e99-43f3-b2e5-cb46977d0531@linaro.org>
Date: Tue, 16 Jun 2026 08:20:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/25] target/arm: Implement EXPAND
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-20-richard.henderson@linaro.org>
 <CAFEAcA9JWsJPLx=rH2OiuDMP4f46H5PSzzOBrQaVq=URonSfRQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9JWsJPLx=rH2OiuDMP4f46H5PSzzOBrQaVq=URonSfRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 6/16/26 06:30, Peter Maydell wrote:
>> +#define DO_EXPAND(NAME, TYPE, H)                                      \
>> +void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
>> +{                                                                     \
>> +    intptr_t oprsz = simd_oprsz(desc);                                \
>> +    ARMVectorReg tn = *(ARMVectorReg *)vn;                            \
>> +    intptr_t i = 0, j = 0;                                            \
>> +    do {                                                              \
>> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
>> +        do {                                                          \
>> +            TYPE nn = 0;                                              \
>> +            if (pg & 1) {                                             \
>> +                nn = *(TYPE *)((void *)&tn + H(j));                   \
>> +                j += sizeof(TYPE);                                    \
>> +            }                                                         \
>> +            *(TYPE *)(vd + H(i)) = nn;                                \
>> +            i += sizeof(TYPE);                                        \
>> +            pg >>= sizeof(TYPE);                                      \
>> +        } while (i & 15);                                             \
>> +    } while (i < oprsz);                                              \
> 
> It looks like in the other macros where we iterate like this
> (eg DO_ZPZZ, DO_ZPZ) we write the outer loop as
>     for (i = 0; i < opr_sz; ) {
>       ...
>     }
> 
> rather than as a do while(). Is there a reason I'm missing why
> we need the do-while here ?

Nothing special, no.

Some of the predicate using macros use do/while, e.g. DO_COMPACT.  I probably looked at 
that one while writing expand.


r~

