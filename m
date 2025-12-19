Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579FCD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdAb-0004k5-71; Fri, 19 Dec 2025 11:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ldtqh7nhkj9s057=ax527bc78lxd=7uty75frfxoyvx@em483429.getutm.app>)
 id 1vWdAT-0004jd-Mg
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:17:26 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.ldtqh7nhkj9s057=ax527bc78lxd=7uty75frfxoyvx@em483429.getutm.app>)
 id 1vWdAP-0004uN-7n
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766161924; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=hqkHGjxZDFCVmj4qurNqCR0SP+VZvF7ooe0uIBpISaE=; b=C6KGwmqMv/1PeQehF6Inu9x6rd
 L8B7hhmisiSPP9LuxKEiQb9WIKVnPVWOk6Rsxk8aazHKe0X2hxpIhPDiSbTrFG9jVUxY0XfDZWZ2P
 /OT0iJmtXrWBvJWn1MemlibiQ2C3HSYMo6BBnvRGSa9DkJ5mTGPI1XjRTd6nEXmCd/2j+QWPXiLzt
 reaG5PEv05G10T22NWJznmH5v8wb8m9NyYHY9ZGmEbgopjhtIGDrh/nB4e9KJgG1q2pfFuHZYGAZR
 aOjrrpAmZwHpr5hqXxQnUrzXn8UoQgmhbLKH6SKc+FQUTay6rqLXD1mn6KGxRN+/Evqc8tCC20WrI
 HlKSTzcw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766161024; h=from : subject :
 to : message-id : date;
 bh=hqkHGjxZDFCVmj4qurNqCR0SP+VZvF7ooe0uIBpISaE=;
 b=PYvcOof0++b+46c8Ptjr3M+DZ0MA5XtgkhOMKdPeYhRF2rf1RKW+OPvynPKxLqvSjMSOP
 kjViULrr+BMCIHqkL/OQPECrSU6yIvmYVilTIpWKY0ZQeRL4gYnQ5pwDZWss3nnXIhgDQQI
 JeAJmtafb7m3Og2NCVBIpB/SLbbvlKghBOoscOz+tJCqcz0+F783bgW7P/i0MJ18lVKtiiQ
 6YcuiFWxx6V59XNEcOEahOdQ60J/N8koWTfi51navs/buj6k0MTtd/T5YGtGgQ33MdF814l
 1zIOOL5l+D7WV8ZTQqRRs8ggM1x62/dUBJx+UKU6SrRcwSOZWCeimS8x1ASA==
Received: from [10.173.255.233] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vWdA7-pH9UNl-Lg
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 16:17:03 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f45.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWdA7-FnQW0hPz8IL-1E6L for qemu-devel@nongnu.org;
 Fri, 19 Dec 2025 16:17:03 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso220269266b.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:17:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3te2WkUT8HjZQovU8s73np1pwdlzdl+yMMliyaqQ72xn2Ur/1iKjA0fIcbmu42q2CBmHTz0SErbtm@nongnu.org
X-Gm-Message-State: AOJu0Yyx9mGe6jISP4QXtZMyK8fgvX/nEnGXG/InMP9PPjkGCeFPor9G
 ENMsGUESnTVlfwKfFRW71etveAs1pMykQp36aNPSXP1QGBAnyX7dSnv5xDE+D66iXLoI4zwjl0P
 oN4xXlQIUlTVoVPdwC/TuIUy9GzMIDPw=
X-Google-Smtp-Source: AGHT+IFMvZ4bZzBaEx1XkN46HdAuU4yOt1cmcjGamqL/p7gNeDSQkcztxH20bAcuQKqNF4d/f1dLIoU9xPFsBF0nhEY=
X-Received: by 2002:a17:906:fd86:b0:b7a:615:75aa with SMTP id
 a640c23a62f3a-b80371a3a86mr337681066b.42.1766161021185; Fri, 19 Dec 2025
 08:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-4-j@getutm.app>
 <a3f3b84a-451d-4b41-8f32-fa96ed8a608f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a3f3b84a-451d-4b41-8f32-fa96ed8a608f@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 19 Dec 2025 08:16:48 -0800
X-Gmail-Original-Message-ID: <CA+E+eSB7rV9dvrB+1=wFyAgCQt89Ez8U3fxgyWvbb5QfOJTMkA@mail.gmail.com>
X-Gm-Features: AQt7F2pz8GlQyLJete2Icp-STe6nG3KArZkKTjmX9yP_W82p-Kkd-kPT2fj6XNM
Message-ID: <CA+E+eSB7rV9dvrB+1=wFyAgCQt89Ez8U3fxgyWvbb5QfOJTMkA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] console: rename `d3d_tex2d` to `native`
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: nddceRYoRFIT.EjJdNXGlbChG.1LQfPAtVP5k
Feedback-ID: 483429m:483429abrvJvs:483429sSQBnn4Ium
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.ldtqh7nhkj9s057=ax527bc78lxd=7uty75frfxoyvx@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 3, 2025 at 10:41=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/03 13:07, Joelle van Dyne wrote:
> > In order to support native texture scanout beyond D3D, we make this mor=
e
> > generic allowing for multiple native texture handle types.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   include/ui/console.h          | 22 +++++++++++++++++++---
> >   include/ui/gtk.h              |  4 ++--
> >   include/ui/sdl2.h             |  2 +-
> >   hw/display/virtio-gpu-virgl.c | 10 +++++++---
> >   ui/console.c                  |  8 ++++----
> >   ui/dbus-console.c             |  2 +-
> >   ui/dbus-listener.c            |  8 ++++----
> >   ui/egl-headless.c             |  2 +-
> >   ui/gtk-egl.c                  |  2 +-
> >   ui/gtk-gl-area.c              |  2 +-
> >   ui/sdl2-gl.c                  |  2 +-
> >   ui/spice-display.c            |  2 +-
> >   12 files changed, 43 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 98feaa58bd..25e45295d4 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -131,6 +131,22 @@ struct QemuConsoleClass {
> >       ObjectClass parent_class;
> >   };
> >
> > +typedef enum ScanoutTextureNativeType {
> > +    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> > +    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> > +} ScanoutTextureNativeType;
> > +
> > +typedef struct ScanoutTextureNative {
> > +    ScanoutTextureNativeType type;
> > +    union {
> > +        void *d3d_tex2d;
> > +    } u;> +} ScanoutTextureNative;
>
> Instead, I suggest:
>
> typedef struct ScanoutTextureNative {
>      ScanoutTextureNativeType type;
>      void *handle;
> } ScanoutTextureNative;
>
> ...to align with the definition of struct
> virgl_renderer_resource_info_ext and
> virgl_renderer_create_handle_for_scanout(), which do not add a field for
> each type (except the one for the backward compatibility).
I've updated virglrenderer to use a union as well. Since we are
passing ScanoutTextureNative around byval and it can grow with
additional platform support, I think it would be better to keep it as
a union.

>
> Regards,
> Akihiko Odaki
>
> > +
> > +#define NO_NATIVE_TEXTURE ((ScanoutTextureNative){ \
> > +    .type =3D SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
> > +})
> > +
> >   typedef struct ScanoutTexture {
> >       uint32_t backing_id;
> >       bool backing_y_0_top;
> > @@ -140,7 +156,7 @@ typedef struct ScanoutTexture {
> >       uint32_t y;
> >       uint32_t width;
> >       uint32_t height;
> > -    void *d3d_tex2d;
> > +    ScanoutTextureNative native;
> >   } ScanoutTexture;
> >
> >   typedef struct QemuUIInfo {
> > @@ -245,7 +261,7 @@ typedef struct DisplayChangeListenerOps {
> >                                      uint32_t backing_height,
> >                                      uint32_t x, uint32_t y,
> >                                      uint32_t w, uint32_t h,
> > -                                   void *d3d_tex2d);
> > +                                   ScanoutTextureNative native);
> >       /* optional (default to true if has dpy_gl_scanout_dmabuf) */
> >       bool (*dpy_has_dmabuf)(DisplayChangeListener *dcl);
> >       /* optional */
> > @@ -329,7 +345,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
> >                               uint32_t backing_id, bool backing_y_0_top=
,
> >                               uint32_t backing_width, uint32_t backing_=
height,
> >                               uint32_t x, uint32_t y, uint32_t w, uint3=
2_t h,
> > -                            void *d3d_tex2d);
> > +                            ScanoutTextureNative native);
> >   void dpy_gl_scanout_dmabuf(QemuConsole *con,
> >                              QemuDmaBuf *dmabuf);
> >   void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
> > diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> > index 3e6ce3cb48..f88e2b281d 100644
> > --- a/include/ui/gtk.h
> > +++ b/include/ui/gtk.h
> > @@ -178,7 +178,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *=
dcl,
> >                               uint32_t backing_height,
> >                               uint32_t x, uint32_t y,
> >                               uint32_t w, uint32_t h,
> > -                            void *d3d_tex2d);
> > +                            ScanoutTextureNative native);
> >   void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
> >                              QemuDmaBuf *dmabuf);
> >   void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
> > @@ -215,7 +215,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListen=
er *dcl,
> >                                   uint32_t backing_height,
> >                                   uint32_t x, uint32_t y,
> >                                   uint32_t w, uint32_t h,
> > -                                void *d3d_tex2d);
> > +                                ScanoutTextureNative native);
> >   void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
> >   void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
> >                                 uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h);
> > diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> > index dbe6e3d973..fdefb88229 100644
> > --- a/include/ui/sdl2.h
> > +++ b/include/ui/sdl2.h
> > @@ -93,7 +93,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *d=
cl,
> >                                uint32_t backing_height,
> >                                uint32_t x, uint32_t y,
> >                                uint32_t w, uint32_t h,
> > -                             void *d3d_tex2d);
> > +                             ScanoutTextureNative native);
> >   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
> >                              uint32_t x, uint32_t y, uint32_t w, uint32=
_t h);
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index adf02ac22b..d0e6ad4b17 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -434,14 +434,18 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >
> >       if (ss.resource_id && ss.r.width && ss.r.height) {
> >           struct virgl_renderer_resource_info info;
> > -        void *d3d_tex2d =3D NULL;
> > +        ScanoutTextureNative native =3D { .type =3D SCANOUT_TEXTURE_NA=
TIVE_TYPE_NONE };
> >
> >   #if VIRGL_VERSION_MAJOR >=3D 1
> >           struct virgl_renderer_resource_info_ext ext;
> >           memset(&ext, 0, sizeof(ext));
> >           ret =3D virgl_renderer_resource_get_info_ext(ss.resource_id, =
&ext);
> >           info =3D ext.base;
> > -        d3d_tex2d =3D ext.d3d_tex2d;
> > +        native =3D (ScanoutTextureNative){
> > +            .type =3D ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D =
:
> > +                                    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> > +            .u.d3d_tex2d =3D ext.d3d_tex2d,
> > +        };
> >   #else
> >           memset(&info, 0, sizeof(info));
> >           ret =3D virgl_renderer_resource_get_info(ss.resource_id, &inf=
o);
> > @@ -461,7 +465,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >               info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
> >               info.width, info.height,
> >               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> > -            d3d_tex2d);
> > +            native);
> >       } else {
> >           dpy_gfx_replace_surface(
> >               g->parent_obj.scanout[ss.scanout_id].con, NULL);
> > diff --git a/ui/console.c b/ui/console.c
> > index 2d00828c53..9378afd53d 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -295,7 +295,7 @@ static void displaychangelistener_display_console(D=
isplayChangeListener *dcl,
> >                                            con->scanout.texture.y,
> >                                            con->scanout.texture.width,
> >                                            con->scanout.texture.height,
> > -                                         con->scanout.texture.d3d_tex2=
d);
> > +                                         con->scanout.texture.native);
> >       }
> >   }
> >
> > @@ -1023,7 +1023,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
> >                               uint32_t backing_height,
> >                               uint32_t x, uint32_t y,
> >                               uint32_t width, uint32_t height,
> > -                            void *d3d_tex2d)
> > +                            ScanoutTextureNative native)
> >   {
> >       DisplayState *s =3D con->ds;
> >       DisplayChangeListener *dcl;
> > @@ -1031,7 +1031,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
> >       con->scanout.kind =3D SCANOUT_TEXTURE;
> >       con->scanout.texture =3D (ScanoutTexture) {
> >           backing_id, backing_y_0_top, backing_width, backing_height,
> > -        x, y, width, height, d3d_tex2d,
> > +        x, y, width, height, native,
> >       };
> >       QLIST_FOREACH(dcl, &s->listeners, next) {
> >           if (con !=3D dcl->con) {
> > @@ -1042,7 +1042,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
> >                                                backing_y_0_top,
> >                                                backing_width, backing_h=
eight,
> >                                                x, y, width, height,
> > -                                             d3d_tex2d);
> > +                                             native);
> >           }
> >       }
> >   }
> > diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> > index 85e215ef23..651f0daeaf 100644
> > --- a/ui/dbus-console.c
> > +++ b/ui/dbus-console.c
> > @@ -99,7 +99,7 @@ dbus_gl_scanout_texture(DisplayChangeListener *dcl,
> >                           uint32_t backing_height,
> >                           uint32_t x, uint32_t y,
> >                           uint32_t w, uint32_t h,
> > -                        void *d3d_tex2d)
> > +                        ScanoutTextureNative native)
> >   {
> >       DBusDisplayConsole *ddc =3D container_of(dcl, DBusDisplayConsole,=
 dcl);
> >
> > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > index 52e041edb0..a737752996 100644
> > --- a/ui/dbus-listener.c
> > +++ b/ui/dbus-listener.c
> > @@ -587,7 +587,7 @@ static void dbus_scanout_texture(DisplayChangeListe=
ner *dcl,
> >                                    uint32_t backing_height,
> >                                    uint32_t x, uint32_t y,
> >                                    uint32_t w, uint32_t h,
> > -                                 void *d3d_tex2d)
> > +                                 ScanoutTextureNative native)
> >   {
> >       trace_dbus_scanout_texture(tex_id, backing_y_0_top,
> >                                  backing_width, backing_height, x, y, w=
, h);
> > @@ -618,8 +618,8 @@ static void dbus_scanout_texture(DisplayChangeListe=
ner *dcl,
> >       assert(surface_width(ddl->ds) =3D=3D w);
> >       assert(surface_height(ddl->ds) =3D=3D h);
> >
> > -    if (d3d_tex2d) {
> > -        dbus_scanout_share_d3d_texture(ddl, d3d_tex2d, backing_y_0_top=
,
> > +    if (native.type =3D=3D SCANOUT_TEXTURE_NATIVE_TYPE_D3d) {
>
> s/SCANOUT_TEXTURE_NATIVE_TYPE_D3d/SCANOUT_TEXTURE_NATIVE_TYPE_D3D/
>
> Regards,
> Akihiko Odaki
>
> > +        dbus_scanout_share_d3d_texture(ddl, native.u.d3d_tex2d, backin=
g_y_0_top,
> >                                          backing_width, backing_height,=
 x, y, w, h);
> >       } else {
> >           dbus_scanout_map(ddl);
> > @@ -868,7 +868,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListene=
r *dcl,
> >
> >           /* TODO: lazy send dmabuf (there are unnecessary sent otherwi=
se) */
> >           dbus_scanout_texture(&ddl->dcl, ddl->ds->texture, false,
> > -                             width, height, 0, 0, width, height, NULL)=
;
> > +                             width, height, 0, 0, width, height, NO_NA=
TIVE_TEXTURE);
> >       }
> >   }
> >   #endif
> > diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> > index 1f6b845500..e36778bd48 100644
> > --- a/ui/egl-headless.c
> > +++ b/ui/egl-headless.c
> > @@ -62,7 +62,7 @@ static void egl_scanout_texture(DisplayChangeListener=
 *dcl,
> >                                   uint32_t backing_height,
> >                                   uint32_t x, uint32_t y,
> >                                   uint32_t w, uint32_t h,
> > -                                void *d3d_tex2d)
> > +                                ScanoutTextureNative native)
> >   {
> >       egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> >
> > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> > index ae9239999c..7933237d45 100644
> > --- a/ui/gtk-egl.c
> > +++ b/ui/gtk-egl.c
> > @@ -239,7 +239,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *=
dcl,
> >                               uint32_t backing_width, uint32_t backing_=
height,
> >                               uint32_t x, uint32_t y,
> >                               uint32_t w, uint32_t h,
> > -                            void *d3d_tex2d)
> > +                            ScanoutTextureNative native)
> >   {
> >       VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl)=
;
> >
> > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > index cd86022d26..f2ed543d6a 100644
> > --- a/ui/gtk-gl-area.c
> > +++ b/ui/gtk-gl-area.c
> > @@ -306,7 +306,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListen=
er *dcl,
> >                                   uint32_t backing_height,
> >                                   uint32_t x, uint32_t y,
> >                                   uint32_t w, uint32_t h,
> > -                                void *d3d_tex2d)
> > +                                ScanoutTextureNative native)
> >   {
> >       VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl)=
;
> >
> > diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> > index 3be17d1079..b15db86f24 100644
> > --- a/ui/sdl2-gl.c
> > +++ b/ui/sdl2-gl.c
> > @@ -206,7 +206,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener =
*dcl,
> >                                uint32_t backing_height,
> >                                uint32_t x, uint32_t y,
> >                                uint32_t w, uint32_t h,
> > -                             void *d3d_tex2d)
> > +                             ScanoutTextureNative native)
> >   {
> >       struct sdl2_console *scon =3D container_of(dcl, struct sdl2_conso=
le, dcl);
> >
> > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > index db71e866f8..2a2285cb1f 100644
> > --- a/ui/spice-display.c
> > +++ b/ui/spice-display.c
> > @@ -1084,7 +1084,7 @@ static void qemu_spice_gl_scanout_texture(Display=
ChangeListener *dcl,
> >                                             uint32_t backing_height,
> >                                             uint32_t x, uint32_t y,
> >                                             uint32_t w, uint32_t h,
> > -                                          void *d3d_tex2d)
> > +                                          ScanoutTextureNative native)
> >   {
> >       SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay,=
 dcl);
> >       EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], four=
cc =3D 0;
>

