Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E39C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qub-0007n9-BB; Tue, 15 Sep 2026 07:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuM-0007hr-4F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuK-0004xn-BD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Grh7qdRuTHwI6pGCDJmdUpVUgiFikW+e0aly1We9S6E=;
 b=dpn4ARKKZhtY2sAWcPAkt5Fbgjacf4GEs8rEYNL+3v5AmVaqq0FoR3LweWTeC/MPIA4Iim
 v/ExuFOKiW6Hf2fWvVXv/uVnVqeFLAdOPFBFEgNzWFj3LbtjUwnRJqywcgrdBIsPopTB+F
 ruNku2mHAx8jkUEqWy0C3Is8336TpZw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-8zCY94YLOj2H3-xS7NvEGg-1; Tue, 15 Sep 2026 07:00:58 -0400
X-MC-Unique: 8zCY94YLOj2H3-xS7NvEGg-1
X-Mimecast-MFC-AGG-ID: 8zCY94YLOj2H3-xS7NvEGg_1789470058
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530ef845909so63832961cf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470058; cv=none;
 d=google.com; s=arc-20260327;
 b=S77TpEWSp1IQ9Nr4LR/ENTW3Py5Cngfr+t2VIENxXblW+mBc1JWOnSoxYp5uRxxCGJ
 FReNmhvTKWk6ca/x2AUfGMk/dVV1AfaKE9AE5K6NPavkExInxa/RDky8FSQGgpiTtVtO
 wwURyUhmLr4hZTANGGfszWuP7CumOfrPY+nFDqZFM5VH20F7rKmruyFj2OvXPr0I2slH
 YP3boFGdlk/gzOim3vXMzep59/7GhpJ75/iiIJvGu/qur/rzsLH8ZSakZKW6H+wj+YeA
 wThrUpNivmK3V/uyxlsC7urswj7E1vffZ6Mt6I3XcyhSgiItc75ya4b/OeAaVVetWg9z
 lWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Grh7qdRuTHwI6pGCDJmdUpVUgiFikW+e0aly1We9S6E=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=QQdj01oMqEzBO4Q7GElZAbrJaKF5EfvASp8UaEM3AlbOCJT4icUXcesz60yzS6f7Gh
 bXyFXjnFX3YzyDin3JMSicccgyPaz/XdrNsVHPegms4Y3JUiDavfOD478zpiG4iiS7Rz
 pEqpvR9DH4lvyQi+a60PqXLEn+0fd2alr67Y3CcVLiG8QZjeLE2gqfhsPT/mo1x+kjIO
 CF5b7GkGaqBiGJDbe8PyVhrK75XjGrMKC9xYGcKEbV/CP4FfkgSjt1JKjourjyIoEE4z
 bCk1O52WUVE86bdano8+sXHbkEFQQjhtWt1wbaSK/VN+8VBsYN/Cn+DT2p4l6T0O1jxk
 HDsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470058; x=1790074858; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Grh7qdRuTHwI6pGCDJmdUpVUgiFikW+e0aly1We9S6E=;
 b=HwRlV4yPtELIgtOk/sz6IgpifM/DySCIzS8DAj8rKxqNZHE5QCu5gWBUPsZgsgznNT
 KKibl7OyQPhTAys1QFSGsdMDggsI63kv+pwlKrl5TlP+OnBcrdd/FaoLgvRC/LX75YJ7
 ITrSmcb6e9MlLmUWYK8774n/My4D6f7hiSUj17lebhCKu174ZN04AfCRTgfjrKjoHo5r
 oYFqxKQ9jSmUCIonT1O+Ui1fatpt0mcG4GNfNVkh4b6Vh3YRJhyG+njFLzb7XOnNT78s
 cvQox1sUM1PYnMhsZ/F4Igbe5fZrzXY+h/ElP/OdxJkDGKbsLqkIWzo9lvtoZYd2JK/d
 bLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470058; x=1790074858;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Grh7qdRuTHwI6pGCDJmdUpVUgiFikW+e0aly1We9S6E=;
 b=ekoFYbqqPHhiuIm0kUudGa0QNroQN2/aTY+AqNn3w4SP9b9JN02c1Xrzd3ROu8QMfO
 wn0PueF4IC7CEFw92ctnfhDOwLMfLsnSUcL8c2HKoac9eoTmmOei7kpHGXkuBbg8lbNH
 DzgY9PCHoAskGfDAWhWnfUamWLYLGT5JJlowDkylJuIlNndY/rw8njNqqzYjJ1gjGX2z
 hmPnuu8M+PLJpScxTZi96D6pU8aXRioDySGqW/bIn9ZJJEq3NF7WoxzZnvoUdYOhfJ96
 tCzyr6tnx0qcFovwvlNMqulw/JX1qKXhjomMGXsQCJu4u1VbHwwMXO8EiSyYtaG05vwP
 3AUg==
X-Gm-Message-State: AFuF++kT/bD797rGYQZGHIWrGvAvwQdpbtg5RBEDivHmMQcxlk5CGndi
 KoR6JNj+q8EcYdhsyq59NURL3+XYRBrw6XNnHSPew3XB6wjRrG/oiUdRVSb6QPfpBummbM0G98i
 vo9G/IdYDAYaOZxceDcsVwuyF4jFXV8ZMBOX31tpQlx8pbKuYAj87bFnlUZd3T5f+SR9BXaPoqz
 umPj8L1T7xjEILrSz0oZj3m+V99zU+xts=
X-Gm-Gg: AYBFou0wZgXeqQtP/HEbml94Qv9Ie4H6qRFIOYsDv/A3EtJ63gefN7Uv2sy2jXz7rDi
 O0Q8VMP2NlaCL9IRl3ZoAUFQa5b3A/iE1FKnEzCjo2cWgs+2TFLwnIm2uTCIugveaydfhjZTHQ9
 jQDi050vUrV4T/S9/1BgY712o4PJMrldT1posMElUoULrPLN49c2JPHZJtGck=
X-Received: by 2002:ac8:58c3:0:b0:531:1e10:b65c with SMTP id
 d75a77b69052e-5311e10be70mr25098801cf.35.1789470057727; 
 Tue, 15 Sep 2026 04:00:57 -0700 (PDT)
X-Received: by 2002:ac8:58c3:0:b0:531:1e10:b65c with SMTP id
 d75a77b69052e-5311e10be70mr25096821cf.35.1789470055873; Tue, 15 Sep 2026
 04:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-12-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-12-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:00:44 +0300
X-Gm-Features: AcwNN1US3MwIlh7xYqOQEzCA7X5cvj7Bxt-9TQSRJCcT87lUfJb0Ltz4j3rLMb8
Message-ID: <CAPMcbCrr13eH5Z7+Ojix2G2DDxWGvwUnvynyRjPtnAuXScdiwA@mail.gmail.com>
Subject: Re: [PATCH 12/17] qga/vss-win32: evaluate err_set() macro argument
 only once
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000045b03065b8377b7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000045b03065b8377b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The err_set macro expands its 'err' parameter three times. When
> callers pass GetLastError(), the Win32 error code is fetched on
> each expansion and may change between evaluations, since the
> intervening function calls can reset the thread's last-error value.
>
> Capture the argument in a local DWORD once and reference that
> throughout the macro body.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index d7907c230656..e3a15f83bf90 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -27,10 +27,11 @@
>  #define DEFAULT_VSS_BACKUP_TYPE VSS_BT_FULL
>
>  #define err_set(e, err, fmt, ...) {
>    \
> +    DWORD _e =3D (DWORD)(err);
>   \
>      (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__,
> __func__,  \
> -                                   err, fmt ": Windows error 0x%lx",
>   \
> -                                   ## __VA_ARGS__, err);
>   \
> -    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);
>   \
> +                                   _e, fmt ": Windows error 0x%lx",
>    \
> +                                   ## __VA_ARGS__, _e);
>    \
> +    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, _e);
>    \
>  }
>  /* Bad idea, works only when (e)->errp !=3D NULL: */
>  #define err_is_set(e) ((e)->errp && *(e)->errp)
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000045b03065b8377b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he err_set macro expands its &#39;err&#39; parameter three times. When<br>
callers pass GetLastError(), the Win32 error code is fetched on<br>
each expansion and may change between evaluations, since the<br>
intervening function calls can reset the thread&#39;s last-error value.<br>
<br>
Capture the argument in a local DWORD once and reference that<br>
throughout the macro body.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 7 ++++---<br>
=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index d7907c230656..e3a15f83bf90 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -27,10 +27,11 @@<br>
=C2=A0#define DEFAULT_VSS_BACKUP_TYPE VSS_BT_FULL<br>
<br>
=C2=A0#define err_set(e, err, fmt, ...) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 DWORD _e =3D (DWORD)(err);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0(e)-&gt;error_setg_win32_wrapper((e)-&gt;errp, __FILE__=
, __LINE__, __func__,=C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err, fmt &quot;: Window=
s error 0x%lx&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## __VA_ARGS__, err);=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 qga_debug(fmt &quot;: Windows error 0x%lx&quot;, ## __VA_ARG=
S__, err);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_e, fmt &quot;: Windows=
 error 0x%lx&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## __VA_ARGS__, _e);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 qga_debug(fmt &quot;: Windows error 0x%lx&quot;, ## __VA_ARG=
S__, _e);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0}<br>
=C2=A0/* Bad idea, works only when (e)-&gt;errp !=3D NULL: */<br>
=C2=A0#define err_is_set(e) ((e)-&gt;errp &amp;&amp; *(e)-&gt;errp)<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000045b03065b8377b7--


