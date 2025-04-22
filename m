Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226D5C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 08:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79GX-00077X-SQ; Tue, 22 Apr 2025 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79GW-00077N-HR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:46:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79GR-0003qB-UX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:46:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4794075f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745311558; x=1745916358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=On9jBfn9+K7zDy6uG6kSk4s19H9nOmiVgF5/4Dcte8c=;
 b=aO81+43hX+Us0GuRBxjoiCIKAys7qNH6IshrZIyz67q8DK6YlUcnUKTzfdH0N3kTX9
 eNstM5L4JZYooPQBv+U/vM4Usi6ie9T/xbfTm23+nFPfYaSZY+3tE1VPlOFYyzHGsu2F
 E/AY2EgWqIirg3/r86r/hKX2zAGa9tvMImVNxL50F0o/XMXUMoYTerQz+l+n50O4UMrV
 ImHm2mRY+WwiO5yjMr6URAVNxp++exV34eCEOgzzrQRelKzQtYiXMAll84zSGzhwoi6+
 NqlvUUXovwR+Lt6JHc5G5SQBOpWpRUMBFDMaIpiKRaxnL3gac14i4vZtDYcYwUa3OQjG
 6L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745311558; x=1745916358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=On9jBfn9+K7zDy6uG6kSk4s19H9nOmiVgF5/4Dcte8c=;
 b=kzC4bK/QPdbkVvLZsKIbqRKNexZGbBddpTp30qAdq44XU0T1pE8X89Viz6rRgmcs3o
 sBWtYkkg5vlB68UcAfObPI9a30UBJXX0JY2+U6Qreen8ewRb1HP+6WAWQOcWFgzWy7hG
 9RS/dy1Q1J4yk1GS7wnCx3cAadzJVnekC+jVIPiTq8GXj++8wmbH5vCqsGgvMQE2PRwx
 vMItShir0+oHGHpiqYNFxweXyk2y9VZskJ5+9aSfUrkv+W1hch2cJC4ipIbeXHsuuVHY
 jZLeT3dt8Nm96LSpBc2nWwhxeGXtgNGbrwbd/sgaAEz4zoRecEY/y1hW9OhOQPHtq0IL
 Fk1w==
X-Gm-Message-State: AOJu0Yz9dOsNdZIMXQ0qbvwDTvh3QCLpg09EKhN/ZqCISlA3XKdnYyAt
 PS3G1Olc4flbwUi6DajgYzzBJwxv5AenbGxeqj0JLCH/o54J5dW3QjSQc+DHgto=
X-Gm-Gg: ASbGnctLeDV9JJyiW/ZxwTyBLXojAksZLCmjjNLLL6zA1K6H2ldLyMQpgM4DUOTDN2e
 QFXFFYANy9v00ie+awgNXW2bkKnXybQ9FhGE+HwlVghlImrWq1Sc8qjn/lhYXBstKEsVZm5/itL
 cgmd7X6Cn4CbgVVapmy6wsem5Bhy1oxjXOLP0plfC2iRpxeaB4VtgQfx8fuizHnEgYYyWNwRejJ
 7Gq6DA2f1BgMeQXqPXIs3itzilLrP+A2C1Tsls5fS0tRwjsu707R0jEN5IoMjo+TA+t1ZrDjU2a
 DIUeXOUzBSstm+SI3EoJkxJq1PN0DovHgQ1i2qB0qrmNPeiQ3wsGbqDCBEK+rPq06G2DZel5WoR
 y5fjLKNwK
X-Google-Smtp-Source: AGHT+IGTZOi9zfzGV2QhzQ0rn97GqAuhCFy4vp2N7zZW4llfJ2BGIt94eaTiyjg6/+kzL/rcmUyVog==
X-Received: by 2002:a5d:64c7:0:b0:390:fc5a:91c8 with SMTP id
 ffacd0b85a97d-39efbb020ffmr11577777f8f.53.1745311558114; 
 Tue, 22 Apr 2025 01:45:58 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931dcsm14669320f8f.63.2025.04.22.01.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 01:45:57 -0700 (PDT)
Message-ID: <33dea247-aee7-4d0c-811f-e2734361cb33@linaro.org>
Date: Tue, 22 Apr 2025 10:45:56 +0200
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
 <7cf5d9df-2b09-4ec6-88f5-abf219fa8a80@linaro.org>
 <c82abd30-72db-ba38-30eb-4a44950393ff@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c82abd30-72db-ba38-30eb-4a44950393ff@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 22/4/25 09:57, bibo mao wrote:
> 
> 
> On 2025/4/22 下午3:46, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 09:39, bibo mao wrote:
>>>
>>>
>>> On 2025/4/22 下午3:18, Philippe Mathieu-Daudé wrote:
>>>> On 22/4/25 04:57, Bibo Mao wrote:
>>>>> Define function loongarch_get_addr_from_tlb() non-static, and add its
>>>>> definition in header file tcg/tcg_loongarch.h
>>>>>
>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>> ---
>>>>>   target/loongarch/cpu_helper.c        | 10 ++--------
>>>>>   target/loongarch/tcg/tcg_loongarch.h | 16 ++++++++++++++++
>>>>>   2 files changed, 18 insertions(+), 8 deletions(-)


>>>>> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/ 
>>>>> loongarch/ tcg/tcg_loongarch.h
>>>>> index da2539e995..69a93bfc3e 100644
>>>>> --- a/target/loongarch/tcg/tcg_loongarch.h
>>>>> +++ b/target/loongarch/tcg/tcg_loongarch.h
>>>>> @@ -6,7 +6,23 @@
>>>>>    */
>>>>>   #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
>>>>>   #define TARGET_LOONGARCH_TCG_LOONGARCH_H
>>>>> +#include "cpu.h"
>>>>>   void loongarch_csr_translate_init(void);
>>>>> +#ifdef CONFIG_TCG
>>>>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>>>>> *physical,
>>>>> +                                int *prot, target_ulong address,
>>>>> +                                MMUAccessType access_type, int 
>>>>> mmu_idx);
>>>>> +#else
>>>>> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
>>>>> +                                              hwaddr *physical,
>>>>> +                                              int *prot, 
>>>>> target_ulong address,
>>>>> +                                              MMUAccessType 
>>>>> access_type,
>>>>> +                                              int mmu_idx)
>>>>> +{
>>>>> +    return TLBRET_NOMATCH;
>>>>
>>>> CONFIG_TCG should always be defined when including tcg/tcg_loongarch.h.
>>>
>>> If so, there will be no stub function declaration with 
>>> loongarch_get_addr_from_tlb(). *#ifdef CONFIG_TCG* needs be added in 
>>> c files such as:
>>>
>>> static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>>> *physical,
>>>                                   int *prot, target_ulong address,
>>>                                   MMUAccessType access_type, int 
>>> mmu_idx,
>>>                                   int is_debug)
>>> {
>>>      int ret;
>>>
>>> *#ifdef CONFIG_TCG*
>>>      if (!kvm_enabled()) {
>>
>> Maybe what we want here is:
>>
>>        if (tcg_enabled()) {
> yeap, it works with --enable-debug --disable-tcg option.
> 
> I had thought that loongarch_get_addr_from_tlb should be defined if this 
> file is compiled with -O0 option. It is skipped even with -O0 option.
>      if  (0) {

'if (0)' skips at *compile* time, while 'if (tcg_enabled())' would
skip at *link* time, so we still need to prototype declaration to
compile the source file, but not the stub.

>          ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
>                                            access_type, mmu_idx);
>      }
> 
> And thanks for your guidance.

You are welcome! The cleanups you are doing are not super interesting
(lot of code churn) but make the code easier to follow and maintain IMO.

> 
> Regards
> Bibo Mao


