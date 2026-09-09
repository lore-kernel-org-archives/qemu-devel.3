Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D88C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Bha-0008WH-7c; Wed, 09 Sep 2026 02:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4BhY-0008W4-5M
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:22:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4BhW-0003xP-4l
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:22:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso4219823a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 23:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788934948; cv=none;
 d=google.com; s=arc-20260327;
 b=CHGRIz4JIqQ/PYfuj3TMqg/w2FAOGXNaQY4ceXIn4zZluWk9c+oFyE/BEgisf8h8Jq
 YhKB2czldMckPx450rk4b8Ny+0f9TTd4Q5f+bL2hQ2JY+atyLVoFYyCD6XV2JZ5XHahq
 yguGZc79/nqwT+E4/mLD6+wcw9uJsDoQ8piXBmKOCWz9zqv+W/qyFxCzEoDS8mapIM88
 Fic2JS+wkHgp5Qi3CMwNVQoFN37xFxUZvCtVwiXIhG/h09V6lKKXpeoSwSjSAlDPsEdr
 K5KIepgIEayS3QhGivtfoL/A6k7VQsXZD+1rCnetXoASEXrYJY5CXQyJuURFz/C3We7w
 D+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d7ffpBRaHzZLr66kaBg9CU4rTUv0OWrNi7vLggnnbqo=;
 fh=qut9WCGoiumS8buQKfV4VTgRMJrLq2rWzZgt13Ew7uM=;
 b=j8AKAwa97R3WqqqyD7HEVjW4W3CQOnpWu/QiSo310IWRx2U9TEl6H5UoJmespaUdwP
 Clvu4FUTM64JKV7hnwUq0djer3T1KR3mJwWmrIyhC6h40EElW4EHmlzdIa3CPrRzk0XV
 gfrc+iNweptYeTHFlx1311HkC3jI2JCs8EG4Sq7mPG7XMyqpOaq7x1xIt/8qkWXg2MKe
 JA2vEk3UdULlk5lN3Nwsn8v+lR7b1j57BgkNSITK66CjSYHEnXaU51TRihVtvj2MBISg
 Z1LUpwxr2f3+yXN79NxSVMjYw2gI0NJYIbh/zMcpdPB//g22c+7Uab0JnWthdccuGUli
 WNvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788934948; x=1789539748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d7ffpBRaHzZLr66kaBg9CU4rTUv0OWrNi7vLggnnbqo=;
 b=fjb6M3kAJzayblYdr6qXDnHJ+x8DBvRwM0JGW845njaCO45AaI3AYpy3gJSxPSO4EV
 xd8XJ8A/8iSMRlezTPki0LCaNF9v7YOIeeFQBZW8tbcNxpnfaWeN3xpwTtXhy6K3pZrn
 3zQsEn8oD//5pow0rVJDNXS+GG1vVWwK7YKsWnDrkp/SBaNoMqrkRQHPci1xey7VZYxM
 GDpvH5plgJ8t2RoOHx0vzZ9rNUxS0LUMf0xY8w1Yj/CcDBSpYRbgDB7Ffis5etuDPEHh
 zow23u2no/Wt3twzVWooK9mrbaHZ+TnnZJkTWUa0nVhjypiHVsyUVuAVmEl1dusHcwSb
 SDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788934948; x=1789539748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d7ffpBRaHzZLr66kaBg9CU4rTUv0OWrNi7vLggnnbqo=;
 b=UYWueW8iEiV8XoSS9FNS7sTvzF8CWFlS1SzLVVFWE0JF2o4OLeWEMMQnIOjdJU2sNb
 hEV+5doMzT4njlwbkZ/WJsWGY7OX5Ole+hcFkD4Mxae9Vor51yNjOA0aYErM/rsrxjB5
 AlAGMn8S8J4TKH2qobkwspjvEFKLaITy7K9U59rhGcduOne5NymN+y8Za6nZorOHKl/1
 PKBfp1PgG8q+JABEYtAwfBX/tMOY1Vdd++L1haqwPC7oip3W2a0HsT94U0zOeW2kn1bs
 U4S6IyZfgaQg2pX5lyCbg1B8mPYFxYECYz21rW7Oy+3rp9HgUMrn3/DHSXAiysUTIvg3
 8Lfw==
X-Gm-Message-State: AFuF++nM7RDmJBwXOD50GARbHYHSz8Tfnetyc4tAvK8/pKaA1pj3bQmv
 lZlDMqQNLOHv8T9Eo5Jv2G2mlb328IuQo8rTPHdfEC+hran41L6cOoiPN3svwzqN4+Mv60sZrz+
 dnfokglvpmsfJAD5KJG73SYwubDbD3KLtZQ==
X-Gm-Gg: AYBFou1G8ksLzZK4URezTiYJw1g3WhHPyMabsqjEJd1Jz9gRrNsV7DLr0wzqcP9VGQI
 aNGgta5EivwOFGO6UiJUA5Byih+PYGawkZb42w7YrI9YAwCUVY6o7Tkq23puWh16YQItZxiMG6r
 2907qPGOXNGvKNY3guumAjyVKI0MK7dKnCa/TWObAEks2PY1hax9+ZA37R6z5fOhAgFDNzBpXps
 BMZTDjrRJHVbVTzwE5mKv3EMy7iIm+Z0mJgHtceof07pOZxDsAENopMNbhtRuncIxWxtzXNfe7q
 XeLE3guqr23xXNGmk9/ZxGUEfoF+lCtHXylhbU+c/rgC8G+2Akim2WPhnE70+B9t5eTUn4IC2dM
 b5aav+u2WEcg=
X-Received: by 2002:a05:6a20:7284:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3da39ec3ef2mr47467448637.10.1788934948302; Tue, 08 Sep 2026
 23:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260907201724.523270-1-dongwon.kim@intel.com>
 <CAJ+F1CKJN8enxs5Me-QydcG-8mH4oQqd8aCtQa=phHa+r6yANw@mail.gmail.com>
 <PH0PR11MB5112DE2261942C6F3058CD0FFAB12@PH0PR11MB5112.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5112DE2261942C6F3058CD0FFAB12@PH0PR11MB5112.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 9 Sep 2026 10:22:14 +0400
X-Gm-Features: AcwNN1Wza1-Ho5nluCqikfooQgZILGvETm9_0qGJedtpm7bf_fm3ng-CsEZyCvM
Message-ID: <CAJ+F1CLj6ydVzfUaYfGz7_6g5sfkPX4G1e2VPJDr3W_iYN_-tg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Handle empty notebook state in menu handlers
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52d.google.com
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

On Tue, Sep 8, 2026 at 8:49=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > Subject: Re: [PATCH] ui/gtk: Handle empty notebook state in menu handle=
rs
> >
> > Hi
> >
> > On Tue, Sep 8, 2026 at 12:18=E2=80=AFAM <dongwon.kim@intel.com> wrote:
> > >
> > > From: Dongwon Kim <dongwon.kim@intel.com>
> > >
> > > When the GTK notebook has no active page (e.g. before pages are added
> > > or if all pages are detached/removed), gtk_notebook_get_current_page(=
)
> > > returns -1. Previously, this value was passed unchecked to
> > > gd_vc_find_by_page(), which could result in unexpected lookups or NUL=
L
> > > dereferences.
> > >
> > > Update gd_vc_find_current() to explicitly return NULL when page < 0.
> > > Additionally, add NULL checks for the current VirtualConsole across
> > > all relevant UI menu callbacks to avoid dereferencing an invalid or
> > > NULL pointer when no console tab is currently focused.
> >
> > This looks reasonable, but can it happen? if so, how? Rather than handl=
ing a
> > situation that should not happen, I would rather crash or abort if we b=
roke an
> > invariant.
> >
> > thanks
>
> The mention of "NULL dereferences" in the commit message was inaccurate.
> It's not causing a crash, but rather logic bugs. This happens when all VC=
 tabs
> are detached (untabified). In that state:
>
> gtk_notebook_get_current_page() returns -1.
>
> For any detached tab, gtk_notebook_page_num() also returns -1.
>
> Consequently, gd_vc_find_by_page(s, -1) matches the very first detached
> console in s->vcs. Menu actions triggered on the empty main window mistak=
enly
> route to that detached window instead of being ignored.
>

Please correct the commit message then
thanks

> Thanks!
>
> >
> > >
> > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  ui/gtk.c | 56
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 50 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index 7078d89d67..0b5139ef31 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -184,6 +184,11 @@ static VirtualConsole
> > *gd_vc_find_current(GtkDisplayState *s)
> > >      gint page;
> > >
> > >      page =3D gtk_notebook_get_current_page(GTK_NOTEBOOK(s->notebook)=
);
> > > +
> > > +    if (page < 0) {
> > > +        return NULL;
> > > +    }
> > > +
> > >      return gd_vc_find_by_page(s, page);  }
> > >
> > > @@ -1462,7 +1467,10 @@ static void gd_menu_show_tabs(GtkMenuItem
> > *item, void *opaque)
> > >      } else {
> > >          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE)=
;
> > >      }
> > > -    gd_update_windowsize(vc);
> > > +
> > > +    if (vc) {
> > > +        gd_update_windowsize(vc);
> > > +    }
> > >  }
> > >
> > >  static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole
> > > *target) @@ -1535,6 +1543,10 @@ static void
> > gd_menu_untabify(GtkMenuItem *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >      if (vc->type =3D=3D GD_VC_GFX &&
> > >          qemu_console_is_graphic(vc->gfx.dcl.con)) {
> > >
> > > gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
> > > @@ -1588,7 +1600,10 @@ static void
> > gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
> > >      } else {
> > >          gtk_widget_hide(s->menu_bar);
> > >      }
> > > -    gd_update_windowsize(vc);
> > > +
> > > +    if (vc) {
> > > +        gd_update_windowsize(vc);
> > > +    }
> > >  }
> > >
> > >  static void gd_accel_show_menubar(void *opaque) @@ -1605,7 +1620,7
> > @@
> > > static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
> > >      if (!s->full_screen) {
> > >          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE)=
;
> > >          gtk_widget_hide(s->menu_bar);
> > > -        if (vc->type =3D=3D GD_VC_GFX) {
> > > +        if (vc && vc->type =3D=3D GD_VC_GFX) {
> > >              gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1=
);
> > >          }
> > >          gtk_window_fullscreen(GTK_WINDOW(s->window));
> > > @@ -1618,14 +1633,16 @@ static void gd_menu_full_screen(GtkMenuItem
> > *item, void *opaque)
> > >              gtk_widget_show(s->menu_bar);
> > >          }
> > >          s->full_screen =3D FALSE;
> > > -        if (vc->type =3D=3D GD_VC_GFX) {
> > > +        if (vc && vc->type =3D=3D GD_VC_GFX) {
> > >              vc->gfx.scale_x =3D vc->gfx.preferred_scale;
> > >              vc->gfx.scale_y =3D vc->gfx.preferred_scale;
> > >              gd_update_windowsize(vc);
> > >          }
> > >      }
> > >
> > > -    gd_update_cursor(vc);
> > > +    if (vc) {
> > > +        gd_update_cursor(vc);
> > > +    }
> > >  }
> > >
> > >  static void gd_accel_full_screen(void *opaque) @@ -1639,6 +1656,10 @=
@
> > > static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >      gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s-
> > >zoom_fit_item),
> > >                                     FALSE);
> > >
> > > @@ -1659,6 +1680,10 @@ static void gd_menu_zoom_out(GtkMenuItem
> > *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >      gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s-
> > >zoom_fit_item),
> > >                                     FALSE);
> > >
> > > @@ -1676,6 +1701,10 @@ static void gd_menu_zoom_fixed(GtkMenuItem
> > *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >      vc->gfx.scale_x =3D vc->gfx.preferred_scale;
> > >      vc->gfx.scale_y =3D vc->gfx.preferred_scale;
> > >
> > > @@ -1687,6 +1716,10 @@ static void gd_menu_zoom_fit(GtkMenuItem
> > *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >      if (gtk_check_menu_item_get_active(GTK_CHECK_MENU_ITEM(s-
> > >zoom_fit_item))) {
> > >          s->free_scale =3D TRUE;
> > >      } else {
> > > @@ -1800,6 +1833,11 @@ static void gd_menu_grab_input(GtkMenuItem
> > *item, void *opaque)
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > >      if (gd_is_grab_active(s)) {
> > > +        if (!vc) {
> > > +            gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s-
> > >grab_item),
> > > +                                           FALSE);
> > > +            return;
> > > +        }
> > >          gd_grab_keyboard(vc, "user-request-main-window");
> > >          gd_grab_pointer(vc, "user-request-main-window");
> > >      } else {
> > > @@ -1807,7 +1845,9 @@ static void gd_menu_grab_input(GtkMenuItem
> > *item, void *opaque)
> > >          gd_ungrab_pointer(s);
> > >      }
> > >
> > > -    gd_update_cursor(vc);
> > > +    if (vc) {
> > > +        gd_update_cursor(vc);
> > > +    }
> > >  }
> > >
> > >  static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint
> > > arg2, @@ -1983,6 +2023,10 @@ static void gd_menu_copy(GtkMenuItem
> > *item, void *opaque)
> > >      GtkDisplayState *s =3D opaque;
> > >      VirtualConsole *vc =3D gd_vc_find_current(s);
> > >
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > >  #if VTE_CHECK_VERSION(0, 50, 0)
> > >      vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal=
),
> > >                                         VTE_FORMAT_TEXT);
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

