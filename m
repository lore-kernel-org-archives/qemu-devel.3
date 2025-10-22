Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E2ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 00:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBMrQ-000854-Tx; Tue, 21 Oct 2025 20:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBMrO-00084f-79
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 20:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBMrJ-00038N-A6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 20:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761093461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+KMzEnjn33ZqfWfYmeD/CGQoDFyU3sQRyIYSyadcsUg=;
 b=XNSZSBoJKcL2GO/YVnCKrOWDnvd6RzKCtbQocH3ZFQNgk0zTv4+isCOShXr40dzxfoKRz0
 pE8qyRwPQFoDrH4PpldoZxO5E0CFkTwChrOjDjjj0G03fZMpmI0cL8i9UcNkrVMGYwpn18
 kVV89Dm8kwGytSLq0qOgg4DCA21bQBQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-O-XrnS_zOwK_b7nkjgjzOA-1; Tue, 21 Oct 2025 20:37:39 -0400
X-MC-Unique: O-XrnS_zOwK_b7nkjgjzOA-1
X-Mimecast-MFC-AGG-ID: O-XrnS_zOwK_b7nkjgjzOA_1761093458
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-78378ec9d66so77577457b3.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 17:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761093458; x=1761698258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KMzEnjn33ZqfWfYmeD/CGQoDFyU3sQRyIYSyadcsUg=;
 b=v74pCHSyGL811rcA8I9Xsjj7LkfJ3y4wttTdggky9cDYM6XwKySVBip7QHmUY0Ggnw
 p5EgrgjcKwPkF0ytSDzWe8C/ZMlsybuiJlVBHefAqEUkF3e5H/7hHWb4YBktKyuzSh3+
 wf4bZcHiqQhJmd//VHRM7IW+OdXbm/8d1yokgigKx0gl/RSyb8ApAfMoHIOpQizQv6uO
 9p655HP7f+jLQpxgWCmfVPNPXzwMv23fq9FNTQJHLoWHOwCIumV/5PVNevgXB0V0HdBJ
 fAGyalq5qsU+1mT4BYhqlVyE/xObi+j6CPow/3JidpRBzb+AEOl++5xRhlKGC5BoQE8U
 8HiQ==
X-Gm-Message-State: AOJu0Yw4kdOrzp2iADYmQzBafP2xr0x8G6FO9hNE/C4S37VjgDmGj4lK
 /3F3+Vp8pBf3dcocy4o6p9cVxTgu+eOX/XM0Tw7Z4usbx5xQ5LtWOV4v4BA7gN46uyCXqcr3umE
 3E8qj6o3sn661OOBj4jRQE9W29YKEapdhJBwd131EEwv2wzsLSjOeO4E+da1StTn0tGwYvJK7h7
 7IKwX2TF7UBfK6LYrOmh3jpi+qZs/W+wI=
X-Gm-Gg: ASbGncuPL3M3eJZYxd3/huIWgk1dI5SDHJ35BNeb0jzz+XDnOiuGSRorOrpI+A+8+q8
 BKaKdfyIR0oDvf/ZpY0I5oJ77LzknqLg3aGhbeG191trrl+7RXP2pvIcvT52YXvqZX+bbFD1pTD
 7MxARQJt3J2D4AtLQxFO7OAkVJ3GMQEN9fh2/55dSsPXuKHd3RAr+O
X-Received: by 2002:a05:690e:1553:10b0:63e:14b1:4811 with SMTP id
 956f58d0204a3-63e1617644fmr13606691d50.11.1761093458362; 
 Tue, 21 Oct 2025 17:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtVUn4n+Ch5zMK+qH4LOkEtWy+EQOlP2NR/N7t/fxtp/FJFMMNSli13nRcATYxwfIuC4hMYm3D8huugFOzVlU=
X-Received: by 2002:a05:690e:1553:10b0:63e:14b1:4811 with SMTP id
 956f58d0204a3-63e1617644fmr13606673d50.11.1761093457994; Tue, 21 Oct 2025
 17:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250916162404.9195-1-jsnow@redhat.com>
 <20250916162404.9195-5-jsnow@redhat.com>
 <7be48ced-52c0-4526-bcaa-632165408396@redhat.com>
In-Reply-To: <7be48ced-52c0-4526-bcaa-632165408396@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 21 Oct 2025 20:37:25 -0400
X-Gm-Features: AS18NWBIgFvmg8s5emFSXe4-2FxU1GwOkk2GeE61CE499SCaRjXHTwQcPvR2eHQ
Message-ID: <CAFn=p-Yf8Q3=4g+GoixLJAoLNoDUeN2MpUTot1TSPo_YhzVj6Q@mail.gmail.com>
Subject: Re: [PULL 04/19] python: backport 'protocol: adjust logging name when
 changing client name'
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fb01190641b485fd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000fb01190641b485fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025, 3:11=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 16/09/2025 18.23, John Snow wrote:
> > The client name is mutable, so the logging name should also change to
> > reflect it when it changes.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > cherry picked from commit
> python-qemu-qmp@e10b73c633ce138ba30bc8beccd2ab31989eaf3d
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   python/qemu/qmp/protocol.py | 24 ++++++++++++++++++++----
> >   1 file changed, 20 insertions(+), 4 deletions(-)
>
>   Hi John,
>
> there is a regression when running "scripts/device-crash-test -q": It now
> prints:
>
> ERROR: Negotiation failed: EOFError
> ERROR: Failed to establish session: EOFError
>
> all the time. See also for example:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/11715477453#L145
>
> Bisecting the issue pointed me to this patch here. Could you please have =
a
> look?
>
>   Thanks,
>    Thomas
>
>
> > diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> > index 86e588881b7..ec4762c567b 100644
> > --- a/python/qemu/qmp/protocol.py
> > +++ b/python/qemu/qmp/protocol.py
> > @@ -217,10 +217,8 @@ class AsyncProtocol(Generic[T]):
> >       # -------------------------
> >
> >       def __init__(self, name: Optional[str] =3D None) -> None:
> > -        #: The nickname for this connection, if any.
> > -        self.name: Optional[str] =3D name
> > -        if self.name is not None:
> > -            self.logger =3D self.logger.getChild(self.name)
> > +        self._name: Optional[str]
> > +        self.name =3D name
> >
> >           # stream I/O
> >           self._reader: Optional[StreamReader] =3D None
> > @@ -257,6 +255,24 @@ def __repr__(self) -> str:
> >           tokens.append(f"runstate=3D{self.runstate.name}")
> >           return f"<{cls_name} {' '.join(tokens)}>"
> >
> > +    @property
> > +    def name(self) -> Optional[str]:
> > +        """
> > +        The nickname for this connection, if any.
> > +
> > +        This name is used for differentiating instances in debug outpu=
t.
> > +        """
> > +        return self._name
> > +
> > +    @name.setter
> > +    def name(self, name: Optional[str]) -> None:
> > +        logger =3D logging.getLogger(__name__)
> > +        if name:
> > +            self.logger =3D logger.getChild(name)
> > +        else:
> > +            self.logger =3D logger
> > +        self._name =3D name
> > +
> >       @property  # @upper_half
> >       def runstate(self) -> Runstate:
> >           """The current `Runstate` of the connection."""
>

... odd that it's this patch. I will have a look and issue a fix shortly.

Thanks for the report.

--000000000000fb01190641b485fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 15, 2025, 3:11=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 16/09/2025 18.23,=
 John Snow wrote:<br>
&gt; The client name is mutable, so the logging name should also change to<=
br>
&gt; reflect it when it changes.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; cherry picked from commit python-qemu-qmp@e10b73c633ce138ba30bc8beccd2=
ab31989eaf3d<br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0python/qemu/qmp/protocol.py | 24 ++++++++++++++++++++----<=
br>
&gt;=C2=A0 =C2=A01 file changed, 20 insertions(+), 4 deletions(-)<br>
<br>
=C2=A0 Hi John,<br>
<br>
there is a regression when running &quot;scripts/device-crash-test -q&quot;=
: It now <br>
prints:<br>
<br>
ERROR: Negotiation failed: EOFError<br>
ERROR: Failed to establish session: EOFError<br>
<br>
all the time. See also for example:<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/11715477453#L145" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/11715477453#L145</a><br>
<br>
Bisecting the issue pointed me to this patch here. Could you please have a =
look?<br>
<br>
=C2=A0 Thanks,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
<br>
&gt; diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py=
<br>
&gt; index 86e588881b7..ec4762c567b 100644<br>
&gt; --- a/python/qemu/qmp/protocol.py<br>
&gt; +++ b/python/qemu/qmp/protocol.py<br>
&gt; @@ -217,10 +217,8 @@ class AsyncProtocol(Generic[T]):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# -------------------------<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def __init__(self, name: Optional[str] =3D N=
one) -&gt; None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 #: The nickname for this connection, if a=
ny.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name" rel=3D"noref=
errer noreferrer" target=3D"_blank">self.name</a>: Optional[str] =3D name<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://self.name" rel=3D"no=
referrer noreferrer" target=3D"_blank">self.name</a> is not None:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger =3D self.logger=
.getChild(<a href=3D"http://self.name" rel=3D"noreferrer noreferrer" target=
=3D"_blank">self.name</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._name: Optional[str]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.name" rel=3D"noref=
errer noreferrer" target=3D"_blank">self.name</a> =3D name<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# stream I/O<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._reader: Optional[StreamR=
eader] =3D None<br>
&gt; @@ -257,6 +255,24 @@ def __repr__(self) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tokens.append(f&quot;runstate=
=3D{<a href=3D"http://self.runstate.name" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">self.runstate.name</a>}&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return f&quot;&lt;{cls_name} {=
&#39; &#39;.join(tokens)}&gt;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 @property<br>
&gt; +=C2=A0 =C2=A0 def name(self) -&gt; Optional[str]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The nickname for this connection, if any.=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 This name is used for differentiating ins=
tances in debug output.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._name<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @name.setter<br>
&gt; +=C2=A0 =C2=A0 def name(self, name: Optional[str]) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(__name__)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if name:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger =3D logger.getC=
hild(name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger =3D logger<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._name =3D name<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@property=C2=A0 # @upper_half<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def runstate(self) -&gt; Runstate:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The current =
`Runstate` of the connection.&quot;&quot;&quot;<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">... odd that it&#39;s this p=
atch. I will have a look and issue a fix shortly.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Thanks for the report.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fb01190641b485fd--


