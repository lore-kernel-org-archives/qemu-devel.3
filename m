Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE36C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4e5-0007cI-W4; Tue, 24 Jun 2025 10:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4dy-0007bY-V6
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:29:03 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4dw-0005BW-SG
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:29:02 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e5d953c0bso6306347b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750775336; x=1751380136; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MR1UTuktWKXd3AazgFHH4DPO8NwD0hwBqdt1Z10v6fg=;
 b=eVry0sUUChghza2iW+UEsZl9XVF64TFixUTyeRx0cp4PP4wWwn4/PElxyLwxL0koFD
 mKBQYTmWkqciGBF9IRzXiTYWrBoW3haUujA0XedYvCrPxlRPMKPKTC1gV7EKUASX2gRG
 CX17OCvJ4r+7ktbaXd/xPL8tVGAGxLVudpJJ6Ew0AepfTMlvGTGCfGd1BjK0jXkBoah0
 P1kCAtuJh8NlHuyH0jb1PJbOWPjooNsfPy+2oQwkV6yuPY3+Igp2QS8S5Cs9UR3iMaEr
 Z5xLZ48Xmb7He2gY0ZvQdK5gmxSjZhqExbOhMKTX32O+D0/fz/RQ4mspLeoRK59wO1d+
 3dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775336; x=1751380136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MR1UTuktWKXd3AazgFHH4DPO8NwD0hwBqdt1Z10v6fg=;
 b=KU62hQVlBa6Y6PZ1hAloH94oRaORwqaK7n2vqWdtZwH27jrQis5xOIm6/0hqN8B3mo
 wOAdyFFSTqhCbGTaw5c5uPGpd9USJeG66vrWE0OebfYYBKxwZgZjzrjvIxbBeOu2AzsO
 12G4MJTGomCloO7L7QMzspRfAMVI086tbnfOxYmHmCj4QJwHqG+MEDBfpEhQlPK6+Vqf
 fQPZCMVuYC+/b7dCT5fv5cYFxE4vKa/IGNuuA/y3cnFmPEfnP46zaYzSZVOcESpCgScK
 jmErcZjBJuMnPgs96M9vZ7dPH5XLLsL1Q24pbG3hvFwvCBz/Bm77U1Qf19NVQM+2cFZy
 /61A==
X-Gm-Message-State: AOJu0YzIQK9UwnSl530UKnCjwIOhetD+MYw2gq7uY7GPSdocpGOU9MMV
 4rgLzRyDeS8JO3Iok8ilNKu+Y15MtmzMMbU0FD0zkA5l5CrTOLNNuE90hnhThBPaGHwXpnwKH4x
 0ALwnrzH+KogtxOb+0QNkWqDFwNKWrli7HWpvxqJCS2ULEf0KhW3V
X-Gm-Gg: ASbGncuSeWvGdPhHTQpNgpswMGCgZiK0kS7RJQ1Mru0qPFG4bXN0+Hng0WHjeNv5+sg
 8wVIYXeQS+MdZo5isr+Saub9RCtPq6tUG64f5CwfPhNYDJ140VH0RMI28836H8XuQJTxp/Gs8Zs
 qICDB3anBoz+7O4kRECyCdj2NVlbcBnqXjfL4QKY9jgsiE
X-Google-Smtp-Source: AGHT+IHPtOBDUkObu9JeYou7XhHWcqcINFORYBYsYcH/9twz5UwcsKyRriAmnWZn58Vf4aEV6Tjb6Gw4KtNGuw9XC9o=
X-Received: by 2002:a05:690c:881:b0:70e:5eda:4940 with SMTP id
 00721157ae682-712c67540a7mr246749657b3.25.1750775336325; Tue, 24 Jun 2025
 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-35-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 15:28:44 +0100
X-Gm-Features: AX0GCFtMLg9P9PGQQV2-nWAbY8Qkl50TqsOoBCmiqDgZvsgsB3cBgCeXjRT1Nuw
Message-ID: <CAFEAcA-FziWjBk6_QYVfcoyPkwOwnNOPNFugkSBBxsjCOPHEzA@mail.gmail.com>
Subject: Re: [PATCH v2 034/101] target/arm: Implement SME2 FMLAL, BFMLAL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 93 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 71 ++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+)
>
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 8aae70201c..ec12bfd089 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -751,3 +751,96 @@ TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
>  TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
>  TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
>  TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
> +
> +/*
> + * Expand array multi-vector single (n1), array multi-vector (nn),
> + * and array multi-vector indexed (nx), for floating-point accumulate.
> + *   multi: true for nn, false for n1.
> + *   fpst: >= 0 to set ptr argument for FPST_*, < 0 for ENV.
> + *   data: stuff for simd_data, including any index.
> + */
> +#define FPST_ENV  -1
> +
> +static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
> +                          int rv, int off, int zn, int zm,
> +                          int data, int shsel, bool multi, int fpst,
> +                          gen_helper_gvec_4_ptr *fn)
> +{
> +    if (sme_sm_enabled_check(s)) {

Looking more closely, this isn't the right check: these
insns all call CheckStreamingSVEAndZAEnabled(), so we want
sme_smza_enabled_check(). (Which makes sense, as we're
accessing the zarray.)

thanks
-- PMM

