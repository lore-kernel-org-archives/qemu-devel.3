Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7760C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4Y1-0004oc-7U; Wed, 12 Aug 2026 04:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4Xz-0004oK-5Y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:42:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4Xw-0006gw-EI
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:42:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so226491f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786524166; x=1787128966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p4qtzuJw/9hUKZ4Xxem5F7h0VSa9+8D6c1pFNmk1dog=;
 b=HhEEPRkoM8OOpPAWMCjnB3zaxJlMp5Dtotnhda+55x7JH+9XfNTAdJEEoUew5XQltT
 qCKpW4a0Mi2EazU1T3HaQ60eYcsUGXEwDs7z1LzH8GcdRWR9CcxkcqfnDAZvSU+t0aHY
 QLqXftE6RCo6ALUfQMMKXiW/FFepFfWAUBz8yWQP/ziCEfIt7/Y7O1w3366gSXtQBJFU
 eFwhDXVYX4sNgWj7xxeympR6mHdm4sK4tMZahgwQLnUaiX5w4sLO9bEibKU8uvDbTBGu
 OzNbMhJgH7Pql1JJaVQRQHjRoaTB3E2KYaddCoEKsNTqZYRf2NaTAXralThVZK1tsB6f
 UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786524166; x=1787128966;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4qtzuJw/9hUKZ4Xxem5F7h0VSa9+8D6c1pFNmk1dog=;
 b=pBPEnFxhxss+uTNNRmfuln0+SCqUKvANNFqhsF/SD5uUG2Br+qfJsvdQ4gR8RBgHa1
 TrVc7PThDGoIAa/v9LMDaExlr/JyFn+dNsFKSMcMhuElIiXCiuFsMyCle4GdCdSFeUm5
 Ffoe4MLOTvUZeWZ3GOiqNo1C2i/rYxVXFlBHZ5kEzQz4I4dDN1bBvk2f/PZRLNbMELp+
 h+QbD1Kd5kJc+QmYMfPwTFNloAMAwjtlNKKYcZTpmJXqVGgOXKTHeXGdru4XRrv2y6tM
 rI1c1pzMm5BM3NrxFVq4xFLgkeDOd2SzgZIv7iNtEBKdDni1SaIeZKX4RSQieDA//reV
 hoTA==
X-Gm-Message-State: AOJu0YzxhceXNPPKOPTx/9W2rn62ZbSvL7YgIZ6MwaVh0quBY0EJoWw/
 C9NKGCXPPqYv3tCBw9jV+STjwsZYkINrq3B8KFRgJWfnFuC5w/pbZLbiArdsoQNcnRhjgunJk2L
 q6mg8
X-Gm-Gg: AR+sD10HrY3U/zvrOy9j7otodc7Vb6Lxs8TMxlTRPP75eyNCKOuIFc35VuNWb4JaL5U
 VCO3BEZwxpiCbn8OoH52VM5N06l+zNIayjxuckRk/ucwqmO9PK2xCk0VIOZnkyb68v4jd8T5fFj
 DwCyZMnG3JKbX/rcEPU8VnGSVLeL7W3SbWiSElt5CfGXMASmF9i9ban6COwVrApXQBvl1lPHAat
 QlABIuWgOKinsM0+gDa0/WbcbaXiS/O1lDClz/CBIKL4QKmwel8C771UCySvg7zAnjWmydHOQwt
 fIjG3mnhuPiYwoXG7XJtAvxmGL7N9drpozl+haGzayLVRJ1uA836XBk7tqwIL+uYURo33CGotHu
 B6QnyydJw358x/8hgy9kPzKs9TS/k4lWUk3HIweDz4D7M8DTw8Bp3j/zbauYzQgmrlTWjQ8X7TX
 zWI/pcg9lBrUdSGAVZxWn17ymNfFfgYiM5aF0HIMEB+CFvMkFMw1q6Y2LfBUXS
X-Received: by 2002:adf:e19e:0:b0:47f:8183:e9b8 with SMTP id
 ffacd0b85a97d-48152c76c67mr4331903f8f.22.1786524166092; 
 Wed, 12 Aug 2026 01:42:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f27sm5329734f8f.1.2026.08.12.01.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:42:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6138A5F886;
 Wed, 12 Aug 2026 09:42:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/7] tcg: Add integer min/max opcodes
In-Reply-To: <20260812003143.225228-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 11 Aug 2026 17:31:37 -0700")
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 09:42:44 +0100
Message-ID: <87tsoz20hn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> We already have these for vectors; replicate for integers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-opc.h            |  4 +++
>  tcg/tcg-op.c                     | 48 ++++++++++++++++++++++++++------
>  tcg/tcg.c                        |  4 +++
>  docs/devel/tcg-ops.rst           | 14 +++++++++-
>  tcg/aarch64/tcg-target.c.inc     | 16 +++++++++++
>  tcg/loongarch64/tcg-target.c.inc | 16 +++++++++++
>  tcg/ppc64/tcg-target.c.inc       | 16 +++++++++++
>  tcg/riscv64/tcg-target.c.inc     | 16 +++++++++++
>  tcg/s390x/tcg-target.c.inc       | 16 +++++++++++
>  tcg/sparc64/tcg-target.c.inc     | 16 +++++++++++
>  tcg/tci/tcg-target.c.inc         | 16 +++++++++++
>  tcg/x86_64/tcg-target.c.inc      | 16 +++++++++++
>  12 files changed, 189 insertions(+), 9 deletions(-)
>
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 13c7f17f76..f3a81d5d7f 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -89,11 +89,15 @@ DEF(setcond, 1, 2, 1, TCG_OPF_INT)
>  DEF(sextract, 1, 1, 2, TCG_OPF_INT)
>  DEF(shl, 1, 2, 0, TCG_OPF_INT)
>  DEF(shr, 1, 2, 0, TCG_OPF_INT)
> +DEF(smax, 1, 2, 0, TCG_OPF_INT)
> +DEF(smin, 1, 2, 0, TCG_OPF_INT)
>  DEF(st8, 0, 2, 1, TCG_OPF_INT)
>  DEF(st16, 0, 2, 1, TCG_OPF_INT)
>  DEF(st32, 0, 2, 1, TCG_OPF_INT)
>  DEF(st, 0, 2, 1, TCG_OPF_INT)
>  DEF(sub, 1, 2, 0, TCG_OPF_INT)
> +DEF(umax, 1, 2, 0, TCG_OPF_INT)
> +DEF(umin, 1, 2, 0, TCG_OPF_INT)
>  DEF(xor, 1, 2, 0, TCG_OPF_INT)
>=20=20
>  DEF(addco, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index c302a484cd..e28944cf72 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1294,22 +1294,38 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 =
arg)
>=20=20
>  void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>  {
> -    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
> +    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
> +    }
>  }
>=20=20
>  void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>  {
> -    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
> +    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
> +    }
>  }
>=20=20
>  void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>  {
> -    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
> +    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
> +    }
>  }
>=20=20
>  void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>  {
> -    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
> +    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
> +        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
> +    }
>  }
>=20=20
>  void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
> @@ -2473,22 +2489,38 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh,=
 TCGv_i64 arg1, TCGv_i64 arg2)
>=20=20
>  void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>  {
> -    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
> +    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
> +    }
>  }
>=20=20
>  void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>  {
> -    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
> +    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
> +    }
>  }
>=20=20
>  void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>  {
> -    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
> +    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
> +    }
>  }
>=20=20
>  void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>  {
> -    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
> +    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
> +        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
> +    } else {
> +        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
> +    }
>  }
>=20=20
>  void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 4c2207c6af..54f7906cb7 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -5512,6 +5512,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const =
TCGOp *op)
>      case INDEX_op_sar:
>      case INDEX_op_shl:
>      case INDEX_op_shr:
> +    case INDEX_op_smax:
> +    case INDEX_op_smin:
> +    case INDEX_op_umax:
> +    case INDEX_op_umin:
>      case INDEX_op_xor:
>          {
>              const TCGOutOpBinary *out =3D
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index f2e9255dd9..d30db9ea65 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -317,6 +317,18 @@ Arithmetic
>           pass 0 to *nh* to make a simple zero-extension of *nl*,
>           so overflow should never occur.
>=20=20
> +   * - smax *t0*, *t1*, *t2*
> +
> +       umax *t0*, *t1*, *t2*
> +
> +     - | *t0* =3D MAX(*t1*, *t2*), for signed and unsigned integers.
> +
> +   * - smin *t0*, *t1*, *t2*
> +
> +       umin *t0*, *t1*, *t2*
> +
> +     - | *t0* =3D MIN(*t1*, *t2*), for signed and unsigned integers.
> +
>  Logical
>  -------
>=20=20
> @@ -512,7 +524,7 @@ Misc
>=20=20
>       - | Reverse the 64 bits of input *t1* with output in *dest*.
>=20=20
> -Conditional moves
> +Conditional motes
>  -----------------

A typo snuck in....


Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

