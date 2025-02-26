Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJKo-0007G3-3f; Wed, 26 Feb 2025 10:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnJKk-00078J-63
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnJKi-0001JN-7q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740583703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDSjAhNaEsPGsqfQodHWYIawfSPuR86AL2HuAi0cgdE=;
 b=UtlTMn2RwOyMJBbGXnqHsdyOcktQKZk/PD9Z9ktfnTgXCP20YXsxCdBWQ/t/90JoEDEdX+
 /tJT4bLyHFLG+uXE1Z3ewis+f/bJACqDoZlxW7+Thop1Ae1dxeyCcGbCxtCR5wfpY+pGxT
 RPFzHJMtS4YBBdklBlKWyK5d8s+qpfg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-TjGTvDJWPHmHvObynfgoDQ-1; Wed, 26 Feb 2025 10:28:21 -0500
X-MC-Unique: TjGTvDJWPHmHvObynfgoDQ-1
X-Mimecast-MFC-AGG-ID: TjGTvDJWPHmHvObynfgoDQ_1740583700
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe8de1297eso940869a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583700; x=1741188500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDSjAhNaEsPGsqfQodHWYIawfSPuR86AL2HuAi0cgdE=;
 b=I5fitHMTwfzST8pvAT2chcGKzh2AtXgUlYImsTPzxI3DxQoraaplTKNV27qOjLoSP9
 JBt0wXhg3stIBvpAvNZhTcLQm6Ofg7ZXrazFm4u+GSnB168ro8R8Shdf1Nm/KpTEwKIy
 AEzMzteqizdRXTpDG2pas32vcG8ayIA9RXKdQie6DylIbstg60le20LHRmCHhiqSEuSN
 BpvK6BUUnI5aXdH43gOCHsTeBMhk5Lc/aWdMmOaj23cC6Nge+ErHp+PBdSUtNQL4wCsa
 S0Xv5YsZ4ADSYLzBYGxXYTsqh6KwafJKZcirm3NHRi2VlIv45UzrYebnNK/AcdJupws6
 8e2w==
X-Gm-Message-State: AOJu0Yz++R7OI9UnX1l5NovwJfUlDNtLdtgGAd/U4eogQWPiJsu8aYAI
 f/txIvaWON1ah7mCV2dpasoouLBU8bTkjgwjsW6HjzYSu/dcPOnyosqNPQgz29gVnhBYSu/nt/8
 7CY1MgsUZUMyZdG71vl0+ufkzl4yEj5t+77h2xNJGwqNpKPEJbqqittcc2iO8MFGG7nVf0zwSzi
 ncq0hh2NixVnX9eYCmBO1aYnTBbGQ=
X-Gm-Gg: ASbGncsw8sA/Pdsvynw5MVLyVPsCowZ0N1K6QzivGm9F+eQ6qyw5rIggWI4Gf0yMw5X
 g724PISeiY/dJ4Z0AuJmase7UR/YkSw6XPbRbx3fn6CL62uX3O7vV5pP8OrAVVdmfb2fPXSPoM4
 P1j7NhZycZqI/ERL1rMugawaLV11P0
X-Received: by 2002:a17:90b:350e:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-2fccc1172demr42941987a91.6.1740583700158; 
 Wed, 26 Feb 2025 07:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEalUdWFYUf2a2wQS/VHLaTbKuxRcYYxPB4+NvEKrnBERm/4Zcv6buB349hKI9jasWKtBVjlFRn043CvG1u+kw=
X-Received: by 2002:a17:90b:350e:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-2fccc1172demr42941950a91.6.1740583699794; Wed, 26 Feb 2025
 07:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-5-jsnow@redhat.com>
 <87frk3fr45.fsf@pond.sub.org> <87wmdd11zd.fsf@pond.sub.org>
In-Reply-To: <87wmdd11zd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Feb 2025 10:28:07 -0500
X-Gm-Features: AWEUYZnWdoB3HmNDg79FIHVms-B4OhmFVERKqSvViwh8nND-kOt81dA3FJdp4Yw
Message-ID: <CAFn=p-bGAXKZhJ8x39JC3p5NwYmG5+DwF5bF0ObuMJa+0sFdyQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] docs/qapidoc: support header-less freeform sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002117ad062f0d39ca"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

--0000000000002117ad062f0d39ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025, 4:37=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Markus Armbruster <armbru@redhat.com> writes:
>
> > John Snow <jsnow@redhat.com> writes:
> >
> >> The code as written crashes when a free-form documentation block doesn=
't
> >> start with a heading or subheading, for example:
> >>
> >> | ##
> >> | # Just text, no heading.
> >> | ##
> >>
> >> The code will attempt to use the `node` variable uninitialized. To fix=
,
> >> create a generic block to insert the doc text into.
> >>
> >> (This patch also removes a lingering pylint warning in the QAPIDoc
> >> implementation that prevents getting a clean baseline to use for
> >> forthcoming additions.)
> >>
> >> Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freefor=
m
> QMP sections)
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  docs/sphinx/qapidoc.py | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> index 5f96b46270b..5a4d7388b29 100644
> >> --- a/docs/sphinx/qapidoc.py
> >> +++ b/docs/sphinx/qapidoc.py
> >> @@ -421,6 +421,8 @@ def freeform(self, doc):
> >>              node =3D self._start_new_heading(heading, len(leader))
> >>              if text =3D=3D '':
> >>                  return
> >> +        else:
> >> +            node =3D nodes.container()
> >>
> >>          self._parse_text_into_node(text, node)
> >>          self._cur_doc =3D None
> >
> > Let's add a suitable free-form block to tests/qapi-schema/doc-good.json
> > to catch regressions.  Not worth a respin by itself.
>
> With the appended obvious fixup:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>
> diff --git a/tests/qapi-schema/doc-good.json
> b/tests/qapi-schema/doc-good.json
> index f64bf38d85..0a4f139f83 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -11,6 +11,10 @@
>  # =3D Section
>  ##
>
> +##
> +# Just text, no heading.
> +##
> +
>  ##
>  # =3D=3D Subsection
>  #
> diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> index ec277be91e..0a9da3efde 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -56,6 +56,9 @@ event EVT_BOXED Object
>  doc freeform
>      body=3D
>  =3D Section
> +doc freeform
> +    body=3D
> +Just text, no heading.
>  doc freeform
>      body=3D
>  =3D=3D Subsection
>

Sold!

>

--0000000000002117ad062f0d39ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2025, 4:37=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Markus Armbr=
uster &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"nor=
eferrer">armbru@redhat.com</a>&gt; writes:<br>
<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; The code as written crashes when a free-form documentation block d=
oesn&#39;t<br>
&gt;&gt; start with a heading or subheading, for example:<br>
&gt;&gt;<br>
&gt;&gt; | ##<br>
&gt;&gt; | # Just text, no heading.<br>
&gt;&gt; | ##<br>
&gt;&gt;<br>
&gt;&gt; The code will attempt to use the `node` variable uninitialized. To=
 fix,<br>
&gt;&gt; create a generic block to insert the doc text into.<br>
&gt;&gt;<br>
&gt;&gt; (This patch also removes a lingering pylint warning in the QAPIDoc=
<br>
&gt;&gt; implementation that prevents getting a clean baseline to use for<b=
r>
&gt;&gt; forthcoming additions.)<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after fre=
eform QMP sections)<br>
&gt;&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 docs/sphinx/qapidoc.py | 2 ++<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt;&gt; index 5f96b46270b..5a4d7388b29 100644<br>
&gt;&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; @@ -421,6 +421,8 @@ def freeform(self, doc):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D self._sta=
rt_new_heading(heading, len(leader))<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if text =3D=3D &#3=
9;&#39;:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D nodes.containe=
r()<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_text_into_node(text,=
 node)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cur_doc =3D None<br>
&gt;<br>
&gt; Let&#39;s add a suitable free-form block to tests/qapi-schema/doc-good=
.json<br>
&gt; to catch regressions.=C2=A0 Not worth a respin by itself.<br>
<br>
With the appended obvious fixup:<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
<br>
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son<br>
index f64bf38d85..0a4f139f83 100644<br>
--- a/tests/qapi-schema/doc-good.json<br>
+++ b/tests/qapi-schema/doc-good.json<br>
@@ -11,6 +11,10 @@<br>
=C2=A0# =3D Section<br>
=C2=A0##<br>
<br>
+##<br>
+# Just text, no heading.<br>
+##<br>
+<br>
=C2=A0##<br>
=C2=A0# =3D=3D Subsection<br>
=C2=A0#<br>
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t<br>
index ec277be91e..0a9da3efde 100644<br>
--- a/tests/qapi-schema/doc-good.out<br>
+++ b/tests/qapi-schema/doc-good.out<br>
@@ -56,6 +56,9 @@ event EVT_BOXED Object<br>
=C2=A0doc freeform<br>
=C2=A0 =C2=A0 =C2=A0body=3D<br>
=C2=A0=3D Section<br>
+doc freeform<br>
+=C2=A0 =C2=A0 body=3D<br>
+Just text, no heading.<br>
=C2=A0doc freeform<br>
=C2=A0 =C2=A0 =C2=A0body=3D<br>
=C2=A0=3D=3D Subsection<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Sold!</div><div dir=3D"auto"><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div=
></div></div>

--0000000000002117ad062f0d39ca--


