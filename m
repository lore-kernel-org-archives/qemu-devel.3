Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14DFC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77PY-0000zo-Ay; Thu, 17 Sep 2026 04:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x77PV-0000zT-3E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:24:01 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x77PT-0002Ur-6c
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:24:00 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so402120a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789633437; cv=none;
 d=google.com; s=arc-20260327;
 b=pwrtbIbggSFC1j8SeTd1AL74YoqLGDCnijbni8jrotlB+YsQXJbu3w8iVPGgFL+XTG
 WvJLmZ4lIJi1y/F9Q0aDuVc5AcffvxUoqBxYx/TA2389HnHdi41UYbor/FOBjkebNWrX
 wNjrqYyiXCPM6krGrDFzUqI/CQ9c/OcO+enxR2B8i2ciK3c7JRCIgEYu78ntSsUolsAe
 faF08b5NEDC7GiXlcv6bkcfOf2fw1dMdXMOPTA52GPOwbSGCoC68klKsAo89rQzzGyxx
 BuDh+7w3b3cdcXlmTFGRDsmvFjpdoIoU4oT4dQa88qml0YEC2iQt1zpC5SSv6SI7K/T2
 SWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MgljbMx+9tbggmGmsP3W5ODQaw4qYd5hbvO8caxkUQI=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=Sjn1Chhv8N7FPSFkypHgGhqo/ViT0U2GiZpDAzjgzilAtZHa98ePsV4RuWu0+nMZoF
 oIqeqxsp70fELr8Jx+ZfIJ3eCV5rcz5GloistRSuAJFNu6iLGYtJWKhgfHyu+F042krb
 f1lRellUnc+IP77Y8U0ixvtKjJQCixmXgmSvt+P0QTmwp90QmOK0x+uwE2Fk5Ae6lduA
 ZKvCTbENtji/zTMPdcd2cSqXfaSOET/n2zUEw1AWoBJhJrfUTLVvGhq1ACooLsbPKRh7
 dVqp9vqA4OFoZXE0fa2cgNdijkOyG1HZa/OI9R2cEI18tcdP8W6zRzBy7/5UcrwVIeUI
 XPdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789633437; x=1790238237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MgljbMx+9tbggmGmsP3W5ODQaw4qYd5hbvO8caxkUQI=;
 b=N+UXjEE/X6LkqdywpUfM2FUz2hyPM1gBA1hwPmb8Z/tH85zokC6pCIf3c+2iXRd2sJ
 WzJU/Ng98SfPfo2EOgbRdysiQFXSvU/I1SzbjzCXK+uvfsPeAyiqT/GJtNp3f1pTP2pf
 R2g+0bBbxal78QF5UeAJeezOR+cvE/MXk0//1T7fyXCrkWfvjYUm1WPuR9vfPXH1mJV9
 HFOWAb2/9eb+Nuj9MxkbTU76IvUfoEfQ/5JQl6OjPtr8CRwCgI8qAPu+7ffZuyPtCu3I
 gH8EKRuZlo7TKkebwQDMSmlqYoGV8A0hiqcaEjvaf3Uxcah0l9e6Psjw6KfmmQ8kj3zH
 sVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633437; x=1790238237;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MgljbMx+9tbggmGmsP3W5ODQaw4qYd5hbvO8caxkUQI=;
 b=HQNxCLuntBuaViNZ2kkqfBvvrX4q2exBb0h70Vh+9U3ZZ0/WhhUqIVMcl4O4YCy47j
 FiZ5C1SMktK3U0Mcoam4wN4/Z/C5zp+BF+UpgjrnQ1fNiyF8P+AltGNIj+NZtTke9iSz
 hoMxJQavz7+vh551e7bZBzGhoj2Av+kNzKlQsPrYP7RHS2zFFN0z4TnRZO8VBf2W87sQ
 NFbin8RXyt675wTZaS0NBsE75M7SMQ+CD7hbQHpct1l1M5m5cXQeU5/viEj7L150VQjF
 9X7eOikma/AptkR/6K/T9GHeI413SpmtYf+h+ouSyK+avF9MxG1tfFT84DZgrY/asQZf
 7Z5g==
X-Gm-Message-State: AFuF++m849F7MpM7vYfzzy+tyqsJ72itpcxLN3hYcEaey+whKp10HjDp
 FRC88FFE9JDlm0BJ9eJPgtk8uVNKQ8KBeV4g9se2f2tnM5BC7SbFOb/ThWTFHMxPqWE0fRI06xZ
 qZ6qOFwMbME8l77BbgaBSkt0pRTNq3CE=
X-Gm-Gg: AYBFou11xHt3+stSiRdm6OOVbVttMzH+xxkab1yrJ2abMGm82LQrZaQcQZ6jRZUwx3W
 DcWUGweOGRfwYY+QUS7jP7kLZWS7cq7zSbPz854LwBWydHf9PQipc8s4Rqnzq8oVRhJuo0RzNq5
 zI0dvLnejFGbGSZA+FDJovyIRkb5sXGZ3jxrm8En3cPR7zIjkILuJZRlxnkqjBG/ugT/GZ2Ufht
 sIhHZQJerxk9WQTYghYC1PBx33sgDMppPLT7aKvYcj3V3+jzeRAoDl/d7XPMgZgbPDCS9rvlzRO
 HbvyrJzMUxspVT2sO1T7uzujJn/6nbiV9xhJ75hNvFRkw09UAcEXF7yVTEEMMKEDSQrvL6DsgfJ
 urp5W5cdZLwQ=
X-Received: by 2002:a17:90b:2744:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39e1e5770b9mr19219704a91.25.1789633437220; Thu, 17 Sep 2026
 01:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260805092017.21028-1-dongwon.kim@intel.com>
In-Reply-To: <20260805092017.21028-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Sep 2026 12:23:44 +0400
X-Gm-Features: AcwNN1UWZ6-67jlYvxjVS83NLC56rU91JsNtw6_gyVe6Q8K17crbojue23AHqgo
Message-ID: <CAJ+F1CJb0uN6912RBvhe5H=epKnShmCVGDVRw8_mJWs-ActKVw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Enable fullscreen and zoom hotkeys for detached
 windows
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

Hi

On Tue, Sep 15, 2026 at 11:02=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Currently, the fullscreen toggle hotkey (Ctrl+Alt+f by default) and zoom
> hotkeys (Ctrl+Alt++, Ctrl+Alt+-, Ctrl+Alt+0) only function for the main
> QEMU window. When a VC is detached (untabified), it loses these capabilit=
ies.
>
> Implement toggle helpers, gd_win_full_screen and zoom helpers
> (gd_win_zoom_in, gd_win_zoom_out, gd_win_zoom_fixed) and connect them
> to the detached window's accelerator group in gd_menu_untabify.
>
> Also remove a leftover debug fprintf in gd_win_grab.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 98 insertions(+), 4 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index a723c8215d..632e302ed7 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1547,7 +1547,6 @@ static gboolean gd_win_grab(void *opaque)
>  {
>      VirtualConsole *vc =3D opaque;
>
> -    fprintf(stderr, "%s: %s\n", __func__, vc->label);
>      if (vc->s->ptr_owner) {
>          gd_ungrab_pointer(vc->s);
>      } else {
> @@ -1556,6 +1555,86 @@ static gboolean gd_win_grab(void *opaque)
>      return TRUE;
>  }
>
> +static gboolean gd_win_full_screen(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +    GdkWindow *window;
> +    GdkWindowState state;
> +
> +    if (!vc->window || !gtk_widget_get_realized(vc->window)) {
> +        return TRUE;
> +    }
> +
> +    window =3D gtk_widget_get_window(vc->window);
> +    if (!window) {
> +        return TRUE;
> +    }
> +
> +    state =3D gdk_window_get_state(window);
> +
> +    if (state & GDK_WINDOW_STATE_FULLSCREEN) {
> +        gtk_window_unfullscreen(GTK_WINDOW(vc->window));
> +
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            vc->gfx.scale_x =3D vc->gfx.preferred_scale;
> +            vc->gfx.scale_y =3D vc->gfx.preferred_scale;
> +            gd_update_windowsize(vc);
> +        }
> +    } else {
> +        if (vc->type =3D=3D GD_VC_GFX) {
> +            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
> +        }
> +        gtk_window_fullscreen(GTK_WINDOW(vc->window));
> +    }
> +
> +    gd_update_cursor(vc);
> +    return TRUE;
> +}
> +
> +static gboolean gd_win_zoom_in(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +    GtkDisplayState *s =3D vc->s;
> +
> +    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item)=
,
> +                                   FALSE);
> +
> +    vc->gfx.scale_x +=3D VC_SCALE_STEP;
> +    vc->gfx.scale_y +=3D VC_SCALE_STEP;
> +
> +    gd_update_windowsize(vc);
> +    return TRUE;
> +}
> +
> +static gboolean gd_win_zoom_out(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +    GtkDisplayState *s =3D vc->s;
> +
> +    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->zoom_fit_item)=
,
> +                                   FALSE);
> +
> +    vc->gfx.scale_x -=3D VC_SCALE_STEP;
> +    vc->gfx.scale_y -=3D VC_SCALE_STEP;
> +
> +    vc->gfx.scale_x =3D MAX(vc->gfx.scale_x, VC_SCALE_MIN);
> +    vc->gfx.scale_y =3D MAX(vc->gfx.scale_y, VC_SCALE_MIN);
> +
> +    gd_update_windowsize(vc);
> +    return TRUE;
> +}
> +
> +static gboolean gd_win_zoom_fixed(void *opaque)
> +{
> +    VirtualConsole *vc =3D opaque;
> +
> +    vc->gfx.scale_x =3D vc->gfx.preferred_scale;
> +    vc->gfx.scale_y =3D vc->gfx.preferred_scale;
> +
> +    gd_update_windowsize(vc);
> +    return TRUE;
> +}
> +

This duplicates existing code. Can you refactor it so we avoid logic
duplication?

btw, it would make sense to send a patch series now that you have 2
ui/gtk patches and more to come.

thanks

>  static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> @@ -1590,9 +1669,24 @@ static void gd_menu_untabify(GtkMenuItem *item, vo=
id *opaque)
>              GtkAccelGroup *ag =3D gtk_accel_group_new();
>              gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
>
> -            GClosure *cb =3D g_cclosure_new_swap(G_CALLBACK(gd_win_grab)=
,
> -                                               vc, NULL);
> -            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, =
cb);
> +            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
> +                                        vc, NULL));
> +            gtk_accel_group_connect(ag, GDK_KEY_f, HOTKEY_MODIFIERS, 0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_full_screen),
> +                                        vc, NULL));
> +            gtk_accel_group_connect(ag, GDK_KEY_plus, HOTKEY_MODIFIERS, =
0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
> +                                        vc, NULL));
> +            gtk_accel_group_connect(ag, GDK_KEY_equal, HOTKEY_MODIFIERS,=
 0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_in),
> +                                        vc, NULL));
> +            gtk_accel_group_connect(ag, GDK_KEY_minus, HOTKEY_MODIFIERS,=
 0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_out),
> +                                        vc, NULL));
> +            gtk_accel_group_connect(ag, GDK_KEY_0, HOTKEY_MODIFIERS, 0,
> +                    g_cclosure_new_swap(G_CALLBACK(gd_win_zoom_fixed),
> +                                        vc, NULL));
>          }
>
>          gd_rebuild_vc_menu(s);
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

