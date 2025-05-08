Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C394C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzvA-0006jC-R6; Thu, 08 May 2025 08:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCzv8-0006cP-Bg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:00:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCzv6-0008Fd-4I
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:00:10 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so149382966b.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746705606; x=1747310406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOidC1G0JuJvmtz0itHhsdjrFQZ/G/6LXn6/7CbSSyY=;
 b=BYIi9gfH8+VsvZSJk84+4HdopezufoQ+3sAHhmEEvs8INbAnKiP3B+Vv0z1KYYFPv/
 P8Js5EzLtR8R3zhYRAphnbzACnHrVkBFnXO8LjkVJtsnvzrPGziBzVKoO3hFF1SpqVGT
 ZXTBObd5xdu3xzhaUCh/KT+yVy6p/EfZEQzKsenlSiDuGpKwWTolkVy3c2JaWJoMTGtZ
 TEX/LyTtJMB1RQyd990pTKxpY9LeoR7ZQVxDjai3QZwMhUeOpEQryxO1YUHnYSQgmlmZ
 ncAtUg9S3P7FRAqLGpLFYrIDB09XpdwuqGvC7T+jGqgCkfMx53+X5GQz5vNnQTBB4Pkw
 n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746705606; x=1747310406;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kOidC1G0JuJvmtz0itHhsdjrFQZ/G/6LXn6/7CbSSyY=;
 b=rD6F7L1FWW/tCYpHCHXrQ39Y4pMkbpUTiQMUn2hY5Fh7r6mJ+2EVg5zPmlVL2I8N5w
 q6C8UoOjWgA3S4yEsMlEzHIjYPnRXJ8v33atZKYIdI/lYKARxLbMioQeLXj+BWTdGv3G
 BUI1kGNHyaA7gwApUv8UhDExAHNJ0jOvinZaJfnVqET6V3Nvd1NrdQ0WmHAY5eq/znMJ
 Q8t9kK1M9tUaEFiTcNCco+WUfYrve99w85AIcNe0+Mk/zgq9s7gxzbvqUoYwSZD/ZkK9
 jJViml0XkTR+mMx0oWN4KWLtw2t3n/ZLO9i+IHlx6qfbl/ZAZfqdIVaBUzda9g+2jQC1
 bdEg==
X-Gm-Message-State: AOJu0Yy4FYb4uFDGIInIFhjpdaGzB58zcnGftZGz+rt8emyFDBUt8L7b
 2oI/AdVbYadw7hnCHER7cUW2Qez0iL0nWXVC3YA1+rcqRsX5kO1M8ghjA5A21I7N5wrAyTrcSoX
 CMyw=
X-Gm-Gg: ASbGncu9mwS6ahF9OdLOg7+W5LOHa5ITEK0BVG86hC3R5uZC05+bywK+3RykJ2sqTlU
 CTN+ZmOi3AoxEzv++8WrYMSNuBk2xtoYNxGiokwJlg9jZQWjuZB4rEa+Ha5GpuG9ttmkXO9b4ER
 O4w/ULDetMJ29GlnFR/SgBbNAUhcfdw+uoqFirUtmj3s0v4GXa0xhSpVwu+Ca43dP99dS7stY9d
 WcP5fVY7P9JnwKL7brR7SBJbE1otx15ISOfGau5rQrvjPWNmh1yj5aSBd6HtluHiJy3Mg8f9UIt
 Cc/ZiGpyTx9BH2eu8gkc9jlUPEe3OjPP1Sl9rZMKuZo=
X-Google-Smtp-Source: AGHT+IEhZZUOWG+EMQYSK24/oGP7xL3GDl8ccg2kQfUM4SCunSxjkKddexDoVK5EcresNlIclD/Ngg==
X-Received: by 2002:a17:907:2d11:b0:ad1:8fc6:d704 with SMTP id
 a640c23a62f3a-ad1fe69e150mr270072666b.1.1746705606122; 
 Thu, 08 May 2025 05:00:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146f74sm1086157766b.17.2025.05.08.05.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 05:00:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D64E5F767;
 Thu,  8 May 2025 13:00:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jiang XueQian <jiangxueqian@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-gpu-gl: Add 'serverfd' property
In-Reply-To: <20250403155129.3396821-1-jiangxueqian@gmail.com> (Jiang
 XueQian's message of "Thu, 3 Apr 2025 23:51:29 +0800")
References: <20250403155129.3396821-1-jiangxueqian@gmail.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Thu, 08 May 2025 13:00:02 +0100
Message-ID: <87tt5vmhx9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jiang XueQian <jiangxueqian@gmail.com> writes:

> This property passes socket of a externally started virgl_render_server
> to virglrenderer, so that it won't try to spawn new process and get
> killed by seccomp, allowing virtio-gpu-gl venus and sandbox to enable
> at the same time.

Do we have an example of how to start such a virgl server?
docs/syste,/devices/virtio-gpu.rst could be expanded with some example
invocations of the various modes.

>
> Signed-off-by: Jiang XueQian <jiangxueqian@gmail.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 15 +++++++++++++++
>  hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
>  include/hw/virtio/virtio-gpu.h |  2 ++
>  3 files changed, 34 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 683fad3bf8..e7c89f7c29 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -22,6 +22,7 @@
>  #include "hw/virtio/virtio-gpu-bswap.h"
>  #include "hw/virtio/virtio-gpu-pixman.h"
>  #include "hw/qdev-properties.h"
> +#include "monitor/monitor.h"
>=20=20
>  #include <virglrenderer.h>
>=20=20
> @@ -143,6 +144,17 @@ static void virtio_gpu_gl_device_realize(DeviceState=
 *qdev, Error **errp)
>          return;
>      }
>=20=20
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 3
> +    if (g->parent_obj.conf.serverfd) {
> +        g->parent_obj.conf.serverfd_parsed =3D
> +            monitor_fd_param(monitor_cur(),
> g->parent_obj.conf.serverfd, errp);

I think the right place to validate we have a valid serverfd is in a
property setter function.

> +        if (g->parent_obj.conf.serverfd_parsed < 0) {
> +            error_prepend(errp, "unable to parse serverfd: ");
> +            return;
> +        }
> +    }
> +#endif
> +
>      g->parent_obj.conf.flags |=3D (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
>      g->capset_ids =3D virtio_gpu_virgl_get_capsets(g);
>      VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =3D g->capset_ids->len;
> @@ -159,6 +171,9 @@ static const Property virtio_gpu_gl_properties[] =3D {
>                      VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>      DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 3
> +    DEFINE_PROP_STRING("serverfd", VirtIOGPU,
> parent_obj.conf.serverfd),

Use DEFINE_PROP with a PropertyInfo structure.

> +#endif
>  };
>=20=20
>  static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..420aae3b05 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1030,6 +1030,19 @@ static int virgl_make_context_current(void *opaque=
, int scanout_idx,
>                                     qctx);
>  }
>=20=20
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 3
> +static int virgl_get_server_fd(void *opaque, uint32_t version)
> +{
> +    VirtIOGPU *g =3D opaque;
> +
> +    if (g->parent_obj.conf.serverfd) {
> +        return g->parent_obj.conf.serverfd_parsed;
> +    }
> +
> +    return -1;
> +}
> +#endif
> +
>  static struct virgl_renderer_callbacks virtio_gpu_3d_cbs =3D {
>      .version             =3D 1,
>      .write_fence         =3D virgl_write_fence,
> @@ -1097,6 +1110,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      uint32_t flags =3D 0;
>      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>=20=20
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 3
> +    virtio_gpu_3d_cbs.version =3D 3;
> +    virtio_gpu_3d_cbs.get_server_fd =3D virgl_get_server_fd;
> +#endif
>  #if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
>      if (qemu_egl_display) {
>          virtio_gpu_3d_cbs.version =3D 4;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index a42957c4e2..40a81f500c 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -128,6 +128,8 @@ struct virtio_gpu_base_conf {
>      uint32_t xres;
>      uint32_t yres;
>      uint64_t hostmem;
> +    char *serverfd;
> +    int serverfd_parsed;

And we can drop char serverfd and have an explicit place for the fd. Is
0 a valid fd or do we need a initialise to -1?

>  };
>=20=20
>  struct virtio_gpu_ctrl_command {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

