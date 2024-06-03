Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE92C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6cZ-00051O-ET; Mon, 03 Jun 2024 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6cP-0004zS-P2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE6cM-0002yK-6c
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717417007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khm7CsJRM8Y9X5kFUTCtue9EJoYIFQEkaCB1J9W/xbk=;
 b=cEufK3VfiZJ7wIuCz+KrjJIKJPxz3j1PkpghtDxKhLeme+cIXSDw+0mxEum9vEi22mC4FQ
 MIEv3wLmwKE0U3z+bRWtKIhBZ4ssqjCiuQcx+HV0cDkeZW04QXnLVdYEP6LOx7E/CNIZvS
 0Ohb0la/NAZ0g6Oq9/Z1LpskHpwVMoY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-LEsjrs4lPXe4L42ewqBgAg-1; Mon, 03 Jun 2024 08:16:45 -0400
X-MC-Unique: LEsjrs4lPXe4L42ewqBgAg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43ff7b96a3fso33042531cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417005; x=1718021805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khm7CsJRM8Y9X5kFUTCtue9EJoYIFQEkaCB1J9W/xbk=;
 b=YtPRjoUVDSYh+TkNY72F101HkDVrBZRjnDGYBxuCmUyj9WZ2Q4WuhXbeh+EDMwaaPc
 TGgQkoE5Bk2zgtlfuvRVataj0GNTzvbCr3vhybMRLHxdtAeV2pfkJVMFL/Ya8b1YbN0n
 u5q2Pahl9cRPDfWgoOfFAIK9DkuLlfo3krxgviLhNOaCD/Q6vennDqWH/cvJVz085sNM
 lA/5lm8z16mbWRrM2rtB/ZeyDeWXrz5bfC6We8fFPDJm+iGMEUGw5u5Pi7943GkEmDEr
 c7qfj4taDuP69rnyqmVJYcGIwT9RoJC8nGnR6J64dgHoo5y91TqkDbebg9RwWJqbQ9Ya
 yRKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnbEjlJVtZqtU5ZN7uKgLNH3R178sRT9qovvxoXz5MLyRp4hXw2ErhD/hfxIj9HTCu6hpjZ+su+l0+R++DZ1ZJ56g68M=
X-Gm-Message-State: AOJu0YwetKk3dibqttSVsa+DqJmcdr/lBxXtpw6dKRUZJPLRHWI0qEjt
 IAl1I95iDQpuT+jAjZiw6AdFWkdHWGVv6/7SI7n1AXueJofRbx1uHvmtPNLrjbCqd6wxGihzTzb
 gAKDuiQwAtTwr5+gznm1iC52iRJK4Yv94gTWQ7UXKRJmwSMV5alRd
X-Received: by 2002:ac8:5e54:0:b0:43a:ed56:4c86 with SMTP id
 d75a77b69052e-43ff550b0c3mr125929911cf.56.1717417004908; 
 Mon, 03 Jun 2024 05:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1E5BtGp/rMWlaqFiGqGfgRcOQhz2hAE+8faqdY/5SDxGrrNrxoMFDoAZKJbunMliPWfM1lw==
X-Received: by 2002:ac8:5e54:0:b0:43a:ed56:4c86 with SMTP id
 d75a77b69052e-43ff550b0c3mr125929621cf.56.1717417004500; 
 Mon, 03 Jun 2024 05:16:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23a419asm38646031cf.15.2024.06.03.05.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:16:44 -0700 (PDT)
Message-ID: <753187fa-d165-46da-ba0c-f74683f5d850@redhat.com>
Date: Mon, 3 Jun 2024 14:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240603061023.269738-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
>   MAINTAINERS                        |  2 ++
>   include/sysemu/host_iommu_device.h | 51 ++++++++++++++++++++++++++++++
>   backends/host_iommu_device.c       | 30 ++++++++++++++++++
>   backends/Kconfig                   |  5 +++
>   backends/meson.build               |  1 +
>   5 files changed, 89 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448dc951c5..1cf2b25beb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2196,6 +2196,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
>   S: Supported
>   F: backends/iommufd.c
>   F: include/sysemu/iommufd.h
> +F: backends/host_iommu_device.c
> +F: include/sysemu/host_iommu_device.h
>   F: include/qemu/chardev_open.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
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
> + * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
> + * can have different sub-classes.
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
> +     *
> +     * @errp: pass an Error out when realize fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
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
>   config IOMMUFD
>       bool
>       depends on VFIO
> +
> +config HOST_IOMMU_DEVICE
> +    bool
> +    default y
> +    depends on VFIO

And you can drop HOST_IOMMU_DEVICE config

> diff --git a/backends/meson.build b/backends/meson.build
> index 8b2b111497..2e975d641e 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -25,6 +25,7 @@ if have_vhost_user
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
>   system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
> +system_ss.add(when: 'CONFIG_HOST_IOMMU_DEVICE', if_true: files('host_iommu_device.c'))

and I would move host_iommu_device.c build under host_os == 'linux'

Thanks,

C.


>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif


