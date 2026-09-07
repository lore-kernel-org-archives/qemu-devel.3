Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63100C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XCX-0003PZ-4V; Mon, 07 Sep 2026 07:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XCV-0003PM-Pv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XCU-0003sU-6e
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOunQyFnM9mQf4XhZlcC2AQk2Ch+N0/OUunQChar1mQ=;
 b=TI1uiPYLnOOdvWnoZ+jBWuftim9Ia/0HIKvie1LssBC+jflDdLHiNOWlg34m5YN522qEiT
 Sbuj2Klnj3zB5xW9eHLDAJpoyFxE65Ox7oh2ca5dQfs6P9Akg3Am62fe5deHdW5YvqXzzk
 UyV9LPgLptSeJS9E8BAU0aNqy/et3Go=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-7zcMBix2Mm2NYYm7Y882-w-1; Mon, 07 Sep 2026 07:07:43 -0400
X-MC-Unique: 7zcMBix2Mm2NYYm7Y882-w-1
X-Mimecast-MFC-AGG-ID: 7zcMBix2Mm2NYYm7Y882-w_1788779263
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-869553205a7so51037827b3.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779263; cv=none;
 d=google.com; s=arc-20260327;
 b=gjvTA+B8cd1dfTzvbNEt4XjRG5j24J5S4II/vHVbV4rdiyZuuUalmQPQA/HT8kJtU6
 kLSnOkv9Gv6loTaDBGsTbDmljgeFFB+cwIErMSDXgveH8OVPHh+VNcxMVZqpXOxe8LLX
 i81KZEp2r3rcCWj8IdE6YiWBBss421APvT0vAtLQb9U01FcYK41g0fhXdTbfzjqQU6Pj
 D6/JoUSqWoah+U+ANxOU8E7KwOylmStMowYWpWGgTeLkzD1fakdRyY7gpKXpv+LSYlZO
 0E/RZFmIOyp9vxmbBBNMpR6ctMboY1nF9QWHKbfS+YSXVTLsLXCnGgvyNExL+GyKal6I
 6+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uOunQyFnM9mQf4XhZlcC2AQk2Ch+N0/OUunQChar1mQ=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=qHkp8PXD+YvalI15BMvmwUukkNuxUiBama6fEzUfgaHq3IygPtYxH9jY2WiMn4I2rY
 OGoZeIAX1BmmqgHfSnTCuhwX/IuJJD8zS58wDceBY+x3JOasyQV2XESjCI24qHm3Caep
 o8J9ADpKz/W2GIeii+udIKz6oTRrwLNYeCOvMMAdp2YLnkyXdRE0jrSRZ6iZLaTw+b1N
 Rsl2zgPuXVDDTsrGda6eMLcZ121a5niDOu+qCdPMti/wy5HldZqAVyR99E9K9eeXmUor
 43bTUHwzey/EKBN14vRvQWk3MjPvHIr9EnyLfxADSDQHrNmsfxlyW9Ly33Zk8uJ9yMb3
 ccCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779263; x=1789384063; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uOunQyFnM9mQf4XhZlcC2AQk2Ch+N0/OUunQChar1mQ=;
 b=m6XQ66eORe1+FtTj/Bi0N1EH3dp36Li33V57ofVsAOsl05Hl1WYuLYBkztNjH3Pl4E
 tYantX7lX1HY69TGbGF9XZsn3Mp+IR6xwwTQtlDsxXfW/Oxmaki85lVsKyYmgpgO3BCf
 R9HY4i5GYampU+Gc951wthtgT0xFwTk7OIIt8xoxLt3VoEIzc/QQn0MNOGNVwO3gM72m
 tRQ1SCpqmxhWkHZFH2c/+b28tW4zZb8XuJByuyWcc1VjFdEEaqJZ3Zc12jY4YfAbnSfl
 mBJs/G2PPVZpQQRxB4dwtUx/LwW51lpX+zX+uOaFDPLgyim++eQIq6I4mx7yVCCJVf4r
 YB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779263; x=1789384063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uOunQyFnM9mQf4XhZlcC2AQk2Ch+N0/OUunQChar1mQ=;
 b=epncwxqwDcOzHgYlIBAo0Gd+jMLMt30uLmjvi21A8hUPdRpTFagZBIw6GX0sSF+f+o
 h9OACXDnENrM6E3c9lo3jY3x57TtAkHxLANbN0Xa3qtmpWcLDa2aSuKGgCWiJLg8mRek
 EfzqJmOBR6fucV9AH7oJ9qKqqy9Lb6fWHg+tPKVcwZH7gQ8OP52y1WmMbmI+jDtWoZ2N
 k9n2wdkiw/yXRboAt11ymANh5DwWfr4RObFo2o0Jm5qnN6nsqIymD1U64IygpdwBkPKk
 Bk5nZJzQsItk4GYjMPmR7hFrzp6b7UwSmWXUgqpp3opPuHXk/fjJmnAZobeFMqdHhrBe
 OEDA==
X-Gm-Message-State: AFuF++lBhq/dhGmt0Jc+ovqf7ssjwuXtnJeGoRHOpmspIs/6ahEkawt1
 1fOUurkL4KtSWsWv5wphMjSf8PfAFNc6hCHTtkafByJ5OAyx21aHW2irybLGAJAPyYa5a3HNQdD
 0zakgR7lhG7ge+LiysXkHnFndrMvfePoxGc2mdGP+8qUElYxecyvbmipm9CLUwScnb3LsIqh1Z6
 dROhsFjvxI+CJ04Jqq2xf8fxJnOf92M3S2g7z72DtapA==
X-Gm-Gg: AYBFou2S65TCp/0NsPX5L4N3aqK6DMStsq102wnONu3p+CMut1W5D0eierU3/GKJvQd
 0ZoOhTcciYgdHFAz5KJqIwWvh2Yx/7k6CxUFz2eQ3ARWFcEpbziJw4GVoNbi84Iy4xM/sJM5kT2
 zJm4P8QsAeYVHPp+TPtacBHKjNIDUyD7So3HC3NGHqbnGEq3Eayuy8JF+eGpE=
X-Received: by 2002:a05:690e:c4c:b0:66f:c5de:c1 with SMTP id
 956f58d0204a3-66fc5de012cmr2878003d50.7.1788779263261; 
 Mon, 07 Sep 2026 04:07:43 -0700 (PDT)
X-Received: by 2002:a05:690e:c4c:b0:66f:c5de:c1 with SMTP id
 956f58d0204a3-66fc5de012cmr2877984d50.7.1788779262741; Mon, 07 Sep 2026
 04:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-2-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-2-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:07:32 +0300
X-Gm-Features: AcwNN1Wzjr25WoKgtGnWZDQqs4toGI6csgkLFyy1scCnBFv5UBd1hGPRH4oY4eE
Message-ID: <CAPMcbCoPQy4vvr+9T8PMjRnMy2OeAFiGgQw=+DOkBhUX33in2Q@mail.gmail.com>
Subject: Re: [PATCH 02/17] qga/vss-win32: fix race condition in COM Release()
 methods
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000089fa05065ae2a0c4"
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

--00000000000089fa05065ae2a0c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> All three Release() implementations checked the member m_nRefCount
> after InterlockedDecrement instead of using the local return value.
> In a multi-threaded context (vssvc), two threads decrementing
> concurrently could both read m_nRefCount as 0 and double-free.
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/provider.cpp | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index 2b5c6f8e8ecd..79906dcc24ae 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -108,7 +108,7 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::AddRef()
>  STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()
>  {
>      long nRefCount =3D InterlockedDecrement(&m_nRefCount);
> -    if (m_nRefCount =3D=3D 0) {
> +    if (nRefCount =3D=3D 0) {
>          delete this;
>      }
>      return nRefCount;
> @@ -244,7 +244,7 @@ STDMETHODIMP_(ULONG) CQGAVssProvider::AddRef()
>  STDMETHODIMP_(ULONG) CQGAVssProvider::Release()
>  {
>      long nRefCount =3D InterlockedDecrement(&m_nRefCount);
> -    if (m_nRefCount =3D=3D 0) {
> +    if (nRefCount =3D=3D 0) {
>          delete this;
>      }
>      return nRefCount;
> @@ -477,7 +477,7 @@ STDMETHODIMP_(ULONG) CQGAVssProviderFactory::AddRef()
>  STDMETHODIMP_(ULONG) CQGAVssProviderFactory::Release()
>  {
>      long nRefCount =3D InterlockedDecrement(&m_nRefCount);
> -    if (m_nRefCount =3D=3D 0) {
> +    if (nRefCount =3D=3D 0) {
>          delete this;
>      }
>      return nRefCount;
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>
>

--00000000000089fa05065ae2a0c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">All three Release()=
 implementations checked the member m_nRefCount<br>
after InterlockedDecrement instead of using the local return value.<br>
In a multi-threaded context (vssvc), two threads decrementing<br>
concurrently could both read m_nRefCount as 0 and double-free.<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/provider.cpp | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index 2b5c6f8e8ecd..79906dcc24ae 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -108,7 +108,7 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::AddRef()<br>
=C2=A0STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0long nRefCount =3D InterlockedDecrement(&amp;m_nRefCoun=
t);<br>
-=C2=A0 =C2=A0 if (m_nRefCount =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (nRefCount =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete this;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return nRefCount;<br>
@@ -244,7 +244,7 @@ STDMETHODIMP_(ULONG) CQGAVssProvider::AddRef()<br>
=C2=A0STDMETHODIMP_(ULONG) CQGAVssProvider::Release()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0long nRefCount =3D InterlockedDecrement(&amp;m_nRefCoun=
t);<br>
-=C2=A0 =C2=A0 if (m_nRefCount =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (nRefCount =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete this;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return nRefCount;<br>
@@ -477,7 +477,7 @@ STDMETHODIMP_(ULONG) CQGAVssProviderFactory::AddRef()<b=
r>
=C2=A0STDMETHODIMP_(ULONG) CQGAVssProviderFactory::Release()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0long nRefCount =3D InterlockedDecrement(&amp;m_nRefCoun=
t);<br>
-=C2=A0 =C2=A0 if (m_nRefCount =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (nRefCount =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete this;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return nRefCount;<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
<br>
</blockquote></div>

--00000000000089fa05065ae2a0c4--


