Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10830CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYoQ-0007oi-AO; Thu, 14 May 2026 12:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNYoL-0007nq-Hf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:21:21 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNYoJ-00083A-Jg
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:21:21 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65d071aac6eso8883248d50.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778775678; cv=none;
 d=google.com; s=arc-20240605;
 b=hUi0HRGoEF1ElHlgutbju29qAbMlTxsf+dwsNpTwxCTHMCqzDK/O//FeZwer7Ima9Q
 dMuqVmuWlUwJqcubN8D59LQ8mQNc3OCyNvNlh4RksR21Ajlpo1IDuJQcTFSp6LHdFFnb
 804OV+9kxilqfrz90zm2rWre6fwwsmm1iQ1S5FKHVGfJW83x6cbnfHxdGBB157t2dxFG
 qT25Y9bfeXBun4xpB8LuofxMSUTjlgOhB5otw22Z0vTD8cRy7I+WZ6mMTp5RBXKcdZ7B
 dP0QmdtIAD5c7BxdXfRbWmHGPLlp6+ob7Fu3F6zw+RrFM0R/IhERFsC0X/C0PXic2zy1
 EaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OAwWMAatT+tvxc0cMeqjmBcnAUfd8sZjNY1T2yBJRDM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=KKkPkMlQ/i+MCO7oa0Kt2HlHpdiFGdIoAARX6I5WosCPOZM8ueAUQq37iBLgUX55Yj
 Yt3vKF2Wn2CVlVUM1yO3IrKlDrOYIRh5y/30DGDAPSmswfGxYU2TzeF6+M0M956d29vG
 Z53rjR8LgTV/YEMhXQ9j2wwEMeOtpgPyICJ3srb+lgZu3lryjZEUbArdE+1cI4GfaB2e
 Hz1W/Tdn+IFGCsycvMv93wdZrp8jojyaCEjiRBCQYMsz9N3NpbY2QgEYYsPpiy6TEget
 dKtVPLacR0Jw3KCddg0oJtjD2zTX888XT1F3+6buu9xJI8JAQ9mGiFy1lSaA0a4v9hZg
 k2LA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778775678; x=1779380478; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAwWMAatT+tvxc0cMeqjmBcnAUfd8sZjNY1T2yBJRDM=;
 b=jG3F98psf+AU17qjxXLhacfmkLTn+SPSSlKeopp7gbrRengUesF7SF5cGnLauL7QUj
 ZZts4ofmIrvcBrJSZgnlKzkmOyUY9IhTd3tF6jsySPzGmoqDFexTtrp+vkFeaC0NVldH
 1ycs7mLiNwj49F/IWfDZ9oEb+2PrtNO+yyWlbgLXq6ROP4mge4lx2KWSQhTOSop7pVvS
 UKvv9nzVanMX3NvzUzH2H/x7qeVAsah4zVxtaeYPHLDb5uZZFsyxQoRi0uVWlB1CwfJg
 04de0mCNBgTkqG782uueYablOzymNkrI7HPc1jK/FzlMmjhBRDB/Xji71tydePllLtGP
 8cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778775678; x=1779380478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OAwWMAatT+tvxc0cMeqjmBcnAUfd8sZjNY1T2yBJRDM=;
 b=bazL3VpsCSF+6fX+q5t25ARr9Pck7as936XZpbYRz8yh14CZ8q0WVQPd9TENoPeYQw
 4brvhz0IV1Vnjv86uX3krGpqmr7/6lDtOu61J66fyAN7FWCH+dP2CI8ieqRJdwRbKL+Q
 2jjlG6NAzLD0XtnrRmN2UjdCp439kHe5088fRClpwx85m1IK708hS9CgbNGqkWy5wIjq
 IbGDhi/7uixE72xpkxrV9NOFpnN6yAZymHP5MpQ4xE8tms3FesiL+VBd9wZHaHhSQk6/
 P0gqJvQnFXiMsv3IOhpSAu23z4SooW1aBIF9oVkAHGdosbAZmOKpIVVpoUcLxUnwr/aQ
 LEGA==
X-Gm-Message-State: AOJu0YyDLP1KrBRQLQqCdKkWDDUSEICY5UtosUek8GrVCPcTNoWZk7G2
 R/NKnhKUVSLLSwsx7uBOarITyvBGl0lpRu1PS9WFkPNIX1y1Y48ifyXd/PMYA64yLOlh4I42HAz
 4ZxTHtptQtAKtK5NMojlJquYI+z2IUd0u1VJq8/QOtg==
X-Gm-Gg: Acq92OEc9xcSXhkKGSmLT4gEswI/m/jvNkC4u4SQq6Ww29ztOxTw7iC7oAzFqzjxbZX
 NuZT6nyLqdx+M0mCeWGfpcVGBlRElg6/H1AajT/rGq9Qn4trwrmMY4ZnTDbZpl1Swk+X9VVE2kz
 bUX/jWAgHfkr1PdrgcX1CSqx412VkGW5VL7PN9HzxwDaGST5RdEZIECdsFyM16luedNUuwhTMOZ
 hxXE43mpE3YxP8jxXdISZDCJdppS1GH0H1P3GK4qRa3Z/6601U+RDy3Az6rxyTJt8SfH3PPqP+G
 UtUZ5E0X/qoViqegqftJFjHBShKs7DKtXe2MtEahmLRwVjGA6IE2VixXWMSNqZqQW9EOUpBKDmn
 bFw==
X-Received: by 2002:a05:690e:4147:b0:654:45be:85ad with SMTP id
 956f58d0204a3-65df82c480cmr7610096d50.52.1778775678200; Thu, 14 May 2026
 09:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
 <20260507234413.643512-30-richard.henderson@linaro.org>
In-Reply-To: <20260507234413.643512-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 17:21:06 +0100
X-Gm-Features: AVHnY4JQRBodPCFLe-w_gdlmlxYKT0gNtzTUko1bN8x6SzRVG2JYTvBVvAJXI8w
Message-ID: <CAFEAcA-KCRHpxzPz9n8NCqVrJTWFNw9t2xCK8Eb1v4mwt0oVMA@mail.gmail.com>
Subject: Re: [PATCH v4 29/60] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 8 May 2026 at 00:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-fp8-defs.h |  2 +
>  target/arm/tcg/fp8_helper.c      | 85 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c   |  3 ++
>  target/arm/tcg/sve.decode        |  2 +
>  4 files changed, 92 insertions(+)
>
> diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8=
-defs.h
> index b5dc2b7064..bbc8d69e28 100644
> --- a/target/arm/tcg/helper-fp8-defs.h
> +++ b/target/arm/tcg/helper-fp8-defs.h
> @@ -12,3 +12,5 @@ DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, v=
oid, ptr, ptr, env, i32)
>  DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i=
32)
>  DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i=
32)
>  DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, =
i32)
> +
> +DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env,=
 i32)
> diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
> index fce02f68fa..400deee612 100644
> --- a/target/arm/tcg/fp8_helper.c
> +++ b/target/arm/tcg/fp8_helper.c
> @@ -78,6 +78,14 @@ static FP8Context fp8_src_start(CPUARMState *env, uint=
32_t desc, int scale_mask)
>      return fp8_start(env, desc, f8fmt, scale);
>  }
>
> +static FP8Context fp8_dst_start(CPUARMState *env, uint32_t desc)
> +{
> +    uint64_t fpmr =3D env->vfp.fpmr;
> +    FPMRType f8fmt =3D FIELD_EX64(fpmr, FPMR, F8D);
> +    int scale =3D FIELD_SEX64(fpmr, FPMR, NSCALE);
> +
> +    return fp8_start(env, desc, f8fmt, scale);
> +}

We need to vary the number of bits in FPMR.NSCALE that we look
at depending on whether we're doing halfprec to fp8 or single to
fp8 conversions. The pseudocode FPConvertFP8() function has
  let scale : integer =3D if N =3D=3D 16 then SInt(fpmr.NSCALE[4:0]) else
SInt(fpmr.NSCALE)=CD=BE

I think this function needs an extra "bool is_halfprec" or
some equivalent of the fp8_src_start() scale_mask argument
(not quite as simple as just copying that because this one
is signed...)

thanks
-- PMM

