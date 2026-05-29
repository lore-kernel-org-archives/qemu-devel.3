Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C8CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwDE-0002oA-Nl; Fri, 29 May 2026 08:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSwDD-0002nS-1s
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:21:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wSwDA-0007Qu-Sd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:21:14 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64TCL1cE029889
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 May 2026 21:21:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NzB2DNcUpEDgqK4WLalhN83umUzsHlzVbk6AX8sbzZ0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1780057262; v=1;
 b=LQgI1JZakPPdDCWnfYNT8lTUxwDiIrqrX1uN7uM3rZ42sJGiTi+1HxIZ0BeGAhcG
 qfMib6+myrdVYIcy6jshdTdwrk44lEqqYE7Qa32+f71sfgEjCARhibOVa3aDi8Ea
 E0QjG8xPetm8C9MxtXRDwEGaCqXlIFzUS0KteOnut+BdgAPwCU75gIoHzIMQr0Ie
 hwT/V+AlFKYpxPeIoiKm2d5grCj35FwByu2LOXcZl7GgkguEUSwEphERzoOy1U+m
 aJlEHY0GAQmgWbSbv6dop53XfI+6mzpjnkDsvqvw3Um4MSPfxwC60MtfSli0vPmy
 AYA9i/rbbtusKjJjvUWUXw==
Message-ID: <55517e9e-fac3-473e-b1d3-11b195aab20e@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 29 May 2026 21:21:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/32] ui/gtk: convert VirtualConsole storage from fixed
 array to GPtrArray
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-24-8db3068421ef@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260529-b4-ui-v1-24-8db3068421ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/05/29 20:16, Marc-André Lureau wrote:
> Replace the fixed-size vc[MAX_VCS] with GPtrArray.
> 
> This is a preparatory refactoring for console hotplug support, which
> needs to add/remove VCs dynamically.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/gtk.h |   3 +-
>   ui/gtk.c         | 102 +++++++++++++++++++++++++++++++++++++++++++------------
>   2 files changed, 81 insertions(+), 24 deletions(-)
> 
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 5156a049509..4d54de97ea7 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -118,8 +118,7 @@ struct GtkDisplayState {
>       GtkWidget *grab_item;
>       GtkWidget *grab_on_hover_item;
>   
> -    int nb_vcs;
> -    VirtualConsole vc[MAX_VCS];
> +    GPtrArray *vcs;
>   
>       GtkWidget *show_tabs_item;
>       GtkWidget *untabify_item;
> diff --git a/ui/gtk.c b/ui/gtk.c
> index c26dc83ac3e..141cb69d494 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -150,8 +150,8 @@ static VirtualConsole *gd_vc_find_by_menu(GtkDisplayState *s)
>       VirtualConsole *vc;
>       gint i;
>   
> -    for (i = 0; i < s->nb_vcs; i++) {
> -        vc = &s->vc[i];
> +    for (i = 0; i < s->vcs->len; i++) {
> +        vc = g_ptr_array_index(s->vcs, i);
>           if (gtk_check_menu_item_get_active
>               (GTK_CHECK_MENU_ITEM(vc->menu_item))) {
>               return vc;
> @@ -165,8 +165,11 @@ static VirtualConsole *gd_vc_find_by_page(GtkDisplayState *s, gint page)
>       VirtualConsole *vc;
>       gint i, p;
>   
> -    for (i = 0; i < s->nb_vcs; i++) {
> -        vc = &s->vc[i];
> +    if (!s->vcs) {
> +        return NULL;
> +    }
> +    for (i = 0; i < s->vcs->len; i++) {
> +        vc = g_ptr_array_index(s->vcs, i);
>           p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), vc->tab_item);
>           if (p == page) {
>               return vc;
> @@ -247,8 +250,8 @@ static void gd_update_caption(GtkDisplayState *s)
>       gtk_window_set_title(GTK_WINDOW(s->window), title);
>       g_free(title);
>   
> -    for (i = 0; i < s->nb_vcs; i++) {
> -        VirtualConsole *vc = &s->vc[i];
> +    for (i = 0; i < s->vcs->len; i++) {
> +        VirtualConsole *vc = g_ptr_array_index(s->vcs, i);
>   
>           if (!vc->window) {
>               continue;
> @@ -357,7 +360,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
>   {
>       VirtualConsole *vc = gd_vc_find_current(s);
>   
> -    if (vc->type != GD_VC_GFX ||
> +    if (!vc || vc->type != GD_VC_GFX ||
>           !qemu_console_is_graphic(vc->gfx.dcl.con)) {
>           return;
>       }
> @@ -702,8 +705,8 @@ static void gd_mouse_mode_change(Notifier *notify, void *data)
>               gd_ungrab_pointer(s);
>           }
>       }
> -    for (i = 0; i < s->nb_vcs; i++) {
> -        VirtualConsole *vc = &s->vc[i];
> +    for (i = 0; i < s->vcs->len; i++) {
> +        VirtualConsole *vc = g_ptr_array_index(s->vcs, i);
>           gd_update_cursor(vc);
>       }
>   }
> @@ -2114,9 +2117,10 @@ static void gd_vcs_init(GtkDisplayState *s, GSList *group,
>       int i;
>   
>       for (i = 0; i < nb_vcs; i++) {
> -        VirtualConsole *vc = &s->vc[s->nb_vcs];
> -        group = gd_vc_vte_init(s, vc, vcs[i], s->nb_vcs, group, view_menu);
> -        s->nb_vcs++;
> +        VirtualConsole *vc = g_new0(VirtualConsole, 1);
> +        g_ptr_array_add(s->vcs, vc);
> +        group = gd_vc_vte_init(s, vc, vcs[i], s->vcs->len - 1,
> +                               group, view_menu);
>       }
>   }
>   #endif /* CONFIG_VTE */
> @@ -2441,13 +2445,14 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
>   
>       /* gfx */
>       for (vc = 0;; vc++) {
> +        VirtualConsole *v;
>           con = qemu_console_lookup_by_index(vc);
>           if (!con) {
>               break;
>           }
> -        group = gd_vc_gfx_init(s, &s->vc[vc], con,
> -                               vc, group, view_menu);
> -        s->nb_vcs++;
> +        v = g_new0(VirtualConsole, 1);
> +        g_ptr_array_add(s->vcs, v);
> +        group = gd_vc_gfx_init(s, v, con, vc, group, view_menu);
>       }
>   
>   #if defined(CONFIG_VTE)
> @@ -2505,6 +2510,58 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
>   }
>   
>   
> +static void gd_vc_free(void *p)
> +{
> +    VirtualConsole *vc = p;
> +
> +    switch (vc->type) {
> +    case GD_VC_GFX:
> +        qemu_console_unregister_listener(&vc->gfx.dcl);
> +#if defined(CONFIG_OPENGL)
> +        if (display_opengl) {
> +            qemu_console_set_display_gl_ctx(vc->gfx.dcl.con, NULL);
> +        }
> +        if (vc->gfx.esurface) {
> +            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
> +        }
> +        if (vc->gfx.ectx) {
> +            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
> +        }
> +        if (vc->gfx.gls) {
> +            surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
> +            qemu_gl_fini_shader(vc->gfx.gls);
> +        }
> +        egl_fb_destroy(&vc->gfx.guest_fb);
> +        egl_fb_destroy(&vc->gfx.win_fb);
> +        egl_fb_destroy(&vc->gfx.cursor_fb);
> +#endif
> +        qkbd_state_free(vc->gfx.kbd);
> +        if (vc->gfx.surface) {
> +            cairo_surface_destroy(vc->gfx.surface);
> +        }
> +        if (vc->gfx.convert) {
> +            pixman_image_unref(vc->gfx.convert);
> +        }
> +        break;
> +#if defined(CONFIG_VTE)
> +    case GD_VC_VTE:
> +        fifo8_destroy(&vc->vte.out_fifo);
> +        break;
> +#endif

GCC emits a warning if !defined(CONFIG_VTE) because this doesn't handle 
GD_VC_VTE while the enum value is still present.

Regards,
Akihiko Odaki

> +    }
> +
> +    if (vc->window) {
> +        gtk_widget_destroy(vc->window);
> +    } else if (vc->tab_item) {
> +        gtk_widget_destroy(vc->tab_item);
> +    }
> +    if (vc->menu_item) {
> +        gtk_widget_destroy(vc->menu_item);
> +    }
> +    g_free(vc->label);
> +    g_free(vc);
> +}
> +
>   static GtkDisplayState *gtk_display_state;
>   static gboolean gtkinit;
>   
> @@ -2525,6 +2582,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>       assert(opts->type == DISPLAY_TYPE_GTK);
>       s = g_malloc0(sizeof(*s));
>       gtk_display_state = s;
> +    s->vcs = g_ptr_array_new_with_free_func(gd_vc_free);
>       s->opts = opts;
>   
>       theme = gtk_icon_theme_get_default();
> @@ -2582,13 +2640,10 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>   
>       gtk_widget_show_all(s->window);
>   
> -    for (idx = 0;; idx++) {
> -        QemuConsole *con = qemu_console_lookup_by_index(idx);
> -        if (!con) {
> -            break;
> -        }
> -        if (s->vc[idx].type == GD_VC_GFX) {
> -            gtk_widget_realize(s->vc[idx].gfx.drawing_area);
> +    for (idx = 0; idx < s->vcs->len; idx++) {
> +        VirtualConsole *v = g_ptr_array_index(s->vcs, idx);
> +        if (v->type == GD_VC_GFX) {
> +            gtk_widget_realize(v->gfx.drawing_area);
>           }
>       }
>   
> @@ -2693,6 +2748,9 @@ static void gtk_display_cleanup(void)
>   
>       qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
>       gd_clipboard_cleanup(s);
> +    g_signal_handlers_disconnect_by_func(s->notebook,
> +                                         G_CALLBACK(gd_change_page), s);
> +    g_clear_pointer(&s->vcs, g_ptr_array_unref);
>       g_clear_pointer(&s->window, gtk_widget_destroy);
>       g_clear_object(&s->null_cursor);
>       g_clear_pointer(&gtk_display_state, g_free);
> 


