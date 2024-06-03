Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07105C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7Kb-0005ki-KC; Mon, 03 Jun 2024 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE7KV-0005j5-5y; Mon, 03 Jun 2024 09:02:29 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sE7KS-0003nU-TG; Mon, 03 Jun 2024 09:02:26 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43ff9dceb0bso14623581cf.0; 
 Mon, 03 Jun 2024 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717419743; x=1718024543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vp7D+glSkbKRQ7kB/ZJ7QvtxN4fhXEXaVjpsESt/NxA=;
 b=Dx9h1mR2ltVckTstvj/nxwZtcXJZQ0NkBLmutghTEfogABdWgtvwF2GDk6dQIGfQoV
 lfFm+Kt/Q/tKiC+4FNbV7PFg+hhHrYZ+HGm7xOntcrKmj/P30mHlqAJG5YOAGF/X29vW
 gH237cneTZwDm+bv7r6+cYm2IlAoIGnbOqe03Y73qW7istxYg+5x1y21IKTmezPi3yOG
 23qksqv3b15ISISWKllo79NgUX9HMbCIiVm1adaLTHvByGQTVxLGtHU9Ci4+FH+SpJaX
 hPawOPt31JbQD9F7TahRnUlEqa58qBKe12+RXeLStU8ntsCByDBqyasRFmwqr5q5VX8Z
 D04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419743; x=1718024543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vp7D+glSkbKRQ7kB/ZJ7QvtxN4fhXEXaVjpsESt/NxA=;
 b=OFEr3dvXOLK/jsIld1NvdZ/0996juGt7TxF5hnjzeM9t0UtzQwiyUsmH2cmyeJGRHo
 y+9cisM1wxgEQC+NtOgMCdt1b6LkFZQzYX2hnvJc1ZQAbkbxP1N7xLoMZ78TdZaretdV
 PoAuLhC29hyMDahzrcf33J+XPoQYJ/FKe0mai1Ki9ShkGLr+xu2J/28neZ3v89fwdspL
 kW5a/w46nclhA1p92YuYO+aVmbg6zcrwmmYt+Szrd3BGSe+Psi+KvNDoy0dmuGachT/T
 CbRB6dVoz1GDVjVaUIJ3XnUlpir6u8fDkUdHrqPY1lj08Cwz67votl28YttUvmo7weuH
 Ju4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV4wyhjkh7HR/jhtghrxNWE24PxkP/AAFXXdlao0ti05l/Mnt8T6aGqnzYj2sibN1q7qV2VQgLcYROwbczAzv0UBBB6HHz
X-Gm-Message-State: AOJu0Yx6Q4qkYaX5Rbi1g5amuXdb0h+1Q/Bmu78HV8pBGBT4spkyf5nd
 k+y2olRMS/DB/SrCVvFDrmaZykXeInF1D1WtVHLuw/dzgYdALqR/K7dFFlwIro20m78x0STj3Ts
 LiCdcxehQzexuSOJb3A2cjnaacnIyT76p5/k=
X-Google-Smtp-Source: AGHT+IHa/j/Z6xi3Yt+/C2XSq5z6IsUqSRjzo0q83v8dZIY1U7aQDEZpJoO4UD2/8ceAF7mpc+qrqkUfbFnNWW7B6Sw=
X-Received: by 2002:a05:622a:1ba2:b0:436:4d7c:8a9b with SMTP id
 d75a77b69052e-43ff54fa8b5mr113874031cf.46.1717419742589; Mon, 03 Jun 2024
 06:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240530110417.1724583-1-kraxel@redhat.com>
 <CAJ+F1CJMjq6SSwuW3E3CweVH_ftGJL0qF3QqKgGQMvt=_t8tKg@mail.gmail.com>
 <h5xbnhrqfhuvqf5xef34h3rnfybwb5de4mxhlgta32vpuvqtpo@s7kx5h6c4k4x>
In-Reply-To: <h5xbnhrqfhuvqf5xef34h3rnfybwb5de4mxhlgta32vpuvqtpo@s7kx5h6c4k4x>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Jun 2024 17:02:09 +0400
Message-ID: <CAJ+F1CJY4neA+1LMnog=FhhNqzMVM-MPukxswXDfiLX72L-VcA@mail.gmail.com>
Subject: Re: [PATCH] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000affccf0619fbf1e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000affccf0619fbf1e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 3, 2024 at 3:51=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:

> On Mon, Jun 03, 2024 at 02:24:52PM GMT, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, May 30, 2024 at 3:05=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.co=
m> wrote:
> >
> > > In case the display surface uses a shared buffer (i.e. uses vga vram
> > > directly instead of a shadow) go unshare the buffer before clearing i=
t.
> > >
> > > This avoids vga memory corruption, which in turn fixes unblanking not
> > > working properly with X11.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  hw/display/vga.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > > index 30facc6c8e33..34ab8eb9b745 100644
> > > --- a/hw/display/vga.c
> > > +++ b/hw/display/vga.c
> > > @@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s,
> int
> > > full_update)
> > >      if (s->last_scr_width <=3D 0 || s->last_scr_height <=3D 0)
> > >          return;
> > >
> > > +    if (is_buffer_shared(surface)) {
> > >
> >
> > It might be a good time to rename this function. surface_is_borrowed() =
?
>
> "shared" means memory shared between guest and host (typically vga vram).
>
>
In this context, but this is now confusing because we also have shared
memory surface support for win32.

static inline int is_buffer_shared(DisplaySurface *surface)
{
    return !(surface->flags & QEMU_ALLOCATED_FLAG);
}

!allocated =3D the surface memory is not owned.


> I doubt using the term "borrowed" instead clarifies things much,
> especially as this isn't an rust-style "borrow" (which I guess you are
> referring to).  Nothing prevents the host from writing to the surface as
> the bug clearly shows.  Also qemu is a C project, so I wouldn't expect
> developers being familiar with rust semantics and terminology.
>
>
Borrowing is not a term specific to Rust :) (and you can have mutable
borrows btw)

 I'd rather use "shared" memory for IPC purposes.

The lack of surface_ function prefix is also annoying.


> > > +        /* unshare buffer, otherwise the blanking corrupts vga vram =
*/
> > > +        qemu_console_resize(s->con, s->last_scr_width,
> > > s->last_scr_height);
> >
> > If we want to guarantee that a new surface is created, we should leave =
a
> > comment on qemu_console_resize(),
>
> I left the comment there exactly because it isn't obvious that the
> qemu_console_resize() will create a new (not shared) surface.  So not
> sure what exactly you are suggesting here?
>
>
I meant to document qemu_console_resize() function itself, as it would be
too easy to miss and break this case.


> > or perhaps make it take a new/alloc argument?
>
> Right now qemu_console_resize() does a bunch of checks to figure
> whenever it can take a shortcut (because width + height didn't change)
> or not.
>
> We could certainly pass a boolean in instead and have the caller decide
> that way.  Didn't check whenever that makes sense, and IMHO that is well
> beyond the scope of a 3-lines bugfix.
>
>    kraxel@sirius ~/projects/qemu# git grep qemu_console_resize | wc -l
>    35
>

Maybe introduce a new function then?



--=20
Marc-Andr=C3=A9 Lureau

--000000000000affccf0619fbf1e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 3, 2024 at 3:51=E2=80=
=AFPM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, Jun 03, 2024 at 02:24:52PM GMT, Marc-Andr=C3=A9 Lureau wrote:<br=
>
&gt; Hi<br>
&gt; <br>
&gt; On Thu, May 30, 2024 at 3:05=E2=80=AFPM Gerd Hoffmann &lt;<a href=3D"m=
ailto:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:=
<br>
&gt; <br>
&gt; &gt; In case the display surface uses a shared buffer (i.e. uses vga v=
ram<br>
&gt; &gt; directly instead of a shadow) go unshare the buffer before cleari=
ng it.<br>
&gt; &gt;<br>
&gt; &gt; This avoids vga memory corruption, which in turn fixes unblanking=
 not<br>
&gt; &gt; working properly with X11.<br>
&gt; &gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">q=
emu-stable@nongnu.org</a><br>
&gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issue=
s/2067" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/issues/2067</a><br>
&gt; &gt; Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.=
com" target=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/display/vga.c | 6 ++++++<br>
&gt; &gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/display/vga.c b/hw/display/vga.c<br>
&gt; &gt; index 30facc6c8e33..34ab8eb9b745 100644<br>
&gt; &gt; --- a/hw/display/vga.c<br>
&gt; &gt; +++ b/hw/display/vga.c<br>
&gt; &gt; @@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState =
*s, int<br>
&gt; &gt; full_update)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (s-&gt;last_scr_width &lt;=3D 0 || s-&gt;l=
ast_scr_height &lt;=3D 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 if (is_buffer_shared(surface)) {<br>
&gt; &gt;<br>
&gt; <br>
&gt; It might be a good time to rename this function. surface_is_borrowed()=
 ?<br>
<br>
&quot;shared&quot; means memory shared between guest and host (typically vg=
a vram).<br>
<br></blockquote><div><br></div><div>In this context, but this is now confu=
sing because we also have shared memory surface support for win32.=C2=A0</d=
iv><div><br></div><div>static inline int is_buffer_shared(DisplaySurface *s=
urface)<br>{<br>=C2=A0 =C2=A0 return !(surface-&gt;flags &amp; QEMU_ALLOCAT=
ED_FLAG);<br>}<br></div><div><br></div><div>!allocated =3D the surface memo=
ry is not owned.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">I doubt using the term &quot;borrowed&quot; instead clarifies=
 things much,<br>
especially as this isn&#39;t an rust-style &quot;borrow&quot; (which I gues=
s you are<br>
referring to).=C2=A0 Nothing prevents the host from writing to the surface =
as<br>
the bug clearly shows.=C2=A0 Also qemu is a C project, so I wouldn&#39;t ex=
pect<br>
developers being familiar with rust semantics and terminology.<br>
<br></blockquote><div><br></div><div>Borrowing is not a term specific to Ru=
st :) (and you can have mutable borrows btw)=C2=A0 <br></div><div><br></div=
><div>=C2=A0I&#39;d rather use &quot;shared&quot; memory for IPC purposes.<=
br></div><div><br></div><div>The lack of surface_ function prefix is also a=
nnoying.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* unshare buffer, otherwise the bla=
nking corrupts vga vram */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_console_resize(s-&gt;con, s-&gt=
;last_scr_width,<br>
&gt; &gt; s-&gt;last_scr_height);<br>
&gt; <br>
&gt; If we want to guarantee that a new surface is created, we should leave=
 a<br>
&gt; comment on qemu_console_resize(), <br>
<br>
I left the comment there exactly because it isn&#39;t obvious that the<br>
qemu_console_resize() will create a new (not shared) surface.=C2=A0 So not<=
br>
sure what exactly you are suggesting here?<br>
<br></blockquote><div><br></div><div>I meant to document qemu_console_resiz=
e() function itself, as it would be too easy to miss and break this case.<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; or perhaps make it take a new/alloc argument?<br>
<br>
Right now qemu_console_resize() does a bunch of checks to figure<br>
whenever it can take a shortcut (because width + height didn&#39;t change)<=
br>
or not.<br>
<br>
We could certainly pass a boolean in instead and have the caller decide<br>
that way.=C2=A0 Didn&#39;t check whenever that makes sense, and IMHO that i=
s well<br>
beyond the scope of a 3-lines bugfix.<br>
<br>
=C2=A0 =C2=A0kraxel@sirius ~/projects/qemu# git grep qemu_console_resize | =
wc -l<br>
=C2=A0 =C2=A035<br></blockquote><div><br></div><div>Maybe introduce a new f=
unction then?</div><div>=C2=A0<br></div></div><br clear=3D"all"><br><span c=
lass=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gma=
il_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000affccf0619fbf1e9--

