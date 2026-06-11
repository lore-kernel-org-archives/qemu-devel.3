Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523FCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbG0-0006sv-FF; Thu, 11 Jun 2026 04:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXbFy-0006sn-UX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:59:22 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXbFx-0002aK-5a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:59:22 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-307631dbfedso568214eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 01:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781168359; cv=none;
 d=google.com; s=arc-20240605;
 b=anKzlR3aXvtCSGrkE7fLhh8Zxu0Y8B2pfS9DnpV8ZymRhbB+pIo/NBUilyFsrbVE8/
 2598VIPrDX4rz2C88jMuibj+7tUCMMUKfoNeRiNygX53MXt9VBSNGb6mvst6OQLdLd5Z
 /F3C1MeVxGEjjv39s9yK/rpbkUgP8+AwyEj8eO91JgvqbDiLQb6GuyEZfgD85N9FhD7B
 JHE4o5B18WYnxhi8Z1i0FmbwtyzM70/WWFCp8XoO/KbIXIR0pCieubMS5LTAwdgiSDGG
 i26ekNmmmkEpx6vScoYrSOBtLYnIiY1BqkYtJwa+PNNDS7TYShlAbB51itKc/GsFqr2r
 OaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PNw6491ibAw/fNpZxxH9sa5QPWryeY7W6+16dyUzILs=;
 fh=AZkZ0b1lNOWrPAvx6utUMPvNnVTPoQb/VE06IgS7KRU=;
 b=JMSx5sN1IiIGAB7o3PPMC5uV5olppEA9O1k/fokPrIFNUvMXpYeOqJO2bdAGeNNk7G
 5PcJbz9Hn3VkpnYMHFcSTYvoQ2aR87qKowTXep6SzMfVwbrrgIGjkniy03fDKuNk0JTv
 Wz8apPDyCAfRnwRpRGhbd4xzqveNFQ1CwTnauBAizMQzCYQTm32aLEUAnJCxnizglkSD
 wPWphH0PAUz888D3uROaGBEEblRkv75+61ySUka+IkmjyRQIYv8TwqBvFobpHu92DKPu
 z6S4S9PJn3i+s1exC3qDf5BYbot2mvmx577s0aK4HYDaBRDFBo88QlfxdHfXxUKrmzQm
 ZJ5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781168359; x=1781773159; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNw6491ibAw/fNpZxxH9sa5QPWryeY7W6+16dyUzILs=;
 b=a7JRBz639qCpiTVX+PNYEybkEPhjbJe2M86qs64x+HxZT4TK5ZHaYbfsMAf4/F7e0W
 CeC6l7E8agNFxB/TsUmo2BTQGIYlzFYqVmJ1fmn1X3RtBawL4KE4mo2+ZpQKy76+h6B4
 UjLXpOvJ3URHLyiMl7o1HMNqZkIEGXVdn1kEyejVZTnIgAuJnBv3kfneLnivHQ8egB1E
 AuePMfxJkdskeaiV94/JEopDF8NEQ/U8jsdyu5KoDHGy0IR+CGbOKGEY53ZJ9P0vgJFi
 5OxWfMXHKOyLKmf7gK1G5O1YiHsAv96pE7XA3BPQOyNtqbox9X7SLH50c3YvCMUJJW6H
 im0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781168359; x=1781773159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PNw6491ibAw/fNpZxxH9sa5QPWryeY7W6+16dyUzILs=;
 b=h/QZPpOFXNcJyazIm4A7s5ytYa4SpnzncjSgXnVvjeLFDOBWlUIuyCRRRhgPgYi55d
 YIcuFISaDSoKxYX7PHgKO/4wr5Th6LTY6quvxe7ZwNMqKb5Fd/5TbRnX1GEyN84rF5dR
 p5Mnr+mOriij08Y6U3TYCUVkQsxvK8KMAdy+6h6tQ1OP49eSFvU1PK6cQWACMVBSqSgK
 8mKgejahAZqJPzzjLZtNpOrT8GoX/8r9dT0KuNxrQGpt3W47ROkoGZ0norxlDN7xSFpA
 5bxaouqt2EoNsSSMxlzsYTfEI+sHdES1asDhalNIH1pjsBgRyZJ9mWg5N4II5wwTxobh
 oBpA==
X-Gm-Message-State: AOJu0Yz3jQzPgJjyxLSon//aSmd7W7dz6Gp4CtbKftqtADytvORpbfmT
 SwjcDdAcvshCl43xKl+Yav/Xh7lcsfQbGN1x2FI2V9njeDo2+bcYBmnx2IyIxyRhKrRebz9oKPY
 qF2pAcw5lXpHbF4j09kyqiNlcoz9XARI=
X-Gm-Gg: Acq92OHW8oUpJHtNhkjAJIBoJ4fAZ282vba5d8FXKv6jXQuT4+sgTGbaFedHXiXPn34
 0+y5ghbtn+Nga+z8EuD82CiStvHMSdaHv2/wEu5G+TW9ilzXFuNW1ldX70pQEkn/9Rm6Nv1RrNW
 1aaclGJEtB/YXwMDnAVPtknztBeml2HyY9sD3Q4LDw+RBhbSFw/S628kBd0sTzmMIHCb9sDOyb+
 lUc5ERYVKvoQmOoY2w5RoK/B+xA33lB58L4USPabb2T85mCj/dAqKR9cex0QvJ+6jUir/kZVJkH
 Cl7xizKutcU5jEE4w2jtbQXEFxy0z6l8HRRqZxDq7Wkf4UxPWq/XxXWPiAsV
X-Received: by 2002:a05:7300:dc13:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-3080479b71emr1683456eec.7.1781168359435; Thu, 11 Jun 2026
 01:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-29-9ea6355ea08f@redhat.com>
 <0abf9855-0b37-460c-baec-958785f1558b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0abf9855-0b37-460c-baec-958785f1558b@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 12:59:07 +0400
X-Gm-Features: AVVi8CcJeDu2jDz426s4GSaVNd7MgY35GA238m7575LgLDKh0qQGKj2b0Mwmg5A
Message-ID: <CAJ+F1CL9sLD4SuetrWSYNEe-kKrzGn_2m5Ctx1gvhU8oX1rrOQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/33] ui/gtk: handle console hotplug/unplug events
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
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

Hi

On Thu, Jun 11, 2026 at 12:03=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/08 16:16, Marc-Andr=C3=A9 Lureau wrote:
> > Register a console notifier so the GTK display dynamically creates and
> > destroys VirtualConsole tabs when graphic consoles are added or removed
> > at runtime (e.g. vfio-pci with display=3Don hotplug).
> >
> > Add skips consoles that already have a VC binding, remove skips unknown
> > consoles.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/gtk.h |  1 +
> >   ui/gtk.c         | 77 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++-
> >   2 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> > index b0be5070795..6cb611ce474 100644
> > --- a/include/ui/gtk.h
> > +++ b/include/ui/gtk.h
> > @@ -140,6 +140,7 @@ struct GtkDisplayState {
> >
> >       GdkCursor *null_cursor;
> >       Notifier mouse_mode_notifier;
> > +    Notifier console_notifier;
> >       gboolean free_scale;
> >       gboolean keep_aspect_ratio;
> >
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 6325704c397..6ef58d1367c 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -2332,7 +2332,8 @@ static bool gd_scale_valid(double scale)
> >       return scale >=3D VC_SCALE_MIN && scale <=3D VC_SCALE_MAX;
> >   }
> >
> > -static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
> > +static VirtualConsole *
> > +add_gfx_console(GtkDisplayState *s, QemuConsole *con)
> >   {
> >       VirtualConsole *vc =3D g_new0(VirtualConsole, 1);
> >       const DisplayChangeListenerOps *ops =3D &dcl_ops;
> > @@ -2414,6 +2415,76 @@ static void add_gfx_console(GtkDisplayState *s, =
QemuConsole *con)
> >       qemu_console_register_listener(con, &vc->gfx.dcl, ops);
> >
> >       gd_connect_vc_gfx_signals(vc);
> > +    return vc;
> > +}
> > +
> > +static void gd_vc_add_gfx(GtkDisplayState *s, QemuConsole *con)
> > +{
> > +    VirtualConsole *vc;
> > +    int i;
> > +
> > +    for (i =3D 0; i < (int)s->vcs->len; i++) {
> > +        VirtualConsole *v =3D g_ptr_array_index(s->vcs, i);
> > +        if (v->type =3D=3D GD_VC_GFX && v->gfx.dcl.con =3D=3D con) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    vc =3D add_gfx_console(s, con);
> > +    gtk_widget_show_all(vc->tab_item);
> > +    gtk_widget_realize(vc->gfx.drawing_area);
> > +
> > +    if (s->free_scale) {
> > +        gd_update_windowsize(vc);
> > +    }
> > +
> > +    gd_update_caption(s);
> > +    gd_rebuild_vc_menu(s);
> > +
> > +    gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), true);
>
> This ignores the user-specified show-tabs configuration.

true, that was useful for testing, but I should have dropped it.

> Regards,
> Akihiko Odaki
>
> > +}
> > +
> > +static void gd_vc_remove_gfx(GtkDisplayState *s, QemuConsole *con)
> > +{
> > +    VirtualConsole *vc =3D NULL;
> > +    guint idx;
> > +
> > +    for (idx =3D 0; idx < s->vcs->len; idx++) {
> > +        VirtualConsole *v =3D g_ptr_array_index(s->vcs, idx);
> > +        if (v->type =3D=3D GD_VC_GFX && v->gfx.dcl.con =3D=3D con) {
> > +            vc =3D v;
> > +            break;
> > +        }
> > +    }
> > +    if (!vc) {
> > +        return;
> > +    }
> > +
> > +    if (s->kbd_owner =3D=3D vc) {
> > +        gd_ungrab_keyboard(s);
> > +    }
> > +    if (s->ptr_owner =3D=3D vc) {
> > +        gd_ungrab_pointer(s);
> > +    }
> > +
> > +    g_ptr_array_remove_index(s->vcs, idx);
> > +    gd_rebuild_vc_menu(s);
> > +    gd_update_caption(s);
> > +}
> > +
> > +static void gd_console_notify(Notifier *n, void *data)
> > +{
> > +    GtkDisplayState *s =3D container_of(n, GtkDisplayState, console_no=
tifier);
> > +    QemuConsoleEvent *event =3D data;
> > +
> > +    switch (event->type) {
> > +    case QEMU_CONSOLE_ADDED:
> > +        gd_vc_add_gfx(s, event->con);
> > +        break;
> > +    case QEMU_CONSOLE_REMOVED:
> > +        gd_vc_remove_gfx(s, event->con);
> > +        break;
> > +    }
> >   }
> >
> >   static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *o=
pts)
> > @@ -2688,6 +2759,9 @@ static void gtk_display_init(DisplayState *ds, Di=
splayOptions *opts)
> >
> >       gd_create_menus(s, opts);
> >
> > +    s->console_notifier.notify =3D gd_console_notify;
> > +    qemu_console_add_notifier(&s->console_notifier);
> > +
> >       gd_connect_signals(s);
> >
> >       gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
> > @@ -2808,6 +2882,7 @@ static void gtk_display_cleanup(void)
> >           return;
> >       }
> >
> > +    qemu_console_remove_notifier(&s->console_notifier);
> >       qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
> >       gd_clipboard_cleanup(s);
> >       g_signal_handlers_disconnect_by_func(s->notebook,
> >
>
>

