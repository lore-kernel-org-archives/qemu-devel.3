Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34ECD32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXRr-0001sl-4j; Fri, 05 Dec 2025 10:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXRp-0001sW-8v
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXRn-0000xm-G7
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DdzIjTyBM9H7zr3Q1a/w8aftnUQgZs6jjvIma1x7pyw=;
 b=ZJHnDN+IxAN1EPv0rJwZa1cjYLBJJqPdBE2nYi4V+Hghi2pGQWc9W9LUyLFOKTx9Ad53/L
 gjd9mkgUY2V1MY02B1e8EQa0JFWpIgI/CeT+0+LInsv0QI2AcYgcHVHAR2Q3kU1UaLB6cn
 q5u3EnQj2xG0+zMvx5FPdeM0IbZswR8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-jLgkRl9dMlqsLtXfQL7LcQ-1; Fri, 05 Dec 2025 10:10:12 -0500
X-MC-Unique: jLgkRl9dMlqsLtXfQL7LcQ-1
X-Mimecast-MFC-AGG-ID: jLgkRl9dMlqsLtXfQL7LcQ_1764947412
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34176460924so2167149a91.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947412; x=1765552212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DdzIjTyBM9H7zr3Q1a/w8aftnUQgZs6jjvIma1x7pyw=;
 b=DW1dSDoomV3xZ2+wmBUlxu6VoevqnAlrjuDCkg67VA8KK2QD8Z1+KpootetDtkGOjR
 jwnkl4lu3Qfo73vkLOVgJxOEjKtZRROOB5zDDd8OI6arE3pUKDeH/i4FxxLSIhKX2rls
 bRQ2GdtxCiff2Tt9vgYEsOL3y5bkzQj4aqtdwaf8lM3NRJxAkqNo8Dz+DWRdpFwgkmzQ
 QBTdXluUxrXW3ZV57cPLR9DP+L5/vp3GZxXFJCiALuV/6WmznXFadgl5TmLBnPECRZKr
 TF9+R4/8JDRPhLKgyBqb8metNTLu02RDZJaQvy2gS0M3W3+T/fdomDQh1+d0v7zsJJfM
 mK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947412; x=1765552212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdzIjTyBM9H7zr3Q1a/w8aftnUQgZs6jjvIma1x7pyw=;
 b=QjtJpRdZRUx8wzAeOJHEKpM4/sRll2S2e7OiAxzcVhJk8V9cZr+4/T4cE2an1bYBNJ
 lRlqukJoQf7JH3eswbCW0GDx/tuhzza+yNoCAatvAeUYgsdmDilj8MAHPNjiC+g8BI3+
 qNc1fFuEdpU+m/w63p5jyF1V3F1Azqlun+mxYXLYo7XRFEv+I1fXAlH2OZar36skY72x
 5J9wGYArXwWA1HjeTpZBpfwwyusHg4drzEzpDqd0SKOu8s1YjoYx2EXvBvGLYekmFKMt
 ibgvfl8RKoM741nxgA6DTtPGcv35arwlEYA7RH8cp0PcjFhzTRgrVV3ytzUDoWJGahkq
 dZdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzGlmki6bLV7V28u42nbAbuF0Oooup9IXrKVeVrDevmeboMp7i1x4OixcKsuauitKZANGTN5DNHgvC@nongnu.org
X-Gm-Message-State: AOJu0Yynlhn1RVF/sbkt/jKLxgQ+UP8WAN79g5Jo0c4O56ZhEP+uUCbS
 sOpmmVZSw7ss7mEuXKiQCK5H5z/V5rwr0sGcNpPM/r7weazlk/Ur5bs5kqo8eJYu98z5mjiTs2i
 MVpasK3Ns1Sr79Q12Pll8lb+h+3dTCv7j7TmFNfHXTl3jCTu9QQsuCWrrf5Wbc5Ug2g8B5j/4js
 HWmuTXTrSxEP0It/0rbR257fYLAhFwLMI=
X-Gm-Gg: ASbGncvnZ69Ezen6dY8RpMDsdvYVZIQPmLgk7m9kwHW6q/cvE5EXf8j6Pfzc+N3iOpF
 4YqCsZk5upSix/Hb56nMSblsGj2qgegq3fF781Na5A4TP1uiG4x/Efs+vnhXbK87uLPU3E1vvMm
 yelJ+soH5g4ZOeYNAmcgZpYhWPxhhwaD+uYbg1NDGhchfNJO1kUIWBNqWdQaEZUOIVOxTnFOgQh
 O1VuPuRU5fD++YiA+kt2kIQbw==
X-Received: by 2002:a17:90b:562f:b0:343:684c:f8ac with SMTP id
 98e67ed59e1d1-349125c16abmr10689227a91.8.1764947411608; 
 Fri, 05 Dec 2025 07:10:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6FdXCPZGEDR7JH65ZRK3USqAzFJq1fqtCspmicyeYRmFnh8zVvKTsim7U/ujk7fycZlCPNYxmyAd7uWcsBj0=
X-Received: by 2002:a17:90b:562f:b0:343:684c:f8ac with SMTP id
 98e67ed59e1d1-349125c16abmr10689210a91.8.1764947411205; Fri, 05 Dec 2025
 07:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-3-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-3-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:09:59 +0400
X-Gm-Features: AWmQ_blPIYTsBkMu-jTA26GkeLU6aeD18rA67AR5Srg3NToXTJnTO-q_Gk6zaQk
Message-ID: <CAMxuvaycsqJ+Sk+Mm=8shHXW17U6e1pwyjS6qNYpv6O-_qST5A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ui/spice: drop SPICE_HAS_ATTACHED_WORKER macro
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="0000000000007e194e064535d78b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000007e194e064535d78b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Since previous commit it is always 1. Let's just drop it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/qxl.c        | 12 ------------
>  include/ui/qemu-spice.h |  2 --
>  ui/spice-display.c      | 11 -----------
>  3 files changed, 25 deletions(-)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 0fa8a3204d..a06395fb8a 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -530,13 +530,6 @@ static void interface_attached_worker(QXLInstance
> *sin)
>      trace_qxl_interface_attach_worker(qxl->id);
>  }
>
> -#if !(SPICE_HAS_ATTACHED_WORKER)
> -static void interface_attach_worker(QXLInstance *sin, QXLWorker
> *qxl_worker)
> -{
> -    interface_attached_worker(sin);
> -}
> -#endif
> -
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
>      PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
> @@ -1131,12 +1124,7 @@ static const QXLInterface qxl_interface =3D {
>      .base.major_version      =3D SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      =3D SPICE_INTERFACE_QXL_MINOR,
>
> -#if SPICE_HAS_ATTACHED_WORKER
>      .attached_worker         =3D interface_attached_worker,
> -#else
> -    .attache_worker          =3D interface_attach_worker,
> -#endif
> -
>      .set_compression_level   =3D interface_set_compression_level,
>      .get_init_info           =3D interface_get_init_info,
>
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index 8e5e6b2a74..111a09ceca 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -34,8 +34,6 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin=
,
> QemuConsole *con);
>  int qemu_spice_migrate_info(const char *hostname, int port, int tls_port=
,
>                              const char *subject);
>
> -#define SPICE_HAS_ATTACHED_WORKER 1
> -
>  #else  /* CONFIG_SPICE */
>
>  #include "qemu/error-report.h"
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index f2304bb0ce..28399f8a81 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -507,17 +507,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay
> *ssd)
>
>  /* spice display interface callbacks */
>
> -#if SPICE_HAS_ATTACHED_WORKER
>  static void interface_attached_worker(QXLInstance *sin)
>  {
>      /* nothing to do */
>  }
> -#else
> -static void interface_attach_worker(QXLInstance *sin, QXLWorker
> *qxl_worker)
> -{
> -    /* nothing to do */
> -}
> -#endif
>
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> @@ -707,11 +700,7 @@ static const QXLInterface dpy_interface =3D {
>      .base.major_version      =3D SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      =3D SPICE_INTERFACE_QXL_MINOR,
>
> -#if SPICE_HAS_ATTACHED_WORKER
>      .attached_worker         =3D interface_attached_worker,
> -#else
> -    .attache_worker          =3D interface_attach_worker,
> -#endif
>      .set_compression_level   =3D interface_set_compression_level,
>      .get_init_info           =3D interface_get_init_info,
>
> --
> 2.48.1
>
>

--0000000000007e194e064535d78b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 20=
25 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vs=
ementsov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Since previous commit it =
is always 1. Let&#39;s just drop it.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0hw/display/qxl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 ------------<br>
=C2=A0include/ui/qemu-spice.h |=C2=A0 2 --<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 | 11 -----------<br>
=C2=A03 files changed, 25 deletions(-)<br>
<br>
diff --git a/hw/display/qxl.c b/hw/display/qxl.c<br>
index 0fa8a3204d..a06395fb8a 100644<br>
--- a/hw/display/qxl.c<br>
+++ b/hw/display/qxl.c<br>
@@ -530,13 +530,6 @@ static void interface_attached_worker(QXLInstance *sin=
)<br>
=C2=A0 =C2=A0 =C2=A0trace_qxl_interface_attach_worker(qxl-&gt;id);<br>
=C2=A0}<br>
<br>
-#if !(SPICE_HAS_ATTACHED_WORKER)<br>
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worke=
r)<br>
-{<br>
-=C2=A0 =C2=A0 interface_attached_worker(sin);<br>
-}<br>
-#endif<br>
-<br>
=C2=A0static void interface_set_compression_level(QXLInstance *sin, int lev=
el)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, s=
sd.qxl);<br>
@@ -1131,12 +1124,7 @@ static const QXLInterface qxl_interface =3D {<br>
=C2=A0 =C2=A0 =C2=A0.base.major_version=C2=A0 =C2=A0 =C2=A0 =3D SPICE_INTER=
FACE_QXL_MAJOR,<br>
=C2=A0 =C2=A0 =C2=A0.base.minor_version=C2=A0 =C2=A0 =C2=A0 =3D SPICE_INTER=
FACE_QXL_MINOR,<br>
<br>
-#if SPICE_HAS_ATTACHED_WORKER<br>
=C2=A0 =C2=A0 =C2=A0.attached_worker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
nterface_attached_worker,<br>
-#else<br>
-=C2=A0 =C2=A0 .attache_worker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D interf=
ace_attach_worker,<br>
-#endif<br>
-<br>
=C2=A0 =C2=A0 =C2=A0.set_compression_level=C2=A0 =C2=A0=3D interface_set_co=
mpression_level,<br>
=C2=A0 =C2=A0 =C2=A0.get_init_info=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D interface_get_init_info,<br>
<br>
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h<br>
index 8e5e6b2a74..111a09ceca 100644<br>
--- a/include/ui/qemu-spice.h<br>
+++ b/include/ui/qemu-spice.h<br>
@@ -34,8 +34,6 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, =
QemuConsole *con);<br>
=C2=A0int qemu_spice_migrate_info(const char *hostname, int port, int tls_p=
ort,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *subject);<br>
<br>
-#define SPICE_HAS_ATTACHED_WORKER 1<br>
-<br>
=C2=A0#else=C2=A0 /* CONFIG_SPICE */<br>
<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
diff --git a/ui/spice-display.c b/ui/spice-display.c<br>
index f2304bb0ce..28399f8a81 100644<br>
--- a/ui/spice-display.c<br>
+++ b/ui/spice-display.c<br>
@@ -507,17 +507,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *s=
sd)<br>
<br>
=C2=A0/* spice display interface callbacks */<br>
<br>
-#if SPICE_HAS_ATTACHED_WORKER<br>
=C2=A0static void interface_attached_worker(QXLInstance *sin)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* nothing to do */<br>
=C2=A0}<br>
-#else<br>
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worke=
r)<br>
-{<br>
-=C2=A0 =C2=A0 /* nothing to do */<br>
-}<br>
-#endif<br>
<br>
=C2=A0static void interface_set_compression_level(QXLInstance *sin, int lev=
el)<br>
=C2=A0{<br>
@@ -707,11 +700,7 @@ static const QXLInterface dpy_interface =3D {<br>
=C2=A0 =C2=A0 =C2=A0.base.major_version=C2=A0 =C2=A0 =C2=A0 =3D SPICE_INTER=
FACE_QXL_MAJOR,<br>
=C2=A0 =C2=A0 =C2=A0.base.minor_version=C2=A0 =C2=A0 =C2=A0 =3D SPICE_INTER=
FACE_QXL_MINOR,<br>
<br>
-#if SPICE_HAS_ATTACHED_WORKER<br>
=C2=A0 =C2=A0 =C2=A0.attached_worker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
nterface_attached_worker,<br>
-#else<br>
-=C2=A0 =C2=A0 .attache_worker=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D interf=
ace_attach_worker,<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0.set_compression_level=C2=A0 =C2=A0=3D interface_set_co=
mpression_level,<br>
=C2=A0 =C2=A0 =C2=A0.get_init_info=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D interface_get_init_info,<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--0000000000007e194e064535d78b--


