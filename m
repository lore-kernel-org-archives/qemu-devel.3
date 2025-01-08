Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C0E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVf0O-0005LJ-9I; Wed, 08 Jan 2025 17:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVf0N-0005Kx-5k
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVf0J-0005Fs-Lz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736377102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gopJHO5nyrC+MLbJ2j53PrZP+DxduyXn+bKJZ3/mvQ=;
 b=NwltSQfKSMWn6PjOhlxHbJymfd/AlfZiJQqlWvCsUh4EgLKSuhtUq124rZ6G6CVFb0vgZK
 jKPDbfqxkycOz4bkT4wenaLuJz/+CulWrB60I9Ndrdloc438wBIcfnSevyY4Lp374X9viy
 WB9tFMo8bDJCzctfQFHMjYJSVfMQz1M=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-IBOgHdXRMOqjSWQYOsm9Sw-1; Wed, 08 Jan 2025 17:58:16 -0500
X-MC-Unique: IBOgHdXRMOqjSWQYOsm9Sw-1
X-Mimecast-MFC-AGG-ID: IBOgHdXRMOqjSWQYOsm9Sw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2eeeb5b7022so556311a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736377096; x=1736981896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gopJHO5nyrC+MLbJ2j53PrZP+DxduyXn+bKJZ3/mvQ=;
 b=uypg+HT0yr9QHBtjywBSkPhvZi0267qDW0FanToq6MmWldUDbaaUQXMDKqeFZDPa6d
 FwhV1tsa0J+EUrriFhBJgI1kqI/B4Dr7wTkd/6k29pLElTLiocrFEhX7gpl8bcOh8eWx
 sS2nlsh6wBhAS+EAPIwqjfyrYzeAs+Tc2odKxpnbnnZ0BsnIsH1I8NPro1DKdEvQUjY6
 XCF5ETAUL+8tt22xBXEeVl/qC0SFMCfYx8MNWM6HLtrGiI9RWJmfyNEBNi6LbyU+fH2a
 36oL/S9sdcDw3dufyGyWzjn319y0oaCBVo0YzEU5CSLG1qNTGaYAjSY2pK/VRXtp3Qdr
 pScw==
X-Gm-Message-State: AOJu0Yztgc+Oy9QvbMtcbACDqHQLyPN3Gra4L9uu4PdYlq5VktrkPfwD
 +yf31J9IC+PJ+zszFdE83zQCTrX4Jg7JlCe/wGQDqwffSMVT/s0YCjQg/sxmtYsT0IK1HvBIH+u
 99hL3QgE9Pqw4kqICYNPAjS0s+z3JsvZX8Clk/qp+dpd/uS6b1VNwX8+WydHtMBjPS0rPrCK/vK
 oR8w6R+N+ra7nusX+4YMGQs+AkIfY=
X-Gm-Gg: ASbGncuBCEro6yYi518znY2rAaSxozGhb4yOqbg8PW5LpZjcyGw0iFh0YTBwPi26oUx
 OK+9iQm86khaGRldo66MGKsaLfX/tSjJmZQ8R3LaZBAoa7YrYMAwo0JErtcsoDitfTWrWTQ==
X-Received: by 2002:a17:90a:d004:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2f548e9a588mr6875313a91.5.1736377095373; 
 Wed, 08 Jan 2025 14:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh71xaZQfXh/f0Kt1bK0jcb5HLofcyKo3uVIeBbDrhx12skn/3j2c/jlBMPOvjPrcg/ELqgWvgOzjv/KYDH3s=
X-Received: by 2002:a17:90a:d004:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2f548e9a588mr6875295a91.5.1736377094952; Wed, 08 Jan 2025
 14:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
In-Reply-To: <87h66y30gn.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 8 Jan 2025 17:58:03 -0500
X-Gm-Features: AbW1kvb5vjByZmU5Bb7k1iHEJuwkZZymLQwB-EHxdKv-OVM6cB8gml4bFILH2nE
Message-ID: <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f0f4ac062b39cb1c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000f0f4ac062b39cb1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This method adds the options/preamble to each definition block. Notably=
,
> > :since: and :ifcond: are added, as are any "special features" such as
> > :deprecated: and :unstable:.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 6f8f69077b1..85c7ce94564 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -38,7 +38,7 @@
> >  from qapi.error import QAPIError, QAPISemError
> >  from qapi.gen import QAPISchemaVisitor
> >  from qapi.parser import QAPIDoc
> > -from qapi.schema import QAPISchema
> > +from qapi.schema import QAPISchema, QAPISchemaEntity
> >  from qapi.source import QAPISourceInfo
> >
> >  from sphinx import addnodes
> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
> >              # +2: correct for zero/one index, then increment by one.
> >              self.add_line_raw("", fname, line + 2)
> >
> > +    # Transmogrification helpers
> > +
> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
> > +        """
> > +        Generate option lines for qapi entity directives.
> > +        """
> > +        if ent.doc and ent.doc.since:
> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
> > +            # Generated from the entity's docblock; info location is
> exact.
> > +            self.add_line(f":since: {ent.doc.since.text}",
> ent.doc.since.info)
> > +
> > +        if ent.ifcond.is_present():
> > +            doc =3D ent.ifcond.docgen()
> > +            # Generated from entity definition; info location is
> approximate.
> > +            self.add_line(f":ifcond: {doc}", ent.info)
> > +
> > +        # Hoist special features such as :deprecated: and :unstable:
> > +        # into the options block for the entity. If, in the future, ne=
w
> > +        # special features are added, qapi-domain will chirp about
> > +        # unrecognized options and fail.
> > +        for feat in ent.features:
> > +            if feat.is_special():
> > +                # We don't expect special features to have an ifcond
> property.
> > +                # (Hello, intrepid developer in the future who changed
> that!)
> > +                # ((With luck, you are not me.))
> > +                assert not feat.ifcond.is_present()
>
> Nope :)
>
> The attempt to add a conditional special feature now fails with
>
>     Sphinx parallel build error:
>     AssertionError
>
> If you want to outlaw conditional special features, reject them cleanly
> in schema.py, document the restriction in docs/devel/qapi-code-gen.rst,
> and explain why in the commit message.  Recommend a separate commit, to
> make it stand out in git-log.
>

Do you advocate this? I wasn't sure what it *meant* for a special feature
to be conditional; I couldn't conceive of what it meant to have an ifcond
for "deprecated" or "unstable", for instance. It sounds like it isn't well
defined, but we happen to not expressly forbid it.

I guard against it here because, similarly, I have no idea how to handle
the case where it's true.

I didn't realize we technically allow it, though ... would you like me to
move to expressly forbid it in the parser? (Failing that, I have no idea
how to display this information otherwise, so I'd need you to sketch
something out for me; so my inclination is to forbid it as you suggest.
Future developers can always lift the restriction once they have some
use-case in mind and a plan for how to display that information.)

--js


>
> > +                # Generated from entity def; info location is
> approximate.
> > +                self.add_line(f":{feat.name}:", feat.info)
> > +
> > +        self.ensure_blank_line()
> > +
> >      # Transmogrification core methods
> >
> >      def visit_module(self, path: str) -> None:
>
>

--000000000000f0f4ac062b39cb1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20,=
 2024 at 9:15=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This method adds the options/preamble to each definition block. Notabl=
y,<br>
&gt; :since: and :ifcond: are added, as are any &quot;special features&quot=
; such as<br>
&gt; :deprecated: and :unstable:.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-<br=
>
&gt;=C2=A0 1 file changed, 32 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 6f8f69077b1..85c7ce94564 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -38,7 +38,7 @@<br>
&gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt;=C2=A0 from qapi.gen import QAPISchemaVisitor<br>
&gt;=C2=A0 from qapi.parser import QAPIDoc<br>
&gt; -from qapi.schema import QAPISchema<br>
&gt; +from qapi.schema import QAPISchema, QAPISchemaEntity<br>
&gt;=C2=A0 from qapi.source import QAPISourceInfo<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from sphinx import addnodes<br>
&gt; @@ -125,6 +125,37 @@ def ensure_blank_line(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # +2: correct for zero=
/one index, then increment by one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(&quo=
t;&quot;, fname, line + 2)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaEntity) -&gt; None:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines for qapi entity dir=
ectives.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.doc and ent.doc.since:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert ent.doc.since.tag =
=3D=3D QAPIDoc.Tag.SINCE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from the entity=
&#39;s docblock; info location is exact.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:since=
: {ent.doc.since.text}&quot;, <a href=3D"http://ent.doc.since.info" rel=3D"=
noreferrer" target=3D"_blank">ent.doc.since.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.ifcond.is_present():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D ent.ifcond.docgen()=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from entity def=
inition; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:ifcon=
d: {doc}&quot;, <a href=3D"http://ent.info" rel=3D"noreferrer" target=3D"_b=
lank">ent.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hoist special features such as :depreca=
ted: and :unstable:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the options block for the entity. =
If, in the future, new<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # special features are added, qapi-domain=
 will chirp about<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # unrecognized options and fail.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in ent.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if feat.is_special():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We don&#39;=
t expect special features to have an ifcond property.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (Hello, int=
repid developer in the future who changed that!)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ((With luck=
, you are not me.))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not fe=
at.ifcond.is_present()<br>
<br>
Nope :)<br>
<br>
The attempt to add a conditional special feature now fails with<br>
<br>
=C2=A0 =C2=A0 Sphinx parallel build error:<br>
=C2=A0 =C2=A0 AssertionError<br>
<br>
If you want to outlaw conditional special features, reject them cleanly<br>
in schema.py, document the restriction in docs/devel/qapi-code-gen.rst,<br>
and explain why in the commit message.=C2=A0 Recommend a separate commit, t=
o<br>
make it stand out in git-log.<br></blockquote><div><br></div><div>Do you ad=
vocate this? I wasn&#39;t sure what it *meant* for a special feature to be =
conditional; I couldn&#39;t conceive of what it meant to have an ifcond for=
 &quot;deprecated&quot; or &quot;unstable&quot;, for instance. It sounds li=
ke it isn&#39;t well defined, but we happen to not expressly forbid it.<br>=
</div><div><br></div><div>I guard against it here because, similarly, I hav=
e no idea how to handle the case where it&#39;s true.<br></div><div><br></d=
iv><div>I didn&#39;t realize we technically allow it, though ... would you =
like me to move to expressly forbid it in the parser? (Failing that, I have=
 no idea how to display this information otherwise, so I&#39;d need you to =
sketch something out for me; so my inclination is to forbid it as you sugge=
st. Future developers can always lift the restriction once they have some u=
se-case in mind and a plan for how to display that information.)<br></div><=
div><br></div><div>--js<br></div><div>=C2=A0<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated f=
rom entity def; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
(f&quot;:{<a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_blank"=
>feat.name</a>}:&quot;, <a href=3D"http://feat.info" rel=3D"noreferrer" tar=
get=3D"_blank">feat.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Transmogrification core methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_module(self, path: str) -&gt; None:<br>
<br>
</blockquote></div></div>

--000000000000f0f4ac062b39cb1c--


