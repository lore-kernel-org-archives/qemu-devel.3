Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B9C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHpQ-0007ka-0U; Fri, 25 Jul 2025 08:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufHpK-0007c2-DT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:47:08 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufHpH-0006K9-UO
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:47:06 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso3805118a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753447621; x=1754052421; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upNuj9KaC5+zlU1E688mzOCPe/mp0iOJhSWj8QnXfGs=;
 b=peGI28RS0gCfHPkZZATearn0F1xUtuNbCAou1JtBqGDWGrZim04IRpbQobmmBA/r+q
 BSeT3oxR33Whx0YUuKVp+WCRuFcZnvFj6cfbXNCuW5y7Xc8u3RLrBz1RU4FY+9cgBJta
 BsJ+Gi4usKQF7fo+J3qya2/JUinoUpFrUutfqqfpcxEz2wFhUkArxlY9cAQzfxxUJzXV
 VA1wZdmFFfyZP/b2UM1kUFsCWqaR1VU49YKu50waDQQvVEhuxw+Z2TUfeZ/iSdx0LG5Y
 2HdlzzQRYNCLPZ3kFix0SIY9VWir5zyGwbrAyrFQ9Bx1ypnVIMogXKQuAT7H/31bPvmK
 dcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753447621; x=1754052421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upNuj9KaC5+zlU1E688mzOCPe/mp0iOJhSWj8QnXfGs=;
 b=iHuujyMpTyPBlqkUB1CUa0itPecewXcm60IJ3HprbfzIaSMJt9ZW98f+zKguHq8f3k
 9yriXuICPov+pF+EPYiLaghP1hHkxPIK2lwjaHvE13gQHDXgOOVJPJzwKYchsvkKFMQ+
 weQHanDY+RwsE8bGn5moloetsqmMtHtpud/5jtIDFI4JPBXsTwMnWZV6yTtewFGHYbOD
 SEQgguzE8AeQN2cinJCmFATjQVyqpFDcV9anTj+wXgtRJ8U6Fi+/Wm72lT05fUm9jCiH
 UgV8jIGrVQNph4ABwmynWXlidfbZST0WXQWJciCZisvkV5aqQcVWJfPckNRPIglJhB6g
 N5fQ==
X-Gm-Message-State: AOJu0YyAgVKVfUkj6NA34PJLnXaLyTpVVOb8KXNKGt9x8YqYE2eEi9tH
 8AVxf+YWzphiYA4ExYq8nKLnVPCK+/chmf3XHz4gxfU1EMCavuF6dtwxkJ03q8cJCj1zCW0dc/s
 24PBcU+1sRai55Hh1ggLJJxHXeNe2wEtF/puonideiw==
X-Gm-Gg: ASbGncuDVJ64LsfnZXJOjzfBYB9HZ9klRz16ONgoqGpUqxhsiQmXx3XUibqd8RsydZ9
 DeUOn3tSiveony+pKORoiFpx19NddrW9jx2/lBkLa4nbR1Z3JzF2Nkd/fm8tESlx+JlBODFpSdH
 JijgA6Ggv8r857JFqbVfEXWRcKcelND0EGTlhB1itAB6KrYy1XMzfSeCHD+nLA8gF8voACUMxrO
 oK9aA==
X-Google-Smtp-Source: AGHT+IEXKmhyDe6dzT0SgK+GrWFKKAs13xMV8dgdnoqGA7TnSiWCY3oHX1RYYhE/7pWIhMzyFaUFOWGFcnOOiuih9NI=
X-Received: by 2002:a05:6402:84f:b0:607:f431:33fb with SMTP id
 4fb4d7f45d1cf-614f1bd5ef3mr1848180a12.3.1753447621403; Fri, 25 Jul 2025
 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-14-alex.bennee@linaro.org>
 <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
 <875xfhvk98.fsf@draig.linaro.org>
 <CAAjaMXaUefn-3tYXgV5itg_=rg4_hwqRAugO_nHHM7RD3v1Nsw@mail.gmail.com>
 <87v7ngscsc.fsf@draig.linaro.org>
In-Reply-To: <87v7ngscsc.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 15:46:34 +0300
X-Gm-Features: Ac12FXxsn4q4HnHHZSJ-xDYItFwcp2PrScv8MqtYDel9zhB9zwzD-iOONbQ1uX4
Message-ID: <CAAjaMXZThujp_JZYKBijg2dkqQpBfkxaswsmyxUvRCN+ZcTnyA@mail.gmail.com>
Subject: Re: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection
 for all-test-cross
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, Jul 25, 2025 at 2:57=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > On Thu, Jul 24, 2025 at 3:36=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >>
> >> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >>
> >> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.benne=
e@linaro.org> wrote:
> >> >>
> >> >> When building on non-x86 we get a bunch but not all of the compiler=
s.
> >> >> Handle this in the Dockerfile by probing the arch and expanding the
> >> >> list available.
> >> >>
> >> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >> ---
> >> >>  .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++-----=
----
> >> >>  1 file changed, 17 insertions(+), 14 deletions(-)
> >> >>
> >> >> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker =
b/tests/docker/dockerfiles/debian-all-test-cross.docker
> >> >> index 5aa43749ebe..16a83241270 100644
> >> >> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> >> >> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> >> >> @@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >> >>          bison \
> >> >>          ccache \
> >> >>          clang  \
> >> >> +        dpkg-dev \
> >> >>          flex \
> >> >> +        gcc \
> >> >>          git \
> >> >>          libclang-rt-dev \
> >> >>          ninja-build \
> >> >> @@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata =
\
> >> >>          python3-venv \
> >> >>          python3-wheel
> >> >>
> >> >> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >> >> -        apt install -y --no-install-recommends \
> >> >> -        gcc-aarch64-linux-gnu \
> >> >> +# All the generally available compilers
> >> >> +ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
> >> >>          libc6-dev-arm64-cross \
> >> >>          gcc-arm-linux-gnueabihf \
> >> >>          libc6-dev-armhf-cross \
> >> >> -        gcc-hppa-linux-gnu \
> >> >> -        libc6-dev-hppa-cross \
> >> >> -        gcc-m68k-linux-gnu \
> >> >> -        libc6-dev-m68k-cross \
> >> >>          gcc-mips-linux-gnu \
> >> >>          libc6-dev-mips-cross \
> >> >>          gcc-mips64-linux-gnuabi64 \
> >> >> @@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata =
\
> >> >>          libc6-dev-mips64el-cross \
> >> >>          gcc-mipsel-linux-gnu \
> >> >>          libc6-dev-mipsel-cross \
> >> >> -        gcc-powerpc-linux-gnu \
> >> >> -        libc6-dev-powerpc-cross \
> >> >> -        gcc-powerpc64-linux-gnu \
> >> >> -        libc6-dev-ppc64-cross \
> >> >>          gcc-powerpc64le-linux-gnu \
> >> >>          libc6-dev-ppc64el-cross \
> >> >>          gcc-riscv64-linux-gnu \
> >> >>          libc6-dev-riscv64-cross \
> >> >>          gcc-s390x-linux-gnu \
> >> >> -        libc6-dev-s390x-cross \
> >> >> -        gcc-sparc64-linux-gnu \
> >> >> -        libc6-dev-sparc64-cross && \
> >> >> +        libc6-dev-s390x-cross
> >> >> +
> >> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
> >> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
> >> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; =
fi
> >> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; =
fi
> >> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; =
fi
> >> >> +
> >> >> +RUN echo "compilers: ${AVAILABLE_COMPILERS}"
> >> >
> >> > Nitpick, each `RUN` command will create a new cached layer for the
> >> > container build. It makes more sense to fold them in a single `RUN`
> >> > step to avoid unnecessary layers. Does not make a big difference so
> >> > feel free to ignore.
> >>
> >> I did try to figure out how to do a multi-line shell with an env
> >> expansion but wasn't able to get the escaping right. If you can sugges=
t
> >> the right runes please do ;-)
> >
> > Like this?
> >
> > RUN if dpkg-architecture -e amd64; then \
> >   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> > gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
> >   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> > gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
> >   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> > gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
> >   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> > gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
> >   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> > gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
> >   fi && \
> >   echo "compilers: ${AVAILABLE_COMPILERS}"
> >
>
> Nope, the continuation has to run for all the lines of the RUN
> statement.

Sorry, it seems Gmail textwrapped the lines. The ones without
continuation should be merged with the following one.


>
>   Processing triggers for libc-bin (2.36-9+deb12u10) ...
>   --> 703d5c21c6e4
>   STEP 5/18: ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu         libc6-=
dev-arm64-cross         gcc-arm-linux-gnueabihf         libc6-dev-armhf-cro=
ss         gcc-mips-linux-gnu         libc6-dev-mips-cross         gcc-mips=
64-linux-gnuabi64         libc6-dev-mips64-cross         gcc-mips64el-linux=
-gnuabi64         libc6-dev-mips64el-cross         gcc-mipsel-linux-gnu    =
     libc6-dev-mipsel-cross         gcc-powerpc64le-linux-gnu         libc6=
-dev-ppc64el-cross         gcc-riscv64-linux-gnu         libc6-dev-riscv64-=
cross         gcc-s390x-linux-gnu         libc6-dev-s390x-cross
>   --> e6fa99881c94
>   STEP 6/18: RUN if dpkg-architecture -e amd64; then   export AVAILABLE_C=
OMPILERS=3D"${AVAILABLE_COMPILERS}
>   /bin/sh: 1: Syntax error: Unterminated quoted string
>   Error: building at STEP "RUN if dpkg-architecture -e amd64; then   expo=
rt AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}": while running runtime: e=
xit status 2
>   make: *** [tests/docker/Makefile.include:40: docker-image-debian-all-te=
st-cross] Error 2
>
> >
> >>
> >> >
> >> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >> >
> >> >> +
> >> >> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >> >> +        apt install -y --no-install-recommends \
> >> >> +        ${AVAILABLE_COMPILERS} && \
> >> >>          dpkg-query --showformat '${Package}_${Version}_${Architect=
ure}\n' --show > /packages.txt
> >> >>
> >> >>
> >> >> --
> >> >> 2.47.2
> >> >>
> >> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >> Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

