Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7EBFB5164
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9roG-0001fw-79; Mon, 06 Apr 2026 17:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9roE-0001fY-Rk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:48:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9roC-0002MD-V5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:48:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82cd6614a90so1899133b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775512115; x=1776116915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fiu0Y/Aqj4Qp1ZQrF81Jat6D8Q8E19fo4fPv8rxFOYY=;
 b=BURbdRA5dpFOLjuxVUKqv9gbg1eLrDcbU/vPlX/ZTdZISIYhsGMXqTMNcncBPQKD9i
 EwiS9kp4ZulEAnG5mb1zDNfy1zatGhhFA8BJpJNXfeInbGy2XWW1MeqCRh/zoXbfIXAX
 OqDXAcv7VJC9yYFt1co5K1IwOsfG44yF9i8rm689DwX1YxgvUNae8cCIQBrxmfCm2k1R
 2nwT8ouccQdMwaMolOUoAC+pj7zXX/wTtM1jThl51xvo0bn6vq/QYVDFzFtgcOiAubUm
 pUJIWwCZsEn2bgbH5XDreAuGkwKoiWUr4chpLa5LnQEz3Z7Qzldxuc2fEUdRVj7gkBIz
 g0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775512115; x=1776116915;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fiu0Y/Aqj4Qp1ZQrF81Jat6D8Q8E19fo4fPv8rxFOYY=;
 b=o21daXyH80tgYhCn8PD9C8GU8g8Sy54sk3+rTadLlhO7yeMo63TBKm8vgpO6cAr5tO
 vhvxuyuCm8WPG9u6+6wN/ZUKETIyojQ4wV0ua4YQgqeoLFEdlVK5P46VElVIj5D4bVOd
 ZAwxYjm+8CJQEmDCMNzu59hwPNP7TF9dA73VrYA7vwNbPcVD8dmXBUV3bFRSULTEK/IX
 caemy1ZYZQaYcS/4VULZaHuD2i3p+z4vGQvSk8MDlIW5LyrXoQkbjR4oFnskzY++tLz0
 bgMecVM1f1VNNPGq3Zf3YGsCZghVQMsCftsX5jHXgcK8de8gesXgVeiWwuvBLt1Ea3d4
 M3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBMURiv9MbRg9yW0j+hGW5dn3D6b77wv3o3KiifjbY+B7VIwhHklIz6VR4ZicI/T9/lmUg2MrAwvCF@nongnu.org
X-Gm-Message-State: AOJu0YzHxZW36RHF8QAMkDmiPh599Q7pJsQlpynGi6J/RbUOmp4qwKl4
 DWp8/ebBKuz357XPvNyfdh9vOFl6VyV0+NwSEmX0dKjpwA0bYK6AWKsaknQgpu4GkyA=
X-Gm-Gg: AeBDietXW69ZZQzGa/do2hSIbD+QzcnPSEx1rJqAKiarazVsuG5Ry2ll1gDcABMKt4E
 i+RrpWtAaN8++A6DVnKrZlq7Q8xumgs/isvZz9YwLfCc3YWLRTS1TydbyKV1rwzj6aCj6v3RX72
 U2xSWWEdF+1DksA6D3D24x5qafvzznq6mEjKwqhf9YriwtQMA79j/xTHczBuVi5zdOQqaFf8yEU
 EOe4PJ/SSpXFdZ+jt5cW/7M16T+xLmXR0OEQThdl3azLAqXOaTWgUrfF8XjnDq2GcgGi4WbiN+U
 hz2KLwZup15MLkdSGGt2ZYL/hJ2FEGc8nUJ3eVBr9RdUqHGWbDiIUT03h6AYs7TK2VtYZhUjUTj
 9ArUzYaleGH8ihjOlHjGDy8DYW10D99Ioq2WzswQvcq4+ngxURyBqgdr5JnY0ArplQ57qixodxQ
 xwXpjHHtpaotIEbTlXAjyF8bO5vkyySN1wkQUiF+wc6difpI/ZC7hmQlTatvCSq64Vd7tAMQd+s
 CvFOA==
X-Received: by 2002:a05:6a20:3ca7:b0:39f:706d:62e3 with SMTP id
 adf61e73a8af0-39f706d674cmr5898566637.54.1775512115179; 
 Mon, 06 Apr 2026 14:48:35 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491157sm12152782a12.9.2026.04.06.14.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 14:48:34 -0700 (PDT)
Message-ID: <e57ff765-d7b7-467f-b218-05509d6ce70b@linaro.org>
Date: Tue, 7 Apr 2026 07:48:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/20] target/arm/tcg/arm_ldst.h: merge in translate.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-17-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> Only translate.c uses those functions, thus move them back to this file.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
>   target/arm/tcg/translate.c | 22 +++++++++++++++++-
>   2 files changed, 21 insertions(+), 48 deletions(-)

You could drop the inline markers with the move.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
> index cee0548a1c7..e69de29bb2d 100644
> --- a/target/arm/tcg/arm_ldst.h
> +++ b/target/arm/tcg/arm_ldst.h
> @@ -1,47 +0,0 @@
> -/*
> - * ARM load/store instructions for code (armeb-user support)
> - *
> - *  Copyright (c) 2012 CodeSourcery, LLC
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef ARM_LDST_H
> -#define ARM_LDST_H
> -
> -#include "exec/translator.h"
> -#include "qemu/bswap.h"
> -
> -/* Load an instruction and return it in the standard little-endian order */
> -static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
> -                                    target_ulong addr, bool sctlr_b)
> -{
> -    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
> -}
> -
> -/* Ditto, for a halfword (Thumb) instruction */
> -static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
> -                                     target_ulong addr, bool sctlr_b)
> -{
> -#ifndef CONFIG_USER_ONLY
> -    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
> -       within each word.  Undo that now.  */
> -    if (sctlr_b) {
> -        addr ^= 2;
> -    }
> -#endif
> -    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
> -}
> -
> -#endif
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 6ea48efbac2..7fcf0656630 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -25,7 +25,6 @@
>   #define TCG_ADDRESS_BITS 32
>   #include "tcg/tcg-op-mem.h"
>   #include "qemu/log.h"
> -#include "arm_ldst.h"
>   #include "semihosting/semihost.h"
>   #include "cpregs.h"
>   #include "exec/target_page.h"
> @@ -6280,6 +6279,20 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>       }
>   }
>   
> +/* Ditto, for a halfword (Thumb) instruction */
> +static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
> +                                     target_ulong addr, bool sctlr_b)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
> +       within each word.  Undo that now.  */
> +    if (sctlr_b) {
> +        addr ^= 2;
> +    }
> +#endif
> +    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
> +}
> +
>   static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
>   {
>       /* Return true if the insn at dc->base.pc_next might cross a page boundary.
> @@ -6514,6 +6527,13 @@ static void arm_post_translate_insn(DisasContext *dc)
>       }
>   }
>   
> +/* Load an instruction and return it in the standard little-endian order */
> +static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
> +                                    target_ulong addr, bool sctlr_b)
> +{
> +    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
> +}
> +
>   static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   {
>       DisasContext *dc = container_of(dcbase, DisasContext, base);


