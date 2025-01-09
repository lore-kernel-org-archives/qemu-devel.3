Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC08FE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwu4-0003BV-Jb; Thu, 09 Jan 2025 13:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwu2-00039d-Lw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwtz-0007lw-S9
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736445902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYDHhJ+Ne3TNceB+aF/Hzg5H3tE0S4TcUQ/af9HABJI=;
 b=EsGTVsoTsBxmx4fy28T2WIiOq2F04gQKbkvjweC7iXP/2Yj0eYa+jmwmpwtg3VF1XTJVNY
 Cx3+nBLujCwzaG075kSsU5/N7g+qiMqyOfyYjIud48IjNSdoeyBm/phKlQCrjjQYpNSd42
 QGZ2Ea8UopIIsgsbOiQnYtTP6REJQrY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-3_6DZXgfN3qNNmhbagwuOA-1; Thu, 09 Jan 2025 13:04:53 -0500
X-MC-Unique: 3_6DZXgfN3qNNmhbagwuOA-1
X-Mimecast-MFC-AGG-ID: 3_6DZXgfN3qNNmhbagwuOA
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so2167476a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736445892; x=1737050692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYDHhJ+Ne3TNceB+aF/Hzg5H3tE0S4TcUQ/af9HABJI=;
 b=rCK8FIZjUx2HQSJqDfAkDrRZ7KBUbYqnN1ryoQ8UMpVUvOoYQTn8QWRHFlhmU3odRt
 Emk+lBrh6BUhmqDRBnr4zHjKDpjuaNzYeIAEKB/Rv1arMHAztvCP2oPjGz1R0YiZCxAS
 zAoEeMf+4a1rgehMqjbI977CuA1vR8JxAsFN3zmVyapOOS0q/zNsX150OQrB6ABK7o9N
 9TBnlW8zY4asChS7gqHrrHi8t9Ng5n5MWff2HxHPQtnNp8tu4GCwAOKz++lGq4lsC9C/
 Os8TvAI49tHbmztR3uu0oJktsIV/D+6cBICChPHGVW3W1aRixn8tOq7aBi1GxUIkjr4R
 7OdA==
X-Gm-Message-State: AOJu0YzLYY51XdKfmZeYkM3xzD0QtjMoVlouzm9D8KitJ2/+vPISVkrA
 7Mk+Kli8LWHktqLxPUawJFs3DCMnL1/zWrRpvJJRqMGSb3evKBt3fNuWdxYpYuwvtqa79EAyE6U
 836u+7PI3X38tf/OWBtakrdPXy44eQ2tTVm17HqLaJN/PteArPbypqfTul4qfblv4zFP3EoVh5A
 bf1gUdsES1afTsBj11zGt/oQGk1Lk=
X-Gm-Gg: ASbGncusb3H9wn4cJef7QSXSzL5BVscfZ/uqWkVsh92lIhUenIk2dCSIDyJXhE3kG3Z
 NHwEDsQNOma90iTvaJSfFiXOBs0GeDyOb2uJ26OIJV9DcwdA5DXxl1teLag2BWq2pFZYm7w==
X-Received: by 2002:a17:90b:258b:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f548ec788amr12671663a91.17.1736445892061; 
 Thu, 09 Jan 2025 10:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Pg4Cvv0+DYA2fd2VzJPWexEvauOYLMWn7zrzeP2y4hBhv6Eoh/xkMOVBhpq14vn14OogZp9izKpk+weeb7c=
X-Received: by 2002:a17:90b:258b:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f548ec788amr12671616a91.17.1736445891659; Thu, 09 Jan 2025
 10:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
 <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
 <87sepss2bv.fsf@pond.sub.org>
In-Reply-To: <87sepss2bv.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Jan 2025 13:04:39 -0500
X-Gm-Features: AbW1kvbrBjlR9fJlAD6_p8j3ncg60kDrXOEtiCPevKrHSFiM5d-ktvhSF0vvzPQ
Message-ID: <CAFn=p-bum9NvZNEYRKCD6Wh_GucSmT33YT9aEqK80u+2d7cUQQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008b6006062b49d07d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000008b6006062b49d07d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025, 5:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > This method adds the options/preamble to each definition block.
> Notably,
> >> > :since: and :ifcond: are added, as are any "special features" such a=
s
> >> > :deprecated: and :unstable:.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
> >> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> > index 6f8f69077b1..85c7ce94564 100644
> >> > --- a/docs/sphinx/qapidoc.py
> >> > +++ b/docs/sphinx/qapidoc.py
> >> > @@ -38,7 +38,7 @@
> >> >  from qapi.error import QAPIError, QAPISemError
> >> >  from qapi.gen import QAPISchemaVisitor
> >> >  from qapi.parser import QAPIDoc
> >> > -from qapi.schema import QAPISchema
> >> > +from qapi.schema import QAPISchema, QAPISchemaEntity
> >> >  from qapi.source import QAPISourceInfo
> >> >
> >> >  from sphinx import addnodes
> >> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
> >> >              # +2: correct for zero/one index, then increment by one=
.
> >> >              self.add_line_raw("", fname, line + 2)
> >> >
> >> > +    # Transmogrification helpers
> >> > +
> >> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
> >> > +        """
> >> > +        Generate option lines for qapi entity directives.
> >> > +        """
> >> > +        if ent.doc and ent.doc.since:
> >> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
> >> > +            # Generated from the entity's docblock; info location i=
s
> exact.
> >> > +            self.add_line(f":since: {ent.doc.since.text}",
> ent.doc.since.info)
> >> > +
> >> > +        if ent.ifcond.is_present():
> >> > +            doc =3D ent.ifcond.docgen()
> >> > +            # Generated from entity definition; info location is
> approximate.
> >> > +            self.add_line(f":ifcond: {doc}", ent.info)
> >> > +
> >> > +        # Hoist special features such as :deprecated: and :unstable=
:
> >> > +        # into the options block for the entity. If, in the future,
> new
> >> > +        # special features are added, qapi-domain will chirp about
> >> > +        # unrecognized options and fail.
> >> > +        for feat in ent.features:
> >> > +            if feat.is_special():
> >> > +                # We don't expect special features to have an ifcon=
d
> property.
> >> > +                # (Hello, intrepid developer in the future who
> changed that!)
> >> > +                # ((With luck, you are not me.))
> >> > +                assert not feat.ifcond.is_present()
> >>
> >> Nope :)
> >>
> >> The attempt to add a conditional special feature now fails with
> >>
> >>     Sphinx parallel build error:
> >>     AssertionError
> >>
> >> If you want to outlaw conditional special features, reject them cleanl=
y
> >> in schema.py, document the restriction in docs/devel/qapi-code-gen.rst=
,
> >> and explain why in the commit message.  Recommend a separate commit, t=
o
> >> make it stand out in git-log.
> >
> > Do you advocate this? I wasn't sure what it *meant* for a special featu=
re
> > to be conditional; I couldn't conceive of what it meant to have an ifco=
nd
> > for "deprecated" or "unstable", for instance. It sounds like it isn't
> well
> > defined, but we happen to not expressly forbid it.
>
> Semantics are clear enough to me.
>
> "Conditional special feature" combines "conditional feature" (which is a
> special case of conditional thing) with special feature (which is a
> special case of feature).
>
> The QAPI schema language supports compile-time conditionals for certain
> things.  Generated code behaves as if the thing didn't exist unless its
> condition is true.
>
> QAPI schema features are strings exposed to clients in introspection.
>
> Combine the two: a conditional feature is exposed if and only if its
> condition is true.
>
> Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if
> CONFIG_BLKIO_VHOST_VDPA_FD.
>
> A special feature is a feature that has special meaning to the
> generator, i.e. we generate different code in places when it's present.
>
> Combine: we enable different code for a conditional special feature only
> when its condition is true.
>
> No existing uses so far.
>
> Implementation is straightforward, too.
>

Mechanically, it's well defined... but that isn't my concern.

What I asked you was: "what would it mean for deprecated to be conditional?=
"

Without understanding that, I have no chance to design a system that
handles that information accordingly for the documentation.


> Any code we generate for a conditional thing is guarded by #if
> ... #endif.
>
> For features, we generate suitable data into qapi-introspect.c.
>
> For special features, we generate a little additional code here and
> there; look for .is_special() to find it.
>
> Bug: this additional code lacks #if ... #endif.  Simple oversight,
> should be easy enough to fix.
>
> > I guard against it here because, similarly, I have no idea how to handl=
e
> > the case where it's true.
> >
> > I didn't realize we technically allow it, though ... would you like me =
to
> > move to expressly forbid it in the parser? (Failing that, I have no ide=
a
> > how to display this information otherwise, so I'd need you to sketch
> > something out for me; so my inclination is to forbid it as you suggest.
> > Future developers can always lift the restriction once they have some
> > use-case in mind and a plan for how to display that information.)
>
> I think we should first make a reasonable effort at figuring out how to
> handle conditional special features.  If we fail, we can add the
> restriction instead.
>

I don't think I agree; I don't think it's worth spending time defining a
feature we don't use in our minds to then design around a hypothetical
future use.

Easier to admit we don't use it and save defining the semantics for the
future developer who stumbles across a reason for needing it.


> How do you handle features in general, and special features in
> particular?
>

Features: they go in the :feat: field list.
Special features: they go in the :feat: field list, and also receive a
special option flag to the directive to allow for special rendering of the
"signature bar" (the header line for a given entity definition in the
rendered documentation.)

e.g.

@deprecated will generate two things:

1) the definition block will get a :deprecated: option, which enables the
html renderer to (potentially) do special things like color the entry
differently, add a "warning pip"/eyecatch, etc. It's scoped to the whole
definition.

2) A :feat deprecated: line which is added to the features "field list" as
per normal for features.


> How do you handle conditionals in general?
>

In this series, I don't!

...except for top-level conditionals, which are currently passed as-is as
an argument to the :ifcond: directive option. The format of that argument
and what the HTML renderer actually does with it is currently TBD.

(In current prototypes I just print the conditional string in the signature
bar.)


> How do you combine feature and conditional?
>

Notably TBD. Unhandled both in this series as-is *and* in my larger WIP.


> How could you combine special feature and conditonal?
>

Bewilderingly uncertain.

Mechanically, it *could* be handled the same way :ifcond: directive options
are.

e.g.

```
.. qapi:command:: x-beware-of-the-leopard
   :deprecated: {ifcond stuff here}
   :unstable: {ifcond stuff here}

   lorem ipsum dolor sit amet

   :feat deprecated: blah blah (if: ...)
   :feat unstable: blah blah (if: ...)
```

Semantically and in the rendered output, I have absolutely no clue
whatsoever; and doubt I could figure it out without a use case in front of
me to design around ... so I'd prefer to put up a traffic barrier for now.

i.o.w. the design issue arises specifically because special features are
semanticaly special and are "hoisted" to be block-level in the
transmogrified rST doc, and so syntax needs to be designed, implemented and
tested if they are to be conditional.

Yet, we have no such cases to facilitate the design, implementation and
testing.

So, I'd like to prohibit until such time as we have such a case.


> [...]
>
>

--0000000000008b6006062b49d07d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2025, 5:34=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; This method adds the options/preamble to each definition bloc=
k. Notably,<br>
&gt;&gt; &gt; :since: and :ifcond: are added, as are any &quot;special feat=
ures&quot; such as<br>
&gt;&gt; &gt; :deprecated: and :unstable:.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc.py | 33 +++++++++++++++++++++++++++=
+++++-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 32 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<=
br>
&gt;&gt; &gt; index 6f8f69077b1..85c7ce94564 100644<br>
&gt;&gt; &gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; @@ -38,7 +38,7 @@<br>
&gt;&gt; &gt;=C2=A0 from qapi.error import QAPIError, QAPISemError<br>
&gt;&gt; &gt;=C2=A0 from qapi.gen import QAPISchemaVisitor<br>
&gt;&gt; &gt;=C2=A0 from qapi.parser import QAPIDoc<br>
&gt;&gt; &gt; -from qapi.schema import QAPISchema<br>
&gt;&gt; &gt; +from qapi.schema import QAPISchema, QAPISchemaEntity<br>
&gt;&gt; &gt;=C2=A0 from qapi.source import QAPISourceInfo<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 from sphinx import addnodes<br>
&gt;&gt; &gt; @@ -125,6 +125,37 @@ def ensure_blank_line(self) -&gt; None:<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # +2: correct=
 for zero/one index, then increment by one.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
_raw(&quot;&quot;, fname, line + 2)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaEntity) -&gt=
; None:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines for qapi e=
ntity directives.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.doc and ent.doc.since:<br=
>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert ent.doc.sin=
ce.tag =3D=3D QAPIDoc.Tag.SINCE<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from t=
he entity&#39;s docblock; info location is exact.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&qu=
ot;:since: {ent.doc.since.text}&quot;, <a href=3D"http://ent.doc.since.info=
" rel=3D"noreferrer noreferrer" target=3D"_blank">ent.doc.since.info</a>)<b=
r>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.ifcond.is_present():<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D ent.ifcond=
.docgen()<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from e=
ntity definition; info location is approximate.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&qu=
ot;:ifcond: {doc}&quot;, <a href=3D"http://ent.info" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">ent.info</a>)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hoist special features such as=
 :deprecated: and :unstable:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the options block for the=
 entity. If, in the future, new<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # special features are added, qa=
pi-domain will chirp about<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # unrecognized options and fail.=
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in ent.features:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if feat.is_special=
():<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We=
 don&#39;t expect special features to have an ifcond property.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (H=
ello, intrepid developer in the future who changed that!)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ((=
With luck, you are not me.))<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asse=
rt not feat.ifcond.is_present()<br>
&gt;&gt;<br>
&gt;&gt; Nope :)<br>
&gt;&gt;<br>
&gt;&gt; The attempt to add a conditional special feature now fails with<br=
>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Sphinx parallel build error:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0AssertionError<br>
&gt;&gt;<br>
&gt;&gt; If you want to outlaw conditional special features, reject them cl=
eanly<br>
&gt;&gt; in schema.py, document the restriction in docs/devel/qapi-code-gen=
.rst,<br>
&gt;&gt; and explain why in the commit message.=C2=A0 Recommend a separate =
commit, to<br>
&gt;&gt; make it stand out in git-log.<br>
&gt;<br>
&gt; Do you advocate this? I wasn&#39;t sure what it *meant* for a special =
feature<br>
&gt; to be conditional; I couldn&#39;t conceive of what it meant to have an=
 ifcond<br>
&gt; for &quot;deprecated&quot; or &quot;unstable&quot;, for instance. It s=
ounds like it isn&#39;t well<br>
&gt; defined, but we happen to not expressly forbid it.<br>
<br>
Semantics are clear enough to me.<br>
<br>
&quot;Conditional special feature&quot; combines &quot;conditional feature&=
quot; (which is a<br>
special case of conditional thing) with special feature (which is a<br>
special case of feature).<br>
<br>
The QAPI schema language supports compile-time conditionals for certain<br>
things.=C2=A0 Generated code behaves as if the thing didn&#39;t exist unles=
s its<br>
condition is true.<br>
<br>
QAPI schema features are strings exposed to clients in introspection.<br>
<br>
Combine the two: a conditional feature is exposed if and only if its<br>
condition is true.<br>
<br>
Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if<br>
CONFIG_BLKIO_VHOST_VDPA_FD.<br>
<br>
A special feature is a feature that has special meaning to the<br>
generator, i.e. we generate different code in places when it&#39;s present.=
<br>
<br>
Combine: we enable different code for a conditional special feature only<br=
>
when its condition is true.<br>
<br>
No existing uses so far.<br>
<br>
Implementation is straightforward, too.<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Mechanically, it&#39;s well defined.=
.. but that isn&#39;t my concern.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">What I asked you was: &quot;what would it mean for deprecated to =
be conditional?&quot;</div><div dir=3D"auto"><br></div><div dir=3D"auto">Wi=
thout understanding that, I have no chance to design a system that handles =
that information accordingly for the documentation.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br>
Any code we generate for a conditional thing is guarded by #if<br>
... #endif.<br>
<br>
For features, we generate suitable data into qapi-introspect.c.<br>
<br>
For special features, we generate a little additional code here and<br>
there; look for .is_special() to find it.<br>
<br>
Bug: this additional code lacks #if ... #endif.=C2=A0 Simple oversight,<br>
should be easy enough to fix.<br>
<br>
&gt; I guard against it here because, similarly, I have no idea how to hand=
le<br>
&gt; the case where it&#39;s true.<br>
&gt;<br>
&gt; I didn&#39;t realize we technically allow it, though ... would you lik=
e me to<br>
&gt; move to expressly forbid it in the parser? (Failing that, I have no id=
ea<br>
&gt; how to display this information otherwise, so I&#39;d need you to sket=
ch<br>
&gt; something out for me; so my inclination is to forbid it as you suggest=
.<br>
&gt; Future developers can always lift the restriction once they have some<=
br>
&gt; use-case in mind and a plan for how to display that information.)<br>
<br>
I think we should first make a reasonable effort at figuring out how to<br>
handle conditional special features.=C2=A0 If we fail, we can add the<br>
restriction instead.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">I don&#39;t think I agree; I don&#39;t think it&#39;s w=
orth spending time defining a feature we don&#39;t use in our minds to then=
 design around a hypothetical future use.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Easier to admit we don&#39;t use it and save defining the=
 semantics for the future developer who stumbles across a reason for needin=
g it.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
How do you handle features in general, and special features in<br>
particular?<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Features: they go in the :feat: field list.</div><div dir=3D"aut=
o">Special features: they go in the :feat: field list, and also receive a s=
pecial option flag to the directive to allow for special rendering of the &=
quot;signature bar&quot; (the header line for a given entity definition in =
the rendered documentation.)</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">e.g.</div><div dir=3D"auto"><br></div><div dir=3D"auto">@deprecated wi=
ll generate two things:</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
1) the definition block will get a :deprecated: option, which enables the h=
tml renderer to (potentially) do special things like color the entry differ=
ently, add a &quot;warning pip&quot;/eyecatch, etc. It&#39;s scoped to the =
whole definition.</div><div dir=3D"auto"><br></div><div dir=3D"auto">2) A :=
feat deprecated: line which is added to the features &quot;field list&quot;=
 as per normal for features.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<br>
How do you handle conditionals in general?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">In this series, I don&#39;t!</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">...except for top-level cond=
itionals, which are currently passed as-is as an argument to the :ifcond: d=
irective option. The format of that argument and what the HTML renderer act=
ually does with it is currently TBD.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">(In current prototypes I just print the conditional string in =
the signature bar.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
How do you combine feature and conditional?<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Notably TBD. Unhandled both in t=
his series as-is *and* in my larger WIP.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
How could you combine special feature and conditonal?<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Bewilderingly uncertai=
n.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Mechanically, it *cou=
ld* be handled the same way :ifcond: directive options are.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">e.g.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">```</div><div dir=3D"auto">.. qapi:command:: x-beware-of=
-the-leopard</div><div dir=3D"auto">=C2=A0 =C2=A0:deprecated: {ifcond stuff=
 here}</div><div dir=3D"auto">=C2=A0 =C2=A0:unstable: {ifcond stuff here}</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0lorem ipsum =
dolor sit amet</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =
=C2=A0:feat deprecated: blah blah (if: ...)</div><div dir=3D"auto">=C2=A0 =
=C2=A0:feat unstable: blah blah (if: ...)</div><div dir=3D"auto">```</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Semantically and in the render=
ed output, I have absolutely no clue whatsoever; and doubt I could figure i=
t out without a use case in front of me to design around ... so I&#39;d pre=
fer to put up a traffic barrier for now.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">i.o.w. the design issue arises specifically because specia=
l features are semanticaly special and are &quot;hoisted&quot; to be block-=
level in the transmogrified rST doc, and so syntax needs to be designed, im=
plemented and tested if they are to be conditional.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Yet, we have no such cases to facilitate the de=
sign, implementation and testing.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">So, I&#39;d like to prohibit until such time as we have such a ca=
se.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000008b6006062b49d07d--


