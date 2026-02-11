Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16964EB5954
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq6b0-0008Jk-1w; Wed, 11 Feb 2026 04:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq6at-0008JL-T2
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq6ar-0005Qy-7n
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770802386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7BVEgv+0sKtyrF+Ee38q1NUJ7yVW0qIKgZwlcyaCEE=;
 b=CrlWgMYA01C71AOK+CXWo0aWn4kjPQa/T0pV5QMatdlWdx2cSu12+Kq6LAwBkaxgb31cet
 +a/0g3q6bw7xjvhr9vLe8ZAoSYzUKqWU4IgrzcZLR2gFfZzAIEE7CM1UCfwqIgm+2Th1YH
 2P0RukAHPftkiqbS5/VuSFXZN15TvKU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-QzYbz8ZdOmyXOMJcI9eu4g-1; Wed, 11 Feb 2026 04:33:04 -0500
X-MC-Unique: QzYbz8ZdOmyXOMJcI9eu4g-1
X-Mimecast-MFC-AGG-ID: QzYbz8ZdOmyXOMJcI9eu4g_1770802384
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8947d47793fso316473056d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 01:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770802384; cv=none;
 d=google.com; s=arc-20240605;
 b=f04HORRDLRH1+rioJJqUWlhcxk/wvZHUYZk1cEvGF8NgIo6Hg+hYAERYz+p1dxwWZo
 vBrmxlFToy5i8uSYnR4b+doQ7hZwpGpEUIes9X5Thj0pgHYDSg/3l/7Gk3lPq7T5Zo3t
 sOfiIPsrA+RxPDgdhf0Q3gv6RdWtRNad7VldLrUX4CuPqHnoLsgc9bsdZS5+KJnOUVM2
 keh4a0rqZcLez294uyhotBq35GgcoeyemeDipPGLsi2QcQ+rB/P4HsOMMu0fcpdb4VYe
 k4Xfcz/+4GioiSGJNrKFNLJ0DP59A1hWePx+gB7jLQAmh67hYOobKTnGsiRy/u+WUJBe
 MyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w7BVEgv+0sKtyrF+Ee38q1NUJ7yVW0qIKgZwlcyaCEE=;
 fh=y2IBWUgtcUjG6NJSqP3lV5ogPzGemdHdE6RYndP4ox8=;
 b=AYyZnXh4jfOKx6wekcJM7Xnx6tZGRqZmBshE5tCWI7LVtezLyU7FX4OFU4Toys0IBK
 7rmvIhiFvP2dDaQJoureorWWMFP8QgRJA+s9FMcGJGgvBUtzQT7Jzw2+qVUQ45r3WeaI
 kNSO/tLkwT6C+RGVcfXXhhkSa5s7Y3mw7IAo0OiJH3EFxZyMC3YT2DZveQ8MbQ65gH5g
 /FiRUWKaRXZLdyyEiqlQWKXoRMAmtRhrzQ+Yfgf/JxTjGHcb0QmZs3TJ/mlqquCPomsz
 xTbu6g8XV3BSib/g/U5OXXeiGZ2FqUW59YoaY90f7ld2Uu7yuLlpnDObaLAiQEHcoKeL
 Vcnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770802384; x=1771407184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w7BVEgv+0sKtyrF+Ee38q1NUJ7yVW0qIKgZwlcyaCEE=;
 b=UxNIvQEOUxI/5jp/pSeej9Ni/gO+i9yy6FBbPkW5ZCMaJLQAfvSE01bEd4jLYnZ//i
 RE5lAa+0a74HkSASjZRCMRhGl+Ods/tHTYtsmBeTsRAA68z/+S6eBqmog4dQLX4ABiQK
 FXGEdGs210wXpzinO+t5oialt8Qe8fVG/7v3UuA4AzmfOsxoYJcjFcPfOSjzuXekFexG
 LiezqJ4f4mG2lI2vE8jEvYp0Za2sv+TD1pwpjjlsiR8YQh+cMjtjGAV1nHPG7kOnHQGe
 GNiN8Bf+SvqysCC1ZDdx0SdUIoa5izHbrdq9UmpNWE5ejnDYITnXx4S4XnvYWqAq/lXu
 H4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770802384; x=1771407184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7BVEgv+0sKtyrF+Ee38q1NUJ7yVW0qIKgZwlcyaCEE=;
 b=Ab/c+txJUKTpAhPvXoFBrufxRbbC8oT4l/AAYhqtth0nr09Ecp10jVObcIeus/Kj+h
 U1UJqHhIpm8m3tsS+kKFh+Bp1gR9k7kBbvY0YhBUKiSXQC7jKXhmWBHgq29xpqeRDGlp
 B9B/3HiHHfztV7BdpaeXDYyS2THM20Iaa9Ozu2IweOkFWARH1eNuQ26J66sgLT3TBGS4
 RJu6zdrPXIAC5YkIa11A40GIh5ufqMMFqsqT8abvwJbuQl0c7N+BhejOsw/BeKzB3q+0
 XYmPlU3wDXoLegZYF0bGsYU1A+87pMKasGCTrwZSKlSwtt2b6o8yMRI7JAn6pdSXhiXw
 oA4A==
X-Gm-Message-State: AOJu0YwdV9LZRa5A4y6L11qQOT7utKJLdEu7cjcbAzhi4kzULTFofKIk
 p926H6eO0bLFGp/+tmpaIJBZSq4k5gvEqgVKmRlPbI3VIwVE9GtwNQssi5X4jEg+3kOYl/Fvap2
 1sKMfN5LSqo1c6qG/MrNVFuC48YlkTbCxqf2muZZGHaB9JaY2h2iVTRtF6EcBGNdr5zTo7bJZFd
 zDHCpuES8EWkG1CijJbUQo5GFw8lVokCmYXF1TRpHcLg==
X-Gm-Gg: AZuq6aJrCngn+IZR7KF7/TGognmRj3ceGFRJMf+H6vdg3CtPWv1DklzZ+PvkNCZvfkq
 5YFInyEkqJjdkXdco7U/XxwXzez+O5+wpoz0T08AIVAwzV0s0gE7PGatio9zYUfmJyU6dYGOkq5
 GGKvpmfsNV18a8gp0fWWt1SE2z3UPqrfNPZMv4RAHNd3qXle0mJ4skB23/lAc1zPyaMwv3SIs1H
 S35X6QU
X-Received: by 2002:a05:6214:d65:b0:895:1e32:d2c6 with SMTP id
 6a1803df08f44-8971af48e1dmr26973806d6.50.1770802383891; 
 Wed, 11 Feb 2026 01:33:03 -0800 (PST)
X-Received: by 2002:a05:6214:d65:b0:895:1e32:d2c6 with SMTP id
 6a1803df08f44-8971af48e1dmr26973706d6.50.1770802383557; Wed, 11 Feb 2026
 01:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20260211090151.747926-3-eashurov@redhat.com>
 <20260211090151.747926-5-eashurov@redhat.com>
In-Reply-To: <20260211090151.747926-5-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 11 Feb 2026 11:32:52 +0200
X-Gm-Features: AZwV_Qi-vQ59g_SLU-bs_xuF2hF-BdIIOavOv9us4bRuYd6mHfm3A8_fwMAsev0
Message-ID: <CAPMcbCq1uqsMgHZCszt4DhZie4BDd_8CeOmdGhHcC9ua0p1N_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga: Fix VSS provider GetSnapshotProperties return
 value
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000a2534064a890f33"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000000a2534064a890f33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 11:05=E2=80=AFAM Elizabeth Ashurov <eashurov@redhat=
.com>
wrote:

> GetSnapshotProperties() returned VSS_E_OBJECT_NOT_FOUND causing
> "Snapshot id not found" errors during VSS operations.
>

Please add that any error in this function causes a similar error in
Windows VSS,
so we must return OK there.

Best Regards,
Kostiantyn Kostiuk.



>
> Return S_OK instead to allow VSS operations to complete successfully.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/vss-win32/provider.cpp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index a102a23fbf..2b5c6f8e8e 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -263,7 +263,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContex=
t)
>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
>  {
> -    return VSS_E_OBJECT_NOT_FOUND;
> +    return S_OK;
>  }
>
>  STDMETHODIMP CQGAVssProvider::Query(
> --
> 2.51.0
>
>
>

--0000000000000a2534064a890f33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 11,=
 2026 at 11:05=E2=80=AFAM Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@=
redhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">GetSnapshotProperties() returned VSS_E_OBJ=
ECT_NOT_FOUND causing<br>
&quot;Snapshot id not found&quot; errors during VSS operations.<br></blockq=
uote><div><br></div><div>Please add that any error in this function causes =
a similar error in Windows VSS,=C2=A0</div><div>so we must return OK there.=
</div><div><br></div><div><div><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div=
></div></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Return S_OK instead to allow VSS operations to complete successfully.<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/provider.cpp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp<br>
index a102a23fbf..2b5c6f8e8e 100644<br>
--- a/qga/vss-win32/provider.cpp<br>
+++ b/qga/vss-win32/provider.cpp<br>
@@ -263,7 +263,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)=
<br>
=C2=A0STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(<br>
=C2=A0 =C2=A0 =C2=A0VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return VSS_E_OBJECT_NOT_FOUND;<br>
+=C2=A0 =C2=A0 return S_OK;<br>
=C2=A0}<br>
<br>
=C2=A0STDMETHODIMP CQGAVssProvider::Query(<br>
-- <br>
2.51.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000000a2534064a890f33--


