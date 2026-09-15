Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB156C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QXH-0001xY-QN; Tue, 15 Sep 2026 06:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6QXG-0001xQ-4l
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:37:10 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6QXE-0000B2-BB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:37:09 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so2850898a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789468626; cv=none;
 d=google.com; s=arc-20260327;
 b=jh1w80KOvv/pbfqPGmRR6EVGJIcdIzFQlGGibEeQ6+0qbpzqGpibgEi5+EzTzpndnT
 ljfKDWr63Fr7c8ezooqFVAggyCyrd88ZJDOqk3l/y74/6sV3Py2TCOXFq/L9PK5egAGk
 ysbF6ZyI3fk4uhg+C6dPiqB/2BfvqlhFRZhBPXQk6FHw12CCLOELDR/QbrV+VjqO2zjJ
 nZlqYUfNHL54LqeWf7b3kII1qoPgOSGNvEuPu0qGfTzTS/yIIsbdRb8JH+jXhB0VPxWl
 hfE12Ep7gYveAsjKWRVdsxpQhG7jL13F3Th+vKHlvCQKzcvcnCRap8SMeFzvcAOVEFOu
 NRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EGvpBS9AGBPJyElA0kheMsHRXcgn2BsskjCu6EV8nyc=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=dCBHKFxyON7fFNyUM4dafimyRy/F92CNkEjNsQwuN9mqEgFpGD7DKSkBgdPCF7DDd3
 95+x1ioDi4z2FVUSLTcLeWpzuK6cGgMMRWmqVa81Nyg83ljlwWLwLg3zfgsz5rrluGw6
 d1MLPcfbf9hhgIPAImRtYK9IjSSJCw1IDu6KCu6xJpxL4jdsGtQ/XVbYSKSInMxWHGy1
 xptPn0jfFQOCxiNogIa3ww1RNh0pc4DXqUF8O+pOz48sKHmt27p2ZOcSCUUyouZAJiHY
 +kxfUbX13jc4B3CSrlcrslYsJMhDVenWKKIiqVukFdzXHFyNeBcxyxrHt3+YS8fOyRuK
 Cm1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789468626; x=1790073426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EGvpBS9AGBPJyElA0kheMsHRXcgn2BsskjCu6EV8nyc=;
 b=PmRj2s3k5HvvWhuDlf0GKZs1bBE4eryiu1WG07KYgsKAXH8mt27CbyAoGumjx6OrGn
 zcOWbdj5PzEi44nSOJsEkL4lme12yQbAPSzhJ6ROdt49P2FST/AprDyo2mIbPe4d39Do
 eIvlT9Xi1rUIyIZrmZJzQCrdql4dnC4S7pbSk+hZaAeRNC4wzqZZihGMq3PN/9s48ICH
 SQr9pho0Tz5T4JgWmSmpn1AB6Gq2Fq3s9jQyFHSWMx39lpIQb6fTGRpOiRJCo69rTfad
 JkPCRJPRekQwpkUMOtwunnmHyJb/31JCJEOC60JuHW96SwWUxrnvQwKFP9NwRmBUGWjj
 r8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789468626; x=1790073426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EGvpBS9AGBPJyElA0kheMsHRXcgn2BsskjCu6EV8nyc=;
 b=WC+Dn9rHeSRWdal8rTzQDkLuDbUCN/ny9BSINuagDrZYEmYFoQM+I17JG4idOLRy9s
 xZAeHkOWyPxEZTDQC+LcXd2RE5pMGbq2psriJ0A/KCoKNuuK+38Ji8I6uwMwwDlwyEaK
 q6+ogo8xF6gsJ0stpOdl9T5XKcHRFIAWNoSKZc+WTTUlo5/UOqhabPX3jgXhQyxCKqZu
 G3Aiulze0QXDxGwmzkhIsHtcXcWc86ktB9y2JhJlPnyl6LUbnBB2odJn3GzL/4agu38Q
 SGcYW5AetKsiSYFNec4pR8ckbe+TvafbSkivlo80wRwHqt0+veW68QEm0Vbl7Hor6SyB
 sztw==
X-Gm-Message-State: AFuF++lbLIaFwuvizzAffqOivoH9bFGkKXmpMHAGVP5jCvRtWWXvLYcb
 T93nsrfd+r/v+b+TxVCe87WlyyayEqqlAKdxtMaPdWU+wu06b8SPTlEA3ywixuhrVdpdAEXH5zf
 949kwlrl5lQCGgMDZXsOkd9FrQLQU9ao=
X-Gm-Gg: AYBFou3qsCklVcRj68+XJoyQr4mR+xyweo1GIJaR2RucbI2MX/r75g3qKvNqygnq0oR
 ofm8DHEmJ8k5Fk5x8vcfatm+wYuKkspMqvBohtuyGoZ7x2FxfABaeDJiqNoly/6+r+h9WRbky99
 dSJcTypxKMzarYJRb2jhDh3qk+KeGDOSTzqdB+sCrTBchOnr4vVEfQMBOJEKdDmC3EfcwHainDn
 yVQyXugj7HDOorElXxrTVo73csMmWe+0qRi493/j0/x40Sbbgph6fSxp2ghYqdJaQmWryZkunEk
 9WZ24+w4kQm3oXrI3sY04qnOO3S22Gipa7OpWNlTFBNIafuBmDhfdeoje8k9sQEmODzH7IdlUii
 b1e1749fHY+s=
X-Received: by 2002:a17:90b:2dd2:b0:39e:132d:df19 with SMTP id
 98e67ed59e1d1-39e132de5b4mr69723a91.10.1789468626005; Tue, 15 Sep 2026
 03:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260804090847.18871-1-dongwon.kim@intel.com>
 <20260804090847.18871-2-dongwon.kim@intel.com>
In-Reply-To: <20260804090847.18871-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2026 14:36:53 +0400
X-Gm-Features: AcwNN1XjNIAOvVFx9drsd4idS9P4Cydd-xJ4cOrBcWVQXCe2dNlhZulIp_s3vQo
Message-ID: <CAJ+F1C+T-j9qVD9sHSQdYEvw3LQYRGHo7=L4MgsaUhhZbr+LJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ui/gtk: register "Grab Input" shortcut to accel_group
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj2-x10.google.com
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

On Mon, Sep 14, 2026 at 10:51=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> The "Grab Input" shortcut key currently fails to trigger when the
> window is in fullscreen mode because the menubar is hidden, which
> disables GtkAccelMap-based shortcuts associated with it.
>
> To ensure the accelerator remains active in fullscreen, connect it
> directly to s->accel_group and explicitly set the hotkey display on
> the menu item label.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 3c9720a330..2f83c557d8 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1878,6 +1878,12 @@ static void gd_menu_grab_input(GtkMenuItem *item, =
void *opaque)
>      gd_update_cursor(vc);
>  }
>
> +static void gd_accel_grab_input(void *opaque)
> +{

https://docs.gtk.org/gtk3/method.AccelGroup.connect.html
The signature used for the closure is that of GtkAccelGroupActivate.

This means that other key events could potentially be triggered. It
should return true (handled).


> +    GtkDisplayState *s =3D opaque;
> +    gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_item));
> +}
> +
>  static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
>                             gpointer data)
>  {
> @@ -2557,6 +2563,7 @@ static void gd_create_menu_view(GtkDisplayState *s,=
 DisplayOptions *opts)
>  {
>      GtkWidget *view_menu;
>      GtkWidget *separator;
> +    GtkWidget *child;
>      QemuConsole *con;
>      bool zoom_to_fit =3D false;
>      int vc, i;
> @@ -2615,12 +2622,15 @@ static void gd_create_menu_view(GtkDisplayState *=
s, DisplayOptions *opts)
>      gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->grab_on_hover_it=
em);
>
>      s->grab_item =3D gtk_check_menu_item_new_with_mnemonic(_("_Grab Inpu=
t"));
> -    gtk_menu_item_set_accel_path(GTK_MENU_ITEM(s->grab_item),
> -                                 "<QEMU>/View/Grab Input");
> -    gtk_accel_map_add_entry("<QEMU>/View/Grab Input", GDK_KEY_g,
> -                            HOTKEY_MODIFIERS);
>      gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->grab_item);
> -
> +    gtk_accel_group_connect(s->accel_group, GDK_KEY_g, HOTKEY_MODIFIERS,=
 0,
> +                            g_cclosure_new_swap(G_CALLBACK(gd_accel_grab=
_input),
> +                                                s, NULL));
> +    child =3D gtk_bin_get_child(GTK_BIN(s->grab_item));
> +    if (GTK_IS_ACCEL_LABEL(child)) {
> +        gtk_accel_label_set_accel(GTK_ACCEL_LABEL(child),
> +                                  GDK_KEY_g, HOTKEY_MODIFIERS);
> +    }
>      separator =3D gtk_separator_menu_item_new();
>      gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), separator);
>
> --
> 2.43.0
>
>


--
Marc-Andr=C3=A9 Lureau

