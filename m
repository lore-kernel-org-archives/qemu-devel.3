Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD08CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulNQg-0008Ki-ET; Mon, 11 Aug 2025 03:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulNQe-0008KT-0S
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:58:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulNQV-0002uK-D7
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:58:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso39564095e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754899116; x=1755503916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3G5UvgaNnMQ45il3AslcTljeJ0uS1dHP410BO5S58PY=;
 b=xO+Jn5X4h6gIHIJYwfH0UmisePjHLPaiuo39C7V3/zX2KRQEaZyh4uoAxONkOHQqGu
 LUm8t5c0qutX7v6CVsW46ktOPXkAXQhYOGiK2pUXStAKfeZPLHwLbTvlbXp9tK9cAoRD
 fNxDrnv1TYkulvxXw/zVjo2YCSewQU+AAE2CO81saqMdryQHiwsszF9h+kz60Smi6Tpe
 UAx5o2O9zv/VZbFX/n1hMVv8MrKfGTDGrBFgEQT2d0NlyZCoS4TUgfHQ37AMbhJz/qO1
 QWgYxC0lvPpep9d6WdgjcPkFB+oZU9nUJ1vt4u6k7THKUHQdMM9L0NNLGklPQjJp3KyR
 N/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754899116; x=1755503916;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3G5UvgaNnMQ45il3AslcTljeJ0uS1dHP410BO5S58PY=;
 b=SUxXBtit7IVvQArQxvLLiKinNE5ZoLKPZLsWsZj2uvZaAOFbv+kd7+ppw2zARwMBRv
 YiC3fM/VODcSKvRvRlrdWlxAhn7scICsvS3Uya3aQpl6Y1dSiS+/0nvTmr5g0qtSye0m
 W1VxrPsCbCmgKo1KZDlqO5FJTXyYr9YCmbmaKQoztXULMf/TBzl6o0bPjcRW8D4fT0qf
 mlmmVwQTdqrCxA/Iu/ATxz7J8EfXOuwV53s7wV28+kfsuv4Z5b+OwyeQtsFx+1y1aPWL
 +3XnFl1afX3UoKE/V+feqSqaDglbJVrIfUof/0KZ2m61X+tImpPPhVbwx6p73D4tcBpd
 xYfw==
X-Gm-Message-State: AOJu0YyAsTlcckKwCzpshZ3ueDg9O6MWbMf1o3znXkDQwdpQVM2enbe8
 0HRcmQbPFkpyF/XosSz+ditOwJnSzlMYhKAXW+ZH/lKgNODHPhe2bWoNQiYu5C/Hrf8=
X-Gm-Gg: ASbGnctNLEtAecd1pimsrgtP8d85KOXcJzbuJU7sUqoLpj+jtA7CQSO0OokW/iPirxL
 OSFK1UwiVkjsLpBBcCOdtn/CIstLMoNwiPdaFPyO2kDWGm2PdW4zGk/MOQ/Gh+WIY0QDGq+Feh+
 EJO3HYIKzQwqKNs/S7tjBQI0wpvFJtc32MVvXEUI46E5QhPfqZCqouJZqmtnzc1zuv8yZnenT/3
 O8mUK/3CQ1ZPOGOhPmex6l2XYxNrRNKx0ULVfFKd4yfBsoenIbJ+a8O2qP4w7mDSOiOTjnIP4UP
 TQF5ShuX1/kkhVWAjEm4ZELlVQmuXVdHqvugBLnmc2v4eNkm3zLkaPeRZUwlRyMDVNuiqiu9MnY
 J0ZobjS+GMyGHG5Zc7JHJvWM=
X-Google-Smtp-Source: AGHT+IGIToCIuov5LeNrF94/KlG5niFqMK1a4fxFNuEuJ9J0ePWcuWgklYxn3nplSqGUe9zsaI/+Ig==
X-Received: by 2002:a05:600c:1d04:b0:459:d3d0:650e with SMTP id
 5b1f17b1804b1-459f4f52923mr101539625e9.13.1754899115624; 
 Mon, 11 Aug 2025 00:58:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0a24bf1sm266646195e9.1.2025.08.11.00.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 00:58:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C82CA5F7F6;
 Mon, 11 Aug 2025 08:58:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v4 2/2] target/arm: Added support for SME register
 exposure to GDB
In-Reply-To: <CAEWVDmstkUnsLbj-h2g9p5ajUSuc9UZXngqFOj-xgoJO2PsWiw@mail.gmail.com>
 (Vacha Bhavsar's message of "Fri, 8 Aug 2025 09:54:12 -0400")
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com>
 <87zfcf5cco.fsf@draig.linaro.org>
 <CAEWVDmstkUnsLbj-h2g9p5ajUSuc9UZXngqFOj-xgoJO2PsWiw@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 11 Aug 2025 08:58:33 +0100
Message-ID: <87cy92jnme.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> Hi,
>
>=20=20
>
> I've built a testcase for this similar to the one you suggested. This tes=
t=20
>
> checks both reading and writing the za register via $za and via the tiles
>
> and tiles slices that gdb produces (i.e., za0hb0). However, these tiles a=
nd=20
>
> slices are generated from the gdb side, they're not made available by any
>
> of the changes that I have implemented. But this feature of gdb's kicks in
>
> when using gdb14.1 or newer. Due to this, the testcase works correctly wh=
en
>
> used with gdb14.1 and above, and fails on any gdb version older than that
>
> as the tiles/slices are not made available by gdb.
>
>=20=20
>
> I was wondering if there is any way to set a requirement on this testcase
>
> which specifies it needs to be run with minimum of gdb version 14.1
>
> which has the functionality to break down the ZA storage into tiles and=20
>
> slices?

We have tests in configure to probe the gdbversion, e.g:

  if test "${gdb_arches#*aarch64}" !=3D "$gdb_arches" && version_ge $gdb_ve=
rsion 15.1; then
      echo "GDB_HAS_MTE=3Dy" >> $config_target_mak
  fi

which can then wrap the test in the Makefile, e.g.:

  ifeq ($(GDB_HAS_MTE),y)
  run-gdbstub-mte: mte-8
          $(call run-test, $@, $(GDB_SCRIPT) \
                  --gdb $(GDB) \
                  --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
                  --bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
                  -- --mode=3Duser, \
          gdbstub MTE support)

  EXTRA_RUNS +=3D run-gdbstub-mte
  endif


>
>=20=20
>
>=20=20
>
> Thanks,
>
> Vacha
>
> On Mon, Aug 4, 2025 at 11:35=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>
>  > The QEMU GDB stub does not expose the ZA storage SME register to GDB v=
ia
>  > the remote serial protocol, which can be a useful functionality to deb=
ug SME
>  > code. To provide this functionality in Aarch64 target, this patch regi=
sters the
>  > SME register set with the GDB stub. To do so, this patch implements the
>  > aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
>  > specify how to get and set the SME registers, and the
>  > arm_gen_dynamic_smereg_feature() function to generate the target
>  > description in XML format to indicate the target architecture supports=
 SME.
>  > Finally, this patch includes a dyn_smereg_feature structure to hold th=
is
>  > GDB XML description of the SME registers for each CPU.
>  >
>  > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
>  > ---
>  > Changes since v3:
>  > - added changes to aarch64_gdb_set_sme_reg() to address the concerns=20
>  > brought up in review regarding endianness
>  >
>  >  target/arm/cpu.h       |   1 +
>  >  target/arm/gdbstub.c   |   6 ++
>  >  target/arm/gdbstub64.c | 122 +++++++++++++++++++++++++++++++++++++++++
>  >  target/arm/internals.h |   3 +
>  >  4 files changed, 132 insertions(+)
>  >
>  > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>  > index dc9b6dce4c..8bd66d7049 100644
>  > --- a/target/arm/cpu.h
>  > +++ b/target/arm/cpu.h
>  > @@ -933,6 +933,7 @@ struct ArchCPU {
>  >=20=20
>  >      DynamicGDBFeatureInfo dyn_sysreg_feature;
>  >      DynamicGDBFeatureInfo dyn_svereg_feature;
>  > +    DynamicGDBFeatureInfo dyn_smereg_feature;
>  >      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
>  >      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
>  >=20=20
>  > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>  > index ce4497ad7c..9c942c77cc 100644
>  > --- a/target/arm/gdbstub.c
>  > +++ b/target/arm/gdbstub.c
>  > @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)
>  >              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs=
, cs->gdb_num_regs);
>  >              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>  >                                       aarch64_gdb_set_sve_reg, feature=
, 0);
>  > +            if (isar_feature_aa64_sme(&cpu->isar)) {
>  > +                GDBFeature *sme_feature =3D arm_gen_dynamic_smereg_fe=
ature(cs,
>  > +                                             cs->gdb_num_regs);
>  > +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
>  > +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
>  > +            }
>  >          } else {
>  >              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
>  >                                       aarch64_gdb_set_fpu_reg,
>  > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>  > index 64ee9b3b56..3d86980bc9 100644
>  > --- a/target/arm/gdbstub64.c
>  > +++ b/target/arm/gdbstub64.c
>  > @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t=
 *buf, int reg)
>  >      return 0;
>  >  }
>  >=20=20
>  > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
>  > +{
>  > +    ARMCPU *cpu =3D ARM_CPU(cs);
>  > +    CPUARMState *env =3D &cpu->env;
>  > +
>  > +    switch (reg) {
>  > +    /* Svg register */
>  > +    case 0:
>  > +    {
>  > +        int vq =3D 0;
>  > +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
>  > +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
>  > +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
>  > +        }
>  > +        /* svg =3D vector granules (2 * vector quardwords) in streami=
ng mode */
>  > +        return gdb_get_reg64(buf, vq * 2);
>  > +    }
>  > +    case 1:
>  > +        return gdb_get_reg64(buf, env->svcr);
>  > +    case 2:
>  > +    {
>  > +        int len =3D 0;
>  > +        int vq =3D cpu->sme_max_vq;
>  > +        int svl =3D vq * 16;
>  > +        for (int i =3D 0; i < svl; i++) {
>  > +            for (int q =3D 0; q < vq; q++) {
>  > +                len +=3D gdb_get_reg128(buf,
>  > +                           env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q =
* 2 + 1],
>  > +                           env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q =
* 2]);
>  > +            }
>  > +        }
>  > +        return len;
>  > +    }
>  > +    default:
>  > +        /* gdbstub asked for something out of range */
>  > +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __fu=
nc__, reg);
>  > +        break;
>  > +    }
>  > +
>  > +    return 0;
>  > +}
>  > +
>  > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
>  > +{
>  > +    ARMCPU *cpu =3D ARM_CPU(cs);
>  > +    CPUARMState *env =3D &cpu->env;
>  > +
>  > +    switch (reg) {
>  > +    case 0:
>  > +    {
>  > +        /* cannot set svg via gdbstub */
>  > +        return 8;
>  > +    }
>  > +    case 1:
>  > +        aarch64_set_svcr(env, ldq_le_p(buf),
>  > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
>  > +        return 8;
>  > +    case 2:
>  > +        int len =3D 0;
>  > +        int vq =3D cpu->sme_max_vq;
>  > +        int svl =3D vq * 16;
>  > +        for (int i =3D 0; i < svl; i++) {
>  > +            for (int q =3D 0; q < vq; q++) {
>  > +                if (target_big_endian()){
>  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2 + 1=
] =3D ldq_p(buf);
>  > +                    buf +=3D 8;
>  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2] =
=3D ldq_p(buf);
>  > +                } else{
>  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2] =
=3D ldq_p(buf);
>  > +                    buf +=3D 8;
>  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2 + 1=
] =3D ldq_p(buf);
>  > +                }
>  > +                buf +=3D 8;
>  > +                len +=3D 16;
>  > +            }
>  > +        }
>  > +        return len;
>  > +    default:
>  > +        /* gdbstub asked for something out of range */
>  > +        break;
>  > +    }
>  > +
>  > +    return 0;
>  > +}
>  > +
>  >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
>  >  {
>  >      ARMCPU *cpu =3D ARM_CPU(cs);
>  > @@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUSta=
te *cs, int base_reg)
>  >      return &cpu->dyn_svereg_feature.desc;
>  >  }
>  >=20=20
>  > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
>  > +{
>  > +    ARMCPU *cpu =3D ARM_CPU(cs);
>  > +    int vq =3D cpu->sme_max_vq;
>  > +    int svl =3D vq * 16;
>  > +    GDBFeatureBuilder builder;
>  > +    int reg =3D 0;
>  > +
>  > +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
>  > +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
>  > +
>  > +
>  > +    /* Create the sme_bv vector type. */
>  > +    gdb_feature_builder_append_tag(&builder,
>  > +        "<vector id=3D\"sme_bv\" type=3D\"uint8\" count=3D\"%d\"/>",
>  > +        svl);
>  > +
>  > +    /* Create the sme_bvv vector type. */
>  > +    gdb_feature_builder_append_tag(
>  > +        &builder, "<vector id=3D\"sme_bvv\" type=3D\"sme_bv\" count=
=3D\"%d\"/>",
>  > +        svl);
>  > +
>  > +    /* Define the svg, svcr, and za registers. */
>  > +
>  > +    /* fpscr & status registers */
>  > +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
>  > +        "int", NULL);
>  > +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
>  > +        "int", NULL);
>  > +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg=
++,
>  > +        "sme_bvv", NULL);
>  > +
>  > +    gdb_feature_builder_end(&builder);
>  > +
>  > +    return &cpu->dyn_smereg_feature.desc;
>  > +}
>  > +
>  >  #ifdef CONFIG_USER_ONLY
>  >  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int re=
g)
>  >  {
>  > diff --git a/target/arm/internals.h b/target/arm/internals.h
>  > index c4765e4489..760e1c6490 100644
>  > --- a/target/arm/internals.h
>  > +++ b/target/arm/internals.h
>  > @@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMS=
tate *env)
>  >  }
>  >=20=20
>  >  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_re=
g);
>  > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_re=
g);
>  >  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>  >  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
>  > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
>  > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
>  >  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
>  >  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
>  >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
>
>  It would also be nice to add a test for this, see tests/tcg/aarch64/gdbs=
tub/test-sve.py
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

