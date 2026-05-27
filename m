Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3363FCD6E41
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEjm-0000zI-QK; Wed, 27 May 2026 09:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSEjj-0000z7-QH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:55:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSEjf-0000NX-RK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:55:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so123850895e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779890150; x=1780494950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ve5cygPlQ/W1XTSo3VQVGyUgcIzgm9WbtFJ34w89aPY=;
 b=OiGsibECCU9JgpowtvyjAzh7Z2ifBoR94mGdINmTHqeWbrRoYMZ7qCyEvkoxQxRErn
 dZq7/nCFif4yaXrkmnDeV93OFcMOUEerXtvqNgiQWDin1Yshi8etQIkTQEc7suYR50Qg
 OBYROPWcIf1lFALuF1UwCDs0hF5/OUn06f6f40guK6qAvR3+GvA7+ElLnWxyOkth0q3X
 FBrGEPjsmE/pgnyhv4UjXiDy75gM8ShvDNA7YCknKnU1OWXmAAK3HBPEqAiIRW2nF0Fq
 ddipxNI7qO7+zF4CeLsM2D/s7ASpYDqOtkAO71GWGCAIZ8SjQTHgWsfswhcsQRNWwz+a
 eHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779890150; x=1780494950;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ve5cygPlQ/W1XTSo3VQVGyUgcIzgm9WbtFJ34w89aPY=;
 b=hI7FwlrsMj75mzpLRDTOpcXj3E2PG2L60W3JAyqUTDQR4oD8glNAJguliLZl6VDIWB
 LpKd18Q3++PpXjxqdEvNR5B6V6YwllvvXQWEpnQUqpGDYLqNTJ0Xml07vJVMAYU/He85
 /bdC5cn/4o4ucTePT0njf5mc0lAbOOZ1QL98l9OPGnshc7/Ru3EbA1kS/L+vIsJNVPwE
 P3/nDO2h2aO4C2349DPGFRrQIVP6g+dMcWxXFYOR0+CB/I6kat1PBNp5FfYwARyGS1Bd
 rLswQF/BglO+0I752BckOScSxS+rjo57r+XdCJCep3K4IcegLsWZ66G79EtDWvFVF8R5
 cxcQ==
X-Gm-Message-State: AOJu0YxlZ6QEOoBC5rPsc4bd8X6Rtv+ANzvzyfKWLOzPZ3/twEwdplHn
 LkO4+mtqcPLkXHYIBdOmDQNfkPPka0J/toWNBRkXr6Pg5cqNpUXKqHfvS8JIl3JhcPo=
X-Gm-Gg: Acq92OHJcA2wNPdz8gr4d4d/lcSv4HMIf3+u5cAMLAg67yC4ySzXT47xH6ve3ZmedKC
 hZc4/u9ztovuMT9r1qW34/o4Pb9ye8HqRxE/NkH/sg9qq+ILFk2TdlpNQ8vsjJ7L8v6LizsjhhM
 +zRUUVJNwdxWIk932S24kYxEDfB5OcyAaBpW017uxc/ucROKs9laxp4diDDene7vEo2u+DWGFA+
 mgaIiPUsx3nBIzZ4pgcZ/VFQ19IFVzroA8F3th5RETr+ZLjLC6wHTJxeGe6IALrr3h3lhRjovtO
 2gubxdP7z0TKOcsfe0TUYz59AB+ag/jCGuWEt45CAupUULz3rGPI+UqGoJERwsHZZEcN0URXtHa
 JRMY2tTYT4ZA2pS1olrFSp9FvJG6GqvVQ5abcTIJuu0ZtGSsui7MLT6zh4+Wv+qSj9I3bJb7Txz
 8Zic/8JRKJpI79sG2rDVRW53exKZJ0ywqVkw==
X-Received: by 2002:a05:600c:1393:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-490428e0bf3mr385459495e9.31.1779890150008; 
 Wed, 27 May 2026 06:55:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a432sm8778535f8f.3.2026.05.27.06.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:55:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E86B5F7F0;
 Wed, 27 May 2026 14:55:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Torbj=C3=B6rn?= SVENSSON <torbjorn.svensson@foss.st.com>
Cc: <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 3/3] target/arm: implement v8.1-m PAC support
In-Reply-To: <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
 (=?utf-8?Q?=22Torbj=C3=B6rn?=
 SVENSSON"'s message of "Mon, 18 May 2026 18:14:01 +0200")
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 14:55:48 +0100
Message-ID: <875x49x8gr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com> writes:

> The algorithm used for hashing is a simple XOR between the pointer
> and the modifier using the "implementation defined" scheme.
>
> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>
> ---
>  target/arm/cpu-features.h  |  6 +++
>  target/arm/internals.h     |  2 +
>  target/arm/tcg/cpu-v7m.c   |  2 +-
>  target/arm/tcg/m_helper.c  | 17 ++++++++
>  target/arm/tcg/translate.c | 98 ++++++++++++++++++++++++++++++++++++++++=
------
>  5 files changed, 113 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4e44245a8b..60bd7a0765 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -114,6 +114,7 @@ FIELD(ID_ISAR5, AES, 4, 4)
>  FIELD(ID_ISAR5, SHA1, 8, 4)
>  FIELD(ID_ISAR5, SHA2, 12, 4)
>  FIELD(ID_ISAR5, CRC32, 16, 4)
> +FIELD(ID_ISAR5, PACBTI, 20, 4)
>  FIELD(ID_ISAR5, RDM, 24, 4)
>  FIELD(ID_ISAR5, VCMA, 28, 4)
>=20=20
> @@ -583,6 +584,11 @@ static inline bool isar_feature_aa32_m_sec_state(con=
st ARMISARegisters *id)
>      return FIELD_EX32_IDREG(id, ID_PFR1, SECURITY) >=3D 3;
>  }
>=20=20
> +static inline bool isar_feature_aa32_m_pacbti(const ARMISARegisters *id)
> +{
> +    return FIELD_EX32_IDREG(id, ID_ISAR5, PACBTI) !=3D 0;
> +}

See isar_feature_aa64_pauth and friends.

> +
>  static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *i=
d)
>  {
>      /* Sadly this is encoded differently for A-profile and M-profile */
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 00830b1724..cbb0a1d8fc 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -90,6 +90,8 @@ FIELD(V7M_CONTROL, NPRIV, 0, 1)
>  FIELD(V7M_CONTROL, SPSEL, 1, 1)
>  FIELD(V7M_CONTROL, FPCA, 2, 1)
>  FIELD(V7M_CONTROL, SFPA, 3, 1)
> +FIELD(V7M_CONTROL, PAC_EN, 6, 1)
> +FIELD(V7M_CONTROL, UPAC_EN, 7, 1)

Hmm my copy of the v7m Arm ARM doesn't include these bits...

But I can see it online:

  https://developer.arm.com/documentation/109576/0100/Pointer-Authenticatio=
n-Code/Enabling-pointer-authentication?lang=3Den

>=20=20
>  /* Bit definitions for v7M exception return payload */
>  FIELD(V7M_EXCRET, ES, 0, 1)
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index 5cfda232cd..3beb2b23fa 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -269,7 +269,7 @@ static void cortex_m85_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR2, 0x20232232);
>      SET_IDREG(isar, ID_ISAR3, 0x01111131);
>      SET_IDREG(isar, ID_ISAR4, 0x01310132);
> -    SET_IDREG(isar, ID_ISAR5, 0x00000000);
> +    SET_IDREG(isar, ID_ISAR5, 0x00200000); /* PACBTI=3Dimplementation de=
fined */
>      SET_IDREG(isar, ID_ISAR6, 0x00000000);
>      SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
>      cpu->ctr =3D 0x8303c003;
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index f2059ed8b0..1160fe8d87 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -2658,6 +2658,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t ma=
skreg, uint32_t val)
>                  env->v7m.control[M_REG_S] &=3D ~R_V7M_CONTROL_FPCA_MASK;
>                  env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
>              }
> +
> +            /* Only update PAC_EN / UPAC_EN if PACBTI is implemented. */
> +            if (cpu_isar_feature(aa32_m_pacbti, env_archcpu(env))) {
> +                uint32_t enable_mask =3D
> +                    R_V7M_CONTROL_PAC_EN_MASK | R_V7M_CONTROL_UPAC_EN_MA=
SK;
> +                env->v7m.control[M_REG_NS] &=3D ~enable_mask;
> +                env->v7m.control[M_REG_NS] |=3D val & enable_mask;

Hmm I was going to suggest looking at FIELD_DP32 but it looks like this
is following the existing style.

> +            }
> +
>              return;
>          case 0x98: /* SP_NS */
>          {
> @@ -2784,6 +2793,14 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t ma=
skreg, uint32_t val)
>                  env->v7m.control[M_REG_S] |=3D val & R_V7M_CONTROL_FPCA_=
MASK;
>              }
>          }
> +
> +        /* Only update PAC_EN / UPAC_EN if PACBTI is implemented. */
> +        if (cpu_isar_feature(aa32_m_pacbti, env_archcpu(env))) {
> +            uint32_t enable_mask =3D
> +                R_V7M_CONTROL_PAC_EN_MASK | R_V7M_CONTROL_UPAC_EN_MASK;
> +            env->v7m.control[env->v7m.secure] &=3D ~enable_mask;
> +            env->v7m.control[env->v7m.secure] |=3D val & enable_mask;
> +        }
>          break;
>      default:
>      bad_reg:
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index ae1351ef03..e13119b33b 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -5012,26 +5012,80 @@ static bool trans_SMMLSR(DisasContext *s, arg_rrr=
r *a)
>      return op_smmla(s, a, true, true);
>  }
>=20=20
> +static void arm_gen_test_pac_enabled(DisasContext *s, TCGLabel *label)
> +{
> +    int bank =3D s->v8m_secure ? M_REG_S : M_REG_NS;
> +    int mask =3D IS_USER(s)
> +        ?  R_V7M_CONTROL_UPAC_EN_MASK
> +        : R_V7M_CONTROL_PAC_EN_MASK;
> +    TCGv_i32 temp =3D load_cpu_field(v7m.control[bank]);
> +    tcg_gen_brcondi_i32(TCG_COND_TSTEQ, temp, mask, label);
> +}
> +
> +static TCGv_i32 op_create_pac_hash(DisasContext *s, int rn, int rm)
> +{
> +    TCGv_i32 res =3D tcg_temp_new_i32();
> +    TCGv_i64 ext_ptr =3D tcg_temp_new_i64();
> +    TCGv_i64 modifier =3D tcg_temp_new_i64();
> +    TCGv_i64 temp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_extu_i32_i64(ext_ptr, load_reg(s, rn));
> +    tcg_gen_extu_i32_i64(modifier, load_reg(s, rm));
> +
> +    /*
> +     * This a very simple implementation that just xor the two
> +     * inputs. The goal is not to replicate any of the predefined
> +     * hashing functions, but use a simple check.
> +     */
> +    tcg_gen_xor_i64(temp, ext_ptr, modifier);
> +
> +    /* Return the lower word */
> +    tcg_gen_extrl_i64_i32(res, temp);
> +    return res;

Is it really needed here? Could you not create an equivalent of
pauth_computepac for m-profile and use the architected helpers or
fall-back to the xxhash impl?

Is does mean a helper call but it would keep more in common with the
A-profile code.

> +}
> +
> +static bool op_pacg(DisasContext *s, arg_rrr *a)
> +{
> +    TCGv_i32 temp;
> +    TCGLabel *done =3D gen_new_label();
> +
> +    arm_gen_test_pac_enabled(s, done);
> +
> +    temp =3D op_create_pac_hash(s, a->rn, a->rm);
> +    store_reg(s, a->rd, temp);
> +
> +    gen_set_label(done);
> +    return true;
> +}
> +
>  static bool trans_PAC(DisasContext *s, arg_empty *a)
>  {
> +    arg_rrr arg;
> +
>      if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
>          return false;
>      }
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    arg.rd =3D 0xc; /* R12 */
> +    arg.rn =3D 0xe; /* LR */
> +    arg.rm =3D 0xd; /* SP */
> +    return op_pacg(s, &arg);
>  }
>=20=20
>  static bool trans_PACBTI(DisasContext *s, arg_empty *a)
>  {
> +    arg_rrr arg;
> +
>      if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
>          return false;
>      }
>=20=20
>      /* todo: reset EPSR.B to 0 */
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    arg.rd =3D 0xc; /* R12 */
> +    arg.rn =3D 0xe; /* LR */
> +    arg.rm =3D 0xd; /* SP */
> +    return op_pacg(s, &arg);
>  }
>=20=20
>  static bool trans_PACG(DisasContext *s, arg_rrr *a)
> @@ -5040,7 +5094,26 @@ static bool trans_PACG(DisasContext *s, arg_rrr *a)
>          return false;
>      }
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> +    return op_pacg(s, a);
> +}
> +
> +static bool op_autg(DisasContext *s, arg_rrrr *a, int set_pc_from_reg)
> +{
> +    TCGv_i32 expected_pac_hash, actual_pac_hash;
> +    TCGLabel *done =3D gen_new_label();
> +    TCGLabel *fail =3D delay_exception(s, EXCP_INVSTATE, syn_uncategoriz=
ed());
> +
> +    arm_gen_test_pac_enabled(s, done);
> +
> +    expected_pac_hash =3D load_reg(s, a->ra);
> +    actual_pac_hash =3D op_create_pac_hash(s, a->rn, a->rm);
> +    tcg_gen_brcond_i32(TCG_COND_NE, expected_pac_hash, actual_pac_hash, =
fail);
> +
> +    gen_set_label(done);
> +    if (set_pc_from_reg >=3D 0) {
> +        gen_bx_excret(s, load_reg(s, set_pc_from_reg));
> +    }
> +
>      return true;
>  }
>=20=20
> @@ -5050,18 +5123,22 @@ static bool trans_BXAUT(DisasContext *s, arg_rrrr=
 *a)
>          return false;
>      }
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    return op_autg(s, a, a->rn);
>  }
>=20=20
>  static bool trans_AUT(DisasContext *s, arg_empty *a)
>  {
> +    arg_rrrr arg;
> +
>      if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
>          return false;
>      }
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    arg.rd =3D 0; /* unused */
> +    arg.ra =3D 0xc; /* R12 */
> +    arg.rn =3D 0xe; /* LR */
> +    arg.rm =3D 0xd; /* SP */
> +    return op_autg(s, &arg, -1);
>  }
>=20=20
>  static bool trans_AUTG(DisasContext *s, arg_rrrr *a)
> @@ -5070,8 +5147,7 @@ static bool trans_AUTG(DisasContext *s, arg_rrrr *a)
>          return false;
>      }
>=20=20
> -    /* Handle as if PACBTI is disabled. */
> -    return true;
> +    return op_autg(s, a, -1);
>  }
>=20=20
>  static bool op_div(DisasContext *s, arg_rrr *a, bool u)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

