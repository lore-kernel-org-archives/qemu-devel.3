Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953AF3D33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCHi-00082i-LZ; Thu, 05 Mar 2026 12:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCHg-000824-La
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:48 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCHe-0005ON-Ug
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:48 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso10254304d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772730886; cv=none;
 d=google.com; s=arc-20240605;
 b=LP/LdcncQczXk3EOsw86j47REqjHwZdQNdjK3kuh3W/FCYZ7ue0pZk/Ela/WmAHwPd
 9HDFBX4p90CCnsOm2ZXf2S0lV405yYcP540tg6+UpIrMBMvHNXdV7WeTbARB2X745xVg
 HC4+ICIDTfwScGYSy+21YOq3cKTdGGbeLVnaTMdMZ7bH4VNHxjA1Ql+j0OnO8NhoG5ol
 FxGa+dpcNriRJPsbjLZ3EiSv8/yBQSBfgFtqcuvzurvApdpKCShC9x7RXEr9Q5TWKIVp
 txmEIOdSN1aA1oLbs5b1qM61BS9BNIovGHtKWjHeSL0Rap9+T3GHaJiaweV4Rf/DSYGR
 mwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3C1yWLF25aLc+4LPJd/Osdo3AdSB4W7k4hoLqnYQcvs=;
 fh=MDrv/iGjC9/T09ari9rQP2ZSJsJ6DYXPSlFFpFTnTDk=;
 b=Y/LVQOUMjCx6XXqV+kJwckpLLc3GyM3xxFtLItTN+YK33bfWSBezOi/3bFchLI4jvV
 IZVd2o+MT2attGvEcAVIv3qa+J0eBlDDGpgt2MAQMQPNaAYxNYiG0AYLxuY0tUY1fMhw
 CKZFt2J8lr0kEIGDebxno2dKUB0khAOc+8yUW3SRhcCWgN0YCZr4mfBJSQjlEepzELRv
 Lh0UtxU2NHn71a7aHxNseP4ALWMPgxQjljthmdw8xcroX9n3MUdDJ5rmIV5Rr5+nDonJ
 XcMdHrmlQUr1VV4RtP0fjxGCh+BdM17d8zhKYRY+qwNA1M6YpCDluaw4GEZcs4jN7dYi
 SisQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730886; x=1773335686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3C1yWLF25aLc+4LPJd/Osdo3AdSB4W7k4hoLqnYQcvs=;
 b=jmZ7g2NLP9hUP9vGesKMEbS729txoUc5Px5h2RE1D6gwGBmKwBpkZeQEHWDziNTPwd
 NTcRECLPy92jOxqCP8nXgB5B5ZGvu43b/13ckexhfBdcLQegNZI/6YvLxz0DST0g/q6Y
 0WfcIPJzQ88ysOB1U0QOda9TT8qrKzZk9ooVkmZw8ksSZSjIENaN28cFsJkgwrPKW8Am
 DbEm7wXa0rKx8TrkjItmHKfWlJloeFe/h58CqmxGZZhvGigVyrFtq/axK64bj2PpmTeB
 iclC2NAiZWbdtn1jVcjZWBGweAF9TcjoUIpikHX24MAclgo0xd5wblLzvEZTmV06kVb6
 vsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730886; x=1773335686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3C1yWLF25aLc+4LPJd/Osdo3AdSB4W7k4hoLqnYQcvs=;
 b=MI5K0+AH1KkJyb+3bMuDrwLfyDNtNaFM8/tcBdvICet/Qhv63iyXAJoyIu8JEPuS/M
 obvgutgxaWfuWrXTOU3tEKcnV0oFxYZveFoqo8ShUop1SvfGxJVK9G0bPLu4HPls5lng
 FwU8R443CKpB7p3GzdFGWFfbTHrqCKz6F9rmuKm4ojQpYO/ZIbpRKsP6AK/0Ypcbjm9p
 L9hNzNPW9X+EXyha6SrwYPBI8W1875eIRdMjTn6FgoCUgSf3Rx/0j4UtPQiif6lIvD12
 dufGxkDCflDT9wnXLar8e5NWkuDIIlyqpf/Iy5c0EkSC1Zu+ouXgxZyo5bYgykIsxhQE
 ORdw==
X-Gm-Message-State: AOJu0YzgSdawELArbkZ6m5pcrSKVK5TQh9Zkd685XOgYBbRvuWfTzpaY
 ibwh0ragYpVHopNPaPxmmRjSwsTMYlQhvOTXLJ+VM/O91IaJwcI+XxHkEjXgTuIqUD9UcS8hxdm
 S6pg45VS5i49Up/VSQQ56zk0YRandzZtPV//2R7H1SA==
X-Gm-Gg: ATEYQzxhqMt1pM2kGtO84F9vKLGvUxaQ3XUMQDiwSQFvF8cQfMuMi44UXm2fLrvK+Kg
 nUptfDF7aiAftztNVtxiXfXaeH9ZHrrjmiyok+XIU5PFGY0A3qXO8tox8q64OYhpsV0hMl4FOIy
 cAYifFkqN1qEpixZpxJZjQBztD2QBgIibf2irmuR6iswML/mra6oeX5LqoC0+kBh/Z+LqpjBpDh
 nibtdVPGeh39f6zYpw+KrDKpEnEYjVTw5RykpZwK/xZUP90ln0FoxRu4XNcI9KaKpyQIfh/FQVI
 ppatom8oW4OGEGJaSjrbc8/D7nuybe+w4fORyxPW2WKNJgJE5y2IFk/6eZkYPk6Ba7I=
X-Received: by 2002:a05:690e:1441:b0:644:7b19:c207 with SMTP id
 956f58d0204a3-64d0713dcf1mr2276151d50.38.1772730885701; Thu, 05 Mar 2026
 09:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
 <20260305-nvme-v4-4-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260305-nvme-v4-4-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 17:14:33 +0000
X-Gm-Features: AaiRm51JYwBXqMEjS-yZH8L1yCIn6dTuwgID5QnB7m8y6Z-TaTBj3M9clW8N5zg
Message-ID: <CAFEAcA8xx=h+HYyiemPSicXr6bdkFe+DMPjaSLxsvSDuRe9LqQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] meson: Add -Wformat-overflow=2
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 5 Mar 2026 at 06:19, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> w=
rote:
>
> https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Warning-Options.html
> > Level 2 warns also about calls that might overflow the destination
> > buffer given an argument of sufficient length or magnitude. At level
> > 2, unknown numeric arguments are assumed to have the minimum
> > representable value for signed types with a precision greater than 1,
> > and the maximum representable value otherwise. Unknown string
> > arguments whose length cannot be assumed to be bounded either by the
> > directive=E2=80=99s precision, or by a finite set of string literals th=
ey may
> > evaluate to, or the character array they may point to, are assumed to
> > be 1 character long.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index 414c8ea7e280..cf50bc492f9c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -692,6 +692,7 @@ warn_flags =3D [
>    '-Wempty-body',
>    '-Wendif-labels',
>    '-Wexpansion-to-defined',
> +  '-Wformat-overflow=3D2',
>    '-Wformat-security',
>    '-Wformat-y2k',
>    '-Wignored-qualifiers',

I can build with both gcc and clang with this extra warning enabled
without it falling over on anything else, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

