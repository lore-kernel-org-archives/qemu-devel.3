Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE0C28B25
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMM-00065B-7s; Fri, 07 Mar 2025 17:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgMK-00064L-5j
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgMH-0003MT-Qp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJtO1z6iWFrZN4uZkCH5WlotaGwpm2Pxxfa0pjhCUdA=;
 b=VbHVpkkMif0s/H6icUzBNLckaAcHXyzCaACBHEmvqyD9NzGtkJ3gTD4BJHsUGccFhWXB+n
 aSMwpHAFDmC9wyPr066VGm009lXUlLOuBsZ5VirP+YF9jaBClO+NZTTWcXWBeJGWStBHAr
 zO5c9zQq4oYIDn9Zx3q9Tfu33ZANBsw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qXlNs6FxOZGP4B70x29ZzQ-1; Fri, 07 Mar 2025 17:39:54 -0500
X-MC-Unique: qXlNs6FxOZGP4B70x29ZzQ-1
X-Mimecast-MFC-AGG-ID: qXlNs6FxOZGP4B70x29ZzQ_1741387193
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c93so2849139a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387193; x=1741991993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJtO1z6iWFrZN4uZkCH5WlotaGwpm2Pxxfa0pjhCUdA=;
 b=BT8I9HhDQLp9qGzUYwU096sPRaexwDvwazKOOQnSCn6fQ99/aBSwuo4Rli7hioFcxS
 +d4vJDwjyLbEczOeEqjYxSh7ZLkQyzW9OSYqMse0cbOJmOSfcaNltIVa8MTWSo+OxJSX
 NJDq1UEadMHlr7DhDGL+wHgMkxWLM0AWiqs8BDMhn8jPTywW4i/kmX7dNsAD8FUCF12y
 Pa6EdTB8kxM1yJoQ+SkIZBOq+BZYXPRWyEApWZjw3BHLCmIEBH9xLW0wWP74HVXbLy/N
 SpAckcYZkELvsU9VJWmdAEVOUP8lXllbaorIYeL3+Ui//VyLTHUU+ZAOpxYPQSOSw00p
 WLig==
X-Gm-Message-State: AOJu0YwLVid7z1DNOwevXFb3FKmNBXdrCaiKDRbrDGPFWDGf9HV/Xnwb
 vD9Y9pqs9usr77tOmP+TBa1FsNTmQ6cKAbJknPAUER8xfYif2XUZnJe5kMZtJxzMY8dWN4jsRr4
 waqQQCu1Cycp4y1pZ3I/LZ4wXE03U3C95fnydmol48FZvhsZOvN/RomtHHh+9VYcMS/XGOhaSeC
 dYTDJOnkL/L0qJTln+sjkP8LYI87I=
X-Gm-Gg: ASbGnctq38Is51U0J57fJPGrgruKeZE+7oTXxxSbuMnYQRB6SEufWc5ezVk4lFWLi9O
 /2FCRZZYYeBSWLO1gR5JMbrS7OM7mm1qoAIsNBPaRNJ5t+HRp4qu83r1vS/BH5k3irMdVdQ==
X-Received: by 2002:a17:90b:2883:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-2ff7cf29f70mr9322338a91.33.1741387193016; 
 Fri, 07 Mar 2025 14:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLFsehDE55kYBNqIxyIwe75Q0XMU4E4YmDqL2qaM1Ymca7+gz5zwWwuJw4toKtRccumM+IAW6Xf4tH4xM2Pi4=
X-Received: by 2002:a17:90b:2883:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-2ff7cf29f70mr9322319a91.33.1741387192735; Fri, 07 Mar 2025
 14:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-12-jsnow@redhat.com>
 <87ikols629.fsf@pond.sub.org>
In-Reply-To: <87ikols629.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 17:39:40 -0500
X-Gm-Features: AQ5f1JpKWypUZlx2CaSwyptXKk3guow1YjjY-iOTTY28xcD13zJxSKvfaieByCI
Message-ID: <CAFn=p-aXnOy0UBTpsNiorNJwn8DYDC3aVhijK1uYFtScWG5utw@mail.gmail.com>
Subject: Re: [PATCH 11/57] docs/qapi-domain: add qapi:command directive
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a3959062fc84da8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000000a3959062fc84da8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This commit adds a stubbed version of QAPICommand that utilizes the
> > QAPIObject class, the qapi:command directive, the :qapi:cmd:
> > cross-reference role, and the "command" object type in the QAPI object
> > registry.
> >
> > This commit also adds the aforementioned generic QAPIObject class for
> > use in documenting various QAPI entities in the Sphinx ecosystem.
> >
> > They don't do anything *particularly* interesting yet, but that will
> > come in forthcoming commits.
> >
> > Note: some versions of mypy get a little confused over the difference
> > between class and instance variables; because sphinx's ObjectDescriptio=
n
> > does not declare option_spec as a ClassVar (even though it's obvious
> > that it is), mypy may produce this error:
> >
> > qapi-domain.py:125: error: Cannot override instance variable (previousl=
y
> > declared on base class "ObjectDescription") with class variable [misc]
> >
> > I can't control that; so silence the error with a pragma.
>
> Is this still accurate?  qapi-domain.py line 125 is a comment.  I can't
> see the pragma.
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapi_domain.py | 146 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 144 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index 104bae709f3..6168c23936f 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -21,9 +21,10 @@
> >  from docutils import nodes
> >  from docutils.parsers.rst import directives
> >
> > -from compat import nested_parse
> > +from compat import KeywordNode, SpaceNode, nested_parse
> >  from sphinx import addnodes
> > -from sphinx.addnodes import pending_xref
> > +from sphinx.addnodes import desc_signature, pending_xref
> > +from sphinx.directives import ObjectDescription
> >  from sphinx.domains import (
> >      Domain,
> >      Index,
> > @@ -103,6 +104,144 @@ def process_link(
> >          return title, target
> >
> >
> > +# Alias for the return of handle_signature(), which is used in several
> places.
> > +# (In the Python domain, this is Tuple[str, str] instead.)
> > +Signature =3D str
> > +
> > +
> > +class QAPIObject(ObjectDescription[Signature]):
> > +    """
> > +    Description of a generic QAPI object.
> > +
> > +    It's not used directly, but is instead subclassed by specific
> directives.
> > +    """
> > +
> > +    # Inherit some standard options from Sphinx's ObjectDescription
> > +    option_spec: OptionSpec =3D (  # type:ignore[misc]
>

Originally, that pointed here.


> > +        ObjectDescription.option_spec.copy()
> > +    )
> > +    option_spec.update(
> > +        {
> > +            # Borrowed from the Python domain:
>
> This is line 125 mentioned above.
>

Slightly stale.


>
> > +            "module": directives.unchanged,  # Override contextual
> module name
> > +        }
> > +    )
>
> [...]
>
>

--0000000000000a3959062fc84da8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 1:34=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This commit adds a stubbed version of QAPICommand that utilizes the<br=
>
&gt; QAPIObject class, the qapi:command directive, the :qapi:cmd:<br>
&gt; cross-reference role, and the &quot;command&quot; object type in the Q=
API object<br>
&gt; registry.<br>
&gt;<br>
&gt; This commit also adds the aforementioned generic QAPIObject class for<=
br>
&gt; use in documenting various QAPI entities in the Sphinx ecosystem.<br>
&gt;<br>
&gt; They don&#39;t do anything *particularly* interesting yet, but that wi=
ll<br>
&gt; come in forthcoming commits.<br>
&gt;<br>
&gt; Note: some versions of mypy get a little confused over the difference<=
br>
&gt; between class and instance variables; because sphinx&#39;s ObjectDescr=
iption<br>
&gt; does not declare option_spec as a ClassVar (even though it&#39;s obvio=
us<br>
&gt; that it is), mypy may produce this error:<br>
&gt;<br>
&gt; qapi-domain.py:125: error: Cannot override instance variable (previous=
ly<br>
&gt; declared on base class &quot;ObjectDescription&quot;) with class varia=
ble [misc]<br>
&gt;<br>
&gt; I can&#39;t control that; so silence the error with a pragma.<br>
<br>
Is this still accurate?=C2=A0 qapi-domain.py line 125 is a comment.=C2=A0 I=
 can&#39;t<br>
see the pragma.<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py | 146 +++++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 1 file changed, 144 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index 104bae709f3..6168c23936f 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -21,9 +21,10 @@<br>
&gt;=C2=A0 from docutils import nodes<br>
&gt;=C2=A0 from docutils.parsers.rst import directives<br>
&gt;=C2=A0 <br>
&gt; -from compat import nested_parse<br>
&gt; +from compat import KeywordNode, SpaceNode, nested_parse<br>
&gt;=C2=A0 from sphinx import addnodes<br>
&gt; -from sphinx.addnodes import pending_xref<br>
&gt; +from sphinx.addnodes import desc_signature, pending_xref<br>
&gt; +from sphinx.directives import ObjectDescription<br>
&gt;=C2=A0 from sphinx.domains import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Domain,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Index,<br>
&gt; @@ -103,6 +104,144 @@ def process_link(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return title, target<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +# Alias for the return of handle_signature(), which is used in severa=
l places.<br>
&gt; +# (In the Python domain, this is Tuple[str, str] instead.)<br>
&gt; +Signature =3D str<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPIObject(ObjectDescription[Signature]):<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 Description of a generic QAPI object.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 It&#39;s not used directly, but is instead subclassed b=
y specific directives.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 # Inherit some standard options from Sphinx&#39;s Objec=
tDescription<br>
&gt; +=C2=A0 =C2=A0 option_spec: OptionSpec =3D (=C2=A0 # type:ignore[misc]=
<br></blockquote><div><br></div><div>Originally, that pointed here.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ObjectDescription.option_spec.copy()<br>
&gt; +=C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 option_spec.update(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Borrowed from the Python =
domain:<br>
<br>
This is line 125 mentioned above.<br></blockquote><div><br></div><div>Sligh=
tly stale.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&quot;: directi=
ves.unchanged,=C2=A0 # Override contextual module name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 )<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--0000000000000a3959062fc84da8--


