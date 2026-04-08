Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C5B10FC45A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAbCW-0002BH-VF; Wed, 08 Apr 2026 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAbCU-0002An-Oa
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:16:42 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAbCS-0003kE-OY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:16:42 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-471bf5157d7so136883b6e.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775686598; x=1776291398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6P4gHWKaE6cGmulNBoFPUffZF6Pb5l5kAqyMy2Igilg=;
 b=bVkiUTrx+KSOjmuuoWl0Dtct5J/aqrHPVL/SfjftmS5rdNbTTvmx+5SDb9HiD4euds
 OTDZ1454TlqdGdv+r5KvJmKfEAUGciulSKXNdqTd3/3ahdDbQAbxZf8sIzi6O7vee9YP
 i7kqlOOqwUrBvOvGJ+CuUy+6XfuHMrqPBZvxn1NK9Hd3wQ8P2NNB3WX0TvO8U8MpVIye
 3zwJQv/J3plWuzxacLIAiWcm9pkDBVBjaRjSHvcxHLTuWm0nqPJMI3JRIphLr4v1tH4r
 WRCPXYt0t1wO/MZu6ca9fm3f1rH3EcIyOZ0pL//7v9w2LRJXf70Crg/a1i/4FC0Vv0FL
 afMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686598; x=1776291398;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6P4gHWKaE6cGmulNBoFPUffZF6Pb5l5kAqyMy2Igilg=;
 b=pbxy5C1d0c4fpKTrhb3o1XXkLG9KG7dNxh08MkEhMnpTXAT9UwajipSPx6df0EpFz3
 IfqKy3bWTDcjlvmK/Piu68HSlqkgy5AwkWHPtwF1To42ZlK6myOC9uLB5biF/cw3/l3d
 p/8P886jdLU1+C8VnwVGKAMRTH91BZEfgJTjrHPolfjg67IqrR+7NCbuj5Yh0a5pNh5F
 dl5QsZP5K2YopEudwrTG586VCYeIxxdoo3I8C47d+Ga81itynw8J3gS8RxD3lER69CB5
 oi/CQBMzDUe05Jd/K4hdKTtAgzq3nbmiKSyeddVxkvGw31Z5FxeIGFhtwbgvcnBEeaT4
 PVAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3lxWz24tS5YaqRgQzxtwscXyisN+sj/qvtA4xMRo06IUU/9MjHd4Hpd6wrdFumfKhHYsFNc+m7ln0@nongnu.org
X-Gm-Message-State: AOJu0YwYWvXDxe3z4FgWAtdpzauKxc+V3Dt9pV3H8uX4OK/JxjV8FVLi
 TmqD/uSU++6hhhAZa+KZnFRK0ExdMG1kowM+DuI1koJ2QfAnjxiiDWxI4M7KPn20ueukoSgW7KT
 KTQF3r0U=
X-Gm-Gg: AeBDiev2lWQPxRXlK93Bf4nAaqKULYgh5G42yE5FRApSEOqESvDXdbfjmtUbKwcQjz8
 sWzwR1/m4k6cPADxoMU3rec557XjOnQPh9dsMgiuc4MOlBqdBvVnhrbH7pLCeIlYLFpPDnvjYXT
 P09ZGEnDPAIin/eXCL1df9vLZkFD+fh1YmX0eXl0DUy/hG2ve7qmaI+Ea0ZQMpr37hfKuRfVJ5T
 22LXjtOTcpuXdrPrZn66MimvMwS5Nk7FSdopaReECX/pphpuOHhun2RVZdkWSqCNl42NeEJBdCM
 sUAaC43gFPPS4KLWkxCoOMxFqzE136dQ5ypSUBA2MD5iV4k6gA877B31tsah6xE1s5hZi94OQnr
 uzxbqc9Mlkv0Ha5oFjJctLKHlX01ABZxTK61y9mOc+QvlfrhwYb/I8C/5/pWZVHw//Red+7vx6u
 8Y0H6aF9FP6l1vRQdiCDxICskTTw82PjbkX/0I3t9NQUBpaly7Kep5A4Mkc7q0dGehinY=
X-Received: by 2002:a05:6a20:7348:b0:398:7256:3c0 with SMTP id
 adf61e73a8af0-39f2ed95097mr25617684637.13.1775685942312; 
 Wed, 08 Apr 2026 15:05:42 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3baffsm22123741b3a.14.2026.04.08.15.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 15:05:41 -0700 (PDT)
Message-ID: <cd634729-73c6-4f61-8c4a-38e9f6bf6b79@linaro.org>
Date: Thu, 9 Apr 2026 08:05:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
 <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
 <f40a06f2-d3b7-4130-a7ea-cd90337c6bb2@linaro.org>
 <f2abb1dd-55c7-47ca-8000-21fc9f5d987b@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f2abb1dd-55c7-47ca-8000-21fc9f5d987b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 4/9/26 01:57, Philippe Mathieu-Daudé wrote:
> On 8/4/26 10:20, Philippe Mathieu-Daudé wrote:
>> On 9/1/26 23:50, Richard Henderson wrote:
>>> On 1/9/26 16:31, Pierrick Bouvier wrote:
>>>> dc->be_data is already set just above in the same function:
>>>> ```
>>>>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
>>>> ```
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>   target/arm/tcg/translate.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>>>> index ec4358ba402..55b89817cb1 100644
>>>> --- a/target/arm/tcg/translate.c
>>>> +++ b/target/arm/tcg/translate.c
>>>> @@ -6327,7 +6327,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, 
>>>> CPUState *cs)
>>>>       if (arm_feature(env, ARM_FEATURE_M)) {
>>>>           dc->vfp_enabled = 1;
>>>> -        dc->be_data = MO_TE;
>>>>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>>>>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>>>>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
>>>
>>> Whoops, yes indeed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>
>> As per my v10 comments, why Cc stable? This is just removing pointless code, right?
>>
>>> Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
>>
>> This commit doesn't seem to be related.
>>
>> Do you mean commit 79cabf1f473 ("target/arm: Recover 4 bits from
>> TBFLAGs")?
>>
>>      We had completely run out of TBFLAG bits.
>>      Split A- and M-profile bits into two overlapping buckets.
>>      This results in 4 free bits.
>>
>>      We used to initialize all of the a32 and m32 fields in DisasContext
>>      by assignment, in arm_tr_init_disas_context.  Now we only initialize
>>      either the a32 or m32 by assignment, because the bits overlap in
>>      tbflags.  So zero the entire structure in gen_intermediate_code.
>>
>> Since BE_DATA is in the TBFLAG_ANY set, I don't get why it
>> is set to MO_TE for M-profile.
> 
> This is a question to Richard btw, not Pierrick ;)

If you're asking about my inaccurate archaeology, I concede the point.


r~

