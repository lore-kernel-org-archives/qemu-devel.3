Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F91C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizlr-0004jz-Lm; Tue, 27 Aug 2024 13:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sizll-0004jH-GE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:14:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sizlj-0005nj-72
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:14:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ab880b73eso51936505e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724778849; x=1725383649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yoHCEMXlglC4Ojb1w/+bBKoFgpKQuU/89HLCYKjclFg=;
 b=QHdjRXSsTkV2VtaHBmL+qggl7QuoOvnDwcvqirvRHkLkA+MUhSnhxyzBEsuQU7hAHr
 7tsomohqfiyHU/U0lDRxW3gA7M24b+9BxVPZ5QVrJ1hTDUqNTmyGWrzb890jKOXj0nt2
 cvWeiaEgEWUG7urHiWpL7KYtvoUwcZPj50sLHal8ZM7JBaWZ/RNarhdJfU6P8RZp83Cp
 5jZGH/vr9H91iDt/yd9BxY0joVimUGxtVdtnxmwwNIKF+zQ8WkGwgXkkivwQTAVN4AtQ
 a11mkP2tXVCjtJlnSUq3yiuPr+AHWsxr4S7yR3WywzhvCIyd0OPbbMoxCJyfTuUG0BsK
 aojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724778849; x=1725383649;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoHCEMXlglC4Ojb1w/+bBKoFgpKQuU/89HLCYKjclFg=;
 b=sQjsvLnMZAie+a+AMju3hSCiBVrN9Edk5Fs5dVvDqUgBz4qkW7QUG0ndz5/whUuFIk
 +GYdrySDrXVvSEz3dZxhYsMlQAclLNB0qSQva1NZbOMQMnikjNvjj1o6grFZk0avlc+x
 v7SiJ45AltjKZZoRU1tMEf2QXgHYUUj/6p1usk5gmbqOZdP3oV/Uc6wH/eRnHoLcgJN9
 sg8xwtSwMSYczPLLdqQVWHSR89Ef1/kGAoxk6hwAEYUJQX1nukynIf4Pc1ezidZz8WwC
 TSVlp2NxgvIkBECb6JpWaLe5KEGrBNzzCvOY+qP5oyrxuTDQ2J8/vQ2V067Jt0qgnQM7
 xfig==
X-Gm-Message-State: AOJu0YyRq9vr4bqM+dx9QkXMh1XtEjcux0YeVu11tKiQ78Ye0NY1tq0a
 X77RT+EGzudPQUNR2mYn1L08sysQKFEYIfFfyDTaBd21xVDZjarFRCpXKCb+Drc=
X-Google-Smtp-Source: AGHT+IFxizz0saXILDaIKyLH5Z06lkidisve1/PoUjRC5n1J9Wc1D01JVmyGheY7kT4KfBABB9Q1Fw==
X-Received: by 2002:a05:600c:4fc5:b0:427:ffa4:32d0 with SMTP id
 5b1f17b1804b1-42b9ae2422emr24985255e9.28.1724778848348; 
 Tue, 27 Aug 2024 10:14:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e093sm192481855e9.7.2024.08.27.10.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 10:14:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 075635F9E6;
 Tue, 27 Aug 2024 18:14:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <qemu-devel@nongnu.org>,  <viresh.kumar@linaro.org>,
 <quic_ztu@quicinc.com>,  <quic_tsoni@quicinc.com>
Subject: Re: [PATCH] Add vhost-user-spi and vhost-user-spi-pci devices
In-Reply-To: <20240712034246.2553812-1-quic_haixcui@quicinc.com> (Haixu Cui's
 message of "Fri, 12 Jul 2024 11:42:46 +0800")
References: <20240712034246.2553812-1-quic_haixcui@quicinc.com>
Date: Tue, 27 Aug 2024 18:14:06 +0100
Message-ID: <8734mp6g81.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Haixu Cui <quic_haixcui@quicinc.com> writes:


Apologies for the delay in getting to this.=20

> This work is based on the virtio-spi spec, virtio-spi driver introduced by
> the following patch series:
> - https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4/device-types/s=
pi
> - https://lwn.net/Articles/966715/
>
> To test with rust-vmm vhost-user-spi daemon, start the vhost-daemon first=
ly:
>     vhost-device-spi --socket-path=3Dvspi.sock --socket-count=3D1 --devic=
e "/dev/spidev0.0"

I'm struggling to test this on my main dev box. Are there any dummy SPI
modules for the kernel for testing? Otherwise we could consider
implementing something similar to "mock_gpio" for the rust-vmm
vhost-user-spi backend?


> Then invoke qemu with the following parameters:
>     qemu-system-aarch64 -m 1G \
>         -chardev socket,path=3D/home/root/vspi.sock0,id=3Dvspi \
>         -device vhost-user-spi-pci,chardev=3Dvspi,id=3Dspi \
>         -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/sh=
m,share=3Don \
>         -numa node,memdev=3Dmem
>         ...

>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  hw/virtio/Kconfig                           |   5 +
>  hw/virtio/meson.build                       |   3 +
>  hw/virtio/vhost-user-spi-pci.c              |  69 ++++++++
>  hw/virtio/vhost-user-spi.c                  |  66 +++++++
>  hw/virtio/virtio.c                          |   4 +-
>  include/hw/virtio/vhost-user-spi.h          |  25 +++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  include/standard-headers/linux/virtio_spi.h | 186 ++++++++++++++++++++
>  8 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/vhost-user-spi-pci.c
>  create mode 100644 hw/virtio/vhost-user-spi.c
>  create mode 100644 include/hw/virtio/vhost-user-spi.h
>  create mode 100644 include/standard-headers/linux/virtio_spi.h

Generally we want separate headers patches for the importing of headers.
Doubly so in this case because I can't see the SPI definitions in the
current Linux master. So:

  - 1/2 - Import headers for SPI (!merge until upstream)
  - 2/2 - Implement vhost-user stub for virtio-spi



>
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd4..d5857651e5 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -110,3 +110,8 @@ config VHOST_USER_SCMI
>      bool
>      default y
>      depends on VIRTIO && VHOST_USER
> +
> +config VHOST_USER_SPI
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 621fc65454..42296219e5 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -26,6 +26,7 @@ if have_vhost
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('=
vhost-user-rng.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('=
vhost-user-snd.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files=
('vhost-user-input.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('=
vhost-user-spi.c'))
>=20=20
>      # PCI Stubs
>      system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhos=
t-user-device-pci.c'))
> @@ -39,6 +40,8 @@ if have_vhost
>                           if_true: files('vhost-user-snd-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
INPUT'],
>                           if_true: files('vhost-user-input-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
SPI'],
> +                         if_true: files('vhost-user-spi-pci.c'))
>    endif
>    if have_vhost_vdpa
>      system_virtio_ss.add(files('vhost-vdpa.c'))
> diff --git a/hw/virtio/vhost-user-spi-pci.c b/hw/virtio/vhost-user-spi-pc=
i.c
> new file mode 100644
> index 0000000000..3565d526af
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi-pci.c
> @@ -0,0 +1,69 @@
> +/*
> + * Vhost-user spi virtio device PCI glue
> + *
> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserve=
d.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/vhost-user-spi.h"
> +#include "hw/virtio/virtio-pci.h"
> +
> +struct VHostUserSPIPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserSPI vdev;
> +};
> +
> +typedef struct VHostUserSPIPCI VHostUserSPIPCI;
> +
> +#define TYPE_VHOST_USER_SPI_PCI "vhost-user-spi-pci-base"
> +
> +DECLARE_INSTANCE_CHECKER(VHostUserSPIPCI, VHOST_USER_SPI_PCI,
> +                         TYPE_VHOST_USER_SPI_PCI)
> +
> +static void vhost_user_spi_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
> +{
> +    VHostUserSPIPCI *dev =3D VHOST_USER_SPI_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +
> +    vpci_dev->nvectors =3D 1;
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +}
> +
> +static void vhost_user_spi_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +    k->realize =3D vhost_user_spi_pci_realize;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D 0; /* Set by virtio-pci based on virtio id */
> +    pcidev_k->revision =3D 0x00;
> +    pcidev_k->class_id =3D PCI_CLASS_COMMUNICATION_OTHER;
> +}
> +
> +static void vhost_user_spi_pci_instance_init(Object *obj)
> +{
> +    VHostUserSPIPCI *dev =3D VHOST_USER_SPI_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_SPI);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_user_spi_pci_info =3D {
> +    .base_name =3D TYPE_VHOST_USER_SPI_PCI,
> +    .non_transitional_name =3D "vhost-user-spi-pci",
> +    .instance_size =3D sizeof(VHostUserSPIPCI),
> +    .instance_init =3D vhost_user_spi_pci_instance_init,
> +    .class_init =3D vhost_user_spi_pci_class_init,
> +};
> +
> +static void vhost_user_spi_pci_register(void)
> +{
> +    virtio_pci_types_register(&vhost_user_spi_pci_info);
> +}
> +
> +type_init(vhost_user_spi_pci_register);
> diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
> new file mode 100644
> index 0000000000..e138b8b53b
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi.c
> @@ -0,0 +1,66 @@
> +/*
> + * Vhost-user spi virtio device
> + *
> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserve=
d.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/vhost-user-spi.h"
> +#include "qemu/error-report.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_spi.h"
> +
> +static Property vspi_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vspi_realize(DeviceState *dev, Error **errp)
> +{
> +    VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> +    VHostUserBaseClass *vubc =3D VHOST_USER_BASE_GET_CLASS(dev);
> +
> +    /* Fixed for SPI */
> +    vub->virtio_id =3D VIRTIO_ID_SPI;
> +    vub->num_vqs =3D 1;
> +    vub->vq_size =3D 4;
> +    vub->config_size =3D sizeof(struct virtio_spi_config);
> +
> +    vubc->parent_realize(dev, errp);
> +}
> +
> +static const VMStateDescription vu_spi_vmstate =3D {
> +    .name =3D "vhost-user-spi",
> +    .unmigratable =3D 1,
> +};
> +
> +static void vu_spi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VHostUserBaseClass *vubc =3D VHOST_USER_BASE_CLASS(klass);
> +
> +    dc->vmsd =3D &vu_spi_vmstate;
> +    device_class_set_props(dc, vspi_properties);
> +    device_class_set_parent_realize(dc, vspi_realize,
> +                                    &vubc->parent_realize);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo vu_spi_info =3D {
> +    .name =3D TYPE_VHOST_USER_SPI,
> +    .parent =3D TYPE_VHOST_USER_BASE,
> +    .instance_size =3D sizeof(VHostUserSPI),
> +    .class_init =3D vu_spi_class_init,
> +};
> +
> +static void vu_spi_register_types(void)
> +{
> +    type_register_static(&vu_spi_info);
> +}
> +
> +type_init(vu_spi_register_types)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 583a224163..689e2e21e7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -46,6 +46,7 @@
>  #include "standard-headers/linux/virtio_iommu.h"
>  #include "standard-headers/linux/virtio_mem.h"
>  #include "standard-headers/linux/virtio_vsock.h"
> +#include "standard-headers/linux/virtio_spi.h"
>=20=20
>  /*
>   * Maximum size of virtio device config space
> @@ -194,7 +195,8 @@ const char *virtio_device_names[] =3D {
>      [VIRTIO_ID_PARAM_SERV] =3D "virtio-param-serv",
>      [VIRTIO_ID_AUDIO_POLICY] =3D "virtio-audio-pol",
>      [VIRTIO_ID_BT] =3D "virtio-bluetooth",
> -    [VIRTIO_ID_GPIO] =3D "virtio-gpio"
> +    [VIRTIO_ID_GPIO] =3D "virtio-gpio",
> +    [VIRTIO_ID_SPI] =3D "virtio-spi"
>  };


For the vhost-user-stub bits when split from the headers:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

