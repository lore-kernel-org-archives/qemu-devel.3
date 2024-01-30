Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7DEC47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 01:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcuJ-0001zH-Gu; Mon, 29 Jan 2024 20:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rUcuB-0001xu-Ip
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 20:27:15 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rUcu6-0001UT-Hs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 20:27:14 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so391702566b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 17:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1706578017; x=1707182817; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mud5F01IUVyyaB3M7CysiT6Pol/s2BAtLhbMzXFilTQ=;
 b=i1EANysr9UvBGNQLCdu+PPyvPak2X7C3Z//J8QwvZv57CKQYikosA7a6OOpwn35Qq6
 LGX8SPI1/IZ0Eb7akOa+EJ16+849ziqV98MFpBsDNYUgdbY+kEpT9Giut4g6NSucX3hK
 PGhwt5tFMhnM/Vv0wA3bnq1SUAPCGHOwPxPD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706578017; x=1707182817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mud5F01IUVyyaB3M7CysiT6Pol/s2BAtLhbMzXFilTQ=;
 b=xF478w5IoVLwqgIXS0CF0n37yYPQj/AXCD0ERyO/9j9FuLv/dI1IftLq0SyTuprh3i
 lVV+E57OCB3OpytwrsAiJS+k37QaSP6bx0TThxWmVQ/enSvm3I8NPe7I6Wetrk9kz7/X
 0eugT+WZKHPmtcGYo7EARlPMJajA7qVC+tf9UmytmdFt6Td98W1I7nE+/FzvUTy7RWQG
 irFq43IJYo7h16Dv/n7X39KOS/DTrr34DaaGhzwjQG+7gZrgBGKcbI5yLyRzM9CHnoko
 TvB4/j4N+NJGJKt7V7l/tcDIS/IytliLLbwn0ycQlaXGpbKrpLkB9l72YuvPRENo1WZA
 lbvg==
X-Gm-Message-State: AOJu0YzaWjdm51I+H6QzxN8zKIDT88P9E3lZ0rBC6AJfqUpjtzaJAXW+
 1G8TwFSvMVgWzHjlmTnKQLgIoZphFkFuTD3+Z1v7hnMNNDsYIMC6zI/cprKFBvUb7XXMCCIxzCg
 8iA==
X-Google-Smtp-Source: AGHT+IFJ3vudVANuCfhhx8ZH44vvsvWBgNnEa2SlBnFCWabEGG1ephlDprgp62dEdCUUEzZFT/Q33Q==
X-Received: by 2002:a17:906:134b:b0:a32:42a0:6ed with SMTP id
 x11-20020a170906134b00b00a3242a006edmr5363273ejb.37.1706578017323; 
 Mon, 29 Jan 2024 17:26:57 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 hu19-20020a170907a09300b00a31c5caa750sm3695228ejc.177.2024.01.29.17.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 17:26:56 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-55818b7053eso7019a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 17:26:56 -0800 (PST)
X-Received: by 2002:a05:6402:288a:b0:55d:2dda:f331 with SMTP id
 eg10-20020a056402288a00b0055d2ddaf331mr49263edb.7.1706578016581; Mon, 29 Jan
 2024 17:26:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
 <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <926db899bebc1f9ca575bfd29d140f7658050a82.1706542958.git.manos.pitsidianakis@linaro.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 29 Jan 2024 17:26:43 -0800
X-Gmail-Original-Message-ID: <CAAfnVBk1jsOxvOd0k2otPOEz65v5ngN4E98LMHhTr5Vtc2fOcQ@mail.gmail.com>
Message-ID: <CAAfnVBk1jsOxvOd0k2otPOEz65v5ngN4E98LMHhTr5Vtc2fOcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alyssa Ross <hi@alyssa.is>
Content-Type: multipart/alternative; boundary="000000000000767be206101fa849"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--000000000000767be206101fa849
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 7:46=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> When the Rutabaga GPU device frees resources, it calls
> rutabaga_resource_unref for that resource_id. However, when the generic
> VirtIOGPU functions destroys resources, it only removes the
> virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
> The rutabaga resource associated with that resource_id is then leaked.
>
> This commit overrides the resource_destroy class method introduced in
> the previous commit to fix this.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> index 9e67f9bd51..6ac0776005 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>  }
>
>  static void
> +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *re=
s,
> +                                   Error **errp)
> +{
> +    int32_t result;
> +    const char *strerror =3D NULL;
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    result =3D rutabaga_resource_unref(vr->rutabaga, res->resource_id);
> +    if (result) {
> +        error_setg(errp, "%s: rutabaga_resource_unref returned %"PRIi32
> +                   " for resource_id =3D %"PRIu32, __func__, result,
> +                   res->resource_id);
> +        strerror =3D strerrorname_np((int)result);
> +        if (strerror !=3D NULL) {
> +            error_append_hint(errp, "%s: %s\n",
> +                              strerror, strerrordesc_np((int)result) ? :
> "");
> +        }
>

Can't we rely on virtio_gpu_rutabaga_debug_cb(..) to report an error when
the resource ID is not found?



> +    }
> +
> +    if (res->image) {
> +        pixman_image_unref(res->image);
> +    }
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    g_free(res);
> +}
> +
> +static void
>  rutabaga_cmd_resource_unref(VirtIOGPU *g,
>                              struct virtio_gpu_ctrl_command *cmd)
>  {
> -    int32_t result;
> +    int32_t result =3D 0;
>      struct virtio_gpu_simple_resource *res;
>      struct virtio_gpu_resource_unref unref;
> -
> -    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +    Error *local_err =3D NULL;
>
>      VIRTIO_GPU_FILL_CMD(unref);
>
> @@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
>      res =3D virtio_gpu_find_resource(g, unref.resource_id);
>      CHECK(res, cmd);
>
> -    result =3D rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
> -    CHECK(!result, cmd);
> -
> -    if (res->image) {
> -        pixman_image_unref(res->image);
> +    virtio_gpu_rutabaga_resource_unref(g, res, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        /* local_err was freed, do not reuse it. */
> +        local_err =3D NULL;
> +        result =3D 1;
>      }
> -
> -    QTAILQ_REMOVE(&g->reslist, res, next);
> -    g_free(res);
> +    CHECK(!result, cmd);
>  }
>
>  static void
> @@ -1099,7 +1126,7 @@ static void
> virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
>      vgc->handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl;
>      vgc->process_cmd =3D virtio_gpu_rutabaga_process_cmd;
>      vgc->update_cursor_data =3D virtio_gpu_rutabaga_update_cursor;
> -
> +    vgc->resource_destroy =3D virtio_gpu_rutabaga_resource_unref;
>      vdc->realize =3D virtio_gpu_rutabaga_realize;
>      device_class_set_props(dc, virtio_gpu_rutabaga_properties);
>  }
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

--000000000000767be206101fa849
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 29, 2024 at 7:46=E2=80=AF=
AM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org=
">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">When the Rutabaga GPU device frees resourc=
es, it calls<br>
rutabaga_resource_unref for that resource_id. However, when the generic<br>
VirtIOGPU functions destroys resources, it only removes the<br>
virtio_gpu_simple_resource from the device&#39;s VirtIOGPU-&gt;reslist list=
.<br>
The rutabaga resource associated with that resource_id is then leaked.<br>
<br>
This commit overrides the resource_destroy class method introduced in<br>
the previous commit to fix this.<br>
<br>
Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianaki=
s@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-rutabaga.c | 51 ++++++++++++++++++++++++-------=
-<br>
=C2=A01 file changed, 39 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutab=
aga.c<br>
index 9e67f9bd51..6ac0776005 100644<br>
--- a/hw/display/virtio-gpu-rutabaga.c<br>
+++ b/hw/display/virtio-gpu-rutabaga.c<br>
@@ -148,14 +148,42 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
+virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simpl=
e_resource *res,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 const char *strerror =3D NULL;<br>
+=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(vr-&gt;rutabaga, res-&gt;=
resource_id);<br>
+=C2=A0 =C2=A0 if (result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s: rutabaga_resource_u=
nref returned %&quot;PRIi32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; for resource_id =3D %&quot;PRIu32, __func__, result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res-&=
gt;resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror =3D strerrorname_np((int)result);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strerror !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_append_hint(errp, &quot;%s=
: %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror, strerrordesc_np((int)result) ? : =
&quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Can&#39;=
t we rely on=C2=A0virtio_gpu_rutabaga_debug_cb(..) to report an error when =
the resource ID is not found?</div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (res-&gt;image) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(res-&gt;image);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, res, next);<br>
+=C2=A0 =C2=A0 g_free(res);<br>
+}<br>
+<br>
+static void<br>
=C2=A0rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int32_t result;<br>
+=C2=A0 =C2=A0 int32_t result =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *res;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_resource_unref unref;<br>
-<br>
-=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FILL_CMD(unref);<br>
<br>
@@ -164,15 +192,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0res =3D virtio_gpu_find_resource(g, unref.resource_id);=
<br>
=C2=A0 =C2=A0 =C2=A0CHECK(res, cmd);<br>
<br>
-=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(vr-&gt;rutabaga, unref.re=
source_id);<br>
-=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
-<br>
-=C2=A0 =C2=A0 if (res-&gt;image) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(res-&gt;image);<br>
+=C2=A0 =C2=A0 virtio_gpu_rutabaga_resource_unref(g, res, &amp;local_err);<=
br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* local_err was freed, do not reuse it. */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, res, next);<br>
-=C2=A0 =C2=A0 g_free(res);<br>
+=C2=A0 =C2=A0 CHECK(!result, cmd);<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
@@ -1099,7 +1126,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClas=
s *klass, void *data)<br>
=C2=A0 =C2=A0 =C2=A0vgc-&gt;handle_ctrl =3D virtio_gpu_rutabaga_handle_ctrl=
;<br>
=C2=A0 =C2=A0 =C2=A0vgc-&gt;process_cmd =3D virtio_gpu_rutabaga_process_cmd=
;<br>
=C2=A0 =C2=A0 =C2=A0vgc-&gt;update_cursor_data =3D virtio_gpu_rutabaga_upda=
te_cursor;<br>
-<br>
+=C2=A0 =C2=A0 vgc-&gt;resource_destroy =3D virtio_gpu_rutabaga_resource_un=
ref;<br>
=C2=A0 =C2=A0 =C2=A0vdc-&gt;realize =3D virtio_gpu_rutabaga_realize;<br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, virtio_gpu_rutabaga_properti=
es);<br>
=C2=A0}<br>
-- <br>
=CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=CE=
=B8=CE=AE=CF=84=CF=89<br>
<br>
</blockquote></div></div>

--000000000000767be206101fa849--

