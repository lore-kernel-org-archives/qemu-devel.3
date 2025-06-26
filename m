Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8754C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhKn-0008Jv-Gu; Thu, 26 Jun 2025 03:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1uUhKZ-00088f-0i
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1uUhKF-00025N-D0
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750924034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVqmY5gfOpbF8eV+8qqV6iOYtrnyVuPieMCnlFGT9Os=;
 b=EMMORNKcqyffy3EyEYsdr4Rs7zdaOpSEq+gbtq86IQv1QLqtuE8sFYBn1CCZ7KgaVrVxsg
 nWagP5UiWvQtHUxT+N5OnRe4vkl+iuJa16c27a5rnJ7e/k+yPcsMlrdlkOui8zJ3EIMqji
 kZB/oCMlHpvB5wIxhQwJhJT7156r238=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-j93CmvflOR6OPsDNXuaFFg-1; Thu, 26 Jun 2025 03:45:43 -0400
X-MC-Unique: j93CmvflOR6OPsDNXuaFFg-1
X-Mimecast-MFC-AGG-ID: j93CmvflOR6OPsDNXuaFFg_1750923942
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae0c11adcd2so46754066b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750923942; x=1751528742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVqmY5gfOpbF8eV+8qqV6iOYtrnyVuPieMCnlFGT9Os=;
 b=WuosdF97j/wvVJA3XhWB2wZJDRQxuo/FxWyzAZzaU5OF1i7bqJe70j0+T9n5igwXB2
 3k5DSjYA1+5w96QW3gLtLpsyXR/WqSOv2328VlM3Aa60KRWRjKxoaaE/WLqEe94EQB5s
 eascYbgAIub1qivswMt622/5FxwMtPkiXSbCoFmYd7iT6B5tzGUGBdLdsY5G/+A/eZWY
 qEwsRg3XfEnm9kJs4fteoqHcRAhh/XsFAEfpE/6UGv6puJAxzhxEdArLKgVJxEeDSLj9
 khyOn2TrSpwwc9TVq1llfPpjXnBc2FxuExBJDG5i2fUVfzbjwb02R6gHmbcT08u/Olp7
 y21Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgiLt0vNpNJ5gSSQouypqqvtA7tgY0qDgRzHDdCgZd3+A+aBTwxGkRtl93bXsDNLNlty6GJ0BOuplQ@nongnu.org
X-Gm-Message-State: AOJu0Yx6kfHGgBP1jtcL0eCA4X5M8ddh3C9hsbwjm6p8fbmBdMe8EiMA
 V3JoEi1HENNmDYO8W870fYYIUbKVIbBtJQ9+JdiQY3B2xA9p4owvPmUtfK7MKz9zx3/Hs3xOYWJ
 X3UXZSKhRxuJgqzxK5sGg2tLGX2+CikNfLaz2nrR+9LbOXrpI6XH6axoeO0Gg30gMRj8jUE5Htu
 Gt5qp3u1WQKLqa39CDepi7tCptQqVvA2c=
X-Gm-Gg: ASbGncu1EphrEaAFWloZQIcxGPTQMG8V6fOvV28G8l+pI1Z1zVYpzKyauqXBXOKAw6X
 0lBaTpCqnuxD4KX5WtsffKfg1dO6FJd8wwW6or5d8ei7YyOQp5JTwBs6ac/mTNgKiJRZ+J9nFyx
 fTPYbG
X-Received: by 2002:a17:907:7e5d:b0:ae0:a351:61ff with SMTP id
 a640c23a62f3a-ae0be9c12f5mr600363466b.32.1750923941698; 
 Thu, 26 Jun 2025 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRoNtTW2YBh0eBmzx4T8gmtVXIleoFXn7tfMH2aTVRt9/+GQsx/yUEGvkxFiRz/G7SpGeO5aZVp9lp3zE+6Go=
X-Received: by 2002:a17:907:7e5d:b0:ae0:a351:61ff with SMTP id
 a640c23a62f3a-ae0be9c12f5mr600360966b.32.1750923941201; Thu, 26 Jun 2025
 00:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250620083132.28347-1-kkostiuk@redhat.com>
 <CAGoVJZw0-ShHSc3cLkO4tcUjAwifOFksWLF3mFmX-x3bWk5oVg@mail.gmail.com>
In-Reply-To: <CAGoVJZw0-ShHSc3cLkO4tcUjAwifOFksWLF3mFmX-x3bWk5oVg@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Thu, 26 Jun 2025 15:45:29 +0800
X-Gm-Features: Ac12FXynhD_SKbqKzNKx8iDLmOFTUk_5pwsYphmy0wmPikw6b1VUmsJgPSMr7d0
Message-ID: <CA+kPPJzAS27TOkmqsYRaieqoyJLEsFmVqs6hPwbQaQmOrBopWA@mail.gmail.com>
Subject: Re: [PATCH] qga-vss: Exit with non-zero code when register fail
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008be874063874bf0b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000008be874063874bf0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Dehan Meng <*demeng@redhat.com <demeng@redhat.com>*>

On Fri, Jun 20, 2025 at 8:31=E2=80=AFPM Yan Vugenfirer <yvugenfi@redhat.com=
> wrote:

> On Fri, Jun 20, 2025 at 12:33=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@red=
hat.com>
> wrote:
> >
> > QGA installer uses rundll32 to run the DLLCOMRegister function
> > from qga-vss.dll and perform VSS provider registration.
> > rundll32 ignores the return value of the function and always
> > exits with a zero exit code. This causes a situation where
> > the installer does not know the status of VSS provider registration.
> >
> > This commit forces to change exit code when the VSS provider
> > registration fails.
> >
> >
> https://learn.microsoft.com/en-us/windows-server/administration/windows-c=
ommands/rundll32
> >
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  qga/vss-win32/install.cpp | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index 5cea5bcf74..6ee2f44a10 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -385,7 +385,10 @@ out:
> >  STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
> >  STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
> >  {
> > -    COMRegister();
> > +    HRESULT hr =3D COMRegister();
> > +    if (FAILED(hr)) {
> > +        exit(hr);
> > +    }
> >  }
> >
> >  STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
> > --
> > 2.48.1
> >
> >
>
> Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
>
>
>

--0000000000008be874063874bf0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Dehan Meng &lt;<u><font color=3D"#0b5394"><a hr=
ef=3D"mailto:demeng@redhat.com">demeng@redhat.com</a></font></u>&gt;</div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Jun 20, 2025 at 8:31=E2=80=AFPM Yan Vugenfirer &lt;=
<a href=3D"mailto:yvugenfi@redhat.com">yvugenfi@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jun 20, 2=
025 at 12:33=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@r=
edhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; QGA installer uses rundll32 to run the DLLCOMRegister function<br>
&gt; from qga-vss.dll and perform VSS provider registration.<br>
&gt; rundll32 ignores the return value of the function and always<br>
&gt; exits with a zero exit code. This causes a situation where<br>
&gt; the installer does not know the status of VSS provider registration.<b=
r>
&gt;<br>
&gt; This commit forces to change exit code when the VSS provider<br>
&gt; registration fails.<br>
&gt;<br>
&gt; <a href=3D"https://learn.microsoft.com/en-us/windows-server/administra=
tion/windows-commands/rundll32" rel=3D"noreferrer" target=3D"_blank">https:=
//learn.microsoft.com/en-us/windows-server/administration/windows-commands/=
rundll32</a><br>
&gt;<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/vss-win32/install.cpp | 5 ++++-<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
&gt; index 5cea5bcf74..6ee2f44a10 100644<br>
&gt; --- a/qga/vss-win32/install.cpp<br>
&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt; @@ -385,7 +385,10 @@ out:<br>
&gt;=C2=A0 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, in=
t);<br>
&gt;=C2=A0 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, in=
t)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 COMRegister();<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr =3D COMRegister();<br>
&gt; +=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(hr);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, =
int);<br>
&gt; --<br>
&gt; 2.48.1<br>
&gt;<br>
&gt;<br>
<br>
Reviewed-by: Yan Vugenfirer &lt;<a href=3D"mailto:yvugenfi@redhat.com" targ=
et=3D"_blank">yvugenfi@redhat.com</a>&gt;<br>
<br>
<br>
</blockquote></div>

--0000000000008be874063874bf0b--


