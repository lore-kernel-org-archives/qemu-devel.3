Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF06C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rTB-0003p5-3z; Tue, 08 Sep 2026 04:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3rT8-0003oh-JF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:46:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3rT6-0000Ab-Ll
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:46:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso4508405a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 01:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788857175; cv=none;
 d=google.com; s=arc-20260327;
 b=fbusEvqleDWhABDwy4koqcyxvxeVSwkLjurOVVuexXyzh7yoSMHaqW+g8Te/RIuZ+D
 pk3/gFrjCFSrXrzevbOUb/xBtTVsnna3ed0P3a89ft+dmv4rrzCvdY2kjIv4DtS7lkoy
 Y0fiaw+bPeE9yL0Aara6HTa0zWrTms5xb6ZI2pWqfIeXcYdKIunvemwAP8DsSPD2Fv8G
 rGS8b60+iy5TEqz191YQ/3MemadYScx2ZKEhT4FVBdf7nf4RiKxhMyJe9jBHzsJ/UbaT
 MZi+LziSgLX7PS10K8LW+dUTKLcQRw4P7n7XhMPFVQ1g724dfRskleCEVuS0zqotZsSJ
 HEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fvq24ezWWJUaNzuJyOiGCZYmVRlvxgulaV7ucZp8dXY=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=rPDX0OcAwgbTenpVeykAnA3ZIdhJc5pg+47pb5//UaJ4+5o0OpXhAXjtXgVjIzH2Gt
 7k58FEm+e/OidQTmsl/UyIhCWunUG3FI0NwUuWg9AgNPGJhq3VYFNvJxXyrFLzeBPMLR
 7PdsZD+EHDB0yMC+kMsSv3NsXz1eIS0G4QIRVUBWdSRhtbiUDTMPHuPV/rCCp+1Z86SH
 Ur53SOlFCvnkCWx0y8JWa3fTtNwC4IuUxTaRcctRcyE0pMyqz7Y+ZIhFVCtfIyd8z+Yh
 pObQx2OrJoqQ9OiFBZ0simmOgE0rtpRhcfXFvMgZiMeiwrlcNOI6LlV1g47RU2gEbmqj
 7s/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788857175; x=1789461975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fvq24ezWWJUaNzuJyOiGCZYmVRlvxgulaV7ucZp8dXY=;
 b=E1vR82S1ytKeClyszJyV3rbPaoy8LLMcCHKkRkNwpRk6SNfBb3VvV9zzAdBGzSzbKn
 zGyU2W9b49s9D6ftBpJz9FgxTm8luPoRvs1tIX0VreNfQ/yzkHetF4Ofbsqz6/3p/1h1
 Q4XdZZhp//crgLoPTnHMgG+gSWK3+jbAwSxQR2/saoUPp+pVfuUM1eA8y17XrrUCZzrQ
 aD6w7FkRVwT73203fHIhKIUqbVvFHlTJuqs6S2yt2A1oYRHr2NGTYtg/Br+2IpZhjn6X
 wgmx5UWTB+4PqMJGzvU1vwUbJahblE21SKkAq2FHuspOonjGocuQzKVtRxYfn9oiyhAE
 p0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788857175; x=1789461975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fvq24ezWWJUaNzuJyOiGCZYmVRlvxgulaV7ucZp8dXY=;
 b=CxAhjG2WfhALr0V/0916RKTIkr3mUkFek+SKTak894p2KEkMY/mCfMXHobyRJvPKnX
 3Al8YUoPneg8OaKbTs/267qy8H9VGEGYH+5IrNjVzy2vRT2RN3Fa2kkI0uqvKUIrq7OG
 FctDlmuAVZjhDiUpuQN8HKTbOklzx4RlWi5tfXrKed8ThZDWBoDqI9KFIvYOSr2l/Wk8
 iOQdoYLJOf3H1OeyCMkMjW/wvnK1EcXkQIZk9evn2udMLWCuHXE4ezUp2BLYMg5bS5Lz
 Yi3AfdIcFIU+U3bSQ+dFBYq4quCSg5P2q+s3f1dZTqlhz+G+iPtuCb1j2aPZzXWtYEMR
 We7w==
X-Gm-Message-State: AFuF++nIZ+Jadj+mAq0oMi37NXsqba4c0nlu3zGrc16sx22MvEFywA8m
 Xc2h3feSDKItellvKAJ1MRlFq6fNezRHMuGfhHFXSXldJyNWRnSlX6Grs6fRvhbKiSSd/NBx2t4
 PpDAVJJEAoXREfxBu4iQaULJKAdZW5uk=
X-Gm-Gg: AYBFou2z3ttu+NVRaIBWimvCe0P3TU1cEDEFUZL/JOhElq6z8FhQiEjaF6vi0NwzzlO
 AnjCj8f43G/lh8NOAcAd6bz6CQg+/PmmtWlXEmvGDxOq+joZ29swTeHxUohoTYG3PxT9NYEGc7s
 zuVhesAAXuRDHfbxr54XfhdNPli2MKAvbGV86MCwelYC3C0RYykMN12alRAuKmc2eECfaEcQQfZ
 DGsTEzeoevPOMArfPgAwrJxsaDKsrpG0g2HqJ5tWzJxlXp2Jhoq5E9khXDrB6+VLNWnZyVVqmnt
 3AAsLSNwGixKPnsbxYPzwj1O6vMsLrwwE9L9lQntOxI+MkzEOhZfyYZk/z5PM6Pw95gIknhk9Gf
 8B1UfthnFfN8=
X-Received: by 2002:a17:90a:1189:b0:39b:2c55:365 with SMTP id
 98e67ed59e1d1-39b2c55287dmr23813911a91.12.1788857173690; Tue, 08 Sep 2026
 01:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260907201724.523270-1-dongwon.kim@intel.com>
In-Reply-To: <20260907201724.523270-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Sep 2026 12:46:00 +0400
X-Gm-Features: AcwNN1VABCNpaI6fELJRJYq4XpZa1wd4Cv265-SyN2unL1OI7W4_NFdY4h54WsI
Message-ID: <CAJ+F1CKJN8enxs5Me-QydcG-8mH4oQqd8aCtQa=phHa+r6yANw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Handle empty notebook state in menu handlers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102a.google.com
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

On Tue, Sep 8, 2026 at 12:18=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When the GTK notebook has no active page (e.g. before pages are added
> or if all pages are detached/removed), gtk_notebook_get_current_page()
> returns -1. Previously, this value was passed unchecked to
> gd_vc_find_by_page(), which could result in unexpected lookups or NULL
> dereferences.
>
> Update gd_vc_find_current() to explicitly return NULL when page < 0.
> Additionally, add NULL checks for the current VirtualConsole across all
> relevant UI menu callbacks to avoid dereferencing an invalid or NULL
> pointer when no console tab is currently focused.

This looks reasonable, but can it happen? if so, how? Rather than
handling a situation that should not happen, I would rather crash or
abort if we broke an invariant.

thanks

>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 7078d89d67..0b5139ef31 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -184,6 +184,11 @@ static VirtualConsole *gd_vc_find_current(GtkDisplay=
State *s)
>      gint page;
>
>      page =3D gtk_notebook_get_current_page(GTK_NOTEBOOK(s->notebook));
> +
> +    if (page < 0) {
> +        return NULL;
> +    }
> +
>      return gd_vc_find_by_page(s, page);
>  }
>
> @@ -1462,7 +1467,10 @@ static void gd_menu_show_tabs(GtkMenuItem *item, v=
oid *opaque)
>      } else {
>          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
>      }
> -    gd_update_windowsize(vc);
> +
> +    if (vc) {
> +        gd_update_windowsize(vc);
> +    }
>  }
>
>  static int gd_vc_notebook_pos(GtkDisplayState *s, VirtualConsole *target=
)
> @@ -1535,6 +1543,10 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>      if (vc->type =3D=3D GD_VC_GFX &&
>          qemu_console_is_graphic(vc->gfx.dcl.con)) {
>          gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item)=
,
> @@ -1588,7 +1600,10 @@ static void gd_menu_show_menubar(GtkMenuItem *item=
, void *opaque)
>      } else {
>          gtk_widget_hide(s->menu_bar);
>      }
> -    gd_update_windowsize(vc);
> +
> +    if (vc) {
> +        gd_update_windowsize(vc);
> +    }
>  }
>
>  static void gd_accel_show_menubar(void *opaque)
> @@ -1605,7 +1620,7 @@ static void gd_menu_full_screen(GtkMenuItem *item, =
void *opaque)
>      if (!s->full_screen) {
>          gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
>          gtk_widget_hide(s->menu_bar);
> -        if (vc->type =3D=3D GD_VC_GFX) {
> +        if (vc && vc->type =3D=3D GD_VC_GFX) {
>              gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
>          }
>          gtk_window_fullscreen(GTK_WINDOW(s->window));
> @@ -1618,14 +1633,16 @@ static void gd_menu_full_screen(GtkMenuItem *item=
, void *opaque)
>              gtk_widget_show(s->menu_bar);
>          }
>          s->full_screen =3D FALSE;
> -        if (vc->type =3D=3D GD_VC_GFX) {
> +        if (vc && vc->type =3D=3D GD_VC_GFX) {
>              vc->gfx.scale_x =3D vc->gfx.preferred_scale;
>              vc->gfx.scale_y =3D vc->gfx.preferred_scale;
>              gd_update_windowsize(vc);
>          }
>      }
>
> -    gd_update_cursor(vc);
> +    if (vc) {
> +        gd_update_cursor(vc);
> +    }
>  }
>
>  static void gd_accel_full_screen(void *opaque)
> @@ -1639,6 +1656,10 @@ static void gd_menu_zoom_in(GtkMenuItem *item, voi=
d *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>      gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item)=
,
>                                     FALSE);
>
> @@ -1659,6 +1680,10 @@ static void gd_menu_zoom_out(GtkMenuItem *item, vo=
id *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>      gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item)=
,
>                                     FALSE);
>
> @@ -1676,6 +1701,10 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, =
void *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>      vc->gfx.scale_x =3D vc->gfx.preferred_scale;
>      vc->gfx.scale_y =3D vc->gfx.preferred_scale;
>
> @@ -1687,6 +1716,10 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, vo=
id *opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>      if (gtk_check_menu_item_get_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_i=
tem))) {
>          s->free_scale =3D TRUE;
>      } else {
> @@ -1800,6 +1833,11 @@ static void gd_menu_grab_input(GtkMenuItem *item, =
void *opaque)
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
>      if (gd_is_grab_active(s)) {
> +        if (!vc) {
> +            gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_i=
tem),
> +                                           FALSE);
> +            return;
> +        }
>          gd_grab_keyboard(vc, "user-request-main-window");
>          gd_grab_pointer(vc, "user-request-main-window");
>      } else {
> @@ -1807,7 +1845,9 @@ static void gd_menu_grab_input(GtkMenuItem *item, v=
oid *opaque)
>          gd_ungrab_pointer(s);
>      }
>
> -    gd_update_cursor(vc);
> +    if (vc) {
> +        gd_update_cursor(vc);
> +    }
>  }
>
>  static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
> @@ -1983,6 +2023,10 @@ static void gd_menu_copy(GtkMenuItem *item, void *=
opaque)
>      GtkDisplayState *s =3D opaque;
>      VirtualConsole *vc =3D gd_vc_find_current(s);
>
> +    if (!vc) {
> +        return;
> +    }
> +
>  #if VTE_CHECK_VERSION(0, 50, 0)
>      vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
>                                         VTE_FORMAT_TEXT);
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

