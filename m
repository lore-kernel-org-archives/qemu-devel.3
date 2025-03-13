Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0D3C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslyk-0002dQ-6Z; Thu, 13 Mar 2025 13:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslyh-0002bv-9Y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:04:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslye-000493-UO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:04:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22349bb8605so28067485ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741885451; x=1742490251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=McTv65/l7Ie1hnaWfE8H7J7ajFohObYff5gehhTj0FI=;
 b=D4o7BApkwAAiMZl6gfaxrGpN/itRWLW5SoBcTlthGTccO0LDIfUzwn+2VOUG/jMOa0
 M+PUXgRdP9OWpNM2nd7sPntyN+uZfLHsqOSrJRJXgk3ukNa49V6xQT5snj/Tq1//0A7e
 kIZ1eNrb00sG1fC9usDik7GIpNnHyXC8pvCh8W6imRHfiaPEUMsGljI3aMBvY3KaCyPW
 +RBtxEfYpxtoLH7EDLrjC+wI7Lw8S/UMw/IYz3s6GzM1WVXTr5Nvn5wnghU7MmBJY/v5
 E/pCtFTkShLBKutCUwur+mlmvg14aJZVYERTwZFiF0eInNEgDSSB1sDxJNa/bmFmfs37
 HRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885451; x=1742490251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=McTv65/l7Ie1hnaWfE8H7J7ajFohObYff5gehhTj0FI=;
 b=h1yr54MwcV9r55PPvMi3XiaBCyUrTKQoRG5nMYtdPG44agheGCcIdtt9CBT3E5v+Um
 08vbfDGAL8hNRyp6qlmPdtRcZ5E+1DXpvz0VahY+qJCfEhWkmqj49dVmHnWJmzkSuwno
 8XC4/SMwFnZ7RDKqwYN1xW5kTsJ3IHyStbMTo8GfTCDQ7r2/2YmWcFjC20v9q4fRlwN1
 iDxHMD1wNj5+XhCTw5ED5KCAGgcAiv7ZNYBxDwnBz5TBmspo43rNQOY6RChZzkfyE11m
 7ZaNtdbLorEefJmZIGxVMHJpxnx5pi8a0D7Z8CpVwShXrkY5Xr9HZmfX3Do6aSipDvnf
 s4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4B97+40ICNOy0mSdLItyHoEsBUWa6tiq3ajV/7hTlFIx8kOgGfecQYcAe2i6K39NMYYppSsuK78DJ@nongnu.org
X-Gm-Message-State: AOJu0YzprktYaJbL+lnK0CuloKnnaSV56yfn/3BGBL3ZrD66OYNPeI0x
 9xbiImA0gpNWg/C9QoaIWLad1uQnsoFNxf+tJcxwV8EnJE2P3o7E7Apniy5R442yp/E9EcAXPO7
 bIvE=
X-Gm-Gg: ASbGnctMvHbKAUaMS3tsTLTb43PX7E6+NbVGtpeCRqKKmbFi3FwHeRs45Fgv8OqjQMw
 RUzxcGfLu9opQv7Q3y/sZIxY7hXKKkxzGxsPj0sPZFrj15ANjtxv9K1sTC+rIUT1V1yXttljfBn
 hWjRo/7BeG2oggCflVZp5+r6pzz5uyICKM4lAp5wyeKgSODNllVx+P4YlEQWoPzsGlJGU3fAvlX
 vdXiGXgXy+V2bkE+bH5iQ3QiOp6ulg0tOzFLQHLGl0uEPt85BiPYp0mEutRcj82ESWOOD8m3YXq
 si+c/1wc1dTbOjF/vBfwKkJ+50Md6thbvM8jyrzJbWtOf/6K6AtkJxdZ0g==
X-Google-Smtp-Source: AGHT+IEe0SHCdURPTH27N4jKY4gLfQMOkmrmf5UOqBcbjSAro3mB/8OmYpljyRm4wRHwq1vXEsNOXQ==
X-Received: by 2002:a05:6a00:22d1:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-7371f19f8fcmr349613b3a.20.1741885450955; 
 Thu, 13 Mar 2025 10:04:10 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371155077fsm1568880b3a.37.2025.03.13.10.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:04:10 -0700 (PDT)
Message-ID: <fa84d370-3507-4ed2-9c30-b11d33122b67@linaro.org>
Date: Thu, 13 Mar 2025 10:04:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/37] include/exec: Inline *_data_ra memory operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
> These expand inline to the *_mmuidx_ra api with
> a lookup of the target's cpu_mmu_index().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h     | 144 +++++++++++++++++++++++++++++-------
>   accel/tcg/ldst_common.c.inc | 108 ---------------------------
>   2 files changed, 118 insertions(+), 134 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index b33755169e..963c538176 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -84,17 +84,6 @@ int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
>   uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
>   uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
>   
> -uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -
>   void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>   void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>   void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> @@ -103,21 +92,6 @@ void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>   void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>   void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
>   
> -void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
> -                     uint32_t val, uintptr_t ra);
> -void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint64_t val, uintptr_t ra);
> -void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint64_t val, uintptr_t ra);
> -
>   static inline uint32_t
>   cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
>   {
> @@ -249,6 +223,124 @@ cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
>       cpu_stq_mmu(env, addr, val, oi, ra);
>   }
>   
> +/*--------------------------*/
> +
> +static inline uint32_t
> +cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stb_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintptr_t ra)
> +{
> +    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> +    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
>   #if TARGET_BIG_ENDIAN
>   # define cpu_lduw_data        cpu_lduw_be_data
>   # define cpu_ldsw_data        cpu_ldsw_be_data
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index 99a56df3fb..2f203290db 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -248,114 +248,6 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
>    * Wrappers of the above
>    */
>   
> -uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -void cpu_stb_data_ra(CPUArchState *env, abi_ptr addr,
> -                     uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint64_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint64_t val, uintptr_t ra)
> -{
> -    int mmu_index = cpu_mmu_index(env_cpu(env), false);
> -    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -/*--------------------------*/
> -
>   uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
>   {
>       return cpu_ldub_data_ra(env, addr, 0);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


