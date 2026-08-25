Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D2C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyvQF-0008NO-C2; Tue, 25 Aug 2026 13:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wyvQE-0008N1-Ax
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:58:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wyvQC-0003i5-7p
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:58:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so191438a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787680730; x=1788285530; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cCfFLbwwaJ1Fp51XSeYBPjgTykUG+k2Xi9yFMY/cMkI=;
 b=S8jucgb5amf3P9H13L88Bh+4i4C6WxJJZCEIUSjIVbbfZQ5fTRG56teauQRRLd4eoW
 vmfUbmnq603932fW2l44Bi/ixumYyF3VNSdb11BAX1e62AJA2l83egDKV0nj+oz0iTcG
 kR0xUF9Kwmt3/lu/JO5Ngl65YT9cPjdjqG8/kiL/8rCryr4PjMo1Ai6eViz9QIQGf08R
 Gtw6oAbCQUpB1AllVYyKa24rEVWPJkR1t/SDVCdTWwkiHtuaLVyQ7gZRAr9XOEj6WBcJ
 i05q4rNXKGUTcL5EE3bSVzNR6voUFnoenbvP3zQLsTvslRuP5mf1mytAQvaFbU9uUL8a
 CZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787680730; x=1788285530;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cCfFLbwwaJ1Fp51XSeYBPjgTykUG+k2Xi9yFMY/cMkI=;
 b=Jn6WhLhLGWDZ6rmBLiALGniSOGl7LzY+gMjq+KKWDu9xzAZAtuLeV0qdno8vaMqEG2
 gYXDkZdUiVDsHAh6/UEjFL4d8cXPiWnLFPl1pwZO5ql6x89VxAPgOErlpJJ9bhkBDKKb
 08NRclZqPvNULKaT53gl0dLS1FTXZ+seZcnoTjMF59e3YNUpo/ToQyAko5y4e7U/9nf7
 pbzTS0usf8rm2FhrwzenEKlgFhhp7UZMhNSbJYtkvp+t0GOuULGjv1s6qhpAFnz518lp
 asMQl44ptPRVf3VZoliyhNDnqiDd8KWTACMrpOvVWaTjigUmKNqKYex5LTiRBCrXRqxH
 v/UQ==
X-Gm-Message-State: AFuF++nYnHSVa362uJ4p8ttUOrJlbI6W39uQmB7govF0qnGpFxMKknVK
 VqItsQdRrQIdCpUFpJdAKK25WhpZH82GZwE0q+j44hH/OdSvzMpGPCyhkCqDPM+VlRI=
X-Gm-Gg: AR+sD10aQiuJPBfuIZx1CWh3aq9JAP5SRtE3SEDkg5A3eAiTYXRBUJeP2wiPpB7U8Md
 JMrJEuila0sYFsJJJWzJtGrcIgbTR8ViF5JtJGEaOakbE2wyO4ocv2tyv7Rert/OQYRef/7VjDh
 ocPRl2u+DQEX5GG2Q3FK1Xk0QiX+irvdYUKuwt7l0/0NU5n7RuXRXVSq/mu9B2gThEQZEmVj0dF
 /8WcYQgzH0r5f3tyn1uhjrdkKubAWKmu3x5Bi3QY+lpZSERapSfJuWx5+7Dyyw3PKQVWtXEp+Fb
 KTic9F3Y0JqCBU+YnVoJNiSdrE9usDQFc6stFQvvduEaPAVi2dzQZYpT3bdyAiOV/9wNZ6jupNL
 qprUgCM2bzruw+E9KV3F8+4r9MSnZDjFnkZKQF91Gh6rBCeu0RCFvBBgiKmkPKnMl1eDhVf6jFP
 9qMtw2fveNfkC+mFjRzrb2aqL3gYT5zFs7JZ9Lss0uDe7Pap2cX5sWwl+tABIUnkea/OZcUW724
 1upAZpGb52oajTyW3PW0SE3gNtivj2JTTpYrOU=
X-Received: by 2002:a17:90a:e70f:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-3966d4587b7mr1891204a91.12.1787680730104; 
 Tue, 25 Aug 2026 10:58:50 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d69f74sm4291048a91.14.2026.08.25.10.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:58:49 -0700 (PDT)
Date: Wed, 26 Aug 2026 01:58:47 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
Subject: Re: [PATCH 11/23] target/riscv: Rewrite vext_ldff
Message-ID: <ao3JcPyrC7cZaCgp@sifive.com>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260815194549.1377505-12-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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

On 2026-08-15 12:45, Richard Henderson wrote:
> Do not call probe_pages for every active element.
> We can make do with no more than 2 such calls for
> the two pages the insn might reference.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> +    /*
> +     * Test whether the first page is accessible.
> +     * If the first element is active, it must succeed.
> +     */
> +    flags = probe_access_flags(env, adjust_addr(env, addr),
> +                               MIN(last, last_in_page) - addr + 1,
> +                               MMU_DATA_LOAD, mmu_index, !first_active,
> +                               &host, ra);
>  

Hi Richard,

This probe traverses every byte from the initial active element to the
end of the page, not just the bytes of active elements. In the masked
case, the range may encompass a masked-off element, and masked-off body
elements do not perform memory accesses.
I think it may causes unexpected vl.

> +    /* Get number of complete elements in the first page. */
> +    elems = MIN(page_split / msize, vl - i);
> +
> +    /* Load complete elements from the first page. */
> +    if (likely(elems)) {
> +        uint32_t page_evl = i + elems;
> +
> +        if (flags == 0) {
...
> +        } else {
> +            /*
> +             * If the first element is active, it must succeed.
> +             * This will load from MMIO or fault from INVALID.
> +             */
> +            if (first_active) {
> +                vext_ldst_nf_tlb(env, vd, addr, 0, nf, esz,
> +                                 max_elems, ldst_tlb, ra);
> +                i = 1;
> +                addr += msize;
> +            }
> +
> +            /* Stop if invalid (unmapped) or mmio (transaction may fail). */
> +            if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
> +                env->vl = i;
> +                goto tail;
> +            }
> +

For an example, assume
- vl = 3
- vstart = 0
- the mask be [1, 0, 1]
- assume element 0 and element 2 be readable, but deny the byte at element 1
- all three elements are in the same target page.

In theory, the element 1 is masked off and doesn’t perform any memory
access, so the value of vl remains 3.

But the previous probe covers element 1 to 2 and the flags will be non
zero due to the denied masked-off element 2. Then the vl will set to 1
here.

Maybe we could switch to per element prob when vm is 0 and flags is not 0?

rnax

> +            /* None of these ldst_tlb calls may fault. */
> +            if (vm) {
> +                vext_page_ldst_us_tlb(env, vd, addr, i, page_evl, nf,
> +                                      log2_esz, max_elems,
> +                                      ldst_tlb, mmu_index, ra);
> +            } else {
> +                do {
> +                    if (vext_elem_mask(v0, i)) {
> +                        vext_ldst_nf_tlb(env, vd, base + i * msize, i, nf,
> +                                         esz, max_elems, ldst_tlb, ra);
> +                    } else if (vma) {
> +                        vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
>                      }
> -                    remain -= offset;
> -                    addr_i = adjust_addr(env, addr_i + offset);
> -                }
> +                } while (++i < page_evl);
> +            }
> +        }
> +
> +        /* Usually the first page contains the entire vector. */
> +        if (likely(page_evl == vl)) {
> +            goto tail;
> +        }
> +        i = page_evl;
> +    }
> +
> +    /* Skip forward to the next active element. */
> +    if (!vm) {
> +        while (1) {
> +            if (vext_elem_mask(v0, i)) {
> +                break;
> +            }
> +            if (vma) {
> +                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
> +            }
> +            if (++i == vl) {
> +                goto tail;
>              }
>          }
>      }
> -ProbeSuccess:
> -    /* load bytes from guest memory */
> -    if (vl != 0) {
> -        env->vl = vl;
> +
> +    addr = base + i * msize;
> +    page_split = -(addr | TARGET_PAGE_MASK);
> +
> +    /* Validate the second page is accessible. */
> +    if (unlikely(page_split < msize)) {
> +        /*
> +         * Cross page element which isn't first.
> +         * We have not yet advanced addr to the next page.
> +         */
> +        target_ulong next_page = addr + page_split;
> +        flags |= probe_access_flags(env, adjust_addr(env, next_page),
> +                                    last - next_page + 1, MMU_DATA_LOAD,
> +                                    mmu_index, true, &host, ra);
> +
> +        /* Stop if invalid (unmapped) or mmio (transaction may fail). */
> +        if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
> +            env->vl = i;
> +            goto tail;
> +        }
> +
> +        vext_ldst_nf_tlb(env, vd, addr, i, nf, esz, max_elems, ldst_tlb, ra);
> +        if (++i == vl) {
> +            goto tail;
> +        }
> +        addr += msize;
> +        if (host) {
> +            host += addr - next_page;
> +        }
> +    } else {
> +        flags = probe_access_flags(env, adjust_addr(env, addr),
> +                                   last - addr + 1, MMU_DATA_LOAD,
> +                                   mmu_index, true, &host, ra);
> +
> +        /* Stop if invalid (unmapped) or mmio (transaction may fail). */
> +        if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
> +            env->vl = i;
> +            goto tail;
> +        }
>      }
>  
> -    if (env->vstart < env->vl) {
> +    /* Load complete elements from the second page. */
> +    if (flags == 0) {
>          if (vm) {
> -            /* Load/store elements in the first page */
> -            if (likely(elems)) {
> -                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
> -                                  log2_esz, true, mmu_index, ldst_tlb,
> -                                  ldst_host, ra);
> -            }
> -
> -            /* Load/store elements in the second page */
> -            if (unlikely(env->vstart < env->vl)) {
> -                addr = base + env->vstart * msize;
> -
> -                /* Cross page element */
> -                if (unlikely(page_split % msize)) {
> -                    vext_ldst_nf_tlb(env, vd, addr, env->vstart, nf,
> -                                     esz, max_elems, ldst_tlb, ra);
> -                    env->vstart++;
> -                    addr += msize;
> -                }
> -
> -                /* Get number of elements of second page */
> -                elems = env->vl - env->vstart;
> -
> -                /* Load/store elements in the second page */
> -                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
> -                                  log2_esz, true, mmu_index, ldst_tlb,
> -                                  ldst_host, ra);
> -            }
> +            vext_page_ldst_us_host(vd, host, i, vl, nf,
> +                                   log2_esz, max_elems, ldst_host);
>          } else {
> -            for (i = env->vstart; i < env->vl; i++) {
> +            host -= addr - base;
> +            do {
> +                if (vext_elem_mask(v0, i)) {
> +                    vext_ldst_nf_host(vd, host + i * msize, i, nf, esz,
> +                                      max_elems, ldst_host);
> +                } else if (vma) {
> +                    vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
> +                }
> +            } while (++i < vl);
> +        }
> +    } else {
> +        /* None of these ldst_tlb calls may fault. */
> +        if (vm) {
> +            vext_page_ldst_us_tlb(env, vd, addr, i, vl, nf,
> +                                  log2_esz, max_elems,
> +                                  ldst_tlb, mmu_index, ra);
> +        } else {
> +            do {
>                  if (vext_elem_mask(v0, i)) {
>                      vext_ldst_nf_tlb(env, vd, base + i * msize, i, nf,
>                                       esz, max_elems, ldst_tlb, ra);
>                  } else if (vma) {
>                      vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
>                  }
> -            }
> +            } while (++i < vl);
>          }
>      }
>  
> -- 
> 2.43.0
> 
> 

