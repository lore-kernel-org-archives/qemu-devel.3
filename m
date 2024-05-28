Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D88C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzHi-0005uK-V5; Tue, 28 May 2024 12:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzHX-0005hQ-Sf
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:02:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzHW-0007ma-87
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:02:35 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-578517cab9eso1184905a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912153; x=1717516953; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i0tBjJBheDwGGk/n0jw2aYv6JLV2VQU0vdOhoTSCcTs=;
 b=D6pJWPHSytdHcc3DNfexVHzvhWWIOQSrsvSMoIlVwZjCuC9QlESNtYG5W7j9Ylh8nV
 ntugFhXQYCh7GHhqxK0K74whr8TtycA1vx2dUIdo2VI8jg+HOn+QO9fIskAH3+QpxhC1
 G8AArl7Co8Dxq6MuauF2bO0PmieRJv27QUrlP/SvLyzHkdc/E9L+K+gSHn7JrmelGPbV
 7/F9DR5/K42DkAAlzuGjc5Wx8+R7ecoXZMMSsVsCS3Gs987oFAzabPfYLimHNRJ5/Y74
 bzLLFwPVhM+AfpCA3dD5pOYLuxQQ4PYERikZRGzQd3TLxQG+PfGJNAKwUj23V+4Rr/rd
 0EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912153; x=1717516953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i0tBjJBheDwGGk/n0jw2aYv6JLV2VQU0vdOhoTSCcTs=;
 b=HbrJLBDurvbcnPoEZymjHQFJm1vZr0KOeQkYzdOR6p0ud1RfWW52B9ggS1px17K1UM
 fSJ3sj6YMTnAGorW8Vw9ehCXyMMU8lbEtBfzOf1uxHbkuwpQAbCmZwaPYqbTohibt9xL
 e4cifA88T+dYj18DGuudAGbwXZ0q0BC8KulrwQIhKUK5sWPzCoiOuyuM4ycPbBx2XS0g
 xhhFMEdQkLpRm4wHsJHmlA1gKXIjxUm8SxXY0lpJ2+W1oBv0M6AswgWwwkHhZvkZajc7
 jdAqR4HmM9P3W1yk7Q8Ix3a35WZDLtGNnSNhi5kRAeRbJTWNICfueDKkjNAk32JonqBT
 UNcA==
X-Gm-Message-State: AOJu0YwcnDWThLFntCDUgxMaK5+FyFQTHd771XvMw0+lfjEI9CwomLMv
 lgB4SCxf1lal+ujAvObj2JjyLQd/cRWmk9eK/xb2SX2bOxT/y+MC1vWoGSMglgRxZyh5FVYO8cQ
 kYpzHXknAlJXzmCwN9VBM9EWV9ndPWDeOZZK2Ec3WHhjBQRHs
X-Google-Smtp-Source: AGHT+IHh0z4b16ZiHtt1V8/esrml51VBsqzypVD0TMwDnHGCRyl8vDZ6c5T/8DnOoBhfZ+C9R8FiAhIgBwp+kQ9ArM0=
X-Received: by 2002:a50:d59d:0:b0:578:656b:d294 with SMTP id
 4fb4d7f45d1cf-578656bde13mr6630927a12.6.1716912152777; Tue, 28 May 2024
 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-57-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-57-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:02:22 +0100
Message-ID: <CAFEAcA_pH+5qJQqNpwdiNMa+f8WPJFwKsM4URA9CTjJv3YzZkQ@mail.gmail.com>
Subject: Re: [PATCH v2 56/67] target/arm: Convert SHSUB, UHSUB to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |   6 --
>  target/arm/tcg/translate.h      |   4 +
>  target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/neon_helper.c    |  27 ------
>  target/arm/tcg/translate-a64.c  |  17 ++--
>  target/arm/tcg/translate-neon.c |   4 +-
>  6 files changed, 157 insertions(+), 45 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

