Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C209C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvdCf-0003Of-GI; Sun, 16 Aug 2026 11:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvdCY-0003O1-ST
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:55:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvdCU-0000hM-Sw
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:55:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso23386075ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786895705; x=1787500505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QM31yW9Pa+MOhK4T2zWe0zu624wcO9Fk+aZu+h243QY=;
 b=CCifnnabgAwhWuJ0c0/pYXJDmh+AtHOQeWVtOaDXALCTlf3120iUcIxUOJsO/O2Ypu
 dHxGijyKBLf+iAq04oN+MXv/1LjFOCo5AT4oA4HccC99KGWb7eWTTpgOl0+uPBjp1rUn
 Hys5PiSEunEzognogOM0ttDGI4NESG/E5vkdBumT+5VL4JZy6u9bqE4aFZBCCspXuwSL
 m9g12e5rGoChlf3uR4/i6B4Jhfm/spdaegDJnd6kBRIYFv2iB/4Yn+NkArpDgnEwafwu
 RGhvYWclxBll+7wmyggeACr/2FI0p19RlUWBe0pSsMefbTUTZuojUZxbTz2Zze0LL1v/
 NyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786895705; x=1787500505;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QM31yW9Pa+MOhK4T2zWe0zu624wcO9Fk+aZu+h243QY=;
 b=Ybb7ejv1sIv8I1p/SgwiN+dfYia0qSFPKyaavcX65RjAjq6FtToWMzDKAfCStHX3BA
 G1/pe8FwexR2Zvs2iRdenmReIATddu5bRwk+sIHLpSMzzOdGCJJ9qjl8aWhUmaXux77C
 uGJL/iqugQI9/X4UNXTGfOT+8vYW6rutfgY7K9v7ec2m2/ibAJk9D2gAa5HhOOnzv+p+
 mlykllBU52I7idMU0ieXZckW4ajtRnnokuDJFJCa0t79SR/AflVgTtiYT1oZHuKWI+12
 HBtwYMzx+1kjGoCtZnMtFRVCULSysyQA5cqa6NP9K+EZLelllsYgAiHBbdIusdJR0gbt
 Cwjg==
X-Gm-Message-State: AOJu0Yw/06OauYqPHJirxGgcaQoUwIGOWn6pH7WtHLun3IZBR/012MHv
 GuhkmXfAUWyYODFudIwbKb6nPN9Al+XeVFDH4BOxxvmmLpa+KhNR6URgsWMGM/Z6tbxr1DcjLWM
 b1BV5
X-Gm-Gg: AR+sD125IWGXS4N8XsUuofoi44FASuQd+YG2Pxwsb3osbCemK2FOX3ns044DBhz3YKp
 l/gJU1JSwv8vlbfQr0XtgAFDfLlsKekprugD0NWerRNtbhn4vJlyO2D7uXKPdW7aT0zlY6onfGd
 Siu8AuASON76eJ2FDgJetWuN4asXBpueJYgL7cioYqDLt4vbucbWfm43LVi5U7cco3g3zxlVk1x
 Ku38kYUYiWRfzGLbmx9SERtg8TUFfUNcecy7dv2oFLfTlN3iXa5NYXu0sXEZwvscGzq8soe5R67
 RHtzbYVDqdK7+E5RU9R24zO9SopSTJVSh6IekBGRvd9advXzTXK4kld6wIld4gf+uJ8bVcXKcnW
 tpyu1EM68yEtdG/BVHNisQT+HweoDTpFRrqE/xe+XjhJs9WFwojTEihOoDy4oYHywuBbnKaV8Uv
 hzlPjQBorIRv0lhN6zO6a5SGyqk+mguRO7sVAyscTc8ur1sQr1gjQotXQQ1BukDrPEwsMaZy43S
 a6gIpHMDmbD1ceLq4d/LCyzK/Mj
X-Received: by 2002:a17:90a:e7c8:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-3933bd2066dmr18670798a91.21.1786895704984; 
 Sun, 16 Aug 2026 08:55:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e84118sm1983890a91.5.2026.08.16.08.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 08:55:04 -0700 (PDT)
Message-ID: <a7747708-b25c-4027-8960-5a36cef25a8b@linaro.org>
Date: Sun, 16 Aug 2026 08:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] target/riscv: Add evl argument to
 vext_ldst_elem_fn_host
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com, max.chou@sifive.com, qemu-riscv@nongnu.org
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-6-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260815194549.1377505-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/15/26 12:45, Richard Henderson wrote:
> This merges vext_continuous_ldst_host into the ldst_host function.
> We can then handle the byte little-endian optimization at compile-time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/vector_helper.c | 83 +++++++++++++++-----------------
>   1 file changed, 40 insertions(+), 43 deletions(-)

In retrospect, this probably isn't a great idea.  The load side is fine, but the store 
side suffers from atomicity issues.  I'll think of something else.


r~


> 
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 661f1ab2f6..3786a17231 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -214,7 +214,8 @@ static inline MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
>   /* elements operations for load and store */
>   typedef void vext_ldst_elem_fn_tlb(CPURISCVState *env, abi_ptr addr,
>                                      uint32_t idx, void *vd, uintptr_t retaddr);
> -typedef void vext_ldst_elem_fn_host(void *vd, uint32_t idx, void *host);
> +typedef void vext_ldst_elem_fn_host(void *vd, void *host,
> +                                    uint32_t idx, uint32_t evl);
>   
>   #define GEN_VEXT_TLB_LD_ELEM(NAME, ETYPE, H, LDSUF)         \
>   static inline QEMU_ALWAYS_INLINE                            \
> @@ -226,12 +227,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>       *cur = cpu_##LDSUF##_mmu(env, addr, oi, retaddr);       \
>   }                                                           \
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
>   }
>   
>   GEN_VEXT_TLB_LD_ELEM(lde_b, uint8_t,  H1, ldb)
> @@ -239,7 +243,16 @@ GEN_VEXT_TLB_LD_ELEM(lde_h, uint16_t, H2, ldw)
>   GEN_VEXT_TLB_LD_ELEM(lde_w, uint32_t, H4, ldl)
>   GEN_VEXT_TLB_LD_ELEM(lde_d, uint64_t, H8, ldq)
>   
> +#if HOST_BIG_ENDIAN
>   GEN_VEXT_HOST_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> +#else
> +static inline QEMU_ALWAYS_INLINE
> +void lde_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
> +{
> +    memcpy(vd + idx, host, evl - idx);
> +}
> +#endif
> +
>   GEN_VEXT_HOST_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
>   GEN_VEXT_HOST_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
>   GEN_VEXT_HOST_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
> @@ -254,12 +267,15 @@ void NAME##_tlb(CPURISCVState *env, abi_ptr addr,           \
>       cpu_##STSUF##_mmu(env, addr, data, oi, retaddr);        \
>   }                                                           \
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
>   }
>   
>   GEN_VEXT_TLB_ST_ELEM(ste_b, uint8_t,  H1, stb)
> @@ -267,7 +283,16 @@ GEN_VEXT_TLB_ST_ELEM(ste_h, uint16_t, H2, stw)
>   GEN_VEXT_TLB_ST_ELEM(ste_w, uint32_t, H4, stl)
>   GEN_VEXT_TLB_ST_ELEM(ste_d, uint64_t, H8, stq)
>   
> +#if HOST_BIG_ENDIAN
>   GEN_VEXT_HOST_ST_ELEM(ste_b, uint8_t,  H1, stb)
> +#else
> +static inline QEMU_ALWAYS_INLINE
> +void ste_b_host(void *vd, void *host, uint32_t idx, uint32_t evl)
> +{
> +    memcpy(host, vd + idx, evl - idx);
> +}
> +#endif
> +
>   GEN_VEXT_HOST_ST_ELEM(ste_h, uint16_t, H2, stw_le)
>   GEN_VEXT_HOST_ST_ELEM(ste_w, uint32_t, H4, stl_le)
>   GEN_VEXT_HOST_ST_ELEM(ste_d, uint64_t, H8, stq_le)
> @@ -284,33 +309,6 @@ vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>       }
>   }
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
>   static void vext_set_tail_elems_1s(uint32_t vl, void *vd, uint32_t nf,
>                                      uint32_t esz, uint32_t max_elems)
>   {
> @@ -334,7 +332,7 @@ static void vext_ldst_nf_host(void *vd, void *host, uint32_t i, uint32_t nf,
>                                 vext_ldst_elem_fn_host *ldst_host)
>   {
>       for (uint32_t k = 0; k < nf; k++, host += esz) {
> -        ldst_host(vd, i + k * max_elems, host);
> +        ldst_host(vd + k * max_elems, host, i, i + 1);
>       }
>   }
>   
> @@ -450,8 +448,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>        */
>       if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
>           if (nf == 1) {
> -            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
> -                                      host, esz, is_load);
> +            ldst_host(vd, host, env->vstart, evl);
>           } else {
>               for (uint32_t i = env->vstart; i < evl; ++i) {
>                   vext_ldst_nf_host(vd, host, i, nf, esz, max_elems, ldst_host);


