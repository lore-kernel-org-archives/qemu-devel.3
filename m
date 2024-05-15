Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E49C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HCM-0006bn-Eq; Wed, 15 May 2024 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7HCK-0006bV-0o
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7HCH-00027C-IM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715789380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5dlTQVEgjgH3SgYSYtyIs4rvW0zOOp0CYy+ezjrwo4=;
 b=DAY/i5Lv+pCtGtPQ5hz8x4+rtbDs9rQJV3C6gtE701np4mzOLR1Le4k+auYK8SBdwNBu4x
 QdGE2O6ud8gEqv+FWQyazHC60pOVSo4ndNKSlbc2yIhNtH698gA4HLL7c4bSNbGdelnQXV
 u5/RbV5ssjTzeXc+O8rMmWs6IK+CAsw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-oUTWwp4BPkOB_v7LgWjJaA-1; Wed, 15 May 2024 12:09:38 -0400
X-MC-Unique: oUTWwp4BPkOB_v7LgWjJaA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-351bd229b88so2287514f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715789377; x=1716394177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5dlTQVEgjgH3SgYSYtyIs4rvW0zOOp0CYy+ezjrwo4=;
 b=HK9x1ek5ZdX1eEP+vEi2W0eEJ/ox7v3rKy6kRfFlYNbpD8P2shsX0kZXoKy8ZRpcVq
 SKA3ZRenjQt7OCsEb8vlqkbb01dwnGGaUBW0I3FqqjZGjXmTPsuwphdXKcrv7POXcUj9
 HPdmguxPLh/LB9qSzS5lL1Ht1rs1MrV1rZjpkOc8nqTfaJZ7abHbSLBQ3bzuB12/ZSI3
 hH2sYEQayqbT0AJz/YEoaFKnMRF8v066uyn6AxvlUjbPf7tG6iDKnj0CGTXuuB1rwY0z
 cIjYhJBxfZaXpmeSXmb+n4QBu+3qxoKIYS0Rl8v5sSKBUez7SjgzS5RdVn9JKxSEkprJ
 k2fA==
X-Gm-Message-State: AOJu0YwGSV/SmcbcW1BZ5LUGhzqY7qxnHO34abAJrQ0KE6XPU/8SqplV
 LfTDBaaUE0FIOCIBLSBZJ9FeuuWfl5HMojDOpQzQZt2CmrTEOG5n4AiO67XzLnlBk3ovxwliSLH
 26sUbnnKoTgEz+Vyamo0bQ/0I4hMwkEWsXTunyOYC8/yMgVx6rMzR8a1jSPtq9AvGX5UG6VbHDP
 BcV7DEMAlEpGceUOPWNzxHU0bVrxo=
X-Received: by 2002:adf:b30d:0:b0:351:ce05:7a30 with SMTP id
 ffacd0b85a97d-351ce057b71mr2026913f8f.52.1715789377742; 
 Wed, 15 May 2024 09:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv5nsxB3CuSN2Zs4+1n5matmMmE/0z6kociWYOYr+Ag+4Azktamv5T3Cf3SkG0LwZcwiQDn3tszneAB5rkMH8=
X-Received: by 2002:adf:b30d:0:b0:351:ce05:7a30 with SMTP id
 ffacd0b85a97d-351ce057b71mr2026870f8f.52.1715789377349; Wed, 15 May 2024
 09:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-4-jsnow@redhat.com>
 <87h6ezwi2j.fsf@pond.sub.org>
In-Reply-To: <87h6ezwi2j.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 May 2024 12:09:22 -0400
Message-ID: <CAFn=p-aO=g18OQGQWbg+=23n-dRiXrQPEFk52i1-=nczqeLEPA@mail.gmail.com>
Subject: Re: [PATCH 03/20] docs/qapidoc: delint a tiny portion of the module
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058c089061880588f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000058c089061880588f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:17=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > In the coming patches, it's helpful to have a linting baseline. However=
,
> > there's no need to shuffle around the deck chairs too much, because mos=
t
> > of this code will be removed once the new qapidoc generator (the
> > "transmogrifier") is in place.
> >
> > To ease my pain: just turn off the black auto-formatter for most, but
> > not all, of qapidoc.py. This will help ensure that *new* code follows a
> > coding standard without bothering too much with cleaning up the existin=
g
> > code.
> >
> > For manual checking for now, try "black --check qapidoc.py" from the
> > docs/sphinx directory. "pip install black" (without root permissions) i=
f
> > you do not have it installed otherwise.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index f270b494f01..1655682d4c7 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -28,28 +28,30 @@
> >  import re
> >
> >  from docutils import nodes
> > +from docutils.parsers.rst import Directive, directives
> >  from docutils.statemachine import ViewList
> > -from docutils.parsers.rst import directives, Directive
> > -from sphinx.errors import ExtensionError
> > -from sphinx.util.nodes import nested_parse_with_titles
> > -import sphinx
> > -from qapi.gen import QAPISchemaVisitor
> >  from qapi.error import QAPIError, QAPISemError
> > +from qapi.gen import QAPISchemaVisitor
> >  from qapi.schema import QAPISchema
> >
> > +import sphinx
> > +from sphinx.errors import ExtensionError
> > +from sphinx.util.nodes import nested_parse_with_titles
> > +
>
> Exchanges old pylint gripe
>
>     docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphinx are
> not grouped (ungrouped-imports)
>
> for new gripes
>
>     docs/sphinx/qapidoc.py:37:0: C0411: third party import "import sphinx=
"
> should be placed before "from qapi.error import QAPIError, QAPISemError"
> (wrong-import-order)
>     docs/sphinx/qapidoc.py:38:0: C0411: third party import "from
> sphinx.errors import ExtensionError" should be placed before "from
> qapi.error import QAPIError, QAPISemError" (wrong-import-order)
>     docs/sphinx/qapidoc.py:39:0: C0411: third party import "from
> sphinx.util.nodes import nested_parse_with_titles" should be placed befor=
e
> "from qapi.error import QAPIError, QAPISemError" (wrong-import-order)
>
> Easy enough to fix.
>

I believe these errors are caused by the fact that the tools are confused
about the "sphinx" namespace - some interpret them as being the local
"module", the docs/sphinx/ directory, and others believe them to be the
third party external package.

I have not been using pylint on docs/sphinx/ files because of the
difficulty of managing imports - this environment is generally beyond the
reaches of my python borgcube and at present I don't have plans to
integrate it.

At the moment, I am using black, isort and flake8 for qapidoc.py and
they're happy with it. I am not using mypy because I never did the typing
boogaloo with qapidoc.py and I won't be bothering - except for any new code
I write, which *will* bother. By the end of the new transmogrifier,
qapidoc.py *will* strictly typecheck.

pylint may prove to be an issue with the imports, though. isort also seems
to misunderstand "sphinx, the stuff in this folder" and "sphinx, the stuff
in a third party package" and so I'm afraid I don't have any good ability
to get pylint to play along, here.

Pleading for "Sorry, this sucks and I can't figure out how to solve it
quickly". Maybe a future project, apologies.


> >
> >  # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
> >  # use switch_source_input. Check borrowed from kerneldoc.py.
> > -Use_SSI =3D sphinx.__version__[:3] >=3D '1.7'
> > +Use_SSI =3D sphinx.__version__[:3] >=3D "1.7"
> >  if Use_SSI:
> >      from sphinx.util.docutils import switch_source_input
> >  else:
> >      from sphinx.ext.autodoc import AutodocReporter
> >
> >
> > -__version__ =3D '1.0'
> > +__version__ =3D "1.0"
> >
> >
> > +# fmt: off
>
> I figure this tells black to keep quiet for the remainder of the file.
> Worth a comment, I think.
>
> >  # Function borrowed from pydash, which is under the MIT license
> >  def intersperse(iterable, separator):
> >      """Yield the members of *iterable* interspersed with *separator*."=
""
>
> With my comments addressed
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

^ Dropping this unless you're okay with the weird import orders owing to
the strange import paradigm in the sphinx folder.r

--00000000000058c089061880588f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 15, 2024 at 5:17=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; In the coming patches, it&#39;s helpful to have a linting baseline. Ho=
wever,<br>
&gt; there&#39;s no need to shuffle around the deck chairs too much, becaus=
e most<br>
&gt; of this code will be removed once the new qapidoc generator (the<br>
&gt; &quot;transmogrifier&quot;) is in place.<br>
&gt;<br>
&gt; To ease my pain: just turn off the black auto-formatter for most, but<=
br>
&gt; not all, of qapidoc.py. This will help ensure that *new* code follows =
a<br>
&gt; coding standard without bothering too much with cleaning up the existi=
ng<br>
&gt; code.<br>
&gt;<br>
&gt; For manual checking for now, try &quot;black --check qapidoc.py&quot; =
from the<br>
&gt; docs/sphinx directory. &quot;pip install black&quot; (without root per=
missions) if<br>
&gt; you do not have it installed otherwise.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 16 +++++++++-------<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index f270b494f01..1655682d4c7 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -28,28 +28,30 @@<br>
&gt;=C2=A0 import re<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from docutils import nodes<br>
&gt; +from docutils.parsers.rst import Directive, directives<br>
&gt;=C2=A0 from docutils.statemachine import ViewList<br>
&gt; -from docutils.parsers.rst import directives, Directive<br>
&gt; -from sphinx.errors import ExtensionError<br>
&gt; -from sphinx.util.nodes import nested_parse_with_titles<br>
&gt; -import sphinx<br>
&gt; -from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt; +from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.schema import QAPISchema<br>
&gt;=C2=A0 <br>
&gt; +import sphinx<br>
&gt; +from sphinx.errors import ExtensionError<br>
&gt; +from sphinx.util.nodes import nested_parse_with_titles<br>
&gt; +<br>
<br>
Exchanges old pylint gripe<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:45:4: C0412: Imports from package sphi=
nx are not grouped (ungrouped-imports)<br>
<br>
for new gripes<br>
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:37:0: C0411: third party import &quot;=
import sphinx&quot; should be placed before &quot;from qapi.error import QA=
PIError, QAPISemError&quot; (wrong-import-order)<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:38:0: C0411: third party import &quot;=
from sphinx.errors import ExtensionError&quot; should be placed before &quo=
t;from qapi.error import QAPIError, QAPISemError&quot; (wrong-import-order)=
<br>
=C2=A0 =C2=A0 docs/sphinx/qapidoc.py:39:0: C0411: third party import &quot;=
from sphinx.util.nodes import nested_parse_with_titles&quot; should be plac=
ed before &quot;from qapi.error import QAPIError, QAPISemError&quot; (wrong=
-import-order)<br>
<br>
Easy enough to fix.<br></blockquote><div><br></div><div>I believe these err=
ors are caused by the fact that the tools are confused about the &quot;sphi=
nx&quot; namespace - some interpret them as being the local &quot;module&qu=
ot;, the docs/sphinx/ directory, and others believe them to be the third pa=
rty external package.</div><div><br></div><div>I have not been using pylint=
 on docs/sphinx/ files because of the difficulty of managing imports - this=
 environment is generally beyond the reaches of my python borgcube and at p=
resent I don&#39;t have plans to integrate it.</div><div><br></div><div>At =
the moment, I am using black, isort and flake8 for qapidoc.py and they&#39;=
re happy with it. I am not using mypy because I never did the typing boogal=
oo with qapidoc.py and I won&#39;t be bothering - except for any new code I=
 write, which *will* bother. By the end of the new transmogrifier, qapidoc.=
py *will* strictly typecheck.</div><div><br></div><div>pylint may prove to =
be an issue with the imports, though. isort also seems to misunderstand &qu=
ot;sphinx, the stuff in this folder&quot; and &quot;sphinx, the stuff in a =
third party package&quot; and so I&#39;m afraid I don&#39;t have any good a=
bility to get pylint to play along, here.</div><div><br></div><div>Pleading=
 for &quot;Sorry, this sucks and I can&#39;t figure out how to solve it qui=
ckly&quot;. Maybe a future project, apologies.<br></div><div><br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later<br>
&gt;=C2=A0 # use switch_source_input. Check borrowed from kerneldoc.py.<br>
&gt; -Use_SSI =3D sphinx.__version__[:3] &gt;=3D &#39;1.7&#39;<br>
&gt; +Use_SSI =3D sphinx.__version__[:3] &gt;=3D &quot;1.7&quot;<br>
&gt;=C2=A0 if Use_SSI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.docutils import switch_source_inp=
ut<br>
&gt;=C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.ext.autodoc import AutodocReporter<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -__version__ =3D &#39;1.0&#39;<br>
&gt; +__version__ =3D &quot;1.0&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; +# fmt: off<br>
<br>
I figure this tells black to keep quiet for the remainder of the file.<br>
Worth a comment, I think.<br>
<br>
&gt;=C2=A0 # Function borrowed from pydash, which is under the MIT license<=
br>
&gt;=C2=A0 def intersperse(iterable, separator):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Yield the members of *iterable* =
interspersed with *separator*.&quot;&quot;&quot;<br>
<br>
With my comments addressed<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><di=
v>^ Dropping this unless you&#39;re okay with the weird import orders owing=
 to the strange import paradigm in the sphinx folder.r</div></div></div>

--00000000000058c089061880588f--


