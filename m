Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E6BC55182
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 01:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr3Yg-0003cw-6P; Mon, 03 Aug 2026 21:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wr3Ye-0003cf-3j
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 21:03:04 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wr3Yc-00021p-18
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 21:03:03 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3808084a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 18:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785805379; cv=none;
 d=google.com; s=arc-20260327;
 b=qBvhaeulH6ltqbzIWKSwu+ntNzZtkRWENmfzz5hcrE5cUHrbXJfCOa/amIQ7N0wLpA
 LxWFjH/5fx41nZuVbi7VrMUK8D+i7HOc9bR0n1XjqzfdPpYvtTCzmhYbi68zKh5T3dgr
 lDRxwNf5rO100HT8i0TkVpxXz6+DJkocrCsCpu2oN1Z+ANm/XA5TJFJovr2C7j7yLdaI
 EszPsDb5Zi1pA8edJOuFJEuzZs8CQYuoUnemoUaTGhDJK2w6fcwkPk9cwTdopXkklheK
 LrN2QYHb5wlU6IDoV7kszpCVAbV2CZWimyNnRZgofeMS5s0aiv3bgeLCQouqzG2JnYIX
 md0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i4yv0zG3BKoGqiguuGl1GNvdP+/h3GSYFOvweP0Wh+I=;
 fh=v+HurI/0nM74mwkwa2YFxsg5B348u7sJ0X5dx84z3DY=;
 b=VQtNWu1s1vrn83+lxc0lgluV8bgz06Ft/BaaoD0aMyO3yTYPY4d5B5y+2qoF5jI2r6
 10A7Zl9bJvIGpKPaEJOcvDvTMxSlFPcrboaZxCz/7smJhlrBJ3fHGLxj5JaGEMsvgJGg
 koPKHVmfmh3nUQig7IdUzqFUL3nA7dcMDKF2uj0BDLLRBHm3nb4v24rd15/CUz9Fbhf+
 G4DD5y3Z+0T7k+JGMlCl96yqd20Ti0W+hMS0escbKSt8xAO1/d2flB8oUCv3/OKEtnaq
 wxcgdabsvRJI2m4u5xkZVjpwu5kN/5p1OHzFPUdT1j8o0/AGDrPJOQph4KPgjKHLxzsv
 g/pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785805379; x=1786410179; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i4yv0zG3BKoGqiguuGl1GNvdP+/h3GSYFOvweP0Wh+I=;
 b=iWkmL3Fi7t90S4MfM11GaGaPsqcZzZKoyV7xuD2O3Ey+Dy6nVimD1pOSyylb9Ej6gr
 AaBUXPA8PyuhVBNG3Zu6tl4Xk2W6q+GYxV9YsF9Ua2coW6xtELUAPtdkiyBRg4KX+dMM
 EQdThavPhJnx2YUUPhHWeML0900xTD5NglUcE4uRuGMDUwwVvRkiq7XU4gKSEKDHrQn6
 PbZqGfEJ+hNSjr8ji+Y/ggsAIJa7T2yUuNMzuyYvWcZ0Czrp2nq0uI3uqXA7JQyBaFwi
 5KexH9etkPz7Fon/C898rlzy4k6YrJPqSVY2FtY9raRsAlAPcYje0YdAaIQx2IuF/ZR6
 xyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785805379; x=1786410179;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i4yv0zG3BKoGqiguuGl1GNvdP+/h3GSYFOvweP0Wh+I=;
 b=WMH8DHg7PbNqQe+6+T4oPxNzjW7RuD131VIJ9ahEPbc5j+DDdNIHmPcYMVGS13Fn5x
 SlMVaK1h2yb+Xo/wtNbOcK7aWugNdZaYzll5ppkFES+xO6hONmv//GmpEpI30d3xEo16
 YfQznfIQJtjW54glewsLizWePHQDLYHj1dg9GmfP4AyGSoJNVkgsyJq/MtD4rF4Ucdxw
 QgsTGNCoH+6spzn5SLeIJ/3h/qigiaT6HqpYlCSaUn7xMn3WFeyfkrHw8ugptEu45xPH
 MC0V6NUsM6RjL/wULXLRJyT21Cq0BRwm2OaUzPcUnD3q87TFcXI7lJpmIHZqEtXVvhqq
 QMFA==
X-Gm-Message-State: AOJu0Yz+A2PMZyq+kXBUHgY1+wQq0YoD2gLzbftRQ4wEJMoqUb/n+VUF
 GBlZhBeXNMybMqQQ+iU5Wm4sSfRBDOmhkvPIY2Wo4m8tEiYaaK6A207lgs820ayHwQbEbCjPwio
 SDo/iMaiCiZOLMM73iOEAAhqQ7cSgMqaXzXUQ
X-Gm-Gg: AR+sD123ulmTsHCdMjtSrAAnbUyzVT6jvUtFc/d5sNJAgRjMBsgw9aTgFqU5B9qmr+x
 f+zjiVUAoud/PZWI/Qgg44ROY9KadokP+5IzHyq6VHFqwPa0KhHzg+5n8P6T1386t5yRsy7jdAD
 YsknfdRIfCvU2LhwE4anG/aBwcQ2PYEntt5xuH4m4+woeiFPk5iEG1Gd1XgOYT71hIlc/tjMztm
 e99SbZKHcO4lnJ4n369hFEmgUrX1q8fj7joAuY2BdYWq9dNtzvQKt8ZA1fn9/Qgt5GSwfbTdtLN
 5cY9hTrX/LA3F21twWxtvkczFQg8D+NTGvW+j8+o6UUurPJ9iX8867TUVu43AVecgbaBQdXSUX2
 MO2ig9hX0Ug==
X-Received: by 2002:a17:90b:2dc4:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-38fbc3ff292mr11345848a91.1.1785805378561; Mon, 03 Aug 2026
 18:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260803180700.367388-1-stefanha@redhat.com>
 <CAJSP0QVzgmN1uBmB+9Bj1GqYfcW0iGq2E0Qg9JTuLKe1+5+-Qg@mail.gmail.com>
In-Reply-To: <CAJSP0QVzgmN1uBmB+9Bj1GqYfcW0iGq2E0Qg9JTuLKe1+5+-Qg@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 4 Aug 2026 10:02:46 +0900
X-Gm-Features: AUfX_mz_5l51cLN0xKdXCy-JdXrjVujENW3pTa_2hH2CK0KmDH_VgI8QJxpEK-Y
Message-ID: <CAEDrbUYt5-ue4qz+brByixSYsVKqVzYgNPjXZywa0KpcKJ+L3w@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: use stable URLs for zlib tarballs
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003a2b5e06582e37f0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1031.google.com
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

--0000000000003a2b5e06582e37f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> The tarballs at https://zlib.net/zlib-X.Y.Z.tar.xz become unavailable
> when a new release is made. This breaks the emsdk-wasm64-cross.docker
> file that fetches the tarball and builds zlib from source.
>
> There is actually an archive available with a stable URL. Use that
> instead. This does require switching from xz to gzip since xz tarballs
> are not available in the archive.
>
> The upshot is that the emsdk-wasm64-cross Docker image build will
> continue working into the future without causing CI breakage when the
> zlib project makes a new release.
>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Fix "bzip2 to gzip since bzip2" typo. It should have been xz instead
>   of bzip2. [danpb]
>
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index c04a741b0e5..4f26ce7a269 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -56,8 +56,8 @@ EOF
>  FROM build-base AS zlib-dev
>  ARG ZLIB_VERSION
>  RUN mkdir -p /zlib
> -RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
> -    tar xJC /zlib --strip-components=3D1
> +RUN curl -Ls https://zlib.net/fossils/zlib-$ZLIB_VERSION.tar.gz | \
> +    tar xzC /zlib --strip-components=3D1
>  WORKDIR /zlib
>  RUN emconfigure ./configure --prefix=3D$TARGET --static
>  RUN emmake make install -j$(nproc)

Thank you for the fix.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Regards,
Kohei Tokunaga

--0000000000003a2b5e06582e37f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Stefan,<br><br>&gt; The tarballs at <a=
 href=3D"https://zlib.net/zlib-X.Y.Z.tar.xz">https://zlib.net/zlib-X.Y.Z.ta=
r.xz</a> become unavailable<br>&gt; when a new release is made. This breaks=
 the emsdk-wasm64-cross.docker<br>&gt; file that fetches the tarball and bu=
ilds zlib from source.<br>&gt; <br>&gt; There is actually an archive availa=
ble with a stable URL. Use that<br>&gt; instead. This does require switchin=
g from xz to gzip since xz tarballs<br>&gt; are not available in the archiv=
e.<br>&gt; <br>&gt; The upshot is that the emsdk-wasm64-cross Docker image =
build will<br>&gt; continue working into the future without causing CI brea=
kage when the<br>&gt; zlib project makes a new release.<br>&gt; <br>&gt; Re=
ported-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.ms=
k.ru</a>&gt;<br>&gt; Suggested-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"m=
ailto:berrange@redhat.com">berrange@redhat.com</a>&gt;<br>&gt; Reviewed-by:=
 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrang=
e@redhat.com</a>&gt;<br>&gt; Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"=
mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt;<br>&gt; ---<br>&gt;=
 v2:<br>&gt; - Fix &quot;bzip2 to gzip since bzip2&quot; typo. It should ha=
ve been xz instead<br>&gt; =C2=A0 of bzip2. [danpb]<br>&gt; <br>&gt; =C2=A0=
tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--<br>&gt; =C2=A01=
 file changed, 2 insertions(+), 2 deletions(-)<br>&gt; <br>&gt; diff --git =
a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerf=
iles/emsdk-wasm64-cross.docker<br>&gt; index c04a741b0e5..4f26ce7a269 10064=
4<br>&gt; --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker<br>&gt; =
+++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker<br>&gt; @@ -56,8 +=
56,8 @@ EOF<br>&gt; =C2=A0FROM build-base AS zlib-dev<br>&gt; =C2=A0ARG ZLI=
B_VERSION<br>&gt; =C2=A0RUN mkdir -p /zlib<br>&gt; -RUN curl -Ls <a href=3D=
"https://zlib.net/zlib-$ZLIB_VERSION.tar.xz">https://zlib.net/zlib-$ZLIB_VE=
RSION.tar.xz</a> | \<br>&gt; - =C2=A0 =C2=A0tar xJC /zlib --strip-component=
s=3D1<br>&gt; +RUN curl -Ls <a href=3D"https://zlib.net/fossils/zlib-$ZLIB_=
VERSION.tar.gz">https://zlib.net/fossils/zlib-$ZLIB_VERSION.tar.gz</a> | \<=
br>&gt; + =C2=A0 =C2=A0tar xzC /zlib --strip-components=3D1<br>&gt; =C2=A0W=
ORKDIR /zlib<br>&gt; =C2=A0RUN emconfigure ./configure --prefix=3D$TARGET -=
-static<br>&gt; =C2=A0RUN emmake make install -j$(nproc)<br><br>Thank you f=
or the fix.<br><br>Reviewed-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokun=
aga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br><br>Regards,<br>Koh=
ei Tokunaga<br><br></div></div>

--0000000000003a2b5e06582e37f0--

