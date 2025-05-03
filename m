Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE8C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBLST-0001Ym-Ln; Sat, 03 May 2025 18:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLSR-0001YQ-8H
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:35:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLSP-0006Pb-FB
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:35:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so386883b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746311739; x=1746916539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBDLv71STM75w0x2/WasV/3cQ/v/8orxvJvsjTDMfqY=;
 b=LAj1PRHNwmbH17uoSRspGXozYhVPKQnnoWgMunfCVoPynAW0ATjxQbIi233r0+Kd34
 K7a+A17JkcrxF+7cVocM03XOCnkeA+Spa/1rq/Lo2Vq0RXwn7rmX550C+EoozQfUgoiS
 ZPvo6utbNgyudEuAFlM96aBj9JNXCCn2Kq9JwxAEwVAXuuAeEGspCH/Ww/0eHk3MACMs
 YN472f3u51dMZCX1KpDuO3Tdspt7m5SCptD+GjBxOq/5qhrylAeDF2Eg2WSLU3FeC8DP
 8Ewwa2nquOwiLp7gtCrM0nFJssRBV7Orx9GyvTE2objUrdEH/JqPEW2NL+9eg/btko77
 h0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746311739; x=1746916539;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBDLv71STM75w0x2/WasV/3cQ/v/8orxvJvsjTDMfqY=;
 b=PhgS/7hcMgw2z3Jk2zXFN5vjsJmi0Q5UEbhowWMZiH5BoYTPrAiSjmViZ7L3lgou14
 mgILSnBYtW1/6IOnzZ/kjAy7Tnj1YgmuLNZ8XRHpRu3jEm3u0WrjgHe0hSQuilMw9kX+
 gPd/pb1EwBTZq3jk/L6OH1HQ69RQzv6A03cLUo0xbzqmdQxR4BEFERYZTP1JN0M5+Fma
 1TsEn82kAvM8ZhlUVZ09VSumjzheYsxXpQQh5TGNK8Pct7HTkITgtefARRopIj+SKZvl
 0rkdnelcwWlxE/csSCIkVNuZns+3PGxSy7CYBNPMNNTQ79IuVR13NYdozo0SLpA6UUdf
 vSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDUNrilNt68u33RMDENCCMC0qeh/DuqUdXQYEOVECA50/3bvPcGlJaCqXiVJvQ7rNG0LaGudLN2tSY@nongnu.org
X-Gm-Message-State: AOJu0Yxqudx/0lLi7MzOkemM4Ye0/y1McoA9wZen6aygsVdK52w/fL9y
 Bf5TcQLMgtHOGFHiK+ixh3Fa7VJOrk2DO7C5N9RYxzJjq/G9e0iUhNPszWZiK8M=
X-Gm-Gg: ASbGncupNorz14uTkj3ilLNqCnhHC/Iv5iYbYIYWsyTNAymDd3IHTpo0WsFSaohv82t
 A9J1hmmPNj3mi6+ynS1qBbu7sdCfjVeKJcRv1VSOlqbjmQ1HQtBvRc5Oh7jFuyBbrz6SUvtiPSY
 ohrReIdTIx1Xh3rfpcUfdaAgjYsswdOn9qjTj3ZHXmAqtjFRqyppWfazuPEmoCMbULYqOLZ/WJB
 suIdizGqYvl1LthatqleXIB7qb977KbqlN6iRRY721I6OrsUjliBQJrAl9gMcoGv3vg+dsxFFRI
 Oo9A4XQ1m4vinNx6LiRYIyycWzyVUsMbwAw52nVKhn/KlMCKE3pYUg==
X-Google-Smtp-Source: AGHT+IFJAVVz+DXuFU/KI+fGh5lxTsxPYTq2T+1ENcK3xXo/V3zdiRTE8LsOsqIZ267Yuwp1VlKb5w==
X-Received: by 2002:a17:90b:3bc6:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-30a42e72d1amr15068492a91.7.1746311738932; 
 Sat, 03 May 2025 15:35:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eae35sm28820185ad.27.2025.05.03.15.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:35:38 -0700 (PDT)
Message-ID: <a1894468-896f-41ba-8c20-851f92b465d5@linaro.org>
Date: Sat, 3 May 2025 15:35:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/33] target/arm/ptw: replace target_ulong with
 uint64_t
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
 <21d32a4f-8954-4a36-ba0d-6cb7a50f242d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <21d32a4f-8954-4a36-ba0d-6cb7a50f242d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/1/25 12:35 PM, Philippe Mathieu-Daudé wrote:
> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/ptw.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index d0a53d0987f..424d1b54275 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>>        uint64_t ttbr;
>>        hwaddr descaddr, indexmask, indexmask_grainsize;
>>        uint32_t tableattrs;
>> -    target_ulong page_size;
>> +    uint64_t page_size;
> 
> Alternatively size_t.
> 
>>        uint64_t attrs;
>>        int32_t stride;
>>        int addrsize, inputsize, outputsize;
>> @@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>>         * validation to do here.
>>         */
>>        if (inputsize < addrsize) {
>> -        target_ulong top_bits = sextract64(address, inputsize,
>> +        uint64_t top_bits = sextract64(address, inputsize,
>>                                               addrsize - inputsize);
> 
> Maybe use int64_t for signed? Anyway, pre-existing, so:
>

Yes, I'll change to signed integer.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>            if (-top_bits != param.select) {
>>                /* The gap between the two regions is a Translation fault */
> 


