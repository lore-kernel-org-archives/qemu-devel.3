Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F6AC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTlR7-0006OG-N0; Mon, 23 Jun 2025 13:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTlR5-0006Nm-H0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:58:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTlR3-0002ZP-QY
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:58:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso4168694b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750701504; x=1751306304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=veyf+rqFiNAY/fOVJkJmu1D2J6cR1coBKqZtLa9oQMY=;
 b=O9yqg9Iv6KcLhunB6XtN11mCW6u8+6Qt2MD9oY9mcZn10UvYLRmQ/Gow3G8uEbgA8S
 PDRVVUPt3OczCrfXwhJ4uNxDZNaP0AhiyYrWtdMFEgkMuqlMsrKkrkdgO6Z6Sr5UGVY5
 JPNfXCzX3xSROntcMGJuwqYbFx11UTOh3eLf/xzrBIM4TgFmzhyCnWVyYsCRs049hacX
 tMxkx+qCwqoRkvCgXZcw5uYDuLtsQJZajgrhE5XKhly1lFSJUt/3wTDzZsbcD5jw4F7W
 AjeUHYaghnC4A4T9PZyxeKkk9jhubVzYNqC+2f+Vh8ZWteduciaR2xVm8Kjn5C6old8r
 Yx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750701504; x=1751306304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=veyf+rqFiNAY/fOVJkJmu1D2J6cR1coBKqZtLa9oQMY=;
 b=RjRh7F02ji7XZ+ImXGbAjTYVoAaTihU8GNzVx6dtBA3wFF4IyOXjdbDPY4Iy9msQpP
 lzwMZak5j8cXk5XyoeBYU/yogfcFR1lEcBIuFBj+ktGeWGkl9H5YeBgv4FJhh/ICvsQ8
 A+ufthy42V5fd053HyUrosLSlKYqWgPt4n0yBCf/6h6f4bj/qNcbqOdwpIyMlJEqBmfB
 1MdKiSmIC5ZnCdOvCmCjOWF0asIhCGnN6Pssbk9fAUf6hY+d/nceOpTDzdVjIZBYBvoN
 Ts7foljMLmTA/krwdU/AN8ifpbAvILsRh8Ib7Wsoyk+1YV7urMscbcd5vh2I8KtSK2v7
 POnw==
X-Gm-Message-State: AOJu0YwRBfm6oRdn+cnNkTLg8rWurQ868MKKfOhJVn2OopDdc+lpwfhz
 5XD+S4EHajnUDFQhzGvuI9PAe9UfxfmIUKMyIcLjRp4N9CoDbPTfOolbNBN3OkUa6UQeqQE07YI
 FialQZAY=
X-Gm-Gg: ASbGnctTTyRHZkAIucpc3tWsRniK57sby6DnVqH4iNgck4qO8ryCF7dgwpg0qMjNxhD
 uCwxxV+/Ip2QEoyW+x6gcs009Kwb7dyflLUkGVabBWazqxN7IbWg+D7P6AXik0rwNrISAL5vBuW
 16ZTDDdEt+sXEljKtWLZRJ9Xk8p4uacz138OtSR/P138oH3+Pn1FCmTKp1hZ6GTuAcSSK7TtSff
 xFG13vrVXZlEZD756r9Iewi/44DOSG1X5Q8OfjKA+xqZfMns1fAe70IxCDnBCJV7KNOHhco/nvV
 9cb+C5ifizH/HOeA/0pbRQKKhSOUtdgBEPthKDZKO9SbBze3A49mMSKlxPATQ1sujj9vMReNvw5
 QUaLT2wyk4fnqhPiv1RWt5V/qEYfvvzLYnH7KA9c=
X-Google-Smtp-Source: AGHT+IHRCf3WTnz5Bdb2wCJk0PzreY5KEYia5LMeIST6DpyIYIRCqCEUzmdGVyQ4IinIQ5IfYOIO6w==
X-Received: by 2002:a05:6a20:9e48:b0:220:193b:90d with SMTP id
 adf61e73a8af0-22026ec61e5mr20534262637.26.1750701504170; 
 Mon, 23 Jun 2025 10:58:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f1241efbsm8419612a12.36.2025.06.23.10.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 10:58:23 -0700 (PDT)
Message-ID: <ce91e423-703d-4054-badf-e4e30b14969e@linaro.org>
Date: Mon, 23 Jun 2025 10:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 035/101] target/arm: Implement SME2 FDOT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-36-richard.henderson@linaro.org>
 <CAFEAcA87DoZhX0NNEf7nao48VGu7nfpmO0wug6JduYLtEKp35w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA87DoZhX0NNEf7nao48VGu7nfpmO0wug6JduYLtEKp35w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/23/25 09:38, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/helper-sme.h    |  5 ++++
>>   target/arm/tcg/sme_helper.c    | 44 ++++++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-sme.c | 18 ++++++++++++++
>>   target/arm/tcg/translate-sve.c |  5 ++++
>>   target/arm/tcg/sme.decode      | 14 +++++++++++
>>   target/arm/tcg/sve.decode      |  8 +++++--
>>   6 files changed, 92 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
>> index cdd7058aed..ec93ff57ff 100644
>> --- a/target/arm/tcg/helper-sme.h
>> +++ b/target/arm/tcg/helper-sme.h
>> @@ -173,3 +173,8 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_b16, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, fpst, i32)
>>   DEF_HELPER_FLAGS_5(gvec_fminnum_b16, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, fpst, i32)
>> +
>> +DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, env, i32)
>> +DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, env, i32)
>> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
>> index 194560eafa..bd9b81d5aa 100644
>> --- a/target/arm/tcg/sme_helper.c
>> +++ b/target/arm/tcg/sme_helper.c
>> @@ -1122,6 +1122,50 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
>>       }
>>   }
>>
>> +void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
>> +                         CPUARMState *env, uint32_t desc)
>> +{
>> +    intptr_t i, oprsz = simd_maxsz(desc);
>> +    bool za = extract32(desc, SIMD_DATA_SHIFT, 1);
>> +    float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
>> +    float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
>> +    float_status fpst_odd = *fpst_std;
>> +    float32 *d = vd, *a = va;
>> +    uint32_t *n = vn, *m = vm;
>> +
>> +    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
>> +
>> +    for (i = 0; i < oprsz / sizeof(float32); ++i) {
>> +        d[H4(i)] = f16_dotadd(a[H4(i)], n[H4(i)], m[H4(i)],
>> +                              fpst_f16, fpst_std, &fpst_odd);
> 
> I can never figure out with these helpers when we need the H
> macros and when we don't...
If the access is smaller than uint64_t, and the set of operations isn't completely uniform 
across all columns, then H is required.

As it happens, here the set of operations *is* uniform, so I probably didn't need the H.

r~

