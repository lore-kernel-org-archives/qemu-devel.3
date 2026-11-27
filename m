Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF05606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EEEFgJnS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWz8Y-0000Va-1C; Fri, 27 Nov 2026 11:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWz8W-0000JM-C3
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:49:24 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWz8U-0001D3-Ko
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:49:24 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-675617e81f9so9479167d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795798161; cv=none;
 d=google.com; s=arc-20260327;
 b=YAulI2jiHCtdfGnEiiL5MKNExcxgc99UBpvKZYUFA+Yl2mZpnVCAvSTC01hd2uU/0a
 qfIXPXzKaiU81XZwB+X1O1ynpe8aneGrUJh3CX8Yl414DOLoM7szH0aY2mvzEFmQzW/k
 4kO7V9P/7GG3fqslK/w85ru+moYh9kWcLORr+yye3UP2tBRUPuZnech9bQLWZljTGuMy
 PD+oSKDP53ijcEtsB11XA/CZrYQrcndjI4QCD9q9NUtZo3UEbYbK68gLnMw85NZRv13p
 CpKGIJkGhrf3R5cGw+uJ8Qdi9uYeKdGH2mVIv3/7MYmJf/lfqKL2xYoumaxuBZST26nn
 Dq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FDY8dYvzKRlAqhFuGcT05450UmM4sVl57r4E2PVFADc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=lyVbVKQnMu+dQrMtPqqM0nM2OX469k/QLCrCX4DZ9QYMrh6hEbCYwswP3buDxu1G1f
 phT7xc76wVoleybB8N5/BYjUnM7KUAYy3Iq00SHvv+v0OPb/gGI7X53w5hokcevgAkY7
 Lr+5IZSNbyLujVDPOgqtntyOrJ+qdjWFfDReZGFtWaXSLUNjQo/tv4C+uOX/ZEZqvfrw
 VJW2WB8ef7LKFN52QQv60dIe1xsEn8pEaM3aqng9eNLS0zU+2KdcdyOLOzOI2GFxlllj
 BrsEhNufog4Tx4pRecm79YyfQWYYuZoKNhIopTGCtuzvLYBdpoJZU4evkvFbqcPZEhIx
 sYlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795798161; x=1796402961; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FDY8dYvzKRlAqhFuGcT05450UmM4sVl57r4E2PVFADc=;
 b=EEEFgJnStbhNdLo+vFXwrZxgyn7e2bUqEtLzI4FP0trRXO0Oah+zoK9bHiMk6iy2MO
 yWqrxQz6jgNQzYjc3uCKdlqIii8b18xOc3chyYDTMv+zo+PiMj2LwvAGtgcn0B9ZvJJ0
 agzoPhV9TgHhJ+VjmktTs3v/uhUEnD4aK49go+U6XAA5rdBpjDCmlYolltuqPHJ+RZfV
 DHoRbiQ2w29da9FdnrjbhoBjTV8VPAZIqdc2zUiuhr5vdScrNCR/kI6PUVsSrD7C13gG
 TixVW7NAxMSg8dqbk2kKqurSfWBJKvyka9ybrLxnb/pWx9CcD1RELkVKdkxSRxghczb2
 NNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798161; x=1796402961;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FDY8dYvzKRlAqhFuGcT05450UmM4sVl57r4E2PVFADc=;
 b=fzUAx/giPRUicGrmlKz/H2WYme2loS4ziyt7UItn1weEwczu5iHIISmGvCj+DynJ3m
 m34XQTZmgvV8I+zd689o1hklxZbKlmEE7rzRsNUruRJ+OxuI5UmqwrFYi9MdlMqDRZvM
 OW0buPhRTd1NB2/mIkA/NQjuTATkPnom15Jaso97CeJLN+uoDNX0W8CZtUGPtv1Omfd6
 XVyGv2bl91l84kFrVlR1uPsUcjioC5wjPTLy0sxhpD5oD7LOAOL2wZSfiHE0ZPodh61u
 FGXDVSOll7eaCdyulAqIpfmma3kAaq9glBmEL29wkOBiB5OoYhvwtEfC6pJc+RE4yeZU
 ZHRQ==
X-Gm-Message-State: APuU4Z9X1qIgXT+T8DXCoicwbTjh5HcS9WlhDrgDrd6bJq3rDi0tFejD
 yueeFtTGKnC4+z0UY6RWJPgSLZk7dNAkWxrxUxoZiL2nbu//xrzURqBdza9J+b6Hy21YOR5T/UM
 ZSyXFiUxUkgbut3py3OO1P7kxSz+q7f7zHyeqp29YYA==
X-Gm-Gg: AZFdTZdiyKQc0j02rPd9zrsZtd9DJkXX7hfTcPPEN6HbhFMTlApy2nWfTr5AHepn9cY
 pAFCAe02PxQL2otIPA2zfxsk+Tr+ZBs5odEqTydj9kCP/uWTueZvtGp6gjPRKLmTutkOnnyLHFp
 Y2Ej6FlbmJF+5dg0FvzhZQVClVkD7aSluuqUHu4Mz+6xfu6am0Kx+Odxl5MwP9uxrflMxXSo7VQ
 B5xdHyetI5qVzgXHI1814EUJ8kWfJxxKYOYknfo54xV/7ywNmttYPkdnKFFsyLfIZnB8o3b2Qik
 cFTYM8atz/hYqZkMSmpNVX9Bo3MGQXMayjrBXP6lSmIpqe0oiJth2NxlHf5NoMUTDPRkXF8S8qq
 /r0e0wP3ocaufszD3hOPj/b6hdoJYM1JJuO5jOKgP4JP5A8K7sklitVR3VPcOpLRZ3yUO7VIR8H
 iETBN+Zatc0o7a8rGEQG5mVMBtrMj1yP+qbh6ZbIRisg==
X-Received: by 2002:a05:690e:108a:10b0:67b:f72f:c385 with SMTP id
 956f58d0204a3-67df449e300mr7170894d50.107.1795798161168; Fri, 27 Nov 2026
 08:49:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-7-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:49:09 +0000
X-Gm-Features: Aa3M54p201G2OvzSSbJBNpp85gF3Hocpk-dNxXWUL00uaRdgLeBVsI4D5W2_vK8
Message-ID: <CAFEAcA-HyC+WVRztJCizegbnn8x4pBJaN=kJvk8WtAB4HL3qfQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] target/arm: Split out gen_cbranch_goto_tb
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> A common helper for all conditional branches, using DisasCompare64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 142 ++++++++++++++++++---------------
>  1 file changed, 79 insertions(+), 63 deletions(-)

Converting all the potential callsites at once makes this a bit
tiring to review. Could we split out at least the complicated ones
(B_cond and CB_cond) into their own commits?

>  static bool trans_TBZ(DisasContext *s, arg_tbz *a)
>  {
> -    DisasLabel match;
> -    TCGv_i64 tcg_cmp;
> -
> -    tcg_cmp = tcg_temp_new_i64();
> -    tcg_gen_andi_i64(tcg_cmp, cpu_reg(s, a->rt), 1ULL << a->bitpos);
> +    DisasCompare64 c = {
> +        .cond = a->nz ? TCG_COND_TSTNE : TCG_COND_TSTEQ,
> +        .v1 = cpu_reg(s, a->rt),
> +        .v2 = tcg_constant_i64(1ULL << a->bitpos),
> +    };
>
>      reset_btype(s);
> -
> -    match = gen_disas_label(s);
> -    tcg_gen_brcondi_i64(a->nz ? TCG_COND_NE : TCG_COND_EQ,
> -                        tcg_cmp, 0, match.label);

Could we avoid converting the NE/EQ conditional branch
into a TSTNE/TSTEQ branch in the same commit we're doing this
refactoring ?

> -    gen_goto_tb(s, 0, 4);
> -    set_disas_label(s, match);
> -    gen_goto_tb(s, 1, a->imm);
> -    return true;
> +    return gen_cbranch(s, &c, a->imm);
>  }
>
>  static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
> @@ -1801,11 +1833,10 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
>      reset_btype(s);
>      if (a->cond < 0x0e) {
>          /* genuinely conditional branches */
> -        DisasLabel match = gen_disas_label(s);
> -        arm_gen_test_cc(a->cond, match.label);
> -        gen_goto_tb(s, 0, 4);
> -        set_disas_label(s, match);
> -        gen_goto_tb(s, 1, a->imm);
> +        DisasCompare64 c;
> +
> +        a64_test_cc(&c, a->cond);
> +        return gen_cbranch(s, &c, a->imm);
>      } else {
>          /* 0xe and 0xf are both "always" conditions */
>          gen_goto_tb(s, 0, a->imm);
> @@ -1825,35 +1856,27 @@ static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
>          [6] = TCG_COND_EQ,
>          [7] = TCG_COND_NE,
>      };
> -    TCGCond cond = cb_cond[a->cc];
> -    TCGv_i64 t, m;
> -    DisasLabel match;
> +    DisasCompare64 c = { .cond = cb_cond[a->cc] };
>
> -    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
> +    if (!dc_isar_feature(aa64_cmpbr, s) || c.cond == TCG_COND_NEVER) {
>          return false;
>      }
>
> -    t = cpu_reg(s, a->rt);
> -    m = cpu_reg(s, a->rm);
> +    c.v1 = cpu_reg(s, a->rt);
> +    c.v1 = cpu_reg(s, a->rm);

Presumably one of these should be c.v2 ...

>      if (a->esz != MO_64) {
> -        MemOp mop = a->esz | (is_signed_cond(cond) ? MO_SIGN : 0);
> +        MemOp mop = a->esz | (is_signed_cond(c.cond) ? MO_SIGN : 0);
>          TCGv_i64 tt = tcg_temp_new_i64();
>          TCGv_i64 tm = tcg_temp_new_i64();
>
> -        tcg_gen_ext_i64(tt, t, mop);
> -        tcg_gen_ext_i64(tm, m, mop);
> -        t = tt;
> -        m = tm;
> +        tcg_gen_ext_i64(tt, c.v1, mop);
> +        tcg_gen_ext_i64(tm, c.v1, mop);

...and also here...

> +        c.v1 = tt;
> +        c.v1 = tm;

...and here.

>      }
>
>      reset_btype(s);
> -    match = gen_disas_label(s);
> -
> -    tcg_gen_brcond_i64(cond, t, m, match.label);
> -    gen_goto_tb(s, 0, 4);
> -    set_disas_label(s, match);
> -    gen_goto_tb(s, 1, a->imm);
> -    return true;
> +    return gen_cbranch(s, &c, a->imm);
>  }
>

-- PMM

