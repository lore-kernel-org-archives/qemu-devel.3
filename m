Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B3DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnwk-0005dB-NG; Wed, 03 Sep 2025 09:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1utnwe-0005al-Gd
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:54:41 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1utnwc-0002pL-FJ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:54:40 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4b32384e586so30646811cf.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756907676; x=1757512476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFOlvgvRlpuDjNUOH7VA/NtURUrolP2d9Qhif824Jgg=;
 b=Kaw2BFhych0fiY1Hv459LEqjAg+urot6KwrKEnVt2aOJ3TG5N4jcHZNRkg8dEihalv
 Xbz7/+hxmhLK9uY6VwKM+7WSVYtKXFYye3fGNsOSdO8TcwgWx8h535DdfGjdwk8amrRx
 hwImqdY7LbLes7PqUz6miZTvAqFc1fP3+QjFoHAFASF4wbfYNnI/C/1KeHJ3KfOHYKHK
 lFaoelytNLxDZ5D/iieEeJgfqf9+eR6dB7x7BPsXDmw+EmHD4qaWpwqQf5JeBcm13KRg
 L5FGaSYl3eUmYVJYqFN7jFpu/RrGfyc9xQo5boefOfYBgOGC+5T8J0cczVCE4lRxpNez
 5iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756907676; x=1757512476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFOlvgvRlpuDjNUOH7VA/NtURUrolP2d9Qhif824Jgg=;
 b=ZmqU/fOqUaOhpnJBGLrWgKjqImbjp8oqchlZ0NyLAOrRfJZDJGEdxsTOCYkGDq+PQT
 dDU6WSrGKlZbxgpdCmF/zlteXLZlXVYVavSPmSKjpcmH9x+XRBMTBMZ8oZTw3E4k/zUe
 hQnn3aEKE59fvEoUhCKtzcYfescZCx5b/BdPmRAda696Sc6X9lv7xZpqBUvImGI1JrNJ
 G3oZvRo8hoV+IBZkdwW7gTd7knm/UnLF3MsmcMO/upiGpPbdGmcEXznDOZHl3RJU7XIu
 crPveMGTVM+mMUm75VX6xFlwt/ZZGQSpW8hImG2UuOwnERUM2FbS5FG5VyABcN6kyJCZ
 NJ3g==
X-Gm-Message-State: AOJu0YzS8lzH47XYJXbLlso7imKGDisQ51jfFhpi8pCWzGHsfeFoWVVo
 6lwL+KBE4Fikwj3kzn87u4cOYHDbVo7EebgJp2Ajy0kw7CuE9QfEng+qsRKfk3piBgz0DPLGFpt
 Uj6khWQGc+XVqmkXEKFyfZjBzbh8KnaI=
X-Gm-Gg: ASbGnctxQ3mUxYeACtrHQohdsf86spghq5WwBxSH92Uo5Loxskq2ytMFUYnXOFvhBbC
 hmO/ChauNHnh1hNdEQ37fr1womBjInfNhnAddJLCZ58ZCto3oXFKgR80YlEd9b7mIPtX20TsVef
 f45epKHGWORqsbnFQEKndRtcUx3EOjKS/2KMr91heztd9BqOP5VA1alZYP8zwyq8HBxp9KJ4VAE
 EDsuTJNsqt2x5cwj/XfgGZ47eiRkCwbUA8b5rDs5DQfvPwMKhJOJgDtd6dsLg==
X-Google-Smtp-Source: AGHT+IGSKSCxhIQNS9FKQDGipRGGeoDlKwtvsKmTW2d+X4LFpOhQ0TYFBtNxRgAYS93d3TbPHMqeM9XfBY7REFBMSRk=
X-Received: by 2002:ac8:5789:0:b0:4b2:fd35:c687 with SMTP id
 d75a77b69052e-4b31da23858mr181568401cf.42.1756907675600; Wed, 03 Sep 2025
 06:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
In-Reply-To: <20250506152927.222671-2-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Sep 2025 17:54:24 +0400
X-Gm-Features: Ac12FXyH0MulOovghJbKqwXRuzA4ukEzyF7OOK-5yaIIJgtUlsmQSXL9hdEiNak
Message-ID: <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Paolo

On Tue, May 6, 2025 at 7:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Debian, the rustc-web package provides a newer Rust compiler (1.78)
> for all architectures except mips64el.

Unfortunately, rustc-web is not compatible with the cross/multiarch
packages (it will remove all libstd-rust-dev:*).

Should we switch to rustup in the meantime for debian cross-compilation tes=
ting?

>
> On Ubuntu, Rust versions up to 1.80 (?) are available as of this writing
> for both Jammy (22.04) and Noble (24.04).  However, the path to rustc
> and rustdoc must be provided by hand to the configure script using
> either command line arguments or environment variables.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/build-platforms.rst                        | 11 ++++++++---
>  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      |  2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        |  2 +-
>  tests/docker/dockerfiles/debian-amd64-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker     |  2 +-
>  tests/docker/dockerfiles/debian-mips64el-cross.docker |  2 +-
>  tests/docker/dockerfiles/debian-mipsel-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  |  2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian.docker                |  2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker            |  3 ++-
>  tests/lcitool/mappings.yml                            |  5 +++++
>  tests/lcitool/refresh                                 |  5 +++--
>  15 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.=
rst
> index c3651871d20..8ecbd6b26f7 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -118,9 +118,14 @@ Rust build dependencies
>    include bindgen or have an older version, it is recommended to install
>    a newer version using ``cargo install bindgen-cli``.
>
> -  Developers may want to use Cargo-based tools in the QEMU source tree;
> -  this requires Cargo 1.74.0.  Note that Cargo is not required in order
> -  to build QEMU.
> +  QEMU requires Rust 1.77.0.  This is available on all supported platfor=
ms
> +  with one exception, namely the ``mips64el`` architecture on Debian boo=
kworm.
> +  For all other architectures, Debian bookworm provides a new-enough Rus=
t
> +  compiler in the ``rustc-web`` package.
> +
> +  Also, on Ubuntu 22.04 or 24.04 this requires the ``rustc-1.77``
> +  (or newer) package.  The path to ``rustc`` and ``rustdoc`` must be
> +  provided manually to the configure script.
>
>  Optional build dependencies
>    Build components whose absence does not affect the ability to build QE=
MU
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/c=
i/setup/ubuntu/ubuntu-2204-aarch64.yaml
> index dbcd2e076de..f11e9808267 100644
> --- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
> +++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
> @@ -114,7 +114,7 @@ packages:
>    - python3-venv
>    - python3-yaml
>    - rpm2cpio
> -  - rustc
> +  - rustc-1.77
>    - sed
>    - socat
>    - sparse
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/=
setup/ubuntu/ubuntu-2204-s390x.yaml
> index 4b8ee3d885d..6559cb29343 100644
> --- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
> +++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
> @@ -112,7 +112,7 @@ packages:
>    - python3-venv
>    - python3-yaml
>    - rpm2cpio
> -  - rustc
> +  - rustc-1.77
>    - sed
>    - socat
>    - sparse
> diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/d=
ocker/dockerfiles/debian-amd64-cross.docker
> index 05355854285..081f3e00f7b 100644
> --- a/tests/docker/dockerfiles/debian-amd64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/d=
ocker/dockerfiles/debian-arm64-cross.docker
> index 6b1e4fc8279..91c555a36e9 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
> index cf0fe63af91..f0e2efcda09 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/do=
cker/dockerfiles/debian-i686-cross.docker
> index 1c84dfb9456..025beb1ce25 100644
> --- a/tests/docker/dockerfiles/debian-i686-cross.docker
> +++ b/tests/docker/dockerfiles/debian-i686-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/test=
s/docker/dockerfiles/debian-mips64el-cross.docker
> index 257204eae48..4a941dd870e 100644
> --- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/=
docker/dockerfiles/debian-mipsel-cross.docker
> index 395c84d65bc..4d3e5d711bd 100644
> --- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests=
/docker/dockerfiles/debian-ppc64el-cross.docker
> index 1ae227ccded..22b4457ba99 100644
> --- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
> index afa81a57ba8..13ec52c8ad0 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -50,7 +50,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/docker=
files/debian.docker
> index 5b3bac43ccb..0a57c1a1d37 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -122,7 +122,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-web \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/do=
ckerfiles/ubuntu2204.docker
> index 88ce4ef9a9d..4a1cf2bdff3 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -121,7 +121,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-venv \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc \
> +                      rustc-1.77 \
>                        sed \
>                        socat \
>                        sparse \
> @@ -150,6 +150,7 @@ ENV LANG "en_US.UTF-8"
>  ENV MAKE "/usr/bin/make"
>  ENV NINJA "/usr/bin/ninja"
>  ENV PYTHON "/usr/bin/python3"
> +ENV RUSTC=3D/usr/bin/rustc-1.77
>  ENV CARGO_HOME=3D/usr/local/cargo
>  ENV PATH=3D$CARGO_HOME/bin:$PATH
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 74eb13d62b6..673baf39367 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -64,6 +64,11 @@ mappings:
>    python3-wheel:
>      OpenSUSELeap15: python311-pip
>
> +  rust:
> +    Debian12: rustc-web
> +    Ubuntu2204: rustc-1.77
> +    Ubuntu2404: rustc-1.77
> +
>  pypi_mappings:
>    # Request more recent version
>    meson:
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index aa551aca9be..8474ea822f4 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -141,7 +141,8 @@ fedora_rustup_nightly_extras =3D [
>      'RUN $CARGO --list\n',
>  ]
>
> -ubuntu2204_bindgen_extras =3D [
> +ubuntu2204_rust_extras =3D [
> +    "ENV RUSTC=3D/usr/bin/rustc-1.77\n",
>      "ENV CARGO_HOME=3D/usr/local/cargo\n",
>      'ENV PATH=3D$CARGO_HOME/bin:$PATH\n',
>      "RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\\n",
> @@ -170,7 +171,7 @@ try:
>      generate_dockerfile("fedora", "fedora-40")
>      generate_dockerfile("opensuse-leap", "opensuse-leap-15")
>      generate_dockerfile("ubuntu2204", "ubuntu-2204",
> -                        trailer=3D"".join(ubuntu2204_bindgen_extras))
> +                        trailer=3D"".join(ubuntu2204_rust_extras))
>
>      #
>      # Non-fatal Rust-enabled build
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

