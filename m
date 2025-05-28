Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE1C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 14:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKHuZ-0005ON-If; Wed, 28 May 2025 10:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKHuX-0005N5-Ls
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:37:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKHuV-0000yb-Tx
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:37:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3291496b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748443058; x=1749047858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMh2TVV4eeHKMqvY+eazvowJdgpKvE/w2N3CHLyN6kg=;
 b=VdrMD6K5rcnwnaaWQcpXRe7w7XEQOZP3YyAXpJlrxLhQxKPrG4CXhMTI0G0iOw24tE
 jh17bci4N/HCN+79vNwCgLnS1qz1R81y3NKAu2/CIDSVMFsyl/OjypXEcBIUErZn/qzo
 ZZDvaCujn+zPfrFeSXpfv6p/y90qZd6TrCUwF4lTTaqiEUPjw77M7PFRCf77j7dCDuDL
 OHkn+AdOD2Mr9niRdQdA4rUAFgtDSge+B4SnE3z3EoGQ7bWI7uWjvuA4WUBkQ9wlUwEB
 BDhXY/VsTG/8+6QNsKd7+7VOu/VAlh36bXzLhKhRCXL2+Ter324rfcBHkRZeCm6j1snO
 DB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748443058; x=1749047858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMh2TVV4eeHKMqvY+eazvowJdgpKvE/w2N3CHLyN6kg=;
 b=cIsDwL9kot3Njio0Zgb4gO+1N+KLS0mO+8lguZnxTHJf6+5GTd3jezLACJpJCoHtN8
 Qq8M+hrfv08MZhwMrPTKQCgELGQL/9lhGkLxjbVrMzFObdKpvlkTEafoWcCpnijKazwo
 vfUZMmR+NIAJYE9rJRlu/6YI7BOFWTn873D5m2gx01p2KI9wngf1ocxYZkcCRDH2aDp6
 TR7U8n0eoXj7kTe5w8bxQ+c0ouSL8JCGTVv7Is1aFoBT3TtsvLHlCsNvgjEYg4L7aDFw
 UpjUPpOwI5hnRb8Ic3vxOXtOOQbipwAZQj3QBMbOGN9j4rhYNyhCGbh1pa+XyBvQVzwP
 z+8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZqsrqWpw0tqSl1BwhZfcCT3jujhGoadF7Q604HlG9HNZ+ngip4w/SBUtcjmwsCsXhlmGrDIeNzKB6@nongnu.org
X-Gm-Message-State: AOJu0YygMYwykjDJq94tVh40zqreee6Chj5w7RcMXEsCve7qhouwKgcW
 09ABIr6lusTnMGcVXtaEleeJqQLb7/22iO0GKA1pHDtShdp7I2wqCgG3WNCYTj99CDk=
X-Gm-Gg: ASbGncvKrthnHokMbF6iCBTayq0/vzxnrX+OlOR3zwLehsh2HSjlAWT6pEYXqbrTtA3
 rE5Puu8+7PrWjmiDIKJ/1bbqBXh+McL9o1/H2AuxWfzOfZIBV15sXd2XLV05pTC0rRiOD3w5W9o
 ohg29oi34B13M7xPz/CO3X6JqsexdcmbAJDBYaJBj/q1msiTQF/qElH65tp/NnhH5u178xvep4P
 UVuAEGY24noIXAk2oe4Gb94zIZ3jS6UMwBgZyMpn05QUj5fcXsev31juEmbBU19UY9mwoy3dS/f
 VdMOge+mbJWeYkshQDAuHH2gd6njLdHcasYOiiyqpYF2NVAfMOXONCVlROqbffuQ
X-Google-Smtp-Source: AGHT+IHyIRghCSFgFT3F+qOY6f4cBrVcP/2xt9ncYI609VB+1vwFQziuEEHqFEV1N9wRbOTDkYtCnA==
X-Received: by 2002:a05:6a21:6e4a:b0:215:de5f:febc with SMTP id
 adf61e73a8af0-21aad937ce7mr3875658637.27.1748443058070; 
 Wed, 28 May 2025 07:37:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2d99e1e448sm1230524a12.29.2025.05.28.07.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 07:37:37 -0700 (PDT)
Message-ID: <2aa7e70b-f429-48e2-ac40-ef66f43f5b46@linaro.org>
Date: Wed, 28 May 2025 07:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
 <23fce516-74ca-44ca-9cfb-e3b632a977c9@linaro.org>
 <bb371110-1561-4e38-8783-c6ba3073a0ad@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bb371110-1561-4e38-8783-c6ba3073a0ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/27/25 11:42 PM, Richard Henderson wrote:
> On 5/27/25 21:45, Pierrick Bouvier wrote:
>> On 5/24/25 7:40 AM, Richard Henderson wrote:
>>> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
>>> we failed to update atomic_mmu_lookup to properly reconstruct flags.
>>>
>>> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
>>> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    accel/tcg/cputlb.c | 15 ++++++++-------
>>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>>> index 5f6d7c601c..86d0deb08c 100644
>>> --- a/accel/tcg/cputlb.c
>>> +++ b/accel/tcg/cputlb.c
>>
>> [...]
>>
>>> @@ -1882,13 +1886,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr,
>>> MemOpIdx oi,
>>>        }
>>>        hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
>>> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>>>        if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
>>>            notdirty_write(cpu, addr, size, full, retaddr);
>>>        }
>>> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
>>> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
>>>            int wp_flags = 0;
>>>            if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
>>> @@ -1897,10 +1900,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr,
>>> MemOpIdx oi,
>>>            if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
>>>                wp_flags |= BP_MEM_READ;
>>>            }
>>> -        if (wp_flags) {
>>> -            cpu_check_watchpoint(cpu, addr, size,
>>> -                                 full->attrs, wp_flags, retaddr);
>>> -        }
>>> +        cpu_check_watchpoint(cpu, addr, size,
>>> +                             full->attrs, wp_flags, retaddr);
>>>        }
>>>        return hostaddr;
>>
>> The watchpoint part is an additional cleanup, (BP_MEM_READ or BP_MEM_WRITE implies
>> TLB_WATCHPOINT is set). No problem to include it though, it might just be confusing for
>> the reviewer.
> 
> The watchpoint cleanup is required, since I remove TLB_FORCE_SLOW from the flags.  I
> suppose *that* isn't strictly necessary, but it's what we do elsewhere while combining
> "fast" and slow_flags.
> 

Yes! I was just referring to the last part where you remove if 
(wp_flags) but kept the whole diff chunk for convenience.

> 
> r~


