Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA0FD530D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtYa-0000Hq-1G; Fri, 27 Feb 2026 03:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvtYY-0000HO-7B
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:50:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvtYV-000176-5W
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:50:41 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43984d7e49bso1569522f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:50:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772182237; cv=none;
 d=google.com; s=arc-20240605;
 b=YLbcdNbNaNcnPc6mY4DVoEfzAFStsI1c2ZLO3P97qky2Iq6i1XfABJLIfX1NvpL/xh
 nFC/FgXoc9ojOx4yZoo7ntIRmrFT8pRhKDiBiOgSYN9en/7NYcO3b7KooxYnP/2FrcZ7
 mnBQg0fuW+a9QzaDtQYff5aovqAFl3mCdExYLSs8o7jIb0FS4v5ezQT4e3cfoBYz62SE
 9HlKmrdJ0gvaCZdv4f/dSBx/e0epkkWFx5HL7ifbCBspxDIlAI0Fvhznt1cZlU5sxRgg
 MG5wxRQsdweOzBZuHmxUF7xtL1M7vgPGRMDk9L1CJHwt4qoMtighrSnTDW5RoWG75ApS
 HOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hRBglSycTQjd3Rk8PFYlHEvxL7q9EQmKm59mf5HV1Rw=;
 fh=WDn/ho1m3nbphK46GCZowN5Ubh/T1/DiNU4t1NYUzIs=;
 b=fDryh8IZjpLB0gTJNP2PCWAVh6PfNcEcO6Wn1SvyUqvFxSId0LaI+t5UNH42HRvGYB
 SMtbYVgcEK+nCOXkhgyy3QHv7/vYaYsnkutj1M48/LasKklLoXRymXGed2M6y/x8EZ43
 vsuB7tCEFY7iU8LLCXar6f+Z5KIw9JMIVcHCVNwNQEIBXGqUDpUAIsNy2TsjVPK6556/
 2BSxHZifnstT1DI5DuRa7f0PBK1fyuvPyTS4Wngt2Xl4z+hSqOQaUS9Y0P/OMZM8smyl
 iKQegXRK0p42RPZ6TZliOa3g4fuXrP2Da+nr3/TEC1WtHjq3h2G3eKi3f8hk/9dO7FgO
 t26Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772182237; x=1772787037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRBglSycTQjd3Rk8PFYlHEvxL7q9EQmKm59mf5HV1Rw=;
 b=EoDmwiybyjo0lYEVBq5Zk3hh1u45OlHcnwJuLBRyNPm0CfIZd2p5jTrrFpbe6Nepss
 ixxltzyksd/Ho7AjeqBMfDSWlokTWBp3r8KqrS4npj2LrSF7QMXj04JE/3IR9AnqkOz/
 KXHHNadZkWHpP5NG3XTP4vGh35qg6E1BXJwQ6Rq1sJgZVJVzfgwqP4DUgaBM9Jg0Qllm
 0jrNvua7JcFdRftCSSTEuPgDOUhQicRC/SjufUTl85I2ldWrYl/DgYh0mf1ZreC7S0rc
 R2KeQBhU950bnHJaGDmxkzvxM1eQ1WGTTLyKlvcUiyiryLQZ1zSwkEulgj5oJZfPe9tC
 FJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772182237; x=1772787037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hRBglSycTQjd3Rk8PFYlHEvxL7q9EQmKm59mf5HV1Rw=;
 b=v8KH+h9qeNzCdoIta+cIPmohtG1dNLOTy0IZ1tsW7H/ifxNff9Ccwt89uWr3XWnBNA
 GDz0yfLMcBlUY2xDi8rTSroHhIPziFFdU5/8GAInP9aexu26Q76VHMgM7hgjsdbj/XGW
 /IUGUfwl7t0K9Wc6KrLQ+b1JWpCgyVNrHj5A//tUuNnlz/vq99l/w81knMGlA8TYaWJl
 bpIrKQt20ODkQn31wX9aXmFBfEMu2086a9vr0GIf8md7A0dIFZTNZ1+VwQoGSboIm1q3
 LuTV3z4tIrRYnucLOAoKBxvTuBzR0YKNG0lfvPfnqthuVuQVG07ikHsM9pEHzHNwBsas
 807A==
X-Gm-Message-State: AOJu0YztaNoILqJF7PluQ5mvDCKPDatKTPtJRqrL1BhIesyobCvUozyh
 zADNfzAaP99kl3Qp5P9q8DSkhqb6hipJgzp8w/M5I1+UcnGwrPMkE9eyS3GmB8Y4CeDAvSkXXJk
 LbusC4eMlaKgkh///Eh/MHyL0s5y7GE8Sr/9FgmHo8ZhuJbxZkU3qFYAExw==
X-Gm-Gg: ATEYQzxSRBnARtmTKf23+eok9PYfiA7U6k+mzqbaFUICFAHmHtB208sXr1tYasJOj0w
 PRDwkGkKlv2OCLLBL4SZ8mMh/ZSe50xYYVxS64rIGIGG6JqVxV3Cl1RLtJdZvSHL9IKYRgWcoCP
 MB3OURSqxvRFI41QIgWQB5oR/ltsr+0I9b8x6HRZWJuDDIF7D4lO3Jter8mzFEWhAirv1qFTR+f
 Z5p7AdnQsW9qj2Bf/bg7Np+mTFI38+7hSPhqY4Bl0QFI6lND7iWDFWtz22AQ5dVVk7RCR31A1Ld
 HEAKYa2sugv589GJtoFjK3b6kZclUiyhfAx6n+RMn0q2tWyvmw==
X-Received: by 2002:a05:6000:3104:b0:439:9799:dd4b with SMTP id
 ffacd0b85a97d-4399de2d997mr3160533f8f.59.1772182237042; Fri, 27 Feb 2026
 00:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20260227-sme2-hvf-v4-0-3dae31a1876d@linaro.org>
 <20260227-sme2-hvf-v4-1-3dae31a1876d@linaro.org>
In-Reply-To: <20260227-sme2-hvf-v4-1-3dae31a1876d@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 10:50:10 +0200
X-Gm-Features: AaiRm532IukyS1b6Y81t82SIlZzP_oUhBvh3APSyj7S0uPIKr-Jp7SxuCD18OhY
Message-ID: <CAAjaMXbyOZuY+hOLnhpKgxUa9QfFZcktoVq1izZ9DX9dwP-DEA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hvf/arm: handle FEAT_SME2 migration
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Fri, Feb 27, 2026 at 10:01=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> SME2 support adds the following state for HVF guests:
>
> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>   not support it)
> - Predicate registers P0, .., P15 (also FEAT_SVE)
> - ZA register
> - ZT0 register
> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> - SMPRI_EL1 which handles the PE's priority in the SMCU
> - TPIDR2_EL0 the thread local ID register for SME
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  target/arm/hvf/hvf.c           | 290 +++++++++++++++++++++++++++++++++++=
+++++-
>  target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++++++
>  target/arm/hvf/sysreg.c.inc    |   8 ++
>  target/arm/hvf_arm.h           |  41 ++++++
>  target/arm/machine.c           |   2 +-
>  5 files changed, 496 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d79469ca27f794139b8073e25fc16d470b1942d5..ce62f8c97876e3fd948fad96d=
f631f1b53db5e67 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -395,6 +395,60 @@ static const struct hvf_reg_match hvf_fpreg_match[] =
=3D {
>      { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
>  };
>
> +static const struct hvf_reg_match hvf_sme2_zreg_match[] =3D {
> +    { HV_SME_Z_REG_0, offsetof(CPUARMState, vfp.zregs[0]) },
> +    { HV_SME_Z_REG_1, offsetof(CPUARMState, vfp.zregs[1]) },
> +    { HV_SME_Z_REG_2, offsetof(CPUARMState, vfp.zregs[2]) },
> +    { HV_SME_Z_REG_3, offsetof(CPUARMState, vfp.zregs[3]) },
> +    { HV_SME_Z_REG_4, offsetof(CPUARMState, vfp.zregs[4]) },
> +    { HV_SME_Z_REG_5, offsetof(CPUARMState, vfp.zregs[5]) },
> +    { HV_SME_Z_REG_6, offsetof(CPUARMState, vfp.zregs[6]) },
> +    { HV_SME_Z_REG_7, offsetof(CPUARMState, vfp.zregs[7]) },
> +    { HV_SME_Z_REG_8, offsetof(CPUARMState, vfp.zregs[8]) },
> +    { HV_SME_Z_REG_9, offsetof(CPUARMState, vfp.zregs[9]) },
> +    { HV_SME_Z_REG_10, offsetof(CPUARMState, vfp.zregs[10]) },
> +    { HV_SME_Z_REG_11, offsetof(CPUARMState, vfp.zregs[11]) },
> +    { HV_SME_Z_REG_12, offsetof(CPUARMState, vfp.zregs[12]) },
> +    { HV_SME_Z_REG_13, offsetof(CPUARMState, vfp.zregs[13]) },
> +    { HV_SME_Z_REG_14, offsetof(CPUARMState, vfp.zregs[14]) },
> +    { HV_SME_Z_REG_15, offsetof(CPUARMState, vfp.zregs[15]) },
> +    { HV_SME_Z_REG_16, offsetof(CPUARMState, vfp.zregs[16]) },
> +    { HV_SME_Z_REG_17, offsetof(CPUARMState, vfp.zregs[17]) },
> +    { HV_SME_Z_REG_18, offsetof(CPUARMState, vfp.zregs[18]) },
> +    { HV_SME_Z_REG_19, offsetof(CPUARMState, vfp.zregs[19]) },
> +    { HV_SME_Z_REG_20, offsetof(CPUARMState, vfp.zregs[20]) },
> +    { HV_SME_Z_REG_21, offsetof(CPUARMState, vfp.zregs[21]) },
> +    { HV_SME_Z_REG_22, offsetof(CPUARMState, vfp.zregs[22]) },
> +    { HV_SME_Z_REG_23, offsetof(CPUARMState, vfp.zregs[23]) },
> +    { HV_SME_Z_REG_24, offsetof(CPUARMState, vfp.zregs[24]) },
> +    { HV_SME_Z_REG_25, offsetof(CPUARMState, vfp.zregs[25]) },
> +    { HV_SME_Z_REG_26, offsetof(CPUARMState, vfp.zregs[26]) },
> +    { HV_SME_Z_REG_27, offsetof(CPUARMState, vfp.zregs[27]) },
> +    { HV_SME_Z_REG_28, offsetof(CPUARMState, vfp.zregs[28]) },
> +    { HV_SME_Z_REG_29, offsetof(CPUARMState, vfp.zregs[29]) },
> +    { HV_SME_Z_REG_30, offsetof(CPUARMState, vfp.zregs[30]) },
> +    { HV_SME_Z_REG_31, offsetof(CPUARMState, vfp.zregs[31]) },
> +};
> +
> +static const struct hvf_reg_match hvf_sme2_preg_match[] =3D {
> +    { HV_SME_P_REG_0, offsetof(CPUARMState, vfp.pregs[0]) },
> +    { HV_SME_P_REG_1, offsetof(CPUARMState, vfp.pregs[1]) },
> +    { HV_SME_P_REG_2, offsetof(CPUARMState, vfp.pregs[2]) },
> +    { HV_SME_P_REG_3, offsetof(CPUARMState, vfp.pregs[3]) },
> +    { HV_SME_P_REG_4, offsetof(CPUARMState, vfp.pregs[4]) },
> +    { HV_SME_P_REG_5, offsetof(CPUARMState, vfp.pregs[5]) },
> +    { HV_SME_P_REG_6, offsetof(CPUARMState, vfp.pregs[6]) },
> +    { HV_SME_P_REG_7, offsetof(CPUARMState, vfp.pregs[7]) },
> +    { HV_SME_P_REG_8, offsetof(CPUARMState, vfp.pregs[8]) },
> +    { HV_SME_P_REG_9, offsetof(CPUARMState, vfp.pregs[9]) },
> +    { HV_SME_P_REG_10, offsetof(CPUARMState, vfp.pregs[10]) },
> +    { HV_SME_P_REG_11, offsetof(CPUARMState, vfp.pregs[11]) },
> +    { HV_SME_P_REG_12, offsetof(CPUARMState, vfp.pregs[12]) },
> +    { HV_SME_P_REG_13, offsetof(CPUARMState, vfp.pregs[13]) },
> +    { HV_SME_P_REG_14, offsetof(CPUARMState, vfp.pregs[14]) },
> +    { HV_SME_P_REG_15, offsetof(CPUARMState, vfp.pregs[15]) },
> +};
> +
>  /*
>   * QEMU uses KVM system register ids in the migration format.
>   * Conveniently, HVF uses the same encoding of the op* and cr* parameter=
s
> @@ -406,22 +460,201 @@ static const struct hvf_reg_match hvf_fpreg_match[=
] =3D {
>  #define HVF_TO_KVMID(HVF)  \
>      (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>
> -/* Verify this at compile-time. */
> +/*
> + * Verify this at compile-time.
> + *
> + * SME2 registers are guarded by a runtime availability attribute instea=
d of a
> + * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() =
below.
> + */
>
>  #define DEF_SYSREG(HVF_ID, ...) \
>    QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
> +#define DEF_SYSREG_15_02(...)
>
>  #include "sysreg.c.inc"
>
>  #undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
>
>  #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
> +#define DEF_SYSREG_15_02(...)
>
>  static const hv_sys_reg_t hvf_sreg_list[] =3D {
>  #include "sysreg.c.inc"
>  };
>
>  #undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +
> +#define DEF_SYSREG(...)
> +#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
> +
> +API_AVAILABLE(macos(15.2))
> +static const hv_sys_reg_t hvf_sreg_list_sme2[] =3D {
> +#include "sysreg.c.inc"
> +};
> +
> +#undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +
> +/*
> + * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which a=
re
> + * accessible with the SVCR pseudo-register. However, in the HVF API thi=
s is
> + * not exposed as a system-register (i.e. HVF_SYS_REG_SVCR) but a custom
> + * struct, hv_vcpu_sme_state_t. So we need to define our own KVMID in or=
der to
> + * store it in cpreg_values and make it migrateable.
> + */
> +#define SVCR KVMID_AA64_SYS_REG64(3, 3, 4, 2, 2)
> +
> +API_AVAILABLE(macos(15.2))
> +static void hvf_arch_put_sme(CPUState *cpu)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> +    const size_t z_size =3D svl_bytes;
> +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> +    const size_t za_size =3D svl_bytes * svl_bytes;
> +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> +    hv_return_t ret;
> +    uint64_t svcr;
> +    int n;
> +
> +    /*
> +     * Set PSTATE.{SM,ZA} bits
> +     */
> +    svcr =3D arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1];
> +    env->svcr =3D svcr;
> +
> +    /*
> +     * Construct SVCR (PSTATE.{SM,ZA}) state to pass to HVF:
> +     */
> +    sme_state.streaming_sve_mode_enabled =3D FIELD_EX64(env->svcr, SVCR,=
 SM) > 0;
> +    sme_state.za_storage_enabled =3D FIELD_EX64(env->svcr, SVCR, ZA) > 0=
;
> +    ret =3D hv_vcpu_set_sme_state(cpu->accel->fd, &sme_state);
> +    assert_hvf_ok(ret);
> +
> +    /*
> +     * We only care about Z/P registers if we're in streaming SVE mode, =
i.e.
> +     * PSTATE.SM is set, because only then can instructions that access =
them be
> +     * used. We don't care about the register values otherwise. This is =
because
> +     * when the processing unit exits/enters this mode, it zeroes out th=
ose
> +     * registers.
> +     */
> +    if (sme_state.streaming_sve_mode_enabled) {
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> +            ret =3D hv_vcpu_set_sme_z_reg(cpu->accel->fd,
> +                                        hvf_sme2_zreg_match[n].reg,
> +                                        (uint8_t *)&env->vfp.zregs[n].d[=
0],
> +                                        z_size);
> +            assert_hvf_ok(ret);
> +        }
> +
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> +            ret =3D hv_vcpu_set_sme_p_reg(cpu->accel->fd,
> +                                        hvf_sme2_preg_match[n].reg,
> +                                        (uint8_t *)&env->vfp.pregs[n].p[=
0],
> +                                        preg_size);
> +            assert_hvf_ok(ret);
> +        }
> +    }
> +
> +    /*
> +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they=
 are
> +     * zeroed out.
> +     */
> +    if (sme_state.za_storage_enabled) {
> +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> +
> +        memcpy(&tmp, &env->za_state.zt0, 64);
> +        ret =3D hv_vcpu_set_sme_zt0_reg(cpu->accel->fd, &tmp);
> +        assert_hvf_ok(ret);
> +
> +        ret =3D hv_vcpu_set_sme_za_reg(cpu->accel->fd,
> +                                     (uint8_t *)&env->za_state.za,
> +                                     za_size);
> +        assert_hvf_ok(ret);
> +    }
> +
> +    return;
> +}
> +
> +API_AVAILABLE(macos(15.2))
> +static void hvf_arch_get_sme(CPUState *cpu)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    CPUARMState *env =3D &arm_cpu->env;
> +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> +    const size_t z_size =3D svl_bytes;
> +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> +    const size_t za_size =3D svl_bytes * svl_bytes;
> +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> +    hv_return_t ret;
> +    uint64_t svcr;
> +    int n;
> +
> +    /*
> +     * Get SVCR (PSTATE.{SM,ZA}) state from HVF:
> +     */
> +    ret =3D hv_vcpu_get_sme_state(cpu->accel->fd, &sme_state);
> +    assert_hvf_ok(ret);
> +
> +    /*
> +     * Set SVCR first because changing it will zero out Z/P regs
> +     */
> +    svcr =3D
> +        (sme_state.za_storage_enabled ? R_SVCR_ZA_MASK : 0)
> +        | (sme_state.streaming_sve_mode_enabled ? R_SVCR_SM_MASK : 0);
> +
> +    aarch64_set_svcr(env, svcr, R_SVCR_ZA_MASK | R_SVCR_SM_MASK);
> +    arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1] =3D svcr;
> +
> +    /*
> +     * We only care about Z/P registers if we're in streaming SVE mode, =
i.e.
> +     * PSTATE.SM is set, because only then can instructions that access =
them be
> +     * used. We don't care about the register values otherwise. This is =
because
> +     * when the processing unit exits/enters this mode, it zeroes out th=
ose
> +     * registers.
> +     */
> +    if (sme_state.streaming_sve_mode_enabled) {
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> +            ret =3D hv_vcpu_get_sme_z_reg(cpu->accel->fd,
> +                                        hvf_sme2_zreg_match[n].reg,
> +                                        (uint8_t *)&env->vfp.zregs[n].d[=
0],
> +                                        z_size);
> +            assert_hvf_ok(ret);
> +        }
> +
> +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> +            ret =3D hv_vcpu_get_sme_p_reg(cpu->accel->fd,
> +                                        hvf_sme2_preg_match[n].reg,
> +                                        (uint8_t *)&env->vfp.pregs[n].p[=
0],
> +                                        preg_size);
> +            assert_hvf_ok(ret);
> +        }
> +    }
> +
> +    /*
> +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they=
 are
> +     * zeroed out.
> +     */
> +    if (sme_state.za_storage_enabled) {
> +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> +
> +        /* Get ZT0 in a tmp vector, and then copy it to env.za_state.zt0=
 */
> +        ret =3D hv_vcpu_get_sme_zt0_reg(cpu->accel->fd, &tmp);
> +        assert_hvf_ok(ret);
> +
> +        memcpy(&env->za_state.zt0, &tmp, 64);
> +        ret =3D hv_vcpu_get_sme_za_reg(cpu->accel->fd,
> +                                     (uint8_t *)&env->za_state.za,
> +                                     za_size);
> +        assert_hvf_ok(ret);
> +
> +    }
> +
> +    return;
> +}
>
>  static uint32_t hvf_reg2cp_reg(uint32_t reg)
>  {
> @@ -534,6 +767,10 @@ int hvf_arch_get_registers(CPUState *cpu)
>          uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
>          int hvf_id =3D KVMID_TO_HVF(kvm_id);
>
> +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>          if (cpu->accel->guest_debug_enabled) {
>              /* Handle debug registers */
>              switch (hvf_id) {
> @@ -627,6 +864,13 @@ int hvf_arch_get_registers(CPUState *cpu)
>
>          arm_cpu->cpreg_values[i] =3D val;
>      }
> +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            hvf_arch_get_sme(cpu);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }
>      assert(write_list_to_cpustate(arm_cpu));
>
>      aarch64_restore_sp(env, arm_current_el(env));
> @@ -672,6 +916,10 @@ int hvf_arch_put_registers(CPUState *cpu)
>          uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
>          int hvf_id =3D KVMID_TO_HVF(kvm_id);
>
> +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>          if (cpu->accel->guest_debug_enabled) {
>              /* Handle debug registers */
>              switch (hvf_id) {
> @@ -756,6 +1004,14 @@ int hvf_arch_put_registers(CPUState *cpu)
>      ret =3D hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_=
offset);
>      assert_hvf_ok(ret);
>
> +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            hvf_arch_put_sme(cpu);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +    }

This will reset the NEON vector registers we set up earlier in
hvf_arch_put_registers() if transitioning from streaming mode enabled
to disabled. I had tested disabled->{dis,en}abled, enabled->enabled
but not enabled -> disabled. Will send a new revision.

> +
>      return 0;
>  }
>
> @@ -985,6 +1241,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      hv_return_t ret;
>      int i;
>
> +    if (__builtin_available(macOS 15.2, *)) {
> +        sregs_match_len +=3D ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
> +
> +#define DEF_SYSREG_15_02(HVF_ID, ...) \
> +        g_assert(HVF_ID =3D=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_AR=
GS__)));
> +#define DEF_SYSREG(...)
> +
> +#include "sysreg.c.inc"
> +
> +#undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +    }
>      env->aarch64 =3D true;
>
>      /* system count frequency sanity check */
> @@ -1005,7 +1273,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t))=
;
>
>      /* Populate cp list for all known sysregs */
> -    for (i =3D 0; i < sregs_match_len; i++) {
> +    for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
>          hv_sys_reg_t hvf_id =3D hvf_sreg_list[i];
>          uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>          uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> @@ -1016,6 +1284,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>              arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>          }
>      }
> +    if (__builtin_available(macOS 15.2, *)) {
> +        for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> +            hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i];
> +            uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> +            uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> +            const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_re=
gs, key);
> +
> +            if (ri) {
> +                assert(!(ri->type & ARM_CP_NO_RAW));
> +                arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> +            }
> +        }
> +        /*
> +         * Add SVCR last. It is elsewhere assumed its index is after
> +         * hvf_sreg_list and hvf_sreg_list_sme2.
> +         */
> +        arm_cpu->cpreg_indexes[sregs_cnt++] =3D HVF_TO_KVMID(SVCR);
> +    }
>      arm_cpu->cpreg_array_len =3D sregs_cnt;
>      arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
>
> diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stub=
s.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..9c679b711017448681e532b88=
ce10a07ebfd5122
> --- /dev/null
> +++ b/target/arm/hvf/hvf_sme_stubs.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +typedef int32_t hv_return_t;
> +typedef uint64_t hv_vcpu_t;
> +
> +static inline bool hvf_arm_sme2_supported(void)
> +{
> +    return false;
> +}
> +
> +static inline uint32_t hvf_arm_sme2_get_svl(void)
> +{
> +    g_assert_not_reached();
> +}
> +
> +typedef enum hv_sme_p_reg_t {
> +    HV_SME_P_REG_0,
> +    HV_SME_P_REG_1,
> +    HV_SME_P_REG_2,
> +    HV_SME_P_REG_3,
> +    HV_SME_P_REG_4,
> +    HV_SME_P_REG_5,
> +    HV_SME_P_REG_6,
> +    HV_SME_P_REG_7,
> +    HV_SME_P_REG_8,
> +    HV_SME_P_REG_9,
> +    HV_SME_P_REG_10,
> +    HV_SME_P_REG_11,
> +    HV_SME_P_REG_12,
> +    HV_SME_P_REG_13,
> +    HV_SME_P_REG_14,
> +    HV_SME_P_REG_15,
> +} hv_sme_p_reg_t;
> +
> +typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar64_=
t;
> +
> +typedef enum hv_sme_z_reg_t {
> +    HV_SME_Z_REG_0,
> +    HV_SME_Z_REG_1,
> +    HV_SME_Z_REG_2,
> +    HV_SME_Z_REG_3,
> +    HV_SME_Z_REG_4,
> +    HV_SME_Z_REG_5,
> +    HV_SME_Z_REG_6,
> +    HV_SME_Z_REG_7,
> +    HV_SME_Z_REG_8,
> +    HV_SME_Z_REG_9,
> +    HV_SME_Z_REG_10,
> +    HV_SME_Z_REG_11,
> +    HV_SME_Z_REG_12,
> +    HV_SME_Z_REG_13,
> +    HV_SME_Z_REG_14,
> +    HV_SME_Z_REG_15,
> +    HV_SME_Z_REG_16,
> +    HV_SME_Z_REG_17,
> +    HV_SME_Z_REG_18,
> +    HV_SME_Z_REG_19,
> +    HV_SME_Z_REG_20,
> +    HV_SME_Z_REG_21,
> +    HV_SME_Z_REG_22,
> +    HV_SME_Z_REG_23,
> +    HV_SME_Z_REG_24,
> +    HV_SME_Z_REG_25,
> +    HV_SME_Z_REG_26,
> +    HV_SME_Z_REG_27,
> +    HV_SME_Z_REG_28,
> +    HV_SME_Z_REG_29,
> +    HV_SME_Z_REG_30,
> +    HV_SME_Z_REG_31,
> +} hv_sme_z_reg_t;
> +
> +enum {
> +  HV_SYS_REG_SMCR_EL1,
> +  HV_SYS_REG_SMPRI_EL1,
> +  HV_SYS_REG_TPIDR2_EL0,
> +  HV_SYS_REG_ID_AA64ZFR0_EL1,
> +  HV_SYS_REG_ID_AA64SMFR0_EL1,
> +};
> +
> +typedef struct {
> +    bool streaming_sve_mode_enabled;
> +    bool za_storage_enabled;
> +} hv_vcpu_sme_state_t;
> +
> +static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
> +                                                hv_vcpu_sme_state_t *sme=
_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
> +                                                const hv_vcpu_sme_state_=
t *sme_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 uint8_t *value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 const uint8_t *value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  hv_sme_zt0_uchar64_t *=
value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  const hv_sme_zt0_uchar=
64_t *value)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> index 067a8603fa785593ed0879cea26d036b0ec2823e..7a2f880f784b7610b14a6eb91=
fec1817e98bfd2e 100644
> --- a/target/arm/hvf/sysreg.c.inc
> +++ b/target/arm/hvf/sysreg.c.inc
> @@ -145,3 +145,11 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
>  DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
>  DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
>  DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
> +
> +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
> +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
> index 5d19d82e5ded66bc02da10523c0f7138840ecff3..6b1c3b9792dfd7d81ef747d8a=
6676a23fd212d84 100644
> --- a/target/arm/hvf_arm.h
> +++ b/target/arm/hvf_arm.h
> @@ -22,4 +22,45 @@ void hvf_arm_init_debug(void);
>
>  void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
>
> +/*
> + * We need access to types from macOS SDK >=3D15.2, so expose stubs if t=
he
> + * headers are not available until we raise our minimum macOS version.
> + */
> +#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
> +  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200)
> +    #include "system/hvf_int.h"
> +
> +    static inline bool hvf_arm_sme2_supported(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result =3D hv_sme_config_get_max_svl_bytes(&svl_=
bytes);
> +            if (result =3D=3D HV_UNSUPPORTED) {
> +                return false;
> +            }
> +            assert_hvf_ok(result);
> +            return svl_bytes > 0;
> +        } else {
> +            return false;
> +        }
> +    }
> +
> +    static inline uint32_t hvf_arm_sme2_get_svl(void)
> +    {
> +        if (__builtin_available(macOS 15.2, *)) {
> +            size_t svl_bytes;
> +            hv_return_t result =3D hv_sme_config_get_max_svl_bytes(&svl_=
bytes);
> +            assert_hvf_ok(result);
> +            return svl_bytes;
> +        } else {
> +            abort();
> +        }
> +    }
> +  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> +      #include "hvf/hvf_sme_stubs.h"
> +  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> +#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +  #include "hvf/hvf_sme_stubs.h"
> +#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> +
>  #endif
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index bbaae3444928985813b7dcc91888784d06cfe305..81a506ce4cc09493dd7faed88=
652d8d246e23187 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -231,7 +231,7 @@ static bool sve_needed(void *opaque)
>  {
>      ARMCPU *cpu =3D opaque;
>
> -    return cpu_isar_feature(aa64_sve, cpu);
> +    return cpu_isar_feature(aa64_sve, cpu) || cpu_isar_feature(aa64_sme,=
 cpu);
>  }
>
>  /* The first two words of each Zreg is stored in VFP state.  */
>
> --
> 2.47.3
>

