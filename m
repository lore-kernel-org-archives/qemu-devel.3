Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE9BCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmOP-0007Wm-S8; Wed, 17 Jun 2026 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZmON-0007WM-Ug
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wZmOL-0002R6-HZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781687819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQkdD7+C5wEwCzhsPxWD5+TgcMJ4CA6q0/eUOCfhQJQ=;
 b=OFRoPd6htV2m2RAdZt4AGdg6Z5bAU8gjTQZcIhhlwZ2Ps8Qr/F8HRBbx6kbBmduDP8sA/u
 LamKA4T03Nfb+0MjhaU5Lml7aM7gLoPRaPuUJrjeA90pRNDFzlr4AtsMQH/A1Db7lBUtrX
 nfkVyHlIZQrgt5uNAjFqbYR7XdBoVYo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ffTgi34zPwqaYgpFJq2jVg-1; Wed, 17 Jun 2026 05:16:57 -0400
X-MC-Unique: ffTgi34zPwqaYgpFJq2jVg-1
X-Mimecast-MFC-AGG-ID: ffTgi34zPwqaYgpFJq2jVg_1781687816
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bdad545342aso697240866b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781687816; x=1782292616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQkdD7+C5wEwCzhsPxWD5+TgcMJ4CA6q0/eUOCfhQJQ=;
 b=hYPN0UmWsw9N3ZVkAm5Zn0ILChjMnZcmQa+DTPMMYb/Y8bCyOzOO0dVe8p8tT+rU0w
 qFwjkVxPsiazkLn4MdOBO4faoZjp0IF3X8aPk3X3g9J665Gzmf1/Zv17iMSzGt8x6FiZ
 LDILkxNp+HJgX7EtQcomIFGMo6bfI2Py7yOTp8ZXSlAQzdrwf/cBjtHTpPadpS9Yzhn5
 uEpaidCUrag/pdyzNDk7T+i1szgO1Y2WXmhr3IJlTv0nPsvu8Z9TcO4aldlwFtL3aBpq
 iAFUsWU62JEOdw8zJj7xRQ8m5ItlzuZTWMlSY2/BKnOvKwNPbbQPLKxIYRYCYuU3q1l2
 vXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781687816; x=1782292616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQkdD7+C5wEwCzhsPxWD5+TgcMJ4CA6q0/eUOCfhQJQ=;
 b=Gh7om9FB7tgQ6Dmg9jqcYOD+7RKhsc7pkdF+ZY63Qn1XG0A7G1X5bKb720AuO7Jsjy
 izjjz34RMNE34e0FIJtFytFkXCb5dOCINbako8NggKZECsTaLQ77dkUjmvX7LzUS4BNN
 v2+T58YnwEKpSLiYDhvDcbdxGny57X35qUdh8UncI1Si+W+XYzP8htUwu/45rD0itOSw
 TgkOAOvXjkXOI6bDn15wvltHp/1L9Bm236WpQIU6szdMzNvwirpDLtZSmilBR3pzlVJc
 ual4kC4WXMU3I0ObVxD5CMZFlZaCw+yr3euQ/5l7hB4VgEjsY8TgnKlPZo6XHnY/X04q
 4OVw==
X-Gm-Message-State: AOJu0Yxi6CPCzrT2Gpyh5d6huk7300k0qQTVci/Yb21/blbWNB3kUf2S
 DHEZVCjIS4A4igQl+0LLUtz8nfuav3OnJxCimVe5OcLpkFFOqtIN+dK/+V03fVN3lcSlzJ/caz2
 fL7hn9ccG49y+H3PtIO9v5CSvaxEJpyh0vs37vf+aaoOBDRa/Fu5e3ymD
X-Gm-Gg: Acq92OHcuC5cVdNNvPeqXvKIBvD37KugBoKy653ytSqAOEn29gdUWCHPWu1/ig4tiQQ
 c9r1zz7cpv/LjYDRkqGlJTBmR24NkEyWHD8t08Dkctbt1qvolGzvTFmHkNkBElEaqlWhFIJxiqA
 rmBK3iGko99bHmjhmzQxQ6Yw3CF5a+4d8y7v/fJJKMcqBitmRKBQi10ny1Y8mDqHNgWJY/owuJJ
 xffYIgnjICSSp+Aw6fI1oL5Cr44PwKZEGAx16S1ErLSWf1DFbI97dV0Yfl3fOgza6Wd4ay+Cpa6
 1w23SEOP7K8n2nZgiz3t8eHqSgeKlw3BrMyVOcDveKrUDwW7CZFqaON4FF8nSaqIhVPQ5pg=
X-Received: by 2002:a17:907:7618:b0:be8:d31d:e1e1 with SMTP id
 a640c23a62f3a-c05a481801bmr119647166b.3.1781687815970; 
 Wed, 17 Jun 2026 02:16:55 -0700 (PDT)
X-Received: by 2002:a17:907:7618:b0:be8:d31d:e1e1 with SMTP id
 a640c23a62f3a-c05a481801bmr119643466b.3.1781687815069; 
 Wed, 17 Jun 2026 02:16:55 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c063f9b2470sm43909966b.62.2026.06.17.02.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 02:16:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:16:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v12 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
Message-ID: <20260617111652.1bb4d2d4@imammedo>
In-Reply-To: <20260616090808.3047939-2-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
 <20260616090808.3047939-2-FangSheng.Huang@amd.com>
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

On Tue, 16 Jun 2026 17:08:05 +0800
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

Modulo nitpicking/patch splitting and a migration question LGTM 

> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  qapi/machine.json          |  43 +++++++++++-
>  include/hw/mem/sp-mem.h    |  33 +++++++++
>  hw/core/machine-hmp-cmds.c |  11 +++
>  hw/mem/sp-mem.c            | 136 +++++++++++++++++++++++++++++++++++++
>  hw/mem/Kconfig             |   4 ++
>  hw/mem/meson.build         |   1 +
>  6 files changed, 226 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/mem/sp-mem.h
>  create mode 100644 hw/mem/sp-mem.c
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..777cfc81e1 100644
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
> +# @addr: physical address, where device is mapped
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
> +            'addr': 'size',
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
> index 0000000000..a8951b49e6
> --- /dev/null
> +++ b/include/hw/mem/sp-mem.h
> @@ -0,0 +1,33 @@
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
> +#include "hw/core/qdev.h"
> +#include "qom/object.h"
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
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 46846f741a..686304bafa 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -279,6 +279,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      PCDIMMDeviceInfo *di;
>      SgxEPCDeviceInfo *se;
>      HvBalloonDeviceInfo *hi;
> +    SpMemDeviceInfo *spmi;
>  
>      for (info = info_list; info; info = info->next) {
>          value = info->value;
> @@ -350,6 +351,16 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                      monitor_printf(mon, "  memdev: %s\n", hi->memdev);
>                  }
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
> +                spmi = value->u.sp_mem.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               spmi->id ? spmi->id : "");
> +                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
> +                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
> +                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
> +                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
> +                break;
>              default:
>                  g_assert_not_reached();
>              }

hmp could be a separate patch.

> diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
> new file mode 100644
> index 0000000000..3b46cabc46
> --- /dev/null
> +++ b/hw/mem/sp-mem.c
> @@ -0,0 +1,136 @@
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
> +    return object_property_get_uint(OBJECT(md), SP_MEM_ADDR_PROP,
> +                                    &error_abort);
> +}
> +
> +static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                            Error **errp)
> +{
> +    object_property_set_uint(OBJECT(md), SP_MEM_ADDR_PROP, addr, errp);
> +}
> +
> +static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
> +                                              Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(md);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property must be set", SP_MEM_MEMDEV_PROP);
> +        return NULL;
> +    }
> +    return host_memory_backend_get_memory(spm->hostmem);
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
> +    di->addr = spm->addr;
> +    di->size = memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem));
> +    di->node = spm->node;
> +    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
> +
> +    info->u.sp_mem.data = di;
> +    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
> +}

if missing this doesn't break anything, I'd bundle it together with hmp patch


> +
> +static void sp_mem_realize(DeviceState *dev, Error **errp)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
> +        return;
> +    }
> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
> +        error_setg(errp, "memory backend '%s' is already in use",
> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
> +        return;
> +    }
> +    host_memory_backend_set_mapped(spm->hostmem, true);
> +}
> +
> +static void sp_mem_unrealize(DeviceState *dev)
> +{
> +    SpMemDevice *spm = SP_MEM(dev);
> +
> +    host_memory_backend_set_mapped(spm->hostmem, false);
> +}
> +
> +static const VMStateDescription vmstate_sp_mem = {
> +    .name = TYPE_SP_MEM,
> +    /* boot-time only; no plug/unplug state to migrate */
> +    .unmigratable = 1,

this is explicit migration blocker, isn't it?
are we sure about setting it un-migratable, if yes/no than why?

I don't see how plug/unplug is involved here,
but I'd speculate that we would want to migrate memory content itself.

CCing Peter,
 for a look from migration pov


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
> +    dc->unrealize = sp_mem_unrealize;
> +    dc->vmsd = &vmstate_sp_mem;
> +    device_class_set_props(dc, sp_mem_properties);
> +
> +    mdc->get_addr            = sp_mem_get_addr;
> +    mdc->set_addr            = sp_mem_set_addr;
> +    mdc->get_memory_region   = sp_mem_get_memory_region;
> +    mdc->get_plugged_size    = memory_device_get_region_size;
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


