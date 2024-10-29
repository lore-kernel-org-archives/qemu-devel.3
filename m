Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA4D3A68D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rZr-0003gY-Oz; Tue, 29 Oct 2024 15:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5rZa-0003eX-0A
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:08:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5rZV-0002YC-8w
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:08:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cbca51687so54420145ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730228883; x=1730833683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNClpbfpfcxjqc3xeqzo44A3JXjy3qDykQDcs4zdTS0=;
 b=CcsyzLJm05MUJj/PVzE8smpgcvuABPdDdmVPyVbjDe5mDP1Lm/aBvhRJ5vzEANW2Hc
 M+PnTD4y/Kv4OTQJyjAfGPVoZ6tFhIbi+69B4pSAj0ceaMfqF5rA5/BU/VlAqdR6vg44
 T6qti8/HaiYH7OfAeaQA3XMzh+M5fEJuFRh5L/pLGxbHPU7ZwOtEXycXk3v7hiXfoWbR
 rBrrcDLvKVqyqomEP3MKFWdYrfU5pG1Fz6EP1dRQZ00mcvtPGSNksqobJ2tuAojltRRp
 DWt4i32dsekToq4kYZeFRmta6WvI8q+mHAjUKvj8KuACAia//drCfLsaQyKG4ncv9dTA
 VJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730228883; x=1730833683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNClpbfpfcxjqc3xeqzo44A3JXjy3qDykQDcs4zdTS0=;
 b=NNQnHqPUy6/hC9P8CAPbEF6oqwGzw8c4mMQlUhOham8rOmujfyMPDDfu6hIDrlP89o
 IfjnxjGtGBj0cm+PwIx0Kf06W0yFJIe3nDugkXOuyPIK7Tv/+ZhCAVINNUyMRQ3CDWwu
 51rJIMK/yfN6ddj6/fZVqfO4G+N1u8sdEzwv8I3S4L53scb059Ydj/3MLLh9mdcGtz6J
 DGdkD1+0gPybqrFkzZw52nBN9+6cTkXn1snAXTFHxEUloUkheBqTBmEMIB0JoB/5iV/N
 mo7qFBrO7owecuLdHExsCDeOYpUTHuJHZ2dJvhj9+HP+IwIcU98QArWULqXYqeOSl0xz
 pL9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQsdvYDCqW7QiUFlGyXAd+ORwle/kaH0q5Opq+6cvQi3bbp88W5lRaUay3atYPmKV9anI3oSOn4zd4@nongnu.org
X-Gm-Message-State: AOJu0Yy4Tmb/V1UOn5DX9ldzisqx8L+/rQs2qvN0qrXL8jcaFqeC2KPt
 UFHVAOyCAEaNj3ymEgv7vsk7BULQoj/6iqvbcC4vADb5xqcje04R1yK5qD9tZVA=
X-Google-Smtp-Source: AGHT+IFCUQmNbZDullZ1RQ5ojsmCe39UpcoyWJPhjTdHwdvoQ+JC/oa5EL4SCXiGjONISklqHrgmdg==
X-Received: by 2002:a17:903:2312:b0:205:8407:6321 with SMTP id
 d9443c01a7336-210c6879f49mr164644625ad.9.1730228883275; 
 Tue, 29 Oct 2024 12:08:03 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc04bdb6sm69173875ad.255.2024.10.29.12.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 12:08:02 -0700 (PDT)
Message-ID: <c3ad4751-68bc-41df-9929-40629f8826ba@ventanamicro.com>
Date: Tue, 29 Oct 2024 16:07:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] target/riscv: rvv: Provide group continuous ld/st
 flow for unit-stride ld/st instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org, negge@google.com
References: <20240918171412.150107-1-max.chou@sifive.com>
 <20240918171412.150107-7-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240918171412.150107-7-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 9/18/24 2:14 PM, Max Chou wrote:
> The vector unmasked unit-stride and whole register load/store
> instructions will load/store continuous memory. If the endian of both
> the host and guest architecture are the same, then we can group the
> element load/store to load/store more data at a time.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 77 +++++++++++++++++++++++++++++-------
>   1 file changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 59009a940ff..654d5e111f3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -189,6 +189,45 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
>   GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
>   GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
>   
> +static inline QEMU_ALWAYS_INLINE void
> +vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
> +                       void *vd, uint32_t evl, target_ulong addr,
> +                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
> +                       bool is_load)
> +{
> +    uint32_t i;
> +    for (i = env->vstart; i < evl; env->vstart = ++i, addr += esz) {
> +        ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
> +    }
> +}
> +
> +static inline QEMU_ALWAYS_INLINE void
> +vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
> +                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
> +                        uint32_t esz, bool is_load)
> +{
> +#if HOST_BIG_ENDIAN
> +    for (; reg_start < evl; reg_start++, host += esz) {
> +        ldst_host(vd, reg_start, host);
> +    }
> +#else
> +    if (esz == 1) {
> +        uint32_t byte_offset = reg_start * esz;
> +        uint32_t size = (evl - reg_start) * esz;
> +
> +        if (is_load) {
> +            memcpy(vd + byte_offset, host, size);
> +        } else {
> +            memcpy(host, vd + byte_offset, size);
> +        }
> +    } else {
> +        for (; reg_start < evl; reg_start++, host += esz) {
> +            ldst_host(vd, reg_start, host);
> +        }
> +    }
> +#endif
> +}
> +
>   static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
>                                      uint32_t desc, uint32_t nf,
>                                      uint32_t esz, uint32_t max_elems)
> @@ -297,24 +336,34 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>                                  mmu_index, true, &host, ra);
>   
>       if (flags == 0) {
> -        for (i = env->vstart; i < evl; ++i) {
> -            k = 0;
> -            while (k < nf) {
> -                ldst_host(vd, i + k * max_elems, host);
> -                host += esz;
> -                k++;
> +        if (nf == 1) {
> +            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
> +                                    esz, is_load);
> +        } else {
> +            for (i = env->vstart; i < evl; ++i) {
> +                k = 0;
> +                while (k < nf) {
> +                    ldst_host(vd, i + k * max_elems, host);
> +                    host += esz;
> +                    k++;
> +                }
>               }
>           }
>           env->vstart += elems;
>       } else {
> -        /* load bytes from guest memory */
> -        for (i = env->vstart; i < evl; env->vstart = ++i) {
> -            k = 0;
> -            while (k < nf) {
> -                ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems, vd,
> -                         ra);
> -                addr += esz;
> -                k++;
> +        if (nf == 1) {
> +            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
> +                                   ra, esz, is_load);
> +        } else {
> +            /* load bytes from guest memory */
> +            for (i = env->vstart; i < evl; env->vstart = ++i) {
> +                k = 0;
> +                while (k < nf) {
> +                    ldst_tlb(env, adjust_addr(env, addr), i + k * max_elems,
> +                             vd, ra);
> +                    addr += esz;
> +                    k++;
> +                }
>               }
>           }
>       }

