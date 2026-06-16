Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FC6CD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZT41-0005hm-DU; Tue, 16 Jun 2026 08:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZT3y-0005hN-5M
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:38:42 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZT3w-0008L7-LH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:38:41 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660390acd71so4489139d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781613519; cv=none;
 d=google.com; s=arc-20240605;
 b=JGGj7LTWwv1ZHV2hqNVrbkiKCSEwjWmMa60yvJ2f3ZhFi5GySoRJgNd/b5/cI/DOW1
 El6iCdHlE6xCXkDHChntay/yqiz7cStOeRN/3KqbJDUqCYVvT9tOnN5uByZRLyZMZ6x0
 ZgU0P8BlVBO9PhYGz3988MJ7oPQ4fvfmBYeRKHxP8fDUZicvAxGCqusAdVhzhDZfrowD
 FTT4Y8XO6GnqjMZE6fJF40IqOqeBSSbSgxyCL/J4v6wKHnVRJ0PqrJYnZuz66cCvcgfy
 iA/SRZfkejmwh1GjTvTZYgxSznu9MQoafFZoXiHeN+RbScBzQj2lms7e5jTXYtQqAhoC
 6ISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s/ORHAUaOxzVNXO7cpJvSVqKmyyKMS7BCx1X2sI8mhg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Gv1Eu3/kgyvSuVqh7vPTKFDs5S0oJ9uxi43LGG2kxzW7qefmGfuqUHVk3lrw0SqBHi
 TUt1Zx7N+nUr74yXQ6gvN07LhbIdkTxG9mOXR5gDHxiMh1z+K+kIEcljKLjYyuEpou+9
 8JbYv3QX0WxWREy5zBx5hiSqYgObTmNlrHBC5WfIPvLdTbtyUvda6LOXko4cTLMQRId9
 maRiPb4oxzDQn2GaGyI7KjIT4F0sJ4NlF3tj93UweQl4Pb5Bu83jcINwfcAynFQCpvYK
 gsemNref6xbe9IGrN4+YNIilhKJQfwH0TH4bAV56l6LVrkDGvHZZg5nBRu1rFpe3vFiR
 6yAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613519; x=1782218319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s/ORHAUaOxzVNXO7cpJvSVqKmyyKMS7BCx1X2sI8mhg=;
 b=OfPCMbW4FV+adRMVKguYybzCYL6NB8GPew7aIqsUMVX3GryFYkTS46cQI4ZzvURGMK
 gEUoJVhiWEnUbJjMxCbYWPdy/ExXzS+hiyp2HstgQHkZZXdLtu4dOz9cEDIka6yjgcJl
 ms0rfUWb6mlJ+9r5OMiSO8eKLg4B0JiNZqDScGAn/5WZg45yQFMJocwcTwyRT9+MRVyu
 JehMyGvDfFtiGi7PFh70VfQNKxdON5EyN1wIdpt+n+oIgkVr7BW7EWYTHvF2eahoLj10
 jJ7MOlyGCaaEp/pN0pcXV9KI+jxebX6hgCK56Gu3WeW1JdSN4iM9X6jC55Pl7rALSpt1
 61RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613519; x=1782218319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/ORHAUaOxzVNXO7cpJvSVqKmyyKMS7BCx1X2sI8mhg=;
 b=Iz3gioFUeSiVdutrqpoWwoZVS58DLIsUO1odEJmF9EYMc9r+2dCPwV3hNfLhJ/HY5F
 n6ZBrN6rqiY3+EWd8nSjwTrRcEsfn33QeaffejdYp9heEvR7xMYRhFqlsjVWZO/jkpdJ
 h2thzyMV8Cp27YK9SZ3Ak3eayXFgQUNodEa7znZUGVzWnMwiOq1WIf0OY9vzY1jz+BKB
 kP0DiQFBR12YgkpdHM7R2rzTQZdLT7rejt9RhH6bZ4dqAQRtPxdUyrRzX/p5FdJf07lM
 eiXsVsWhMi6mxBIFOCTYZSOr7krpL88/UNf1dHW7RReBgvOriVpMf7u4tcOoabQYsXl3
 KlAw==
X-Gm-Message-State: AOJu0YzzKaAs9OLLw8kVyVCqrVvU/zfqyDqsZn8zlEEyQbZZWuk+QMup
 Ik/8a+OBkpBFNWW0eSyiO6U0KbY5/5fvddrFMiKCaTalGXQECrKyFL31kzdP/MJ79SbPDsTMyal
 DE8MBCM/32cUGT/DkytdiTPB3JD8FFMW93GGT08/F8g==
X-Gm-Gg: Acq92OFoM4OKu22LchTMxyxXzAxK+EU5WIRQZQj1sn2OsHwAcncJVMZmGAhemxS90s0
 dhtoKW61yB2yeMLCdiG9Y8eikOTAoCDvaqwU3m1nzhmYbmZa1WteLHnTkWbUQxX5VoICtVCTyqd
 DuFDOY00JHsrIHVhhN4Q+f0shOBZWQQ9KXtVMjYVrJLBBcs1pB/FvyejgPG880Y9v5Imni/e8YF
 lgBLYI6CEpSpsHGhN9Bh5lJzrnvvYQ6+7xLPscSxhTb8gv/f7xodCB4LwY/fRFpi3q90QG6ruxy
 UJKJ0A3fmXRZ4GJ2ouVw9xJCiwReDFcYSKVtI1gBbAuOW6TVZ4gqBhru/fEKzruBfec=
X-Received: by 2002:a05:690e:418d:b0:660:3c35:4669 with SMTP id
 956f58d0204a3-662b49e856fmr2289011d50.19.1781613518944; Tue, 16 Jun 2026
 05:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-11-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:38:27 +0100
X-Gm-Features: AVVi8CdFRkwdKKw21Bcn4nrmxhewkBQYj_72nFDlZoU97MefUFxKJpoq5S49pjY
Message-ID: <CAFEAcA_w+C9w23UmYSv9ByvukNYRXEkCg3R05q_rdVSCK-7D0A@mail.gmail.com>
Subject: Re: [PATCH 10/25] target/arm: Add data argument to do_frint_mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare for needing a non-zero value.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 083b70b487..e9c0a73e90 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4656,7 +4656,8 @@ TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
>             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
>
>  static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
> -                          ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
> +                          ARMFPRounding mode, int data,
> +                          gen_helper_gvec_3_ptr *fn)
>  {
>      unsigned vsz;
>      TCGv_i32 tmode;
> @@ -4676,22 +4677,22 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
>      tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
>                         vec_full_reg_offset(s, a->rn),
>                         pred_full_reg_offset(s, a->pg),
> -                       status, vsz, vsz, 0, fn);
> +                       status, vsz, vsz, data, fn);
>
>      gen_restore_rmode(tmode, status);
>      return true;
>  }
>
>  TRANS_FEAT(FRINTN_m, aa64_sme_or_sve, do_frint_mode, a,
> -           FPROUNDING_TIEEVEN, frint_fns[a->esz])
> +           FPROUNDING_TIEEVEN, 0, frint_fns[a->esz])
>  TRANS_FEAT(FRINTP_m, aa64_sme_or_sve, do_frint_mode, a,
> -           FPROUNDING_POSINF, frint_fns[a->esz])
> +           FPROUNDING_POSINF, 0, frint_fns[a->esz])

We seem to not be very consistent about whether the function
pointer comes at the end or before the extra data args in
these TRANS_FEAT invocations, which is particularly noticeable
in this patchset where the earlier "add a 0/1 indicator of
zeroing" patches added the 0/1 at the end, and this one puts
it in the middle. However, this is the arrangement that
the existing arguments to do_frint_mode() have, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

