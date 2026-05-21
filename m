Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB478CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5R3-00065t-Us; Thu, 21 May 2026 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5R2-00064X-3T
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:35:44 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5R0-0002Fm-59
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:35:43 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c09c1d000so6062815d50.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377741; cv=none;
 d=google.com; s=arc-20240605;
 b=IMCA6jvXIwW7ZA2AOgg09KUIrt4n63+CU8KEdK9kPKYzZ4Dp/kIvc59sG2OZCb1HNn
 fYnI9Bk8lMdf7bQqFWyv3sfGB+uKHQu58cTYCfbvONQndnOEPYvYTQVP34e01IzPdmn9
 MUbDRPP36z17yz6wwDSagiHq966mArsLGxGTvg5yy9ceoeACmCyUBDm6VYcw2YpRFmEs
 o7BxMGMzkvqH3VzeWb45M84JQ8jAiXWTdnUHcua/0VcrxzqbYIA31+ESYGC2fobriFI9
 3r6+DudZHItGrFwXNqbbSNsZ2LLon6Y4CdhJA+0akBxIt2eZ/iWoUeCky0QrYgd3DTVf
 vW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5yMOeUX9LXsWWxDnUktmHP86kFYBVWfDYqfkqSHprjo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Sc1+wcEieRkzjiQa6DxKTqKWVbNvjVUWktrOWvhpnFHSWHPGs+6fyDCuQ5855bHl5t
 tUk2sad/nnXneNXw94x+mzZ5GioKncAoR3XY7lEDVZOF0DzL7xby3Qca2ccxReCDafIA
 6uDz0r0TxyK0A7wnzItWoz8blLR2oLeowQBDxOy4vo7BQNWWpOZf9sjZhyaT/qdhK6Lr
 TTNSjDv2XkqXhAZlFeWKg86T0eiiwU9Cgxwf1Gw0QtT4R2dIp8zIXyUJ/R6r4tBvardE
 PnThX5ihkl/QHWZH/ALCnFJxtg4XS/hzxA1TqyHfB4LczzBP+id+bTjKbQlvv7pLcHrr
 qCfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377741; x=1779982541; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5yMOeUX9LXsWWxDnUktmHP86kFYBVWfDYqfkqSHprjo=;
 b=LBm2LeRMI/EFdr8BexqTDRN/3jVlFfECI6J1yoOI+MHXirIs8OXSXMX8VHlcQ3FqR0
 zG/UmR8tndoo4Q1t9OCxDoDrr5tKkx0RrrBbUO1yBg+nu/CpbFCw3dli4NXKTqqklVUI
 7ip7qEsJLnEu9jg+OUBB7TmP/SUGIegIaBrvhJNgb4YgRKFw/iwHyWOnfRBWV8FLW9Ej
 ZkhjGLD1QD++gzsvwY6A/XQBwWTM2n5MzpaFeWhwwFyXBB05dBp2ndhjheJMg3dRuO9L
 qU2Bv9FitCF22I8ra9d2Y4OhzDDsDWKvZlka+VGvp5nZhBmBvQ5+ECl8D6B4mnOgTsCf
 dvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377741; x=1779982541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yMOeUX9LXsWWxDnUktmHP86kFYBVWfDYqfkqSHprjo=;
 b=B60y0SikHtgXsM9tG8rJiPXaUhKa4coa7QyuKnG3UmK8WBKsdBuq2If6PvvNVY6Mud
 5Kv+T80YcUySQ4B5kfi7cs1WXVSqcvfSx9pRUEhUfelglmFZYDVep9l2i3auKyFtJwgk
 bZHWQHGQwnF/LgeKwG7FEA+lfZbLsG3TMWuqgV6dgFr4nZTYYrfmVsNNo7WVcz/Ac79r
 MA5Y8TsPAq84ayYD90bJCqNJQJmEuWuI/quRxDqWNvy2KC9IIui83vzLf8GMM9DGGTre
 hVSDHOlCkX4ICufGpY4ahIu2DBv8dY6rRhPYqmaZisA7c/vC6Xjd4Nb9enxveph4Fz2G
 GxPA==
X-Gm-Message-State: AOJu0Yxd5ubufx8MWCBKtJTRF9GpoJ25IeOboxjJlpKzu+A5uj5Je744
 IXxgsvpdNBRC0yjtODe/jg+C7CUNpXtwhWe8vb/2EbORsnBU8SnA/j+URYLCIB1lU0XES/qwpDZ
 lAsp8gEluOvq57xQaJ/miTLg0pdczPHw2zBodOhFbSV4XILMYYIci
X-Gm-Gg: Acq92OHe4DbGhjBJFxKhYk9OK9BC6tbOF/wPPdmz0gHT/N3k0BwTun2JhBdZAmfyV3z
 EaNu9EZYphh0enJC5eYSPjDR4r0IN+AfHoBOM36vSwgE5KA6KucI4+jn30o1Jt3aRUc6GKBfQjx
 RncVnhj5Kk02FmXzYAW/95180tjQMKIvlDd0gKv/uF+Zak0P/bb99Zsz/cjnkk3l6BUbVGxSI8n
 vv48HnFIb//oPNQet6Ws9ltQrEB91jnyNkfNkr5dJbDj3fX4I3ukEUCznhi7+a1Ed6KhWO5Vdrf
 CbYSwexahDBEa74e6Jhc/kxeVm7pVB/991Obpv4vqmKKjLrWjmSRFU/qXh+S8A3/KjjTHFWwWe4
 bVA==
X-Received: by 2002:a05:690e:4093:b0:654:fd9:2e8c with SMTP id
 956f58d0204a3-65ead51abc1mr2663609d50.15.1779377740816; Thu, 21 May 2026
 08:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-20-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:35:28 +0100
X-Gm-Features: AVHnY4LlUYcG28qT8B5Dyf2dOP1Ygpq9c7q0rmLEdUtEErpmcXDRbmiIdLx0BRs
Message-ID: <CAFEAcA-4yuOQgbP7AcV0_eOXNkh9ZtFjaLOxGZk=re8UvWGtXw@mail.gmail.com>
Subject: Re: [PATCH v6 19/64] target/arm: Implement FSCALE for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 20 May 2026 at 19:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64-defs.h |  4 ++++
>  target/arm/tcg/vec_internal.h    |  4 ++++
>  target/arm/tcg/translate-a64.c   |  7 +++++++
>  target/arm/tcg/vec_helper64.c    | 16 ++++++++++++++++
>  target/arm/tcg/a64.decode        |  3 +++
>  5 files changed, 34 insertions(+)
>
> diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
> index 215df1201b..b7880f773e 100644
> --- a/target/arm/tcg/helper-a64-defs.h
> +++ b/target/arm/tcg/helper-a64-defs.h
> @@ -152,6 +152,10 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
>  DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
>  DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
>
> +DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
> +DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
> +DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
> +
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_2(exception_return, void, env, i64)
>  #endif
> diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
> index 5c3f51eed3..b647399b18 100644
> --- a/target/arm/tcg/vec_internal.h
> +++ b/target/arm/tcg/vec_internal.h
> @@ -349,6 +349,10 @@ float32 float32_famin(float32, float32, float_status *);
>  float64 float64_famax(float64, float64, float_status *);
>  float64 float64_famin(float64, float64, float_status *);
>
> +#define float16_fscale  float16_scalbn
> +#define float32_fscale  float32_scalbn
> +float64 float64_fscale(float64, int64_t, float_status *);
> +
>  /*
>   * Decode helper functions for predicate as counter.
>   */
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index d2a4b0fadc..ac18ceeeab 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -6496,6 +6496,13 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
>  };
>  TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
>
> +static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
> +    gen_helper_gvec_fscale_h,
> +    gen_helper_gvec_fscale_s,
> +    gen_helper_gvec_fscale_d,
> +};
> +TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
> +
>  static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
>  {
>      if (fp_access_check(s)) {
> diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
> index dce5e0505e..7d403adfba 100644
> --- a/target/arm/tcg/vec_helper64.c
> +++ b/target/arm/tcg/vec_helper64.c
> @@ -177,3 +177,19 @@ DO_3OP(gvec_famax_s, float32_famax, float32)
>  DO_3OP(gvec_famin_s, float32_famin, float32)
>  DO_3OP(gvec_famax_d, float64_famax, float64)
>  DO_3OP(gvec_famin_d, float64_famin, float64)
> +
> +float64 float64_fscale(float64 n, int64_t m, float_status *s)
> +{
> +    /*
> +     * Given the 'int' parameter of float64_scalbn, we have to saturate
> +     * the 'int64_t' parameter of the operation to some value.  Since
> +     * float64 has an 11-bit exponent, saturating to 12 bits is sufficient
> +     * to ensure that DBL_TRUE_MIN can be made to overflow.
> +     */
> +    int sat_m = MIN(MAX(m, -0xfff), 0xfff);
> +    return float64_scalbn(n, sat_m, s);
> +}
> +

I just noticed that this seems to be reinventing the
existing scalbn_d() in sve_helper.c. Could we share the code?

-- PMM

