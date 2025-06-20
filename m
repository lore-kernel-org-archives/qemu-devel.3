Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377EFC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSead-0002iy-W4; Fri, 20 Jun 2025 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uSeab-0002iY-RA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:27:41 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uSeaZ-0007Df-KU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:27:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso424217966b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750436858; x=1751041658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4SH49HlB7dLfYKSXDh4c3GoPJduj7RZ6tJyrE0QiBN4=;
 b=g/+dUOyD6kRw7t4KMCZaHh6B+hu/+wOokMjteClsPpdAS0Eg5tZVnSBxY5rs4gSpLp
 m4zEQEh1lRrtZhFGdnBh5qpbvxr1Co6QrNTuMyuUQXo6DvzX2incYetQwx4QcBrSRfZw
 deOCyCcK4bDmn39FXanP19gKg/ET4j1pPMqZ5qFGx7Q69T29BlVXfvAJgD3bLdxyr+oi
 aRvXpuWprxOJcmvWtHsPYg7xBq79lmYWzl2rVpYM1pMd4VlDkktEobADPJfX1uJ8aFPD
 0lOSkA4wuGiNVskHgFPZr79AgbNcB+cYbTatL/DoUqNtbJP/Ratnz6eOHJO3PNDHjHDD
 D6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750436858; x=1751041658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4SH49HlB7dLfYKSXDh4c3GoPJduj7RZ6tJyrE0QiBN4=;
 b=jYhV88mKm6kLTV6i7hnydO9+vbD1PY1OYlRoHp9Q8fX+xcqcQ67ZhkdtSAxXcqzRUH
 0QBC0x0WVQMIVnvfyuRPJRdXT5gaWDijYO0SA6C/zRp4wqSiJlHu4+XzZ77+yeKw56UQ
 aUp2h2nr2flnJXOezLYWrAqFra3QkI1xjNmSAdENifuYAKzIbeOSYHZ83lAXqEnf9VgK
 aAl4eGWRYHH/WLjsaiSPzNeUBfsEchzkdyRrwoYIKTpBFLX7UIWSjswZm2lTIRyAo9ky
 EvNRGGt2yIg7O4y3X4QIWmHg3qEXTESCmWstnYD3noPzujwdanT0rVSJIuLh48htrCWB
 hVHw==
X-Gm-Message-State: AOJu0Yx0ZxGxJysqYpFxM7/uR1AL7V5F/yg9TSdNpPoNUesrOgzya80m
 V7QncmLYRxcQinkj/MNBtzfW/gqHhFd/6Ujm4jqbvBTaobdpkYLuhxM20YeAsgTup0IdR8TJzK/
 FhgcA2zpxneA7HB6OhrT+8BTcZvwOEB4=
X-Gm-Gg: ASbGncumFcFdlr4pciInSHZIyXMVTcM8IkEs/mo121cJxUZriY7CeRacQKsKffgnxxM
 3RSM4jKRDQ/opTZ+b2uRXe7sr6zAW6pZz1uPxR9KvPcYhf4jNf4GgwRs0r7AOkfk3Uf2Lm6NX1+
 5I+KFzwg1ftoepblg5BQo+itL6pQaG6iB+lZc0wagN8NDAM967RLXSBjyc1zmln9VRjWxnP8N2Y
 yphvQ==
X-Google-Smtp-Source: AGHT+IGzcGrNwYiW/GzVuIyFo/MM2VPfsfTyULt06RgZkzaIVaGX5/7yBnCw94f8OGYwPrjbmR1PuBrwc3KTr0N/qfQ=
X-Received: by 2002:a17:907:d78a:b0:ad8:9257:5717 with SMTP id
 a640c23a62f3a-ae057915d41mr315935166b.13.1750436856911; Fri, 20 Jun 2025
 09:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-2-tanishdesai37@gmail.com>
 <87jz56s86s.fsf@draig.linaro.org>
In-Reply-To: <87jz56s86s.fsf@draig.linaro.org>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Fri, 20 Jun 2025 21:57:24 +0530
X-Gm-Features: AX0GCFvRM2RhdCXWVmE0GVZUNdQWZzfIOqMysPq-kUxdgvw4q232T4y0ebSGXx0
Message-ID: <CAH_Y1jd56Ve0L2_3SGQafet5GacTPDLWeFe=vviC3Jc5+5iPnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tracetool: removed the unused vcpu property
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="0000000000000ed94f06380357ee"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000000ed94f06380357ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Noted will take care for all upcoming patches.
For this patch should I resend it with r-b tags from v1 or this patch it=E2=
=80=99s
fine for now?


On Fri, 20 Jun 2025 at 9:43=E2=80=AFPM, Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Tanish Desai <tanishdesai37@gmail.com> writes:
>
> > The vcpu property is no longer used in these backends. Removing it avoi=
ds
> > unnecessary checks and simplifies the code generation for these trace
> > backends.
> >
> > Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
>
> I think you forgot to collect the r-b tags from v1, see:
>
>
> https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#prope=
r-use-of-reviewed-by-tags-can-aid-review
>
> > ---
> >  scripts/tracetool/__init__.py       | 6 +++---
> >  scripts/tracetool/backend/log.py    | 6 +-----
> >  scripts/tracetool/backend/simple.py | 6 +-----
> >  scripts/tracetool/backend/syslog.py | 6 +-----
> >  4 files changed, 6 insertions(+), 18 deletions(-)
> >
> > diff --git a/scripts/tracetool/__init__.py
> b/scripts/tracetool/__init__.py
> > index bc03238c0f..e86c898a1e 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -216,9 +216,9 @@ class Event(object):
> >                        r"\s*"
> >                        r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?=
"
> >                        r"\s*")
> > -
> > -    _VALID_PROPS =3D set(["disable", "vcpu"])
> > -
> > +
> > +    _VALID_PROPS =3D set(["disable"])
> > +
> >      def __init__(self, name, props, fmt, args, lineno, filename,
> orig=3DNone,
> >                   event_trans=3DNone, event_exec=3DNone):
> >          """
> > diff --git a/scripts/tracetool/backend/log.py
> b/scripts/tracetool/backend/log.py
> > index de27b7e62e..f24acad74c 100644
> > --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -31,11 +31,7 @@ def generate_h(event, group):
> >      if len(event.args) > 0:
> >          argnames =3D ", " + argnames
> >
> > -    if "vcpu" in event.properties:
> > -        # already checked on the generic format code
> > -        cond =3D "true"
> > -    else:
> > -        cond =3D "trace_event_get_state(%s)" % ("TRACE_" +
> event.name.upper())
> > +    cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.uppe=
r())
> >
> >      out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> >          '        if (message_with_timestamp) {',
> > diff --git a/scripts/tracetool/backend/simple.py
> b/scripts/tracetool/backend/simple.py
> > index 2688d4b64b..7c84c06b20 100644
> > --- a/scripts/tracetool/backend/simple.py
> > +++ b/scripts/tracetool/backend/simple.py
> > @@ -37,11 +37,7 @@ def generate_h_begin(events, group):
> >
> >  def generate_h(event, group):
> >      event_id =3D 'TRACE_' + event.name.upper()
> > -    if "vcpu" in event.properties:
> > -        # already checked on the generic format code
> > -        cond =3D "true"
> > -    else:
> > -        cond =3D "trace_event_get_state(%s)" % event_id
> > +    cond =3D "trace_event_get_state(%s)" % event_id
> >      out('    if (%(cond)s) {',
> >          '        _simple_%(api)s(%(args)s);',
> >          '    }',
> > diff --git a/scripts/tracetool/backend/syslog.py
> b/scripts/tracetool/backend/syslog.py
> > index 012970f6cc..6fdc1142fb 100644
> > --- a/scripts/tracetool/backend/syslog.py
> > +++ b/scripts/tracetool/backend/syslog.py
> > @@ -30,11 +30,7 @@ def generate_h(event, group):
> >      if len(event.args) > 0:
> >          argnames =3D ", " + argnames
> >
> > -    if "vcpu" in event.properties:
> > -        # already checked on the generic format code
> > -        cond =3D "true"
> > -    else:
> > -        cond =3D "trace_event_get_state(%s)" % ("TRACE_" +
> event.name.upper())
> > +    cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.uppe=
r())
> >
> >      out('    if (%(cond)s) {',
> >          '#line %(event_lineno)d "%(event_filename)s"',
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000000ed94f06380357ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Noted will take care for all upcoming patches.</div><div =
dir=3D"auto">For this patch should I resend it with r-b tags from v1 or thi=
s patch it=E2=80=99s fine for now?</div><div dir=3D"auto"><br clear=3D"all"=
><div dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature"><br></div></div></div><div><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Jun=
 2025 at 9:43=E2=80=AFPM, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204=
)">Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_b=
lank">tanishdesai37@gmail.com</a>&gt; writes:<br>
<br>
&gt; The vcpu property is no longer used in these backends. Removing it avo=
ids<br>
&gt; unnecessary checks and simplifies the code generation for these trace<=
br>
&gt; backends.<br>
&gt;<br>
&gt; Signed-off-by: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.=
com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt;<br>
<br>
I think you forgot to collect the r-b tags from v1, see:<br>
<br>
=C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/devel/submitting-a-=
patch.html#proper-use-of-reviewed-by-tags-can-aid-review" rel=3D"noreferrer=
" target=3D"_blank">https://qemu.readthedocs.io/en/master/devel/submitting-=
a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review</a><br>
<br>
&gt; ---<br>
&gt;=C2=A0 scripts/tracetool/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 +++-=
--<br>
&gt;=C2=A0 scripts/tracetool/backend/log.py=C2=A0 =C2=A0 | 6 +-----<br>
&gt;=C2=A0 scripts/tracetool/backend/simple.py | 6 +-----<br>
&gt;=C2=A0 scripts/tracetool/backend/syslog.py | 6 +-----<br>
&gt;=C2=A0 4 files changed, 6 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init_=
_.py<br>
&gt; index bc03238c0f..e86c898a1e 100644<br>
&gt; --- a/scripts/tracetool/__init__.py<br>
&gt; +++ b/scripts/tracetool/__init__.py<br>
&gt; @@ -216,9 +216,9 @@ class Event(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 r&quot;\s*&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 r&quot;(?:(?:(?P&lt;fmt_trans&gt;\&quot;.+),)?\s*(?P&lt;fmt&g=
t;\&quot;.+))?&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 r&quot;\s*&quot;)<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 _VALID_PROPS =3D set([&quot;disable&quot;, &quot;vcpu&q=
uot;])<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt; +=C2=A0 =C2=A0 _VALID_PROPS =3D set([&quot;disable&quot;])<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self, name, props, fmt, args, lineno,=
 filename, orig=3DNone,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ev=
ent_trans=3DNone, event_exec=3DNone):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/back=
end/log.py<br>
&gt; index de27b7e62e..f24acad74c 100644<br>
&gt; --- a/scripts/tracetool/backend/log.py<br>
&gt; +++ b/scripts/tracetool/backend/log.py<br>
&gt; @@ -31,11 +31,7 @@ def generate_h(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if len(event.args) &gt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot; + argnam=
es<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if &quot;vcpu&quot; in event.properties:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # already checked on the generic format c=
ode<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;true&quot;<br>
&gt; -=C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&=
quot; % (&quot;TRACE_&quot; + event.name.upper())<br>
&gt; +=C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&quot; % (&quot=
;TRACE_&quot; + event.name.upper())<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s &amp;&amp; qem=
u_loglevel_mask(LOG_TRACE)) {&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(message_with_timestamp) {&#39;,<br>
&gt; diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/b=
ackend/simple.py<br>
&gt; index 2688d4b64b..7c84c06b20 100644<br>
&gt; --- a/scripts/tracetool/backend/simple.py<br>
&gt; +++ b/scripts/tracetool/backend/simple.py<br>
&gt; @@ -37,11 +37,7 @@ def generate_h_begin(events, group):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def generate_h(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 event_id =3D &#39;TRACE_&#39; + event.name.upper()=
<br>
&gt; -=C2=A0 =C2=A0 if &quot;vcpu&quot; in event.properties:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # already checked on the generic format c=
ode<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;true&quot;<br>
&gt; -=C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&=
quot; % event_id<br>
&gt; +=C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&quot; % event_=
id<br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s) {&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 _si=
mple_%(api)s(%(args)s);&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#39;,<br>
&gt; diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/b=
ackend/syslog.py<br>
&gt; index 012970f6cc..6fdc1142fb 100644<br>
&gt; --- a/scripts/tracetool/backend/syslog.py<br>
&gt; +++ b/scripts/tracetool/backend/syslog.py<br>
&gt; @@ -30,11 +30,7 @@ def generate_h(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if len(event.args) &gt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot; + argnam=
es<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if &quot;vcpu&quot; in event.properties:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # already checked on the generic format c=
ode<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;true&quot;<br>
&gt; -=C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&=
quot; % (&quot;TRACE_&quot; + event.name.upper())<br>
&gt; +=C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state(%s)&quot; % (&quot=
;TRACE_&quot; + event.name.upper())<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s) {&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#line %(event_lineno)d &quot;%(=
event_filename)s&quot;&#39;,<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000000ed94f06380357ee--

