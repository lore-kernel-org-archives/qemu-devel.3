Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB90FD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 20:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvi0O-0001ho-15; Thu, 26 Feb 2026 15:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvi0L-0001hK-Sy
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:30:38 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvi0I-00037g-Kp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:30:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so849605f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 12:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772137832; cv=none;
 d=google.com; s=arc-20240605;
 b=CngaCrBCy6q10jr5CL79N8atqmNmg6ltYqCmIfbjtWchZkqTifo6ZM6MnDoEUzD6oa
 trKan8e0eF++DFCf2pZK6YefICTd5F/dxqveTuqcNwtKos9z/LdZKXm9cV+TBgYw02dE
 ypcalpHX5j1YwpPNiNWMsdlIZ+vZmzjhFPOslFOdtDjH+0MTmp6/th3NYypXmM7W47Zl
 xWLFT97TvdZg3p/C717Tfh02x3FxWz8N4+kysb0bTE3hgYUlqpbiXwD90Bl95+owM2Vr
 DH5pYb2fHG6VEL6xd0RQFheYYf/fL+QFaxvBWVnZ7fr64EkwbOp2vsMW4/mZPGpVr81l
 ksyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4ok9rel8WXBnOljq9Lo5Jv+h7ulwDq4piEa1TyAp5nM=;
 fh=iJj8KHjIwqqS3aRbB2gqqTcXOT1zSYRQsl1zVAPf1UA=;
 b=ABlFE5tNkD+Qrj/GP8EF18Bul1xjpxAiLwmkwJiv2jEL8Q2XXwptiFYQhsCAK5QJWH
 Oirh2ExBeyKBY843WVrZet9vNfKqCBl3vHPMrlxi709d0dF9+r92IlxW6q6ISvvZRPrV
 eF/0/kHSWP+XCnB9p2MyuOUJE25xCYRdUh7fTVwLsmEc1Zt3aeA44UfkHM13PD8/fK+R
 ZWqXD1UzU+D432XSjNi++ahNl2gaOtuSQwVUhupGg2QYnWYXuyGskR33R6Jux09OEdOT
 g+LhoRMdYpreWGV1cBaKjjkVhRE7cB4bziPAf/3Okn6MhG+Otol88/EvoCp4uN/R9yPt
 UfJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772137832; x=1772742632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ok9rel8WXBnOljq9Lo5Jv+h7ulwDq4piEa1TyAp5nM=;
 b=ADsQQ6sWdiGM/P0GtTemFBLNMoXVrzQtb7BfvmRqoiRQFb9CwgOK8KjJY42URbImX1
 LxX+VyuBXQfM2HaeVJx91l8MBeL9W6XULrGPKAeqjAC39dcZpImjW39az93/DdKVQkkb
 DUa+Upt63vFubrQATv7D67o16olJZHDPPnEC9KjlpwWDb6HZ/1MFvEDz6lYQtUYBXJAt
 ca/4D7TV5qX9ZsiM95h+PCebpiBAD7grhy7XnrTqZswYVbdJeqNI4e1TZIQBkxRUhREd
 HJ82Oyc0Fwy2DSzxw07qmJ9rrcmfAAtfZ2zDDQcEpUhplEtKVffpQA7KVvBXODBtxlp6
 zmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772137832; x=1772742632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ok9rel8WXBnOljq9Lo5Jv+h7ulwDq4piEa1TyAp5nM=;
 b=LD7d0Yl/wtodZbND25/hCifoJjkigh4WfDKyrS9UlXhAmBvNuwvzdbQM8juVeaeo2d
 BDwHika/y404Tbvc6RZgEkAcUVe+7ec52H0yyTnNCw8EjyoJ0FL+YHebQ0BsFRImYn+d
 0FC+aFqoB2qp1uXMtrJ7W8vha+H720qym3aput6ub6+WFkUla/X+LHHwnhUK3uy6LcYO
 Fo95g5vfBUPm0n+MR2rtVFr35AP4NM3Q9csE8jbCWRkLf51mdAdAsvobPxmhKXph39YH
 sVcwo0GakjhM5DTwbKcn8c1oo1v+/TO6xhjLew6ZWADd8u23Aiu9cpPsVoyJYbomoLRB
 vgAQ==
X-Gm-Message-State: AOJu0YwavMnLnmzFxC9U7IPI76dV6+f+3dWvIRr/LNkk21iy/DI2gsFw
 n0CDBSwl6RLuv2/59TFmEueC1OzFlqv1D86LTr9zRSaaoKMOwERfV8AZA7k+CvkDjwf4dMeCmIz
 3THvO9NZWI0xukHtUvOi+Thm7kWf3Wz+172vbJQGncA==
X-Gm-Gg: ATEYQzwJwGFJevHARvXZXygQZawYJmr2B3QJFTY78qrJvmQ6ZImycBpB7LPXNrO2spL
 r5e+aG3YcvyJZgZWmkiZLg7Yd7m6GhubABic+/1MVSEXfxct8niECXSv89WtL++nEzHvZ/BE8f/
 MlLd6gCS3iupxYbajb8GYNWnEPQDpYms5DE3AvOIhOvYRr0jLDgpFvs4uhJz8UfQha3RhAajFwD
 uemvF1+Fqug4E7pSvGv69xfE4DMiXj8xjSuoBtC0luU8kSMH3WWcigMTJeg4hB3lUvMiIL/RzJ1
 PS4Z9u6g/IZD5Ksg16ZUVPcKVRpqMA0llh/dHZNi179ci5Tq+m5rn1l1+Mgy
X-Received: by 2002:a05:6000:2c01:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4399dde2b1cmr287756f8f.5.1772137832068; Thu, 26 Feb 2026
 12:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
 <20260226-sme2-hvf-v3-1-ea5763dbeba2@linaro.org>
 <005B316F-6CFB-43E0-AC3A-B894ECD6BCAC@unpredictable.fr>
In-Reply-To: <005B316F-6CFB-43E0-AC3A-B894ECD6BCAC@unpredictable.fr>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 26 Feb 2026 22:30:04 +0200
X-Gm-Features: AaiRm51jyKD_Q4Qj0rwbbd8N9BbOxePCQi8ZDurZ_gtoqfAdYLZHEBrdlyniXk4
Message-ID: <CAAjaMXZv0A1QKvH6TM5Fugm-9+dGrnXvQaEJ2y9ADwF=BAcDpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hvf/arm: handle FEAT_SME2 migration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Thu, Feb 26, 2026 at 9:24=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
>
> > On 26. Feb 2026, at 08:25, Manos Pitsidianakis <manos.pitsidianakis@lin=
aro.org> wrote:
> >
> > SME2 support adds the following state for HVF guests:
> >
> > - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
> >  not support it)
> > - Predicate registers P0, .., P15 (also FEAT_SVE)
> > - ZA register
> > - ZT0 register
> > - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> > - SMPRI_EL1 which handles the PE's priority in the SMCU
> > - TPIDR2_EL0 the thread local ID register for SME
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> > target/arm/hvf/hvf.c           | 289 ++++++++++++++++++++++++++++++++++=
++++++-
> > target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++++++
> > target/arm/hvf/sysreg.c.inc    |   8 ++
> > target/arm/hvf_arm.h           |  44 +++++++
> > target/arm/machine.c           |   2 +-
> > 5 files changed, 498 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index 1b19d9713edd46cc7e9930de171fce87f49963d4..7d80c8b30aeedde8b81ac8f=
afc70f61532141dad 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -398,6 +398,60 @@ static const struct hvf_reg_match hvf_fpreg_match[=
] =3D {
> >     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
> > };
> >
> > +static const struct hvf_reg_match hvf_sme2_zreg_match[] =3D {
> > +    { HV_SME_Z_REG_0, offsetof(CPUARMState, vfp.zregs[0]) },
> > +    { HV_SME_Z_REG_1, offsetof(CPUARMState, vfp.zregs[1]) },
> > +    { HV_SME_Z_REG_2, offsetof(CPUARMState, vfp.zregs[2]) },
> > +    { HV_SME_Z_REG_3, offsetof(CPUARMState, vfp.zregs[3]) },
> > +    { HV_SME_Z_REG_4, offsetof(CPUARMState, vfp.zregs[4]) },
> > +    { HV_SME_Z_REG_5, offsetof(CPUARMState, vfp.zregs[5]) },
> > +    { HV_SME_Z_REG_6, offsetof(CPUARMState, vfp.zregs[6]) },
> > +    { HV_SME_Z_REG_7, offsetof(CPUARMState, vfp.zregs[7]) },
> > +    { HV_SME_Z_REG_8, offsetof(CPUARMState, vfp.zregs[8]) },
> > +    { HV_SME_Z_REG_9, offsetof(CPUARMState, vfp.zregs[9]) },
> > +    { HV_SME_Z_REG_10, offsetof(CPUARMState, vfp.zregs[10]) },
> > +    { HV_SME_Z_REG_11, offsetof(CPUARMState, vfp.zregs[11]) },
> > +    { HV_SME_Z_REG_12, offsetof(CPUARMState, vfp.zregs[12]) },
> > +    { HV_SME_Z_REG_13, offsetof(CPUARMState, vfp.zregs[13]) },
> > +    { HV_SME_Z_REG_14, offsetof(CPUARMState, vfp.zregs[14]) },
> > +    { HV_SME_Z_REG_15, offsetof(CPUARMState, vfp.zregs[15]) },
> > +    { HV_SME_Z_REG_16, offsetof(CPUARMState, vfp.zregs[16]) },
> > +    { HV_SME_Z_REG_17, offsetof(CPUARMState, vfp.zregs[17]) },
> > +    { HV_SME_Z_REG_18, offsetof(CPUARMState, vfp.zregs[18]) },
> > +    { HV_SME_Z_REG_19, offsetof(CPUARMState, vfp.zregs[19]) },
> > +    { HV_SME_Z_REG_20, offsetof(CPUARMState, vfp.zregs[20]) },
> > +    { HV_SME_Z_REG_21, offsetof(CPUARMState, vfp.zregs[21]) },
> > +    { HV_SME_Z_REG_22, offsetof(CPUARMState, vfp.zregs[22]) },
> > +    { HV_SME_Z_REG_23, offsetof(CPUARMState, vfp.zregs[23]) },
> > +    { HV_SME_Z_REG_24, offsetof(CPUARMState, vfp.zregs[24]) },
> > +    { HV_SME_Z_REG_25, offsetof(CPUARMState, vfp.zregs[25]) },
> > +    { HV_SME_Z_REG_26, offsetof(CPUARMState, vfp.zregs[26]) },
> > +    { HV_SME_Z_REG_27, offsetof(CPUARMState, vfp.zregs[27]) },
> > +    { HV_SME_Z_REG_28, offsetof(CPUARMState, vfp.zregs[28]) },
> > +    { HV_SME_Z_REG_29, offsetof(CPUARMState, vfp.zregs[29]) },
> > +    { HV_SME_Z_REG_30, offsetof(CPUARMState, vfp.zregs[30]) },
> > +    { HV_SME_Z_REG_31, offsetof(CPUARMState, vfp.zregs[31]) },
> > +};
> > +
> > +static const struct hvf_reg_match hvf_sme2_preg_match[] =3D {
> > +    { HV_SME_P_REG_0, offsetof(CPUARMState, vfp.pregs[0]) },
> > +    { HV_SME_P_REG_1, offsetof(CPUARMState, vfp.pregs[1]) },
> > +    { HV_SME_P_REG_2, offsetof(CPUARMState, vfp.pregs[2]) },
> > +    { HV_SME_P_REG_3, offsetof(CPUARMState, vfp.pregs[3]) },
> > +    { HV_SME_P_REG_4, offsetof(CPUARMState, vfp.pregs[4]) },
> > +    { HV_SME_P_REG_5, offsetof(CPUARMState, vfp.pregs[5]) },
> > +    { HV_SME_P_REG_6, offsetof(CPUARMState, vfp.pregs[6]) },
> > +    { HV_SME_P_REG_7, offsetof(CPUARMState, vfp.pregs[7]) },
> > +    { HV_SME_P_REG_8, offsetof(CPUARMState, vfp.pregs[8]) },
> > +    { HV_SME_P_REG_9, offsetof(CPUARMState, vfp.pregs[9]) },
> > +    { HV_SME_P_REG_10, offsetof(CPUARMState, vfp.pregs[10]) },
> > +    { HV_SME_P_REG_11, offsetof(CPUARMState, vfp.pregs[11]) },
> > +    { HV_SME_P_REG_12, offsetof(CPUARMState, vfp.pregs[12]) },
> > +    { HV_SME_P_REG_13, offsetof(CPUARMState, vfp.pregs[13]) },
> > +    { HV_SME_P_REG_14, offsetof(CPUARMState, vfp.pregs[14]) },
> > +    { HV_SME_P_REG_15, offsetof(CPUARMState, vfp.pregs[15]) },
> > +};
> > +
> > /*
> >  * QEMU uses KVM system register ids in the migration format.
> >  * Conveniently, HVF uses the same encoding of the op* and cr* paramete=
rs
> > @@ -409,22 +463,201 @@ static const struct hvf_reg_match hvf_fpreg_matc=
h[] =3D {
> > #define HVF_TO_KVMID(HVF)  \
> >     (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
> >
> > -/* Verify this at compile-time. */
> > +/*
> > + * Verify this at compile-time.
> > + *
> > + * SME2 registers are guarded by a runtime availability attribute inst=
ead of a
> > + * compile-time def, so verify those at runtime in hvf_arch_init_vcpu(=
) below.
> > + */
> >
> > #define DEF_SYSREG(HVF_ID, ...) \
> >   QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_=
ARGS__)));
> > +#define DEF_SYSREG_15_02(...)
> >
> > #include "sysreg.c.inc"
> >
> > #undef DEF_SYSREG
> > +#undef DEF_SYSREG_15_02
> >
> > #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
> > +#define DEF_SYSREG_15_02(...)
> >
> > static const hv_sys_reg_t hvf_sreg_list[] =3D {
> > #include "sysreg.c.inc"
> > };
> >
> > #undef DEF_SYSREG
> > +#undef DEF_SYSREG_15_02
> > +
> > +#define DEF_SYSREG(...)
> > +#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
> > +
> > +API_AVAILABLE(macos(15.2))
> > +static const hv_sys_reg_t hvf_sreg_list_sme2[] =3D {
> > +#include "sysreg.c.inc"
> > +};
> > +
> > +#undef DEF_SYSREG
> > +#undef DEF_SYSREG_15_02
> > +
> > +/*
> > + * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which=
 are
> > + * accessible with the SVCR pseudo-register. However, in the HVF API t=
his is
> > + * not exposed as a system-register (i.e. HVF_SYS_REG_SVCR) but a cust=
om
> > + * struct, hv_vcpu_sme_state_t. So we need to define our own KVMID in =
order to
> > + * store it in cpreg_values and make it migrateable.
> > + */
> > +#define SVCR KVMID_AA64_SYS_REG64(3, 3, 4, 2, 2)
> > +
> > +API_AVAILABLE(macos(15.2))
> > +static void hvf_arch_put_sme(CPUState *cpu)
> > +{
> > +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> > +    CPUARMState *env =3D &arm_cpu->env;
> > +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> > +    const size_t z_size =3D svl_bytes;
> > +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> > +    const size_t za_size =3D svl_bytes * svl_bytes;
> > +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> > +    hv_return_t ret;
> > +    uint64_t svcr;
> > +    int n;
> > +
> > +    /*
> > +     * Set PSTATE.{SM,ZA} bits
> > +     */
> > +    svcr =3D arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1];
> > +    env->svcr =3D svcr;
> > +
> > +    /*
> > +     * Construct SVCR (PSTATE.{SM,ZA}) state to pass to HVF:
> > +     */
> > +    sme_state.streaming_sve_mode_enabled =3D FIELD_EX64(env->svcr, SVC=
R, SM) > 0;
> > +    sme_state.za_storage_enabled =3D FIELD_EX64(env->svcr, SVCR, ZA) >=
 0;
> > +    ret =3D hv_vcpu_set_sme_state(cpu->accel->fd, &sme_state);
> > +    assert_hvf_ok(ret);
> > +
> > +    /*
> > +     * We only care about Z/P registers if we're in streaming SVE mode=
, i.e.
> > +     * PSTATE.SM is set, because only then can instructions that acces=
s them be
> > +     * used. We don't care about the register values otherwise. This i=
s because
> > +     * when the processing unit exits/enters this mode, it zeroes out =
those
> > +     * registers.
> > +     */
> > +    if (sme_state.streaming_sve_mode_enabled) {
> > +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> > +            ret =3D hv_vcpu_set_sme_z_reg(cpu->accel->fd,
> > +                                        hvf_sme2_zreg_match[n].reg,
> > +                                        (uint8_t *)&env->vfp.zregs[n].=
d[0],
> > +                                        z_size);
> > +            assert_hvf_ok(ret);
> > +        }
> > +
> > +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> > +            ret =3D hv_vcpu_set_sme_p_reg(cpu->accel->fd,
> > +                                        hvf_sme2_preg_match[n].reg,
> > +                                        (uint8_t *)&env->vfp.pregs[n].=
p[0],
> > +                                        preg_size);
> > +            assert_hvf_ok(ret);
> > +        }
> > +    }
> > +
> > +    /*
> > +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise th=
ey are
> > +     * zeroed out.
> > +     */
> > +    if (sme_state.za_storage_enabled) {
> > +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> > +
> > +        memcpy(&tmp, &env->za_state.zt0, 64);
> > +        ret =3D hv_vcpu_set_sme_zt0_reg(cpu->accel->fd, &tmp);
> > +        assert_hvf_ok(ret);
> > +
> > +        ret =3D hv_vcpu_set_sme_za_reg(cpu->accel->fd,
> > +                                     (uint8_t *)&env->za_state.za,
> > +                                     za_size);
> > +        assert_hvf_ok(ret);
> > +    }
> > +
> > +    return;
> > +}
> > +
> > +API_AVAILABLE(macos(15.2))
> > +static void hvf_arch_get_sme(CPUState *cpu)
> > +{
> > +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> > +    CPUARMState *env =3D &arm_cpu->env;
> > +    const size_t svl_bytes =3D hvf_arm_sme2_get_svl();
> > +    const size_t z_size =3D svl_bytes;
> > +    const size_t preg_size =3D DIV_ROUND_UP(z_size, 8);
> > +    const size_t za_size =3D svl_bytes * svl_bytes;
> > +    hv_vcpu_sme_state_t sme_state =3D { 0 };
> > +    hv_return_t ret;
> > +    uint64_t svcr;
> > +    int n;
> > +
> > +    /*
> > +     * Get SVCR (PSTATE.{SM,ZA}) state from HVF:
> > +     */
> > +    ret =3D hv_vcpu_get_sme_state(cpu->accel->fd, &sme_state);
> > +    assert_hvf_ok(ret);
> > +
> > +    /*
> > +     * Set SVCR first because changing it will zero out Z/P regs
> > +     */
> > +    svcr =3D
> > +        (sme_state.za_storage_enabled ? R_SVCR_ZA_MASK : 0)
> > +        | (sme_state.streaming_sve_mode_enabled ? R_SVCR_SM_MASK : 0);
> > +
> > +    aarch64_set_svcr(env, svcr, R_SVCR_ZA_MASK | R_SVCR_SM_MASK);
> > +    arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1] =3D svcr;
> > +
> > +    /*
> > +     * We only care about Z/P registers if we're in streaming SVE mode=
, i.e.
> > +     * PSTATE.SM is set, because only then can instructions that acces=
s them be
> > +     * used. We don't care about the register values otherwise. This i=
s because
> > +     * when the processing unit exits/enters this mode, it zeroes out =
those
> > +     * registers.
> > +     */
> > +    if (sme_state.streaming_sve_mode_enabled) {
> > +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
> > +            ret =3D hv_vcpu_get_sme_z_reg(cpu->accel->fd,
> > +                                        hvf_sme2_zreg_match[n].reg,
> > +                                        (uint8_t *)&env->vfp.zregs[n].=
d[0],
> > +                                        z_size);
> > +            assert_hvf_ok(ret);
> > +        }
> > +
> > +        for (n =3D 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
> > +            ret =3D hv_vcpu_get_sme_p_reg(cpu->accel->fd,
> > +                                        hvf_sme2_preg_match[n].reg,
> > +                                        (uint8_t *)&env->vfp.pregs[n].=
p[0],
> > +                                        preg_size);
> > +            assert_hvf_ok(ret);
> > +        }
> > +    }
> > +
> > +    /*
> > +     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise th=
ey are
> > +     * zeroed out.
> > +     */
> > +    if (sme_state.za_storage_enabled) {
> > +        hv_sme_zt0_uchar64_t tmp =3D { 0 };
> > +
> > +        /* Get ZT0 in a tmp vector, and then copy it to env.za_state.z=
t0 */
> > +        ret =3D hv_vcpu_get_sme_zt0_reg(cpu->accel->fd, &tmp);
> > +        assert_hvf_ok(ret);
> > +
> > +        memcpy(&env->za_state.zt0, &tmp, 64);
> > +        ret =3D hv_vcpu_get_sme_za_reg(cpu->accel->fd,
> > +                                     (uint8_t *)&env->za_state.za,
> > +                                     za_size);
> > +        assert_hvf_ok(ret);
> > +
> > +    }
> > +
> > +    return;
> > +}
> >
> > static uint32_t hvf_reg2cp_reg(uint32_t reg)
> > {
> > @@ -538,6 +771,10 @@ int hvf_arch_get_registers(CPUState *cpu)
> >         uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
> >         int hvf_id =3D KVMID_TO_HVF(kvm_id);
> >
> > +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> > +            continue;
> > +        }
> > +
> >         if (cpu->accel->guest_debug_enabled) {
> >             /* Handle debug registers */
> >             switch (hvf_id) {
> > @@ -631,6 +868,13 @@ int hvf_arch_get_registers(CPUState *cpu)
> >
> >         arm_cpu->cpreg_values[i] =3D val;
> >     }
> > +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> > +        if (__builtin_available(macOS 15.2, *)) {
> > +            hvf_arch_get_sme(cpu);
> > +        } else {
> > +            g_assert_not_reached();
> > +        }
> > +    }
> >     assert(write_list_to_cpustate(arm_cpu));
> >
> >     aarch64_restore_sp(env, arm_current_el(env));
> > @@ -687,6 +931,10 @@ int hvf_arch_put_registers(CPUState *cpu)
> >         uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
> >         int hvf_id =3D KVMID_TO_HVF(kvm_id);
> >
> > +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> > +            continue;
> > +        }
> > +
> >         if (cpu->accel->guest_debug_enabled) {
> >             /* Handle debug registers */
> >             switch (hvf_id) {
> > @@ -781,6 +1029,13 @@ int hvf_arch_put_registers(CPUState *cpu)
> >     ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0=
, val);
> >     assert_hvf_ok(ret);
> >
> > +    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> > +        if (__builtin_available(macOS 15.2, *)) {
> > +            hvf_arch_put_sme(cpu);
> > +        } else {
> > +            g_assert_not_reached();
> > +        }
> > +    }
> >     return 0;
> > }
> >
> > @@ -1010,6 +1265,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >     hv_return_t ret;
> >     int i;
> >
> > +    if (__builtin_available(macOS 15.2, *)) {
> > +        sregs_match_len +=3D ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
> > +
> > +#define DEF_SYSREG_15_02(HVF_ID, ...) \
> > +        g_assert(HVF_ID =3D=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_=
ARGS__)));
> > +#define DEF_SYSREG(...)
> > +
> > +#include "sysreg.c.inc"
> > +
> > +#undef DEF_SYSREG
> > +#undef DEF_SYSREG_15_02
> > +    }
> >     env->aarch64 =3D true;
> >
> >     /* system count frequency sanity check */
> > @@ -1030,7 +1297,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t)=
);
> >
> >     /* Populate cp list for all known sysregs */
> > -    for (i =3D 0; i < sregs_match_len; i++) {
> > +    for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
> >         hv_sys_reg_t hvf_id =3D hvf_sreg_list[i];
> >         uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> >         uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> > @@ -1041,6 +1308,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >             arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> >         }
> >     }
> > +    if (__builtin_available(macOS 15.2, *)) {
> > +        for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> > +            hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i];
> > +            uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> > +            uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> > +            const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_=
regs, key);
> > +
> > +            if (ri) {
> > +                assert(!(ri->type & ARM_CP_NO_RAW));
> > +                arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> > +            }
> > +        }
> > +        /*
> > +         * Add SVCR last. It is elsewhere assumed its index is after
> > +         * hvf_sreg_list and hvf_sreg_list_sme2.
> > +         */
> > +        arm_cpu->cpreg_indexes[sregs_cnt++] =3D HVF_TO_KVMID(SVCR);
> > +    }
> >     arm_cpu->cpreg_array_len =3D sregs_cnt;
> >     arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
> >
> > diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_st=
ubs.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9c679b711017448681e532b=
88ce10a07ebfd5122
> > --- /dev/null
> > +++ b/target/arm/hvf/hvf_sme_stubs.h
> > @@ -0,0 +1,158 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +typedef int32_t hv_return_t;
> > +typedef uint64_t hv_vcpu_t;
> > +
> > +static inline bool hvf_arm_sme2_supported(void)
> > +{
> > +    return false;
> > +}
> > +
> > +static inline uint32_t hvf_arm_sme2_get_svl(void)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +typedef enum hv_sme_p_reg_t {
> > +    HV_SME_P_REG_0,
> > +    HV_SME_P_REG_1,
> > +    HV_SME_P_REG_2,
> > +    HV_SME_P_REG_3,
> > +    HV_SME_P_REG_4,
> > +    HV_SME_P_REG_5,
> > +    HV_SME_P_REG_6,
> > +    HV_SME_P_REG_7,
> > +    HV_SME_P_REG_8,
> > +    HV_SME_P_REG_9,
> > +    HV_SME_P_REG_10,
> > +    HV_SME_P_REG_11,
> > +    HV_SME_P_REG_12,
> > +    HV_SME_P_REG_13,
> > +    HV_SME_P_REG_14,
> > +    HV_SME_P_REG_15,
> > +} hv_sme_p_reg_t;
> > +
> > +typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar6=
4_t;
> > +
> > +typedef enum hv_sme_z_reg_t {
> > +    HV_SME_Z_REG_0,
> > +    HV_SME_Z_REG_1,
> > +    HV_SME_Z_REG_2,
> > +    HV_SME_Z_REG_3,
> > +    HV_SME_Z_REG_4,
> > +    HV_SME_Z_REG_5,
> > +    HV_SME_Z_REG_6,
> > +    HV_SME_Z_REG_7,
> > +    HV_SME_Z_REG_8,
> > +    HV_SME_Z_REG_9,
> > +    HV_SME_Z_REG_10,
> > +    HV_SME_Z_REG_11,
> > +    HV_SME_Z_REG_12,
> > +    HV_SME_Z_REG_13,
> > +    HV_SME_Z_REG_14,
> > +    HV_SME_Z_REG_15,
> > +    HV_SME_Z_REG_16,
> > +    HV_SME_Z_REG_17,
> > +    HV_SME_Z_REG_18,
> > +    HV_SME_Z_REG_19,
> > +    HV_SME_Z_REG_20,
> > +    HV_SME_Z_REG_21,
> > +    HV_SME_Z_REG_22,
> > +    HV_SME_Z_REG_23,
> > +    HV_SME_Z_REG_24,
> > +    HV_SME_Z_REG_25,
> > +    HV_SME_Z_REG_26,
> > +    HV_SME_Z_REG_27,
> > +    HV_SME_Z_REG_28,
> > +    HV_SME_Z_REG_29,
> > +    HV_SME_Z_REG_30,
> > +    HV_SME_Z_REG_31,
> > +} hv_sme_z_reg_t;
> > +
> > +enum {
> > +  HV_SYS_REG_SMCR_EL1,
> > +  HV_SYS_REG_SMPRI_EL1,
> > +  HV_SYS_REG_TPIDR2_EL0,
> > +  HV_SYS_REG_ID_AA64ZFR0_EL1,
> > +  HV_SYS_REG_ID_AA64SMFR0_EL1,
> > +};
> > +
> > +typedef struct {
> > +    bool streaming_sve_mode_enabled;
> > +    bool za_storage_enabled;
> > +} hv_vcpu_sme_state_t;
> > +
> > +static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *valu=
e)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
> > +                                                hv_vcpu_sme_state_t *s=
me_state)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
> > +                                                const hv_vcpu_sme_stat=
e_t *sme_state)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
> > +                                                hv_sme_z_reg_t reg,
> > +                                                uint8_t *value,
> > +                                                size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
> > +                                                hv_sme_z_reg_t reg,
> > +                                                const uint8_t *value,
> > +                                                size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
> > +                                                hv_sme_p_reg_t reg,
> > +                                                uint8_t *value,
> > +                                                size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
> > +                                                hv_sme_p_reg_t reg,
> > +                                                const uint8_t *value,
> > +                                                size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
> > +                                                 uint8_t *value,
> > +                                                 size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
> > +                                                 const uint8_t *value,
> > +                                                 size_t length)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
> > +                                                  hv_sme_zt0_uchar64_t=
 *value)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
> > +                                                  const hv_sme_zt0_uch=
ar64_t *value)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> > index 067a8603fa785593ed0879cea26d036b0ec2823e..7a2f880f784b7610b14a6eb=
91fec1817e98bfd2e 100644
> > --- a/target/arm/hvf/sysreg.c.inc
> > +++ b/target/arm/hvf/sysreg.c.inc
> > @@ -145,3 +145,11 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
> > DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
> > DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
> > DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
> > +
> > +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> > +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> > +DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
> > +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
> > +DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
> > +DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
> > +DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> > diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
> > index 5d19d82e5ded66bc02da10523c0f7138840ecff3..6b5db457259667dd97620aa=
c76ca0ab5c672fb04 100644
> > --- a/target/arm/hvf_arm.h
> > +++ b/target/arm/hvf_arm.h
> > @@ -22,4 +22,48 @@ void hvf_arm_init_debug(void);
> >
> > void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
> >
> > +uint32_t hvf_arm_get_default_ipa_bit_size(void);
> > +uint32_t hvf_arm_get_max_ipa_bit_size(void);
> Are these lines intended to be there as part of this patch?
>

Oops, for some reason git-rebase against master kept those in. Will
post a new revision tomorrow. Thanks a lot!!

> > +
> > +/*
> > + * We need access to types from macOS SDK >=3D15.2, so expose stubs if=
 the
> > + * headers are not available until we raise our minimum macOS version.
> > + */
> > +#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
> > +  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200)
> > +    #include "system/hvf_int.h"
> > +
> > +    static inline bool hvf_arm_sme2_supported(void)
> > +    {
> > +        if (__builtin_available(macOS 15.2, *)) {
> > +            size_t svl_bytes;
> > +            hv_return_t result =3D hv_sme_config_get_max_svl_bytes(&sv=
l_bytes);
> > +            if (result =3D=3D HV_UNSUPPORTED) {
> > +                return false;
> > +            }
> > +            assert_hvf_ok(result);
> > +            return svl_bytes > 0;
> > +        } else {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    static inline uint32_t hvf_arm_sme2_get_svl(void)
> > +    {
> > +        if (__builtin_available(macOS 15.2, *)) {
> > +            size_t svl_bytes;
> > +            hv_return_t result =3D hv_sme_config_get_max_svl_bytes(&sv=
l_bytes);
> > +            assert_hvf_ok(result);
> > +            return svl_bytes;
> > +        } else {
> > +            abort();
> > +        }
> > +    }
> > +  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> > +      #include "hvf/hvf_sme_stubs.h"
> > +  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >=3D 150200) */
> > +#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> > +  #include "hvf/hvf_sme_stubs.h"
> > +#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
> > +
> > #endif
> > diff --git a/target/arm/machine.c b/target/arm/machine.c
> > index bbaae3444928985813b7dcc91888784d06cfe305..81a506ce4cc09493dd7faed=
88652d8d246e23187 100644
> > --- a/target/arm/machine.c
> > +++ b/target/arm/machine.c
> > @@ -231,7 +231,7 @@ static bool sve_needed(void *opaque)
> > {
> >     ARMCPU *cpu =3D opaque;
> >
> > -    return cpu_isar_feature(aa64_sve, cpu);
> > +    return cpu_isar_feature(aa64_sve, cpu) || cpu_isar_feature(aa64_sm=
e, cpu);
> > }
> >
> > /* The first two words of each Zreg is stored in VFP state.  */
> >
> > --
> > 2.47.3
> >
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

