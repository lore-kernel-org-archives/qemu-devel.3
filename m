Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6908C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsm2m-0005Qb-GG; Thu, 13 Mar 2025 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm2a-0005Ps-Ls
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:08:18 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsm2Y-0005Cr-NS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:08:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so2022043a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741885693; x=1742490493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWcAVJlFhkB0zvyizGO05fJrNEwB5CFpUFSiw9gJDt4=;
 b=X4C/JJm3IEiz+92DKLScKTH8uaMjjjdYyceeCday16m9Ztqctkb034kFdb26mY+fMO
 UrU0PD9eEwyvT0r8WPglymLH2gCztTLiTgJEUEfh1k66IGkYennFzorcaLEnnnk3448X
 P8EmNEsYdwFNQafBoReyDooxVSJeMt4dFR/Ck23pIONvupHz+rUYMSK+fHkgEY3KXr0o
 ylLmGsHWM2f2yFfTqJGhaNKU3f8c46wOitCK1OuuFmSmmj4Z3rLf2fwSO8ZREXptTIzL
 5RwTBfhm1+iKwrQnqWuR5bunFPz1Ztxzh4Aokqf7UrOAg/o3UsMtLvLLoemfROIJZpiN
 tJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885693; x=1742490493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWcAVJlFhkB0zvyizGO05fJrNEwB5CFpUFSiw9gJDt4=;
 b=NuwlnJpAkm7eu1aWNwgPqbhHa9ZJERb4wOGfaERyFmE3R+62FG5MlmPiG/0F6PKwEl
 h3VqMGCioc7/uISfEQ0mEyCMOXeCVQS5WgpbXlZqYve9oAXTTZIceDaHhWSiK4s68Q8H
 uCob91ECddgyHQ8iQoL+XGvygaiyErC6+amo6PRVPQpIYTAl32ygNliurCQEfWOS9XlN
 a+4oHbbKzyfKhTsuxlvbq2vMBuq3aNGTRloZGFUo6kJKWEMoeYTius5OsQyrmUU5rp7M
 TY6/I+KDmoAyyEbLaum0NOC5lU0geYP6t+1AhCOpK+q4fHm4YhrN9cIZc8lbBurpTb7g
 aGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDerAptHqCjMpw296LYFcfTIHE3h2igEx44pecPGTjguJ+plQBw069OIi7WMwegS2cBNsdxaWtTloK@nongnu.org
X-Gm-Message-State: AOJu0Yyp/u/reMq8LlBpRviwVEHg03VZ68VAIyiX6YxfLShvZPEu2lJv
 HUDtQGCLXnfdeikAeJxhsqFQEOW8poviEcO5yFX301+KkmnYIursZksE8bhvvBg=
X-Gm-Gg: ASbGnctk6yWx7ACGUxvJ85z/ho7y+MnPXQ5M9LSdwD02eiwDm8xkCIWNjE1SrO6dLku
 /2of/8YXdTaqz+fU9yqgDAaBCPBkLKYZs37DnclCWXRVhW6J8ejRbkY9+EqgPjjrsgYhUfFd44W
 brT4KTJQWtPoeaB/1436ZH3EmY9L3gEW+uSlCdfHcyzyKrSUO57FmNKSTtrsckHCWBKhobsz4sk
 HfeUy/ypHM5QwwxH2l+ZiBsk2isPL1GTRmgTe2WZhgtP/JVJ6t/qWvI1PfhwvR7ylz+jJ/vM4Gi
 btI54Nq+0eCjkVaPZIl5LUN2z3RQKVt9AyALcTscG7IJWa7xHyj0kRTJCw==
X-Google-Smtp-Source: AGHT+IG8tiyeuM90w1Nl0wAd5KswdVI4/Hy0T9+KAdoD9SGyg7bTAAp0gm4d8ECukCJh9AQwAT64oA==
X-Received: by 2002:a17:90b:2e44:b0:2ff:7031:e380 with SMTP id
 98e67ed59e1d1-3014e84366dmr394242a91.10.1741885693042; 
 Thu, 13 Mar 2025 10:08:13 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b3b4d1sm1624165a91.3.2025.03.13.10.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:08:12 -0700 (PDT)
Message-ID: <98bcdbdb-129d-4810-a969-e743b9c5e1ac@linaro.org>
Date: Thu, 13 Mar 2025 10:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/37] include/exec: Inline *_code memory operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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
> These expand inline to the *_mmu api with a lookup of
> the target's cpu_mmu_index() and ra == 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst.h | 31 +++++++++++++++++++++++++++----
>   accel/tcg/cputlb.c      | 28 ----------------------------
>   accel/tcg/user-exec.c   | 40 ----------------------------------------
>   3 files changed, 27 insertions(+), 72 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 70e98ebc52..92b4cf20fd 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -472,10 +472,33 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
>   # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
>   #endif
>   
> -uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
> -uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
> -uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
> -uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
> +static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
> +{
> +    CPUState *cs = env_cpu(env);
> +    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
> +    return cpu_ldb_code_mmu(env, addr, oi, 0);
> +}
> +
> +static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
> +{
> +    CPUState *cs = env_cpu(env);
> +    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
> +    return cpu_ldw_code_mmu(env, addr, oi, 0);
> +}
> +
> +static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
> +{
> +    CPUState *cs = env_cpu(env);
> +    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
> +    return cpu_ldl_code_mmu(env, addr, oi, 0);
> +}
> +
> +static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
> +{
> +    CPUState *cs = env_cpu(env);
> +    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
> +    return cpu_ldq_code_mmu(env, addr, oi, 0);
> +}
>   
>   /**
>    * tlb_vaddr_to_host:
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b03998f926..2817c9dbdd 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2897,34 +2897,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
>   
>   /* Code access functions.  */
>   
> -uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
> -{
> -    CPUState *cs = env_cpu(env);
> -    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
> -    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> -}
> -
> -uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
> -{
> -    CPUState *cs = env_cpu(env);
> -    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
> -    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> -}
> -
> -uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
> -{
> -    CPUState *cs = env_cpu(env);
> -    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
> -    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> -}
> -
> -uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
> -{
> -    CPUState *cs = env_cpu(env);
> -    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
> -    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> -}
> -
>   uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
>                            MemOpIdx oi, uintptr_t retaddr)
>   {
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 3f63b194bb..5bdbb6f968 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -1214,46 +1214,6 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
>       clear_helper_retaddr();
>   }
>   
> -uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)
> -{
> -    uint32_t ret;
> -
> -    set_helper_retaddr(1);
> -    ret = ldub_p(g2h_untagged(ptr));
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -
> -uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr ptr)
> -{
> -    uint32_t ret;
> -
> -    set_helper_retaddr(1);
> -    ret = lduw_p(g2h_untagged(ptr));
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -
> -uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr ptr)
> -{
> -    uint32_t ret;
> -
> -    set_helper_retaddr(1);
> -    ret = ldl_p(g2h_untagged(ptr));
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -
> -uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
> -{
> -    uint64_t ret;
> -
> -    set_helper_retaddr(1);
> -    ret = ldq_p(g2h_untagged(ptr));
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -
>   uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
>                            MemOpIdx oi, uintptr_t ra)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


