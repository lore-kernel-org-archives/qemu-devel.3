Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CCBC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ2z-0000cF-3k; Thu, 03 Jul 2025 08:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ2x-0000bl-Cf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:28:11 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ2v-0005Hq-O0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:28:11 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8986a25cbfso1425605276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545688; x=1752150488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xf3Tb5TfkpORZ0xl0voMW56/SAE8ScUjNkVmtD5Id0w=;
 b=KM+EIAOb4qEwoc2WcGOI4wdTkLVBB1d0BHLEQ1cCvxoGem12fxN4kHvJyty7CNbA+f
 XFjMpTgHdcgdCECtUN0ao9rco5+hcmkBOawHcwYnPeS5zBgy7bdvdL7xcsaQH7d8agSX
 sAGOhDAVLGEX4mPJg3wm3oZQ8kNQ0gPvV1tB0MoOpe97m6YrAKksyaPm6S9Wo/Pg64br
 sl3TMxkuMpK/VKmE5JUJm4K7mBeil3YdGtoIzritLGYjWIbjqRPTeXKUMlSmdUrlZjMu
 Kaz7ZjFy7h3pA+MjV45A4YD/tW6wHr6CxM+3eN50lBIfTWHhK7ZX3Gs1nd6IUWH8tHLw
 T1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545688; x=1752150488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xf3Tb5TfkpORZ0xl0voMW56/SAE8ScUjNkVmtD5Id0w=;
 b=LZS1Vq4GCIj9i38D0yBP8p85SvVPy1XKiCQyl0QbWmp7VPtuN8yeuP40GWMWnh0zWN
 pGBfUQ++9g43mhe1H823daCBMWP1mNXsxJOH56GwdCIKY5+qxBdLnm0RzyYl74/1QL2M
 C9rRg5iH7gx/0zw3La/Ok8cz0g0iKjl86MpYKDaqX0TXINIkCR7XuzIVO4+U2hYsEEL5
 eTupGKFZJbfntr1H88YqaFiB+luUztoZ+TEEDDgtD3RmUEP0Ok3kgQGO/qxQcJPi/khd
 MbyRiZDhFAf6iN7yI+ulkXOWhfEPf2TmtIcvwxL0OS+ahBcMP0WqqL+QQVZNxaMm1Ych
 I7og==
X-Gm-Message-State: AOJu0YzKdhMDEjiciPrjcXRxryKmhx5lR8JHsAzQcGP+FVCjEYOz3zpQ
 UvsmR06IK+ZPOpEipqts9DuqupNopeLLV1rtH3isY9eZwEMQ/LLykPoFQK6Lsw+6Vx1USmZdrxh
 3ciKyPxPe7PnS4IaqGxgIyYtMuTKEqsd49xZTpCKKIPGlvA59gByc
X-Gm-Gg: ASbGncuFcrBIq0o4/NG5VLSv8cxSH/TtI/nP02VlNNP8O2HHRlGnVPmLGvZxklTPAJS
 cisbVYTLiuSnMAuNrN/hwM6hyPkAXPBLP2sE1uMcDxVnbU//5EvaT5QF4T1GNEBWvMbAiKANxi0
 5qvuGnAWpjnvMXxLT6nf60kWhM7DXoReC1mtINRMLOY559
X-Google-Smtp-Source: AGHT+IHjba+zsVplbVYo04JDjxoqKYWhPOMHAeskb+WpF3hmrNwb7c8yFmNonUOYiJ9aKT3GeVKB+RZoh+BraEZG9Y8=
X-Received: by 2002:a05:690c:48c6:b0:70c:a5c2:ceed with SMTP id
 00721157ae682-716590e59ccmr47950257b3.25.1751545688227; Thu, 03 Jul 2025
 05:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-79-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-79-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:27:56 +0100
X-Gm-Features: Ac12FXyi-oorqMr2HfohgtPrRDfgaH4BBhlRKFot0r5nJ22PJe6X7ThkO1MJE-I
Message-ID: <CAFEAcA8xjSMXYkhUWwf0fQo=r=4frifLbpi4dpsyR+MMnNMz1w@mail.gmail.com>
Subject: Re: [PATCH v3 78/97] target/arm: Implement EXTQ for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  2 ++
>  2 files changed, 51 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

