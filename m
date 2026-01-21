Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ABC44502
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viUpY-0000w4-Is; Wed, 21 Jan 2026 04:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1viUpW-0000v8-Jp
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:48:50 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1viUpU-0004JL-Ki
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 04:48:50 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-655ae329d6bso9579046a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 01:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768988926; cv=none;
 d=google.com; s=arc-20240605;
 b=O5wN6j6it2h6czD6xr+EHBnoo1meYJ0y0mVZ9GzgPGNPBnRq2tbmMAEeJEmBm035vB
 gOeRRMMW171YqnlyN4qNnALocNyYoUhz/9+/w0zl+6rHKCMd7KxOfoj1OnnP4RLIk1M3
 pdax3ofCNUEipTXcG2vxMLEUJH8xIe8JCcFQ7d5rHu9PQFufFiJiKnqRoUYh/hCckwIi
 fKdfiLYpJvlaXXzdDHPuaTyRZEYFq9J0J1dL+FiHHZVazj/xWk2Eda89GYpOMK7MSazb
 q59OZYMIuEv22tyPROeQ5prgQ5QmvGFKxZ2oHJmloDDpf8kz6BZ3dFWriVKqifboHSKZ
 3bVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Kyi9fncuN4cOT9Qwbze6uf3r3BG4aXoohtJV2Ki5cU0=;
 fh=XIoO0Ux/SZ8W8McSemELDCpGv0yDhpljSyd3z1XJOS8=;
 b=CI6ZYGx5mNLMYCMhOVV6DVxhY6V6fx5LdVSm9RuLT//7SyIV30RaD5pfHZHdGJi7e5
 49vE1W9BpaATdQT2FEGgkIwcGu6VB1XPwRlgw5d1IoDWaBPWE7NEeoFDpWjHtdagkgOi
 XDNqWNRjzcUuTB7DKjm9CWfx9GdAeGeYlFABvpDztvBJMAZzVMpdDwWWdeA32hprFreB
 pJhafGHEROFPv2NDDrU9h/WMrB4Np8yG0TyPu0kjy6h1GOPqM0up2g35Fllz1ZA9OQZm
 cOhJPOo3ISrG2Bt5pC15brodOohcbtoP7iRxb6o8fTZ7+Jwvwhyv3EPG7dXMZqi80wwG
 UcGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768988926; x=1769593726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kyi9fncuN4cOT9Qwbze6uf3r3BG4aXoohtJV2Ki5cU0=;
 b=xh2Cj/zwFlZfGeb+vdJxqMaBmQbxtaLcmkCt0Jd1EbKukInNAW5jQPlT1ue1gkPUVd
 wivJ9/ANq7FId56mnCNyPKB8VYKYstf7ziEue30dEfBKyMUv3jCYk6sDvAscQ5+mMNaV
 +ZKK/KbuF3O1f6aeta/toFXxZ2KH6D26T8+u1EVTB7o4ByofA4Kcs9mz4Rv0erLr5LPX
 dBVB7qNQFdm8IIq8qkf7wJEnGNm0xuMvoYFJ1Ix+1txvbN7rXK4UbAzXN9xVH2cPhGvd
 wlDpOV9qwDIqmhJJ5zXWHsCAH4X0XyPuf2NG0Ocz0W1wT98Q1OB+Pb31CWXGI5otpqaw
 xi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768988926; x=1769593726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kyi9fncuN4cOT9Qwbze6uf3r3BG4aXoohtJV2Ki5cU0=;
 b=rk0/MTUyIVNuoohydIiaCYv7F32LD+A6rX9yMtfzsi9pFWtQf8AStIQ8WIWtc9DMoy
 jAnRHL7uJ8GRseVVSLwYR8f9eJsD+Bo3bWBoU5FXVnZ2cfVkKj9D+3bAibirkZMms9vM
 31F6M+mH5CjlFNMf15R+4YQ+Y+v/76puj9OY5ftWl3A8tgYPtlKIEz+XKGmbVnMaaOXD
 6Ii72+NvXEUBld+kXjJskgLg4sHAQ3/VuV7JDdL4ounyi+c+abY2lWU0dn+VscO6v6J0
 6Cfdu3SazzKtDa4zOH/2jEV1SYCwd5a+/cgib3IPDuuIq1wQ1ONkLyXGoM40AYs2NnEB
 kUdw==
X-Gm-Message-State: AOJu0YyxY4tJUwwwdFCYQaWd0S0/bG7pu4MM88aei1SMY66he+8rxJgx
 hwmEYg/yCj6mXIRx4Hl2GGCU8m1fbjUFUZ3CqO4pCP1nF5BqKtkw5ymCWS2Pnp0ukZ3yXMKdmmF
 Ggz0M16stEUA3zfxTYpPDngi0PcWEndk3LREOxbte9w==
X-Gm-Gg: AZuq6aLEqXLXN3SAanCzFIyLDi4+x7srNTwb+ChI2rMtDyElvFdYdr4RLEG3GUcNSG3
 eQHG2TRkVqYgJ7gaiqJf7cigt/SQL6W8mZGnpUzFaQitDLezLmAeCJvaKhYgawKKZhFgFpRLjwz
 SPTY5aUKxEBmWuOL+6nm6OUqVCYH5wr0xzwl2JBmdEdhqxQ/AmD846Y5VsTWGLpKVAO9+WPVTrG
 kcmGRBth0o2PJI7oUdG+KsdOF0x9ewOXF8+i6oncDpZE3gjrYQiSJZeDo5vJ8kQzeHNQg2vu82B
 X1ejEZCjkPGS8Ghnc/2RLlTCmXW9n353c3os
X-Received: by 2002:a17:907:7282:b0:b87:4c37:7fd8 with SMTP id
 a640c23a62f3a-b8796b953bamr1452579966b.49.1768988925589; Wed, 21 Jan 2026
 01:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-1-2eca481bd7ee@linaro.org>
 <1b0bd534-dd41-4ace-b5b3-37d854ae3d31@linaro.org>
In-Reply-To: <1b0bd534-dd41-4ace-b5b3-37d854ae3d31@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 21 Jan 2026 11:48:19 +0200
X-Gm-Features: AZwV_QieMxmGOt5h_uUsgXx8uINFPJk2u-1YhanMM975plgOrem57jmfn9aUJG4
Message-ID: <CAAjaMXbHe_zZ_dbz2VD95LAnfZzUkbFgZ2x4N39AEzWRssF7mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hvf/arm: handle FEAT_SME2 migration
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, Jan 20, 2026 at 12:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Manos,
>
> Mostly nitpicking comments :)
>
> On 15/1/26 12:20, Manos Pitsidianakis wrote:
> > SME2 support adds the following state for HVF guests:
> >
> > - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
> >    not support it)
> > - Predicate registers P0, .., P15 (also FEAT_SVE)
> > - ZA register
> > - ZT0 register
> > - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> > - SMPRI_EL1 which handles the PE's priority in the SMCU
> > - TPIDR2_EL0 the thread local ID register for SME
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   target/arm/hvf/hvf.c           | 285 ++++++++++++++++++++++++++++++++=
++++++++-
> >   target/arm/hvf/hvf_sme_stubs.h | 158 +++++++++++++++++++++++
> >   target/arm/hvf/sysreg.c.inc    |   8 ++
> >   target/arm/hvf_arm.h           |  41 ++++++
> >   target/arm/machine.c           |   2 +-
> >   5 files changed, 491 insertions(+), 3 deletions(-)
>
>
> >   int hvf_arch_get_registers(CPUState *cpu)
> >   {
> > @@ -465,6 +698,10 @@ int hvf_arch_get_registers(CPUState *cpu)
> >           uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
> >           int hvf_id =3D KVMID_TO_HVF(kvm_id);
> >
> > +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> > +            continue;
> > +        }
> > +
> >           if (cpu->accel->guest_debug_enabled) {
> >               /* Handle debug registers */
> >               switch (hvf_id) {
> > @@ -558,6 +795,11 @@ int hvf_arch_get_registers(CPUState *cpu)
> >
> >           arm_cpu->cpreg_values[i] =3D val;
> >       }
> > +    if (__builtin_available(macOS 15.2, *)) {
> > +        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> > +            hvf_arch_get_sme(cpu);
> > +        }
> > +    }
>
> What about:
>
>         if (cpu_isar_feature(aa64_sme, arm_cpu)) {
>             if (__builtin_available(macOS 15.2, *)) {
>                 hvf_arch_get_sme(cpu);
>             } else {
>                 g_assert_not_reached();
>             }
>         }
>
> ?

Yes, that's definitely better.

>
> >       assert(write_list_to_cpustate(arm_cpu));
> >
> >       aarch64_restore_sp(env, arm_current_el(env));
> > @@ -603,6 +845,10 @@ int hvf_arch_put_registers(CPUState *cpu)
> >           uint64_t kvm_id =3D arm_cpu->cpreg_indexes[i];
> >           int hvf_id =3D KVMID_TO_HVF(kvm_id);
> >
> > +        if (kvm_id =3D=3D HVF_TO_KVMID(SVCR)) {
> > +            continue;
> > +        }
> > +
> >           if (cpu->accel->guest_debug_enabled) {
> >               /* Handle debug registers */
> >               switch (hvf_id) {
> > @@ -687,6 +933,11 @@ int hvf_arch_put_registers(CPUState *cpu)
> >       ret =3D hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtim=
er_offset);
> >       assert_hvf_ok(ret);
> >
> > +    if (__builtin_available(macOS 15.2, *)) {
> > +        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> > +            hvf_arch_put_sme(cpu);
> > +        }
> > +    }
> >       return 0;
> >   }
> >
> > @@ -909,6 +1160,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >       hv_return_t ret;
> >       int i;
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
> >       env->aarch64 =3D true;
> >       asm volatile("mrs %0, cntfrq_el0" : "=3Dr"(arm_cpu->gt_cntfrq_hz)=
);
> >
> > @@ -927,7 +1190,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >       memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_=
t));
> >
> >       /* Populate cp list for all known sysregs */
> > -    for (i =3D 0; i < sregs_match_len; i++) {
> > +    for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
> >           hv_sys_reg_t hvf_id =3D hvf_sreg_list[i];
> >           uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> >           uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> > @@ -938,6 +1201,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> >               arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> >           }
> >       }
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
>
> Could we add as a hvf_arch_init_sme() helper instead?
>

Will do in next revision

> >       arm_cpu->cpreg_array_len =3D sregs_cnt;
> >       arm_cpu->cpreg_vmstate_array_len =3D sregs_cnt;
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
>
> We certainly already have these.

We don't, hvf sdk header provides these. If you include the hvf header
here, there will be a bunch of definitions that are available and a
bunch that are not (guarded by availability attribute) so it's far
easier to just typedef these two in the stub header.

>
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
>
> Hmm do we need those? Could we just define the typedef?

Yes, they are used in the static const hvf_reg_match arrays.

>
>    typedef uint32_t hv_sme_p_reg_t;
>    typedef uint32_t hv_sme_z_reg_t;
>    typedef void *hv_sme_zt0_uchar64_t;
>
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

