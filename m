Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8735CA600A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEk7N-0005CE-Ia; Thu, 08 Oct 2026 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xEk7L-0005C4-TP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:08:47 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xEk7J-0001Rc-QS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:08:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ab10550338so98118a91.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791450524; x=1792055324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0pqyYIJL7Tor9e7J/wxRocjtvEyXbwA4xlcFTNsBFTw=;
 b=nUTqeEMPt5reoS4t0Zhrv/LGkC1nZB4xr1tUrO7iSza0FCEx8SpqFf4p4iBAZyfA/X
 8gQL7uKpkgQlZMiN/zLeVB/u5foSrvCxRCcj//YesdbtyjDhj7Pm7XseQf1WIO8UKcw+
 nhRE8HD4jsILNEyfGmWGL7c57nhIYW9u3SKmB76SO1DJWT2pUAWanGmk8g3yUStaCuGS
 0oUv18FmuQf7lvHOivR2CPz0phRJrjv7IXIoYaSWiBMDFyo2ZeM70fcmqiKQIqbTqCvW
 hA0xwVUMUVNN6mtcq4VhwN7QzUh/BnJ5Yrxyh+24yFN6FRA8+RgDN9Vtf6faSxKSQLNp
 4U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791450524; x=1792055324;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0pqyYIJL7Tor9e7J/wxRocjtvEyXbwA4xlcFTNsBFTw=;
 b=qfxFjuBMaweNoaF6361l58q+PJwDgTF58xltmFfEMuradivDjSAxdPpyqqzlMhNwFC
 y5Ed2kIjKn1cgk15gMA4sl8En4Wtmd/Y6ca0aYD7g4uP6fxvI2R9bnC2EM/0wmDU9A7x
 Zu2iHdH6TtGX0UcJQbC9m0RXNX3np3Z5WBMFhgkqsi8NhukYVEaceU41Z6yGl2rNaL3k
 H0W0WdDQRMc0y3xuecUjIkWZEWr71ej4AZQ+czwoiXytXm/3VDe5hAoVXXMfoIEgqVbm
 Yj6Q5uAty237VdiahifTKZEOuLw614d8SOQAFQ8JaWI74KtaSJ4syglWsfEJeB4vKTyd
 eSpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkhoI65q2dd2UWjnhw4Pfe9eOYaBmDxWsb0V6hPpWoyxE4P1+3wGSb2C0RCJuMLQZq4jAnWWFzUyrI@nongnu.org
X-Gm-Message-State: AFq9FYJ0ljH4/2Fy6fRXDoGANkmSf3eNvTj3fNIBkaw9rAUg4th8jIEa
 WD3sQL1EF2KwERsUdfbUPkcWL6rtD03/WE3eUUaI6SUGMW4WUOxkqGk4
X-Gm-Gg: AYBFou1IBx9LHwy1SDfQd4sgQN7TXpB7oWMDTrRyM9wcOGKfrgrX6Nd2yXnRx2Bf3Yc
 HUtAKbpiRZbmbjddGqnbSHiPdL6QArO8whEpKwidlep7lvUxGsrgw+T2PR86kx81cM4GrXoE9nE
 lj0M/cqjYxrdbv1TIl4RTLXTHORElC0qJNT1pBvj82gxwjeUkDYjlqLxjZkelu44N0AS2qlbX98
 yL4JxA0+sCMWrywGPWbfbeoJdsWwV/jNds8ZaFrbXNArQCPZKNhPgTeJ0ljibp+4kBjgw3FxSyA
 GUvTXTS7Hc5bIL8P0C2QOubcxvhve3NNquoHHpRXWMuqBhC4Dy9YbACVj26jRwA6ZJsEV14lniy
 sDK9wJIOJ9XxyXqtwGxaf1Q3GLpL9cQNVuWMmUCvH5llqpPDLCBgo/ivCU8WqGbZNBXCOUFaLSF
 wdgEAM5TjSs9v5bZh8oCJwsb48cHC9XTj+vnrP3WFMCtitL0FwP4aLFMgC6oKda5o3Gs6xmq2yE
 P5kOd3CXNryNJPiIplNWeTZva2yWuTYIbr0izy79vEfpA==
X-Received: by 2002:a17:90b:4b8d:b0:3a5:25e:85fc with SMTP id
 98e67ed59e1d1-3a8a1ce5d6cmr4388398a91.63.1791450523826; 
 Thu, 08 Oct 2026 02:08:43 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9d94d9bc5sm3414622a91.0.2026.10.08.02.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 02:08:42 -0700 (PDT)
Message-ID: <f8c86fc0-9c29-4fd5-a7af-e20289da9f4b@gmail.com>
Date: Thu, 8 Oct 2026 18:08:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20261007201222.648687-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pj1-x1034.google.com
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

On 2026/10/08 5:09, Vivek Kasireddy wrote:
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
> +
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
> +        return false;
> +    }
> +
> +    *first_rbp = first_rb;
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {

This traverses vfio_device_list using next. next belongs to the legacy 
IOMMU-group list. With devices in separate groups, or multiple devices 
using iommufd, buffers belonging to devices beyond the global head are 
missed and DMA-BUF creation fails. Please use global_next.

> +        if (vbasedev->dev == first_rb->mr->dev) {
> +            *vbasedevp = vbasedev;
> +            return true;
> +        }
> +    }
> +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
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
> +        return false;
> +    }
> +
> +    region = vfio_get_region_from_mr(rb->mr);
> +    if (region) {
> +        *regionp = region;
> +        return true;
> +    }
> +    error_setg(errp, "Could not find valid region for dmabuf segment\n");
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
> +    }
> +    return ret;
> +}
> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> new file mode 100644
> index 0000000000..fb5318e929
> --- /dev/null
> +++ b/hw/vfio/dmabuf-stubs.c
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
> +}

The new stub builds when VFIO is disabled, but its declaration is inside 
#ifdef CONFIG_LINUX. Consequently, -Wmissing-prototypes fails builds 
such as macOS CI.

Regards,
Akihiko Odaki

> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index c7c31b78f6..aa6f4bc1b4 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
>   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',
>   ))
> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


