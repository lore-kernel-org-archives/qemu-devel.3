Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65735CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v41dc-0002wP-DX; Wed, 01 Oct 2025 14:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v41db-0002vy-6T
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:33:15 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v41dQ-0006ct-8B
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:33:12 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4b109c6b9fcso1767231cf.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759343574; x=1759948374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BLdhhPzOm9WYYiR3AYxtCceHFtkQJLq069e7c9zdKg=;
 b=MGdiM190TvKefb+KJ8dDXX+T5IWQmsYk7/V+LtjpNu2JK+4ydgXRUsyQwgspPJao3f
 KFV/BFz5+UbUS82oIMUjSUwrSBr36myyBeva85v/WBoQO8UJFiqC7NtRE7hX6hbHYj4R
 u5pHlAJn5Mc/VxHcF0XdcT/86TYNfcfPgjK1aMoUqSHkNw62sECkx68DfVV9qGYvAHQt
 pP2XxB7DqRWDwjyK9V9qbeHWInxZH9KRa2yFfF13c/PkMuRbHKNleHSjaOrznNtrDpO7
 2ULqlLKjXqmxe4cShEh5/bAz6kI6OW84sFRo/LnlWS3n3ivKZkOiNgeB6BJsMIRVvBmc
 dRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759343574; x=1759948374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BLdhhPzOm9WYYiR3AYxtCceHFtkQJLq069e7c9zdKg=;
 b=NaiccFdQsH7JJpsMpv4KsrISZDIrhP8otrTQ24wPLCDa8G+P1gN7581qV7/Uu4UVFw
 WD4QcxQse9qQv/YoV92lMu8jnqKRl8Jo7saXq3gm8A2Vh3Bli+X/HVTfcFqPiF8HfAnu
 +gVcagqTiIkzmqCJB4/Lo/UBkCDnitolTyGJgwEZCxes5Z1Og8l95mZcNuLCjbpNJlUA
 8+dL9TO8zeaIWVPf2vi/xrHdsrpx9U6rLRx+SpiRR1zhyBpx4LXON+NOuLsfjIC/uqzE
 dEnwC7JoXbMb/oDFSm6IosLxK6f1tL2lE/toAVSX1UHiTLxAcTIGAB2/ukJZlWuo+yYJ
 hGiw==
X-Gm-Message-State: AOJu0YyXcvJXwxV9AEN2Xi5NwDop9mstJtWNmPAj8ADwqAi0saE1psQW
 Xkol0Xk/Xh+3LmswGFk1/LviqY0dnwqGnyLTYrFaRoE9ODAV9Cm6uIw7NczxaqYWXqyYCRpf+ij
 IHMcUoM1xzTlItdGT2aLztYWQtQN32vU=
X-Gm-Gg: ASbGnct7C7raAOt0LzpDPUaetucma3r4YsGn4U7OSbJCn0EO7EAMpUc+2WLkRXdRBTU
 5ZxkJzs6bA+e3wg6Ih1LloJsUIYt+0mGuG+F6zpi8xEb2Za+N85lkrOMlF6lwkZCvEmMUV+sE2W
 vS2pAY23Sq8JnNeqWdrrrND/y2IIkC0irpvozaneuczG/TgVhpTuvJF9xc0nN9NyWsB2v3iUwGu
 khoaIkUVUyd9O6mRdPQ0ALZ6CwSr2zjnJXxcSgk5PjZwSguObQPYlVar2TLh6kH
X-Google-Smtp-Source: AGHT+IFsBmXy2J9WRNxp0JaObOPX9DT2ptDzZZ05M/aB4PdBNGH4bImA+qS2Y08oRRWuWuwW5nIIiatGjW2bKU0vXyc=
X-Received: by 2002:a05:622a:649:b0:4b5:f244:6661 with SMTP id
 d75a77b69052e-4e41c548224mr61160141cf.2.1759343573733; Wed, 01 Oct 2025
 11:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-5-alex.bennee@linaro.org>
In-Reply-To: <20251001170947.2769296-5-alex.bennee@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 1 Oct 2025 22:32:42 +0400
X-Gm-Features: AS18NWD8GLVv_tG-ZUfE3AJQF97OKI7tzNMK5VIG4nsQOuhoO-dTb85CoKDAJt8
Message-ID: <CAJ+F1CKFxUDbx2ZG43Y8xMLkwxLs=3NWoX56khejGPRTB69o=Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] tests/lcitool: drop 64 bit guests from i686 cross
 build
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 1, 2025 at 9:12=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> With only TCG available we can't support 64 bit guests on a 32 bit
> host.
>
> Fixes: 5c27baf9519 (docs/about/deprecated: Deprecate 32-bit x86 hosts for=
 system emulation)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
>  tests/lcitool/refresh                             | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/do=
cker/dockerfiles/debian-i686-cross.docker
> index 4e8b3a8293d..2998764065f 100644
> --- a/tests/docker/dockerfiles/debian-i686-cross.docker
> +++ b/tests/docker/dockerfiles/debian-i686-cross.docker
> @@ -178,7 +178,7 @@ ENV ABI "i686-linux-gnu"
>  ENV MESON_OPTS "--cross-file=3Di686-linux-gnu"
>  ENV RUST_TARGET "i686-unknown-linux-gnu"
>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Di686-linux-gnu-
> -ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-l=
inux-user
> +ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 645959318a3..185a47cebe6 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -216,8 +216,6 @@ try:
>      generate_dockerfile("debian-i686-cross", "debian-13",
>                          cross=3D"i686",
>                          trailer=3Dcross_build("i686-linux-gnu-",
> -                                            "x86_64-softmmu,"
> -                                            "x86_64-linux-user,"
>                                              "i386-softmmu,i386-linux-use=
r"))
>
>      # mips no longer supported in debian-13
> --
> 2.47.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

