Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C90C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qw8-0000Ig-5G; Tue, 15 Sep 2026 07:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QvV-0008Vn-Dx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QvT-0005BV-Od
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Rjt7zET7hvkaBbpC4zms4/6Qqc6b+RmcnR9rU3hQL4=;
 b=W+VXr4QY1QPrWkMosrX7C2+IFmCRMCAeajkfMPTUH4K9s4OCrbTe3k1Q7nXCKJCmf+WQWg
 2kkgLnmxDUqPXFomOr+vY42WScuSp44MCniTbLZLQi5sWOosCshw3hfhGjapH9C8gzZP5b
 om6JFfhDGqaZiq+lvKZTFPl2aqLePZw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-pIgVSfbdPXWAfqO7gYHc-Q-1; Tue, 15 Sep 2026 07:02:08 -0400
X-MC-Unique: pIgVSfbdPXWAfqO7gYHc-Q-1
X-Mimecast-MFC-AGG-ID: pIgVSfbdPXWAfqO7gYHc-Q_1789470128
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cdc69a7b5so92760836d6.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470128; cv=none;
 d=google.com; s=arc-20260327;
 b=IBi0swD/qlNP7Hq8dIbKCBzvkxvclILxD2T1DwboO1T2APXeDz+8RB9y+xlsDaslcr
 KopgzOSphQqkpN2QVF2R4fhJOTXOji7DaP6WYBvA9ETFsfTYgVTnP/gupyK08k64XgXw
 WCcVhsMlldtLj/tGbIGv+Zn2vhnIZ/EqZNBYrG7+gNaCDA/JcZ6E21NezUszj98IN+h1
 6pT+JLQNarlTDIQjiBwHrtgNTkWvTJtD4679TvazakwUtMTj22qP6IqKWundj0ybtrrI
 53/FTup89eohBdQUzeH3cijCaaBijlfqQMNYIhuQCEE/Tv/6rfUbww2QPVxjozH+MzNy
 /YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2Rjt7zET7hvkaBbpC4zms4/6Qqc6b+RmcnR9rU3hQL4=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=h7kE4UyNDpMSEQAiAi7oPlZCeUersUg5uNCIe8YskjNOaibkkWEoX3pd7MNdIPzKbY
 KKwTgWWivW5J3vcCkZZc1OX4aLfr4A1t3tHWjzDFzDG0+d58HEsoJvFSynjPxGT9+w3l
 2/3uOKMQp/LESqmPnjLKGycPtuwMUa2Klfrrc4x/4X7bxPrZuetsaLT4jqwoMTTvEIJv
 9kBtBXhFghsgne2aqxom30Y0koAD6dXT83gU1e3ztbaUGsGJPFkEOiI+hYA/ewc49B2I
 x8bAkEeHB5gL41OcK7/JzweH3+2/yd/4XZ4fWP3PubXehyGTrMLcvIIPIoWkvnOIow0e
 1+Rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470128; x=1790074928; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Rjt7zET7hvkaBbpC4zms4/6Qqc6b+RmcnR9rU3hQL4=;
 b=Gov6G1tmfJJ8Gd4NGebECm/vsvUpepjfkNpTIQ4HGEC5Al09lu0aTr9IesLIleTPav
 xyfFDptopyrviIZZKhBy7aO9ROgVJ7MYOQpzLBuBPWm6nCsUtmEFmATr1aEj/GXJMtxI
 QyU1VA4KKSaPE/zx4gQZ4RBuo5XPpLn1iBHHvLEWVSJKnE7y6i20iVOQLoqdnwlK04we
 c4MmrhxWOTu8JIqYXUv9PsQt/06kVsZ48enhm7uc4Cr0790pcZEJsTz7t5TjJHtTu6Nd
 9mrPmDqJYPgeAG1ZAlCZsnbpl6BctN3gPB6qS1w2eDW4R8DzVg/xE3tibNaCLxxqoitM
 ONxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470128; x=1790074928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2Rjt7zET7hvkaBbpC4zms4/6Qqc6b+RmcnR9rU3hQL4=;
 b=ECK3VfPwDAUitIHbD8acOzQQc3+uhoCNhuuoo8dEsclJdUScxtiAUdx0ajq+REkpM1
 MAteNimsC73cp6kUqjmbwHYzefhIA4aBIdhI1HgY9+OBzkQjFCSnXuANJaMcYNsYnd0Y
 nO1CwEJWaIzScV6BqhBZKq+mF1aycvuLgh2Jy4xHdkcfzCed6fqqfgpepuaBT9myzwks
 P43/yIgBsI2p6JlowvKeJOPo7tWCk+7BgVofPZel5dXlu5d8E9vWd0b+RlrRoDuYOF1N
 Z7gAmoSAZK5sCr62FmxzlpVKofJzEXsBWxsLwrYxZJsQuleOGrfEVj7FvhgZRciBbxi7
 4fvg==
X-Gm-Message-State: AFuF++lMq6+38Y+g2Kpx2HE8j/b8SUDDITTIsOasFXetIdCvjCY1bCwq
 BTMrL/G15KG3JiKwCYsUXZThwtsGlyZwcbBEPOAh8yHjTp0SFUwvaOc2TVImLGPY6LE/NohpXqC
 CT3C/ZTKHAY2oeOo3/S7tBuqQ06aguStv3Jy2d7S7zHFygaeQa3cv0d71psGkENLr3A5HUCGAWA
 si9fmiWpeDPoqjY4/vYYrmPbd6hiVtxc0=
X-Gm-Gg: AYBFou2UaVeqTSsZlp2Vf5+xlSatVyQt+B9aoZdeP7ML+7JDP57kNgl7yLAGP75JNeY
 2K5QoAR0+QzJjCEBUxsn1Wx5wlGmwiY8329d8FKjSYRFaVuDRzP33jiinZ6X0G6WfVFne3aHaj4
 TAjxlECr++klLitwFwNgCkMFUIp8XLiEsXhUaroiqicV4rxcbNXbod3O9NVvk=
X-Received: by 2002:a05:622a:1b11:b0:52f:aa6c:bc7d with SMTP id
 d75a77b69052e-5310d03dcc6mr118357001cf.28.1789470127837; 
 Tue, 15 Sep 2026 04:02:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1b11:b0:52f:aa6c:bc7d with SMTP id
 d75a77b69052e-5310d03dcc6mr118356131cf.28.1789470127335; Tue, 15 Sep 2026
 04:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-17-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-17-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:01:56 +0300
X-Gm-Features: AcwNN1XGWa7Vu4WKWmepZCecsH04u33AYv7wCclijgWellrQK7BaWP9npAuCzSY
Message-ID: <CAPMcbCoOV=UJUODrYTRAe75e-8dAZemUxDhxD4x6XBBAXv7t5w@mail.gmail.com>
Subject: Re: [PATCH 17/17] qga/vss-win32: log to file during COM+ registration
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000046c596065b837b67"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000046c596065b837b67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> COMRegister and COMUnregister are invoked both from the MSI installer
> (via DLLCOMRegister/rundll32) and from qemu-ga -s vss-install, where
> stderr is typically not visible. Redirect stderr to
> %SystemRoot%\Temp\qga-vss-install.log so that qga_debug output is
> captured for post-install troubleshooting.
>
> Suggested-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 9e8db79c122c..09d94edd4f53 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -241,10 +241,27 @@ out:
>      return hr;
>  }
>
> +static void qga_vss_open_log(void)
> +{
> +    char path[MAX_PATH];
> +    UINT n;
> +
> +    n =3D GetSystemWindowsDirectoryA(path, sizeof(path));
> +    if (n =3D=3D 0 || n >=3D sizeof(path)) {
> +        return;
> +    }
> +    snprintf(path + n, sizeof(path) - n,
> +             "\\Temp\\qga-vss-install.log");
> +    if (freopen(path, "a", stderr)) {
> +        setvbuf(stderr, NULL, _IONBF, 0);
> +    }
> +}
> +
>  /* Unregister this module from COM+ Applications Catalog */
>  STDAPI COMUnregister(void);
>  STDAPI COMUnregister(void)
>  {
> +    qga_vss_open_log();
>      qga_debug_begin;
>
>      HRESULT hr;
> @@ -260,6 +277,7 @@ out:
>  STDAPI COMRegister(void);
>  STDAPI COMRegister(void)
>  {
> +    qga_vss_open_log();
>      qga_debug_begin;
>
>      HRESULT hr;
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--00000000000046c596065b837b67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">C=
OMRegister and COMUnregister are invoked both from the MSI installer<br>
(via DLLCOMRegister/rundll32) and from qemu-ga -s vss-install, where<br>
stderr is typically not visible. Redirect stderr to<br>
%SystemRoot%\Temp\qga-vss-install.log so that qga_debug output is<br>
captured for post-install troubleshooting.<br>
<br>
Suggested-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com"=
 target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 18 ++++++++++++++++++<br>
=C2=A01 file changed, 18 insertions(+)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 9e8db79c122c..09d94edd4f53 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -241,10 +241,27 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
+static void qga_vss_open_log(void)<br>
+{<br>
+=C2=A0 =C2=A0 char path[MAX_PATH];<br>
+=C2=A0 =C2=A0 UINT n;<br>
+<br>
+=C2=A0 =C2=A0 n =3D GetSystemWindowsDirectoryA(path, sizeof(path));<br>
+=C2=A0 =C2=A0 if (n =3D=3D 0 || n &gt;=3D sizeof(path)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 snprintf(path + n, sizeof(path) - n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\\Temp\\qga-vss-inst=
all.log&quot;);<br>
+=C2=A0 =C2=A0 if (freopen(path, &quot;a&quot;, stderr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setvbuf(stderr, NULL, _IONBF, 0);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0/* Unregister this module from COM+ Applications Catalog */<br>
=C2=A0STDAPI COMUnregister(void);<br>
=C2=A0STDAPI COMUnregister(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_vss_open_log();<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
@@ -260,6 +277,7 @@ out:<br>
=C2=A0STDAPI COMRegister(void);<br>
=C2=A0STDAPI COMRegister(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 qga_vss_open_log();<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--00000000000046c596065b837b67--


