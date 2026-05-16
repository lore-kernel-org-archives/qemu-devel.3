Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F098CD4851
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJak-000542-In; Sat, 16 May 2026 14:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJai-00053g-Kp
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:18:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJah-0007bz-2W
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:18:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so427896b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778955501; x=1779560301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SkCRmJVbMNWIUW+47BF5u3h4ZiH2luosrvtnuMXpL8A=;
 b=LzB8NMRqvlOiACpOCbGggkmnzGV4Zvssm/XgD0pQqP7zKIWUQPRV3kIjcVxbj9x9zg
 3aYDOTEfeC+8gQ+4/nR3aALcYNUjj9UqmIu09FHWPycUubRPeQogNHKb3F4J3vIBtEsb
 AUwqnocq6cyhXmmMUEmmF+UqOua+ikfowjaVRemRTlDOaxEhYaiXM3jRcUCEQyR/dZeA
 asNOCAgWqTfGVIapdMZm8xU8V1VAMyVGnK0RF76zfMYd74T0GkLIAweK6AH/+6MP2MpF
 PK1Hbw4MuvzAO3fThYJP+ap+q59xjnpbB2B40nLf1E6UMFOYaxpIW6dEPKUjI1erhYi8
 G+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778955501; x=1779560301;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SkCRmJVbMNWIUW+47BF5u3h4ZiH2luosrvtnuMXpL8A=;
 b=NthzsBg+AMFgKul5jHdf75TfnHicZ34cGsfG9Wek61/9e0YE+OfQP1nL9WzL8NXltW
 ctzedZW9xNGRHkysKpka3E4jHH3KgohzQGvRL27vyME99nLSGg3wGz7lMm6VbX3JGmQr
 +sUSFLjkkJh5dqZUUMjkRLAw7ONelhRQhZE0zmUWSihkrWQ+ZY/TbPxusvBeuBfVZxke
 eNCl9wuVv+A+MN3dG3hLp2uBztp6+KSAt5kXEplBTXIcaNS7iYVYwM46jK9IRAW952a8
 sIOaxWKmB2ceykhRMbbBSzw+vcMHL3Ygpye56Dija/zHIWcdZE86tyrrGB5mdLDhhtuB
 6cog==
X-Gm-Message-State: AOJu0YxMShWO6jgFJWX0Fy6NRHoIXS/eZSawztY193bDBdT4zHOage1S
 BJuJUzc9SjkH1pl6UBMjpEG5MnIiDrLttKx7u35i3z5tB7cT6wDWc0JKCPDqW9F9AAQ=
X-Gm-Gg: Acq92OHHF/mltaMZXe1YjAtirwpTI5Be7Sek1Il/Ss3NQzRq8SRyh+qBbLk1hVJfwAW
 Yy8IUIoW6i/kMHoale8zeuy5R447shS+PSL4ScPmL/y3oUUNb4xCQhCJmb3IYH20Rrh2aqaaFBT
 6LrCHC2tRBsnRZUTs+mY7POJ3j141PsADycSzurS0sSvXeHwsC73MhA0+d2HLYZxv+1LcBpQxVB
 UyduXMr98lYN6hBQefbh0zaDIWaWbvELjdRvgFvGrfKRtr6Nh912K2fYpQmQm7GGoi2xgSYgLGu
 CChwHy0MBietcxNGAuoarOscSr8Qvp3rAaf1C/zhg1uHN4YaOcH1xoHz4M8H/c84vmcxdb2bm/H
 XuwO1NQSAodql6s1+MFFz1vlXGSF0LrKUmmbEqOVJiyGMCTUsbts8Zx2h4gVJi+O8f17p182Hlu
 +9KV6O2Uu8JbaR2H++uhNGjX3LZQiAlBWATV4B+3Afk2KDhjY=
X-Received: by 2002:a05:6a00:3a2a:b0:837:e9cc:d46e with SMTP id
 d2e1a72fcca58-83f33cbf654mr9338120b3a.21.1778955501309; 
 Sat, 16 May 2026 11:18:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm12105464b3a.10.2026.05.16.11.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:18:20 -0700 (PDT)
Message-ID: <0b520bc5-d680-4e40-92ad-1ff4b6f71466@linaro.org>
Date: Sat, 16 May 2026 11:18:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/37] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260421051346.41106-1-richard.henderson@linaro.org>
 <20260421051346.41106-3-richard.henderson@linaro.org>
 <CAFEAcA8cM2aKa=9Qh8LOVyoEZKQfw3rTBfNrDi4xd_s+tXq2Mg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8cM2aKa=9Qh8LOVyoEZKQfw3rTBfNrDi4xd_s+tXq2Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/14/26 03:35, Peter Maydell wrote:
> On Tue, 21 Apr 2026 at 06:15, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu-features.h        |  5 +++++
>>   target/arm/tcg/helper-a64-defs.h |  7 +++++++
>>   target/arm/tcg/vec_internal.h    |  7 +++++++
>>   target/arm/tcg/translate-a64.c   | 14 +++++++++++++
>>   target/arm/tcg/vec_helper64.c    | 35 ++++++++++++++++++++++++++++++++
>>   target/arm/tcg/a64.decode        |  5 +++++
>>   6 files changed, 73 insertions(+)
> 
> 
> 
>> +#define DO_FAMINMAX(NAME, TYPE, FN)                             \
>> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)             \
>> +{                                                               \
>> +    bool save_fz = get_flush_to_zero(s);                        \
>> +    bool save_fiz = get_flush_inputs_to_zero(s);                \
>> +    int new_flags, save_flags = get_float_exception_flags(s);   \
>> +                                                                \
>> +    set_flush_to_zero(0, s);                                    \
>> +    set_flush_inputs_to_zero(0, s);                             \
>> +    TYPE r = TYPE##_##FN(TYPE##_abs(a), TYPE##_abs(b), s);      \
>> +                                                                \
>> +    set_flush_to_zero(save_fz, s);                              \
>> +    set_flush_inputs_to_zero(save_fiz, s);                      \
>> +    new_flags = get_float_exception_flags(s);                   \
>> +    new_flags = (save_flags & float_flag_input_denormal_used)   \
>> +              | (new_flags & ~float_flag_input_denormal_used);  \
>> +    set_float_exception_flags(new_flags, s);                    \
>> +                                                                \
>> +    return r;                                                   \
>> +}
> 
> I don't think this has the right behaviour for NaN inputs.
> We don't special-case NaNs in this function, and we pass
> our inputs to the floatN_abs() functions, which also don't
> special-case NaNs, they just flip the sign bit. So if the
> input is a NaN with the sign bit set, the max/min function
> will propagate a sign-flipped NaN to the output, rather
> than correctly propagating the input NaN untouched.

Yep.

See FPAbsMax{N}, where the sign bits are squashed before unpacking:

     let op1 = '0'::op1_in[N-2:0];
     let op2 = '0'::op2_in[N-2:0];
     let (type1,-,value1) = FPUnpack{N}(op1, fpcr);
     let (type2,-,value2) = FPUnpack{N}(op2, fpcr);


r~

