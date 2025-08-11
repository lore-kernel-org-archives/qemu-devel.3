Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1388C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 02:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulHsa-0003yQ-FT; Sun, 10 Aug 2025 22:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulHsO-0003xh-BA
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:03:04 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ulHs9-0008CN-1V
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 22:02:59 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-30c036641f2so3288586fac.2
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754877764; x=1755482564;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F4YCi+ys9NO+S3w3bDKbzIIQ4C9chQhmES4ORUyS7+c=;
 b=eJeVWpNFCH8bZhk498PGbxCCPX6lfCFps7tJRD339Yys+hk0q5D4dYvnKBptyBqJAy
 /JTSIZa/eBpqgMvGlywyk/LcCAiRrztRgqJfm8RBStp3SiurqW7cedwDmBj6YhLdagUo
 I22F28xXPP3VN/GUZhsKFA3PeJEsYw1XRECFvpmhmkcB6tAOfXpzZE7hqZ/+MW1kIrrL
 qgDHRKTqRi4DAP/5fJ7Hu+IHjk/OcteEw181iiY9vC7mStKejBTnqJXj3P1hD72H65q9
 JPEmNlF0STJXxnKf5wcXKGx4lbb+u57nRRii4VEC9I9N43R4NLlCwdB41EbjQP1NbMag
 g2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754877764; x=1755482564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4YCi+ys9NO+S3w3bDKbzIIQ4C9chQhmES4ORUyS7+c=;
 b=vTkn6hqNQJYYRWMsfAwMTzZyfwYalTCWppp5tSvpoDB2cdN4imsNp6nmfu8qCr30D+
 p4lHbc4b8m3VK58xmJl/SGYPa/W42/fouhH/mOCsxWO6lMSFaqfr8J0uVbGma2n5qC19
 Sms5eZXCxOeaGXCEdlMTIffiTYvXwv798rDpxA8BB2KrNaItcD2Lf5Q1SPxA6PlrAYQZ
 Tnt5M6rI42nN6Bu8w8mP+ni7gR7lMgjBQ3A9PJ0GlPP+zxij/FihQYPsU8mzcpxQ+GG4
 9kE7AUCq7qJLcLtyxP6+GxxFaqZ+QkuCizQVFup/eGa0HY+boYhmDXjlWMPepciVkf+L
 q7Pw==
X-Gm-Message-State: AOJu0YxBLaRWCAhd27a/5ouzRuisyoImNymZPQoZgr80bOysbREZx3ac
 T787vSExvO48u/uZsJQxk6sWwozXJ+shH2WT70ydMFZQfNaJimVW6Ycor5JLuU6dItZBh1bR4Vv
 2aD/12Ea5x3pZERUFKn/A111yW5XoEGaoxuwCyQy84w==
X-Gm-Gg: ASbGncufGojlzhxZNbWFs58VeFON5kEaaEgOnDIVeKo19wdSspd0sx5nDXtAIJiGuoz
 oIwKmRyGwN4/Barc2wAdKFva9TPkJLdBCL+QLPYLZk72ELyVz8DJ0ymGBB6nIHGMKBCFLiNg23P
 fmwb0X/aJldvfTz2lACtnTLCRnY3vVo0WVYCwR/Ohc3/4XSzseujablS9p4UVaNsq70yDmQBfRA
 epoFZlP
X-Google-Smtp-Source: AGHT+IFqyjKW1FB+6CR3iYzKEXwkbEm1D0DkwAJlMy6fG62/lAipUW4aa/xuSlBSczWbWVMMkp4G+4aPiRqZa0H2ZLc=
X-Received: by 2002:a05:6870:b19:b0:30b:b123:b6c9 with SMTP id
 586e51a60fabf-30c20f2d93amr6654918fac.12.1754877763681; Sun, 10 Aug 2025
 19:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <aJYay1BNkq8fiTVf@x1.local>
In-Reply-To: <aJYay1BNkq8fiTVf@x1.local>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 11 Aug 2025 10:02:25 +0800
X-Gm-Features: Ac12FXwgJHI4iR8-44xqhGAjsMRHJIK7Yb_o976WIj9gJUt7TMCVUjuAUYd2NkU
Message-ID: <CAK9dgmbFV5WTMWqJqU7YX0gPGs=KD23eJQpRqAaFX1crxj25OQ@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="000000000000ba9224063c0d516a"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000ba9224063c0d516a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:42=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Aug 07, 2025 at 10:41:17AM +0800, yong.huang@smartx.com wrote:
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index b255778855..aca0aeb341 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)
> >              }
> >          }
> >          trace_multifd_recv_sync_main_signal(p->id);
> > +        do {
> > +            if (qemu_sem_timedwait(&multifd_recv_state->sem_sync,
> 10000) =3D=3D 0) {
> > +                break;
> > +            }
> > +            if (qemu_in_coroutine()) {
> > +                aio_co_schedule(qemu_get_current_aio_context(),
> > +                                qemu_coroutine_self());
> > +                qemu_coroutine_yield();
> > +            }
> > +        } while (1);
>
> I still think either yank or fixing migrate_cancel is the way to go, but
> when staring at this change.. I don't think I understand this patch at al=
l.
>
> It timedwait()s on the sem_sync that we just consumed.  Do you at least
> need to remove the ones above this piece of code to not hang forever?
>

Yes, thanks for pointing that out, I missed that since this patch is
cherry-picked manually from QEMU 6.2.0. :(


>
>     for (i =3D 0; i < thread_count; i++) {
>         trace_multifd_recv_sync_main_wait(i);
>         qemu_sem_wait(&multifd_recv_state->sem_sync);
>     }
>
> >          qemu_sem_post(&p->sem_sync);
> >      }
> >      trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
> > --
> > 2.27.0
> >
>
> --
> Peter Xu
>
>

--=20
Best regards

--000000000000ba9224063c0d516a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Aug 8, 2025 at 11:42=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:=
peterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">On Thu, Aug 07, 2025 at 10:41:17AM +0800, <a href=3D"mailto:yong.huang@s=
martx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; diff --git a/migration/multifd.c b/migration/multifd.c<br>
&gt; index b255778855..aca0aeb341 100644<br>
&gt; --- a/migration/multifd.c<br>
&gt; +++ b/migration/multifd.c<br>
&gt; @@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_multifd_recv_sync_main_signal(=
p-&gt;id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_sem_timedwait(&amp=
;multifd_recv_state-&gt;sem_sync, 10000) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_in_coroutine()) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_co_schedu=
le(qemu_get_current_aio_context(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_coroutine_self());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_coroutin=
e_yield();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (1);<br>
<br>
I still think either yank or fixing migrate_cancel is the way to go, but<br=
>
when staring at this change.. I don&#39;t think I understand this patch at =
all.<br>
<br>
It timedwait()s on the sem_sync that we just consumed.=C2=A0 Do you at leas=
t<br>
need to remove the ones above this piece of code to not hang forever?<br></=
blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default">Yes, thanks for pointing that o=
ut, I missed that since this patch is</div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default">cherry-picked manua=
lly from QEMU 6.2.0. :(</div></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 for (i =3D 0; i &lt; thread_count; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_multifd_recv_sync_main_wait(i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_sem_wait(&amp;multifd_recv_state-&gt;sem_s=
ync);<br>
=C2=A0 =C2=A0 }<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_sem_post(&amp;p-&gt;sem_sync);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_multifd_recv_sync_main(multifd_recv_state-&g=
t;packet_num);<br>
&gt; -- <br>
&gt; 2.27.0<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000ba9224063c0d516a--

