Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B79CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArQT-00079O-Kj; Mon, 20 Oct 2025 11:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vArQ6-00074Y-TY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:03:38 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vArQ3-0006cj-1T
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:03:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so568781066b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972608; x=1761577408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZMc9myImumVcUr4HSNELyTv4GbJyH7GYYA1sVKIt1M=;
 b=xC2A9kFgMLsO1i5D45wfSp3FxHb4xIDUsPV/kV+EuidXJ3yvZegdouliHxo8ZDZaHZ
 4PSh+AaCmqA+QNtSeF6LjI6ehCf3GUHXASXLqe8KnAGyxZBHtlpNGQttFjto6cym5z7u
 TOT366B2kWI9+DGKLC79cCAUGqh4gVHQRDlR2ubtL7rHWQHdw0IUTIxs8do0eR3N4ULS
 9OAu5va34WIQ7IWDkNeH8tcfdklQ8VuCPj/aw+k/EkTB3CehQQwLt7IJHDg1kl2KT8ch
 O7boBil0BdT5JwPPHyRXXjIaMc8CkaWd+ofh8N81si8++NzW9O66wdVF3s6rGzJuVRlP
 I2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972608; x=1761577408;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ZMc9myImumVcUr4HSNELyTv4GbJyH7GYYA1sVKIt1M=;
 b=r/VLzYTnK06hXGkP8RbVp6p7LMRp6saOTWNctaVU8SoOX7q0qd0sgY3UftHsFuH5sM
 kelSzfFCaB1HmTgpu5sdycetM6q9RERVC1hjqoqcddBIbOaMsIbnYGCfAvIyvrnEuDGN
 lRvJ2AKVcVAeTEZFw58xDOvmL3v7hNLHWmOi4CuaAURi5o0OvDJsIX0OZl7b9NjlJxDe
 FlqJGJoL+UMERIE4CPIB4zxa8MFoc+9NhWkxRSRkoGc1IIu7Aff7bfGkuYzzniN+e/O7
 tP7yNczKKSaG+uRYJrepUl09soLYz+kSTcZ2xmjppVeQF9UfTIXVruSAgdzZSXPuSjQ3
 xatQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg7LF7kTiHEptaNPjYK8aGAk3wzN3mSXYxntB+y58bZunfYO0rxCTEdtQJJiardRqvKXc074EVhHlR@nongnu.org
X-Gm-Message-State: AOJu0YwhAYZcX4KF+1W1EeMeDLNZ997M65ybJ5EYM5HTpZ4UsqEUNQhM
 5T7l8jn0W4rx6xlMt508jAh3hgLco9HlF20FH15CN1jWm7sJuGBNxqC6VyddT8bSuB4=
X-Gm-Gg: ASbGncuqDNMlV1w+HfibNe1Tx8/GtpqhS9Tr2wsvhQsZGKg9PAcRcx40uTpS5Yr/nZl
 VWce17wzSC+cWkAejPMu0spvP0I8vNbpSCyo+dwmjl0Q2sxPDOhrXqseGNPbPr3OHxGKMTsh6qq
 CzzfgeNVCqiCXBZSIltcrEQHp5YQ1JSXhQVrCOeOS9vFhItURI/Ia9rpYHdg4rPPbV8gAvcY++M
 Mne8yJU5jWFIx6+WmhWr+Ghns5X7Fgx+9e7w1egJvAp8a2kv5TLNZbbLP1oJ2qv3s5Fc89rsttw
 cf3sUiZPaQlMeDWavb1r9C9O+JL30xHc0owxgm1YlaTLay9XWQEGIjxIhSj1wmKrSKkZsN6nEkP
 qpAZmIAQLMFdfaRvvqCANsmj6OvkHIGJCDnFtZMI9B1YjdNiAx6YTIHN8qg/beAnZIZswy3q8x8
 ST
X-Google-Smtp-Source: AGHT+IFD4Iiva9OIXG7VcGAZ9gCbM5/c8ixv7EJAcwT5bUkhH1a2OtvzkuKZ24WJ8Zmu6CVn9hAw4A==
X-Received: by 2002:a17:907:2687:b0:b5f:d46c:4b7 with SMTP id
 a640c23a62f3a-b64768bc7d5mr1715303566b.55.1760972607989; 
 Mon, 20 Oct 2025 08:03:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6aaf93a32asm362907266b.51.2025.10.20.08.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 08:03:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 796455F83E;
 Mon, 20 Oct 2025 16:03:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Luc Michel
 <lmichel@kalray.eu>
Subject: Re: [PATCH 0/3] semihosting: Fix a few semihosting bugs
In-Reply-To: <20251017213529.998267-1-sean.anderson@linux.dev> (Sean
 Anderson's message of "Fri, 17 Oct 2025 17:35:26 -0400")
References: <20251017213529.998267-1-sean.anderson@linux.dev>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 20 Oct 2025 16:03:26 +0100
Message-ID: <871pmx8vk1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Sean Anderson <sean.anderson@linux.dev> writes:

> While discussing [1], it came to my attention that QEMU does not
> properly truncate/error SYS_FLEN on 32-bit systems.

TIL that semihostingfs was a thing!

> Fix this, and some
> other bugs with GDB File I/O that I found while working on this series.
> That said, GDB File I/O has been substantially broken for two years now,
> so it makes me wonder if anyone actually uses it!

I suspect this is at the upper end of things to use semihosting for as
its real purpose is to help bootstrap things on the barest of metal
until you have enough bits going to selfhost. In QEMU land it is a
convenient way to do host calls for test cases.

We don't have much actual testing of semihosting in the tree although I
do run Peter's semihosting tests from time to time:

  https://git.linaro.org/people/peter.maydell/semihosting-tests.git/

the tests do include flen() but obviously don't cover the extreme
filesize cases or overflow.

> It would certainly
> simplify the implementation if we didn't have to support it.

While semihosting does have the concept of optional extensions SYS_FLEN
is not one of them.

>
> [1] https://lore.kernel.org/u-boot/20251017195322.GF6688@bill-the-cat/T/#=
m493c42570d3103b8c606c5f50faeb78d27719de6
>
>
> Sean Anderson (3):
>   gdbstub: Fix %s formatting
>   semihosting: Fix GDB File-I/O FLEN
>   semihosting: Check for overflow in FLEN on 32-bit systems
>
>  gdbstub/syscalls.c            |  2 +-
>  semihosting/arm-compat-semi.c | 22 +++++++++++++++-------
>  2 files changed, 16 insertions(+), 8 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

