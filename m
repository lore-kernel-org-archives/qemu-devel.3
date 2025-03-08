Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44276C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpGR-0005lV-FU; Sat, 08 Mar 2025 03:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpGI-0005fj-H2
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpGG-0006er-CN
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQ85BR6/zhNvSqvBFYzbcON7iMiysgVfmGRZ4AD1JL4=;
 b=FhEl8n6pf2avURFZ6WCgZ4Zx1vGbpPIczalV/gjvgJDPxDgAGCfwLvcFJiQZ5WvaF4rrv/
 6J0Yc8oJgaovOCEkPt0mhMKaTlKI8NNGR5c9H3i8cwf9MQ3jbQLHsP3q8nlbKi4CLKFoIp
 FNB6zS8akW7QEVQKcKnVsjz12qTiDv4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-IqINaaA4MiqUKAazjtWLLg-1; Sat, 08 Mar 2025 03:10:17 -0500
X-MC-Unique: IqINaaA4MiqUKAazjtWLLg-1
X-Mimecast-MFC-AGG-ID: IqINaaA4MiqUKAazjtWLLg_1741421416
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff64898e2aso4340828a91.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421416; x=1742026216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQ85BR6/zhNvSqvBFYzbcON7iMiysgVfmGRZ4AD1JL4=;
 b=ZJcNlPnLYjglbfMW9J4Odwh6dPOZU9uxBKuldzcJ7DOYad2b48isx/142o9KQUTkEK
 fxlRqkiv+PAJgsqHwzbXFSyUCCudPexTJ7iAWvGOfaetQjCDhUGYqagywpYoX9XWJhNU
 i8hcsNjbnKphS/vk5HH1wTfhtniCZiuV8HU9NdlH9ypVeOGM4+s6xdLqEfkO89+AkUea
 Sdv357MFiYEBQm3qYZt6Tcy8U5DxMSPuS1XkXxClJhvuZCKTQ9sUGr4aOZIlPBFdeqcr
 UcoNGFflmvFtHbvN8YqLsyKcJVFgBy3h05Bn3RU9uiRS+2II6h9RKSLiEeazs+S8JkYI
 9eTw==
X-Gm-Message-State: AOJu0Yyrm6cLPP/cEzOdYcwrLhafYBi4aQzeg+YghXMSiE6+WNaKW6ZB
 t8hC0512ya+pV/QwZ7Sw5nFCx9OxpFizZSSovKEO5jVWZoXk0Jr/rPfkQs1uhRUGRWyduXvIxg4
 vAULa047A/8lFcE9kwP5Skx2ZkSIGBCV3jIxBkImmGxlxSM5GcCQLqr/gXOEtrgA1TkfrLZgsaA
 DWzm+2R9vEmXUTAF84kMMOHHt6XHA=
X-Gm-Gg: ASbGncsfbOsiMS8x8MZ7PpRQj8p96Ks7Lo8bdqAJxTJN9k2GQiMjJUwFRGnM7tIAmQd
 qnyO7CNyzKJVR2HxTa/1Pr25+M/XDlcfTjDB7YMEa5TxjGtMhhkgZMVnzMrNAJHexAZtAJA==
X-Received: by 2002:a17:90b:3942:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-2ffbc1478f7mr4089465a91.2.1741421415881; 
 Sat, 08 Mar 2025 00:10:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG72Cz5eGIimD5fcACVT597K1l84ugRhsmMjFVAM7GgwM7RHBzQ4EmjTsJtL9IR7ReFu+rj7l4ujOS4mlVKFfg=
X-Received: by 2002:a17:90b:3942:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-2ffbc1478f7mr4089438a91.2.1741421415568; Sat, 08 Mar 2025
 00:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-51-jsnow@redhat.com>
 <87wmd1hvse.fsf@pond.sub.org>
In-Reply-To: <87wmd1hvse.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:10:03 -0500
X-Gm-Features: AQ5f1Jq2wzFTllQkL8WukR34e5KWrqnfkAZoLlyh7bDTEoQcAuEY0EprqPsriFc
Message-ID: <CAFn=p-YEM+DKhmi5h59EUSC9sWLMvAe3S4ibzV=1sN5z9gE7Gg@mail.gmail.com>
Subject: Re: [PATCH 50/57] docs/qapidoc: add visit_sections() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e13213062fd04447"
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

--000000000000e13213062fd04447
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:26=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Implement the actual main dispatch method that processes and handles th=
e
> > list of doc sections for a given QAPI entity.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index ed0269af27d..7308fa0a767 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -288,6 +288,31 @@ def preamble(self, ent: QAPISchemaDefinition) ->
> None:
> >
> >          self.ensure_blank_line()
> >
> > +    def visit_sections(self, ent: QAPISchemaDefinition) -> None:
> > +        sections =3D ent.doc.all_sections if ent.doc else []
> > +
> > +        # Add sections *in the order they are documented*:
>
> Is the order important, or just a matter of style?
>

I meant to emphasize the fact that the transmogrifier works "dumbly" on a
sequence of sections and nothing else; so the output is strictly in source
order.

The order does wind up mattering a *little*; if you randomized the section
order you'd not get good field list grouping, and/or the grouping
mechanisms would re-order the documentation so that it wasn't source order
anymore.

Not that this would happen with our parser, but, you asked.


>
> > +        for section in sections:
> > +            if section.kind =3D=3D QAPIDoc.Kind.PLAIN:
> > +                self.visit_paragraph(section)
> > +            elif section.kind =3D=3D QAPIDoc.Kind.MEMBER:
> > +                assert isinstance(section, QAPIDoc.ArgSection)
> > +                self.visit_member(section)
> > +            elif section.kind =3D=3D QAPIDoc.Kind.FEATURE:
> > +                assert isinstance(section, QAPIDoc.ArgSection)
> > +                self.visit_feature(section)
> > +            elif section.kind in (QAPIDoc.Kind.SINCE,
> QAPIDoc.Kind.TODO):
> > +                # Since is handled in preamble, TODO is skipped
> intentionally.
> > +                pass
> > +            elif section.kind =3D=3D QAPIDoc.Kind.RETURNS:
> > +                self.visit_returns(section)
> > +            elif section.kind =3D=3D QAPIDoc.Kind.ERRORS:
> > +                self.visit_errors(section)
> > +            else:
> > +                assert False
> > +
> > +        self.ensure_blank_line()
> > +
> >      # Transmogrification core methods
> >
> >      def visit_module(self, path: str) -> None:
>
>

--000000000000e13213062fd04447
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:26=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Implement the actual main dispatch method that processes and handles t=
he<br>
&gt; list of doc sections for a given QAPI entity.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 25 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index ed0269af27d..7308fa0a767 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -288,6 +288,31 @@ def preamble(self, ent: QAPISchemaDefinition) -&g=
t; None:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_sections(self, ent: QAPISchemaDefinition) -&g=
t; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sections =3D ent.doc.all_sections if ent.=
doc else []<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add sections *in the order they are doc=
umented*:<br>
<br>
Is the order important, or just a matter of style?<br></blockquote><div><br=
></div><div>I meant to emphasize the fact that the transmogrifier works &qu=
ot;dumbly&quot; on a sequence of sections and nothing else; so the output i=
s strictly in source order.</div><div><br></div><div>The order does wind up=
 mattering a *little*; if you randomized the section order you&#39;d not ge=
t good field list grouping, and/or the grouping mechanisms would re-order t=
he documentation so that it wasn&#39;t source order anymore.</div><div><br>=
</div><div>Not that this would happen with our parser, but, you asked.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in sections:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind =3D=3D QAPI=
Doc.Kind.PLAIN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_pa=
ragraph(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QA=
PIDoc.Kind.MEMBER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinst=
ance(section, QAPIDoc.ArgSection)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_me=
mber(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QA=
PIDoc.Kind.FEATURE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinst=
ance(section, QAPIDoc.ArgSection)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_fe=
ature(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind in (QAPID=
oc.Kind.SINCE, QAPIDoc.Kind.TODO):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Since is ha=
ndled in preamble, TODO is skipped intentionally.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QA=
PIDoc.Kind.RETURNS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_re=
turns(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QA=
PIDoc.Kind.ERRORS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.visit_er=
rors(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert False<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Transmogrification core methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_module(self, path: str) -&gt; None:<br>
<br>
</blockquote></div></div>

--000000000000e13213062fd04447--


