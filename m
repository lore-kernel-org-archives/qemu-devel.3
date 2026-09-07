Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79549C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XPP-00055n-Jy; Mon, 07 Sep 2026 07:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XPN-000501-Jc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XPL-0007aS-1g
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788780062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfZdPc4grxKQpmIi+aRvCq6eXKlYGW2NCnVnPWY+eUo=;
 b=GDZXFfvV4GmTWxTUqH7qp2JC7Pf6pBB9v7F7hAqWtG4ErkbT2n1IxMRdog+v0eHJ/Qgx6i
 nb8FubqFNHaLOeVcA6PLedVyI8BgWiseLyL6iplu7Aheo5DrVhjY0VSHTeEX4Ylz7D7BAc
 eItKTamlKYzfqbT7r+yStL6JeaLJpl0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ab0ysy2-P4C05z5l8D5UZQ-1; Mon, 07 Sep 2026 07:21:00 -0400
X-MC-Unique: ab0ysy2-P4C05z5l8D5UZQ-1
X-Mimecast-MFC-AGG-ID: ab0ysy2-P4C05z5l8D5UZQ_1788780060
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9103c9c0b34so77194066d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788780060; cv=none;
 d=google.com; s=arc-20260327;
 b=Mm5FmBgr45dwrj2j5W9gzyq8EpFQHR/dQJAazPIIoaWPY1ugbfVgV6mBaWg0gB2kbj
 8RUCLXHow9zvXUd0Z/L+9qHOiMCtx9e/GCdD6V/iiCi8XnbLULkWRFzBVr86U+AbfFSN
 E67J7g9Pi8GktMMnF45bGw8L382Z/7AVhjUw8d08ZKeUrzF1XqxqJ3Xx0gCAhypFbmVM
 iFol/Z6hFPlsSa2ryZ7VNwfXlMJmYxxoJ0uQYIvoN4hKJhp6A1h8MPgYKul4IJuJJAaY
 FOTI0BLIHwJhnX9Otf3Q8TeML1fFKPr5qSfEo4SfLRgxEOXv87dfWrml5coE8PSVET7Q
 7VZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qfZdPc4grxKQpmIi+aRvCq6eXKlYGW2NCnVnPWY+eUo=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=BYzit06Eg7DKAC8e0EXAv3qzQ4tjn5OgPsuXwKA3W3NDFl3xPCgCzpP7KLjExMxlGd
 orfbE+DERXqyZHEhvNPED0cyw0nT2sbF9+JtPEaVxiXHRVUu9o161OLFGPkYLiRZjBqc
 A6pnnxnXIV7+5yrOqkxebG7s8zJAChORUwMlR9YzfsCmwzNtgtfST/DUJt0GWgyUZh06
 rch1GDelnvDDWhCqjrMm7fvy6tZDE49sxbFAhzpDGBTMa2Q04nBGqccBUSuK6rnsTA0g
 +7xRylwmqWWjga596XCqMqcc6APEdK4APP447snECuzzfkJ8q5dNRH1xGvPDAal4aHDV
 wrMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788780060; x=1789384860; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qfZdPc4grxKQpmIi+aRvCq6eXKlYGW2NCnVnPWY+eUo=;
 b=kWnWzLo9dV2OasESZ6ZMmPrbjPQHjIUBM6qhSKp0XwKGE6Aq17eVQY+m798f6e1nJG
 ELQv8snoj98oWujihYCjm777gjT8q5bimf4GCkdhchd+bOPxhO2f/CcyqaQkG8/6+w5W
 jwS6Kv7wI0sMTKJKpRIVjVoZe1Erw+mawQJSrC2bf21PhmUFBUYicP+leADPRLqlPMRU
 /Us2ff77iuK998ERfXRTHZ9h9FSPVbw+KCox5iCLRKGx7WICccjMB7mIDxIPjWKSe0br
 yQNzFjYNDBgSoeJA8v6/JhCC18DLiYCLj5085sfWypXUK7SqdKy1hAgEj1khUdfe3Qk5
 ee8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788780060; x=1789384860;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qfZdPc4grxKQpmIi+aRvCq6eXKlYGW2NCnVnPWY+eUo=;
 b=MUvZCv2WMKVawYVYAvH9CCtVlNOeXR6n25z0SmeRhWwtHD3a4+7Ou1CQklb4LZEBi7
 gkLtU7v9idOLITYPuWlU6LK+EKHFuJBguXCsXTVdFrYJgv4T8NL41Jp2iS2wIUl5FUY9
 RyQIiY9GzqlPlDcMau77xFvflfpXnLhDzax+jaFVaP0BPCahvbTTU2ZeW7fJ4CjVN7D1
 wgFDGRvgCHQ5zSsNfib77zt92+Jba+yWKmFAKXK6tYb5dXYfFIA5C/oSXYcK/yybTC4B
 aJTHPzXIsLXcpppqJva/ozik49Wnd3YV5ammfzTm/bRDWQwDMOulls9l095A2hIIhgNL
 /V5g==
X-Gm-Message-State: AFuF++mYliJK8dxCbPxQa7TDnvNstPZq48DA5aE87cY4e4m9uVcH2MfA
 3RdELezFeY3lJgpZfoOIPosHU666jLCWrU58IPMSZ/TODMOb65+bQOZ1UMnA//Rly0uljA6TGVH
 rJtXSIqdD4pMZdCHufvhAQ+6armIqLE8uByWkyAsd5sHIUzoa1GIvqbjcyx3dix8C2pfFUXg7Zs
 gpkEATCdn9qHyo/uw+blSVfSHV4+wvTQM=
X-Gm-Gg: AYBFou1pS606uFR5sa6zHgNDkp5i8ICgnREqiF7V3jHqO5Z5lwRRPWJFv/uSadNqIJ2
 004G703Nl7OAZJc4qBVw1RKqO7OQvHeVtkxcTXYWxYO2OBAG+AuOGCthwS1HJ2qvZdj/a1JR+Wz
 f9gy4M3Ac/91KWDsOb4Kr256bbCHCU/GLbfWQSL2D5FmSF3M5FVlpKLWba3ao=
X-Received: by 2002:a05:6214:daa:b0:910:4b24:a936 with SMTP id
 6a1803df08f44-9104b24aa14mr144876206d6.6.1788780060219; 
 Mon, 07 Sep 2026 04:21:00 -0700 (PDT)
X-Received: by 2002:a05:6214:daa:b0:910:4b24:a936 with SMTP id
 6a1803df08f44-9104b24aa14mr144870146d6.6.1788780055015; Mon, 07 Sep 2026
 04:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-9-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-9-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:20:43 +0300
X-Gm-Features: AcwNN1USb1oldLY_Koa-RveruSHhbPC23VmsaaAcCKCUPzIymyjH8PajXW0WHe8
Message-ID: <CAPMcbCr-OfoEEwoBPc553NQE1RiWvpxvxV0WXmVpykVg33neCw@mail.gmail.com>
Subject: Re: [PATCH 09/17] qga/vss-win32: use GetLastError() after
 FindFirstVolumeW failure
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c2ca46065ae2cf0b"
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

--000000000000c2ca46065ae2cf0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> When FindFirstVolumeW fails, the error was reported using a stale
> HRESULT from a prior SetContext call instead of the actual Windows
> error. Use GetLastError() to report the correct failure reason.
>
> Fixes: 0692b03ee135 ("qga-win: add support for
> qmp_guest_fsfreeze_freeze_list")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 1fd73312bab2..d7907c230656 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -434,7 +434,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      if (!mountpoints) {
>          volume =3D FindFirstVolumeW(short_volume_name,
> ARRAYSIZE(short_volume_name));
>          if (volume =3D=3D INVALID_HANDLE_VALUE) {
> -            err_set(errset, hr, "failed to find first volume");
> +            err_set(errset, GetLastError(), "failed to find first
> volume");
>              goto out;
>          }
>
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000c2ca46065ae2cf0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">When FindFirstVolum=
eW fails, the error was reported using a stale<br>
HRESULT from a prior SetContext call instead of the actual Windows<br>
error. Use GetLastError() to report the correct failure reason.<br>
<br>
Fixes: 0692b03ee135 (&quot;qga-win: add support for qmp_guest_fsfreeze_free=
ze_list&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 1fd73312bab2..d7907c230656 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -434,7 +434,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0if (!mountpoints) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0volume =3D FindFirstVolumeW(short_volume_=
name, ARRAYSIZE(short_volume_name));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (volume =3D=3D INVALID_HANDLE_VALUE) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &quot;failed=
 to find first volume&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, GetLastError(), =
&quot;failed to find first volume&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000c2ca46065ae2cf0b--


