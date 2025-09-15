Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846CCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyE8E-000147-Sf; Mon, 15 Sep 2025 14:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyE8C-00013J-66
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:40:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyE7z-0003ah-Pb
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:40:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3eb08d8d9e7so889185f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757961626; x=1758566426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9plcvB3joQqsIVX9VNOSFGgH2b1wj2xGeS1SFZTKiM=;
 b=KmIJmD4rPWtGKHvL/zf8+eV6RnxEihwGdZTEEqhh0kryGSYiT9KAcftXfhi1uuawda
 dn4Fu2KBnG5dOL+fqMGtJdHh5aomGenLaztJYCbN5a0eQwn4KkBsm4bPlgqhG15vfo5a
 sluInh9uPAeDdXzn+cx/Y1AwXzLlvlH9QzCF787ziZrwB5AMKCyG+8i8Ss94tPRP3/AV
 z1rO+Mk4DqhkWGbdXpSPkIgHwJS1catNizCWWZvCRKbOl7OXF6iJEi5cr9PzBNHxfiTL
 Vs54MSVe3UROtnjs62Wwv3+uHd4Ns5mYZROpENubXEN9kNucnkhehVGKl2ycPO8HN66s
 netQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757961626; x=1758566426;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9plcvB3joQqsIVX9VNOSFGgH2b1wj2xGeS1SFZTKiM=;
 b=mr1fQQha840BsNNqezaarq+coMVgSX9A4Spxkktnf0g7c7ZBi8VqQDc/FSswRCVtr+
 hpl2uLc+prc1VX6JJhezrDuZTeVTNAm3OS+Jpe3Tr+xM2YR8OKouzYUN9kXwCtqbVCTt
 LcRMbwDOKxl3zYsXdMqFNkTM/RHnN3bGWwyTQo9jhIzf2+zU5RVOsdD7oomeGeu/+eL0
 Rbc52pG9O9vJDTFkqJG46Y52E08SmNDuxPiuHMQPNsOtJHEYCrrNaz/uFylI8ht6R9hR
 lrurEY8XasaYactfCWBTM5g0yNs6BYA/XmB0xP1lW7Ov37J/EVhmENq3b30cXYmII4CR
 f01w==
X-Gm-Message-State: AOJu0YzjGLIxalP1b0Sl9MVhi4v9LbCwDtoo3/Hdds35D95e5LpUv8wu
 lLmiIMb6PaloR1qtaHXOdfoVNw4aUJdQLRdLuE6qvAgtFMueuyo8aFY/ou/uW45NBqg=
X-Gm-Gg: ASbGnctiji4jpYkqthN7tqEkLmiMGB/yeErqJQDdnjAwmEaSkdM59VmQF33GbguKFGi
 egPYeqTBMI00pYgT3Vt9lPybxhV22Xa1nmb/AbbeF2g07QfIj+qBSeSFWToIVQ5s9NWSbJmbvVH
 h/XhwyydsNzzGiIWHqXiE7dTkcxeiaMI6NEbqCv4FgqBgoUzBwJpgSHBFMS/6i2usj/KxMQUwqU
 QRZZd9McF6OoDX2ce/MYCZSngpTa2Yu+U/SY2xQo7kC6W52CyYed2nJBQ7G3SSOxOqZdyukIa+s
 gRktxj16I6A8L7zZbj8ryK50O92//II6txIjcZuHMkxrSm7ofCfIzLLMc5iHhMZYBtvNSA6DoqM
 Pao0No898GPAcuYA6+ByEdupwLewp267cYw==
X-Google-Smtp-Source: AGHT+IFbYcbdqC6OYsvq8md+1clqGWM7vzU3KPw/TlYyyddm3TW/ZZOPhpZdZk18AswS0ihtcqMwvQ==
X-Received: by 2002:a05:6000:430e:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-3e9b208f3d2mr5398559f8f.29.1757961625996; 
 Mon, 15 Sep 2025 11:40:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8b7b6ff8fsm10757027f8f.61.2025.09.15.11.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 11:40:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79AD85F867;
 Mon, 15 Sep 2025 19:40:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
In-Reply-To: <20250903054438.1179384-4-vivek.kasireddy@intel.com> (Vivek
 Kasireddy's message of "Tue, 2 Sep 2025 22:42:16 -0700")
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-4-vivek.kasireddy@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 19:40:23 +0100
Message-ID: <87o6rbo8yw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Vivek Kasireddy <vivek.kasireddy@intel.com> writes:

> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Therefore, we first need to figure
> out if the blob is backed by a VFIO device region or a memfd before
> we can call the right API to get a dmabuf fd created.
>
> So, once we have the ramblock and the associated mr, we rely on
> memory_region_is_ram_device() to tell us where the backing storage
> is located. If the blob resource is VFIO backed, we try to find the
> right VFIO device that contains the blob and then invoke the API
> vfio_create_dmabuf().
>
> Note that we only call virtio_gpu_remap_udmabuf() if the blob is
> backed by a memfd. This is because the VFIO dmabuf implementation
> may not support mmap.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  hw/display/virtio-gpu-udmabuf.c | 60 ++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index d804f321aa..0390a8f488 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -18,6 +18,7 @@
>  #include "ui/console.h"
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>  #include "trace.h"
>  #include "system/ramblock.h"
>  #include "system/hostmem.h"
> @@ -27,6 +28,32 @@
>  #include "standard-headers/linux/udmabuf.h"
>  #include "standard-headers/drm/drm_fourcc.h"
>=20=20
> +static void vfio_create_dmabuf(VFIODevice *vdev,
> +                               struct virtio_gpu_simple_resource *res)
> +{
> +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, res->io=
v_cnt);
> +    if (res->dmabuf_fd < 0) {
> +        warn_report("%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s", __func__,
> +                    strerror(errno));
> +    }
> +}
> +
> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> +{
> +    VFIODevice *vdev;
> +
> +    if (QLIST_EMPTY(&vfio_device_list)) {
> +        return NULL;
> +    }
> +
> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> +        if (vdev->dev =3D=3D mr->dev) {
> +            return vdev;
> +        }
> +    }
> +    return NULL;
> +}
> +

Also fails if VFIO isn't enabled:

  /usr/bin/ld: libsystem.a.p/hw_display_virtio-gpu-udmabuf.c.o: warning: re=
location against `vfio_device_list' in read-only section `.text'
  /usr/bin/ld: libsystem.a.p/hw_display_virtio-gpu-udmabuf.c.o: in function=
 `vfio_device_lookup':
  /home/alex/lsrc/qemu.git/builds/all/../../hw/display/virtio-gpu-udmabuf.c=
:45:(.text+0x313): undefined reference to `vfio_device_list'
  /usr/bin/ld: libsystem.a.p/hw_display_virtio-gpu-udmabuf.c.o: in function=
 `vfio_create_dmabuf':
  /home/alex/lsrc/qemu.git/builds/all/../../hw/display/virtio-gpu-udmabuf.c=
:34:(.text+0x361): undefined reference to `vfio_device_create_dmabuf'
  /usr/bin/ld: warning: creating DT_TEXTREL in a PIE


>  static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource =
*res)
>  {
>      struct udmabuf_create_list *list;
> @@ -130,6 +157,9 @@ bool virtio_gpu_have_udmabuf(void)
>=20=20
>  void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>  {
> +    bool memfd_blob =3D false;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
>      void *pdata =3D NULL;
>=20=20
>      res->dmabuf_fd =3D -1;
> @@ -137,15 +167,31 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simp=
le_resource *res)
>          res->iov[0].iov_len < 4096) {
>          pdata =3D res->iov[0].iov_base;
>      } else {
> -        virtio_gpu_create_udmabuf(res);
> +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false, &of=
fset);
> +        if (rb && memory_region_is_ram_device(rb->mr)) {
> +            VFIODevice *vdev =3D vfio_device_lookup(rb->mr);
> +
> +            if (!vdev) {
> +                warn_report("Could not find device to create dmabuf");
> +                return;
> +            }
> +            vfio_create_dmabuf(vdev, res);
> +        } else {
> +            virtio_gpu_create_udmabuf(res);
> +            memfd_blob =3D true;
> +        }
> +
>          if (res->dmabuf_fd < 0) {
>              return;
>          }
> -        virtio_gpu_remap_udmabuf(res);
> -        if (!res->remapped) {
> -            return;
> +
> +        if (memfd_blob) {
> +            virtio_gpu_remap_udmabuf(res);
> +            if (!res->remapped) {
> +                return;
> +            }
> +            pdata =3D res->remapped;
>          }
> -        pdata =3D res->remapped;
>      }
>=20=20
>      res->blob =3D pdata;
> @@ -153,9 +199,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple=
_resource *res)
>=20=20
>  void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
>  {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_udmabuf(res);
> -    }
> +    virtio_gpu_destroy_udmabuf(res);
>  }
>=20=20
>  static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

