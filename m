Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF78C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4b6B-0007cl-6b; Wed, 08 May 2024 02:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4b60-0007VD-Rk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:48:10 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4b5y-00060I-Iu
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:48:08 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-deb5f006019so4388897276.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715150885; x=1715755685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXEzakz9agWZLxZAS5m6ejkd5LGG9Lru/YSwmamEslk=;
 b=aQu4DmkBEEdPMO4e5QHTWH+1RReIcXN0/jrQ57RK3t6yLg59meFUaZ2zye8QnRI/yJ
 JlUdZ2/bPlgW8DU7vdghBmSKu189NKBbMu2J0vERVS8G6hcqQmrpsXJJ1C8vw/MvdfTx
 PRAj+ReXDpIebTQoSjIWgRqpeVLDYgaU1HuTvoQLUyIbbfJNus4m0PaIcLKc5P5Ht1cp
 e1PrCmASTImdXHpQzDikcFm3puPvLJY9EA9pRwfy7QVwbST1Drp54H+UVsL1A0KBpX5S
 Gd+WA47rVfPbsv8j47smLinsoazkOvLoYXN94boot8CNpfybKVntj3WQb8nF/N5olq29
 N0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715150885; x=1715755685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXEzakz9agWZLxZAS5m6ejkd5LGG9Lru/YSwmamEslk=;
 b=KY8xFWFBYnsokFByg2ztrLsACYb6M4xeLwr4gUHwkVqA+8bGUwlkMD4uSBjV/j9Qyv
 T3xUb0407AwYWDsTTsRvYiIky1PaYpS/5l8nSzBYJKXjCNDk5FCJHTIUfgBnyWeKeFz7
 VNQGuoZb3WfUX8xa3a9R1SrvOJ421oPvFX5fRfaQg9HYiehf+5tAjbtkqw+9DUXJWCF7
 Y6HinVBxQWkt0CIsbLPoeMRZhhCTyBZgc8/H+fIMo9/JYb3i4dvRGcfpGEXHn2sLHbOx
 K/DqnAcjc7ogRpt8vJK9PjPKbk6uMpJtLn9jAYpThROxnO0blZNE5W4oywJi86UxKT4M
 8kRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz22Ed2xNcsZcuiFcKbb1+QzJErU3CBKc4KYZy5rUFH3QtPbOJLGsHsFb22vLH9sgm+riu7fvJjOevqKqMO0QQhJgIhdM=
X-Gm-Message-State: AOJu0Yyb/unXKTMBrTHe0XPMm9v3c24dmavBUFM0i0usm6wJWs7c9xe1
 3LUJhkZW1n3c7WETM3IO+C3s77eC/gMQmoMacPtz+VU2ZP+7RjvssGqpAbRTHxnhUnDp0JL2myq
 cupUGgvPvasUA6JhmklOJPmLwEBY=
X-Google-Smtp-Source: AGHT+IFoVn3T4fT1F9E+JaAWdBQYzNPqWDb2Dy9t5boKn8UL9kYv77OJkiKbVfZL/w6ZpxQXbMmQdwLBsbKpqw0w9As=
X-Received: by 2002:a25:8744:0:b0:deb:438a:43b7 with SMTP id
 3f1490d57ef6-debb9d4f594mr1935038276.34.1715150884657; Tue, 07 May 2024
 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-6-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 10:47:52 +0400
Message-ID: <CAJ+F1CL24kPf4_7QZJtN_DYRkfwu4RT2aj1fYJhzx6PZozEDOQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] virtio-gpu: Add virgl resource management
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb34.google.com
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

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> From: Huang Rui <ray.huang@amd.com>
>
> In a preparation to adding host blobs support to virtio-gpu, add virgl
> resource management that allows to retrieve resource based on its ID
> and virgl resource wrapper on top of simple resource that will be contain
> fields specific to virgl.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-virgl.c | 74 +++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 8306961ad502..a040324f5024 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -22,6 +22,23 @@
>
>  #include <virglrenderer.h>
>
> +struct virtio_gpu_virgl_resource {
> +    struct virtio_gpu_simple_resource base;
> +};
> +
> +static struct virtio_gpu_virgl_resource *
> +virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +
> +    res =3D virtio_gpu_find_resource(g, resource_id);
> +    if (!res) {
> +        return NULL;
> +    }
> +
> +    return container_of(res, struct virtio_gpu_virgl_resource, base);
> +}
> +
>  #if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
>  static void *
>  virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
> @@ -35,11 +52,34 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_2d c2d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_virgl_resource *res;
>
>      VIRTIO_GPU_FILL_CMD(c2d);
>      trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>                                         c2d.width, c2d.height);
>
> +    if (c2d.resource_id =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed=
\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res =3D virtio_gpu_virgl_find_resource(g, c2d.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n=
",
> +                      __func__, c2d.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res =3D g_new0(struct virtio_gpu_virgl_resource, 1);
> +    res->base.width =3D c2d.width;
> +    res->base.height =3D c2d.height;
> +    res->base.format =3D c2d.format;
> +    res->base.resource_id =3D c2d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
> +
>      args.handle =3D c2d.resource_id;
>      args.target =3D 2;
>      args.format =3D c2d.format;
> @@ -59,11 +99,34 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_3d c3d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virtio_gpu_virgl_resource *res;
>
>      VIRTIO_GPU_FILL_CMD(c3d);
>      trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>                                         c3d.width, c3d.height, c3d.depth)=
;
>
> +    if (c3d.resource_id =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed=
\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res =3D virtio_gpu_virgl_find_resource(g, c3d.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n=
",
> +                      __func__, c3d.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res =3D g_new0(struct virtio_gpu_virgl_resource, 1);
> +    res->base.width =3D c3d.width;
> +    res->base.height =3D c3d.height;
> +    res->base.format =3D c3d.format;
> +    res->base.resource_id =3D c3d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
> +
>      args.handle =3D c3d.resource_id;
>      args.target =3D c3d.target;
>      args.format =3D c3d.format;
> @@ -82,12 +145,19 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>                                       struct virtio_gpu_ctrl_command *cmd=
)
>  {
>      struct virtio_gpu_resource_unref unref;
> +    struct virtio_gpu_virgl_resource *res;
>      struct iovec *res_iovs =3D NULL;
>      int num_iovs =3D 0;
>
>      VIRTIO_GPU_FILL_CMD(unref);
>      trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>
> +    res =3D virtio_gpu_virgl_find_resource(g, unref.resource_id);
> +    if (!res) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
>      virgl_renderer_resource_detach_iov(unref.resource_id,
>                                         &res_iovs,
>                                         &num_iovs);
> @@ -95,6 +165,10 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>          virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
>      }
>      virgl_renderer_resource_unref(unref.resource_id);
> +
> +    QTAILQ_REMOVE(&g->reslist, &res->base, next);
> +
> +    g_free(res);
>  }
>
>  static void virgl_cmd_context_create(VirtIOGPU *g,
> --
> 2.44.0
>


--=20
Marc-Andr=C3=A9 Lureau

