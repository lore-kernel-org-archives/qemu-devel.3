Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A5ECAC59A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Sep 2025 03:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0Acd-0005OB-TL; Sat, 20 Sep 2025 23:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v0Aca-0005Nm-Ik
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 23:20:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v0AcU-0007K2-Kt
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 23:20:15 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b54a2ab01ffso2376077a12.2
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758424806; x=1759029606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U+AOLgxchQSNO9JByX40uQeCEy7YPXJ8LnPidzeMAoU=;
 b=Ump3VEJqz5GPword6Dlqn3yWaEWWkOno7x55VbnlidAyWkcJcZtlYaH5BY8lZsU4li
 G4EIOGAZKbrTmPdPI/cH7+NW6tTyFeBi75u8eaV8jaF/OJhS5AyS1MnAfCfZ1Mq46ePB
 KB8jWGbRWfEJdADedefP4+q1AuqGp0Qu+jA788EgC4bcPutFHezztBEKd/HEtE2aEfAp
 b1EsJv/jgFcl404RyCbJRPG9nFJKgbX5LSx0ETHtmWJISQ+lh3XI4cSvk02yTVlIdYi9
 V7IEBtjwFr1XJdFvcI+UsL80dlK1CitCobXscE6P3Urx8J1XfYd956BD28Z4g6UbeNm2
 wj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758424806; x=1759029606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+AOLgxchQSNO9JByX40uQeCEy7YPXJ8LnPidzeMAoU=;
 b=i99UmB9DbpjpNzKBg8CtUgS0hwO1zMYEYmNShruA1WxPiLKyB95iFob53S7ZX3TM/K
 rAooVRY1tk3tNJlMgsiw3H7v1cjBCyn6MKTdrlbLxACuJZSiIqVDHnbdc4MIniuMnxiY
 CZRZUEBeta1m4hhnFuWkYGn0yPgerNznGCL8QR3uZxsEE1x1VV6l32Fm1chgY+awHDlR
 AfxsUCbn3ehwdPbb7Niih6sRgl9bJ34dKAe998CeVLLHGhJIlCFtguXmKT1PODCgG1vP
 W32c1LtJkPMx4Nxi0GrF2uq+AW4//VTtkxgFLLo2yXOL0IOA21hcJV0Opa0ZIqbWQWDe
 8aUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Uw74Ntm5afMOoi2QvZmKnRlhXC3bP9OjfBy5uuSvvYdYYHtufzTrBs0aNreW7Y0sk/0FXaKzJxIy@nongnu.org
X-Gm-Message-State: AOJu0YymcVDy35zzXrKC+8GC28hcTSzfa4IDhOh1fChW4XZ4HaBorjB4
 qvhBPWWnbmDvt9xhAOufdknBYBkthRDNW97pLgANmoBJ7GQe4sxnZ5F2lHtyOF+DhKCfrVww6AP
 aoI7d7JsP3Qdry26Gdk5fUsxOloXPXug=
X-Gm-Gg: ASbGncub7Ofbpz3bb3tE9DP9VVka4uCUGLRv1bKTg5sgfpYaiHpMUEZKeWodakwxCUD
 668DPMV38DIm8YHF96d0N65cYAYfFR7WhAfLntE/5gkWogI3DI1ZbYAbx/iTai1HP6DzJTA5Ltt
 eY+ZjUGlSas0gGJcOXqx0FrD6P/DaNHvs3vgmcvvqZLtNAmVyD9HWJO5IssgYf7lID57Re9hg9D
 /MtLbw=
X-Google-Smtp-Source: AGHT+IHXgldAWbLPNGVAoQT85RQk0kuvGbzHuFKoBUpuvxg3gyei7f6RpYOdZoM1CEKBHicQ3ZcjLIwQQyzhoLsixp0=
X-Received: by 2002:a17:902:e34d:b0:24b:1589:5054 with SMTP id
 d9443c01a7336-269ba459b10mr76021905ad.23.1758424805778; Sat, 20 Sep 2025
 20:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-9-marcandre.lureau@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sun, 21 Sep 2025 12:19:53 +0900
X-Gm-Features: AS18NWBElD4T3RJYFf1RGNY3E5yDKZP4muaTfL46Pi2r4JghF39kR9BIWjUohqs
Message-ID: <CAEDrbUatca2WBq5xLoC6CPgFz30ndAmFpucGNzWYynY_EkvkHw@mail.gmail.com>
Subject: Re: [PATCH 08/24] tests/docker: use fully qualified image name for
 emsdk
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e9aaef063f472d74"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
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

--000000000000e9aaef063f472d74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Without it, at least it fails with podman on fc42:
>
> [1/6] STEP 1/15: FROM emscripten/emsdk:3.1.50 AS build-base
> Error: creating build container: short-name resolution enforced but
cannot prompt without a TTY
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm32-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
> index 60a7d02f56..6b1642a207 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
> @@ -8,7 +8,7 @@ ARG PIXMAN_VERSION=3D0.44.2
>  ARG FFI_VERSION=3Dv3.4.7
>  ARG MESON_VERSION=3D1.5.0
>
> -FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
> +FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
>  ARG MESON_VERSION
>  ENV TARGET=3D/builddeps/target
>  ENV CPATH=3D"$TARGET/include"

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Regards,
Kohei Tokunaga

--000000000000e9aaef063f472d74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>=
&gt;<br>&gt; <br>&gt; Without it, at least it fails with podman on fc42:<br=
>&gt; <br>&gt; [1/6] STEP 1/15: FROM emscripten/emsdk:3.1.50 AS build-base<=
br>&gt; Error: creating build container: short-name resolution enforced but=
 cannot prompt without a TTY<br>&gt; <br>&gt; Signed-off-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0tests/docker/dockerfiles/e=
msdk-wasm32-cross.docker | 2 +-<br>&gt; =C2=A01 file changed, 1 insertion(+=
), 1 deletion(-)<br>&gt; <br>&gt; diff --git a/tests/docker/dockerfiles/ems=
dk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker=
<br>&gt; index 60a7d02f56..6b1642a207 100644<br>&gt; --- a/tests/docker/doc=
kerfiles/emsdk-wasm32-cross.docker<br>&gt; +++ b/tests/docker/dockerfiles/e=
msdk-wasm32-cross.docker<br>&gt; @@ -8,7 +8,7 @@ ARG PIXMAN_VERSION=3D0.44.=
2<br>&gt; =C2=A0ARG FFI_VERSION=3Dv3.4.7<br>&gt; =C2=A0ARG MESON_VERSION=3D=
1.5.0<br>&gt; <br>&gt; -FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-=
base<br>&gt; +FROM <a href=3D"http://docker.io/emscripten/emsdk:$EMSDK_VERS=
ION_QEMU">docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU</a> AS build-base<=
br>&gt; =C2=A0ARG MESON_VERSION<br>&gt; =C2=A0ENV TARGET=3D/builddeps/targe=
t<br>&gt; =C2=A0ENV CPATH=3D&quot;$TARGET/include&quot;<br><br>Reviewed-by:=
 Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.m=
ail@gmail.com</a>&gt;<br><br>Regards,<br>Kohei Tokunaga</div></div>

--000000000000e9aaef063f472d74--

