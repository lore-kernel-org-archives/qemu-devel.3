Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A24FC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QPf-0007Vc-16; Tue, 01 Sep 2026 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QPd-0007UC-Gh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:28:37 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QPa-0001dv-G8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:28:37 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8623b1e7cb2so703057b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276508; cv=none;
 d=google.com; s=arc-20260327;
 b=p5N1Cv0MjqHtl3RDg0Rvtnxqgt31jfXclz0wnldKlH7uRe6v2+bp41XbdCVxUa9gsk
 r6pty7vFYCHeLzgI5zt9lAq+D8NqF1OeXWdVAb/wHG27VdDet9FMSeB48sVp0UX0+QdA
 JOFCAfKsPHiVhhIuR8HOEjkGv6CiuCXf/r6wnB8Bajr5gh4HbkF0D3ug8CZkbM5JMhyI
 ll/TOOvUtwIq4rwjxfLkFtvJzGvUFZt7bVHKam4RMMmkmSxzwHYO5BOHvKB4bdXYFyXG
 Nk9B8RqlcyZIdyRnOQg4cO/4onST87qbWjnB25/QmPv+o2wdzDzb6hsJAhNFkyzO+x3R
 z/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Shgzb5eJJo9lYhjmGyOmo/iUM2L9WckXZSOG7+edZvU=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=TS5weY7z6ti5tGoju1Qk5+KdBnCu+vFET0w+BoFsEYnyXlkQYaVvEWoxN6RfQpcvmB
 hyxcbRuBrKFxlAcJnNyghHrhKvYxaqOWdKjBHdHlvdwpoZmfkdX15LgvTBZ9d57QI+HZ
 nqPocMHetMpAE/ZzxuPqSfX62N/8GguqfLfnrmDhbe22cAX68ChHPnZ7zl12lCOfW2x3
 XYoegfBipgNKKwB0lY0VtN8He2PzqlqHPtv0S7otx/9yCxrdfCV9tIyuIN7w2l/qeQy4
 j6lQESwI+q4fNQE3hdJU5gmhVFnww6c4y9o3uH2z5db0G5T5wdkjqLbTCDVhmI18k2yt
 x7Cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788276508; x=1788881308; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Shgzb5eJJo9lYhjmGyOmo/iUM2L9WckXZSOG7+edZvU=;
 b=ELOg+ZPm8pboWOsLFH2mbJ3itW6tczXGHAkFxkP9WSE1mOoqO89jQvnWEnsWpvOETk
 s5EYNxoWbBpIWQKkh+tytzMM6sbtu1jubhjilefA2Zg3PL42XRikaLTwMhJ+OXfPqJdP
 e5JzIxGm3GOd7KDzU5VE41qDTVKBaKwnJPcwPLamtLyZPcodlAyAJbfJOM7XQRir/h5M
 u00hMOBmkXYkduRO12RUSXxaeO4eSlxZejE8muEBgeyyB0xM/KKI48SzS8sDEsfYP2e2
 ZinjNalaIucwJwviaMTRYt/K3sVhaGWSx8gL/NB12KPQASqKVCre355oy5UTqo61WX33
 +gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276508; x=1788881308;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Shgzb5eJJo9lYhjmGyOmo/iUM2L9WckXZSOG7+edZvU=;
 b=pCp8Luffo968YzM5nzqR48C0gZzqmCol1sXbL3KOCJK+8YdPUmezb2wpcX3lWY14yr
 hwQwlBY3V1+tInfnDD0dI/d6sVnFgDzvzFGN9GLBbblLw9LVeoqy/LpFL4vIjoGAfG44
 g/17yBuSbJE9X6ocKOue4o5tHyEwlJT9mtJzx8WfAMo1D7c2up3YZD0OuPRLZukQU+hf
 blmUDxSM43dIm1AtnmUEleCdlU1PFaVl0GqdhOxWmSd6sdueg8ia6DmfB5MIslJdbmT+
 kM81hs8y/0kpX5TeFe8UYSzOO06JM8wTcymby2qy/9gzx9tso+NnBxFEOHhbi3RZvhNR
 VHDA==
X-Gm-Message-State: AFuF++msS8XfQDW0OB+EFfPq3h+BB/xawG4zy0GrXrecB78SkggdFjaX
 cYhHQ67GNLWxov3xtGUEeSsPSozkwx3XTKnlwuomRAvWezGto5zr/3g0PQ+ABcZB2a3QepDjRlk
 zc+RfMSVxMoa6xu0GF2YuBqbxAZi6Dk+WknjDUMNpkQ==
X-Gm-Gg: AYBFou3MItyfiXqiy1zLWJmNDPAY4QD5pYwkTmYCs7h3sk3MGqlJ+nFjj1XfU1rYYoF
 xCsEbbJGLPd38qKln8XVUejnjkjTuZ8VNHGakwdzsQQxAfr+WxkXRsLIuTg5++mJCBW1Yshy0UF
 sGyycYeOlBF1I+pgSgBBCnMAo/lURBZ8oGxadGodCuqFoXO8TuniDXew3Yfw5TwDmG7ScvK/CT0
 ohUSfX0Vbz30P7hTE6YoETK6tgGiV1btOPcU57Q6E73Cytax21annS5CUtzcR2ydxBJmGmhquJW
 lIB5SywqyClw94xffU+IGnXBNCHdCXvrKocdUTiDahii0EPATUv1b86RRVba761KsccBnMi14nF
 W0mpsDKU3oAlxU3jK2+UDb6tK//jh
X-Received: by 2002:a81:8a06:0:b0:866:7724:3bcd with SMTP id
 00721157ae682-86677244407mr47618307b3.16.1788276508474; Tue, 01 Sep 2026
 08:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-11-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 16:28:16 +0100
X-Gm-Features: AcwNN1UEijV3u2vwuPn9QJOEPmesDhDxIlcb0F-5KajZ3mCR4IXC3hbHoeP00Rs
Message-ID: <CAFEAcA-MVRya=Y8i+rURHqizQzJLh=Gp5tQxHSK_VNBUQCAzdg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/18] accel/tcg: Replace size with first/last in
 probe_access_internal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sat, 15 Aug 2026 at 21:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Propagate the API change down one step further within cputlb.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c2ea31a397..b8c23b2948 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1358,8 +1358,8 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>      }
>  }
>
> -static int probe_access_internal(CPUState *cpu, vaddr addr,
> -                                 int fault_size, MMUAccessType access_type,
> +static int probe_access_internal(CPUState *cpu, vaddr addr, vaddr first,
> +                                 vaddr last, MMUAccessType access_type,
>                                   int mmu_idx, bool nonfault,
>                                   void **phost, CPUTLBEntryFull **pfull,
>                                   uintptr_t retaddr, bool check_mem_cbs)
> @@ -1375,7 +1375,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>      if (!tlb_hit_page(tlb_addr, page_addr)) {
>          if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
>              if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
> -                                0, fault_size, nonfault, retaddr)) {
> +                                0, last - addr + 1, nonfault, retaddr)) {
>                  /* Non-faulting page table read failed.  */
>                  *phost = NULL;
>                  *pfull = NULL;
> @@ -1423,7 +1423,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, vaddr first, vaddr last,
>      assert(addr <= last);
>      assert(((first ^ last) & TARGET_PAGE_MASK) == 0);
>
> -    flags = probe_access_internal(env_cpu(env), addr, last - addr + 1,
> +    flags = probe_access_internal(env_cpu(env), addr, first, last,
>                                    access_type, mmu_idx, nonfault,
>                                    phost, pfull, retaddr, true);
>
> @@ -1440,6 +1440,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>                            MMUAccessType access_type, int mmu_idx,
>                            void **phost, CPUTLBEntryFull **pfull)
>  {
> +    vaddr last = size ? addr + size - 1 : addr;

This can never overflow for the convenient reason that all four callers to
probe_access_full_mmu() pass a size of zero :-)

Do we update probe_access_full_mmu() to the first/last convention later
in this series ? I couldn't see anywhere we do that, but maybe I missed it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

