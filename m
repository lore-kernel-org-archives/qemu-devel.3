Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF46EDA698
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSbp-0007l9-PZ; Tue, 03 Mar 2026 11:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxSbm-0007kz-Rp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:28:30 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxSbk-0001cW-CM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:28:30 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5033387c80aso85380611cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772555306; cv=none;
 d=google.com; s=arc-20240605;
 b=brN5xUY3hpczZ+StoCeaJuIzP6HGadrJEmqI9JYSOo/zmldcZV9ZmsWBVhxGisKItk
 bVLmfetgQf8lmKmxBwx0PGcUwSEyeP2HoOEap1pTqtFvviHHyUL5gRzhNuf5u0otRuBG
 oPocqWXTZyQcwRzexUrs/o+QKE/WmpcAqi+qF25TifeUCFD4lbuI/Vegy321s70pf1oT
 bRmdfPzm2ONNT0v9SmTO1CpCs0nJWmq9wVN/BPPMmuYUlpdY9ZX52wWo5o2cU3eVfMnK
 fv8LXOfWeP7lD9GkZPpQXC45Xe2PEwYQp0T5lSNgQfa1Uihas0l2rCs6XAvFuAEJFDpN
 FYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NqdJAtK9KrLy6wFq0Jol/frW1ci3IUY9uNLAAfGCdL0=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=lSZ8DvLD2fpgRQU68uNr0tHM+h/kZfg8k9DahwSuO0rlOKS8KsN2NPwZWCJ7/IJv0O
 HkogK4xSunI3mxFJSolYVjZnJCvbxnqB9+4Ako3c4t/FbyJwL2CkDJNBT5WVUTG/fzEk
 Vc2cWEZnnmgEQ9wTjxWQ3CdAHIO3Ysac2xWFGGU7j8FBdh25LwRl8Lqi16N/5G0+2BTf
 W2gxPFsQp0vkVs+MrNKgML+UhS7jYI0hOnwYkqFpRZh0hcATvg5j/rHbCB2ubCG4R1s9
 R+JB/S/4h8gb2KD5uLenKTA2kSAqyudbzB3vTXfWKJVUcj/FlNeJZHeWMT+tjpi/EGLw
 YkjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772555306; x=1773160106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqdJAtK9KrLy6wFq0Jol/frW1ci3IUY9uNLAAfGCdL0=;
 b=gDCtVApLWIn72XX1Ycw/cfasMFTP6RvyPKNKHfMSw8eIcnT73DGFRxvUAIFZtJzvmV
 IM0BCE50ftCdPn52xvt3RtCcXMi5xfUsnrjWl0YOrjKgzb82LlfPBA11XQvmOMOBj3PW
 iqmUc0vMO9R+dL/7pkd94+i8EtC+HY4ci7DHNjiejbrHf1hcifCvgB9tfBe+KCjRdP3f
 yJY2BWPTiu3ErnpprblgGzXI+2Pa6qMeYcI0gy2QuCCmdQWFhHVpjtrb+aK39qsPmpF3
 +FOtJZc7Uuio+f2tWV9lu37GTHmEBn03KLM3/DEcfyovsPF5bJeWkaTHaXS7BvcRoIHh
 6/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772555306; x=1773160106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NqdJAtK9KrLy6wFq0Jol/frW1ci3IUY9uNLAAfGCdL0=;
 b=X0OPm8zAPXkFH0xyciZ89dwFyIU4AJgXR2U9pLNc0ojqna6PyhIk3fYLwJ8SScZDWb
 nWAJ4Ck4j/bxfn7/ZxfVDIpsBdAmyXGF7hmD1GRRZ8g9U5xpghQEb7T6T54gFksWp5pM
 Uw9vd8pAPmLhKFvb6tXtF1mIi6vW4ws28NLTbKjYQyb7z2C2AaPNsh5geOMtcC8ElZAs
 f6/6xQ8leMjv9YYB5EYC0v/T3Q++cXCua3Xs3xsrcOhMq+RQyKqforuIoJS5oQeAsxD+
 MTZSo/B3F/AewMX3sQExjY0hur78nCRqG7SgYpYHgLwIC0mAtloFnJemEkExm9ziNmMZ
 OowA==
X-Gm-Message-State: AOJu0YztQhWupOVFvWs+wuveOQafYxKexUGZw6UxMqkUvW7yJ+aSIxab
 iVzpXzoF/zYBdtg3wbqnuw49V2zyx8K7isoEIpFCkdecBG1aZ/YxytKK8+KjgXiNs7GOmqRe55n
 3o/VIEEINyjlzpaJIsgnbWUdYXQDbJ++ZQCNUTqwf83UHibc=
X-Gm-Gg: ATEYQzyLH9KNvBoM0x6+NSJLj8IDsouFJh4+MDbzV95rtDocv5g3yC4uDjC6Oe9HYhL
 ahHwC0wUPlzs/5IqOr/gH50QW5me3nMjffIrJicT1vL0VFMEnxqrKMlBFyG1BDFRO5bkOniULJk
 LjjoU3wgixFeYuqZkTsRE24jWkaAkp6lO+tHrPB2U6roLT8OBW6xv4hDRTVKOVQbVsuVEwxPs+m
 bhvQiWrziQLAjLj55UAEkTG/9IxRRcHcSFnSCAApX7UQww07QB758h+0qDGYu+LGPIupBK15DxS
 zZmtL0PLLmc6VJB2qxLCoXEK7sEO+5epyMNEA5pz
X-Received: by 2002:a05:622a:180c:b0:4ff:b0f4:c307 with SMTP id
 d75a77b69052e-508ceab7063mr30617741cf.24.1772555306546; Tue, 03 Mar 2026
 08:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
In-Reply-To: <20260303010047.1925589-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 17:28:15 +0100
X-Gm-Features: AaiRm50aotk5OFXgfJbKbqnEIXAXOWDYmgUSIUOlsQr5_23TDBu-qyJf2K94Wpc
Message-ID: <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

Hi

On Tue, Mar 3, 2026 at 2:06=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
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
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu.h  |  3 ++-
>  hw/display/virtio-gpu-udmabuf.c | 25 ++++++++++++++++++-------
>  hw/display/virtio-gpu.c         |  2 +-
>  3 files changed, 21 insertions(+), 9 deletions(-)
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
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index d804f321aa..bd5b44f5fb 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -151,13 +151,6 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simpl=
e_resource *res)
>      res->blob =3D pdata;
>  }
>
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
> @@ -169,6 +162,24 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGP=
UDMABuf *dmabuf)
>      g_free(dmabuf);
>  }
>
> +void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_reso=
urce *res)
> +{
> +    int max_outputs =3D g->parent_obj.conf.max_outputs;
> +    int i;
> +
> +    for (i =3D 0; i < max_outputs; i++) {
> +        VGPUDMABuf *dmabuf =3D g->dmabuf.primary[i];
> +
> +        if (dmabuf && (res->dmabuf_fd !=3D -1) &&

Maybe add qemu_dmabuf_get_numplanes() > 0 ?

> +            qemu_dmabuf_get_fds(dmabuf->buf, NULL)[0] =3D=3D res->dmabuf=
_fd) {
> +            qemu_dmabuf_close(dmabuf->buf);
> +            res->dmabuf_fd =3D -1;

I am not really happy about that we close the underlying fd here
before the next destroy, but I don't have an immediate solution

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
>
>      if (res->blob) {
> -        virtio_gpu_fini_udmabuf(res);
> +        virtio_gpu_fini_udmabuf(g, res);
>      }
>  }
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

