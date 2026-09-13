Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACD1C88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5gBA-0007d4-FI; Sun, 13 Sep 2026 05:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5gB8-0007ca-VN
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 05:07:14 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5gB7-0000gg-43
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 05:07:14 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso495948b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 02:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789290431; cv=none;
 d=google.com; s=arc-20260327;
 b=SisIPMKAgoBOmE7ysyMOrJf19nllwRfzwQEgjdtPAF5PEm1BmaKT6JO73nPFj1Y8bo
 x3YCRWholzMSaB2gAPG1n9sFDKdzXizqUJEooqm0XfAY/fHw2AJ42oy6dH52cR7egvUx
 UeW0jSBeu2dl33/k1lL7AZTI2l8fB1VOPHY+BXVN7ZMPSc//6wSaJnNtcFUtESpVBKpy
 eMOJ8e8/opVVGcLzepXEulO68kgxDjH4shbqGq80uS+lULhSZUg5p5uGuWXjgpKDsl1x
 D1QmXqQiCwxf4dE+qRf2OwUnUp8XwgNAp/cAmNJQp/F69LiRUBVNClQMShBRds0W7sg3
 Y0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=danLeoRTSF6q8wCLFxlpfFfT+gr65XpcCVGrzBWqro0=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=GmC7dx9mhq3uX6sSzmvSseM93BE5DyLoMcRuXwutJqlzO904dmaWVQvtmK33Jq2ev3
 C3WK/4Q1W3LblAfjvqqnCUZZnivxTfnio3zsYL92E1ARQICpvt3TScOBcm3nMcUPu+MA
 5rhlGV2xeqgv8x/pNAccvApodo6tweAg/WItPLS7YejgRhsxcAGqlsPYCSSLJPElE5e7
 n7ou/d6jR3P+WcP/oMqifqbKHQByOFRap7LKTpX5uzcLxk6npY44bYZvkzgvpNt2T+Wa
 6LR09muwnOb9M83X6hbbV3tngrB3F6FMtBWCNz5zjaVz1DPzJ95ABhlcj/POXS3sBr22
 PJyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789290431; x=1789895231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=danLeoRTSF6q8wCLFxlpfFfT+gr65XpcCVGrzBWqro0=;
 b=UjNOb/PCtmk1KwxCavQuSslQRMQesbf6hAlGdzrgRkPebeI5Nnsf7GRUi96BFYHbso
 gjymlSLmULk1RLJsIYf9yug0/0k6xAMij7QTu7D8OSnExjNH3QU3YYSBaI9n0lwO8lXv
 X8HD7UJJe9/+BxpefEZQs7XqPKd50i1Li1gJlD1lnAzS4KHXeTjjwa4vnegCVQbqrxQ6
 3Jij4qptJwq35dbGhIzZLG1bHJVfng8NZev/bMOaIF2oZRuLhpZvrxct6ydiI7GMmD/t
 BnbsCOldx+LO1G1xo6UCe028c1qts4SDzh8fXzwlk3+crpqtVV4RWP4kGKWc1IO1TvuY
 ELfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789290431; x=1789895231;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=danLeoRTSF6q8wCLFxlpfFfT+gr65XpcCVGrzBWqro0=;
 b=bsuVOu6s7FgZK7GImQuAQFpHm4U7vkR6iJwSqzVj0UCOh3a2Fb9nfixeecixrn6Nyz
 cen0bKm3ZFhPiqLmGewY1qLe0neRibnLpHi3y/SxoV6SfIoSrzRqgPW36TqPtIerxHUn
 jfFgk1BnaCuinZAjmxvzN2jScYh9AleLOAFOr7VKpltxQkj3B8QRvuD3tx3N3XDJscPJ
 C2EQVQswyp2Dc50GBwyNnuimSjaAWwuG4wIlv8yedORXALn46Nm/nIqAGxiFCd/oNGYX
 VLwriYacATGCOEl1HfyT7EOXot1mE4aRXaqT7+6pJBfYKSkgWL+ylBXCCJcj8SbZgYhB
 5yhQ==
X-Gm-Message-State: AFuF++l6iA4q/ic8wOiB+1e24KKbbD/sfDI4b59nqMXdYM8C9rJfEcYG
 71t3PvvTJqzVZtIrs/Y3O45BC+S+s27Few5sh4EFf8KG7Ve9HTNZpo/rmOOjzfL0Qg5b31q5Ky4
 QgXruCIlGa0MzTk1oQJoHOQkIE6rgW5Y=
X-Gm-Gg: AYBFou0h4srEd3foqeQ46zH8knEFmOAfCA/X81aeuq40GXD4niK91DFNdEowBSZ9waZ
 yE6KGtsEI8YyYERw41G1Q6Npsxvpw1z9euqmQifQHvTjQfCh8tu93tAtlIxtt6FARQEuZTsTWgN
 m1nbEZIDgu4nRnjpA/tTMJTN6bdjwURgThhDX9agpRCPGGulROpJ5KiBxgKcxSn+WI3iBrBFByu
 b5VgbUl+1M4rdD0L6PevS7DT8vDSJ7PtohXX7rFWF/48POeFZEweUXVFCcEi08x+BWtjC45qUIB
 3EcOWtJU5x8IdRelmOokqxjUqz3Rity6l0VFaB6WF/fFWi7tj9zdZNWzeScc7fT5DvTJySvD9fV
 Ck4MaXzuXjdQDx3+h2WtISg==
X-Received: by 2002:a05:6300:6684:b0:3bf:9b3d:61bb with SMTP id
 adf61e73a8af0-3db0e1f7d7bmr12299102637.16.1789290430717; Sun, 13 Sep 2026
 02:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260729214456.3350-1-dongwon.kim@intel.com>
In-Reply-To: <20260729214456.3350-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 13 Sep 2026 13:06:57 +0400
X-Gm-Features: AcwNN1VMqM4OPZfX1E1RDkRpqpD-_VY5VL1niAwfau2AJ8vv5ZkglzXcoh9NRik
Message-ID: <CAJ+F1CKKzn8Ly3eH3CkgQTTvQHypTsZPdhgRPekEXSnaFuxmSw@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Handle empty notebook state in menu handlers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x10.google.com
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

On Wed, Sep 9, 2026 at 11:27=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When all virtual console tabs are detached (untabified) from the main
> window, the notebook contains no active pages, causing
> gtk_notebook_get_current_page() to return -1.
>
> Because gtk_notebook_page_num() also returns -1 for any detached VC,
> gd_vc_find_by_page(s, -1) mistakenly matches the first detached
> console. As a result, gd_vc_find_current() incorrectly returns
> a detached VC instead of NULL. Menu actions executed on the empty main
> window then unintentionally operate on that detached VC.
>
> Fix this by having gd_vc_find_current() explicitly check for page < 0
> and return NULL when the notebook has no active page. In addition, add
> NULL checks for the current VC across relevant UI menu callbacks so
> actions are properly bypassed or reset when no console tab is focused
> in the main window.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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

