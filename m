Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8850DCA9EDC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGb2-0006w9-JS; Mon, 12 Oct 2026 10:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGGay-0006u1-9s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:01:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xGGav-0005ar-Lk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:01:40 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69CE1Set079703
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 12 Oct 2026 23:01:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=UgccqkC644zlF1XLnbCYTDkTktpq2gecEQBRdaPEr2Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791813688; v=1;
 b=pezPJW2DvHWqICas7+HE2itSHx2OZO+ujA8pTH9kUQsD4asN+KRR5WZuQbWmmVGx
 +5ELl3V59HzjUrOUMG8U1mqcX0b6d/ffvUpEIRFTa4ARqbakjOnW2KDHvpjEW1IA
 fWMGQI5eNPc0Z60/YEmIxjo8bmBYbs3hMb+AwK1AJQG8hINcUESeevZwvYHVuzkR
 XfpBYTQr3rVsmE2xsMVywIWFJ1oMec2odoJB2DzQ0MFpsVEK2H//bxZpapN5vBKW
 BOC0LQIZrmKuzhw3RkKJPf0nQmekVQLRXgIb/l88zx1Sl4IhbZFkSzIdxGphcrkS
 1cM0Eu8MxX9CFFLqdZzJiA==
Message-ID: <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 12 Oct 2026 23:01:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/12 15:27, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
>> from multiple ranges
>>
>>> In order to create a dmabuf associated with a buffer that spans
>>> multiple ranges, we first need to identify the VFIO region and
>>> index the buffer (represented by iovec) belongs to and then
>>> translate its addresses to offsets within that region.
>>>
>>> The qemu_ram_block_from_host() API gives us both the region and
>>> the offset info we need to populate the dma ranges so that we can
>>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
>> dmabuf.
>>>
>>> Also, instead of iterating over all QOM devices to find the
>>> VFIODevice associated with a memory region, introduce a helper
>>> to just use the vfio_device_list to lookup the VFIODevice.
>>> And, introduce another helper to lookup the VFIO region given an
>>> address.
>>>
>>> Lastly, introduce an enum to return the type of error encountered
>>> while creating the dmabuf fd.
>>>
>>> Cc: Alex Williamson <alex@shazbot.org>
>>> Cc: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-device.h |  22 +++++++
>>>    hw/vfio/device.c              | 109 ++++++++++++++++++++++++++++++++++
>>>    hw/vfio/dmabuf-stubs.c        |  17 ++++++
>>>    hw/vfio/meson.build           |   1 +
>>>    4 files changed, 149 insertions(+)
>>>    create mode 100644 hw/vfio/dmabuf-stubs.c
>>>
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
>> device.h
>>> index 8472420d3f..c05430be8a 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -41,6 +41,13 @@ enum {
>>>        VFIO_DEVICE_TYPE_AP = 3,
>>>    };
>>>
>>> +enum {
>>> +    /* The Guest passed addresses stored in IOV are invalid */
>>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>>> +    /* Guest or Host may be at fault for this type of error */
>>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
>>> +};
>>
>> Nack.
>>
>> As said a few times already : it's a VFIO-specific enum leaking
>> into vfio-device.h to serve virtio-gpu's fallback logic. The
>> cleanest alternative is to use standard -errno returns and
>> make the fd an output parameter.
> It looks like Cedric remains unconvinced about the value or usefulness
> of this error enum. Therefore, to make progress, I intend to adopt his
> suggestion to use standard -errno returns for the next version, considering
> that this series has been stuck for a year.
> 
> AFAICS, dropping this error enum means that we would not be able to
> clearly identify and log (or attribute) Guest vs Host errors in virtio-gpu,
> particularly the INVALID_IOV case. I am not sure if this can be considered
> a significant limitation. However, if there is a reasonable middle ground
> solution or an alternative that you can think of that does not involve
> using VFIO error enums in virtio-gpu, then I would like to pursue that
> instead.

Cédric's comment is a reiteration of previous points, but his concrete 
code suggestion is new and brings to light some challenges with errno 
propagation.

First, errno does not precisely match the required semantics. We need to 
distinguish lookup failures from the other errors. However, with your 
suggestion, lookup failures become -EINVAL and vfio_device_get_feature() 
also returns the same value when the backend lacks the operation, making 
it impossible to distinguish them.

Propagating errno also requires extra care to preserve it when 
necessary. For patch "[PATCH v13 8/9] virtio-gpu-dmabuf: Improve error 
handling with 'Error **' and err enum", you suggested to add the 
"saved_errno" variable to save errno before error_setg_errno(). That is 
redundant because error_setg_errno() preserves errno. Realizing that 
requires careful attention.

While we could spend effort fixing these issues, we can simply avoid the 
churn by not using errno.

In any case, I agree keeping this stuck is not ideal while I don't think 
I can provide any further insights. So I'm inviting Markus Armbruster to 
this discussion. This is an area better handled by him, who maintains 
the error reporting facility, including include/qapi/error.h, which 
extensively documents codebase-wide error-handling convention.

Markus, could you advise on the appropriate convention for returning
this kind of classification alongside Error **? Your perspective
across the codebase may help us settle on a consistent approach
beyond the individual subsystems involved here. Perhaps you may improve 
the documentation according to a design decision made here.

If anyone else has a clean middle-ground solution in the meantime, I 
would greatly appreciate your input as well.

Regards,
Akihiko Odaki

> 
> Thanks,
> Vivek
>>
>>
>>>    typedef struct VFIODeviceOps VFIODeviceOps;
>>>    typedef struct VFIODeviceIOOps VFIODeviceIOOps;
>>>    typedef struct VFIOMigration VFIOMigration;
>>> @@ -323,6 +330,21 @@ bool vfio_device_has_region_cap(VFIODevice
>> *vbasedev, int region, uint16_t cap_t
>>>
>>>    int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>>>                                    struct vfio_irq_info *info);
>>> +
>>> +/**
>>> + * Create a dmabuf fd by first translating the addresses in the
>>> + * iovec array into VFIO region offsets and then invoking the
>>> + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
>>> + *
>>> + * @iov: array of iovec entries associated with a buffer
>>> + * @iov_cnt: number of entries in the iovec array
>>> + * @errp: pointer to Error*, to store an error if it happens.
>>> + *
>>> + * Returns the created dmabuf fd or either
>> VFIO_DMABUF_CREATE_ERR_UNSPEC
>>> + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
>>> + */
>>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
>> iov_cnt,
>>> +                                 Error **errp);
>>>    #endif
>>>
>>>    /* Returns 0 on success, or a negative errno. */
>>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>>> index 4f11959633..d95503a5f1 100644
>>> --- a/hw/vfio/device.c
>>> +++ b/hw/vfio/device.c
>>> @@ -21,7 +21,9 @@
>>>    #include "qemu/osdep.h"
>>>    #include <sys/ioctl.h>
>>>
>>> +#include "system/ramblock.h"
>>>    #include "hw/vfio/vfio-device.h"
>>> +#include "hw/vfio/vfio-region.h"
>>>    #include "hw/vfio/pci.h"
>>>    #include "hw/core/iommu.h"
>>>    #include "trace.h"
>>> @@ -667,3 +669,110 @@ static VFIODeviceIOOps
>> vfio_device_io_ops_ioctl = {
>>>        .region_read = vfio_device_io_region_read,
>>>        .region_write = vfio_device_io_region_write,
>>>    };
>>> +
>>> +/*
>>> + * This helper looks up the VFIODevice corresponding to the given iov.
>> It
>>> + * can be useful to determinine if a buffer (represented by the iov)
>> belongs
>>> + * to a VFIO device or not. This is mainly invoked when external
>> components
>>> + * such as virtio-gpu request creation of dmabuf fds for buffers that may
>>> + * belong to a VFIO device.
>>> + */
>>> +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
>> **vbasedevp,
>>> +                               RAMBlock **first_rbp, Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev;
>>> +    RAMBlock *first_rb;
>>> +    ram_addr_t offset;
>>> +
>>> +    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false,
>> &offset);
>>> +    if (!first_rb) {
>>> +        error_setg(errp, "Could not find first ramblock\n");
>>
>> no \n
>>
>>
>>> +        return false;
>>> +    }
>>> +
>>> +    *first_rbp = first_rb;
>>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>>
>> wrong list : global_next.
>>
>>
>>> +        if (vbasedev->dev == first_rb->mr->dev) {
>>> +            *vbasedevp = vbasedev;
>>> +            return true;
>>> +        }
>>> +    }
>>> +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
>>
>> no \n
>>
>>> +    return false;
>>> +}
>>> +
>>> +/*
>>> + * This helper looks up the VFIORegion corresponding to the given
>> address.
>>> + * It also verifies that the RAMBlock associated with the address is the
>>> + * same as the first_rb passed in. This is to ensure that all addresses
>>> + * in the iov belong to the same region.
>>> + */
>>> +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
>>> +                               RAMBlock *first_rb, ram_addr_t *offsetp,
>>> +                               Error **errp)
>>> +{
>>> +    VFIORegion *region;
>>> +    RAMBlock *rb;
>>> +
>>> +    rb = qemu_ram_block_from_host(addr, false, offsetp);
>>> +    if (!rb || rb != first_rb) {
>>> +        error_setg(errp, "Dmabuf segments must belong to the same
>> region\n");
>>
>> remove \n
>>
>>> +        return false;
>>> +    }
>>> +
>>> +    region = vfio_get_region_from_mr(rb->mr);
>>> +    if (region) {
>>> +        *regionp = region;
>>> +        return true;
>>> +    }
>>> +    error_setg(errp, "Could not find valid region for dmabuf segment\n");
>>
>> here too.
>>
>>> +    return false;
>>> +}
>>> +
>>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
>> iov_cnt,
>>> +                                 Error **errp)
>>> +{
>>> +    g_autofree struct vfio_device_feature *feature = NULL;
>>> +    struct vfio_device_feature_dma_buf *dma_buf;
>>> +    RAMBlock *first_rb = NULL;
>>> +    VFIODevice *vbasedev;
>>> +    VFIORegion *region;
>>> +    ram_addr_t offset;
>>> +    size_t argsz;
>>> +    int i, ret;
>>> +
>>> +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>>> +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>
>> return -EINVAL;
>>
>>> +    }
>>> +
>>> +    argsz = sizeof(*feature) + sizeof (*dma_buf) +
>>> +            sizeof(struct vfio_region_dma_range) * iov_cnt;
>>> +    feature = g_malloc0(argsz);
>>> +    *feature = (struct vfio_device_feature) {
>>> +        .argsz = argsz,
>>> +        .flags = VFIO_DEVICE_FEATURE_GET |
>> VFIO_DEVICE_FEATURE_DMA_BUF,
>>> +    };
>>> +    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
>>> +
>>> +    for (i = 0; i < iov_cnt; i++) {
>>> +        if (!vfio_region_lookup(iov[i].iov_base, &region,
>>> +                                first_rb, &offset, errp)) {
>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>>
>> return -EINVAL;
>>
>>> +        }
>>> +
>>> +        dma_buf->region_index = region->nr;
>>> +        dma_buf->dma_ranges[i].offset = offset;
>>> +        dma_buf->dma_ranges[i].length = iov[i].iov_len;
>>> +    }
>>> +
>>> +    dma_buf->nr_ranges = iov_cnt;
>>> +    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
>>> +
>>> +    ret = vfio_device_get_feature(vbasedev, feature);
>>> +    if (ret < 0) {
>>> +        error_setg_errno(errp, -ret,
>>> +                         "Could not create dmabuf fd via VFIO device");
>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>
>> return ret;
>>
>>> +    }
>>> +    return ret;
>>> +}
>>> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
>>> new file mode 100644
>>> index 0000000000..fb5318e929
>>> --- /dev/null
>>> +++ b/hw/vfio/dmabuf-stubs.c
>>
>> Fails to build on MinGW/Windows.
>>
>>       hw/vfio/dmabuf-stubs.c:12:5: error: no previous prototype for
>>            'vfio_device_create_dmabuf_fd'
>>        hw/vfio/dmabuf-stubs.c:19:7: error: no previous prototype for
>>            'vfio_device_mmap_dmabuf'
>>
>>
>>> @@ -0,0 +1,17 @@
>>> +/*
>>> + * Copyright (c) 2026 Intel and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qemu/iov.h"
>>> +#include "hw/vfio/vfio-device.h"
>>> +
>>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
>> iov_cnt,
>>> +                                 Error **errp)
>>> +{
>>> +    error_setg(errp, "VFIO dmabuf support is not enabled");
>>> +    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>>
>> return -ENOTSUP;
>>
>>
>>> +}
>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>> index c7c31b78f6..aa6f4bc1b4 100644
>>> --- a/hw/vfio/meson.build
>>> +++ b/hw/vfio/meson.build
>>> @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
>>>    system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>>      'display.c',
>>>    ))
>>> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))
> 

