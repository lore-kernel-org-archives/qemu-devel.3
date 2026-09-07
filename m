Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF0AC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XP3-0004JH-4M; Mon, 07 Sep 2026 07:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XP1-0004DZ-Ix
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XOz-0007Vg-UN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788780041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sllGCfs866d6uk3mfpsxXK7ApZ1iGgYZ2HzOeO5pvQ=;
 b=Z8MKxw5+GFjLPhHGWNTR4fuRRwg3gqcTy78VNlbTvr11Ruh4+4QVwOD0hwjmA0InTmulPd
 hhXH71J/MVqJSXvWVMluPqWoMr/bMA0O9YUY0mM4qKkqpSpQ+NKq9Dkzh/pQeZ8v9V0AdB
 TorOhdHa1k9k9lEx1JUS2rF/MCbz2kM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-IwUQM7tON9WZr526gKIrFQ-1; Mon, 07 Sep 2026 07:20:39 -0400
X-MC-Unique: IwUQM7tON9WZr526gKIrFQ-1
X-Mimecast-MFC-AGG-ID: IwUQM7tON9WZr526gKIrFQ_1788780039
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90e7db8d191so79440596d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788780039; cv=none;
 d=google.com; s=arc-20260327;
 b=g+Y2dE/u/fgb7/Do/w+segRlTCCTRAy0+uBubsLI5UxcsLFIAFdOqiMjwA0/X/SuPI
 JKLqpz1TA+kNUZFFxLvFZJ1wkpF55Wo2u9WuErJ6jWv4EDiab7HlAqF7d0IDcNxO0VmC
 0ENCmKZdox5hHy3Z0CRKjdotsu1oGX4B7fjTrjJir3BRln+M+iwnLhRhmntrl9afaDQN
 u276jCfxPVXgbHcXTEOrV6kBHj35ki9Y47DbfL7PpMs4KQpdVJ67Z+sTCcJVrqOSAyui
 qxzNmtjv8CnpOK9FmEXXHf4GfvDv0Nd1WV28mWAdju0eyTaOc4U6MnNziKlB4lWUGIx8
 8AzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6sllGCfs866d6uk3mfpsxXK7ApZ1iGgYZ2HzOeO5pvQ=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=ktnjOZYECgBTjfFyjspvl++mY8gjn2A+YdehELKMYiOhWCDxAfh3xWYTHDPEKxnzDE
 wWZ7llRArT/7k3OmYwWaKHRfzDLm3e2T2EWEw0HeVq5rCSimz1ueJ/5esQ4zoiCHdm4W
 /+WCMUczYkTbU12d0kzbp1vHTfAbNvUt5JadeoWAYN7oGdWO0UUqjLJufq7ZHQEhjCxR
 aEq6A3i9J4bXOrDBIExP9dhq0pu4v+2+q5nYS8lM/6gUBuq3275wpTrY9rynn6wZ2sGS
 WdhPEYdIC1xmGuayDeHKUpYO8rDVBGmmHKWOo2y17eJXmzbeMqtOOt6WqM+wWDCewqa5
 Iu4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788780039; x=1789384839; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6sllGCfs866d6uk3mfpsxXK7ApZ1iGgYZ2HzOeO5pvQ=;
 b=X0PJ9UGGS5tj55E6rOpvjd4oXNcOB9DKl0DahOSFG1ODjsPeYnfpLb13NdWluFNDIk
 U1Z81TOP3E7Pcxc8xHale1FwxXD0/kb0J0Zml1u7beQZm7Mz2aTJbRee62Yhz7JiWmcS
 GXp0Ln5w0nqaSlZ6B6KtgrjuJFEdiqWWsXCqd9z1bqRl9cq2NMV/Trpma8YTBbekIiGG
 U1g5nZcNskqD+EzP59dtHP2GTh67rXkuB5EhrY8lX4Sk8QGSLn+iIJbtXdCM0biSJ5ru
 K+wnc4IfM2bkcHAf8QaCJw7ePAM6lYbwXcQWLLXTscjZmOHCoHd1yxf8ZlryvMhfoB7a
 2ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788780039; x=1789384839;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6sllGCfs866d6uk3mfpsxXK7ApZ1iGgYZ2HzOeO5pvQ=;
 b=D49pBHpg0wU3gu4Yv04kj4ZmB90Z13WhB8vbbKWZL7SosXZGouVgJkJNsUEQRaHwM5
 PIjo3247D4Y9IbThM00diSot14AxurT+iGXmVJrzUHeehArWkrVEByc72OmSKeqmE8KX
 ZqlV3SuDCou3WUotszaNi81wdgCfu6wHMX8AWgEjaaW8jDxhIYi2abO5/c5HOLqI+6bB
 LQoaEUt/RszRphWt2d+DE4cnOfbONa3EPtYHp8ZD7Jgrz6/Nsqew+ffvA/m4GgbEGj+l
 u5NxoBoPn5oau9gI9YcpMV4bh9PFqoLsajV46CDPaav8o4NA5rw21KWK+fl236sYnEFN
 btLA==
X-Gm-Message-State: AFuF++lRJBqma5FSa9wkDbsw2lD+ByT6h+FJe1ukO+Db+WbJK6xOylac
 WX+cE1zthAoWBrrHy2r4hm7VMvLXI/NuMRgP2g1e91rGAkOXmXbuL9HjBqnds9NtNS+dgNPZgAD
 3CGCWReMM64kJqxTj8GykjfmlE9bGNNHVEzSMvkWffxcfeYiFZMv2jyzT/zFupAcgWe/KZCo5Ug
 6i6W0MNMYM/vrrtiQUUnCn/LrkerQ3rO4=
X-Gm-Gg: AYBFou2E4p4MlLS9zOOyIxxP3d1jDbZsq2uwY28p582V6wbJCY+XDp1Jaxvtg4S9FrF
 1eHi73+GMuiSSTG1sRW/dCOZwHIv918GWxGi0E2pbK99SXioTyepgao91QkG9xZk9yL0AiD7iqG
 2lCAK33TCVmBCkHGJZM4/11r22fFFQGB1dp9wZ457ZHErX+nNwuBDlRJXZcgQ=
X-Received: by 2002:ad4:5d45:0:b0:910:3f0c:b9e5 with SMTP id
 6a1803df08f44-9103f0cbdafmr295482416d6.6.1788780038889; 
 Mon, 07 Sep 2026 04:20:38 -0700 (PDT)
X-Received: by 2002:ad4:5d45:0:b0:910:3f0c:b9e5 with SMTP id
 6a1803df08f44-9103f0cbdafmr295481866d6.6.1788780038480; Mon, 07 Sep 2026
 04:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-8-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-8-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:20:27 +0300
X-Gm-Features: AcwNN1VmwiY-wvkE_ycDuu16kd0NH0bjI2yFtri900dBTjt1YlZzGQC9IJHTcPg
Message-ID: <CAPMcbCpPqwmAC7mRAun0D2drKXz5seDsVRmfMJQ5vy0xe6SbCw@mail.gmail.com>
Subject: Re: [PATCH 08/17] qga/vss-win32: return an interface pointer for
 IID_IUnknown
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c67dd0065ae2ce53"
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

--000000000000c67dd0065ae2ce53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> CQGAVssProvider implements three COM interfaces, each with its own
> IUnknown base subobject. Returning the complete object address for
> IID_IUnknown relies on IVssSoftwareSnapshotProvider remaining the first
> base class.
>
> Return the IVssSoftwareSnapshotProvider subobject instead. This selects
> the canonical IUnknown identity without relying on the complete-object
> layout.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/provider.cpp | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 377571b94881..44c3c74bd2f2 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -212,7 +212,8 @@ CQGAVssProvider::~CQGAVssProvider()
>  STDMETHODIMP CQGAVssProvider::QueryInterface(REFIID riid, void **ppObj)
>  {
>      if (riid =3D=3D IID_IUnknown) {
> -        *ppObj =3D static_cast<void*>(this);
> +        *ppObj =3D static_cast<void*>(
> +            static_cast<IVssSoftwareSnapshotProvider*>(this));
>          AddRef();
>          return S_OK;
>      }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000c67dd0065ae2ce53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">CQGAVssProvider imp=
lements three COM interfaces, each with its own<br>
IUnknown base subobject. Returning the complete object address for<br>
IID_IUnknown relies on IVssSoftwareSnapshotProvider remaining the first<br>
base class.<br>
<br>
Return the IVssSoftwareSnapshotProvider subobject instead. This selects<br>
the canonical IUnknown identity without relying on the complete-object<br>
layout.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/provider.cpp | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 377571b94881..44c3c74bd2f2 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -212,7 +212,8 @@ CQGAVssProvider::~CQGAVssProvider()<br>
=C2=A0STDMETHODIMP CQGAVssProvider::QueryInterface(REFIID riid, void **ppOb=
j)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (riid =3D=3D IID_IUnknown) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ppObj =3D static_cast&lt;void*&gt;(this);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ppObj =3D static_cast&lt;void*&gt;(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static_cast&lt;IVssSoftwareSnaps=
hotProvider*&gt;(this));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddRef();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return S_OK;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000c67dd0065ae2ce53--


