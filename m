Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA35C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTwW-0006Ww-A2; Tue, 20 May 2025 16:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHTwU-0006Wg-Jn
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHTwS-0000rQ-17
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747774321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPeBfAUKbNd9CQESWRz8j/9u8ACqq4WOETZtVvZTLAI=;
 b=hdrNTsI4GCWGiyrCiY6L4eC13T41ZYmLR5+tqCx0SXxJksGRd5JlOtSBDWZhgOEs0vHt6B
 kNbsd4k8mwGcz0ddnXC1OG+zArljcrXfKKZGS0k9rP+qnAOOWMN9XNujI/POD5SqzvbloM
 A88GiGNUvh0usoebaMv0B9SaGb/cimA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-dVHjtLEoNmWwTN4eSTreHg-1; Tue, 20 May 2025 16:51:59 -0400
X-MC-Unique: dVHjtLEoNmWwTN4eSTreHg-1
X-Mimecast-MFC-AGG-ID: dVHjtLEoNmWwTN4eSTreHg_1747774317
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so35456635e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 13:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747774317; x=1748379117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPeBfAUKbNd9CQESWRz8j/9u8ACqq4WOETZtVvZTLAI=;
 b=MkV9VzxEdCnNkLJ+xFV2PR1TUB6a44el5n+odIV2w2EXpbmDFT2wEFWLjp/NwIBzMW
 uh/aZ996kH3Fe3nqiVX9ukM3+JI93mu3FZ2FCksxgFjDJDA+IPNgmPAYEUkJwfZvcF5q
 ikHKfXSOGTe7yMruCnyzZo57JmeAZOAvPhnDJ3iYOVVjcmIk7hbT1GFmhp5DHXD5WVz6
 U7olPSosFh8o54dBnI6BEtEIVm3g17wcvOOlWVq298DkzQD66X/B1be3kY/pPTfs9hMK
 BHMb3J09RdVmiKQ7lkpZwRc/fdqpFyFQ+xkr4UlzinbD0mJQ84uQgqJrsaiD/F1gPzYZ
 UrbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBhTwar+F0f82unvQSS5AJ+ly3Eo3QTKmpB2uX7q7g2FwnLprb6JUJw5TQ91jLdi3/M/bPuj76ST5z@nongnu.org
X-Gm-Message-State: AOJu0YzoygWNjwoX9LJ4cc/am/6LG0LztJlzTqeyU4KIXoEwwVASb1Su
 t+ilMreiUuXtbHg1hBEX3Z7oCKiGdB/DM65mlZBz0J38C8H4rUaTk//upTLmw40pcOrrOatLTtr
 dDl5U5DtSlawGjUYT748timU8E0lJSxeMPc8X6ovucwoPp8VWnpTnSaCQRm3i0K/hgaRTtMhkJ/
 PnCHeZyzWhX3VKueZ5UK1OEjLHhUdAjY8=
X-Gm-Gg: ASbGncvlYurIM0HrTPy1PYI8VHNI67r8bv2tFM6qFWRm0eF/rUsLGoES10qcr2ElpuW
 qxurh+BGOQBaO6PtheoIY8sT3JYfwXaGWEwg0DdO9MDVahBN4PzdIDEn3sBNTT3E7doU=
X-Received: by 2002:a05:600c:1d82:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-442ff03c2d7mr151220985e9.29.1747774317148; 
 Tue, 20 May 2025 13:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpJY9BeVtXZ/0uVI7ED/yxVlq5cOKvH+oY7z2n+QZinICrWjvJLz5onZ0kujW4CPh+OHSFxWn6PGRV69d0DHM=
X-Received: by 2002:a05:600c:1d82:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-442ff03c2d7mr151220845e9.29.1747774316732; Tue, 20 May 2025
 13:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
 <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
In-Reply-To: <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 May 2025 22:51:45 +0200
X-Gm-Features: AX0GCFsDFQ043J860kY2AzPkToxbrtplEaWUXf5JBAdT7Odu7SmFSFfH5ULJBuQ
Message-ID: <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Tanish Desai <tanishdesai37@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="0000000000004bffbe0635976b04"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000004bffbe0635976b04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 20 mag 2025, 21:01 Stefan Hajnoczi <stefanha@gmail.com> ha scritto:

> On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <tanishdesai37@gmail=
.com>
> wrote:
> >
> > Remove hot paths from .c file and added it in .h file to keep it inline=
.
>
> Please include performance results in the commit description so it's
> clear what impact this change has.
>

Hi Stefan,

I am replying because I take the blame for this :) and as an example of how
he could interact with the maintainer.

For now we mostly looked at differences between the code that tracetool
generates for the various backends, and the observation that some of them
put code in the .h and some in the .c file. I explained to Tanish the
concept of separating hot vs cold code in theory, showed him some examples
in QEMU where performance measurements were done in the past, and suggested
applying this to various backends (starting with the one with the weirdest
choice!). However we didn't do any measurement yet.

Some possibilities that come to mind:

1) maybe the coroutine benchmarks are enough to show a difference, with
some luck

2) a new microbenchmark (or a set of microbenchmarks that try various level
of register pressure around the tracepoint), which would be nice to have
anyway

3) perhaps we could try to check the code size for some object files in
block/ (for example libblock.a.p/*.c.o), as a proxy for how much
instruction cache space is saved when all tracepoints are disabled

We can start from 3, but also try 1+3 and 2+3 if it fails if you think that
would be more persuasive.

Thanks,

Paolo

>
> > Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> > ---
> >  scripts/tracetool/backend/simple.py | 23 ++++++++++-------------
>
> Please use scripts/get_maintainer.pl to find the emails to CC:
>
>   $ scripts/get_maintainer.pl -f scripts/tracetool/backend/simple.py
>   Stefan Hajnoczi <stefanha@redhat.com> (maintainer:Tracing)
>   Mads Ynddal <mads@ynddal.dk> (reviewer:Tracing)
>   qemu-devel@nongnu.org (open list:All patches CC here)
>
> qemu-devel is a high-traffic list and maintainers may not see your
> patches unless you CC them.
>
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/scripts/tracetool/backend/simple.py
> b/scripts/tracetool/backend/simple.py
> > index a74d61fcd6..2688d4b64b 100644
> > --- a/scripts/tracetool/backend/simple.py
> > +++ b/scripts/tracetool/backend/simple.py
> > @@ -36,8 +36,17 @@ def generate_h_begin(events, group):
> >
> >
> >  def generate_h(event, group):
> > -    out('    _simple_%(api)s(%(args)s);',
> > +    event_id =3D 'TRACE_' + event.name.upper()
> > +    if "vcpu" in event.properties:
> > +        # already checked on the generic format code
> > +        cond =3D "true"
> > +    else:
> > +        cond =3D "trace_event_get_state(%s)" % event_id
> > +    out('    if (%(cond)s) {',
> > +        '        _simple_%(api)s(%(args)s);',
> > +        '    }',
> >          api=3Devent.api(),
> > +        cond=3Dcond,
> >          args=3D", ".join(event.args.names()))
> >
> >
> > @@ -72,22 +81,10 @@ def generate_c(event, group):
> >      if len(event.args) =3D=3D 0:
> >          sizestr =3D '0'
> >
> > -    event_id =3D 'TRACE_' + event.name.upper()
> > -    if "vcpu" in event.properties:
> > -        # already checked on the generic format code
> > -        cond =3D "true"
> > -    else:
> > -        cond =3D "trace_event_get_state(%s)" % event_id
> > -
> >      out('',
> > -        '    if (!%(cond)s) {',
> > -        '        return;',
> > -        '    }',
> > -        '',
> >          '    if (trace_record_start(&rec, %(event_obj)s.id,
> %(size_str)s)) {',
> >          '        return; /* Trace Buffer Full, Event Dropped ! */',
> >          '    }',
> > -        cond=3Dcond,
> >          event_obj=3Devent.api(event.QEMU_EVENT),
> >          size_str=3Dsizestr)
> >
> > --
> > 2.34.1
> >
> >
>
>

--0000000000004bffbe0635976b04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 20 mag 2025, 21:01 Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">stefanha@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish D=
esai &lt;<a href=3D"mailto:tanishdesai37@gmail.com" rel=3D"noreferrer noref=
errer noreferrer" target=3D"_blank">tanishdesai37@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; Remove hot paths from .c file and added it in .h file to keep it inlin=
e.<br>
<br>
Please include performance results in the commit description so it&#39;s<br=
>
clear what impact this change has.<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Hi Stefan,</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I am replying because I take the blame for this :) and=
 as an example of how he could interact with the  maintainer.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">For now we mostly looked at differenc=
es between the code that tracetool generates for the various backends, and =
the observation that some of them put code in the .h and some in the .c fil=
e. I explained to Tanish the concept of separating hot vs cold code in theo=
ry, showed him some examples in QEMU where performance measurements were do=
ne in the past, and suggested applying this to various backends (starting w=
ith the one with the weirdest choice!). However we didn&#39;t do any measur=
ement yet.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Some possibil=
ities that come to mind:</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>1) maybe the coroutine benchmarks are enough to show a difference, with so=
me luck</div><div dir=3D"auto"><br></div><div dir=3D"auto">2) a new microbe=
nchmark (or a set of microbenchmarks that try various level of register pre=
ssure around the tracepoint), which would be nice to have anyway</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">3) perhaps we could try to check t=
he code size for some object files in block/ (for example libblock.a.p/*.c.=
o), as a proxy for how much instruction cache space is saved when all trace=
points are disabled</div><div dir=3D"auto"><br></div><div dir=3D"auto">We c=
an start from 3, but also try 1+3 and 2+3 if it fails if you think that wou=
ld be more persuasive.</div><div dir=3D"auto"><br></div><div dir=3D"auto">T=
hanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">&gt;<br>
&gt; Signed-off-by: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.=
com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">tanishdesai=
37@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/tracetool/backend/simple.py | 23 ++++++++++-------------=
<br>
<br>
Please use scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer n=
oreferrer noreferrer noreferrer" target=3D"_blank">get_maintainer.pl</a> to=
 find the emails to CC:<br>
<br>
=C2=A0 $ scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer nor=
eferrer noreferrer noreferrer" target=3D"_blank">get_maintainer.pl</a> -f s=
cripts/tracetool/backend/simple.py<br>
=C2=A0 Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" rel=3D"no=
referrer noreferrer noreferrer" target=3D"_blank">stefanha@redhat.com</a>&g=
t; (maintainer:Tracing)<br>
=C2=A0 Mads Ynddal &lt;<a href=3D"mailto:mads@ynddal.dk" rel=3D"noreferrer =
noreferrer noreferrer" target=3D"_blank">mads@ynddal.dk</a>&gt; (reviewer:T=
racing)<br>
=C2=A0 <a href=3D"mailto:qemu-devel@nongnu.org" rel=3D"noreferrer noreferre=
r noreferrer" target=3D"_blank">qemu-devel@nongnu.org</a> (open list:All pa=
tches CC here)<br>
<br>
qemu-devel is a high-traffic list and maintainers may not see your<br>
patches unless you CC them.<br>
<br>
&gt;=C2=A0 1 file changed, 10 insertions(+), 13 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/b=
ackend/simple.py<br>
&gt; index a74d61fcd6..2688d4b64b 100644<br>
&gt; --- a/scripts/tracetool/backend/simple.py<br>
&gt; +++ b/scripts/tracetool/backend/simple.py<br>
&gt; @@ -36,8 +36,17 @@ def generate_h_begin(events, group):<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 def generate_h(event, group):<br>
&gt; -=C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 _simple_%(api)s(%(args)s);&#39;,=
<br>
&gt; +=C2=A0 =C2=A0 event_id =3D &#39;TRACE_&#39; + event.name.upper()<br>
&gt; +=C2=A0 =C2=A0 if &quot;vcpu&quot; in event.properties:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # already checked on the generic format c=
ode<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;true&quot;<br>
&gt; +=C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&=
quot; % event_id<br>
&gt; +=C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s) {&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 _simple_=
%(api)s(%(args)s);&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3Devent.api(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond=3Dcond,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3D&quot;, &quot;.join(event.arg=
s.names()))<br>
&gt;<br>
&gt;<br>
&gt; @@ -72,22 +81,10 @@ def generate_c(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if len(event.args) =3D=3D 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizestr =3D &#39;0&#39;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 event_id =3D &#39;TRACE_&#39; + event.name.upper()<br>
&gt; -=C2=A0 =C2=A0 if &quot;vcpu&quot; in event.properties:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # already checked on the generic format c=
ode<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;true&quot;<br>
&gt; -=C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&=
quot; % event_id<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 if (!%(cond)s) {&#39;,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;&=
#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 if (trace_record_=
start(&amp;rec, %(event_obj)<a href=3D"http://s.id" rel=3D"noreferrer noref=
errer noreferrer noreferrer" target=3D"_blank">s.id</a>, %(size_str)s)) {&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn; /* Trace Buffer Full, Event Dropped ! */&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond=3Dcond,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_obj=3Devent.api(event.QEMU_EVE=
NT),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_str=3Dsizestr)<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000004bffbe0635976b04--


