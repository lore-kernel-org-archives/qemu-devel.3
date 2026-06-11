Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB9BCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaMm-0001Yi-KB; Thu, 11 Jun 2026 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaMk-0001YB-6z
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:02:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaMi-0007H0-9e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:02:17 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B81lW7066092
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 17:01:47 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2+L3bmfj8tsk8xs4DuqT6sI80FoCVySKP+u96Jld3oE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781164907; v=1;
 b=d5vxQU1zGMGZ9ukQbw4elGi1kz+sP0aRxO6MWwYIFbGEhoFen1dk5Ok2TTQaAz3R
 vL6G9iL6sI0BBTCuEZjh23juxkguT7QYrajgqVlkFT97NGSxngPyZLDyncmogXvK
 CKB79+B8SxNiNLgXTUfefZJoEcnHwT6svosMkUofj9r6mxw+eQkvP5b+tp4/pKbA
 49wiGQE3FGvrd0M3x/P3H1S7FTkCVzu+1R+7HHsODaoOThJAaO19B6zKVh4MQezK
 y/sdG+cG4SRSqEtEJc/Mal9pHCnKpdW1CPm6vgduWfjOF1AScxAUAQVEhuDORbdg
 mG1WpY1nos0ac6uQzZLihw==
Message-ID: <0abf9855-0b37-460c-baec-958785f1558b@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 17:01:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] ui/gtk: handle console hotplug/unplug events
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-29-9ea6355ea08f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260608-b4-ui-v2-29-9ea6355ea08f@redhat.com>
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

On 2026/06/08 16:16, Marc-André Lureau wrote:
> Register a console notifier so the GTK display dynamically creates and
> destroys VirtualConsole tabs when graphic consoles are added or removed
> at runtime (e.g. vfio-pci with display=on hotplug).
> 
> Add skips consoles that already have a VC binding, remove skips unknown
> consoles.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/gtk.h |  1 +
>   ui/gtk.c         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index b0be5070795..6cb611ce474 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -140,6 +140,7 @@ struct GtkDisplayState {
>   
>       GdkCursor *null_cursor;
>       Notifier mouse_mode_notifier;
> +    Notifier console_notifier;
>       gboolean free_scale;
>       gboolean keep_aspect_ratio;
>   
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 6325704c397..6ef58d1367c 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2332,7 +2332,8 @@ static bool gd_scale_valid(double scale)
>       return scale >= VC_SCALE_MIN && scale <= VC_SCALE_MAX;
>   }
>   
> -static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
> +static VirtualConsole *
> +add_gfx_console(GtkDisplayState *s, QemuConsole *con)
>   {
>       VirtualConsole *vc = g_new0(VirtualConsole, 1);
>       const DisplayChangeListenerOps *ops = &dcl_ops;
> @@ -2414,6 +2415,76 @@ static void add_gfx_console(GtkDisplayState *s, QemuConsole *con)
>       qemu_console_register_listener(con, &vc->gfx.dcl, ops);
>   
>       gd_connect_vc_gfx_signals(vc);
> +    return vc;
> +}
> +
> +static void gd_vc_add_gfx(GtkDisplayState *s, QemuConsole *con)
> +{
> +    VirtualConsole *vc;
> +    int i;
> +
> +    for (i = 0; i < (int)s->vcs->len; i++) {
> +        VirtualConsole *v = g_ptr_array_index(s->vcs, i);
> +        if (v->type == GD_VC_GFX && v->gfx.dcl.con == con) {
> +            return;
> +        }
> +    }
> +
> +    vc = add_gfx_console(s, con);
> +    gtk_widget_show_all(vc->tab_item);
> +    gtk_widget_realize(vc->gfx.drawing_area);
> +
> +    if (s->free_scale) {
> +        gd_update_windowsize(vc);
> +    }
> +
> +    gd_update_caption(s);
> +    gd_rebuild_vc_menu(s);
> +
> +    gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), true);

This ignores the user-specified show-tabs configuration.

Regards,
Akihiko Odaki

> +}
> +
> +static void gd_vc_remove_gfx(GtkDisplayState *s, QemuConsole *con)
> +{
> +    VirtualConsole *vc = NULL;
> +    guint idx;
> +
> +    for (idx = 0; idx < s->vcs->len; idx++) {
> +        VirtualConsole *v = g_ptr_array_index(s->vcs, idx);
> +        if (v->type == GD_VC_GFX && v->gfx.dcl.con == con) {
> +            vc = v;
> +            break;
> +        }
> +    }
> +    if (!vc) {
> +        return;
> +    }
> +
> +    if (s->kbd_owner == vc) {
> +        gd_ungrab_keyboard(s);
> +    }
> +    if (s->ptr_owner == vc) {
> +        gd_ungrab_pointer(s);
> +    }
> +
> +    g_ptr_array_remove_index(s->vcs, idx);
> +    gd_rebuild_vc_menu(s);
> +    gd_update_caption(s);
> +}
> +
> +static void gd_console_notify(Notifier *n, void *data)
> +{
> +    GtkDisplayState *s = container_of(n, GtkDisplayState, console_notifier);
> +    QemuConsoleEvent *event = data;
> +
> +    switch (event->type) {
> +    case QEMU_CONSOLE_ADDED:
> +        gd_vc_add_gfx(s, event->con);
> +        break;
> +    case QEMU_CONSOLE_REMOVED:
> +        gd_vc_remove_gfx(s, event->con);
> +        break;
> +    }
>   }
>   
>   static void gd_create_menu_view(GtkDisplayState *s, DisplayOptions *opts)
> @@ -2688,6 +2759,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>   
>       gd_create_menus(s, opts);
>   
> +    s->console_notifier.notify = gd_console_notify;
> +    qemu_console_add_notifier(&s->console_notifier);
> +
>       gd_connect_signals(s);
>   
>       gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
> @@ -2808,6 +2882,7 @@ static void gtk_display_cleanup(void)
>           return;
>       }
>   
> +    qemu_console_remove_notifier(&s->console_notifier);
>       qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);
>       gd_clipboard_cleanup(s);
>       g_signal_handlers_disconnect_by_func(s->notebook,
> 


