Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA3FF433CC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDAR8-0003lx-Rv; Wed, 15 Apr 2026 20:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAR4-0003lV-Ni
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:18:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDAR2-0003l9-5g
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:18:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so33781935ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298698; x=1776903498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jh6ngV3LCF5wyCqtiiXdFMjAbQJ7fwH1cCJ9pGcKZgw=;
 b=CxH7fPS1d+f742ZdH9l/Ceolj4NimPDpJpK8VLu8d7cvaFXPKhHIVeb9h1qc4RP+rv
 igvzG7B6m62SnHYMkVnemXRc2Ivq19OMPx4jA8q1mhBq49p+YMKqktE6QqZbI/hdjrPu
 M27Aik5lvHy91bjCUJRxO6D3SV5VnCFrgg2/yRwQt27P5354nR6iqOact69LXFj7d+sl
 VgXNlOf3o2TqKNEmSaGNquyQbGJ62n/239wHYv1DgC1rdN18dgjAUdancgw6AyMq5/Fv
 a2U59Gi3AeLsWcO/KOTydODxBpTxluwIe+SkrXkxvzV0KIHgfAs0FkfdvUNT+WmBlR31
 PE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298698; x=1776903498;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jh6ngV3LCF5wyCqtiiXdFMjAbQJ7fwH1cCJ9pGcKZgw=;
 b=FQwZlLz9CAMqxdOxZl8dGLdF9oNZ9Wu7UMsOBHoG63cFMYgPMhH8qwOYjBabt+9BwS
 No+FbO+n7vgHhwfndc8ejf9z8+aC+nwZYCnOqd4R8XtNmYLaNRcRFp6hKtjekVDXuSxh
 zP5fxmY8wgy31wWS7vnKogS7+lSy5M/c29ddA7sE0B/bQJBnT0nm5aUA4kdJG2wT6dwR
 5oJliZ7HdKTDRD6TNiWHP9VmaNkPgHqdwGLCz0DZUwaNz5rnP++O8Wnmgfmay6sc0u2c
 I2xJwKVicxgECfeNr/qXGdViCKFqtx/WYxF/e0gMU5o30Kj9SLVqwrUyQekoOXxbAVde
 vfpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QNPrEwlOyKfp9IyvEb4TnXi0H5RMcyOzDSNjaMcGThDjc2sVKk62wPtd6EMi0yA1qtOMkS2cfPxKx@nongnu.org
X-Gm-Message-State: AOJu0YwqdctYOZJOsI335tN9uNtfB/hMuVIfrkzAnV1Udes7hgv+u0Pp
 L91MC8kXUE7uOWTTrrGIfoIPNxQHDxZELQNYCPLrJ4rtMoL68SLPqYkaSocJ9KMR+mo=
X-Gm-Gg: AeBDiesTrckY7vwGCQlu+r2szGOuttk+3PlzfLNPWlq0HhNZf+E+VE9gZXLmxRozQFr
 6mWGdQU78Hh6Eutl8ywE4NsenT84ANXOr3rQjHEB/GaAxL3ZDbzz8yBOgwtrDQAWL8F32EYP+Zy
 6TPB80o8Wm8eoOH+gat7R3Q6pCkcUmNhVxQu3W/gduHKkdRGCkgXX3yBzoFsLRJ2oi2FlQr1GOy
 CM8iHJq+TZGExf0SFmFeWu0kUhu7tN9ENKUvIDccDx8gcPJ9LQFMYWVPyaWuD2cWlzt/b3JsOsB
 MVz7CfsG7GGg1ahbnNUNGGSTXxe1aEUNkaQlHn8O9BTugmHjv+Di2abnTH8yIJOEFTV6qE7UBRq
 4HG+tsFPMI9YONlwVYLMge2hgQOrJcFrPgJ1A8pciYSsLibAGUC7lCXa+NPxtPviEQmSnes1W0m
 OtFxm6ckVdG/2HhOBagsZBxAVGQmbPpgK3W4daOAiZTc5d7OHrXuFvgHUBBTUI9b7U+aaniXnlm
 ZHBdoVSfHHO/WlphbRquXsQymC5Hdw+KGJd8X93YyeEBtEfq55uB/QAeCPCxHCNHQ==
X-Received: by 2002:a17:902:8e84:b0:2b2:98d7:bff with SMTP id
 d9443c01a7336-2b2d5aad43cmr169496865ad.45.1776298698083; 
 Wed, 15 Apr 2026 17:18:18 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 (bg30dhzr9yyk68wp6s9g.ip6.superloop.au.
 [2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780efa9fsm32356155ad.12.2026.04.15.17.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:18:17 -0700 (PDT)
Message-ID: <f72593b2-0c82-4f90-804d-b03105b00815@linaro.org>
Date: Thu, 16 Apr 2026 10:18:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 5/6] target/mips: Convert MSA LD/ST.D (Doubleword
 Vector)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415202027.83008-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
> Replace runtime helpers by translation.
> 
> Replace the legacy cpu_ld/st*_data_ra() calls by tcg_gen_qemu_ld/st()
> which allow to respect atomicity.
> 
> Remove the ensure_writable_pages() hack and MSALDST_PROTO macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/msa_helper.h.inc |  6 ----
>   target/mips/tcg/msa_helper.c     | 53 --------------------------------
>   target/mips/tcg/msa_translate.c  | 18 +----------
>   3 files changed, 1 insertion(+), 76 deletions(-)
> 
> diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
> index f0d31ceef29..e994353056f 100644
> --- a/target/mips/tcg/msa_helper.h.inc
> +++ b/target/mips/tcg/msa_helper.h.inc
> @@ -432,9 +432,3 @@ DEF_HELPER_4(msa_ftint_s_df, void, env, i32, i32, i32)
>   DEF_HELPER_4(msa_ftint_u_df, void, env, i32, i32, i32)
>   DEF_HELPER_4(msa_ffint_s_df, void, env, i32, i32, i32)
>   DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
> -
> -#define MSALDST_PROTO(type)                         \
> -DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
> -DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
> -MSALDST_PROTO(d)
> -#undef MSALDST_PROTO
> diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
> index c93c0cddebc..67ec19ea95c 100644
> --- a/target/mips/tcg/msa_helper.c
> +++ b/target/mips/tcg/msa_helper.c
> @@ -21,11 +21,8 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "tcg/tcg.h"
> -#include "accel/tcg/cpu-ldst.h"
> -#include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
>   #include "exec/memop.h"
> -#include "exec/target_page.h"
>   #include "fpu/softfloat.h"
>   #include "fpu_helper.h"
>   
> @@ -8205,53 +8202,3 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
>   
>       msa_move_v(pwd, pwx);
>   }
> -
> -/* Data format min and max values */
> -#define DF_BITS(df) (1 << ((df) + 3))
> -
> -/* Element-by-element access macros */
> -#define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
> -
> -void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
> -                     target_ulong addr)
> -{
> -    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> -    uintptr_t ra = GETPC();
> -    uint64_t d0, d1;
> -
> -    d0 = cpu_ldq_data_ra(env, addr + 0, ra);
> -    d1 = cpu_ldq_data_ra(env, addr + 8, ra);
> -    pwd->d[0] = d0;
> -    pwd->d[1] = d1;
> -}
> -
> -#define MSA_PAGESPAN(x) \
> -        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
> -
> -static inline void ensure_writable_pages(CPUMIPSState *env,
> -                                         target_ulong addr,
> -                                         int mmu_idx,
> -                                         uintptr_t retaddr)
> -{
> -    /* FIXME: Probe the actual accesses (pass and use a size) */
> -    if (unlikely(MSA_PAGESPAN(addr))) {
> -        /* first page */
> -        probe_write(env, addr, 0, mmu_idx, retaddr);
> -        /* second page */
> -        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -        probe_write(env, addr, 0, mmu_idx, retaddr);
> -    }
> -}
> -
> -void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
> -                     target_ulong addr)
> -{
> -    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> -    int mmu_idx = mips_env_mmu_index(env);
> -    uintptr_t ra = GETPC();
> -
> -    ensure_writable_pages(env, addr, mmu_idx, GETPC());
> -
> -    cpu_stq_data_ra(env, addr + 0, pwd->d[0], ra);
> -    cpu_stq_data_ra(env, addr + 8, pwd->d[1], ra);
> -}

This isn't using a LE operation...

> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 8486508f5ba..b1d764bd179 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -785,8 +785,8 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>           MO_ATOM_NONE,
>           MO_ATOM_SUBALIGN, /* Slightly stronger than required */
>           MO_ATOM_SUBALIGN, /* Slightly stronger than required */
> +        MO_ATOM_IFALIGN_PAIR
>       };
> -    TCGv_i32 wd;
>       TCGv_i128 t16;
>       TCGv_va addr;
>       MemOp mop;
> @@ -801,22 +801,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
>       addr = tcgv_va_temp_new();
>       gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
>   
> -    wd = tcg_constant_i32(a->wd);
> -
> -    if (is_load) {
> -        switch (a->df) {
> -        case 3:
> -            gen_helper_msa_ld_d(tcg_env, wd, addr);
> -            return true;
> -        }
> -    } else {
> -        switch (a->df) {
> -        case 3:
> -            gen_helper_msa_st_d(tcg_env, wd, addr);
> -            return true;
> -        }
> -    }
> -
>       t16 = tcg_temp_new_i128();
>   
>       mop = MO_128 | MO_LE;

... which you're now getting from here.

You could bswap d0 and d1, or you could have the 64-bit path reorder d0 and d1 in t16 and 
mop ^= MO_BSWAP.


r~


