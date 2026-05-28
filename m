Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF551CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXPb-0005WC-Ua; Thu, 28 May 2026 05:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXPX-0005RB-Fa
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:52:19 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXPU-0004K9-9p
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:52:19 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7bdec52f48dso117747297b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779961934; cv=none;
 d=google.com; s=arc-20240605;
 b=Qfsxgat6yODPqp0FufwmqN4I2mEcf9odT7Gqhkop9vGP+FXEpA9vI/7zneBOlgguiG
 o+zmb59iQsOtldqnxglgQDNBl4qDeORJqgqpgfgruSVRL9oMY9u1/bTzFFblVXh9L70p
 BY0PJpZs2gq90gMWGM/g0+3XGpofa0ffiMIXzIUWU4XEp8lztDh8jfDxpLVL4b0H0XJm
 ifJZvA6iJ8zdvMWGWyM1NKK0+CJXxaiFRyrpQGgPbGVZ2P3/U6t06SpfSVBnOukObHZX
 cpmJZLZFDERJTYVEDyM5goDBskVz6IJWUnmwIIvZOqCRwD2touZ+PX6/OljaZTtx4c+Q
 Kopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yVnX1CvyMgiLMXnC6mLBbF00QNioMAzNA307LYuJ1Lo=;
 fh=KZ4/kZneNwvwAQV2kkV2LzI/aRIn+Syl/sitJqMG6Sw=;
 b=bQP73TFbzSSgfF9qPqImbRi+r2G84/JLPdCbWZ/8at7ml9Xy3+P81Q/UlHgp3IZr0q
 M5m5oOwJNI2v2P9sL3kao75qebZT52be5CWSU0oEoUrXLteFWzyUySXWSHEFrMsAXNxb
 k0pCVjdXI6NkIdUKf54iQKDmmEEqg7Kf71UcIq+fIo5o3qZ6aJB9Kvi2I1ATIPyu3bqB
 NtfKFQfj9mXS2PBEYvzm5i6O4RHDpRpsEDBdnq8IuOg3uoVbuQILZWXIXFQEDMqqJKnu
 7TyzaXnK74Sg48+OhVNT+w5bEc4o5gFixKVYz2qFW2et+5jGDMZIzqh4L9clRiNWpM3a
 ArOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779961934; x=1780566734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yVnX1CvyMgiLMXnC6mLBbF00QNioMAzNA307LYuJ1Lo=;
 b=GNIC+Yxkk4oCrgNPIftB8+tPHhO8MUDNDpLV80l4/m7uL0Bq2BYxtVzL2nxq1OxSVs
 JdpNIYUZylFZbbi2OVu7AB6MEzfnViEL2mqy11yvk3IpporiGvRua0ElBU1SpNyJOBK2
 GeH6q5lm58JoNoMwy3ecXrCR5fxXmM67lJbrDIbX07lUr8kujHIPvFwfvtnDoEaBNhB7
 TbQtY7uhyceT7Sqw9AEV0afMk6pJ+m2KvEDhEC5qMRqNrWdlDYbZ2FebXeIKgnPEQc5N
 o0vG9/OG/XMtVzoPFv8K3SxKIaQPd3ZuC0om5qf0OWnMpTyxD3V7GiXIngmGPdIZfoZ/
 Vf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779961934; x=1780566734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVnX1CvyMgiLMXnC6mLBbF00QNioMAzNA307LYuJ1Lo=;
 b=grn9bUgk43S1JDKsZhh3NPOdRs7yNN5mmXkaBxFZUbpFRfDX5e31Z8RupS5uYj/RC3
 4Ms5Aqa/9DZ5P4l0OQBaCsYy7iisDz5rvoRGwkaX5Dq+4xOOvL7MUSiSTzYRBX5g+n66
 KxWyJdUZFAHhUAeAWaFgvITLWSQQeh6vqas0mSmLQ5z8bTgCmLrOR9Q42dN8BWl19KGD
 fHpPsQKdOXS5yIpL6UNeF5cjyErU+pJXX1X+vu0agNw3XeTipg1Vb8sErc/qTNzRZ7yo
 BGzzRNy9QAlCwP4g2Dri3fsQuEI7/fldwpsvocKRliJJHPHgNCluWOwzRSIHMbgDWWQ6
 ilDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d0mDERCixgJcNJ2Fo0hPSU6JI98gKBLVOmRcjt5VpeSi+5JvdU6K3OlVMki/xXr7CDfybGaVXRVHA@nongnu.org
X-Gm-Message-State: AOJu0Yy4jrItQ6BhoOdkoxIjggZCNKJZscIUHqWvK++6tD+UKa1yeVNa
 dhdu3NA7Z7h57+AYma1HuIc8PQJ1RxbooCydnRlKXAEucapOH954MntVdaZHNTKXVce4YtuWE+Y
 m0iS0scAbV8P6WqeWoO48BLp4tjQ9qnraU7Tk+ybOVQ==
X-Gm-Gg: Acq92OGj5CFmJia0TsW2bhRcaccEENzjHSOurA426ECNCsNGySeXLp+2wWBbkQcfkg4
 A/5xaTa47wZtlRjOAmpdNq8zmqmiz47sj9mLdPMhuosojquQ25hawH8/uqx35/o/2jduUcyHmAC
 OFMwOBbImkp0Fx6ycpdqzdJuzu8VSAIHPDHUygOcmAoWgus2uyV2St0QMG7MT6ADHKcIti9WWMY
 H8x7LjNDye5Z1FH5FstapQNOhDhK+SUmo1JyWP/g0yyZqgzghQ+biHAnMtyGnfoT+DNZdz0ylXr
 klhfLnCjY87704idRM0PYLA5jS/hgY+PuSUU2L0eyu5J7dVGI+wW0CEynQflaGQlnIkAggJ4Yps
 bqA==
X-Received: by 2002:a05:690e:419a:b0:660:329a:38d4 with SMTP id
 956f58d0204a3-66044a12dbbmr402048d50.10.1779961934120; Thu, 28 May 2026
 02:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260524002617.69593-3-wrigjl@proton.me>
In-Reply-To: <20260524002617.69593-3-wrigjl@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 10:52:01 +0100
X-Gm-Features: AVHnY4LFyxZW4UjOWOgre3DES04JrDW6CnCoLpc7D0IBED3yVD48t5h5yNymrLE
Message-ID: <CAFEAcA9qc-uLROo7K=fMbRn0mKUrC2GQgi6_SiJhMmUAqPSs-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/arm: advertise FEAT_RNG_TRAP on cortex-max
To: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 24 May 2026 at 01:26, Jason Wright <wrigjl@proton.me> wrote:
>
> Set ID_AA64PFR1.RNDR_TRAP=1 on the max CPU model so guests and
> firmware detect FEAT_RNG_TRAP, per the Arm Architecture Reference
> Manual for A-profile architecture (DDI 0487).
>
> Signed-off-by: Jason Wright <wrigjl@proton.me>
> ---
>  target/arm/tcg/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 649d854a65..8caa06ecb7 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1291,6 +1291,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
>      t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
>      t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
> +    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */

I think we try to keep these sorted in the order of the fields
in the ID register: RNDR_TRAP comes after SME and before
CSV2_FRAC.

>      SET_IDREG(isar, ID_AA64PFR1, t);
>
>      t = GET_IDREG(isar, ID_AA64MMFR0);

We also need to document that we now support emulation of this
feature, by adding a line to docs/system/arm/emulation.rst:

- FEAT_RNG_TRAP (Trapping support for RNDR/RNDRRS)

thanks
-- PMM

