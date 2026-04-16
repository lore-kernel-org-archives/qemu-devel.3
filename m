Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67946F433FE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDH4l-0006LN-LS; Thu, 16 Apr 2026 03:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDH4j-0006LB-Hc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:23:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDH4g-0004NN-C7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:23:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d572f7437so4799056f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776324220; cv=none;
 d=google.com; s=arc-20240605;
 b=Sc0/B/bxD4sQ65yD2Z9S9K1N6xNO2FfBKibHtg8v3M6ZgwMByzVjD4yk1j9ihKPSvZ
 tbLKOnz/ivlA/sIqA+AYV3j8Fw+JMj5xeryqQgVtSizXlSKv2qKp96//XwAKeCvibTaA
 0GUL3QgtNuYrFzLV3Er3skWBq5YsGqos7PN6GCaBhebQ6iZ6I7Cf2bNuOLE5Y/rktHzo
 /ta+sXNNOIXRP1hIynt+lnvCJ6jzX6uRCTK4N5DwfTwWPh/fvu5Fyass1tEvJMaSIkxz
 dkxrG4mStLTJSvyFGfWddbKwxjGUhAbRtYfbFHkKOi+iYC9s6D6lqqhpSPtWWlgK4pqy
 wjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=98VW48OvCZt4Y1KolkSz4s8/iC9l/QVZlDk3uXBYNS4=;
 fh=twGKalWFE6mAUg76ntPFb2qzAJ/rF1XSn+WP06v4Mko=;
 b=J/fhBzQag/fl/e5ZLPJfzjhqaDuinj8QApGQxjLcatIJMvmck6RInFquV0PUsr7Jlu
 48AVOV4o1bkEJqw9yB/t0uZruxUEbVgUKeG3mLzWecfoQ6BBloWfQtVWx+4YvCyvrL0o
 3DM0G/tPC1EKf8oE0zIaODXKJoClhyhun3pd6FHT39LcO0ctu96tUFtsi59l8I0AwAwt
 Quwn0tDJjtc7hhW2iDFpjKPopZF9SYYfjSP0EutiT+Ha1g8t1rXRjf8oQ1fZK+vq4cGV
 VRhXqkhyevmt0BIaIJ8Wpqt57WL4xa7Xsj0Fb2Blj2xSNmPqq78lk3rhDzAJ0418VA3P
 2gXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776324220; x=1776929020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98VW48OvCZt4Y1KolkSz4s8/iC9l/QVZlDk3uXBYNS4=;
 b=vQtwX7uMJP9Ud0mlO4UdNGaTRonsdPZ3JHaXXTPOkoabEwOTKasTd4/zD7kXfdTaOy
 KGGClk75V97FX1IEvb9PId/trtelM8YXKg4mryhF9n5hKwk9YhmLZv/dM0L8t8BcxoUv
 ahW9By41pHfmL1aivSOxAEpoWIFrT93MQz5FzHlpPai5XmWtTMzDDZ4NvbO0gkw4mi+Y
 MPsCXIPLenChLT8AwslWxIo1qbs+GDYhrXlbw9dApDIw0rfODMFh+VBZBbLoxKHi0qFj
 Ga7oKJp7TMtwlY790Rszk5zIdJzWxuXz3TdE7pJrx6SiLFgR/gt6ni5ruBtzlPHRE0BP
 MxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324220; x=1776929020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=98VW48OvCZt4Y1KolkSz4s8/iC9l/QVZlDk3uXBYNS4=;
 b=fict0GDa0yIi9+3IerL28Yoqa/XiruzhasNctWOeapwB/rOSdJbRYhjzZ2hM1Jtjld
 ouQFeYDgzKelwzVH6q9f3FxJGxQVZVCvVmJpwW0Etk/hioVy9L2odANrJRD9O8iV3SZr
 q/t88YI1umdcRvhvKb6W1T4+WnMBk2juMG5WLfeiAblAIVvI6DkASDjm/yXU7U1x52w4
 ZhOEJx8jwjbq+jBDmC1o8Vp5k1CqKAZ95z28YA7/yAHBTyNZqkYQKYd8qOUZ2cQmHbaH
 d1y0PEk6BpCOkJdQw1/TJi7fdo5JR82ZXVEYPhHf8csy00xNGXaoizte+3UKx2fMQb1B
 2ByA==
X-Gm-Message-State: AOJu0YzzIiOEnc0y/dcJ6mY7fLe8lABqmhMcv8UVGGap/MBHafBRCIXj
 Q7v22rIbGYdGRAVvIw9o4A2uua/EUaA+U58u04BuSsoeZGUdpqz7omClD9q+87NoTGosaWp/lTm
 w6+tTKtqajEibEZa0nhaGh9rtDKjhsYZz7oCoa4g2MuSRI3qkICEwKWo=
X-Gm-Gg: AeBDievxZdU4+wpQQdktV6D76iNlwGRHd6al1ZQYk5ekGU0J8lhwKlkwCXfA685U6Tk
 JXJAy35ovp1EDnOEntO0RQVetOnPAtAr49ErnqnyBXCtlS/MWGRfByxs7cFirzOYvWnF29Qoflq
 au4kh3BH2dZIxbrdg1DFIschHNeeHjIPXQ0SeIQRTBRYblZvTYW1Moi8i0NUkcY2ry8eC1v8XIF
 GviwGxy51xmRpgXmyoUJi0oQwm5Z6t6AAapbJdeA09VDZRzdPj/YArUVeWF8e8Y5czv7NwFu0u4
 Kl7sDB5AizxdwxENOonyW0kQit8/i2/i/5mhUS88ea10+9xl9d+Q
X-Received: by 2002:a05:6000:400e:b0:43d:1c39:26fd with SMTP id
 ffacd0b85a97d-43d642dc79bmr37029675f8f.43.1776324220336; Thu, 16 Apr 2026
 00:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-vhost-user-rtc-v1-1-1b2d44f0c889@linaro.org>
 <aeCNR5CmtcbuNRm_@redhat.com>
In-Reply-To: <aeCNR5CmtcbuNRm_@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 16 Apr 2026 10:23:12 +0300
X-Gm-Features: AQROBzD0cWyfCmVPwiu8jWzAHo3-0BZ-DiXYpKjDRO_HMZ0UI8P4tPKd9zSzDok
Message-ID: <CAAjaMXbUBka_r-=vP-gvywS9CqT6F-0q+x5G5qx3PUmRgbmLgQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?B?TWl0c3V5YSBJa3V5YSAo5LiJ44OE5bGLIOmDgeWTiSk=?=
 <mitsuya.ikuya@jp.panasonic.com>, 
 =?UTF-8?B?S1VaVSBLQVpVS0kgKOiRm+eUnyDkuIDmqLkp?=
 <kuzu.kazuki@jp.panasonic.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Thu, Apr 16, 2026 at 10:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
>
> Missing commit message.....


Commit title is self-explanatory.

>
>
> On Thu, Apr 16, 2026 at 08:54:40AM +0300, Manos Pitsidianakis wrote:
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  include/hw/virtio/vhost-user-rtc.h        | 22 ++++++++++
> >  MAINTAINERS                               |  6 +++
> >  docs/system/devices/virtio/vhost-user.rst |  3 ++
> >  hw/virtio/Kconfig                         |  5 +++
> >  hw/virtio/meson.build                     |  3 ++
> >  hw/virtio/vhost-user-rtc-pci.c            | 70 +++++++++++++++++++++++=
++++++++
> >  hw/virtio/vhost-user-rtc.c                | 64 +++++++++++++++++++++++=
+++++
> >  7 files changed, 173 insertions(+)
> >
> > diff --git a/include/hw/virtio/vhost-user-rtc.h b/include/hw/virtio/vho=
st-user-rtc.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..6b7b53c28f93032886d8268=
7199585aba0edd917
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-user-rtc.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * Vhost-user RTC virtio device
> > + *
> > + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.=
org>
> > + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
>
> This commit is only signed off by yourself, as @linaro.org but the
> newest copyright is from Panasonic.  What is the situation with
> authorship here ?
>
> If it was co-authored by people from multiple companies then I'd
> expect to see multiple signed-off-bys, so that each company is
> represented.


It is authored solely by me for Panasonic, but based on existing
vhost-user devices I wrote in 2025, so the copyright is mixed.


>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef QEMU_VHOST_USER_RTC_H
> > +#define QEMU_VHOST_USER_RTC_H
> > +
> > +#include "hw/virtio/vhost-user-base.h"
> > +
> > +#define TYPE_VHOST_USER_RTC "vhost-user-rtc"
> > +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRTC, VHOST_USER_RTC)
> > +
> > +struct VHostUserRTC {
> > +    VHostUserBase parent_obj;
> > +};
> > +
> > +#endif /* QEMU_VHOST_USER_RTC_H */
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ad215eced84d1ac58956ea374ee012acbb3cbd18..da6376b0f5e6fa99495504e=
88da9fef5a7a969e3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2573,6 +2573,12 @@ S: Maintained
> >  F: include/hw/virtio/vhost-user-spi.h
> >  F: hw/virtio/vhost-user-spi*
> >
> > +vhost-user-rtc
> > +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +S: Supported
> > +F: include/hw/virtio/vhost-user-rtc.h
> > +F: hw/virtio/vhost-user-rtc*
> > +
> >  virtio-crypto
> >  M: Gonglei <arei.gonglei@huawei.com>
> >  S: Supported
> > diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/de=
vices/virtio/vhost-user.rst
> > index 2806d81ca201551a91246a10e0d98fd36d74200b..acfbd609d0f9c87e3af6847=
97adf156a8a61bc88 100644
> > --- a/docs/system/devices/virtio/vhost-user.rst
> > +++ b/docs/system/devices/virtio/vhost-user.rst
> > @@ -61,6 +61,9 @@ platform details for what sort of virtio bus to use.
> >    * - vhost-user-spi
> >      - Proxy spi devices to host
> >      - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-spi>`_
> > +  * - vhost-user-rtc
> > +    - Real time clock
> > +    - `vhost-device-rtc <https://github.com/rust-vmm/vhost-device/tree=
/main/vhost-device-rtc>`_
> >
> >  The referenced *daemons* are not exhaustive, any conforming backend
> >  implementing the device and using the vhost-user protocol should work.
> > diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> > index 8895682c619402eb3c9cd7269d3319f39711b4bd..2ebdac16b31aec3ec283c02=
85a4dcfa67f0a5157 100644
> > --- a/hw/virtio/Kconfig
> > +++ b/hw/virtio/Kconfig
> > @@ -136,3 +136,8 @@ config VHOST_USER_TEST
> >      bool
> >      default y
> >      depends on VIRTIO && VHOST_USER
> > +
> > +config VHOST_USER_RTC
> > +    bool
> > +    default y
> > +    depends on VIRTIO && VHOST_USER
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index 415e359e9fc79b6b1adbbcfc4f87a7106ef1d4a6..e0566a60de7989c4048956e=
268f151659467fe34 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -27,6 +27,7 @@ if have_vhost
> >      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files=
('vhost-user-snd.c'))
> >      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: fil=
es('vhost-user-input.c'))
> >      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files=
('vhost-user-spi.c'))
> > +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RTC', if_true: files=
('vhost-user-rtc.c'))
> >
> >      # PCI Stubs
> >      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USE=
R_TEST'],
> > @@ -43,6 +44,8 @@ if have_vhost
> >                           if_true: files('vhost-user-input-pci.c'))
> >      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USE=
R_SPI'],
> >                           if_true: files('vhost-user-spi-pci.c'))
> > +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USE=
R_RTC'],
> > +                         if_true: files('vhost-user-rtc-pci.c'))
> >    endif
> >    if have_vhost_vdpa
> >      system_virtio_ss.add(files('vhost-vdpa.c'))
> > diff --git a/hw/virtio/vhost-user-rtc-pci.c b/hw/virtio/vhost-user-rtc-=
pci.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..449368d27009acde20aa4af=
2542a912ac8b82cbc
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-rtc-pci.c
> > @@ -0,0 +1,70 @@
> > +/*
> > + * Vhost-user RTC virtio device PCI glue
> > + *
> > + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.=
org>
> > + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/virtio/vhost-user-rtc.h"
> > +#include "hw/virtio/virtio-pci.h"
> > +
> > +struct VHostUserRTCPCI {
> > +    VirtIOPCIProxy parent_obj;
> > +    VHostUserRTC vdev;
> > +};
> > +
> > +typedef struct VHostUserRTCPCI VHostUserRTCPCI;
> > +
> > +#define TYPE_VHOST_USER_RTC_PCI "vhost-user-rtc-pci-base"
> > +
> > +DECLARE_INSTANCE_CHECKER(VHostUserRTCPCI, VHOST_USER_RTC_PCI,
> > +                         TYPE_VHOST_USER_RTC_PCI)
> > +
> > +static void vhost_user_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error=
 **errp)
> > +{
> > +    VHostUserRTCPCI *dev =3D VHOST_USER_RTC_PCI(vpci_dev);
> > +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> > +
> > +    vpci_dev->nvectors =3D 1;
> > +
> > +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +}
> > +
> > +static void vhost_user_rtc_pci_class_init(ObjectClass *klass, const vo=
id *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> > +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> > +    k->realize =3D vhost_user_rtc_pci_realize;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> > +    pcidev_k->device_id =3D 0; /* Set by virtio-pci based on virtio id=
 */
> > +    pcidev_k->revision =3D 0x00;
> > +    pcidev_k->class_id =3D PCI_CLASS_SYSTEM_RTC;
> > +}
> > +
> > +static void vhost_user_rtc_pci_instance_init(Object *obj)
> > +{
> > +    VHostUserRTCPCI *dev =3D VHOST_USER_RTC_PCI(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VHOST_USER_RTC);
> > +}
> > +
> > +static const VirtioPCIDeviceTypeInfo vhost_user_rtc_pci_info =3D {
> > +    .base_name =3D TYPE_VHOST_USER_RTC_PCI,
> > +    .non_transitional_name =3D "vhost-user-rtc-pci",
> > +    .instance_size =3D sizeof(VHostUserRTCPCI),
> > +    .instance_init =3D vhost_user_rtc_pci_instance_init,
> > +    .class_init =3D vhost_user_rtc_pci_class_init,
> > +};
> > +
> > +static void vhost_user_rtc_pci_register(void)
> > +{
> > +    virtio_pci_types_register(&vhost_user_rtc_pci_info);
> > +}
> > +
> > +type_init(vhost_user_rtc_pci_register);
> > diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..88b0c70b903363fc9ac7ccb=
65a1b1755e095c6bc
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-rtc.c
> > @@ -0,0 +1,64 @@
> > +/*
> > + * Vhost-user RTC virtio device
> > + *
> > + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.=
org>
> > + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
> > + *
> > + * Simple wrapper of the generic vhost-user-device.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/virtio/vhost-user-rtc.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +
> > +static const VMStateDescription vu_rtc_vmstate =3D {
> > +    .name =3D "vhost-user-rtc",
> > +    .unmigratable =3D 1,
> > +};
> > +
> > +static const Property vrtc_properties[] =3D {
> > +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> > +};
> > +
> > +static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > +    VHostUserBaseClass *vubs =3D VHOST_USER_BASE_GET_CLASS(dev);
> > +
> > +    vub->virtio_id =3D VIRTIO_ID_CLOCK;
> > +    vub->num_vqs =3D 2;
> > +    vub->config_size =3D 0;
> > +    vub->vq_size =3D 1024;
> > +
> > +    vubs->parent_realize(dev, errp);
> > +}
> > +
> > +static void vu_rtc_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VHostUserBaseClass *vubc =3D VHOST_USER_BASE_CLASS(klass);
> > +
> > +    dc->vmsd =3D &vu_rtc_vmstate;
> > +    device_class_set_props(dc, vrtc_properties);
> > +    device_class_set_parent_realize(dc, vu_rtc_base_realize,
> > +                                    &vubc->parent_realize);
> > +
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +}
> > +
> > +static const TypeInfo vu_rtc_info =3D {
> > +    .name =3D TYPE_VHOST_USER_RTC,
> > +    .parent =3D TYPE_VHOST_USER_BASE,
> > +    .instance_size =3D sizeof(VHostUserRTC),
> > +    .class_init =3D vu_rtc_class_init,
> > +};
> > +
> > +static void vu_rtc_register_types(void)
> > +{
> > +    type_register_static(&vu_rtc_info);
> > +}
> > +
> > +type_init(vu_rtc_register_types)
> >
> > ---
> > base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> > change-id: 20260416-vhost-user-rtc-ce8ff0377356
> >
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>



--
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

