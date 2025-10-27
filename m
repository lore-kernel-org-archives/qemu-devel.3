Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4274CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLhl-0007pq-Vj; Mon, 27 Oct 2025 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLhi-0007nc-9t
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:48:04 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLhc-0007OD-7F
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:48:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c3c7d3d53so6909415a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761565672; x=1762170472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFI81I62K4Q3kbrq7ZnN7xnBndnVGylk+wBKfPvi4qw=;
 b=jN3ss7F30FgIYmmw5uHme6EEBrrLtH2DM/FXIa6LA5wxv5K5Vv3yYvxlX6J53HC59M
 OM4pAc7xBJMpzgDi9EwntCA59U0cWaKZF3EQSeWHYHG9RZ6YIUDq9FyaN6hXdARVbpEf
 uPQZuFsX5wqbZHD7xGNXHVdOWY3qQyF5x4s8lfMhJQraL5Qhzv+5MR8fGYzvZ5FCMDuB
 9bkySe5W+fqCqCqCFzrq++XMUS8f6Zo/JsxmdXzoD3CSx5XuoFiz3ndWR8MZik//DST2
 iSPD46WKTI8ogPB5q1zObHuiFyoLh2oekRDDqWg3XIrm3UZc0JZGFhwDUbxVqAL575RC
 NAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761565672; x=1762170472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFI81I62K4Q3kbrq7ZnN7xnBndnVGylk+wBKfPvi4qw=;
 b=Pb+NZFgkW+7DHZJSIHJApRCqc3zKQUvj4BySlMdq6iSVpZsijEM4FOJaTei1xeGSTJ
 xOy8e6CTqvyImH5ScS++moiK727KsUbTcLKVammSA5JNwm65J46NtX2rmpQ71h4GRxAF
 vLQc3ndeI1t/AwHhgxi5JmVKjvtycxxsS3nqGUmiKgf1eNPzfvjvCShWRuWg69PrRwcp
 WBxSWbMkRI99b+0ANDfIkrJ8j0ZUx58eGPOC/Id6hOpV39f8CIXyRkmGAvy6JNMSwH+8
 SH4mqfouA+5mCTXTmk0GVSL3vjvSz746CGn23wi74sxiWUovZojlZRKxSm+TDNWI2GJi
 7Z+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOuxpnfDE0yn1M22813yDLFCd/gv/9YdgfY/Cbcp/Nkcy6wOoNZlED2f6KSzRAUFZJ3vcbOtXlUcZj@nongnu.org
X-Gm-Message-State: AOJu0YzsuBjmxtgNp0XpIaPcEP9tIdZ2QYGf2S8cZGsyF0dv4xVeKQe9
 j7tLD9wbUfjzTqKv7A+JcZf7XBubL1kmonWyEt9M3QZIybU57ub2wA3YIv+ixffFYHHJSMWqViu
 9Uzbca92UHRmfA45BY+mewU6X1khyZUbAlwGoFXWlgwZWpy9K2RpbHpg=
X-Gm-Gg: ASbGncuR2UMeu9CnEbDowHoU6oHRYBXGGCJNQBbGUEivXfCHAyOpv3vFI039gOGEC7S
 xaJn9a7s9Umq43FFUUxg1Y463KL8ajDu/EpuYL35Zv0BLe1oT/sKnrgkGvn64DBvsXuDQSYrAdo
 dVsQhZKiojQeeD/NCUAUNLMZOU5AEAmURQjrA6HrsnuwUlt7UNyoleWLgCeVugga3vTizbjQ6q0
 iRyEdr3GRFGTuZUZFQoL+cUa1mKQLtGiqUh9iYvXYiasQiE+jE2sy7cerjzeQ==
X-Google-Smtp-Source: AGHT+IGC2EA8knIU2yPngnJugfDYwJPIsmqZesn1wnLqAx2rjzVkjNQkZwI7QIX9x3duOqYVp3og8O2sHCMzr0KEoLQ=
X-Received: by 2002:a05:6402:1941:b0:639:ea57:44f2 with SMTP id
 4fb4d7f45d1cf-63e6007f18amr9025027a12.24.1761565672130; Mon, 27 Oct 2025
 04:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
 <20251027075123.2237914-4-quic_haixcui@quicinc.com>
In-Reply-To: <20251027075123.2237914-4-quic_haixcui@quicinc.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 27 Oct 2025 13:47:26 +0200
X-Gm-Features: AWmQ_bmwSuBbtbdGrYu6Pqy6TzZ0tB1LfCDcDxwg0nVn1EYIMzI8dRXd5HqDRBc
Message-ID: <CAAjaMXY9roe5z_tZmrW46LqPgB+ERhaE+47rg6c0YwJQnQ1w1Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] virtio-spi: Add vhost-user-spi device support
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: alex.bennee@linaro.org, viresh.kumar@linaro.org, quic_tsoni@quicinc.com, 
 qemu-devel@nongnu.org, mst@redhat.com, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, Oct 27, 2025 at 9:52=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.com=
> wrote:
>
> This patch introduces support for vhost-user-spi and vhost-user-spi-pci
> devices in QEMU, enabling virtio-based SPI communication via the vhost-us=
er
> protocol.
>
> The implementation follows the virtio-spi specification and leverages
> the upstream virtio-spi driver in Linux. Relevant references:
>
> - Virtio SPI specification:
>   https://github.com/oasis-tcs/virtio-spec/tree/master/device-types/spi
> - Linux virtio-spi driver:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/spi/spi-virtio.c?h=3Dv6.18-rc3
> - vhost-user-spi daemon:
>   https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi
>
> Example usage with rust-vmm vhost-user-spi daemon:
>
> Start the vhost-user-spi daemon:
>     vhost-device-spi --socket-path=3Dvspi.sock --socket-count=3D1 \
>         --device "/dev/spidev0.0"
>
> Launch QEMU with:
>     qemu-system-aarch64 -m 1G \
>         -chardev socket,path=3D/home/root/vspi.sock0,id=3Dvspi \
>         -device vhost-user-spi-device,chardev=3Dvspi,id=3Dspi \
>         -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/sh=
m,share=3Don \
>         -numa node,memdev=3Dmem
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

LGTM

You should also update docs/system/devices/vhost-user.rst with an entry.

> ---
>  MAINTAINERS                        |  6 +++
>  hw/virtio/Kconfig                  |  5 +++
>  hw/virtio/meson.build              |  3 ++
>  hw/virtio/vhost-user-spi-pci.c     | 69 ++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user-spi.c         | 65 ++++++++++++++++++++++++++++
>  hw/virtio/virtio.c                 |  4 +-
>  include/hw/virtio/vhost-user-spi.h | 25 +++++++++++
>  7 files changed, 176 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/vhost-user-spi-pci.c
>  create mode 100644 hw/virtio/vhost-user-spi.c
>  create mode 100644 include/hw/virtio/vhost-user-spi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f33f95ceea..9ce2e16140 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2520,6 +2520,12 @@ F: hw/virtio/vhost-user-scmi*
>  F: include/hw/virtio/vhost-user-scmi.h
>  F: tests/qtest/libqos/virtio-scmi.*
>
> +vhost-user-spi
> +M: Haixu Cui <quic_haixcui@quicinc.com>
> +S: Maintained
> +F: include/hw/virtio/vhost-user-spi.h
> +F: hw/virtio/vhost-user-spi*
> +
>  virtio-crypto
>  M: Gonglei <arei.gonglei@huawei.com>
>  S: Supported
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 10f5c53ac0..8895682c61 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -127,6 +127,11 @@ config VHOST_USER_SCMI
>      default y
>      depends on VIRTIO && VHOST_USER && ARM
>
> +config VHOST_USER_SPI
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> +
>  config VHOST_USER_TEST
>      bool
>      default y
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index affd66887d..6675b63ce6 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -28,6 +28,7 @@ if have_vhost
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('=
vhost-user-rng.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('=
vhost-user-snd.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files=
('vhost-user-input.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('=
vhost-user-spi.c'))
>
>      # PCI Stubs
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
TEST'],
> @@ -42,6 +43,8 @@ if have_vhost
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
> index 0000000000..095aba5760
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi-pci.c
> @@ -0,0 +1,69 @@
> +/*
> + * Vhost-user spi virtio device PCI glue
> + *
> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserv=
ed.
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
> +static void vhost_user_spi_pci_class_init(ObjectClass *klass, const void=
 *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +    k->realize =3D vhost_user_spi_pci_realize;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D 0; /* Set by virtio-pci based on virtio id *=
/
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
> index 0000000000..0d44dec46a
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi.c
> @@ -0,0 +1,65 @@
> +/*
> + * Vhost-user spi virtio device
> + *
> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserv=
ed.
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
> +static const Property vspi_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
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
> +static void vu_spi_class_init(ObjectClass *klass, const void *data)
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
> index 153ee0a0cf..242b95e702 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -48,6 +48,7 @@
>  #include "standard-headers/linux/virtio_iommu.h"
>  #include "standard-headers/linux/virtio_mem.h"
>  #include "standard-headers/linux/virtio_vsock.h"
> +#include "standard-headers/linux/virtio_spi.h"
>
>  /*
>   * Maximum size of virtio device config space
> @@ -196,7 +197,8 @@ const char *virtio_device_names[] =3D {
>      [VIRTIO_ID_PARAM_SERV] =3D "virtio-param-serv",
>      [VIRTIO_ID_AUDIO_POLICY] =3D "virtio-audio-pol",
>      [VIRTIO_ID_BT] =3D "virtio-bluetooth",
> -    [VIRTIO_ID_GPIO] =3D "virtio-gpio"
> +    [VIRTIO_ID_GPIO] =3D "virtio-gpio",
> +    [VIRTIO_ID_SPI] =3D "virtio-spi"
>  };
>
>  static const char *virtio_id_to_name(uint16_t device_id)
> diff --git a/include/hw/virtio/vhost-user-spi.h b/include/hw/virtio/vhost=
-user-spi.h
> new file mode 100644
> index 0000000000..a1a65820cd
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-spi.h
> @@ -0,0 +1,25 @@
> +/*
> + * Vhost-user spi virtio device
> + *
> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All Rights Reserv=
ed.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_VHOST_USER_SPI_H
> +#define QEMU_VHOST_USER_SPI_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +#include "hw/virtio/vhost-user-base.h"
> +
> +#define TYPE_VHOST_USER_SPI "vhost-user-spi-device"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSPI, VHOST_USER_SPI)
> +
> +struct VHostUserSPI {
> +    VHostUserBase parent_obj;
> +};
> +
> +#endif /* QEMU_VHOST_USER_SPI_H */
> --
> 2.34.1
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

