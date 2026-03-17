Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D09FED9E4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VuX-0006Zv-LP; Tue, 17 Mar 2026 11:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2VuV-0006Zm-Uf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2VuR-0005Mb-F0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773759638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1EqLAlRpKGxif3BxRLDrOY+m1VtDqUS62mA+EOYlt4c=;
 b=ZdQbuSJJhgrLLgU9cuJxXIcYy2ybM7vQ8MYH+Io04PJ12XZsxOP5k2Uxw86XLtIXhDGBFI
 Rs0hEdCUUdedVl1BPlkK8OXjFi1HFAj8/VnSZt3Z0Yp75KpjAMWggfySMH7vWza3uv2IOY
 FlZ+7w8izSnK9yKqo6OjlBR21oKnwGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-JbQ9t0tUPwaGvGl8m8m8EA-1; Tue, 17 Mar 2026 11:00:36 -0400
X-MC-Unique: JbQ9t0tUPwaGvGl8m8m8EA-1
X-Mimecast-MFC-AGG-ID: JbQ9t0tUPwaGvGl8m8m8EA_1773759635
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso72114495e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773759635; x=1774364435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1EqLAlRpKGxif3BxRLDrOY+m1VtDqUS62mA+EOYlt4c=;
 b=s4ezl/I+0iEIKNfIi7lbAktRDi79bFOTsqkV1ieoHPAFofC/imlsgcZ0kRfWDgaRPs
 2xHNLmkILE7drO0st03kkUFooEG1PgMaSG/ap7czZ3WbGR0FQn1r977CajHtj0u/7te1
 RXCO6qC4JO3QH7a7PFnyZHA4eJec0GO0UuSkW8dmdohSWk+L7j6b+iGFrKt7T4JCrvof
 AIr3fivMgM5UHhMDqe5G0CckvPvXy1wVAjhcD76Ya+x/JAmve1QcozmoErI3OTuS+I/I
 duqu7HV48ksr2pCbth28tz1fdUqn5Xb13X8Ra7dTOjI0TNL9BMPK29Uxs/k6cgXoes1/
 lAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759635; x=1774364435;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EqLAlRpKGxif3BxRLDrOY+m1VtDqUS62mA+EOYlt4c=;
 b=m4V7MYbO29F6/8GpCmkuMswUxjubW0LsqxC+G5Z+VkdcFPmqeQZodadyxvqlOsk9ck
 zl54VHz5qOOjWenHccNHgOV8n3VrfzINSkOiQqOCInbxCRN6k+dSsem67tPinBF8zr41
 XiQ+9LrUwfz+T/646C30FzZ1x5Q4DmOtCtTcbwznzLp/nDszb4wgy0Njzy7RsStvOpYW
 nievvz8tSte7aD5ND5lC4CPVyqSCnzBvxMWrXppnkxuxAVEa0vKqAojguh/O4Dmtlqx6
 l4rr9hmkBzt36xMWd0n0GLGZtxkj1GEIe5nYqk2ZotbzTy4z4tqjeULIrNSeiMShROi5
 +Lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHPin0iz4zcCfSVvhRK8JOjMYFOWQOecrNB/VDp2FUbxr6QpMrdswSYBXyu6sT3Z7kP++DVkArV9i@nongnu.org
X-Gm-Message-State: AOJu0Yx5a8ZHnDyGbm4aIwJ2V1VgNH+v8cjNrV+D7SaWh+6YGZbmSAA+
 iCuH8CoYkIAIKUzqVP8UP2iHMexx33wU0jt5v42V+l6IUPepWZ93x8ThNNGeHdeOudJ5g2sZxK3
 YxidqeQUyXuqswxNelIZWKjIf5ArBZzQDQcXxD3g1LFK7Lg3VrP2MnigmW8ryfS8S
X-Gm-Gg: ATEYQzygqqHs7YHSzJpH0S+230C4xcIOkXGW6ArmIyq5KcoXasnbEG4CuDNQtzUlX65
 L1SnfA4czBNR+a6zuCNDlHlvXYzfWhfpUntCvfSCywwRCLvtVJV+cQi+yXIchByx29VFHBwTNd2
 brwQoXYn3MK/R7fpUEkVZXQzsyA/0pO6a+ASrpvImzyHbZhJVpSefj6ujqF0xBGT7YNGEUhUGJ7
 HSA4RADXTq8E8pcGODMHF7MTeFLMePkEQTxJt5+q4X1FseEcvJbeu25N1DuJG6DdmZC7AX+EYQ2
 wKY3DR3Bqw89XfWbuuKMt7HvALthN5F9DWJDhfSC4Ur2hljMSqAyhfRk5g2AysDxZOnrI0VTSu9
 2dF8Q4kTCWjBvRwE6c16lotIyEhU0FhATORpL3uirCt3otXlKKyeXlrkosZnQ
X-Received: by 2002:a05:600c:354b:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48556703401mr294122755e9.18.1773759634486; 
 Tue, 17 Mar 2026 08:00:34 -0700 (PDT)
X-Received: by 2002:a05:600c:354b:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48556703401mr294121625e9.18.1773759633770; 
 Tue, 17 Mar 2026 08:00:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557777105sm203628805e9.4.2026.03.17.08.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:00:33 -0700 (PDT)
Message-ID: <d313433e-e601-4ebc-baee-ae5baef45b29@redhat.com>
Date: Tue, 17 Mar 2026 16:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] vfio/device: Add support for creating dmabuf
 from multiple ranges
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-8-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260311025340.1335673-8-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

HEllo,

On 3/11/26 03:50, Vivek Kasireddy wrote:
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
> VFIODevice associated with a memory region, introduce a helper to
> just use the vfio_device_list to lookup the VFIODevice.
> 
> Lastly, introduce an enum to return the type of error encountered
> while creating the dmabuf fd.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/device.c              | 81 +++++++++++++++++++++++++++++++++++
>   hw/vfio/dmabuf-stubs.c        | 17 ++++++++
>   hw/vfio/meson.build           |  1 +
>   include/hw/vfio/vfio-device.h | 22 ++++++++++

Please add to your .git/config

[diff]
	orderFile = /path/to/qemu/scripts/git.orderfile



>   4 files changed, 121 insertions(+)
>   create mode 100644 hw/vfio/dmabuf-stubs.c
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..2d01059be0 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   
> +#include "system/ramblock.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
>   #include "hw/core/iommu.h"
> @@ -644,3 +645,83 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .region_read = vfio_device_io_region_read,
>       .region_write = vfio_device_io_region_write,
>   };
> +

Please add a comment

   /*
    * For virtio-gpu, < explain the context >
    */


> +static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
> +                               Error **errp)
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
> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
> +                                 Error **errp)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    RAMBlock *rb, *first_rb;
> +    VFIODevice *vbasedev;
> +    ram_addr_t offset;
> +    int i, index, ret;
> +    size_t argsz;

Shouldn't we check iov and iov_cnt values ?

> +    argsz = sizeof(*feature) + sizeof (*dma_buf) +
> +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> +    feature = g_malloc0(argsz);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = argsz,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
> +
> +    if (!vfio_device_lookup(iov, &vbasedev, errp)) {
> +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> +    }
> +
> +    for (i = 0; i < iov_cnt; i++) {
> +        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
> +        if (i == 0) {
> +            first_rb = rb;
> +        }
> +        if (!rb || rb != first_rb) {
> +            error_setg(errp, "Cannot create dmabuf with different regions\n");
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> +        }
> +
> +        index = vfio_get_region_index_from_mr(rb->mr);

returning a VFIORegion seems cleaner.

> +        if (index < 0) {
> +            error_setg(errp, "Cannot find region index for dmabuf segment\n");
> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> +        }


Could you please introduce a common helper for the code above that
could be shared with vfio_device_mmap_dmabuf() ? The same sequence
is duplicated.


> +        dma_buf->region_index = index;
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

See vfio_region_create_dma_buf() for possible errors. You might want
to introduce a helper.


> +    }
> +    return ret;
> +}
> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> new file mode 100644
> index 0000000000..e71e2b68dd
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
> +    return VFIO_DMABUF_CREATE_HOST_ERROR;
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
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 596c7f5a10..566e5d8bc0 100644
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

This is overkill. Please return a bool value and ensure the errp
argument is correctly filled.

> +
>   typedef struct VFIODeviceOps VFIODeviceOps;
>   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>   typedef struct VFIOMigration VFIOMigration;
> @@ -318,6 +325,21 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>    * Returns the region index or -1 on error.
>    */
>   int vfio_get_region_index_from_mr(MemoryRegion *mr);
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


