Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB778C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslzx-0003Si-Qm; Thu, 13 Mar 2025 13:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslzs-0003N0-Sg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:05:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslzq-0004bk-Oe
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:05:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22438c356c8so24708435ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741885524; x=1742490324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PCq3WypWonKUkMAI3+Ic3/z4fmykFtceadbIlnAYePE=;
 b=kIhxcwk7cnmkZA2z0QL2Qyjx4VFE0a0qqwRFZ2mg8FvR/k1LghFnYIYrZHexvxSnhR
 pk+ZzFmWNsWV8j7OVQ1Qu+5BMYx6vjPd0NrHsGXPGAqqtxPS2tHpFzU++PDotZgxTaO4
 HScs8S83hIoqULQJkqw6gCvauE2WxOvgGam5c6eyaPV7WmISNVXNI678IHoxPAAJILZK
 fZi0HtcrCG4ixQEUZkWIjcNvFew2G7EiJdBedw/z0x6Eqbd4/NdL6mPFY1sUGUQbYwxn
 nc1WM2zokWYp1tI0PqmER5KqIYzmEGwIqOBjrI2V/hfmncxG+mxO7D9Offlxa45abyIp
 ZJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885524; x=1742490324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PCq3WypWonKUkMAI3+Ic3/z4fmykFtceadbIlnAYePE=;
 b=SkBnqRjGi/CRGke1cVjIWEV/9TNZ/o2TtZsUjCNl8PYrDRv6qS4qGXcc2NKzKgTD5A
 oxfnCgdAV96FA+PDcpGaTF7jiW8bP5SjUHaGQa7CnXNKYp2WBpw03TCZcXHs1o1ZJIRJ
 dKxw1Nl1gBwp2fxDhtme8ju2MHFpHRb6cg4WE/UI6gHnB3UofbgDiL7alBTdfLXUETFY
 ps8mNi4vYXwwIAdk8k/CF9jHTaeK4j3kLGcNqf/QxypeoPYPG1iwM1u2gB32lcd4P5r/
 2Om54wc0HOBPfS5d8G9YLxshBV3HITcGqm54wAgPGB4tvcFjwEjVd/BgGD+QHQpdaj1A
 jwPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1yleDj+EHRMlM+m0cnVbbk9Skggm7GvDWgUstaUi9vJz10ds1jEC5GodWtn8MQY/iusYsmzqNCLFk@nongnu.org
X-Gm-Message-State: AOJu0Yzlq90gbSgVDFXQ7dzuF9iQMcfmxf+loULwQlcWGIQCkNoOFo27
 RizdGS9PNs4PC5Wxr5E/LJUEZTqC3eskGY/AbXjVeiLU2EQ1XN4qQPiiEfJhPLI=
X-Gm-Gg: ASbGnct7cCPxABMyTS46qnOV4qE+UZ2HfeYUbrqbgj9MiOnVv0lH670qfiAH2LtHf7E
 vnHddVFxgfiXqzY+HHOC4m3hifQM9NNw7ZOp72wpGAT/g4PPhAaRdJgzmnfSRS+jfSvOpI9gNpF
 4JPu6TtrJNRevdyXFq5NngQfB2BhT0pWpF0/g9go+LvmHRKvnUQPE74tednVXWClfSwKVQ4cOt3
 tCkkU1xZxY/t285rgNij+2ijGVyEh5Ow2lDFemLQY44dmC38BGAqHCdD8921Hdnq6fr+zxRGIBs
 mwssiGTK2GwytVFWb4ExYOcOwxZuj0LxsOKkPlN8HOzGY7CBZ32Fp0g/Rw==
X-Google-Smtp-Source: AGHT+IHpn63TWlA8vzc6UXMem0jaKcRG54j+nygnJFmuL3sy0VQzNj/wXZZ7QwMMRn7yyYxV5ph1FQ==
X-Received: by 2002:a05:6a00:13a4:b0:736:9f20:a176 with SMTP id
 d2e1a72fcca58-7371f0d4f81mr428264b3a.8.1741885523731; 
 Thu, 13 Mar 2025 10:05:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167da42sm1617683b3a.105.2025.03.13.10.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:05:23 -0700 (PDT)
Message-ID: <125e592d-61a9-401c-a007-267eef2dea24@linaro.org>
Date: Thu, 13 Mar 2025 10:05:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/37] include/exec: Inline *_data memory operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> These expand inline to the *_data_ra api with ra == 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 123 ++++++++++++++++++++++++++++++------
>   accel/tcg/ldst_common.c.inc |  89 --------------------------
>   2 files changed, 104 insertions(+), 108 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 963c538176..70e98ebc52 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -73,25 +73,6 @@
>   #include "user/guest-host.h"
>   #endif /* CONFIG_USER_ONLY */
>   
> -uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsw_be_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr ptr);
> -uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr ptr);
> -int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
> -uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
> -uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
> -
> -void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stq_be_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
> -void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> -void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
> -
>   static inline uint32_t
>   cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
>   {
> @@ -341,6 +322,110 @@ cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
>       cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
>   }
>   
> +/*--------------------------*/
> +
> +static inline uint32_t
> +cpu_ldub_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldub_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int8_t)cpu_ldub_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_lduw_be_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int16_t)cpu_lduw_be_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldl_be_data_ra(env, addr, 0);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldq_be_data_ra(env, addr, 0);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_lduw_le_data_ra(env, addr, 0);
> +}
> +
> +static inline int
> +cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int16_t)cpu_lduw_le_data(env, addr);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldl_le_data_ra(env, addr, 0);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
> +{
> +    return cpu_ldq_le_data_ra(env, addr, 0);
> +}
> +
> +static inline void
> +cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stb_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stw_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stl_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> +{
> +    cpu_stq_be_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stw_le_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> +{
> +    cpu_stl_le_data_ra(env, addr, val, 0);
> +}
> +
> +static inline void
> +cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> +{
> +    cpu_stq_le_data_ra(env, addr, val, 0);
> +}
> +
>   #if TARGET_BIG_ENDIAN
>   # define cpu_lduw_data        cpu_lduw_be_data
>   # define cpu_ldsw_data        cpu_ldsw_be_data
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index 2f203290db..9791a4e9ef 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -243,92 +243,3 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
>       do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
>       plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
>   }
> -
> -/*
> - * Wrappers of the above
> - */
> -
> -uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_ldub_data_ra(env, addr, 0);
> -}
> -
> -int cpu_ldsb_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return (int8_t)cpu_ldub_data(env, addr);
> -}
> -
> -uint32_t cpu_lduw_be_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_lduw_be_data_ra(env, addr, 0);
> -}
> -
> -int cpu_ldsw_be_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return (int16_t)cpu_lduw_be_data(env, addr);
> -}
> -
> -uint32_t cpu_ldl_be_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_ldl_be_data_ra(env, addr, 0);
> -}
> -
> -uint64_t cpu_ldq_be_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_ldq_be_data_ra(env, addr, 0);
> -}
> -
> -uint32_t cpu_lduw_le_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_lduw_le_data_ra(env, addr, 0);
> -}
> -
> -int cpu_ldsw_le_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return (int16_t)cpu_lduw_le_data(env, addr);
> -}
> -
> -uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_ldl_le_data_ra(env, addr, 0);
> -}
> -
> -uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr addr)
> -{
> -    return cpu_ldq_le_data_ra(env, addr, 0);
> -}
> -
> -void cpu_stb_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> -{
> -    cpu_stb_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stw_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> -{
> -    cpu_stw_be_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stl_be_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> -{
> -    cpu_stl_be_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stq_be_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> -{
> -    cpu_stq_be_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stw_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> -{
> -    cpu_stw_le_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stl_le_data(CPUArchState *env, abi_ptr addr, uint32_t val)
> -{
> -    cpu_stl_le_data_ra(env, addr, val, 0);
> -}
> -
> -void cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
> -{
> -    cpu_stq_le_data_ra(env, addr, val, 0);
> -}

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


