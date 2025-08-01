Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3882C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhton-0006Ch-2X; Fri, 01 Aug 2025 13:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsKp-0001xW-8Y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:10:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhsKl-0004fg-P1
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:10:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-24099fade34so19640385ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754064613; x=1754669413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tEHG5XwF+mj3EjDyUhWj9etU2r1+imJLJhpVjhEPCCE=;
 b=n9tol9fsdFat+8pmA1FWaPhuQzqm9UCeqDU5o0icxdByrcl0qNjZgDNF/phMqzQOQ9
 nhYvBUCU3+XTjAFdt/ua8zIqiPqTgk3vecUSC64NFBzDdSFLLCE1VrkQbOsCjLVc1Y3t
 JDgf1wKYTrSsJCiNmltyC3TjHy6k8PjJv9hMeKIagsGzraoUeWii072X9liKVF2HzSRK
 BQnZl4xTpZNH/gJaT3QlbadfjC4h9+7EehwWG8y+GNh6u3FVV3+Zed8h4HES6ABqpV7i
 nWvVzO286XaGgtl0BRGGH9odBnnoXZjno3qIX4GUsl7Ca7APYmnW2OUIZ9tfYN+P1FF7
 h4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754064613; x=1754669413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEHG5XwF+mj3EjDyUhWj9etU2r1+imJLJhpVjhEPCCE=;
 b=Z29AzkRsoQIT4+YQw3qLvWjS4LzLkGJdft6U1S/03NeErECnye5o8BeU/2rtCTixIS
 FKhCSfzu+XDfU8MCg6pK60gcsbVKoSTxD8Ayt9FEcW/9m8FeXUJRgcVOap/xtTaE10dL
 Jufg5zHwSizd1oBtMTALWPp3c9/+1TnGC5gxKoYKw9AebXlfC5es5PUl90oBDmfeU3hy
 j6wvP5bVB0KR283JsQzx1AVkzR5IozrL5vPbxvWcaJBF9h/GheqOimK+5WaMka+0xp3Z
 02dZr3TtUCvXu7kCC7xQoxNtBxNvIS39BynJS2QDwEOPc5nnR5jHWSkjTmvrZWMl0F17
 8bCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUACa5jF2YOEnRZyzZQPyWvRG2SeYFa3xBISTACz3Z2Ha0lbpBIwcjfz57LTfaac34w/yq25KifpYrE@nongnu.org
X-Gm-Message-State: AOJu0Yw/AWonVcG6D9+r9PRnZWkRGSXK312Herk9SRFLWOunFvZ84jS7
 D1u1oxdH5uB4f2j4ryf7rrOwbBHiEPwVsJuTV25DNhSh/pe0AgSgxr2dLLyfcX2LLYc=
X-Gm-Gg: ASbGncvXV61+CmOVmjnkwGgXiq/BLI7tsX2NS2FEbSk7dM4oj97PnNgRXija7OYoriK
 ErCI0EBFfXYWy1PCzVWpH3JaGfO3+KQBGI+/Tz2T3RfZBA/o9xt2bVYqAleLKlXxQ4lbUiu3HVH
 ZlWRygimk1ISgC2KBigZbcbzieyY48cylwoeC8RZ4/Sf1al6+8da1MFUMF6KLzDVjGZZOgFYMTa
 0emfhUBDh5l63KaoQ0mPBdoZSIIQTnj5EZ6ZWdySERCfE2VZTLP7Ga1x80Ui2Nh1r/Fja4ijAw+
 bodBnD7ZIIgYJCFAdJz7Gs1V4y6xAktZNs//+VpEWj9xPU5Wlqs/NqXHEb2up7snTS+qWX6CdoT
 0Wkci+++uU39d5R2biLK0G1BoXqgJXe4G3jc=
X-Google-Smtp-Source: AGHT+IEmTUYf8UVCsynrBIvTa9moHqBFMfn2fvjatHEtPZX8U2mkwECK5wX84WSYpi/Z4+n0CANLHQ==
X-Received: by 2002:a17:903:187:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-24246f3e974mr1513225ad.4.1754064613178; 
 Fri, 01 Aug 2025 09:10:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8977114sm46559455ad.102.2025.08.01.09.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:10:12 -0700 (PDT)
Message-ID: <8d940286-3eb9-4b4a-a084-dffc096062c9@linaro.org>
Date: Fri, 1 Aug 2025 09:10:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/82] target/arm: Convert regime_is_user from switch to
 table
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-38-richard.henderson@linaro.org>
 <0128c452-8bde-4bdd-b73c-330a7bd619a1@linaro.org>
 <e275dc71-2d48-4b48-9b7f-dae2c8934d64@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e275dc71-2d48-4b48-9b7f-dae2c8934d64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/31/25 8:53 PM, Richard Henderson wrote:
> On 7/31/25 07:21, Pierrick Bouvier wrote:
>>>    #include "mmuidx-internal.h"
>>> -#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
>>> +#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK | \
>>> +                ((X == 0) << R_MMUIDXINFO_USER_SHIFT))
>>>    #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
>>>    #define R2     R_MMUIDXINFO_2RANGES_MASK
>>>    #define PAN    R_MMUIDXINFO_PAN_MASK
>>> +#define USER   R_MMUIDXINFO_USER_MASK
>>>    const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
>>>        /*
>>> @@ -33,7 +35,7 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
>>>        [ARMMMUIdx_Stage2_S]        = REL(2),
>>>        [ARMMMUIdx_Stage2]          = REL(2),
>>> -    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
>>> +    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
>>>        [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
>>>        [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
>>
>> Maybe I missed something, but what about other entries that were initially treated in the
>> switch?
>> - ARMMMUIdx_E.0_0
>> - ARMMMUIdx_M*User
> 
> See the change to EL().
> 

Ok.

> I'm not sure why ARMMMUIdx_Stage1_* is excluded from arm_mmu_idx_to_el(), but I don't
> change that in this patch series.
> 

Maybe it could be more explicit to either tag all concerned entries with 
USER, than rely on EL(0) adding the magic, since this fails to apply for 
ARMMMUIdx_Stage1_E0. It's just a suggestion for readability though.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

> 
> r~


