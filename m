Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3C7C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTnf-0000IL-JG; Thu, 16 Jan 2025 12:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tYTne-0000Hr-Hx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tYTnc-0003HT-PS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737049014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZYzzbNE5zy4yEDN4knmkDVilJVx97A2EzKXTMPsGdE=;
 b=CqLcy/rOoL2jnuxFILTABWrtgt0yvKM8qOPiNtn28bjLolAINJpSElS4aI+k0M1SFtJ560
 pv34FFRds+j1q253jqiqj2rTkf6vJrHYAPwfgqbzovYmmMjBM8XKA5Sp2YfwBKJRvhdN1u
 /XsHpMb4z5GOuGpCGR41Q4d64goVFUk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-3SaG0zQAOtmiQ_XVF7HN4Q-1; Thu, 16 Jan 2025 12:36:52 -0500
X-MC-Unique: 3SaG0zQAOtmiQ_XVF7HN4Q-1
X-Mimecast-MFC-AGG-ID: 3SaG0zQAOtmiQ_XVF7HN4Q
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2165433e229so25699565ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049011; x=1737653811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZYzzbNE5zy4yEDN4knmkDVilJVx97A2EzKXTMPsGdE=;
 b=IGF6nEXkue2MhLCwk0epQcSFjPFh2hG2TUAn5qYqN8qCUnVpCuWo815PWa6DDeVplT
 0RAMQT51VBLOy1tb3e5LuyKtMJAJBEBdAfJG+X0ORpUHijUC4TA6QsuWE5p0LDvbsUJ0
 j9WXT6OFHZjnQY1c4woU+ZDIq/+FoQic68it13+wm3YFsx3xPPTNFPlX6DUYS0qXA7D7
 XRmyIF2tuJO+HgqJve68oMEFAjjXnWcNTBQq+7q/wXE2GDLWS725VLVhraXEU0lv//J1
 NcWurYQ8wyfqtcD8Ivjd8/3/JnogX7asTFVl/HP0L7qY5bW9MCp8mBVxOUrp4M3kqSRI
 wFhQ==
X-Gm-Message-State: AOJu0YwePHFS8w7Epai+DPL9FLMMUzjyTk77cJ6JuiGpLZedM6+O08eK
 OQ12vvMteiS674t+XR5wsZqgpmrRiCusiHwCLlgfyruVvl0244XbXTZrDIhgeLUEf0il0+tvgsc
 tSD9Eog5R7tz0kVwQHuxAp/uXfD+2tmIErqEIR42eiWu+pkz6m0hZXdBCXeIfD3rtJ19oCqJIM7
 7eux+ujBpVu7W5Jgjk8Bb7rslHlbs=
X-Gm-Gg: ASbGncug6KvgyMph8sUbsf7y/VNyeX0P3Fs+uTv6es5XAJUIkl3IT8IsTrwF3pIfrrp
 hSpqNpXz7mcidRwOZYgRAFC/sm0mKxKZaetUJN7x49LWfZNWSZwG80pMgGIut0UfrJKsqiQ==
X-Received: by 2002:a17:903:186:b0:215:9bc2:42ec with SMTP id
 d9443c01a7336-21a83ffb98dmr502304975ad.47.1737049011355; 
 Thu, 16 Jan 2025 09:36:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuoat0hXqygsmBt75JWuP+FYQixDZ//+ZGllCOEa3KsiWDxiFwR4mXq3aiogqjQEAC9jYOmA1ipDONCsrSIPs=
X-Received: by 2002:a17:903:186:b0:215:9bc2:42ec with SMTP id
 d9443c01a7336-21a83ffb98dmr502304745ad.47.1737049011086; Thu, 16 Jan 2025
 09:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20250114185840.3058525-1-jsnow@redhat.com>
 <20250114185840.3058525-6-jsnow@redhat.com>
 <87v7uf6kpw.fsf@pond.sub.org>
In-Reply-To: <87v7uf6kpw.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 Jan 2025 12:36:39 -0500
X-Gm-Features: AbW1kvZW5gyjmv4yia7SSm_S1HkAWRcTbP_FycFRZbEWNlICJcvxyFxsyZZr5yM
Message-ID: <CAFn=p-YCh6ruTtVpzf-a63ouyh78t80DpDyWGz=gf_njiuT3OA@mail.gmail.com>
Subject: Re: [PATCH v2 05/23] qapi/schema: add __repr__ to QAPIDoc.Section
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004385a1062bd63d95"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

--0000000000004385a1062bd63d95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:51=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Makes debugging far more pleasant when you can just print(section) and
> > get something reasonable to display.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index c3004aa70c6..cb259c42a6d 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -673,6 +673,9 @@ def __init__(
> >              # section text without tag
> >              self.text =3D ''
> >
> > +        def __repr__(self) -> str:
> > +            return f"<QAPIDoc.Section tag=3D{self.tag!r}
> text=3D{self.text!r}>"
>
> pylint points out
>
>     scripts/qapi/parser.py:677:43: E1101: Instance of 'Section' has no
> 'tag' member (no-member)
>
> Previous patch renamed it to @kind.
>
> > +
> >          def append_line(self, line: str) -> None:
> >              self.text +=3D line + '\n'
>
>
Oops. Was only linting qapidoc.py and not the parser.py stuff. Will fix for
v3.

--0000000000004385a1062bd63d95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 16,=
 2025 at 6:51=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Makes debugging far more pleasant when you can just print(section) and=
<br>
&gt; get something reasonable to display.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index c3004aa70c6..cb259c42a6d 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -673,6 +673,9 @@ def __init__(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section text without=
 tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D &#39;&#3=
9;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __repr__(self) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;&lt;QAPIDoc.S=
ection tag=3D{self.tag!r} text=3D{self.text!r}&gt;&quot;<br>
<br>
pylint points out<br>
<br>
=C2=A0 =C2=A0 scripts/qapi/parser.py:677:43: E1101: Instance of &#39;Sectio=
n&#39; has no &#39;tag&#39; member (no-member)<br>
<br>
Previous patch renamed it to @kind.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def append_line(self, line: str) -&g=
t; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text +=3D line + =
&#39;\n&#39;<br>
<br></blockquote><div><br></div><div>Oops. Was only linting qapidoc.py and =
not the parser.py stuff. Will fix for v3. <br></div></div></div>

--0000000000004385a1062bd63d95--


