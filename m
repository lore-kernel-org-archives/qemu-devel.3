Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D36CCD18E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ij3-0005Xe-EV; Mon, 13 Oct 2025 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Ij1-0005Wq-BD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:36:31 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iiz-0006PU-GE
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:36:31 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-780fe73e337so46559737b3.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760362587; x=1760967387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sFzIbSNWSlokoLsVJ01E0TJJ/rLPCd+u6AXIbjzCbQA=;
 b=F1026YWdiJyOY+30budCDo8FRzHdmkkMsplUpjEB8T1lX1AWQPjqPXYpwD84nmlg3Q
 0RSavUz8tzwZw/ebADHAfNww4K6uufFotwApOu0mrOW+OVYHsv5Sw2VDbLQGq9H+xpdr
 R6mQpVul/flhG2fyYNXMIILwY+o2JbqcEDSbIla/W6Cz01i3pKTLDN+aOvCxr7K92xlX
 EO1D1sZCOJBFlfvRhMR+ZfhJ2X/5/7L1ldHHUkyr6VXaEAbe5o4ZD7LE+IYtLem+aCzC
 uSM4wUoaSqeQKL5gd1FMgzKxNRa2yLfouY/E6UCvZnbagQ7GhcfP+NwU9y5Qra5+SBYf
 lQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362587; x=1760967387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFzIbSNWSlokoLsVJ01E0TJJ/rLPCd+u6AXIbjzCbQA=;
 b=ha1wdmQm9ifQJguVxCDHipLyk8hezl7xmfgc5PELnDc1O4p8L6+kTs7mLvWAUaPKiI
 pKCRe3COl0DCwOoUgZbF1mJm05PlRe3yi6SSxFLPWTgKnaO0oXURHlkghh3wAqpvPUOu
 YeaAIxohC3DeMGsGND2WLPlR+aPwxG/LE780ppGt49GEZwaOJhA2Ys+uT3ZqQabxnHWK
 BHAsUWlEb4XdP984iU37CcTDmxDDiF4OpnWTexuXocGwlQSenUKL8PEBGfVmJeEvI4fC
 8hP/PrQwatRHqJpH6AiUjbRplG4iHVJjD1E0tSDeUJuvvGDGLgTpySr/gkKRTHDqAALd
 UPJQ==
X-Gm-Message-State: AOJu0Yw8HUe42iCKlpBaIu+yQh2/Nb7D8PnjizCfhhVp/N8K9XJ9dc+1
 4lXlU0OI8PCNc3I57pDQd7gCIJiVLIQ/hahbpFkIU90bcQ210hJwoecE3oUVG31pRSCe+6yxhyM
 uxepUxkfBwThd81Jrnav4Xd2hTMtwg/JIRQTMHso7sw==
X-Gm-Gg: ASbGncte2c1oUftERvrKQfeDscwFNzIhLkkpUdThahxEg0uLYa8g3/UP7Jl0mmue9qF
 GbyXxm0ECDwE9A/NQY9/j72Z6hpSdnB5lzqPb1KG4X/CVaWYXpBECd1M/kfi8rt2Vb3UAuvrkN5
 vVLQXM1AYbKjwhRA9lGNAE7DKp2i7FvVRWCf5PIz0SfQr3csJTkCqUDF3DS3mE1hqtRdT4ydxPI
 +7W60AtIDDW/Wtp5s5HLOFTyygdpMg7+KYZWhrhhybf0nkMEM7p
X-Google-Smtp-Source: AGHT+IGa9KGFD9GkIWACxfuhDx/PeAo3vh7rSF8pBHErx60Ml+nka4BiwT1sChLHUXO0zg9jSZOwE4UkCKGF7dKIJtM=
X-Received: by 2002:a05:690e:158e:10b0:63c:f5a6:f2ee with SMTP id
 956f58d0204a3-63cf5a70b20mr6347293d50.64.1760362587269; Mon, 13 Oct 2025
 06:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-6-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:36:15 +0100
X-Gm-Features: AS18NWDL0G-598jTRuTEmRcvpFsH7N3uXzZdtB6mjxBNZRaIS_UC1oo9aVGswSU
Message-ID: <CAFEAcA_WdDpndTFOADR61Wgc87LVuOcEjn2y8UgNrfHORaUh2Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] target/arm: Use el local indexing mair_el
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 10 Oct 2025 at 21:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We already have regime_el() computed to a local.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 54c45fc9fe..5fcf104272 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2319,7 +2319,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>
>          /* Index into MAIR registers for cache attributes */
>          attrindx = extract32(attrs, 2, 3);
> -        mair = env->cp15.mair_el[regime_el(mmu_idx)];
> +        mair = env->cp15.mair_el[el];
>          result->cacheattrs.is_s2_format = false;
>          result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

