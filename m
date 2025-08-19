Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F58CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 09:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoIHR-0004fS-Ob; Tue, 19 Aug 2025 05:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoIHM-0004e9-Rq
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 05:05:16 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoIHK-000484-BW
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 05:05:16 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71e6f84b77eso27839497b3.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755594305; x=1756199105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sIq2ds9Uv9nQ7HV1FXL86ykrtBBDGbFmNGBWN1V5mPw=;
 b=IUlEqZlVcT64X5neRkDHjw/54FmBKzBhbq+jYWbqtqJLajwth7QNHLqUlfoxXtbONc
 CYdibLOd5afKb+Zi/YTxaUHsInXw1Vh0xD0n4NHkihUN6b3y97kCsKdX+2IwWUGDaEMu
 B8JUBSClIWGINKaU4N0gpjm1gfADULulLB7OsFzglJhTATQtwosUthBCs+CqyVvxtYEx
 G31h0zxHts2HvQXdzi5QQd9mxuiSbpWMOkY/jNerNL+0Z0arpm7pV+2ro3sLUgza5czr
 9BZflTwnbsZ3sEDmvnd4+Z1EM7VsHXZCEdeyt/Zj7HL+ERi1C8Ib28Vz/EYn0GvWQCWa
 v1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755594305; x=1756199105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sIq2ds9Uv9nQ7HV1FXL86ykrtBBDGbFmNGBWN1V5mPw=;
 b=KnucfdBwXuJGXTu5pWodN4L/hiekH8SZeY5d7wD/RNvHVzxgoWVAuQR5SHJUr6lToq
 Y7FM6/LZGz1icN6GkZxTWYXtPVcTUYIU/GjJ53F+E+tp+939hJ/BHgSJ7Bf/cRK73NUG
 kRvcmHJ70DVr5gTYcHDtHGTTKRd4K6TQEw+D2Ph38cUYUAgBFrxIwrsMekmtMIgMExPE
 17eh0G74qM1m4gBtxmC7XaIda3Jot+Lfk3b2dq3aTMgZmlSS1HneN3u/toaxcBaSUKxR
 Ano91Ogwow/vxBg+tYSwDv3L88LXpeRx0NRSc49DyceJKgteOLGfGybfCiinxxUXGuvG
 4lEA==
X-Gm-Message-State: AOJu0Yz8KJmm+inCreuUq4Jcn1I96W66kxYYMHpTeI3LzFwMsxK09Nf5
 Mylnslkuz4/DlDxK+DKiubRSTZMn9gsiO+ywbOeQi9m4SKybHWhBjwL6LfB9RSr0XPXZHqqVSbC
 Q3SAl1JxFAOH/JC6a09dL7CaaQGQOi+MnCr9khndkAw==
X-Gm-Gg: ASbGncvqooXcA09bsPNLoVWmFivIpDxBJ6AKapPQ+HPe68eenzAhbmV+grYRpNXkpMe
 xQrZIEcp4oG7sC+vnuApPb+b2pt/k/c02iubmaT0L+43XRi752gS4teewT0MyNEylj28xSMtpJp
 tne/HGOXeIRJej4OjEFR1t+TqW0YZ/rLgKx9I16T8xyx0AVJVa3Ra2WB3mPC9gkus+04jpTOe3s
 xblVk7x
X-Google-Smtp-Source: AGHT+IF7ZDwn4eiZElYI57f9iuECpVyOkhueqUSVLueO9BdZRBNS0D1iGiDdkEzAW7qVIRcuMvK5e4+mvOlmXjpAhzs=
X-Received: by 2002:a05:690c:64ca:b0:71a:41e2:b553 with SMTP id
 00721157ae682-71f9d64e10dmr20335547b3.26.1755594304768; Tue, 19 Aug 2025
 02:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 10:04:52 +0100
X-Gm-Features: Ac12FXzT_nUo_pc5DVSZe7MCVWetnVOe_MEf4xDVHG7HfLhnM0-h1hSJpvK2dfc
Message-ID: <CAFEAcA9wQ8qh3Ah+QNNXY6u8ut6ZMVqaxFTvDDhvEGYrazFPsA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] target/arm: Added support for SME register
 exposure to
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 11 Aug 2025 at 20:37, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> The QEMU GDB stub does not expose the ZA storage SME register to GDB via
> the remote serial protocol, which can be a useful functionality to debug SME
> code. To provide this functionality in Aarch64 target, this patch registers the
> SME register set with the GDB stub. To do so, this patch implements the
> aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> specify how to get and set the SME registers, and the
> arm_gen_dynamic_smereg_feature() function to generate the target
> description in XML format to indicate the target architecture supports SME.
> Finally, this patch includes a dyn_smereg_feature structure to hold this
> GDB XML description of the SME registers for each CPU.
>
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
>  target/arm/cpu.h       |   1 +
>  target/arm/gdbstub.c   |   6 ++
>  target/arm/gdbstub64.c | 122 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/internals.h |   3 +
>  4 files changed, 132 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index dc9b6dce4c..8bd66d7049 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -933,6 +933,7 @@ struct ArchCPU {
>
>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>      DynamicGDBFeatureInfo dyn_svereg_feature;
> +    DynamicGDBFeatureInfo dyn_smereg_feature;
>      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
>      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
>
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index ce4497ad7c..4371a367a0 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>              GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
>              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                       aarch64_gdb_set_sve_reg, feature, 0);
> +            if (isar_feature_aa64_sme(&cpu->isar)) {
> +                GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
> +                    cs->gdb_num_regs);
> +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> +            }

It's possible to have SME without SVE, so this should not be
inside the "if we have SVE" check.

>          } else {
>              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
>                                       aarch64_gdb_set_fpu_reg,
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 08e2858539..047b1f8133 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -249,6 +249,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
>      return 0;
>  }
>
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    switch (reg) {
> +    /* Svg register */
> +    case 0:

We should comment what all the cases here are; the usual ploce to
put such a comment is either on the same line as the case, or else
on the line immediately after the case if the comment would be
too long to put on the same line.

The capitalization here is odd, too: the register is either "SVG" or "svg".

> +    {
> +        int vq = 0;
> +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
> +            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
> +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
> +        }
> +        /* svg = vector granules (2 * vector quardwords) in streaming mode */
> +        return gdb_get_reg64(buf, vq * 2);
> +    }
> +    case 1:
> +        return gdb_get_reg64(buf, env->svcr);
> +    case 2:
> +    {
> +        int len = 0;
> +        int vq = cpu->sme_max_vq;
> +        int svl = vq * 16;
> +        for (int i = 0; i < svl; i++) {
> +            for (int q = 0; q < vq; q++) {
> +                len += gdb_get_reg128(buf,
> +                           env->za_state.za[i].d[q * 2 + 1],
> +                           env->za_state.za[i].d[q * 2]);
> +            }
> +        }
> +        return len;
> +    }
> +    default:
> +        /* gdbstub asked for something out of range */
> +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    switch (reg) {
> +    case 0:
> +    {
> +        /* cannot set svg via gdbstub */
> +        return 8;
> +    }

You don't need braces here, because there are no local variables
in this arm of the switch statement.

> +    case 1:
> +        aarch64_set_svcr(env, ldq_le_p(buf),
> +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> +        return 8;
> +    case 2:
> +        int len = 0;
> +        int vq = cpu->sme_max_vq;
> +        int svl = vq * 16;

But you do need braces here, because there are local variables.
This is (a) because our coding style requires that declarations
go at the top of a block and (b) because clang will complain:

../../target/arm/gdbstub64.c:310:9: error: label followed by a
declaration is a C23 extension [-Werror,-Wc23-extensions]
  310 |         int len = 0;
      |         ^

> +        for (int i = 0; i < svl; i++) {
> +            for (int q = 0; q < vq; q++) {
> +                if (target_big_endian()){

Missing space before the {

> +                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
> +                    buf += 8;
> +                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
> +                } else{
> +                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
> +                    buf += 8;
> +                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
> +                }
> +                buf += 8;
> +                len += 16;
> +            }
> +        }
> +        return len;
> +    default:
> +        /* gdbstub asked for something out of range */
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
>  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -413,6 +498,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
>      return &cpu->dyn_svereg_feature.desc;
>  }
>
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    int vq = cpu->sme_max_vq;
> +    int svl = vq * 16;
> +    GDBFeatureBuilder builder;
> +    int reg = 0;
> +
> +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
> +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
> +
> +
> +    /* Create the sme_bv vector type. */
> +    gdb_feature_builder_append_tag(&builder,
> +        "<vector id=\"sme_bv\" type=\"uint8\" count=\"%d\"/>",
> +        svl);
> +
> +    /* Create the sme_bvv vector type. */
> +    gdb_feature_builder_append_tag(
> +        &builder, "<vector id=\"sme_bvv\" type=\"sme_bv\" count=\"%d\"/>",
> +        svl);
> +
> +    /* Define the svg, svcr, and za registers. */
> +
> +    /* fpscr & status registers */
> +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
> +        "sme_bvv", NULL);
> +
> +    gdb_feature_builder_end(&builder);
> +
> +    return &cpu->dyn_smereg_feature.desc;
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
>  {
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1b3d0244fd..41e05066b9 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1802,8 +1802,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
>  }
>
>  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
>  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
> --

thanks
-- PMM

