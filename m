Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2058C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIR-0007Oe-CF; Thu, 28 Aug 2025 13:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdgB-000658-LY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:43 -0400
Received: from [2607:f8b0:4864:20::b12e] (helo=mail-yx1-xb12e.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdg7-0007yi-2R
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:42 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-5fb298c0646so562356d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391556; x=1756996356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eRJYWiLEmXiLw6j7N/M1zidwXL9uveYpyEeTDXeuTRA=;
 b=yjM4G5cHXC2BPj0KzoVxZsrM5Jz2Ee+aJf1Aqp02JrQ8/QLEOoOSJhvwfSsnhHz0eo
 OceC6Vm7MxLiT8BD7o4lF+tcAuZo7Uam2C59Y6wNfExrZ5gEirVb+JG5m37mXv4YCRXW
 md464cWfs726+dZ5/0R+Sa95mdvjQRCVwz8vpTDdMc9ST0LtcK5S9P+/cdUD31veTpNE
 tIozunoC5ulW9n+HG9U4yLl0hZH6+mFJhy/aor45CppYQO3N6+4zvSQNkFKmRMM1kVaj
 vLtUyyJzTS9wQDXkbQUMQvRZJRXxygZ7ky2lYjMrrKEqSxk6JR9xQYbKPPvA8Kr+sij/
 1rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391556; x=1756996356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRJYWiLEmXiLw6j7N/M1zidwXL9uveYpyEeTDXeuTRA=;
 b=OVcdT5J/SW6V/L3HS7MSIYGM8hlNDXx9HxOOVFZLLZzcapgapM5AYK4cA8ZPJFQG+b
 3OtQ2j0LQb3quQHTGKIS4WGD6NFW99jgMwcOfel84F2ippOnf+cQy721OADLG11sTBNf
 9aPwEURG1PjjxplrnCmAAhCnKlCzZd0fq3/+9r9cfcviSmc6voSZfylGBYY6qlevlJPz
 2JJ3QPuAUfxHEt3A6Q1yFTVPnqj4CMCXxZeMxy0n2kGM4OG9echukFZUU4p0uvTniBlv
 jmFg9TROEKF3Px8bSUuUZ35Ofdn1LqOjl/Rc2fiV2sRDCfDSIIkcmlzOjDzPnjEmk1EO
 PR/A==
X-Gm-Message-State: AOJu0YxUOVeGPuj9zdiie32SiGvJZJw0wZPjuaJgCppwR8sPKYe8knTC
 Rd2CNXjvi7MXAq5CSFPPEu0GS2HoQEmJ26B/XwZCoXgDMWnLWL7v42lYHzIcy7y6L54y8yv8AVw
 wIoapS5ij7MCyK0g+dMZfZhe8++tRbfv/SsKd1hpq1w==
X-Gm-Gg: ASbGncs+59aG7vd7qqJds2eY+XXGgTt+EkhqIYr4EFuVAMeJk9LYKMXn4wsA7gFvm6w
 Ixw4r5kp6geKeamWsWgn91R2dzPHeVeUNiRBdWnmg5i7rFqJwyZWgL+gUTnWhCGwnvjqRdmFbII
 yfDHZfq6m+OdNk6UiIygE8n059bir6lAaRXjKxKuhDQvWyXU2Y7NfTZloez/vWjfKI5BWxi3cAr
 An3ZN/d5tcUzUY+syI=
X-Google-Smtp-Source: AGHT+IHkZqK90EiClXFzjRFJKmLA6hM6pDU+PPro89b0Xl9gP0fUTPzdzLKcWv56xAiYVGdTNlp3uSNBuv2uFPHtagU=
X-Received: by 2002:a05:690c:6102:b0:71f:f866:bba4 with SMTP id
 00721157ae682-71ff866f374mr222538277b3.17.1756391555948; Thu, 28 Aug 2025
 07:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-26-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:32:24 +0100
X-Gm-Features: Ac12FXz8BveSJDGQ05TvS1_m3PLAMHZbEXCL3ucOwcH3C45qmj9Bzq8r6xj2DV8
Message-ID: <CAFEAcA9JmUdem=fxAKQ_biWRs2N6nN0_3mQ5+-9aNd9ErbYtgw@mail.gmail.com>
Subject: Re: [PATCH v3 25/87] linux-user: Move elf_core_copy_regs to
 sh4/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b12e
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sh4/target_elf.h |  9 +++++++++
>  linux-user/elfload.c        | 33 ---------------------------------
>  linux-user/sh4/elfload.c    | 29 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 33 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

