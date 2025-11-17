Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D96CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2Uy-0001Od-3r; Mon, 17 Nov 2025 11:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL2Uk-0001N0-Ut
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:54:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL2Uc-0002f4-RR
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:54:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so48131195e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763398457; x=1764003257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiI+ErW/gjrEn6qHwHygYlyNpSeAZDkXnFa/j4W5bJU=;
 b=vwsIo/UxsauaLaJ3WXPxEa9uGDngdX8qLF1ZqEb9yU3qGxA791vv9w3mpFcGyQrlTP
 vEXnD82wMjPtP4fMiC7Deod8e5iY2fD8XIhpBgmpjUKMIjIyCUH+vA6js2q2enIMj+Ae
 PGHj4t3KtkwQJLODqtWd2wEHSMG8fGjMYvHtt9OogYDRO0vc82UhhQZmDqldFxYvnn51
 kqFKtBengvIKzgrj7QtOWZHhOwNEmzfNqGMClbi3tfls58FtnsaVKyMWZBre60SzFYlE
 dakJJlxRbNLP11uZC8haoM6kSs/ktkfOgtfgZfsLHIwoMOcLKDbIgPNw2SbCNd5V6UPb
 anxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763398457; x=1764003257;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiI+ErW/gjrEn6qHwHygYlyNpSeAZDkXnFa/j4W5bJU=;
 b=fi6K9vALzkN3j+iKPrj6liL8GXrvg79PfLg26yf+NRWy70XeolRbA9etLng2uK5rtO
 VVJmS4fd3jYhFCHEoI2UtFqfFBu16C6QvszQ1BZC9F6WvBoOyegII00ZwefBdF/fM4/I
 /bXGFjvSSwnJprjhgDwP2YpdRfZP136vCBIpAvtET9XDrzLBgBk0YZe53pDE0ELjnQtC
 UZj2B85C6LIOLJxlt6690qR1gZnLWzmDnONQ1cxhE1NXBHlsdi0X0gMClvdxL1HTGKY0
 a16n65VnBsh5Vm7cQv/iWjIgboqtpbLGn37kE0YwCtbQEUeXDbGidF0EIanT2bsR5IOx
 ovKg==
X-Gm-Message-State: AOJu0Ywy4oqvvF3WFZKMWuztrv4YAo6flFT9Yo2WzF+29oDJMTfJNIFO
 LjSclChk8CuUSzDX7ap0vTeyHYg8BR1jjl7Ks5UTZF9eWhopvfA4eYF1KpNVh+9sIaE=
X-Gm-Gg: ASbGncvESQcIMnQeV7mTvJ/Ad7WgbTZ9b0HylQdy73mk7cKAgPVczGHePyWm5tgraZS
 Si0Tq/Apw7XIrZ6S6ZJZ87pBiemCwyhGjIL0Sk6ajpXIQSdETkSQVfyg858vPQglRad/XTs2XXp
 0oTKcc6EHUAL1yVsmqNJyU1lN1C/jAEo6ckmU9I1JZY3xrsKNiaWuCWu5PsK/hQHTLe2uiExFAt
 qzBBhOUOs/1f+Iw8vZ6i5oP5Hqr/tcMptdiJbR7N7wOnJV42I6C8V+QuWHv73ENQQ+hyMtRts4K
 R0n9Zlk1Qna5D05nSkZsSo+IveX7uG18PNvvG0Pg0N1E3/6JO4ksX76EIlMqbGzdzsDJ/KgeLyP
 RXWEwwXHay9e/+DxYCTzPmWjRtVPvbKKrbH42cj2r2/CNObXL4u8mAYYetajEyFA3Nd5hvQvpa1
 V/
X-Google-Smtp-Source: AGHT+IEDlY8oX019rMDJHuPUOYTY3+rA5nPMtOCfUfXAPTPZQg/tPMXmOOYTuThetPBP8ZByv8VWPA==
X-Received: by 2002:a05:600c:1f86:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-4778fea17bemr112617575e9.32.1763398456594; 
 Mon, 17 Nov 2025 08:54:16 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779973ddcfsm138884595e9.15.2025.11.17.08.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:54:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1973C5F76E;
 Mon, 17 Nov 2025 16:54:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH-for-10.2 1/2] gitlab: Stop cross-testing for 32-bit ARM
 hosts
In-Reply-To: <20251117154154.79090-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 17 Nov 2025 16:41:53
 +0100")
References: <20251117154154.79090-1-philmd@linaro.org>
 <20251117154154.79090-2-philmd@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 16:54:15 +0000
Message-ID: <87h5uslhvs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> 32-bit host support is deprecated since commit 6d701c9bac1
> ("meson: Deprecate 32-bit host support"). Next commits will
> remove support for 32-bit ARM hosts. Stop cross-building
> QEMU on our CI. Remove the CI jobs and related Docker files.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  configure                                     |   9 -
>  .gitlab-ci.d/container-cross.yml              |   6 -
>  .gitlab-ci.d/crossbuilds.yml                  |   7 -
>  python/qemu/utils/accel.py                    |   1 -
>  roms/edk2-build.py                            |   4 -
>  .../dockerfiles/debian-armhf-cross.docker     | 188 ------------------
>  tests/docker/dockerfiles/debian-bootstrap.pre |   5 +-
>  tests/lcitool/refresh                         |   5 -
>  8 files changed, 1 insertion(+), 224 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
>
> diff --git a/configure b/configure
> index a2f66f7ff9c..4b8f92e822b 100755
> --- a/configure
> +++ b/configure
> @@ -1334,8 +1334,6 @@ fi
>  : ${cross_prefix_aarch64=3D"aarch64-linux-gnu-"}
>  : ${cross_prefix_aarch64_be=3D"$cross_prefix_aarch64"}
>  : ${cross_prefix_alpha=3D"alpha-linux-gnu-"}
> -: ${cross_prefix_arm=3D"arm-linux-gnueabihf-"}
> -: ${cross_prefix_armeb=3D"$cross_prefix_arm"}
>  : ${cross_prefix_hexagon=3D"hexagon-unknown-linux-musl-"}
>  : ${cross_prefix_loongarch64=3D"loongarch64-unknown-linux-gnu-"}
>  : ${cross_prefix_hppa=3D"hppa-linux-gnu-"}
> @@ -1359,8 +1357,6 @@ fi
>=20=20
>  : ${cross_cc_aarch64_be=3D"$cross_cc_aarch64"}
>  : ${cross_cc_cflags_aarch64_be=3D"-mbig-endian"}
> -: ${cross_cc_armeb=3D"$cross_cc_arm"}
> -: ${cross_cc_cflags_armeb=3D"-mbig-endian"}
>  : ${cross_cc_hexagon=3D"hexagon-unknown-linux-musl-clang"}
>  : ${cross_cc_cflags_hexagon=3D"-mv73 -O2 -static"}
>  : ${cross_cc_cflags_i386=3D"-m32"}
> @@ -1481,11 +1477,6 @@ probe_target_compiler() {
>          # We don't have any bigendian build tools so we only use this fo=
r AArch64
>          container_image=3Ddebian-arm64-cross
>          ;;
> -      arm)
> -        # We don't have any bigendian build tools so we only use this fo=
r ARM
> -        container_image=3Ddebian-armhf-cross
> -        container_cross_prefix=3Darm-linux-gnueabihf-
> -        ;;

This isn't used for cross-builds but for building tests. So you need to
add a stanza above that passes:

  container_image=3Ddebian-all-test-cross

>        hexagon)
>          container_cross_prefix=3Dhexagon-unknown-linux-musl-
>          container_cross_cc=3D${container_cross_prefix}clang
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cr=
oss.yml
> index 0fd7341afac..e7ce1392770 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -22,12 +22,6 @@ arm64-debian-cross-container:
>    variables:
>      NAME: debian-arm64-cross
>=20=20
> -armhf-debian-cross-container:
> -  extends: .container_job_template
> -  stage: containers
> -  variables:
> -    NAME: debian-armhf-cross
> -
>  hexagon-cross-container:
>    extends: .container_job_template
>    stage: containers
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 99dfa7eea6f..e0a68c2023d 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -1,13 +1,6 @@
>  include:
>    - local: '/.gitlab-ci.d/crossbuild-template.yml'
>=20=20
> -cross-armhf-user:
> -  extends: .cross_user_build_job
> -  needs:
> -    - job: armhf-debian-cross-container
> -  variables:
> -    IMAGE: debian-armhf-cross
> -
>  cross-arm64-system:
>    extends: .cross_system_build_job
>    needs:
> diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
> index f915b646692..e6fca304b33 100644
> --- a/python/qemu/utils/accel.py
> +++ b/python/qemu/utils/accel.py
> @@ -26,7 +26,6 @@
>  # support which often includes its 32 bit cousin.
>  ADDITIONAL_ARCHES =3D {
>      "x86_64": "i386",
> -    "aarch64": "armhf",
>      "ppc64le": "ppc64",
>  }
>=20=20
> diff --git a/roms/edk2-build.py b/roms/edk2-build.py
> index c7e9dc58ec0..683c622c3d6 100755
> --- a/roms/edk2-build.py
> +++ b/roms/edk2-build.py
> @@ -289,10 +289,6 @@ def prepare_env(cfg, silent =3D False):
>      os.environ['PYTHONHASHSEED'] =3D '1'
>=20=20
>      # for cross builds
> -    if binary_exists('arm-linux-gnueabi-gcc'):
> -        # ubuntu
> -        os.environ['GCC5_ARM_PREFIX'] =3D 'arm-linux-gnueabi-'
> -        os.environ['GCC_ARM_PREFIX'] =3D 'arm-linux-gnueabi-'

Isn't this part of the firmware build? armhf guests aren't going away.

>      if binary_exists('loongarch64-linux-gnu-gcc'):
>          os.environ['GCC5_LOONGARCH64_PREFIX'] =3D 'loongarch64-linux-gnu=
-'
>          os.environ['GCC_LOONGARCH64_PREFIX'] =3D 'loongarch64-linux-gnu-'
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
> deleted file mode 100644
> index 627d41c6dee..00000000000
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ /dev/null
> @@ -1,188 +0,0 @@
> -# THIS FILE WAS AUTO-GENERATED
> -#
> -#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-13 qemu
> -#
> -# https://gitlab.com/libvirt/libvirt-ci
> -
> -FROM docker.io/library/debian:13-slim
> -
> -RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
> -    apt-get update && \
> -    apt-get install -y eatmydata && \
> -    eatmydata apt-get dist-upgrade -y && \
> -    eatmydata apt-get install --no-install-recommends -y \
> -                      bash \
> -                      bc \
> -                      bindgen \
> -                      bison \
> -                      bsdextrautils \
> -                      bzip2 \
> -                      ca-certificates \
> -                      ccache \
> -                      dbus \
> -                      debianutils \
> -                      diffutils \
> -                      exuberant-ctags \
> -                      findutils \
> -                      flex \
> -                      gcc \
> -                      gcovr \
> -                      gettext \
> -                      git \
> -                      hostname \
> -                      libclang-rt-dev \
> -                      libglib2.0-dev \
> -                      llvm \
> -                      locales \
> -                      make \
> -                      mtools \
> -                      ncat \
> -                      ninja-build \
> -                      openssh-client \
> -                      pkgconf \
> -                      python3 \
> -                      python3-numpy \
> -                      python3-opencv \
> -                      python3-pillow \
> -                      python3-pip \
> -                      python3-setuptools \
> -                      python3-sphinx \
> -                      python3-sphinx-rtd-theme \
> -                      python3-tomli \
> -                      python3-venv \
> -                      python3-wheel \
> -                      python3-yaml \
> -                      rpm2cpio \
> -                      rustc \
> -                      sed \
> -                      socat \
> -                      sparse \
> -                      swtpm \
> -                      tar \
> -                      tesseract-ocr \
> -                      tesseract-ocr-eng \
> -                      vulkan-tools \
> -                      xorriso \
> -                      zstd && \
> -    eatmydata apt-get autoremove -y && \
> -    eatmydata apt-get autoclean -y && \
> -    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
> -    dpkg-reconfigure locales && \
> -    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
> -
> -RUN /usr/bin/pip3 install meson=3D=3D1.8.1
> -
> -ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
> -ENV LANG "en_US.UTF-8"
> -ENV MAKE "/usr/bin/make"
> -ENV NINJA "/usr/bin/ninja"
> -ENV PYTHON "/usr/bin/python3"
> -
> -RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
> -    dpkg --add-architecture armhf && \
> -    eatmydata apt-get update && \
> -    eatmydata apt-get dist-upgrade -y && \
> -    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
> -    eatmydata apt-get install --no-install-recommends -y \
> -                      gcc-arm-linux-gnueabihf \
> -                      libaio-dev:armhf \
> -                      libasan8:armhf \
> -                      libasound2-dev:armhf \
> -                      libattr1-dev:armhf \
> -                      libbpf-dev:armhf \
> -                      libbrlapi-dev:armhf \
> -                      libbz2-dev:armhf \
> -                      libc6-dev:armhf \
> -                      libcacard-dev:armhf \
> -                      libcap-ng-dev:armhf \
> -                      libcapstone-dev:armhf \
> -                      libcbor-dev:armhf \
> -                      libcmocka-dev:armhf \
> -                      libcurl4-gnutls-dev:armhf \
> -                      libdaxctl-dev:armhf \
> -                      libdrm-dev:armhf \
> -                      libepoxy-dev:armhf \
> -                      libfdt-dev:armhf \
> -                      libffi-dev:armhf \
> -                      libfuse3-dev:armhf \
> -                      libgbm-dev:armhf \
> -                      libgcrypt20-dev:armhf \
> -                      libglib2.0-dev:armhf \
> -                      libgnutls28-dev:armhf \
> -                      libgtk-3-dev:armhf \
> -                      libgtk-vnc-2.0-dev:armhf \
> -                      libibverbs-dev:armhf \
> -                      libiscsi-dev:armhf \
> -                      libjemalloc-dev:armhf \
> -                      libjpeg62-turbo-dev:armhf \
> -                      libjson-c-dev:armhf \
> -                      liblttng-ust-dev:armhf \
> -                      liblzo2-dev:armhf \
> -                      libncursesw5-dev:armhf \
> -                      libnfs-dev:armhf \
> -                      libnuma-dev:armhf \
> -                      libpam0g-dev:armhf \
> -                      libpcre2-dev:armhf \
> -                      libpipewire-0.3-dev:armhf \
> -                      libpixman-1-dev:armhf \
> -                      libpng-dev:armhf \
> -                      libpulse-dev:armhf \
> -                      librdmacm-dev:armhf \
> -                      libsasl2-dev:armhf \
> -                      libsdl2-dev:armhf \
> -                      libsdl2-image-dev:armhf \
> -                      libseccomp-dev:armhf \
> -                      libselinux1-dev:armhf \
> -                      libslirp-dev:armhf \
> -                      libsnappy-dev:armhf \
> -                      libsndio-dev:armhf \
> -                      libspice-protocol-dev:armhf \
> -                      libspice-server-dev:armhf \
> -                      libssh-dev:armhf \
> -                      libstd-rust-dev:armhf \
> -                      libsystemd-dev:armhf \
> -                      libtasn1-6-dev:armhf \
> -                      libubsan1:armhf \
> -                      libudev-dev:armhf \
> -                      liburing-dev:armhf \
> -                      libusb-1.0-0-dev:armhf \
> -                      libusbredirhost-dev:armhf \
> -                      libvdeplug-dev:armhf \
> -                      libvirglrenderer-dev:armhf \
> -                      libvte-2.91-dev:armhf \
> -                      libxdp-dev:armhf \
> -                      libzstd-dev:armhf \
> -                      nettle-dev:armhf \
> -                      systemtap-sdt-dev:armhf \
> -                      zlib1g-dev:armhf && \
> -    eatmydata apt-get autoremove -y && \
> -    eatmydata apt-get autoclean -y && \
> -    mkdir -p /usr/local/share/meson/cross && \
> -    printf "[binaries]\n\
> -c =3D '/usr/bin/arm-linux-gnueabihf-gcc'\n\
> -ar =3D '/usr/bin/arm-linux-gnueabihf-gcc-ar'\n\
> -strip =3D '/usr/bin/arm-linux-gnueabihf-strip'\n\
> -pkgconfig =3D '/usr/bin/arm-linux-gnueabihf-pkg-config'\n\
> -\n\
> -[host_machine]\n\
> -system =3D 'linux'\n\
> -cpu_family =3D 'arm'\n\
> -cpu =3D 'armhf'\n\
> -endian =3D 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabih=
f && \
> -    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --=
show > /packages.txt && \
> -    mkdir -p /usr/libexec/ccache-wrappers && \
> -    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi=
hf-cc && \
> -    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi=
hf-gcc
> -
> -ENV ABI "arm-linux-gnueabihf"
> -ENV MESON_OPTS "--cross-file=3Darm-linux-gnueabihf"
> -ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
> -ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabihf-
> -ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
> -# As a final step configure the user (if env is defined)
> -ARG USER
> -ARG UID
> -RUN if [ "${USER}" ]; then \
> -  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
> -
> -ENV ENABLE_RUST 1
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker=
/dockerfiles/debian-bootstrap.pre
> index 35c85f7db8a..0a652754dfd 100755
> --- a/tests/docker/dockerfiles/debian-bootstrap.pre
> +++ b/tests/docker/dockerfiles/debian-bootstrap.pre
> @@ -21,7 +21,7 @@ if [ -z $FAKEROOT ]; then
>  fi
>=20=20
>  if [ -z "${DEB_ARCH}" ]; then
> -    echo "Please set DEB_ARCH to choose an architecture (e.g. armhf)" >&2
> +    echo "Please set DEB_ARCH to choose an architecture (e.g. arm64)" >&2
>      exit_and_skip
>=20=20
>  fi
> @@ -99,9 +99,6 @@ else
>          amd64)
>              QEMU=3Dqemu-i386
>              ;;
> -        armel|armhf)
> -            QEMU=3Dqemu-arm
> -            ;;

Again this is for testing and building rootfs's so shouldn't be dropped
here.


>          arm64)
>              QEMU=3Dqemu-aarch64
>              ;;
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index df186caffe6..d3743ba73e8 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -208,11 +208,6 @@ try:
>                          trailer=3Dcross_build("aarch64-linux-gnu-",
>                                              "aarch64-softmmu,aarch64-lin=
ux-user"))
>=20=20
> -    generate_dockerfile("debian-armhf-cross", "debian-13",
> -                        cross=3D"armv7l",
> -                        trailer=3Dcross_build("arm-linux-gnueabihf-",
> -                                            "arm-softmmu,arm-linux-user"=
))
> -
>      generate_dockerfile("debian-i686-cross", "debian-13",
>                          cross=3D"i686",
>                          trailer=3Dcross_build("i686-linux-gnu-",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

