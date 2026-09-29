Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A54DCA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhR8-0002nA-LA; Tue, 29 Sep 2026 19:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhR3-0002mu-BO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:40:34 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhR1-0006fj-JZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:40:33 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5ba379d8804so714041e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790725229; cv=none;
 d=google.com; s=arc-20260327;
 b=WLB+O7e6Fu0aalEdKiW9JednJiS2b624JkGRSCigROytujwjPmNn29ymlCPGWdNUKe
 KIE+YKGpRJ8Qmq4aqVTP7OFKkeqWZHhbQqlWLTZ3dDo15BeUvgTI6L3KKbQ12ug71xpw
 pOVGDlg7HY7szw4VSlSFb9Pf8gR01Gx1kkyZU3yJ9Xhxkl+b2E89Pwvc7rLt7WuClEMt
 soxDnrO2dNlJ+Co5Yc8vKleti8DyFpKrscZK8asimo0+eHqE1oTjAx70/m/oz7oxAcZ7
 YImVEs0+0WeAwzRA9q44Tx8S0omnxTxOdORrD2IKLW7FGC4CR9lwio32Zg4/AtkSHBjE
 Kdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LJWCYeIQpblIhuC1Ep/IVWBNu+bssMD7qoDoNBRu/j8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=YYpn0i2BtSN2QkdP857cRe1QF8oykBLkAn98VYvJc7g1SID263xhv/ouVgIE4PqYxP
 mOnz73xIBweg61PjfB8MN8k/ULiMc8fynSRzeC1pNuf+LpNRm0G4SWLjldTVDjH02grs
 Mksf0kmeqX7MxeF2W9jMbxauO5tqFxdaRVTixm/v8zCI00qWjCAG33edjjd7XInmuV+d
 zTstfTcwO23HEuv4r2BDCXt7vAAUCShAyFPQ42CwYAGtyEZUS7ZSvsK16oXkBE4bWhVc
 33zIMleXHgQhx9O3vKuEXTMqi4onzZ0MgQKDtKpocLigNQ9T2w3HCZG80NUu5CsOCqwM
 HTTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790725229; x=1791330029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LJWCYeIQpblIhuC1Ep/IVWBNu+bssMD7qoDoNBRu/j8=;
 b=UUIUpj+EphTI8N6szzfkTiQQVh26+WGvumoiJCVkGHU+gyakfqNWvWNrP47C3x77nV
 figO273h6nZFOPwFAiJlWt9yIgFXNgghuRdoz6B7/zOn/c3VjO0V9lIwWgEGNk292S4s
 ZqhQYACqo4lnM1ya8dXz0hVyIHlIiOe7DhLhzsisUo0w7yoFaEXvy8kfw3usNj0cD+9q
 aK4HUnVAFOx3s5vg0RE9Enay/5vvT4a8D/W2kObnv6wK4e1NDB4da4ugKZ+Y2BZgmmu0
 C/jpNVRZelKTfsdYIx6iKxhSSzaSqPHl3n0EiB/7fu+7C+qHUE5C7xmxtSrRav6FvpS9
 IrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790725229; x=1791330029;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LJWCYeIQpblIhuC1Ep/IVWBNu+bssMD7qoDoNBRu/j8=;
 b=fFx3PMGDSvzJmVhXwL18qfxJq+XSb9eWcI3bjiTmJ+DdZd96eCI7vZR/8+9aOLkM4H
 +DaXxOQnHTmX1tDtWV9TQdNHqTMy6/2Tp/KFpDwuzs40l1XF03P0oxu/KvYl3rd89RvP
 xiLje5OqJeF1SYNrc/H6QGpwVUpJ2QVTt7Cy8e6iIhsuHb6E84X1bX8otq3JimakQ7vh
 oyfUn5+iuar1nabydgB/gMC7xCUKykcbQpq/zg0NZ1FiulwbBQ4YF47LFX9TreEqcI7j
 JWShNzJFn0Rym73/T/EiPZQQcqpD0xyweoNIQBdhr4r16PirbR8kCUafAWT1AHh5/Me4
 PvLQ==
X-Gm-Message-State: AFq9FYIPHmJ8lB/CCq/BvyLgzr9PulYW5noCk8eIBifjjWzF6trvRyDE
 4wnHnjG26z5pMun5jq7bx/lcXcVsQ/E7WjQ3d3rCYP2NdTAbLB8EtHYm2tUus5Bvgdc2DVxHj1J
 gUYmFSmwxexM/IZJ6T7OaJ20cpDH63QhPFA==
X-Gm-Gg: AYBFou3H7JMJ8/H1MJj7kVGWPhX4CBZqIap98NVUb8qTQspjql1/Cn/Fdlyw4mP3eZD
 ufgk9iGyrNP3QSdKieQUcTX5Kkv+f5v0NwCvVLGUbzJcl5ky8VjhOjdD8PRfpo8gOCOXclTra1d
 oGoApFUeeWF60PaHnrnzcL6OhbLYVL38N5gSHWkuIaI0/BG3L/iFTl8Fw3Bbex4txDy9YpaWC4X
 /PYWeuJIJSoRdkHSJTC5WoVMH5Vmat3AGbmb8Jj2NeA8tybiDMMENPD6x7UAkQ+fg6yqINr2gao
 0l7jwj92DrNuDJLafvjvPbyCwlrBpVXxzX5JnYWRiCbxf57O/h4jXuewfeU6ivRVmLZFyULTEgT
 8HHb1BDpVGFb7rQ==
X-Received: by 2002:a05:6512:108c:b0:5b8:b3e0:5567 with SMTP id
 2adb3069b0e04-5ba3bee7680mr348650e87.15.1790725229270; Tue, 29 Sep 2026
 16:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-84-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-84-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:40:15 -0400
X-Gm-Features: AclHuK-K1h3IORqUbEWCYqDJuMuacp552jyKEQzMu14v_WjBH8_UKiamgjIlezY
Message-ID: <CAEdQ38E7pjwWKvjRo6Rfb8kQ5u=4JO5XerrjFcnOsNKKhOc4Dw@mail.gmail.com>
Subject: Re: [PATCH v5 083/101] tcg: Generic expansion of tcg_gen_muls2_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Sep 27, 2026 at 5:07=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |   2 -
>  include/tcg/tcg-op-def.h.inc |   1 +
>  tcg/tcg-op.c                 | 131 +++++++++++++----------------------
>  3 files changed, 51 insertions(+), 83 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 41a4d52d497..5f73601ddf7 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>
>  /* 32 bit ops */
>
> -void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32=
 arg2);
>  void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i3=
2 arg2);
>  void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
>  void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
> @@ -156,7 +155,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg=
_target_long offset);
>  /* 64 bit ops */
>
>  void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
> -void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64=
 arg2);
>  void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i6=
4 arg2);
>  void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index b24122173a2..b606aaab128 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -35,6 +35,7 @@ DEF2(movi, TCGV, TINT)
>  DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
>  DEF3(mul, TCGV, TCGV, TCGV)
>  DEF3(muli, TCGV, TCGV, TINT)
> +DEF4(muls2, TCGV, TCGV, TCGV, TCGV)
>  DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
>  DEF3(nand, TCGV, TCGV, TCGV)
>  DEF2(neg, TCGV, TCGV)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f107e3a85ea..61d50294a68 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -129,13 +129,6 @@ static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_=
i64 a1, TCGv_i64 a2)
>      tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
>  }
>
> -static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
> -                                TCGv_i32 a2, TCGv_i32 a3)
> -{
> -    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
> -                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
> -}
> -
>  static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
>                                  TCGv_i64 a2, TCGv_i64 a3)
>  {
> @@ -169,20 +162,6 @@ static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, T=
CGv_i64 val,
>                  tcgv_ptr_arg(base), offset);
>  }
>
> -static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> -                                TCGv_i32 a3, TCGv_i32 a4)
> -{
> -    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
> -                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
> -}
> -
> -static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
> -                                TCGv_i64 a3, TCGv_i64 a4)
> -{
> -    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
> -                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
> -}
> -
>  /* Generic ops.  */
>
>  void gen_set_label(TCGLabel *l)
> @@ -778,6 +757,56 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTem=
p *src1, int64_t src2)
>      }
>  }
>
> +void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
> +                   TCGTemp *src1, TCGTemp *src2)
> +{
> +    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
> +        tcg_gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
> +    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {

s/TCG_TYPE_I32/type/ since that's how mulsh is emitted a couple lines below=
.

> +        g_autoptr(TCGTemp) t =3D tcg_temp_new_ebb(type);
> +
> +        tcg_gen_mul(type, t, src1, src2);
> +        tcg_gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
> +        tcg_gen_mov(type, rl, t);

