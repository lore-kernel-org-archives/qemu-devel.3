Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A079BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUguh-0008Dg-FJ; Wed, 03 Jun 2026 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgug-0008DU-9I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:22 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgud-00032w-UL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780473729; bh=Pd3ZIsXLHb2Q+tTYjF7Z6dVmj08P0j3k0kKzzHd+H+k=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=bi0ZueoqY0PpvAPFB9rzEePvVt2AE8TbhaBMZYow9LRDp8OLwjcIJKho/lWX6KtEB
 P93niWFuwnNZPueZ22k+c/v0mcO1GVKosxlCHgNGpb8XTNkzWnHnr0unCTXM7cqUWE
 6Np7GC9J7kLIEx+B+fyr89DxLGQQ4kAwUz5Jf8yQ=
Received: by be1-7.in.mailobj.net [192.168.91.17] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 10:01:31 +0200 (CEST)
X-EA-Auth: 760rwCotuxeUoolLSDeOoe0Sich75v73ieFK2LYkWVHyQcRYlmY+GI3Evf68Kx0Jc7bFTiNPsllEcrsBMGsqj8OapRYtfLhD
Message-ID: <244fb7fb-af40-4566-bc58-7aa34742f0b8@mailo.com>
Date: Wed, 3 Jun 2026 10:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Content-Language: en-US
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, david@kernel.org, gourry@gourry.net
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com, Thomas Huth <thuth@redhat.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <20260602084447.1100554-2-FangSheng.Huang@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602084447.1100554-2-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi,

On 2/6/26 10:44, fanhuang wrote:
> Introduce a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
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
>      -object memory-backend-ram,id=spm0,size=$SIZE
>      -numa node,nodeid=$N
>      -device spm-memory,id=dev0,memdev=spm0,node=$N[,addr=$GPA]
> 
> The device is boot-time only (no hotplug).
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>   hw/i386/Kconfig             |   2 +
>   hw/mem/Kconfig              |   4 ++
>   hw/mem/meson.build          |   1 +
>   hw/mem/spm-memory.c         | 133 ++++++++++++++++++++++++++++++++++++
>   include/hw/mem/spm-memory.h |  42 ++++++++++++
>   qapi/machine.json           |  43 +++++++++++-
>   6 files changed, 223 insertions(+), 2 deletions(-)
>   create mode 100644 hw/mem/spm-memory.c
>   create mode 100644 include/hw/mem/spm-memory.h

Please enable scripts/git.orderfile to ease review.

> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 12473acaa7..e31a25b634 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -84,6 +84,7 @@ config I440FX
>       select PCI_I440FX
>       select PIIX
>       select DIMM
> +    select SPM_MEMORY
>       select SMBIOS
>       select SMBIOS_LEGACY
>       select FW_CFG_DMA
> @@ -113,6 +114,7 @@ config Q35
>       select LPC_ICH9
>       select AHCI_ICH9
>       select DIMM
> +    select SPM_MEMORY
>       select SMBIOS
>       select FW_CFG_DMA

This hunk seems to belong to patch #3.

> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 73c5ae8ad9..4145870881 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
>       bool
>       default y if CXL
>       select MEM_DEVICE
> +
> +config SPM_MEMORY

Simply 'SPM'.

> +    bool
> +    select MEM_DEVICE
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 8c2beeb7d4..2c28104282 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>   mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>   mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>   mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +mem_ss.add(when: 'CONFIG_SPM_MEMORY', if_true: files('spm-memory.c'))
>   stub_ss.add(files('cxl_type3_stubs.c'))
>   
>   stub_ss.add(files('memory-device-stubs.c'))
> diff --git a/hw/mem/spm-memory.c b/hw/mem/spm-memory.c
> new file mode 100644
> index 0000000000..e3942c6a3a
> --- /dev/null
> +++ b/hw/mem/spm-memory.c
> @@ -0,0 +1,133 @@
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
> +#include "hw/mem/spm-memory.h"
> +#include "hw/mem/memory-device.h"
> +#include "migration/vmstate.h"
> +#include "system/hostmem.h"
> +
> +#define SPM_MEMORY_MEMDEV_PROP    "memdev"
> +#define SPM_MEMORY_NODE_PROP      "node"
> +#define SPM_MEMORY_ADDR_PROP      "addr"
> +
> +static const Property spm_memory_properties[] = {
> +    DEFINE_PROP_LINK(SPM_MEMORY_MEMDEV_PROP, SpmMemoryDevice, hostmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_UINT32(SPM_MEMORY_NODE_PROP, SpmMemoryDevice, node, 0),
> +    DEFINE_PROP_UINT64(SPM_MEMORY_ADDR_PROP, SpmMemoryDevice, addr, 0),
> +};
> +
> +static uint64_t spm_memory_md_get_addr(const MemoryDeviceState *md)

KISS, s/memory_md_// for local methods.

> +{
> +    return SPM_MEMORY(md)->addr;
> +}
> +
> +static void spm_memory_md_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                                   Error **errp)
> +{
> +    SPM_MEMORY(md)->addr = addr;
> +}
> +
> +static MemoryRegion *spm_memory_md_get_memory_region(MemoryDeviceState *md,
> +                                                    Error **errp)
> +{
> +    SpmMemoryDevice *spm = SPM_MEMORY(md);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'memdev' property must be set");
> +        return NULL;
> +    }
> +    return host_memory_backend_get_memory(spm->hostmem);
> +}
> +
> +static uint64_t spm_memory_md_get_plugged_size(const MemoryDeviceState *md,
> +                                               Error **errp)
> +{
> +    SpmMemoryDevice *spm = SPM_MEMORY(md);
> +    return spm->hostmem ?
> +        memory_region_size(host_memory_backend_get_memory(spm->hostmem)) : 0;
> +}
> +
> +static void spm_memory_md_fill_device_info(const MemoryDeviceState *md,
> +                                           MemoryDeviceInfo *info)
> +{
> +    SpmMemoryDeviceInfo *di = g_new0(SpmMemoryDeviceInfo, 1);
> +    SpmMemoryDevice *spm = SPM_MEMORY(md);
> +    DeviceState *dev = DEVICE(md);
> +
> +    di->id = dev->id ? g_strdup(dev->id) : NULL;
> +    di->memaddr = spm->addr;
> +    di->size = spm->hostmem ? memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem)) : 0;
> +    di->node = spm->node;
> +    di->memdev = spm->hostmem ?
> +                 object_get_canonical_path(OBJECT(spm->hostmem)) : NULL;
> +
> +    info->u.spm_memory.data = di;
> +    info->type = MEMORY_DEVICE_INFO_KIND_SPM_MEMORY;
> +}
> +
> +static void spm_memory_realize(DeviceState *dev, Error **errp)
> +{
> +    SpmMemoryDevice *spm = SPM_MEMORY(dev);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property is required", SPM_MEMORY_MEMDEV_PROP);
> +        return;
> +    }

Should the 'node' property be validated?

> +}
> +
> +static const VMStateDescription vmstate_spm_memory = {
> +    .name = TYPE_SPM_MEMORY,
> +    .unmigratable = 1,

Please add a comment explaining the reason.

> +};
> +
> +static void spm_memory_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
> +
> +    dc->desc = "SPM (Specific Purpose Memory) device";
> +    dc->hotpluggable = false;
> +    dc->realize = spm_memory_realize;
> +    dc->vmsd = &vmstate_spm_memory;
> +    device_class_set_props(dc, spm_memory_properties);

Should we add/use DEVICE_CATEGORY_MEMORY?

        set_bit(DEVICE_CATEGORY_MEMORY, dc->categories);

> +
> +    mdc->get_addr            = spm_memory_md_get_addr;
> +    mdc->set_addr            = spm_memory_md_set_addr;
> +    mdc->get_memory_region   = spm_memory_md_get_memory_region;
> +    mdc->get_plugged_size    = spm_memory_md_get_plugged_size;
> +    mdc->fill_device_info    = spm_memory_md_fill_device_info;
> +}
> +
> +static const TypeInfo spm_memory_info = {
> +    .name          = TYPE_SPM_MEMORY,
> +    .parent        = TYPE_DEVICE,
> +    .class_size    = sizeof(SpmMemoryDeviceClass),
> +    .class_init    = spm_memory_class_init,
> +    .instance_size = sizeof(SpmMemoryDevice),
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_MEMORY_DEVICE },
> +        { }
> +    },
> +};
> +
> +static void spm_memory_register_types(void)
> +{
> +    type_register_static(&spm_memory_info);

Preferrably DEFINE_TYPES().

> +}
> +
> +type_init(spm_memory_register_types)
> diff --git a/include/hw/mem/spm-memory.h b/include/hw/mem/spm-memory.h
> new file mode 100644
> index 0000000000..b56aa3cd12
> --- /dev/null
> +++ b/include/hw/mem/spm-memory.h
> @@ -0,0 +1,42 @@
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
> +#ifndef QEMU_SPM_MEMORY_H
> +#define QEMU_SPM_MEMORY_H
> +
> +#include "hw/mem/memory-device.h"
> +#include "hw/core/qdev.h"
> +#include "qom/object.h"
> +#include "system/hostmem.h"
> +
> +#define TYPE_SPM_MEMORY "spm-memory"

    #define TYPE_SPM "spm"

(or TYPE_SPM_DEVICE if you rather).

> +
> +OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass, SPM_MEMORY)

    OBJECT_DECLARE_SIMPLE_TYPE(SpmDevice, SPM_DEVICE)

> +
> +struct SpmMemoryDevice {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/

Please drop this public/private unuseful comments.

> +    HostMemoryBackend *hostmem;    /* memdev= backend */
> +    uint32_t node;                 /* NUMA proximity domain (node=) */
> +    uint64_t addr;                 /* GPA (from addr= or framework-assigned) */
> +};
> +
> +struct SpmMemoryDeviceClass {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +};

Not needed (empty).

> +
> +#endif /* QEMU_SPM_MEMORY_H */
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..51b06d7cba 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1413,6 +1413,32 @@
>             }
>   }
>   
> +##
> +# @SpmMemoryDeviceInfo:
> +#
> +# spm-memory device state information
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
> +{ 'struct': 'SpmMemoryDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'size': 'size',

Pre-existing, these fields belong to the TYPE_MEMORY_DEVICE
interface. Isn't it a way to have all implementation field
directly QAPIfied?

> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +
>   ##
>   # @MemoryDeviceInfoKind:
>   #
> @@ -1426,11 +1452,13 @@
>   #
>   # @hv-balloon: since 8.2.
>   #
> +# @spm-memory: since 11.1.
> +#
>   # Since: 2.1
>   ##
>   { 'enum': 'MemoryDeviceInfoKind',
>     'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> -            'hv-balloon' ] }
> +            'hv-balloon', 'spm-memory' ] }

Clearly 'spm' :)

>   
>   ##
>   # @PCDIMMDeviceInfoWrapper:
> @@ -1482,6 +1510,16 @@
>   { 'struct': 'HvBalloonDeviceInfoWrapper',
>     'data': { 'data': 'HvBalloonDeviceInfo' } }
>   
> +##
> +# @SpmMemoryDeviceInfoWrapper:
> +#
> +# @data: spm-memory device state information
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'SpmMemoryDeviceInfoWrapper',
> +  'data': { 'data': 'SpmMemoryDeviceInfo' } }
> +
>   ##
>   # @MemoryDeviceInfo:
>   #
> @@ -1499,7 +1537,8 @@
>               'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>               'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
>               'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> -            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
> +            'spm-memory': 'SpmMemoryDeviceInfoWrapper'
>             }
>   }
>   

Patch LGTM.


