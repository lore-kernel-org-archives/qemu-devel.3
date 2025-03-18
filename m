Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6845CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufZn-000288-5K; Tue, 18 Mar 2025 18:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tufZf-00020g-2R; Tue, 18 Mar 2025 18:38:16 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tufZc-0000ze-J6; Tue, 18 Mar 2025 18:38:14 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3fea67e64caso583599b6e.2; 
 Tue, 18 Mar 2025 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742337487; x=1742942287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ur2+UR2faoF2snFORmP8GukCGRDJPf/ZNZug1dv0E2E=;
 b=e2uPeMJHrsVhdVMDVmySPfqVX8gK5mdDiimdaYWg1Bi6V4NpXRodc5nC8XnB+4viQ4
 ZqjA8zVNZoU/Adzr4SKNnh4iKsucEDWNBgwX8wlaez27blCROG2GO9MSzd0/6bccAiSq
 bfa6536SZAoVcKrEvPEjPXF7OdyJB0eBlqOcY1Xg8JXw0+jseCY/858/n9BTRf43SZXc
 b293mLzMbCdmVDJX6RsMWlZKHJCOqOqSSoY+cQXiaZBTAvw2/hRAfzGIOQCuhB4//1gV
 tvxfcqHjxWHC9sFNWQZkxdWAUDcyzUoFic+kaGGQ8AM9JhusPtB5CTCkR9vGsDxGaXAo
 jtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337487; x=1742942287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ur2+UR2faoF2snFORmP8GukCGRDJPf/ZNZug1dv0E2E=;
 b=ZdxRfVvt1O0RBwwi7eb5yznO+ggXFFHfmLDip4GjYqwNTm5YOfRP+HtcxsoM1AM/lj
 L2MYLqLf4C0yXEBi6J1p4ArtpfIKMtvYQp0cH17sj2JLI0FBkL/tn5WzCS1LU+ptgmgV
 8mWWxJj9F9CvpNEBkpPCfbjw4OUqSjatonyzvcmcpVRscXZY0nY5mtT58nwLwDwUKQ5u
 /c9ouohx9jMt+czB0YTFbtQmNOYguPtnzmRfpBJaeYjaEJ2mPBhjlYfIaBYC51up9Hjq
 3D52invt9LF09J8QfDYpiEpdESsOMJ8qMPSBTRzKjMChYFd5SWCbZScaqgTc89g1944t
 yz6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVigXdBvt1KaS09M7k2uCaOYy2fCYn8JFPdbBaEOW7vV8XCDnodO+Oe6ezsVmrmWKdaVfJHNhhmtw==@nongnu.org
X-Gm-Message-State: AOJu0Yy/H8IQfqxwPBbp50Za8GDFEpahug+NGNXFT3OEgTlVkxrlHNDg
 Zbse9f7mZ1HtYBB8xgni3BR9dPKlpLb8dGwJmzuhPW9aqBPzWo+4qrSMA/7+Ls7XXYfNL5SkfeD
 vonbU+7pCExeRQ88G3DqsJL3XG6Q=
X-Gm-Gg: ASbGncv/itlFhVRvDP71CAO5wZbIzGrNZ8Kz4OUZGnJRiK4DVMayakghK0gMWch2Oi8
 dGW/0LlKceYnR80sJuXh4kupuUA+RKr5uDY+g5prShiw9TpBAhsfppGHwNiXV2J2vtsWJ1aOtw/
 dNzRxCJI+XN/mvuAnJq7h2p08i8NkY7PffvMo3BE3F3bYJG+r3TZYeam6+
X-Google-Smtp-Source: AGHT+IEZDrP7rdTTKK3n+z5M+rIs0rqVFeoJD26b8rLzxIEKp0A8iqhp325l3KylUi6GEh4m6NjH/NNv2HK/NfVvBKs=
X-Received: by 2002:a05:6808:1645:b0:3f9:56ff:1468 with SMTP id
 5614622812f47-3fead5b65cbmr238934b6e.24.1742337486775; Tue, 18 Mar 2025
 15:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250318055415.16501-1-thuth@redhat.com>
In-Reply-To: <20250318055415.16501-1-thuth@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 18 Mar 2025 23:37:55 +0100
X-Gm-Features: AQ5f1JppQe0Fdq14vsW5zFBD8ORE_6qkzwDUUl7MVyB4WdZLKY2HsZnj6jCYMZY
Message-ID: <CAPan3Wr=Td9EK3F5XgMkPeWyDEWfKbKocbsNew9Jf7gsjTppAQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Use the meson binary from the pyvenv
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Content-Type: multipart/alternative; boundary="000000000000fa6dc70630a58ea7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oi1-x22c.google.com
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

--000000000000fa6dc70630a58ea7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Tue, Mar 18, 2025 at 6:54=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> From: Thomas Huth <thuth@redhat.com>
>
> To avoid problems with the meson installation from the host
> system, we should always use the meson from our venv instead.
> Thus use this in the documentation, too.
>
> While we're at it, also mention that it has to be run from
> the build folder (in the igb.rst file; the other two files
> were already fine).
>
> Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/arm/bananapi_m2u.rst | 2 +-
>  docs/system/arm/orangepi.rst     | 2 +-
>  docs/system/devices/igb.rst      | 5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/arm/bananapi_m2u.rst
> b/docs/system/arm/bananapi_m2u.rst
> index d30db8d04c3..6efa222c16f 100644
> --- a/docs/system/arm/bananapi_m2u.rst
> +++ b/docs/system/arm/bananapi_m2u.rst
> @@ -136,4 +136,4 @@ provide the following command:
>
>    $ cd qemu-build-dir
>    $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \
> -    meson test --suite thorough func-arm-arm_bpim2u
> +    pyvenv/bin/meson test --suite thorough func-arm-arm_bpim2u
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index 8b9448ca7b0..716062fca9c 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -262,4 +262,4 @@ provide the following command from the build director=
y:
>  .. code-block:: bash
>
>    $ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \
> -    meson test --suite thorough func-arm-arm_orangepi
> +    pyvenv/bin/meson test --suite thorough func-arm-arm_orangepi
> diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
> index 9145af5c757..71f31cb1160 100644
> --- a/docs/system/devices/igb.rst
> +++ b/docs/system/devices/igb.rst
> @@ -57,11 +57,12 @@ directory:
>    meson test qtest-x86_64/qos-test
>
>  ethtool can test register accesses, interrupts, etc. It is automated as =
an
> -functional test and can be ran with the following command:
> +functional test and can be run from the build directory with the followi=
ng
> +command:
>
>  .. code:: shell
>
> -  meson test --suite thorough func-x86_64-netdev_ethtool
> +  pyvenv/bin/meson test --suite thorough func-x86_64-netdev_ethtool
>
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.48.1
>
>

--=20
Niek Linnenbank

--000000000000fa6dc70630a58ea7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklin=
nenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Tue, Mar 18, 2025 at 6:54=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">From: Thomas Huth &lt;<a href=3D"mailto:th=
uth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt;<br>
<br>
To avoid problems with the meson installation from the host<br>
system, we should always use the meson from our venv instead.<br>
Thus use this in the documentation, too.<br>
<br>
While we&#39;re at it, also mention that it has to be run from<br>
the build folder (in the igb.rst file; the other two files<br>
were already fine).<br>
<br>
Suggested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.co=
m" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/system/arm/bananapi_m2u.rst | 2 +-<br>
=C2=A0docs/system/arm/orangepi.rst=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0docs/system/devices/igb.rst=C2=A0 =C2=A0 =C2=A0 | 5 +++--<br>
=C2=A03 files changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2=
u.rst<br>
index d30db8d04c3..6efa222c16f 100644<br>
--- a/docs/system/arm/bananapi_m2u.rst<br>
+++ b/docs/system/arm/bananapi_m2u.rst<br>
@@ -136,4 +136,4 @@ provide the following command:<br>
<br>
=C2=A0 =C2=A0$ cd qemu-build-dir<br>
=C2=A0 =C2=A0$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \<br>
-=C2=A0 =C2=A0 meson test --suite thorough func-arm-arm_bpim2u<br>
+=C2=A0 =C2=A0 pyvenv/bin/meson test --suite thorough func-arm-arm_bpim2u<b=
r>
diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst<br=
>
index 8b9448ca7b0..716062fca9c 100644<br>
--- a/docs/system/arm/orangepi.rst<br>
+++ b/docs/system/arm/orangepi.rst<br>
@@ -262,4 +262,4 @@ provide the following command from the build directory:=
<br>
=C2=A0.. code-block:: bash<br>
<br>
=C2=A0 =C2=A0$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 \<br>
-=C2=A0 =C2=A0 meson test --suite thorough func-arm-arm_orangepi<br>
+=C2=A0 =C2=A0 pyvenv/bin/meson test --suite thorough func-arm-arm_orangepi=
<br>
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst<br>
index 9145af5c757..71f31cb1160 100644<br>
--- a/docs/system/devices/igb.rst<br>
+++ b/docs/system/devices/igb.rst<br>
@@ -57,11 +57,12 @@ directory:<br>
=C2=A0 =C2=A0meson test qtest-x86_64/qos-test<br>
<br>
=C2=A0ethtool can test register accesses, interrupts, etc. It is automated =
as an<br>
-functional test and can be ran with the following command:<br>
+functional test and can be run from the build directory with the following=
<br>
+command:<br>
<br>
=C2=A0.. code:: shell<br>
<br>
-=C2=A0 meson test --suite thorough func-x86_64-netdev_ethtool<br>
+=C2=A0 pyvenv/bin/meson test --suite thorough func-x86_64-netdev_ethtool<b=
r>
<br>
=C2=A0References<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div>

--000000000000fa6dc70630a58ea7--

