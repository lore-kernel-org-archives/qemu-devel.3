Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ66a-0003ve-MU; Thu, 21 May 2026 12:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ66Z-0003vF-7t
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:18:39 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ66W-00039k-Ub
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:18:39 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65e170f1ca5so6626192d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779380315; cv=none;
 d=google.com; s=arc-20240605;
 b=TLheCx0e3rZr51S8d9hT7Af4oCwdo5WdASQbxa8/lhHBPt7vq7VED+JLlomgB+MlbF
 K4XXOOhTzVouDa4lKNV0GSCoZT2S9wSSVX8QcLJrhQvEs5d2BuhSNRkTAonassV59lh1
 F6UTLfRPCjUkKNx55uqj9VlbnlhJXBZdK1f6MH+uG8Nmoc3Rt0Llw4cRbyAr7V6mNTNe
 p8z64vlRuLKzj+C9BRLoMJ9XH3X205aLBMP+JR9uu3PGg4eIGNkxYGGYeuxS2SuLW1lj
 s27JGKgH0a5qt5fYD+YJn1h5yf/iM0TUvbpRY54nMctPKMlBcd7ynbKgtOo+OLxaJI0F
 ZAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tMI/evBTMShzs84jPFqhsyqVZe2nlZMQeCzSVZ3bSC0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=RtVhxn5gk3msvpUMcS5NBkrvcSJWMXHWiwhFqAnP4lTP+YBMvOS6dA7SsjOpuhOpne
 8dIZ4Iz4q2ApqmRouRJQ4wfYf4uCr+fWqoisRyAvcFBdsuO5LkGv2cfgqfLReKJzb/Sc
 wc3GvDjkreZoSENA62DQDSBM5Ufp9DhwhvIOm6QYoziYwAHJFzts4ur49aEM67UXrEN9
 ECpi1yW+ZdBTObhzYh3+9AaUoFXg4iCXGh1YCZS0yiz3c9WNZhzqm4WyzbfnTHSXwHmp
 WF/gz42PaWsEHIWDSgug92Dd+UhL8z5/Wu3omcc4QciN/ENOqFoMGqljUmaDMnkvkvMR
 sVsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779380315; x=1779985115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMI/evBTMShzs84jPFqhsyqVZe2nlZMQeCzSVZ3bSC0=;
 b=MV8xjHINOwS0nh54+M6+znOKe5ObOmF9ehZ39VbE/1F6+bfOT8D0TL1+/vIzqea0Wj
 sTSNwEExX8dXgmcj4AodzOQEvUjYGreVaoRGU+EalQ9Vg+WhKRfzUc6eVfQaIEx9nqbp
 pc2lZJR4lnN7KSzA4bLhxaRrZeE3wBRo2/T9v9eljI33+/h0Fh3+7SKIMcuYxi7tf5j0
 EgllwnnGSBBJr7esRymctjJDe9xDBK5TBpUK8/jJvTTkEbYjnz6tpCepuZe7RjUDaWWO
 266lRE4iqD9NPkq3D6cBom3Q9Q53aqIFiAQnBojjJZ/4MyZhKygDtVjh5vIxL6TPTS2H
 H+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779380315; x=1779985115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMI/evBTMShzs84jPFqhsyqVZe2nlZMQeCzSVZ3bSC0=;
 b=OUmhkxRmyVXIg3oupYsm7EC1pDNYzm4GUHD8T4jRQGOMBoL67NJVLr2JBQrWRwcVcx
 6KWmq1zOArloI8AmtUfUlWf3tkPNu6FnmPN0l6AbJ+1x4K5KpalUeylWylHbBrVEC0Jt
 44/pxWGqloNg8FXNE6gZGRi0LSzkySPPAlvlmPcOjfUrt9FOmaHQpkof8cAJbszESMUw
 n3Qd6qI8uvF67OzhqNopmI4/slLfG97sEJ/wHsgi5g1WK+iBjPm9FRwZcmKynAbbPpRt
 BjJuaR5Izi5HuJfgxSaMfk6pGrENeETqvanX0rCpvXtDPMj8R798onKmLUzhj1XSgh8o
 tpTw==
X-Gm-Message-State: AOJu0YzwaQKEAcS1aWu2/zPNJqSnFnLMFzzClVluFkEyAdG+Oy/RIN6g
 cxWL7h/BnS9y4xPfo5GoAiZ2RR+8d6PWNSPNNWZN6byTcstsMUNkNQgzXbanCpXyiilADCb2sEz
 97sqCJXRs24VyCb2FlZWrDtvCxm8ymKl4ueaLPJd2FVgxvHqgDfcN
X-Gm-Gg: Acq92OHP8t7FeWutoQiHw4KWJgF69oCyAtGS9HEAGK49loNlThf3aHkv/K2xI4dHVo/
 rFLfWXRCaQV5hAjF5Q4e5bgTkN5qfGvFVaCC26brLrwoaZKGCDVzDrdiBxlYF1MBpcXX24Ah+tb
 71XQSX3a59Cbh/pvYVeiXsPTuLsKuxMTQ/yr46PLu56oDPXTliLvdCVK13ip8rbkqkmzHdO++wK
 APXPodkFjb06Ra94NrN0nq90bbXrGhaYACSjLak4Mo5XJGEI7+5atyFcjb4Gnj0pGLhnTTLoEHE
 YEpgJar+0mPOvu2bJ/O90YE1w+qbe8yMVDgULhjKBchEK5PQ2BIiZqyo5Y2p3uRYGj4mYDG8OTj
 NJg==
X-Received: by 2002:a05:690e:4393:b0:651:b477:71cf with SMTP id
 956f58d0204a3-65eae2ee64bmr2115463d50.31.1779380315400; Thu, 21 May 2026
 09:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-25-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 17:18:23 +0100
X-Gm-Features: AVHnY4IvPWaA1dov9w5mABJ56fZrMJUU-2ef5ftWke2t99YwRo-t9MouQfapaW0
Message-ID: <CAFEAcA8TiBX2Ej8TqBkvoivDo2_QdM7G5VAAoSr73Yw=CGRKqg@mail.gmail.com>
Subject: Re: [PATCH v6 24/64] target/arm: Implement BF1CVTL, BF1CVTL2,
 BF2CVTL, BF2CVTL2 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 20 May 2026 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-fp8.h          |  14 ++++
>  target/arm/tcg/helper-fp8-defs.h |   6 ++
>  target/arm/tcg/translate-a64.h   |   1 +
>  target/arm/tcg/fp8_helper.c      | 124 +++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  34 +++++++++
>  target/arm/tcg/a64.decode        |   3 +
>  target/arm/tcg/meson.build       |   1 +
>  7 files changed, 183 insertions(+)
>  create mode 100644 target/arm/helper-fp8.h
>  create mode 100644 target/arm/tcg/helper-fp8-defs.h
>  create mode 100644 target/arm/tcg/fp8_helper.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

