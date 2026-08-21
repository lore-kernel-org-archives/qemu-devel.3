Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4877C5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQhR-0008Ta-4P; Fri, 21 Aug 2026 10:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxQhP-0008Sz-RF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:58:27 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxQhN-0006cc-Er
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:58:27 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66b35d2c4edso1464458d50.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787324304; cv=none;
 d=google.com; s=arc-20260327;
 b=AZMIcNFhbGOt/zM6OsON4RFdtfklM6imZq37BEkJX1inQRLbE/Tf/4kfYMHVJS48Oy
 jqxh8E3oDGXyoVFcMO4GQHRpcvqUJMf+tYgkTbspt4YDcxnnA1wuNEcv5ifJm6epfMr0
 X0EUAulYyv4FngEtHUA14vnITVt+BKsVjDEPqysUegjf7LRg9S+QOL2EcrTqm7bkSjmC
 S4E0Dvigh0lZ1SSnsNmeZnzF6fRbszkh/TE/EbZLQ2SVG5wAcnjhZeTMoxXnO9Lv40vK
 QH5/pb+DT5Bp4LU2ImTRl0QVifpOThEoYvNYWzu66C87sAz1jVnK0W9fWSVQhxb++ZpP
 8iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z79hWShm9VccnWd+uC/1NaHgQD4YoYjiNLaCCez5k6M=;
 fh=ajr7ykT2HetDNr+bKPx1xkoEZLAYcluUxURTvLl+9Zo=;
 b=hcQEbAk9Zh8y0l5O4SzTiNKPxhpBsucaDARDkO7VXPiLqz0SJ5Afh0PoYcIG4jJDRX
 1N3SorjCRIczLtYGeA6xnu3ekv8ZHTNju9QQX5YMxkB4W7tA2/sZUUpOaFQol9NkWfbL
 lFhT0/8YMXWWdjnYxpBWIWoNB1AJDSBWFcfXinjUWdJ879ix3Nn4rs3EFdIVWZnKkRmZ
 FmPJ4Vqp+W+sqi7DFrZJ9IpN2UV1sNFUIYesz1xGKOj5D/P2Nai69Q0p3Xy5Nv/bJ2Rp
 Z8sptgNSGFfyFCMTB74Wjd1+iLCaSPboShi+dlVAJhQkrI68DxxPsJF7TCi74sEkJx11
 1LAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787324304; x=1787929104; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z79hWShm9VccnWd+uC/1NaHgQD4YoYjiNLaCCez5k6M=;
 b=fMR7i4OLZGlXD5MnfKQzu4CmH0K1JJvdMUihGZGk8UzHwF7sKvfplE/yXG9mQJRDtQ
 04eWSBKsyjul8roCMMfeMkKkynZoIp9g6YvKjza/jVENiyDHq8W5SLKm6Y3yHOv5/PpQ
 R+AJIegRQ7wjtF27S5mVDC4pjlvVMAOV7i/KaEAboq69RlATtYfOJaXH6zLO4B+EO4xr
 AnzPmw8Ux9SofCq0w+JW2nQNhkUYFKIV47WfK2jKLi5Y+C9DLb0n4dJ4NR8FeZZTJxQU
 R7+LrSJHg3fytjA3sCcStSV7F/CjnMSJDJP0CfeThuvyIyGz/UFD19s2ifWLxuLR1oms
 8fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787324304; x=1787929104;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z79hWShm9VccnWd+uC/1NaHgQD4YoYjiNLaCCez5k6M=;
 b=DzAZecJ+F5ZApiZhB3U9icqqN2WoHrpOHbeJIrSZ7xkKSQlaPsZAYLtKcfzvW2SXxi
 hdsilO3IWgt7Pm7XX7eFhUDIbCoe7lsYIa1emTkXXaTm0lQVBcZcb/vQu36ge60KcSue
 +bqTR04WT88qEDhYnEgFE/L0RhP95/ZqoGQYAYqOx4G95OwuL19fXEOCllOfksEiUfE3
 tiY4mi8bHaU7870kz1FmkfuM4l09mqdlmlKez3D7UxHZf4bNarKwULa2yw5/nXFHFNac
 BOkGDMSlzqUYliqgUB9Bbvq/Z8ePdgQWTSmIpDpuGPXPYpd2+j8E2Fnmdtz1rOAVsBWa
 pseg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsE7iweVyfKhbwBrAYg0sTEDQpO1IAZbgKK4URSzX0pph1SahfoN2fNfRoJL5sMXDNti9BzmKJxqAo@nongnu.org
X-Gm-Message-State: AFuF++l/A70MGubeuLdU/KznUKsAm1yB7J4ghxHlu5bZlc979zyb+jOY
 FyfbhTCHOfDz+CL8nXW2UEii35bWGYJNfoxbOgrdYtVhx+zMtZXzODen1VVobGB8xInyuTV5J8h
 Jik+cg3OxinDACxsDLlv4jgl4g+fubvn0nMtOcfavfrI0mfXJ+gjOgjM=
X-Gm-Gg: AR+sD10lrZrQjAOtVfT48Pf6Ef7anTfAd+un4d659gji6Xm05JMlpuo5ktF/LxO2UQP
 yB1EeMjtgyOieRqvIXFr3loDiqmzzqgno4lq0oVnLuzgYRAHWkvfft1aqxRwPVUNewoUjpuINh5
 im6IgQ22F8rm6EDiWrfVyJoig3gqDwRLlOo7zDpQIJtIvkx7DdjMNMQNB5qM/S5974NEaFBOdRA
 wcg9AcwrXbKfjrfiKai3393rQcghnAUT7qwph1Q1bgMkZL4zWNy2V6HSy/iMVntjiGbeSzpUaDD
 /UNHpu8sdB4T3hDyIE2gq2RPTXZQccdnDVHzSXlnK+kXt9r1V/5VEo25kx/QwSgTkmgFZnVNp+6
 fVA/lkzU7kejUzf3HBOFJ4Mzt196P
X-Received: by 2002:a05:690e:4814:b0:667:aa5c:d2d1 with SMTP id
 956f58d0204a3-66ce4bab296mr2101378d50.38.1787324303582; Fri, 21 Aug 2026
 07:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260821132550.168896-1-peter.maydell@linaro.org>
 <20260821132550.168896-3-peter.maydell@linaro.org>
 <0a7ca30b-e623-48dd-8db9-c53c76f9407e@linaro.org>
In-Reply-To: <0a7ca30b-e623-48dd-8db9-c53c76f9407e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 15:58:11 +0100
X-Gm-Features: AcwNN1Uq3s4_dG3mePj7BLzqAanyFDzLKm0umz8IhT3SI8uDS-STqAo38Duse3g
Message-ID: <CAFEAcA_UKRZQFiuJV0bq9BhLCPXbVVsKEmCiO1egdmrRgBe9mg@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/arm: Make IT insn undef when not present
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Fri, 21 Aug 2026 at 15:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/21/26 06:25, Peter Maydell wrote:
> > The IT insn is introduced for A-profile starting in v6T2; for
> > M-profile it is present when the Main Extension is implemented (which
> > includes v7M and excludes v6M).  We were missing the feature-check,
> > so fail to UNDEF on earlier cores.
> >
> > Add the missing check.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 9ee6e8bb853bde ("ARMv7 support.")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/tcg/translate.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> > index df98dc2e34d..103e2fe7c73 100644
> > --- a/target/arm/tcg/translate.c
> > +++ b/target/arm/tcg/translate.c
> > @@ -6038,6 +6038,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
> >   {
> >       int cond_mask = a->cond_mask;
> >
> > +    /*
> > +     * IT insn introduced in v6T2 for A-profile; it is only present
> > +     * on M-profile if the Main Extension is implemented.
> > +     */
> > +    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2) ||
> > +        (arm_dc_feature(s, ARM_FEATURE_M) &&
> > +         !arm_dc_feature(s, ARM_FEATURE_M_MAIN))) {
> > +        return false;
> > +    }
> In practice this is going to be the same as just thumb2, because v7M has v7 which implies
> thumb2, and all v7M have m_main.

v8M without the main extension exists, though we don't model any
of those CPUs at the moment. That will have ARM_FEATURE_THUMB2
(because FEATURE_V8 implies FEATURE_V7 and FEATURE_V7 implies
FEATURE_THUMB2).

> Is it clearer as
>
>         !(arm_dc_feature(s, ARM_FEATURE_M)
>            ? arm_dc_feature(s, ARM_FEATURE_M_MAIN)
>            : arm_dc_feature(s, ARM_FEATURE_THUMB2))
>
> ?

Yeah, I think so. (I actually wrote it first with nested if()s
roughly like that.)

-- PMM

