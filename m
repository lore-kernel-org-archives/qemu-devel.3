Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3C5C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsljs-0001hc-6L; Thu, 13 Mar 2025 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsljE-0001I7-Et
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:48:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsljB-00007A-RD
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:48:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224100e9a5cso25902965ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741884492; x=1742489292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ce8xTCMM68EEoKjhtadMfLmQFPL2XPcbW3vz1EJ+ZhE=;
 b=UTPnUY/tzpMKwZtObAx8t+FPCESmO6YbRqWBjcRqVi9EZjWV50PImq8LHx6V9Mhebp
 eqeIvVF3AdM1iHPj3dCXYUBbqrMUvmKRtiQ110Z/DJJbfURKlG8GEXbke6wcuzUWEzt3
 86hdGpj8mxItN3Hk9hhAw/hY36QGo3OwAkg03fTkRj4fgmHbbhFuLxnS+lusK2WjNtVv
 aEbY84vfQo+2NSUbo7y5s3swiiHSPhuBwqj88Qkr0jkLeSf5A5CEfsC7eBgeJPQigA6t
 zgLtaBEznD7MPIa/MuynL4Bqa6KCHD0mB+qj4AbMcSUwPVxkE9HObrjojwyr5vu2fc0J
 YaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741884492; x=1742489292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ce8xTCMM68EEoKjhtadMfLmQFPL2XPcbW3vz1EJ+ZhE=;
 b=Jor/stqR9FGauRDjB61YD8JAQ5Rj8MjJwJ58m+BQN3Ic3BeDYLKWTHwJexm4x67xwF
 sv7Gc6BozRwqiqJnScYPPJ+HXWzZ8bbVoFUNAa2Rt/hF+zzyF1wfHX7oNrGZaAPm7BEX
 jLgy0fWgWIODf4EFogpvOAo7dFg6msbn/Bd82vfjpXrnjRUfyZjSdmRkqPn3T5V3aFIr
 hQWH2W6FY+CQxN7EX/lIa43X3ga5D+w2yerC2hxr2kVKTZAGWwYfYlY4VHh8JwHLa4sH
 FN9nut/YpNrQg0TzqEPCpaurg/gV3J1KN3bRgIp4lOB9ICuOYEc6/NCgHFmQ8W31heHh
 dcaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/+f+uXh2nTICFJ7rb2DyknsHuDX3wnZkwvqiuxj+j8GLZvoPWCi8aW1Kd7HM2n+Lc0Ifsqj0L/kPq@nongnu.org
X-Gm-Message-State: AOJu0YwIdrWUs7xzqntGAUl2DkMOXk8ZQbS7dzQ/g+ljmclrZWFmJPTr
 vMDnjqaRORLSY0sC5ssrDurpi/ZwG9PMDjXTSx2l7ciZuqCdftJeeGDQeE8+L+Q=
X-Gm-Gg: ASbGncu6f2vqSYkQdCdhbIcqUWMKWI0QJAWHBZKfmRqtiKZ6UnwEGKPSn+WmH7eG5S7
 HP8vYOH5MXUOwYLjGmgRpX+Hynjv7iwjqR0g517mrrZhFCkRT/EzSZhDQdrq/813ZyhwFGuOmZ/
 0QtDoNteIU1dzbnpL9wWY02+XpNjOougZmTUBiEVXcJ42mYNq4RkKPAXYQlDdHhG+iNIDiPdNK9
 /9Aw0yUnyqiDrTBpOZg1Sc3t6j88hp79NoKOOPQf33YQjMWrFxB3sC10yodp6cX+pxEATIRPgB+
 iUmkJ2lKkt1KGYNQPdI/5E4+qYIgOVaJD0COhEMbQDzS0VBGEN3OQROPfl6T0sT7ixxN
X-Google-Smtp-Source: AGHT+IFg2k0livcPK6yMH7UN6PRnEvpT/yJHTe0NZ2Hyeqn52Y+IGfNlw1uJhh1kYNpYqkugWa+DFA==
X-Received: by 2002:a05:6a00:1413:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-7371f1b4083mr315233b3a.20.1741884492002; 
 Thu, 13 Mar 2025 09:48:12 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711529526sm1553354b3a.24.2025.03.13.09.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:48:11 -0700 (PDT)
Message-ID: <69893df2-775a-40d8-8cb5-b64425de2fb3@linaro.org>
Date: Thu, 13 Mar 2025 09:48:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/37] include/exec: Use vaddr for *_mmu guest memory
 access routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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
> Use vaddr only for the newest api, because it has the least
> number of uses and therefore is the easiest to audit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/atomic_template.h | 16 ++++++-------
>   include/exec/cpu_ldst.h     | 48 ++++++++++++++++++-------------------
>   accel/tcg/cputlb.c          |  8 +++----
>   accel/tcg/user-exec.c       |  8 +++----
>   accel/tcg/ldst_common.c.inc | 20 ++++++++--------
>   5 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index 89593b2502..08a475c10c 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -77,7 +77,7 @@
>   # define END  _le
>   #endif
>   
> -ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
> +ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
>                                 ABI_TYPE cmpv, ABI_TYPE newv,
>                                 MemOpIdx oi, uintptr_t retaddr)
>   {
> @@ -101,7 +101,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
>   }
>   
>   #if DATA_SIZE < 16
> -ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
> +ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
>                              MemOpIdx oi, uintptr_t retaddr)
>   {
>       DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
> @@ -120,7 +120,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
>   }
>   
>   #define GEN_ATOMIC_HELPER(X)                                        \
> -ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
>                           ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
>   {                                                                   \
>       DATA_TYPE *haddr, ret;                                          \
> @@ -156,7 +156,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
>    * of CF_PARALLEL's value, we'll trace just a read and a write.
>    */
>   #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
> -ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
>                           ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
>   {                                                                   \
>       XDATA_TYPE *haddr, cmp, old, new, val = xval;                   \
> @@ -202,7 +202,7 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
>   # define END  _be
>   #endif
>   
> -ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
> +ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
>                                 ABI_TYPE cmpv, ABI_TYPE newv,
>                                 MemOpIdx oi, uintptr_t retaddr)
>   {
> @@ -226,7 +226,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
>   }
>   
>   #if DATA_SIZE < 16
> -ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
> +ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, vaddr addr, ABI_TYPE val,
>                              MemOpIdx oi, uintptr_t retaddr)
>   {
>       DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
> @@ -245,7 +245,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
>   }
>   
>   #define GEN_ATOMIC_HELPER(X)                                        \
> -ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
>                           ABI_TYPE val, MemOpIdx oi, uintptr_t retaddr) \
>   {                                                                   \
>       DATA_TYPE *haddr, ret;                                          \
> @@ -278,7 +278,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
>    * of CF_PARALLEL's value, we'll trace just a read and a write.
>    */
>   #define GEN_ATOMIC_HELPER_FN(X, FN, XDATA_TYPE, RET)                \
> -ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
> +ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, vaddr addr,              \
>                           ABI_TYPE xval, MemOpIdx oi, uintptr_t retaddr) \
>   {                                                                   \
>       XDATA_TYPE *haddr, ldo, ldn, old, new, val = xval;              \
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 769e9fc440..ddd8e0cf48 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -157,48 +157,48 @@ void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
>   void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
>                             int mmu_idx, uintptr_t ra);
>   
> -uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
> -uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
> -uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
> -uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr ptr, MemOpIdx oi, uintptr_t ra);
> -Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra);
> +uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
>   
> -void cpu_stb_mmu(CPUArchState *env, abi_ptr ptr, uint8_t val,
> +void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
>                    MemOpIdx oi, uintptr_t ra);
> -void cpu_stw_mmu(CPUArchState *env, abi_ptr ptr, uint16_t val,
> +void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
>                    MemOpIdx oi, uintptr_t ra);
> -void cpu_stl_mmu(CPUArchState *env, abi_ptr ptr, uint32_t val,
> +void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
>                    MemOpIdx oi, uintptr_t ra);
> -void cpu_stq_mmu(CPUArchState *env, abi_ptr ptr, uint64_t val,
> +void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
>                    MemOpIdx oi, uintptr_t ra);
> -void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
> +void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
>                     MemOpIdx oi, uintptr_t ra);
>   
> -uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
>                                    uint32_t cmpv, uint32_t newv,
>                                    MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
>                                       uint32_t cmpv, uint32_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
>                                       uint32_t cmpv, uint32_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
> -uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
>                                       uint64_t cmpv, uint64_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
>                                       uint32_t cmpv, uint32_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
>                                       uint32_t cmpv, uint32_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
> -uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
>                                       uint64_t cmpv, uint64_t newv,
>                                       MemOpIdx oi, uintptr_t retaddr);
>   
>   #define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
>   TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
> -    (CPUArchState *env, abi_ptr addr, TYPE val, \
> +    (CPUArchState *env, vaddr addr, TYPE val, \
>        MemOpIdx oi, uintptr_t retaddr);
>   
>   #ifdef CONFIG_ATOMIC64
> @@ -244,10 +244,10 @@ GEN_ATOMIC_HELPER_ALL(xchg)
>   #undef GEN_ATOMIC_HELPER_ALL
>   #undef GEN_ATOMIC_HELPER
>   
> -Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, abi_ptr addr,
> +Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
>                                     Int128 cmpv, Int128 newv,
>                                     MemOpIdx oi, uintptr_t retaddr);
> -Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
> +Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
>                                     Int128 cmpv, Int128 newv,
>                                     MemOpIdx oi, uintptr_t retaddr);
>   
> @@ -297,13 +297,13 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
>   # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
>   #endif
>   
> -uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
>                            MemOpIdx oi, uintptr_t ra);
> -uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra);
> -uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra);
> -uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra);
>   
>   uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fb22048876..b03998f926 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2925,25 +2925,25 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
>       return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
>   }
>   
> -uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
>                            MemOpIdx oi, uintptr_t retaddr)
>   {
>       return do_ld1_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
>   }
>   
> -uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t retaddr)
>   {
>       return do_ld2_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
>   }
>   
> -uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t retaddr)
>   {
>       return do_ld4_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
>   }
>   
> -uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t retaddr)
>   {
>       return do_ld8_mmu(env_cpu(env), addr, oi, retaddr, MMU_INST_FETCH);
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 2322181b15..3f63b194bb 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -1254,7 +1254,7 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
>       return ret;
>   }
>   
> -uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
>                            MemOpIdx oi, uintptr_t ra)
>   {
>       void *haddr;
> @@ -1266,7 +1266,7 @@ uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
>       void *haddr;
> @@ -1281,7 +1281,7 @@ uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
>       void *haddr;
> @@ -1296,7 +1296,7 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
>       void *haddr;
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index ebbf380d76..0447c0bb92 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -135,7 +135,7 @@ static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
>       }
>   }
>   
> -uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
> +uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra)
>   {
>       uint8_t ret;
>   
> @@ -145,7 +145,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
>       return ret;
>   }
>   
> -uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
> +uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr addr,
>                        MemOpIdx oi, uintptr_t ra)
>   {
>       uint16_t ret;
> @@ -156,7 +156,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
> +uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr addr,
>                        MemOpIdx oi, uintptr_t ra)
>   {
>       uint32_t ret;
> @@ -167,7 +167,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
> +uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr addr,
>                        MemOpIdx oi, uintptr_t ra)
>   {
>       uint64_t ret;
> @@ -178,7 +178,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
>       return ret;
>   }
>   
> -Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
> +Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr,
>                       MemOpIdx oi, uintptr_t ra)
>   {
>       Int128 ret;
> @@ -205,14 +205,14 @@ static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
>       }
>   }
>   
> -void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
> +void cpu_stb_mmu(CPUArchState *env, vaddr addr, uint8_t val,
>                    MemOpIdx oi, uintptr_t retaddr)
>   {
>       helper_stb_mmu(env, addr, val, oi, retaddr);
>       plugin_store_cb(env, addr, val, 0, oi);
>   }
>   
> -void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
> +void cpu_stw_mmu(CPUArchState *env, vaddr addr, uint16_t val,
>                    MemOpIdx oi, uintptr_t retaddr)
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
> @@ -220,7 +220,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
>       plugin_store_cb(env, addr, val, 0, oi);
>   }
>   
> -void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
> +void cpu_stl_mmu(CPUArchState *env, vaddr addr, uint32_t val,
>                       MemOpIdx oi, uintptr_t retaddr)
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
> @@ -228,7 +228,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
>       plugin_store_cb(env, addr, val, 0, oi);
>   }
>   
> -void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
> +void cpu_stq_mmu(CPUArchState *env, vaddr addr, uint64_t val,
>                    MemOpIdx oi, uintptr_t retaddr)
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
> @@ -236,7 +236,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
>       plugin_store_cb(env, addr, val, 0, oi);
>   }
>   
> -void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
> +void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
>                     MemOpIdx oi, uintptr_t retaddr)
>   {
>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);

Restricting 64bit targets on 32bit hosts comes with nice benefits.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

