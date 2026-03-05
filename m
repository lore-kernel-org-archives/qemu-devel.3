Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E31FEEF319
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy3kZ-0007p7-EI; Thu, 05 Mar 2026 03:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vy3kX-0007jn-H3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:08:02 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vy3kU-0008JX-ML
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:08:00 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-660a7aa6e44so3891857a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772698077; x=1773302877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KodPW6+51SwlY0DgicXlKEFQXnm8ZmZGUkGlYHmaB30=;
 b=GWaeCvsIPmPSqfrmzqTKIoFC/hmD3/6u0S9EmDWBFT36EOgoZg8qCku2B+qBHS6zfa
 ZmreWBKEr5fXdmzbHrxCyXQI8QAVZUthW5Y3NkW0ni0iM419UZPPmVM/jS0NUU3t1ABb
 KHN8z6ob5PD6m/3+gnKW8Y6TWtDOr3jVjVHjstlYJTuOH/0YmRe9uUHvketeVCGTjTKw
 pRcVnP9UyIZ5sw7jHbB8EEsiNm6k6id/ul7QJps6hKEw+AE4/UKd58QC9VYsy5+NfuVs
 pMMiXuGaOdf6Ucse06hEpC4bqUvwvMYXbHV46KFT5HZE+j75W0m8Lh8Mt48uipqqUSIH
 HQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772698077; x=1773302877;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KodPW6+51SwlY0DgicXlKEFQXnm8ZmZGUkGlYHmaB30=;
 b=wMLUgTUhMdkfByVyuBzEmfXMExf06eGvgwnHXrw+qO3T70CrMCvnhxRnOGNBvs/R7X
 +phudzkE+/jdHLVPFamQIUYhGIHXinIWGKnBkUS39otlvWxLbCyaUodDU2gv3FxKXCY0
 t5fs/wwBIvLcqS6n/5fHTMv0gppSyu188yndtYWXt251kN9iBAtoaMEI8NBxYH/ORrSN
 bBsPjTWCWNMedd9pPJKKfKoqxo/uM42GEkC3nR6ZT8msnKBa3GP/Z4rd4W44kCBY+5Yq
 gwRI6NmvH+JX/J3aLWmEbZqA48I/OjKhOBrdcXVFBJTBQE4KWb2ukfjufs6X9qVLGpoG
 XebQ==
X-Gm-Message-State: AOJu0YzsZERvgRuhOTgMNULdmSo4L6HTeNCPHXjbqMHcWRF0Kk7Q1Sqe
 i5zBj+7GCWwSGbZCSygChZdCbQqo36AfPWbXoWmjzwQ5vI8Ybcldk9Cc5GMKDGZHe2I=
X-Gm-Gg: ATEYQzzi+sjq+LJngnKxEJmh/TJTYGmSZkw/xUKHMP5onhhaNwiXxW4jCo73nXn8Vcf
 EgW+EIZXKp0jOyOs0vWDfPPQSdkeATHDi8Pefo4pKqAtp7xSqHlAygAcWXRfPn9P9U/InjVU3oH
 K3015zdinbGPXjzYA+juXp/VCxWfv/G+F+8T6p20bnZrUK4BJ74bjVZ1iE/UcUvlhoLtkDlbsZf
 WcOW/FjC8sT0U/bPVWpPfp+b4wztGo31FlRgTpiWLE0lN2GqC2Yalxp02nShDqgMIvF/pfSQnQr
 bMwmh60sNE2XG0T3223sBdnvZHgqzGU5ynvipLQVDWA6hjeY6oNctojUZaXVgo4t6qTJq67/eff
 5pAtzCXBB17K4h0tO6f+ersMRksjr9gc9i6mdfHBqaZBChRYrxMd8ir4zbTiMFUwFjCd7IJ0yLA
 05WxWJVy26TxJ+8/iDl6zznQqt2SEktQPieg==
X-Received: by 2002:a17:907:5cb:b0:b8a:f225:edde with SMTP id
 a640c23a62f3a-b93f14101d4mr284036266b.45.1772698076819; 
 Thu, 05 Mar 2026 00:07:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac74adasm846874466b.27.2026.03.05.00.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:07:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6825E5F802;
 Thu, 05 Mar 2026 08:07:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio-gpu: Fix scanout dmabuf cleanup during
 resource destruction
In-Reply-To: <20260304203230.1955266-1-dongwon.kim@intel.com> (dongwon kim's
 message of "Wed, 4 Mar 2026 12:32:30 -0800")
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
 <20260304203230.1955266-1-dongwon.kim@intel.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Thu, 05 Mar 2026 08:07:55 +0000
Message-ID: <87ikbaog10.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

dongwon.kim@intel.com writes:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When a virtio-gpu resource is destroyed, any associated udmabuf must be
> properly torn down. Currently, the code may leave dangling references
> to dmabuf file descriptors in the scanout primary buffers.
>
> This patch updates virtio_gpu_fini_udmabuf to:
> 1. Iterate through all active scanouts.
> 2. Identify dmabufs that match the resource's file descriptor.
> 3. Close the dmabuf and invalidate the resource's FD reference to
>    prevent use-after-free or double-close scenarios.
> 4. Finally, trigger the underlying udmabuf destruction.
>
> This ensures that the display backend does not attempt to access
> memory or FDs that have been released by the guest or the host.

Queued to virtio-gpu/next, thanks.

>
> v2: - Corrected virtio_gpu_fini_udmabuf in stub
>       (Alex Benn=C3=A9e)
>
>     - Make sure that qemu dmabuf has at least one plane before
>       Comparing fds
>       (Marc-Andr=C3=A9 Lureau)

FYI usually we put version information under the --- so it doesn't
pollute the commit message when things are applied.

>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/hw/virtio/virtio-gpu.h        |  3 ++-
>  hw/display/virtio-gpu-udmabuf-stubs.c |  2 +-
>  hw/display/virtio-gpu-udmabuf.c       | 27 ++++++++++++++++++++-------
>  hw/display/virtio-gpu.c               |  2 +-
>  4 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 58e0f91fda..65312f869d 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -357,7 +357,8 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_=
framebuffer *fb,
>  /* virtio-gpu-udmabuf.c */
>  bool virtio_gpu_have_udmabuf(void);
>  void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
> -void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res);
> +void virtio_gpu_fini_udmabuf(VirtIOGPU *g,
> +                             struct virtio_gpu_simple_resource *res);
>  int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>                               uint32_t scanout_id,
>                               struct virtio_gpu_simple_resource *res,
> diff --git a/hw/display/virtio-gpu-udmabuf-stubs.c b/hw/display/virtio-gp=
u-udmabuf-stubs.c
> index f692e13510..85d03935a3 100644
> --- a/hw/display/virtio-gpu-udmabuf-stubs.c
> +++ b/hw/display/virtio-gpu-udmabuf-stubs.c
> @@ -12,7 +12,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_r=
esource *res)
>      /* nothing (stub) */
>  }
>=20=20
> -void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
> +void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_reso=
urce *res)
>  {
>      /* nothing (stub) */
>  }
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index d804f321aa..74b6a7766a 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simpl=
e_resource *res)
>      res->blob =3D pdata;
>  }
>=20=20
> -void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
> -{
> -    if (res->remapped) {
> -        virtio_gpu_destroy_udmabuf(res);
> -    }
> -}
> -
>  static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
>  {
>      struct virtio_gpu_scanout *scanout;
> @@ -169,6 +162,26 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGP=
UDMABuf *dmabuf)
>      g_free(dmabuf);
>  }
>=20=20
> +void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_reso=
urce *res)
> +{
> +    int max_outputs =3D g->parent_obj.conf.max_outputs;
> +    int i;
> +
> +    for (i =3D 0; i < max_outputs; i++) {
> +        VGPUDMABuf *dmabuf =3D g->dmabuf.primary[i];
> +
> +        if (dmabuf &&
> +            qemu_dmabuf_get_num_planes(dmabuf->buf) > 0 &&
> +            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] =3D=3D res->dmabuf=
_fd &&
> +            res->dmabuf_fd !=3D -1) {
> +            qemu_dmabuf_close(dmabuf->buf);
> +            res->dmabuf_fd =3D -1;
> +        }
> +    }
> +
> +    virtio_gpu_destroy_udmabuf(res);
> +}
> +
>  static VGPUDMABuf
>  *virtio_gpu_create_dmabuf(VirtIOGPU *g,
>                            uint32_t scanout_id,
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 643e91ca2a..b2af861f0d 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -902,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>      res->addrs =3D NULL;
>=20=20
>      if (res->blob) {
> -        virtio_gpu_fini_udmabuf(res);
> +        virtio_gpu_fini_udmabuf(g, res);
>      }
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

