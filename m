Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D31D17130
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2yvG-0007bm-4l; Mon, 21 Oct 2024 16:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1t2ydH-0004Kf-0b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:04:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1t2ydE-0003LT-8p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:04:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso3210525b3a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729541038; x=1730145838; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NFEZMo6jioCrY6nrxlIFpukwmliB1JFTDtefWoF8W/s=;
 b=XYrdTEKwqOOIiOuXQ63ZV96w2qWY+aYxLSL+s6Qun02emgI3zgHkV5Y24GZopQFmPf
 x/TRY+kMjF2uPMCPJ5TvVCnP6b4VTqL6o84RACS3oMEl4W/kBxP1vpPzbd2nCBkBvJ70
 ODbL9DgdRwb0ZYIJNfbwYOSAozz6h2CsoqhaGvdh8wUWdf2Uupq+KTV6hkRUM6R1YT0C
 ImeXnHqz3I7kNK/yDPS8meR+7BpSrSMn5fi49DleKnGdZ7fqYxUAIPQIuAE9S5cvEZSO
 C7CZtIytAeN7+7Du+mPXcQEP16h1Dujig0uFQRLaI/oTSzzQpiSfR2Hr/rWoN8o0LFHY
 z6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729541038; x=1730145838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFEZMo6jioCrY6nrxlIFpukwmliB1JFTDtefWoF8W/s=;
 b=s9UUXRf7wZsyBmMZJqXrnaLsjDpr4/1p2obm8w9eL0ecyVyzhwJGZDMGcm8Hd+A0Xw
 UW+sCviixQiIJnGEnlTJ/n27KUjoGgS6xn/kIk+24gTTjQP29nyKnk3iCY6QwInwoNcp
 ADAivkKxsjtKY387ONPlvo8IagO/d27f8bCWJL04X8AtXl6pjfpyJ5VIMIJtVyb40T/M
 nIQDziU6MyhPvHCxrAeCa4ziw7p8n8rQ/CEaiFwvpcl9/3QbdJjpTVzOm9HUgIac7vEO
 MVjaFQo5bzCDWvrrHgINn9iTuIMfQixxR6+t0FWAYfYXFpY9wjK+qHjhTwVYGCcyBmjZ
 O+ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvLMd/m3HqK4I5H999bNKeMbOzl4h9k1+IQaG+XjlzP13HtZiaWHcxZ/xzPEcTAHLmuZUpBeXlLUFv@nongnu.org
X-Gm-Message-State: AOJu0Yz7DaZ54T+vYJs+lZJ25YU0xkOA2by5KbtHJdDhIpRFECg1eU6a
 fBbFh4PXRaZSi/UCL86JuR2qBK4axTNYf0hSd44fRuJ+vWvUVnKYTZCSjXce3M0TDJopdpr+ihH
 QFk5RGY4P4K68K4g5BUEZ5ckU8mkAuSe59BM=
X-Google-Smtp-Source: AGHT+IGY/prbZeDCItvhYZaHuu8TkAkkdGoCo/mS1tqFW2t/kVGBktzzLwSafgE9IJ9dzQ+DgWZGXqych4d5h3lvC68=
X-Received: by 2002:a05:6a20:b58b:b0:1d9:1dcd:b229 with SMTP id
 adf61e73a8af0-1d92c56d43bmr15939024637.33.1729541037633; Mon, 21 Oct 2024
 13:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
In-Reply-To: <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Mon, 21 Oct 2024 16:03:46 -0400
Message-ID: <CAGZECHPnD5XiZbGzHbxCEUOxE_CTR3ZOHBzF8+38xAqwYQAn_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="0000000000002cdb260625022738"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=ankeesler@google.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Oct 2024 16:22:36 -0400
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

--0000000000002cdb260625022738
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc-Andr=C3=A9 -

The ability to set the name with QMP qom-set seems like a nice behavior.

Note that the ultimate goal of this name is to propagate it downstream to
a device (see next patch[0] for a sample propagation to virtio-gpu).

In order to accomplish this, would it work to expose this new "head_name"
property via a qemu_graphic_console_get_head_name(QemuConsole *c) function
that:

1. verifies that c is indeed a QemuGraphicConsole with
   QEMU_IS_GRAPHIC_CONSOLE(), and
2. returns c->head_name (similar to qemu_console_get_name() from [0])?

We'd probably need a similar function
qemu_graphic_console_get_head_name(QemuConsole *c, const char *name) in
order to
set the head_name from a display (e.g., VNC) - correct me if you were
thinking
of going a different direction with this interface, though. My main goal is
to
provide some way for a user to inject a display EDID name from the command
line.

Also, just to verify my understanding - there would never be a QemuConsole
that
a) is NOT a QemuGraphicConsole AND b) is associated with an EDID in a guest=
,
correct?

[0] https://lists.gnu.org/archive/html/qemu-devel/2024-10/msg03238.html

On Mon, Oct 21, 2024 at 7:14=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi Roque
>
> On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez
> <roqueh@google.com> wrote:
> >
> > From: Andrew Keesler <ankeesler@google.com>
> >
> > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> Identification
> > Data) is propagated by QEMU such that a virtual display presents
> legitimate
> > metadata (e.g., name, serial number, preferred resolutions, etc.) to it=
s
> > connected guest.
> >
> > This change propagates an optional user-provided display name to
> > QemuConsole. Future changes will update downstream devices to leverage
> this
> > display name for various uses, the primary one being providing a custom
> EDID
> > name to guests. Future changes will also update other displays (e.g.,
> spice)
> > with a similar option to propagate a display name to downstream devices=
.
> >
> > Currently, every virtio-gpu virtual display has the same name: "QEMU
> > Monitor". We hope to be able to inject the EDID name of virtual display=
s
> in
> > order to test guest behavior that is specific to display names. We
> provide the
> > ability to inject the display name from the display configuration as
> that most
> > closely resembles how real displays work (hardware displays contain
> static EDID
> > information that is provided to every connected host).
> >
> > It should also be noted that EDID names longer than 12 bytes will be
> truncated
> > per spec (I think?).
> >
> > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >  include/ui/console.h | 1 +
> >  ui/console-priv.h    | 1 +
> >  ui/console.c         | 8 ++++++++
> >  ui/vnc.c             | 8 +++++++-
> >  4 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 5832d52a8a..74ab03ed72 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
> >  uint32_t qemu_console_get_head(QemuConsole *con);
> >  int qemu_console_get_width(QemuConsole *con, int fallback);
> >  int qemu_console_get_height(QemuConsole *con, int fallback);
> > +void qemu_console_set_name(QemuConsole *con, const char *name);
> >  /* Return the low-level window id for the console */
> >  int qemu_console_get_window_id(QemuConsole *con);
> >  /* Set the low-level window id for the console */
> > diff --git a/ui/console-priv.h b/ui/console-priv.h
> > index 43ceb8122f..9f2769843f 100644
> > --- a/ui/console-priv.h
> > +++ b/ui/console-priv.h
> > @@ -18,6 +18,7 @@ struct QemuConsole {
> >      Object parent;
> >
> >      int index;
> > +    const char *name;
> >      DisplayState *ds;
> >      DisplaySurface *surface;
> >      DisplayScanout scanout;
> > diff --git a/ui/console.c b/ui/console.c
> > index 5165f17125..f377fd8417 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, in=
t
> fallback)
> >      }
> >  }
> >
> > +void qemu_console_set_name(QemuConsole *con, const char *name)
> > +{
> > +    if (con =3D=3D NULL) {
> > +        return;
> > +    }
> > +    con->name =3D name;
> > +}
> > +
> >  int qemu_invalidate_text_consoles(void)
> >  {
> >      QemuConsole *s;
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 93a8dbd253..7d6acc5c2e 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {
> >          },{
> >              .name =3D "power-control",
> >              .type =3D QEMU_OPT_BOOL,
> > +        },{
> > +            .name =3D "name",
> > +            .type =3D QEMU_OPT_STRING,
> >          },
> >          { /* end of list */ }
> >      },
> > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **err=
p)
> >      QemuOpts *opts =3D qemu_opts_find(&qemu_vnc_opts, id);
> >      g_autoptr(SocketAddressList) saddr_list =3D NULL;
> >      g_autoptr(SocketAddressList) wsaddr_list =3D NULL;
> > -    const char *share, *device_id;
> > +    const char *share, *device_id, *name;
> >      QemuConsole *con;
> >      bool password =3D false;
> >      bool reverse =3D false;
> > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **err=
p)
> >      }
> >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
> >
> > +    name =3D qemu_opt_get(opts, "name");
> > +    qemu_console_set_name(vd->dcl.con, name);
>
> Why not expose a "head_name" property in QemuGraphicConsole?
>
> This way it should be possible to set the name with QMP qom-set.
>
>

--0000000000002cdb260625022738
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Marc-Andr=C3=A9 -<br><br>The ability to set the na=
me with QMP qom-set seems like a nice behavior.<br><br>Note that the ultima=
te goal of this name is to propagate it downstream to<br>a device (see next=
 patch[0] for a sample propagation to virtio-gpu).<br><br>In order to accom=
plish this, would it work to expose this new &quot;head_name&quot;<br>prope=
rty via a qemu_graphic_console_get_head_name(QemuConsole *c) function that:=
<br><br>1. verifies that c is indeed a QemuGraphicConsole with<br>=C2=A0 =
=C2=A0QEMU_IS_GRAPHIC_CONSOLE(), and<br>2. returns c-&gt;head_name (similar=
 to qemu_console_get_name() from [0])?<br><br>We&#39;d probably need a simi=
lar function<br>qemu_graphic_console_get_head_name(QemuConsole *c, const ch=
ar *name) in order to<br>set the head_name from a display (e.g., VNC) - cor=
rect me if you were thinking<br>of going a different direction with this in=
terface, though. My main goal is to<br>provide some way for a user to injec=
t a display EDID name from the command line.<br><br>Also, just to verify my=
 understanding - there would never be a QemuConsole that<br>a) is NOT a Qem=
uGraphicConsole AND b) is associated with an EDID in a guest,<br>correct?<b=
r><br>[0] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2024-10/=
msg03238.html">https://lists.gnu.org/archive/html/qemu-devel/2024-10/msg032=
38.html</a><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Oct 21, 2024 at 7:14=E2=80=AFAM Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Roque<br>
<br>
On Fri, Oct 18, 2024 at 1:53=E2=80=AFAM Roque Arcudia Hernandez<br>
&lt;<a href=3D"mailto:roqueh@google.com" target=3D"_blank">roqueh@google.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.com" targe=
t=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt;<br>
&gt; Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Ident=
ification<br>
&gt; Data) is propagated by QEMU such that a virtual display presents legit=
imate<br>
&gt; metadata (e.g., name, serial number, preferred resolutions, etc.) to i=
ts<br>
&gt; connected guest.<br>
&gt;<br>
&gt; This change propagates an optional user-provided display name to<br>
&gt; QemuConsole. Future changes will update downstream devices to leverage=
 this<br>
&gt; display name for various uses, the primary one being providing a custo=
m EDID<br>
&gt; name to guests. Future changes will also update other displays (e.g., =
spice)<br>
&gt; with a similar option to propagate a display name to downstream device=
s.<br>
&gt;<br>
&gt; Currently, every virtio-gpu virtual display has the same name: &quot;Q=
EMU<br>
&gt; Monitor&quot;. We hope to be able to inject the EDID name of virtual d=
isplays in<br>
&gt; order to test guest behavior that is specific to display names. We pro=
vide the<br>
&gt; ability to inject the display name from the display configuration as t=
hat most<br>
&gt; closely resembles how real displays work (hardware displays contain st=
atic EDID<br>
&gt; information that is provided to every connected host).<br>
&gt;<br>
&gt; It should also be noted that EDID names longer than 12 bytes will be t=
runcated<br>
&gt; per spec (I think?).<br>
&gt;<br>
&gt; Signed-off-by: Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.c=
om" target=3D"_blank">ankeesler@google.com</a>&gt;<br>
&gt; Signed-off-by: Roque Arcudia Hernandez &lt;<a href=3D"mailto:roqueh@go=
ogle.com" target=3D"_blank">roqueh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/ui/console.h | 1 +<br>
&gt;=C2=A0 ui/console-priv.h=C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++++++<br>
&gt;=C2=A0 ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++=
+++-<br>
&gt;=C2=A0 4 files changed, 17 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/include/ui/console.h b/include/ui/console.h<br>
&gt; index 5832d52a8a..74ab03ed72 100644<br>
&gt; --- a/include/ui/console.h<br>
&gt; +++ b/include/ui/console.h<br>
&gt; @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);<br>
&gt;=C2=A0 uint32_t qemu_console_get_head(QemuConsole *con);<br>
&gt;=C2=A0 int qemu_console_get_width(QemuConsole *con, int fallback);<br>
&gt;=C2=A0 int qemu_console_get_height(QemuConsole *con, int fallback);<br>
&gt; +void qemu_console_set_name(QemuConsole *con, const char *name);<br>
&gt;=C2=A0 /* Return the low-level window id for the console */<br>
&gt;=C2=A0 int qemu_console_get_window_id(QemuConsole *con);<br>
&gt;=C2=A0 /* Set the low-level window id for the console */<br>
&gt; diff --git a/ui/console-priv.h b/ui/console-priv.h<br>
&gt; index 43ceb8122f..9f2769843f 100644<br>
&gt; --- a/ui/console-priv.h<br>
&gt; +++ b/ui/console-priv.h<br>
&gt; @@ -18,6 +18,7 @@ struct QemuConsole {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Object parent;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int index;<br>
&gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplayState *ds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DisplayScanout scanout;<br>
&gt; diff --git a/ui/console.c b/ui/console.c<br>
&gt; index 5165f17125..f377fd8417 100644<br>
&gt; --- a/ui/console.c<br>
&gt; +++ b/ui/console.c<br>
&gt; @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, i=
nt fallback)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +void qemu_console_set_name(QemuConsole *con, const char *name)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (con =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 con-&gt;name =3D name;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int qemu_invalidate_text_consoles(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *s;<br>
&gt; diff --git a/ui/vnc.c b/ui/vnc.c<br>
&gt; index 93a8dbd253..7d6acc5c2e 100644<br>
&gt; --- a/ui/vnc.c<br>
&gt; +++ b/ui/vnc.c<br>
&gt; @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;power-=
control&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_BOO=
L,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;name&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_STRING,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuOpts *opts =3D qemu_opts_find(&amp;qemu_vnc_op=
ts, id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) saddr_list =3D NULL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(SocketAddressList) wsaddr_list =3D NULL;=
<br>
&gt; -=C2=A0 =C2=A0 const char *share, *device_id;<br>
&gt; +=C2=A0 =C2=A0 const char *share, *device_id, *name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuConsole *con;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool password =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool reverse =3D false;<br>
&gt; @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qkbd_state_set_delay(vd-&gt;kbd, key_delay_ms);<br=
>
&gt;<br>
&gt; +=C2=A0 =C2=A0 name =3D qemu_opt_get(opts, &quot;name&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_console_set_name(vd-&gt;dcl.con, name);<br>
<br>
Why not expose a &quot;head_name&quot; property in QemuGraphicConsole?<br>
<br>
This way it should be possible to set the name with QMP qom-set.<br>
<br>
</blockquote></div>

--0000000000002cdb260625022738--

