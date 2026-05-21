Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA9FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4By-0006B3-EP; Thu, 21 May 2026 10:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Bl-000687-GV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:16:01 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4Bj-0007lW-Uo
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:15:53 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so6257197d50.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372950; cv=none;
 d=google.com; s=arc-20240605;
 b=hVrynW9+dvGMQXiJfC06QJ7qhBtBIjwsjyfxJQ1OVUPmQYZsMaP2zY3PagwEfaZPXU
 KTatcNG/kenymSOvFoZ/Vmaoimn9a6iIDquZBs930y/spRwEG6fn1ITruZx9OUYJxxFI
 rZS+5ROX1Y7y/UmtkGuCcr0Q5jtWIdo2XGhg9CrsY/66Uv+iri8ghhDKqjsp+PTeRxdI
 E50KlbbMn2AuyGIfffnQWj+s8z8UcHPhwTWg4sPfiRpXtmo5QndcGNTZVwrgQAJ7uf/p
 PB2R99m440j+ZEELIBiqYJ6rSUR4gBsAiq3lJBsmtzwye+Yfib5GWKqqZvYgx1QhajFB
 SaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i3SZX9b3XBKzh8GrCno8uBWd6Z6M7n+j+/60T4uS5pk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q6/KuylYM8/pkIFkL9tY0YGylXGwh2hXj4M4/uSqWYfaxOt8LET2AZkgxU5oJQ8huz
 zJSis3WIyaR1CuKmstPkLfgNy/pih4F6KYmQcfSxtZQTm0VtuDd2qfGHbdbTayCJeOIB
 WJhXptS/aqwIZHZaNWhx9a7n3ECdSfMMjquyjFBCVyby40vkTsBo11ljIBpgPJQpWv4v
 AamwFZdhBRerwO+Ik4oLvYJIpzXJLEuqI6letIXsrtDdV5JsrhHz0WA/asUP6hzO3uHs
 UJfc8xxWWZc/TD6NQzM+WahFBHQeRgB00s3Y5Z4OTgp00vbMgjGaCooaiWznOEhKsaiy
 n/nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372950; x=1779977750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i3SZX9b3XBKzh8GrCno8uBWd6Z6M7n+j+/60T4uS5pk=;
 b=OtGS2a9EObGoKz7b27NXgRZAsMP1AaR93lPm5h29snadveXTZI9oT5HdMzOixdHMPC
 GRpGfZTtri+c2TJJm6cRTY7DSTb45YLG3ci50EUxQ4UKITswuefA0ciqA6HDTGShDsA2
 Vavf2sDFPfZ2TppPQ2po4Eca28Hh/SQSflPel8Ttz6gRkt5MpngBdASuxw4Y1UbnagGX
 Tr+bIuEpwJAAxM789bqT6hAxAqIvFvO/9naUvpoUfEpBWnumQg/hGBde1ytotu6UQURM
 ZLr1XOouxy8wLQLqIeMqy6xqPkLl5vAtqtuwGrTCAvWAbrEqHEkDkZr/lDTg7jKeG+t+
 kWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372950; x=1779977750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3SZX9b3XBKzh8GrCno8uBWd6Z6M7n+j+/60T4uS5pk=;
 b=TCnLV3/SrpUbZM5s12WExJZikYOChcMQz5DNgLa3SelECEZbyl3xRqQE3xx7pag+XU
 XNK3QDn56OVOeMEuP/q5EnKV/qBvBCLw021Z+rdy6It8aviuuIKCwc/YDdis71K+QPVX
 FFT9phdilSuybkHZegGhrnD8OJKUozyJRDfjleq2cM31SzYDVn0kfZz4rCFfVjRsHfRa
 +loBWgurjs82CFCWRANtWhXFB2c94KJi3GX9yQkSiUDbC06ojoPVjqE/jNKiWvWUyxtW
 ISJzF0OuRjfqVOsnZtESUowN9BcKttJ4HilHenxtLrQ9poGAs4GcceUd2ak+pe57+Fv/
 AyGQ==
X-Gm-Message-State: AOJu0YyGVE3L2s5Q4oQMfD7XZrD8NbG7D0oSSUgte8yVbwRIyyC2ilsF
 lXc/B6otEWjWn6ThZ24w+BRcc1eTOgygu69HPY6BWhkn/DLeVyQKwte1Pm6KZlokA3N+Fp3E8rm
 deyoghEFmEjLGjG4YJRAKNCBtOkmHYPwX6yfY9UGCMQ==
X-Gm-Gg: Acq92OFsifqSIL8cjFvM4MWBr31VnAF8oCxl7O64KOewcDFzAgjeTDHu1aGlSsJmEvf
 EEsh/ZjhobI5WFvDbUzYCiJtJfdBADm1sxRK41QWYFsXYZ/6LoYa6hqhdkzIKmPq33JdjnYPvk/
 +biTW4TGmt6GrmHaHDD8HHomi3bBEzrZZypfz26DVOBkUr1Vpbio18wA6tiQ7RlL1VFrOQpfDTQ
 DtJy9RnhPreF/aflWzmGUF9sFClMaQp56jijyY7oOUyqrwcIrkJbSZo+SfnhYD143HfY/4hOz9M
 iJ0HelG5yvP+n8NsjN0KBiUsZKt6Is3zRirSpHzyungUxpGfmi6HXh50x8JoQfoTCi4=
X-Received: by 2002:a53:acda:0:10b0:651:bc7e:4687 with SMTP id
 956f58d0204a3-65eae1fea17mr1960145d50.42.1779372950484; Thu, 21 May 2026
 07:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-11-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:15:37 +0100
X-Gm-Features: AVHnY4JJIhNEtLHBWSs3DG-Foho0SXBp8_N9_pC3NqZf1GCRUvHdYshyAuGIhDc
Message-ID: <CAFEAcA8ibw4o3R6eJdtupAc8o0Tk2N5iWahDHwbuCdoCLKK5CQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/64] target/arm: Enable EnFPM bits for FEAT_FPMR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 20 May 2026 at 19:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ae1dd42dc4..7eb7031294 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          if (cpu_isar_feature(aa64_mec, cpu)) {
>              valid_mask |= SCR_MECEN;
>          }
> +        if (cpu_isar_feature(aa64_fpmr, cpu)) {
> +            valid_mask |= SCR_ENFPM;
> +        }
>      } else {
>          valid_mask &= ~(SCR_RW | SCR_ST);
>          if (cpu_isar_feature(aa32_ras, cpu)) {
> @@ -3973,6 +3976,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      if (cpu_isar_feature(aa64_gcs, cpu)) {
>          valid_mask |= HCRX_GCSEN;
>      }
> +    if (cpu_isar_feature(aa64_fpmr, cpu)) {
> +        valid_mask |= HCRX_ENFPM;
> +    }
>
>      /* Clear RES0 bits.  */
>      env->cp15.hcrx_el2 = value & valid_mask;
> @@ -4046,6 +4052,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
>          if (cpu_isar_feature(aa64_gcs, cpu)) {
>              hcrx |= HCRX_GCSEN;
>          }
> +        if (cpu_isar_feature(aa64_fpmr, cpu)) {
> +            hcrx |= HCRX_ENFPM;
> +        }
>          return hcrx;
>      }
>      if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
> --
> 2.43.0

I think we also need arm_emulate_firmware_reset() to
set SCR_ENFPM, so we get the "emulating EL3 but starting
guest at EL2" case right.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

