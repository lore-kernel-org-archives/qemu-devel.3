Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7976D4A5FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 05:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcFy-0005yW-Pt; Fri, 16 Jan 2026 00:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcFt-0005xz-AF
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:20:17 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vgcFp-0003oI-KL
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:20:17 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-11f1fb91996so3950209c88.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 21:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768540807; x=1769145607; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RD1J4BogNFF21DlCmqH6QaTA3hy6UqdyiGX1UJGq3ag=;
 b=HKfIslDoYETjtzxOiSU6lMW3w1KYVo/kGWgzQqFWNXuvgk2ho0zPz/fJixGiQHxyjM
 096/XIEyZz5L9jo03jvun5b0BxvJdGGw5M6rqOtA1ehTThP94dMECwQxw4qXzQHFj8IV
 tg9pXG1iomyWPEk4gK00m6r5MezDsGDyAyZBIlMfLIixX8EBCDh9esW0tqIKpInMlaaY
 ZSNF3W5uQKY/HfCzBN3ddPnl4ZuWT8AQUfrZWzsNU51vwyv3L/U/0hNcmC3lFpMpV8Jq
 DYNuGHimXkOQS+V2fhdwTBtX2LmrXbPGg6eMQ87oqSf9APbKdKVefgNPsdiz+IBUSv82
 +xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768540807; x=1769145607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RD1J4BogNFF21DlCmqH6QaTA3hy6UqdyiGX1UJGq3ag=;
 b=iqwGtH2maNc/8i8yKXgHIyevGZ3AFSUIFY5lCgNEyb4P8DTLUEIoFvv2Jtgle421ey
 2OAFRe07zRkFsD1Vw3nNHIv/P+fz1Js9HPkd8MoyQQH4OvXo0p3cFf1u9NEvqbCltq4U
 olhjqo0IlukzNLdKH68Wpk3rurlZuHDnTUuodCYMyDbEBvovfoEuHNb2PD2fMc9AVe3q
 Va3hRoTre+tdXSM4LRzZ5ov2KTvSurl0dCFsukyyYfyXFnE+gfYcEjRwvX4YxlYEbcnH
 TzPfUrJkNWfydi5c7k0mf6sm23LFqBxy0zk6W187Iy3Xvl1251L6db8TFb1aqkbTb7an
 x4Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWDfDvDyJZuZQMIgYvdg9m1crmmOikRuFDGif67faWDMgsxSd+mMYtd37ZWDq6HsjihLqxXkiWKkXW@nongnu.org
X-Gm-Message-State: AOJu0Yz71xBI8d2Q0fvoEWhK2itQvIjpd+1ZQSkhPer3fIjEFAKVwqG2
 1FMmPPv2wdzXslIK1ErJcMAkcMdpXSYrkAdIvY1Ost1TukRZiieiZmTUvwrHqF2vbK88VzF9/ev
 6gQ3waJXxu+fnZnraR8Cc03xyMKfXOUo=
X-Gm-Gg: AY/fxX7z87Vjt7rdliMtW/nXWdBAC/uvMXB9xoYA7F02OxLw0zaeeqBpGUQp3YdDT+V
 3oSj+U2k/Lj6k0wPYoSpuWRELn4OaGD4uCwBtIxXVaJ3WIc28q1tTboZOAPwRanNmivDXUDnoUC
 hc/s0nY6FuV9dLB+v1TpE3OKxP42ymLDA+YCI3k4DHrPuad17cjLnxDi9PiHfp9IMfBrFOF9hzc
 FzTEvgsFFQbCvftJL+OSNa+LEhWAFZnr0rsMZr3adPdfcoCVBBYivfV8jHB89JZKXalUqKgV+nf
 aCoaqjxZqZqn8pswwDvsd1y/4Q==
X-Received: by 2002:a05:7022:6290:b0:11a:e426:911a with SMTP id
 a92af1059eb24-1244b335c09mr1468644c88.15.1768540806967; Thu, 15 Jan 2026
 21:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-7-richard.henderson@linaro.org>
In-Reply-To: <20260116033305.51162-7-richard.henderson@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 16 Jan 2026 14:19:55 +0900
X-Gm-Features: AZwV_QibTEmu-3ot-DrD5LvmaWCi7s6o_ApUY7l4M6Tka39x-FyuXbTo8fey5Xw
Message-ID: <CAEDrbUY85LNotYo+E+nvSYvnyWwKbRdUedop6_uktR=McSU6iA@mail.gmail.com>
Subject: Re: [PATCH v2 06/58] tests/docker/dockerfiles: Drop wasm32 from
 emsdk-wasm-cross.docker
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, pierrick.bouvier@linaro.org, thuth@redhat.com, 
 pbonzini@redhat.com, philmd@linaro.org
Content-Type: multipart/alternative; boundary="00000000000091f37f06487a7ebc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000091f37f06487a7ebc
Content-Type: text/plain; charset="UTF-8"

> We will no longer build wasm32, so drop the docker config.
> Streamline the dockerfile to hardcode TARGET_CPU as wasm64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .gitlab-ci.d/container-cross.yml                 |  1 -
>  tests/docker/dockerfiles/emsdk-wasm-cross.docker | 15 ++++-----------
>  2 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/.gitlab-ci.d/container-cross.yml
b/.gitlab-ci.d/container-cross.yml
> index 6bdd482b80..b376c837dc 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -90,5 +90,4 @@ wasm64-emsdk-cross-container:
>    extends: .container_job_template
>    variables:
>      NAME: emsdk-wasm64-cross
> -    BUILD_ARGS: --build-arg TARGET_CPU=wasm64
>      DOCKERFILE: emsdk-wasm-cross
> diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker
b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
> index ecd5a02903..8a924816f9 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
> @@ -7,7 +7,6 @@ ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
>  ARG PIXMAN_VERSION=0.44.2
>  ARG FFI_VERSION=v3.5.2
>  ARG MESON_VERSION=1.5.0
> -ARG TARGET_CPU=wasm32
>
>  FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
>  ARG MESON_VERSION
> @@ -31,21 +30,16 @@ RUN mkdir /build
>  WORKDIR /build
>  RUN mkdir -p $TARGET
>
> -FROM build-base-common AS build-base-wasm32
> -
> -FROM build-base-common AS build-base-wasm64
> +FROM build-base-common AS build-base
>  ENV CFLAGS="$CFLAGS -sMEMORY64=1"
>  ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=1"
>  ENV LDFLAGS="$LDFLAGS -sMEMORY64=1"
> -
> -FROM build-base-${TARGET_CPU} AS build-base
> -ARG TARGET_CPU
>  RUN <<EOF
>  cat <<EOT > /cross.meson
>  [host_machine]
>  system = 'emscripten'
> -cpu_family = '${TARGET_CPU}'
> -cpu = '${TARGET_CPU}'
> +cpu_family = 'wasm64'
> +cpu = 'wasm64'
>  endian = 'little'
>
>  [binaries]
> @@ -67,14 +61,13 @@ RUN emconfigure ./configure --prefix=$TARGET --static
>  RUN emmake make install -j$(nproc)
>
>  FROM build-base AS libffi-dev
> -ARG TARGET_CPU
>  ARG FFI_VERSION
>  RUN mkdir -p /libffi
>  RUN git clone https://github.com/libffi/libffi /libffi
>  WORKDIR /libffi
>  RUN git checkout $FFI_VERSION
>  RUN autoreconf -fiv
> -RUN emconfigure ./configure --host=${TARGET_CPU}-unknown-linux \
> +RUN emconfigure ./configure --host=wasm64-unknown-linux \
>      --prefix=$TARGET --enable-static \
>      --disable-shared --disable-dependency-tracking \
>      --disable-builddir --disable-multi-os-directory \

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--00000000000091f37f06487a7ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; We will no longer build wasm32, so d=
rop the docker config.<br>&gt; Streamline the dockerfile to hardcode TARGET=
_CPU as wasm64.<br>&gt; <br>&gt; Signed-off-by: Richard Henderson &lt;<a hr=
ef=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>=
&gt;<br>&gt; ---<br>&gt; =C2=A0.gitlab-ci.d/container-cross.yml =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0tes=
ts/docker/dockerfiles/emsdk-wasm-cross.docker | 15 ++++-----------<br>&gt; =
=C2=A02 files changed, 4 insertions(+), 12 deletions(-)<br>&gt; <br>&gt; di=
ff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.=
yml<br>&gt; index 6bdd482b80..b376c837dc 100644<br>&gt; --- a/.gitlab-ci.d/=
container-cross.yml<br>&gt; +++ b/.gitlab-ci.d/container-cross.yml<br>&gt; =
@@ -90,5 +90,4 @@ wasm64-emsdk-cross-container:<br>&gt; =C2=A0 =C2=A0extend=
s: .container_job_template<br>&gt; =C2=A0 =C2=A0variables:<br>&gt; =C2=A0 =
=C2=A0 =C2=A0NAME: emsdk-wasm64-cross<br>&gt; - =C2=A0 =C2=A0BUILD_ARGS: --=
build-arg TARGET_CPU=3Dwasm64<br>&gt; =C2=A0 =C2=A0 =C2=A0DOCKERFILE: emsdk=
-wasm-cross<br>&gt; diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.=
docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker<br>&gt; index ecd=
5a02903..8a924816f9 100644<br>&gt; --- a/tests/docker/dockerfiles/emsdk-was=
m-cross.docker<br>&gt; +++ b/tests/docker/dockerfiles/emsdk-wasm-cross.dock=
er<br>&gt; @@ -7,7 +7,6 @@ ARG GLIB_VERSION=3D${GLIB_MINOR_VERSION}.0<br>&g=
t; =C2=A0ARG PIXMAN_VERSION=3D0.44.2<br>&gt; =C2=A0ARG FFI_VERSION=3Dv3.5.2=
<br>&gt; =C2=A0ARG MESON_VERSION=3D1.5.0<br>&gt; -ARG TARGET_CPU=3Dwasm32<b=
r>&gt; <br>&gt; =C2=A0FROM <a href=3D"http://docker.io/emscripten/emsdk:$EM=
SDK_VERSION_QEMU">docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU</a> AS bui=
ld-base-common<br>&gt; =C2=A0ARG MESON_VERSION<br>&gt; @@ -31,21 +30,16 @@ =
RUN mkdir /build<br>&gt; =C2=A0WORKDIR /build<br>&gt; =C2=A0RUN mkdir -p $T=
ARGET<br>&gt; <br>&gt; -FROM build-base-common AS build-base-wasm32<br>&gt;=
 -<br>&gt; -FROM build-base-common AS build-base-wasm64<br>&gt; +FROM build=
-base-common AS build-base<br>&gt; =C2=A0ENV CFLAGS=3D&quot;$CFLAGS -sMEMOR=
Y64=3D1&quot;<br>&gt; =C2=A0ENV CXXFLAGS=3D&quot;$CXXFLAGS -sMEMORY64=3D1&q=
uot;<br>&gt; =C2=A0ENV LDFLAGS=3D&quot;$LDFLAGS -sMEMORY64=3D1&quot;<br>&gt=
; -<br>&gt; -FROM build-base-${TARGET_CPU} AS build-base<br>&gt; -ARG TARGE=
T_CPU<br>&gt; =C2=A0RUN &lt;&lt;EOF<br>&gt; =C2=A0cat &lt;&lt;EOT &gt; /cro=
ss.meson<br>&gt; =C2=A0[host_machine]<br>&gt; =C2=A0system =3D &#39;emscrip=
ten&#39;<br>&gt; -cpu_family =3D &#39;${TARGET_CPU}&#39;<br>&gt; -cpu =3D &=
#39;${TARGET_CPU}&#39;<br>&gt; +cpu_family =3D &#39;wasm64&#39;<br>&gt; +cp=
u =3D &#39;wasm64&#39;<br>&gt; =C2=A0endian =3D &#39;little&#39;<br>&gt; <b=
r>&gt; =C2=A0[binaries]<br>&gt; @@ -67,14 +61,13 @@ RUN emconfigure ./confi=
gure --prefix=3D$TARGET --static<br>&gt; =C2=A0RUN emmake make install -j$(=
nproc)<br>&gt; <br>&gt; =C2=A0FROM build-base AS libffi-dev<br>&gt; -ARG TA=
RGET_CPU<br>&gt; =C2=A0ARG FFI_VERSION<br>&gt; =C2=A0RUN mkdir -p /libffi<b=
r>&gt; =C2=A0RUN git clone <a href=3D"https://github.com/libffi/libffi">htt=
ps://github.com/libffi/libffi</a> /libffi<br>&gt; =C2=A0WORKDIR /libffi<br>=
&gt; =C2=A0RUN git checkout $FFI_VERSION<br>&gt; =C2=A0RUN autoreconf -fiv<=
br>&gt; -RUN emconfigure ./configure --host=3D${TARGET_CPU}-unknown-linux \=
<br>&gt; +RUN emconfigure ./configure --host=3Dwasm64-unknown-linux \<br>&g=
t; =C2=A0 =C2=A0 =C2=A0--prefix=3D$TARGET --enable-static \<br>&gt; =C2=A0 =
=C2=A0 =C2=A0--disable-shared --disable-dependency-tracking \<br>&gt; =C2=
=A0 =C2=A0 =C2=A0--disable-builddir --disable-multi-os-directory \<br><br>R=
eviewed-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">=
ktokunaga.mail@gmail.com</a>&gt;</div></div>

--00000000000091f37f06487a7ebc--

