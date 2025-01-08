Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A909E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdRf-0000hJ-Fp; Wed, 08 Jan 2025 16:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdRa-0000gZ-Fm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdRX-0005Ck-3U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736371101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDPxfsGHj4pCbSf5mPsZPhRAO1dq6Qr6r72Z+W/S8qk=;
 b=GDDAL8CtbwTsTDcCX2595rrDYmrNV1e0vqi9rA/nuXdRZfY1kLC8Qjd+BCcLsEdTCgNysQ
 rG9t15dg6MGs8YHM266JZYEcLtZ/fYg27gWEZgYEeMI0ueHd1wntp4THKlytfWXJxEN2G3
 YyqdSCTcn7kreFanbCAkzXZznRA+3w0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-hYTRtmbqOEWK5g2SLwlsUA-1; Wed, 08 Jan 2025 16:18:20 -0500
X-MC-Unique: hYTRtmbqOEWK5g2SLwlsUA-1
X-Mimecast-MFC-AGG-ID: hYTRtmbqOEWK5g2SLwlsUA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef7fbd99a6so376291a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736371099; x=1736975899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDPxfsGHj4pCbSf5mPsZPhRAO1dq6Qr6r72Z+W/S8qk=;
 b=Od6eAPpQA8vuyoDQn9fLvMuRFzbWiVZqEA5XGD6yWhj5kJ1wVyEIFxeyCRT72Fjvq7
 h1olhXisuOhMr3ipNHCAZWbVxrS5bbDK3vQHPF2KamZJW9MzNNYLstLuyFEsmxeGhKsk
 tPMqtFkTTBTAZvAdJxRVk7MWholjR4hA6Q5X9dyI/BYb9a9BHsVljyOUfGCmRaL1HegH
 AFhx+HME9rYmWo8pVip8YQyqvo8Sxpot0HFTdxrL8++10X72ifKdbYMMpeAezQIPm76w
 oLrLygUhdFbKJW98zzJobd65tzeyy3LJS4RinwGYposMt5nBIdNJcbqFH8uPURANGL7n
 juwA==
X-Gm-Message-State: AOJu0Yz+XOQvFnyfI+6zb17d1oM9ZxUY0GTU7zOqq5++DV3gDrdWcSf8
 c7TMR+cFvdcyhHHPu+1TH76TKCHNhWM4CAndHHSFec2wmFXgFXmADmdmBOOt7U0p0XpNWvvWZVp
 YrraBn0/JrsmED1oR04R9DpZ3+ljpnsy/Q85YPEEIyo6PjaaOJ4cQ7v+3mRHq72dLW+j2tf8B5L
 Sx+p29wiRk/IktzoS5zJHb4RE+mdQ=
X-Gm-Gg: ASbGncsI+rTHIsKmo5qpsuXBknYY+OjVPkWTzJwv44rBvpadX0AHzzo030vhIPjtWH7
 D2dSoxiDb5+2JIl1wedWfuQPrZHY9rySUnNYcufIOj2ySF5LxBAFCPYdKxseOqyzhryo/xQ==
X-Received: by 2002:a17:90b:2652:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f548f44334mr5689034a91.26.1736371098971; 
 Wed, 08 Jan 2025 13:18:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPIFl2eEGgPTDDmbi4BEjYibDOfjbLx3vUJmbNG6yoJmJWJrmR9GdcOlikzXWdZO7oOKbQ1JLkfyzimDawtBQ=
X-Received: by 2002:a17:90b:2652:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f548f44334mr5689008a91.26.1736371098631; Wed, 08 Jan 2025
 13:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-10-jsnow@redhat.com>
 <87h66y4hgl.fsf@pond.sub.org>
In-Reply-To: <87h66y4hgl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 8 Jan 2025 16:18:07 -0500
X-Gm-Features: AbW1kvYg78JQGGUoRrOClqJHWsEiAVfl5xIFbkXtew7esmL2lYeOwHQNz9Yrg_M
Message-ID: <CAFn=p-YBsJBNFWrX=XLF1TaWPjSA5kNhg3spf83Cw9_JnS2_pw@mail.gmail.com>
Subject: Re: [PATCH 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000885e06062b3866d0"
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

--000000000000885e06062b3866d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 8:22=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is for the sake of the new rST generator (the "transmogrifier") so
> > we can advance multiple lines on occasion while keeping the
> > generated<-->source mappings accurate.
> >
> > next_line now simply takes an optional n parameter which chooses the
> > number of lines to advance.
> >
> >
> > RFC: Here's the exorbitant detail on why I want this:
> >
> > This is used mainly when converting section syntax in free-form
> > documentation to more traditional rST section header syntax, which
> > does not always line up 1:1 for line counts.
> >
> > For example:
> >
> > ```
> >  ##
> >  # =3D Section     <-- Info is pointing here, "L1"
> >  #
> >  # Lorem Ipsum
> >  ##
> > ```
> >
> > would be transformed to rST as:
> >
> > ```
> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> > Section        <-- L1
> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
> >                <-- L2
> > Lorem Ipsum    <-- L3
> > ```
>
> I can't help to wonder...  Could we simply use rST markup instead?
>
> "Later", "maybe later", or even "please ask me later" would be perfectly
> acceptable answers.
>

Yeah, I'd be happy with that, I just didn't want to add more complexity to
the pile so I went for what I felt was "simplest":

- Leave source syntax alone
- Copy and modify the existing freeform doc parser
- Quickly allow for multi-line advancing where it appeared to be important.

Modifying freeform syntax to be purely rST that isn't modified or rewritten
at all has benefits:

- No need to mangle or multiplex source line source information
- Less code
- More straightforward

I'm quite happy to do it later, is there some kind of "ticket" system you'd
tolerate using for tracking nits for cleanup? I *will* forget if we don't
listify and track them, I'm sorry (but wise enough) to admit. I just don't
want to get sidetracked on little side-quests right now. (Quite prone to
this...)


>
> > After consuming the single "Section" line from the source, we want to
> > advance the source pointer to the next non-empty line which requires
> > jumping by more than one line.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/source.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> > index 7b379fdc925..ffdc3f482ac 100644
> > --- a/scripts/qapi/source.py
> > +++ b/scripts/qapi/source.py
> > @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
> >          self.defn_meta =3D meta
> >          self.defn_name =3D name
> >
> > -    def next_line(self: T) -> T:
> > +    def next_line(self: T, n: int =3D 1) -> T:
> >          info =3D copy.copy(self)
> > -        info.line +=3D 1
> > +        info.line +=3D n
> >          return info
> >
> >      def loc(self) -> str:
>
> Assuming we need this:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>


Thanks! We can always drop stuff later if we wind up not needing it, it's
just a means to an end.

--js

--000000000000885e06062b3866d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20,=
 2024 at 8:22=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This is for the sake of the new rST generator (the &quot;transmogrifie=
r&quot;) so<br>
&gt; we can advance multiple lines on occasion while keeping the<br>
&gt; generated&lt;--&gt;source mappings accurate.<br>
&gt;<br>
&gt; next_line now simply takes an optional n parameter which chooses the<b=
r>
&gt; number of lines to advance.<br>
&gt;<br>
&gt;<br>
&gt; RFC: Here&#39;s the exorbitant detail on why I want this:<br>
&gt;<br>
&gt; This is used mainly when converting section syntax in free-form<br>
&gt; documentation to more traditional rST section header syntax, which<br>
&gt; does not always line up 1:1 for line counts.<br>
&gt;<br>
&gt; For example:<br>
&gt;<br>
&gt; ```<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # =3D Section=C2=A0 =C2=A0 =C2=A0&lt;-- Info is pointing here, &=
quot;L1&quot;<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Lorem Ipsum<br>
&gt;=C2=A0 ##<br>
&gt; ```<br>
&gt;<br>
&gt; would be transformed to rST as:<br>
&gt;<br>
&gt; ```<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt; Section=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- L2<br>
&gt; Lorem Ipsum=C2=A0 =C2=A0 &lt;-- L3<br>
&gt; ```<br>
<br>
I can&#39;t help to wonder...=C2=A0 Could we simply use rST markup instead?=
<br>
<br>
&quot;Later&quot;, &quot;maybe later&quot;, or even &quot;please ask me lat=
er&quot; would be perfectly<br>
acceptable answers.<br></blockquote><div><br></div><div>Yeah, I&#39;d be ha=
ppy with that, I just didn&#39;t want to add more complexity to the pile so=
 I went for what I felt was &quot;simplest&quot;:</div><div><br></div><div>=
- Leave source syntax alone</div><div>- Copy and modify the existing freefo=
rm doc parser</div><div>- Quickly allow for multi-line advancing where it a=
ppeared to be important.</div><div><br></div><div>Modifying freeform syntax=
 to be purely rST that isn&#39;t modified or rewritten at all has benefits:=
</div><div><br></div><div>- No need to mangle or multiplex source line sour=
ce information</div><div>- Less code</div><div>- More straightforward<br></=
div><div><br></div><div>I&#39;m quite happy to do it later, is there some k=
ind of &quot;ticket&quot; system you&#39;d tolerate using for tracking nits=
 for cleanup? I *will* forget if we don&#39;t listify and track them, I&#39=
;m sorry (but wise enough) to admit. I just don&#39;t want to get sidetrack=
ed on little side-quests right now. (Quite prone to this...)<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; After consuming the single &quot;Section&quot; line from the source, w=
e want to<br>
&gt; advance the source pointer to the next non-empty line which requires<b=
r>
&gt; jumping by more than one line.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/source.py | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py<br>
&gt; index 7b379fdc925..ffdc3f482ac 100644<br>
&gt; --- a/scripts/qapi/source.py<br>
&gt; +++ b/scripts/qapi/source.py<br>
&gt; @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -&gt; None:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.defn_meta =3D meta<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.defn_name =3D name<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def next_line(self: T) -&gt; T:<br>
&gt; +=C2=A0 =C2=A0 def next_line(self: T, n: int =3D 1) -&gt; T:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D copy.copy(self)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 info.line +=3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info.line +=3D n<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return info<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def loc(self) -&gt; str:<br>
<br>
Assuming we need this:<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;</blockquote><div><br></div><div>Th=
anks! We can always drop stuff later if we wind up not needing it, it&#39;s=
 just a means to an end.</div><div><br></div><div>--js <br></div></div></di=
v>

--000000000000885e06062b3866d0--


