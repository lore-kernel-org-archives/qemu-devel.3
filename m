Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECD6C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqp9J-0001KI-UR; Sat, 08 Mar 2025 03:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqp9H-0001Fy-OY
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqp9F-0004bK-NH
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741420984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpg66SEM2E/5jcsubxhmj66iyOo1qmzyiqhE7YYWTsM=;
 b=HJlqIgx8Tgi/+XU2c9GWkaGQhPRrjP05e75ezuPSc6fY34aHC3HUE2RzQNmPqm1J5qVUpm
 7qze1r+ladX2nhn5QY4uRXOpmoWGO8BbXrdCoAXmpYpux4FoUnV1wJwjFW4jLjX5WkUVrc
 iU1bzjJQIIYBC/HLCZKng4xrHRbQYw0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-THKPeQGKOgGEwrsf_kiziQ-1; Sat, 08 Mar 2025 03:02:59 -0500
X-MC-Unique: THKPeQGKOgGEwrsf_kiziQ-1
X-Mimecast-MFC-AGG-ID: THKPeQGKOgGEwrsf_kiziQ_1741420978
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22107b29ac3so39283175ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741420978; x=1742025778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bpg66SEM2E/5jcsubxhmj66iyOo1qmzyiqhE7YYWTsM=;
 b=Gmm6VBd4GLzNSHiPZuw5gz4zUX3sDO6D1Tzox2o5v6tHFqNdQ0EiarzuEefhfpYzvN
 RLWyxL1Zi01UdlRjoN/tsWIA76Xa60fSo7VvzqCg9gtrrckNch35rAt4upiCx3RQGwhq
 dcb5uw7DM9k5N6kaubZG1YVoskOR5Jpz7pDle9ZjOnJXwdr1or94vP25nd1Hv/Uu8wyI
 ZVsJ0d3BubiyRE+0ytLYIm+m5QeuWz3v7MIdxlMo75tlyyhwpnc+lZcbv6N1Lxj4n89d
 u9EoAZQcta5B4VN451HwGeR5yVQ0hRWKgkKvSe5eUYaJ6PVeuxW9BQvAfrKa6tmFjxCD
 92Zw==
X-Gm-Message-State: AOJu0YxDFu2cpAHvgjKMJNKVAIUlDtbIHdbIHeS/Jd9Tu6nIRxSdbLWP
 7A2Osph2giBTGiGVcecOeeBi+sM+jiy53BXjwxwVCn8Pkb87tJuTV2yWuPIHupmfAJ6sEzaABOK
 wVTvYWzqfwi3WnohSD6AYnArLlhD0JzEU5qxxjmvtt+AYvkIn3sR4lgBYk2Xwwd9SnGFLQ8XKBR
 OoPp+t+PGst/9j+6hs4fVUh7aX49M=
X-Gm-Gg: ASbGnctDHg2ZYvfc7cKbvV2ehkR6Rqw3dgxQULl7YgVy2gijwMzxckZ1eUdG8pWYh34
 JDlmyvN/wvP+UuiO9WlPTDNg1J/SAwGLr/p1bu7XJWIjaOa7JmEkmyJUjJ3Obh0lwoWq7wg==
X-Received: by 2002:a17:903:1d0:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2246456801bmr33045425ad.26.1741420978002; 
 Sat, 08 Mar 2025 00:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVdG1v1ihcpp4lBK3f53DjOoIUvdP25YtbwyQpQScG+PsIbMHFcfuzPeLW1At+ZQh7/t4n1FmUL3ioWKImrP8=
X-Received: by 2002:a17:903:1d0:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2246456801bmr33045115ad.26.1741420977625; Sat, 08 Mar 2025
 00:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-41-jsnow@redhat.com>
 <8734fpkpna.fsf@pond.sub.org>
In-Reply-To: <8734fpkpna.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:02:46 -0500
X-Gm-Features: AQ5f1JqIxr0BLPcGqiqlLG3owIYj2yJ56ngpmoOZe3KWxpiZz3R3vCfi6QGxXVk
Message-ID: <CAFn=p-ZB9WP90KiH401Jo5VaY8S6WLSuXYkheGmB5ZNPxF8wxA@mail.gmail.com>
Subject: Re: [PATCH 40/57] docs/qapidoc: add visit_freeform() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c6be6a062fd02aa8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000c6be6a062fd02aa8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:10=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 6de8c900543..cf5dbb0133d 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -29,6 +29,7 @@
> >  from contextlib import contextmanager
> >  import os
> >  from pathlib import Path
> > +import re
> >  import sys
> >  from typing import TYPE_CHECKING
> >
> > @@ -55,6 +56,8 @@
> >          Sequence,
> >      )
> >
> > +    from qapi.parser import QAPIDoc
> > +
> >      from sphinx.application import Sphinx
> >      from sphinx.util.typing import ExtensionMetadata
> >
> > @@ -130,6 +133,53 @@ def visit_module(self, path: str) -> None:
> >          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
> >          self.ensure_blank_line()
> >
> > +    def visit_freeform(self, doc: QAPIDoc) -> None:
> > +        # TODO: Once the old qapidoc transformer is deprecated, freefo=
rm
> > +        # sections can be updated to pure rST, and this transformed
> removed.
> > +        #
> > +        # For now, translate our micro-format into rST. Code adapted
> > +        # from Peter Maydell's freeform().
> > +
> > +        assert len(doc.all_sections) =3D=3D 1, doc.all_sections
> > +        body =3D doc.all_sections[0]
> > +        text =3D body.text
> > +        info =3D doc.info
> > +
> > +        if re.match(r"=3D+ ", text):
> > +            # Section/subsection heading (if present, will always be t=
he
> > +            # first line of the block)
> > +            (heading, _, text) =3D text.partition("\n")
> > +            (leader, _, heading) =3D heading.partition(" ")
>
>
>
> > +            level =3D len(leader) + 1  # Implicit +1 for heading in .r=
ST
> stub
>
> What is the ".rST stub"?
>

sorry, I meant the .rst document in-tree that invokes the qapidoc
directive. that document inherently has a title, so I treat everything in
the generated doc as a sub-heading of some kind.

(i.e., only one <h1>)


>
> > +
> > +            #
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#s=
ections
> > +            markers =3D {
> > +                1: "#",
> > +                2: "*",
> > +                3: "=3D",
> > +                4: "-",
> > +                5: "^",
> > +                6: '"',
> > +            }
>
> I'd be tempted to use markers =3D '#*=3D-^".  Matter of taste, yours take=
s
> precedence here.
>

Oh, yeah. I think I need a vacation from Python.


>
> > +            overline =3D level <=3D 2
> > +            marker =3D markers[level]
> > +
> > +            self.ensure_blank_line()
> > +            # This credits all 2 or 3 lines to the single source line.
> > +            if overline:
> > +                self.add_line(marker * len(heading), info)
> > +            self.add_line(heading, info)
> > +            self.add_line(marker * len(heading), info)
> > +            self.ensure_blank_line()
> > +
> > +            # Eat blank line(s) and advance info
> > +            trimmed =3D text.lstrip("\n")
> > +            text =3D trimmed
> > +            info =3D info.next_line(len(text) - len(trimmed) + 1)
> > +
> > +        self.add_lines(text, info)
> > +        self.ensure_blank_line()
> > +
> >
> >  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      """A QAPI schema visitor which adds Sphinx dependencies each modul=
e
>
>

--000000000000c6be6a062fd02aa8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:10=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 50 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 6de8c900543..cf5dbb0133d 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 from contextlib import contextmanager<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 from pathlib import Path<br>
&gt; +import re<br>
&gt;=C2=A0 import sys<br>
&gt;=C2=A0 from typing import TYPE_CHECKING<br>
&gt;=C2=A0 <br>
&gt; @@ -55,6 +56,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sequence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 from qapi.parser import QAPIDoc<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetadata<b=
r>
&gt;=C2=A0 <br>
&gt; @@ -130,6 +133,53 @@ def visit_module(self, path: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(f&quot;.. qapi:mod=
ule:: {name}&quot;, path, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_freeform(self, doc: QAPIDoc) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: Once the old qapidoc transformer =
is deprecated, freeform<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sections can be updated to pure rST, an=
d this transformed removed.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For now, translate our micro-format int=
o rST. Code adapted<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # from Peter Maydell&#39;s freeform().<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert len(doc.all_sections) =3D=3D 1, do=
c.all_sections<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 body =3D doc.all_sections[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D body.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D <a href=3D"http://doc.info" rel=
=3D"noreferrer" target=3D"_blank">doc.info</a><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match(r&quot;=3D+ &quot;, text):<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Section/subsection headin=
g (if present, will always be the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # first line of the block)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (heading, _, text) =3D text=
.partition(&quot;\n&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (leader, _, heading) =3D he=
ading.partition(&quot; &quot;)<br>
<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 level =3D len(leader) + 1=
=C2=A0 # Implicit +1 for heading in .rST stub<br>
<br>
What is the &quot;.rST stub&quot;?<br></blockquote><div><br></div><div>sorr=
y, I meant the .rst document in-tree that invokes the qapidoc directive. th=
at document inherently has a title, so I treat everything in the generated =
doc as a sub-heading of some kind.</div><div><br></div><div>(i.e., only one=
 &lt;h1&gt;)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://www.sp=
hinx-doc.org/en/master/usage/restructuredtext/basics.html#sections" rel=3D"=
noreferrer" target=3D"_blank">https://www.sphinx-doc.org/en/master/usage/re=
structuredtext/basics.html#sections</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 markers =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1: &quot;#&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2: &quot;*&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3: &quot;=3D&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4: &quot;-&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5: &quot;^&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6: &#39;&quot=
;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
I&#39;d be tempted to use markers =3D &#39;#*=3D-^&quot;.=C2=A0 Matter of t=
aste, yours takes<br>
precedence here.<br></blockquote><div><br></div><div>Oh, yeah. I think I ne=
ed a vacation from Python.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 overline =3D level &lt;=3D =
2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 marker =3D markers[level]<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This credits all 2 or 3 l=
ines to the single source line.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if overline:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
(marker * len(heading), info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(heading, info=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(marker * len(=
heading), info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Eat blank line(s) and adv=
ance info<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trimmed =3D text.lstrip(&qu=
ot;\n&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D trimmed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D info.next_line(len=
(text) - len(trimmed) + 1)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(text, info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;A QAPI schema visitor which adds=
 Sphinx dependencies each module<br>
<br>
</blockquote></div></div>

--000000000000c6be6a062fd02aa8--


