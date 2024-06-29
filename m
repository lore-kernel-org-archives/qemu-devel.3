Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC672C30659
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNX2r-0002jB-Dc; Sat, 29 Jun 2024 08:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX2h-0002iY-B8
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:18:59 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX2e-0004Q1-PH
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:18:58 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-446416dccd5so8308551cf.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719663534; x=1720268334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FuMJdsWjJzCgg9RDa1EypL2XSxxYmohysxFWWzgWGsE=;
 b=OueRdQG6lAa4yEC9Q5685v3nrBc1+6Pdz2xgXtgv8g6kNgHsdVrDEo6RDNM+p8dL1N
 4n3UTEmLKwEIMCLGSkGKzhOW+E4UUiijp2UxXSyUvMXCVPwI41Km388zfRcuyeI3QD5j
 GlMFvf8bjuNaHmXDKgEqvcsXI45xaISFz39rQFQLyNMIvqOD2qzUBa7abGIiuaE0O6h6
 tfuomV9/7G7O1mYS6bRsReZ4EFeztxbBqL5jfe/8Y+UZ9WjQ2+RDC59yG3Lm8eE/HTmw
 sgBUgbIPsDoegHBTJlpJ6DjfvETfQYfWEGHrbLdV8D5U08BKzHWr9dMx2KENprOpqnj2
 +nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719663534; x=1720268334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FuMJdsWjJzCgg9RDa1EypL2XSxxYmohysxFWWzgWGsE=;
 b=RorQWeDWMFlrXsMwkG2cyQkGgVMAPR8bMxUPGbyyAN3o0h4kcasYucw3aNlLCtgViy
 GBZsEMPggdj/Z2BxDE6Bn/2yteGrDndM/n5PRyRctgntIRLKxYiHj0vGwjUgTaSCpVU4
 b3g+mSEIKH38wE/ZGRXPa+Hcs3fRwO6WjqiRX90wigBq41kzZ0u3NgvTe80Gf09F9uTY
 GNvhlacdZCVBePxQ+odg5Af7zqIyYAl33PhVMjO7PsxciinshPKReQPA/aAwkttLPcx5
 SiaaF5AJh/OMNXDqzPYkmSZUQqF+NhRs01AQ0bBQsC3w+UteKtIPJKCfUkEl+LATyU9e
 CImQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYy3m6FEQBZX1d5HcRhEupT11e/WpmfzwOvE0gclhMA7viyWB9/jj2jlYxgfOxZhVOrlE9XUqULd56NvC4K0DgnofD7/s=
X-Gm-Message-State: AOJu0YzgYDRmkK2dprnkcgiYkgK/EWA8plQlYff667dSssbk9mQf0lUA
 p7Czl/y5Qzi7uNhokwVV2weK9klGFCwZd80CG2DZooCHaWsOBt5p/iPG+sVCMuPoyha+hAzwFdT
 mBDIX0HowKHOKnStc4meED8lMLt5WEF7o
X-Google-Smtp-Source: AGHT+IEgz259DJ7GpP+UA7wgrUHdOxCLsCjPn88ImrtRjAT0Y2a5cOeKaRGOqAkZCVIHdOQBldLWBFVmpvFWpC4Mmwo=
X-Received: by 2002:ac8:5f82:0:b0:445:624:22ed with SMTP id
 d75a77b69052e-44662dd3be1mr9882431cf.9.1719663534238; Sat, 29 Jun 2024
 05:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-2-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-2-c3cd3ee35616@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 29 Jun 2024 16:18:43 +0400
Message-ID: <CAJ+F1CK7vghZRL3Uqw6eS_zvdAqQwzqS_MfDqzK2CwzsRMucOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ui/console: Convert mouse visibility parameter
 into bool
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000177410061c065e38"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

--000000000000177410061c065e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/ui/console.h    |  4 ++--
>  hw/display/ati.c        |  2 +-
>  hw/display/virtio-gpu.c |  3 +--
>  hw/display/vmware_vga.c |  2 +-
>  ui/console.c            |  5 +++--
>  ui/dbus-listener.c      |  2 +-
>  ui/gtk.c                |  2 +-
>  ui/sdl2.c               |  4 ++--
>  ui/spice-display.c      | 11 ++++++-----
>  ui/vnc.c                |  2 +-
>  10 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a208a68b8886..82b573e68082 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -233,7 +233,7 @@ typedef struct DisplayChangeListenerOps {
>
>      /* optional */
>      void (*dpy_mouse_set)(DisplayChangeListener *dcl,
> -                          int x, int y, int on);
> +                          int x, int y, bool on);
>      /* optional */
>      void (*dpy_cursor_define)(DisplayChangeListener *dcl,
>                                QEMUCursor *cursor);
> @@ -322,7 +322,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>  void dpy_text_cursor(QemuConsole *con, int x, int y);
>  void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
>  void dpy_text_resize(QemuConsole *con, int w, int h);
> -void dpy_mouse_set(QemuConsole *con, int x, int y, int on);
> +void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);
>  void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);
>  bool dpy_cursor_define_supported(QemuConsole *con);
>  bool dpy_gfx_check_format(QemuConsole *con,
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8d2501bd8210..b1f94f5b767d 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -742,7 +742,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>          if (!s->cursor_guest_mode &&
>              (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(t & BIT(31))) {
>              dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
> -                          s->regs.cur_hv_pos & 0xffff, 1);
> +                          s->regs.cur_hv_pos & 0xffff, true);
>          }
>          break;
>      }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index d60b1b2973af..3281842bfe1b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -109,8 +109,7 @@ static void update_cursor(VirtIOGPU *g, struct
> virtio_gpu_update_cursor *cursor)
>          s->cursor.pos.x =3D cursor->pos.x;
>          s->cursor.pos.y =3D cursor->pos.y;
>      }
> -    dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
> -                  cursor->resource_id ? 1 : 0);
> +    dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
> cursor->resource_id);
>  }
>
>  struct virtio_gpu_simple_resource *
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index 1c0f9d9a991d..512f224b9f58 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -1167,7 +1167,7 @@ static void vmsvga_reset(DeviceState *dev)
>      s->enable =3D 0;
>      s->config =3D 0;
>      s->svgaid =3D SVGA_ID;
> -    s->cursor.on =3D 0;
> +    s->cursor.on =3D false;
>      s->redraw_fifo_last =3D 0;
>      s->syncing =3D 0;
>
> diff --git a/ui/console.c b/ui/console.c
> index 1b2cd0c7365d..0ec70cb50ce6 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -49,7 +49,8 @@ typedef struct QemuGraphicConsole {
>      uint32_t head;
>
>      QEMUCursor *cursor;
> -    int cursor_x, cursor_y, cursor_on;
> +    int cursor_x, cursor_y;
> +    bool cursor_on;
>  } QemuGraphicConsole;
>
>  typedef QemuConsoleClass QemuGraphicConsoleClass;
> @@ -957,7 +958,7 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
>      }
>  }
>
> -void dpy_mouse_set(QemuConsole *c, int x, int y, int on)
> +void dpy_mouse_set(QemuConsole *c, int x, int y, bool on)
>  {
>      QemuGraphicConsole *con =3D QEMU_GRAPHIC_CONSOLE(c);
>      DisplayState *s =3D c->ds;
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 54900880433e..a54123acea7d 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -726,7 +726,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dc=
l,
>  }
>
>  static void dbus_mouse_set(DisplayChangeListener *dcl,
> -                           int x, int y, int on)
> +                           int x, int y, bool on)
>  {
>      DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener,
> dcl);
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 93b13b7a30ff..bc29f7a1b4f7 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -446,7 +446,7 @@ static GdkDevice *gd_get_pointer(GdkDisplay *dpy)
>  }
>
>  static void gd_mouse_set(DisplayChangeListener *dcl,
> -                         int x, int y, int visible)
> +                         int x, int y, bool visible)
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GdkDisplay *dpy;
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 0a0eb5a42d58..98ed97437171 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -49,7 +49,7 @@ static int gui_grab_code =3D KMOD_LALT | KMOD_LCTRL;
>  static SDL_Cursor *sdl_cursor_normal;
>  static SDL_Cursor *sdl_cursor_hidden;
>  static int absolute_enabled;
> -static int guest_cursor;
> +static bool guest_cursor;
>  static int guest_x, guest_y;
>  static SDL_Cursor *guest_sprite;
>  static Notifier mouse_mode_notifier;
> @@ -729,7 +729,7 @@ void sdl2_poll_events(struct sdl2_console *scon)
>  }
>
>  static void sdl_mouse_warp(DisplayChangeListener *dcl,
> -                           int x, int y, int on)
> +                           int x, int y, bool on)
>  {
>      struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,
> dcl);
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 8a8472d0294e..c794ae06498b 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -254,7 +254,7 @@ static void
> qemu_spice_create_update(SimpleSpiceDisplay *ssd)
>  static SimpleSpiceCursor*
>  qemu_spice_create_cursor_update(SimpleSpiceDisplay *ssd,
>                                  QEMUCursor *c,
> -                                int on)
> +                                bool on)
>  {
>      size_t size =3D c ? c->width * c->height * 4 : 0;
>      SimpleSpiceCursor *update;
> @@ -448,7 +448,8 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ss=
d,
>      qemu_mutex_lock(&ssd->lock);
>      if (ssd->cursor) {
>          g_free(ssd->ptr_define);
> -        ssd->ptr_define =3D qemu_spice_create_cursor_update(ssd,
> ssd->cursor, 0);
> +        ssd->ptr_define =3D
> +            qemu_spice_create_cursor_update(ssd, ssd->cursor, false);
>      }
>      qemu_mutex_unlock(&ssd->lock);
>  }
> @@ -476,7 +477,7 @@ void qemu_spice_cursor_refresh_bh(void *opaque)
>          ssd->mouse_x =3D -1;
>          ssd->mouse_y =3D -1;
>          qemu_mutex_unlock(&ssd->lock);
> -        dpy_mouse_set(ssd->dcl.con, x, y, 1);
> +        dpy_mouse_set(ssd->dcl.con, x, y, true);
>      } else {
>          qemu_mutex_unlock(&ssd->lock);
>      }
> @@ -747,7 +748,7 @@ static void display_refresh(DisplayChangeListener *dc=
l)
>  }
>
>  static void display_mouse_set(DisplayChangeListener *dcl,
> -                              int x, int y, int on)
> +                              int x, int y, bool on)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>
> @@ -774,7 +775,7 @@ static void display_mouse_define(DisplayChangeListene=
r
> *dcl,
>      g_free(ssd->ptr_move);
>      ssd->ptr_move =3D NULL;
>      g_free(ssd->ptr_define);
> -    ssd->ptr_define =3D qemu_spice_create_cursor_update(ssd, c, 0);
> +    ssd->ptr_define =3D qemu_spice_create_cursor_update(ssd, c, false);
>      qemu_mutex_unlock(&ssd->lock);
>      qemu_spice_wakeup(ssd);
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index dd530f04e579..dae5d51210be 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -981,7 +981,7 @@ int vnc_send_framebuffer_update(VncState *vs, int x,
> int y, int w, int h)
>  }
>
>  static void vnc_mouse_set(DisplayChangeListener *dcl,
> -                          int x, int y, int visible)
> +                          int x, int y, bool visible)
>  {
>      /* can we ask the client(s) to move the pointer ??? */
>  }
>
> --
> 2.45.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000177410061c065e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 27, 2024 at 3:19=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.od=
aki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blo=
ckquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0include/ui/console.h=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0hw/display/ati.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/display/virtio-gpu.c |=C2=A0 3 +--<br>
=C2=A0hw/display/vmware_vga.c |=C2=A0 2 +-<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--=
<br>
=C2=A0ui/dbus-listener.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
=C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++--<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 | 11 ++++++-----<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
=C2=A010 files changed, 19 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/include/ui/console.h b/include/ui/console.h<br>
index a208a68b8886..82b573e68082 100644<br>
--- a/include/ui/console.h<br>
+++ b/include/ui/console.h<br>
@@ -233,7 +233,7 @@ typedef struct DisplayChangeListenerOps {<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* optional */<br>
=C2=A0 =C2=A0 =C2=A0void (*dpy_mouse_set)(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int x, int y, int on);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int x, int y, bool on);<br>
=C2=A0 =C2=A0 =C2=A0/* optional */<br>
=C2=A0 =C2=A0 =C2=A0void (*dpy_cursor_define)(DisplayChangeListener *dcl,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMUCursor *cursor);<br>
@@ -322,7 +322,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,<br>
=C2=A0void dpy_text_cursor(QemuConsole *con, int x, int y);<br>
=C2=A0void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);<b=
r>
=C2=A0void dpy_text_resize(QemuConsole *con, int w, int h);<br>
-void dpy_mouse_set(QemuConsole *con, int x, int y, int on);<br>
+void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);<br>
=C2=A0void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);<br>
=C2=A0bool dpy_cursor_define_supported(QemuConsole *con);<br>
=C2=A0bool dpy_gfx_check_format(QemuConsole *con,<br>
diff --git a/hw/display/ati.c b/hw/display/ati.c<br>
index 8d2501bd8210..b1f94f5b767d 100644<br>
--- a/hw/display/ati.c<br>
+++ b/hw/display/ati.c<br>
@@ -742,7 +742,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;cursor_guest_mode &amp;&amp;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;regs.crtc_gen_cntl &=
amp; CRTC2_CUR_EN) &amp;&amp; !(t &amp; BIT(31))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpy_mouse_set(s-&gt;vga.con=
, s-&gt;regs.cur_hv_pos &gt;&gt; 16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s-&gt;regs.cur_hv_pos &amp; 0xffff, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s-&gt;regs.cur_hv_pos &amp; 0xffff, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index d60b1b2973af..3281842bfe1b 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -109,8 +109,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_g=
pu_update_cursor *cursor)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cursor.pos.x =3D cursor-&gt;pos.x;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cursor.pos.y =3D cursor-&gt;pos.y;<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, cursor-&gt;pos.x, cursor-&gt;pos.y,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor-&gt;=
resource_id ? 1 : 0);<br>
+=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, cursor-&gt;pos.x, cursor-&gt;pos.y,=
 cursor-&gt;resource_id);<br>
=C2=A0}<br>
<br>
=C2=A0struct virtio_gpu_simple_resource *<br>
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c<br>
index 1c0f9d9a991d..512f224b9f58 100644<br>
--- a/hw/display/vmware_vga.c<br>
+++ b/hw/display/vmware_vga.c<br>
@@ -1167,7 +1167,7 @@ static void vmsvga_reset(DeviceState *dev)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;enable =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;config =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;svgaid =3D SVGA_ID;<br>
-=C2=A0 =C2=A0 s-&gt;cursor.on =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;cursor.on =3D false;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;redraw_fifo_last =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;syncing =3D 0;<br>
<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 1b2cd0c7365d..0ec70cb50ce6 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -49,7 +49,8 @@ typedef struct QemuGraphicConsole {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t head;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUCursor *cursor;<br>
-=C2=A0 =C2=A0 int cursor_x, cursor_y, cursor_on;<br>
+=C2=A0 =C2=A0 int cursor_x, cursor_y;<br>
+=C2=A0 =C2=A0 bool cursor_on;<br>
=C2=A0} QemuGraphicConsole;<br>
<br>
=C2=A0typedef QemuConsoleClass QemuGraphicConsoleClass;<br>
@@ -957,7 +958,7 @@ void dpy_text_resize(QemuConsole *con, int w, int h)<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void dpy_mouse_set(QemuConsole *c, int x, int y, int on)<br>
+void dpy_mouse_set(QemuConsole *c, int x, int y, bool on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QemuGraphicConsole *con =3D QEMU_GRAPHIC_CONSOLE(c);<br=
>
=C2=A0 =C2=A0 =C2=A0DisplayState *s =3D c-&gt;ds;<br>
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
index 54900880433e..a54123acea7d 100644<br>
--- a/ui/dbus-listener.c<br>
+++ b/ui/dbus-listener.c<br>
@@ -726,7 +726,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,=
<br>
=C2=A0}<br>
<br>
=C2=A0static void dbus_mouse_set(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int on)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, bool on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DBusDisplayListener *ddl =3D container_of(dcl, DBusDisp=
layListener, dcl);<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index 93b13b7a30ff..bc29f7a1b4f7 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -446,7 +446,7 @@ static GdkDevice *gd_get_pointer(GdkDisplay *dpy)<br>
=C2=A0}<br>
<br>
=C2=A0static void gd_mouse_set(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int x, int y, int visible)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int x, int y, bool visible)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtualConsole *vc =3D container_of(dcl, VirtualConsole=
, gfx.dcl);<br>
=C2=A0 =C2=A0 =C2=A0GdkDisplay *dpy;<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 0a0eb5a42d58..98ed97437171 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -49,7 +49,7 @@ static int gui_grab_code =3D KMOD_LALT | KMOD_LCTRL;<br>
=C2=A0static SDL_Cursor *sdl_cursor_normal;<br>
=C2=A0static SDL_Cursor *sdl_cursor_hidden;<br>
=C2=A0static int absolute_enabled;<br>
-static int guest_cursor;<br>
+static bool guest_cursor;<br>
=C2=A0static int guest_x, guest_y;<br>
=C2=A0static SDL_Cursor *guest_sprite;<br>
=C2=A0static Notifier mouse_mode_notifier;<br>
@@ -729,7 +729,7 @@ void sdl2_poll_events(struct sdl2_console *scon)<br>
=C2=A0}<br>
<br>
=C2=A0static void sdl_mouse_warp(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int on)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, bool on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct sdl2_console *scon =3D container_of(dcl, struct =
sdl2_console, dcl);<br>
<br>
diff --git a/ui/spice-display.c b/ui/spice-display.c<br>
index 8a8472d0294e..c794ae06498b 100644<br>
--- a/ui/spice-display.c<br>
+++ b/ui/spice-display.c<br>
@@ -254,7 +254,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay=
 *ssd)<br>
=C2=A0static SimpleSpiceCursor*<br>
=C2=A0qemu_spice_create_cursor_update(SimpleSpiceDisplay *ssd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMUCursor *c,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int on)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t size =3D c ? c-&gt;width * c-&gt;height * 4 : 0;=
<br>
=C2=A0 =C2=A0 =C2=A0SimpleSpiceCursor *update;<br>
@@ -448,7 +448,8 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,=
<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;ssd-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0if (ssd-&gt;cursor) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(ssd-&gt;ptr_define);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssd-&gt;ptr_define =3D qemu_spice_create_curso=
r_update(ssd, ssd-&gt;cursor, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssd-&gt;ptr_define =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_spice_create_cursor_update(=
ssd, ssd-&gt;cursor, false);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;ssd-&gt;lock);<br>
=C2=A0}<br>
@@ -476,7 +477,7 @@ void qemu_spice_cursor_refresh_bh(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssd-&gt;mouse_x =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssd-&gt;mouse_y =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;ssd-&gt;lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_mouse_set(ssd-&gt;dcl.con, x, y, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_mouse_set(ssd-&gt;dcl.con, x, y, true);<br=
>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;ssd-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -747,7 +748,7 @@ static void display_refresh(DisplayChangeListener *dcl)=
<br>
=C2=A0}<br>
<br>
=C2=A0static void display_mouse_set(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int on)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, bool on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpi=
ceDisplay, dcl);<br>
<br>
@@ -774,7 +775,7 @@ static void display_mouse_define(DisplayChangeListener =
*dcl,<br>
=C2=A0 =C2=A0 =C2=A0g_free(ssd-&gt;ptr_move);<br>
=C2=A0 =C2=A0 =C2=A0ssd-&gt;ptr_move =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_free(ssd-&gt;ptr_define);<br>
-=C2=A0 =C2=A0 ssd-&gt;ptr_define =3D qemu_spice_create_cursor_update(ssd, =
c, 0);<br>
+=C2=A0 =C2=A0 ssd-&gt;ptr_define =3D qemu_spice_create_cursor_update(ssd, =
c, false);<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;ssd-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_wakeup(ssd);<br>
=C2=A0}<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index dd530f04e579..dae5d51210be 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -981,7 +981,7 @@ int vnc_send_framebuffer_update(VncState *vs, int x, in=
t y, int w, int h)<br>
=C2=A0}<br>
<br>
=C2=A0static void vnc_mouse_set(DisplayChangeListener *dcl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int x, int y, int visible)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int x, int y, bool visible)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* can we ask the client(s) to move the pointer ??? */<=
br>
=C2=A0}<br>
<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000177410061c065e38--

