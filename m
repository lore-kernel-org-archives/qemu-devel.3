Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C63E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeJW-0002U5-GC; Wed, 08 Jan 2025 17:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeJU-0002Tb-Gh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:14:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeJR-0000IY-Db
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:14:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso2463115e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736374441; x=1736979241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HkpVNvz8OiUHJly0dtgs3s5fVF4bZnDmiYZGR2NuTJo=;
 b=pZVjm/vTlh1IeUj/3GzKRN0qXfwiE3uusbYNZi2j62S8r/eaKansevB0eZAxZXEPlg
 8cZVrvyS2j/B4YcJqR/4TnvXp4s1X70sKb+N2AYHYGexRoRhfiDhNT+z4IH7SYlPrCtI
 PLNJSLi0CqZL/pLWDX0JyZcA5AqK7cvsRVX1VKesyp2PtIE5G/ksu4P2DFxF3X+/O/zj
 J9Gh3ymxuhoiQ1kWlmhgirZwrGeporwr7mu9LgvBeCJX3zjvXalO9+V5qLJTsiOqCrsx
 tAkVHAwCS39UtOCLsAce6plOwrzkTpMJ1mUwaMXuiNk5idJ3j4oxNVS1/s2frs1MObwl
 0dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736374441; x=1736979241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HkpVNvz8OiUHJly0dtgs3s5fVF4bZnDmiYZGR2NuTJo=;
 b=vD5jT/goEQjnJEkyk/TE4NmHxBZgVrdP4RQvleR/pq/hDP+Bh4fRGNaDchP2KQhMwP
 fKJkKk34NVngsfXYg2/upCtn8GZYbmA64/lPg9AOakZRFiSytFmz+gNz1GceP4DiVBNC
 JEJ1nhiezplMwC108SkqCYdnczuWD0wi6aCN3P0PmYXBMGL/KXpyEqQZdVJ+1HDhyjjg
 cmfi/GSZtUrym6/aNyDkvRdgbp+eWqOdkXCIK0d/HkRylJF9dlh+16S+uitA/S0sx5GE
 IHUx0SIMQI++ncTHkUHVTkJbaq40VN22BJUIR60uctnZRGzOkDqsV/EMf9dhRXX4SI9L
 MZEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuYzn6VyEpHKOH7Ee/Pr3tPeVD2RX7QmT25zazjWSz7giAfGnwYcdP2CsA7q67j1ZoW6RlJIwImvZ/@nongnu.org
X-Gm-Message-State: AOJu0YzAhyk1GdKbw/gsiE6PJLJazD9wIuvWa4lTzaHlSx/aBHVf+H7J
 jDTKuZ4o5gxQ9AY6JEk3LQwy1Eyw6uEmQYDlUnAT2LqF9IyveicXV8kg09ziwGQ1z8YOCuoYzXr
 vKao=
X-Gm-Gg: ASbGncshjNQMlCshPqEJpAW0wwOmhh/SrEA6MHGQ7xUg6FMIr7zE2uJRDGfJJpBo4eC
 yrs3ykTa1srG5vUS2NpjJuTplGTzj8gpR78hOv+1Yw53vQ56vNM5z2HDGRRj6ILQxIS/tD32rsT
 4ZcqgU1aXgHjLbB7UAazbPwVvc9EoDotTV0XtOJWxqB//WzaUeBO53XhCM3dwo+Je0hkHz/JkAV
 HBTY23OelCSIOePQw8VPB2XbQkZgYrF0iiLFm0A9yu5VVWWwoxkjLQ8hwQ8wqhw97rHNxo/d68R
 8vAYqCPoxkdfJW9aYNdtvgNR
X-Google-Smtp-Source: AGHT+IF9rlkowUbW/dWDP5pAAceIgDRtKCa9O7axjezkdxzgG9k53OMvKgham0fQU3KZuGBGvIi4+g==
X-Received: by 2002:a05:600c:138f:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436e26a88d9mr40077135e9.12.1736374441476; 
 Wed, 08 Jan 2025 14:14:01 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d26a7bsm400545e9.0.2025.01.08.14.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:14:01 -0800 (PST)
Message-ID: <2353d8be-843a-4054-86e8-a961aab62769@linaro.org>
Date: Wed, 8 Jan 2025 23:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-8-richard.henderson@linaro.org>
 <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
 <393fb699-a360-416e-b1d1-df9372685c16@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <393fb699-a360-416e-b1d1-df9372685c16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 8/1/25 22:38, Richard Henderson wrote:
> On 1/8/25 09:46, Philippe Mathieu-Daudé wrote:
>> On 7/1/25 08:59, Richard Henderson wrote:
>>> Rely on tcg-op-vec.c to expand the opcode if missing.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/tcg/translate-sve.c | 20 ++++----------------
>>>   1 file changed, 4 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/ 
>>> translate-sve.c
>>> index 49d32fabc9..732453db6f 100644
>>> --- a/target/arm/tcg/translate-sve.c
>>> +++ b/target/arm/tcg/translate-sve.c
>>> @@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 
>>> n, TCGv_i64 m, TCGv_i64 k)
>>>   static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>>>                             TCGv_vec m, TCGv_vec k)
>>>   {
>>> -    if (TCG_TARGET_HAS_bitsel_vec) {
>>> -        tcg_gen_not_vec(vece, n, n);
>>> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
>>> -    } else {
>>
>> Why aren't we doing the NOT n operation here?
>>
>>> -        tcg_gen_andc_vec(vece, n, k, n);
>>> -        tcg_gen_andc_vec(vece, m, m, k);
>>> -        tcg_gen_or_vec(vece, d, n, m);
>>> -    }
>>> +    tcg_gen_not_vec(vece, n, n);
>>> +    tcg_gen_bitsel_vec(vece, d, k, n, m);
> 
> Pardon?  It's right there, unindented.

Sorry I'm not clear. Previous to your change, in the
TCG_TARGET_HAS_bitsel_vec side we use the NOT opcode,
but not in the other side where we expand, why?

> Anyway, maybe I'll keep this, as it's still used on pre-avx512 x86 hosts.
> 
> 
> r~


