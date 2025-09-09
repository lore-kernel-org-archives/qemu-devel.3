Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F1CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyBL-0008Cn-KI; Tue, 09 Sep 2025 09:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyBJ-0008CP-DR
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:14:45 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyB9-0005Jw-G0
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:14:44 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b6f7f15so6207711a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757423668; x=1758028468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WK6iSa7YVEuwZh5jHiv1calgQtryNYGyo+j8EmNE6Ek=;
 b=Rtnfrl5tXfaD5FKJ+0kiBl2Oa6Yp/YbPs5uG8JgYaGiXkAZm7hQd5j9lXQf5aJ3H6I
 NsY8b0moHm/t9smWoRnOXO8rzYTiSlORtzGAzJ1gCkVb+VLLIRqOxuGCuVs6fQOUqYU+
 dLMWpKrK4oa2yNKMDzg8LPIXhaZ078J4bj9SmCtwRVOSdIX6A2ndOvMjVNcuIq+tlDh2
 LJh61FHJhsZxsH/6kjQjqxng1greHEr+7k+PlhryOSjPXzWhLQLVbRWyVw603q4NRD0o
 jvHuKLkPgtXsfZQa7jduLXZPloQ0N0812PwCk7FzAykOZVeZeRkQQ/jDSaAT9mP5ZHer
 Bo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757423668; x=1758028468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WK6iSa7YVEuwZh5jHiv1calgQtryNYGyo+j8EmNE6Ek=;
 b=pGCUkVE+gIUAVCF+kudwr8hUPrJHRzDdg+jBhFMTufEkwJ8HuI0UFg3PJUD4dvTVxg
 4NG8UCrJLt8uZuy4Klh94aOTVxIOikroD7HTDWbNJvufQEOjH0CiFk/nvMpifISYOUxJ
 eODwM1fNgnrJ0VIcWx5zdbKUl/k3OBlvIM53gGydZmBB8IlQRbqdZZoME+2SU3QeCbO3
 Dy3AXAmBkAPekB8OoeRSwqxIrCG+QZfVWDo/hIqBplfz5CZnKxno5TroGcBTl0v2vPVs
 lnPR17B8ubtN8SZ6du6km3VY4V6O6qaRcxBZ6yrzQv5GPOcZ2oSB39+BIssVokDBR8E9
 zxTQ==
X-Gm-Message-State: AOJu0YzyQLqHVOYIO72CLeNGXmNbnZd7eTHZn1y7m8763NeeHUkPB3Jc
 cQpHqqViO+GKvVeMyF7gD3CagpRmmmCQRYLqMe+IC24H9KRQ9oTvYo6FsmQcObHZ+uyuwFyTeb2
 uAVUMfJrLi5Vhdj7XyG2lCTwg36Lk8JPkQZ7TjHxU+9p6KbU7ELly
X-Gm-Gg: ASbGncvLeu/WoyxfmxhFCFpDVVih4A2W2xl1C2wpmsrEYYIoQqPFp6hlyRoMNKRFGsc
 nRziqH+o2wcuQqnmAUqWer3xVUjXTPlxL0QEjQTZMPIYcs0+lY2ZMvKxg8heDSh28dFyt5vPHU1
 Z3fLbSGifxQwtyDLJK9hXGmLIBKLWw9u1I2jT7oekkrcSUiLNcoKwq/Wgc85tdJck6oXYpyeaNQ
 sMNn+W3
X-Google-Smtp-Source: AGHT+IHS8FHWjm3uU09tINxvZDTYSimLwH4/8Qrgw1XgPO4epptpJDDvcfvjKeiAjki74t7XD7EZdYSbg+XQDSScqDY=
X-Received: by 2002:a05:6402:270e:b0:629:949c:a667 with SMTP id
 4fb4d7f45d1cf-629949cb089mr4884812a12.31.1757423667887; Tue, 09 Sep 2025
 06:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-53-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 14:14:14 +0100
X-Gm-Features: AS18NWASZvkm2c4BDr_tn8kJNsmiHPAFhQRG9bMfAfuzPtCfaFumN5UzJEKHxug
Message-ID: <CAFEAcA831MJsku0M28knN0e-dKe4zzU-DF7VODanXmzS8-LPvg@mail.gmail.com>
Subject: Re: [PATCH v4 52/84] target/arm: Implement EXLOCKException for
 ELR_ELx and SPSR_ELx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 30 Aug 2025 at 17:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If PSTATE.EXLOCK is set, and the GCS EXLOCK enable bit is set,
> and nested virt is in the appropriate state, then we need to
> raise an EXLOCK exception.
>
> Since PSTATE.EXLOCK cannot be set without GCS being present
> and enabled, no explicit check for GCS is required.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h        |  3 ++
>  target/arm/cpu.h           |  1 +
>  target/arm/helper.c        | 83 +++++++++++++++++++++++++++++++++++---
>  target/arm/tcg/op_helper.c |  4 ++
>  4 files changed, 85 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index bc6adf5956..15894332b2 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -346,6 +346,9 @@ typedef enum CPAccessResult {
>       * specified target EL.
>       */
>      CP_ACCESS_UNDEFINED = (2 << 2),
> +
> +    /* Access fails with EXLOCK, a GCS exception syndrome. */
> +    CP_ACCESS_EXLOCK = (3 << 2),

The values in this enum are documented as to whether they can
validly include the target-EL in the low bits. In this case
we can't, so I would expand the comment to say so:

       /*
        * Access fails with EXLOCK, a GCS exception syndrome.
        * These traps are always to the current execution EL,
        * which is the same as the usual target EL because
        * they cannot occur from EL0.
        */

(Last time I was in this area of the code I was tempted to
drop the idea of "low bits might indicate target EL" and
just have CP_ACCESS_TRAP_EL* be normal enum values, rolling
the two switch() statements at the bottom of access_check_cp_reg
together. But perhaps some future trap type will also want to
go to a specified-target-EL...)

>  } CPAccessResult;
>
>  /* Indexes into fgt_read[] */
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d5a5152a9c..17902eb40d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1511,6 +1511,7 @@ void pmu_init(ARMCPU *cpu);
>  #define PSTATE_C (1U << 29)
>  #define PSTATE_Z (1U << 30)
>  #define PSTATE_N (1U << 31)
> +#define PSTATE_EXLOCK (1ULL << 34)
>  #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
>  #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
>  #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 83a7d6ae36..2f19695d82 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3432,6 +3432,77 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>
> +static CPAccessResult access_exlock_el1(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri, bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (el == 1) {
> +        uint64_t hcr = arm_hcr_el2_eff(env);
> +
> +        /*
> +         * EXLOCK check is disabled for NVx in 'x11'.
> +         * Since we have to diagnose that, dispatch NV1 trap too.
> +         */
> +        if ((hcr & HCR_NV) && (hcr & HCR_NV1)) {
> +            if (hcr & HCR_NV2) {
> +                return CP_ACCESS_OK;
> +            }
> +            return CP_ACCESS_TRAP_EL2;
> +        }
> +    }
> +
> +    if (!isread &&
> +        (env->pstate & PSTATE_EXLOCK) &&
> +        (el_is_in_host(env, el) ? el == 2 : el == 1) &&
> +        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
> +        return CP_ACCESS_EXLOCK;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
> +static CPAccessResult access_exlock_el2(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri, bool isread)
> +{
> +    int el = arm_current_el(env);
> +
> +    if (el == 3) {
> +        return CP_ACCESS_OK;
> +    }
> +    if (el == 1) {
> +        uint64_t hcr = arm_hcr_el2_eff(env);
> +
> +        /*
> +         * EXLOCK check is disabled for NVx in 'xx1'.

"not in 'xx1'", if I'm reading the pseudocode correctly ?

> +         * Since we have to diagnose that, dispatch NV1 trap too.
> +         */
> +        if (hcr & HCR_NV) {
> +            if (hcr & HCR_NV2) {
> +                return CP_ACCESS_OK;
> +            }
> +            return CP_ACCESS_TRAP_EL2;
> +        }

I find this confusing. Before, we had no access fn for
these ELR_EL2 and SPSR_EL2 registers. So the changes
for GCS should not be adding extra trap cases that we
weren't doing before: just do the EXLOCK check when you
need to, otherwise return ACCESS_OK and let the existing
code continue to handle the NV traps/redirections.

Otherwise I have to reread all that code to remember
how it works and what order it does all the checks and
redirects in to confirm that we're doing things in the
right order.

(This is different from access_exlock_el1(), where we
are replacing the use of access_nv1() and so need to
do the same tests it does.)

Incidentally if we get to this function and el == 1 then
I'm pretty sure that HCR_NV must be set (or we would have
UNDEFed because ri->access permits access only at EL2 and
above). So for us we don't need to do any test on NVx
to bypass the EXLOCK check: we can do it unconditionally here.

> +    }
> +
> +    if (!isread &&
> +        (env->pstate & PSTATE_EXLOCK) &&
> +        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
> +        return CP_ACCESS_EXLOCK;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
> +static CPAccessResult access_exlock_el3(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri, bool isread)
> +{
> +    if (!isread &&
> +        (env->pstate & PSTATE_EXLOCK) &&
> +        (env->cp15.gcscr_el[3] & GCSCR_EXLOCKEN)) {
> +        return CP_ACCESS_EXLOCK;
> +    }
> +    return CP_ACCESS_OK;
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  /*
>   * `IC IVAU` is handled to improve compatibility with JITs that dual-map their
> @@ -3603,13 +3674,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>      { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS,
>        .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
> -      .access = PL1_RW, .accessfn = access_nv1,
> +      .access = PL1_RW, .accessfn = access_exlock_el1,
>        .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
>        .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
>      { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS,
>        .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
> -      .access = PL1_RW, .accessfn = access_nv1,
> +      .access = PL1_RW, .accessfn = access_exlock_el1,
>        .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
>        .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
>      /*
> @@ -4080,7 +4151,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>      { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
>        .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
> -      .access = PL2_RW,
> +      .access = PL2_RW, .accessfn = access_exlock_el2,
>        .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
>      { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
>        .type = ARM_CP_NV2_REDIRECT,
> @@ -4098,7 +4169,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>      { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
>        .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
> -      .access = PL2_RW,
> +      .access = PL2_RW, .accessfn = access_exlock_el2,
>        .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
>      { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
> @@ -4380,7 +4451,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>      { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS,
>        .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
> -      .access = PL3_RW,
> +      .access = PL3_RW, .accessfn = access_exlock_el3,
>        .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
>      { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
> @@ -4391,7 +4462,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>      { .name = "SPSR_EL3", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_ALIAS,
>        .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 0,
> -      .access = PL3_RW,
> +      .access = PL3_RW, .accessfn = access_exlock_el3,
>        .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
>      { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 46a3b911ec..56e117c01e 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -887,6 +887,10 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
>          }
>          syndrome = syn_uncategorized();
>          break;
> +    case CP_ACCESS_EXLOCK:
> +        /* CP_ACCESS_EXLOCK is always directed to the current EL */

", which is going to be the same as the usual target EL."

> +        syndrome = syn_gcs_exlock();
> +        break;
>      default:
>          g_assert_not_reached();
>      }

thanks
-- PMM

