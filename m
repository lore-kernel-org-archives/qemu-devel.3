Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E70E9E2E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq7mA-0008IK-JJ; Wed, 11 Feb 2026 05:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7m9-0008I7-Kf
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7m8-0003kO-75
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770806931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yfo49RTjE0k0JYE7+aYbLd0jlCkXHW0yXwEbusR6Nkw=;
 b=TEAj+mD5JM1xpWshQv4Ep7DTCFNWP2iJkjF9vou01CpC5OcRjJJ/G7h9XvMprCz1rsx820
 P2OaXHa631JQgSdYOT1SKZjd2s9/hs2moTlUivPTxJ+w4enzDE7OQ4wU2qx2y5NqCOKh3G
 8e6epf/AkcMVlzxGJWc+SPL5BZohoVE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61--yyZ48xgPoWQLYy7-cwbfQ-1; Wed, 11 Feb 2026 05:48:49 -0500
X-MC-Unique: -yyZ48xgPoWQLYy7-cwbfQ-1
X-Mimecast-MFC-AGG-ID: -yyZ48xgPoWQLYy7-cwbfQ_1770806929
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-896fbdb9968so111238476d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 02:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806929; cv=none;
 d=google.com; s=arc-20240605;
 b=CxZ/vzPDR4CLZDVulJABV//z7d3GAbyh554RUuGq/Lyntn5j/wGxl8RCk3tFkEhCO7
 u0FMSybwGI0bIxsI3EmN88LtoFwkdF03opiuenPjPX9K5AsaHbqdeLvpOyJm69SdtYc8
 ozF46EIwuSFxO/ParZBPReC8rgLSA97vadywUj85pKIGg/GoqpyhIN24kcH7ikGO4kok
 UVYjDPsJOgXDydzK4j7thHDLgaqd6nM/H6JJxJ+18MHtwfSul74X1iw87KI6ZpOWTO1E
 S//7sQothMQ0xKDf5R1rdzUVkAuw5M/JnlbkabxaVgInrh1a1ydM4JxovfogFVBbeyrW
 JB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yfo49RTjE0k0JYE7+aYbLd0jlCkXHW0yXwEbusR6Nkw=;
 fh=y2IBWUgtcUjG6NJSqP3lV5ogPzGemdHdE6RYndP4ox8=;
 b=JIWo7U3PXrtPo0BA7eHmQpEh9dSK7WjU1/bJgDgD05DPl3UHQj2de/7/0V1/Ny5RYf
 pjkw/Y4zcefmNVzzI2QGSwwOlK3tT7BV8n/S9a9hby6kN8ymCizDPm2XfZ0muR0vM8U5
 UIjHFLYlDTsilmtRcRfzVPAzxRISBqyP3WJUNVOArUynVe8ivZ8uSxRdRIMRJLy8NN7X
 7ZKkpWj5tOBQ4mNk3Twr+/9et/qwuUsdgG++NbpjNWl6U1W06L3GkEgpox2y/oGUtrd5
 mQBJVlrGXEimbhy9wuy9zphiwE91NButDmoGfN0batA0GgKQBvP4YFOel7qbM18jbdvt
 wqPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770806929; x=1771411729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfo49RTjE0k0JYE7+aYbLd0jlCkXHW0yXwEbusR6Nkw=;
 b=FZ2Ge1Pt57eKsABW2EoYY8zyrdJ7uAUUU+4TDRE0aJ+Jd59xfohq5zzMUmKBs0m5r0
 Dx0dANuCW89q8m/oYK4AtEH+uHhDbjriFIAECauGRkzALWVApCNcMI72QKkD3NT+S6Ig
 oz57UvR2mB0MjjBxNaG86Z+mM7r0sInpSqXJAdPO4aU4u3mRHs8I3fSWuZOPs9w3jP9J
 qKBk6c1VnlLIJZT66OA2Q6CX7VoibQE6GSp1NtOOMdMO/Tfx8Ks85azO6T/Fd3OMtEhX
 UhiivExX2JKhMyjWrEOzLyOIPT+gaYx05S+iCWOZ9+ImoLUfLKpGhrPVHkPan1ekche3
 xDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770806929; x=1771411729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfo49RTjE0k0JYE7+aYbLd0jlCkXHW0yXwEbusR6Nkw=;
 b=e9uOUl6fRumCtwt41NWO4yUhkAQvMKb4jkLXF0OfnM29EmArRJ5nmhKbCfwlEmp7U9
 uIMG3Ml61UbrPGLxuVAGBkXBBe34sayEP6bb4yZD/8RI5GboYggIig5zuxrbfp3asBiE
 +GB4SrEI3PlFM5FIam4OqypRM/4opIqt9l53XerPZxul9byT7ABQFfWUeDkhoTjge1MV
 6OdDJp/pzP4sXJ+0zd23Z+4gYtdPW0+bAB4ehWSJAJ96ozzlmZ327J3mxnUtF/1XSs4+
 v1KlVu1WiOjdCOnEX+9HBYEvBARUFCatsLNa/rGc+sV2Fo8sy95JmxsL8veNAUCvVo8b
 FMQw==
X-Gm-Message-State: AOJu0YzsBkH1aT8u5jVNalqQrSbFdgz8tCeW/NJg9/fQbuiA5yilRR05
 bndVd6P2rb4wH8YE27awNjiSUHNwetBFMiiP5wSXa7TOTBlPAOZOKrJtj1pbLYfwl/Gz9Zz+6MX
 YeVUxRKztd2HjkwqpoiO3T+LJK4D4v486prLSwuGj8xTpRyWw1WjJNZe8diaqTg5xiz99HLrpJm
 0gPv14c0EkmzmhS1nU3/Lz9ho5hexlIOg=
X-Gm-Gg: AZuq6aI6Vm7t12zmO8JoHZwwPT2UpZLXSjXkKT5zcAUBKRyT2JNiIQs/6kUbklQquyO
 iXqz+5u34hOU8uqQ3W4BHoIzlKxT+GbsmeQgMbQaBR2tYBsnmRDnsdSvooDMviVPl5SjJ0NBc6d
 UuRoEFBgG/6j56BbgdjNb0NnB+DeQ9VKNOTpqW7UeNPIJJKNaRRsALfTB5TLnqy+BRtUHBiOGBp
 EbxPs7U
X-Received: by 2002:a05:6214:4018:b0:896:fc72:f89 with SMTP id
 6a1803df08f44-8971db99b8fmr12164826d6.57.1770806928642; 
 Wed, 11 Feb 2026 02:48:48 -0800 (PST)
X-Received: by 2002:a05:6214:4018:b0:896:fc72:f89 with SMTP id
 6a1803df08f44-8971db99b8fmr12164656d6.57.1770806928208; Wed, 11 Feb 2026
 02:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20260211101744.757548-1-eashurov@redhat.com>
 <20260211101744.757548-2-eashurov@redhat.com>
In-Reply-To: <20260211101744.757548-2-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 11 Feb 2026 12:48:37 +0200
X-Gm-Features: AZwV_QhwswNY5qWazNSsxiIZvwSmSYyDbg-86o1KWOHWftM8PaLTY6Q6QG_3QBk
Message-ID: <CAPMcbCoKwYOdxDAXY3QbXSQoYssejxj6LJhQrQw2OUKxDFtXDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qga: Fix VSS provider GetSnapshotProperties return
 value
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ec10a0064a8a1d47"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ec10a0064a8a1d47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Wed, Feb 11, 2026 at 12:22=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat=
.com>
wrote:

> GetSnapshotProperties() returned VSS_E_OBJECT_NOT_FOUND causing
> "Snapshot id not found" errors during VSS operations.
>
> Any error in this function causes a similar error in Windows VSS,
> so we must return S_OK there.
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

--000000000000ec10a0064a8a1d47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Feb 11, 2026 at 12:22=E2=80=AFPM Elizabeth Ashurov &lt;<a =
href=3D"mailto:eashurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">GetSnapshotPropertie=
s() returned VSS_E_OBJECT_NOT_FOUND causing<br>
&quot;Snapshot id not found&quot; errors during VSS operations.<br>
<br>
Any error in this function causes a similar error in Windows VSS,<br>
so we must return S_OK there.<br>
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
</blockquote></div>

--000000000000ec10a0064a8a1d47--


