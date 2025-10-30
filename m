Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA33CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETzu-0003G6-0t; Thu, 30 Oct 2025 10:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vETzk-0002gY-4H
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vETzZ-0001sC-BG
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nFMttYB5fauTANmpLOz33X8KQGAeltN2KPLLD7rD2c=;
 b=h1xGT474CN9epahbh18xJoipnCC8XX3mSp8lv+KycUZxzrvlfqvQFlyJnrDRQXlD5jsid4
 XTyl4ngNSRWFtiW8ijCelh/dSOR2xAXGoumGIsHq58eBXg5CmwryFRj1lYzAL5FVx7VBup
 kUi5pHGpSHvAD0OuT+HHDrDsDl7po8U=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-FPWkVw3-PaaY5JfV6KpUuA-1; Thu, 30 Oct 2025 10:51:01 -0400
X-MC-Unique: FPWkVw3-PaaY5JfV6KpUuA-1
X-Mimecast-MFC-AGG-ID: FPWkVw3-PaaY5JfV6KpUuA_1761835861
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-781353ba452so15508007b3.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 07:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835861; x=1762440661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nFMttYB5fauTANmpLOz33X8KQGAeltN2KPLLD7rD2c=;
 b=cHee+zImHdYpugsUpCMaQgffDLMtW/dcrrP258T1c+KK/ir1bmaMK8FQUEAk2uNRBO
 lJj/EJOlcseQXQK9/BIljwG8MyhNokUNgbFfuE/hQ993pMBHWtHfM/6bpHhPxuC26zzf
 p9xS419HH2oxpjkeZPZ8jBkwA8OVVIv1MVlNk6imAQuBWi6Lwm3bG77e9d3qpR6hx1Df
 wR4iNdgIzc/1EIahIl6T2NfoT6ZaPppVaxObSwmIoxn1l3j5+Xqe4Wfa6aS7biWQuhU3
 IG3dG/Gv9zhTNXqDnH/aAZojV6wIk0tauIcLpOrlcBASzrqn1WfreKl/ztkwNi/fksJJ
 jzeQ==
X-Gm-Message-State: AOJu0YxRGmQZbZw3vcikOLMfXQOTXn6s2Ox47fR1f40+ln2G9ClVBisQ
 b2xLPY3o3Zu8cBT6v76f5Bx0XNU/9oGosBh575yR3xgUiSjehMToQXe+SZwjGXBumXxmzhocY8x
 uQ4yT9MClrnv+8FOb3j9sawYZhu2Ix5T2ovG6jQjxBRLf4UbQXwpwYgaOQ+P/tA/URiVZcHZsCm
 mwZdNzNg8fE+DSwT32NlmL5DNJkaK3J2I=
X-Gm-Gg: ASbGncvggP5dC9CIGFgQTXmgD6M9EZxoUE1sRkDx9F45sbtVYJSCgmLeZhR+S75e3/E
 Cy65K0RK+P0pqMNKPYxuxZMRhipkfoVTjTHZMz+txRotSXG3AsxYutFNIn318N0t3NU/pjm4xB3
 TDBlUXHE2w3h2J/dFGAocEM2SXh6ZqAGq+cV8ixTBhLUC3Iyk25APp4CoWdBImjOW8RjUhurphf
 KjAgEXqyFt1MLA=
X-Received: by 2002:a05:690c:6c84:b0:784:f14d:6946 with SMTP id
 00721157ae682-78628ffec19mr65704837b3.55.1761835861117; 
 Thu, 30 Oct 2025 07:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU2XBs3mVPK45zy1qH+p5tLgwo80pni5MM2JQeI+9sTSxnp2++sHZ/kMQJZrBl6wFtoqcG6tRkUE+/YwdxmBA=
X-Received: by 2002:a05:690c:6c84:b0:784:f14d:6946 with SMTP id
 00721157ae682-78628ffec19mr65704417b3.55.1761835860549; Thu, 30 Oct 2025
 07:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-3-jsnow@redhat.com>
 <d08731ce-e543-462c-8980-e5153cca5621@redhat.com>
In-Reply-To: <d08731ce-e543-462c-8980-e5153cca5621@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Oct 2025 10:50:48 -0400
X-Gm-Features: AWmQ_bkoYvttOzeVlmK40i_lzQ_1lRSmegMi8ALWuYOyVmYD1E0KdW1ZK58UzFU
Message-ID: <CAFn=p-YkossgdQJUJZE9NXJKcavmAcOA7pcyNTiTEMVWxiAeiA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] python/qapi: Add an ignore for Pylint 4.x
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009ef7050642616039"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009ef7050642616039
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, 4:23=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 28/10/2025 23.03, John Snow wrote:
> > Pylint 4.x wants to use a different regex for _Stub for some reason;
> > just silence this.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   scripts/qapi/introspect.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index 89ee5d5f176..7e28de2279a 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -59,7 +59,7 @@
> >   #
> >   # Sadly, mypy does not support recursive types; so the _Stub alias is
> used to
> >   # mark the imprecision in the type model where we'd otherwise use
> JSONValue.
> > -_Stub =3D Any
> > +_Stub =3D Any  # pylint: disable=3Dinvalid-name
> >   _Scalar =3D Union[str, bool, None]
> >   _NonScalar =3D Union[Dict[str, _Stub], List[_Stub]]
> >   _Value =3D Union[_Scalar, _NonScalar]
>
> Alternatively, rename it to "_stub" ?
>

Well, it's a "type" and it should match the others, ... I don't actually
know why it is deciding to whine about this and had bigger fish to fry.


> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>

--0000000000009ef7050642616039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025, 4:23=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 28/10/2025 23.03,=
 John Snow wrote:<br>
&gt; Pylint 4.x wants to use a different regex for _Stub for some reason;<b=
r>
&gt; just silence this.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0scripts/qapi/introspect.py | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py<b=
r>
&gt; index 89ee5d5f176..7e28de2279a 100644<br>
&gt; --- a/scripts/qapi/introspect.py<br>
&gt; +++ b/scripts/qapi/introspect.py<br>
&gt; @@ -59,7 +59,7 @@<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0# Sadly, mypy does not support recursive types; so the _St=
ub alias is used to<br>
&gt;=C2=A0 =C2=A0# mark the imprecision in the type model where we&#39;d ot=
herwise use JSONValue.<br>
&gt; -_Stub =3D Any<br>
&gt; +_Stub =3D Any=C2=A0 # pylint: disable=3Dinvalid-name<br>
&gt;=C2=A0 =C2=A0_Scalar =3D Union[str, bool, None]<br>
&gt;=C2=A0 =C2=A0_NonScalar =3D Union[Dict[str, _Stub], List[_Stub]]<br>
&gt;=C2=A0 =C2=A0_Value =3D Union[_Scalar, _NonScalar]<br>
<br>
Alternatively, rename it to &quot;_stub&quot; ?<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Well, it&#39;s a &quot;type&=
quot; and it should match the others, ... I don&#39;t actually know why it =
is deciding to whine about this and had bigger fish to fry.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Anyway,<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000009ef7050642616039--


