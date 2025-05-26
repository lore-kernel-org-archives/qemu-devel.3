Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC4C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcMD-00087D-6m; Mon, 26 May 2025 14:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcM1-000867-MF
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:15:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcLy-0006Hg-5v
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:15:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so23001465e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748283312; x=1748888112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRWTXK6F0TtjftMzftbtG1pBhONz9R1WrCmvSecwMds=;
 b=i3FQYXsnk27YbhT0qOGWCWf9LOhTzmr/y5QaIZxQkncTFbiZybd6kTMp2tkZfJIiQm
 M5sbDKH8/aQ01CTAJctnzDK9pM0+NPXKQjxjbBSKczPOtyVjN1iUYXymcF3c6v8cseAK
 HFoqyyohUUrXqB6mtxeB4ihniUG3JQaoWYD29w4BacgRgWV0sysVWGYxK1Ssz+15SC47
 8nfCceDH8bHgMcaRyapgrfSO1Acf2c6YJRRxdYBxz7jZR6v5LCM0CXubxROjkJ+KLhNw
 fbt4sAIh6Qu6R6HpZ0vYogl04lf8wUryT/diyrprMzrRD+ThrfacSLPrB0mAHIEp8U7e
 NpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283312; x=1748888112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRWTXK6F0TtjftMzftbtG1pBhONz9R1WrCmvSecwMds=;
 b=sGEawZ7N1ObYi76BWSpGagzbAApKof+snwm/q8aIZhX5GiACcyovoAsRuI/fCV83wm
 YoeE1UHcT1yCVZCPsjAla2Wr+0xOJMUa94Xo2i1sw0GdmQHIJmtyQu8pHWqgNMdqqiFi
 S+c0SRL+H2D68ZANhv+5r41JZPmOkexbVd1dIBN+IMJ9jR4wKg2fBONJHFRgrsGVYyNW
 lTQQwqkyzOgt/yjcxIOAeNdxp6NucUGz5eBDghX6jmvwRPbbuUZ0d1Pivmh5j+sLniyc
 fmTsUw2GmbbL+Y9J05MgiGl3PqWdcz1pBBTzJeG41bgr07J/80TYi2sp36zGGDl2xVOe
 i3Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbiqPmEJf8+zWhM+Eyj2dG4F3FOOILAFWsdSgTF8ruD4BH3gF2lu4s3u4Pee8J0knQMu8Xyc4NWRh8@nongnu.org
X-Gm-Message-State: AOJu0YxEx23tonEcSp7oKvaAorqwJJbUmQU0E5SR3U/+oO2rQCtufofH
 1obl4eGwBntcJ5iMi3DZOcNMzzv13TZ3ZkN5MCii6Rre5b0T2D4IkuvNSHYn63nvKlY=
X-Gm-Gg: ASbGncuu6KRSN2g12ipp2QY0c7H04BfHJ7jX4Sz30Yud8D30GWD1vgQw0mkEy/Gegnw
 W4GhfrEiIuN/lhNasJ/PO4DuAJ4jb/lOGEa9CJDFQC0KhEf4BjU/RwYC5Y6YC/CrYBC5kSHCWFs
 ec4Dt2KsTOWbki4MRkE51XKlJExrq0n5IZ9rRNDESzBL/jMecrBjiGRgtumtfgV4tN6oJBSfge4
 d+2UvuIYUCYFFyWAZNwrqPR+C+iNo38cdWpA1unsuECSmvuzBjURa5Sfx9nJvBdCzCuc1k4F3hj
 GVV8Rcgpuml9L07u7ijCpyeAPD/ZxEIGNWV4XibCs/4HyrtC1VP2+FhnY4oNQCh46CoVL/RWQX7
 wuGi02BQwiPycByujESh13OtR
X-Google-Smtp-Source: AGHT+IFMxQLEv2ZxU9/LVdfnpCq8u5a8B+HuHh+1TvK7xwqy3AysJaI9Pf+HCtXIdzFj458BI+2Veg==
X-Received: by 2002:a05:600c:8189:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-44c919e13f3mr80705585e9.11.1748283311925; 
 Mon, 26 May 2025 11:15:11 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d5deae4dsm4827908f8f.2.2025.05.26.11.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 11:15:11 -0700 (PDT)
Message-ID: <f1fc4726-8b87-4995-a874-60e0c969b633@linaro.org>
Date: Mon, 26 May 2025 20:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target/riscv: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-riscv@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-10-richard.henderson@linaro.org>
 <e8db1ec3-fcb3-42d1-a488-cf55d6060904@linaro.org>
 <702b4c82-653d-4782-8805-c4ff9a1155ae@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <702b4c82-653d-4782-8805-c4ff9a1155ae@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/25 20:59, Richard Henderson wrote:
> On 5/5/25 09:47, Philippe Mathieu-Daudé wrote:
>> On 4/5/25 22:57, Richard Henderson wrote:
>>> Check 32 vs 64-bit and pointer masking state.
>>>
>>> Cc: qemu-riscv@nongnu.org
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index 55e00972b7..267186e5e3 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -237,6 +237,31 @@ static void riscv_restore_state_to_opc(CPUState 
>>> *cs,
>>>       env->excp_uw2 = data[2];
>>>   }
>>> +#ifndef CONFIG_USER_ONLY
>>> +static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
>>> +                                vaddr result, vaddr base)
>>> +{
>>> +    CPURISCVState *env = cpu_env(cs);
>>> +    uint32_t pm_len;
>>> +    bool pm_signext;
>>> +
>>> +    if (cpu_address_xl(env) == MXL_RV32) {
>>> +        return (uint32_t)result;
>>> +    }
>>> +
>>> +    pm_len = riscv_pm_get_pmlen(riscv_pm_get_pmm(env));
>>> +    if (pm_len == 0) {
>>> +        return result;
>>> +    }
>>> +
>>> +    pm_signext = riscv_cpu_virt_mem_enabled(env);
>>> +    if (pm_signext) {
>>> +        return sextract64(result, 0, 64 - pm_len);
>>> +    }
>>> +    return extract64(result, 0, 64 - pm_len);
>>
>> Is this safe for MXL_RV128?
> 
> The RV128 implementation only uses 64-bit pointers, so, yes.

Thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


