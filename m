Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42312CD041F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 22:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vct8W-0002MS-Ua; Mon, 05 Jan 2026 17:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vct8M-0002Fh-4R
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:33:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vct8J-00046z-O7
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 17:33:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso3700255ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 14:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767652382; x=1768257182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Rn4zgYufMW7rIMHFO5uTe8EU5x+JDUJ8tv9sxcWIH8=;
 b=etZtkWwtUDVq9YkwsDYOfWyZ0ZydO9u5QlimPwXBh4y/424HdIve8ErAy1P9lN1srV
 wHNDQr8WXO18HgoFp597lIQ95ECUNIn/0X4hWPOc/37wxdQnfBG43Ar/4o6SJ52igeIA
 xdYeKvjvmOB0Uhz9n6Uho0Kn0EXDUXT7nWfM/jolXGIS/zHnqb3eZw7b4UQDfWbBtMoc
 NKJWnOK3hgA9kbbkgEY91poFMBJSRUdbgdHBhZpvUvptuJrVq9KM37AX0kI7zA7V38A2
 j+nBwa8RXqLv1BfZgmg3Y3cugwO5W8DeiVVxLWHvjrQ4sWb8fCTqZRJh02gxD6lwMjY2
 YHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767652382; x=1768257182;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Rn4zgYufMW7rIMHFO5uTe8EU5x+JDUJ8tv9sxcWIH8=;
 b=JvzVuQYqyuYMas0WnmBsEiAm751PYbRG7l6o6P54BbxPYuvAPrMokHu5JYKnEUm+oi
 X/siXAhv0PPn4bkVlRiHIhyJBoAa4XA/1dsjRBl5Oluz6SvOvDdLv8IZ63iQs8cvw+gQ
 HqyLeg1snTNbksoqEfeuBB0W+qBgbV9ab8nnz/chOzhnNe0fgTPe3tmC2zt0su3bNa/c
 7lBPguOjSAAq4pza5Dw1tFM2QDBCFmLfe/9+CZBJ8Ks26av4PWYZVCV8rNW7064eU8lv
 TY6FXanm+V5EtxB7bqlUDCN8mDlOBDAgVT2OheIDznc4YTPutwwjPX8FXHePLNLmOJwh
 KsoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrnghpmMIWbXEJ+attmkCUh1JWmbvZEf5RiAlMsKBLam/B/uFAeUqhSZSq6rplNJiqRuLAJTMyGOJj@nongnu.org
X-Gm-Message-State: AOJu0YwNcB3HYJB1VKbKgR15o/Rq2DRjy0f2rhJGfIJnNkXKGYu6cVez
 5XdkiZT2JTLkbjucdQwXjL1Zy4kPCSDyrh4j+ppp0Cmwk0KUF21drne88kKztOq9t/gbw4uh+XP
 jqrSyJOY=
X-Gm-Gg: AY/fxX4XeGoJTVdSt/dmdGTZarhH/dp0s+7NOC0djZEuxjpKJ4AS8Ccao/+NERP7yjx
 w5gHG4HAGBklr35ZhyRezbxlYv9XSltYghqPg154mUK/d/Axgn5UYKAmNRNT3oCG7K4gXZnD72L
 vNPLsXuZHOCldFBrMLcoZTwPd4rZi72nlmixEwYxZikYt0ReAS8ybqIvG3aFJtEd1FF943qacen
 4xKy5Exgu88F7UpkDAwipH580uDubS/pUZZZsN7oNqm+UiOqAxvqas6WDJ99zrPOcLgRJd7WQad
 E2ATX2aY5SsZBQioVmF9WyvGEMdFxgOAMiZy2huLwilfikiCHkY4pB3GiC2+pT6jUuOnxCxyBu9
 8Km0l0jh+kGXkjRiFDuA61rZQQCTnaOaKZBdLISgGLaXy9OzF8ydwIxZeuwIAYOriZKqoia9nZn
 h6JSpEVVNCd1f/L6OW6RZ91slbu34jiw==
X-Google-Smtp-Source: AGHT+IHdqFjaOzlPDrbCcbqaIb2hcqvT1VIzaLvjMCs+EV7x/nXnnQMlvxq26yS4MUgVuLTI6voMqw==
X-Received: by 2002:a17:903:2f8f:b0:2a1:5f23:7ddf with SMTP id
 d9443c01a7336-2a3e2c92066mr10946115ad.6.1767652381528; 
 Mon, 05 Jan 2026 14:33:01 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48d77sm2380185ad.41.2026.01.05.14.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 14:33:01 -0800 (PST)
Message-ID: <76dfc640-b8db-4ed5-9232-41ede17da314@linaro.org>
Date: Tue, 6 Jan 2026 09:32:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/12] target/arm: mte_check unemitted on
 STORE_ONLY load
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
 <20260105-feat-mte4-v3-3-86a0d99ef2e4@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105-feat-mte4-v3-3-86a0d99ef2e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/6/26 05:14, Gabriel Brookman wrote:
> This feature disables generation of the mte check helper on loads when
> STORE_ONLY tag checking mode is enabled.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/cpu.h               |  2 ++
>   target/arm/tcg/hflags.c        | 14 ++++++++++++++
>   target/arm/tcg/translate-a64.c |  8 ++++++--
>   target/arm/tcg/translate.h     |  2 ++
>   4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 393bfc0dc9..4087484faf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2496,6 +2496,8 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
>   FIELD(TBFLAG_A64, GCS_EN, 41, 1)
>   FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
>   FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
> +FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
> +FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)

Skipping bit 44?

> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 5c9b9bec3b..c4696af5d8 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -425,6 +425,16 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                        */
>                       DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
>                   }
> +                /*
> +                 * Repeat for MTE_STORE_ONLY
> +                 */
> +                if (cpu_isar_feature(aa64_mte4, env_archcpu(env)) &&
> +                    ((el == 0 ? SCTLR_TCSO0 : SCTLR_TCSO) & sctlr)) {
> +                    DP_TBFLAG_A64(flags, MTE_STORE_ONLY, 1);
> +                    if (!EX_TBFLAG_A64(flags, UNPRIV)) {
> +                        DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
> +                    }
> +                }
>               }
>           }
>           /* And again for unprivileged accesses, if required.  */
> @@ -434,6 +444,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>               && (sctlr & SCTLR_TCF0)
>               && allocation_tag_access_enabled(env, 0, sctlr)) {
>               DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
> +            if (cpu_isar_feature(aa64_mte4, env_archcpu(env)) &&
> +                (SCTLR_TCSO0 & sctlr)) {
> +                DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
> +            }
>           }

These two hunks don't need to check cpu_isar_feature, because we already did that when 
filtering the valid SCTLR bits.


r~

