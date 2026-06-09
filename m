Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82924CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsPE-0004zb-Un; Tue, 09 Jun 2026 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsPA-0004zH-Rl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:05:54 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsP3-0008B5-JV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:05:47 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6603d8697d2so5319367d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995944; cv=none;
 d=google.com; s=arc-20240605;
 b=Gw23kuixChwuqHziXOEZDjDnoBujyeFPzzo4RztN8j3Wjanl3PgidZBiZXyhJ9N77U
 8FOS3OWWaUP5unAb6NQMyhaDkb7e5WQ6iDF8uH3oUxqg7tUw3RkXo4J/F9spz+gjONHR
 3l4lvlUsg+jfNlyTynHrcQ+cmbDy5nBhoxLmxG5ZE/81JnJ5Ra0OLhBYCmODSt3kVU6S
 955zRa3MulyKMVbvKensVD96QTsYjHeuNPRwxqGZ9lA9eVkxNoreiWoFTtE3+4GezEQB
 r8MBlqoqYTonmgQQpkZIvSbFjM1KqCThkCtfn2yi9A0efvwQK2+1eT8etTu5dNyIYfom
 Z/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YFV0+Ihly1rYM+mrr47H0WRI3stoCKHq+jZ3ATNwk08=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=BMPkFHlJ3lMZ01upQaT3rlZyeKrVUr3VWe7wT4hldnPsYK0CAqpEUSJzLmTI/o8GBD
 IMkbZ51Ps0OJ2S7EowjypZsIeGEFq13cJhNDNN7JAFDiaod7q7yON8ObxlRo+nuaNuPI
 rKPhY9UtcBW/evqhyV9WyoIhBdQ/1VvmNhAwfAmiJGuRuJKAJ/C7kLCg5CMrlZn+K1mD
 EFKIGYkJ1Gnc+r5Mbp0/m8L8swN4zVoQjIjVf3NkU0aTaElZi/BnjNQv6bs1HNVKT7iO
 ntpuT+pcLYbpboTmUYmarLrtIXE1VOhekF2n2C9WnWOO2FdP58z4Plwflgc0H9Qjj5mC
 oHEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995944; x=1781600744; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YFV0+Ihly1rYM+mrr47H0WRI3stoCKHq+jZ3ATNwk08=;
 b=GFnhwP9eExQJA/dW/w0HaapfuuoGrnsVud6cB3+b0dEdxAuCqjqQ4H/37NDtTa70l6
 pk/nlClGyWnPp3SessxHyVQrfosClLJwppR/ctMloXA1nusRsh3ykBmBhHhp/tvLoB0y
 AfyYPm2tyRtF07z5cNAJzBCUtKrmvXnd7CN/P4VOzxTl+eW2l5y/AIOkPkn21uul0bOh
 tMdg2hR5jNghVBI4wWv30tqLmNGG0+xhzUmbaBUY8fnJao6ltOcPWzOM643tV8gGhEnc
 cNU9iI7DAnHyqOp4kaFe8yytP8O9g4em6P1uUpVhf5WLxJRj7NL2Lu1COVm/jRkcV0ka
 nVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995944; x=1781600744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFV0+Ihly1rYM+mrr47H0WRI3stoCKHq+jZ3ATNwk08=;
 b=nHaL7B0jpZav+r85wi53Xdo1WB5YzzH0+4ZPxOKdF4jjnlXef5V9shno5H6tBXv2ht
 2uCu/xoVGyr2gkQhEK+opbm0p5oan2ugOI0+Ndq4JZQmi3nLn1w/g9JgTyvXgeKLrsey
 vnai04V84Hozc+SJ0Wn//gX7JHBiMtuLpCnoDYwLmNOnzgqChaFGEc9ezlFTi8Vx/YKq
 vmlBoF9XufzA82yJSBDuH/NcI2LNpmqNg+n/+itBFtkC3iIPODrUuajkQVvcqdjsAuHY
 X3pe4lgPxiIx6fzc7ybTVgfojkwWqtVtMk0S6fv7Q3N1a7D/pBuvoquKAK7bVTWO/Bse
 VeJg==
X-Gm-Message-State: AOJu0Yw595B+amvPQQl5zFWeGTu0zLjEnojnHXbiPhSrZeDHUQuyLTwi
 aLRRsXKHzK56/ReqaF6Ch6uSAddJgOitpuu9GrB+aeQOLIBsijsRfGDxBnLAtgZXlmsbQc1Nxqk
 B9yQ8ED0xBRPYT+m/xKLfMrUbWHLLorco5WxOsiNRfA==
X-Gm-Gg: Acq92OHaCV0oV0PrP7+45q9bijHGSIVaECpqP3W29hIbT9Edt/fg7ufA8Y8jBv0HhQx
 av03KfyJyd0hvIKgYIC2kRMrhuGORNao67Sn+7NNQAyY5znUsM0uLzetIArapNeCqJKjLadFgHN
 nJKQ6UXNwbbYRo2TdwX7765Ts8BJWq6Jkhrjpbeu3qUdUU1RTNvhkOanYBy9kX4AurLUqOb1U7t
 aAA9uVjZb44dGkbxnbidEWO3mYRpiF9dgI0OZxKpwi8HUB0JQS+rMX0/n3XRKDWovPrH/mLjzts
 xcyo8XQw8z1I1wJF0RcJYKOr48BJiesuY5qxiq+jVdM5u5If5fZd7Nw5vhhmpjkfbEBs00Uguo9
 vwx7JoOQrPJl7
X-Received: by 2002:a05:690e:1c07:b0:660:481b:c56 with SMTP id
 956f58d0204a3-6614f81add4mr1354066d50.58.1780995944072; Tue, 09 Jun 2026
 02:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-20-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:05:32 +0100
X-Gm-Features: AVVi8CevS2yu14AWLr86rDwa0HGXy0IfwK0__u9gLY578zAjONULkmyL-vMzSGg
Message-ID: <CAFEAcA-u90AtC0m_MmhQGVN63apPxVEKaEV-jePxgpRaBZxe4g@mail.gmail.com>
Subject: Re: [PATCH v9 19/45] target/arm: Implement FCVT (FP16 to FP8) for SME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
>  target/arm/tcg/sme.decode      |  2 ++
>  2 files changed, 18 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

