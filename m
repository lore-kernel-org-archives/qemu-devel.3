Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED99DCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1Tb-0005Ja-C3; Wed, 29 Oct 2025 04:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1Ta-0005JE-5k
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:24:14 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1TQ-0006UC-RG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:24:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so1232690466b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761726241; x=1762331041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sKes6IQxjSlG8QEOdkrliUXqc6y5PN6vwJyeVBRyYeU=;
 b=pYthpVdKfOJ3b2TDm25T4QeJV39/KhWBwsobR3cdC0PWSOi2McLqv6Np07vUxIJC1D
 VfqCPj0EkQfUZygp2/a1LCFi5pze2BXK41/MaE5NiZjz4IfaiVsUwJN8pTBFQr8jB46e
 wGXr0U1mz9GsYOx2KSpUoQJ4iiXn4JEFJQoXMIDHabSiDYq4Lr/fFBu87syZKZq9i0pq
 F1uTEbOBW/IE7ehZLb5rTYIiok4bmvlxBhHVBHAk7V2ZAuMVFnO6IlLP09qsr1QWrK5H
 /LG3eqLBLqv5lvTu8qcwaWWZcl/u53NLfIUFGzTdDUcuUZxRhK+2tEwd9bEWAKCOS+sO
 6IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761726241; x=1762331041;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKes6IQxjSlG8QEOdkrliUXqc6y5PN6vwJyeVBRyYeU=;
 b=FElrtUCOIS42VKz+JmoKH2G93gJEkEtuZbSwo7xiVzI6A/3GRvmmCe3pfu1jAW9GmB
 FJNJg5l12jJhDWB8cyyEdNB0sHfAS0XwtAp6vx09Hz+uyMeTQWcv3P1IgPKfw5l8TWqr
 O+aWe8iHRT7DAhuBC8ws/HBv6LPbMhB4zJT8aTVwNUZyXBDAt5nCfe5pTkCTZvWpHuJQ
 xnr6Lc2EYpoCWoUkAfimATghKGsm1mByppu9TGnrXBMoy7YAapjlxJPUAe5g/o0Ru6R8
 qqaOyr0pe10zUdbJV+/eMQrf1I25L8R3bqsaoG4g1Zcd84wTLOGBG8OUdc7lKAFTGu0j
 W8BA==
X-Gm-Message-State: AOJu0Yy4cJokhWDaO+A7+qWvhMf2/t64pVZjXTospZE13z3tLYGwdHfX
 T2VwkIgcbmK2DYr9k3aN1GyXO54+Va3Jhr/g67KvV7XIfa3u2kYJOwKo+39gswiEleUfq4EDh+O
 uTmAjye0=
X-Gm-Gg: ASbGncuq8K2wI9CZgdnMQBx2mUQmZfCiJKv8OGkRqJU988L/Gtm0tBmiYwib8mOVcug
 Z7e8Ln2gqlTMgq63Nc234NlQcRd49g7lqwq3iUOtCH8wpRtD7QpS2ctoZG4RgxH3+Tr0ZmB6dAa
 BKJnSDqnZYbx2dXwq5xNKf1foyj/B6NnhX5y3GDbN2TRLmmn91d5dARbnEeQMx/5CD0pC2nCUAl
 jdwggODrFQr5y56+NCWmS4Z+cxu6AZjB8bWzWLqEGsme7+I5on4eFA8pKyehNWz8ykye8KUDirO
 buGcnl9OP4kWLC6pA/qZkvIFDVLWxxtcAPPuZMz9CyGQeL0FvLiQZyksM9KEDC5c+cMiVjezzWT
 WGZ2024jnR4JA5+hBsBCD7aW+dhPYZayD3CL0gkAM7G3BQFwljtir26tFw/A4i6SB6SGpGtCuer
 BHsaKz5KPMRgsnXETf
X-Google-Smtp-Source: AGHT+IGyPnI/gB93SSYMdzNVBb4j5oXy0oL0l0GUVjpWbp77LaIrfyNYlZk23jd6E+Pa5NspK46t6Q==
X-Received: by 2002:a17:907:869f:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b703d4f364emr177570366b.45.1761726240846; 
 Wed, 29 Oct 2025 01:24:00 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854763b1sm1352630466b.71.2025.10.29.01.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:24:00 -0700 (PDT)
Message-ID: <8db95ba7-09f7-4a97-89c8-e0e0bcb668d4@linaro.org>
Date: Wed, 29 Oct 2025 09:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251022001741.222499-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022001741.222499-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Ping.

r~

On 10/22/25 02:17, Richard Henderson wrote:
> For Arm, we need 3 cases: (1) the alignment required when accessing
> Normal memory, (2) the alignment required when accessing Device memory,
> and (3) the atomicity of the access.
> 
> When we added TLB_CHECK_ALIGNED, we assumed that cases 2 and 3 were
> identical, and thus used memop_atomicity_bits for TLB_CHECK_ALIGNED.
> 
> This is incorrect for multiple reasons, including that the atomicity
> of the access is adjusted depending on whether or not we are executing
> within a serial context.
> 
> For Arm, what is true is that there is an underlying alignment
> requirement of the access, and for that access Normal memory
> will support unalignement.
> 
> Introduce MO_ALIGN_TLB_ONLY to indicate that the alignment
> specified in MO_AMASK only applies when the TLB entry has
> TLB_CHECK_ALIGNED set; otherwise no alignment required.
> 
> Introduce memop_tlb_alignment_bits with an additional bool
> argument that specifies whether TLB_CHECK_ALIGNED is set.
> All other usage of memop_alignment_bits assumes it is not.
> 
> Remove memop_atomicity_bits as unused; it didn't properly
> support MO_ATOM_SUBWORD anyway.
> 
> Update target/arm finalize_memop_atom to set MO_ALIGN_TLB_ONLY
> when strict alignment isn't otherwise required.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> PS: There are a number of uses of align_mem for AdvSIMD, SVE and SME.
> I have not re-familiarized myself with the effects of SCR.A and
> Normal/Device memory for those cases.  I may well have missed something.
> 
> ---
>   include/exec/memop.h            | 43 +++++++++++++++------------------
>   target/arm/tcg/translate.h      |  4 +--
>   accel/tcg/cputlb.c              | 13 +---------
>   target/arm/ptw.c                |  2 +-
>   target/arm/tcg/translate-a64.c  | 10 +++-----
>   target/arm/tcg/translate-neon.c |  2 +-
>   tcg/tcg.c                       | 10 +++++---
>   7 files changed, 35 insertions(+), 49 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index cf7da3362e..799b5b4221 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -72,6 +72,16 @@ typedef enum MemOp {
>       MO_ALIGN_64 = 6 << MO_ASHIFT,
>       MO_ALIGN    = MO_AMASK,
>   
> +    /*
> +     * MO_ALIGN_TLB_ONLY:
> +     * Apply MO_AMASK only along the TCG slow path if TLB_CHECK_ALIGNED
> +     * is set; otherwise unaligned access is permitted.
> +     * This is used by target/arm, where unaligned accesses are
> +     * permitted for pages marked Normal but aligned accesses are
> +     * required for pages marked Device.
> +     */
> +    MO_ALIGN_TLB_ONLY = 1 << 8,
> +
>       /*
>        * MO_ATOM_* describes the atomicity requirements of the operation:
>        * MO_ATOM_IFALIGN: the operation must be single-copy atomic if it
> @@ -104,7 +114,7 @@ typedef enum MemOp {
>        * size of the operation, if aligned.  This retains the behaviour
>        * from before this field was introduced.
>        */
> -    MO_ATOM_SHIFT         = 8,
> +    MO_ATOM_SHIFT         = 9,
>       MO_ATOM_IFALIGN       = 0 << MO_ATOM_SHIFT,
>       MO_ATOM_IFALIGN_PAIR  = 1 << MO_ATOM_SHIFT,
>       MO_ATOM_WITHIN16      = 2 << MO_ATOM_SHIFT,
> @@ -169,16 +179,16 @@ static inline MemOp size_memop(unsigned size)
>   }
>   
>   /**
> - * memop_alignment_bits:
> + * memop_tlb_alignment_bits:
>    * @memop: MemOp value
>    *
> - * Extract the alignment size from the memop.
> + * Extract the alignment size for use with TLB_CHECK_ALIGNED.
>    */
> -static inline unsigned memop_alignment_bits(MemOp memop)
> +static inline unsigned memop_tlb_alignment_bits(MemOp memop, bool tlb_check)
>   {
>       unsigned a = memop & MO_AMASK;
>   
> -    if (a == MO_UNALN) {
> +    if (a == MO_UNALN || (!tlb_check && (memop & MO_ALIGN_TLB_ONLY))) {
>           /* No alignment required.  */
>           a = 0;
>       } else if (a == MO_ALIGN) {
> @@ -191,28 +201,15 @@ static inline unsigned memop_alignment_bits(MemOp memop)
>       return a;
>   }
>   
> -/*
> - * memop_atomicity_bits:
> +/**
> + * memop_alignment_bits:
>    * @memop: MemOp value
>    *
> - * Extract the atomicity size from the memop.
> + * Extract the alignment size from the memop.
>    */
> -static inline unsigned memop_atomicity_bits(MemOp memop)
> +static inline unsigned memop_alignment_bits(MemOp memop)
>   {
> -    unsigned size = memop & MO_SIZE;
> -
> -    switch (memop & MO_ATOM_MASK) {
> -    case MO_ATOM_NONE:
> -        size = MO_8;
> -        break;
> -    case MO_ATOM_IFALIGN_PAIR:
> -    case MO_ATOM_WITHIN16_PAIR:
> -        size = size ? size - 1 : 0;
> -        break;
> -    default:
> -        break;
> -    }
> -    return size;
> +    return memop_tlb_alignment_bits(memop, false);
>   }
>   
>   #endif
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 9a85ea74db..b62104b4ae 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -744,8 +744,8 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
>    */
>   static inline MemOp finalize_memop_atom(DisasContext *s, MemOp opc, MemOp atom)
>   {
> -    if (s->align_mem && !(opc & MO_AMASK)) {
> -        opc |= MO_ALIGN;
> +    if (!(opc & MO_AMASK)) {
> +        opc |= MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>       }
>       return opc | atom | s->be_data;
>   }
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 631f1fe135..fd1606c856 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1668,18 +1668,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>   
>       if (likely(!maybe_resized)) {
>           /* Alignment has not been checked by tlb_fill_align. */
> -        int a_bits = memop_alignment_bits(memop);
> -
> -        /*
> -         * This alignment check differs from the one above, in that this is
> -         * based on the atomicity of the operation. The intended use case is
> -         * the ARM memory type field of each PTE, where access to pages with
> -         * Device memory type require alignment.
> -         */
> -        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
> -            int at_bits = memop_atomicity_bits(memop);
> -            a_bits = MAX(a_bits, at_bits);
> -        }
> +        int a_bits = memop_tlb_alignment_bits(memop, flags & TLB_CHECK_ALIGNED);
>           if (unlikely(addr & ((1 << a_bits) - 1))) {
>               cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
>           }
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d4386ede73..939215d096 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2351,7 +2351,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>        * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
>        */
>       if (device) {
> -        unsigned a_bits = memop_atomicity_bits(memop);
> +        unsigned a_bits = memop_tlb_alignment_bits(memop, true);
>           if (address & ((1 << a_bits) - 1)) {
>               fi->type = ARMFault_Alignment;
>               goto do_fault;
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 3292d7cbfd..08b21d7dbf 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3691,9 +3691,8 @@ static bool trans_STP(DisasContext *s, arg_ldstpair *a)
>        * In all cases, issue one operation with the correct atomicity.
>        */
>       mop = a->sz + 1;
> -    if (s->align_mem) {
> -        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> -    }
> +    mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> +    mop |= (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>       mop = finalize_memop_pair(s, mop);
>       if (a->sz == 2) {
>           TCGv_i64 tmp = tcg_temp_new_i64();
> @@ -3742,9 +3741,8 @@ static bool trans_LDP(DisasContext *s, arg_ldstpair *a)
>        * since that reuses the most code below.
>        */
>       mop = a->sz + 1;
> -    if (s->align_mem) {
> -        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> -    }
> +    mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
> +    mop |= (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>       mop = finalize_memop_pair(s, mop);
>       if (a->sz == 2) {
>           int o2 = s->be_data == MO_LE ? 32 : 0;
> diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
> index 844d2e29e4..e3c7d9217b 100644
> --- a/target/arm/tcg/translate-neon.c
> +++ b/target/arm/tcg/translate-neon.c
> @@ -520,7 +520,7 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
>       if (a->align) {
>           align = pow2_align(a->align + 2); /* 4 ** a->align */
>       } else {
> -        align = s->align_mem ? MO_ALIGN : 0;
> +        align = MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
>       }
>   
>       /*
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 294762c283..fbf09f5c82 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3039,20 +3039,22 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
>               case INDEX_op_qemu_ld2:
>               case INDEX_op_qemu_st2:
>                   {
> -                    const char *s_al, *s_op, *s_at;
> +                    const char *s_al, *s_tlb, *s_op, *s_at;
>                       MemOpIdx oi = op->args[k++];
>                       MemOp mop = get_memop(oi);
>                       unsigned ix = get_mmuidx(oi);
>   
> +                    s_tlb = mop & MO_ALIGN_TLB_ONLY ? "tlb+" : "";
>                       s_al = alignment_name[(mop & MO_AMASK) >> MO_ASHIFT];
>                       s_op = ldst_name[mop & (MO_BSWAP | MO_SSIZE)];
>                       s_at = atom_name[(mop & MO_ATOM_MASK) >> MO_ATOM_SHIFT];
> -                    mop &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_MASK);
> +                    mop &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE |
> +                             MO_ATOM_MASK | MO_ALIGN_TLB_ONLY);
>   
>                       /* If all fields are accounted for, print symbolically. */
>                       if (!mop && s_al && s_op && s_at) {
> -                        col += ne_fprintf(f, ",%s%s%s,%u",
> -                                          s_at, s_al, s_op, ix);
> +                        col += ne_fprintf(f, ",%s%s%s%s,%u",
> +                                          s_at, s_al, s_tlb, s_op, ix);
>                       } else {
>                           mop = get_memop(oi);
>                           col += ne_fprintf(f, ",$0x%x,%u", mop, ix);


