Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37669C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6WI-0006Xy-AK; Wed, 12 Aug 2026 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6WG-0006XL-K5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:49:12 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6WE-0005Hk-TW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:49:12 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8114a4542b2so12556407b3.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786531749; cv=none;
 d=google.com; s=arc-20260327;
 b=i0p7w8PsT+ZYkmtxK9rRAQ7uJqRaMP56qosMrOVNq19HadNbdX6/DvxTael2RffilA
 sdoCIy7mTAZ2UStRmpgGXQcCe6rmZdbeExsFe+ybqHfaLEJ2A8uIzeoYaXpz2oaU5egb
 HtVja3UetmJ4jcquK5H0zdATYDgQh65ZN3JrbMJJiEGu0bxJ6UBevOSAaheJwW+Joc3S
 g3sVJsjXyc7ZD0B4YwGZwL6DApTv4nbp+P1SOACClKGTSwmzdaxz+8Mm9z75LPz0yptR
 +DUnaD6DUQIC/nC8zc9wsPIadIoIlT4+yvd1v7jh7uf9D4hIm/tldijkPUxyZHO7tfBj
 fvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5i/V48r7uzuz1OG9Zh5Gu5Y0/TnUEksBAMsmsnDC6bI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=nKPq/8QshzctLQu6de/D8NuCqJn0FG/7rL5sFfQ93P0RaKWU0crTjAuzqClAhhOMst
 osNu3u3G1z4UxTCiJ607XOjaORpoiHt2q7VMYMzTRJUoFUKDPuJgXQF/TJdVanttBmzS
 WaSUKlYwDUI6HfEZxLeLmt1V27QbrumUfjZAbHXoyfuNR6do9HTDK8VcG8fdSCPxjYlu
 tha1GZwD4dGDTjcDJNaw2Lp243XdcjgZh/0dQ2EuGSDZG3ELGLmxIEvROfh1yO4F/keJ
 UFOJhy4+88TaFhlufRjIssVQ8u7ulLdeWyN3q9ET5QqSyVNv7gAuWB/SWIb42Xla2sZa
 U2Jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786531749; x=1787136549; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5i/V48r7uzuz1OG9Zh5Gu5Y0/TnUEksBAMsmsnDC6bI=;
 b=r7kaJUkLSRVv2ckeh8cYTaXqmbkkVH39t53XWKSaXaY0r2C1z0eT9NliHHzmm+jvJj
 PnrzvR1u4OLdnER01YL8uMR39Lt3KvuHn9r1418zb49r+R/dMxdKBGMZUgByO7F6/7yD
 ForLW7EzJwizGZtWUPvNiX2XXAOCu8JXlUlKvY+1ViBWaqNWe6sDvq9/wB6dsikWr5ns
 E4PtRYAv4CEH7WVEtKvPm3BV46+aTyoaScFCrFVB/d9qNOPAHrDXyygiIy6medlZbYDa
 L1S8fsJOZuVfLPXOhchtXC4svLjKxoBQF3rX9Yh0UND8LzHH+bmpLBqwXVXTnY5DA9mn
 SHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786531749; x=1787136549;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5i/V48r7uzuz1OG9Zh5Gu5Y0/TnUEksBAMsmsnDC6bI=;
 b=tS9HdX97uXmv1aGR+nkHN3uEHI7Qr1yB5+EPiRWsEZyCHgPR92oqP9tSyQmU9Rtnvx
 PCRmb3IGvcqau59Jb12ui9ywgFE479kh9L/e0Oc6sAVnqaotfXVbdF/gUBa5YrOpKv/S
 YYOFTsm7YkGZbY2i4VExSq1WSCUkrgLwgEKFmlv6CNqnIRy5CsevqRgoK8lfoSRrWDUs
 Fn2Wcsb7CE/VkkOvw17G8eEtnRvLCEzqKQZ5ovx/yClEJSYQXubHmJEpCtkRlOSo2O3C
 Fre8XFvwWcH+7RTdLM3GR1R0iax8+dAB42oeabK8FUtt6velbQ2FW5Vrdn4gANbudj03
 1rYg==
X-Gm-Message-State: AOJu0YzR+5G0krbNmi+r08M0RVlt+yjWlilFLtT9zC3wAk1C7KsahlMB
 T0q9iaaIlrfvPg/FMaE9idAlOj7ui9xxFkKmiP7dKxApWDQBnN+a7RxqRSnRuWQm/A9cJ6KPksm
 Rch+ITWQEhGUafqckdZhva/hYexG2WrLJFd0CBSczTw==
X-Gm-Gg: AR+sD12UzGDOreN0XWQMdDHnaaAGsqUt7uM6fxIPQZzI9JPallFlJmvO8WUzVB6AZew
 NDKhCAhr8r1BfE74AxKBUNInpq5vgu0OpT8LP8Al2+QEM5zgJJClxEygZ5ibugHp+VMHHMJIhHn
 JH/VwOZL9Oos+4Hc7sTxxBqkpB3An7ajvLd5WbP8BPv4JTyGml4wieXhN98LPQ6sOWjIVxJjfaM
 ZP0OUDyMaqd+GtCsZN3R7w6axafmVq7A1kdavMRw9/l4rpTjzjuupQdSpRsj9HfIqX2cgUcISzR
 Cy5cNnjuSzGMOnuaPYzT9fqT5AH71tC7YZeXOh328rCYOhvYr0U1fgpu5oB0rkgrenjz5Ys/JVq
 IK4cwv4H0o7zzsZymaH0MKyKQB/zC
X-Received: by 2002:a05:690c:60c4:b0:80d:a249:4854 with SMTP id
 00721157ae682-83109ef95bcmr22059257b3.17.1786531749229; Wed, 12 Aug 2026
 03:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-8-richard.henderson@linaro.org>
In-Reply-To: <20260806163939.328201-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Aug 2026 11:48:57 +0100
X-Gm-Features: AUfX_mz77ePcDw5qhNXXy8ErTv6EUbrATcmJox-cluOmZLznMPW5S4wA4N9-P9Q
Message-ID: <CAFEAcA8Q3RmeGpTdC1KjTBMriiUMmYZTEpgiP83PBDvUmCdOkw@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/arm: Separate cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 6 Aug 2026 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not include v9-only features in "max-v8".
> Do not include the prohibited v8 features in "max-v9".
> In tcg mode, define "max" as "max-v9".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h        |   2 +-
>  target/arm/cpu-max.c          |   2 +-
>  target/arm/tcg/cpu64.c        | 408 ++++++++++++++++++++--------------
>  target/arm/tcg/stubs32.c      |   2 +-
>  docs/system/arm/emulation.rst |  11 +-
>  5 files changed, 253 insertions(+), 172 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 5e7f41a50d..2ced0b1c2c 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1809,7 +1809,7 @@ void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>  void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
>  void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
>  void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
> -void aarch64_max_tcg_initfn(Object *obj);
> +void aarch64_max_v9_tcg_initfn(Object *obj);
>  void aarch64_add_pauth_properties(Object *obj);
>  void aarch64_add_sve_properties(Object *obj);
>  void aarch64_add_sme_properties(Object *obj);
> diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
> index cfcc46eb9d..e6872c1c8d 100644
> --- a/target/arm/cpu-max.c
> +++ b/target/arm/cpu-max.c
> @@ -220,7 +220,7 @@ static void cpu_max_initfn(Object *obj)
>           * '-cpu max' for TCG: we currently do this as
>           * "A57 with extra things"
>           */
> -        aarch64_max_tcg_initfn(obj);
> +        aarch64_max_v9_tcg_initfn(obj);
>      }
>  }
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 556fa9fa3c..5eeb6712da 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1156,13 +1156,11 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>  }
>
>  /*
> - * -cpu max: a CPU with as many features enabled as our emulation supports.
> - * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
> - * this only needs to handle 64 bits.
> + * -cpu max-v8: an ARMv8 CPU with as many features enabled as
> + * our emulation supports.
>   */
> -void aarch64_max_tcg_initfn(Object *obj)
> +static void aarch64_max_v8_tcg_initfn_aa64(ARMCPU *cpu)
>  {
> -    ARMCPU *cpu = ARM_CPU(obj);
>      ARMISARegisters *isar = &cpu->isar;
>      uint64_t t;
>      uint32_t u;
> @@ -1226,203 +1224,148 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t = FIELD_DP64(t, CTR_EL0, DIC, 1);
>      cpu->ctr = t;
>
> +    /*
> +     * Below, note the revision from which the feature is OPTIONAL.
> +     */
>      t = GET_IDREG(isar, ID_AA64ISAR0);
> -    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* FEAT_LSE, FEAT_LSE128 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* FEAT_SM3 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* FEAT_SM4 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* FEAT_DotProd */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* FEAT_FHM */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* FEAT_FlagM2 */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* FEAT_TLBIRANGE */
> -    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* v8.0: FEAT_PMULL */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* v8.0: FEAT_SHA1 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* v8.1: FEAT_SHA512 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* v8.0: FEAT_CRC32 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* v8.0: FEAT_LSE */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* v8.0: FEAT_RDM */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* v8.1: FEAT_SHA3 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* v8.1: FEAT_SM3 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* v8.1: FEAT_SM4 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* v8.1: FEAT_DotProd */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* v8.1: FEAT_FHM */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* v8.1: FEAT_FlagM2 */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* v8.3: FEAT_TLBIRANGE */
> +    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* v8.4: FEAT_RNG */
>      SET_IDREG(isar, ID_AA64ISAR0, t);

Because this commit updates every line to put the optional-from
version in the comment, it makes it very hard to review for what
has functionally changed (i.e. which features that we previously
had in 'max' have we dropped from 'max-v8'). Could we do the
bulk comment update as a separate commit, please ?

thanks
-- PMM

