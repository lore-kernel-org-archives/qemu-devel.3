Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzfqn-0006p8-PF; Tue, 01 Apr 2025 13:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfql-0006ng-8W
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:56:35 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzfqi-0002Ya-Kp
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 13:56:34 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c7336ed99so741944a34.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743530191; x=1744134991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q5+pSJ2I8gzg/67q+Dz+K47cz4hCqoWoArZnbWgiRpE=;
 b=FhQmE+nRsakSe8JfirAzpbVxAE9xHj97a/HQsN8cmgCfOI5lKlJDWmJwPk/TUG0H0L
 VJnmeAdhHTiZAh4MefqaRCXDQqkfbXaAWmmtZXwNFAAec11ohH/7SmJ0jwGbLoX0BCkF
 +Vhg5duB+xLMhPbRc6bmkO90W0dEfMg5SxEC6WOPLIRkHL74fSuIb/c+6kNz3A02H9+w
 yAEVuFMwWrojH6rlf8WjbzBBr3XiLcI216nj9v7jOovWAyb6/RAHaQjM2TZ8Tf1Qz1MN
 XVphabgjgKPILK7F6Mh6B8mms8L28+DI6tBIiTpqJ9ysD24wCVxBpdXvMjtQKjtV/Ifr
 8r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743530191; x=1744134991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5+pSJ2I8gzg/67q+Dz+K47cz4hCqoWoArZnbWgiRpE=;
 b=YWQdsQVKSSDsXM1JurkT0fmbuRn7PX83P2gQWdUx/aS3eOHiatyH2eMYrPh1Ohl5j1
 XNFdtl/Lbcbkd3DkZrMtX3/vdIU6sk7vxPLxFGlvswu+VDwulJPevPHvt/T+fBSLcVKG
 n4R+F9QOP9fuj08Dk5Uf0X+sOJmcldT/BnX2C35VNBibmPoKh9zn/fvEkfqdY/FikDz6
 4DqK32+MYt6cyzjDyPyUfbWuU6hN0QHsRGzP8dvGJmlcQdktwXLQEagg0N1YFYJ9H8OH
 tgSNnWIxKGA/woE6gNI6i1t81z62CH0yH7iO/pjTfujry1vsL179rsU//zhO/BZP8zpw
 JlDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtPTcok09B4cWxY+e2wI2MofAOCi3kswmBLbyOIybUryPDckOyCWxWBr7MIhz+9u9Mmh96gZdNo7HG@nongnu.org
X-Gm-Message-State: AOJu0YxgWqrSE7RNFwPupFCFJ/8vxfIAw34dornOi26wVl+Cw20UacLE
 l3KPFy4XYwVzUB8f94y220pZSlp9htggg+IJa3U2gS1lWOpkM4Y3JXZo7wsLNNqcIo7RCYmuH6t
 c
X-Gm-Gg: ASbGnctL8BMjn802NNUxWvmrhnGBPA0uX9mWLHIi7OleVPeagTsSd2hyp14wFfo9Ll9
 L5DdPpvgMSZIP1EwrnJxrmQmpD3rVVjde/6K0ErBZuISOr/jQDRUvLBg3zOTX3WX7uYE9qv0A72
 S2j4ACbIKTuXv8Wp7oUGjqnPpLf2yk6c65sPQkf95tF8VXc2gNf4sdCbmGjwdGlDvs91M/3GH5z
 099AonOnZRU4Y+QZEmNY2SmttjZz3sLozwTejAN1nSXSHvWECqGqvS4P9Z8L4quaQ+XWbY1DLS4
 8VIZawlCyRsfNquVJR2ay5bwjq71br31vUekAx5npJQk0nvplh+NdmcfiZ3fLfqyYCKSAXXCb7J
 mZIoDXs92eSnQFMth5CZ2rVrhU8oc/UlF
X-Google-Smtp-Source: AGHT+IFYCG3RiZsnM369ahTH1FzGZJ7mZxhUAsNgNwbnG7Waw5PRuxGjB9om7U0y5lvovWhrdQvwWA==
X-Received: by 2002:a05:6830:6584:b0:727:3a2e:2132 with SMTP id
 46e09a7af769-72c6382f0f1mr11616924a34.21.1743530190904; 
 Tue, 01 Apr 2025 10:56:30 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580fa72fsm1947169a34.41.2025.04.01.10.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 10:56:30 -0700 (PDT)
Message-ID: <1205914e-b344-4f64-826e-416b5e491cc4@linaro.org>
Date: Tue, 1 Apr 2025 12:56:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/42] include/exec: Inline *_data memory operations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-10-richard.henderson@linaro.org>
 <7b57e8c0-076b-44dc-859a-2829a68cf669@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7b57e8c0-076b-44dc-859a-2829a68cf669@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 4/1/25 01:24, Philippe Mathieu-Daudé wrote:
> On 18/3/25 22:31, Richard Henderson wrote:
>> These need to be per-target for 'abi_ptr'.  Expand inline to
>> the *_data_ra api with ra == 0.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
>>   accel/tcg/ldst_common.c.inc |  89 --------------------------
>>   2 files changed, 104 insertions(+), 108 deletions(-)
>>
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index a2a90c7554..d084da0b5f 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -74,25 +74,6 @@
>>   #include "user/guest-host.h"
>>   #endif /* CONFIG_USER_ONLY */
>> -uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
>> -int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
>> -uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
>> -int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
>> -uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
>> -uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
>> -uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
>> -int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
>> -uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
>> -uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
>> -
>> -void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>> -void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>> -void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>> -void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
>> -void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>> -void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>> -void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
>> -
>>   static inline uint32_t
>>   cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
>>   {
>> @@ -342,6 +323,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, 
>> uintptr_t ra)
>>       cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
>>   }
>> +/*--------------------------*/
>> +
>> +static inline uint32_t
> 
> Pre-existing, but why don't we use 'unsigned int' like for the signed
> variants, or the plain int8_t type?

It's the original type used by the api.

You'd never change this.  If you want to audit all of the uses vs the api change, you'd 
update to one of the newer function groups.


r~

