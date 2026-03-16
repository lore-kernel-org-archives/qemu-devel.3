Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC37F506E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29B5-0000gf-5L; Mon, 16 Mar 2026 10:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w29Au-0000fN-8c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:44:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w29Ar-0000EJ-GU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:44:08 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso872656966b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773672243; x=1774277043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcyS4c0ZFzXBzY8/awrHzLx1zlBHC2pXS4g0m2w2ceA=;
 b=TKrgVE/2D6I3umS64Wo5XcjWT7t10+gZs1hykV5qXaPjYY+oIRlS2KJEdKP8vPWvl3
 IWloJouTslH6V4qEp0/lSQg66PNyE+VmOoWNjDyhe3H0jK0qcQ8uRMzubBTvXsHtaF/E
 N8T1mFtMTZm/2P1fCFviqrM+W8PK8ady4Ol9Bx+0yGrhmX3z+CopbLXlYkb0j3Itm1er
 NwOi9zaty7Mq1WUKaa64qMQN8UsXELPkfxLwMlwDNFZhVMCmV/CFk9Djo9LWWmAc995v
 9v6U9DbV58itT4T7Dft2G2WzId1WfvLGMXEpKx20KVeN8z/AihYig7GcqiXM3aeV8kk6
 5ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773672243; x=1774277043;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcyS4c0ZFzXBzY8/awrHzLx1zlBHC2pXS4g0m2w2ceA=;
 b=bPvO4a1gFnMEHngpo8+1Ty9FhelcAOrZg7s7icoxMGWvplOgRaozUXB2sbZWz4RMGD
 2rfMvwrnMpJ1gqZS+/SN+Gj7tb6NlbGUTKiH5m+rq9zTFjIcvefxieaIfbTNM6PTCkrL
 VLbcjqGnA3KnK7qr+gdgKqRZTL0Q3U4fa0IIEbz32Xw1ax+IUDU8/JPUQG3A1rplCIxM
 6wIsySUWeZ/cDEsi/a/qV9i4I4TkAqxf8kC3rKN5OC3lRygaULD6pp7rbOCWWerAvgnQ
 l3v4/td8Of526w82pJvPwdGxGZJ/cuwGeyhLYJt8/kxwQuVfy5v7M5PZEH2ND6knv34y
 AFHA==
X-Gm-Message-State: AOJu0Yz4M0UaykuhAfFQIAOtsYB25MEsDiQyKMECubEbW+VU8JYlq1YN
 TmpExvFd7AM7wDtVDBuasdf3vEsuy+1OeIzHOeihWmjdukjiXkm4UtFBUSG8xrrY01Q=
X-Gm-Gg: ATEYQzyB72WnALpJan85yJqIhUjdl7M8Dw5yyEoweY+3bCuaEUMo/WrpIhfMpQW3L9Y
 H4KWnS24f9NeuAHv/U2m1ZnOtc7OrqpFJKYMknxhVJTN0eEIH95fLh6wWihp+LrhPpnlxSnX+8D
 2as+QZlCKW959TyKxYxBXTrLpwRNXqL7RR6ehYkBWUJo0a3zOBeYX7Z0o00RW9N+AJFneuK87Uo
 wVx6YliSB+VQSQ6HRER4jy27CBGh+x/XONtLVK/YRj2sb4OrD0IzlwXoJiPskM283T3DITL/CmN
 idF80fBIsctODz1+0DOsF8KJW2qmQ+IzhjMnwCeb410qGUJdMSd0D/4DJ2RIP7DtxUzA8g+ytET
 YnwmMyjqCBNPwfzXLzzCQJu2vFQnzhNp2MmTVzDTBjAfNdzEcZOHsPrd988iu+5YsVhQ4PIomSc
 29q8P/t7LACmwTa+Mf9tQGiAg=
X-Received: by 2002:a17:907:9808:b0:b97:9a7a:9d21 with SMTP id
 a640c23a62f3a-b979a7ab081mr480380366b.4.1773672242958; 
 Mon, 16 Mar 2026 07:44:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97cb0d2e1esm82789166b.55.2026.03.16.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:44:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 978C95FA31;
 Mon, 16 Mar 2026 14:44:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/3] tests/docker: Update the opensuse-leap container
 file to version 16
In-Reply-To: <20260316135407.209072-4-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 16 Mar 2026 14:54:07 +0100")
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-4-thuth@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 16 Mar 2026 14:44:01 +0000
Message-ID: <871phjomvi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Run "make lcitool-refresh" to update the container file to the latest
> version of openSUSE.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Personally I'd merge this with the refresh update in the previous
commit. Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/opensuse-leap.docker | 35 +++++++++----------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker=
/dockerfiles/opensuse-leap.docker
> index d693f2c6f85..66e90fa3634 100644
> --- a/tests/docker/dockerfiles/opensuse-leap.docker
> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> @@ -1,13 +1,12 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all opensuse-leap-15 qemu
> +#  $ lcitool dockerfile --layers all opensuse-leap-16 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>=20=20
> -FROM registry.opensuse.org/opensuse/leap:15.6
> +FROM registry.opensuse.org/opensuse/leap:16.0
>=20=20
>  RUN zypper update -y && \
> -    zypper addrepo -fc https://download.opensuse.org/update/leap/15.6/ba=
ckports/openSUSE:Backports:SLE-15-SP6:Update.repo && \
>      zypper install -y \
>             Mesa-devel \
>             alsa-lib-devel \
> @@ -80,13 +79,14 @@ RUN zypper update -y && \
>             libudev-devel \
>             liburing-devel \
>             libusb-1_0-devel \
> +           libxdp-devel \
>             libzstd-devel \
>             llvm \
>             lttng-ust-devel \
>             lzo-devel \
>             make \
> +           meson \
>             mtools \
> -           ncat \
>             ncurses-devel \
>             ninja \
>             openssh \
> @@ -94,11 +94,17 @@ RUN zypper update -y && \
>             pcre2-devel-static \
>             pipewire-devel \
>             pkgconfig \
> -           python311 \
> -           python311-base \
> -           python311-pip \
> -           python311-setuptools \
> -           python311-wheel \
> +           python3-Pillow \
> +           python3-PyYAML \
> +           python3-Sphinx \
> +           python3-base \
> +           python3-numpy \
> +           python3-opencv \
> +           python3-pip \
> +           python3-setuptools \
> +           python3-sphinx_rtd_theme \
> +           python3-tomli \
> +           python3-wheel \
>             rdma-core-devel \
>             rust \
>             rust-bindgen \
> @@ -110,7 +116,7 @@ RUN zypper update -y && \
>             spice-protocol-devel \
>             swtpm \
>             systemd-devel \
> -           systemtap-sdt-devel \
> +           systemtap-dtrace \
>             tar \
>             tesseract-ocr \
>             tesseract-ocr-traineddata-english \
> @@ -133,18 +139,11 @@ RUN zypper update -y && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
>=20=20
> -RUN /usr/bin/pip3.11 install \
> -                     PyYAML \
> -                     meson=3D=3D1.8.1 \
> -                     pillow \
> -                     sphinx \
> -                     sphinx-rtd-theme
> -
>  ENV CCACHE_WRAPPERSDIR=3D"/usr/libexec/ccache-wrappers"
>  ENV LANG=3D"en_US.UTF-8"
>  ENV MAKE=3D"/usr/bin/make"
>  ENV NINJA=3D"/usr/bin/ninja"
> -ENV PYTHON=3D"/usr/bin/python3.11"
> +ENV PYTHON=3D"/usr/bin/python3"
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

