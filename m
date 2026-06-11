Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA4ACD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXatw-000147-6E; Thu, 11 Jun 2026 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXatu-00013V-Iv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:36:34 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXats-0002Ol-Uc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:36:34 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso2734446eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 01:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781166991; cv=none;
 d=google.com; s=arc-20240605;
 b=HqL9MYaylLVGahJh5SlGb1tSlG1EHSsQ/gr51H4tOgMc9tyh3oLBoxC+4bp+emYDSZ
 kRqXAwjZZ4ednOTU/nne468+nl2izkxt+BonwHTSq3JCJmrtCO2ZrcVcDzhduKv+8zwu
 pEHmVX59c+O2Gcfs0Ycwtm8ZZVQi+wlNV20Jv0zcywZyvHu5abuHPlOU754SEA8ohGdN
 FEoSUZkzJRMl+3mnoaIVYiZFArNXB+tNxzTT+st8QdC/ZmbnoWNZ6M97sH3oMZO0T2JF
 Tlvy/0bbSFglzEfbjva4/p1XV5yYL0G3bDDXLmEYT2LpgKqb1yjjwUiX6ky+buuAAK7q
 kqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SS9duF1cOZPDt17W4MVd8R88Ihqq20H2vSVKyFBYKpQ=;
 fh=AZkZ0b1lNOWrPAvx6utUMPvNnVTPoQb/VE06IgS7KRU=;
 b=ZZ2JxKKgCkzlMhu1wTgzvRkfyEqxZQCGFWwThFO1XM4PWocDhvqoD33PojRUGacF7I
 ItGvXT9MPUnHwxmnuTS6+dXljdDGpABUogvv66XZWkkIQC9QJ2QGRHIHeK3gK92uuOpX
 7vo9hj7D/retAHLS1WeFXXJgKMU6qas1Ktob9POe5QdEPv7oREi6gXx2DJ4tnT4cr8Tz
 8NmGs4pPTIb/o4oTOoeAWRRai2ApuyRoTlsks4OCNwb2Pc7IYnDCPybDotWweOBtBSjL
 yzJ0SF0sZWALEBsD0ajE54NAt4v/o7JoCCVeFpEArShA5HttuiMCIXXAsMJAsjtvl7Jw
 rzYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781166991; x=1781771791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SS9duF1cOZPDt17W4MVd8R88Ihqq20H2vSVKyFBYKpQ=;
 b=FQwQEct0yczSZ1CLoxM/jtjDm8+xayNLyuL1t1YuF90GBEDSw5r7mFtg0+f6kYU8TQ
 zHNc0Pl+/74WGhTASo8WW6YjxZFPyN1wPv/9UlWTrwBXFw47z7Yk1ui0ew3RQvC33J6x
 dPJBPl5RDyrDypWEK7egVT1NNCU+iu32ixWkUqhnO1XWPFGQzmQEwHL2VHiyP6MgCkpF
 pl7OVz0gMctgmauD18lpYRMCG+6/H0b+oFskSw61h5Hg1vjksUhG+JDIesoWfXzpYDgh
 P/pnNnv3b4gBDzNsDIKwfUKtyA7f58474L11AmA2vtywOBvTKiTK7HpuQNjOy68iLnt/
 F1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781166991; x=1781771791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SS9duF1cOZPDt17W4MVd8R88Ihqq20H2vSVKyFBYKpQ=;
 b=lg4OP/XARazHA90193wxM7fDCYYE0dm427TGj7mH+897ZZ4vZDMBC7uvrmDw0cqY+d
 MgyT9dIxQ4i2H9tTia/SU6dfyH1lD0JxL7rJYHBi5qJznKdwkc4n/FrqdH/VvnCbbf/k
 hw/jZUY9QzCJc1inI1YQK/TKLWK2w8Em5NyatYZN6wx9HhCFv3Es9KOocS1b5OmHhHt1
 imWMfkDeIOOzXhprbSa7PZBEWWyfa5eiNbQHwgy7m0w9H1nT5PxI6SbRM6DZEWFMOzRG
 I40eO0+pFEdgCQbcIppmzGbYWfVGWh57UGK5wiaeBIpl+bCvR8FduChFNjJf3wlx5C5Y
 No2A==
X-Gm-Message-State: AOJu0YwWAJN1bWb+bXUHmSyuS+PURWUPskWrdGbc9Ey49vF++0+3cuzt
 iqLQQZLS/B19OU4TWInjFKNf605FBfalZ9rw6zfhPmL0pxPR63u7UkZA85a74yoE3qMBoxNsYND
 GjgKTTjGqprH3YxX9L8ABKr38N6py1QU=
X-Gm-Gg: Acq92OHQHu3/GJ85wgWLV261ovj14vnQcq8XZZs/AiXphdENKognMt1NqWADUjf+piz
 jCbMcxURkiGewiB6vceCqHLtYeulvbM0pTarVEoE8oz4RhFxrCBpuMvRwmwHwbZ4/mPvj0VzQiZ
 kFpNXVnnEfC0Bm5WPtv9UojW3PZIAGJvmkgKP4yFiLh5WYv+3LqgyHzoMdLqjclhTsA2EClQXKi
 EaLf5cPR/owPFevb66BiDM/c+DNiwCYT0zDBQ+7Wwb9hv9xwlFQOAxpCJ+/FLH+kfkeeuGgnisD
 rTEA9vYisF6ZzTwbAAYja7loZZRkZPjXBiXpWPwVCwwIlWVYAw==
X-Received: by 2002:a05:7300:a886:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-30804b9667cmr1348795eec.33.1781166990997; Thu, 11 Jun 2026
 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-21-9ea6355ea08f@redhat.com>
 <a75178b2-de9d-4c63-89c6-74938ea13fa4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a75178b2-de9d-4c63-89c6-74938ea13fa4@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 12:36:18 +0400
X-Gm-Features: AVVi8Cci2Xdyn4eM9IH2kD1l-1tKKgXp7h1vznVjx_38qVcqC4wtIJSmXzUB4Rg
Message-ID: <CAJ+F1C+yP9bx_KoQpKKMAHwRUP5Cvs6unyGbe=TBSy6RGkMCAA@mail.gmail.com>
Subject: Re: [PATCH v2 21/33] ui/gtk: implement display cleanup
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 11, 2026 at 11:56=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/08 16:16, Marc-Andr=C3=A9 Lureau wrote:
> > Add gtk_display_cleanup() to properly tear down GTK display state:
> > remove console and mouse notifiers, unregister clipboard peer,
> > destroy the main window and virtual consoles.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/gtk.h   |  1 +
> >   ui/gtk-clipboard.c | 15 +++++++++++++++
> >   ui/gtk.c           | 18 ++++++++++++++++++
> >   3 files changed, 34 insertions(+)
> >
> > diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> > index 3e6ce3cb48c..5156a049509 100644
> > --- a/include/ui/gtk.h
> > +++ b/include/ui/gtk.h
> > @@ -225,6 +225,7 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
> >
> >   /* gtk-clipboard.c */
> >   void gd_clipboard_init(GtkDisplayState *gd);
> > +void gd_clipboard_cleanup(GtkDisplayState *gd);
> >
> >   void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int=
 fbh);
> >
> > diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> > index ea9444be70f..476e6b8303c 100644
> > --- a/ui/gtk-clipboard.c
> > +++ b/ui/gtk-clipboard.c
> > @@ -235,3 +235,18 @@ void gd_clipboard_init(GtkDisplayState *gd)
> >       g_signal_connect(gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY],
> >                        "owner-change", G_CALLBACK(gd_owner_change), gd)=
;
> >   }
> > +
> > +void gd_clipboard_cleanup(GtkDisplayState *gd)
> > +{
> > +    if (!gd->cbpeer.name) {
> > +        return;
> > +    }
> > +    qemu_clipboard_peer_unregister(&gd->cbpeer);
> > +    g_signal_handlers_disconnect_by_data(
> > +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_CLIPBOARD], gd);
> > +    g_signal_handlers_disconnect_by_data(
> > +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_PRIMARY], gd);
> > +    g_signal_handlers_disconnect_by_data(
> > +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY], gd);
> > +    gd->cbpeer.name =3D NULL;
> > +}
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 2ee826b56fb..c26dc83ac3e 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -2505,6 +2505,7 @@ static void gd_create_menus(GtkDisplayState *s, D=
isplayOptions *opts)
> >   }
> >
> >
> > +static GtkDisplayState *gtk_display_state;
> >   static gboolean gtkinit;
> >
> >   static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
> > @@ -2523,6 +2524,7 @@ static void gtk_display_init(DisplayState *ds, Di=
splayOptions *opts)
> >       }
> >       assert(opts->type =3D=3D DISPLAY_TYPE_GTK);
> >       s =3D g_malloc0(sizeof(*s));
> > +    gtk_display_state =3D s;
> >       s->opts =3D opts;
> >
> >       theme =3D gtk_icon_theme_get_default();
> > @@ -2681,10 +2683,26 @@ static void early_gtk_display_init(DisplayOptio=
ns *opts)
> >   #endif
> >   }
> >
> > +static void gtk_display_cleanup(void)
> > +{
> > +    GtkDisplayState *s =3D gtk_display_state;
> > +
> > +    if (!s) {
> > +        return;
> > +    }
> > +
> > +    qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
>
> qemu_del_vm_change_state_handler() should be called too.

ack

>
> Regards,
> Akihiko Odaki
>
> > +    gd_clipboard_cleanup(s);
> > +    g_clear_pointer(&s->window, gtk_widget_destroy);
> > +    g_clear_object(&s->null_cursor);
> > +    g_clear_pointer(&gtk_display_state, g_free);
> > +}
> > +
> >   static QemuDisplay qemu_display_gtk =3D {
> >       .type       =3D DISPLAY_TYPE_GTK,
> >       .early_init =3D early_gtk_display_init,
> >       .init       =3D gtk_display_init,
> > +    .cleanup    =3D gtk_display_cleanup,
> >       .vc         =3D "vc",
> >   };
> >
> >
>

