Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB861D1F9B4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6xv-0004lB-S0; Thu, 04 Dec 2025 05:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vR6xu-0004l0-IL
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:53:38 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vR6xq-00032e-5U
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:53:37 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8b2ea5a44a9so73102185a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 02:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764845610; x=1765450410; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pa/hsHLqThxvRCmNRYFutdsDhF6IyoTCBEGwmpVrYh8=;
 b=aaaPrXRY/eq0lY9hr8m0CZwVf0yLF3/FV2ZdNsZ99kF6SBUGhGBTeK4uwLftbxXe5P
 odBB1WiNfcO6wIRKzf8wgcntNhLYqEab1T+ay4aCKreMynaHS1CR6yrXGguVY6T9Sg4i
 EaM4CJ6qXs0wOYA+24/0AyOIgguT3S1C28PWRyrUk+oeCyIZ43HAVvzs8r8IS8GD0Ozx
 kZPfJLJUo/JMyvHvjDXlm9+9j7WmfV1UUY6pu6Y3wRaIf/5hkizuBJIwwyouDifnIcj4
 U/tJPWSaPqvpfBslQjhfzpJBwdhHdaHTKbHceXa9bnIAZ6NykpExFs+A//0Jeo1wIVVE
 FxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764845610; x=1765450410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pa/hsHLqThxvRCmNRYFutdsDhF6IyoTCBEGwmpVrYh8=;
 b=UYyIBvnHO5EoPUjr4pebDgvJZnX2h7ntfVyxilfG9tM0kPp72tQf7RGC06VtUj4XYu
 I5Q23UysBHc/FXz8OII4HtzY8zfZDZJSn1kmaIWPdgc4NSFN2HPp0uSl7PLy8b/+b5d1
 K422Fv/Fk4+/iNTbEKTWNS24dsRiy19+b0CSd73DHvHcLXc4rCOfv5tA1H/doi+LkHC/
 r74dLxAkSl2DsSAW2IRQq/ktCw6L2Vm/SdpcJDQWtNnQDDrtNpSF5K8U+ukenpYJ1lfP
 5Ya4MBjEOqXfX4c6syegvXHmApfxRkbWBp40PIEf4HdOKJ/NwOILt7pQNmbd2rOL2M5K
 7Z9A==
X-Gm-Message-State: AOJu0Yy60U/+60Pv8DfXpYFohJU5BHdy22cxp/3L80xJbMeb59V51OIo
 QP8ORuPL0SXSrbb4MKdHLPnyAMXRkW7yobMLGBaYgUdsW7wTRTPLayVhlIezHfTMm5Fik+UdA9X
 zBDy99e3zQmpvHS1k8f2MiUz+YTS12Ts=
X-Gm-Gg: ASbGnculZwM/wjLJiV43lJXdrN5VtT7rgYh8cJbz+Pa81z//jtuygg8Ki3A1nmtozug
 PO51N/eQfow1aXiQdKk4fOqorJB8eqLAzi83SaMCcpxYSlHtXHCnJaJQTnn3hgr4qp4s2uVlpjw
 M8vSQgxtDhDpBCllau55NE3UdszvHKQ3dYjF78vQKImDzPaycdrSlUDt+SSvhAxNcugFYEenu+X
 1FUMyo1aimonCLwTCLJwRr8Si+ZORh8qJuTTAfZyuXazZVlOJspsVOWsiqf5Eqjchn32eTHnFo3
 Fw==
X-Google-Smtp-Source: AGHT+IGzelsD7Znc5gtL+Ft8WTQXkbgxtSAk/z+v+syHgK/pvFaffXg3kUhy5ZkfSViVqWRZew7sXwLezMvhQXKD7AE=
X-Received: by 2002:a05:620a:4445:b0:8b5:8ba0:b312 with SMTP id
 af79cd13be357-8b6181bd570mr342416385a.48.1764845609659; Thu, 04 Dec 2025
 02:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-4-j@getutm.app>
In-Reply-To: <20251203040754.94487-4-j@getutm.app>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Dec 2025 14:53:17 +0400
X-Gm-Features: AWmQ_bkV6-FAaStRnR97DvgRZTKlLZYOj-K-SYlVP_I6dUdtpJ3v_wXgSOlVY5k
Message-ID: <CAJ+F1CK9cnFjMyQZD2s5g__wX38QkPraESWihM4KDUgxShN+RA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] console: rename `d3d_tex2d` to `native`
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
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

Hi

On Wed, Dec 3, 2025 at 8:09=E2=80=AFAM Joelle van Dyne <j@getutm.app> wrote=
:
>
> In order to support native texture scanout beyond D3D, we make this more
> generic allowing for multiple native texture handle types.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>

../ui/egl-headless.c:100:40: error: incompatible type for argument 10
of =E2=80=98egl_scanout_texture=E2=80=99
../ui/gtk-gl-area.c:377:53: error: incompatible type for argument 10
of =E2=80=98gd_gl_area_scanout_texture=E2=80=99
../ui/gtk-egl.c:293:49: error: incompatible type for argument 10 of
=E2=80=98gd_egl_scanout_texture=E2=80=99

all like:
 note: expected =E2=80=98ScanoutTextureNative=E2=80=99 but argument is of t=
ype =E2=80=98void *=E2=80=99


> ---
>  include/ui/console.h          | 22 +++++++++++++++++++---
>  include/ui/gtk.h              |  4 ++--
>  include/ui/sdl2.h             |  2 +-
>  hw/display/virtio-gpu-virgl.c | 10 +++++++---
>  ui/console.c                  |  8 ++++----
>  ui/dbus-console.c             |  2 +-
>  ui/dbus-listener.c            |  8 ++++----
>  ui/egl-headless.c             |  2 +-
>  ui/gtk-egl.c                  |  2 +-
>  ui/gtk-gl-area.c              |  2 +-
>  ui/sdl2-gl.c                  |  2 +-
>  ui/spice-display.c            |  2 +-
>  12 files changed, 43 insertions(+), 23 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 98feaa58bd..25e45295d4 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -131,6 +131,22 @@ struct QemuConsoleClass {
>      ObjectClass parent_class;
>  };
>
> +typedef enum ScanoutTextureNativeType {
> +    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> +    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> +} ScanoutTextureNativeType;
> +
> +typedef struct ScanoutTextureNative {
> +    ScanoutTextureNativeType type;
> +    union {
> +        void *d3d_tex2d;
> +    } u;
> +} ScanoutTextureNative;
> +
> +#define NO_NATIVE_TEXTURE ((ScanoutTextureNative){ \
> +    .type =3D SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
> +})
> +
>  typedef struct ScanoutTexture {
>      uint32_t backing_id;
>      bool backing_y_0_top;
> @@ -140,7 +156,7 @@ typedef struct ScanoutTexture {
>      uint32_t y;
>      uint32_t width;
>      uint32_t height;
> -    void *d3d_tex2d;
> +    ScanoutTextureNative native;
>  } ScanoutTexture;
>
>  typedef struct QemuUIInfo {
> @@ -245,7 +261,7 @@ typedef struct DisplayChangeListenerOps {
>                                     uint32_t backing_height,
>                                     uint32_t x, uint32_t y,
>                                     uint32_t w, uint32_t h,
> -                                   void *d3d_tex2d);
> +                                   ScanoutTextureNative native);
>      /* optional (default to true if has dpy_gl_scanout_dmabuf) */
>      bool (*dpy_has_dmabuf)(DisplayChangeListener *dcl);
>      /* optional */
> @@ -329,7 +345,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                              uint32_t backing_id, bool backing_y_0_top,
>                              uint32_t backing_width, uint32_t backing_hei=
ght,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t=
 h,
> -                            void *d3d_tex2d);
> +                            ScanoutTextureNative native);
>  void dpy_gl_scanout_dmabuf(QemuConsole *con,
>                             QemuDmaBuf *dmabuf);
>  void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 3e6ce3cb48..f88e2b281d 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -178,7 +178,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dc=
l,
>                              uint32_t backing_height,
>                              uint32_t x, uint32_t y,
>                              uint32_t w, uint32_t h,
> -                            void *d3d_tex2d);
> +                            ScanoutTextureNative native);
>  void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>                             QemuDmaBuf *dmabuf);
>  void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
> @@ -215,7 +215,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener=
 *dcl,
>                                  uint32_t backing_height,
>                                  uint32_t x, uint32_t y,
>                                  uint32_t w, uint32_t h,
> -                                void *d3d_tex2d);
> +                                ScanoutTextureNative native);
>  void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
>  void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>                                uint32_t x, uint32_t y, uint32_t w, uint32=
_t h);
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d973..fdefb88229 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -93,7 +93,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl=
,
>                               uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t w, uint32_t h,
> -                             void *d3d_tex2d);
> +                             ScanoutTextureNative native);
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t =
h);
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index adf02ac22b..d0e6ad4b17 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -434,14 +434,18 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>
>      if (ss.resource_id && ss.r.width && ss.r.height) {
>          struct virgl_renderer_resource_info info;
> -        void *d3d_tex2d =3D NULL;
> +        ScanoutTextureNative native =3D { .type =3D SCANOUT_TEXTURE_NATI=
VE_TYPE_NONE };
>
>  #if VIRGL_VERSION_MAJOR >=3D 1
>          struct virgl_renderer_resource_info_ext ext;
>          memset(&ext, 0, sizeof(ext));
>          ret =3D virgl_renderer_resource_get_info_ext(ss.resource_id, &ex=
t);
>          info =3D ext.base;
> -        d3d_tex2d =3D ext.d3d_tex2d;
> +        native =3D (ScanoutTextureNative){
> +            .type =3D ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
> +                                    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> +            .u.d3d_tex2d =3D ext.d3d_tex2d,
> +        };
>  #else
>          memset(&info, 0, sizeof(info));
>          ret =3D virgl_renderer_resource_get_info(ss.resource_id, &info);
> @@ -461,7 +465,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>              info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
>              info.width, info.height,
>              ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> -            d3d_tex2d);
> +            native);
>      } else {
>          dpy_gfx_replace_surface(
>              g->parent_obj.scanout[ss.scanout_id].con, NULL);
> diff --git a/ui/console.c b/ui/console.c
> index 2d00828c53..9378afd53d 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -295,7 +295,7 @@ static void displaychangelistener_display_console(Dis=
playChangeListener *dcl,
>                                           con->scanout.texture.y,
>                                           con->scanout.texture.width,
>                                           con->scanout.texture.height,
> -                                         con->scanout.texture.d3d_tex2d)=
;
> +                                         con->scanout.texture.native);
>      }
>  }
>
> @@ -1023,7 +1023,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                              uint32_t backing_height,
>                              uint32_t x, uint32_t y,
>                              uint32_t width, uint32_t height,
> -                            void *d3d_tex2d)
> +                            ScanoutTextureNative native)
>  {
>      DisplayState *s =3D con->ds;
>      DisplayChangeListener *dcl;
> @@ -1031,7 +1031,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>      con->scanout.kind =3D SCANOUT_TEXTURE;
>      con->scanout.texture =3D (ScanoutTexture) {
>          backing_id, backing_y_0_top, backing_width, backing_height,
> -        x, y, width, height, d3d_tex2d,
> +        x, y, width, height, native,
>      };
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (con !=3D dcl->con) {
> @@ -1042,7 +1042,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                                               backing_y_0_top,
>                                               backing_width, backing_heig=
ht,
>                                               x, y, width, height,
> -                                             d3d_tex2d);
> +                                             native);
>          }
>      }
>  }
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 85e215ef23..651f0daeaf 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -99,7 +99,7 @@ dbus_gl_scanout_texture(DisplayChangeListener *dcl,
>                          uint32_t backing_height,
>                          uint32_t x, uint32_t y,
>                          uint32_t w, uint32_t h,
> -                        void *d3d_tex2d)
> +                        ScanoutTextureNative native)
>  {
>      DBusDisplayConsole *ddc =3D container_of(dcl, DBusDisplayConsole, dc=
l);
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 52e041edb0..a737752996 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -587,7 +587,7 @@ static void dbus_scanout_texture(DisplayChangeListene=
r *dcl,
>                                   uint32_t backing_height,
>                                   uint32_t x, uint32_t y,
>                                   uint32_t w, uint32_t h,
> -                                 void *d3d_tex2d)
> +                                 ScanoutTextureNative native)
>  {
>      trace_dbus_scanout_texture(tex_id, backing_y_0_top,
>                                 backing_width, backing_height, x, y, w, h=
);
> @@ -618,8 +618,8 @@ static void dbus_scanout_texture(DisplayChangeListene=
r *dcl,
>      assert(surface_width(ddl->ds) =3D=3D w);
>      assert(surface_height(ddl->ds) =3D=3D h);
>
> -    if (d3d_tex2d) {
> -        dbus_scanout_share_d3d_texture(ddl, d3d_tex2d, backing_y_0_top,
> +    if (native.type =3D=3D SCANOUT_TEXTURE_NATIVE_TYPE_D3d) {
> +        dbus_scanout_share_d3d_texture(ddl, native.u.d3d_tex2d, backing_=
y_0_top,
>                                         backing_width, backing_height, x,=
 y, w, h);
>      } else {
>          dbus_scanout_map(ddl);
> @@ -868,7 +868,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListener =
*dcl,
>
>          /* TODO: lazy send dmabuf (there are unnecessary sent otherwise)=
 */
>          dbus_scanout_texture(&ddl->dcl, ddl->ds->texture, false,
> -                             width, height, 0, 0, width, height, NULL);
> +                             width, height, 0, 0, width, height, NO_NATI=
VE_TEXTURE);
>      }
>  }
>  #endif
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index 1f6b845500..e36778bd48 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -62,7 +62,7 @@ static void egl_scanout_texture(DisplayChangeListener *=
dcl,
>                                  uint32_t backing_height,
>                                  uint32_t x, uint32_t y,
>                                  uint32_t w, uint32_t h,
> -                                void *d3d_tex2d)
> +                                ScanoutTextureNative native)
>  {
>      egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index ae9239999c..7933237d45 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -239,7 +239,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dc=
l,
>                              uint32_t backing_width, uint32_t backing_hei=
ght,
>                              uint32_t x, uint32_t y,
>                              uint32_t w, uint32_t h,
> -                            void *d3d_tex2d)
> +                            ScanoutTextureNative native)
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index cd86022d26..f2ed543d6a 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -306,7 +306,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener=
 *dcl,
>                                  uint32_t backing_height,
>                                  uint32_t x, uint32_t y,
>                                  uint32_t w, uint32_t h,
> -                                void *d3d_tex2d)
> +                                ScanoutTextureNative native)
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 3be17d1079..b15db86f24 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -206,7 +206,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *d=
cl,
>                               uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t w, uint32_t h,
> -                             void *d3d_tex2d)
> +                             ScanoutTextureNative native)
>  {
>      struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,=
 dcl);
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index db71e866f8..2a2285cb1f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1084,7 +1084,7 @@ static void qemu_spice_gl_scanout_texture(DisplayCh=
angeListener *dcl,
>                                            uint32_t backing_height,
>                                            uint32_t x, uint32_t y,
>                                            uint32_t w, uint32_t h,
> -                                          void *d3d_tex2d)
> +                                          ScanoutTextureNative native)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc =
=3D 0;
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

