Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598D8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78Ki-0007x1-0L; Tue, 22 Apr 2025 03:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78Kc-0007vH-I2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:46:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u78Ka-0006Df-3l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:46:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso41289025e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745307969; x=1745912769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iq02Lvr9T3R5D3gA2725wPYKVxSDTzaRxrhAZjOKMAc=;
 b=t/qsMRaNw7fi7iNVGHjcoi/3mxyLUicQJb7TWj82o/+t67aO8fH78i2eRxLL6TC0Wm
 bU/r6xTbryba1YMYZEuO7fKa3wpOUPTmvUY8p8eCZ2yMzC4+1QEMsNtfCJOJb3sG/aDG
 strfSxSxytADViR2CgwXbY6dYHBTEc6QuHA6KPxIFgsda/tGanZKpj9f6D1H8qY1V/zK
 4kMP2zNwFrqjk7G3TLuEaBAznKmFEqXxHQgI5MjVIsMzE57bmcES0wELenm7L7o++pl3
 qCFQMZ2Yu1wWcJBVfuVnKxvvk8UWLwyQNBAnBCc7J9EK1q8sVjrJiX9UOw/zgHuwdXiZ
 DOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745307969; x=1745912769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iq02Lvr9T3R5D3gA2725wPYKVxSDTzaRxrhAZjOKMAc=;
 b=kDvL/rn2fLDWBgm7QDTuCDPWK1MWQCRj1qO78qip7ZzI2Nm4T42EXKSSNi0V52wbPe
 etxZA/rabMOBByCMKD/CodMjgAoMVZ+AGyouyL76WNUXxYJFS05GCZbZldLjUxvLMIWJ
 cQhvi5145fSS9u5yrapX15VoK96rwsraZWDDjI4hS/ibryhsm2yYDI7jixem3Dh+bwdV
 vlW4sUIUS1Y6A17H2twN6t5uO51bvRSrVOktAHLhUH5NRpDytHY8+SUENhUAoLvLJqZW
 3uYxOgd6Wfib2bViGJ8fXyziR/d2rTeesG0L3oHAZ0wsk0wNUPKCgUkwQ4FDuRX8Q468
 ZPtg==
X-Gm-Message-State: AOJu0YzBDd0RVcp1SXMv6t4xsOK80A0LK7tf6a/rsw5+DtLH1pLK4rkF
 8ablnX76zy+6jcxgwIUrrJaUY3bGqLdq1U0tn+ZyvNHccKDQLDlpFoM7XFebGVM=
X-Gm-Gg: ASbGncudEPrqdVADy/M/T3rXX+HS2xiiN2ATyU2QczDHaN9hFuaYad+6W5RJGegh5SS
 15qKOMxWG/yos2iV5CbOcyTdDIQY+ZJhOjRFpMCZDSvXDAFI2WRMTKaagV+Caw8POAo4n74mDRU
 rcJ58hDivpY5E4KxsQmSZMGor+p1jw5Pbu7AxwIM4YDP5eiLhP4jIYJ4MJfqIkHsjFg+n1ZYuZJ
 InYwzZDTj+gEu1EMSsGgb1RKnfK7Wbip663ZKsP1CkmIkL2inEGXQHk5Z771uDJKY16Ra7DtfTr
 7bHEUPj8lccZ+cev4nekAr4GGAMiPbslUDHyMNJZEc99J+MOUQqBRcsvTv6OoDfPl0YuzNt/ai5
 q3QirGf8C
X-Google-Smtp-Source: AGHT+IFaHRRdkYMqZAFn7QAKncF4wEgQgB5iY9KEhsL6RcdSQyVu9u6NrKsIvXNsNocsK2V4lK7uPQ==
X-Received: by 2002:a05:600c:a143:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-44076c9c6fbmr82042105e9.10.1745307969396; 
 Tue, 22 Apr 2025 00:46:09 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c80174dsm8208865e9.0.2025.04.22.00.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 00:46:08 -0700 (PDT)
Message-ID: <7cf5d9df-2b09-4ec6-88f5-abf219fa8a80@linaro.org>
Date: Tue, 22 Apr 2025 09:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
To: bibo mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-7-maobibo@loongson.cn>
 <e86b1efe-514c-4757-9a7d-477c27803c95@linaro.org>
 <b73e6439-2435-f064-2f07-24b10b9dd2a1@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b73e6439-2435-f064-2f07-24b10b9dd2a1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 22/4/25 09:39, bibo mao wrote:
> 
> 
> On 2025/4/22 下午3:18, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 04:57, Bibo Mao wrote:
>>> Define function loongarch_get_addr_from_tlb() non-static, and add its
>>> definition in header file tcg/tcg_loongarch.h
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   target/loongarch/cpu_helper.c        | 10 ++--------
>>>   target/loongarch/tcg/tcg_loongarch.h | 16 ++++++++++++++++
>>>   2 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/ 
>>> cpu_helper.c
>>> index 5db64a45cc..7636b2c265 100644
>>> --- a/target/loongarch/cpu_helper.c
>>> +++ b/target/loongarch/cpu_helper.c
>>> @@ -11,6 +11,7 @@
>>>   #include "cpu.h"
>>>   #include "internals.h"
>>>   #include "cpu-csr.h"
>>> +#include "tcg/tcg_loongarch.h"
>>>   #ifdef CONFIG_TCG
>>>   static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr 
>>> *physical,
>>> @@ -142,7 +143,7 @@ bool loongarch_tlb_search(CPULoongArchState *env, 
>>> target_ulong vaddr,
>>>       return false;
>>>   }
>>> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, 
>>> hwaddr *physical,
>>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>>> *physical,
>>>                                          int *prot, target_ulong 
>>> address,
>>>                                          MMUAccessType access_type, 
>>> int mmu_idx)
>>>   {
>>> @@ -156,13 +157,6 @@ static int 
>>> loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>>>       return TLBRET_NOMATCH;
>>>   }
>>> -#else
>>> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, 
>>> hwaddr *physical,
>>> -                                       int *prot, target_ulong address,
>>> -                                       MMUAccessType access_type, 
>>> int mmu_idx)
>>> -{
>>> -    return TLBRET_NOMATCH;
>>> -}
>>>   #endif
>>>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/ 
>>> tcg/tcg_loongarch.h
>>> index da2539e995..69a93bfc3e 100644
>>> --- a/target/loongarch/tcg/tcg_loongarch.h
>>> +++ b/target/loongarch/tcg/tcg_loongarch.h
>>> @@ -6,7 +6,23 @@
>>>    */
>>>   #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
>>>   #define TARGET_LOONGARCH_TCG_LOONGARCH_H
>>> +#include "cpu.h"
>>>   void loongarch_csr_translate_init(void);
>>> +#ifdef CONFIG_TCG
>>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>>> *physical,
>>> +                                int *prot, target_ulong address,
>>> +                                MMUAccessType access_type, int 
>>> mmu_idx);
>>> +#else
>>> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
>>> +                                              hwaddr *physical,
>>> +                                              int *prot, 
>>> target_ulong address,
>>> +                                              MMUAccessType 
>>> access_type,
>>> +                                              int mmu_idx)
>>> +{
>>> +    return TLBRET_NOMATCH;
>>
>> CONFIG_TCG should always be defined when including tcg/tcg_loongarch.h.
> 
> If so, there will be no stub function declaration with 
> loongarch_get_addr_from_tlb(). *#ifdef CONFIG_TCG* needs be added in c 
> files such as:
> 
> static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>                                   int *prot, target_ulong address,
>                                   MMUAccessType access_type, int mmu_idx,
>                                   int is_debug)
> {
>      int ret;
> 
> *#ifdef CONFIG_TCG*
>      if (!kvm_enabled()) {

Maybe what we want here is:

       if (tcg_enabled()) {

?

>          ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
>                                            access_type, mmu_idx);
>          if (ret != TLBRET_NOMATCH) {
>              return ret;
>          }
>      }
> *#endif*
> 
> My original thought is to add stub function and remove *#ifdef 
> CONFIG_TCG* in c file.
> 
> Regards
> Bibo Mao
> 
>>
>>> +}
>>> +#endif
>>> +
>>>   #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
>>
> 


