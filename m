Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC2D46977
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viyfo-0002Cg-PX; Thu, 22 Jan 2026 12:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viyfm-0001xE-7L
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:40:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viyfW-0003G4-J7
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 12:40:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so11183475e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769103626; x=1769708426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T18WTgJAP0KXw1fYxRcwzRoLfwi9bzmU2Fjs+7gqb5U=;
 b=L8sxGimCXKNT0dsdT/uy00so61SC9UaAsChdHzAhRUFH0wlX/i3BieZIiL39Sj06VW
 aKl1MCS5mywzEu1h0xPw2PQxYoaVzjBMKjQzSvlZWoL957aBW8xJFDiHmHygXlxlM7Le
 XPRnm3XU1F9mkbpe5A+Uuf3UDWjeBfn0wYBWCIwrUq0zHEakLJ16NLkw1Y7DFIOrEyIG
 ge+An8lHEFdSAdp9MdcdFz3E9ts/v+Rk1sR67wXvHECQ1kdwz2Od8k7JHcEDq96INrbO
 xs14l9wKQgWMJXqOACoZ6JTRSvGwy8gwnpe0QTi48McvWqvPZH4TU7FlXk13wa+TR54r
 gCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769103626; x=1769708426;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T18WTgJAP0KXw1fYxRcwzRoLfwi9bzmU2Fjs+7gqb5U=;
 b=kt8uLc7P7sgr+Fq7pUXErw8okycpvRdUBTe/sICA6LM8XBbTRmRdj/+a3n22DB19Dy
 GnxidReoGR2TDWZQKx9A+K6OJtmaEejv6mnFVSKUi4E3CImxJ1DBnS60m8NWT91q1i71
 kcS/MAZ1irQ01vqJNgN+lscYMGNITz2UwOnW1AXrWw6d12nUz1Ltv5ajtVVw1WzAhHoV
 oCpXs2LwKuTHe0L2462TEgu21zUr0HqHZnDtEHt+53w7SmqQ3Rs6Q0wwY/+Xf2PdG4Ae
 cQH5V1i8L91SYrO04PM/uSHQ0cyi0G4KoxtoC2YnkqwZWMAxH9OhaqCDZ+f25Lk9QVds
 Inlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVunBRMZS/1IAPpjBxnngdphHqX0FjOuoaslj40jSB0zngRjTX1Y7XiIghobCBvoU2ADzFI2iRs14Yo@nongnu.org
X-Gm-Message-State: AOJu0Yx0+pgu8uTLOFRXu685oo2Mjldxuxt9jX12PUVqFV9NPR7rtNZ9
 DvuuatZD3I1fmarouxtoroS/jfNcXhIqG0b0O+ujnHyzPUk6RWUp21pB8RFYSzJwW9w=
X-Gm-Gg: AZuq6aK/t4F0BmCMxXqHM/UKnuPkNLHr+OSeSQb4Id4zw89FrFUgAh+rU6DIBoBShT1
 PzKjq62a1QAGZmnmF+viGZ7tSHaOCYVssjdM+8sM0QlbqgDkZZMIqWHS8fXbw6YtIjfAZd8rr7P
 ZApEcMU0Una1zDkV8FuuoK5hvaqjnYcfEgXpMWiaQTFy2EGNSBlsrplq/ShSBNX1j6Mza20dYNY
 xivUigbr4X1tR6eOaRWzdv6D1EgKb3fWHksrbWkQgiwsvLNjuvjni8CDd5QtXBjNQPZHMlAKWjO
 TTgxSSAkHlPGxavfSlY7XI2UGBS7/XA0gc53FQA/zW7cHLrDLzMcPVGou0Izn3aYRyPPvFzLKZl
 dfHTVkjMOvDSNciO+1fcGMCW2W3evFWCKZcTCxzf2UAVzNJOzC2tpnqnhqtNFGi8mDbeZ3kPNp2
 S0NS8q0XEyZR5ql0vZ/t1tzbGhPpfQLpozCZ0njhNV3gZnq9EHV3rXtg==
X-Received: by 2002:a05:600c:5298:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4804c9d9f23mr6112405e9.36.1769103626359; 
 Thu, 22 Jan 2026 09:40:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470403d3sm85824825e9.5.2026.01.22.09.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 09:40:25 -0800 (PST)
Message-ID: <982f5122-56b4-432c-a83f-fab17f0cd644@linaro.org>
Date: Thu, 22 Jan 2026 18:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 18/22] target/ppc: Inline cpu_ld/st_data_ra()
 calls in do_hash()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-19-philmd@linaro.org>
 <f1a210ab-8d4a-4646-b358-81183a74c5b2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <f1a210ab-8d4a-4646-b358-81183a74c5b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/12/25 17:57, Richard Henderson wrote:
> On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
>> In preparation of removing the cpu_ld*_data_ra()
>> and cpu_st*_data_ra() calls, inline them.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/tcg-excp_helper.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
>> index edecfb85725..244aeb23c16 100644
>> --- a/target/ppc/tcg-excp_helper.c
>> +++ b/target/ppc/tcg-excp_helper.c
>> @@ -160,14 +160,17 @@ static void do_hash(CPUPPCState *env, 
>> target_ulong ea, target_ulong ra,
>>                       target_ulong rb, uint64_t key, bool store)
>>   {
>>       uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
>> +    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
>> +    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ | MO_UNALN, mmu_idx);
>> +    uintptr_t retaddr = GETPC();
>>       if (store) {
>> -        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
>> +        cpu_stq_mmu(env, ea, calculated_hash, oi, retaddr);
>>       } else {
>> -        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
>> +        loaded_hash = cpu_ldq_mmu(env, ea, oi, retaddr);
>>           if (loaded_hash != calculated_hash) {
>>               raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
>> -                POWERPC_EXCP_TRAP, GETPC());
>> +                                   POWERPC_EXCP_TRAP, retaddr);
>>           }
>>       }
>>   }
> 
> This is the page translation hash.  I suspect the actual address must be 
> aligned, and probably forcibly so via computation.  The MO_UNALN is 
> either wrong or misleading.

This is a faithful expansion of inlined helpers, showing the current
logical state of the code. I'll remove MO_UNALN in a subsequent patch.


