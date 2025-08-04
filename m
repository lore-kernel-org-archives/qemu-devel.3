Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD7C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiz88-0002M9-MB; Mon, 04 Aug 2025 13:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixDi-0003QR-Dh
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:35:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixDg-0003oj-DK
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:35:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45896cf24ebso34134695e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754321721; x=1754926521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/u6Q56xQ9Q60idVE0Rf2O5HxxiFQLiMDAsQ3NR474Q=;
 b=Vl5ZCew/FHpELAw/Mhtnv2BRVpgvb0l3tbJ0OC6CYkFIFMns4JGSDnF/H8DBkzeLKE
 rQAJh+a1nVxXPKb3Ll/b0a+p0kmVFSJ0kF2tmr4eIDJ2JdqtkGymPxyHu5LJ/2P59eTj
 c3xXnOVYOJlaOlfvpI2pMPRxEX8kslm8emLgfWrpG24Qj3upwDIE5l+lG6T7sgN/RYBz
 I22MU+8ceBnXsHJ2Xgxn0CU8c40fhd0ltbabkWog742LCL1poAHqRgKyNC778L/7E1M1
 JWQUPDmAGClb06y/VVhPiEOHUi3ZKRgoVnkCnFz9EvrKOf3JOlbyZoUaBIz+ZyI1cs4q
 apgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321721; x=1754926521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/u6Q56xQ9Q60idVE0Rf2O5HxxiFQLiMDAsQ3NR474Q=;
 b=snbDO0mJsRhPAAsd2N1SAPZ0B5/6eF3e8Zw6JFqGx2fFMGEq3p8ZZaJMDx1fDYL6vQ
 9L0qs1w/KLcxE06fqalbuQfgfYncGSAeqIInX7KPKgR3TQZD7cK327IzAWtWgvCSN+IU
 PmSQD1o1XpMcmqRu7DyWNh48Et/0axzlNMUs6FUpD/nXUES1d0INSULoaZQlEjWnan1P
 LRDmGOxmErJDW9/i/R/UfYTMFytOcMtsKC1UMV7tLeN2YWNWGRVWSgv0pc/1qSMLWLk/
 0jp5/t5NtgRmZjQ3eph33L6iBkfn4j52Wmi9Z2kX6VtdeHIt4/0+LX+8muNZQC04r8/2
 TpGQ==
X-Gm-Message-State: AOJu0YwSqkeIHgU8G0N5EbTVoiwKnXOzM2+09gTLxfCUghTIHaQvURkB
 A2M3Qgr4mA9wXc+6IHEXru+qyHH8IOpQ9+vTjVKL1ypZWaN2t1JTLINUdfVC3HxJGKhB7ru6VfL
 OXasj
X-Gm-Gg: ASbGncv4CGvD+ykJT0GacqrW7rHEVNmRuEXRtoPM7wWDltoS870K0lqoF8OVhbyjUvj
 VzVvYZ7n27m/0ZFmLZ+oGAChotCuf6poa08i0dKNYN7YwvtGgOzn7KBbOfUw7pSK3/RLqGn0AvP
 KH25hgez3LmTGERGscN3rPjy1tsJFiuH/cc07EBPBMc4u4049/3rpIUIsaG9nTOn47TU/zIkQeU
 YyBg9m5w7K5nL9CkgfaECuKaWzg2JIq3OwlDvqMqSCsihX1nuMYu1fcJ2HA1Z4v2HP3wiVYBx5C
 VENr5BsZT8yDkWXBATgole15M32Ldbo5jc4EEV+ekPUFWB/PYG806mpXzDGyKEf3PSk25kkz5Lm
 o3dZbemtMCuW1r380SqkeAfQ=
X-Google-Smtp-Source: AGHT+IFqQUOBKKZEgGG/c0ipwJjNPhw5AbtQVhRlFRmiVdEzAUi1xxMrnWMN6Qt3GFKx3ktFnQF1jw==
X-Received: by 2002:a05:600c:1f84:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-458b6b666famr57936465e9.25.1754321720851; 
 Mon, 04 Aug 2025 08:35:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458ba5ef18asm96488305e9.12.2025.08.04.08.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:35:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5FC5F5F88A;
 Mon, 04 Aug 2025 16:35:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v4 2/2] target/arm: Added support for SME register
 exposure to GDB
In-Reply-To: <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com> (Vacha
 Bhavsar's message of "Tue, 22 Jul 2025 20:14:04 +0000")
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 16:35:19 +0100
Message-ID: <87zfcf5cco.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:

> The QEMU GDB stub does not expose the ZA storage SME register to GDB via
> the remote serial protocol, which can be a useful functionality to debug =
SME
> code. To provide this functionality in Aarch64 target, this patch registe=
rs the
> SME register set with the GDB stub. To do so, this patch implements the
> aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> specify how to get and set the SME registers, and the
> arm_gen_dynamic_smereg_feature() function to generate the target
> description in XML format to indicate the target architecture supports SM=
E.
> Finally, this patch includes a dyn_smereg_feature structure to hold this
> GDB XML description of the SME registers for each CPU.
>
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
> Changes since v3:
> - added changes to aarch64_gdb_set_sme_reg() to address the concerns=20
> brought up in review regarding endianness
>
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
>=20=20
>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>      DynamicGDBFeatureInfo dyn_svereg_feature;
> +    DynamicGDBFeatureInfo dyn_smereg_feature;
>      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
>      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
>=20=20
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index ce4497ad7c..9c942c77cc 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *=
cpu)
>              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs, c=
s->gdb_num_regs);
>              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                       aarch64_gdb_set_sve_reg, feature, 0=
);
> +            if (isar_feature_aa64_sme(&cpu->isar)) {
> +                GDBFeature *sme_feature =3D arm_gen_dynamic_smereg_featu=
re(cs,
> +                                             cs->gdb_num_regs);
> +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> +            }
>          } else {
>              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
>                                       aarch64_gdb_set_fpu_reg,
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 64ee9b3b56..3d86980bc9 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *b=
uf, int reg)
>      return 0;
>  }
>=20=20
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    switch (reg) {
> +    /* Svg register */
> +    case 0:
> +    {
> +        int vq =3D 0;
> +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
> +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
> +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
> +        }
> +        /* svg =3D vector granules (2 * vector quardwords) in streaming =
mode */
> +        return gdb_get_reg64(buf, vq * 2);
> +    }
> +    case 1:
> +        return gdb_get_reg64(buf, env->svcr);
> +    case 2:
> +    {
> +        int len =3D 0;
> +        int vq =3D cpu->sme_max_vq;
> +        int svl =3D vq * 16;
> +        for (int i =3D 0; i < svl; i++) {
> +            for (int q =3D 0; q < vq; q++) {
> +                len +=3D gdb_get_reg128(buf,
> +                           env->za_state.za[i].d[q * 2 + 1],
> +                           env->za_state.za[i].d[q * 2]);
> +            }
> +        }
> +        return len;
> +    }
> +    default:
> +        /* gdbstub asked for something out of range */
> +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func_=
_, reg);
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    switch (reg) {
> +    case 0:
> +    {
> +        /* cannot set svg via gdbstub */
> +        return 8;
> +    }
> +    case 1:
> +        aarch64_set_svcr(env, ldq_le_p(buf),
> +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> +        return 8;
> +    case 2:
> +        int len =3D 0;
> +        int vq =3D cpu->sme_max_vq;
> +        int svl =3D vq * 16;
> +        for (int i =3D 0; i < svl; i++) {
> +            for (int q =3D 0; q < vq; q++) {
> +                if (target_big_endian()){
> +                    env->za_state.za[i].d[q * 2 + 1] =3D ldq_p(buf);
> +                    buf +=3D 8;
> +                    env->za_state.za[i].d[q * 2] =3D ldq_p(buf);
> +                } else{
> +                    env->za_state.za[i].d[q * 2] =3D ldq_p(buf);
> +                    buf +=3D 8;
> +                    env->za_state.za[i].d[q * 2 + 1] =3D ldq_p(buf);
> +                }
> +                buf +=3D 8;
> +                len +=3D 16;
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
>      ARMCPU *cpu =3D ARM_CPU(cs);
> @@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState =
*cs, int base_reg)
>      return &cpu->dyn_svereg_feature.desc;
>  }
>=20=20
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    int vq =3D cpu->sme_max_vq;
> +    int svl =3D vq * 16;
> +    GDBFeatureBuilder builder;
> +    int reg =3D 0;
> +
> +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
> +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
> +
> +
> +    /* Create the sme_bv vector type. */
> +    gdb_feature_builder_append_tag(&builder,
> +        "<vector id=3D\"sme_bv\" type=3D\"uint8\" count=3D\"%d\"/>",
> +        svl);
> +
> +    /* Create the sme_bvv vector type. */
> +    gdb_feature_builder_append_tag(
> +        &builder, "<vector id=3D\"sme_bvv\" type=3D\"sme_bv\" count=3D\"=
%d\"/>",
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
> index c4765e4489..760e1c6490 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMStat=
e *env)
>  }
>=20=20
>  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
>  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);

It would also be nice to add a test for this, see tests/tcg/aarch64/gdbstub=
/test-sve.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

