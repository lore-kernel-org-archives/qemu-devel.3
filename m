Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4FF531E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 01:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCSgV-0001dS-B6; Mon, 13 Apr 2026 21:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCSgS-0001bt-RO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 21:35:20 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCSgQ-00038v-9g
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 21:35:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so3145626a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776130516; x=1776735316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/6iN49mWnUgv5H57b5T7X6O5t497bfzvx5B1ZSYIkfU=;
 b=iXPHHkKCR1Ma8NE0T4IiyMJCTYma3yt5n7oAcTFZlmytEdpy2LswiYiBFPjHyzVFH/
 TmCFQY9e1Vpn2Cp3s80E1Sw+nz9iUE1OIdchv7CujgNyA3uZeYoCbjQX8EGUgPxlC/vh
 1Gk2oma0vCSMi5qPEdZVzQSMcarHJGdYZ4rX2ut2NtJLIDfy1Sx7gY1f/2aiuXbmLfub
 XZSw9PgIyOt3aaqQvYCorNihfg4xdDXS2PddRLwcSfHgw56qq96ArpDO414LcJXRyejM
 46GMinTI+ERw0VLMyslMb7r4yAcK++aMFkjby2ivHj1h1k2J3QBjYp3QEzUDBe4zNLXs
 lBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776130516; x=1776735316;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/6iN49mWnUgv5H57b5T7X6O5t497bfzvx5B1ZSYIkfU=;
 b=VZZ0i6hqyDUcr8Bcb5oXuOKcK1MbGEQJcOCxCbJqD/YCrJmu5yXmFPXRm6riDmu0Px
 BPgmUK0aH+LaIhE7p+KWQfb1HqiIklwlhSbSvYDZCsI7mRLIsZnuq9bE7dpTZrqMA5EG
 l2O6uzPoqJGfwAJdWWju1ChcC10jlYhbpktw6S3ztCiDyVa6bqasrrrb3yNib1wCEWfk
 f61FiUeM5autfw6mFHqfoOxbX3JC8oeWEUyfJ17NhsG2UQPnHHMCuZ102xjVfjHT3m3A
 Fgd45lIoBXHD90q+vVZ3bUBAgqViVdnt2+GHZZFHcDrdXqKr8n7hcbqxfZgMiQC1uKe5
 U74A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WunpzeGpx3dyl+By641OTPspf2Gb8JKoNgE99tN3adLGmVuWwanzQmqmiIeAoDU18IByX8Bs1T8oc@nongnu.org
X-Gm-Message-State: AOJu0YxTP25LWaV52QPsi79EHIvZ9sOxMKsKsOtNZvygLVggUoAhVOsy
 F1eIPxgQdRcmEVd7f3+UEBHH4rFuX5ctcW60eqsAEeHkOJ/EiFyuwJWgVYBtWtVe2kk=
X-Gm-Gg: AeBDiet/3IM3qxjJ1kR8Y9SeFpp99DhuIjEU24+FXG/JSrxV/FAiOwuQ2G8h5OjAeh+
 +CUjh8BbvdokXVJnfVK+2j7TpU17Hpv5tx/6v058z7FRbNOYiMGgxIalaHdFBXOf1dQb7AVpyQ9
 pHdZaYMU4Hlc66tMUNMME9wiKpg/XkOdv8LyyGycmOY/tYtMF9oPRvutsTBp5J0CSH9uyDuU0Ca
 MYBdpHYsjXIVk8ViMUoMJBGGLUNlSZcHsUvxKv1BIRK39LhJrGDDHHwnEfQB+jcPeMY6q/s2K2b
 RD04TPkSn0O4sldhR2BqT1Kd3WmNjh6Oeb0KhDaoK/mx80yOfs+LPSZpuP9lx/97uewDBgYhDal
 ooOYcGksCT0LujmAqNtthJQABkj/LIZfYbh+a4Q1QcoXINZpJnwpQai5MMhM86bY7mBRI128ZCT
 jNiN3urYeonMwAUHT1Eswd3ir84M+T4aJHhlLX3ScWy2qW3PSJRHtVKEXr53QChhYqeQJz82Pw1
 zm6UvI9oNw88ZjANOsqYuVXXBnYjIxDqQs8RbaG50JCIpe9VFJxw+8=
X-Received: by 2002:a17:90a:d405:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-35fc46f0468mr1302453a91.14.1776130515900; 
 Mon, 13 Apr 2026 18:35:15 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 (bg30dhzrtpvfdxnnygb2.ip6.superloop.au.
 [2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb87d0361sm2305447a91.0.2026.04.13.18.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 18:35:15 -0700 (PDT)
Message-ID: <0a95eb1b-c9c8-4da7-a9bb-dcac36c51e59@linaro.org>
Date: Tue, 14 Apr 2026 11:35:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/arm: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
 <20260414005348.4767-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414005348.4767-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/14/26 10:53, Philippe Mathieu-Daudé wrote:
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h      | 6 ++++++
>   target/arm/tcg/mve_helper.c | 3 ++-
>   2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index e92a967f575..e65014af1a7 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -28,6 +28,7 @@
>   #include "exec/hwaddr.h"
>   #include "exec/vaddr.h"
>   #include "exec/breakpoint.h"
> +#include "exec/memop.h"
>   #include "accel/tcg/tb-cpu-state.h"
>   #include "hw/core/registerfields.h"
>   #include "tcg/tcg-gvec-desc.h"
> @@ -46,6 +47,11 @@
>   #define BANK_HYP    6
>   #define BANK_MON    7
>   
> +static inline MemOp mo_endian(CPUARMState *env)
> +{
> +    return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
> +}
> +
>   static inline int arm_env_mmu_index(CPUARMState *env)
>   {
>       return EX_TBFLAG_ANY(env->hflags, MMUIDX);
> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index 4bea0991de9..a5a23c97056 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -299,7 +299,8 @@ DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
>           unsigned e;                                                     \
>           uint32_t addr;                                                  \
>           int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
> -        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
> +        MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN, \
> +                                     mmu_idx);                          \
>           for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
>               if (!(eci_mask & 1)) {                                      \
>                   continue;                                               \


