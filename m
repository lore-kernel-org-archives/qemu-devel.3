Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03FDCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 01:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqLfL-0005fg-QE; Sun, 24 Aug 2025 21:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqLfJ-0005e3-LI
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 21:06:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqLfD-0001QD-6o
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 21:06:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-770d7dafacdso579676b3a.0
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756083981; x=1756688781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=owPpjy1b6z7D4h8pyobZNG3RHizY1I3o+b9QgVnm3cE=;
 b=UF5Zr8rAfqcZOW4uU5SBGV5336MU8tIpR2HfHzJvnf5DKoAo9hFd1Yd86awypp0NvY
 BHltE0WBHGFKX3+SXns3ITPrX1PsvyrFXHpxIl4izzNNzvTeJy3CtyCMHtWuzBtZm5Gz
 HARZsJfUi/SvZLr4GlEhJyf4SKKN6GD5/1IyY6ziI1TWPog/Lswwv32JXOoErQ+l5Myl
 OEC+Ij6zdiszHnnepCsolB3MwvWSqdOZpmwN67+QgEkqH/Q0/ZnRUTOepiIm9LmZPqBr
 WEFm43KMCQFhRd2I/sKvtV0xllkmSYFpqjJXXTQkT681uUu4zOCa9cZbMk/vedSWTwgB
 P6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756083981; x=1756688781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=owPpjy1b6z7D4h8pyobZNG3RHizY1I3o+b9QgVnm3cE=;
 b=HZIqITOF2uqq5Rpw6/n7WRmcxZFhLW5ZNhGNg3iEVCjIXctCuPTDY0so7ZdF6mHbeA
 6E2Os95JE+hz0wgKEvc+oEFnp5SOQ5fF/tXndZjw+oAyYLEiMMDM5o5XxjpQEEBeo+i6
 qhu/6X0IbCDQ8E4eUZjx2efvYDfrKwAjfH3H3UWvGljhPsgA4MDal7n0l3+qPLKMq57l
 54J1EzWpeiO9jxWTvVu3YYCnIU0Hw7ktewfizARfW7ulZFW1/2Evp4t3KJarpQ93OkGe
 o9K8KxDRqfJqH38LzAtVQ06ybfYgyLkU6HdBHp0IYhZGcVAJyaeH4fyp1VfOmp8dJ2Hi
 vX4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX8y19KTG+d8ekISrNSf06jye3A/IGEIcTR1qXh4J5ws4suFHz87WzTFFU1sukwims6o5HNn38bHJI@nongnu.org
X-Gm-Message-State: AOJu0YzOc9hKyVTKsufEbDKVFcB4FRmfrXoO1STxL9paoNGkML6PY8/4
 kxg5A30upz2Z5fPG48NO8p67dZruVQXgEHJmvpXuXmkhSfRZtBzXiXPaCqIW19v530c=
X-Gm-Gg: ASbGncs0441I2+ykma9YUzuy9xDx94urlgrED5epMWb2jqKxmY8nG6hkTdxFnXN5ppk
 RBPY+pGVgyR5U2VmEW2zcwfYiirNUFZV4buSrhe5bOSNtLWuEw8K+Qi95W64AXbRo7EyUmSYK9D
 /aPOOddDiPw4SkWoAc422w6iK9u+JcLfhHxIloHLvZ0U8k3STN6VFjKuyUSgR0qg99hfVfzqfl+
 +CFO04jnquKKoKV3cQvRL9lqSi2KeeYYxSm9YPl7KsqrW8OFHEa5UkolDGL/TkkOiLDHOY7j7PM
 nLS61IQjZxwGalWx0v2J03bgL/la27ItPIeWuNZV+HetJEDtcK6odKpZ3sAWKcZFMo17uwHUnTi
 bPEHGIrUqD2o+dHQmpZXjtgIlzFtBTRjsCAEZ+G2A8Mfpk9BOPdGJ9/gHipp7UoF0LCm3m4GbHd
 7/ln2QNy7NyeMmAebHnh2cPWdwPhu2KdYERUXkiI5Xzs3skN7OqyHfN5hIG9rmnxt9
X-Google-Smtp-Source: AGHT+IETTsM5fmbGnFRYslYuy+Q0YFArBXbFSuyTzTpe4VnCu0xyx/dzamVz30D8Q86Ol4me0j8rDw==
X-Received: by 2002:a05:6a20:7f97:b0:23f:fa6e:912a with SMTP id
 adf61e73a8af0-24340b585dfmr14141920637.16.1756083980876; 
 Sun, 24 Aug 2025 18:06:20 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77057368ca0sm2563515b3a.58.2025.08.24.18.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 18:06:20 -0700 (PDT)
Message-ID: <5c0701e6-2485-41df-929f-2ad9037e626c@linaro.org>
Date: Mon, 25 Aug 2025 11:06:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Add support for LE pages on PowerPC
 booke206 mmu
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
 <20250821113348.91339-3-d.zhebryakov@yandex.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250821113348.91339-3-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/21/25 21:33, Danila Zhebryakov wrote:
> Add support for passing TLB_BSWAP flag from powerpc booke206 MMU
> Fix instruction fetches from LE pages being treated as MMIO
> This change should not affect SPARC, as its instruction fetches are always BE
> 
> Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
> ---
>   accel/tcg/cputlb.c      | 12 +++++-------
>   target/ppc/cpu.h        |  4 ++++
>   target/ppc/mmu-booke.c  |  5 +++++
>   target/ppc/mmu_helper.c | 17 +++++++++++++++--
>   target/ppc/translate.c  | 29 ++++++++++++++++++++++++++++-
>   5 files changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 841b54e41d..396e510f1b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1401,7 +1401,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       flags |= full->slow_flags[access_type];
>   
>       /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
> -    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> +    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY
> +                           | TLB_CHECK_ALIGNED | TLB_BSWAP))
>           || (access_type != MMU_INST_FETCH && force_mmio)) {
>           *phost = NULL;
>           return TLB_MMIO;
> @@ -1792,12 +1793,9 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>               mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
>           }
>   
> -        /*
> -         * Since target/sparc is the only user of TLB_BSWAP, and all
> -         * Sparc accesses are aligned, any treatment across two pages
> -         * would be arbitrary.  Refuse it until there's a use.
> -         */
> -        tcg_debug_assert((flags & TLB_BSWAP) == 0);
> +        if (unlikely(flags & TLB_BSWAP)) {
> +            l->memop ^= MO_BSWAP;
> +        }

You should replace the comment, noting that E500 detects endianness on the lowest memory 
address.

> +/*****************************************************************************/
> +/* PowerPC usage of the PAGE_TARGET_1 bit for TLB little-endian bit */
> +#define PAGE_LE  PAGE_TARGET_1

PAGE_TARGET_1 is a user-only thing...


> diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
> index 55e5dd7c6b..dc72bbf21f 100644
> --- a/target/ppc/mmu-booke.c
> +++ b/target/ppc/mmu-booke.c
> @@ -357,6 +357,11 @@ found_tlb:
>       }
>   
>       *prot = 0;
> +
> +    if (tlb->mas2 & MAS2_E) {
> +        *prot |= PAGE_LE;
> +    }
> +
>       if (pr) {
>           if (tlb->mas7_3 & MAS3_UR) {
>               *prot |= PAGE_READ;
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index ac60705402..20282edaaa 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -27,6 +27,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
> +#include "exec/tlb-flags.h"
>   #include "exec/log.h"
>   #include "helper_regs.h"
>   #include "qemu/error-report.h"
> @@ -1368,8 +1369,20 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
>   
>       if (ppc_xlate(cpu, eaddr, access_type, &raddr,
>                     &page_size, &prot, mmu_idx, !probe)) {
> -        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
> -                     prot, mmu_idx, 1UL << page_size);
> +        if (prot & PAGE_LE) {
> +            CPUTLBEntryFull full = {
> +                .phys_addr = raddr & TARGET_PAGE_MASK,
> +                .attrs = MEMTXATTRS_UNSPECIFIED,
> +                .prot = prot,
> +                .lg_page_size = ctz64(1UL << page_size),
> +                .tlb_fill_flags = TLB_BSWAP
> +            };
> +            tlb_set_page_full(cs, mmu_idx, eaddr & TARGET_PAGE_MASK, &full);
> +
> +        } else {
> +            tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
> +                         prot, mmu_idx, 1UL << page_size);
> +        }

(0) ctz64(1 << x) == x.
(1) Ideally convert ppc to *always* use tlb_set_page_full.
(2) Pass the CPUTLBEntryFull struct down to the helpers to be
     filled in and then you don't need to abuse PAGE_TARGET_1;
     you can set .tlb_fill_flags directly for MAS2_E.

> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -24,7 +24,9 @@
>   #include "exec/target_page.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> +#include "accel/tcg/probe.h"
>   #include "qemu/host-utils.h"
> +#include "exec/tlb-flags.h"
>   
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> @@ -219,6 +221,27 @@ static inline bool need_byteswap(const DisasContext *ctx)
>   #endif
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static bool is_page_little_endian(CPUPPCState *env, vaddr addr)
> +{
> +    CPUTLBEntryFull *full;
> +    void *host;
> +    int mmu_idx = ppc_env_mmu_index(env, true);
> +    int flags;
> +
> +    flags = probe_access_full_mmu(env, addr, 0, MMU_INST_FETCH, mmu_idx,
> +                                  &host, &full);
> +    assert(!(flags & TLB_INVALID_MASK));
> +
> +    return full->tlb_fill_flags & TLB_BSWAP;
> +}
> +#else
> +static bool is_page_little_endian(CPUPPCState *env, vaddr addr)
> +{
> +    return false;
> +}
> +#endif
> +
>   /* True when active word size < size of target_long.  */
>   #ifdef TARGET_PPC64
>   # define NARROW_MODE(C)  (!(C)->sf_mode)
> @@ -6577,7 +6600,11 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>                 ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
>   
>       ctx->cia = pc = ctx->base.pc_next;
> -    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
> +    bool tlb_is_le = is_page_little_endian(env, ctx->base.pc_next);
> +
> +
> +    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx)
> +                                                || tlb_is_le);

You should probe the page once during ppc_tr_init_disas_context, not for every insn.  You 
can skip this probe unless E500.


r~

