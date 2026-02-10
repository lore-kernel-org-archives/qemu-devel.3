Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8019DEA812B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppOG-00056N-J1; Tue, 10 Feb 2026 10:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vppOF-00055w-Bj
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:10:59 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vppOD-0006hu-Ma
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:10:59 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c93e0269cso4138754a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:10:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770736254; cv=none;
 d=google.com; s=arc-20240605;
 b=cY5hQ8g5cEKX2+VD/AUMnIQzEE/Qo2/U13b87TnSThABnzXXWJ3oYC7bQygpSJH91P
 BTRsbrsXjVe1wh1DQ4vvK6UfjlgDobH1VMQ87s4wB6kIZqRq0BCJA2Ktu/+sd0meQkKe
 8/iZSyyjxUJ5TjhCHoDYbKXjEMp1BUYTzX1VkKypd1BufYuTtyDFdrNWtc0eN2aYFQdv
 nPBsRkJRpE4ZFOJWxcPeqIzq1RqcRWCWgsip0TZmCxKl20G4T4GSoWBmyGSg/cWKUb0G
 FgdFrwzRpZtb7f8T+JasQwWvU540xzXyvKf1QGlz1/GvO9DdSa/lYvpiD5QDmifdnAb0
 Jc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TsV9h1tmcmY6ze6zuPt5ENCnwnehb4ZNQR6yd6fgK1w=;
 fh=cpW1GerhB7fjJkXYQz+afhx2t9YzVXb9VUY9OOh20to=;
 b=BwZPqAwXw6k2TBMPCQsGHcOPns/X7CNJbWxilYc7wHh7AvqP/e2gWiaz8lfsLtC0c4
 R8x1GKW9a22YfKDMw6X5b5wSgz57eNIufrP/iyxrFlP0BXrEYWOwMGy15zQxX1m5/Zec
 GmbaMI6Sd2nr8qNDMNpW2jWl77Heu2Zz1SmzVfKJI4kAReE0/Y/89++QMtHuKKsF8r5/
 6ewj3uixnD55H7GnY2CsCjb+ePa9YJ2knio/PyMQ5xnE6Z4S0geFJM8yCQuF5/0o7PmS
 Qp3iQWb+D3VnmhwYrQWiw3DHjvHfY+yHzvE+eF6ErWDIH9RC1jpAkojv23WZ28yW9yK+
 5PfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770736254; x=1771341054;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsV9h1tmcmY6ze6zuPt5ENCnwnehb4ZNQR6yd6fgK1w=;
 b=iUFx3CBBnhrGs4cPMAmWKbG89THlrJn2z7AmRanOmQ3ENiWa3P2KLYoEmCE7CnLLoY
 Vj7AXgj09XrNK2IoMMdsuCwAPrwVSoVHKNoa5yIodp+54FICMmJX3cizfajM7e4NkFMA
 8JVm9xttr4LKSfnxSB1coy4O3D/dc3vI8bdK6QasWnJkNUoI3Y5q6s9/67hJMtK27tTi
 GzW/NpAOwKMnqnCs1/OdfFkaPPn1SXyE+31Ins/dyoYrPisOFdV0KDm8aU2dH+Bngu+y
 Y1xdZS+cEWKhrldBhfXWmoJwk4GWbNiI/t8vSsmiV9oByvgJGmXKjSxfzSGHCZJ/yPMu
 CeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736254; x=1771341054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsV9h1tmcmY6ze6zuPt5ENCnwnehb4ZNQR6yd6fgK1w=;
 b=EaNePjkKMpDdJvfvZE7FakVSMda+f+ztR3yK2A3zdLhKHz2S9QYOK5edfihieCeij6
 Y6iDH3/4gwx6L/Fcr3r5o99tORf/tCAIsARoHJ5OgPR8VIIFRnh5rIArh7/mSUs0E28O
 VMVbc8v2ZUPofxaOB7LyDmPU+q+rywlwyAXHWpRWQgpJjxBy6Qgis7ZDNK+6mbOLx+gr
 li65xUTQVcsz1BNZzDzlbYzCtKNnI4Zet1Tx/eno6+/0UDdjz7LfrRo44cXKpAiyh0S1
 Xx5cgutSsV5xx+kgl9Iyh9oY34g5gT3ue56taPK9hOrwRXJOrvj4VPEpNGfoQ33SMuWP
 HFTQ==
X-Gm-Message-State: AOJu0Yxc7HlzU7TX34fskt2sNFDysoJFaIPIjnawtQ3oVu8jX9LE4MdI
 NUCj96pFyBxPOyAjPxEdXAehNb6tSesG+8C2EVeh9i7KYePS+3CQly8LtSRw11c3GUN2F6mVUkw
 ltY8r9D+5xibxVzz/hGnB/tf9DtT6ZxGiC0QT0fFUoFiHOTIsLbj7tW8=
X-Gm-Gg: AZuq6aKT2L4zRgyBu920/vRLXuqBPpc2pqiZYSlbU/Sjkf7kvSmWzXIV+ALXrQb6qHe
 NTZxcic4cddSVWnDVuj2UPFaJy0pS6nMvguCkHhv2WWDdjIGOBJLGqACPn+eUvqxQ4CnbXy/nCQ
 yRyp1Aa29e/cqWVcZY5Ku9ZUjObLCMv/zt4mWaJ1Vrt8rIWXmT45VvAupjIPXGnW2sGNDh6Ow4s
 wwGs994KdDWjbC1OlV6ru0xK8m1jSEUqaDO6z4RWdeFHTfbwmp9Dk7PvEs69AKcLTGjAljzfwZO
 yZXG6BY=
X-Received: by 2002:a17:90b:4f48:b0:354:c40c:7010 with SMTP id
 98e67ed59e1d1-35666227856mr2148481a91.11.1770736254362; Tue, 10 Feb 2026
 07:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
 <20260210-bsd-user-rm-openbsd-netbsd-v1-1-8b8b0f50c29d@bsdimp.com>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v1-1-8b8b0f50c29d@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 08:10:43 -0700
X-Gm-Features: AZwV_QgNIm2KjHt1WJngMFMIq-oomA612YJfl5KIKUOTMZhdPVyTFzdRwJLLHck
Message-ID: <CANCZdfojQ8nSd+8Zy=hUqzXP1mdo=vyf+c_kYGKRJNdya2A6Ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] freebsd: FreeBSD 15 has native inotify
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: multipart/alternative; boundary="0000000000006eb877064a79a924"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000006eb877064a79a924
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 8:07=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:

> Check to make sure that we have inotify in libc, before looking for it
> in libinotify.
>
> Sponsored by:           Netflix
>

Opps, added the wrong SOB here (this is for a different project). This work
wasn't sponsored by Netflix. I'll fix in v2.

I just need Paolo, or somebody, to give it a nod.

Warner


> ---
>  meson.build | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 2d114e9018..537f50283f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2662,13 +2662,15 @@ have_inotify_init =3D
> cc.has_header_symbol('sys/inotify.h', 'inotify_init')
>  have_inotify_init1 =3D cc.has_header_symbol('sys/inotify.h',
> 'inotify_init1')
>  inotify =3D not_found
>  if (have_inotify_init or have_inotify_init1) and host_os =3D=3D 'freebsd=
'
> -  # libinotify-kqueue
> -  inotify =3D cc.find_library('inotify')
> -  if have_inotify_init
> -    have_inotify_init =3D inotify.found()
> -  endif
> -  if have_inotify_init1
> -    have_inotify_init1 =3D inotify.found()
> +  if not cc.has_function('inotify_init') and not
> cc.has_function('inotify_init1')
> +    inotify =3D cc.find_library('inotify')
> +    # libinotify-kqueue
> +    if have_inotify_init
> +      have_inotify_init =3D inotify.found()
> +    endif
> +    if have_inotify_init1
> +      have_inotify_init1 =3D inotify.found()
> +    endif
>    endif
>  endif
>  config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
>
> --
> 2.52.0
>
>

--0000000000006eb877064a79a924
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10,=
 2026 at 8:07=E2=80=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">=
imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Check to make sure that we have inotify in libc, before looki=
ng for it<br>
in libinotify.<br>
<br>
Sponsored by:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Netflix<br></blockquo=
te><div><br></div><div>Opps, added the wrong SOB here (this is for a differ=
ent project). This work wasn&#39;t sponsored by Netflix. I&#39;ll fix in v2=
.</div><div><br></div><div>I just need Paolo, or somebody, to give it a nod=
.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build | 16 +++++++++-------<br>
=C2=A01 file changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 2d114e9018..537f50283f 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2662,13 +2662,15 @@ have_inotify_init =3D cc.has_header_symbol(&#39;sys=
/inotify.h&#39;, &#39;inotify_init&#39;)<br>
=C2=A0have_inotify_init1 =3D cc.has_header_symbol(&#39;sys/inotify.h&#39;, =
&#39;inotify_init1&#39;)<br>
=C2=A0inotify =3D not_found<br>
=C2=A0if (have_inotify_init or have_inotify_init1) and host_os =3D=3D &#39;=
freebsd&#39;<br>
-=C2=A0 # libinotify-kqueue<br>
-=C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
-=C2=A0 if have_inotify_init<br>
-=C2=A0 =C2=A0 have_inotify_init =3D inotify.found()<br>
-=C2=A0 endif<br>
-=C2=A0 if have_inotify_init1<br>
-=C2=A0 =C2=A0 have_inotify_init1 =3D inotify.found()<br>
+=C2=A0 if not cc.has_function(&#39;inotify_init&#39;) and not cc.has_funct=
ion(&#39;inotify_init1&#39;)<br>
+=C2=A0 =C2=A0 inotify =3D cc.find_library(&#39;inotify&#39;)<br>
+=C2=A0 =C2=A0 # libinotify-kqueue<br>
+=C2=A0 =C2=A0 if have_inotify_init<br>
+=C2=A0 =C2=A0 =C2=A0 have_inotify_init =3D inotify.found()<br>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 if have_inotify_init1<br>
+=C2=A0 =C2=A0 =C2=A0 have_inotify_init1 =3D inotify.found()<br>
+=C2=A0 =C2=A0 endif<br>
=C2=A0 =C2=A0endif<br>
=C2=A0endif<br>
=C2=A0config_host_data.set(&#39;CONFIG_INOTIFY&#39;, have_inotify_init)<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--0000000000006eb877064a79a924--

