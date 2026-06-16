Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D591CD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSw1-0001XL-QM; Tue, 16 Jun 2026 08:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSw0-0001WG-0z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:30:28 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSvy-0005sX-5H
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:30:27 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so4166895d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781613025; cv=none;
 d=google.com; s=arc-20240605;
 b=N62u1IMa6pR0nmBSjZvQL1tpAYxwIc15r9lgpXtpmY/dk2sWSI/wDuW60oz84A0wPA
 UuiH7nVhRm8Jxau9UedXz9LwfoK8jq28ACLlqmPB13jvrSwLtSL0WYzO8cDyYVl8q8dS
 23zlyK0Q5qMEV2HoRa3zb4ZA9QAn9DzjV5YJDI77kSUYy3fmPnjB8OXWW2cfD7SUI/yO
 DjacFjqi2a+j5cmWNmYsscqk5Ach0eN3TZQItHAh/mL8ESUb+gOhQAwi7ZbbVzF0ZuCf
 TevDclEheMb0sqAQ52uTVg3FlSNERPJmTXNfQSYw4lfyv/jdCIBvCq3c/TMY20BATxd/
 PC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxlX35AWJg0w5QhGd7wJhEhtGu0JCcd0LIXnEtGZGKQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=A0WZxvQfElHCxcjR/W52zVeqkJ10F0Z50yyQ5NibKPw9qrc2ZCDXCkYvyuNi4IWC+V
 aKuYbuMfPF+dKy0KdMgponUP8UwHoYGuqrQ+D2O693Y1/WZudKGt8uMtsHfRu8y4ErMs
 P02v7er/ewAFJgByomADuL2V8j4bFtGJHdj3XAr/ceK/+lassSfnYlHo5EOOfaFyFk/F
 4l/1HtFEmdJrb2TtTWHUOJ9HEjpGwDxLRB8rUHuZ1BEzGjnyTmeObBm2c48GwuoHKi9O
 qPDjXIVLriRm0D0AlRm4k6My1GxYsYtGZrcm7Khyw8WR0WlQLGpHoGKVmpCaHmZYdp33
 W5wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781613025; x=1782217825; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxlX35AWJg0w5QhGd7wJhEhtGu0JCcd0LIXnEtGZGKQ=;
 b=h7eW3ojDqUfTqBLD64N65wBBODuhmbcABxH8W1mn3SEqqzyPNY/0jMdVGIynJYonK0
 tN7Ri78iM34UBQCF3AkPGhovgASo1GhLWUz2RHfljGt7AWdD89usRXaojgMIeNikpymD
 9fTAdmLAenctQ8DDSnF6i2U2fHFl1EyNbrv05brGUQaofCg7XO+k9UmOmKsqwm12D89q
 G1YVrA6KNPr15OR6B29bHKtkLCSYuzNZgerVZhdZc31U1FiKxhvzJLi44klst+dJvDyJ
 yRYJRy+V9VfJmcyuNlqJtT0viL8FirMQvgYng4tsU0sSup/em0mNE4YIFqFGIvL0MFQh
 nWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613025; x=1782217825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxlX35AWJg0w5QhGd7wJhEhtGu0JCcd0LIXnEtGZGKQ=;
 b=cAYLl7oPvyQ5+xMqwEdqBYz/8WovKbmli83/Rmz6GFOqPSDiNWnMIqOHYdeT7SDZXf
 Pp8Zugs7Dv48Y3E+mmp3XvdKan4fIPNKCMOkq1tkWhxr8a3A+V/trz57awMUzTXoMrUx
 GbGEVE+xZw/gpLLYqcJ/evo6UmSIzLAmT6Gzn5jkPdeCszC18OrEVpHiUmy3VMkDu0LF
 iURwIKdaXZ17jYh1Ws9pfaEx88nezABT7VrXlkrbdffo7P3RrO/co+xFtQ8ZXdSXoeWd
 zbu7pflON/17ngF6cZD2vtgyry1jbqJhvKPG3EcFQ0Wxnxbxk3ylEfF1DXNsXmTwhfr/
 cTjw==
X-Gm-Message-State: AOJu0YyvvCd5ViIj1I6CAuJAmuSufUvfBdcpt+8eu183orTcvb/GH3j2
 QhMKuIKYY58A8SLmqacF3EGAqFXlCfbiEFPzvxde9J5I2uXEOLa5z2p/Bke6AZctllpgLPVz1yR
 x3J9GRXwvdAdpwCdIxT7gkwm0PsEJE0fYmwFChS7Mrg==
X-Gm-Gg: Acq92OHzD5lnqTVbBQD9vPd5dI4P3MlRB9SMziyPngn4+76ZmwAemEJrGJIrEv0ejiz
 2PEJxv5y/7cMYawofymhCFTXuJMVrQGyVGwxFLoZ0GJCovRhJ+iebneQ5z7IAC/K/ASZbCR9hYZ
 akZSZWqfe6h5qD1gA2Y6ZqIRZxO6pgdMyJiIietNjjEHberqX4ectQRZUPcTawzCP++/3qjlLVx
 8On5DQYexfl4yQ8gLiFoZ0XIF7PSOVBhOSxNrH4E1PaxJALvwvuNFOsGvvRTCE9iUAq8Q7WDxa2
 726HzI5wLmdTni586VjqqqvTaAFnkAbQUXNMJJGEG6xN5X5SZxPkpU2gtYR9uYBFCMQ=
X-Received: by 2002:a05:690e:e87:b0:662:bd61:f80a with SMTP id
 956f58d0204a3-662bd61fbc3mr1225933d50.48.1781613024517; Tue, 16 Jun 2026
 05:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-9-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:30:12 +0100
X-Gm-Features: AVVi8Ce6wRyugd_4QjRUp7fafwq37-1ofjMZ3BAnVtjvfC5nvB0ldtkABg71ac4
Message-ID: <CAFEAcA_3kV1VUqT3TgK7dTP9HEjCwpxV3ZTz0WLYgu5O0JtnjA@mail.gmail.com>
Subject: Re: [PATCH 08/25] target/arm: Implement SVE reverse doublewords
 (zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c    | 4 ++++
>  target/arm/tcg/translate-sve.c | 2 ++
>  target/arm/tcg/sve.decode      | 1 +
>  3 files changed, 7 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

