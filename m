Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23690D111B6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rlM-0002M7-GG; Mon, 04 Nov 2024 02:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7rlL-0002Lx-Jq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:44:35 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7rlJ-0007n7-SC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:44:35 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460ad0440ddso25520601cf.3
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 23:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730706273; x=1731311073; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CcVvXhhptpImTvMsu+bOqGZJuCpqHssCDRPpOajVwTw=;
 b=DzWIAHAUAJNQaJjI5KJUMJEO9qgkGjQoGWjpvt3Qaa7tmQ0Nse3D/nd8Gs1/7lUtGr
 vWoMKR5V9XZL+0MKwpcO2kAzToEKrUVeoszb4fSPTMkZzTnGqX0U5OKCliJIPxGGm+s1
 8ali2dxlx407cmAggW6FxSf+SxrL7LXPd2LRuGPLcXBuu0+DsqB12ysiAYYJLrRQUQ2k
 0DcAsioixBZ5DMTkv/vUONmzjb5ZdBSvEJyfzy7u0wMfzxoJ07hZL7YJhtUU41Dn+DjO
 SzLJtkqssWpKLEFxZ+I3SeB+RC3DS2TBUMABdUEYGm56PgwslzraXQy0RbvOEgTqVzBF
 cs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730706273; x=1731311073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CcVvXhhptpImTvMsu+bOqGZJuCpqHssCDRPpOajVwTw=;
 b=Cz24q7R3n0OwAB3gjr2lw68iZEvCh1nLS8b/7kfq9lj4DCvP+ydch6kttfGUtY8emF
 mXR+IpepMoZH11LzspWU0pMJzyL1uy0jjYcFuQfvEe02Ns2oOINGb8sAqWarETWgC9jX
 5skyNyFuxvDRQzYbIZJjb+VZjiI4GzdM+OG/zpa3xmfswY6Pe1suDvGmjS9LI5VXadEX
 QmcVa0M6La0Mb7SaIKhVSRKVnkAOvdt4ep//nzkrqDSIKObXM6b0uETmeGSa22NoVZHC
 RxeqIEyaTx89dF4jPpgLsfPUZVWVuS8QtIKDtCjeVTVs5SqATG24S4q/NKPzG4lXk+Ir
 M5VQ==
X-Gm-Message-State: AOJu0Yzunn7tpS1Vm0rG8tB1RPfUl8vos0ryloAseY1t0sL8om/hsjgl
 FE1tpz4OUhV4nbKxo5nD+E9KK5ugZy+SFkG18m24K2sMdfcvqewVCUg4Hlp6MYOZRnmKkyKz9Ze
 UMO/xGnUumNxNY5WIHhqAVkoGSMZ/I96Y
X-Google-Smtp-Source: AGHT+IESX/27cXTsvlRqVL4p2eRHVbsNjg8tv0zc+712Uri8vCIGb8paa8eVXRx7hJPyLb+IfHosdnj1gkPwjwoWKYA=
X-Received: by 2002:a05:622a:134c:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-4613c16a6eamr515399911cf.43.1730706272616; Sun, 03 Nov 2024
 23:44:32 -0800 (PST)
MIME-Version: 1.0
References: <a3f5c533b761756e90e80cc616e2e9dff3aefa4a.camel@proton.me>
In-Reply-To: <a3f5c533b761756e90e80cc616e2e9dff3aefa4a.camel@proton.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Nov 2024 11:44:21 +0400
Message-ID: <CAJ+F1C+6Gs67D8jo-gSqJB4SDxfhof2LDXB=6xjmqYgnBoFCSQ@mail.gmail.com>
Subject: Re: [PATCH] UI/GTK: full-screen after wait for hiding of tabs and
 menu_bar
To: Edmund Raile <edmund.raile@proton.me>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, dongwon.kim@intel.com, 
 hikalium@hikalium.com, thuth@redhat.com
Content-Type: multipart/alternative; boundary="00000000000097086406261174eb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

--00000000000097086406261174eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Nov 2, 2024 at 8:05=E2=80=AFAM Edmund Raile via <qemu-devel@nongnu.=
org>
wrote:

> Wait for hiding of GTK notebook tabs and GTK menu_bar before entering
> full-screen due to asynchronous nature of GTK.
>
> prevent:
>  * full-screen window overlap onto monitor below
>  * black bar on top of full-screen guest display
>  * misallignment of host-drawn guest cursor and invisible guest cursor
>
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> ---
> I'd like to report an issue with GTK UI and suggest a solution for it.
> When entering full-screen, the tabs and menu_bar need to be hidden.
>
> Currently, gd_menu_full_screen() does all of this in-line but since
> GTK operates asynchronously, this results in:
>  * a full-screen window that overlaps onto the monitor below
>  * a full-screen guest display that has a black bar above it
>  * a guest cursor that is misalligned to the
>    host cursor the GTK UI draws in-style of the guest cursor (QXL vga)
>
> My solution is to wait for GTK to hide tabs and menu_bar,
> and only then enter full screen.
> I've implemented this with a callback on a simple 10ms timer.
>
> It has been tested to work reliably under heavy CPU load, when
> GTK may take longer to respond to requests.
>
> Since gtk.c currently has no maintainer, I am uncertain who to submit
> this patch to.
>
> Kind regards,
> Edmund Raile.
>  ui/gtk.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bf9d3dd679..2f6aac6386 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1463,6 +1463,32 @@ static void gd_accel_show_menubar(void *opaque)
>      gtk_menu_item_activate(GTK_MENU_ITEM(s->show_menubar_item));
>  }
>
> +static gboolean full_screen_enter_callback(gpointer user_data)
> +{
> +    GtkDisplayState *s =3D user_data;
> +    VirtualConsole *vc =3D gd_vc_find_current(s);
> +
> +    gboolean tabs_visible =3D gtk_notebook_get_show_tabs(
> +                                GTK_NOTEBOOK(s->notebook));
> +    gboolean menu_bar_visible =3D gtk_widget_get_visible(s->menu_bar);
> +
> +    if (!tabs_visible && !menu_bar_visible) {
> +        gtk_window_fullscreen(GTK_WINDOW(s->window));
> +        s->full_screen =3D TRUE;
> +
> +        gd_update_windowsize(vc);
> +
> +        /** deactivate callback **/
> +        return FALSE;
> +    } else {
> +        /*
> +         * re-schedule callback if GTK _still_
> +         * did not manage to hide tabs and menu_bar
> +         */
> +        return TRUE;
> +    }
> +}
> +
>  static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
>  {
>      GtkDisplayState *s =3D opaque;
> @@ -1474,8 +1500,11 @@ static void gd_menu_full_screen(GtkMenuItem
> *item, void *opaque)
>          if (vc->type =3D=3D GD_VC_GFX) {
>              gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
>          }
> -        gtk_window_fullscreen(GTK_WINDOW(s->window));
> -        s->full_screen =3D TRUE;
> +
> +        gd_update_windowsize(vc);
> +
> +        /** give GTK 10ms to perform the resize **/
> +        g_timeout_add(10, full_screen_enter_callback, s);
>

This is odd. Is there a related Gtk3 issue reported upstream?


>      } else {
>          gtk_window_unfullscreen(GTK_WINDOW(s->window));
>          gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
> --
> 2.47.0
>
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000097086406261174eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 2, 2024 at 8:05=E2=80=
=AFAM Edmund Raile via &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-de=
vel@nongnu.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Wait for hiding of GTK notebook tabs and GTK menu_bar before =
entering<br>
full-screen due to asynchronous nature of GTK.<br>
<br>
prevent:<br>
=C2=A0* full-screen window overlap onto monitor below<br>
=C2=A0* black bar on top of full-screen guest display<br>
=C2=A0* misallignment of host-drawn guest cursor and invisible guest cursor=
<br>
<br>
Signed-off-by: Edmund Raile &lt;<a href=3D"mailto:edmund.raile@proton.me" t=
arget=3D"_blank">edmund.raile@proton.me</a>&gt;<br>
---<br>
I&#39;d like to report an issue with GTK UI and suggest a solution for it.<=
br>
When entering full-screen, the tabs and menu_bar need to be hidden.<br>
<br>
Currently, gd_menu_full_screen() does all of this in-line but since<br>
GTK operates asynchronously, this results in:<br>
=C2=A0* a full-screen window that overlaps onto the monitor below<br>
=C2=A0* a full-screen guest display that has a black bar above it<br>
=C2=A0* a guest cursor that is misalligned to the<br>
=C2=A0 =C2=A0host cursor the GTK UI draws in-style of the guest cursor (QXL=
 vga)<br>
<br>
My solution is to wait for GTK to hide tabs and menu_bar,<br>
and only then enter full screen.<br>
I&#39;ve implemented this with a callback on a simple 10ms timer.<br>
<br>
It has been tested to work reliably under heavy CPU load, when<br>
GTK may take longer to respond to requests.<br>
<br>
Since gtk.c currently has no maintainer, I am uncertain who to submit<br>
this patch to.<br>
<br>
Kind regards,<br>
Edmund Raile.<br>
=C2=A0ui/gtk.c | 33 +++++++++++++++++++++++++++++++--<br>
=C2=A01 file changed, 31 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index bf9d3dd679..2f6aac6386 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1463,6 +1463,32 @@ static void gd_accel_show_menubar(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0gtk_menu_item_activate(GTK_MENU_ITEM(s-&gt;show_menubar=
_item));<br>
=C2=A0}<br>
<br>
+static gboolean full_screen_enter_callback(gpointer user_data)<br>
+{<br>
+=C2=A0 =C2=A0 GtkDisplayState *s =3D user_data;<br>
+=C2=A0 =C2=A0 VirtualConsole *vc =3D gd_vc_find_current(s);<br>
+<br>
+=C2=A0 =C2=A0 gboolean tabs_visible =3D gtk_notebook_get_show_tabs(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GTK_NOTEBOOK(s-&gt;notebook));<br>
+=C2=A0 =C2=A0 gboolean menu_bar_visible =3D gtk_widget_get_visible(s-&gt;m=
enu_bar);<br>
+<br>
+=C2=A0 =C2=A0 if (!tabs_visible &amp;&amp; !menu_bar_visible) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_window_fullscreen(GTK_WINDOW(s-&gt;window)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;full_screen =3D TRUE;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gd_update_windowsize(vc);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** deactivate callback **/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* re-schedule callback if GTK _still_<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* did not manage to hide tabs and menu_b=
ar<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GtkDisplayState *s =3D opaque;<br>
@@ -1474,8 +1500,11 @@ static void gd_menu_full_screen(GtkMenuItem<br>
*item, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vc-&gt;type =3D=3D GD_VC_GFX) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_widget_set_size_request=
(vc-&gt;gfx.drawing_area, -1, -1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gtk_window_fullscreen(GTK_WINDOW(s-&gt;window)=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;full_screen =3D TRUE;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gd_update_windowsize(vc);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** give GTK 10ms to perform the resize **/<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_timeout_add(10, full_screen_enter_callback, =
s);<br></blockquote><div><br></div><div>This is odd. Is there a related Gtk=
3 issue reported upstream?</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtk_window_unfullscreen(GTK_WINDOW(s-&gt;=
window));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gd_menu_show_tabs(GTK_MENU_ITEM(s-&gt;sho=
w_tabs_item), s);<br>
-- <br>
2.47.0<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000097086406261174eb--

