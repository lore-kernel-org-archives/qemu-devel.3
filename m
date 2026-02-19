Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C21E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7T1-00020n-4v; Thu, 19 Feb 2026 12:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt7Su-0001rB-WE
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt7Sr-0006ha-Bu
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771520717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+KmzAu4+ybYUz0qFkRfQ96SFUwTEftZIh1X34TXIh8=;
 b=OT6kmUhxtNHzjw2Rg+8DSOkB5Db32928yqI9HFaqcRsrIFfi9M2NIzxaxhBixhO+oJ6iU/
 omoV+znMxGYrfdPEAPAApn8dW8wAgCHd2wUB/aicrfYJSocKYlIQ+0LN/vd/zenIhiD2Da
 lV7dDHBS03BBR9RpXaTkL8IKkyxfEqs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Ucwa2DnWMoirNSPV9A9bgA-1; Thu, 19 Feb 2026 12:05:15 -0500
X-MC-Unique: Ucwa2DnWMoirNSPV9A9bgA-1
X-Mimecast-MFC-AGG-ID: Ucwa2DnWMoirNSPV9A9bgA_1771520714
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-798080635ceso7777207b3.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520714; cv=none;
 d=google.com; s=arc-20240605;
 b=J3tENdfBCg7FMyCYJimeB2lU1cZyGW8xjmzDWTct9yOItKGGnlH7GrxgRZD3YnJCt6
 E3Bz+0wPZuC5KwfC5PaoYNulky+Mc9h7zGox+AlbBk5vPXZiGBLuPPk4gFS+O33WE05n
 jrHNFw3pwxptW9MDtgs1m2r/2SF8qGyeZT1+b9pbLu51y4YGhs+Br+D1aJBto3adqdaU
 yslEDfyS9SYP5Uzg9eMUuOaHs3/sKFFNdY3LPH9U5sgwVUOlQ+yc7QGWPgp45J1N4jds
 bh60HRiWAT0VsgMrex0/3jOksJH3E8SsVB6Txnp2MGhoJIPdUGid50BeJRfR2hT26iAs
 5FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4+KmzAu4+ybYUz0qFkRfQ96SFUwTEftZIh1X34TXIh8=;
 fh=/cYHESLrHbWEtKM+urYn1JV96YMPLAcipSOzHB1G12o=;
 b=XfDqKO9LZ0TSWxOZVpb5sVgRhiw8v6xL03xoAVc7gMrQUmEr0OpUR6h1hT4YOCWoGg
 fK/SbAfpzQnHZFCWV/MYdHkuVY7BmoM1H8tlDn+AywLW0Qf+3mapCnBkz48HDlQUDlGC
 NlRHJlcsePGPM/VEmGmqXQA2hdrprTp419JQXsq0o/oWEi7g9efR6fxHNUvRxXMNhT0U
 BoQr+NJcZWdNKSNi4jWyuh1aPDpRM5z2PMxQf+UwPGrDqAJrqBO3wFr/OQ3J4zALhKPS
 BCgWZuXy7yAHigNfqLECb8QNrB2qNKYQx/zs0TUOtyJRaW26bEvFuKOEYKIoniIAsypf
 Vilg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771520714; x=1772125514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4+KmzAu4+ybYUz0qFkRfQ96SFUwTEftZIh1X34TXIh8=;
 b=WIPeWvjKGpQF/SEFglp1ZAXEX30Oh544TT4fsQMUXKN3vGveeDGlkKZ8MUgDWENoIb
 eQiCTPKqnklryhD9hhzCnLNbF8MhPWRDyYFodvCMqqkURw7JYQdvBrxsuJUf1goGPnyK
 uTntH+7kccEvRRfs6oA3vmEcMoenGN3NDRpVQGV+ddMZYXCIgn15zh78RSCk8qIIe692
 kSIeIS3fTW1mrKQ4Y2YrCmlYFdYX4MbZvt8CCFsuMTWE75uoeFSm33/WRLwOUn6w4CJn
 3lfQzkKM2sQaodXKEO9fpQolYdN0Z8CeAxVfslA8KyVvAbOj0Tjhw0onLd4+tvkNNQG5
 5HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771520714; x=1772125514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+KmzAu4+ybYUz0qFkRfQ96SFUwTEftZIh1X34TXIh8=;
 b=SxNs32rqcln0XLythVbfvaZ/JJYWzpxDICtJg0WvBLovwRlxITmLxDnJSBLGZI1IlA
 JcxZssiBed4ONtdtbwqctrG7lGtWAftSBHX/DlBapYKvajcB1PSya/JFprKa/7aRio6B
 aw8UA0QH5aIo9pCBjNrYaHVjlMO1lptyC9rAfVGWLooy1Ag2tv8HxQSSyouk2ez1jFVw
 /xZRf499QJ5WZWm2MDsE69hSoDsJGvHaJLyncwYwtXug3zURPsa2YnfM2+lOo2Xza2IR
 eyRSJL9LqqBI1/uaxs2z/NmFVAoJzvDWOAL+Gg7lo01oYAe8sCzvOkZioxLG8/ydZl+d
 SW6Q==
X-Gm-Message-State: AOJu0YyDOIKzdSz5FU0xaFbU9tv1t8vL25NcLjPWz/hoar03N6brr8XH
 19CBnvSd5LpIjR65G/qc7bIp/eAZ5Zc/z0FJzS89BSbyp7mszaBSIDlQ62ki19djjr9TMWn2QHS
 1SxdmF70Nl/Bzoo1JOKwHmyWoB38YrSo6UUp5uUeFfWw0WQfe3cQbh9qvIYSapPxSTAK9rYMawz
 T0aKP88cwhBftgQI2pCsaC3k7ppEX0bUw=
X-Gm-Gg: AZuq6aJ8LJKe1uQ5j51xzjT5xNAtUwJ2s7Yp07VFZxGtTZYhoRp0aZW0pQnBYOtfJkE
 3b7T4/ig3Zz837Ansswur6MzxYtn7XA7v5jO9Vyi5IaaDRexQ+yuAPmKCoz6iBOgf4bvzH6U5bA
 fk5BxTtftGpCaAWFAXCIrKoGSe6p8FTdtWRR1hn9FlypRkhyRwD0oVXNMmpBT2DWXtrmb4Z/un0
 zit+VqAI5/byENT1gZuenJujfgTIdwqnVJYNQ==
X-Received: by 2002:a05:690e:1382:b0:649:b216:c8b8 with SMTP id
 956f58d0204a3-64c5557346dmr3830677d50.4.1771520714363; 
 Thu, 19 Feb 2026 09:05:14 -0800 (PST)
X-Received: by 2002:a05:690e:1382:b0:649:b216:c8b8 with SMTP id
 956f58d0204a3-64c5557346dmr3830630d50.4.1771520713739; Thu, 19 Feb 2026
 09:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20260218192444.658046-1-jsnow@redhat.com>
 <20260218192444.658046-2-jsnow@redhat.com>
 <118306d2-8c7f-4b8d-bba7-bf4529c3cc9b@linaro.org>
In-Reply-To: <118306d2-8c7f-4b8d-bba7-bf4529c3cc9b@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 19 Feb 2026 12:05:02 -0500
X-Gm-Features: AaiRm50TcxCjOe1-l__dLf1xzpiyjZHjYcHpjhFIABOiah4WVU69EHRogCWuwk0
Message-ID: <CAFn=p-aDnE+YgE6e-cpLQZeNhG6Tw99jt6F_Gn5vz4_u4dZ7YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: use checked_div to make clippy happy
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000db4e0b064b304e4d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000db4e0b064b304e4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026, 10:39=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/19/26 05:24, John Snow wrote:
> > When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
> > complaining about not using checked_div instead of manually checking
> > divisors. Make clippy happy and use checked_div() instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   rust/hw/core/src/qdev.rs | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> > index 145e20a984f..c4a7312168f 100644
> > --- a/rust/hw/core/src/qdev.rs
> > +++ b/rust/hw/core/src/qdev.rs
> > @@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
> >       }
> >
> >       pub const fn period_from_hz(hz: u64) -> u64 {
> > -        if hz =3D=3D 0 {
> > -            0
> > -        } else {
> > -            Self::PERIOD_1SEC / hz
> > +        match Self::PERIOD_1SEC.checked_div(hz) {
> > +            Some(value) =3D> value,
> > +            None =3D> 0,
> >           }
> >       }
> >
> >       pub const fn period_to_hz(period: u64) -> u64 {
> > -        if period =3D=3D 0 {
> > -            0
> > -        } else {
> > -            Self::PERIOD_1SEC / period
> > +        match period.checked_div(Self::PERIOD_1SEC) {
> > +            Some(value) =3D> value,
> > +            None =3D> 0,
> >           }
> >       }
> >
>
> These conversions are inconsistent about the placement of divisor and
> dividend.
>
> r~
>

Whoops, fugue state. I'll fix.

--000000000000db4e0b064b304e4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 18, 2026, 10:39=E2=
=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.o=
rg">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 2/19/26 05:24, John Snow wrote:<br>
&gt; When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins=
<br>
&gt; complaining about not using checked_div instead of manually checking<b=
r>
&gt; divisors. Make clippy happy and use checked_div() instead.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0rust/hw/core/src/qdev.rs | 14 ++++++--------<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs<br>
&gt; index 145e20a984f..c4a7312168f 100644<br>
&gt; --- a/rust/hw/core/src/qdev.rs<br>
&gt; +++ b/rust/hw/core/src/qdev.rs<br>
&gt; @@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -&gt; u64 {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pub const fn period_from_hz(hz: u64) -&gt; u=
64 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hz =3D=3D 0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::PERIOD_1SEC / hz<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match Self::PERIOD_1SEC.checked_div(hz) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Some(value) =3D&gt; value,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 None =3D&gt; 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pub const fn period_to_hz(period: u64) -&gt;=
 u64 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if period =3D=3D 0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::PERIOD_1SEC / period<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match period.checked_div(Self::PERIOD_1SE=
C) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Some(value) =3D&gt; value,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 None =3D&gt; 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
These conversions are inconsistent about the placement of divisor and divid=
end.<br>
<br>
r~<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Whoops, fugue state. I&#39;ll fix.</div></div>

--000000000000db4e0b064b304e4d--


