Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF8Bi-0008Cj-D0; Sat, 01 Nov 2025 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vF8Bg-0008CG-Qp
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:46:20 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vF8Be-000822-KO
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:46:20 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-87c1a760df5so52381166d6.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761990376; x=1762595176; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Lb3hpo7+EKHeNPYqW5iGgi40d2PaiZI+drdIl4ZXuM=;
 b=NHCcVxrKi3/qgbpWadKEF9yaQHcQYNlfF5/qDH6bp20PgSzQ7wq66ro4d02SluwJbg
 xo7zphhS4zuPirIy4otGMGFGFVBIIAVqu/ODoYt0jGDoJ93CpUm0s7qiN6OIplaZ8hGh
 mB5l19cNEYhBCQn8Kqtsowaxnv8zawDeoabEKXGw6a1svCBeFYgrWgbpj5N5Gfbc0/3A
 8KznaPqsWtoEQPO5Ew1qgEANCybSbwSKC3FG7TAdR8MH4KvTWoc4GU4zJMckllPq6pCW
 0rg2pSNlXH3szufvPWxaiRvE7ylIg03Y4MGqzUMtnR0ORg18gRHRa8peixCpbXn+c5+z
 l9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990376; x=1762595176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Lb3hpo7+EKHeNPYqW5iGgi40d2PaiZI+drdIl4ZXuM=;
 b=pb1oDUc1N6Ew8tJ0FcbjcOPNMh8ju4MElwVtEgcRSDDpMizhwNJL3z/QO4CL3PTy67
 bg1d6qVLagI7x2znWublmuXKkJ4sxoJrTOjvPfI7xnrKVU3UUu76LVb0Jx7I+CwxW5vF
 UYtvpjqbSnEA2ZJzwvwBed4SxS3zMV2eWxkUrEQ9WBZ6oDFn/IA10ZJfc9gqU5+3fmYs
 6qb744sVtPsfZq1c/sEznDOEeRkSD5xTJ5WsOyjjnjm/+4D6V8Hl28qBbBawWC4D2Gd9
 RtPFNmTYPm5bWHhZ1FmJVfxNFqI9BcnQxZoWKxj/mm54m/bjZRukXpy10BuRTNCvi/mJ
 QdWA==
X-Gm-Message-State: AOJu0YyRP55Y2EguZfurLRIjK1Eh92ywCYAwjzVxToF/u1y+YP7jvt8S
 iwh5GssDJvtPOMg2JuVA+mv1uZKbzLa3Cd90BrQn4Wx557a1ShAilmNlC1gWlms42og9VC0PPqN
 hcBtYOVoFucp5sPHbCDheFBFrC8ymGlU=
X-Gm-Gg: ASbGncs/IPuyeyhR5W5P+w2DgWXLyRmuCkEtuYZmy8D7v1628ncEtb1fPUza1ivgc0u
 4KxRnOZXYFVYbktOnlgJs1j9Cf96l6dd1LrIW0UG+l6dUBTS5xDiOr6lbV8HlklaMyA9wk+EuDd
 zIQ4Co7ZH0Q79ziZrbe6g12PyLCBJ1XIRWW/TrxkZ1cm5th+sUwb7oVSRKBmSJj0oa4ar4XPsEG
 OogtVcDP1eMev6LIIOj3y17ge0hgDc/SIQ2UyQ6kninl+To3TOLA4iY5dN1n67/+Qvt++YnW8ZQ
 ZQ==
X-Google-Smtp-Source: AGHT+IFf8EM6oBHMuG2Hmm+xhie/QeIs8p1NvGtHYSDnjWV+AnXQI+ZHINsCXqB1ewgCHj9QR3H/pmofTJ7mKjwAecY=
X-Received: by 2002:a05:6214:5288:b0:877:81d2:4c27 with SMTP id
 6a1803df08f44-8802f4ac09emr87238266d6.57.1761990375721; Sat, 01 Nov 2025
 02:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251031152639.294034-1-pbonzini@redhat.com>
In-Reply-To: <20251031152639.294034-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 1 Nov 2025 13:46:04 +0400
X-Gm-Features: AWmQ_bnpS44UMBo_cDaMajY0RaHP498_ZTQJemPaEPfPICashpfHgp0Q0MkKnD4
Message-ID: <CAJ+F1CLe0d=97syE-J8h9yGWAAz16NQ_dpYEbQvatS8vr3qU=Q@mail.gmail.com>
Subject: Re: [PATCH] rust: add back to Ubuntu 22.04 jobs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf34.google.com
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

Hi

On Fri, Oct 31, 2025 at 7:28=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Ubuntu is now including updated versions of Rust (up to 1.85) for
> its LTS releases.  Adjust the CI containers and re-add --enable-rust
> to the Ubuntu jobs.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/about/build-platforms.rst                   | 10 +++++-----
>  .gitlab-ci.d/buildtest.yml                       |  2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml |  2 +-
>  scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   |  2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker       |  6 +++---
>  tests/lcitool/mappings.yml                       |  4 ++--
>  tests/lcitool/refresh                            |  4 ++--
>  7 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.=
rst
> index fc2743658d4..e95784cdb55 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -117,14 +117,14 @@ Rust build dependencies
>    a newer version using ``cargo install bindgen-cli``.
>
>    QEMU requires Rust 1.83.0.  This is available on all supported platfor=
ms
> -  with two exception: Ubuntu LTS releases 22.04 and 24.04, and the
> -  ``mips64el`` architecture on Debian bookworm.  For all other
> +  except for the ``mips64el`` architecture on Debian bookworm.  For all =
other
>    architectures, Debian bookworm provides a new-enough Rust compiler
>    in the ``rustc-web`` package.
>
> -  It is expected that in the future Ubuntu will provide updated packages
> -  like the existing ``rustc-1.82`` package.  The path to ``rustc`` and
> -  ``rustdoc`` will have to be provided manually to the configure script.
> +  For Ubuntu 22.04 ("Jammy") and 24.04 ("Noble") updated versions of
> +  Rust are available through packages such as ``rustc-1.83`` package;
> +  the path to ``rustc`` and ``rustdoc`` has to be provided manually to
> +  the configure script.
>
>    Some distros prefer to avoid vendored crate sources, and instead use
>    local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes =
a
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 21f6d7e96fe..44df116139b 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -39,7 +39,7 @@ build-system-ubuntu:
>      - job: amd64-ubuntu2204-container
>    variables:
>      IMAGE: ubuntu2204
> -    CONFIGURE_ARGS: --enable-docs
> +    CONFIGURE_ARGS: --enable-docs --enable-rust
>      TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>      MAKE_CHECK_ARGS: check-build
>
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/c=
i/setup/ubuntu/ubuntu-2404-aarch64.yaml
> index ce632d97108..8c4b71b5942 100644
> --- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
> +++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
> @@ -119,7 +119,7 @@ packages:
>    - python3-wheel
>    - python3-yaml
>    - rpm2cpio
> -  - rustc-1.77
> +  - rustc-1.83
>    - sed
>    - socat
>    - sparse
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/=
setup/ubuntu/ubuntu-2404-s390x.yaml
> index f45f75c9602..2758f55e5a2 100644
> --- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
> +++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
> @@ -117,7 +117,7 @@ packages:
>    - python3-wheel
>    - python3-yaml
>    - rpm2cpio
> -  - rustc-1.77
> +  - rustc-1.83
>    - sed
>    - socat
>    - sparse
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/do=
ckerfiles/ubuntu2204.docker
> index b393db55a8c..602d4196249 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -124,7 +124,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-1.77 \
> +                      rustc-1.83 \
>                        sed \
>                        socat \
>                        sparse \
> @@ -155,8 +155,8 @@ ENV LANG "en_US.UTF-8"
>  ENV MAKE "/usr/bin/make"
>  ENV NINJA "/usr/bin/ninja"
>  ENV PYTHON "/usr/bin/python3"
> -ENV RUSTC=3D/usr/bin/rustc-1.77
> -ENV RUSTDOC=3D/usr/bin/rustdoc-1.77
> +ENV RUSTC=3D/usr/bin/rustc-1.83
> +ENV RUSTDOC=3D/usr/bin/rustdoc-1.83
>  ENV CARGO_HOME=3D/usr/local/cargo
>  ENV PATH=3D$CARGO_HOME/bin:$PATH
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 8f0e95e1c56..a749cf8c515 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -70,8 +70,8 @@ mappings:
>
>    rust:
>      Debian12: rustc-web
> -    Ubuntu2204: rustc-1.77
> -    Ubuntu2404: rustc-1.77
> +    Ubuntu2204: rustc-1.83
> +    Ubuntu2404: rustc-1.83
>
>  pypi_mappings:
>    # Request more recent version
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 056cfb6e9d7..273fb534cdd 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -152,8 +152,8 @@ fedora_rustup_nightly_extras =3D [
>  ]
>
>  ubuntu2204_rust_extras =3D [
> -    "ENV RUSTC=3D/usr/bin/rustc-1.77\n",
> -    "ENV RUSTDOC=3D/usr/bin/rustdoc-1.77\n",
> +    "ENV RUSTC=3D/usr/bin/rustc-1.83\n",
> +    "ENV RUSTDOC=3D/usr/bin/rustdoc-1.83\n",
>      "ENV CARGO_HOME=3D/usr/local/cargo\n",
>      'ENV PATH=3D$CARGO_HOME/bin:$PATH\n',
>      "RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\\n",
> --
> 2.51.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

