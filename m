Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5F8C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 18:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyvvS-0004L4-Ff; Tue, 25 Aug 2026 14:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wyvvK-0004Kn-I5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 14:31:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wyvvI-0005YJ-NF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 14:31:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so113154b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787682659; x=1788287459; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zzcWJ2HD/hgVg+MMFGSGmV1kwoxiSIEDKm4fM8YeB/0=;
 b=eB6x44PcYoysU3Rw5F+8/qyjYd1cOdHCP7yA0ChTW5T9Nc9p6yLQwgwiGZxtevLF0v
 O8TrzxeJtV9aPyb/JDolw01DBWkmwGrxCmHzhDz5nCVz7KR6YYPdVOxL0nFuay5wd9Ye
 2KTog5CAc64tYiMKtXWiDZu9l5MTM5EZRlyNS93VFFphMK56m33MnCIBIU0JFKSz2ypU
 OEcI/NgGUS0dWA2OfRBk0KEw5EGh2vPVvjNX5GcPgWwn5QuUqz4B2gLHvRncw18uQOp5
 jRyAlm5eqpG1Qzon92Ct7VUTuvIZPJ5dYO7h1IdPBUPM3UDMe3kLIDgy6+hFmAZXDSyV
 +eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787682659; x=1788287459;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zzcWJ2HD/hgVg+MMFGSGmV1kwoxiSIEDKm4fM8YeB/0=;
 b=LaXwEDOE7y/YKBD8UrEF8SOiWnu3kaYUbgBoeF/VSL6D0K9FjT0bc2aRdKdZL/0oTW
 5sKIKI82cYD+EN8d7L77RTFeSC41E2K49AtAGIItSK+zAR25ATx6rBoDq/gAt5GW+whP
 Fz6F7hREDnj/aspglXjTTyYmdGW4Z6WcqE1KmUX66iMrBhWMk+MJE9fosd1wElSyWnQY
 UbFUi0XNOhrHygkMlJqHxsBjZqGZBHaACrb33c4OSL0ljBGs8zmvqjq/D3echNNjKgeQ
 KzWuNXTkZc6RfbRVzpYY437mZSSMDn3xEOcMLZHskaUBZCT7/15q6MvhfbtJqCRfdIYg
 AjpQ==
X-Gm-Message-State: AFuF++m8gzjcVtrr5s9g3OWDigsB53HQ/zkMsJGR1Wt0RIwR4br6SUMf
 H82rXdqfbKGUBBuDJi1WVco8TwSHTimJahHYtUbcwlT89c76wu0gVYkzm7A1LNM7piE=
X-Gm-Gg: AR+sD13Ka88G2zY5A3hhLecam76X4Rbz70uVfNt4k9nxYbXkNkezlWJo9Wo6o90t7fG
 VZoQJ4mWRtt3OXrQl88mHBl9gc/19WNXPP/PzAB+tS2M3sar2za+5HGmFEVxChHhD4ezi/35xgx
 smozRWe5QXIPWU19EKbkDU2OaDIXBmhhxy0/QtAT66x/CZ3QlkyHhu7VKfUQQNb9edMowgxS4tO
 kJj8ydtHbC8szLgYDVKkDhvbjYtznd4/U5vI/JQBOHgSkRqmvpozS6Qj2e1kfYoBHtBgSv3Lr7k
 jZtBLLrC2phr62hGoCEVxI1bxK2n49rA2ajpAsRFpRBlPjnPVono66QZ7Ospl0SRhCLj0NZo+Bu
 Ak/tY5kb3bihUAJo8ni7vxPQWNXnZ3ExAj74g/zCPcFwHgMq0hYUL9hrD9oxjcURp5fXEwXcrI5
 uDqHdTcHM2bkvYrkQXFbPJOfRudlIJ24LVeehq0Cdy74Wi1FqdqeO6EMjxEfw1Yv9BnFk5zJMW7
 DrKQOuqNrV2QwQTBbPbRA2jrW5eXztz3A==
X-Received: by 2002:a05:6a00:4ac7:b0:846:de21:3da4 with SMTP id
 d2e1a72fcca58-85371aacd42mr1442062b3a.3.1787682658806; 
 Tue, 25 Aug 2026 11:30:58 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535d7262d2sm160655b3a.61.2026.08.25.11.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 11:30:58 -0700 (PDT)
Date: Wed, 26 Aug 2026 02:30:55 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
Subject: Re: [PATCH 05/23] target/riscv: Add evl argument to
 vext_ldst_elem_fn_host
Message-ID: <ao3Yufx1A7yoMoDw@sifive.com>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815194549.1377505-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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
> This merges vext_continuous_ldst_host into the ldst_host function.
> We can then handle the byte little-endian optimization at compile-time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/tcg/vector_helper.c | 83 +++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 661f1ab2f6..3786a17231 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -214,7 +214,8 @@ static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
>  /* elements operations for load and store */
>  typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
>                                     uint32_t idx, void *vd, uintptr_t retaddr);
> -typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
> +typedef void vext_ldst_elem_fn_host(void *vd, void *host,
> +                                    uint32_t idx, uint32_t evl);
>  
>  #define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
>  static inline QEMU_ALWAYS_INLINE                            \
> @@ -226,12 +227,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>      *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
>  }                                                           \
>  
> -#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)        \
> -static inline QEMU_ALWAYS_INLINE                            \
> -void NAME##_host(void *vd, uint32_t idx, void *host)        \
> -{                                                           \
> -    ETYPE *cur = ((ETYPE *)vd + H(idx));                    \
> -    *cur = (ETYPE)LDSUF##_p(host);                          \
> +#define GEN_VEXT_HOST_LD_ELEM(NAME, ETYPE, H, LDSUF)                    \
> +static inline QEMU_ALWAYS_INLINE                                        \
> +void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
> +{                                                                       \
> +    do {                                                                \
> +        ETYPE *cur = (ETYPE *)vd + H(idx);                              \
> +        *cur = LDSUF##_p(host);                                         \
> +        host += sizeof(ETYPE);                                          \
> +    } while (++idx < evl);                                              \
>  }
>  
>  GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
> @@ -239,7 +243,16 @@ GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
>  GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
>  GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
>  
> +#if HOST_BIG_ENDIAN
>  GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> +#else
> +static inline QEMU_ALWAYS_INLINE
> +void lde_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
> +{
> +    memcpy(vd + idx, host, evl - idx);
> +}
> +#endif
> +
>  GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
>  GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
>  GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
> @@ -254,12 +267,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>      cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
>  }                                                           \
>  
> -#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)        \
> -static inline QEMU_ALWAYS_INLINE                            \
> -void NAME##_host(void *vd, uint32_t idx, void *host)        \
> -{                                                           \
> -    ETYPE data = *((ETYPE *)vd + H(idx));                   \
> -    STSUF##_p(host, data);                                  \
> +#define GEN_VEXT_HOST_ST_ELEM(NAME, ETYPE, H, STSUF)                    \
> +static inline QEMU_ALWAYS_INLINE                                        \
> +void NAME##_host(void *vd, void *host, uint32_t idx, uint32_t evl)      \
> +{                                                                       \
> +    do {                                                                \
> +        ETYPE data = *((ETYPE *)vd + H(idx));                           \
> +        STSUF##_p(host, data);                                          \
> +        host += sizeof(ETYPE);                                          \
> +    } while (++idx < evl);                                              \
>  }
>  
>  GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
> @@ -267,7 +283,16 @@ GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
>  GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
>  GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
>  
> +#if HOST_BIG_ENDIAN
>  GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
> +#else
> +static inline QEMU_ALWAYS_INLINE
> +void ste_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
> +{
> +    memcpy(host, vd + idx, evl - idx);
> +}
> +#endif
> +
>  GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
>  GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
>  GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
> @@ -284,33 +309,6 @@ vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>      }
>  }
>  
> -static inline QEMU_ALWAYS_INLINE void
> -vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
> -                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
> -                        uint32_t esz, bool is_load)
> -{
> -    if (HOST_BIG_ENDIAN) {
> -        for (; reg_start < evl; reg_start++, host += esz) {
> -            ldst_host(vd, reg_start, host);
> -        }
> -    } else {
> -        if (esz == 1) {
> -            uint32_t byte_offset = reg_start * esz;
> -            uint32_t size = (evl - reg_start) * esz;
> -
> -            if (is_load) {
> -                memcpy(vd + byte_offset, host, size);
> -            } else {
> -                memcpy(host, vd + byte_offset, size);
> -            }
> -        } else {
> -            for (; reg_start < evl; reg_start++, host += esz) {
> -                ldst_host(vd, reg_start, host);
> -            }
> -        }
> -    }
> -}
> -
>  static void vext_set_tail_elems_1s(uint32_t vl, void *vd, uint32_t nf,
>                                     uint32_t esz, uint32_t max_elems)
>  {
> @@ -334,7 +332,7 @@ static void vext_ldst_nf_host(void *vd, void *host, uint32_t i, uint32_t nf,
>                                vext_ldst_elem_fn_host *ldst_host)
>  {
>      for (uint32_t k = 0; k < nf; k++, host += esz) {
> -        ldst_host(vd, i + k * max_elems, host);
> +        ldst_host(vd + k * max_elems, host, i, i + 1);

The type of ldst_host vd parameter is void *, so vd + k * max_elems
advances in bytes, not the target element width.

I think here should be

> +        ldst_host(vd, host, i + k * max_elems, i + k * max_elems + 1);


rnax

