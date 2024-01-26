Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3734CC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQdj-00024r-Eq; Fri, 26 Jan 2024 13:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTQdh-00024L-B5
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:09:17 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTQdf-00020e-Da
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:09:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337cf4eabc9so766131f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706292553; x=1706897353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcwIRp3QrYNMwKvJB5qKH6qWps9edEb1BPMUxNamifs=;
 b=wRLq+Nwb+Av6wgL9OGDEaaq042P8mvq85iDpJuykOybeIBr4JmGalT2Chz+JAgAfNw
 mYr01cJaijSHD3MRsrnZhP72DmqZ2tp/aIbi3ohWqS1RSyBzaWjnyBiiaTwrberaNROG
 141/PzaQ5gdGRsA2L2HYbpAvhBmC5BDrrk6TphzmuKNRljgMpeARV/FY2BXkS0kos8tV
 0VinvJo1v5hnxZO3RhmFDpuPkNRcc8MASVpdlexXSxy+oiHfFS9vGakpBa1I5BOmOSvo
 d0laVv5hwzki5iXLbK5V/1FqfumBNU/wNriasan07JQ4yI+x2mVVrtlQ9X73hnVLrQGw
 e2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706292553; x=1706897353;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LcwIRp3QrYNMwKvJB5qKH6qWps9edEb1BPMUxNamifs=;
 b=JWiW8mRnRM+KlJ67r5G2q/qTS7EWKulRq0nDYKoFrFK91Wp9TvAYfqPutJd7FJQbaH
 4AfK8wmBh6E5RQlZ1oAluTmhlPG7sHLCcNo5akZbFFxCitYw+sloaZeljPePy0g76Yy8
 AhLkbIQ5obcvFajQoQ835+kaVNcBRlHa6qhc2woYmRxh8Idg1GyaMPOQkLYGkGz2o6Se
 QCD6xFKNbq+z1aFtAvgTXc7waBt19Ms1nH8FCSX9cl1dfstP8jGDrXLmuLHDeiOV/O+V
 1yXXfsmg6yV2/9EjAYxCi+kGIc3uaAvRWs1LbTSE9wRLMo8wsxhDgC5PFdikvlgfHCG8
 uKWA==
X-Gm-Message-State: AOJu0YzbuLSf8ztuJy7hTc4VUzKw4OTU6sh1HR0wgBLHP9T/avRnPDy/
 VVule/dkQtVG4Wzk1WIZX3c8Pwvcl66HckhdEanYxz2sX/G/VIbLWRH6grvgLuo=
X-Google-Smtp-Source: AGHT+IF28dVfpD/dCP0VP1ZNM/SDLcMry7uGCATe5AwePV1oXponM88L2Xz6QK7seAPpmZ1oWLt9Dg==
X-Received: by 2002:adf:ab11:0:b0:336:613e:9e54 with SMTP id
 q17-20020adfab11000000b00336613e9e54mr18461wrc.89.1706292553400; 
 Fri, 26 Jan 2024 10:09:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k8-20020a5d6288000000b00337be3b02aasm1727831wru.100.2024.01.26.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 10:09:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF9785F78A;
 Fri, 26 Jan 2024 18:09:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>
Subject: Re: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
In-Reply-To: <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Fri, 26 Jan 2024 16:41:49 +0200")
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 18:09:12 +0000
Message-ID: <87h6j0q853.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
> need to do their own bookkeeping (free rutabaga resources that are
> associated with the virtio_gpu_simple_resource).
>
> This commit adds a class method so that virtio-gpu-rutabaga can override
> it in the next commit.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
>  include/hw/virtio/virtio-gpu.h |  2 ++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2b73ae585b..96420ba74f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -401,8 +401,9 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, =
int scanout_id)
>      scanout->height =3D 0;
>  }
>=20=20
> -static void virtio_gpu_resource_destroy(VirtIOGPU *g,
> -                                        struct virtio_gpu_simple_resourc=
e *res)
> +static int32_t
> +virtio_gpu_resource_destroy(VirtIOGPU *g,
> +                            struct virtio_gpu_simple_resource *res)
>  {
>      int i;
>=20=20
> @@ -419,6 +420,8 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
>      QTAILQ_REMOVE(&g->reslist, res, next);
>      g->hostmem -=3D res->hostmem;
>      g_free(res);
> +
> +    return 0;
>  }
>=20=20
>  static void virtio_gpu_resource_unref(VirtIOGPU *g,
> @@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(DeviceSta=
te *qdev)
>  static void virtio_gpu_reset_bh(void *opaque)
>  {
>      VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_GET_CLASS(g);
>      struct virtio_gpu_simple_resource *res, *tmp;
> +    int32_t result, resource_id;
>      int i =3D 0;
>=20=20
>      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> -        virtio_gpu_resource_destroy(g, res);
> +        resource_id =3D res->resource_id;
> +        result =3D vgc->resource_destroy(g, res);
> +        if (result) {
> +            error_report("%s: %s resource_destroy"
> +                         "for resource_id =3D %d failed with return valu=
e =3D %d;",
> +                         __func__, object_get_typename(OBJECT(g)), resou=
rce_id,
> +                         result);
> +        }
>      }
>=20=20
>      for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> @@ -1632,6 +1644,7 @@ static void virtio_gpu_class_init(ObjectClass *klas=
s, void *data)
>      vgc->handle_ctrl =3D virtio_gpu_handle_ctrl;
>      vgc->process_cmd =3D virtio_gpu_simple_process_cmd;
>      vgc->update_cursor_data =3D virtio_gpu_update_cursor_data;
> +    vgc->resource_destroy =3D virtio_gpu_resource_destroy;
>      vgbc->gl_flushed =3D virtio_gpu_handle_gl_flushed;
>=20=20
>      vdc->realize =3D virtio_gpu_device_realize;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 584ba2ed73..5683354236 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -219,6 +219,8 @@ struct VirtIOGPUClass {
>      void (*update_cursor_data)(VirtIOGPU *g,
>                                 struct virtio_gpu_scanout *s,
>                                 uint32_t resource_id);
> +    int32_t (*resource_destroy)(VirtIOGPU *g,
> +                                struct virtio_gpu_simple_resource
>      *res);

What range of errors to you expect to have here? Otherwise you might as
well return a bool for success/fail.

>  };
>=20=20
>  struct VirtIOGPUGL {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

