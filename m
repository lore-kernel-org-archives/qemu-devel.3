Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00CEC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywO3-0002ER-Oz; Tue, 25 Aug 2026 15:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wywO2-0002E4-Em
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:00:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wywO0-0002K5-Jh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:00:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso249361b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787684439; x=1788289239; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sjjQW6oWlwCaWLgf2ixMcgUAbuhGMfokCZiLHVuIGjU=;
 b=OzzXdjGfcIIxm8S9vfsFKNWLaJBswwZivADVIQ8LHhUxXaYzGp8hQWuWSx22kGq5dH
 HzVFRx5f47ox6z1sgS51LEahVbmOI2YVmwzafLAFVHCdS4pCEzUHblyOdZJ+LRRc209W
 o2IJFRZC/IXg+spDZhuAnCq4dLQtFxOV71zoJl/pJlXh+Xd9UWdYX7dZ0jcmaxP86R6b
 X6dIuikJhFcRpBjE2MlDa1VNPiaryG0R+x/v49N4Ojp3As+i7pK2H7EPnAfii498SEXq
 wWVv0ES55cf4mlNtha5EX/2rWGbDTg6pYF6NHBD04X0P0g3QwdLc3FC3Xp9gFqdhHE0y
 l6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787684439; x=1788289239;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sjjQW6oWlwCaWLgf2ixMcgUAbuhGMfokCZiLHVuIGjU=;
 b=b3+7cpt43MLB1c05imlbC8d+XZetHNtsFCQA7LYxEjJ9i0MB86DcgAQI9hIRzKM8L3
 jdKShHE61lyLKg6ZiIKZQHysKoBOvUjLLWR1/xnIADYsCY41aBr4QS7LnaVfXHm4YoT8
 H3JpXEDq8h2WWpjPJvKGVFwpVdzYTQGUAEEc2Huhm+OTgyEyMzVrHLxJroR8nZLHulg1
 Sl7jPAVrNHJ2y9yfxDXzw2+20QL96azwHR4iogNie/+Ec1cBvH/nPUzeQw+y4eVyJmT9
 9Yec1stvR4lB6ngXF9zwQTlaf9oJe+M+LyLL2yLZMAw2K2i6KKjkzE1wHHsW0/kq1j1B
 uyEQ==
X-Gm-Message-State: AFuF++ntnCryix+qjvJp47T4rGR2n8ClfmvjpeBFSxo0q1fCDlkhmrwq
 fNfPMZT0qFMArI1jBj8j+kMgqkfJoXFPVKQUBfQJuXxHSxeh8yDrHJEfF6F1LY7+Ack=
X-Gm-Gg: AR+sD12E7wkxb/YEcNipXguX2/8ash//sCoACkdPZZw4Src8Kd/ZcdS98Qfo8TIQctp
 Wwcnkx+N5geqcHFy8Y28tcV0hBWF7bAO6HPVCN/cUiGBiJfwYETE0RA3mgq8rsZBjPhOzIPtwen
 pjf9Il2QoqnS+MR+cGcAmh8WOQZpo9LXqGcRac5YpqbmW2zgm8+qRTVxHR62hsONBkHc53vfUFy
 riVH0EMzrRot9pFifIR6rCTX33GP8N/BgCoEWZRseNcNQ/rqJGy5wIV9pRwuo6WIkZH9ThRM6S5
 RLjoSHCtDChsN9jomP+YNHN0K/gZEFcWytAKkFGI4Xn0dBp/5TMFk5oyDLF0FetudahVkPr0qK2
 7+K0iJMIxUQszkatdFPjTQXyiF+wdxof1Zmn8CDtHkHXDYB2dAcVJHCdqWmimOnVyt6Sm8RlUiE
 IkAoeKhJEQkz9yto/FKb2v65WjnGJilhJSZq7Zo+JR8WDMS0uyo7iP3v6tzGMu49wdGztrKoV65
 rRhtYVMB1G8
X-Received: by 2002:a05:6a00:995:b0:842:55b6:f5a1 with SMTP id
 d2e1a72fcca58-853733ae90dmr1604056b3a.6.1787684438764; 
 Tue, 25 Aug 2026 12:00:38 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1beb11b65sm79291a12.8.2026.08.25.12.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:00:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 03:00:32 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
Subject: Re: [PATCH 10/23] target/riscv: Rewrite vext_ldst_us
Message-ID: <ao3fnC8rHy3Q3iW0@sifive.com>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815194549.1377505-11-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
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

On 2026-08-15 12:45, Richard Henderson wrote:
> We already computed the page split here, which means we
> were quite ready to call probe_access directly.  Do so,
> then use vext_ldst_nf_{host,tlb} to load the elements.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/tcg/vector_helper.c | 92 ++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 7f721dc24d..5b03e23fc3 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -483,7 +483,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>               vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
>               uint32_t evl, uintptr_t ra, bool is_load)
>  {
> -    target_ulong page_split, elems, addr;
> +    target_ulong elems, addr, last, last_in_page, page_split;
>      uint32_t nf = vext_nf(desc);
>      uint32_t vma = vext_vma(desc);
>      uint32_t max_elems = vext_max_elems(desc, log2_esz);
> @@ -491,10 +491,12 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>      uint32_t msize = nf * esz;
>      int mmu_index = riscv_env_mmu_index(env, false);
>      MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
> +    uint32_t i = env->vstart;
> +    void *host;
>  
>      VSTART_CHECK_EARLY_EXIT(env, evl);
>  
> -    addr = base + env->vstart * msize;
> +    addr = base + i * msize;
>  
>      /* Recognize alignment fault before memory protection fault. */
>      vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
> @@ -505,52 +507,72 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>       * by simply calling ldst_tlb.
>       */
>      if (nf == 1 && (evl << log2_esz) <= 6) {
> -        for (uint32_t i = env->vstart; i < evl;
> -             env->vstart = ++i, addr += esz) {
> +        for (; i < evl; env->vstart = ++i, addr += esz) {
>              ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
>          }
> -        env->vstart = 0;
> -        if (vma) {
> -            vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
> -        }
> -        return;
> +        goto tail;
>      }
>  #endif
>  
> -    /* Calculate the page range of first page */
> -    page_split = -(addr | TARGET_PAGE_MASK);
> -    /* Get number of elements */
> -    elems = page_split / msize;
> -    if (unlikely(env->vstart + elems >= evl)) {
> -        elems = evl - env->vstart;
> -    }
> +    /* Calculate the page range of first page. */
> +    last = base + evl * msize - 1;
> +    last_in_page = addr | ~TARGET_PAGE_MASK;
> +    page_split = last_in_page - addr;
> +
> +    /* Validate the first page is accessible. */
> +    host = probe_access(env, adjust_addr(env, addr),
> +                        MIN(last, last_in_page) - addr + 1,
> +                        access_type, mmu_index, ra);
> +
> +    /* Get number of complete elements in the first page. */
> +    elems = MIN(page_split / msize, evl - i);
>  

The page_split may excludes the byte at last_in_page, which the probe
size includes it. That elems will undercount a complete element ending
at the page boundary.
Then the following cross page element and second page probe will
be affected.

Maybe we could fix it by replacing the page_split with something like
probe_size below:

+    target_unlong probe_bytes = MIN(last, last_in_page) - addr + 1;
 
     /* Validate the first page is accessible. */
-    host = probe_access(env, adjust_addr(env, addr),
-                        MIN(last, last_in_page) - addr + 1,
+    host = probe_access(env, adjust_addr(env, addr), probe_bytes,
                         access_type, mmu_index, ra);
 
     /* Get number of complete elements in the first page. */
-    elems = MIN(page_split / msize, evl - i);
+    elems = MIN(probe_bytes / msize, evl - i);
 

> +    /* Cross page element */
> +    if (unlikely(page_split % msize)) {

+    if (unlikely(probe_bytes % msize)) {

> +        vext_ldst_nf_tlb(env, vd, addr, i++, nf, esz, max_elems, ldst_tlb, ra);
> +        if (i == evl) {
> +            goto tail;
> +        }
> +        env->vstart = i;
> +        addr += msize;
> +    }
> +
> +    /* Validate the second page is accessible. */
> +    assert(i < evl);
> +    elems = evl - i;
> +    host = probe_access(env, adjust_addr(env, addr), elems * msize,

+    probe_bytes = last - addr + 1;
+    host = probe_access(env, adjust_addr(env, addr), probe_bytes,

> +                        access_type, mmu_index, ra);

rnax

