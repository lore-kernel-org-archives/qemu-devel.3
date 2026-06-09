Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9F2CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsN0-0003b9-Fi; Tue, 09 Jun 2026 05:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWsMy-0003ad-FC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWsMw-0007SV-9k
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Zt3Tr2gBlI50lqoBl4pWkWRjro6vOPSfhflZpOM1FI=;
 b=f4qZU1yxwq0xKRGr06ZnIHAq+Skq732kja0a0vts7mIt5fJFt24BOyE6gk5GLU2ClaC9Jr
 eU9gpO7nbFcFQxR74IyaQdSJk0/8cLwcZyXg79/+rc+wU5HQx2R+EFPRFYf6FN3tqyqh3k
 k5uLbojQlgImQ3Nzjd+u+HMj7ageXVA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-GFqP4EhkOXqJU-RMIYFBhg-1; Tue, 09 Jun 2026 05:03:31 -0400
X-MC-Unique: GFqP4EhkOXqJU-RMIYFBhg-1
X-Mimecast-MFC-AGG-ID: GFqP4EhkOXqJU-RMIYFBhg_1780995810
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-68b6f4f3c06so5210929a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780995810; x=1781600610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Zt3Tr2gBlI50lqoBl4pWkWRjro6vOPSfhflZpOM1FI=;
 b=WbRrR/JSFioFCsgl50kkyoAjBZzzWV3BpXtUHD2p53NAMn2i9Td8Wzlx8DOWNtxq24
 kQ226v++9xxTlC7ZAgTUUWUBmmNY6wzr8Z8H7jgV2030YaCsnfNmKQ1Yxdoz1tTMBPsH
 gPGc9aeQAZV64J47ZE6n8dCJF36NPdOBioq2xwWHbDCo1mUwKA6uO9iOloRmjYgxXQys
 qZsVnwyT82gPXuFTPVZGG6VfoMyyH2Dim+I34mHRaR7lIGgO4tVe2RTrGGH8kIAC8Fpm
 PBxRSjP2IMJlUY5ySTB9elVJR5kSPGpUYyfHlOM1D1i/S9vGgbXfbsy3pRhrm2/rhiGY
 cpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995810; x=1781600610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Zt3Tr2gBlI50lqoBl4pWkWRjro6vOPSfhflZpOM1FI=;
 b=gMZTQgacnoidvu4O5i5BXKJcu2CFsp45CN7hqtAOxN7xUh9iTX9j8ksf7uL1lmrDzp
 W8+r3u4Fj1ZG8c5bs148K/pWQ38Mqm776TDywxKbgGvWUaubtEQKFYFxDiKsQ+eqNWKO
 MAjgHgjjECFf+AUq28PXvzBtCpmQEyuz+h6MCQacNo6ur64WojKucUC5uIDXJzNIndCG
 t/YL6gLT02LGPBPpNgWz7f+YiJdjzcoESTGoNo2b1MALYfKKY7dR6V3FikdIyKYD0WIp
 O/RTynyzx+++b5x+4FBHPHNZfjr27AcM1LYUYix+w+MSpnMqMZcYxYGxEZRkxaD1oogB
 2PGQ==
X-Gm-Message-State: AOJu0YyFIusJT45wKFzNpDA7r8/7NqF7DPZs88gf9L5+sMOM9XVdjfqP
 VCM2ZnSHAS68Hx0KLewiJrOu84d7ZkNv56LuFs4OOZ92maN5KctZCCKBOVqSCDQdv3rHHP67ZDL
 PknJg7VgeazwWWz5bka4RIT41fjrZ27i8a0U1Ro37N+WCIqoDCourue0toKNF8rtN
X-Gm-Gg: Acq92OFry0IJSM6fEwRQWtZ+zVJDEBNcrP2JTzQYzWJ1eVUfSVNDVHXjdWZQ8xLQplP
 /BMKlUVv8cB9uQzguRgDMgxQdEvRa/BC+PKWr9McqvFLCpW8Z+wMQOBAq+JDFs4bVs8aVg+qMsF
 TYRH13uIlV80sKpatZz0kad/DR7m7tYV73HRDd/kIHE9U7fvJKlFD8+o4Jc+aRw2L13Ly2F8joh
 a6avUR/PpGAv2Qq1USzEWvUw7RsHpkMt8a/0s8ohkM/FVVr4C6OPaY6C0GppPVvxxbNPPn0gR4K
 KcjZI+oBMe15lcd5tMS8R4C4673EI1QR+CGgVkm0qhnX8YN+whS7S0H3AmqVC7epKPfFZ7T7mAA
 zNdfjVIXnTxv7E801jIuj0T9eCWQ=
X-Received: by 2002:a05:6402:528c:b0:68e:28f9:ff3f with SMTP id
 4fb4d7f45d1cf-68fa4c2900emr8506370a12.10.1780995810004; 
 Tue, 09 Jun 2026 02:03:30 -0700 (PDT)
X-Received: by 2002:a05:6402:528c:b0:68e:28f9:ff3f with SMTP id
 4fb4d7f45d1cf-68fa4c2900emr8506337a12.10.1780995809407; 
 Tue, 09 Jun 2026 02:03:29 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-691afe82416sm2845722a12.13.2026.06.09.02.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:03:29 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:03:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v10 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
Message-ID: <20260609110324.41b410c0@imammedo>
In-Reply-To: <20260605104609.1739911-2-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-2-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 5 Jun 2026 18:46:06 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
> proximity domain.
> 
> The device targets accelerator memory (HBM and similar) that the
> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
> in the guest -- rather than the kernel's general allocator -- owns
> the range.
> 
> Usage:
> 
>     -object memory-backend-ram,id=spm0,size=$SIZE
>     -numa node,nodeid=$N
>     -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]
> 
> The device is boot-time only (no hotplug).
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  qapi/machine.json       |  43 ++++++++++++-
>  include/hw/mem/sp-mem.h |  35 +++++++++++
>  hw/mem/sp-mem.c         | 130 ++++++++++++++++++++++++++++++++++++++++
>  hw/mem/Kconfig          |   4 ++
>  hw/mem/meson.build      |   1 +
>  5 files changed, 211 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/mem/sp-mem.h
>  create mode 100644 hw/mem/sp-mem.c
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..41cc3a188a 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1413,6 +1413,32 @@
>            }
>  }
>  
> +##
> +# @SpMemDeviceInfo:
> +#
> +# sp-mem device state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @node: NUMA proximity domain to which the device is assigned
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpMemDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',

why not 'addr', like DIMM?

> +            'size': 'size',
> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfoKind:
>  #
> @@ -1426,11 +1452,13 @@
>  #
>  # @hv-balloon: since 8.2.
>  #
> +# @sp-mem: since 11.1.
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'MemoryDeviceInfoKind',
>    'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> -            'hv-balloon' ] }
> +            'hv-balloon', 'sp-mem' ] }
>  
>  ##
>  # @PCDIMMDeviceInfoWrapper:
> @@ -1482,6 +1510,16 @@
>  { 'struct': 'HvBalloonDeviceInfoWrapper',
>    'data': { 'data': 'HvBalloonDeviceInfo' } }
>  
> +##
> +# @SpMemDeviceInfoWrapper:
> +#
> +# @data: sp-mem device state information
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpMemDeviceInfoWrapper',
> +  'data': { 'data': 'SpMemDeviceInfo' } }
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
> @@ -1499,7 +1537,8 @@
>              'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>              'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
>              'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> -            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
> +            'sp-mem': 'SpMemDeviceInfoWrapper'
>            }
>  }
>  
> diff --git a/include/hw/mem/sp-mem.h b/include/hw/mem/sp-mem.h
> new file mode 100644
> index 0000000000..5c0b6ec4f8
> --- /dev/null
> +++ b/include/hw/mem/sp-mem.h
> @@ -0,0 +1,35 @@
> +/*
> + * Specific Purpose Memory (SPM) device
> + *
> + * TYPE_MEMORY_DEVICE subclass for boot-time-only memory exposed to the
> + * guest as an E820 SOFT_RESERVED range with a SRAT memory-affinity entry.
> + *
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + *
> + * Authors:
> + *  FangSheng Huang <FangSheng.Huang@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_SP_MEM_H
> +#define QEMU_SP_MEM_H
> +
> +#include "hw/mem/memory-device.h"
> +#include "hw/core/qdev.h"
> +#include "qom/object.h"
> +#include "system/hostmem.h"
> +
> +#define TYPE_SP_MEM "sp-mem"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)
> +
> +struct SpMemDevice {
> +    DeviceState parent_obj;
> +
> +    HostMemoryBackend *hostmem;
> +    uint32_t node;
> +    uint64_t addr;
> +};
> +
> +#endif /* QEMU_SP_MEM_H */
> diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
> new file mode 100644
> index 0000000000..f6ba9a6d7c
> --- /dev/null
> +++ b/hw/mem/sp-mem.c
> @@ -0,0 +1,130 @@
> +/*
> + * Specific Purpose Memory (SPM) device
> + *
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + *
> + * Authors:
> + *  FangSheng Huang <FangSheng.Huang@amd.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev.h"
> +#include "hw/mem/sp-mem.h"
> +#include "hw/mem/memory-device.h"
> +#include "migration/vmstate.h"
> +#include "system/hostmem.h"
> +
> +#define SP_MEM_MEMDEV_PROP    "memdev"
> +#define SP_MEM_NODE_PROP      "node"
> +#define SP_MEM_ADDR_PROP      "addr"
> +
> +static const Property sp_mem_properties[] = {
> +    DEFINE_PROP_LINK(SP_MEM_MEMDEV_PROP, SpMemDevice, hostmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_UINT32(SP_MEM_NODE_PROP, SpMemDevice, node, 0),
> +    DEFINE_PROP_UINT64(SP_MEM_ADDR_PROP, SpMemDevice, addr, 0),
> +};
> +
> +static uint64_t sp_mem_get_addr(const MemoryDeviceState *md)
> +{
> +    return SP_MEM(md)->addr;

device cast + deref, should be separate. or even better look at
pc_dimm_md_get_addr()

> +}
> +
> +static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                            Error **errp)
> +{
> +    SP_MEM(md)->addr = addr;
> +}

ditto

> +
> +static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
> +                                              Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(md);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'memdev' property must be set");
> +        return NULL;
> +    }
> +    return host_memory_backend_get_memory(spm->hostmem);
> +}
> +
> +static uint64_t sp_mem_get_plugged_size(const MemoryDeviceState *md,
> +                                        Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(md);
> +    return spm->hostmem ?
> +        memory_region_size(host_memory_backend_get_memory(spm->hostmem)) : 0;
> +}
> +
> +static void sp_mem_fill_device_info(const MemoryDeviceState *md,
> +                                    MemoryDeviceInfo *info)
> +{
> +    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
> +    SpMemDevice *spm = SP_MEM(md);
> +    DeviceState *dev = DEVICE(md);
> +
> +    di->id = dev->id ? g_strdup(dev->id) : NULL;
> +    di->memaddr = spm->addr;
> +    di->size = spm->hostmem ? memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem)) : 0;

why conditional?

> +    di->node = spm->node;
> +    di->memdev = spm->hostmem ?
> +                 object_get_canonical_path(OBJECT(spm->hostmem)) : NULL;
ditto

> +
> +    info->u.sp_mem.data = di;
> +    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
> +}
> +
> +static void sp_mem_realize(DeviceState *dev, Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
> +        return;
> +    }
> +}
> +
> +/* boot-time only; no plug/unplug state to migrate */
> +static const VMStateDescription vmstate_sp_mem = {
> +    .name = TYPE_SP_MEM,
> +    .unmigratable = 1,
> +};
> +
> +static void sp_mem_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
> +
> +    dc->desc = "SPM (Specific Purpose Memory) device";
> +    dc->hotpluggable = false;
> +    dc->realize = sp_mem_realize;
> +    dc->vmsd = &vmstate_sp_mem;
> +    device_class_set_props(dc, sp_mem_properties);
> +
> +    mdc->get_addr            = sp_mem_get_addr;
> +    mdc->set_addr            = sp_mem_set_addr;
> +    mdc->get_memory_region   = sp_mem_get_memory_region;
> +    mdc->get_plugged_size    = sp_mem_get_plugged_size;
                                   ^^^^
wouldn't memory_device_get_region_size() do here?

> +    mdc->fill_device_info    = sp_mem_fill_device_info;
> +}
> +
> +static const TypeInfo sp_mem_types[] = {
> +    {
> +        .name          = TYPE_SP_MEM,
> +        .parent        = TYPE_DEVICE,
> +        .class_init    = sp_mem_class_init,
> +        .instance_size = sizeof(SpMemDevice),
> +        .interfaces    = (InterfaceInfo[]) {
> +            { TYPE_MEMORY_DEVICE },
> +            { }
> +        },
> +    },
> +};
> +
> +DEFINE_TYPES(sp_mem_types)
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 73c5ae8ad9..39ddb36710 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
>      bool
>      default y if CXL
>      select MEM_DEVICE
> +
> +config SP_MEM
> +    bool
> +    select MEM_DEVICE
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 8c2beeb7d4..f410d75475 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>  mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>  mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>  mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +mem_ss.add(when: 'CONFIG_SP_MEM', if_true: files('sp-mem.c'))
>  stub_ss.add(files('cxl_type3_stubs.c'))
>  
>  stub_ss.add(files('memory-device-stubs.c'))


