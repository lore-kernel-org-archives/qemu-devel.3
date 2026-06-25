Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34378CDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmo4-0005pp-LP; Thu, 25 Jun 2026 12:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcmo3-0005pR-HF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcmo1-0003qo-GT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-46cbf263113so1955420f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782404395; x=1783009195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj7X5I6CCUGv3cEHugrfroZPva44IefEq//8zcmRGsA=;
 b=zAqsaSChpIK6QL3SC9rGcTHyAWqUEFaxFWlpl8o9ccA8uk+S4q8xNBLOfyBDwAIOfa
 AN0fFVFXB5YfPw2OvE0zLlixLd0y8yJaAOq/Ej66bRdEHOlFDEQSDPDaHtXFWBDjgizf
 MPSQ4eC2xsVZnISEbuubVEoeGf/QqmN5hTCIgYGt5SfbEURSOuPAYPi9zi6qXIYuknmT
 SoGzfyziicOryoQAfEXIhHyNKZyKGecYV8d0YGF4ywn6kxLPRads7wyQetQLRargMaCi
 ri7B3/zkC6WWtrTY/s271BHA3Vn84zxN7gx/ZLrRInteCHpWU/JoKNjuZhuMqvU6r+5w
 cr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404395; x=1783009195;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bj7X5I6CCUGv3cEHugrfroZPva44IefEq//8zcmRGsA=;
 b=UaXw1t0X6Y8vo/5oBxNSN/Y78vsxj4qU+ykmxZrh3zYEHhcr4ZDQ3arQpDzZJzahAp
 8KOkbzAs5mzl7t10TZtkcus4yuT/pv39liSC5q0DGfUSCUHE5R/iCkpPh/KtYTMN5pLn
 mYZblLVknN9wNzWhm8FoW+gpfO2G7wdzhW+VnIVx08NBEBgrex1nr7MalscD9F02oRFW
 51n9VwNKo7wSjrJOCyukDHvrXf3nhiZmPt/sbr5QmVUXdLxTBg1fC/K22MDBai/xXPFS
 mq0udgRkkaVo8f21owSg/f3r/ghs0QBENeh/ktCaVYCm0yLZJRrcmFpjxAFoRtEvvLhf
 Q5zA==
X-Gm-Message-State: AOJu0YzIT+p3k5iy9MC+pulePMaWCmbIX+ruizIOkYrzJ5UJvtkpjbKh
 mDIUZIFSaeKFrEMacOa1YQ5SS21E0vLOzd2TEupUBdqoFfL3NIAd2OickPiTz1WXCBk=
X-Gm-Gg: AfdE7cmDqqOTI1/bWFCa3xopVkeWUasR+kwhDYFnvX7xlSNyyElVKZCU3KsSFV3CkSV
 +bdGQe6jdczeAwNA27fq+AoQoTkNwBtnQK4W6F1lb21u3FNGa9/CTS6HFhyeYsB+51E2RoizcJB
 eQtNQ0wEBqmfqJ/No538i8INRU/9wut1fhAm/x7fkVXwrzicpPCF6QH+i3gLb8BcfopfiCQgLZ8
 F4FnrkEg5XhBz8lM1fxrd6JYtStxhjWTaNPf8RWBRG0DCbCJIep8zOmOkhBJ4SXG8BYSGfymSl1
 UTk6bMq8Rr1+s2+ikqofs8XJjF9UYixLQh15/0W4Tbp5Nf7CsphG18XT5J/R/R9TeZ73+rtY8Ug
 a3qdjX39B1tO9lxDmeQIFLfIrYW7Yw+Pf5SH01aYckNjys4JWaLZhe/e+yQ4WsCVbkzxqdKyxGk
 erOqN+sT1isRuA
X-Received: by 2002:a05:6000:461a:b0:46d:a16b:d21 with SMTP id
 ffacd0b85a97d-46dc1aa69b1mr4572281f8f.39.1782404395481; 
 Thu, 25 Jun 2026 09:19:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dc10e8f3bsm7721356f8f.2.2026.06.25.09.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:19:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C85BF5F8E5;
 Thu, 25 Jun 2026 17:19:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/6] target/arm/tcg: Implement new instructions for
 FPRCVT
In-Reply-To: <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org> (Jim
 MacArthur's message of "Wed, 24 Jun 2026 14:37:25 +0100")
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 25 Jun 2026 17:19:53 +0100
Message-ID: <87y0g2h9sm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Adds the opcode format for the SIMD versions of FCVTXX and [US]CVTF.
> These use very similar logic to the FP-to-general and general-to-FP
> register versions which exist, but use another SIMD/FP register
> as source or destination. The source and destination size rules are
> slightly different.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++
>  target/arm/tcg/a64.decode      | 15 +++++++++
>  target/arm/tcg/translate-a64.c | 71 ++++++++++++++++++++++++++++++++++++=
+-----
>  3 files changed, 83 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index a80b251589..aba95f4253 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1665,6 +1665,11 @@ static inline bool isar_feature_aa64_f8mm4(const A=
RMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
>  }
>=20=20
> +static inline bool isar_feature_aa64_fprcvt(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64ISAR3, FPRCVT);
> +}
> +
>  /*
>   * Combinations of feature tests, for ease of use with TRANS_FEAT.
>   */
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 28cd1faf61..5b6f156d08 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -1456,6 +1456,21 @@ FCVTZU_g        . 0011110 .. 111001 000000 ..... .=
....  @icvt
>  FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
>  FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
>=20=20
> +# Conversion between floating-point and integer (SIMD & FP)
> +SCVTF_simd      . 0011110 .. 111100 000000 ..... .....  @icvt
> +UCVTF_simd      . 0011110 .. 111101 000000 ..... .....  @icvt
> +
> +FCVTAS_g_simd   . 0011110 .. 111010 000000 ..... .....  @icvt
> +FCVTAU_g_simd   . 0011110 .. 111011 000000 ..... .....  @icvt
> +FCVTMS_g_simd   . 0011110 .. 110100 000000 ..... .....  @icvt
> +FCVTMU_g_simd   . 0011110 .. 110101 000000 ..... .....  @icvt
> +FCVTNS_g_simd   . 0011110 .. 101010 000000 ..... .....  @icvt
> +FCVTNU_g_simd   . 0011110 .. 101011 000000 ..... .....  @icvt
> +FCVTPS_g_simd   . 0011110 .. 110010 000000 ..... .....  @icvt
> +FCVTPU_g_simd   . 0011110 .. 110011 000000 ..... .....  @icvt
> +FCVTZS_g_simd   . 0011110 .. 110110 000000 ..... .....  @icvt
> +FCVTZU_g_simd   . 0011110 .. 110111 000000 ..... .....  @icvt
> +
>  FJCVTZS         0 0011110 01 111110 000000 ..... .....  @rr
>=20=20
>  FMOV_ws         0 0011110 00 100110 000000 ..... .....  @rr
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 227719ef25..07f985a5f0 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -9905,12 +9905,14 @@ TRANS(SCVTF_g, do_cvtf_g, a, true)
>  TRANS(UCVTF_g, do_cvtf_g, a, false)
>=20=20
>  /*
> - * [US]CVTF (vector), scalar version.
> - * Which sounds weird, but really just means input from fp register
> + * [US]CVTF (vector), scalar or SIMD version.
> + * Which sounds weird, but really just means input from FP/SIMD register
>   * instead of input from general register.  Input and output element
> - * size are always equal.
> + * size are always equal for the scalar version and different for the
> + * SIMD version.
>   */
> -static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, bool is_signed)
> +static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, MemOp src_mop_int,
> +                      bool is_signed)
>  {
>      TCGv_i64 tcg_int;
>      int check =3D fp_access_check_scalar_hsd(s, a->esz);
> @@ -9918,14 +9920,18 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *=
a, bool is_signed)
>      if (check <=3D 0) {
>          return check =3D=3D 0;
>      }
> -
>      tcg_int =3D tcg_temp_new_i64();
> -    read_vec_element(s, tcg_int, a->rn, 0, a->esz | (is_signed ? MO_SIGN=
 : 0));
> +    read_vec_element(s, tcg_int, a->rn, 0,
> +                     src_mop_int | (is_signed ? MO_SIGN : 0));
>      return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed=
);
>  }
>=20=20
> -TRANS(SCVTF_f, do_cvtf_f, a, true)
> -TRANS(UCVTF_f, do_cvtf_f, a, false)
> +TRANS(SCVTF_f, do_cvtf_f, a, a->esz, true)
> +TRANS(UCVTF_f, do_cvtf_f, a, a->esz, false)
> +TRANS_FEAT(SCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
> +           a->sf ? MO_64 : MO_32, true)
> +TRANS_FEAT(UCVTF_simd, aa64_fprcvt, do_cvtf_f, a,
> +           a->sf ? MO_64 : MO_32, false)
>=20=20
>  static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
>                             TCGv_i64 tcg_out, int shift, int rn,
> @@ -10044,6 +10050,34 @@ static bool do_fcvt_g(DisasContext *s, arg_fcvt =
*a,
>      return true;
>  }
>=20=20
> +/*
> + * Floating point to int conversion, but puts the result
> + * in a SIMD register.
> + */
> +static bool do_fcvt_simd(DisasContext *s, arg_fcvt *a,
> +                      ARMFPRounding rmode, bool is_signed)
> +{
> +    TCGv_i64 tcg_int;
> +    int check =3D fp_access_check_scalar_hsd(s, a->esz);
> +

I did test with:

  g_assert(s->is_nonstreaming =3D=3D false);

which shows trans_FAIL or aarch64_tr_translate_insn setting had done
whatever it was supposed to.

> +    if (check <=3D 0) {
> +        return check =3D=3D 0;
> +    }
> +    /*
> +     * a->sf should specify destination size (64 bit or 32 bit)
> +     * a->esz specifies source size
> +     */
> +    tcg_int =3D tcg_temp_new_i64();
> +    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0=
),
> +                   a->esz, tcg_int, a->shift, a->rn, rmode);
> +
> +    if (!s->fpcr_nep) {
> +        clear_vec(s, a->rd);
> +    }
> +    write_vec_element(s, tcg_int, a->rd, 0, (a->sf ? MO_64 : MO_32));
> +    return true;
> +}
> +
>  TRANS(FCVTNS_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, true)
>  TRANS(FCVTNU_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, false)
>  TRANS(FCVTPS_g, do_fcvt_g, a, FPROUNDING_POSINF, true)
> @@ -10055,6 +10089,27 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, f=
alse)
>  TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
>  TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
>=20=20
> +TRANS_FEAT(FCVTNS_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_TIEEVEN, true)
> +TRANS_FEAT(FCVTNU_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_TIEEVEN, false)
> +TRANS_FEAT(FCVTPS_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_POSINF, true)
> +TRANS_FEAT(FCVTPU_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_POSINF, false)
> +TRANS_FEAT(FCVTMS_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_NEGINF, true)
> +TRANS_FEAT(FCVTMU_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_NEGINF, false)
> +TRANS_FEAT(FCVTZS_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_ZERO, true)
> +TRANS_FEAT(FCVTZU_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_ZERO, false)
> +TRANS_FEAT(FCVTAS_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_TIEAWAY, true)
> +TRANS_FEAT(FCVTAU_g_simd, aa64_fprcvt, do_fcvt_simd, a,
> +           FPROUNDING_TIEAWAY, false)
> +
>  /*
>   * FCVT* (vector), scalar version.
>   * Which sounds weird, but really just means output to fp register

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

