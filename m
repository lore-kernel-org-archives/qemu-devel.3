Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAE1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsllN-0004iy-2S; Thu, 13 Mar 2025 12:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsllD-0004eH-Ps
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:50:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsllB-0000os-BQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:50:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so25282625ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741884615; x=1742489415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJBEhRLE2xgc4sAAuLDGnbNffsawUBdxAW8GYXWkSUc=;
 b=lgsNZ4IeiYxhBV2JZ8rNR6ftqquhQc3fdTwjg4W6MitwnyQin8AXDQNo6N5tzIRPZE
 i3ow7Y7S18Bb8ugPqQQbcfk3Ej5dxVCzaJuxMK/SDnR5OFZHFLlcO2vxkmS3L7g+U46T
 zHM9OjvAUBPbGtjt49hikEveUvnlayTF4KpH1oBe05euBY+8zEwerDt3Hs4dJJN7d+Xr
 ZDBAFx0AOSB1wyT+IeG55D4GQXPv675AIhoPdZ3Eijlb0a5pFDvD87l08VvSU9CWc6M2
 QAykLlzEX7qd1WVCEeuL+7tMIHjWGMfns9eLZh5bisA1JisT3sPuZEMBDIVWdbgYnzSI
 C19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741884615; x=1742489415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJBEhRLE2xgc4sAAuLDGnbNffsawUBdxAW8GYXWkSUc=;
 b=lx4LiBvZ6IWBeNCKmrUWtg81nfKATWJoxx6JJWjERX1WX1JriHJ6G62LjQy+Pqqmg2
 CllPjE+ieL8k1oSAnWgMgfgap5mBccZOHT/vf/O/5IeyCOigTbPSL9n64ZM/kAV7QZuU
 nxmRQ5nCvE8OGBEPC0Dn/E52M2kXM+0HrvRjaJdaYJku2AVD9EFU9PaKKYnzqZdVKpyV
 hggj7Q2GMzDE90CWZLjmt+0X703FQPTmkYkT4aTbBb2ozW4I/H31PJP8AniOk/vsP6se
 FhXjUXCDyd4V/tgSvhNTSFu5h6E8oWmTfOAPCzXK4DkoQcjWejOLRygV4zs6RT8fiBKO
 88gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQFBT1vTwVTBqED80A5YRAEydM8dpMaLnbchBJtXghRi4BnTvALFTiowwB7v2w4kHJg7lxtbNRRCw+@nongnu.org
X-Gm-Message-State: AOJu0YxPMbxr/LKAkiofo3l1zuiLyxkRyWy0A95ANIfZbco6q4uWNgrb
 xpIjOgeMgls8V908cbybamrQOsAL7jDQqk1dfeyVvFCbLhA9oCH28bcf5jILR9o=
X-Gm-Gg: ASbGncuT5jNttvRCH+FfwN1Exm8RElxSs0Ie9gQIZOg+ZusXhD8PVhYmPUob3+QijrU
 PrU+/awINCe/hfVqqZd7tFkFlD2BYB51B5VBAFPylC0BkV6RgRAZXpGKlVlM+f9oBon7xuRrhjj
 UtZbuYnDCOVW7MKJWKsVA+g9+qhypi9xz+KB+XDG3Zm5JXGJ7UXx2LOhheOSuNoIdN2r4uNCOWW
 Ew4AKbdUyZU/WjVUr9ErumODVutFXXMUvWcEJxRjzyFYbUcDyX3215QUsWzvWgGUr80KWMEM2hf
 loyEMPpgKbgLts+CwVLFUBZx2eK9yXeW5UjzS4MNcluuKIQ2OuA1iMgmHw==
X-Google-Smtp-Source: AGHT+IGt7W2EXy2bsXuqtLCWJYiS6aGXvWuJbMfEwZVupgeVrl3GsotrfZReYgx9qMxMJhM31xqfNw==
X-Received: by 2002:a17:903:198e:b0:225:abd2:5e39 with SMTP id
 d9443c01a7336-225abd26003mr87186815ad.30.1741884615528; 
 Thu, 13 Mar 2025 09:50:15 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a6e09sm15633215ad.55.2025.03.13.09.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:50:15 -0700 (PDT)
Message-ID: <0d55cb62-b677-4338-a9ab-520e9bfb4f4a@linaro.org>
Date: Thu, 13 Mar 2025 09:50:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/37] include/exec: Split out cpu-ldst-common.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
> Split out the *_mmu api, which no longer uses
> target specific argument types.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-ldst-common.h | 122 +++++++++++++++++++++++++++++++++
>   include/exec/cpu_ldst.h        | 108 +----------------------------
>   2 files changed, 123 insertions(+), 107 deletions(-)
>   create mode 100644 include/exec/cpu-ldst-common.h
> 
> diff --git a/include/exec/cpu-ldst-common.h b/include/exec/cpu-ldst-common.h
> new file mode 100644
> index 0000000000..c46a6ade5d
> --- /dev/null
> +++ b/include/exec/cpu-ldst-common.h
> @@ -0,0 +1,122 @@
> +/*
> + * Software MMU support
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef CPU_LDST_COMMON_H
> +#define CPU_LDST_COMMON_H
> +
> +#ifndef CONFIG_TCG
> +#error Can only include this header with TCG
> +#endif
> +
> +#include "exec/memopidx.h"
> +#include "exec/vaddr.h"
> +#include "exec/mmu-access-type.h"
> +#include "qemu/int128.h"
> +
> +uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> +Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
> +
> +void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
> +                 MemOpIdx oi, uintptr_t ra);
> +void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
> +                 MemOpIdx oi, uintptr_t ra);
> +void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
> +                 MemOpIdx oi, uintptr_t ra);
> +void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
> +                 MemOpIdx oi, uintptr_t ra);
> +void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
> +                  MemOpIdx oi, uintptr_t ra);
> +
> +uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
> +                                 uint32_t cmpv, uint32_t newv,
> +                                 MemOpIdx oi, uintptr_t retaddr);
> +uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
> +                                    uint32_t cmpv, uint32_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
> +                                    uint32_t cmpv, uint32_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
> +                                    uint64_t cmpv, uint64_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
> +                                    uint32_t cmpv, uint32_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
> +                                    uint32_t cmpv, uint32_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
> +                                    uint64_t cmpv, uint64_t newv,
> +                                    MemOpIdx oi, uintptr_t retaddr);
> +
> +#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
> +TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
> +    (CPUArchState *env, vaddr addr, TYPE val,   \
> +     MemOpIdx oi, uintptr_t retaddr);
> +
> +#ifdef CONFIG_ATOMIC64
> +#define GEN_ATOMIC_HELPER_ALL(NAME)          \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
> +    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
> +    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
> +#else
> +#define GEN_ATOMIC_HELPER_ALL(NAME)          \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
> +    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
> +#endif
> +
> +GEN_ATOMIC_HELPER_ALL(fetch_add)
> +GEN_ATOMIC_HELPER_ALL(fetch_sub)
> +GEN_ATOMIC_HELPER_ALL(fetch_and)
> +GEN_ATOMIC_HELPER_ALL(fetch_or)
> +GEN_ATOMIC_HELPER_ALL(fetch_xor)
> +GEN_ATOMIC_HELPER_ALL(fetch_smin)
> +GEN_ATOMIC_HELPER_ALL(fetch_umin)
> +GEN_ATOMIC_HELPER_ALL(fetch_smax)
> +GEN_ATOMIC_HELPER_ALL(fetch_umax)
> +
> +GEN_ATOMIC_HELPER_ALL(add_fetch)
> +GEN_ATOMIC_HELPER_ALL(sub_fetch)
> +GEN_ATOMIC_HELPER_ALL(and_fetch)
> +GEN_ATOMIC_HELPER_ALL(or_fetch)
> +GEN_ATOMIC_HELPER_ALL(xor_fetch)
> +GEN_ATOMIC_HELPER_ALL(smin_fetch)
> +GEN_ATOMIC_HELPER_ALL(umin_fetch)
> +GEN_ATOMIC_HELPER_ALL(smax_fetch)
> +GEN_ATOMIC_HELPER_ALL(umax_fetch)
> +
> +GEN_ATOMIC_HELPER_ALL(xchg)
> +
> +#undef GEN_ATOMIC_HELPER_ALL
> +#undef GEN_ATOMIC_HELPER
> +
> +Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
> +                                  Int128 cmpv, Int128 newv,
> +                                  MemOpIdx oi, uintptr_t retaddr);
> +Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
> +                                  Int128 cmpv, Int128 newv,
> +                                  MemOpIdx oi, uintptr_t retaddr);
> +
> +uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
> +                         MemOpIdx oi, uintptr_t ra);
> +uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
> +                          MemOpIdx oi, uintptr_t ra);
> +uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
> +                          MemOpIdx oi, uintptr_t ra);
> +uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
> +                          MemOpIdx oi, uintptr_t ra);
> +
> +#endif /* CPU_LDST_COMMON_H */
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index ddd8e0cf48..1fbdbe59ae 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -66,11 +66,8 @@
>   #error Can only include this header with TCG
>   #endif
>   
> -#include "exec/memopidx.h"
> -#include "exec/vaddr.h"
> +#include "exec/cpu-ldst-common.h"
>   #include "exec/abi_ptr.h"
> -#include "exec/mmu-access-type.h"
> -#include "qemu/int128.h"
>   
>   #if defined(CONFIG_USER_ONLY)
>   #include "user/guest-host.h"
> @@ -157,100 +154,6 @@ void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
>   void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
>                             int mmu_idx, uintptr_t ra);
>   
> -uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> -uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> -uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> -uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
> -Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
> -
> -void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
> -                 MemOpIdx oi, uintptr_t ra);
> -void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
> -                 MemOpIdx oi, uintptr_t ra);
> -void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
> -                 MemOpIdx oi, uintptr_t ra);
> -void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
> -                 MemOpIdx oi, uintptr_t ra);
> -void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
> -                  MemOpIdx oi, uintptr_t ra);
> -
> -uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
> -                                 uint32_t cmpv, uint32_t newv,
> -                                 MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
> -                                    uint32_t cmpv, uint32_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
> -                                    uint32_t cmpv, uint32_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
> -                                    uint64_t cmpv, uint64_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
> -                                    uint32_t cmpv, uint32_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
> -                                    uint32_t cmpv, uint32_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
> -                                    uint64_t cmpv, uint64_t newv,
> -                                    MemOpIdx oi, uintptr_t retaddr);
> -
> -#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
> -TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
> -    (CPUArchState *env, vaddr addr, TYPE val, \
> -     MemOpIdx oi, uintptr_t retaddr);
> -
> -#ifdef CONFIG_ATOMIC64
> -#define GEN_ATOMIC_HELPER_ALL(NAME)          \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
> -    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
> -    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
> -#else
> -#define GEN_ATOMIC_HELPER_ALL(NAME)          \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
> -    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
> -#endif
> -
> -GEN_ATOMIC_HELPER_ALL(fetch_add)
> -GEN_ATOMIC_HELPER_ALL(fetch_sub)
> -GEN_ATOMIC_HELPER_ALL(fetch_and)
> -GEN_ATOMIC_HELPER_ALL(fetch_or)
> -GEN_ATOMIC_HELPER_ALL(fetch_xor)
> -GEN_ATOMIC_HELPER_ALL(fetch_smin)
> -GEN_ATOMIC_HELPER_ALL(fetch_umin)
> -GEN_ATOMIC_HELPER_ALL(fetch_smax)
> -GEN_ATOMIC_HELPER_ALL(fetch_umax)
> -
> -GEN_ATOMIC_HELPER_ALL(add_fetch)
> -GEN_ATOMIC_HELPER_ALL(sub_fetch)
> -GEN_ATOMIC_HELPER_ALL(and_fetch)
> -GEN_ATOMIC_HELPER_ALL(or_fetch)
> -GEN_ATOMIC_HELPER_ALL(xor_fetch)
> -GEN_ATOMIC_HELPER_ALL(smin_fetch)
> -GEN_ATOMIC_HELPER_ALL(umin_fetch)
> -GEN_ATOMIC_HELPER_ALL(smax_fetch)
> -GEN_ATOMIC_HELPER_ALL(umax_fetch)
> -
> -GEN_ATOMIC_HELPER_ALL(xchg)
> -
> -#undef GEN_ATOMIC_HELPER_ALL
> -#undef GEN_ATOMIC_HELPER
> -
> -Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
> -                                  Int128 cmpv, Int128 newv,
> -                                  MemOpIdx oi, uintptr_t retaddr);
> -Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
> -                                  Int128 cmpv, Int128 newv,
> -                                  MemOpIdx oi, uintptr_t retaddr);
> -
>   #if TARGET_BIG_ENDIAN
>   # define cpu_lduw_data        cpu_lduw_be_data
>   # define cpu_ldsw_data        cpu_ldsw_be_data
> @@ -297,15 +200,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
>   # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
>   #endif
>   
> -uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
> -                         MemOpIdx oi, uintptr_t ra);
> -uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
> -                          MemOpIdx oi, uintptr_t ra);
> -uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
> -                          MemOpIdx oi, uintptr_t ra);
> -uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
> -                          MemOpIdx oi, uintptr_t ra);
> -
>   uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
>   uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
>   uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


