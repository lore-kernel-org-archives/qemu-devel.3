Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5B2C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV0zQ-0001RC-9k; Tue, 30 Jan 2024 22:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rV0zO-0001Qx-Tu
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:10:14 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rV0zM-0006jq-PQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:10:14 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a35385da5bbso617898266b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 19:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1706670610; x=1707275410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L51Os2kRdO8C6Jo9aOUVeiCkbwmHBHzSsSn/oaCKWMw=;
 b=cyP1YSDGBMfzLNAiEjENVfWDpUNpoL4/oVqkv4pYNHQ+AOTHIvAWFHiS8nTaQjcXM0
 VwdOKNHykPVmn2eM9TboW2/oWgM7sbYmAA2GpALXDg7fqq3J4eopyOGPDr8xlBjvHKvG
 F0/UtHVPlEDD79GDteH58dUxRqJgHogNNanys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706670610; x=1707275410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L51Os2kRdO8C6Jo9aOUVeiCkbwmHBHzSsSn/oaCKWMw=;
 b=Z6TNW7cWVWFkGwgOoiLPanDHSPBDoPAUaA0vfKyt7Jbr30INV3Pp2nObvQZASBXbvO
 fp7AgRjUXZlKArQwV3Fn4GLeZQp4zCifwY4Nhf7R+jieNDLCO4BGb4f0c7Lyzvt1PkVN
 BfhNkBu7zcEVzQI9qjWwU18ernGwUQu1yYiL5RkINjXp9xLIZ217urMTY/gr8/ZbSI19
 aSZZvTX/XWZmWTYDZTJU86fvcirX4+qHXqRnN1MDSRbSNuuZSE7vbve7sntb2qUBeL/q
 MQwQkfc1/tBSLC1w+fy02nNwLXwIdlSZh0I8jadW2brvUMVKblmT/Q/iEzyPXfZxYwjd
 9QXQ==
X-Gm-Message-State: AOJu0YxLvotzG9aqOWxkYTxxQq87n/Zu6/fWpEzS6FsUikWCMfbXHHEt
 7Ub9UMiV9gw9LYn+NGnDZuS8sWOobhLw091CCu7yC6anuD+o+o6nA6/GMlLOgd2Lgt0FZ1WMqoi
 olg==
X-Google-Smtp-Source: AGHT+IH+i1REv29zjmuKYpV52IQeIva/tyVPlb2E0ru3yDtw/tugRgwYhiLzGN6KWOdQQ+sKWcThGg==
X-Received: by 2002:a17:907:bb88:b0:a36:55d5:2364 with SMTP id
 xo8-20020a170907bb8800b00a3655d52364mr175072ejc.21.1706670609486; 
 Tue, 30 Jan 2024 19:10:09 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 sn24-20020a170906629800b00a35f05514a4sm2084797ejc.218.2024.01.30.19.10.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 19:10:09 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-55f85a2a43fso2172a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 19:10:08 -0800 (PST)
X-Received: by 2002:a05:6402:26d3:b0:55f:3fe8:b5e0 with SMTP id
 x19-20020a05640226d300b0055f3fe8b5e0mr363162edd.0.1706670608550; Tue, 30 Jan
 2024 19:10:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
 <e3778e44c98a35839de2f4938e5355449fa3aa14.1706626470.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <e3778e44c98a35839de2f4938e5355449fa3aa14.1706626470.git.manos.pitsidianakis@linaro.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 30 Jan 2024 19:09:56 -0800
X-Gmail-Original-Message-ID: <CAAfnVBkCv0BzbE4W5UPh9Y8U5iTzGEQ1m1Bdy8rgXOckzsuWsg@mail.gmail.com>
Message-ID: <CAAfnVBkCv0BzbE4W5UPh9Y8U5iTzGEQ1m1Bdy8rgXOckzsuWsg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] virtio-gpu-rutabaga.c: override resource_destroy
 method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005fd89c06103537fd"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

--0000000000005fd89c06103537fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:00=E2=80=AFAM Manos Pitsidianakis <
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

Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>


>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 47 ++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> index 9e67f9bd51..17bf701a21 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -148,14 +148,38 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>  }
>
>  static void
> +virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *re=
s,
> +                                   Error **errp)
> +{
> +    int32_t result;
> +    VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);
> +
> +    result =3D rutabaga_resource_unref(vr->rutabaga, res->resource_id);
> +    if (result) {
> +        error_setg_errno(errp,
> +                        (int)result,
> +                        "%s: rutabaga_resource_unref returned %"PRIi32
> +                        " for resource_id =3D %"PRIu32, __func__, result=
,
> +                        res->resource_id);
> +    }
> +
> +    if (res->image) {
> +        pixman_image_unref(res->image);
> +    }
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    g_free(res);
> +}

+
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
> @@ -164,15 +188,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
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
> @@ -1099,7 +1122,7 @@ static void
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

--0000000000005fd89c06103537fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 30, 2024 at 7:00=E2=80=AF=
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
the previous commit to fix this.<br></blockquote><div><br></div><div>Review=
ed-by: Gurchetan Singh &lt;<a href=3D"mailto:gurchetansingh@chromium.org">g=
urchetansingh@chromium.org</a>&gt;<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianaki=
s@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-rutabaga.c | 47 ++++++++++++++++++++++++-------=
-<br>
=C2=A01 file changed, 35 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutab=
aga.c<br>
index 9e67f9bd51..17bf701a21 100644<br>
--- a/hw/display/virtio-gpu-rutabaga.c<br>
+++ b/hw/display/virtio-gpu-rutabaga.c<br>
@@ -148,14 +148,38 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,<br>
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
+=C2=A0 =C2=A0 VirtIOGPURutabaga *vr =3D VIRTIO_GPU_RUTABAGA(g);<br>
+<br>
+=C2=A0 =C2=A0 result =3D rutabaga_resource_unref(vr-&gt;rutabaga, res-&gt;=
resource_id);<br>
+=C2=A0 =C2=A0 if (result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (int)result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;%s: rutabaga_resource_unref returned %&quot;PRIi32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; for resource_id =3D %&quot;PRIu32, __func__, result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 res-&gt;resource_id);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (res-&gt;image) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pixman_image_unref(res-&gt;image);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;g-&gt;reslist, res, next);<br>
+=C2=A0 =C2=A0 g_free(res);<br>
+}=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
@@ -164,15 +188,14 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,<br>
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
@@ -1099,7 +1122,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClas=
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

--0000000000005fd89c06103537fd--

