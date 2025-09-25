Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF0CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1mTU-0006qY-7q; Thu, 25 Sep 2025 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mTB-0006p0-WB
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:57:14 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mRD-0002U1-95
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:57:13 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6354a4b4871so634488d50.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758808494; x=1759413294; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPitgufYREd3sp3mlhfbyYLeiVT2Xjtf4HSuOODcATs=;
 b=T9QdzJO21XQVZLmSgc8qf0OwkHM/pF7r1NvYDcnBWCeI7WkNa1bRDrH5pnYK71cJWv
 agxliM5V0LVLWm4LmplVkaaTGvS41XTrY4Kd2//B3YgFnVl1g6F3n3hTmJSBkvg85mWD
 qK8OYVy61q91YKkk5bx7vG9+cpgcEhdgofarCdtlyXw9M7OP0hLqLsxUMmJOgX29oCu9
 EJuC08HQxhnq8eM+aGp3873EZPGCHkDT/LqrvWE9/6o1nar5W7RED93wp3X5jUDWUa8/
 SUc43ZGZ//Upk4jiDpQdmEMRrEaJRTVfSZvNs1oBZAdtDG4D0K/mLiyWmlcMzYrwP56e
 r4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758808494; x=1759413294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPitgufYREd3sp3mlhfbyYLeiVT2Xjtf4HSuOODcATs=;
 b=khZ1NbVeSuKyTvbuL5U5j5dglRKsYD/FrA1RQZIdQeNPyCs9nn2X1WD0iHP9E+JSmb
 UPRGjRXSxs1BwCM4uo+JxdY8pwwn4M5xBGEiPfuW9r2BH4akdB+/hvlr1LrW9IsEpU8K
 tERgxppuwz7FeOypwVn7IP+8nhHAws78IaLKUwdaNpeuxqD71wGT7ueS8YrxsaBDGgtF
 Hl1n3Hrmz2hj4F+3AqIXQ2yvFOCKHygxnf6W7oxhXlYF/F9W9CnHjoAd6WFBLAJ97NFX
 aU7NCuLA/4d9W7RwvhX98UHvkUp0X8bbw7DskuB7f7P2jjsOM9oWOg4I1BWZlsI/ixGf
 RfUQ==
X-Gm-Message-State: AOJu0YwJ/Ojp7NTL5kem/FwQc3Mo4pizxGefSxPFv51VhG56S3ThNxwC
 Y7v+LrFsdtVAdLaz3Dh+wa5Ic/YqGU99fzoHmJIvQvCaAejR6Bk0rQ3aU5vp8aQVxVEcKMpg59A
 OavDV1410N6gcJUZ4SF316749m6ipjCMXCaVqQ+o61w==
X-Gm-Gg: ASbGnctX23/p7ESALtvpKzvHQ6mmI/mdUpdnBTE6vDFiZ1nDoFr4uPM06qCWXxpdWVE
 QrvswkyGpZHuWed89zr0UBHbNP953Ea1LgfBPR6BNS1m4ayHbaqKqgodHZEaKIJteS+U8w2w+68
 kHVd+nEXKuuBXmUytcnjQ/FuWpB/6rJE0CHSh6q1QnEK4sK5NSEQOiilY9ptj7paWTRaisEICda
 AHNioZ8
X-Google-Smtp-Source: AGHT+IFTb363n43DEqxuOrhV8YksX0YbT8p43C8aSe4ylxrhCHWsmow/i8lSaDalbeXKqK0XDpC4lzmxCHoy9pX2/Yo=
X-Received: by 2002:a05:6902:228b:b0:ea5:cfb1:f9ff with SMTP id
 3f1490d57ef6-eb37fcc7da5mr3370547276.51.1758808494032; Thu, 25 Sep 2025
 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-34-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 14:54:42 +0100
X-Gm-Features: AS18NWDI-ENLYKBFywdYleJgkRWNYuEXR_-5gqNBdWE-TzWeMoulJ02nML9WNrI
Message-ID: <CAFEAcA8iTS6gpHwchagCFTOwjU=KKOJrmp+d7m4oMR2_xRfvkQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/36] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2
 during translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 16 Sept 2025 at 15:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h            |  6 ++++
>  target/arm/gdbstub.c           |  5 ++++
>  target/arm/helper.c            | 53 +---------------------------------
>  target/arm/tcg/translate-a64.c |  9 ++++++
>  4 files changed, 21 insertions(+), 52 deletions(-)

> -/* Test if system register redirection is to occur in the current state.  */
> -static bool redirect_for_e2h(CPUARMState *env)
> -{
> -    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
> -}

> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index c0fa2137b6..3ef24fb0c3 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2573,6 +2573,15 @@ static void handle_sys(DisasContext *s, bool isread,
>          }
>      }
>
> +    if (ri->vhe_redir_to_el2 && s->current_el == 2 && s->e2h) {
> +        /*
> +         * This one of the FOO_EL1 registers which redirect to FOO_EL2
> +         * from EL2 when HCR_EL2.E2H is set.
> +         */
> +        key = ri->vhe_redir_to_el2;
> +        ri = redirect_cpreg(s, key, isread);
> +    }

I was looking through the details for this one, and noticed that
R_PHHPL says the redirects from FOO_EL12 to FOO_EL1 apply
when "the PE is executing at EL2 or EL3", so I think our
check on "EL == 2" isn't actually correct. But as you can
see in the old redirect_for_e2h() code this has always been
wrong, so as this is a refactoring and shouldn't be introducing
behaviour changes:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

