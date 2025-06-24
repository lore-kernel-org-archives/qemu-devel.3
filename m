Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20FC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU3Lb-0004Sh-Ki; Tue, 24 Jun 2025 09:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU3LT-0004Qi-Bp
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:05:53 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU3LQ-0007h3-AE
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:05:50 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e4043c5b7so52885107b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750770346; x=1751375146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vdJuDU4r5Z5yQ4QDa0PcpmPpRwKqPu3jUFEjfRT688o=;
 b=Ew9zEYRPasPDeteswmE0NOr9dWGG4pj2uGPUxaEesx4P4n/cQTVPAFfw/Lq3ZH4fyU
 P+tlCL8YWaFO+lgSMWZ4xCPU22pC2EjLwauTQYBPpBf0zsoJ8+zDLJEz7tELMFja5dF3
 sCoVzL1uTGQm5ehmzzqH/cDZ1T2N40oII5EQbjhdfS/sRBH7+7tFJxSX9eXY0LNJzGa1
 Vwt+1e8dG/XAgY+W9yuo0/I8UJJKwDIlGMQRusoOBuEdNJNIowgWCqC7aw8kDGROj1cG
 jt8Sen7a8CJB9TUrZzZDwTqfrxv4yRja1Oo/VhxtkZqTEin760luvtoe2KBtJK9Fkbkl
 sG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750770346; x=1751375146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdJuDU4r5Z5yQ4QDa0PcpmPpRwKqPu3jUFEjfRT688o=;
 b=NwHp8kXvIbn8A/5OQvgj0UM9brqr65N3siKIH7bwKKwetWcExxJVrWWFqcHhK3sRju
 rSa2MVaiJg0B0RTZ7L69a3FpRYXd5fvm3vZ6+XBT9dv/SNvU90Ox1gXCKnE0iHUBRrp8
 AEtcIxwyzySRJ2X/qTUbtCdsMuX31BBgB8eN6GkPeJw1SIlm4cmhTt7Ygc1fc3RYLnME
 DeB0B3uq5JdQwknMUDiQe51arDUoVrehnhv199zLj0DJiKaOknWC1KiSMikJ/Ksjlwj0
 kINwurtB8ZK9fVqdAz41sWD76QI/ezVi+x1z26TSfXDacuxKcGvYECrjfe9XybPjLpT6
 n8GQ==
X-Gm-Message-State: AOJu0Yy60Cxqx/vRpNt5sLmygH4+4XyGn7QFG4G3GBrYK4Z0E12xh5rX
 RKn/6mNf6iP43lKEqwg8CeKI/yqPWjddkTemk6VB6+N+ReUtqEJ28hnUuT0zHkuuJ7H7bkxBVTt
 kkZwsYYACz016QxYIpF+kl7nHo6jsAzi9OlYI5bZF8A==
X-Gm-Gg: ASbGnctjFxMU+A3Nj5kdQ2x6WEKo9sQ+LNeVnsJ2xOYXfqunkvTfMnfaW3uoQrKuKBP
 HoQmuAtRUnMuEfFWBdNg65XgqLdnhPzYIz9fk2QnMA0MrGnFA3HSIsvcixJjTAse9qQJOzYUt+h
 lkliY1QqwFNXYVL3bc4d4RIv+xfjQATW1CDrm7O/5vDiJi
X-Google-Smtp-Source: AGHT+IFLWhg93NHh83cc7mvaFxu1W/eg21vxzSZAh1gBiIxFGp9r8bkltoJVqGls+bZ0b8dJkA3gOqTX/f0izzlWyR4=
X-Received: by 2002:a05:690c:6505:b0:710:f350:64f2 with SMTP id
 00721157ae682-712c63b94f6mr220744707b3.9.1750770346439; Tue, 24 Jun 2025
 06:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250622213509.277798-1-richard.henderson@linaro.org>
 <20250622213509.277798-2-richard.henderson@linaro.org>
In-Reply-To: <20250622213509.277798-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 14:05:35 +0100
X-Gm-Features: AX0GCFtpT2Uzwd7qX4sjfZQwK9mA1tdTF7pbDMsZRAOd7pE88YipXvhjPxrhfZA
Message-ID: <CAFEAcA97L2feCdH1MOZ6iLCQQeJOU+wwE_=Nm77obaJhtdJeXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/arm: Fix SME vs AdvSIMD exception priority
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sun, 22 Jun 2025 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We failed to raise an exception when
> sme_excp_el == 0 and fp_excp_el == 1.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

