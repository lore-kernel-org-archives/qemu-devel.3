Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC447C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFwX-0006ew-AP; Thu, 03 Jul 2025 05:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFwV-0006ds-Gx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:19 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFwU-0000hX-0Y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:19 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-711a3dda147so84158837b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533757; x=1752138557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wz0yTYttiw5SfPbbLkMOcZ7w7E8uJtXqifW6IrGf/7U=;
 b=zg3Ur8yV29mfQ9vlPTMzm5K6MbP9RUkgN7jxPoMbzDIzc5i+OZCgwnSuOQwY7do+k3
 KRZHI9/bmPsYomnzu3JxFYc/Psav+IeDgwj5EX3GJCBSyPUwx5AKSicQrhiSZUx+/cVy
 1hsNB06S6k/k9WXLZ/sUbLk2gbZTK+S6IFVSVD+bnGk6SMxEy6voMANmcFkRF0KgBP5g
 Kiq25N5Z7k1YnUUEWCgkwrKKNW7V77z9zgho7NU3V653yuY82o4yRCb/CDS4A5SNAubk
 QEpoXgT1cD6gDWmPBT+eo0fxF33bK0QwX/kXb5sj4LdghZOwXUAkuWET3RgXiHiq/nQW
 nihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533757; x=1752138557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wz0yTYttiw5SfPbbLkMOcZ7w7E8uJtXqifW6IrGf/7U=;
 b=pkkXwn6I9jFMN6msxG2xpg1kdu4ZvR6o1pyhGBO28zCDGTiUVJoAfGpbgTGs/0eUNx
 jjGfPuFdqyjeYKOBQ8Lgy+T9Uz5nLhbEAihe0ijYPzcUjmRouQFoqFkPfpG/RZ3NaVxH
 VDMtTZc2AgNNhFpM9kRP/eYio0SiQHkolauZyaALFBPQlWIbU5CWZc5N+YGm6GTe9NE3
 siEsLg5mqSFT8Km3U0T1zBq9sLeTW5i8RMGdUFuKkSdYZhON+YiSWkC1tePCTgTMHhgp
 nNiLbUQiGMVzhDuTC09CCmXBYGBADGekKzSTKuMPDK+k7rEIp58hTgyuU68cAJw/zzTv
 oYug==
X-Gm-Message-State: AOJu0Yz5YcMgSVX4Po3YMbiVhTh4Mo3YZGD3acoLcrFJFUwUHhEHAITl
 a0CRg0MW73DR6D3xCntjnUxefGCvxH7w/K03wZICifqVyzbmNKHvpjUgrumG7sOznQnCiAn1Rq7
 JVlKcduIMf2aUdoLIhUrK2KxFhX15PalAg3qK2TivxQ==
X-Gm-Gg: ASbGncvRx2nBcN1hXvXrnLKIn/YS4tz5MvH42FHE9EHVFsresp7a1iSde0HDsHM0lCn
 sU3l1p/pDPMPFA2rkwS3E+Bs2SyMzKPgu+pblqZqUKOcHAvj1dHgIjrG9Eex6fAfRZVCCgBmKLv
 PvOJVMQmnQptOOSdEEkulFb2oItIt1e2yh+kU6BhmCZdjD
X-Google-Smtp-Source: AGHT+IHG/bHHgjGxU9BEPChkYT9I/20ioFJllaAperKB0LyallkvyGlZtMiYa9kq193I2DM2nCAGy4kliwq98EYWenM=
X-Received: by 2002:a05:690c:6d0c:b0:70f:9fcd:34f1 with SMTP id
 00721157ae682-7164d529e09mr81371457b3.25.1751533756994; Thu, 03 Jul 2025
 02:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-8-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:09:05 +0100
X-Gm-Features: Ac12FXzI2NETAyF6zjOTDSNmLu8HUdviAS2HQM4Vwh2MNVHKTTivIRNwIj7GIlE
Message-ID: <CAFEAcA8WvtJtDfQWAXP+uzgBsNSJLFqjz6hotNzXgy+bOr0T3A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] target/arm: Fix PSEL size operands to
 tcg_gen_gvec_ands
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Gvec only operates on size 8 and multiples of 16.
> Predicates may be any multiple of 2.
> Round up the size using the appropriate function.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 598ab0b24c0 ("target/arm: Implement PSEL")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index a0de5b488d..8403034a0e 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7291,6 +7291,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
>      tcg_gen_neg_i64(tmp, tmp);
>
>      /* Apply to either copy the source, or write zeros. */
> +    pl = size_for_gvec(pl);
>      tcg_gen_gvec_ands(MO_64, pred_full_reg_offset(s, a->pd),
>                        pred_full_reg_offset(s, a->pn), tmp, pl, pl);
>      return true;
> --
> 2.43.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

