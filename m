Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4264AC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpq7s-0008Hb-LC; Fri, 31 Jul 2026 12:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq7q-0008Gf-6i
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:30:22 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq7o-0002vS-3a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:30:21 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-667971437d6so1503311d50.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515419; cv=none;
 d=google.com; s=arc-20260327;
 b=Kb4hGYon3F04XqrcTA28hvyaHOCy3PrjHJyh16WApzCCrVycCXm4NviOQKF8bJ+hlS
 GLaNJwOnmDg4t3KJ3oynq9n7DdEflR9BTlPW3pAttndM0VWggX8y7xRg3lcojel6/BKv
 rzamT3xqarfynJ0VylljfnasiVb1UTMf3vzdPh2uzd5C9+ep4rjXV3JnQ7U3aJftZyYz
 28kU3xLli0pAb+qgSKigNW1Aw0gjLgwf55uRc/fwShvku/WYF7KbWb5ieJLtrt9uTzyg
 uHNp/fBePHTQdVo0LlAenwUl9tsy6CTS9scptqFVibMUsjiVJJDx0nXCjaMEcC4QgVxH
 mTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PB8wYCHzDuCP2XGvIx/g3tf6wVQHIjEjr2yPQDKBC0g=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=cza3MQubMrRIL8ylsV4OiudsGtTMqkRuT3MlDkj8c9piJG76ZVBtoWRtiqVtiyUhkd
 MkSNOQ+tFziVz3GuSRybLmypGuscgBGGe1TtLQKAxcgaRk7a5qKPD5gk6kVaSPL3hXnG
 Ul7wnWlc5Uux3o58joYAfCoqBDMWH3qU77uKVsa+Gx7ya0pwnZWx7dy2hqAcXiFz8bYw
 qDka3EVvMVNXNbOMGVauRCgl0fWwg8hqkuwBCwmsbkGZurxYtZNrVTob8X6z3ZCG6vOA
 fGetpSkp9fXofs/cimofSbX5ZWHljGL/xTzDpMh0vTaX/qYE1/XeCnTnMMgVLF++WVUc
 Hjjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515419; x=1786120219; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PB8wYCHzDuCP2XGvIx/g3tf6wVQHIjEjr2yPQDKBC0g=;
 b=L7Z2hrU+wEs01bPAlwpkA+nP+pHwz3kIlvAMbgZmAjwan8NRUwP0FmY9EUtshI+BIv
 LfcC05x0cLtSWy2WmesGD4GObIeJQSlZsHJnpw2GMYU/waPmsbOzeUwFpBA4cku8N9vr
 kFTW/31wmRYXFawAXt3tyqt2bW6iJvxE2jUCOuCSMRFZXoSXATImmVSLOGsi+BnZk/dR
 Va5jVNqCSvykRrCFY4ON+/Ur12J9qZ2CaRBgRsGhaCicgVhgpSLvcWgTh5vGjB6QmLgd
 Jr186diLEjFV8ExgCJls1fP++Ma6qJF6MiWf9r5ESoxHEMRIzc4pN47r7PtYe3y14P8S
 Sd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515419; x=1786120219;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PB8wYCHzDuCP2XGvIx/g3tf6wVQHIjEjr2yPQDKBC0g=;
 b=nT04l4iDQRk5A2CCne53JKJKqVLrV89rA8+2GtgDg6n+VCOTrMeXJJCCp/x8J4KUnw
 HZdadV0mx6uENl4URznXoXfVLOfwWO12pd1I4dD1H2Kes71gMjgnoddpMRGl+KA3s6kF
 S1u+TDPvMa/fniXl55GnXTaY0++M1eEF+G6Wz89+6Gkxz9YuvwL0zrdEUcNvxVdUKBbA
 posSrQ4ZBSPw5dYgXBjEqIZH3kUAesN90BF9aAJBrBKgSDeixpFPwZeUbCws1uRt0eb0
 xaUNn+kx0tse41EWQd/RqYbFzn+I10/wECIBQVFaU0AGe2zhsIXvdtPdVaLPYkkJn98O
 2Ofw==
X-Gm-Message-State: AOJu0YyF9ivrxjjrauWndjfyKR/6DkwNdfldO0SIbPVVC2wjwjdA/ydc
 PStkqm0ljXv8h6NNrf62ht4qMWilW5J3Td+bNYQ+zZJkMJ38BviIh93/T1J/6ph2ReEssrEU5ao
 PdvmoMb7GPjphyjLGeUFJAIHGNnuqwRCIvPYZtqx2XQ==
X-Gm-Gg: AR+sD11gboOkdmcSSgTfxNBSQAzxvxuwOawi84J3ZgW494FOy8bY6VuvZGYqnax/4gr
 TgidzxnSMdZH34gMcilqrDz23pVQ6XodkJiWIi0BskBPzhh/Qg/hsjjIAZY+avYQelQnTTEc0Ue
 yVbAtf7F6JhOtUxRwZvEOAGGblugD9qI1ixrttjf2PYEqpnA6rjuzB3eybPmBxEanK1YaHyPi2w
 qc1CtjXH/payFxW5zPkdU6FJyLQT7qOvsf1FSTvH++0VeYDB3MqoMX//01a9smeZM2luJS87VIQ
 c/Zrk86h6rlQmf1rka8AdtLyD6SPKHWPgL+AsR1UmVzEFsgtDx+cnEdC9TuiFqjhJMCuV3PCDPb
 7Vg228OyXyUwozFk84BJeuTMbsItP
X-Received: by 2002:a53:b1c2:0:b0:668:9230:e265 with SMTP id
 956f58d0204a3-6694f23a666mr617562d50.42.1785515418489; Fri, 31 Jul 2026
 09:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-2-richard.henderson@linaro.org>
In-Reply-To: <20260724030616.76180-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 17:30:05 +0100
X-Gm-Features: AUfX_mx41XrJPMUQzsmEWZlOc2erlpsFdrNo0OsVkeG68TPRC7NPJ45ll-kIEQQ
Message-ID: <CAFEAcA-BkEG59qM8sRtEtD-Y0-LC5sWfuWhMFTLnEcGDcvvDmQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/arm: Add FGWTE3_EL3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 24 Jul 2026 at 04:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h       |  1 +
>  target/arm/cpu-features.h |  5 +++++
>  target/arm/cpu.h          |  2 +-
>  target/arm/helper.c       | 19 +++++++++++++++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index 391c0e322b..34592679e4 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -385,6 +385,7 @@ typedef enum CPAccessResult {
>  /* Indexes into fgt_write[] */
>  #define FGTREG_HFGWTR 0
>  #define FGTREG_HDFGWTR 1
> +#define FGTREG_FGWTE3 2
>  /* Indexes into fgt_exec[] */
>  #define FGTREG_HFGITR 0
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index fb5ed25ad0..75f0fc4169 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1467,6 +1467,11 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
>  }
>
> +static inline bool isar_feature_aa64_fgwte3(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, FGWTE3) != 0;
> +}
> +
>  /*
>   * Note the E2H0 ID fields is signed, increasingly negative as more
>   * isn't implemented.
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 03a30afcbe..ca75e379eb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -553,7 +553,7 @@ typedef struct CPUArchState {
>           * FEAT_FGT2 will add more elements to these arrays.
>           */
>          uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
> -        uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
> +        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
>          uint64_t fgt_exec[1]; /* HFGITR */

GICv5 also has some new fgt registers, incidentally; implementation
of them in my w-i-p gicv5 branch:
https://gitlab.com/pm215/qemu/-/commit/31900667e440a136c60b984c9e7c9e9a95d708df

I don't think there's any particular clash here, though. The
one thing I do wonder about is that FGWTE3 has only a
write trap version, whereas the gicv5 regs have both read
and write trap versions. We rely on being able to use the same
index for fgt_read[] and fgt_write[]. So I think maybe here we
should make fgt_read[] also 3 entries and comment it as
"FGWTE3 (unused)"? Unless we deliberately land the gicv5 traps
first, we'll need to add a gap there later anyway, and doing it
now means we won't forget this oddity.

>          /* RME registers */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index af45234ad2..d410a9a1ec 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6331,6 +6331,21 @@ static const ARMCPRegInfo fpmr_reginfo[] = {
>      }
>  };
>
> +static void fgwte3_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    env->cp15.fgt_write[FGTREG_FGWTE3] |= value;

I think I would comment this as
     /* All bits are sticky and can only be cleared by CPU reset */
because the semantics are odd enough to look like maybe a mistake
otherwise.

> +}
> +
> +static const ARMCPRegInfo fgwte3_reginfo[] = {
> +    { .name = "FGWTE3_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 5,
> +      .access = PL3_RW, .resetvalue = 0,
> +      .writefn = fgwte3_write, .raw_writefn = raw_write,
> +      .fieldoffset = offsetof(CPUARMState, cp15.fgt_write[FGTREG_FGWTE3])
> +    },
> +};
> +
>  void register_cp_regs_for_features(ARMCPU *cpu)
>  {
>      /* Register all the coprocessor registers based on feature bits */
> @@ -7642,6 +7657,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          define_arm_cp_regs(cpu, ccsidr2_reginfo);
>      }
>
> +    if (cpu_isar_feature(aa64_fgwte3, cpu)) {
> +        define_arm_cp_regs(cpu, fgwte3_reginfo);
> +    }
> +
>      define_pm_cpregs(cpu);
>      define_gcs_cpregs(cpu);
>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

