Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D7C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNX5K-0003WT-K4; Sat, 29 Jun 2024 08:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX5J-0003W6-FR
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:21:41 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX5H-0004zT-JV
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:21:41 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-446416dccd5so8314411cf.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719663698; x=1720268498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/xWAUkaPr2PRQg1Q0WhVjdGslqPK1Im3QqiImTkR8o=;
 b=GI2trFyP6wTy1aKN6o1idOTsFzyNtK3q9SRCAEmpKjcsJskTMSSYie6QhC5e+DVLdC
 zJZz8z10j23xBVkpyN3F184Y56ImJXLx5Zrb9ri9TJXK+o6wu/Y45Iz5HhE7MXLjaVy/
 Z21Vt/HcR+voFA/+uYKAHTtOimLaWaYdjRQG2sl4w/flqgQDWAndaEcw1SveQHZXosAD
 ZNrqX04UlJ3rOq7s/dOO6rXFUd3Ucz5sfkx7U1l3tNbVByH2ggGd4W4BkHBnt334UXBA
 lINM5xiXr9yJ63Qz87V21hX7qJvhl0lfmWfeXbfCLpVeLP2W8LVlEejJTEdeT1sAgyiB
 r9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719663698; x=1720268498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/xWAUkaPr2PRQg1Q0WhVjdGslqPK1Im3QqiImTkR8o=;
 b=eNljpr+lGxrYOwojroN2zy7LV96U0HQdhlXzpWR+iVicTD6LWnr28FscZAGWsSLCse
 AtptwG2QkWRlyRZEGUHAf11bsC2rxO6HFUiIiO/Az3BEwWVExlCjJZ5AQZHku0/7oNxe
 fhpjaaCXAKCR/G0ZCiBosWFBE52P4/KdaGy4oQt1RBT5JhhyDfTFrtxPeu8XOHX5SPDg
 dSIQ/U3M5WkQTsV9dmPjlU0lQKyvPtcJVAiAw8gTOBePIpe8y5wDmY+Q3ZRzwXJ5k+EN
 pB66FzHPfSjWfghgYV5ZSydpRRfbsh7OJ/aA3OnuSdd/WTwUFew0CFPwLrhx1AC2GEs1
 mFjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/eG8f0UrxMzqF7LRYIfEofFHOlAbDOo/Q7b1fLz0xwJzp3nqFlXAPfhe1OADDk65OrNOUWgrhuDPipPmZf5ivFrorwRU=
X-Gm-Message-State: AOJu0YwvUJdtuNz0uhONEpFysZGfa31u7Vswa9+pg9hOeTpN3yqOYkt+
 U2aLo805egqyc4d1SJy2SH2Z4N1NRcK+ZLSSKdXGwyn+BUJvf6YAfTsGj18wGWKIJzznePNkqbi
 QCBIDBwNSLnzQvmVwn9minDAxzv0vRGFkY50=
X-Google-Smtp-Source: AGHT+IHyfGG/d0NLgfxDRp0xVmQk6bU7FGWukyCzr74p2ddtc50LuVHzegfQAAfYNG9CJSRELw2+WeYRORSYmN/e96E=
X-Received: by 2002:ac8:584d:0:b0:446:48b5:16d8 with SMTP id
 d75a77b69052e-44662e9c972mr8258091cf.58.1719663698350; Sat, 29 Jun 2024
 05:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-4-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-4-c3cd3ee35616@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 29 Jun 2024 16:21:27 +0400
Message-ID: <CAJ+F1C+0R=K_nfLkH+xFhocy8z_e5maeKpVs501TyhAktfc3Sg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ui/console: Remove dpy_cursor_define_supported()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000df99f6061c06674a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

--000000000000df99f6061c06674a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com>
wrote:

> Remove dpy_cursor_define_supported() as it brings no benefit today and
> it has a few inherent problems.
>
> All graphical displays except egl-headless support cursor composition
> without DMA-BUF, and egl-headless is meant to be used in conjunction
> with another graphical display, so dpy_cursor_define_supported()
> always returns true and meaningless.
>
> Even if we add a new display without cursor composition in the future,
> dpy_cursor_define_supported() will be problematic as a cursor display
> fix for it because some display devices like virtio-gpu cannot tell the
> lack of cursor composition capability to the guest and are unable to
> utilize the value the function returns. Therefore, all non-headless
> graphical displays must actually implement cursor composition for
> correct cursor display.
>
> Another problem with dpy_cursor_define_supported() is that it returns
> true even if only some of the display listeners support cursor
> composition, which is wrong unless all display listeners that lack
> cursor composition is headless.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Agreed,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/console.h    |  1 -
>  hw/display/qxl-render.c |  4 ----
>  hw/display/vmware_vga.c |  6 ++----
>  ui/console.c            | 13 -------------
>  4 files changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 82b573e68082..fa986ab97e3b 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -324,7 +324,6 @@ void dpy_text_update(QemuConsole *con, int x, int y,
> int w, int h);
>  void dpy_text_resize(QemuConsole *con, int w, int h);
>  void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);
>  void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);
> -bool dpy_cursor_define_supported(QemuConsole *con);
>  bool dpy_gfx_check_format(QemuConsole *con,
>                            pixman_format_code_t format);
>
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index ec99ec887a6e..837d2446cd52 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -307,10 +307,6 @@ int qxl_render_cursor(PCIQXLDevice *qxl,
> QXLCommandExt *ext)
>          return 1;
>      }
>
> -    if (!dpy_cursor_define_supported(qxl->vga.con)) {
> -        return 0;
> -    }
> -
>      if (qxl->debug > 1 && cmd->type !=3D QXL_CURSOR_MOVE) {
>          fprintf(stderr, "%s", __func__);
>          qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
> index 512f224b9f58..3db3ff98f763 100644
> --- a/hw/display/vmware_vga.c
> +++ b/hw/display/vmware_vga.c
> @@ -904,10 +904,8 @@ static uint32_t vmsvga_value_read(void *opaque,
> uint32_t address)
>          caps |=3D SVGA_CAP_RECT_FILL;
>  #endif
>  #ifdef HW_MOUSE_ACCEL
> -        if (dpy_cursor_define_supported(s->vga.con)) {
> -            caps |=3D SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
> -                    SVGA_CAP_CURSOR_BYPASS;
> -        }
> +        caps |=3D SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
> +                SVGA_CAP_CURSOR_BYPASS;
>  #endif
>          ret =3D caps;
>          break;
> diff --git a/ui/console.c b/ui/console.c
> index 0ec70cb50ce6..33976446425e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1001,19 +1001,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor
> *cursor)
>      }
>  }
>
> -bool dpy_cursor_define_supported(QemuConsole *con)
> -{
> -    DisplayState *s =3D con->ds;
> -    DisplayChangeListener *dcl;
> -
> -    QLIST_FOREACH(dcl, &s->listeners, next) {
> -        if (dcl->ops->dpy_cursor_define) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
>  QEMUGLContext dpy_gl_ctx_create(QemuConsole *con,
>                                  struct QEMUGLParams *qparams)
>  {
>
> --
> 2.45.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000df99f6061c06674a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 27, 2024 at 3:19=E2=80=AF=
PM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.od=
aki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Remove dpy_cursor_define_supported() as it brings no benefit =
today and<br>
it has a few inherent problems.<br>
<br>
All graphical displays except egl-headless support cursor composition<br>
without DMA-BUF, and egl-headless is meant to be used in conjunction<br>
with another graphical display, so dpy_cursor_define_supported()<br>
always returns true and meaningless.<br>
<br>
Even if we add a new display without cursor composition in the future,<br>
dpy_cursor_define_supported() will be problematic as a cursor display<br>
fix for it because some display devices like virtio-gpu cannot tell the<br>
lack of cursor composition capability to the guest and are unable to<br>
utilize the value the function returns. Therefore, all non-headless<br>
graphical displays must actually implement cursor composition for<br>
correct cursor display.<br>
<br>
Another problem with dpy_cursor_define_supported() is that it returns<br>
true even if only some of the display listeners support cursor<br>
composition, which is wrong unless all display listeners that lack<br>
cursor composition is headless.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>Agreed,</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>=
&gt; <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/ui/console.h=C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0hw/display/qxl-render.c |=C2=A0 4 ----<br>
=C2=A0hw/display/vmware_vga.c |=C2=A0 6 ++----<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 ----------=
---<br>
=C2=A04 files changed, 2 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/include/ui/console.h b/include/ui/console.h<br>
index 82b573e68082..fa986ab97e3b 100644<br>
--- a/include/ui/console.h<br>
+++ b/include/ui/console.h<br>
@@ -324,7 +324,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, in=
t w, int h);<br>
=C2=A0void dpy_text_resize(QemuConsole *con, int w, int h);<br>
=C2=A0void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);<br>
=C2=A0void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);<br>
-bool dpy_cursor_define_supported(QemuConsole *con);<br>
=C2=A0bool dpy_gfx_check_format(QemuConsole *con,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pixman_format_code_t format);<br>
<br>
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c<br>
index ec99ec887a6e..837d2446cd52 100644<br>
--- a/hw/display/qxl-render.c<br>
+++ b/hw/display/qxl-render.c<br>
@@ -307,10 +307,6 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt=
 *ext)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!dpy_cursor_define_supported(qxl-&gt;vga.con)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (qxl-&gt;debug &gt; 1 &amp;&amp; cmd-&gt;type !=3D Q=
XL_CURSOR_MOVE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;%s&quot;, __func__)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qxl_log_cmd_cursor(qxl, cmd, ext-&gt;grou=
p_id);<br>
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c<br>
index 512f224b9f58..3db3ff98f763 100644<br>
--- a/hw/display/vmware_vga.c<br>
+++ b/hw/display/vmware_vga.c<br>
@@ -904,10 +904,8 @@ static uint32_t vmsvga_value_read(void *opaque, uint32=
_t address)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0caps |=3D SVGA_CAP_RECT_FILL;<br>
=C2=A0#endif<br>
=C2=A0#ifdef HW_MOUSE_ACCEL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dpy_cursor_define_supported(s-&gt;vga.con)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 caps |=3D SVGA_CAP_CURSOR | SVGA=
_CAP_CURSOR_BYPASS_2 |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SVGA=
_CAP_CURSOR_BYPASS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 caps |=3D SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BY=
PASS_2 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SVGA_CAP_CURSOR_BY=
PASS;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D caps;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 0ec70cb50ce6..33976446425e 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -1001,19 +1001,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *c=
ursor)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-bool dpy_cursor_define_supported(QemuConsole *con)<br>
-{<br>
-=C2=A0 =C2=A0 DisplayState *s =3D con-&gt;ds;<br>
-=C2=A0 =C2=A0 DisplayChangeListener *dcl;<br>
-<br>
-=C2=A0 =C2=A0 QLIST_FOREACH(dcl, &amp;s-&gt;listeners, next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dcl-&gt;ops-&gt;dpy_cursor_define) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return false;<br>
-}<br>
-<br>
=C2=A0QEMUGLContext dpy_gl_ctx_create(QemuConsole *con,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct QEMUGLParams *qparams)<=
br>
=C2=A0{<br>
<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000df99f6061c06674a--

