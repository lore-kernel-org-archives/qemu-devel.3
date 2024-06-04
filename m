Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7964C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEV2l-0001xO-QE; Tue, 04 Jun 2024 10:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEV2f-0001vh-Nx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:21:42 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEV2d-0007vk-Mz
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:21:37 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-794ab4480beso402927685a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717510894; x=1718115694; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N22WDqBJ0QQ2Czr+hskpBniQJcziJpbnfcQwyieXbjo=;
 b=HYP9/SyOHGgBCrOTqHWb85R3NfO1z2/YWBa6rfZT2ejUibldSCZb0Xt27Re/tvmEcD
 KTYeyZF7vbGfNx7jj/g3HMyuMHUIpOwhLxYYqsGIdwwUSY45/xAarAcehulaP6TsC6A6
 xDFXJIAC8AbrlIPLqYOVOmYX0uHdX9IBW9dW14Fmleh+OZ46Qv6qs7GSyuSSoA4oUw22
 NsOJ22JaHQ4WvJ8Fr/dC46/J6YSqfzPXykGRtOhPs+Jgm/1tzxC5uTibZMZ+xMS3k/gL
 rQjDHXQ4syH2YUlUuBPdySjAzElD398W0rJXrT8sCX5d57e32LzGF2lVwJSA0Ce3F8tw
 4tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510894; x=1718115694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N22WDqBJ0QQ2Czr+hskpBniQJcziJpbnfcQwyieXbjo=;
 b=iNL+wWmAmrglHBHCE14rMgdTBsAg2BcO7JH9zxSKBtCVeqTFvVMG2YOEULpjweggCh
 VJIy/3S6uaQGTHioQ1MTbxDkxSm1oN45gEXOpg2rBLCstQIfi5ExT3pGrVzCi9gTi9Ys
 7KeW21aEhWguwMQWcKa4iu9HyieMw30D4XnhIrYBtP7a7GQOE1wN0lsfpgxbVsI09Ujv
 f9ICS1zzf5mPIxGOgY1gdbepOht1hJj3w+5aTFcMV36g1xFWEmh/AOOVyColLTk0QJyx
 jh+QMPFBRAM/Hkh8XKXudaQEqw0myeuvgp5ecd11uyfxys57bSpd3UyQdm6OkRG0pJAw
 yGhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYC25Qne664w0cD7uuRK+Hi1CaZDkUfSgbcAbRUU0Pl194CUIBanJ6GyPywoRPPEUVV+rtBS+sTLC7ozUADybK/31j1cg=
X-Gm-Message-State: AOJu0YwdAb5AUPuJROWBNgIWWAQ32J6RZm/B1lLNCSiVFFmG67d0+qli
 F0dg0cuTvh8a8+Dwa+HQbkaDjrxGzu04nqnEZdDPpILElAYVRyNmeTApCzDp4YBIsHx8yJl9rGt
 jAEE13s1NKgV2PWcbaf0l7Y6Ljp0=
X-Google-Smtp-Source: AGHT+IHFqbtIG/iMjc7jAmsZL+9l0rMoAFpkMGpusDKXA6J7k3NKp/vQ4gSAyThI0keJdT4TLg7+itdHsNiVmhTsDm8=
X-Received: by 2002:a05:620a:191e:b0:794:8226:7104 with SMTP id
 af79cd13be357-794f5c669e3mr1571664385a.9.1717510894308; Tue, 04 Jun 2024
 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20240527030233.3775514-4-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 18:21:21 +0400
Message-ID: <CAJ+F1CLW3fSE+UVwqXepwipJrK77EJfSqvepFXZUwecNdwmTwQ@mail.gmail.com>
Subject: Re: [PATCH v13 03/13] virtio-gpu: Handle virtio_gpu_virgl_init()
 failure
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000c0d796061a112a56"
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c0d796061a112a56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 27, 2024 at 7:03=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> virtio_gpu_virgl_init() may fail, leading to a further Qemu crash
> because Qemu assumes it never fails. Check virtio_gpu_virgl_init()
> return code and don't execute virtio commands on error. Failed
> virtio_gpu_virgl_init() will result in a timed out virtio commands
> for a guest OS.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 29 +++++++++++++++++++++--------
>  include/hw/virtio/virtio-gpu.h | 11 +++++++++--
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfbfc..38a2b1bd3916 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -29,9 +29,14 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU
> *g,
>                                               struct virtio_gpu_scanout *=
s,
>                                               uint32_t resource_id)
>  {
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      uint32_t width, height;
>      uint32_t pixels, *data;
>
> +    if (gl->renderer_state !=3D RS_INITED) {
> +        return;
> +    }
> +
>      data =3D virgl_renderer_get_cursor_data(resource_id, &width, &height=
);
>      if (!data) {
>          return;
> @@ -65,13 +70,21 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice
> *vdev, VirtQueue *vq)
>          return;
>      }
>
> -    if (!gl->renderer_inited) {
> -        virtio_gpu_virgl_init(g);
> -        gl->renderer_inited =3D true;
> -    }
> -    if (gl->renderer_reset) {
> -        gl->renderer_reset =3D false;
> +    switch (gl->renderer_state) {
> +    case RS_RESET:
>          virtio_gpu_virgl_reset(g);
> +        /* fallthrough */
> +    case RS_START:
> +        if (virtio_gpu_virgl_init(g)) {
> +            gl->renderer_state =3D RS_INIT_FAILED;
> +        } else {
> +            gl->renderer_state =3D RS_INITED;
> +        }
> +        break;
> +    case RS_INIT_FAILED:
> +        return;
> +    case RS_INITED:
> +        break;
>      }
>
>
This still lets it go through the cmd processing after setting
gl->renderer_state =3D RS_INIT_FAILED, the first time.


>      cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> @@ -98,9 +111,9 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>       * GL functions must be called with the associated GL context in mai=
n
>       * thread, and when the renderer is unblocked.
>       */
> -    if (gl->renderer_inited && !gl->renderer_reset) {
> +    if (gl->renderer_state =3D=3D RS_INITED) {
>          virtio_gpu_virgl_reset_scanout(g);
> -        gl->renderer_reset =3D true;
> +        gl->renderer_state =3D RS_RESET;
>      }
>  }
>
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index 7ff989a45a5c..6e71d799e5da 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -224,11 +224,18 @@ struct VirtIOGPUClass {
>                               Error **errp);
>  };
>
> +/* VirtIOGPUGL renderer states */
> +typedef enum {
> +    RS_START,       /* starting state */
> +    RS_INIT_FAILED, /* failed initialisation */
> +    RS_INITED,      /* initialised and working */
> +    RS_RESET,       /* inited and reset pending, moves to start after
> reset */
> +} RenderState;
> +
>  struct VirtIOGPUGL {
>      struct VirtIOGPU parent_obj;
>
> -    bool renderer_inited;
> -    bool renderer_reset;
> +    RenderState renderer_state;
>
>      QEMUTimer *fence_poll;
>      QEMUTimer *print_stats;
> --
> 2.44.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c0d796061a112a56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at 7:03=E2=80=
=AFAM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">=
dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">virtio_gpu_virgl_init() may fail, leading to a=
 further Qemu crash<br>
because Qemu assumes it never fails. Check virtio_gpu_virgl_init()<br>
return code and don&#39;t execute virtio commands on error. Failed<br>
virtio_gpu_virgl_init() will result in a timed out virtio commands<br>
for a guest OS.<br>
<br>
Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collab=
ora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-gl.c=C2=A0 =C2=A0 =C2=A0| 29 ++++++++++++++++++=
+++--------<br>
=C2=A0include/hw/virtio/virtio-gpu.h | 11 +++++++++--<br>
=C2=A02 files changed, 30 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c<br>
index e06be60dfbfc..38a2b1bd3916 100644<br>
--- a/hw/display/virtio-gpu-gl.c<br>
+++ b/hw/display/virtio-gpu-gl.c<br>
@@ -29,9 +29,14 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *=
g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct virtio_gpu_scanout *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t resource_id)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t width, height;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t pixels, *data;<br>
<br>
+=C2=A0 =C2=A0 if (gl-&gt;renderer_state !=3D RS_INITED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0data =3D virgl_renderer_get_cursor_data(resource_id, &a=
mp;width, &amp;height);<br>
=C2=A0 =C2=A0 =C2=A0if (!data) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -65,13 +70,21 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vde=
v, VirtQueue *vq)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!gl-&gt;renderer_inited) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_virgl_init(g);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_inited =3D true;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (gl-&gt;renderer_reset) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_reset =3D false;<br>
+=C2=A0 =C2=A0 switch (gl-&gt;renderer_state) {<br>
+=C2=A0 =C2=A0 case RS_RESET:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_virgl_reset(g);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>
+=C2=A0 =C2=A0 case RS_START:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_gpu_virgl_init(g)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_state =3D RS_INI=
T_FAILED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_state =3D RS_INI=
TED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RS_INIT_FAILED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 case RS_INITED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br></blockquote><div><br></div><div>This still lets it go through the cmd =
processing after setting gl-&gt;renderer_state =3D RS_INIT_FAILED, the firs=
t time.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0 =C2=A0 =C2=A0cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl=
_command));<br>
@@ -98,9 +111,9 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)<br>
=C2=A0 =C2=A0 =C2=A0 * GL functions must be called with the associated GL c=
ontext in main<br>
=C2=A0 =C2=A0 =C2=A0 * thread, and when the renderer is unblocked.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (gl-&gt;renderer_inited &amp;&amp; !gl-&gt;renderer_reset=
) {<br>
+=C2=A0 =C2=A0 if (gl-&gt;renderer_state =3D=3D RS_INITED) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_virgl_reset_scanout(g);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_reset =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_state =3D RS_RESET;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.=
h<br>
index 7ff989a45a5c..6e71d799e5da 100644<br>
--- a/include/hw/virtio/virtio-gpu.h<br>
+++ b/include/hw/virtio/virtio-gpu.h<br>
@@ -224,11 +224,18 @@ struct VirtIOGPUClass {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
=C2=A0};<br>
<br>
+/* VirtIOGPUGL renderer states */<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 RS_START,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* starting state */<br>
+=C2=A0 =C2=A0 RS_INIT_FAILED, /* failed initialisation */<br>
+=C2=A0 =C2=A0 RS_INITED,=C2=A0 =C2=A0 =C2=A0 /* initialised and working */=
<br>
+=C2=A0 =C2=A0 RS_RESET,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* inited and reset pend=
ing, moves to start after reset */<br>
+} RenderState;<br>
+<br>
=C2=A0struct VirtIOGPUGL {<br>
=C2=A0 =C2=A0 =C2=A0struct VirtIOGPU parent_obj;<br>
<br>
-=C2=A0 =C2=A0 bool renderer_inited;<br>
-=C2=A0 =C2=A0 bool renderer_reset;<br>
+=C2=A0 =C2=A0 RenderState renderer_state;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *fence_poll;<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *print_stats;<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000c0d796061a112a56--

