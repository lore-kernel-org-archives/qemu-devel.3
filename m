Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE0CC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiad-00042S-FU; Tue, 25 Aug 2026 00:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wyiab-00041U-IR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:16:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wyiaZ-0002OP-VF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:16:45 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so3720301a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787631402; cv=none;
 d=google.com; s=arc-20260327;
 b=e6Mh8EF4AiTerMR8i+0fZnrcRjVCUJEXP3pLBKdUEf+lbUrosaWI5LlBRWuhdejB3A
 imLshMAIK4QRqqKKp1AaGu8enGJope0gGb6qI+FBmcJlDXvkDgeNGFRrQlMTejzRhhiR
 h4MXfdeIx3O7qmxyZ6JuIziBrz/ZmPtCtQS+2mdAQhblwPKeaofXxU8/vWXTBzL/noCe
 rFIUiqvSf+rb3ufY78A1Uh+uJJhGbF2LqYdg2hnaYk2c5hmzdFzzUNHtLkdHw6345qto
 1AkcGZdhkY07AvRkdnaFxjBrqVNBwRUZHyKkp86j28ABgaDKUOlxDrtEkc5Y+YRSGkjn
 9JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WeorhylmTGvZHmjIljUcojLz8W7gdjxQuSUTFU9wu8w=;
 fh=IgCz8vGf/vCwhFivRaOdNxIYp8J1BN39+hpD0RE5lEw=;
 b=HIYNt+wyFlY53HsIyrqbHhEpwL1RZZTPj4oe9ulzkipIpHcgFS10cX91BGudWrS1J5
 78fiitQ6SDdv1It7TyX/2puCJ+3JPcmuVUjwMc2pE1PEpsNonH6/KNqntRkJwYQNN2kD
 bqy6vwUcJ9F1Ybe0nt5DExGWk2TUJU7drYnUmc5w0i+84QbXh0Q+rb0E6Ht7cD4ZtJ4/
 cA/FdQUs+/wIbis9bokkZdDTozrbMBgFd5wga4TWJzSyo5pmx/XIWzyjUDWT9Gr6IPWV
 utaMR3KIVpgcNHpdxxowWjfyhNdbOjjj1bf231/td4zK0u84ao8CkVKvqLHboDl110nU
 VHuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787631402; x=1788236202; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WeorhylmTGvZHmjIljUcojLz8W7gdjxQuSUTFU9wu8w=;
 b=XyiyT/CMm1L+bwYKw4N5KqFQmZ2s3JD89kytgdkZ2EaPGYGroY/X4fL9uXsYVvRGuP
 gEeEhhBKHWF6/ggRuATux6cNtS8fjkQdbcDFn91zVzEXWqn2o1NOKsn3Y9yUZZxBFdvP
 /8pnQUZq6pXTps3rA7In6FkC6DRZG/Hu81Z8KiouoC4E1refWXmdBreokvy/aM2ULcMV
 BuPJJQBIcQPETEIvlRklBXz/z0VQE3ARFNXFrzHK3UIMEcOvmNpk2Ed2GXQY2ZF2iwKU
 EipG1pgW2ylIjxk4fdpxfAuz2VTfzfeddbO4wpPyC8ih2e9MC0Dc4pXTpmfTou9LCsf8
 DO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787631402; x=1788236202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WeorhylmTGvZHmjIljUcojLz8W7gdjxQuSUTFU9wu8w=;
 b=X8UW+QeZzyZDMGUWVLbjSw6Waqtc/kzDnH9g/a+CkhlL8CIiVHV12xRhmxNf2PptMv
 UE+zkgvGlhkiHe9rsok5SGpeHHGp0qe7vDZbBR9WpwxJ3jygzfE+YRmKsV+EdyI0aWHR
 aREYvTjXDgRfdVKJsweXshqxTiof26s4KRbbdI9FInlw+sbQ7XgGBZ0W2MvH7kMBx/ly
 nMK7MoO2JrXJwKfJchtb/qlhEwFH++OKzfN048nmw7BkAeykvcj7q3Frg/FQfdwhIeoZ
 A8XP6GJQ/DZ4p4Ni5WnMtOzTkTyFqOMr7vD15OYv6BH/naCxdgMI0FM3GdcAn1ORX6Y3
 gNdw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk4s4R6JBleqpkMapvu17a3SZsASm60JJ/4gkXPYwSAFHjwPVo1iF4r7k5iGgk75Avf6yB+zUk7uH0@nongnu.org
X-Gm-Message-State: AFuF++lU/B5RUdepnN2676973dpqs0N946HWyslFCGkgvY6EMKLA+KFI
 0XSCLqpy4b90+f+vSD8nufQoejDU/mDNdSzELpifRRyp34DgTpPegM2TCwyASO+EUDXSRgFPjkA
 uSU6jUJx92gfX8hF7OdWCGwehDeSnLDk=
X-Gm-Gg: AR+sD135BEoDkdRfIwbtaLP/F57y5zopBVAFZ/J6RnqNq9l8hDfJDz/TqDNCvj7ISlT
 U93JTvH+7aO6AtZX/gRN6JSM4/OSo65iaBu2K+BRiva2DNcqpPFoVCJjpCPMQtf4jVX6iG1FxIg
 9Y0G2tKQIJtGqlceUO/NY67xZciWntBDwiv+eLR5OiZoMoflh5WdVjg5asq8cdAwLQ3CQYOBCB5
 9DKTv/xCpZQ2suDITG8LkVDtC172obpIqOKjUpT252DmO2heUrpSQvtxn9xlsXAHS5izz93HPPr
 ocgitnT6hRFeujwGUUEM4AZMUIhnGooAotjVp5PbaQZeidTAtln+Tosv0kxzuhrCLhUetE2pRfo
 =
X-Received: by 2002:a17:90b:33c4:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-395c3552287mr55553395a91.13.1787631401972; Mon, 24 Aug 2026
 21:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-4-jsnow@redhat.com>
 <178755712684.3526866.6785976168211066891.b4-review@b4>
In-Reply-To: <178755712684.3526866.6785976168211066891.b4-review@b4>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 25 Aug 2026 13:16:30 +0900
X-Gm-Features: AcwNN1XNdyId4xs1P3Orf3mw3VrbAlMknzJBE5waCrNm70W8JsN5IsiSsyiLFvI
Message-ID: <CAEDrbUa_aa=sXTPdkiHEHdo3wCY4mEo3B3BWkfkPiN=jB9s1-w@mail.gmail.com>
Subject: Re: [PATCH 03/12] tests: update emsdk-wasm64-cross
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="000000000000b436810659d75e64"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102e.google.com
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

--000000000000b436810659d75e64
Content-Type: text/plain; charset="UTF-8"

> This container currently uses Ubuntu 22.04 as a base, which is no
> longer supported by QEMU as a build platform. Upgrade to a newer
> version of the image which will provide Python3.12+.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index c04a741b0e5..f11a9f34244 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -1,6 +1,6 @@
>  # syntax = docker/dockerfile:1.5
>
> -ARG EMSDK_VERSION_QEMU=4.0.10
> +ARG EMSDK_VERSION_QEMU=5.0.2
>  ARG ZLIB_VERSION=1.3.2
>  ARG GLIB_MINOR_VERSION=2.84
>  ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
> @@ -27,7 +27,7 @@ RUN apt-get update && apt-get install -y \
>      pkgconf \
>      ninja-build \
>      python3-pip
> -RUN pip3 install meson==${MESON_VERSION} tomli
> +RUN pip3 install --break-system-packages meson==${MESON_VERSION} tomli
>  RUN mkdir /build
>  WORKDIR /build
>  RUN mkdir -p $TARGET

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--000000000000b436810659d75e64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; This container currently uses Ubuntu=
 22.04 as a base, which is no<br>&gt; longer supported by QEMU as a build p=
latform. Upgrade to a newer<br>&gt; version of the image which will provide=
 Python3.12+.<br>&gt; <br>&gt; Signed-off-by: John Snow &lt;<a href=3D"mail=
to:jsnow@redhat.com">jsnow@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0tes=
ts/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--<br>&gt; =C2=A01 fi=
le changed, 2 insertions(+), 2 deletions(-)<br>&gt; <br>&gt; diff --git a/t=
ests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfile=
s/emsdk-wasm64-cross.docker<br>&gt; index c04a741b0e5..f11a9f34244 100644<b=
r>&gt; --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker<br>&gt; +++=
 b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker<br>&gt; @@ -1,6 +1,6 =
@@<br>&gt; =C2=A0# syntax =3D docker/dockerfile:1.5<br>&gt; <br>&gt; -ARG E=
MSDK_VERSION_QEMU=3D4.0.10<br>&gt; +ARG EMSDK_VERSION_QEMU=3D5.0.2<br>&gt; =
=C2=A0ARG ZLIB_VERSION=3D1.3.2<br>&gt; =C2=A0ARG GLIB_MINOR_VERSION=3D2.84<=
br>&gt; =C2=A0ARG GLIB_VERSION=3D${GLIB_MINOR_VERSION}.0<br>&gt; @@ -27,7 +=
27,7 @@ RUN apt-get update &amp;&amp; apt-get install -y \<br>&gt; =C2=A0 =
=C2=A0 =C2=A0pkgconf \<br>&gt; =C2=A0 =C2=A0 =C2=A0ninja-build \<br>&gt; =
=C2=A0 =C2=A0 =C2=A0python3-pip<br>&gt; -RUN pip3 install meson=3D=3D${MESO=
N_VERSION} tomli<br>&gt; +RUN pip3 install --break-system-packages meson=3D=
=3D${MESON_VERSION} tomli<br>&gt; =C2=A0RUN mkdir /build<br>&gt; =C2=A0WORK=
DIR /build<br>&gt; =C2=A0RUN mkdir -p $TARGET<br><br>Reviewed-by: Kohei Tok=
unaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.=
com</a>&gt;<br><br></div></div>

--000000000000b436810659d75e64--

