Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68836CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5k5-0007iG-TZ; Fri, 09 Oct 2026 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5jg-0007gU-Vn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xF5je-00047Q-7p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791533620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7W6BqVLOyeUY8aQ05ZBFmWL1Tni0IJ5snsYijsoAHY0=;
 b=KT1CjEef/rNAHAofMT6CGtC9eAL0tq7AztDmAmd/7JLzJz0Kfe+/SCvRbBP3gRDXbhnHF7
 NTnybFaiFHTx/sbNC47/bUbUn2nW8XfAqlxczPzMzLlfuIie7Y+JQf6MeF1hUXa+V5PC2N
 osmuZxc46ndNxfaIqo2B2wAtlqGkUHc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Ucxx2ZVWOuWIbmYloBB0Vg-1; Fri, 09 Oct 2026 04:13:39 -0400
X-MC-Unique: Ucxx2ZVWOuWIbmYloBB0Vg-1
X-Mimecast-MFC-AGG-ID: Ucxx2ZVWOuWIbmYloBB0Vg_1791533618
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1721559b4so49544455e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791533618; x=1792138418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7W6BqVLOyeUY8aQ05ZBFmWL1Tni0IJ5snsYijsoAHY0=;
 b=OHO8rdtUTWXU47cVpuhMOVb7b/S0Zi3+5cg3j9L6exmmElyG+ZQy6YUY/XZd+IStz4
 EayhDb7LvOfBRuK9C9TH3x89te6rFDDFY3SOpwJnKJdrWocvKwJvVCE9n8bJN0bZMqn6
 qzFK+5jl9NRlSYccl5HVs41sptzBvhAiOc++MPbGODTZ+wSKFx0DxDOaobsY2hO97kqh
 ult86zHQjo9/xZl4scjjDWiBHAxPSPOEgn0GYnLSR6emv4Kc6u68wCNAkMM1FA8m+bnD
 4xm4VDCAfoSL3V5CJ4Ke/g7841fWFKar1+jLqjdwMtR4iVdH/84Uv4al57b0BBKd9bvU
 dOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791533618; x=1792138418;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7W6BqVLOyeUY8aQ05ZBFmWL1Tni0IJ5snsYijsoAHY0=;
 b=KgfACBq6lnoGUqUdYbgW8mgcncS6/6cST10XpVEdtE76PmUAr9esZKjmy+KiOJ9biH
 GpWbraajhZPu49fMNCuqcpczhZb5Rvy4LbedPJ/aKNhZKCb7BnnRZnjcCxqeAJCClN5X
 jhAVdqn/MDycMmYC38VYPbswZuniSSVP+8sySyc/D0mbBbHzrkfRm3m28vbtjdKXx712
 WUKwadct2GNJyGd9rmWrA9S6ZNyS4lRwfXQqaW6xlBq0oNUjlst5er4nP9CaVbAYGZVC
 ffjDlcaHKAO0NUTliibKzrtmwW+WayUizKWatbKNBnsCUjvpw49HgBgsIhn7jSovKsPk
 9Mug==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIrQnSkMi5eYA7hATUF3XhPxP/+MaBtc6a0CHywwZqBBQHVRo+y3iiHTw1m/LF2qyvCh91hcH9uT5w@nongnu.org
X-Gm-Message-State: AFuF++kGjMYURPLIABwxOdzV2YPrdJksqFMmZBJIAG2xZ581O5SyBlF8
 nJgIQ0W6GZ4TL5pCYMlEG75/JGrrMJGPZE6qq9odExiHmT+rvtFZbkouIsyeoAxfLNhEIrQjGjE
 qPJAOE1xr5b5jTnx5ER+ccTb+2yQGpzmOQdH0vgJP017cx4VuT+hKpdlHSgZtAntH
X-Gm-Gg: AYBFou3mdov7Nff/1qSlnoe4NUal+XCps2hY6u0TKoTlNxdXzrIXonPkgMuE8QU5x3Y
 26NguPhKz3Uf/WFiYVFcEzoNAJpUhtc7tiKosj7BZUq9cNp/hGdpd1p84Q8ZFIueOfNB7slDAJq
 SX35FYtRimSX4jv4xLDlIXukjvqHde0di8MvNLGfNE20KU1UatpSGw0pqO3NgfTB4zfSRhZNd/D
 u4aSrQDyo0XNXb0PGhOVhkTgQrxOlV5DY0O8IqMLh4dQW4PhtpbIo2fyyMfamj2aY96Nv/90YmZ
 h0Ye+bALHdhVf3JwX6JDhelEGqd08GOziSi5hInYIAs6Gi7sFLOUVa7pDzB3Y09m9mF7guevUZH
 gGe0kttg0spYY3V+igQu+Q3TipFmTTchN343dvT+0
X-Received: by 2002:a05:600c:8b04:b0:4a0:1e37:ae41 with SMTP id
 5b1f17b1804b1-4a18e4d67edmr18327705e9.24.1791533618372; 
 Fri, 09 Oct 2026 01:13:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b04:b0:4a0:1e37:ae41 with SMTP id
 5b1f17b1804b1-4a18e4d67edmr18327235e9.24.1791533617788; 
 Fri, 09 Oct 2026 01:13:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm29991865e9.2.2026.10.09.01.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 01:13:37 -0700 (PDT)
Message-ID: <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
Date: Fri, 9 Oct 2026 10:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261007201222.648687-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 10/7/26 22:09, Vivek Kasireddy wrote:
> In order to create a dmabuf associated with a buffer that spans
> multiple ranges, we first need to identify the VFIO region and
> index the buffer (represented by iovec) belongs to and then
> translate its addresses to offsets within that region.
> 
> The qemu_ram_block_from_host() API gives us both the region and
> the offset info we need to populate the dma ranges so that we can
> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the dmabuf.
> 
> Also, instead of iterating over all QOM devices to find the
> VFIODevice associated with a memory region, introduce a helper
> to just use the vfio_device_list to lookup the VFIODevice.
> And, introduce another helper to lookup the VFIO region given an
> address.
> 
> Lastly, introduce an enum to return the type of error encountered
> while creating the dmabuf fd.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  22 +++++++
>   hw/vfio/device.c              | 109 ++++++++++++++++++++++++++++++++++
>   hw/vfio/dmabuf-stubs.c        |  17 ++++++
>   hw/vfio/meson.build           |   1 +
>   4 files changed, 149 insertions(+)
>   create mode 100644 hw/vfio/dmabuf-stubs.c
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 8472420d3f..c05430be8a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -41,6 +41,13 @@ enum {
>       VFIO_DEVICE_TYPE_AP = 3,
>   };
>   
> +enum {
> +    /* The Guest passed addresses stored in IOV are invalid */
> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
> +    /* Guest or Host may be at fault for this type of error */
> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
> +};

Nack.

As said a few times already : it's a VFIO-specific enum leaking
into vfio-device.h to serve virtio-gpu's fallback logic. The
cleanest alternative is to use standard -errno returns and
make the fd an output parameter.


>   typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>   typedef struct VFIOMigration VFIOMigration;
> @@ -323,6 +330,21 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
>   
>   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_irq_info *info);
> +
> +/**
> + * Create a dmabuf fd by first translating the addresses in the
> + * iovec array into VFIO region offsets and then invoking the
> + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> + *
> + * @iov: array of iovec entries associated with a buffer
> + * @iov_cnt: number of entries in the iovec array
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_ERR_UNSPEC
> + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> + */
> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
> +                                 Error **errp);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4f11959633..d95503a5f1 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -21,7 +21,9 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   
> +#include "system/ramblock.h"
>   #include "hw/vfio/vfio-device.h"
> +#include "hw/vfio/vfio-region.h"
>   #include "hw/vfio/pci.h"
>   #include "hw/core/iommu.h"
>   #include "trace.h"
> @@ -667,3 +669,110 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .region_read = vfio_device_io_region_read,
>       .region_write = vfio_device_io_region_write,
>   };
> +
> +/*
> + * This helper looks up the VFIODevice corresponding to the given iov. It
> + * can be useful to determinine if a buffer (represented by the iov) belongs
> + * to a VFIO device or not. This is mainly invoked when external components
> + * such as virtio-gpu request creation of dmabuf fds for buffers that may
> + * belong to a VFIO device.
> + */
> +static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
> +                               RAMBlock **first_rbp, Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    RAMBlock *first_rb;
> +    ram_addr_t offset;
> +
> +    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        error_setg(errp, "Could not find first ramblock\n");

no \n


> +        return false;
> +    }
> +
> +    *first_rbp = first_rb;
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {

wrong list : global_next.


> +        if (vbasedev->dev == first_rb->mr->dev) {
> +            *vbasedevp = vbasedev;
> +            return true;
> +        }
> +    }
> +    error_setg(errp, "No VFIO device found to create dmabuf from\n");

no \n

> +    return false;
> +}
> +
> +/*
> + * This helper looks up the VFIORegion corresponding to the given address.
> + * It also verifies that the RAMBlock associated with the address is the
> + * same as the first_rb passed in. This is to ensure that all addresses
> + * in the iov belong to the same region.
> + */
> +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
> +                               RAMBlock *first_rb, ram_addr_t *offsetp,
> +                               Error **errp)
> +{
> +    VFIORegion *region;
> +    RAMBlock *rb;
> +
> +    rb = qemu_ram_block_from_host(addr, false, offsetp);
> +    if (!rb || rb != first_rb) {
> +        error_setg(errp, "Dmabuf segments must belong to the same region\n");

remove \n

> +        return false;
> +    }
> +
> +    region = vfio_get_region_from_mr(rb->mr);
> +    if (region) {
> +        *regionp = region;
> +        return true;
> +    }
> +    error_setg(errp, "Could not find valid region for dmabuf segment\n");

here too.

> +    return false;
> +}
> +
> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
> +                                 Error **errp)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    RAMBlock *first_rb = NULL;
> +    VFIODevice *vbasedev;
> +    VFIORegion *region;
> +    ram_addr_t offset;
> +    size_t argsz;
> +    int i, ret;
> +
> +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;

return -EINVAL;

> +    }
> +
> +    argsz = sizeof(*feature) + sizeof (*dma_buf) +
> +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> +    feature = g_malloc0(argsz);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = argsz,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
> +
> +    for (i = 0; i < iov_cnt; i++) {
> +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> +                                first_rb, &offset, errp)) {
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;

return -EINVAL;

> +        }
> +
> +        dma_buf->region_index = region->nr;
> +        dma_buf->dma_ranges[i].offset = offset;
> +        dma_buf->dma_ranges[i].length = iov[i].iov_len;
> +    }
> +
> +    dma_buf->nr_ranges = iov_cnt;
> +    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
> +
> +    ret = vfio_device_get_feature(vbasedev, feature);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Could not create dmabuf fd via VFIO device");
> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;

return ret;

> +    }
> +    return ret;
> +}
> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> new file mode 100644
> index 0000000000..fb5318e929
> --- /dev/null
> +++ b/hw/vfio/dmabuf-stubs.c

Fails to build on MinGW/Windows.

     hw/vfio/dmabuf-stubs.c:12:5: error: no previous prototype for
          'vfio_device_create_dmabuf_fd'
      hw/vfio/dmabuf-stubs.c:19:7: error: no previous prototype for
          'vfio_device_mmap_dmabuf'


> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) 2026 Intel and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/iov.h"
> +#include "hw/vfio/vfio-device.h"
> +
> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
> +                                 Error **errp)
> +{
> +    error_setg(errp, "VFIO dmabuf support is not enabled");
> +    return VFIO_DMABUF_CREATE_ERR_UNSPEC;

return -ENOTSUP;


> +}
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index c7c31b78f6..aa6f4bc1b4 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
>   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',
>   ))
> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


