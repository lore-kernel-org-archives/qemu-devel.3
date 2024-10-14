Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC6BD16260
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0L1n-0004AP-LQ; Mon, 14 Oct 2024 09:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L1m-00049O-AD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:22:26 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L1k-0000rX-Jg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:22:26 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-460464090d5so40984751cf.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728912143; x=1729516943; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2YEbh8E9VKA+a1lWCAaWzUNRorcQmKI4Z8YL3u3Aosw=;
 b=AFkfsm6cVU/cMuQMwshfDM/IWsyogvb3TPnXXruBuuqFcMFWkPnXl17hOT2V+pfIfP
 O/WpMmSWvaDMaEVoDo0IA0ZuuGmRK20DcWmgnoM4u9P3/QfByqSB2U6nB4XId+P6azBB
 1CAeA0GRAqcsiW6YUOs0haZt2OdChvFr+sUqrNJfVJCUGfARLuQ3RIYEOUuM1UjZar+S
 a0ZZIavP3P1aBmZ/kGuXWVwkUyiieqIwCwwZg9ov3gTknfvu2LpWx49O1vNWVwYXsxC8
 yRhZyPQn+kN05AMeYxZjIIPT3T6DG/ONJIgjsa1+HTmotFHPMbIfqFTDBXQX68F3a8nR
 Ilrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728912143; x=1729516943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YEbh8E9VKA+a1lWCAaWzUNRorcQmKI4Z8YL3u3Aosw=;
 b=RI3qFtgeAZw2LNJjLJTbBL7ynGYsVbJWGSVPYXn9LP12iRs5TojpLB8oZMDYildObK
 ta9plj+zQsuEpynHd9sg4/36QSsRbRy3S8JVAjXL/uHHhFmeViAL6QGHRwh0NwKhBRhe
 twpQrZ4a5JjDysKfZY4ktrpft+3Zn1qqAzzaypw9PtkBJVGZgzkVNUbHfh+/MkprKjjR
 M/IQn8TTphnHyELuk2JuyJCuvkuiIp5egUEz8BSs7Zpy4+l8MAXaxf3pfjGA36Szs47i
 UEXlFrMo0Pb2R3IWEiF6s83cOhl+v0fcmpdnDtANu04hc8HCsUkrFxR4greDiChj9Yaw
 TsRw==
X-Gm-Message-State: AOJu0YxAF1FUNYkEoNL6cm/pYQwU2VK9Edj1suyX5bTapIcE60f7jkhc
 l7QK6ZQE7cBDr6uc4AUZJaQcKP30RYwZM2ElqzEW+TYXvyDGRwYSea7vJUH0ug88xvAMZgRrXO0
 aomXQpPbrq9UQWAv96ToeOSg6jumWHF6E
X-Google-Smtp-Source: AGHT+IHW7Mvv0ZywUKZQJ3ZE+wjQ98nM0Y056Aoqs6B1cfY3577Dmikw0IsaLo8ZOKQc9vlX6C/5dp95/pHHgCfRjTc=
X-Received: by 2002:a05:622a:110a:b0:458:2607:d5a7 with SMTP id
 d75a77b69052e-4604bc45d3emr197011491cf.43.1728912143449; Mon, 14 Oct 2024
 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
 <20241014114135.389766-8-r.peniaev@gmail.com>
In-Reply-To: <20241014114135.389766-8-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Oct 2024 17:22:12 +0400
Message-ID: <CAJ+F1CL6SNBFwo3CgfZR-WhahrcwGky3zTHzHUyoztDbUEroNQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] chardev/mux: implement detach of frontends from mux
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000028891e06246fbaa0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000028891e06246fbaa0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Oct 14, 2024 at 3:46=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> With bitset management now it becomes feasible to implement
> the logic of detaching frontends from multiplexer.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-fe.c          |  2 +-
>  chardev/char-mux.c         | 20 +++++++++++++++++---
>  chardev/chardev-internal.h |  1 +
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index 3b8771ca2ac4..8ac6bebb6f74 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>          }
>          if (CHARDEV_IS_MUX(b->chr)) {
>              MuxChardev *d =3D MUX_CHARDEV(b->chr);
> -            d->backends[b->tag] =3D NULL;
> +            mux_chr_detach_frontend(d, b->tag);
>
         }
>          if (del) {
>              Object *obj =3D OBJECT(b->chr);
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 9c3cacb2fecd..649f8ff6ccbf 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -289,10 +289,10 @@ static void char_mux_finalize(Object *obj)
>      bit =3D -1;
>      while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) <
> MAX_MUX) {
>          CharBackend *be =3D d->backends[bit];
> -        if (be) {
> -            be->chr =3D NULL;
> -        }
> +        be->chr =3D NULL;
> +        d->backends[bit] =3D NULL;
>      }
> +    d->mux_bitset =3D 0;
>      qemu_chr_fe_deinit(&d->chr, false);
>  }
>
> @@ -331,6 +331,21 @@ bool mux_chr_attach_frontend(MuxChardev *d,
> CharBackend *b,
>      return true;
>  }
>
> +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
> +{
> +    unsigned int bit;
> +
> +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
> +    if (bit >=3D MAX_MUX) {
>

if (bit !=3D tag) instead?


> +        return false;
> +    }
> +
> +    d->mux_bitset &=3D ~(1 << bit);
> +    d->backends[bit] =3D NULL;
> +
> +    return true;
> +}
> +
>  void mux_set_focus(Chardev *chr, unsigned int focus)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index b89aada5413b..853807f3cb88 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
>
>  bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
>                               unsigned int *tag, Error **errp);
> +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
>  void mux_set_focus(Chardev *chr, unsigned int focus);
>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000028891e06246fbaa0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 14, 2024 at 3:46=E2=80=
=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">With bitset management now it becomes feasible to implement<br>
the logic of detaching frontends from multiplexer.<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 ++++++++++++=
+++++---<br>
=C2=A0chardev/chardev-internal.h |=C2=A0 1 +<br>
=C2=A03 files changed, 19 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
index 3b8771ca2ac4..8ac6bebb6f74 100644<br>
--- a/chardev/char-fe.c<br>
+++ b/chardev/char-fe.c<br>
@@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(b-&gt;chr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARD=
EV(b-&gt;chr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[b-&gt;tag] =3D NU=
LL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_detach_frontend(d, b-&gt=
;tag); <br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (del) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Object *obj =3D OBJECT(b-&g=
t;chr);<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index 9c3cacb2fecd..649f8ff6ccbf 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -289,10 +289,10 @@ static void char_mux_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0bit =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0while ((bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MA=
X_MUX, bit + 1)) &lt; MAX_MUX) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CharBackend *be =3D d-&gt;backends[bit];<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[bit] =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 d-&gt;mux_bitset =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_fe_deinit(&amp;d-&gt;chr, false);<br>
=C2=A0}<br>
<br>
@@ -331,6 +331,21 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBacken=
d *b,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int bit;<br>
+<br>
+=C2=A0 =C2=A0 bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, tag);<=
br>
+=C2=A0 =C2=A0 if (bit &gt;=3D MAX_MUX) {<br></blockquote><div><br></div><d=
iv>if (bit !=3D tag) instead?<br></div><div>=C2=A0<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 d-&gt;mux_bitset &amp;=3D ~(1 &lt;&lt; bit);<br>
+=C2=A0 =C2=A0 d-&gt;backends[bit] =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
=C2=A0void mux_set_focus(Chardev *chr, unsigned int focus)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(chr);<br>
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h<br>
index b89aada5413b..853807f3cb88 100644<br>
--- a/chardev/chardev-internal.h<br>
+++ b/chardev/chardev-internal.h<br>
@@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,<br>
<br>
=C2=A0bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *tag, Error **errp);<br>
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);<br>
=C2=A0void mux_set_focus(Chardev *chr, unsigned int focus);<br>
=C2=A0void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000028891e06246fbaa0--

