Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4D7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4Kz-00044W-1n; Thu, 21 May 2026 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Kq-0003v1-R6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:25:18 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Kf-0007SM-T2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:25:11 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c7492a2ceso5434900d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373501; cv=none;
 d=google.com; s=arc-20240605;
 b=IUa9Ie+ebXts8Yk5R+WSodM7papxOtIg4R2xUtOa1IWei113VfhCOF3Rr1Q4kYxykt
 Dru0ki7fOB8Fm3vqZF2ahEnm8AQCEbM1ktErJqFzVqgzDtlTgzxa35W7+3gLaCEnTu9p
 569QWD5Vv1Anxp+yhiR9nahzA+VSo5/vA+HhrZdlFGwYZ1xUuwkKABjwjF1J7LrE2foD
 +eoyCYAS352o+YLKirqfVUVRq7fsMlEi1YIVXowFAW1EHsc1qkgISFJZ5DT3KqXKn2LH
 TAYPy7nCTvyPpFepOaNppV9dTjr5928ilB2uHw2uCMTBHK6Jl1Pw/SwCf7M7gAjcKhft
 Lqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IMV2VojKM9YiIg5cUWJK1+VmYrgz8Yp4qTbDppJE9p4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XwLUWfdYnKm+xtjQZkSvWRMXlDXDTYYsET6wKimF4sEYBaYV+WvIxjFdDvBMfeAAK1
 mn9t1tII0ntwdaXRRdR4ZGpaOtD6Cu7Dsx9ePb8WPGpqvIAQHac1soPif1zTPqwcF/SE
 h9RABmg62/QUVY2H7eXzYXbn5uqt+e7uQMtdZhJ0haAiTUkhX9SdvTeVS/79C0o4AyQp
 2YDg/YMA+k7bh0RV7Z8RHEtZWDlD9dYTWUPrlH+fJEKmqcLSFSQ15AKgkVFwHlAH2e7Y
 TA/tjGLeLst/HA12pNwlNAAZUQFZFNzXwRiZxmdvulVlRBGW26UXMDcIj3EBm2kf4DZS
 ZkyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779373501; x=1779978301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IMV2VojKM9YiIg5cUWJK1+VmYrgz8Yp4qTbDppJE9p4=;
 b=tZb15mzYTapuq7Nf1Wuvd5t2C8576MFWJJm8vbrYxKq7YFCCqRPBRWZl69pFX4+6ip
 G2+ieiTbSr7ldjiQpJSEZubIZ/LFxxVqjadXVhgUzn7k62/dDx9cPXfDqcwTFXp6Vdek
 obVZlcoUKDEGNddWxxz/vhMoqIdxgQ/KkINi6MR7IhEvkpV2kwq6BM3nyfPLxnl9DGpk
 +e271Ji3L3ANAD5tpoM7DGav5yvgy4z7TG+O+d3GeVgnigAL2T2VTrhX1olLlZlF7aZq
 FI6OqGv0z70+afm9hdE/mCHVBsWrmtSs92mUfe/gdx8pCYPA+MiRNP0g7+ohzrgIo83P
 rtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373501; x=1779978301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMV2VojKM9YiIg5cUWJK1+VmYrgz8Yp4qTbDppJE9p4=;
 b=AgfHVg1kQD+8a6XXyrhGX5IzXH4oFsw0Z1+gYMpkMMwinNdoT0XGjGd3UClWEwt2t4
 Fls+GF/iJ6YHYNWquKZ7MD03hMv8m6g2yQ588pA4S/7JCkGDS3I6m5tuVmY/VdHMDD1I
 Qv0AgyYIMk1xBwrnVRq8DNH/z9LVNr8LtkOuZi/WqEzTwVUiDsipQFUS361lS3QLlgY1
 gcSTznkdZXlrW+4y2dBrNH7jGObRl33dsjdcihj8R2UzVl4CrqmFe9XzlaMmEvmcFOa4
 JYsf7astdkw21mV6hhV+57eUQp7oPzAfCCnSwu9Ka5BbIP1/bxKyDlEXwE0uijZTwVUI
 8t9g==
X-Gm-Message-State: AOJu0YxB4N6in6ngAHpX5shHrlmli75Cm9rL2/nUc1Y62WVOcuZaI/Fh
 HjceSwFXG5cyAkOe20YRv4epHFBPr+PWZTeOZQKmL+wLDFpxvi3BFLgHBC2hBPdQikoA/OMATTF
 5yKU5/WvpcDY3DAsK9lOvZZRBoZpJCJqHi4IhZpWezNLbMmJf2Ocw
X-Gm-Gg: Acq92OFOj2574k7NS7yKDt1Olvki+O6asR0jfgWW0Hx9N4LFaRqGY39oBYvQTEWKXk5
 nklLdWwRvkuQa7UHIw8SC/jbZzbMmLaIQ9+oSTJ1DmDaLDABlC1XsYGEpbEKytY2tQcYfeHe0Xb
 IGxKUc4lTMRy2XXG1QyUmIQqN2tDqwDWzxnheyFp8rDBca8i4CFlWnpv13zSst2Fj8g2/jUAaQ4
 g6yaZ44aE72XRxnXe5r8tcN4sJ/+mcyKRoHpJphjFzJU8xqL0rhx3SwS5uWV+Gcze2JeuzgkaCo
 X5BlpXzwIYNnCZC8cIESat+u3X8n9RInR178Q4hTGHhfmUGNeFbVKNY6TRRqrAudp7oxcxGNvLF
 Ytw==
X-Received: by 2002:a05:690e:140d:b0:65c:2ac8:ec3a with SMTP id
 956f58d0204a3-65eadfc9228mr2604010d50.21.1779373501074; Thu, 21 May 2026
 07:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-17-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:24:49 +0100
X-Gm-Features: AVHnY4LMy91g4wBRaAIznalaSncZHAyZGwPatmGhi0mRbciHyujRbqPY6i4iAyU
Message-ID: <CAFEAcA9bEO6QrchkPg-XRxi0i1ijaw0z2Wmc8QxJZuGAxhBs_g@mail.gmail.com>
Subject: Re: [PATCH v6 16/64] target/arm: Enable FEAT_FPMR for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 20 May 2026 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 4 ++++
>  docs/system/arm/emulation.rst | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index ff0c2b1c47..a377f67b9c 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
>      SET_IDREG(isar, ID_AA64PFR1, t);
>
> +    t = GET_IDREG(isar, ID_AA64PFR2);
> +    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
> +    SET_IDREG(isar, ID_AA64PFR2, t);
> +
>      t = GET_IDREG(isar, ID_AA64MMFR0);
>      t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
>      t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index da5f7efce2..44c7196d09 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -77,6 +77,7 @@ the following architecture extensions:
>  - FEAT_FPAC (Faulting on AUT* instructions)
>  - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
>  - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
> +- FEAT_FPMR (Floating-point mode register)

I generally keep to the capitalization the Arm ARM uses in
the section where it describes each feature, which in this
case is "Floating-point Mode Register".

>  - FEAT_FRINTTS (Floating-point to integer instructions)
>  - FEAT_FlagM (Flag manipulation instructions v2)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

