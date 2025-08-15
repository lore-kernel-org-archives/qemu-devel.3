Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B5ACA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuKM-0001JT-Lp; Fri, 15 Aug 2025 09:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuKK-0001IU-Ri
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:18:36 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuKG-0004hT-Tp
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:18:35 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e931cb606ebso1324595276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755263911; x=1755868711; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A2SVl82lSKwzn5pgHmgDIU4GdUEyVyA3SjiVbW3mXOw=;
 b=fMdK/KF+0aYsabkMCExtpJCBOznAejaPCwqq5giPwUDGfQfKVCJ11UmOaa3QNXYDw4
 CASEYvFAhEq7PNqt/zc4kbbSSgIKccQiIxpvPZWm+hFEA0Z+/rBMMImIfUvPvjtx8Zsc
 YXk1yih140a82OZJOvBiKMnzHF1Gwh8/gz1t9zDN/+WO9FBY1/Ur/GyT/9HyXzjnUUdB
 BHgJf3xhPc7MqIjqO1cF2uc7dcY6SL9XXuWE7bocMH4Xl6bjyeEkmXvzAvTpDNlWcccn
 UpX2qZ8NR4x1/XluEyeuDEYkZe/36Gn81KUfMSSXi0Lsbu9APylo0XxJKSXS7DFFliJu
 U2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755263911; x=1755868711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2SVl82lSKwzn5pgHmgDIU4GdUEyVyA3SjiVbW3mXOw=;
 b=Pe50BBpgbFh4z6ydw+7WLqrA5P4b4kF3ADErmMxLtqU4HJWSsxtdtDAjIZi+XddZUO
 SpzMSW0Aappd56Q1WzmDqGScT+QAyd12HbAKiQB2baNfvMFw10CBC3m46pAwJPeu1CFx
 Bs4dNxQP8YFs6Ab2p/5NE+vK64ZWzkNMppEjpksVw9ahVcQZhXAKaQsn2DxWMmU0RIZA
 OFdSn4/meTdkeQ4RMGyLxuylrBO/Bzk0lvkpOu/+r/AIN/6SvkWzvqPYz9r+527kdG8d
 atcNFj8Je/nbUXckc0E7It9lNHxE3Ng+N55Jf2brZnBSWUci+dfTLslF3SulJkT1dOw2
 eYBA==
X-Gm-Message-State: AOJu0YwkAHDlbEBpp7Vp10+wAECMPpuyHwJDa0s/x3dNzGJ5PnzGa5In
 4zxIK5vab5jj60EVhWZo+AG4x0sIT1uomL56m+3/sF1qSVBBTUCvVPuASMUXFmGOEHX5etsij9L
 wFu8j9gOz/cKVHGDkOjgpcsK/2PGlmEf+nhVabjTZgA==
X-Gm-Gg: ASbGnctfvX/UDS7fseScOPeegwJsOP/iTr6YXKeDie0knJzqLyrG261hGkwnGwn5+7k
 6hqBVCkvNBMyMdcfkd7IfpW1/5j5yu2HOKpq5HpieQF/FcpQ3JvWFQ0uBpFmnil7f8XUlLbpp0R
 hP5DTL7nu3nqGCNVjzq+K8levpEdnSefradgdnsTOc3vVqRsaxTfqOj3BBkO0k2wX0eql0SUoxy
 Ca1OBE1
X-Google-Smtp-Source: AGHT+IHq1UIOye1aEteNk99Nf1KxaQCTc0bfeCCvtq816CSKeJ/uE6kAXpC70OFHLOmF2cH0Zh5BnXsSjEsW2PQH6fE=
X-Received: by 2002:a05:6902:300c:b0:e92:3380:3151 with SMTP id
 3f1490d57ef6-e93324dee4emr2608021276.24.1755263910858; Fri, 15 Aug 2025
 06:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-3-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:18:19 +0100
X-Gm-Features: Ac12FXwQcHZse5KJhgIKQE9HmeL_ac9-xF6s0m5U0_TIPlxwxA1qSo1ibLNCBx0
Message-ID: <CAFEAcA8YsRWk-dFMpnMc7ZgJNhOH5WuqHkhJ-0g2WATE6mAqdg@mail.gmail.com>
Subject: Re: [PATCH 02/11] target/arm: Implement MIN/MAX (immediate)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Sun, 3 Aug 2025 at 02:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 44 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      | 10 ++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index dbf47595db..b70ae5befd 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -4552,6 +4552,50 @@ TRANS(SUB_i, gen_rri, a, 1, 1, tcg_gen_sub_i64)
>  TRANS(ADDS_i, gen_rri, a, 0, 1, a->sf ? gen_add64_CC : gen_add32_CC)
>  TRANS(SUBS_i, gen_rri, a, 0, 1, a->sf ? gen_sub64_CC : gen_sub32_CC)
>
> +/*
> + * Min/Max (immediate)
> + */
> +
> +static void gen_wrap3_i32(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, NeonGenTwoOpFn fn)
> +{
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +    TCGv_i32 t2 = tcg_temp_new_i32();
> +
> +    tcg_gen_extrl_i64_i32(t1, n);
> +    tcg_gen_extrl_i64_i32(t2, m);
> +    fn(t1, t1, t2);
> +    tcg_gen_extu_i32_i64(d, t1);
> +}
> +
> +static void gen_smax32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
> +{
> +    gen_wrap3_i32(d, n, m, tcg_gen_smax_i32);
> +}
> +
> +static void gen_smin32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
> +{
> +    gen_wrap3_i32(d, n, m, tcg_gen_smin_i32);
> +}
> +
> +static void gen_umax32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
> +{
> +    gen_wrap3_i32(d, n, m, tcg_gen_umax_i32);
> +}
> +
> +static void gen_umin32_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
> +{
> +    gen_wrap3_i32(d, n, m, tcg_gen_umin_i32);
> +}
> +
> +TRANS_FEAT(SMAX_i, aa64_cssc, gen_rri, a, 0, 0,
> +           a->sf ? tcg_gen_smax_i64 : gen_smax32_i64)
> +TRANS_FEAT(SMIN_i, aa64_cssc, gen_rri, a, 0, 0,
> +           a->sf ? tcg_gen_smin_i64 : gen_smin32_i64)
> +TRANS_FEAT(UMAX_i, aa64_cssc, gen_rri, a, 0, 0,
> +           a->sf ? tcg_gen_umax_i64 : gen_umax32_i64)
> +TRANS_FEAT(UMIN_i, aa64_cssc, gen_rri, a, 0, 0,
> +           a->sf ? tcg_gen_umin_i64 : gen_umin32_i64)

We end up doing the zero-extension twice for the 32-bit case,
once in gen_wrap3_i32(), and once in gen_rri().  Does the
extra one get optimized away ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

