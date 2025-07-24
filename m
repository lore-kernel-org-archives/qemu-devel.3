Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0128EC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetjV-0005XA-1E; Thu, 24 Jul 2025 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetjJ-00055u-FI
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:03:21 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetjH-0000Ne-MO
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:03:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso1749963a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354993; x=1753959793; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXcZhJOLvv/edrJWZYhZg2P5PsxK0KA/B34keg0jb/4=;
 b=Rs0QGlE9DI+BU0Xx76t8liB79WS6HcR+htmFfQe/rKcjjReiQfTLhaXbUVMGHIVNTO
 PLIf7FsBjBkOEY7TTexCjwaUcq+qaw5Av7c+6tSv9QAPIOWuIw3pRSh6C7KelYrfCaUq
 tpgiEJX6qhZpt/jKtXWkjLwyweqC5nRpzyhtV3DwvxZLteKULWrG0RuTdNAYVGxBkw34
 zdLa+sBOGe7XcK7WJjGE75ygCrl2yn5QSbuHakdDUZzkfO4bT5l9gnzOcTN08gxu8mvD
 uc/mWLI+L123PtxC+hnwrr+k5k/Uy9PhPYhdGvUNqEEXOtODO1LY+hi2JU3nujlmQROg
 KstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354993; x=1753959793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXcZhJOLvv/edrJWZYhZg2P5PsxK0KA/B34keg0jb/4=;
 b=K21Pl7YIgspFYBbBJk0ubuvXNV9Xd9udkwD8rVuVHCxbrfNiGQLUk3SmxlhdeFzKkM
 1i/vVvuXr8m0lIPU3qEDthVwjiCsKT8rSDDT6vKJEmL3U4HBANIEX8omcsVjUQqi1DiE
 lqonHVUsQQ6LVPhiVgDHKiYYh/yNomEbgGA8HbfV1nmGhzNUlM3gsnWWKt38IEim8ZTL
 parNvWR1ImzBzBgToGDWMfItdeC1Ao48aSMirZQLAaERLRtBgIbMOSgvVfVPfrQVyATY
 KpBfDCmxTx6M9WYlaquqSUXfzt2ilqT3xUW5wR+iY1wGrDuQ9kNhmX957hzzh54+uBva
 MFKw==
X-Gm-Message-State: AOJu0Yy2ZLU5zHjaAh29kuGbIKxc+Xvi4TFLkBpx+xze9WDJTWx2rLfn
 T4UZx5SKtLf3yV8bjikYLchXJ2FV01wPQJPtjhD1F0OOUGK0lzAy64qs/V75/deM/ASCAf8DfU/
 ybHcWVD1xOiHGdLL0QOQoTVg5iHgd0X8vnwm6Swg8mA==
X-Gm-Gg: ASbGnctDD+pnce5/4gqzlhPkM7Deo+3Xxp2NgKwMuMT9h4U2WG0xSrfoEI+/dxngwQl
 oUdUolyTF0cvUV9UxQnejAkW8nfcCl5XpNlM0fD2tzo4UYQ+KlzSC3PX4UWe9bvLRuxIxwKNH2n
 PZs/ab0kG3hNWoqaYmbIBGfuXddbZvbKZJqz6VpyIwO7MPU4tK5EW7P3c31JQatQVyLKhXRzsoJ
 lISJw==
X-Google-Smtp-Source: AGHT+IFx3raHIQUBXwOqqywHJ/OyAV1UMmizAx7VVuiqGZvqF5ZeQR701H7Ci7nhRLkqbsjGeQD6uKzbDf8xSfEHM/Y=
X-Received: by 2002:a05:6402:350d:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-6149b590a84mr5772439a12.16.1753354993044; Thu, 24 Jul 2025
 04:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-2-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-2-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:02:46 +0300
X-Gm-Features: Ac12FXyvQVOs91o4iqsKbE378Yk7ccC0-rFjmQl--nYStzQRF5EU0ncF-eKe0sk
Message-ID: <CAAjaMXYsbn4L0416FLZUPt3+oeySn0A1Bvats3dtqSb+GUPTOQ@mail.gmail.com>
Subject: Re: [PATCH for 10.1 01/13] docs/user: clarify user-mode expects the
 same OS
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, Jul 24, 2025 at 1:59=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> While we somewhat cover this later when we talk about supported
> operating systems make it clear in the front matter.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/user/index.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/user/index.rst b/docs/user/index.rst
> index 782d27cda27..2307580cb97 100644
> --- a/docs/user/index.rst
> +++ b/docs/user/index.rst
> @@ -5,8 +5,9 @@ User Mode Emulation
>  -------------------
>
>  This section of the manual is the overall guide for users using QEMU
> -for user-mode emulation.  In this mode, QEMU can launch
> -processes compiled for one CPU on another CPU.
> +for user-mode emulation. In this mode, QEMU can launch programs
> +compiled for one CPU architecture on the same Operating System (OS)
> +but running on a different CPU architecture.
>
>  .. toctree::
>     :maxdepth: 2
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

