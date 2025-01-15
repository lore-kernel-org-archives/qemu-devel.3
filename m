Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63406C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4yb-00026B-9Q; Wed, 15 Jan 2025 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY4yZ-000261-F7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:06:35 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY4yT-0003p4-Px
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:06:33 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb7f3b1342so3297784b6e.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736953588; x=1737558388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXZu+55vnbQ850EC85Qbq7saGi1ur3LUIKp5GTwdUiw=;
 b=AISYAERunrXIHW/ngtynpO9lS8JU375fRU+OBO9gEXeDJGSxnKBxqZsijrTAlB42rr
 FNmlxyP/BoCuaM2uBuix/Q6pK2xMW8+JLQhNtoOsjYanP4v8zBsUu5MWUyy5yC6P1gXj
 J5pK/bWqF7tJwfQhWLdzKI/Mgp2EMa/EXdnjutBRu3xWf9gnl4UuI5fWHhEigH5nxUqR
 lBM1Hq5P+BhjCdmOHdf9H9ObRmoC7Be2Nk+xoiNrdL/VGInMv4aTzZfWhiiPy0a7EpO4
 q6SG4iEQdnHJe8GAGOKGIVnU8TRBrSVKIEfHVjwv+Bbt2/AI6kxYKjxg1IioXJAJ0tBl
 sv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953588; x=1737558388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXZu+55vnbQ850EC85Qbq7saGi1ur3LUIKp5GTwdUiw=;
 b=tDheF3WqudWvGKW2z1fVE249g2EtnrDPD2/or+Haj06tNnk/Jd/lRV5U1AHeTczpRH
 PaUXnliVZI3mszmHFyJm/1xXMK6i70vfYPpHHwedNvyYucsBtuwrVUc6watHPKGsOnXy
 rJ0Xwbt7MFRtGUVXy38t9LWT7dBpuWch5gJ8pT94bQSpqjnmmVSQN7pMPOSp/Dvru1zq
 e6u2l0Uzb1bVpqcWfQ8wMBrwhdg5z9s297cNDa2cyhQpR1O0qLV8QO9ogSRKMgI0Qg9u
 4TZH7hZEs0Jvo3Z+HmHk1avsvv1JHmau2o3dkSee0AwM6ZLFTWTZZkdzo8X5mYoU42V1
 TRPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnb/PB56uQa34Snmdyj8HaOMYh3B6eE7FTPoXxb99oZXbDk44eDTn0cQwiUbG0wpX8RfreWYcne2q@nongnu.org
X-Gm-Message-State: AOJu0YxFwUzRHqHFMMxMfbOEWl3x6Ubir1g/0Xx9Dk6jY7E46VcTe7dY
 WvNnCm4jBGBboW8fObaeQd/LWRYYRAUMvW9/K+5t+OznZ/kh/3tle2LZ/UyOmyo=
X-Gm-Gg: ASbGncvmnImefHa81S9fKl2mi6cJBjSWrTiuOyzkEEyiVPZnO15adDA4YQjFKX+17ZY
 U/WcFiEqbgGhgYvFmQXl1iM9HzAPltakEI3fG7ihZQSjuivUcyEC9brdbKj6pLULIJtkqZnHhbL
 jniwp0Lkd0gEcxkVHJvaOlXocYx3NazE+wOW/hSvnp00WZEBd8ydHCBurOPnApnx91IYri8a9Sg
 MSse+JFK1/NBBSZMs0td7jj3aSzUfROLoKjbilt6jfEPzbpR6alAWfbX+SXAiyXJsNaCM8=
X-Google-Smtp-Source: AGHT+IE0hfrblRAl65oyvm60AiPo3RQiO+IKgoU/lRf3QwOFN9d/JK7To2E5+ySpYoiN1EEiPf2Dgw==
X-Received: by 2002:a05:6808:301f:b0:3eb:71d7:246b with SMTP id
 5614622812f47-3ef2eddfb0cmr21067224b6e.39.1736953586965; 
 Wed, 15 Jan 2025 07:06:26 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f95b0c780esm659719eaf.39.2025.01.15.07.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 07:06:26 -0800 (PST)
Message-ID: <36017420-8ed5-4e17-a7c2-0fc7e27a0f43@ventanamicro.com>
Date: Wed, 15 Jan 2025 12:06:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <20250109160122.129409-1-craig.blackmore@embecosm.com>
 <20250109160122.129409-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250109160122.129409-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22f.google.com
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



On 1/9/25 1:01 PM, Craig Blackmore wrote:
> Use atomic load/store functions to access multiple elements from host.
> 
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 95 +++++++++++++++++++++++++++++++++---
>   1 file changed, 87 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a85dd1d200..f9228270b1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -206,29 +206,108 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>       }
>   }
>   
> +#if !HOST_BIG_ENDIAN
> +/* Atomic operations for load/store */
> +
> +#define GEN_VEXT_LDST_ATOMIC_HOST(SIZE, TYPE)                             \
> +static inline QEMU_ALWAYS_INLINE void                                     \
> +vext_ldst_atom_##SIZE##_host(void *vd, uint32_t byte_offset, TYPE *host,  \
> +                             bool is_load)                                \
> +{                                                                         \
> +    TYPE *vd_ptr = (TYPE *) (vd + byte_offset);                           \
> +    if (is_load) {                                                        \
> +        *vd_ptr = qatomic_read__nocheck(host);                            \
> +    } else {                                                              \
> +        qatomic_set__nocheck(host, *vd_ptr);                              \
> +    }                                                                     \
> +}                                                                         \
> +
> +GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t)
> +GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t)
> +#ifdef CONFIG_ATOMIC64
> +GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t)
> +#endif
> +
> +static inline QEMU_ALWAYS_INLINE void
> +vext_ldst_atom_16_host(void *vd, uint32_t byte_offset, Int128 *host,
> +                       bool is_load)
> +{
> +    Int128 *vd_ptr = (Int128 *) (vd + byte_offset);
> +    if (is_load) {
> +        *vd_ptr = atomic16_read_ro(host);
> +    } else {
> +        atomic16_set(host, *vd_ptr);
> +    }
> +}
> +#endif
> +
>   static inline QEMU_ALWAYS_INLINE void
>   vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
>                           void *vd, uint32_t evl, uint32_t reg_start, void *host,
> -                        uint32_t esz, bool is_load)
> +                        uint32_t esz, bool is_load, uint32_t log2_esz)
>   {
>   #if HOST_BIG_ENDIAN
>       for (; reg_start < evl; reg_start++, host += esz) {
>           ldst_host(vd, reg_start, host);
>       }
>   #else
> -    if (esz == 1) {
> -        uint32_t byte_offset = reg_start * esz;
> -        uint32_t size = (evl - reg_start) * esz;
> +    uint32_t size = (evl - reg_start) * esz;
> +    uint32_t test = (uintptr_t) host;
>   
> +    /* Misaligned load/stores do not require any atomicity */
> +    if (esz == 1 || unlikely(test % esz != 0)) {
> +        uint32_t byte_offset = reg_start * esz;
>           if (is_load) {
>               memcpy(vd + byte_offset, host, size);
>           } else {
>               memcpy(host, vd + byte_offset, size);
>           }
> -    } else {
> -        for (; reg_start < evl; reg_start++, host += esz) {
> -            ldst_host(vd, reg_start, host);
> +        return;
> +    }
> +
> +    /*
> +     * At this point esz > 1 and host is aligned to at least esz, so the ldst
> +     * can be completed in atomic chunks of at least esz if the atomic operation
> +     * is available.
> +     */
> +
> +    /* Test that both alignment and size are multiples of the atomic width. */
> +    test |= size;
> +
> +    /*
> +     * If !HAVE_ATOMIC128_RO, then atomic16_set may be implemented with a
> +     * 16-byte compare and store loop, which is expensive, so prefer two 8-byte
> +     * stores in this case.
> +     */
> +    if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW)
> +        && (test % 16 == 0)) {
> +        for (; reg_start < evl; reg_start += 16 >> log2_esz, host += 16) {
> +            vext_ldst_atom_16_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
> +    }
> +#ifdef CONFIG_ATOMIC64
> +    if (test % 8 == 0) {
> +        for (; reg_start < evl; reg_start += 8 >> log2_esz, host += 8) {
> +            vext_ldst_atom_8_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
> +    }
> +#endif
> +    if (test % 4 == 0) {
> +        for (; reg_start < evl; reg_start += 4 >> log2_esz, host += 4) {
> +            vext_ldst_atom_4_host(vd, reg_start * esz, host, is_load);
> +        }
> +        return;
> +    }
> +    if (test % 2 == 0) {
> +        for (; reg_start < evl; reg_start += 2 >> log2_esz, host += 2) {
> +            vext_ldst_atom_2_host(vd, reg_start * esz, host, is_load);
>           }
> +        return;
> +    }
> +    for (; reg_start < evl; reg_start++, host += esz) {
> +        ldst_host(vd, reg_start, host);
>       }
>   #endif
>   }
> @@ -343,7 +422,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
>       if (flags == 0) {
>           if (nf == 1) {
>               vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
> -                                    esz, is_load);
> +                                    esz, is_load, log2_esz);
>           } else {
>               for (i = env->vstart; i < evl; ++i) {
>                   k = 0;


