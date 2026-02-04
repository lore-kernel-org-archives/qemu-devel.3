Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C60E95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaMH-0005X3-4m; Wed, 04 Feb 2026 05:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vnaMF-0005Ws-Dl
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:43:39 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vnaMD-0006Vc-Nr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:43:39 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5033387c80aso11370711cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 02:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201815; cv=none;
 d=google.com; s=arc-20240605;
 b=C3sVVq1cARZU9kRMjDltQz3Jb/c+fS1uTiZFThh6lsJH522AQHbbjAWNTOJgsvs9/n
 7MFTbFXtCAif+3Sf3L73NLxQ2gk/tAJefp4kBUHOv6z+0lNA1EuX+cj6QBOgErJfgVIV
 o+akWeJL39eCOjC+stgjHqOK0/qgojSJ0rRDpvA8s8SLcmC9IBNgHKBqK3/5v9tjB9Nc
 78Ph4h+I42ZvrckQXY7ANrjdTvGmIoWIE7kj/ddcj86L3QxIgZIC49rnkQ2IDH1zevyX
 jtHTIfk12H3nWy+MW8QYK9WX6/sfasmDhCejlLV1a6ZYvzY1VA/nFKQgvLwyh7dfOtNG
 UvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ISvwD8HrsXCyHKIJufvhNiq7o74rXU9PmDlHxPHcbOI=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=VaIJMISqgsY8AU0O+R7pALIGZcOupoldYu6iElrPVbjifnBBsfk0Bn2sW0+uggBmEl
 JNn9c3woCAP+hYA9zFoZ1rgyD+YbG9pEqaWhZFgn/kqi0Aixj0VujSoHhGrHId8WWm2q
 jNRwO4h7VALU4JB4k7sdjjm4V3C0dMBaniKuxdLJTwrwiq+fPfjZqr4ssXY500MHjRqU
 xYlPg4nkxR3q4wpgIfIomwEojjKuTfFsCHECiM7sYZHLDqw8J72C5DBcwEqpvsPhDTv1
 BAV0jVOwPLzPgm+VXwsZXucYQDWRyUquJIQw3vlpbV74t4fylkYPcFP2UrO6wnJui8Gd
 rUdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770201815; x=1770806615; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISvwD8HrsXCyHKIJufvhNiq7o74rXU9PmDlHxPHcbOI=;
 b=bHt3/AIk55sZjpKsA/Hyp2ZEsaazVNtq4ljIxrlLCxI/iKC5Rb816QJ8H7QgTSDLrd
 loN6uA5anmyA7dqxWvdfGWyZQJLrLgbWZY9xbFOloLCiuV40bJlNVR5oth9CvmS6FY9n
 t2VAZSCqjmEbuajUnfDIg6buxvDFtc+nqd4IGF0nRQyDeHlndYilXG25Pw2PUpMyvBRq
 uEdduMJxbogqhUcXvHNbUK6XOeespC8Wf4kjDo+dwoJjhGilg0ygcNsyj4VzPEzdLynF
 VqkZnwOMljjlfwMx9wUPcNNbQvRKWx3387uzfbk72Xatq+nda157YHzi4waJNLwuof2I
 h4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770201815; x=1770806615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISvwD8HrsXCyHKIJufvhNiq7o74rXU9PmDlHxPHcbOI=;
 b=kfSOc5T6CE0Cq+K8o5kumgnlr+UayeHvkX0ZbBPOIL4QcNT7M9twhZuUxvZETdeDdX
 sOHcqjpiksyOBIvSY3h0nnLrC94lwCBQNJ6DD5YjlIANIlI9A/2zL3K35K3q34E8PQV1
 KeP5NyeNHd0WAyv5WYM9Odl3/cAyulQM5KWqdyMXgKOb25VsZvexjAk3HtqavqlJY870
 1qaG6U6zqnHya8HIQa+rR6QjtmSP9dXCO0bu3+PBAFVgvd56SoJtWuS28Sdk6iZ8nkSg
 D2urv5h0QDZifZU4x2Pbu6r71o27ujprj4Oj/TQb0j6WHcEgiFzzlCpssaMlGWBKx0S9
 FbSQ==
X-Gm-Message-State: AOJu0Yy2iYAcIIMpd4VejskZmxLYONSyPvI4TrSHdkysaGk1fg9vI288
 4nGW5uISaqbZGqnKFf1eC67vnuC0M39BhommTwFQtaFpxBPSNoBTapPBQ4LWsTAeT1DA9GHSiPV
 6QhR2xhmsWYiDfa0T/6NtWr9+URnwmB7hW/GdcZA=
X-Gm-Gg: AZuq6aKIj1nC7EuejFzZOuOhHB9RJjqdGbH6j3ohilVnqxjWfk4Hm0vzYjuaM2h9gCm
 G57zhl6SX5tVqUdvm/egwkng67gppmoVhl9+BenRNvj6sNdPCTcMbIakO5XZ+Mqd99rUhnsETDl
 mUckdcK+engvzKKPphHR7WdG3pDN2N3cNKnoUFSP8lyTU9Z7Vuqwrzs+FHkDEd8xQJuX/ePis6U
 p+RQ+GNpqTb/M4axLYuAar7Gjo7fkXkr1e4iIzDJSO4qfbo0zQaTDKEK2PPNWpyjxl0klWksdNu
 xm5PDUZ53u26+j95jK8Jcm0lfiA=
X-Received: by 2002:a05:622a:14d2:b0:4f1:de87:ad90 with SMTP id
 d75a77b69052e-50609152498mr71410601cf.4.1770201815232; Wed, 04 Feb 2026
 02:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-5-marcandre.lureau@redhat.com>
 <a86192d7-4de8-4835-a868-0d0d7cb42eb1@nutanix.com>
In-Reply-To: <a86192d7-4de8-4835-a868-0d0d7cb42eb1@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Feb 2026 14:43:23 +0400
X-Gm-Features: AZwV_QgyKL5B6KC5mX5ntM9cfcRsFdwZJONESrfgGJ_fTDCHv_pxAdQ3YudELRs
Message-ID: <CAJ+F1CK092y3Gbzz2JUFLKHJmR4RdeKau1pVrQbRVb7zAtWVGA@mail.gmail.com>
Subject: Re: [PATCH 04/37] audio/dbus: make "dbus" the default backend when
 using -display dbus
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Tue, Feb 3, 2026 at 7:42=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Set "using_dbus_display" during early_dbus_init(), so that we can try t=
o
> > create the "dbus" audio backend by default from audio_prio_list.
> >
> > This makes dbus audio work by default when using an audio device,
> > without having to setup and wire up the -audiodev manually.
> >
> > The added FIXME is addressed in the following commits.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio.c     |  3 +++
> >   audio/dbusaudio.c |  8 +++++++-
> >   ui/dbus.c         | 22 +++++++++++++++++-----
> >   3 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index e5841d7f0e6..80e4ba83712 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -57,6 +57,9 @@
> >       that we generate the list.
> >   */
> >   const char *audio_prio_list[] =3D {
> > +#ifdef CONFIG_GIO
> > +    "dbus",
> > +#endif
> >       "spice",
> >       CONFIG_AUDIO_DRIVERS
> >       "none",
> > diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> > index d729a810aa6..1fe7c4ed647 100644
> > --- a/audio/dbusaudio.c
> > +++ b/audio/dbusaudio.c
> > @@ -32,6 +32,7 @@
> >   #endif
> >
> >   #include "ui/dbus.h"
> > +#include "ui/dbus-display.h"
> >   #include "ui/dbus-display1.h"
> >
> >   #define AUDIO_CAP "dbus"
> > @@ -408,8 +409,13 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
> >   static void *
> >   dbus_audio_init(Audiodev *dev, Error **errp)
> >   {
> > -    DBusAudio *da =3D g_new0(DBusAudio, 1);
> > +    DBusAudio *da;
> >
> > +    if (!qemu_using_dbus_display(errp)) {
> > +        return NULL;
> > +    }
> > +
> > +    da =3D g_new0(DBusAudio, 1);
> >       da->dev =3D dev;
> >       da->out_listeners =3D g_hash_table_new_full(g_str_hash, g_str_equ=
al,
> >                                                   g_free, g_object_unre=
f);
> > diff --git a/ui/dbus.c b/ui/dbus.c
> > index d2dff332585..e44e2ff9877 100644
> > --- a/ui/dbus.c
> > +++ b/ui/dbus.c
> > @@ -35,6 +35,7 @@
> >   #include "ui/egl-context.h"
> >   #endif
> >   #include "qemu/audio.h"
> > +#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of=
 drv->name */
> >   #include "qapi/error.h"
> >   #include "trace.h"
> >
> > @@ -218,9 +219,20 @@ dbus_display_complete(UserCreatable *uc, Error **e=
rrp)
> >           return;
> >       }
> >
> > -    if (dd->audiodev && *dd->audiodev) {
> > -        AudioBackend *audio_be =3D audio_be_by_name(dd->audiodev, errp=
);
> > -        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->serve=
r, dd->p2p, errp)) {
> > +    {
> > +        AudioBackend *audio_be =3D audio_get_default_audio_be(NULL);
> > +
> > +        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
> > +            audio_be =3D NULL;
> > +        }
> > +        if (dd->audiodev && *dd->audiodev) {
> > +            audio_be =3D audio_be_by_name(dd->audiodev, errp);
> > +            if (!audio_be) {
> > +                return;
> > +            }
> > +        }
> > +        if (audio_be &&
> > +            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, e=
rrp)) {
> >               return;
> >           }
> >       }
> > @@ -475,6 +487,8 @@ early_dbus_init(DisplayOptions *opts)
> >   #endif
> >       }
> >
> > +    using_dbus_display =3D 1;
> > +
> >       type_register_static(&dbus_vc_type_info);
> >   }
> >
> > @@ -488,8 +502,6 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
> >           exit(1);
> >       }
> >
> > -    using_dbus_display =3D 1;
> > -
> >       object_new_with_props(TYPE_DBUS_DISPLAY,
> >                             object_get_objects_root(),
> >                             "dbus-display", &error_fatal,
>
> Looks reasonable to me: out of curiosity, what's the best client to use
> to test a combined dbus display/audio setup? Anyhow:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

thanks

I only know of 2 desktop clients, libmks[1] and qemu-display/rdw[2].
But only qemu-display/rdw actually implements audio support.

[1] https://gitlab.gnome.org/GNOME/libmks
[2] https://gitlab.com/marcandre.lureau/qemu-display

--=20
Marc-Andr=C3=A9 Lureau

