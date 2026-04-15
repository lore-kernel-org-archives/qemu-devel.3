Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FECAF419A2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzsH-0000Ke-00; Wed, 15 Apr 2026 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wCzsA-0000KN-O1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:01:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wCzs8-0006pz-2I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:01:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso895512166b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776258092; cv=none;
 d=google.com; s=arc-20240605;
 b=dSi3gndIvT933Eq+H1WJ0Q/PO6nYm48nG/Zb+KKFxJmrZsblRZMJEJFKB7EVQZN/Zk
 ssHyDbytwIPBa5NtfDpmpR/899Sc1jE6ZNF1Tu5Kie/pw2P1g5euwVeR3qYtPi5XN5C4
 NJeRSEAStMgFiEm1JTACkT8/LDZSjQ92WEEOG6BpL4O7NqmieOb4oS9MJdxDB2U9Dx1k
 JOtze4iy6LYXk+52KjOktmxXLN9qgg+DbxPmhzvlJHzVCCKWTcdE6X9DCVhWI30oMFYv
 lINwp8kPG8wDRC+LQY5DUoELZMqRfA1YkZlPV1OnHT9plgMsbZFNqmT4JfQn53EaFGNq
 pp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9mvKZz9T7ZTKnjmqUudVYht/iKfNOKfvU2iWhDo9o6k=;
 fh=5DtwW8VDym1e0k1+6VgeguCLLQmQuHFGrQGNU3lyEOY=;
 b=OeWIysPIsO7+x0qrqBYi4aApbOk1sjaCvvbnwFpvEzvjYH4toKAETB7QnGB6AgEn71
 OjTRewqqL7So6MidGjywVandqAhVBBLs96EmXiichP+Wy+CCtd+zA0QE3HXXCw8r7Ws1
 RJgq+CUE6oBm05h0YqzTkWeqwi/4mDVRA/MrYRlGsfuv/8F89EeJxg+g1iDwYBtO9rqR
 nBMYLIIHUs6/mb1MasTBNNRn4CgUk+W70ARXsPbHKjo7vcWlgKIRM6pT6CzrdropyXed
 +j5uE7w57+W0ZIFlv2kyLVgukhnscWE7kqnwKVc8JH+t1HoTlgxO+QGpRYnvK8h0uT1D
 U/Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neodyme.io; s=google; t=1776258092; x=1776862892; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9mvKZz9T7ZTKnjmqUudVYht/iKfNOKfvU2iWhDo9o6k=;
 b=kVX9Tl25xZrYt/8u/R9Wrm+WHMdEn+1oQjM+bIlPvkMCaWaxoXECoC4IcA7EaWjojE
 C0uPyec+jhOIGiITJNDC4bh4SAcbMkAoK6Z/FO8URrfEmg7cHH541oGQOK2iBwiuoyUo
 hezK7dAWnqsPjSnDNo8emxwieOUAlJZQY4cpPzm6JsCWTyMCu2Xx2+6YJe3sdmDbSj+o
 3fK+RkPObvziILrGY9r6+LnDvOKOiNJjGzu9kGjDWce5XxR2rvjikf24vMepvq/K2P7v
 o7MSlNicaB7bv0qcy2q4c9S8qeVoVTeuL+StKkFyWhHKAEO9KjtzZzyqFQh7+p24n8+X
 Kn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258092; x=1776862892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mvKZz9T7ZTKnjmqUudVYht/iKfNOKfvU2iWhDo9o6k=;
 b=oGVtVAU4xVXs9POwxnvMNqHpf78ra2lO0JrAdQiHzaSYVwZPS5Z8u5pUYjTYmgoOqn
 8BB1sjUKcbOTozbF1uZOaAYujTPi+SlnGCJnBVlw8oSNDIvmtw8wpYHGqTnSpoWrQwHS
 MZT6VR3Y60wJmh1HbTrAemMgEl0f+YIzqSNemGOueXGqeVQkcNSjybmXjbb0KdalzjYG
 SESpdvmbq7vRIeLttAqcjzKRMgGyeqPnhGao60uzJtm2pvncAIOX7yA5Xjez0i5mN0Tw
 g039RzlaU2yar+PvllxQzTVI4a/bE0oFKHSgvEBJI4zGoPLzcxKJpg6GMTmdtVfNbICY
 lEMA==
X-Gm-Message-State: AOJu0Yzso/9Ucn9JGUIttQCA8HM8eNgkDUWv235lR0wy4RovTC+I1Kly
 jv27QKAMSaceZ29mZBsT7SlQCogA7Z+nOh4cIGFN8WDXC7mhs1Jn8dKNJWA5jxANbVKMUQhdoFo
 OCQLhS3+2QmOu6Hlnw7c+8lgYckk9rCMNRE835MQYl9AOyd5GjLoDRx1ZQksvjU4OGg4zGB9Zmm
 Mde3ZPwoy6KjQFGpPZu3x2Wm9cqw==
X-Gm-Gg: AeBDieslk9C92q6wM1RF+31O0DB2c66cEvYdUrnstRBzSGsHNTrB0dJ6bjIe8kYbzpX
 xE9fSWZMhr2/jTluyj9YGl/uoq/daPKwg0dAUsMorSxl1ziHFY5vpllK7z7I382fVb7UqnD8O53
 E2brxTWInVz4s1EqfrtKKH//bddYa/be/pzYTQmi2GHXYgY4Jig5vmiiqKzohZhZ86IsjgLUhmI
 3xgJMla4lRKNEh95baAZ/ueT59moAFXE6g2Lf+VzqON1t9g7wbk+rUJBcS0Sh+GdmwNEwZEOhyN
 K/fHZvqGxCtLYc4BscXPeXmVon/zUqRhe2yaVYgPTSIyKKrWeA==
X-Received: by 2002:a17:907:7b87:b0:b9d:c34f:2a2b with SMTP id
 a640c23a62f3a-b9dc34f39e6mr778052966b.40.1776258091966; Wed, 15 Apr 2026
 06:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
 <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
In-Reply-To: <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
From: =?UTF-8?B?QmVubm8gRsO8bmZzdMO8Y2s=?= <benno.fuenfstueck@neodyme.io>
Date: Wed, 15 Apr 2026 15:01:20 +0200
X-Gm-Features: AQROBzB0WO42TBaCVWjR6R9Y89Bp2bDPxPWZNapABDhfM4QmDExxEc1tmG6ZUI8
Message-ID: <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: multipart/alternative; boundary="00000000000099f587064f7f50d4"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=benno.fuenfstueck@neodyme.io; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000099f587064f7f50d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc-Andr=C3=A9,

On Mon, 13 Apr 2026 at 15:23, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com>
wrote:

> Arguably, this is a bug in virgl vrend_renderer_get_cursor_content(),
> since the function doesn't return y0_top it should always return the
> data in the correct orientation.
>
> We may have a temporary workaround in qemu though for older virgl, but
> I think it should be solved there too.
>

Thanks, I didn't know about this. I submitted a MR to virglrenderer now as
well to fix it there:
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1611

How should I change the patch to make it a temporary fix? Some kind of
version gate (but not sure yet in which version of virglrenderer the fix
will end up being release)?


>
> > ---
> >  hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> > index 2b7a41c466..4562d3405e 100644
> > --- a/hw/display/virtio-gpu-gl.c
> > +++ b/hw/display/virtio-gpu-gl.c
> > @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGP=
U
> *g,
> >      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> >      uint32_t width, height;
> >      uint32_t pixels, *data;
> > +    bool y_0_top =3D true;
> > +    int ret;
> > +    struct virgl_renderer_resource_info info;
> >
> >      if (gl->renderer_state !=3D RS_INITED) {
> >          return;
> > @@ -49,8 +52,23 @@ static void
> virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
> >          return;
> >      }
> >
> > +    memset(&info, 0, sizeof(info));
> > +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
> > +    if (ret =3D=3D 0) {
> > +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> > +    }
> > +
> >      pixels =3D s->current_cursor->width * s->current_cursor->height;
> > -    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
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
> >      free(data);
> >  }
> >
> > --
> > 2.50.1 (Apple Git-155)
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





--00000000000099f587064f7f50d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Marc-Andr=C3=A9,</div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 13 A=
pr 2026 at 15:23, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Arguably, this is a bug in virgl =
vrend_renderer_get_cursor_content(),<br>
since the function doesn&#39;t return y0_top it should always return the<br=
>
data in the correct orientation.<br>
<br>
We may have a temporary workaround in qemu though for older virgl, but<br>
I think it should be solved there too.<br></blockquote><div><br></div><div>=
Thanks, I didn&#39;t know about this. I submitted a MR to virglrenderer now=
 as well to fix it there:=C2=A0<a href=3D"https://gitlab.freedesktop.org/vi=
rgl/virglrenderer/-/merge_requests/1611">https://gitlab.freedesktop.org/vir=
gl/virglrenderer/-/merge_requests/1611</a><br><br></div><div>How should I c=
hange the patch to make it a temporary fix? Some kind of version gate (but =
not sure yet in which version of virglrenderer the fix will end up being re=
lease)?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c<b=
r>
&gt; index 2b7a41c466..4562d3405e 100644<br>
&gt; --- a/hw/display/virtio-gpu-gl.c<br>
&gt; +++ b/hw/display/virtio-gpu-gl.c<br>
&gt; @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOG=
PU *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t width, height;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t pixels, *data;<br>
&gt; +=C2=A0 =C2=A0 bool y_0_top =3D true;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 struct virgl_renderer_resource_info info;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (gl-&gt;renderer_state !=3D RS_INITED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIO=
GPU *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;info, 0, sizeof(info));<br>
&gt; +=C2=A0 =C2=A0 ret =3D virgl_renderer_resource_get_info(resource_id, &=
amp;info);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 y_0_top =3D info.flags &amp; VIRTIO_GPU_R=
ESOURCE_FLAG_Y_0_TOP;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pixels =3D s-&gt;current_cursor-&gt;width * s-&gt;=
current_cursor-&gt;height;<br>
&gt; -=C2=A0 =C2=A0 memcpy(s-&gt;current_cursor-&gt;data, data, pixels * si=
zeof(uint32_t));<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 free(data);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; --<br>
&gt; 2.50.1 (Apple Git-155)<br>
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
--00000000000099f587064f7f50d4--

