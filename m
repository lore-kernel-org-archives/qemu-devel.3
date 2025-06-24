Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30431C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0et-0003Y2-7P; Tue, 24 Jun 2025 06:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0eq-0003Xe-4h
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:13:41 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0eo-0006Cs-0S
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:13:39 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-712cba3c6dcso33293547b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750760015; x=1751364815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V1K0DQYMEo/LNp64xNhtoNntqP4UYD353UEygP8WUYQ=;
 b=x4aek1iTmiLXbVodKeuURoQsmZnW4zGahymbSKBUcNKMLFbsrWIbBc0oLp4WGDBhM9
 sfuMl1tFVqVFW0Ht3Cpf5uxZEOLIxHAmeH6cdUQY1+bn4XeV9Pp4r4Sh7L/sOz1A50Sg
 GCxCNo6x5UR9kWS+yBOEOINYEg29qeiPb1Nl8oZmkm7Hmx1FbohD47E8UDsrPHRCZEzV
 i4m2ooYvyRqenQzQJmp7Ef/SWllzg7XHXxBJv+9EmYr87STMn0yznoHtoUQFcYVO9mUg
 ApvigImS4QmCsxwehYgxl+Q0KlgNBjw1NiLnHUaXByRp2NQahvnFMeo6PSzKUfdK5Jkb
 SNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750760015; x=1751364815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1K0DQYMEo/LNp64xNhtoNntqP4UYD353UEygP8WUYQ=;
 b=npjFyXNQoEWr3D6Pe9AgzVkfTx391par89J3rk6XKJeYtv7lvyFh1S3PMBxmBAPVU3
 mwWzPSivOTe/cPVTpYeism0T+hnRoCNXd2HXgHKZvhSOYd3+VXpQFk5np+fa8n5vI1oy
 8+cPXJv3duSOzouPxciFvnhxB7DcXR6Gv9yxM0xmzf+wlNwia74XtaaERWtuGPrdNDcv
 ZB92eEpOWd4NxxZYBn91EbG0DjA8ZD7jk/QI/PVq5Vtg2tgjpetb8S1JJYS10Sr7nLJ2
 8dNqqleH3DdSm0sJXAJjpLwwkfvX7sKe5hZYcxhyIZAhKo8uoPMdaUIuT/NNySE0LKC0
 UYug==
X-Gm-Message-State: AOJu0YzbRpUEfpVcO8yxufDJFTv5PXg9FMbDbNabGhsZUYgiN1oxNKcU
 WxxqdjWEgMXf1xPvpXoj4A3Neb4ZjAj2vD9LWO+Hd3e0rM5HgSrTwYauKTGDVm+5Ski/WBiWWH3
 ocJ+Oi5J06iuCv2qlXh0RnfwPYl1aikWAxuRh9ewteUy7MSiNTJyA
X-Gm-Gg: ASbGncuJ8RvjVE+6DmtfVr0qjdKRD7T9a6Wqv+aa4JIbUYlVsEVb006eOxKxOkSlPM/
 hQ0HY3kGyVIUIPMfOAupg0rr0uj+UDWcIzriBfDg7jRrcp7lb0DktOraVCxFd01Op6flHYC3ksD
 vOl9ozF9jFyoIggL6zDkgoI5grD1GBFgI3G5VZkw0LTK3d
X-Google-Smtp-Source: AGHT+IEcuKvXWilL9rLRIN8MeTDe+orpBTkZTVZxOn2p+8gdLmPldNmWnEqRvgFRXwReC1ZiluR25aQ78fTlu3etiZI=
X-Received: by 2002:a05:690c:9985:b0:70e:2d77:3cfe with SMTP id
 00721157ae682-712c6386f1emr248989907b3.2.1750760015118; Tue, 24 Jun 2025
 03:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-43-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 11:13:22 +0100
X-Gm-Features: AX0GCFvs3ObUbQdsIJo5vvrNQ7vDTN8r2yEI_JWOCekp-ljgnSJqDsTlST-JXN4
Message-ID: <CAFEAcA-VvH13D8ViMu8kv85sERNNA1JP+JLX0p26zKu_nasBcQ@mail.gmail.com>
Subject: Re: [PATCH v2 042/101] target/arm: Tighten USDOT (vectors) decode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to USDOT_zzzz_4s and force size=2 during decode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 4 ++--
>  target/arm/tcg/sve.decode      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 20b73cd572..29b6f09260 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7105,8 +7105,8 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
>  TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
>             sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
>
> -TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
> -           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
> +TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
> +           gen_helper_gvec_usdot_4b, a, 0)
>
>  TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
>                          gen_helper_crypto_aesmc, a->rd, a->rd, 0)
> diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
> index bd06a1bdf0..7ed186c9bd 100644
> --- a/target/arm/tcg/sve.decode
> +++ b/target/arm/tcg/sve.decode
> @@ -1599,7 +1599,7 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
>
>  ## SVE mixed sign dot product
>
> -USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
> +USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_e0

This sets esz to 0, when it used to be 2. The helper function
looks like it looks at the simd_oprsz() so I think this is
wrong as well as inconsistent with the esz we use for _4s
insns in the previous patch.

-- PMM

