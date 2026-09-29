Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37021CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhTQ-0003Af-Ga; Tue, 29 Sep 2026 19:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhTO-0003AI-Ez
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:42:58 -0400
Received: from mail-lr2-x0e.google.com ([2a00:1450:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhTM-0006xG-EU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:42:58 -0400
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a75ff20a6eso17960851fa.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790725375; cv=none;
 d=google.com; s=arc-20260327;
 b=RWtk9tHdleHsoO0E0svNHg06VVTzCOp1nNCp1XDA96fWXCP2QHIeuYtynreuLZaqcF
 s1NF/1kZwuhS7upOyKGfa8AXPO4D5HDKeHsLvpwJ+z+8/J3ccQ3bcx/0SvTyb9eq8Nm7
 YCQ/aGnwNEI4MJKE/xpXlpqHv86O/r7u+fud1w+D4alGWu74woFD+ChcKeeNlu02j4bU
 tTgqjhlrDCiy1szYgp7+YJWUQ9rM//Y4xAZaYWaLbXGEdvN4ayF5/dIgscpLU11KgwYz
 eHOt4mSwDdAd+TVd+GD4xqO8Q3zhst7FoCe/OUlyKKZbbqoPWKKm2y8EsDo+dA+2kFOr
 SdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=36qulkgnU5sHVxvQazCApqqJnmEzIMsxa5APScSv94c=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=cnWdblkuDkQ6kFJgHbD0UYkz4PoV2xeC7nNZPXObfmysNtOg7+JYxY5bJwIPmfXbnO
 3n2ZvPDY8svSGhj4QWpSLozCVsu80u0ymbe8foTQj110LsXq5hi4uGyEvbh5xSjmeYhv
 tcDyTkctdaV9o84arhV6ZtaFBj2+moCaHrLIcjvqVQ2yuspDgcmr0jwBiFE+qpN3sFM9
 A0eGo7+7rpS3Fbf1na1eHEk8VnH/Q/PKi0QSLxHwOjelAfQqwJeb3FOelhUOJnv0Z9QJ
 lbcNdqJHUpCWxCydgkn1OmeA+78d9/Axprd1dQryw045w27a3OB4Ck/8UgaYhUHQYJdC
 qFwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790725375; x=1791330175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=36qulkgnU5sHVxvQazCApqqJnmEzIMsxa5APScSv94c=;
 b=L4Jy3Vn0uiqYXNoyQrAptZ82Je0aev6qSVCt6+NJN6AimPTMdxd4y93LWYJ4L7kngo
 bOSUu3gh0KnFvsjuW4zSzsuaOx/9YSalMh5cZ9eDIPmqO06x/5Mp8VLXTxyiiIsBUCKo
 wO/zfBmpAMVlNJD3acbWri3CgGOPst9U5O5JpWIXpL9HR3i1TqUR0VQDMP2vW3LZ/4I1
 lO/mzXUQpEq7wG6eyT2x3XmS2M0EytUoN6ZNIRYfRrJP6e82whT6UhBR8NRaCOX0X37T
 MsdYThaXp/1oHEw1FnG8RQ68WmWxYVsbUnrBJhsVFQZytI41YuXaiyLOhtFFi95e9Dnv
 B2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790725375; x=1791330175;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=36qulkgnU5sHVxvQazCApqqJnmEzIMsxa5APScSv94c=;
 b=Jx/gB6RYlhZwYWS0uj0d7iS17dXyzkpDm2oQ1SFTjvQ0656TnisO6SctzPq5JjzGib
 H5YKkBF327Ao5Tim5ChDEiDgL73wiQ7kH39tCoULnAsyJ0/MLA9QgrVWfykcAEOz1YwW
 M+PgWWgQyTp04T7B8mf+2AdHF03C7Bnc9WCsvxUI0bzvMyQOHbmIFOPoCKjpH5+wRErN
 oJxcHUtmu/UFgJrsMG3Nh6bLlRifqQff6NUBJLgH5dk6TLPluadewlATmq5oiDiaAiFk
 awc3o0W24arro872wT1FtyXSyznJXYv2nq1NFHrZzwbPbIzCbNHITNubSQPV21runbDf
 pIog==
X-Gm-Message-State: AFq9FYIfHVtTJnqCaNEixuoxBHUCo+b5Gep/9U4OYEU2EJPWLaeF2Hib
 EjpZ6ic4XR2DG1fXC1CUWEXTheAZbQisWeycLIwSbNB0e/+e4JD8S9kXfCb3fekPZ1NTFvzu7c6
 SzKR76hYaJ/z5SP6W3Rx+IsNhZuBifo0=
X-Gm-Gg: AYBFou3lkEHGTZnl1mwz7T0x90yrFAAEOrEcjFhPPYZmBbwz1Pfde24qVmzcVRF0qPk
 0ui9Ao2HZVIF9OM9+/Nu6mPrT5GFi+8Akngw+43aXRPZvWnqmTu0wVVf3c/JQt/Qm/GVqZIPXMV
 9EadrLDvDpf5qOtCSVC426kUleVJ4rdHaZeeYf7EBO+l/S8DykY0Cp66j7HL4wjJWZWGqa3Y1Il
 tPcrRWlmVVzCKZ3bCIsGKD/O6dDZPx+w5RLX5RCgjq8YBaFCq8SH7fYXb6sIwrX2irYg61tTmoC
 rroQ4DAr9bhqg7RsUZO3okJ8OVbFHnI/H6vFSuzdo3EX9FPUpuHq9rMUtsR0oBUSPtmMV2WN/mj
 FJ9DLLc9Tnc2nLg==
X-Received: by 2002:a05:651c:b21:b0:3a5:e027:1b49 with SMTP id
 38308e7fff4ca-3a7716ed054mr2491791fa.2.1790725374451; Tue, 29 Sep 2026
 16:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-84-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-84-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:42:41 -0400
X-Gm-Features: AclHuK-4Z3Rmk5vMRtqCUy_RDx3R3J2548klznGXKALIWUAYyMcqydUq6wdXnGM
Message-ID: <CAEdQ38E0yKH8bzDYmL2X29RXt4gmGLp_1e=ij5Z+FKBcp9FpaQ@mail.gmail.com>
Subject: Re: [PATCH v5 083/101] tcg: Generic expansion of tcg_gen_muls2_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::e;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x0e.google.com
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
> +        g_autoptr(TCGTemp) t =3D tcg_temp_new_ebb(type);
> +
> +        tcg_gen_mul(type, t, src1, src2);
> +        tcg_gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
> +        tcg_gen_mov(type, rl, t);
> +    } else if (type =3D=3D TCG_TYPE_I32) {
> +        g_autoptr(TCGTemp) t0 =3D tcg_temp_new_ebb(type);
> +        g_autoptr(TCGTemp) t1 =3D tcg_temp_new_ebb(type);

... and these need to be TCG_TYPE_I64 I think?

> +
> +        /* Simply extend and use host 64-bit multiply. */
> +        tcg_gen_exts(t0, src1);
> +        tcg_gen_exts(t1, src2);
> +        tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
> +        tcg_gen_extrl(rl, t0);
> +        tcg_gen_extrh(rh, t0);

