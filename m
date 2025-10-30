Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A507CCCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOI3-00065O-Pa; Thu, 30 Oct 2025 04:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vEOHo-00062d-GR
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:45:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vEOHg-000735-O1
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:45:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso214573066b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761813920; x=1762418720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvVXyXEC4ouHlK09pYRWE6ZpgOz26EbhsqkkpB7UII4=;
 b=GVTH98b5Al20JTXrzjHExIg2ZwthOFyaYToIcVXQr2riTrwBvKEpVi0xQTbbS5q9r4
 tRAW/IPHFxgyjoV/i+kQK+aySnMCPjptqObXlG/8Cs0g7EiF1U52iWiN1B7ChAvm1wMj
 rtAIbR1z2gptFkZ1aUvjFPdFsSBj22LoqzpSVd1DRBn0Y8kOs0k4sMdo/yqBA3yuY7ZE
 mfwGjqHIhoqhgwpVn8AdXxhmWhR4v9nECnCkHgQdvDzeGXT7INT8zEUKtEGIEL3Z+BHG
 bmcwwOef9jNRadLwEwdPZj12hb3Xh90lfpHQ3H2mh7qOW2vr4zRSNmhEJQn5+UTunXox
 GVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813920; x=1762418720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvVXyXEC4ouHlK09pYRWE6ZpgOz26EbhsqkkpB7UII4=;
 b=F98PbEJ5riOlax0+JqrClzSivcyWq/mEXr6DLxScNAeiks5vbHFWMFm+3ZafaxeulE
 yUkM1yhY2OKw7+JNv4VIZGcr3PlHvEhV8oUEdKtvqG7vriQ0cakq3cXxqQEdTjNI9mXu
 BBDjx6x4/OZNx50nrN520OQZNI1sdIxM3prCeEi+jOuD1k1m3yR8PVgGP/YqFiBUfK67
 vhN8iL59kDzA+RCuga8hVdDnX4pcHjnnRmJ2GD+k/WseOr2b2QACNEfqrsL6z5r50eHY
 1vDRyzDeOuCrYvXZrCjtZj/0yhfacuNH6LSN+8nQ7K0TeEMa3+8rJ6ogvdETE1kgxds1
 Ue7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0gJ+/Iaw8FZ6nCKsy/Hg9i0wSKhpUv0tNQEkEsuweEKOtwqEu3v5NKi9Wb5XFZKlBOF1WxLG1jtcQ@nongnu.org
X-Gm-Message-State: AOJu0YymVwdrij4l81g82NJ9Na/LwT+PEUREkpHOrQaF1r77lvh8jjU6
 99eXMUbVEDb7RIOe49PAPf/lDwzSMgV0zvdsHMnjT8cDoOqrru/bJQqJRqz0I2NDOaKpH4h0k3S
 zBdzxCxsyZI6KmmfKKLr/um+9WMt1Z6BRf7oWPsSvAg==
X-Gm-Gg: ASbGnctwik/LD96Wu92GYzIs/HF0HuaaK+B/n+BcU4g2rWh+SDAhiUbh1jJISYIPXbD
 EktrijNYnpARHbvHQsZYAXdET69zt1oEHV9HpRM1nwfDb5+tqQYXde7h+6kgsMv6IYWNRHITkSv
 oZjDmYYgNVzzih/A5m+YPsUXHyMmAnHStXX3vK5FBcwMZkMyW115suODOTdJ38N2XApiIxCKLDZ
 1dCeKODqywDqKUKdcn5BP7cu7KHt5LpPaVJn3cIPR8yJ20gtGQX+kYmTnv7
X-Google-Smtp-Source: AGHT+IHXtr4ZdVd8KTDcQOU6kw8s2Np0hWDtoCk+2JcfChGHtxnpCwfpktQHDppYOCTSQgPHVHcGGWKSZDMCOFA2AVU=
X-Received: by 2002:a17:907:3d8e:b0:b5c:6e0b:3706 with SMTP id
 a640c23a62f3a-b70520b308dmr346542566b.13.1761813919928; Thu, 30 Oct 2025
 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251030083413.1532360-1-quic_haixcui@quicinc.com>
 <20251030083413.1532360-4-quic_haixcui@quicinc.com>
In-Reply-To: <20251030083413.1532360-4-quic_haixcui@quicinc.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 30 Oct 2025 10:44:53 +0200
X-Gm-Features: AWmQ_bk5t31587Dc6kgLiC6KnCQtXCGDEPD2uLcusEBW_gnKPz09cDf9ByA8was
Message-ID: <CAAjaMXYRpRXxGcGA9B5=56=tgHNjCyaiWpJ7wQj4RHGXe24XLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtio-spi: Add vhost-user-spi device support
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: alex.bennee@linaro.org, viresh.kumar@linaro.org, quic_tsoni@quicinc.com, 
 qemu-devel@nongnu.org, mst@redhat.com, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Thu, Oct 30, 2025 at 10:34=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.co=
m> wrote:
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
> ---
>  MAINTAINERS                               |  6 ++
>  docs/system/devices/virtio/vhost-user.rst |  3 +
>  hw/virtio/Kconfig                         |  5 ++
>  hw/virtio/meson.build                     |  3 +
>  hw/virtio/vhost-user-spi-pci.c            | 69 +++++++++++++++++++++++
>  hw/virtio/vhost-user-spi.c                | 65 +++++++++++++++++++++
>  hw/virtio/virtio.c                        |  4 +-
>  include/hw/virtio/vhost-user-spi.h        | 25 ++++++++
>  8 files changed, 179 insertions(+), 1 deletion(-)
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
> diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devi=
ces/virtio/vhost-user.rst
> index f556a840e9..2806d81ca2 100644
> --- a/docs/system/devices/virtio/vhost-user.rst
> +++ b/docs/system/devices/virtio/vhost-user.rst
> @@ -58,6 +58,9 @@ platform details for what sort of virtio bus to use.
>    * - vhost-user-vsock
>      - Socket based communication
>      - `vhost-device-vsock <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-vsock>`_
> +  * - vhost-user-spi
> +    - Proxy spi devices to host
> +    - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree/m=
ain/vhost-device-spi>`_
>
>  The referenced *daemons* are not exhaustive, any conforming backend
>  implementing the device and using the vhost-user protocol should work.
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

I unfortunately cannot test it since the rust-vmm daemon requires a
host SPI device, but LGTM

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

