Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12AFCEACCC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdte-0001S9-Ip; Tue, 01 Oct 2024 10:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svdqG-0008RD-HX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:27:18 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svdqD-0007Vn-DD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:27:07 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso839319866b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727792821; x=1728397621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmxmWQKJiawU7J7tshrMb5YEm8SUr36MYrvdY6rkgtI=;
 b=fyqHJ9h+mPE8EYGr21K6L3F2iff0vavZ1EEqFhZKNyNfoDbdpPCbHB+JBoU+9NoA2J
 Y/PwvpC+ROIflUHUt6MWoRKmpHw0HlxnhMJuhSkI7y2rFgNuY9X8BbqQSlMTHWWat4B8
 QaPOL2oJlPuByAsNlcFnTiI7mzUWl51fjMQCP/rYYxBJ+muB7TT9UMW+M+nkY0JpaPx1
 vF27m8woRaxabl4of+dwTtKACAsG0jaZ+s/cxEVOgukbQhFEksxqpD2limNsHoq+zzdl
 GQ9Jh+gqa/JrDwugM8RdKG6Ih5pwohlsIBjC8Vq8i+jByuLSmIWitIkrKvsV4EG3qEY/
 EV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792821; x=1728397621;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmxmWQKJiawU7J7tshrMb5YEm8SUr36MYrvdY6rkgtI=;
 b=KMbZ86WtskyVR5zEqNr1NCUPaEqrVhzpdmdeiUH1+o0B+iIZOdrqy4qeNThfT/bpCU
 BWi5flF5P5sHI0kL6eTpLCS9dQ6+XjfB1poWQ7ZeDs1Hmcb4ptFBCNQ3iGscs5c4JELp
 OPPzRkoJRTij31MteMqy3dGdPMyfOjfjSE97uI5R1jFNwdHyf+qa4lRqN/fn4lhZWDxP
 qaqFHfBOzBpRry3d0DGQpgqyjjBTI5fdylJHGGmWiR7627qo14aja+g4KUItIsEMeuBy
 I26RbxUsO7QeVKzXira9ZsaQE27m/b0PEPzmzz3J4uXWzKYCEHqCuaWcy5yYbwWx0vMt
 cSFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwNXlU6JeTFCYuLJo8HJw4Nwaj7EnXlufSAPkJM7MVMWhSJbU4yRoFRIXCYJbCu0DCdPj5DZ6hG9QG@nongnu.org
X-Gm-Message-State: AOJu0Yw9mIrtknipKiUqebwdT9M5IwP0tQ4A/AyrEsWAeNpb6G+iMDXo
 frzJi/8nzFsCbNSyOA2wB9PNEDhCmoaEv0F36hYfzot7VLk5vY8u4uzbLWEmgR2/hZVXRIHUTMZ
 H
X-Google-Smtp-Source: AGHT+IExmZ8mwUveSVXjfxQECo3qKvs4DhRznbITdNYQe5ZIwDLn5pb4n3xAJRX3Ze+iaC/pmtZmmA==
X-Received: by 2002:a17:907:25c3:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a93c492a3a9mr1608321366b.35.1727781501550; 
 Tue, 01 Oct 2024 04:18:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2947ae8sm691527766b.112.2024.10.01.04.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 04:18:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F7335F871;
 Tue,  1 Oct 2024 12:18:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael
 Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] testing: bump mips64el cross to bookworm and allow
 to fail
In-Reply-To: <20241001105148.74182-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 1 Oct 2024 12:51:48 +0200")
References: <20241001105148.74182-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 01 Oct 2024 12:18:20 +0100
Message-ID: <87bk04nkar.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> The mips64el cross setup is very broken for bullseye which has now
> entered LTS support so is unlikely to be fixed. While we still can't
> build the container for bookworm due to a single missing dependency
> that will hopefully get fixed in due course. For the sake of keeping
> the CI green we mark it as allow_fail for the time being.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [thuth: Temporarily remove the problematic packages manually]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Removing the packages that depend on mesa manually helps to get the
>  job green again:
>   https://gitlab.com/thuth/qemu/-/jobs/7961678029
>  That's of course just a temporary fix 'til the next update via lcitool,
>  but hopefully Debian will have fixed their distro by that point in time.
>
>  .gitlab-ci.d/container-cross.yml              |  3 +++
>  .../dockerfiles/debian-mips64el-cross.docker  | 20 ++++---------------
>  tests/lcitool/refresh                         |  2 +-
>  3 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cr=
oss.yml
> index 34c0e729ad..c567926182 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -49,6 +49,9 @@ i686-debian-cross-container:
>  mips64el-debian-cross-container:
>    extends: .container_job_template
>    stage: containers
> +  # Currently waiting for Debian to fix:
> +  #  libgl1-mesa-dri:mips64el : Depends: libllvm15:mips64el but it is
> not going to be installed

Peter if you merge this one then it might be worth using the bugref
instead: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1081535

> +  allow_failure: true
>    variables:
>      NAME: debian-mips64el-cross
>=20=20
> diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/test=
s/docker/dockerfiles/debian-mips64el-cross.docker
> index 2862785692..4f3277a3a6 100644
> --- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> @@ -1,10 +1,10 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-11 qemu
> +#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM docker.io/library/debian:11-slim
> +FROM docker.io/library/debian:12-slim
>=20=20
>  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
> @@ -33,7 +33,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libgtk-vnc-2.0-dev \
>                        libpcre2-dev \
>                        libsndio-dev \
> -                      libspice-protocol-dev \
>                        llvm \
>                        locales \
>                        make \
> @@ -48,16 +47,15 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        python3-opencv \
>                        python3-pillow \
>                        python3-pip \
> -                      python3-setuptools \
>                        python3-sphinx \
>                        python3-sphinx-rtd-theme \
>                        python3-venv \
> -                      python3-wheel \
>                        python3-yaml \
>                        rpm2cpio \
>                        sed \
>                        socat \
>                        sparse \
> +                      swtpm \
>                        tar \
>                        tesseract-ocr \
>                        tesseract-ocr-eng \
> @@ -69,8 +67,6 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      dpkg-reconfigure locales && \
>      rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
>=20=20
> -RUN /usr/bin/pip3 install tomli
> -
>  ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
>  ENV LANG "en_US.UTF-8"
>  ENV MAKE "/usr/bin/make"
> @@ -97,17 +93,13 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libcmocka-dev:mips64el \
>                        libcurl4-gnutls-dev:mips64el \
>                        libdaxctl-dev:mips64el \
> -                      libdrm-dev:mips64el \
> -                      libepoxy-dev:mips64el \
>                        libfdt-dev:mips64el \
>                        libffi-dev:mips64el \
>                        libfuse3-dev:mips64el \
> -                      libgbm-dev:mips64el \
>                        libgcrypt20-dev:mips64el \
>                        libglib2.0-dev:mips64el \
>                        libglusterfs-dev:mips64el \
>                        libgnutls28-dev:mips64el \
> -                      libgtk-3-dev:mips64el \
>                        libibverbs-dev:mips64el \
>                        libiscsi-dev:mips64el \
>                        libjemalloc-dev:mips64el \
> @@ -126,13 +118,10 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        librbd-dev:mips64el \
>                        librdmacm-dev:mips64el \
>                        libsasl2-dev:mips64el \
> -                      libsdl2-dev:mips64el \
> -                      libsdl2-image-dev:mips64el \
>                        libseccomp-dev:mips64el \
>                        libselinux1-dev:mips64el \
>                        libslirp-dev:mips64el \
>                        libsnappy-dev:mips64el \
> -                      libspice-server-dev:mips64el \
>                        libssh-gcrypt-dev:mips64el \
>                        libsystemd-dev:mips64el \
>                        libtasn1-6-dev:mips64el \
> @@ -141,8 +130,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>                        libusb-1.0-0-dev:mips64el \
>                        libusbredirhost-dev:mips64el \
>                        libvdeplug-dev:mips64el \
> -                      libvirglrenderer-dev:mips64el \
> -                      libvte-2.91-dev:mips64el \
> +                      libxdp-dev:mips64el \
>                        libzstd-dev:mips64el \
>                        nettle-dev:mips64el \
>                        systemtap-sdt-dev:mips64el \
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 92381f3c46..a78219f7bc 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -166,7 +166,7 @@ try:
>                                              "x86_64-linux-user,"
>                                              "i386-softmmu,i386-linux-use=
r"))
>=20=20
> -    generate_dockerfile("debian-mips64el-cross", "debian-11",
> +    generate_dockerfile("debian-mips64el-cross", "debian-12",
>                          cross=3D"mips64el",
>                          trailer=3Dcross_build("mips64el-linux-gnuabi64-",
>                                              "mips64el-softmmu,mips64el-l=
inux-user"))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

