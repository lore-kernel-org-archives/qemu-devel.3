Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2BFCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKs8-0006EC-5l; Mon, 27 Oct 2025 06:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDKs6-0006Dc-8M
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:54:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDKs3-0004BD-ET
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:54:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b6d83bf1077so491242866b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761562474; x=1762167274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKMpWIhXtpialEwmpkHTuwm2zcptNqdLqzLgkitl22I=;
 b=SQXMQbUGnXGzwvuLrKt+JqgKiTHYSiJDhUYr1OG9AZEAgFJTYrwkOnj5JnabJtxpMO
 hsSmKybSufclVKmRtn81UNuI+Jzz2abj9fs+vgD2lwgS0Acq37lmpw9v+IimArpCR+pF
 anpI/cVgsA4XglmlqeWEsV3NELsAuGUcYmTJWRyK1e5peJB5bFeVq9af+igcZqmeGus/
 7CF3Q410c3zX9GcdhWKAUYQ6mbqdT6IZWGtmaj1Mcl3CcVyctsrWGTQM4RXfauKNppfh
 njb7lOHRI7Q0+XxNmLcvKLHLTEEYR1Lb8d6NJBFDoEPek8wYv61/d7+U9aB4XiZs0M/l
 LIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761562474; x=1762167274;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GKMpWIhXtpialEwmpkHTuwm2zcptNqdLqzLgkitl22I=;
 b=GSH8zin3nvapJmS4XXxXmpzGmqzBzwmRA2ISofqnqnyl5DotELZqpQyts1LpHj8jcG
 GCTdcFCRw+cq8Welm9xWioqedlBpqfHmAWvSbjWO23e+Pz+ID7h2LXuG6RPYm7Ld/eUT
 BbqOgIDVVWAGoZqo1wrnaLU+qL/9QZ07lFGLlOCrJIetULHhopMXEN4BQwqX+B+USGZ7
 sx/wTIFt73dAlZB4vkCktRVjv071akfoixbm6zjx/bVXW5KYeDZ98SQoqI9f9TATe0Cj
 HGVBO0AUZczOfaYBYyeTd7NTPLY/IW/DlEVR6cLlnb6qYlwaifqI+7BgFZRICIHDjFrq
 NVRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4cd5TEbzG6G4t6Dloxu/6JtC0hL2cZ+fXODevRrbV+hSzkycMKDNNFFk9U6lAghEBMK+UFVN0o+Yb@nongnu.org
X-Gm-Message-State: AOJu0YyknKmjzfKl7UEyN47mJU2iqqjSRr1YynN9Z45mFKYOJziEg7w7
 bHKYbUOsNHYDXH827lzscwIwcjZWwG/6XAYeXLET//BCF/S8LFQrJPJL0rErbFvNXd8=
X-Gm-Gg: ASbGncu4wnFJJWHqv0ce1vdhJhaoOGu6uZH6n1Ewt4wbuN94dmwvURJqoTuM5znjeny
 oTD5EWbwiMqGaytYZzfGRDStZjRc7cURbGq3NkmIVWs6NtO/FpYCykywaal+TwEzd/6F7Cigh25
 ObUKEO8Bs2DgyCIAj5P2sndv7TJnbjd5T+IausA0Tp5xtIWnyP5xTfU3GnaaPjOlZnv+sXobKll
 MRi1n4YPGxvaeJO2CtEMHna8N7jDYoTFCO5zOd0SkerdG/sygL88nS3ODP40S7rgY9u03K8oSh2
 mPxtNmbskiqxbnrHIrYNgJ1Kh7eQAIVf2FeGdIipDt6Ad+6KSgwV35WQgqpUjcS0O6OwjXwjdIw
 iyIwEL/TZi8JkctrbZprK9gFBLISg+oEAmg9mU6lcy0TGDiFbkguIgXAs2jNBPTyd8uItQzedkN
 hQ
X-Google-Smtp-Source: AGHT+IFP6NXAuCmJI3sdvaT5jhDNPV/6xaLa3Cq62LT8zBTGlnBJuPxpifKiXOhBvfqR82nAhrKv2Q==
X-Received: by 2002:a17:907:3e85:b0:b3e:8252:cd54 with SMTP id
 a640c23a62f3a-b647395033fmr4446620666b.32.1761562473633; 
 Mon, 27 Oct 2025 03:54:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f3851sm727715966b.48.2025.10.27.03.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 03:54:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 193C75F8CD;
 Mon, 27 Oct 2025 10:54:32 +0000 (GMT)
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
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 27 Oct 2025 10:54:32 +0000
Message-ID: <877bwgzkbb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
> properly truncate/error SYS_FLEN on 32-bit systems. Fix this, and some
> other bugs with GDB File I/O that I found while working on this series.
> That said, GDB File I/O has been substantially broken for two years now,
> so it makes me wonder if anyone actually uses it! It would certainly
> simplify the implementation if we didn't have to support it.
>
> [1] https://lore.kernel.org/u-boot/20251017195322.GF6688@bill-the-cat/T/#=
m493c42570d3103b8c606c5f50faeb78d27719de6
>

Queued 1-2 to maintainer/8.2-softfreeze, thanks.

As there is some discussion on patch 3 I'll leave that for now. We can
still merge bug fixes after softfreeze but it doesn't seem like its a
critical problem.
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

