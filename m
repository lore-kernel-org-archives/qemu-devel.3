Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BCCC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3thK-0002UZ-7b; Tue, 08 Sep 2026 07:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3thI-0002UJ-KH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:09:04 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3thG-0002uX-Au
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:09:04 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-86fbd1a23ebso31761677b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865741; cv=none;
 d=google.com; s=arc-20260327;
 b=orsyKnrg7hHBx+01+FSLbZqu6ceqY9PH8jD/kH0DZl2hhwIMDLQuKEmwIWT0wLa8AQ
 bOBo6G5FJK841BS9a34cCzITwHXNkxrBCVfsMgmYO++fep1p9Mk4qd5ZQp1bT9lzHHFO
 YJozrlWUWucwSURayZJJ/y46SECqdsMQX8U7hz36fzxnfgS8oK7cL0QtHY5kJVtAUX4i
 Cy0EFdiNR2uCPfYIlyJ5G/pxRvPb8LYolP5OCzDa0Y+jhNrOFHdxvlbK5JM/ls8QLN8N
 eBA8JyPw5zfYyhutfXOTWmyviUcWZAC7UmGikKNzfsx1Sv5ot/zQej//2cK/1k2EZ2Qs
 29uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6zzCrh/17UdhMQXqTF+7vnnKKNLQtdkheDiXfndDr5s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=L0fHsXYsB8Nnw+9xgGKtrYZIRK9Pvz3fvgSEpirczyupWX4gvFJJIIzGgiIfvAjBgo
 +si2Oz5o86hjVQuZDjI6tj79haX2ELy+3uqLRxRR8z9b5G6xOVAaSe7OhAgLEYAzmh54
 +pzej8APJrcXbAPpKr0bdNIGMmpBMc+7x2aRZkVch9pIh1+OaDQB3EW5ltqOLrACli0d
 q8+p2Z5kQcHXpY+i4/XOUp/7WEe4G0sIqimIyXBleuMKHpDACL9tkymyUmj0jznK3kn1
 WotYLbb3el1jDE+b+R8Ro/hjEQkgRG7SWMdLcASEsNlJx1/aqPP1QCu8eilIAZcvwveq
 1MgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788865741; x=1789470541; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zzCrh/17UdhMQXqTF+7vnnKKNLQtdkheDiXfndDr5s=;
 b=ZOPl+49+574jpvu6qX7VsZAnz3ybpqJMllg5kcfzjX0ptNlbm/hz+uwRk6iD1yyG6y
 jK7y68oAmOzhgNiN/agGLnrSH92De5tirdECzyT7l7AwWmJsqBgmt8U1XLrhb/YcaXwD
 S/hOXllcGltwxZa4oq4yeG00/Oe7rPkF1FMN1ktRVXRcq9HKLzlpVzPs1pzbW7mA0YUq
 MHu+2GTMSIbSlUzrQUE3XEmpIXkXGghm3IZ3hNMLhFd+zM31M9kYxljHjZbTzhxhoy7N
 SVoSz43rIXBYllbpdy74Yh4Y0YPr/ze+4vAt0ApJBpO8MwmuGKTHvKrgj2j0ImrGf4Ky
 3uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788865741; x=1789470541;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6zzCrh/17UdhMQXqTF+7vnnKKNLQtdkheDiXfndDr5s=;
 b=hNCwT1mtH6ifqK7pX/CVgyn7+XN+wHwQ6RVVR3nP7n4mi8v2zOBbuohfoAQtMyr5Py
 OMM1PWkki0LD30sOPqH/jzxHwR60NHZ7iDjOz0pueB5Kq6YWG+hsJsoZOCMP/ZZT2JyJ
 ZGDpGw0xVVHwqQIo9R7BTqGwhgcUYInLa/TRkxeh7PCB6h0sSCpmoTEA3QbcsVyNNTav
 E8F7MWv1JdFOzYFMDVshuKf/1D3iL8V7JTNi3EQIe99D8PPo8CaE5NnHhjk63QOxT0Md
 6qtdYRjN1nkV/V7xZVAK6UCCu+eCRLqCkDAqSnnVownJrry+Bz3mMszKmbbM1Yio0noi
 5lBQ==
X-Gm-Message-State: AFuF++nRW3DDWGddVn/wP9hGHgoGuXqg4OSkNSY0LVEgZTB318bXrG+h
 RzT3bq1aIP0o1+cX9g17lovv/rDxZptgCQsfKZ5vHH1nihDypYieW9fxcqWD2u45AWtNRuat9qY
 NjwG0LCo/pFQz9l/rc/mQMIR0asmkOKkaVtqFVK2fPA==
X-Gm-Gg: AYBFou1eo+60TRK3CryHt/bCvgrjDkM7zfruPkwBlT7TZiil2Bx2gf7Jd4psZuZfCua
 GvH2uOCR5evfqKVkam9AZTeQV+ieG7YZF8uM1d3+9ZemUkHIPdz+GlEJWTqiXKLfnwpkqcPSNHJ
 zCLDJHQUL1w61Mt1gj5basBJ6jU1Bko5ydqeLKi1oPp4VNv7cDAgnT7ewmZppxQtQ6nqf07eDfB
 BHDclQZiZLpzMzopGVPA97JVs5aKFH6AzfmgFw6RBZJTUe0d1GF/3ULAFh09otDUUK4N/ZlMZra
 kywH0QP5jWW0WxBOrhn+SJWFylrO7VWkZlPlZsgJm8EJCm8kVcJQMujnSnSfsEVfMnpLokaiU+k
 FrSxLAKSa7+8uyF/W0TS9XSgqUjeF
X-Received: by 2002:a05:690c:399:b0:81f:4247:de16 with SMTP id
 00721157ae682-87129c559e4mr107216377b3.24.1788865740807; Tue, 08 Sep 2026
 04:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-12-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 12:08:48 +0100
X-Gm-Features: AcwNN1WdHHOKYVXi-9jlIdFsbzcihkz2yn1WGA090iQPLDFL5Nwo7ZMSzO2VLXU
Message-ID: <CAFEAcA-9BWhLf2AagEcnacxMYKPYGKC=iKKoGRvPg4BW0PtbaA@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/arm: Add PSTATE.UINJ to tbflags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 28 Aug 2026 at 23:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 296ec8101ab..174f4aa746f 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -292,6 +292,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
>      if (env->uncached_cpsr & CPSR_IL) {
>          DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
>      }
> +    if (env->pstate & PSTATE_UINJ) {
> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
> +    }
>
>      /*
>       * The SME exception we are testing for is raised via
> @@ -513,6 +516,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>      if (env->pstate & PSTATE_IL) {
>          DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
>      }
> +    if (env->pstate & PSTATE_UINJ) {
> +        DP_TBFLAG_ANY(flags, PSTATE__UINJ, 1);
> +    }
>
>      if (arm_fgt_active(env, el)) {
>          DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);

Could we do this just once in rebuild_hflags_common() rather than
duplicating it in _a32 and _a64 ?


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

