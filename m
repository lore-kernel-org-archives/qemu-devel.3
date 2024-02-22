Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EBBC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7PS-0004Ld-4s; Thu, 22 Feb 2024 06:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7PP-0004L5-UA
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:38:35 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7PN-0006yd-UU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:38:35 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso8677572a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708601912; x=1709206712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXv2bkch8+nR9c89c16LLN3ML9A1adGz0xTEYO7PrpQ=;
 b=pBEeAirpPKz2LSPW2xC4YVPOC/yVKIp+H9PXvrGYo9FrPDl1GteUcoKYws2tFztGQc
 AdMq94EXApD5BRsE3g1aRFYslIiH89KBg5aO4pork8FiFP+3YKEHN/K24cZiScHilwBj
 DFDl15yZ2KsXP2rmQVTMzB4AsQs3ubTbeAnbc+6EqZUC+5QnQyreebLh0S9FMEbTLfJD
 17Lqe7RXlo2A58jYX2RYwb4cgadRmkbZWQA5jp3XVfEvNK62NdPFYZYX2uRRjIJPCG95
 N6iE8lBPFJQTJddKY/I2S8ZKCzzx7Lovfx2FoECNB74/4Eq8j24izuH2h7X0ylRimvgs
 cNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708601912; x=1709206712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXv2bkch8+nR9c89c16LLN3ML9A1adGz0xTEYO7PrpQ=;
 b=j2LWkQzgMaut4ipzUVa3P1SWBKUHtvGURKHIpEiksP4LwqzzkWSEWwZH1FvdxvOBIQ
 uc+WxO/C/IQ2EXBXs7ivRUjHcY7bIWUebwmMLlxczOFZozfGG1dPDACg5UZOSFpX/09p
 HMMPF2gAkqUjYAd8S8V4mvzJYhZV6c3pJPYSsD/ZYJSJqENbMF0IOojJYNJ3VveJr3m0
 7h9fcF1q875fgWfUyqEnWn5pgcCfE3CDnfl7mJ4tt/gX+j4/frCiT3N7MXgJ7S2Bz0nZ
 3XG6ZpxKRDv/ZWy8uGkdWjDbkZVX6IbqjwEuufj6n+9Wx4JI1cFIt2y4OqZ5HHvdQrKI
 lQfg==
X-Gm-Message-State: AOJu0Yw6ICbmwvih8n0XjUICyKXSa5RPbTZoytfp/hzXgl+QbueVg6il
 ycjfngS1lx6B5woSSCIKRQgxX3RUE2kFFl4lZETbo+UYxle+yDU2q85wA0LHmrEC003vLtrVZVF
 iAiKIY8/tC7vQlgGef+n6I/8eYqSX7NuEzj7dRQ==
X-Google-Smtp-Source: AGHT+IFp6xTu/klY5UQo/9LK+kGQW6fDBnxXpbeeNl/5q7c2GKmfr9HKjCdK6qwRjH/tUPFaHGPlo1PgxMEpuicpcq8=
X-Received: by 2002:a05:6402:5246:b0:565:2183:d296 with SMTP id
 t6-20020a056402524600b005652183d296mr2236133edd.27.1708601912023; Thu, 22 Feb
 2024 03:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-4-peter.maydell@linaro.org>
 <e434d7fc-d215-4537-b594-784155ebadfb@linaro.org>
In-Reply-To: <e434d7fc-d215-4537-b594-784155ebadfb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 11:38:21 +0000
Message-ID: <CAFEAcA-rqXQ_mEmLk4HJf8jnYPqTFBG2rkvb360BOE+vOywVDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 18:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/2/24 18:44, Peter Maydell wrote:
> > Now we don't build msys2-32bit we don't need the abstraction out of the
> > common msys2 handling from the 32-vs-64-bit specifics. Collapse it
> > down into the msys2-64bit job definition.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++--------------------=
-
> >   1 file changed, 40 insertions(+), 44 deletions(-)
> >
> > diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> > index 8fc08218d28..e784d5a68cd 100644
> > --- a/.gitlab-ci.d/windows.yml
> > +++ b/.gitlab-ci.d/windows.yml
> > @@ -1,4 +1,4 @@
> > -.shared_msys2_builder:
> > +msys2-64bit:
> >     extends: .base_job_template
> >     tags:
> >     - shared-windows
> > @@ -14,9 +14,19 @@
> >     stage: build
> >     timeout: 100m
> >     variables:
> > +    MINGW_TARGET: mingw-w64-x86_64
>
> You expanded $MINGW_TARGET so we can remove it.
>
> > +    MSYSTEM: MINGW64
> >       # This feature doesn't (currently) work with PowerShell, it stops
> >       # the echo'ing of commands being run and doesn't show any timing
> >       FF_SCRIPT_SECTIONS: 0
> > +    # do not remove "--without-default-devices"!
> > +    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by=
 using --without-default-devices"
> > +    # changed to compile QEMU with the --without-default-devices switc=
h
> > +    # for the msys2 64-bit job, due to the build could not complete wi=
thin
>
> s/the msys2 64-bit/this/, although it seems this sentence got truncated.

Looks like commit 11961d08fcbddf accidentally dropped a line
when refactoring the file; it should end:
  # the project timeout.

-- PMM

