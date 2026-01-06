Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC8CEFCFE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDJS-000248-4Y; Tue, 06 Jan 2026 15:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdDJP-0001zj-Qb
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:05:52 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdDJO-0000ZJ-7q
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:05:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477770019e4so11446975e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767729948; x=1768334748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWDpdQA31alZgSKJxXmD24ihSckz9ErDDAbZjXFU90E=;
 b=AKQj6NhzrDZzGaHxXKS0i6Ut8niPy0wsW5PIay5qBj/pICPnCj/Us4RTOiuGZqdQtw
 kiv4lGDq7z6/4ozPz5pe0FclL9ydcn83ABB6dsG4hBoeFPj4ZuWicfz0kzUE593dfm+j
 m7wB9KsvH3HAUE1fFtN0PeIZHqFafq86l8Ze34kAJ8RwqTsNjGOkl5OwfOy4ouu3dQ2r
 a1sBkBOYc2PxWORzWIx77HSunV5GKo6HHww0RmjWmZzu0nKG4gVH4nlzvFOOKU9Hrpdy
 gTCvCb2Iz5FBF2w67J8jiruPCCTrwdXG45Btz0EnPWYwK7gScBcX5Q/4HHeqpIEJi0lK
 EfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767729948; x=1768334748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWDpdQA31alZgSKJxXmD24ihSckz9ErDDAbZjXFU90E=;
 b=gLu9xZWHfYwa8km+eWhZg/JotbEGcMALswSyVkAjh/4qcVxnIDyxZvmzoLbUK6lXUn
 D7fzT62wNTl0rd0k6KzqKqcWkn+7gg0KD+oi6LsetiId3IFjIVjPWARo5EtEoaHHmZG9
 El8hjDWa8jyJUHTsRRn2q4q4YeUGpyJN3FkaRb/d8kNm+qu9bqeJi3CalqOP6dw/NNB9
 xKRizlvr0THshcMkCzd7tqAKDunH7+l+3Tl3YM/g0iegICshGpdDxwKB5I05AVl73I6q
 UQuo/c6iw81g8lrTzVxsR3PjMC2a+QuVgNa/L1BU+HiRjInScIM4EL2rEHIDOpNmlKqH
 rJgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0SmiICA+8UMa8p20hM5fdNgll41n2dr87SnNMg6kOT9zeMVEwK+EiWgZoM0z7XA8O6kgbkAq4JdW6@nongnu.org
X-Gm-Message-State: AOJu0YxI65rIVBQYsaoK8tmh76R1FNffMTggD5tlPT+D+Gnh9lyM//18
 /cIakD9EGEIpyF+2EDBq+FjKWoTUmvfhg8tKLPPqv7wXfCyTmPOFLeenC8qrNWKn9qE=
X-Gm-Gg: AY/fxX56YUwuKFcCAbw4b4IKTwWodwtG/Z1VB+6ZRICLrvVogZj8blIOKJNly8IraL/
 nf27h+WJYAiZfneRwVtl9QLiynempQGGb6XtmF3qYAwKhSOrvu8RIx69PIYGNiZcRmClbCXzi76
 yPxB5Y5Sh0MGCMCcPjd5Zm0OOmxu6k5yb6DAY79w1c27LY48qf/GEFYYGeZOlqXjGKoUbOCbkdU
 6NXK89L7NCprteLZW3ksoE8pxyq86FK6yjB520IpLGLKl8rV/I2pubRNS9ifqIxh441EsaFmniu
 GWYuXqCOnqtqtQCdZencxy7Cm6zO2FlsGu51sFHZ6tz/QwC+Uews6YRSY6fLt64CFsuLWsPsbgn
 SFKIonkLNHVm0VDluqN7WYv4TX8tBcuVaqwLJJLjoR9c4iSf1pAyAL1sz9GvLXb+Xml2nbi2jHx
 K9SYVd8PdMM6lte+eeyDQzPTvTRNOeRyLLyua4BjKT3og12Ve6oSOWxg==
X-Google-Smtp-Source: AGHT+IGegEfsnhYQZ0CkPFvNbI1orVI+KJ8AgF/c7EMw7yO0JW+hkl50dqCMg5fb73kXkLnNj/IERA==
X-Received: by 2002:a05:600c:3b90:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47d84b3864cmr1290975e9.27.1767729947551; 
 Tue, 06 Jan 2026 12:05:47 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e802sm61025315e9.8.2026.01.06.12.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 12:05:46 -0800 (PST)
Message-ID: <72543341-2fea-448d-a610-76e1003778a2@linaro.org>
Date: Tue, 6 Jan 2026 21:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] target/alpha: Factor mo_endian() helper out
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
 <20260106155755.53646-6-philmd@linaro.org>
 <f465bc94-4343-47f7-8526-3fb63eed54cd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f465bc94-4343-47f7-8526-3fb63eed54cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 6/1/26 20:00, Richard Henderson wrote:
> On 1/7/26 02:57, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/alpha/translate.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>> index 3be97057465..4f918cbfe63 100644
>> --- a/target/alpha/translate.c
>> +++ b/target/alpha/translate.c
>> @@ -96,6 +96,11 @@ static TCGv cpu_lock_value;
>>   static TCGv cpu_pal_ir[31];
>>   #endif
>> +static inline MemOp mo_endian(DisasContext *dc)
>> +{
>> +    return MO_TE;
>> +}
>> +
>>   void alpha_translate_init(void)
>>   {
>>   #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
>> @@ -2905,7 +2910,7 @@ static void 
>> alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>   {
>>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>       uint32_t insn = translator_ldl_end(cpu_env(cpu), &ctx->base,
>> -                                       ctx->base.pc_next, MO_TE);
>> +                                       ctx->base.pc_next, 
>> mo_endian(ctx));
>>       ctx->base.pc_next += 4;
>>       ctx->base.is_jmp = translate_one(ctx, insn);
> 
> I don't think we need this or the next.

Shouldn't we define mo_endian() for each target for consistency?

> The note about big-endian cray alpha was a mere curiosity.

Well, I like it and it doesn't hurt :)

