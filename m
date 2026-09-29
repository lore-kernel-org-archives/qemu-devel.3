Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC60CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhFt-0000no-Tn; Tue, 29 Sep 2026 19:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhFr-0000nS-Ml
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:28:59 -0400
Received: from mail-lr2-x10.google.com ([2a00:1450:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhFp-0005e1-QS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:28:59 -0400
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a3156692c6so38387891fa.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790724536; cv=none;
 d=google.com; s=arc-20260327;
 b=ePBBFCTR8NKlHgH2HJdDq+Psov/LS70BdIGUK6SkvieCXEEWs/svmILPdtYA/X0g4s
 1H+QkiPNfP6t1CtETNHOMJb2LaYTE6jifVrpCOQquhXB8AZdFlEl3zWnKFr6GV1G/c+s
 WTJNGYfmzixCv/CcfqDSZx2Pa4P1ZxK40+pJkf3XPZeJl8bjsfY1H9VPkIJnafu4WVLp
 s55ghMV1xGgHw9nDmNxrel1CI+3nAY79rJDlIpFAebNU6KnrU8g9V0c3uEw8byc/Pn+O
 eP67llSmIRnEXYmD0mGLU0DlEv28fV0YEziN4I05VaWPD2alouPjoP6bJFVBHvrkFekD
 QeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lwgKgJTOftillpLvgna/GBtQWCryJ+skqv1iqRRbk9w=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=d6koAgS0ThI7sUvLetsmDVJWgB+SqyzftGXlq9Du0FC7I4XkN4Xh+DqldrcsPiUOWU
 LH9NVsIrsoCrymlhFqAGVb7Q+YDtfpH4s0i1xKEwb6ItKdvN3eNehsedpNh6qs+uD4RN
 SgjiE98PnsIqEJmUDU8TrdDMZtqhGaMekjKkD8pnEtVv31bvtxuOtMbTVc0khOLp8unS
 CijXzmAL7iTXZzM55Xihz30FtzcVv4g6dHvrmGah5tfUJuABIx+eTn4glso+DfDwbqx9
 LDIAhlVQZ9lv3CSkRuvQzPYoA9PckdUS8y3uoS+JCCNucMo3HC8HvHpP7o6u5dKrqd3F
 AYZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790724536; x=1791329336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lwgKgJTOftillpLvgna/GBtQWCryJ+skqv1iqRRbk9w=;
 b=l/D+nrIfPkuUOHYV4dpxeBqAqbXN9KiXyP1uOmtnd/fsuaSPuNumRS7bRystZr9+CQ
 8kaZam/S+0V/aSYZrGLCbDuRgOehPa+HhEHFkdJGx/UFnV74msVrJlWrPpx8FqTdwlzr
 j2Ir7HtKk/hoKmuy0YPypJdG5Nl7m+u/hOL5GylA7R94BdsNDI8uAPMEUjC1qOhsPi/z
 XGRVZPWMgzGldzaUZIycIe6BY6KmzjOaHmPwsevV+3WZIk2iR0N/DQvw1npcjtSDGiAq
 HzAtwMSvdCwngAhS9yICsSMM88lX6XTOhvMXpKo1syhVpBmVakUSNxPuvWYj87cU6sAb
 p4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790724536; x=1791329336;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwgKgJTOftillpLvgna/GBtQWCryJ+skqv1iqRRbk9w=;
 b=OdVB/3IJd5lbiHOywhLLG8iwCaxvZHgIsNxbKAtIUk1AsxrG5E2CBW0daMS7R148KO
 hdWpxh9pChK27eGVmKwYJzA2L6NzuaXkz/0eiIU/OqeHeE1o65cLMjSOJJoO7cnbWE+H
 Zxm1o1bSknalybmv9o/N5VrY7P5OGsdChQKrBsnYia3h/a1kq8oGmIe5bOUeWiCUEcgD
 HFPnai5sdnU0TZ6TOdPRMycn8tCnovwQeAMjosbQhUQUROtX5qhhFJknlH3ru6fiUww7
 TSpAp0+mRgxKQy5o/SAL2Bir/zPWB4Db/9V4syFdLJdEaMCVzCoUnsXrKbLuETY2uND2
 /nFw==
X-Gm-Message-State: AFq9FYJa8PrHzFa1Td1Fe1L5uaYZH38rt4ywiIQAdxuzt1lrhU8nvMwP
 hQa1nIc10froo8k1hIiTJWzfAaW/sfhzI8UX0cFPde7Sm2NDOYnNIczN2/EjQvczXDDuLyqvV8/
 99QYEDAtYA7DqgMxT4kuHTV/R/+HDi0w=
X-Gm-Gg: AYBFou3zu0Qe3iKSstNrutY5UKy4HrmQWqzZClF3AxKyDewwJPMxBRVqFDbsaW3PDOC
 eDb6WEhcpR8WTdFXps3GnSXMGKNd0XR7u2lNMI4sV2gBWVRbkeYndkuBk3Poi/dvGbb/CvvhYW8
 k+ItW7GwtxqrB44rItdi/XHldcin8y4VLdqPdEfNbTFN/okyhgONsTeIdWw7D7tyC4YOgwtD4TY
 O2Nqf92rBajpL//bLhX2In+pPnYf0FIr8+B5ErQtoZgxjYnWokUVZksk4Thh5Xg4guv/misR728
 gQf9LRxDcpbJgdlJDUtbLpSwFiNsVYhGvGeKIKenirn6UH6lmWuCrHsnuKwGk025I2nO8ddhdiO
 KsIUfzQMlWLoHcA==
X-Received: by 2002:a05:651c:f0f:b0:3a6:2bc5:5955 with SMTP id
 38308e7fff4ca-3a77190afb5mr2537401fa.22.1790724535250; Tue, 29 Sep 2026
 16:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-97-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-97-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:28:39 -0400
X-Gm-Features: AclHuK-VeA-AQWCO2l6FfExYflqv39w0UG_BLN0ozG-GN_cu8bvjpNXQdbtjydQ
Message-ID: <CAEdQ38G0vF8J-LNXk=hiEwMn=pWZcNrgSQUK9zLf9s9LS1vzVw@mail.gmail.com>
Subject: Re: [PATCH v5 096/101] tcg: Generic expansion of tcg_gen_dup_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::10;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x10.google.com
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

On Sun, Sep 27, 2026 at 5:08=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  6 ------
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op-gvec.c            | 41 ------------------------------------
>  tcg/tcg-op.c                 | 16 ++++++++++++++
>  4 files changed, 17 insertions(+), 47 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 65b9d828e38..583f6ebb2f5 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -137,9 +137,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
>
> -/* Replicate a value of size @vece from @in to all the lanes in @out */
> -void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
> -
>  /* 64 bit ops */
>
>  void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
> @@ -153,9 +150,6 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
>  void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
>
> -/* Replicate a value of size @vece from @in to all the lanes in @out */
> -void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
> -
>  void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offs=
et);
>
>  void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offs=
et);
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index f9dab50a911..556f7470cd6 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -23,6 +23,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
>  DEF1(discard, TCGV)
>  DEF3(div, TCGV, TCGV, TCGV)
>  DEF3(divu, TCGV, TCGV, TCGV)
> +DEF3(dup, unsigned, TCGV, TCGV)
>  DEF3(ext, TCGV, TCGV, MemOp)
>  DEF2(ext8s, TCGV, TCGV)
>  DEF2(ext8u, TCGV, TCGV)
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 0d649cc13b2..72abb0a08ec 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -434,47 +434,6 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
>      }
>  }
>
> -/* Duplicate IN into OUT as per VECE.  */
> -void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
> -{
> -    switch (vece) {
> -    case MO_8:
> -        tcg_gen_ext8u_i32(out, in);
> -        tcg_gen_muli_i32(out, out, 0x01010101);
> -        break;
> -    case MO_16:
> -        tcg_gen_deposit_i32(out, in, in, 16, 16);
> -        break;
> -    case MO_32:
> -        tcg_gen_mov_i32(out, in);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
> -void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
> -{
> -    switch (vece) {
> -    case MO_8:
> -        tcg_gen_ext8u_i64(out, in);
> -        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
> -        break;
> -    case MO_16:
> -        tcg_gen_ext16u_i64(out, in);
> -        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
> -        break;
> -    case MO_32:
> -        tcg_gen_deposit_i64(out, in, in, 32, 32);
> -        break;
> -    case MO_64:
> -        tcg_gen_mov_i64(out, in);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
>  /* Select a supported vector type for implementing an operation on SIZE
>   * bytes.  If OP is 0, assume that the real operation to be performed is
>   * required by all backends.  Otherwise, make sure than OP can be perfor=
med
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 2e8087c938c..924b94414b7 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -661,6 +661,22 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTem=
p *src1, TCGTemp *src2)
>      }
>  }
>
> +void tcg_gen_dup(TCGType type, unsigned vece, TCGTemp *dst, TCGTemp *src=
)
> +{
> +    unsigned t_width =3D tcg_type_size(type) * 8;
> +    unsigned e_width =3D memop_size(vece) * 8;
> +
> +    tcg_debug_assert(e_width <=3D t_width);
> +    if (t_width =3D=3D e_width) {
> +        tcg_gen_mov(type, dst, src);
> +    } else if (t_width =3D=3D e_width * 2) {
> +        tcg_gen_deposit(type, dst, src, src, e_width, e_width);
> +    } else {
> +        tcg_gen_extract(type, dst, src, 0, e_width);
> +        tcg_gen_muli(type, dst, dst, ~0ull / MAKE_64BIT_MASK(0, e_width)=
);

For I32 with MO_8 this multiplies by an I32 constant
0x0101010101010101 rather than 0x01010101.

