Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE80DC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgS78-0004C3-KW; Fri, 07 Feb 2025 12:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgS75-00046O-Mx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:25:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgS72-00013v-UU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738949155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qu5NBm25Yk7t+Enp2OBCWGHhca42y2WHz6oHmjwplPQ=;
 b=PEM2cIfPHaWKawLuR191fXcE5dlsmrkB1kf+XNSBmNtqxfRcbVPY54te+4B1tZR+CbE+NI
 IAAePnq5KUy3kCBZZOYfHyMXbeQ7z8oe9MClZjLUoq5/eXUGoH/6ypvjG3lOqm8xztzpCX
 EnmoIDZdbv/lssnNLwt4MVtaFW87VO0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-CtT50TW0PN-SuPnMpsfhPA-1; Fri, 07 Feb 2025 12:25:54 -0500
X-MC-Unique: CtT50TW0PN-SuPnMpsfhPA-1
X-Mimecast-MFC-AGG-ID: CtT50TW0PN-SuPnMpsfhPA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f9c02f54f2so4749136a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738949153; x=1739553953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qu5NBm25Yk7t+Enp2OBCWGHhca42y2WHz6oHmjwplPQ=;
 b=DVutcRTR6dr4GJrQjq4zBaOoq4/Eh8w8sSTfPJx31ZvfjLJP2fpHJb7GnTajvRDT5d
 Qc+N/6PN+kw9Lje19Gr142CZ+beCrwflq0Bt1TPLSl6N+kTNtP4KyTdJCUbWiiFLbvsC
 m1f0i8+vffAyV1uJxF/UOUE4Tp0QIrVyTZP6Ss8yGxQiCCmoZghNZEveBTOQvAtU86YO
 RFUK4w8ZjJuSdNe4o2YfFgaydXvyOCR9rj/xYAB0oeyLTlnbLhdOHTElEWYXORS+ytgc
 OWYYxesg76MSGHiMd1eaojr3DL47ZUIKzjV6o/5XNco3+F29AGh9z3zsZhZx2Zbmfy5t
 M4Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfpovF25eDsRWaQbJaqdiBXuxDqulK7Xhg/LoLofNq1Zbjr93VAgJXUNRFhX0mwxP/6uVZAF3hN8J1@nongnu.org
X-Gm-Message-State: AOJu0YzWcy7xZzt5V76cbrTlT7XTQFiOVXdoPU1l5z6r0+CCcaKtJFY7
 CluPBaY8XrhXlS1TUpbQOlFXLO4lCY/eEgNrEv+UxTxr0NysvnML4hiKxxNncCTnvwYv/mGTMot
 b+yLRnDjS8mu+APq6gUko06i50iM+TFhCW6N4ZE/hLVG7/ltej8KEgZVtDMdsaIWsVAevEU9Xwu
 ckhlUpcrVHp+F24HJYgNISF2/osvQ=
X-Gm-Gg: ASbGncucRbl+OROUEQ0rxgXd+7PzEdDd4Pft4/8TYxRxmPZKhft8ANVlem59Cj+aCiP
 GvGLVuXPrFEbHh/6LF70FpgOMSBmUuBYy8RE77FMH4fPibBTYnpd7czFuI70oSDPlosE0jJjuEm
 oQEx+w9qJ88rM0ymi7sw==
X-Received: by 2002:a17:90b:3788:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2fa24062a01mr6631681a91.14.1738949153195; 
 Fri, 07 Feb 2025 09:25:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM13aJKYkMVW9KivwoCddRGUlOb9n9IkP9KY7yFgSN2AOWS/jyF083TwOyKY01DbmjzHq7iL1TZEbKAP7tI8I=
X-Received: by 2002:a17:90b:3788:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2fa24062a01mr6631649a91.14.1738949152815; Fri, 07 Feb 2025
 09:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20241212110616.3147676-1-berrange@redhat.com>
 <20241212110616.3147676-5-berrange@redhat.com>
 <87jzabm8ae.fsf@pond.sub.org>
 <CAFn=p-Y4RXP395Kjc4ZnSWuEjn-Vr7YuVEtGAOsWse74pkqvCw@mail.gmail.com>
 <87wme2jbco.fsf@pond.sub.org>
In-Reply-To: <87wme2jbco.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Feb 2025 12:25:40 -0500
X-Gm-Features: AWEUYZmI2Lc0EI_Z5dqw8_VcYCVTTUadhOBndiNFarcyKiHEfmSda27ZbDsqG6k
Message-ID: <CAFn=p-aAKbrG05w=-bJgt5_Xkg=avj4=M4u4ive1Jx=3SvKZXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] qapi: expose all schema features to code
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000895038062d90a694"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000895038062d90a694
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025, 5:30=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Jan 31, 2025 at 8:18=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Cc: John Snow for Python typing expertise.
> >>
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>
> >> > This replaces use of the constants from the QapiSpecialFeatures
> >> > enum, with constants from the auto-generate QapiFeatures enum
> >> > in qapi-features.h
> >> >
> >> > The 'deprecated' and 'unstable' features still have a little bit of
> >> > special handling, being force defined to be the 1st + 2nd features
> >> > in the enum, regardless of whether they're used in the schema. This
> >> > retains compatibility with common code that references the features
> >> > via the QapiSpecialFeatures constants.
> >> >
> >> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> [...]
>
> >> > diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> >> > new file mode 100644
> >> > index 0000000000..f32f9fe5f4
> >> > --- /dev/null
> >> > +++ b/scripts/qapi/features.py
> >> > @@ -0,0 +1,51 @@
> >> > +"""
> >> > +QAPI features generator
> >> > +
> >> > +Copyright 2024 Red Hat
> >> > +
> >> > +This work is licensed under the terms of the GNU GPL, version 2.
> >> > +# See the COPYING file in the top-level directory.
> >> > +"""
> >> > +
> >> > +from typing import Dict
> >> > +
> >> > +from .common import c_enum_const, c_name
> >> > +from .gen import QAPISchemaMonolithicCVisitor
> >> > +from .schema import (
> >> > +    QAPISchema,
> >> > +    QAPISchemaFeature,
> >> > +)
> >> > +
> >> > +
> >> > +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
> >> > +
> >> > +    def __init__(self, prefix: str):
> >> > +        super().__init__(
> >> > +            prefix, 'qapi-features',
> >> > +            ' * Schema-defined QAPI features',
> >> > +            __doc__)
> >> > +
> >> > +        self.features: Dict[str, QAPISchemaFeature] =3D {}
> >> > +
> >> > +    def visit_begin(self, schema: QAPISchema) -> None:
> >> > +        self.features =3D schema.features()
> >>
> >> Inconsistent type hints:
> >>
> >>     $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi-gen.py
> >>     scripts/qapi/schema.py:1164: error: Incompatible return value type
> >> (got "dict_values[str, QAPISchemaFeature]", expected
> >> "List[QAPISchemaFeature]")  [return-value]
> >>     scripts/qapi/features.py:31: error: Incompatible types in assignme=
nt
> >> (expression has type "List[QAPISchemaFeature]", variable has type
> >> "Dict[str, QAPISchemaFeature]")  [assignment]
> >>
> >> We've been working towards having the build run mypy, but we're not
> >> there, yet.  Sorry for the inconvenience!
> >>
> >> schema.features() returns .values(), i.e. a view object.
> >>
> >> I guess the type hint should be ValuesView[QAPISchemaFeature], both fo=
r
> >> type type of attribute .features above, and for the return type of
> >> method .features() below.  John?
> >>
> >
> > It's probably easiest to just use list(...) in the return and then use
> > List[T] anywhere it matters. The values view type is "kind of, but not
> > actually a list" because it isn't mutable. It is, however, an
> > Iterable/Sequence. You can either convert it to a list or make the typi=
ng
> > more abstract.
> >
> > (Rule of thumb: return types should be as specific as possible, input
> types
> > should be as abstract as possible.)
>
> Converting a view to a list makes a copy, right?
>
> I'm not asking because that would be terrible.  I just like to
> understand things.
>
> I'd like to move further discussion to Daniel's v4.


'Kay, but let me answer your direct questions here, sorry. I'll switch to
v4 afterwards.

Yeah, list(iterable) just builds a list from the iterable, so it uses the
iterable, immutable "view" into the dict keys to build a list. The dict
view is a "live" object attached to the dict, the list is a static mutable
list fixed at time of copy.

(you could type it more accurately, but that can be annoying, so you can
just convert it to something "normal" like a list or tuple.)


> > I apologize for this format of relaying patches as it is against the
> blood
> > oath I swore as a maintainer, but it's late in my day, forgive me:
> > https://gitlab.com/jsnow/qemu/-/commits/dan-fixup
> >
> > That branch has two things in it:
> >
> > (1) patches to make the python/ tests check the qapi module. This means
> the
> > "make check-minreqs" test you can run from python/ will be run by the
> > GitLab pipelines. You can also run "make check-tox" manually, or run th=
e
> > optional python-tox test from the pipeline dashboard.
>
> These are:
>
>     dd9e47f0a8 qapi: update pylintrc config
>     dfc6344f32 python: add qapi static analysis tests
>     1f89bf53ed qapi: delete un-needed static analysis configs
>
> Will you post them for review & merging?
>

Yep! Just wanted to offer them as part of this fixup/review to make it easy
for the both of you to run tests consistently. I know it's been a real PITA
to lint qapi, and I found a really simple way to ease that pain and wanted
to share right away.


> > (2) two fixups for linting problems with this series with my s-o-b; fee=
l
> > free to steal them if they're good enough for you.
>
> These are:
>
>     b36a412162 fixup
>     fa6c90ea76 fixup
>
> I'll post them in reply to Daniel's v4 so they get recorded in the list
> archive.
>

Thanks, didn't realize there was a v4 since I'm not in the CC list there.
Add me to the replies if you have further questions or requests for advice.


> > Thank you for your patience,
> > --js
>
> Thanks for your help!
>
> [...]
>
>

--000000000000895038062d90a694
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2025, 5:30=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Jan 31, 2025 at 8:18=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Cc: John Snow for Python typing expertise.<br>
&gt;&gt;<br>
&gt;&gt; Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt; writes:<b=
r>
&gt;&gt;<br>
&gt;&gt; &gt; This replaces use of the constants from the QapiSpecialFeatur=
es<br>
&gt;&gt; &gt; enum, with constants from the auto-generate QapiFeatures enum=
<br>
&gt;&gt; &gt; in qapi-features.h<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The &#39;deprecated&#39; and &#39;unstable&#39; features stil=
l have a little bit of<br>
&gt;&gt; &gt; special handling, being force defined to be the 1st + 2nd fea=
tures<br>
&gt;&gt; &gt; in the enum, regardless of whether they&#39;re used in the sc=
hema. This<br>
&gt;&gt; &gt; retains compatibility with common code that references the fe=
atures<br>
&gt;&gt; &gt; via the QapiSpecialFeatures constants.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:=
berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.c=
om</a>&gt;<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/features.py b/scripts/qapi/features=
.py<br>
&gt;&gt; &gt; new file mode 100644<br>
&gt;&gt; &gt; index 0000000000..f32f9fe5f4<br>
&gt;&gt; &gt; --- /dev/null<br>
&gt;&gt; &gt; +++ b/scripts/qapi/features.py<br>
&gt;&gt; &gt; @@ -0,0 +1,51 @@<br>
&gt;&gt; &gt; +&quot;&quot;&quot;<br>
&gt;&gt; &gt; +QAPI features generator<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +Copyright 2024 Red Hat<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +This work is licensed under the terms of the GNU GPL, versio=
n 2.<br>
&gt;&gt; &gt; +# See the COPYING file in the top-level directory.<br>
&gt;&gt; &gt; +&quot;&quot;&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +from typing import Dict<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +from .common import c_enum_const, c_name<br>
&gt;&gt; &gt; +from .gen import QAPISchemaMonolithicCVisitor<br>
&gt;&gt; &gt; +from .schema import (<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 QAPISchemaFeature,<br>
&gt;&gt; &gt; +)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisit=
or):<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def __init__(self, prefix: str):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix, &#39;qapi-=
features&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; * Schema-def=
ined QAPI features&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __doc__)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features: Dict[str, QAPISch=
emaFeature] =3D {}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def visit_begin(self, schema: QAPISchema) -&gt=
; None:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features =3D schema.feature=
s()<br>
&gt;&gt;<br>
&gt;&gt; Inconsistent type hints:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0$ mypy --config-file scripts/qapi/mypy.ini scri=
pts/qapi-gen.py<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0scripts/qapi/schema.py:1164: error: Incompatibl=
e return value type<br>
&gt;&gt; (got &quot;dict_values[str, QAPISchemaFeature]&quot;, expected<br>
&gt;&gt; &quot;List[QAPISchemaFeature]&quot;)=C2=A0 [return-value]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0scripts/qapi/features.py:31: error: Incompatibl=
e types in assignment<br>
&gt;&gt; (expression has type &quot;List[QAPISchemaFeature]&quot;, variable=
 has type<br>
&gt;&gt; &quot;Dict[str, QAPISchemaFeature]&quot;)=C2=A0 [assignment]<br>
&gt;&gt;<br>
&gt;&gt; We&#39;ve been working towards having the build run mypy, but we&#=
39;re not<br>
&gt;&gt; there, yet.=C2=A0 Sorry for the inconvenience!<br>
&gt;&gt;<br>
&gt;&gt; schema.features() returns .values(), i.e. a view object.<br>
&gt;&gt;<br>
&gt;&gt; I guess the type hint should be ValuesView[QAPISchemaFeature], bot=
h for<br>
&gt;&gt; type type of attribute .features above, and for the return type of=
<br>
&gt;&gt; method .features() below.=C2=A0 John?<br>
&gt;&gt;<br>
&gt;<br>
&gt; It&#39;s probably easiest to just use list(...) in the return and then=
 use<br>
&gt; List[T] anywhere it matters. The values view type is &quot;kind of, bu=
t not<br>
&gt; actually a list&quot; because it isn&#39;t mutable. It is, however, an=
<br>
&gt; Iterable/Sequence. You can either convert it to a list or make the typ=
ing<br>
&gt; more abstract.<br>
&gt;<br>
&gt; (Rule of thumb: return types should be as specific as possible, input =
types<br>
&gt; should be as abstract as possible.)<br>
<br>
Converting a view to a list makes a copy, right?<br>
<br>
I&#39;m not asking because that would be terrible.=C2=A0 I just like to<br>
understand things.<br>
<br>
I&#39;d like to move further discussion to Daniel&#39;s v4.</blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">&#39;Kay, but let me=
 answer your direct questions here, sorry. I&#39;ll switch to v4 afterwards=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, list(iterable) j=
ust builds a list from the iterable, so it uses the iterable, immutable &qu=
ot;view&quot; into the dict keys to build a list. The dict view is a &quot;=
live&quot; object attached to the dict, the list is a static mutable list f=
ixed at time of copy.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(y=
ou could type it more accurately, but that can be annoying, so you can just=
 convert it to something &quot;normal&quot; like a list or tuple.)</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; I apologize for this format of relaying patches as it is against the b=
lood<br>
&gt; oath I swore as a maintainer, but it&#39;s late in my day, forgive me:=
<br>
&gt; <a href=3D"https://gitlab.com/jsnow/qemu/-/commits/dan-fixup" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu/-/com=
mits/dan-fixup</a><br>
&gt;<br>
&gt; That branch has two things in it:<br>
&gt;<br>
&gt; (1) patches to make the python/ tests check the qapi module. This mean=
s the<br>
&gt; &quot;make check-minreqs&quot; test you can run from python/ will be r=
un by the<br>
&gt; GitLab pipelines. You can also run &quot;make check-tox&quot; manually=
, or run the<br>
&gt; optional python-tox test from the pipeline dashboard.<br>
<br>
These are:<br>
<br>
=C2=A0 =C2=A0 dd9e47f0a8 qapi: update pylintrc config<br>
=C2=A0 =C2=A0 dfc6344f32 python: add qapi static analysis tests<br>
=C2=A0 =C2=A0 1f89bf53ed qapi: delete un-needed static analysis configs<br>
<br>
Will you post them for review &amp; merging?<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Yep! Just wanted to offer them =
as part of this fixup/review to make it easy for the both of you to run tes=
ts consistently. I know it&#39;s been a real PITA to lint qapi, and I found=
 a really simple way to ease that pain and wanted to share right away.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gm=
ail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; (2) two fixups for linting problems with this series with my s-o-b; fe=
el<br>
&gt; free to steal them if they&#39;re good enough for you.<br>
<br>
These are:<br>
<br>
=C2=A0 =C2=A0 b36a412162 fixup<br>
=C2=A0 =C2=A0 fa6c90ea76 fixup<br>
<br>
I&#39;ll post them in reply to Daniel&#39;s v4 so they get recorded in the =
list<br>
archive.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks, didn&#39;t realize there was a v4 since I&#39;m not in th=
e CC list there. Add me to the replies if you have further questions or req=
uests for advice.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Thank you for your patience,<br>
&gt; --js<br>
<br>
Thanks for your help!<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000895038062d90a694--


