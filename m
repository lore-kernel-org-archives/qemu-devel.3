Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBB6FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHKs5-0005FS-UY; Mon, 27 Apr 2026 08:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wHKry-0005Dv-6S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:15:23 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wHKru-0001VM-Aj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:15:21 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso679380966b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292114; cv=none;
 d=google.com; s=arc-20240605;
 b=BtYkBTr5hjW8VnKzloalhcK8ClV/DCdvPPLhOZV96UxJPmBDLbjECu/uolA2Ca3dHh
 ddd95xbup7FR9Keu3ppD9RAEWmBPLOekpHccz2T/XMlU7o+xLyRVmm4wPMxKtzfPruir
 7nIJvKpo1JDC4QgmwJg9SxHyFVJtyRQ2+xunTTZFdeaL/mFNywHq8qp9ezvCJgwH0akl
 fplSdcvw4cS3oyR//maDmON77/fu9QS+b5iz/kh/6vWFyBHTQyLNEcJIyPxjjqXsGPUf
 ZRp8AswP+aRrYNaDOmkizyaSRVldL0W7zFzqmAvt11d+BEyIPZMlwYdvXJwmyxENv025
 nDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oz+eD363NQ1uJnhbgwljHzW8MtTeN+EqqhGcDb1bZjg=;
 fh=5DtwW8VDym1e0k1+6VgeguCLLQmQuHFGrQGNU3lyEOY=;
 b=TI1rqUWSdFXhzsnlvfnUcK9cwycW8tjMfdkWsnCZI0ynsuvaE2Lw/TfHKni9rtsx8d
 93HJaw1w39/ydGjW9FQSeP0TwUpOGkC+fgZ8BWIsmv0vCq1Rciu62Uubz9iR21tITGcj
 5k6RH5U7VM4w6J/0iWA0fOTsisB3FxkwqPYxFzJ/XUqvjtrtgWgRKF4hM55XQjE0RNIE
 9S3TseOXg+ehfxmbYbNKC6zyiHqBKXB0gvpsje4TAv9LYtmhZaciJoA7DtDtD+QhNISh
 HXsVBZMT5JmEmZqdYJBxzXdhucNEnhiFi4a2R02M+I+iDuWSeAHaPZZpi6skEiTZ3IPz
 TmdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neodyme.io; s=google; t=1777292114; x=1777896914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oz+eD363NQ1uJnhbgwljHzW8MtTeN+EqqhGcDb1bZjg=;
 b=bK3fJgbkCHC6xlsdnjgf/dUP8Sqi6yvc4C/smOuU8OEuMMOgD5icXYy9ilv3wu8Iay
 bVpRWgY4Kv31Ipgooj1UDCpm9NKmt7Vd1LOLLTIIJPnlz/gYucwrafVjpnzxude8bqwT
 0JGg3RdjZHdBrtZ5jMUAcnhy5dpYN8eJlZRE62BgcTAhMS3gDgYogdt+7/ek31mAiqfq
 k3EZdbtN83FnTm8RHLloZOW031seJmkcNvn3xNfV6zpxEg+7Xb84vbt7E6N9jc0po/fQ
 h6MssiJQhgysx6hM9NsPmEpGyvw3VQUhdo+T1VFstZlk41LDBlsfk+QXX/SyIDWd+vDt
 sCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777292114; x=1777896914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz+eD363NQ1uJnhbgwljHzW8MtTeN+EqqhGcDb1bZjg=;
 b=mYh02XdwnQYX9iHzOCOdq+jKE05KgvQhULdoWjNI65xOXf3PyuJ05I1QSr0Zg9TWP2
 zNrn96yylMDIzOedY0E4gP6/5FWhqVRaLbsod5wwugMJjTirMtU1oYQOHDLN0I6fdLss
 13o7dNHuTaz+HL90s78Biat22D5GWqDbwgcEhJny+bTmznWrRBC4B+CfQDqfPfQwAoet
 bDKB2aOvRykhQ1+4w5rawr+Q6LMmbYY9+J1Y09Llp5Bu0hdLVXF24uoMwiOAqQG+CGIV
 LBBwhYdSyVGRv2ynIE2YpCeYDFFKNhMO4jg9HT5Vmq7Fs/lk3o2REvprXN66glJMwu6V
 9SwA==
X-Gm-Message-State: AOJu0Yw5o3Yi7mcEkUhLKqS0VIdqVIvX5XTKFbiUEJ6aX6ZnsMSv2Udd
 NgvNnY179X1jGbKnPJUN9UCvOj/Yf1ZQocKzlIjsDDU5YTVNoRuZTFUMYFzgFGwvuxS1RwaBUXu
 q0/pEY2X53Z1apDAmfVzWr1kAJcqhiFSNTptU90fCny4E2VNAqPO+vfFEFJ8fWk4sijTR2E3XwZ
 mbXr+BBkWkZ2f6cNMf538xUCcWjw==
X-Gm-Gg: AeBDieuYRe4jOVPjA08kd+F8dg3D8s5XefQp3tnCgkP0/8233IvWOP8l6OtYPopoaf3
 crRj/XVTK1pDSsiPvNCDB08capaPlqslksTdrWQ7eBR2XAhff1x3Q2siD/ruZzQuxGaywjeeCPi
 +EQ4SlQBOqcKQPPxDu9vmb01/bwk+q3iFykxlt6aUV4uvBRuZm5w+dMZORI3lpJ18L28OooWyDQ
 6q4oso3WtSpsbLNsIbdP8Oa+HF3YiGraWdwjQuyWXgMELj3epyRazoBZcgGR5YeIy8lHZ9N7UhF
 jQkOMCVxks6OwF4apXNsoFqZC4bZTw2wiqQsUUueFqd2Ciap
X-Received: by 2002:a17:907:a60b:b0:ba0:fd75:9c58 with SMTP id
 a640c23a62f3a-ba41b3e1284mr1896343266b.32.1777292114196; Mon, 27 Apr 2026
 05:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260427105531.75701-1-benno.fuenfstueck@neodyme.io>
 <CAJ+F1CLjdAvjvCe9m5uQ9-gcL7iq-eJ0hamp5A3tm2D-kG_wzA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLjdAvjvCe9m5uQ9-gcL7iq-eJ0hamp5A3tm2D-kG_wzA@mail.gmail.com>
From: =?UTF-8?B?QmVubm8gRsO8bmZzdMO8Y2s=?= <benno.fuenfstueck@neodyme.io>
Date: Mon, 27 Apr 2026 14:15:02 +0200
X-Gm-Features: AQROBzAfkGur2zBnMNJbSllLmHEwOEXVI2oaO0SMyOdwVCcug323xGNYWYn_GVs
Message-ID: <CAP-XHHCbnfOUtJmZs9H6pLNnL0ieW4c7m+6GeemojaAFEmbAOA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: multipart/alternative; boundary="00000000000021144f065070114f"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=benno.fuenfstueck@neodyme.io; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MXG_EMAIL_FRAG=0.099, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000021144f065070114f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 at 13:28, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com>
wrote:

>
> In v1, Akihiko raised a valid concern that this might be backported
> and fixed in earlier version of virgl:
>
> https://patchew.org/QEMU/20260409144639.3610-1-benno.fuenfstueck@neodyme.=
io/#40fb4df5-20a7-49ce-a087-d9c048255d05@rsg.ci.i.u-tokyo.ac.jp
>
>
That's a valid point, then feel free to just ignore the patch.


> > ---
> > Now with a version check, since the fix for this is in virlglrenderer
> master so I think it is any version newer than the current one (which is
> 1.3.0).
> > I copied the code from virtio-gpu-virgl.c for the version check for
> simplicty, if I should instead move that code for some DRY feel free to s=
ay
> so.
> >
> >  hw/display/virtio-gpu-gl.c | 45 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> > index 2b7a41c466..6505a84f5e 100644
> > --- a/hw/display/virtio-gpu-gl.c
> > +++ b/hw/display/virtio-gpu-gl.c
> > @@ -26,6 +26,25 @@
> >
> >  #include <virglrenderer.h>
> >
> > +/*
> > + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was
> fixed
> > + * in 1.1.0. Undefine bugged version of the macro and provide our own.
> > + */
> > +#if defined(VIRGL_CHECK_VERSION) && \
> > +    VIRGL_VERSION_MAJOR =3D=3D 1 && VIRGL_VERSION_MINOR < 1
> > +#undef VIRGL_CHECK_VERSION
> > +#endif
> > +
> > +#ifndef VIRGL_CHECK_VERSION
> > +#define VIRGL_CHECK_VERSION(major, minor, micro) \
> > +    (VIRGL_VERSION_MAJOR > (major) || \
> > +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR > (mino=
r) ||
> \
> > +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR =3D=3D =
(minor)
> && \
> > +     VIRGL_VERSION_MICRO >=3D (micro))
> > +#endif
> > +
> > +#define VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX (!VIRGL_CHECK_VERSION(1, 3, 1=
))
> > +
> >  static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
> >                                               struct virtio_gpu_scanout
> *s,
> >                                               uint32_t resource_id)
> > @@ -33,6 +52,11 @@ static void
> virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
> >      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> >      uint32_t width, height;
> >      uint32_t pixels, *data;
> > +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> > +    bool y_0_top =3D true;
> > +    int ret;
> > +    struct virgl_renderer_resource_info info;
> > +#endif
> >
> >      if (gl->renderer_state !=3D RS_INITED) {
> >          return;
> > @@ -49,8 +73,29 @@ static void
> virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
> >          return;
> >      }
> >
> > +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> > +    memset(&info, 0, sizeof(info));
> > +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
> > +    if (ret =3D=3D 0) {
> > +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> > +    }
> > +#endif
> > +
> >      pixels =3D s->current_cursor->width * s->current_cursor->height;
> > +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> > +    if (y_0_top) {
> > +        memcpy(s->current_cursor->data, data, pixels *
> sizeof(uint32_t));
> > +    } else {
> > +        uint32_t *dst =3D s->current_cursor->data;
> > +        for (uint32_t y =3D 0; y < height; y++) {
> > +            memcpy(dst + y * width,
> > +                   data + (height - 1 - y) * width,
> > +                   width * sizeof(uint32_t));
> > +        }
> > +    }
> > +#else
> >      memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
> > +#endif
> >      free(data);
> >  }
> >
> > --
> > 2.51.2
> >
> >
> > --
> > Neodyme AG
> > Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |
> > 85748 Garching b.M=C3=BCnchen
> > Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119
> > Berlin
> >
> > Registergericht / Registry court: M=C3=BCnchen, HRB 269168
> > Vorstand /
> > Management Board: Thomas Lambertz | Tobias Madl
> > Aufsichtsratsvorsitzender /
> > Chairman of the Supervisory Board: Hendrik Hofstadt
> >
> >
> >
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>

--=20
Neodyme AG
Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |=C2=A0
85748 Garching b.M=C3=BCnchen
Postanschrift:=C2=A0=E2=80=8BRosenthaler Stra=C3=9Fe 72a |=C2=A0=E2=80=8B10=
119=20
Berlin

Registergericht / Registry court: M=C3=BCnchen, HRB 269168
Vorstand /=20
Management Board: Thomas Lambertz | Tobias Madl
Aufsichtsratsvorsitzender /=20
Chairman of the Supervisory Board: Hendrik Hofstadt





--00000000000021144f065070114f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 27 Apr =
2026 at 13:28, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
In v1, Akihiko raised a valid concern that this might be backported<br>
and fixed in earlier version of virgl:<br>
<a href=3D"https://patchew.org/QEMU/20260409144639.3610-1-benno.fuenfstueck=
@neodyme.io/#40fb4df5-20a7-49ce-a087-d9c048255d05@rsg.ci.i.u-tokyo.ac.jp" r=
el=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/20260409144639=
.3610-1-benno.fuenfstueck@neodyme.io/#40fb4df5-20a7-49ce-a087-d9c048255d05@=
rsg.ci.i.u-tokyo.ac.jp</a><br><br></blockquote><div><br></div><div>That&#39=
;s a valid point, then feel free to just ignore the patch.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt; Now with a version check, since the fix for this is in virlglrenderer =
master so I think it is any version newer than the current one (which is 1.=
3.0).<br>
&gt; I copied the code from virtio-gpu-virgl.c for the version check for si=
mplicty, if I should instead move that code for some DRY feel free to say s=
o.<br>
&gt;<br>
&gt;=C2=A0 hw/display/virtio-gpu-gl.c | 45 ++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 45 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c<b=
r>
&gt; index 2b7a41c466..6505a84f5e 100644<br>
&gt; --- a/hw/display/virtio-gpu-gl.c<br>
&gt; +++ b/hw/display/virtio-gpu-gl.c<br>
&gt; @@ -26,6 +26,25 @@<br>
&gt;<br>
&gt;=C2=A0 #include &lt;virglrenderer.h&gt;<br>
&gt;<br>
&gt; +/*<br>
&gt; + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was=
 fixed<br>
&gt; + * in 1.1.0. Undefine bugged version of the macro and provide our own=
.<br>
&gt; + */<br>
&gt; +#if defined(VIRGL_CHECK_VERSION) &amp;&amp; \<br>
&gt; +=C2=A0 =C2=A0 VIRGL_VERSION_MAJOR =3D=3D 1 &amp;&amp; VIRGL_VERSION_M=
INOR &lt; 1<br>
&gt; +#undef VIRGL_CHECK_VERSION<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#ifndef VIRGL_CHECK_VERSION<br>
&gt; +#define VIRGL_CHECK_VERSION(major, minor, micro) \<br>
&gt; +=C2=A0 =C2=A0 (VIRGL_VERSION_MAJOR &gt; (major) || \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0VIRGL_VERSION_MAJOR =3D=3D (major) &amp;&amp; VIR=
GL_VERSION_MINOR &gt; (minor) || \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0VIRGL_VERSION_MAJOR =3D=3D (major) &amp;&amp; VIR=
GL_VERSION_MINOR =3D=3D (minor) &amp;&amp; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0VIRGL_VERSION_MICRO &gt;=3D (micro))<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#define VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX (!VIRGL_CHECK_VERSION(1, 3, =
1))<br>
&gt; +<br>
&gt;=C2=A0 static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint32_t resource_id)<br>
&gt; @@ -33,6 +52,11 @@ static void virtio_gpu_gl_update_cursor_data(VirtIO=
GPU *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t width, height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t pixels, *data;<br>
&gt; +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX<br>
&gt; +=C2=A0 =C2=A0 bool y_0_top =3D true;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 struct virgl_renderer_resource_info info;<br>
&gt; +#endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (gl-&gt;renderer_state !=3D RS_INITED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -49,8 +73,29 @@ static void virtio_gpu_gl_update_cursor_data(VirtIO=
GPU *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;info, 0, sizeof(info));<br>
&gt; +=C2=A0 =C2=A0 ret =3D virgl_renderer_resource_get_info(resource_id, &=
amp;info);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 y_0_top =3D info.flags &amp; VIRTIO_GPU_R=
ESOURCE_FLAG_Y_0_TOP;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pixels =3D s-&gt;current_cursor-&gt;width * s-&gt;=
current_cursor-&gt;height;<br>
&gt; +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX<br>
&gt; +=C2=A0 =C2=A0 if (y_0_top) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(s-&gt;current_cursor-&gt;data, dat=
a, pixels * sizeof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *dst =3D s-&gt;current_cursor-&g=
t;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (uint32_t y =3D 0; y &lt; height; y++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(dst + y * width,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
data + (height - 1 - y) * width,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
width * sizeof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memcpy(s-&gt;current_cursor-&gt;data, data, pixels=
 * sizeof(uint32_t));<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 free(data);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; --<br>
&gt; 2.51.2<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Neodyme AG<br>
&gt; Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |<br>
&gt; 85748 Garching b.M=C3=BCnchen<br>
&gt; Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119<br>
&gt; Berlin<br>
&gt;<br>
&gt; Registergericht / Registry court: M=C3=BCnchen, HRB 269168<br>
&gt; Vorstand /<br>
&gt; Management Board: Thomas Lambertz | Tobias Madl<br>
&gt; Aufsichtsratsvorsitzender /<br>
&gt; Chairman of the Supervisory Board: Hendrik Hofstadt<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div></div>

<br>
<font face=3D"Arial" style=3D"background-color:white" color=3D"#808080" siz=
e=3D"2">Neodyme AG</font><div><font color=3D"#808080" face=3D"Arial" size=
=3D"2"><br></font><div><div><font face=3D"Arial" size=3D"2"><span style=3D"=
color:rgb(128,128,128);text-align:center">Sitz der Gesellschaft / Address: =
Dirnismaning 55 | Halle 13 |</span><span style=3D"color:rgb(128,128,128);te=
xt-align:center">=C2=A0</span><span style=3D"color:rgb(128,128,128);text-al=
ign:center">85748 Garching b.M=C3=BCnchen</span></font></div><div><font fac=
e=3D"Arial" size=3D"2"><font color=3D"#808080"><span style=3D"text-align:ce=
nter">Postanschrift:=C2=A0</span>=E2=80=8BRosenthaler Stra=C3=9Fe 72a |=C2=
=A0=E2=80=8B10119 Berlin</font><span style=3D"color:rgb(128,128,128);text-a=
lign:center"><br></span></font></div><div><span style=3D"color:rgb(128,128,=
128);text-align:center"><font face=3D"Arial" size=3D"2">Registergericht / R=
egistry court: M=C3=BCnchen, HRB 269168</font></span></div><div><div><div><=
font face=3D"Arial" style=3D"background-color:white" color=3D"#808080" size=
=3D"2">Vorstand / Management Board: Thomas Lambertz | Tobias Madl</font></d=
iv><div><font face=3D"Arial" size=3D"2"><font color=3D"#808080">Aufsichtsra=
tsvorsitzender / Chairman of the Supervisory Board</font><span style=3D"col=
or:rgb(128,128,128)">: Hendrik Hofstadt</span></font></div></div></div></di=
v></div>
--00000000000021144f065070114f--

