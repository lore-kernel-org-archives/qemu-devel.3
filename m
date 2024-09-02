Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0128BCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl46I-0001Fe-Mq; Mon, 02 Sep 2024 06:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl46G-0001F1-Pq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:15:56 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl46E-00061Z-9Z
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:15:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a16c53d3cso23195766b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725272152; x=1725876952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZr3mrKyn4BTtG7LjvSQKE3DKxX8O1/xmFD/LBeK8X4=;
 b=rcl9+M9ZAXLBabdnuDCM5CHc5QOW5IZiWNHIBHrVXrh9JQARKXU43HFuQ42VTvPn+U
 AJ6gQCSyvhVR9ccYeJ6StiZZ8bawCCnkZ2SFyxNd+v0oHb936m5ESOPrWdwV6nvDCB+9
 NgzLYnZKhmehmVP44q3NxE3kaoLIp1+L2dPXk5W8jNY1xGR3Pa3s2Y/uC2S2VPzYzVaU
 J8P7ADrotJ4T1a3h7Z1IMAay+BUwozmxBrV6yQQq0xire3j+7BXj83JJOGjDwv2FyhKw
 sVLmSYrujz/bnWQ2CbcclP+MOkkbEPHcyfhxrNGB1YeWRPAbsCGDHCRr1uaMMUSaK8Q+
 l01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725272152; x=1725876952;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EZr3mrKyn4BTtG7LjvSQKE3DKxX8O1/xmFD/LBeK8X4=;
 b=fWgbEYJD6o0ufrCg/eMJhyT4c+Y7kNZYrA3UjQw4KJbTwCB0j6sxSgqVn9M6OLehmw
 iSTQxnI0/CvOmHb6jGEDbyWehyWWy/xMaPUlVkRj7VlEPoyjLWJVUw7W/aoS4Vg70eUZ
 NgEgj3hCNyHTNMxRL1//e9Vz942p9Vk1buyJ9CkZRMvx1VRQVoDuRVqvq3KEqprmd+nP
 C/BC0yS6mJHm4ZVfZRofbA4L7aRnRfaAyTkVbiYcqEFUBczhtgT7o35P1SWPxKVnTBaj
 WFUtyRN3WX5ZkOof2dm8NjVCmvqMmXI7ZSoB7lpD+L9HeSwMLhLFgjrOSxf5U5PoRYem
 QQOQ==
X-Gm-Message-State: AOJu0Yze140qcFtgFJq9T8SUyhKavDfZNCXePAgCCln8S17a4FH6qMjD
 ApPMC/1r6GRJXuFU62SxHRyDCN9RJDJUTmyIJxRatiZNzVDjUlFcjzzdEp3CDK0=
X-Google-Smtp-Source: AGHT+IHoDBH2xilS5dBz5HxNuDhYHsklYdM6Mo2eqkEWW/H39G26fkNtocdsTvlE7d+xoxLyqIxzSw==
X-Received: by 2002:a17:907:720a:b0:a86:82e2:8c64 with SMTP id
 a640c23a62f3a-a897f8e2bb0mr1119805366b.35.1725272151695; 
 Mon, 02 Sep 2024 03:15:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989215cb5sm536092366b.191.2024.09.02.03.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 03:15:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3ED275F835;
 Mon,  2 Sep 2024 11:15:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <qemu-devel@nongnu.org>,  <viresh.kumar@linaro.org>,
 <quic_ztu@quicinc.com>,  <quic_tsoni@quicinc.com>
Subject: Re: [PATCH] Add vhost-user-spi and vhost-user-spi-pci devices
In-Reply-To: <944cb43a-e578-4102-9d8d-8cea475455f0@quicinc.com> (Haixu Cui's
 message of "Mon, 2 Sep 2024 16:57:08 +0800")
References: <20240712034246.2553812-1-quic_haixcui@quicinc.com>
 <8734mp6g81.fsf@draig.linaro.org>
 <944cb43a-e578-4102-9d8d-8cea475455f0@quicinc.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 11:15:50 +0100
Message-ID: <87v7zecqeh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

> Hi Alex,
>     Thanks a lot for your comments, please refer to my response below.
>
> On 8/28/2024 1:14 AM, Alex Benn=C3=A9e wrote:
>> Haixu Cui <quic_haixcui@quicinc.com> writes:
>> Apologies for the delay in getting to this.
>>=20
>>> This work is based on the virtio-spi spec, virtio-spi driver introduced=
 by
>>> the following patch series:
>>> - https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4/device-types=
/spi
>>> - https://lwn.net/Articles/966715/
>>>
>>> To test with rust-vmm vhost-user-spi daemon, start the vhost-daemon fir=
stly:
>>>      vhost-device-spi --socket-path=3Dvspi.sock --socket-count=3D1 --de=
vice "/dev/spidev0.0"
>> I'm struggling to test this on my main dev box. Are there any dummy
>> SPI
>> modules for the kernel for testing? Otherwise we could consider
>> implementing something similar to "mock_gpio" for the rust-vmm
>> vhost-user-spi backend?
>
> I verified this on my board with physical SPI interface, and I don't
> know if these is dummy SPI module available in kernel. I'll look into
> this.

I'll see if I can boot full Linux into a QEMU machine with SPI devices
which would be another approach.

>>=20
>>> Then invoke qemu with the following parameters:
>>>      qemu-system-aarch64 -m 1G \
>>>          -chardev socket,path=3D/home/root/vspi.sock0,id=3Dvspi \
>>>          -device vhost-user-spi-pci,chardev=3Dvspi,id=3Dspi \
>>>          -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev=
/shm,share=3Don \
>>>          -numa node,memdev=3Dmem
>>>          ...
>>=20
>>>
>>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>>> ---
>>>   hw/virtio/Kconfig                           |   5 +
>>>   hw/virtio/meson.build                       |   3 +
>>>   hw/virtio/vhost-user-spi-pci.c              |  69 ++++++++
>>>   hw/virtio/vhost-user-spi.c                  |  66 +++++++
>>>   hw/virtio/virtio.c                          |   4 +-
>>>   include/hw/virtio/vhost-user-spi.h          |  25 +++
>>>   include/standard-headers/linux/virtio_ids.h |   1 +
>>>   include/standard-headers/linux/virtio_spi.h | 186 ++++++++++++++++++++
>>>   8 files changed, 358 insertions(+), 1 deletion(-)
>>>   create mode 100644 hw/virtio/vhost-user-spi-pci.c
>>>   create mode 100644 hw/virtio/vhost-user-spi.c
>>>   create mode 100644 include/hw/virtio/vhost-user-spi.h
>>>   create mode 100644 include/standard-headers/linux/virtio_spi.h
>> Generally we want separate headers patches for the importing of
>> headers.
>> Doubly so in this case because I can't see the SPI definitions in the
>> current Linux master. So:
>>    - 1/2 - Import headers for SPI (!merge until upstream)
>>    - 2/2 - Implement vhost-user stub for virtio-spi
>>=20
>
> Should I move only virtio_spi.h to the first patch, or all of the
> header files? I don't quite understand here.

Just the kernel headers (include/standard-headers). You should import
the kernel headers from a checked out kernel tree using:

  ./scripts/update-linux-headers.sh <path/to/linux.git>

and save them as a single commit for the 1st patch. As the SPI code is
not yet upstream just make it clear in the commit to avoid merging. e.g.

  linux-headers: update to 6.10-rc5 + SPI patches (!merge)

  This imports the headers from the current Linux HEAD + the VirtIO SPI
  patches which are not yet upstream. Once the SPI work is up-streamed in
  the kernel they will be imported from there.

Just make sure you kernel base is newer than the last import otherwise
you will get a lot of additional noise.

>
> Best Regards
> Thanks
>>=20
>>>
>>> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>>> index aa63ff7fd4..d5857651e5 100644
>>> --- a/hw/virtio/Kconfig
>>> +++ b/hw/virtio/Kconfig
>>> @@ -110,3 +110,8 @@ config VHOST_USER_SCMI
>>>       bool
>>>       default y
>>>       depends on VIRTIO && VHOST_USER
>>> +
>>> +config VHOST_USER_SPI
>>> +    bool
>>> +    default y
>>> +    depends on VIRTIO && VHOST_USER
>>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>> index 621fc65454..42296219e5 100644
>>> --- a/hw/virtio/meson.build
>>> +++ b/hw/virtio/meson.build
>>> @@ -26,6 +26,7 @@ if have_vhost
>>>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: file=
s('vhost-user-rng.c'))
>>>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: file=
s('vhost-user-snd.c'))
>>>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: fi=
les('vhost-user-input.c'))
>>> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files=
('vhost-user-spi.c'))
>>>         # PCI Stubs
>>>       system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('v=
host-user-device-pci.c'))
>>> @@ -39,6 +40,8 @@ if have_vhost
>>>                            if_true: files('vhost-user-snd-pci.c'))
>>>       system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_US=
ER_INPUT'],
>>>                            if_true: files('vhost-user-input-pci.c'))
>>> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USE=
R_SPI'],
>>> +                         if_true: files('vhost-user-spi-pci.c'))
>>>     endif
>>>     if have_vhost_vdpa
>>>       system_virtio_ss.add(files('vhost-vdpa.c'))
>>> diff --git a/hw/virtio/vhost-user-spi-pci.c b/hw/virtio/vhost-user-spi-=
pci.c
>>> new file mode 100644
>>> index 0000000000..3565d526af
>>> --- /dev/null
>>> +++ b/hw/virtio/vhost-user-spi-pci.c
>>> @@ -0,0 +1,69 @@
>>> +/*
>>> + * Vhost-user spi virtio device PCI glue
>>> + *
>>> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reser=
ved.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "hw/virtio/vhost-user-spi.h"
>>> +#include "hw/virtio/virtio-pci.h"
>>> +
>>> +struct VHostUserSPIPCI {
>>> +    VirtIOPCIProxy parent_obj;
>>> +    VHostUserSPI vdev;
>>> +};
>>> +
>>> +typedef struct VHostUserSPIPCI VHostUserSPIPCI;
>>> +
>>> +#define TYPE_VHOST_USER_SPI_PCI "vhost-user-spi-pci-base"
>>> +
>>> +DECLARE_INSTANCE_CHECKER(VHostUserSPIPCI, VHOST_USER_SPI_PCI,
>>> +                         TYPE_VHOST_USER_SPI_PCI)
>>> +
>>> +static void vhost_user_spi_pci_realize(VirtIOPCIProxy *vpci_dev, Error=
 **errp)
>>> +{
>>> +    VHostUserSPIPCI *dev =3D VHOST_USER_SPI_PCI(vpci_dev);
>>> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
>>> +
>>> +    vpci_dev->nvectors =3D 1;
>>> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>>> +}
>>> +
>>> +static void vhost_user_spi_pci_class_init(ObjectClass *klass, void *da=
ta)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
>>> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
>>> +    k->realize =3D vhost_user_spi_pci_realize;
>>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
>>> +    pcidev_k->device_id =3D 0; /* Set by virtio-pci based on virtio id=
 */
>>> +    pcidev_k->revision =3D 0x00;
>>> +    pcidev_k->class_id =3D PCI_CLASS_COMMUNICATION_OTHER;
>>> +}
>>> +
>>> +static void vhost_user_spi_pci_instance_init(Object *obj)
>>> +{
>>> +    VHostUserSPIPCI *dev =3D VHOST_USER_SPI_PCI(obj);
>>> +
>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>>> +                                TYPE_VHOST_USER_SPI);
>>> +}
>>> +
>>> +static const VirtioPCIDeviceTypeInfo vhost_user_spi_pci_info =3D {
>>> +    .base_name =3D TYPE_VHOST_USER_SPI_PCI,
>>> +    .non_transitional_name =3D "vhost-user-spi-pci",
>>> +    .instance_size =3D sizeof(VHostUserSPIPCI),
>>> +    .instance_init =3D vhost_user_spi_pci_instance_init,
>>> +    .class_init =3D vhost_user_spi_pci_class_init,
>>> +};
>>> +
>>> +static void vhost_user_spi_pci_register(void)
>>> +{
>>> +    virtio_pci_types_register(&vhost_user_spi_pci_info);
>>> +}
>>> +
>>> +type_init(vhost_user_spi_pci_register);
>>> diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
>>> new file mode 100644
>>> index 0000000000..e138b8b53b
>>> --- /dev/null
>>> +++ b/hw/virtio/vhost-user-spi.c
>>> @@ -0,0 +1,66 @@
>>> +/*
>>> + * Vhost-user spi virtio device
>>> + *
>>> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reser=
ved.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "hw/virtio/virtio-bus.h"
>>> +#include "hw/virtio/vhost-user-spi.h"
>>> +#include "qemu/error-report.h"
>>> +#include "standard-headers/linux/virtio_ids.h"
>>> +#include "standard-headers/linux/virtio_spi.h"
>>> +
>>> +static Property vspi_properties[] =3D {
>>> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void vspi_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VHostUserBase *vub =3D VHOST_USER_BASE(dev);
>>> +    VHostUserBaseClass *vubc =3D VHOST_USER_BASE_GET_CLASS(dev);
>>> +
>>> +    /* Fixed for SPI */
>>> +    vub->virtio_id =3D VIRTIO_ID_SPI;
>>> +    vub->num_vqs =3D 1;
>>> +    vub->vq_size =3D 4;
>>> +    vub->config_size =3D sizeof(struct virtio_spi_config);
>>> +
>>> +    vubc->parent_realize(dev, errp);
>>> +}
>>> +
>>> +static const VMStateDescription vu_spi_vmstate =3D {
>>> +    .name =3D "vhost-user-spi",
>>> +    .unmigratable =3D 1,
>>> +};
>>> +
>>> +static void vu_spi_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +    VHostUserBaseClass *vubc =3D VHOST_USER_BASE_CLASS(klass);
>>> +
>>> +    dc->vmsd =3D &vu_spi_vmstate;
>>> +    device_class_set_props(dc, vspi_properties);
>>> +    device_class_set_parent_realize(dc, vspi_realize,
>>> +                                    &vubc->parent_realize);
>>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>> +}
>>> +
>>> +static const TypeInfo vu_spi_info =3D {
>>> +    .name =3D TYPE_VHOST_USER_SPI,
>>> +    .parent =3D TYPE_VHOST_USER_BASE,
>>> +    .instance_size =3D sizeof(VHostUserSPI),
>>> +    .class_init =3D vu_spi_class_init,
>>> +};
>>> +
>>> +static void vu_spi_register_types(void)
>>> +{
>>> +    type_register_static(&vu_spi_info);
>>> +}
>>> +
>>> +type_init(vu_spi_register_types)
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 583a224163..689e2e21e7 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -46,6 +46,7 @@
>>>   #include "standard-headers/linux/virtio_iommu.h"
>>>   #include "standard-headers/linux/virtio_mem.h"
>>>   #include "standard-headers/linux/virtio_vsock.h"
>>> +#include "standard-headers/linux/virtio_spi.h"
>>>     /*
>>>    * Maximum size of virtio device config space
>>> @@ -194,7 +195,8 @@ const char *virtio_device_names[] =3D {
>>>       [VIRTIO_ID_PARAM_SERV] =3D "virtio-param-serv",
>>>       [VIRTIO_ID_AUDIO_POLICY] =3D "virtio-audio-pol",
>>>       [VIRTIO_ID_BT] =3D "virtio-bluetooth",
>>> -    [VIRTIO_ID_GPIO] =3D "virtio-gpio"
>>> +    [VIRTIO_ID_GPIO] =3D "virtio-gpio",
>>> +    [VIRTIO_ID_SPI] =3D "virtio-spi"
>>>   };
>> For the vhost-user-stub bits when split from the headers:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

