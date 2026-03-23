Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D065F483DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jcM-0006bC-Hh; Mon, 23 Mar 2026 14:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jcK-0006ap-2t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jcH-0001WF-41
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774288983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CNVx7MGecRn7jzAZSGowQlLI3mtcT0HKT1QmZNdCH04=;
 b=aijLo6hTXTT94bD5SH435CfU47QzwZVh/dEQ8GmyZilZEYESDEfX/PfTTEH/kThItFdVRN
 jn7nI5CdNFX48qytE3Kkda0QHvYeMJfoclVgiQFguEh3zJPhAWz5Lfppg9m5j6mk6Q/vFt
 8aPekSKNnhfJsOb8eNcVBv3UfMngU1M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-GL8BZJdLO_Ky8ZjUHLmcVA-1; Mon, 23 Mar 2026 14:03:02 -0400
X-MC-Unique: GL8BZJdLO_Ky8ZjUHLmcVA-1
X-Mimecast-MFC-AGG-ID: GL8BZJdLO_Ky8ZjUHLmcVA_1774288981
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbfcfc21so3954558f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774288961; x=1774893761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CNVx7MGecRn7jzAZSGowQlLI3mtcT0HKT1QmZNdCH04=;
 b=m579aa6ZPQY0K5Lo20qWVJn0ohAmPW0L9XY52JTjAMouZ76M3xme+OC0JvxNf/4zx9
 mSx3IlKuS9hywj1fvQSPQWsFJ+OWHE636gbfyj43hYgMWWdHqg8Chi1KqaFv88XQfYTM
 L/clspPyXNI3FBl0Rkg7IMc841HiEapp6aHzfuM5PBLPz7nYD1ApA6qZA1xeb1N4uOQT
 e+cenkei+JUPmAwLhBuBD/d2e4nfq8wGVF11wrYly938TaF3lUImlg/N2Sj8P2A5DvuM
 JSOGdi9vK6n02kHJGzj3nZ9wDK+aNQZui6Mq7gjddoYouNxQQPPGltK9DwdD7vZsABYd
 C8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774288961; x=1774893761;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNVx7MGecRn7jzAZSGowQlLI3mtcT0HKT1QmZNdCH04=;
 b=mQp/9QPX8K0BqV0XK70ETKSi+dfdhM+vE5h0NqCdXNMhy4RHhPzw2OYox8TFsNmH6A
 faNgp7CejcHhGzIft8t+T7aTUjryul8kEiRVSxVRhIE2uTmheo1YbEle4MYlacSrb21w
 nnMTW503vgWaZGMiFdqXBvIJLa6Wb0RlMWZ5Zs1AkhJUkKOuePnxi2ErZvPTa2RvqQgh
 KTW0eIL5Qu5D9Di2dyMPLZGm8OatnibSRS5MXb0ObFvwPG9REmHaKtinG3rBso28pAY1
 0fGgIHSBo9M2LIIstBIrVVFkPVEb2MxCP8mpFncHneorZR/PvTLRsJWsX/XBsXPgzpg2
 eQ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWsGxvruZ/fqdAbna+5Lg+lJ0iBpKoUiQE6CN5F5h/dPRa49mEczZb4xoKmiB4rZJotSGueHi1fAYO@nongnu.org
X-Gm-Message-State: AOJu0YyHtr2PNlSauT3ptC1n3g+IWpdMKBk/QVGaJSVB7M31OUB1ddea
 eosmzsq2BQrlV/x39rQ2qyhIR7Xsw81CarmiUJz/72B1hbBDKi17zqb0ysso6X6xYbk6UVPq90X
 w2I7OEQ1RoSQxNYPflSMmkC1FyXUGJMawABS6FKwuY8Hbt0qXIcLcKsgd
X-Gm-Gg: ATEYQzzGtIn109OGv2Bc0PAQQjMPP+Arwi3FyjhvnPp6p5oYL9CkjoSLbTJ98WB5d0d
 DwgKBAICDIbniLpATCKm84T0unX3vqZc/B5bpXohuKhmvZAUJUQ0wILFDdnr8Is340UdJpRfc1D
 ACNCDMaRbvS+gq8aMJcLOKS/Vipu2eHrjhqO7a9KaGOAQ8i5xTahWD2KOPE5pdjaR0zp987Q8J7
 J3Jn9f0jCMBZoITHlP/fk0Cj/y6wgQvqd4nfwImLlH6YaaNwWXpE+Q82xWntow2foka5uwdQhec
 xbp5bkkQoiVEB2RuM3jq7Zm2dNNgb299Ie5z7ajVBvHnCZLoMl8YoxqK/R+oKerVXaK++18uEM4
 87WkptDKZinVZg9Ar+EI3NfParYzGmzszu+WY43uaV1yNMSa+HY7kZ+PioooG
X-Received: by 2002:a5d:64c6:0:b0:439:bd26:3c63 with SMTP id
 ffacd0b85a97d-43b64262da5mr19819010f8f.28.1774288961361; 
 Mon, 23 Mar 2026 11:02:41 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:439:bd26:3c63 with SMTP id
 ffacd0b85a97d-43b64262da5mr19818936f8f.28.1774288960793; 
 Mon, 23 Mar 2026 11:02:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0d3dsm29548179f8f.16.2026.03.23.11.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 11:02:39 -0700 (PDT)
Message-ID: <98c1495e-e142-4e63-ada1-87e14b85342e@redhat.com>
Date: Mon, 23 Mar 2026 19:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-8-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260319052023.2088685-8-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/19/26 06:15, Vivek Kasireddy wrote:
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
> And, introduce another helper lookup the VFIO region given an
> address.
> 
> Lastly, introduce an enum to return the type of error encountered
> while creating the dmabuf fd.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  23 +++++++
>   hw/vfio/device.c              | 114 ++++++++++++++++++++++++++++++++++
>   hw/vfio/dmabuf-stubs.c        |  17 +++++
>   hw/vfio/meson.build           |   1 +
>   4 files changed, 155 insertions(+)
>   create mode 100644 hw/vfio/dmabuf-stubs.c
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 828a31c006..d46640ff53 100644
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

Sorry, I am not convinced this is useful.

> +
>   typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>   typedef struct VFIOMigration VFIOMigration;
> @@ -308,6 +315,22 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
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
> + * @total_size: total size of the dmabuf
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_ERR_UNSPEC
> + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> + */
> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
> +                                 size_t total_size, Error **errp);
>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..542c378913 100644
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
>   #include "hw/core/hw-error.h"
> @@ -644,3 +646,115 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
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
> +                                 size_t total_size, Error **errp)
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
> +    if (iov_size(iov, iov_cnt) != total_size) {
> +        error_setg(errp, "Total size of iov does not match dmabuf size\n");
> +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;

This returned value is redundant with errp and error-prone for an API.
I think you should find an alternative implementation. May be these
routines simply do not belong to VFIO.
  

> +    }
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
> index 0000000000..374bd2a188
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
> +                                 size_t total_size, Error **errp)
> +{
> +    error_setg(errp, "VFIO dmabuf support is not enabled");
> +    return VFIO_DMABUF_CREATE_HOST_ERROR;

../hw/vfio/dmabuf-stubs.c:16:12: error: ‘VFIO_DMABUF_CREATE_HOST_ERROR’ undeclared (first use in this function)
    16 |     return VFIO_DMABUF_CREATE_HOST_ERROR;

Thanks,

C.



> +}
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 82f68698fb..ac899d30a8 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -34,3 +34,4 @@ system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
>   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',
>   ))
> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


