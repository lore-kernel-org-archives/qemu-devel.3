Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BC2C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 21:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trkVL-0008Ny-1s; Mon, 10 Mar 2025 17:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkVJ-0008NP-2O
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkVH-000788-8f
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741641456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N+eXkgBa/NTgjWl9AYfOdL3SMNRYQL19mdptwFMrik0=;
 b=FuYvi4x0CpyumARL37BTrDMjmgO7ySb01shQz06eQZjHcXsgn6BYTkVrZG0GBL21L3sf2j
 8W5xanYjumW+Pm5KywOYvvQfQjWFlBGBWLWxhomXL+GiSRifA+r1onHJKCOuw2UH4GASI3
 THZmHgI1ojxLFOQGOr0vZ2Z4H9ma5js=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-yyTi82-rPVu8uPVFL-CBSQ-1; Mon, 10 Mar 2025 17:17:33 -0400
X-MC-Unique: yyTi82-rPVu8uPVFL-CBSQ-1
X-Mimecast-MFC-AGG-ID: yyTi82-rPVu8uPVFL-CBSQ_1741641452
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2241e7e3addso65004715ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741641452; x=1742246252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N+eXkgBa/NTgjWl9AYfOdL3SMNRYQL19mdptwFMrik0=;
 b=Pkkri5Yl3/2TOpkSTuYKg3rAlVBEEtQVsCncs7E8k9puGfsa1Nq5O11mslTrEKfZaz
 LSadnzTldV9BZ4wDPIxaCHSfJoOszzQUKS/zkjQU8oY2iqXw7dZkFMab7pDGb0FihChf
 swbJByJlHNKQQ5IRtRgE8f6DJysMdzM3jYUuZtYJYUqZXb0fnmGtGwSDYBKKm/C2qdfk
 orbHPeZwLX5KQ3IGKIrMtOoL/+IMkF5WoFsA86M/yjTl1MPdcu47vRhuTcIBMUQ8sBWk
 oGWUbI2BHyAwAu9oTEYwAL0VYERvKj4ZJhXNLOdGRzyat19gP6HwwzHotVUOUZ/gjPmU
 awxw==
X-Gm-Message-State: AOJu0YwPCYFoxwRPKRer99DPG72ZrTiDQfTitXCnWGUgYhGvgLy60W3a
 yHy0Y4+bb+BLSb4dYjbjn3sixu4bRfx4ddyZEQBimblg+zZafC1urCobXGfqCN8VtyoeMTjDy7r
 CGGDAEgH9MRsrCDVLqeaSLIeKDMYsvmnFaJa81zAVkXGnJ5OZbR0HTDK4WVjKDtfS7+i504775M
 dIcA/tTx8sJVN4d5yDGrIooGJUQ1A=
X-Gm-Gg: ASbGncsDUtQKSR0QbEgxvRzCfx5laF5Col8QyUJE+4aLgOspfWKBa/defmfTXqNsxzA
 nkN718Oz0hfxd56pMTPX/w1g8+J+KYNFzJHBNnHXaFUfB651FEyaF63NBxxJOk21Ta0WhDnxCtH
 AJF4099/n4TsPcvuj3Io2+NEyOK/vE
X-Received: by 2002:a17:902:e842:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-225931ad6e5mr17378295ad.48.1741641452187; 
 Mon, 10 Mar 2025 14:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ISbWU2WFHpbxwVeRNOV4Iq0/udQtWWRokt8O1ULsnLzurg75TiBTgc+78uogUpCo1clUeU7NBQ/+amdXtkM=
X-Received: by 2002:a17:902:e842:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-225931ad6e5mr17378005ad.48.1741641451829; Mon, 10 Mar 2025
 14:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-46-jsnow@redhat.com>
 <87tt81ykwh.fsf@pond.sub.org>
In-Reply-To: <87tt81ykwh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:17:20 -0400
X-Gm-Features: AQ5f1JqfXGRwYV0yOZX97A8hXdHX2HEMRQE01gtWsQzk-41iyyciGSw0apIBNME
Message-ID: <CAFn=p-ZER5NtaHvgVS+sOj=Hnki2pnrqGGDc-m2qFgYx0+vosw@mail.gmail.com>
Subject: Re: [PATCH v2 45/62] docs/qapidoc: add visit_errors() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001019a906300380ec"
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

--0000000000001019a906300380ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:05=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Notably, this method does not currently address the formatting issues
> > present with the "errors" section in QAPIDoc and just vomits the text
> > verbatim into the rST doc, with somewhat inconsistent results.
> >
> > To be addressed in a future revision.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index b96445f0802..14feafe866e 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -139,6 +139,12 @@ def visit_paragraph(self, section: QAPIDoc.Section=
)
> -> None:
> >          self.add_lines(section.text, section.info)
> >          self.ensure_blank_line()
> >
> > +    def visit_errors(self, section: QAPIDoc.Section) -> None:
> > +        # FIXME: the formatting for errors may be inconsistent and may
>
> If I remember correctly, you wanted to mention this FIXME in the commit
> message.
>

Well, that's what the entire commit message is already about! Both of these
places are talking about the visual misalignment and enforcing the source
formatting of errors to fix the visual alignment problems.


>
> > +        # or may not require different newline placement to ensure
> > +        # proper rendering as a nested list.
> > +        self.add_lines(f":error:\n{section.text}", section.info)
> > +
> >      def preamble(self, ent: QAPISchemaDefinition) -> None:
> >          """
> >          Generate option lines for qapi entity directives.
>
>

--0000000000001019a906300380ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 5:05=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Notably, this method does not currently address the formatting issues<=
br>
&gt; present with the &quot;errors&quot; section in QAPIDoc and just vomits=
 the text<br>
&gt; verbatim into the rST doc, with somewhat inconsistent results.<br>
&gt;<br>
&gt; To be addressed in a future revision.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index b96445f0802..14feafe866e 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -139,6 +139,12 @@ def visit_paragraph(self, section: QAPIDoc.Sectio=
n) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(section.text, <a href=
=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.info<=
/a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_errors(self, section: QAPIDoc.Section) -&gt; =
None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: the formatting for errors may be=
 inconsistent and may<br>
<br>
If I remember correctly, you wanted to mention this FIXME in the commit<br>
message.<br></blockquote><div><br></div><div>Well, that&#39;s what the enti=
re commit message is already about! Both of these places are talking about =
the visual misalignment and enforcing the source formatting of errors to fi=
x the visual alignment problems.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # or may not require different newline pl=
acement to ensure<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # proper rendering as a nested list.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(f&quot;:error:\n{section.t=
ext}&quot;, <a href=3D"http://section.info" rel=3D"noreferrer" target=3D"_b=
lank">section.info</a>)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaDefinition) -&gt=
; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines for qapi entit=
y directives.<br>
<br>
</blockquote></div></div>

--0000000000001019a906300380ec--


