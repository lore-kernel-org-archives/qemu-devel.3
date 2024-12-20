Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC270E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfro-00008o-AL; Fri, 20 Dec 2024 11:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOfrm-00008P-Lm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:28:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOfrk-0001qP-N8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:28:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163dc5155fso20416355ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734712119; x=1735316919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=udENEynPBHDOzD5HmEf366V/0YdRrDGVZxSULZeESUo=;
 b=L8ODg2MaDWt5A/FXw7DZu+UntQrARHeA9IhFhKy+uop78FbKFKFBRjEIRrWCyJms1O
 ekYZDQtx5+8qr6rTpjujO4ZaOEQgW3Cv2PoojkME4g9Q4f8q7zBVkBJQTnrVzKQR2Z+/
 qsrSuNhyArXBlRgdSYYaGi0xGBGpSzjIpwMr02Tg8xdmyL+E/GYMoGPE0V8it9PgkTL8
 hh8GjBMCsbnP5t9TmklTn/CE66xA1E8vMR/ZFpEEghL8XN1YexlCfNzokRk2l0LO/VYG
 FCvylJOR0CvhO9mZEk5S7jm+23Ei2NxON0xPy0jOh7bare1VPcn6LTUiTLdhbp9VyqTn
 E+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734712119; x=1735316919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udENEynPBHDOzD5HmEf366V/0YdRrDGVZxSULZeESUo=;
 b=SwF668ZteWSmO9/RaMz2WPqj78wMiiurpuSuTzOhHELbs0ep2hEQAmOHmfkW+VPF9q
 RFu43+qUrDKFZmnRmZfF2yZpwcO0kHujZauuPHQS0qUPlPPwRQrY/N85NrR8Gi9611tU
 WFmrRHSQkgjX514BYkVK7Nejip8GvpCwzvfGErXcdnunPARcWS2QxLNnhpvpTw5fIQui
 czt1jGQx+7Pr6oqB/S5N8miTorhrK9ma1O6I2gYf05S4o4rY4niq8VE5yY40CFBFQelZ
 IVXHzzR0C91iKz9qVjtFVxJK6k29q9XvEV9JhHaajU1YiqMZpku5y6qLLGeZVD7bp2tG
 5+4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSc9kHcevEzcRsS0TsYWIHCJcq3aVVMTWD6Kusen1F0zqTmFYyzyAbTCiqTmuykjoJrdSCv13aPmo@nongnu.org
X-Gm-Message-State: AOJu0YzmGmVBFKR0vecA1CwJNumKctWIAEIYpQINUeerI4O286dsCBKh
 sdMMNJWqVlvhHv9edItaoiYg8P/6+aSswpwWQsm+J7lJiO+zUOX/S7Wr633HthrM5yfrXAwgeGL
 9
X-Gm-Gg: ASbGncsjTIWm/fZbQ+a1UvXdZ4hTWLd/yHKGFzsdsp0Aohag30UVoaxfXPpBnB4Qlgc
 M0QVVdiQKQzQzQs9zvlqXmTcictaxUc/gOLcHlNtz++FlM+/OLHjFmK5VO+cWCasN0LsMlwTiHT
 1cbZCd50equRNneCUU9ZBI4Q0ZbOnFIFbP++KP8RxsLYP/hTUifN533f0mob8KIFCykD054f/9a
 zPKXkiVbuEB0TeOg/kxe6Xbuq0++4L0zqPwPCHSF3xnjgE0SZd1B5NhKJfarRicIeKogs0=
X-Google-Smtp-Source: AGHT+IEmp/dHGHkXFCFWTK2lK8BGASIiUFVOS46Fs7OJC17y7DmEhJhKBpCxqt3Tkr39JyAZN9c81Q==
X-Received: by 2002:a17:902:c941:b0:215:4d90:4caf with SMTP id
 d9443c01a7336-219e6ea1bb5mr38796725ad.14.1734712119139; 
 Fri, 20 Dec 2024 08:28:39 -0800 (PST)
Received: from [192.168.0.4] ([71.212.144.252])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cdeccsm31051235ad.144.2024.12.20.08.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 08:28:38 -0800 (PST)
Message-ID: <ac1efe23-1920-45d1-97f1-3fd80d11039e@linaro.org>
Date: Fri, 20 Dec 2024 08:28:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20241220122109.2083215-1-craig.blackmore@embecosm.com>
 <20241220122109.2083215-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241220122109.2083215-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 12/20/24 04:21, Craig Blackmore wrote:
> Use atomic load/store functions to access multiple elements from host.
> 
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 107 +++++++++++++++++++++++++++++++++--
>   1 file changed, 101 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a85dd1d200..c0179165ce 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -206,10 +206,102 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
>       }
>   }
>   
> +#if !HOST_BIG_ENDIAN
> +/* Atomic operations for load/store */
> +
> +/*
> + * Return true if there are enough elements for this size access and the
> + * pointer is aligned to the required atomicity.
> + */
> +
> +static inline QEMU_ALWAYS_INLINE bool
> +ok_for_atomic(uint32_t size, void *host, uint32_t reg_start, uint32_t evl,
> +              uint32_t log2_esz)
> +{
> +    return (reg_start + (size >> log2_esz)) <= evl
> +            && ((uintptr_t) host % size) == 0;
> +}
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
> +#ifdef CONFIG_INT128_TYPE
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
> +#endif

Using CONFIG_INT128_TYPE is peeking under the hood a bit too far.
As it happens, the ifdef should not be required, because the atomic16_{read,set} symbols 
are always present.

> +#ifdef CONFIG_INT128_TYPE
> +    if (((is_load && HAVE_ATOMIC128_RO) || (!is_load && HAVE_ATOMIC128_RW))
> +        && ok_for_atomic(16, host, reg_start, evl, log2_esz)) {
> +        vext_ldst_atom_16_host(vd, byte_offset, host, is_load);
> +        return 16;
> +    }
> +#endif

The tricky part is that if !HAVE_ATOMIC128_RO, then atomic16_set may be implemented with a 
16-byte compare and store loop.  This is expensive, and you certainly don't want to use 
that.  You'd prefer two 8-byte stores.

So I think the condition should be

     if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW))

with the above paragraph added as a comment.

That said, RVV does not have 128-bit elements, so at no point do you actually require 
128-bit atomicity.

> +
> +#ifdef CONFIG_ATOMIC64
> +    if (ok_for_atomic(8, host, reg_start, evl, log2_esz)) {
> +        vext_ldst_atom_8_host(vd, byte_offset, host, is_load);
> +        return 8;
> +    }
> +#endif
> +
> +    if (ok_for_atomic(4, host, reg_start, evl, log2_esz)) {
> +        vext_ldst_atom_4_host(vd, byte_offset, host, is_load);
> +        return 4;
> +    }
> +
> +    if (ok_for_atomic(2, host, reg_start, evl, log2_esz)) {
> +        vext_ldst_atom_2_host(vd, byte_offset, host, is_load);
> +        return 2;
> +    }
> +#endif
> +
> +    ldst_host(vd, reg_start, host);
> +    return 1;
> +}
> +
>   static inline QEMU_ALWAYS_INLINE void
>   vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
>                           void *vd, uint32_t evl, uint32_t reg_start, void *host,
> -                        uint32_t esz, bool is_load)
> +                        uint32_t esz, bool is_load, uint32_t log2_esz)
>   {
>   #if HOST_BIG_ENDIAN
>       for (; reg_start < evl; reg_start++, host += esz) {
> @@ -225,10 +317,13 @@ vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
>           } else {
>               memcpy(host, vd + byte_offset, size);
>           }
> -    } else {
> -        for (; reg_start < evl; reg_start++, host += esz) {
> -            ldst_host(vd, reg_start, host);
> -        }
> +        return;
> +    }
> +    uint32_t chunk = 0;
> +    for (; reg_start < evl; reg_start += (chunk >> log2_esz),
> +                            host += chunk) {
> +        chunk = vext_ldst_atomic_chunk_host(env, ldst_host, vd, evl, reg_start,
> +                                            host, esz, is_load, log2_esz);
>       }

My guess is the arrangement of the loop is not great, in that ok_for_atomic is buried at 
the bottom of the call stack within this loop.

It would be better to test for alignment once, here at the outside.  If the alignment is 
below esz, then the individual elements are misaligned, at which point the architecture 
does not require *any* atomicity.  At which point, I believe you could use the memcpy path 
just above.

Perhaps something like

     uint32_t byte_offset = reg_start * esz;
     uint32_t size = (evl - reg_start) * esz;
     uint32_t test = (uintptr_t)host;

     if (esz == 1 || unlikely(test % esz != 0)) {
         if (is_load) {
             memcpy(vd + byte_offset, host, size);
         } else {
             memcpy(host, vd + byte_offset, size);
         }
         return;
     }

     /* Test that both alignment and size are multiples. */
     test |= size;
     if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW) && (test % 16 == 0) {
         do {
             vext_ldst_atom_16_host(vd, reg_offset, host, is_load);
             reg_offset += 16 >> log2_esz;
             host += 16;
         } while (reg_offset < evl);
         return;
     }
     if (esz < 8 && test % 8 == 0) {
         ...
     }
     ...
     for (; reg_start < evl; reg_start++, host += esz) {
         ldst_host(vd, reg_start, host);
     }


r~

