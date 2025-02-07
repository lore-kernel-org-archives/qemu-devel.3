Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C16C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTWs-00013s-5V; Fri, 07 Feb 2025 13:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgTWp-00013T-7d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgTWl-0003ur-Vs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738954592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AhCXKEBu16WAD8C93Sg6ImNhML9szrFyJEDAX0+ai/M=;
 b=UV8iHVXIT8MFgqdOJCZ4uferhWx+g1FsF9wgmJjRWxdFnabt4IKAdhBra73eLjiI96I5QG
 Igv8e4lZ6E686Apg8CW0csogO2n52P1OinkZvWmNYI/9yVthoganoshFYX0xD9BLeVafFg
 BZYnnGlwNogFIKav2SMWZdwQeUHRw7Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-iLOYGisoMQihSQuqI3z1SQ-1; Fri, 07 Feb 2025 13:56:31 -0500
X-MC-Unique: iLOYGisoMQihSQuqI3z1SQ-1
X-Mimecast-MFC-AGG-ID: iLOYGisoMQihSQuqI3z1SQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so5143996a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738954590; x=1739559390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhCXKEBu16WAD8C93Sg6ImNhML9szrFyJEDAX0+ai/M=;
 b=mULZ2IiGHi6OvdZSztZUENMIMRwyvoaGDA1QKnzH31ulspzuNFgbfM4Lm2q+3dgWxb
 abD0tBvyRj5t9Qgwzn44vmvQ7yeikDsMNgEocowc3xOlKcTzVRBELUu7MRJMmp4PThfA
 Nd85xu/tnin6NEM1WU8jgvM9tntQC24fF5dBmVNMgevoZgPLeQOVi3Q82leSCFUba62D
 Y/r+QxSqCLp6lnZDxZzV6ASkg8J29hvLfhuS1f77KuAvmaidBuCeteZitPqnQKsbtzrv
 UcvElOPdCpZZlIizVtKVXdQoLQfezk80/pd5YJosEP1RKD3e0Tf23VwHcAIh1dBfzmpM
 Yllw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWapySdFDj2IMco2JubGctnpWHa3WixpxVZ0zUAdq9ar9SxVXTICO2dxGr9oI+8FfAimpFQtoJ8W1tH@nongnu.org
X-Gm-Message-State: AOJu0YyIVb78pdiA+c8RGuuw7pPaaf+JPxp8EN99eMuXy0fpj56LteFT
 BavOfaX6B++hRwJ/Rrc1yM1HL+LWRwbtcfPRqWq0/nL0KvQkXMPdUOlBEpNqjnr/nd6bBn/2vPb
 AbVi+gQwQicuwSSClMHh1IfjzhIoKjnz/xYGbXkf/3IKQ9QFFGjf2lKm9+GqILiBvF7fcUkppu0
 tgxN0skuZol1VEIPtlYgKDzqy96Bs=
X-Gm-Gg: ASbGnctQPXff2rXl9L/9podZvF5wfTl8C+5VwRsI9PzZtwBDr0T8ETAMRY+SBW6t0zX
 04/ISmXoqpLdwA+IYoityau7QO1hKijB1mTcXNzuRfHelS0LSvfRlunxxioZVhTI/XGGO63lAzT
 +C/KmkYDFKFtj0LX6lmg==
X-Received: by 2002:a17:90a:ec86:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-2fa24064f1dmr7498740a91.12.1738954590275; 
 Fri, 07 Feb 2025 10:56:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1g9i0nyyg8imkPYn7Ev3KiyFaSNI5O3vmMoxV6z6Fg/9uJ+hgqfEpI/5bwwsjwkXLVzJt/GjhaEH3ZPM0quE=
X-Received: by 2002:a17:90a:ec86:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-2fa24064f1dmr7498716a91.12.1738954590010; Fri, 07 Feb 2025
 10:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20250205123550.2754387-1-berrange@redhat.com>
 <20250205123550.2754387-5-berrange@redhat.com>
 <87wme2hsrn.fsf@pond.sub.org>
In-Reply-To: <87wme2hsrn.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Feb 2025 13:56:18 -0500
X-Gm-Features: AWEUYZl3P2kPRE49SdVB249pgoBqL6hrG0SEY_1kioi0ZwAU5DHy5o4_gr2Il9Q
Message-ID: <CAFn=p-aSdesaSxb3pTFD54qnJJ5y0MHnS16eevcU7L+ReqZwyA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] qapi: expose all schema features to code
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009e57e8062d91ea25"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009e57e8062d91ea25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025, 6:57=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > This replaces use of the constants from the QapiSpecialFeatures
> > enum, with constants from the auto-generate QapiFeatures enum
> > in qapi-features.h
> >
> > The 'deprecated' and 'unstable' features still have a little bit of
> > special handling, being force defined to be the 1st + 2nd features
> > in the enum, regardless of whether they're used in the schema. This
> > retains compatibility with common code that references the features
> > via the QapiSpecialFeatures constants.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Daniel, feel free to ignore this at least for now.  I'm trying to learn
> some typing lore from John.
>
> v3 made mypy unhappy.  I asked John for advice, and also posted a
> solution involving ValuesView I hacked up myself.  Daniel took it for
> v4.
>
> John suggested to use List.
>
> I now wonder whether could use Iterable.
>
> I'll show the three solutions inline.
>
> John, thoughts?
>

ValuesView works just fine. It accurately describes what that function
returns. I only avoided it in my fixup because it's a more obscure type and
generally list is easier to work with as a first-class built in primitive
type to the language.

(read as: I didn't have to consult any docs to fix it up using List and I'm
lazy.)

Your solution describes precisely the type being returned (always good) and
avoids any re-copying of data.

Do be aware by caching the values view object in another object that you
are keeping a "live reference" to the list of dict values that I think can
change if the source dict changes. I doubt it matters, but you should know
about that.

The only design consideration you have now is what type you actually want
to return and why. I think it barely matters, and I'm always going to opt
for whatever is the least annoying for the patch author so I don't have to
bore/torture them with python minutiae.

As long as the tests pass (my first three patches in the dan-fixup branch I
posted based on v3) I'm more than content.


> [...]
>
> > diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> > new file mode 100644
> > index 0000000000..be3e5d03ff
> > --- /dev/null
> > +++ b/scripts/qapi/features.py
> > @@ -0,0 +1,51 @@
> > +"""
> > +QAPI features generator
> > +
> > +Copyright 2024 Red Hat
> > +
> > +This work is licensed under the terms of the GNU GPL, version 2.
> > +# See the COPYING file in the top-level directory.
> > +"""
> > +
> > +from typing import Dict, ValuesView
> > +
> > +from .common import c_enum_const, c_name
> > +from .gen import QAPISchemaMonolithicCVisitor
> > +from .schema import (
> > +    QAPISchema,
> > +    QAPISchemaFeature,
> > +)
> > +
> > +
> > +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
> > +
> > +    def __init__(self, prefix: str):
> > +        super().__init__(
> > +            prefix, 'qapi-features',
> > +            ' * Schema-defined QAPI features',
> > +            __doc__)
> > +
> > +        self.features: ValuesView[QAPISchemaFeature]
>
> This is the ValuesView solution.
>
> The List solution:
>
>            self.features: List[QAPISchemaFeature] =3D []
>
> The Iterable solution:
>
>            self.features: Iterable[QAPISchemaFeature]
>
> [...]
>
>
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index e97c978d38..7f70969c09 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
>
> [...]
>
> > @@ -1147,6 +1161,9 @@ def __init__(self, fname: str):
> >          self._def_exprs(exprs)
> >          self.check()
> >
> > +    def features(self) -> ValuesView[QAPISchemaFeature]:
> > +        return self._feature_dict.values()
>
> This is the ValuesView solution.
>
> The List solution:
>
>        def features(self) -> List[QAPISchemaFeature]:
>            return list(self._feature_dict.values())
>
> The Iterable solution:
>
>        def features(self) -> Iterable[QAPISchemaFeature]:
>            return self._feature_dict.values()
>
>
> > +
> >      def _def_entity(self, ent: QAPISchemaEntity) -> None:
> >          self._entity_list.append(ent)
> >
>
> [...]
>
>

--0000000000009e57e8062d91ea25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2025, 6:57=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Daniel P. Be=
rrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">berrange@redhat.com</a>&gt; writes:<br>
<br>
&gt; This replaces use of the constants from the QapiSpecialFeatures<br>
&gt; enum, with constants from the auto-generate QapiFeatures enum<br>
&gt; in qapi-features.h<br>
&gt;<br>
&gt; The &#39;deprecated&#39; and &#39;unstable&#39; features still have a =
little bit of<br>
&gt; special handling, being force defined to be the 1st + 2nd features<br>
&gt; in the enum, regardless of whether they&#39;re used in the schema. Thi=
s<br>
&gt; retains compatibility with common code that references the features<br=
>
&gt; via the QapiSpecialFeatures constants.<br>
&gt;<br>
&gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt=
;<br>
<br>
Daniel, feel free to ignore this at least for now.=C2=A0 I&#39;m trying to =
learn<br>
some typing lore from John.<br>
<br>
v3 made mypy unhappy.=C2=A0 I asked John for advice, and also posted a<br>
solution involving ValuesView I hacked up myself.=C2=A0 Daniel took it for<=
br>
v4.<br>
<br>
John suggested to use List.<br>
<br>
I now wonder whether could use Iterable.<br>
<br>
I&#39;ll show the three solutions inline.<br>
<br>
John, thoughts?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">ValuesView works just fine. It accurately describes what tha=
t function returns. I only avoided it in my fixup because it&#39;s a more o=
bscure type and generally list is easier to work with as a first-class buil=
t in primitive type to the language.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">(read as: I didn&#39;t have to consult any docs to fix it up u=
sing List and I&#39;m lazy.)</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Your solution describes precisely the type being returned (always good=
) and avoids any re-copying of data.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Do be aware by caching the values view object in another objec=
t that you are keeping a &quot;live reference&quot; to the list of dict val=
ues that I think can change if the source dict changes. I doubt it matters,=
 but you should know about that.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">The only design consideration you have now is what type you actua=
lly want to return and why. I think it barely matters, and I&#39;m always g=
oing to opt for whatever is the least annoying for the patch author so I do=
n&#39;t have to bore/torture them with python minutiae.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">As long as the tests pass (my first three p=
atches in the dan-fixup branch I posted based on v3) I&#39;m more than cont=
ent.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
[...]<br>
<br>
&gt; diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..be3e5d03ff<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/qapi/features.py<br>
&gt; @@ -0,0 +1,51 @@<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +QAPI features generator<br>
&gt; +<br>
&gt; +Copyright 2024 Red Hat<br>
&gt; +<br>
&gt; +This work is licensed under the terms of the GNU GPL, version 2.<br>
&gt; +# See the COPYING file in the top-level directory.<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +from typing import Dict, ValuesView<br>
&gt; +<br>
&gt; +from .common import c_enum_const, c_name<br>
&gt; +from .gen import QAPISchemaMonolithicCVisitor<br>
&gt; +from .schema import (<br>
&gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaFeature,<br>
&gt; +)<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, prefix: str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix, &#39;qapi-features&=
#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; * Schema-defined QAPI=
 features&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __doc__)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features: ValuesView[QAPISchemaFeatu=
re]<br>
<br>
This is the ValuesView solution.<br>
<br>
The List solution:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.features: List[QAPISchemaFeat=
ure] =3D []<br>
<br>
The Iterable solution:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.features: Iterable[QAPISchema=
Feature]<br>
<br>
[...]<br>
<br>
<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index e97c978d38..7f70969c09 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
<br>
[...]<br>
<br>
&gt; @@ -1147,6 +1161,9 @@ def __init__(self, fname: str):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_exprs(exprs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def features(self) -&gt; ValuesView[QAPISchemaFeature]:=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._feature_dict.values()<br>
<br>
This is the ValuesView solution.<br>
<br>
The List solution:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0def features(self) -&gt; List[QAPISchemaFeature]=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return list(self._feature_dict.val=
ues())<br>
<br>
The Iterable solution:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0def features(self) -&gt; Iterable[QAPISchemaFeat=
ure]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._feature_dict.values()=
<br>
<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def _def_entity(self, ent: QAPISchemaEntity) -&gt;=
 None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list.append(ent)<br>
&gt;=C2=A0 <br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000009e57e8062d91ea25--


