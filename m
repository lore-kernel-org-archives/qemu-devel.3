Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB87CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWVnd-0001mO-Ag; Mon, 08 Jun 2026 04:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWVnK-0001cc-7s
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:57:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wWVnH-0001w1-Af
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:57:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso2252575e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780909033; x=1781513833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILbJILzoaP91WfXISNvrQkUdNusk3MvusDGjf7M5Vms=;
 b=G8oiT8iMbRaM7XhjzLkqxT33Lp/h3fye8HjXZrCUWmX8fM9lhQPLV2thNXLHA8hGRC
 iL1FYqRW4+Q4ZJQnTxVni8NtCHbeS+WJoVXO3E1hxue8lOuCfeXpZDQNrFrBaCEvNYaf
 qN88ZHTfA13FrQKLRNuWiO+oftI9NRBrsPGOmWBs4XvPaQJQjP0EjdEoCuxCtexrayvs
 KAzltNS7vB1/RbZH6tldXd7giC7tecoLbl8Vzlycx4xoUy0NgFC4+auTpuZI0n6E06Vm
 W/HeBEdIV7xtZzIBdRcpGnMImeQrhi2+PNvaxu58j3RL4Iji6ZgEjbz9f+bE9mjyc6zX
 ry1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909033; x=1781513833;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILbJILzoaP91WfXISNvrQkUdNusk3MvusDGjf7M5Vms=;
 b=df7eEyr6m/yBg8Rql7saYLnNWHAvo6UF1QbYE95Da4NbBOUWsd3K/0T5jcfG8OdO57
 sKxFdXrH5e8BPYkcouuuYie8tqsSekYpCnZSv3tOBYQgrATICEdOfsrJaSX9QY07eHUP
 F7VeFiq/NtcMseZrSVUSCGbJbOrp3OAyYgjai0zINj8eKrURHOAneJtROVikxlSB1leY
 GAluZjOfCaRqXzeVNZdvZ8m4XD7cbAx+BhtxjdV85pfffxIWx3JUFaYTY+8/aoBj4ASA
 tlLDxVvWsgIdPQu3EAspMu0Xf728oelqDHqIf5DxuwEV+8cgKfcrOaTOKZLXf/7ALNuh
 mt7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BzPWZfy2Mo6KAwH3T1HFQwOoPTStKWKeEsTi1ewIl97IsRN8FzB+OA0sMhj5TtQl5T+ZGn108J9rw@nongnu.org
X-Gm-Message-State: AOJu0Yzg06qjoz+NvpiZDAIuM3rj2QevygpGczqmBYmlez3FdZF7g7GF
 sSFM/S8OIJnH65qo01oL3+0vFWcPMBkFblVPkwSKJ6RVKDZeKizE6JxLHNu+gythTjY=
X-Gm-Gg: Acq92OHXyTip1U7DAMuTYLlubdof7CYuKq9OaWSyfQRXTytodMtlhIltrhaZ/5v3I7T
 /yf9lg3Pr/uRDGSMC/K/L9UmWAjcEYT6nl/wlHwrD6MYzl2JJX4T6vxKaj7P3VIw9C2YihlYb4Q
 S7oxNwJbSZ91JYBfTVxDiWaBlwa09F4IB+xc0+iJh/4zSY9RSBsEp8vjFE94Ip+t/3hKISbovLr
 MLSK50691ZOvTswAJGoTEyWaKC5T3NShxok+ykr2SjgWnTdFFYy6XYjNyFkgVzsY/3TVRYmbDCK
 VvGSm9xrvtsWradSRytJvfR3KXUdhk/gnS74LoFnZOryHEEyXYa4yBIUC2CgOFQ7rLOlmWd8fbr
 gK9M+ldWlC+iGYEuRSA/8PEa5OPKdDrVQE/+QvreP5ajAgQDNgMB6pH2QysT8eB8Swcu945Xkre
 A/PU8ViuVKwff7f2or1ooF2nL2NBqg8/BAO/AOqbF2VqEM
X-Received: by 2002:a05:600c:c059:10b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490c265b439mr177113085e9.14.1780909032610; 
 Mon, 08 Jun 2026 01:57:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm39785918f8f.7.2026.06.08.01.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:57:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 096DD5F9CE;
 Mon, 08 Jun 2026 09:57:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Jason L. Wright'" <wrigjl@proton.me>
Cc: Zenghui Yu <zenghui.yu@linux.dev>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  Alexander Graf
 <agraf@csgraf.de>,  qemu-arm <qemu-arm@nongnu.org>, Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@mailo.com>, Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: [PULL 17/21] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
In-Reply-To: <aiWyrX0aVvBk2olT@Jasons-MacBook-Pro.local> (Jason L. Wright''s
 message of "Sun, 07 Jun 2026 18:04:42 +0000")
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <aiWyrX0aVvBk2olT@Jasons-MacBook-Pro.local>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 08 Jun 2026 09:57:10 +0100
Message-ID: <874ijd2yvt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

"Jason L. Wright'" <wrigjl@proton.me> writes:

> On Sun, Jun 07, 2026 at 06:42:30PM +0800, Zenghui Yu wrote:
>> + Alexander and qemu-arm (for HVF/arm),
>>=20
>> On 5/29/26 7:47 PM, Peter Maydell wrote:
>> > From: Jason Wright <wrigjl@proton.me>
>> >
>> > Add an .accessfn to the RNDR and RNDRRS system registers that traps
>> > reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
>> > Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
>> > the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
>> > shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
>> > check of arm_current_el().
>> >
>> > When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
>> > with SCR_EL3.TRNDR=3D0 should UNDEF rather than succeed; handle that c=
ase
>> > in access_rndr(). Register the rndr_reginfo CP reg entries whenever ei=
ther
>> > FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even o=
n a
>> > FEAT_RNG_TRAP-only CPU.
>> >
>> > When SCR_EL3.TRNDR is set, ID_AA64ISAR0_EL1.RNDR reads as 1 regardless
>> > of whether FEAT_RNG is implemented; give ID_AA64ISAR0_EL1 a readfn so =
it
>> > reports this at runtime, as we already do for ID_AA64PFR0_EL1.
>> >
>> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Jason Wright <wrigjl@proton.me>
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> >  target/arm/cpu-features.h |  5 ++++
>> >  target/arm/helper.c       | 58 +++++++++++++++++++++++++++++++++++----
>> >  2 files changed, 58 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>> > index 4e8d844fea..38a695ded7 100644
>> > --- a/target/arm/cpu-features.h
>> > +++ b/target/arm/cpu-features.h
>> > @@ -908,6 +908,11 @@ static inline bool isar_feature_aa64_rndr(const A=
RMISARegisters *id)
>> >      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RNDR) !=3D 0;
>> >  }
>> >
>> > +static inline bool isar_feature_aa64_rng_trap(const ARMISARegisters *=
id)
>> > +{
>> > +    return FIELD_EX64_IDREG(id, ID_AA64PFR1, RNDR_TRAP) !=3D 0;
>> > +}
>> > +
>> >  static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters =
*id)
>> >  {
>> >      return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) =3D=3D 2;
>> > diff --git a/target/arm/helper.c b/target/arm/helper.c
>> > index 34487eeaa3..9dd8fdfa41 100644
>> > --- a/target/arm/helper.c
>> > +++ b/target/arm/helper.c
>> > @@ -790,6 +790,9 @@ static void scr_write(CPUARMState *env, const ARMC=
PRegInfo *ri, uint64_t value)
>> >          if (cpu_isar_feature(aa64_fpmr, cpu)) {
>> >              valid_mask |=3D SCR_ENFPM;
>> >          }
>> > +        if (cpu_isar_feature(aa64_rng_trap, cpu)) {
>> > +            valid_mask |=3D SCR_TRNDR;
>> > +        }
>> >      } else {
>> >          valid_mask &=3D ~(SCR_RW | SCR_ST);
>> >          if (cpu_isar_feature(aa32_ras, cpu)) {
>> > @@ -5170,6 +5173,21 @@ static uint64_t id_aa64pfr0_read(CPUARMState *e=
nv, const ARMCPRegInfo *ri)
>> >      }
>> >      return pfr0;
>> >  }
>> > +
>> > +static uint64_t id_aa64isar0_read(CPUARMState *env, const ARMCPRegInf=
o *ri)
>> > +{
>> > +    ARMCPU *cpu =3D env_archcpu(env);
>> > +    uint64_t isar0 =3D GET_IDREG(&cpu->isar, ID_AA64ISAR0);
>> > +
>> > +    /*
>> > +     * When FEAT_RNG_TRAP is active (SCR_EL3.TRNDR set), ID_AA64ISAR0=
_EL1.RNDR
>> > +     * reads as 1 regardless of whether FEAT_RNG is implemented.
>> > +     */
>> > +    if (env->cp15.scr_el3 & SCR_TRNDR) {
>> > +        isar0 =3D FIELD_DP64(isar0, ID_AA64ISAR0, RNDR, 1);
>> > +    }
>> > +    return isar0;
>> > +}
>> >  #endif
>> >
>> >  /*
>> > @@ -5304,6 +5322,22 @@ static const ARMCPRegInfo pauth_reginfo[] =3D {
>> >        .fieldoffset =3D offsetof(CPUARMState, keys.apib.hi) },
>> >  };
>> >
>> > +static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInf=
o *ri,
>> > +                                  bool isread)
>> > +{
>> > +    if (env->cp15.scr_el3 & SCR_TRNDR) {
>> > +        return CP_ACCESS_TRAP_EL3;
>> > +    }
>> > +    /*
>> > +     * Note that FEAT_RNG_TRAP may be implemented without FEAT_RNG.
>> > +     * In that case, if the trap is not enabled, the read undefs.
>> > +     */
>> > +    if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
>> > +        return CP_ACCESS_UNDEFINED;
>> > +    }
>> > +    return CP_ACCESS_OK;
>> > +}
>> > +
>> >  static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
>> >  {
>> >      Error *err =3D NULL;
>> > @@ -5335,11 +5369,11 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
>> >      { .name =3D "RNDR", .state =3D ARM_CP_STATE_AA64,
>> >        .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
>> >        .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 0,
>> > -      .access =3D PL0_R, .readfn =3D rndr_readfn },
>> > +      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_=
readfn },
>> >      { .name =3D "RNDRRS", .state =3D ARM_CP_STATE_AA64,
>> >        .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
>> >        .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 1,
>> > -      .access =3D PL0_R, .readfn =3D rndr_readfn },
>> > +      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_=
readfn },
>> >  };
>> >
>> >  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
>> > @@ -6522,11 +6556,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>> >                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>> >                .accessfn =3D access_tid3,
>> >                .resetvalue =3D 0 },
>> > +            /*
>> > +             * ID_AA64ISAR0_EL1 is not a plain ARM_CP_CONST in system
>> > +             * emulation because the RNDR field depends on SCR_EL3.TR=
NDR
>> > +             * at read time when FEAT_RNG_TRAP is implemented.
>> > +             */
>> >              { .name =3D "ID_AA64ISAR0_EL1", .state =3D ARM_CP_STATE_A=
A64,
>> >                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2=
 =3D 0,
>> > -              .access =3D PL1_R, .type =3D ARM_CP_CONST,
>> > +              .access =3D PL1_R,
>> > +#ifdef CONFIG_USER_ONLY
>> > +              .type =3D ARM_CP_CONST,
>> > +              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)
>> > +#else
>> > +              .type =3D ARM_CP_NO_RAW,
>> >                .accessfn =3D access_tid3,
>> > -              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)},
>> > +              .readfn =3D id_aa64isar0_read,
>> > +              .writefn =3D arm_cp_write_ignore
>> > +#endif
>> > +            },
>>=20
>> A new assert() was triggered when booting guest on M1 since this change:
>>=20
>> Assertion failed: (!(ri->type & ARM_CP_NO_RAW)), function hvf_arch_init_=
vcpu, file hvf.c, line 1442.
>>=20
>> Thanks,
>> Zenghui
>>=20
> Thanks for the report and the bisect, Zenghui. I can reproduce on M1 with:
>
> qemu-system-aarch64 -M virt,accel=3Dhvf -cpu host \
>                       -nographic -display none -bios /dev/null
>
> ID_AA64PFR0_EL1 has the same NO_RAW + readfn shape that the FEAT_RNG_TRAP
> change gave ID_AA64ISAR0_EL1, and HVF already accommodates it by listing
> the cpreg in the SYNC_NO_RAW_REGS block in target/arm/hvf/sysreg.c.inc
> (so the assert loop skips it) and pushing QEMU's value to the vCPU at
> init time. Mirroring that pattern for ID_AA64ISAR0_EL1 clears the assert
> without disturbing the readfn semantics that the spec requires if a
> FEAT_RNG_TRAP-only CPU eventually appears.
>
> I'll send a fix-up as [PATCH] target/arm/hvf shortly.

This highlights why we need some bare metal MacOS machines in the
CI to exercise this code path.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

