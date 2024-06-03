Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF7C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE755-000584-68; Mon, 03 Jun 2024 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE74z-000563-B5
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE74x-0000AE-G2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717418781;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXnwVrfP3aH8hfqVPoRbXrRuKgiJQfeFfyeMUodBt3w=;
 b=envqx/xhqHBbWPnU+nbSDI2Knc1mF2lBxFQmOmL4fKMe4d3C6SaWXgWBU6mMuKQP2isu3O
 dSwf9e+C86UXKEP7nrdAqN6eT6TYUA3cnm6GCacX0CLuyMIMVaTIu9qHm2GPY1IaN1IXzY
 ytWy5WQ3vjwkMJuBcv7Kwf0L5UXBKok=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-0GoEvcUQNjGrPvW2HDMaVQ-1; Mon, 03 Jun 2024 08:46:19 -0400
X-MC-Unique: 0GoEvcUQNjGrPvW2HDMaVQ-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-48a33435f58so2348251137.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418779; x=1718023579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXnwVrfP3aH8hfqVPoRbXrRuKgiJQfeFfyeMUodBt3w=;
 b=EyZx4Ciu3KFe4wNvG1iVLuufitxVNmn1HNgFtDW4fdgkkCnB7YdNDA+uqrWGt8HKRu
 2ANcI8jO/5nZGpQfYmCIHeKbBSXZ59oN+AqyehxYX/uKdLtmyMLAnCn0VOD4bRb7Kkhw
 qwZyr1Y6+nkZUJPaYEi/mH8zmbLe36tWGOPpX9IDwSDISxDWkAH3sEQnK8l5HdXaOdkD
 uob7aCM0ICc6CKXQ28vO2ieVvTbeb4oI1Ttj+ecQNqirIYAZNaNMg1Uhu5xZSeDLGmHV
 MqAzLtXH/aY+jk0vyc4AQfqWzxJQA1kbHcjf4+dZcwudQljJAkQy5dA2v0cJR7Got9Qo
 ymqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv3xHSpItcL8IGFTlrIuPXM/zeaecxDJyvcWFJEuQ2mYmZIQnxxWaoJtdoZoA2BYqWIE+6tE0ioNou8TBSe/zKY1co1rg=
X-Gm-Message-State: AOJu0YwKn7/JkVx9/5xM1kg5MgoqtxzVchILvCWOkpFJdxUWc6RxBH/f
 1w+URLYk0J10Cr4ZaNGjJ3i39DU/4L3KF6ZeE5SsU1wZqSvWHc//SVgHqJBeCcAOYF4BP7p/hyc
 DEpDbR/xBPYumJAtECszFbzKk6PQ+6Nl7hTj9XXlB06RQCaKoI2ow
X-Received: by 2002:a67:fa19:0:b0:48b:c455:8b57 with SMTP id
 ada2fe7eead31-48bc4558d20mr8493619137.7.1717418779296; 
 Mon, 03 Jun 2024 05:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbEzvLUTUV31JgU/L6O6cjNKvXdkjwiG0qMnLi0DF/duT9lCwCOOwVI+jJa3riW0RQwmogbg==
X-Received: by 2002:a67:fa19:0:b0:48b:c455:8b57 with SMTP id
 ada2fe7eead31-48bc4558d20mr8493586137.7.1717418778781; 
 Mon, 03 Jun 2024 05:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f3172d05sm279816285a.113.2024.06.03.05.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:46:18 -0700 (PDT)
Message-ID: <43b7e164-9657-4368-9baa-fd83bedb2066@redhat.com>
Date: Mon, 3 Jun 2024 14:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/3/24 08:10, Zhenzhong Duan wrote:
> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
>
> Introduce .realize() to initialize HostIOMMUDevice further after
> instance init.
>
> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
> for VFIO, and VDPA in the future.
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS                        |  2 ++
>  include/sysemu/host_iommu_device.h | 51 ++++++++++++++++++++++++++++++
>  backends/host_iommu_device.c       | 30 ++++++++++++++++++
>  backends/Kconfig                   |  5 +++
>  backends/meson.build               |  1 +
>  5 files changed, 89 insertions(+)
>  create mode 100644 include/sysemu/host_iommu_device.h
>  create mode 100644 backends/host_iommu_device.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448dc951c5..1cf2b25beb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2196,6 +2196,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
>  S: Supported
>  F: backends/iommufd.c
>  F: include/sysemu/iommufd.h
> +F: backends/host_iommu_device.c
> +F: include/sysemu/host_iommu_device.h
>  F: include/qemu/chardev_open.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> new file mode 100644
> index 0000000000..2b58a94d62
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,51 @@
> +/*
> + * Host IOMMU device abstract declaration
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +
> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> +
> +struct HostIOMMUDevice {
> +    Object parent_obj;
> +};
> +
> +/**
> + * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
> + *
> + * Different type of host devices (e.g., VFIO or VDPA device) or devices
s/type/types
> + * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
> + * can have different sub-classes.
will have different implementations of the HostIOMMUDeviceClass?
> + */
> +struct HostIOMMUDeviceClass {
> +    ObjectClass parent_class;
> +
> +    /**
> +     * @realize: initialize host IOMMU device instance further.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @opaque: pointer to agent device of this host IOMMU device,
> +     *          i.e., for VFIO, pointer to VFIODevice
VFIO base device or VDPA device?
> +     *
> +     * @errp: pass an Error out when realize fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);

I think I would introduce the get_cap API here as well to give a minimal
consistency to the class API.
> +};
> +#endif
> diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
> new file mode 100644
> index 0000000000..41f2fdce20
> --- /dev/null
> +++ b/backends/host_iommu_device.c
> @@ -0,0 +1,30 @@
> +/*
> + * Host IOMMU device abstract
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/host_iommu_device.h"
> +
> +OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
> +                            host_iommu_device,
> +                            HOST_IOMMU_DEVICE,
> +                            OBJECT)
> +
> +static void host_iommu_device_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +static void host_iommu_device_init(Object *obj)
> +{
> +}
> +
> +static void host_iommu_device_finalize(Object *obj)
> +{
> +}
> diff --git a/backends/Kconfig b/backends/Kconfig
> index 2cb23f62fa..34ab29e994 100644
> --- a/backends/Kconfig
> +++ b/backends/Kconfig
> @@ -3,3 +3,8 @@ source tpm/Kconfig
>  config IOMMUFD
>      bool
>      depends on VFIO
> +
> +config HOST_IOMMU_DEVICE
> +    bool
> +    default y
> +    depends on VFIO
> diff --git a/backends/meson.build b/backends/meson.build
> index 8b2b111497..2e975d641e 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -25,6 +25,7 @@ if have_vhost_user
>  endif
>  system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
>  system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
> +system_ss.add(when: 'CONFIG_HOST_IOMMU_DEVICE', if_true: files('host_iommu_device.c'))
>  if have_vhost_user_crypto
>    system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>  endif


