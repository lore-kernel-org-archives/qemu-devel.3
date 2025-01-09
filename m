Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99099E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwBw-0002BW-TY; Thu, 09 Jan 2025 12:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwBu-0002B0-HH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwBs-0000XL-JK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736443166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sff78c02fa4ryDeTV7DAmmR6tax8ftfNV516k4ExTTU=;
 b=VGLm/GampX6Ic+5eQHpDMC8ghDr31YpNeos8Vww4wexKuR9ErkHZIDBYfzHblzdlvNR57D
 wQzBqHm13hAgwO80GeeKlpTQ0uQTubhvvXxd91vRQYfhRvgEua2wJTXTYpWn2VkV+e9tdZ
 TH4lRs29tUgZiNoljlnKozLMSmOsi+4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-3m1n1b6dM-uO3DRSAbhAyg-1; Thu, 09 Jan 2025 12:19:23 -0500
X-MC-Unique: 3m1n1b6dM-uO3DRSAbhAyg-1
X-Mimecast-MFC-AGG-ID: 3m1n1b6dM-uO3DRSAbhAyg
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2161d185f04so14324645ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443162; x=1737047962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sff78c02fa4ryDeTV7DAmmR6tax8ftfNV516k4ExTTU=;
 b=AsEaAyC4FIzPcZPaCN7vO6VkOsOvQ2eH91raWEdQDG/GKxgG/QKPJbuUBMgcFnF/In
 1bmuVVOs3H3P+Ms5NvNxrf/SFYhO/+vyoUIk/+PFMN1dkfIUTEbx92Rr7HkIA1BpOSkb
 S5lNNHm8vQSA+XuSmlzVDD1nQkz9L5llON+Ibn80fwsADPwDU8EZ4fX4EII5Xbdc9KZv
 zXOYONv7rht/cr+8B+fV2KxbOwHNoAikncdrqH/r43k1JhUhe6oKaM/tnHaqUSiO53AM
 0UNy8j79c2CGMI0RDnXoDlBn0hlYUGN+mr5feCtyMCXNfxqe4YquMiZUuVnV5sCzT0zZ
 GcrA==
X-Gm-Message-State: AOJu0Yx6GMwATl8lk98RPfeCfcb+zKh/U4YkDZ5VBVIGZOr68D9vFL+H
 9LfreM5lecgKzEQ+14qlN8JaIUTknnNhiojkOeHvh9Co5+vxc2wJTbvvxmAa1ydskxO7ksDDvZK
 LEGl1idYaXBP0ACttg7O1qOydkDqP0E0ekEWUDEvOB5GmdLk8DqFSnmrpWNuBPoGbKO5E9X69Ue
 vV0DDiG4S4JG/3UJv9WOh/iiTCFk+Pz75SodE=
X-Gm-Gg: ASbGnctgZSmkvJ+U2W0Y3rbIydcwP+3cWzvJy0b/8Y/LPMro+PvADQeFKLn+nQuz/tv
 e1bqk8iyyH4TnInf15g9M8SYOx/4JPhnb/WyRKFs8cGgLcpqGyMtN1VHA17J83r2wCM2NVQ==
X-Received: by 2002:a17:902:d48a:b0:215:a97a:c6bb with SMTP id
 d9443c01a7336-21a83f36e9dmr110151175ad.12.1736443161754; 
 Thu, 09 Jan 2025 09:19:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa2tJmOOW5ArPDgGwRYMlGLxjLJfCWopuqa07PNk4WDYMEscr/xz0nomv2fAVHG56cDeKOvInenPW1eoyLnp8=
X-Received: by 2002:a17:902:d48a:b0:215:a97a:c6bb with SMTP id
 d9443c01a7336-21a83f36e9dmr110150895ad.12.1736443161353; Thu, 09 Jan 2025
 09:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-10-jsnow@redhat.com>
 <87h66y4hgl.fsf@pond.sub.org>
 <CAFn=p-YBsJBNFWrX=XLF1TaWPjSA5kNhg3spf83Cw9_JnS2_pw@mail.gmail.com>
 <87plkwto0z.fsf@pond.sub.org>
In-Reply-To: <87plkwto0z.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Jan 2025 12:19:09 -0500
X-Gm-Features: AbW1kvYhGb6z9_oi11MqzMxt7SIkvbRVypxPjGeFhUZ98M3reQ_w-YOoaufrtCU
Message-ID: <CAFn=p-aH0Py8qTiSO01Gc3r==gcTcYBm9zY4TT-x5wbaVxTo6g@mail.gmail.com>
Subject: Re: [PATCH 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ce3d97062b492df3"
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

--000000000000ce3d97062b492df3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025, 3:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Dec 20, 2024 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > This is for the sake of the new rST generator (the "transmogrifier")
> so
> >> > we can advance multiple lines on occasion while keeping the
> >> > generated<-->source mappings accurate.
> >> >
> >> > next_line now simply takes an optional n parameter which chooses the
> >> > number of lines to advance.
> >> >
> >> >
> >> > RFC: Here's the exorbitant detail on why I want this:
> >> >
> >> > This is used mainly when converting section syntax in free-form
> >> > documentation to more traditional rST section header syntax, which
> >> > does not always line up 1:1 for line counts.
> >> >
> >> > For example:
> >> >
> >> > ```
> >> >  ##
> >> >  # =3D Section     <-- Info is pointing here, "L1"
> >> >  #
> >> >  # Lorem Ipsum
> >> >  ##
> >> > ```
> >> >
> >> > would be transformed to rST as:
> >> >
> >> > ```
> >> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> >> > Section        <-- L1
> >> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> >> >                <-- L2
> >> > Lorem Ipsum    <-- L3
> >> > ```
> >>
> >> I can't help to wonder...  Could we simply use rST markup instead?
> >>
> >> "Later", "maybe later", or even "please ask me later" would be perfect=
ly
> >> acceptable answers.
> >>
> >
> > Yeah, I'd be happy with that, I just didn't want to add more complexity
> to
> > the pile so I went for what I felt was "simplest":
>
> Avoiding mission creep is good.
>
> > - Leave source syntax alone
> > - Copy and modify the existing freeform doc parser
> > - Quickly allow for multi-line advancing where it appeared to be
> important.
> >
> > Modifying freeform syntax to be purely rST that isn't modified or
> rewritten
> > at all has benefits:
> >
> > - No need to mangle or multiplex source line source information
> > - Less code
> > - More straightforward
> >
> > I'm quite happy to do it later, is there some kind of "ticket" system
> you'd
> > tolerate using for tracking nits for cleanup? I *will* forget if we don=
't
> > listify and track them, I'm sorry (but wise enough) to admit. I just
> don't
> > want to get sidetracked on little side-quests right now. (Quite prone t=
o
> > this...)
>
> TODO comment in code this would obviously kill?  Not exactly a ticket
> system...
>
> scripts/qapi/TODO?  Still not a ticket system...
>

If a TODO is fine (and you don't mind pinging me in the future), then the
comment I left in the visit_freeform() function (it's in another patch)
explaining that the custom parser can be dropped after we sunset the old
qapidoc is likely sufficient if I just add a "TODO".

Sound good?


> Other ideas?
>
> >> > After consuming the single "Section" line from the source, we want t=
o
> >> > advance the source pointer to the next non-empty line which requires
> >> > jumping by more than one line.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/source.py | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> >> > index 7b379fdc925..ffdc3f482ac 100644
> >> > --- a/scripts/qapi/source.py
> >> > +++ b/scripts/qapi/source.py
> >> > @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
> >> >          self.defn_meta =3D meta
> >> >          self.defn_name =3D name
> >> >
> >> > -    def next_line(self: T) -> T:
> >> > +    def next_line(self: T, n: int =3D 1) -> T:
> >> >          info =3D copy.copy(self)
> >> > -        info.line +=3D 1
> >> > +        info.line +=3D n
> >> >          return info
> >> >
> >> >      def loc(self) -> str:
> >>
> >> Assuming we need this:
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >
> > Thanks! We can always drop stuff later if we wind up not needing it, it=
's
> > just a means to an end.
>
> Yes, and this one isn't exactly a complexity bomb :)
>

--000000000000ce3d97062b492df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2025, 3:00=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Dec 20, 2024 at 8:22=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; This is for the sake of the new rST generator (the &quot;tran=
smogrifier&quot;) so<br>
&gt;&gt; &gt; we can advance multiple lines on occasion while keeping the<b=
r>
&gt;&gt; &gt; generated&lt;--&gt;source mappings accurate.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; next_line now simply takes an optional n parameter which choo=
ses the<br>
&gt;&gt; &gt; number of lines to advance.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; RFC: Here&#39;s the exorbitant detail on why I want this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is used mainly when converting section syntax in free-fo=
rm<br>
&gt;&gt; &gt; documentation to more traditional rST section header syntax, =
which<br>
&gt;&gt; &gt; does not always line up 1:1 for line counts.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; For example:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;=C2=A0 ##<br>
&gt;&gt; &gt;=C2=A0 # =3D Section=C2=A0 =C2=A0 =C2=A0&lt;-- Info is pointin=
g here, &quot;L1&quot;<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # Lorem Ipsum<br>
&gt;&gt; &gt;=C2=A0 ##<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; would be transformed to rST as:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br=
>
&gt;&gt; &gt; Section=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;--=
 L2<br>
&gt;&gt; &gt; Lorem Ipsum=C2=A0 =C2=A0 &lt;-- L3<br>
&gt;&gt; &gt; ```<br>
&gt;&gt;<br>
&gt;&gt; I can&#39;t help to wonder...=C2=A0 Could we simply use rST markup=
 instead?<br>
&gt;&gt;<br>
&gt;&gt; &quot;Later&quot;, &quot;maybe later&quot;, or even &quot;please a=
sk me later&quot; would be perfectly<br>
&gt;&gt; acceptable answers.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yeah, I&#39;d be happy with that, I just didn&#39;t want to add more c=
omplexity to<br>
&gt; the pile so I went for what I felt was &quot;simplest&quot;:<br>
<br>
Avoiding mission creep is good.<br>
<br>
&gt; - Leave source syntax alone<br>
&gt; - Copy and modify the existing freeform doc parser<br>
&gt; - Quickly allow for multi-line advancing where it appeared to be impor=
tant.<br>
&gt;<br>
&gt; Modifying freeform syntax to be purely rST that isn&#39;t modified or =
rewritten<br>
&gt; at all has benefits:<br>
&gt;<br>
&gt; - No need to mangle or multiplex source line source information<br>
&gt; - Less code<br>
&gt; - More straightforward<br>
&gt;<br>
&gt; I&#39;m quite happy to do it later, is there some kind of &quot;ticket=
&quot; system you&#39;d<br>
&gt; tolerate using for tracking nits for cleanup? I *will* forget if we do=
n&#39;t<br>
&gt; listify and track them, I&#39;m sorry (but wise enough) to admit. I ju=
st don&#39;t<br>
&gt; want to get sidetracked on little side-quests right now. (Quite prone =
to<br>
&gt; this...)<br>
<br>
TODO comment in code this would obviously kill?=C2=A0 Not exactly a ticket<=
br>
system...<br>
<br>
scripts/qapi/TODO?=C2=A0 Still not a ticket system...<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">If a TODO is fine (and=
 you don&#39;t mind pinging me in the future), then the comment I left in t=
he visit_freeform() function (it&#39;s in another patch) explaining that th=
e custom parser can be dropped after we sunset the old qapidoc is likely su=
fficient if I just add a &quot;TODO&quot;.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Sound good?</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Other ideas?<br>
<br>
&gt;&gt; &gt; After consuming the single &quot;Section&quot; line from the =
source, we want to<br>
&gt;&gt; &gt; advance the source pointer to the next non-empty line which r=
equires<br>
&gt;&gt; &gt; jumping by more than one line.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/source.py | 4 ++--<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py<=
br>
&gt;&gt; &gt; index 7b379fdc925..ffdc3f482ac 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/source.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/source.py<br>
&gt;&gt; &gt; @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -&=
gt; None:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.defn_meta =3D meta<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.defn_name =3D name<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 def next_line(self: T) -&gt; T:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 def next_line(self: T, n: int =3D 1) -&gt; T:<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D copy.copy(self)<br=
>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 info.line +=3D 1<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info.line +=3D n<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return info<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def loc(self) -&gt; str:<br>
&gt;&gt;<br>
&gt;&gt; Assuming we need this:<br>
&gt;&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Thanks! We can always drop stuff later if we wind up not needing it, i=
t&#39;s<br>
&gt; just a means to an end.<br>
<br>
Yes, and this one isn&#39;t exactly a complexity bomb :)<br>
</blockquote></div></div></div>

--000000000000ce3d97062b492df3--


