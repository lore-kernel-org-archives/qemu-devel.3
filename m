Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A086BCF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 11:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st489-0005Qw-7n; Tue, 24 Sep 2024 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st486-0005K8-1h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 07:54:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st484-0008DI-1H
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 07:54:53 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365392cfafso5659680e87.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727178889; x=1727783689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=an8OCBlDzGH6BEuuhsfez2SdrFAj2zXulAr/zH2d/G8=;
 b=JP8Exja+8dj7fuukKSKzaQaQuXsm7VKh+aEAoWDUF/3q4d78ymjlodvL8J8N+gKsOy
 sGQRwgu47bNfKxexgEFoxgGTfigECw5qTXdyj/WD2WzwaFqJ0YonIqzDasK4OuhN+BgX
 h96SVWLAaY1gqigDOPxdh51KLelH+dgVQq0+K8PqK6SghfBiJxm1VvLef4yXKTloH2+a
 dOHrwVdOaemDM2l6yeurkB6c/a3NkD6gSsAFh959cuOkqnBV3yexxzUYQTDAEtAKgEjS
 XmfgLbF6RXFi53oqFzd0G8ocf5JsvAkCv1v6NTtuCrr0E7nQ8YmgJHBdpr4RfanMim8m
 fvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727178889; x=1727783689;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=an8OCBlDzGH6BEuuhsfez2SdrFAj2zXulAr/zH2d/G8=;
 b=cml771qXwTVrEWAXdxKJL7evSATK9ykQXu23QbihCChNot5rTfSQXdtlS/P4tAe65V
 iwWyaKrXBkjiJvLaQh4pCNzsy7LLKPxC6ALtc+X1DyMza9MGRDijhOTMXAYYqsUnz8Ur
 SMoZ0hziC9t7xWWc/VAghwwODT2JTgO2AoZspz8WjAsPSZikVn1FXEtgRF+CJqVv8DW8
 T+svHJylTIw5r6xOTlon6DIMEZCNf0UUX412bzNQAGnka1o9MQaqw4FX9gbH6uaNKSeV
 gDf8ZBuCM/8bFZ85t9ARAbrNTpCXS1k1vntfg7zcuFFi8yqmRxt34C+x9K7FhnwVU3By
 z69A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQm/RuxrysrROcekDnfkmOLV+JK7xHgGK8WJJILiXo7/S1uwwTguK8sZcV3BiRoRM7UR3sOPu1LE29@nongnu.org
X-Gm-Message-State: AOJu0YwtIThASdY8+ZL+oZmaBt1ctE4uOn2CRoHIrG44qxCDTJcBbb51
 xj4jgYzztN0xPYhR7Ghw5K2yOvreRvRo/uZOEIINcpPaRVR7yDXvzA9GrXlhSyA=
X-Google-Smtp-Source: AGHT+IFjHmtAsyVtQRc+JSgkR190nsiPb6rIql3kW8OwkFlsbxQ30zC90lQh7AIVH+2RcGNZ/oxLYw==
X-Received: by 2002:a05:6512:693:b0:52e:a63d:e5c1 with SMTP id
 2adb3069b0e04-536ac2f5147mr7935280e87.30.1727178889291; 
 Tue, 24 Sep 2024 04:54:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930fb413sm74841966b.187.2024.09.24.04.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 04:54:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6CFC5F77C;
 Tue, 24 Sep 2024 12:54:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>, Mahesh Bodapati <mbodapat@xilinx.com>
Subject: Re: [PATCH] tests/docker: Fix microblaze atomics
In-Reply-To: <20240919152308.10440-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Thu, 19 Sep 2024 17:23:04 +0200")
References: <20240919152308.10440-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 24 Sep 2024 12:54:46 +0100
Message-ID: <87wmj1clmh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

(add Mahesh to CC)

> GCC produces invalid code for microblaze atomics.
>
> The fix is unfortunately not upstream, so fetch it from an external
> location and apply it locally.

Queued to testing/next, thanks.

However I didn't see any tests failing so I'm curious where you saw the
problem? Would it be worth adding an atomics test (microblaze or
generic) to catch this?

Also for the Microblaze guys is there any push to upstream the patches
you have into GCC or have an easily distributively binary build we could
convert our dockerfiles to?

>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../debian-microblaze-cross.d/build-toolchain.sh          | 8 ++++++++
>  tests/docker/dockerfiles/debian-toolchain.docker          | 7 +++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/debian-microblaze-cross.d/build-too=
lchain.sh b/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolch=
ain.sh
> index 23ec0aa9a72..c5cd0aa931c 100755
> --- a/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.=
sh
> +++ b/tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.=
sh
> @@ -10,6 +10,8 @@ TOOLCHAIN_INSTALL=3D/usr/local
>  TOOLCHAIN_BIN=3D${TOOLCHAIN_INSTALL}/bin
>  CROSS_SYSROOT=3D${TOOLCHAIN_INSTALL}/$TARGET/sys-root
>=20=20
> +GCC_PATCH0_URL=3Dhttps://raw.githubusercontent.com/Xilinx/meta-xilinx/re=
fs/tags/xlnx-rel-v2024.1/meta-microblaze/recipes-devtools/gcc/gcc-12/0009-P=
atch-microblaze-Fix-atomic-boolean-return-value.patch
> +
>  export PATH=3D${TOOLCHAIN_BIN}:$PATH
>=20=20
>  #
> @@ -31,6 +33,12 @@ mv gcc-11.2.0 src-gcc
>  mv musl-1.2.2 src-musl
>  mv linux-5.10.70 src-linux
>=20=20
> +#
> +# Patch gcc
> +#
> +
> +wget -O - ${GCC_PATCH0_URL} | patch -d src-gcc -p1
> +
>  mkdir -p bld-hdr bld-binu bld-gcc bld-musl
>  mkdir -p ${CROSS_SYSROOT}/usr/include
>=20=20
> diff --git a/tests/docker/dockerfiles/debian-toolchain.docker b/tests/doc=
ker/dockerfiles/debian-toolchain.docker
> index 687a97fec4a..ab4ce29533d 100644
> --- a/tests/docker/dockerfiles/debian-toolchain.docker
> +++ b/tests/docker/dockerfiles/debian-toolchain.docker
> @@ -10,6 +10,8 @@ FROM docker.io/library/debian:11-slim
>  # ??? The build-dep isn't working, missing a number of
>  # minimal build dependiencies, e.g. libmpc.
>=20=20
> +RUN sed 's/^deb /deb-src /' </etc/apt/sources.list >/etc/apt/sources.lis=
t.d/deb-src.list
> +
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> @@ -33,6 +35,11 @@ RUN cd /root && ./build-toolchain.sh
>  # and the build trees by restoring the original image,
>  # then copying the built toolchain from stage 0.
>  FROM docker.io/library/debian:11-slim
> +RUN apt update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        libmpc3
>  COPY --from=3D0 /usr/local /usr/local
>  # As a final step configure the user (if env is defined)
>  ARG USER

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

