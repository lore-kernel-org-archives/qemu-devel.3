Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC8CC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Pye-0002sl-2C; Tue, 01 Sep 2026 11:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1PyQ-0002qb-0M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:00:30 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1PyO-00029o-8D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:00:29 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-86a29a48ed9so8055207b3.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788274827; cv=none;
 d=google.com; s=arc-20260327;
 b=Qn2Gxnc9rTgKaXTjZ973xaeLfoW7yEyx5uI6qCYCgBSwbcUYPAjQl2sDAFeNtHM+II
 TiA7Nnds1LLlUo3a7YfUyDFgFwXLOKS7dt61Ni77TIorbJQ8M9k227DRu4Q890i+4lM/
 OoAJEIOwBmZSOmFv9WVTyH5F5RQiC41T1omFD5X0tmUfxGqEam8O+Ob+KizSTaUvkQ4K
 52Z/RsQGIt4fQE7JbS9ecHpr97pFkuqP/iVcFZY6QREcQLkHjLONICVZ/hr1HRI2FmSv
 cudeRVmjc3vca/b+dqUwuQ5WRW+M3LHKqRip76fFWNmGy3k6K66g2QXth24qOll/++6X
 wjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O8EOjDFm+wry6t9343Xh2LgYjmemUERgZx+dmAS7FfE=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=lQUr+r8whW5OwX+IXl0FQbCU1Q7wo2sE3SrViducDXQJWmEq4p+Ha6Qg1hQnIhrHTF
 3ZZnJMgJ3qpS5WOitRy1aULI42kABZKeTYiEUqzrBNshLbeLJc+EpegM7AZbJuQuYUKG
 aRFebZv4M2DradKXOQHQYOKrT7IS5BOd/u4BiOoMzj2MHnFFlGL1r18K6u0HpiJNyUob
 piQeoP8KYDikt3LfVEu/92C7g5WZWtOhynTYRBvaAr605UaUhATdfcDow86jcPMB/KSk
 FCmThZ3aste9zjKRXZtUFFKFSRPLvgZUgUF1uM18fOq5dsz0jaLGKCD/ZzDH9jYrIElu
 n9vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788274827; x=1788879627; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O8EOjDFm+wry6t9343Xh2LgYjmemUERgZx+dmAS7FfE=;
 b=Ya0CAi9dRwN5CO4+KzPlI+klcLT2pRoQ1LIJwP3BI2hMdk35r42Tn+fzD80cXPoxE1
 xgV9x6HMTg5j4sI6Dulf/6XTPkjROPPAzcW1PwHdMk3c3bY61hQAmaZBXa0gpYXUzBsU
 4FZhHYV6Q3ysyAZTHUNnm9ovWnuGp8gya4HEAosur7nBXiArFvbqg3qEBUD0NWNZfvGR
 uruxzBeR55sDm5NMyy0gZTu+KQzj/xKLLAbJzretqI0r6tmqc/XNCTLc83B4NuPit+6K
 73QRDkDiHHIYb8nLqF3WboeI62TTggo8jSq3eNOA1WTg5AFYx20H0eotJi0Cf7CND3DZ
 Zx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788274827; x=1788879627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O8EOjDFm+wry6t9343Xh2LgYjmemUERgZx+dmAS7FfE=;
 b=bpsJwUQtMFA49v3nZndbtP8MxK9L9Hs4x0FVas4tsfRE6BhrmZddggksh/WhJyCNRN
 aNbHElXGuXLu4qV7v2FVm2nzgro2LgOy1rtx4+NzKkQfyM5ehr0axkdCy+hZFeCe4mZi
 zfflDA2rRNwyxDo15ZD9UUQq2621j5IacBG/CXxobGMEe3qGpzi6Yxl59yK7aHCrW9Bp
 2JbUvUnWO3JSxvFCYfrjvrkIBqsLQwC0b7pTXiWQcyAivPxr2iees58quupnn7k03Eev
 5VZfD+HPcFSyPSL0k3q9a32hZzM24S5SmP/Nj0pY5deuDi4nfR4umozDHlsz1Xskdyjt
 OXhA==
X-Gm-Message-State: AFuF++mc8euoBdX+jAuu09694Gcffo0qnsA4XAPyKUa6t9QYov4vTooI
 mnJFxpzX62UB93/1tasTYfWkD7O8dbBgSXb1Kr2pLwTugyRkKTONt+qUwPOhk+VtgNXmA49IF0F
 t3ToS3ySO5r1NMd5JOVHvKtXH4bJAWPXnmn/rNvGWoA==
X-Gm-Gg: AYBFou0uZFnrCyKVj7/PMJVSCZ477JcmMpGpHVluaI0nX6gIbMXRfxmWUoODdVYoKJ/
 7Brof8SiU8/7kZU2hEckHqg+OI30Bu3975JwOeVy5SDkpQ/1bB4lwKo8Uxv46gDst29e9KNQie0
 AUVa9Hc9mJpIwxGE8vHbR/JAG9Dpf7u4EtudgqEJLPsOQFhvhefx4FTPZ33PSnP0wggWMq6S/N0
 k1Ko0a9f7ZlkKXEfi2PmLoOG7ioHWJDtVjW5q/qUT7XVfasEtWzGWos7xf8FlA8sK31tJoNLD59
 bEGBDE3Vwb3irLuJGZvU7gOX1p0TlrAbO1gMCxcWlVLEUcAZhEJxVy0vZNeP6qngeJL1kpdXOdD
 KLPmTbZxAWayedUvxhZhwBtzVPLVHU500VcFhjw==
X-Received: by 2002:a05:690c:4017:b0:808:f9bb:3832 with SMTP id
 00721157ae682-86874ed6716mr36431947b3.22.1788274825957; Tue, 01 Sep 2026
 08:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-8-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 16:00:14 +0100
X-Gm-Features: AcwNN1WPi7qGbg46Wh0xWYH9-0XQaT0gVeeR0vqvhzK0VAgdSmxHoNQPfEo-pc0
Message-ID: <CAFEAcA_C7KpgU2--eEKwifuTgh-oCJPKexy30RB=Bc8VCcXD3w@mail.gmail.com>
Subject: Re: [RFC PATCH 07/18] accel/tcg: Replace size with first/last in
 probe_access_full
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 15 Aug 2026 at 21:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/accel/tcg/probe.h     |  2 +-
>  accel/tcg/cputlb.c            | 17 +++++++++++------
>  target/arm/tcg/helper-a64.c   |  5 ++++-
>  target/arm/tcg/mte_helper.c   | 21 ++++++++++++---------
>  target/arm/tcg/sve_helper.c   |  5 ++++-
>  target/mips/tcg/ldst_helper.c |  4 ++--
>  6 files changed, 34 insertions(+), 20 deletions(-)

> @@ -1412,19 +1412,24 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>      return flags;
>  }
>
> -int probe_access_full(CPUArchState *env, vaddr addr, int size,
> +int probe_access_full(CPUArchState *env, vaddr addr, vaddr first, vaddr last,
>                        MMUAccessType access_type, int mmu_idx,
>                        bool nonfault, void **phost, CPUTLBEntryFull **pfull,
>                        uintptr_t retaddr)
>  {
> -    int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
> -                                      mmu_idx, nonfault, phost, pfull, retaddr,
> -                                      true);
> +    int flags;
> +
> +    assert(first <= addr);
> +    assert(addr <= last);
> +    assert(((first ^ last) & TARGET_PAGE_MASK) == 0);
> +
> +    flags = probe_access_internal(env_cpu(env), addr, last - addr + 1,
> +                                  access_type, mmu_idx, nonfault,
> +                                  phost, pfull, retaddr, true);
>
>      /* Handle clean RAM pages.  */
>      if (unlikely(flags & TLB_NOTDIRTY)) {
> -        int dirtysize = size == 0 ? 1 : size;
> -        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, retaddr);
> +        notdirty_write(env_cpu(env), first, last - first + 1, *pfull, retaddr);
>          flags &= ~TLB_NOTDIRTY;
>      }

> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 399bca30c9..f36286d596 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -151,6 +151,7 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
>      ret.flags = 0;
>  #else
>      CPUTLBEntryFull *full;
> +    vaddr ptr_last, ptr_page_last;
>      hwaddr ptr_paddr, tag_paddr, xlat;
>      MemoryRegion *mr;
>      ARMASIdx tag_asi;
> @@ -162,7 +163,11 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
>       * exception for inaccessible pages, and resolves the virtual address
>       * into the softmmu tlb.
>       */
> -    ret.flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
> +    ptr_last = ptr + ptr_size - 1;
> +    ptr_page_last = ptr | ~TARGET_PAGE_MASK;

Are we definitely guaranteed not to get here such that ptr_last has wrapped
back around to 0 ?  I think 'ptr' can come directly from the guest
(e.g. trans_LDG can pass a guest register value to HELPER(ldg), which
calls us). In that case we'll fail the assert() inside probe_access_full()
because last will be < addr. The second probe below will also calculate
a ptr_page_last + 1 that wraps round to 0.

> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index 1b25466b49..065570a8f1 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -44,8 +44,8 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
>      int flags;                                                                \
>                                                                                \
>      env->llval = do_cast cpu_##insn##_mmu(env, arg, oi, ra);                  \
> -    flags = probe_access_full(env, arg, size, MMU_DATA_LOAD, mem_idx,         \
> -                              true, &host_unused, &full, ra);                 \
> +    flags = probe_access_full(env, arg, arg, arg + size - 1, MMU_DATA_LOAD,   \
> +                              mem_idx, true, &host_unused, &full, ra);        \
>      assert(!(flags & TLB_INVALID_MASK));                                      \
>      env->CP0_LLAddr = full->phys_addr;                                        \
>      env->lladdr = arg;                                                        \

The macro magic in the MIPS translator is confusing, but I think that
it's possible that "arg + size - 1" here also might wrap round to 0 ?

thanks
-- PMM

