Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84278D1A63D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKZZ-0001sY-A1; Fri, 09 Jan 2026 17:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKYq-0001eN-Ut
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:02:32 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKYp-000877-1c
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:02:24 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c525de78ebaso1146189a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767996141; x=1768600941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNH1wx8Folj05gFSm4ZTA/PCXnzQp+Y1pEsYvG4DMxY=;
 b=jjOCjbNvLNNhQSHy6oUVyRmPDpemc3bELTMxtLnc+e3bk9QyQHUWNPUU5huO3pLK7p
 R9T7ZUGN3nVQF57XGqtmV9NQDgdUPhiJA4+WwcInQ8oHgDFpJN7zt+bHMeWpMBoFgXLf
 ej1wF2WDzLs8727Y20Ym+Bd1d5X9I8jgmeT5tU6o5ifBp3wMGlnmoxZTxlPyDVqTLrFz
 3Jiq82qVwtIJQHoJ8b6I8r2KInp+JkYqxeGQ1nqav13X18Xp5+xAkLQdxcuCk1fwZoip
 CBZqcrL8SNmtHavNkt3c5mnfnzEXBWHXBU59NE6r8YQmoA+XLTMv5SVJ//OGlzyKWBy+
 UDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767996141; x=1768600941;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNH1wx8Folj05gFSm4ZTA/PCXnzQp+Y1pEsYvG4DMxY=;
 b=PKzj+cp87xeFxDkhMGziucaHteXKvu6OLFu2LdLxspCxpR4ba0rwwuvEcXlMjM8IOc
 CmxqJTodFCI3a4sPdf1IdPEDe+sTq1QS709/QwN41bfHHlcSk0iAG8t5zR4zj1hfgOR/
 YJ/EbKp95TYYV+8heuo66Ugj4BJw3ZZtkoyXGIx2wKOBX2BDcu+xOCWTHKhFREZ8gNTj
 VkwyWA28m1KzzSQqXiWIZ1n0f0pUbduN12FnXLKyUpDx56cha5dBtQadzwjyZa18/7aN
 7WDA+fPn2xdgurA4poCr7BJbsSNt7kRqpPymKtGHEvFqp/bZJEsixoQFuWobjH/ve4h3
 WOAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi/GtrlaT/HxjV4I52+yRJdeJljKqPft1Vggy9JAW5d9wwBNt6CxYHwWnZ299Lpqf4bsMJPfCU4c19@nongnu.org
X-Gm-Message-State: AOJu0YwMYDc+AFJbKVOrK1GYOTBg9smTwrOsZYWNeM2Z8bnHFkWE3iPA
 ltMzxsgdUH/A05Wu2lXRTIxDUOy8RhgU2KFvxr2jPIbVsfLHe2BzDOR3xodDYoYn06M=
X-Gm-Gg: AY/fxX6/vbLqiKCWcV1rb0Uep8uv8ELH1HPrYPJOHgg24FY6ysZofEVOak/MGbPgauj
 e8B+9v8A0B9rDuIhpHzsd4uogqlEYIzrCfn227y8LpgR4VSFMBMUqL6z5mocp2UsozR90dNCvxX
 8GC4EyaQjx1ckggB/3SzmOeAAZ5rIjySOGSRfgrfOfn4bfEP2w8jj3TEowuNGraK+m5un0xum+e
 IfT1PrmnWKa38g7qOYoq6xk0YM2sxbH8Va1oS2nmWMj/Vhz7z3EZvAXN/iWRlpNMy2JKDp0MJpT
 5ESkTxoGW+ykIpG9hw1/V0fGdKOltgsAL0rGkMSLefL8mbQHqG1guKCsi+9WQszeZoW+yMUZdCT
 ByQE/dU/mDufeiNQHcH/S49ZLxz76EGfd5bcK7LsaVEPSitKLGbYZqZN1KnvrW+LcaZdFnhg3By
 lGrUoNpYcPDWU0PnT6WA6TWTIM8g==
X-Google-Smtp-Source: AGHT+IEsTsFnvHkSOHOnWPH0djY0A3zyz5rnEe9FDiAkGS/kFAqI33z2/004eGgxLZYz0mKwRskaUA==
X-Received: by 2002:a17:902:dad1:b0:295:99f0:6c66 with SMTP id
 d9443c01a7336-2a3ee47f311mr98681265ad.36.1767996140759; 
 Fri, 09 Jan 2026 14:02:20 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c5ceeasm112237995ad.45.2026.01.09.14.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:02:20 -0800 (PST)
Message-ID: <a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org>
Date: Sat, 10 Jan 2026 09:02:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
> headers. The goal here is to allow a compilation unit to set explicitely
> which variant of the arch it's targeting (32 vs 64 bits).
> 
> By default, we simple let it defined as TARGET_LONG_BITS, so existing
> code does not need to be changed, and we can progressively convert new
> files.
> 
> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
> some TARGET_AARCH64 defines). For other arch, this is a work that will
> have to be done before converting them.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
>   include/tcg/tcg-op-gvec.h         | 11 +++--------
>   include/tcg/tcg-op.h              | 22 +++++++---------------
>   3 files changed, 31 insertions(+), 23 deletions(-)
>   create mode 100644 include/tcg/tcg-op-address-bits.h
> 
> diff --git a/include/tcg/tcg-op-address-bits.h b/include/tcg/tcg-op-address-bits.h
> new file mode 100644
> index 00000000000..71e9de65280
> --- /dev/null
> +++ b/include/tcg/tcg-op-address-bits.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef TCG_OP_ADDRESS_BITS
> +#define TCG_OP_ADDRESS_BITS
> +
> +#ifdef COMPILING_PER_TARGET
> + #include "exec/target_long.h"
> + #ifndef TARGET_ADDRESS_BITS
> +  #define TARGET_ADDRESS_BITS TARGET_LONG_BITS
> + #endif
> +#else
> + #ifndef TARGET_ADDRESS_BITS
> +  #error TARGET_ADDRESS_BITS must be defined for current file
> + #endif
> +#endif /* COMPILING_PER_TARGET */
> +
> +#if TARGET_ADDRESS_BITS != 32 && TARGET_ADDRESS_BITS != 64
> + #error TARGET_ADDRESS_BITS must be 32 or 64
> +#endif
> +
> +#endif /* TCG_OP_ADDRESS_BITS */
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index b0a81ad4bf4..422a270b694 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -8,13 +8,10 @@
>   #ifndef TCG_TCG_OP_GVEC_H
>   #define TCG_TCG_OP_GVEC_H
>   
> +#include "tcg/tcg-op-address-bits.h"
>   #include "tcg/tcg-op-gvec-common.h"
>   
> -#ifndef TARGET_LONG_BITS
> -#error must include QEMU headers
> -#endif
> -
> -#if TARGET_LONG_BITS == 64
> +#if TARGET_ADDRESS_BITS == 64
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
>   #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
>   #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
> @@ -28,7 +25,7 @@
>   #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
>   #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
>   #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
> -#elif TARGET_LONG_BITS == 32
> +#elif TARGET_ADDRESS_BITS == 32
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
>   #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
>   #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
> @@ -42,8 +39,6 @@
>   #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
>   #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
>   #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
> -#else
> -# error
>   #endif

Not address related.  Not even close.


>   
>   #endif
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index bf76749d1c5..9e4e58a2d4b 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -8,20 +8,14 @@
>   #ifndef TCG_TCG_OP_H
>   #define TCG_TCG_OP_H
>   
> +#include "tcg/tcg-op-address-bits.h"
>   #include "tcg/tcg-op-common.h"
>   #include "tcg/insn-start-words.h"
> -#include "exec/target_long.h"
>   
> -#ifndef TARGET_LONG_BITS
> -#error must include QEMU headers
> -#endif
> -
> -#if TARGET_LONG_BITS == 32
> +#if TARGET_ADDRESS_BITS == 32
>   # define TCG_TYPE_TL  TCG_TYPE_I32
> -#elif TARGET_LONG_BITS == 64
> +#elif TARGET_ADDRESS_BITS == 64
>   # define TCG_TYPE_TL  TCG_TYPE_I64
> -#else
> -# error
>   #endif

Ok, there's been a fundamental misunderstanding about what we discussed.

There should be *no* changes to target_long, TCGv or TCG_TYPE_TL.

There should be a *new* file, include/tcg/tcg-op-mem.h which deals with TCGv_va, 
TCG_TYPE_VA, and all of the tcg_gen_qemu_{ld,st}* helpers based on that.

The only thing that should happen in tcg-op.h is:

#define TARGET_ADDRESS_BITS  TARGET_LONG_BITS
#include "tcg-op-mem.h"


r~

