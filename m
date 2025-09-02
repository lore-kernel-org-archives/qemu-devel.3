Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E670CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOVz-000797-8B; Tue, 02 Sep 2025 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOVv-00077P-6A
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:45:23 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utOVs-0002cQ-S6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:45:22 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d60504788so42389027b3.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809918; x=1757414718; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJmO/c3N4MGTaS2/0iRyPF/GLVfR6SnUkliQAn+eVD8=;
 b=FrlfmpxTJxdUfmJwAeKIVTrMwPUop4681tBZlSK8wN5EmUFJ4JCVgj7WxvD5HeqzSH
 4aIl1gbUZxIpsTPsh5D6GOgMqaEBOr0mlqxJd/tCtrxeg4S9Cfpicpw7wLcm+TFKVdSE
 MrXYmBr9NHwl2DoLAfAZ0JTwFbh9QvlZWBAH3252lVNLo7/CPwAX4ipHmRz0yO8tVYbv
 19NViuZau5GpZZVmKBO5bhl5jKA8sxzA+8pQ1Oeqf6kOrCPypVEMA3XWgN2zTpwVpgVH
 tOY4V/xxwhy2Tdv7TCyi+c0EsvbtcBOK34+aVCjA5vNEbNNIbs3eWimFKUpi8RkzYEr5
 8g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809918; x=1757414718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJmO/c3N4MGTaS2/0iRyPF/GLVfR6SnUkliQAn+eVD8=;
 b=IY/5eLlNDL552DyoLeRXdz/TD+5SLZ+q88R45pqqFek9Bpwxfhxp/vkgTsdqe8XwlF
 u255XbVRNZWIBjqi3a8omJcY5Fo8ESS7C8KnVxxe8kJXeiNUHX6GiTmEFQdaLie+kmwC
 cyec2J6UHX5ytNfctXn3/RvGKUsV4UtHSGvMe3CB5EyvfYVCVwy7ur5ZSUFWthLb48/R
 QT6CCh30FVweqXCrFzT8/4kVD8Qywx1jKVaoFG5qgAIDL7LgFaG4F9l8XaWGQnr0AiSj
 P+WiNTz/K55Ifl6iF9WVT5OrtJLjbAVZsEQpLP7HNg0boa532dQKlxDXGpeUgd5rBG4C
 g+LQ==
X-Gm-Message-State: AOJu0Yy8GswjWrdTebMG5zew8wM2Fl0T93lIQkKjayrtd/PXgGv5NAKY
 6H4HE6NtegQtCyxG2WHlXHzhNqhrcEQkIBWcsuuNkg+szztQ88VFFL9Vfy06AJC6uefyjgwvzps
 2798rRytJBoUzV6PpyLHpV7A+ZZ8cdQdXCC3vOZ4n+w==
X-Gm-Gg: ASbGncsNiX68KaE3U+blEJvDvbleR4pGyTKVS6cyf0bE2Vb86EsDFVH30+yLxPqFqZo
 DYjlALZiStLfC08xxo6iRBR0Psc1uZxmyf9T1MZ20Uff3J1WlP5r13Ocm9nUaFI83QSEGe5VF2M
 NWk8HiReWGJDvce+rH6DT+LdfBQmqJhPGmUCPzZKq76W4owcxyKMH82ffFk2jk81jItipNNPFPK
 hCGB6lqIgXKdFS2/Mf3rEaOuL+bcA==
X-Google-Smtp-Source: AGHT+IFMJuQO0HRXma1h0OhPC5AlupP4yc9JSHY47VFhD+wmYQTYkR+P+1f3ggnrRomLguEhNlqR2Yoaff6nn/29W/A=
X-Received: by 2002:a05:690c:8e14:b0:722:85cc:3970 with SMTP id
 00721157ae682-72285cc3ea6mr88517777b3.4.1756809917995; Tue, 02 Sep 2025
 03:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250826185052.511223-1-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250826185052.511223-1-vacha.bhavsar@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 11:45:06 +0100
X-Gm-Features: Ac12FXyRLQ9v8m7FMZl0F4wdnoPuTMj1-GtoX6r9N6H02ZQD_Y6_n5zdHuN3G_o
Message-ID: <CAFEAcA_R4tZTtP875VJM3_o_fTL=oo05GcCXO479eq3VNgDpLA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] target/arm: Added support for SME register
 exposure to GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 26 Aug 2025 at 19:50, Vacha Bhavsar
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
> Changes since v5:
> - added code to handle the case when we have SME without SVE
> - added comments to indicate th cases in aarch64_gdb_get/set_sme_reg
> - added/removed braces where necessary
> - corrected capitalization in comments
> ---
>  target/arm/cpu.h       |   1 +
>  target/arm/gdbstub.c   |   9 ++-
>  target/arm/gdbstub64.c | 121 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/internals.h |   3 +
>  4 files changed, 133 insertions(+), 1 deletion(-)
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
> index ce4497ad7c..110258ec18 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -527,7 +527,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>           * registers so we don't need to include both.
>           */
>  #ifdef TARGET_AARCH64
> -        if (isar_feature_aa64_sve(&cpu->isar)) {
> +        if (isar_feature_aa64_sve(&cpu->isar) || isar_feature_aa64_sme(&cpu->isar)) {
>              GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
>              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                       aarch64_gdb_set_sve_reg, feature, 0);
> @@ -537,6 +537,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>                                       gdb_find_static_feature("aarch64-fpu.xml"),
>                                       0);
>          }
> +
> +        if (isar_feature_aa64_sme(&cpu->isar)) {
> +            GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
> +                cs->gdb_num_regs);

Your indent here and below for function calls on multiple
lines is wrong -- follow the way the existing code does it,
where the second line lines up with the first argument
after the '('.  (We sometimes make an exception where the wrapping
would look terrible, but this is the usual approach.)

> +            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> +                aarch64_gdb_set_sme_reg, sme_feature, 0);
> +        }
>          /*
>           * Note that we report pauth information via the feature name
>           * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 08e2858539..d3fd94b93d 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -249,6 +249,90 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
>      return 0;
>  }
>
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    switch (reg) {
> +    case 0: /* svg register */
> +    {
> +        int vq = 0;
> +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
> +            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
> +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
> +        }
> +        /* svg = vector granules (2 * vector quardwords) in streaming mode */
> +        return gdb_get_reg64(buf, vq * 2);
> +    }
> +    case 1: /* svcr register */
> +        return gdb_get_reg64(buf, env->svcr);
> +    case 2: /* za register */
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
> +    case 0: /* svg register */
> +        /* cannot set svg via gdbstub */
> +        return 8;
> +    case 1: /* svcr register */
> +        aarch64_set_svcr(env, ldq_le_p(buf),
> +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> +        return 8;
> +    case 2: /* za register */
> +    {
> +        int len = 0;
> +        int vq = cpu->sme_max_vq;
> +        int svl = vq * 16;
> +        for (int i = 0; i < svl; i++) {
> +            for (int q = 0; q < vq; q++) {
> +                if (target_big_endian()) {
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
> +    }
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
> @@ -413,6 +497,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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

https://sourceware.org/gdb/current/onlinedocs/gdb.html/AArch64-Features.html#AArch64-Features

says ZA should be a vector of bytes, not a vector of a vector of bytes.
Is it wrong ?

> +
> +    /* Define the svg, svcr, and za registers. */
> +
> +    /* fpscr & status registers */

This comment seems to be wrong and can be deleted.

> +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
> +        "sme_bvv", NULL);

We will also want to have support for the org.gnu.gdb.aarch64.sme2
feature (which has the ZT0 register), but we can add that as
a separate patch later.

> +
> +    gdb_feature_builder_end(&builder);
> +
> +    return &cpu->dyn_smereg_feature.desc;
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
>  {

thanks
-- PMM

