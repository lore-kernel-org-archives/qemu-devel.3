Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2BVo-0007ck-NB; Fri, 26 Sep 2025 12:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2BVm-0007cM-Ty
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:41:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2BVY-0004s4-M2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:41:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46cf7bbfda8so13046865e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758904873; x=1759509673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ow/Yog+KyxSbh0n7xMlyK09VhFG8KT8bLL4FEel20v8=;
 b=vYu8GXfKOfUoaZ3gshtUlp3K8O6JxeI6Mad/VwF7d0H4ZGJqJ3X3K4EfkfqtU3pwhE
 MA6QK6loQRgXesRLEPnFRme6nwCWR2dFVTowFUBK1Ya/gctczuXq4cdNeKIZLOC7AI3V
 t4hMcCo8lS8AvjYfO+UnKtek4jILNBnQAbwlHCU7WlviFZ8iKOYh9tOggE4eSo5S90nw
 pT9SBWGtqzx0AVbQY2u+g5pddPZ6JbFxAvUkpdASQel2RDIWp2rU7A6sHJOrHWsvWji+
 BIutCwEOkuHb87bbwvUPtBDjtwiKBpsSsgpSkHEuVRcRyVMqBEjNyEbyHbdPTeUSiJxM
 +Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758904873; x=1759509673;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ow/Yog+KyxSbh0n7xMlyK09VhFG8KT8bLL4FEel20v8=;
 b=T1jD/jhCZOJ1WTt+2OdNUNu7EykWl2tW7px6LvRbyMJHyYljnZuXb4aqJmwoVKayJT
 kRI6iTDiERK0BArcbsj3RclMi8nteuw6+rnG353cpBaV2QKckjMIjjA9+i0ZNTt3OTJo
 3dkylIS2aoROD2Tde8xpHgzQF05Rgkml11yRWHp+e5lTM/tpf7hHkNMNlfNpydXKZO7m
 GLom/XVBNEAa4/Co4oHDSYPdJZRHU81V8q9SrrjEa67z3WYh3ZMZuuj+W724vDldpIcg
 DM39nXQna12VIBd58vYaZ2XYDmqUYT69pM0RMHlykXDND67yJBeVZ2napyjFs3evX18B
 g5+A==
X-Gm-Message-State: AOJu0Ywmwsm/2pdPnyihWf+JsXccRz4YYDBcblBlxt/CEUfEuOnGeSw4
 +qElOKp6zcBrshXs0nPiOHs3GLC4Ljcy8ZNbVr5oDri9v11VrAv2dETdcK4KjQOXpAg=
X-Gm-Gg: ASbGncs8L+tTj4pZWCGYKGsEhOXkqkGnnQpb4bpO2ZcSjOhcXmC3RU16YOLwswivK+i
 1vai9eLweVlQb4y20cxC8oPzZMBR9K7qGh/lsyunY+kbjKCBggCNMxDIFDK8x61/fuEfn0GSOMg
 GQaBwGK0NX/VZibG7eB6UOg0N+3G1oYN26ddTq2+clE+11vLYJyaj1zarHTnTtA+NlCA5ZmHkAz
 bob/A8cFP1VM5DQeUMFEQwUVjfOO2BMY+Q7fcbc7cE8/4FxyZMc+S/6I/PgI6WYKuMNox1bCrWX
 ApzuHf9bhgRe5JPARL7/sHLxyF3/jZmNX+YISXcOnwqAXFeoV3yKWuCwu3ePwCEKogujU8Yw+Yl
 h4ui0llC4qefDLzTTRLz7i44=
X-Google-Smtp-Source: AGHT+IFCdMg6YuL+DIlg1SSm+egjR+yasB0JpYItsXelXICcYkOSeq3p9FzSNNdv3vmauBSGJ2LQHw==
X-Received: by 2002:a05:6000:24c3:b0:3f5:453:77e3 with SMTP id
 ffacd0b85a97d-40e42502f18mr7204818f8f.6.1758904872687; 
 Fri, 26 Sep 2025 09:41:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33e3b355sm84360675e9.12.2025.09.26.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:41:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BC435F7C3;
 Fri, 26 Sep 2025 17:41:11 +0100 (BST)
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
Subject: Re: [PATCH v2 16/27] tests/lcitool: update to debian13
In-Reply-To: <20250924120426.2158655-17-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Wed, 24 Sep 2025 16:04:13 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-17-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 26 Sep 2025 17:41:10 +0100
Message-ID: <87v7l5go9l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .../dockerfiles/debian-amd64-cross.docker     |  9 +++++----
>  .../dockerfiles/debian-arm64-cross.docker     |  9 +++++----
>  .../dockerfiles/debian-armhf-cross.docker     | 12 +++++------
>  .../dockerfiles/debian-i686-cross.docker      | 11 +++++-----
>  .../dockerfiles/debian-ppc64el-cross.docker   |  9 +++++----
>  .../dockerfiles/debian-s390x-cross.docker     |  9 +++++----
>  tests/docker/dockerfiles/debian.docker        |  9 +++++----
>  tests/lcitool/refresh                         | 20 ++++++++++---------
>  8 files changed, 46 insertions(+), 42 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/d=
ocker/dockerfiles/debian-amd64-cross.docker
> index f3ad2205a7..08621879dd 100644
> --- a/tests/docker/dockerfiles/debian-amd64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch x86_64 debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-x86-64-linux-gnu \
>                        libaio-dev:amd64 \
> -                      libasan6:amd64 \
> +                      libasan8:amd64 \
>                        libasound2-dev:amd64 \
>                        libattr1-dev:amd64 \
>                        libbpf-dev:amd64 \
> diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/d=
ocker/dockerfiles/debian-arm64-cross.docker
> index 7d42227fa1..725cccbee1 100644
> --- a/tests/docker/dockerfiles/debian-arm64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch aarch64 debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-aarch64-linux-gnu \
>                        libaio-dev:arm64 \
> -                      libasan6:arm64 \
> +                      libasan8:arm64 \
>                        libasound2-dev:arm64 \
>                        libattr1-dev:arm64 \
>                        libbpf-dev:arm64 \
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
> index 8ad4d2bebf..50f7e0e986 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-arm-linux-gnueabihf \
>                        libaio-dev:armhf \
> -                      libasan6:armhf \
> +                      libasan8:armhf \
>                        libasound2-dev:armhf \
>                        libattr1-dev:armhf \
>                        libbpf-dev:armhf \
> @@ -107,7 +108,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libgbm-dev:armhf \
>                        libgcrypt20-dev:armhf \
>                        libglib2.0-dev:armhf \
> -                      libglusterfs-dev:armhf \
>                        libgnutls28-dev:armhf \
>                        libgtk-3-dev:armhf \
>                        libgtk-vnc-2.0-dev:armhf \
> @@ -127,7 +127,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libpixman-1-dev:armhf \
>                        libpng-dev:armhf \
>                        libpulse-dev:armhf \
> -                      librbd-dev:armhf \
>                        librdmacm-dev:armhf \
>                        libsasl2-dev:armhf \
>                        libsdl2-dev:armhf \
> @@ -152,7 +151,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libvirglrenderer-dev:armhf \
>                        libvte-2.91-dev:armhf \
>                        libxdp-dev:armhf \
> -                      libxen-dev:armhf \
>                        libzstd-dev:armhf \
>                        nettle-dev:armhf \
>                        systemtap-sdt-dev:armhf \

This fails to build:

Build started at 2025-09-26T16:02:34.986501
Main binary: /tmp/qemu-test/build/pyvenv/bin/python3
Build Options: -Dwerror=3Dtrue -Dprefix=3D/tmp/qemu-test/install -Drust=3De=
nabled -Ddocs=3Denabled -Dplugins=3Dtrue --cross-file=3Dconfig-meson.cross =
--native-file=3Dconfig-meson.native
Python system: Linux
The Meson build system
Version: 1.9.0
Source dir: /tmp/qemu-test/src
Build dir: /tmp/qemu-test/build
Build type: cross build
Project name: qemu
Project version: 10.1.50
-----------
Detecting compiler via: `arm-linux-gnueabihf-gcc --version` -> 0
stdout:
arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-----------
Running command: -cpp -x c -E -dM -
-----
-----------
Detecting linker via: `arm-linux-gnueabihf-gcc -Wl,--version` -> 0
stdout:
GNU ld (GNU Binutils for Debian) 2.44
Copyright (C) 2025 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later versio=
n.
This program has absolutely no warranty.
-----------
stderr:
collect2 version 14.2.0
/usr/lib/gcc-cross/arm-linux-gnueabihf/14/../../../../arm-linux-gnueabihf/b=
in/ld -plugin /usr/libexec/gcc-cross/arm-linux-gnueabihf/14/liblto_plugin.s=
o -plugin-opt=3D/usr/libexec/gcc-cross/arm-linux-gnueabihf/14/lto-wrapper -=
plugin-opt=3D-fresolution=3D/tmp/ccSBX4gO.res -plugin-opt=3D-pass-through=
=3D-lgcc -plugin-opt=3D-pass-through=3D-lgcc_s -plugin-opt=3D-pass-through=
=3D-lc -plugin-opt=3D-pass-through=3D-lgcc -plugin-opt=3D-pass-through=3D-l=
gcc_s --sysroot=3D/ --build-id --eh-frame-hdr -dynamic-linker /lib/ld-linux=
-armhf.so.3 -X --hash-style=3Dgnu --as-needed -m armelf_linux_eabi -pie /li=
b/arm-linux-gnueabihf/Scrt1.o /lib/arm-linux-gnueabihf/crti.o /usr/lib/gcc-=
cross/arm-linux-gnueabihf/14/crtbeginS.o -L/usr/lib/gcc-cross/arm-linux-gnu=
eabihf/14 -L/usr/lib/gcc-cross/arm-linux-gnueabihf/14/../../../../arm-linux=
-gnueabihf/lib -L/lib/arm-linux-gnueabihf -L/usr/lib/arm-linux-gnueabihf --=
version -lgcc --push-state --as-needed -lgcc_s --pop-state -lc -lgcc --push=
-state --as-needed -lgcc_s --pop-state /usr/lib/gcc-cross/arm-linux-gnueabi=
hf/14/crtendS.o /lib/arm-linux-gnueabihf/crtn.o
-----------
Sanity testing C compiler: arm-linux-gnueabihf-gcc
Is cross compiler: True.
Sanity check compiler command line: arm-linux-gnueabihf-gcc sanitycheckc.c =
-o sanitycheckc_cross.exe -D_FILE_OFFSET_BITS=3D64 -c
Sanity check compile stdout:

-----
Sanity check compile stderr:

-----
C compiler for the host machine: arm-linux-gnueabihf-gcc (gcc 14.2.0 "arm-l=
inux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0")
C linker for the host machine: arm-linux-gnueabihf-gcc ld.bfd 2.44
-----------
Detecting archiver via: `arm-linux-gnueabihf-ar --version` -> 0
stdout:
GNU ar (GNU Binutils for Debian) 2.44
Copyright (C) 2025 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later vers=
ion.
This program has absolutely no warranty.
-----------
-----------
Detecting compiler via: `cc --version` -> 0
stdout:
cc (Debian 14.2.0-19) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-----------
Running command: -cpp -x c -E -dM -
-----
-----------
Detecting linker via: `cc -Wl,--version` -> 0
stdout:
GNU ld (GNU Binutils for Debian) 2.44
Copyright (C) 2025 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later versio=
n.
This program has absolutely no warranty.
-----------
stderr:
collect2 version 14.2.0
/usr/bin/ld -plugin /usr/libexec/gcc/x86_64-linux-gnu/14/liblto_plugin.so -=
plugin-opt=3D/usr/libexec/gcc/x86_64-linux-gnu/14/lto-wrapper -plugin-opt=
=3D-fresolution=3D/tmp/ccm2bSZj.res -plugin-opt=3D-pass-through=3D-lgcc -pl=
ugin-opt=3D-pass-through=3D-lgcc_s -plugin-opt=3D-pass-through=3D-lc -plugi=
n-opt=3D-pass-through=3D-lgcc -plugin-opt=3D-pass-through=3D-lgcc_s --build=
-id --eh-frame-hdr -m elf_x86_64 --hash-style=3Dgnu --as-needed -dynamic-li=
nker /lib64/ld-linux-x86-64.so.2 -pie /usr/lib/gcc/x86_64-linux-gnu/14/../.=
./../x86_64-linux-gnu/Scrt1.o /usr/lib/gcc/x86_64-linux-gnu/14/../../../x86=
_64-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/14/crtbeginS.o -L/usr/li=
b/gcc/x86_64-linux-gnu/14 -L/usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_6=
4-linux-gnu -L/usr/lib/gcc/x86_64-linux-gnu/14/../../../../lib -L/lib/x86_6=
4-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu -L/usr/lib/../lib -L/=
usr/lib/gcc/x86_64-linux-gnu/14/../../.. --version -lgcc --push-state --as-=
needed -lgcc_s --pop-state -lc -lgcc --push-state --as-needed -lgcc_s --pop=
-state /usr/lib/gcc/x86_64-linux-gnu/14/crtendS.o /usr/lib/gcc/x86_64-linux=
-gnu/14/../../../x86_64-linux-gnu/crtn.o
-----------
Sanity testing C compiler: cc
Is cross compiler: False.
Sanity check compiler command line: cc sanitycheckc.c -o sanitycheckc.exe -=
D_FILE_OFFSET_BITS=3D64
Sanity check compile stdout:

-----
Sanity check compile stderr:

-----
Running test binary command:  /tmp/qemu-test/build/meson-private/sanitychec=
kc.exe
-----------
Sanity check: `/tmp/qemu-test/build/meson-private/sanitycheckc.exe` -> 0
C compiler for the build machine: cc (gcc 14.2.0 "cc (Debian 14.2.0-19) 14.=
2.0")
C linker for the build machine: cc ld.bfd 2.44
-----------
Detecting archiver via: `gcc-ar --version` -> 0
stdout:
GNU ar (GNU Binutils for Debian) 2.44
Copyright (C) 2025 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later vers=
ion.
This program has absolutely no warranty.
-----------
Build machine cpu family: x86_64
Build machine cpu: x86_64
Host machine cpu family: arm
Host machine cpu: arm
Target machine cpu family: arm
Target machine cpu: arm
Program scripts/symlink-install-tree.py found: YES (/tmp/qemu-test/build/py=
venv/bin/python3 /tmp/qemu-test/src/scripts/symlink-install-tree.py)
Program sh found: YES (/usr/bin/sh)
Program python3 found: YES (/tmp/qemu-test/build/pyvenv/bin/python3)
-----------
Detecting compiler via: `arm-linux-gnueabihf-gcc --version` -> 0
stdout:
arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-----------
Running command: -cpp -x c -E -dM -
-----
-----------
Detecting linker via: `arm-linux-gnueabihf-gcc -Wl,--version` -> 0
stdout:
GNU ld (GNU Binutils for Debian) 2.44
Copyright (C) 2025 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later versio=
n.
This program has absolutely no warranty.
-----------
stderr:
collect2 version 14.2.0
/usr/lib/gcc-cross/arm-linux-gnueabihf/14/../../../../arm-linux-gnueabihf/b=
in/ld -plugin /usr/libexec/gcc-cross/arm-linux-gnueabihf/14/liblto_plugin.s=
o -plugin-opt=3D/usr/libexec/gcc-cross/arm-linux-gnueabihf/14/lto-wrapper -=
plugin-opt=3D-fresolution=3D/tmp/ccDS7TeO.res -plugin-opt=3D-pass-through=
=3D-lgcc -plugin-opt=3D-pass-through=3D-lgcc_s -plugin-opt=3D-pass-through=
=3D-lc -plugin-opt=3D-pass-through=3D-lgcc -plugin-opt=3D-pass-through=3D-l=
gcc_s --sysroot=3D/ --build-id --eh-frame-hdr -dynamic-linker /lib/ld-linux=
-armhf.so.3 -X --hash-style=3Dgnu --as-needed -m armelf_linux_eabi -pie /li=
b/arm-linux-gnueabihf/Scrt1.o /lib/arm-linux-gnueabihf/crti.o /usr/lib/gcc-=
cross/arm-linux-gnueabihf/14/crtbeginS.o -L/usr/lib/gcc-cross/arm-linux-gnu=
eabihf/14 -L/usr/lib/gcc-cross/arm-linux-gnueabihf/14/../../../../arm-linux=
-gnueabihf/lib -L/lib/arm-linux-gnueabihf -L/usr/lib/arm-linux-gnueabihf --=
version -lgcc --push-state --as-needed -lgcc_s --pop-state -lc -lgcc --push=
-state --as-needed -lgcc_s --pop-state /usr/lib/gcc-cross/arm-linux-gnueabi=
hf/14/crtendS.o /lib/arm-linux-gnueabihf/crtn.o
-----------
-----------
Detecting compiler via: `rustc --target arm-unknown-linux-gnueabi --version=
` -> 0
stdout:
rustc 1.85.0 (4d91de4e4 2025-02-17) (built from a source tarball)
-----------
-----------
Called: `rustc --target arm-unknown-linux-gnueabi -C linker=3Darm-linux-gnu=
eabihf-gcc -o /tmp/qemu-test/build/meson-private/rusttest.exe /tmp/qemu-tes=
t/build/meson-private/sanity.rs` -> 1
stderr:
error[E0463]: can't find crate for `std`
  |
  =3D note: the `arm-unknown-linux-gnueabi` target may not be installed
  =3D help: consider downloading the target with `rustup target add arm-unk=
nown-linux-gnueabi`

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0463`.
-----------

../src/meson.build:91:12: ERROR: Rust compiler rustc --target arm-unknown-l=
inux-gnueabi -C linker=3Darm-linux-gnueabihf-gcc cannot compile programs.
Failed to run 'configure'
make[1]: *** [tests/docker/Makefile.include:203: docker-run] Error 1
make[1]: Leaving directory '/home/alex/lsrc/qemu.git'
make: *** [tests/docker/Makefile.include:131: docker-test-build@debian-armh=
f-cross] Error 2
=F0=9F=95=9917:02:35 alex@draig:qemu.git  on =EE=82=A0 testing/next:master =
[$!?=E2=87=A1] took 12m1s [=F0=9F=94=B4 USAGE]


> diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/do=
cker/dockerfiles/debian-i686-cross.docker
> index e7e8d8e0f1..f53b77cb62 100644
> --- a/tests/docker/dockerfiles/debian-i686-cross.docker
> +++ b/tests/docker/dockerfiles/debian-i686-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch i686 debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch i686 debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-i686-linux-gnu \
>                        libaio-dev:i386 \
> -                      libasan6:i386 \
> +                      libasan8:i386 \
>                        libasound2-dev:i386 \
>                        libattr1-dev:i386 \
>                        libbpf-dev:i386 \
> @@ -107,7 +108,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libgbm-dev:i386 \
>                        libgcrypt20-dev:i386 \
>                        libglib2.0-dev:i386 \
> -                      libglusterfs-dev:i386 \
>                        libgnutls28-dev:i386 \
>                        libgtk-3-dev:i386 \
>                        libgtk-vnc-2.0-dev:i386 \
> @@ -127,7 +127,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libpixman-1-dev:i386 \
>                        libpng-dev:i386 \
>                        libpulse-dev:i386 \
> -                      librbd-dev:i386 \
>                        librdmacm-dev:i386 \
>                        libsasl2-dev:i386 \
>                        libsdl2-dev:i386 \
> diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests=
/docker/dockerfiles/debian-ppc64el-cross.docker
> index 97ef64d934..09de265c26 100644
> --- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch ppc64le debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-powerpc64le-linux-gnu \
>                        libaio-dev:ppc64el \
> -                      libasan6:ppc64el \
> +                      libasan8:ppc64el \
>                        libasound2-dev:ppc64el \
>                        libattr1-dev:ppc64el \
>                        libbpf-dev:ppc64el \
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
> index 3afe91494d..d7b2ca99ce 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch s390x debian-12 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch s390x debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -48,11 +48,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> @@ -85,7 +86,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      eatmydata apt-get install --no-install-recommends -y \
>                        gcc-s390x-linux-gnu \
>                        libaio-dev:s390x \
> -                      libasan6:s390x \
> +                      libasan8:s390x \
>                        libasound2-dev:s390x \
>                        libattr1-dev:s390x \
>                        libbpf-dev:s390x \
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/docker=
files/debian.docker
> index f68fcc83a9..2696cf2167 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all debian-12 qemu
> +#  $ lcitool dockerfile --layers all debian-13 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:12-slim
> +FROM docker.io/library/debian:13-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -32,7 +32,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        git \
>                        hostname \
>                        libaio-dev \
> -                      libasan6 \
> +                      libasan8 \
>                        libasound2-dev \
>                        libattr1-dev \
>                        libbpf-dev \
> @@ -121,11 +121,12 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
> +                      python3-tomli \
>                        python3-venv \
>                        python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
> -                      rustc-web \
> +                      rustc \
>                        sed \
>                        socat \
>                        sparse \
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 6f98a91277..f4d2721178 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -105,7 +105,7 @@ alpine_extras =3D [
>  # Netmap still needs to be manually built as it is yet to be packaged
>  # into a distro. We also add cscope and gtags which are used in the CI
>  # test
> -debian12_extras =3D [
> +debian13_extras =3D [
>      "# netmap/cscope/global\n",
>      "RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\\n",
>      "  apt install -y --no-install-recommends \\\n",
> @@ -175,8 +175,8 @@ try:
>      generate_dockerfile("alpine", "alpine-321",
>                          trailer=3D"".join(alpine_extras))
>      generate_dockerfile("centos9", "centos-stream-9")
> -    generate_dockerfile("debian", "debian-12",
> -                        trailer=3D"".join(debian12_extras))
> +    generate_dockerfile("debian", "debian-13",
> +                        trailer=3D"".join(debian13_extras))
>      generate_dockerfile("fedora", "fedora-41")
>      generate_dockerfile("opensuse-leap", "opensuse-leap-15")
>      generate_dockerfile("ubuntu2204", "ubuntu-2204",
> @@ -191,30 +191,32 @@ try:
>      #
>      # Cross compiling builds
>      #
> -    generate_dockerfile("debian-amd64-cross", "debian-12",
> +    generate_dockerfile("debian-amd64-cross", "debian-13",
>                          cross=3D"x86_64",
>                          trailer=3Dcross_build("x86_64-linux-gnu-",
>                                              "x86_64-softmmu,"
>                                              "x86_64-linux-user,"
>                                              "i386-softmmu,i386-linux-use=
r"))
>=20=20
> -    generate_dockerfile("debian-arm64-cross", "debian-12",
> +    generate_dockerfile("debian-arm64-cross", "debian-13",
>                          cross=3D"aarch64",
>                          trailer=3Dcross_build("aarch64-linux-gnu-",
>                                              "aarch64-softmmu,aarch64-lin=
ux-user"))
>=20=20
> -    generate_dockerfile("debian-armhf-cross", "debian-12",
> +    generate_dockerfile("debian-armhf-cross", "debian-13",
>                          cross=3D"armv7l",
>                          trailer=3Dcross_build("arm-linux-gnueabihf-",
>                                              "arm-softmmu,arm-linux-user"=
))
>=20=20
> -    generate_dockerfile("debian-i686-cross", "debian-12",
> +    generate_dockerfile("debian-i686-cross", "debian-13",
>                          cross=3D"i686",
>                          trailer=3Dcross_build("i686-linux-gnu-",
>                                              "x86_64-softmmu,"
>                                              "x86_64-linux-user,"
>                                              "i386-softmmu,i386-linux-use=
r"))
>=20=20
> +    # mips no longer supported in debian-13
> +    # https://www.debian.org/releases/trixie/release-notes/issues.html#m=
ips-architectures-removed
>      generate_dockerfile("debian-mips64el-cross", "debian-12",
>                          cross=3D"mips64el",
>                          trailer=3Dcross_build("mips64el-linux-gnuabi64-",
> @@ -225,7 +227,7 @@ try:
>                          trailer=3Dcross_build("mipsel-linux-gnu-",
>                                              "mipsel-softmmu,mipsel-linux=
-user"))
>=20=20
> -    generate_dockerfile("debian-ppc64el-cross", "debian-12",
> +    generate_dockerfile("debian-ppc64el-cross", "debian-13",
>                          cross=3D"ppc64le",
>                          trailer=3Dcross_build("powerpc64le-linux-gnu-",
>                                              "ppc64-softmmu,ppc64-linux-u=
ser"))
> @@ -238,7 +240,7 @@ try:
>                          trailer=3Dcross_build("riscv64-linux-gnu-",
>                                              "riscv64-softmmu,riscv64-lin=
ux-user"))
>=20=20
> -    generate_dockerfile("debian-s390x-cross", "debian-12",
> +    generate_dockerfile("debian-s390x-cross", "debian-13",
>                          cross=3D"s390x",
>                          trailer=3Dcross_build("s390x-linux-gnu-",
>                                              "s390x-softmmu,s390x-linux-u=
ser"))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

