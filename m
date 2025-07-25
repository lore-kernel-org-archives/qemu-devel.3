Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C38C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufH4K-0002Eg-6q; Fri, 25 Jul 2025 07:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufH3x-0000JU-FD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:58:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufH3r-0003It-AF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:58:07 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-612a338aed8so3265657a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753444678; x=1754049478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDzq84X3al9Fq0d4saSA7ND4nlFnJzpOxnoSzp0c3YI=;
 b=f0XLEsHmk9LtkVByMb0AxgHh4Xej4ypOTNdPpTLLmJAafejnx5lcZz7+Ez3Hu4vrfp
 Ib7nVWAkgS4UDNZkLPwmGNhwT48fnjbypmAbzOnSnallMl+C2Nvjdzh7GCm1AyDMsowa
 x2leWp+NttU7w0w091sTr3IyuYidbs/vChxIA9QIiJG5zdvgRsmvpPu6hFXpnlCnwp5e
 FNOJ2ZzhGvHflwxVlCbTeg5so80l/QHnbUfKR6VXnuXzEQy/QByp6wDAnAv6Lz2oCz56
 2TxXu8ZaK9HOshYrZKVKXDVktXmkBgrR1u4cgW4VqpKhdYmjmxXUh1XISW94xYeDTgAq
 njCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753444678; x=1754049478;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDzq84X3al9Fq0d4saSA7ND4nlFnJzpOxnoSzp0c3YI=;
 b=wku/UpljXQfoo8yl0GGxroIGEu1bydNQIYoVkFuA5GNdZVs37VZFC2CNqIXb9wAOeP
 IZIPDh5yEXuKG1ouLhkUa/4n+FpvqBSCPH2uwDzTE9wxeV7YxaG5Nn1zxqyTF2WwFsS8
 zif2dmSwP3yHDGGSrsCp0c18QtoLMWvtGAGEDeYOH68jZ0oK4Q3OtkHoO+1EDIOtOebC
 Vd0G/h3zJlQe50Ag5L9TXDFa97gCbcShZnYaD460+eAvS4NlVjcj5uRYycefVDNBLHau
 azJ1JKoNDNHHd8V0jYbnWCxltyurizviscfgFUoeR1HMtAgaYDoACpPEQ2IHYuPS3iQw
 oXBQ==
X-Gm-Message-State: AOJu0Yx5RXCYrc8R7ASD6Mh6JS+9bHRQR0zEoaTaThR+wblHO9nlo+ex
 mdF7jvjvHUjpLU9vC4O5Rv+0V/XIeONh8VhbyN8LGYGKI8rvBBi7aWyxlChgWd9b5YQ=
X-Gm-Gg: ASbGncv/WAljSQwK7Cxk2OWybvgeAK2q+YvJj7H/lEPkjn8Uohh5rpGQtrgrngw9fbX
 REh8XQnffrL85gujwYXRiQGzCvDRDxiliPRxAvIxYF55B6kQBAuV49VvYflZWGOAplGSnZSy33h
 bsCyrDFu9/OxgQCXnajXYtyVqbRhxkfI0I0xH3iqmxJiP4rx85+rP1Uq48r4WumSSI9s5JlK7mi
 epv+8okaLM1iwVWCVsWRvH2E00qxw0WBLE2iykRI3TOOIm3X+admrUS2+kR8r4PJpFg+RvFswuw
 9rO+6v2/BLYjFBVOFW43mhpZa3d/9ZriYQZQcHep6dIxZLQ9/yVl9OS7aRzi/AleKpOFPiaz5G2
 wR4F0LJ+9zS8iYQCVNtLXAno=
X-Google-Smtp-Source: AGHT+IGeyZnjG4MfPm56/RNbu7MUJ/ajPSi+z8q79JkTkH9EkWUpHGV41yntXEbi6VFTEejQ+jdR2A==
X-Received: by 2002:a05:6402:2685:b0:607:6619:1092 with SMTP id
 4fb4d7f45d1cf-614f1bd9142mr1691208a12.13.1753444677627; 
 Fri, 25 Jul 2025 04:57:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd0f9243sm2023421a12.23.2025.07.25.04.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:57:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3D425F7EE;
 Fri, 25 Jul 2025 12:57:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection
 for all-test-cross
In-Reply-To: <CAAjaMXaUefn-3tYXgV5itg_=rg4_hwqRAugO_nHHM7RD3v1Nsw@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 24 Jul 2025 15:49:24 +0300")
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-14-alex.bennee@linaro.org>
 <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
 <875xfhvk98.fsf@draig.linaro.org>
 <CAAjaMXaUefn-3tYXgV5itg_=rg4_hwqRAugO_nHHM7RD3v1Nsw@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 25 Jul 2025 12:57:55 +0100
Message-ID: <87v7ngscsc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, Jul 24, 2025 at 3:36=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@=
linaro.org> wrote:
>> >>
>> >> When building on non-x86 we get a bunch but not all of the compilers.
>> >> Handle this in the Dockerfile by probing the arch and expanding the
>> >> list available.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++-------=
--
>> >>  1 file changed, 17 insertions(+), 14 deletions(-)
>> >>
>> >> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/=
tests/docker/dockerfiles/debian-all-test-cross.docker
>> >> index 5aa43749ebe..16a83241270 100644
>> >> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>> >> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> >> @@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> >>          bison \
>> >>          ccache \
>> >>          clang  \
>> >> +        dpkg-dev \
>> >>          flex \
>> >> +        gcc \
>> >>          git \
>> >>          libclang-rt-dev \
>> >>          ninja-build \
>> >> @@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> >>          python3-venv \
>> >>          python3-wheel
>> >>
>> >> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> >> -        apt install -y --no-install-recommends \
>> >> -        gcc-aarch64-linux-gnu \
>> >> +# All the generally available compilers
>> >> +ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>> >>          libc6-dev-arm64-cross \
>> >>          gcc-arm-linux-gnueabihf \
>> >>          libc6-dev-armhf-cross \
>> >> -        gcc-hppa-linux-gnu \
>> >> -        libc6-dev-hppa-cross \
>> >> -        gcc-m68k-linux-gnu \
>> >> -        libc6-dev-m68k-cross \
>> >>          gcc-mips-linux-gnu \
>> >>          libc6-dev-mips-cross \
>> >>          gcc-mips64-linux-gnuabi64 \
>> >> @@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> >>          libc6-dev-mips64el-cross \
>> >>          gcc-mipsel-linux-gnu \
>> >>          libc6-dev-mipsel-cross \
>> >> -        gcc-powerpc-linux-gnu \
>> >> -        libc6-dev-powerpc-cross \
>> >> -        gcc-powerpc64-linux-gnu \
>> >> -        libc6-dev-ppc64-cross \
>> >>          gcc-powerpc64le-linux-gnu \
>> >>          libc6-dev-ppc64el-cross \
>> >>          gcc-riscv64-linux-gnu \
>> >>          libc6-dev-riscv64-cross \
>> >>          gcc-s390x-linux-gnu \
>> >> -        libc6-dev-s390x-cross \
>> >> -        gcc-sparc64-linux-gnu \
>> >> -        libc6-dev-sparc64-cross && \
>> >> +        libc6-dev-s390x-cross
>> >> +
>> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
>> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
>> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; =
fi
>> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; =
fi
>> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=
=3D"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; =
fi
>> >> +
>> >> +RUN echo "compilers: ${AVAILABLE_COMPILERS}"
>> >
>> > Nitpick, each `RUN` command will create a new cached layer for the
>> > container build. It makes more sense to fold them in a single `RUN`
>> > step to avoid unnecessary layers. Does not make a big difference so
>> > feel free to ignore.
>>
>> I did try to figure out how to do a multi-line shell with an env
>> expansion but wasn't able to get the escaping right. If you can suggest
>> the right runes please do ;-)
>
> Like this?
>
> RUN if dpkg-architecture -e amd64; then \
>   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
>   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
>   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
>   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
>   export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
> gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
>   fi && \
>   echo "compilers: ${AVAILABLE_COMPILERS}"
>

Nope, the continuation has to run for all the lines of the RUN
statement.

  Processing triggers for libc-bin (2.36-9+deb12u10) ...
  --> 703d5c21c6e4
  STEP 5/18: ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu         libc6-de=
v-arm64-cross         gcc-arm-linux-gnueabihf         libc6-dev-armhf-cross=
         gcc-mips-linux-gnu         libc6-dev-mips-cross         gcc-mips64=
-linux-gnuabi64         libc6-dev-mips64-cross         gcc-mips64el-linux-g=
nuabi64         libc6-dev-mips64el-cross         gcc-mipsel-linux-gnu      =
   libc6-dev-mipsel-cross         gcc-powerpc64le-linux-gnu         libc6-d=
ev-ppc64el-cross         gcc-riscv64-linux-gnu         libc6-dev-riscv64-cr=
oss         gcc-s390x-linux-gnu         libc6-dev-s390x-cross
  --> e6fa99881c94
  STEP 6/18: RUN if dpkg-architecture -e amd64; then   export AVAILABLE_COM=
PILERS=3D"${AVAILABLE_COMPILERS}
  /bin/sh: 1: Syntax error: Unterminated quoted string
  Error: building at STEP "RUN if dpkg-architecture -e amd64; then   export=
 AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}": while running runtime: exi=
t status 2
  make: *** [tests/docker/Makefile.include:40: docker-image-debian-all-test=
-cross] Error 2

>
>>
>> >
>> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> >
>> >> +
>> >> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> >> +        apt install -y --no-install-recommends \
>> >> +        ${AVAILABLE_COMPILERS} && \
>> >>          dpkg-query --showformat '${Package}_${Version}_${Architectur=
e}\n' --show > /packages.txt
>> >>
>> >>
>> >> --
>> >> 2.47.2
>> >>
>> >>
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

