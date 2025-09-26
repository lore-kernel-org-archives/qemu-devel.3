Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D41CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Aew-0002f1-9c; Fri, 26 Sep 2025 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AeT-0002TL-1B
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:46:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AeC-0001nw-1H
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:46:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so16947715e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758901567; x=1759506367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqS3Goqj63+B1mgLpvk95pT/+QyQN2YsQObxw5uNn7U=;
 b=zMd3LX4zo+5jLYmO8hfdNoPawCZaqi3rxZWy+FxNfypv0eEgv6S2UDXFi3Y3LEHpuU
 L3b61vDnGfPshS+SNgnToR+3qY43GWUK+7J2rIqEFdvX6nMaM+lTy8kocvLGPalXVr6Y
 WrYjk/ifC9I2DtQ+Uwliqwk7wUzjPGGX+NSK106lfCgH2EWn6ywGooumoF31ohMPWIDk
 t1rly/TYmMQadehmioKik00jU9rSjcYslsX8Nk+0szuhGJ0lPbJZv+8HBzJMNDLN000+
 +dKM7H1VGt0y44HRogoCBJeZCljYySNzQOPPcOjnpU5V+4qnvGfJGLrB2NT3CsDyQDjL
 W2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901567; x=1759506367;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BqS3Goqj63+B1mgLpvk95pT/+QyQN2YsQObxw5uNn7U=;
 b=Wr0tP2xTIm/IwywWRfgA/kn4SoGOp5YYZhUl49NNXwtvgTOpIRMB3abdCTMLrHKVQI
 vHkm7zTZ9jGn3ca+bkxIvzPBmRYell91qolTkTifNF5aXxK5iZ/DFnS1IKDWKw8X6VC0
 lNIgraGGToQHggK3Bj6QetiPHj6djB0HOQVdh1hWbBXpPK0FUzBGOGQYR534UyGDasQm
 fMBpa2p2qlIm3FDPqBdUfib4docTclevDDCxfHwi4vOOkodKJrtuDQzXIuez8dobA7b1
 1AKoSsx5zIPmZDTpNPGQ5uB3NmLFeIQfAjwNp/oE/Fd4Wui0rp6pXHt9qrlxoVMMyoEQ
 hd4A==
X-Gm-Message-State: AOJu0YyXB77gB4KPgYwSQCIppkRahEabeMn/dxrXK4YXgrjZf1PqisTb
 I3giHPFYNNTphkf72vx2IMl+G4vGlWs4eSi3FcMMkztw/JF0+mwkJUdxQP7ZGU1kWbk=
X-Gm-Gg: ASbGncvfp1dPZVzGNpWF9W0xfsotSR0+ATWlkuYJklC/N9zEIFjaNx1sS6Kd9eYNNml
 2uoM9PKadd46mkloefJqkmUu56V+IwdgmlubeW3e8WNIxybjf3qiyeNQCu3+uwvpwGBNh1C46km
 Xx/hIe2LvxzWaGfN514ojNBSEUxRbvnzJuxezCFfxR5xVZREgNU52uVvNDvH53SU7U/kETycAWK
 O/VhEGfb8/1aWI3DWX4hG4Y3Jvy3bgdXvA0FOTLRC8JTgYoqrnvDpVY2RX+sJF0YMD35B3FKrmm
 rS3fluN6Qiah0tQJ/cVgnpEGL/o+gUK2fPmMnVhCS7KcSuPJXsnB+j1YhgRYi7fciJaLqWcwW/a
 uUFMSk+fx1DUQsXhBaG6vnaRahKF/ALHdijBKEmKxvEST
X-Google-Smtp-Source: AGHT+IHqWCxVCSqODhsJgXq9ydHALRRLegrZ5ZoHa2xPMSWyfFnTWGWu9DsCUBFvz21ElUZKAXATFQ==
X-Received: by 2002:a05:6000:22c7:b0:3ee:1563:a78b with SMTP id
 ffacd0b85a97d-40e4745e23dmr7505535f8f.20.1758901567448; 
 Fri, 26 Sep 2025 08:46:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e42eee0b6sm10693895e9.10.2025.09.26.08.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:46:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D7225F7C3;
 Fri, 26 Sep 2025 16:46:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  Yonggang Luo <luoyonggang@gmail.com>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Warner Losh <imp@bsdimp.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>,  devel@lists.libvirt.org,
 qemu-rust@nongnu.org,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 22/27] RFC: tests/docker: add rust to
 debian-legacy-test-cross
In-Reply-To: <20250924120426.2158655-23-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Wed, 24 Sep 2025 16:04:19 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-23-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 26 Sep 2025 16:46:06 +0100
Message-ID: <871pnti5dt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Unfortunately, debian 11 has bindgen version 0.55...
> Should we install it with cargo install bindgen-cli?

I wouldn't bother. This only exists for older targets that are either
linux-user or unlikely to get a rust version of any of their device
backends.

>
> Linking is still failing with -lrt, despite it being present in the link =
arguments...
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml                               | 2 +-
>  tests/docker/dockerfiles/debian-legacy-test-cross.docker | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index c3467200f4..34d8c1a496 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -389,7 +389,7 @@ build-legacy:
>    variables:
>      IMAGE: debian-legacy-test-cross
>      TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user
> -    CONFIGURE_ARGS: --disable-tools
> +    CONFIGURE_ARGS: --disable-tools --enable-rust
>      MAKE_CHECK_ARGS: check-tcg
>=20=20
>  build-user-hexagon:
> diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/t=
ests/docker/dockerfiles/debian-legacy-test-cross.docker
> index 5a6616b7d3..f9b31b0eab 100644
> --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> @@ -24,6 +24,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          apt install -y --no-install-recommends \
>          bison \
> +        cargo-web \
>          ccache \
>          clang  \
>          flex \
> @@ -36,14 +37,20 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          python3-pip \
>          python3-setuptools \
>          python3-venv \
> -        python3-wheel && \
> +        python3-wheel \
> +        rustc-web \
> +        && \
>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\n=
' --show > /packages.txt
>=20=20
> +ENV CARGO_HOME=3D/usr/local/cargo
> +RUN cargo install bindgen-cli
> +
>  RUN /usr/bin/pip3 install tomli
>=20=20
>  ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
>  ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
>  ENV MAKE /usr/bin/make
> +ENV PATH=3D$CARGO_HOME/bin:$PATH
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

