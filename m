Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5016FCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbe5b-0004QO-VR; Mon, 22 Jun 2026 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe5b-0004QF-2y
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe5Z-0004zV-0U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDweJFPNLcjZsW0+IHsRhMBFLDutj96EQCJO+mZv7ls=;
 b=HViLGRF3eaqMC0QIU2O5VcQGuEfv5DjNpjaYdrtBzS1nJxDlX7Sm6OIKrTVKdIvmrczHkK
 37BONa+kfJUF84ukZExrD9O8NGY7YSEMRcEvx+BY8IfZhe042yzU187Jv/EpMzIY2knepW
 d1DEKj7wirr079Hi1iNoQBFOHikKX6c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-G5urueuYOZalwoEhcmoU8A-1; Mon, 22 Jun 2026 08:49:18 -0400
X-MC-Unique: G5urueuYOZalwoEhcmoU8A-1
X-Mimecast-MFC-AGG-ID: G5urueuYOZalwoEhcmoU8A_1782132557
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c0db30ce19aso125806866b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782132557; x=1782737357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDweJFPNLcjZsW0+IHsRhMBFLDutj96EQCJO+mZv7ls=;
 b=txGSekHRyoSiWpKXha2WjCCDMyarWxqcRVprHaQgqf8VBMkw62J//5xdQu6B7XTDb3
 mLMP8hD87P701MAidTI5BYfXNuYbybQ/wpqqgj7nIwkV1hxN95PhM344duw/2kd6kV6Y
 vONoi1cvcWfLnLf/+NpNOpp58Ef6lmsykn63zYONFLbuI58M9pLX/ltKIksR9aTpBC6+
 Kybu/+ML5fAHLXA/JjUQTu3nLeh7EpG5wfNUAAec5FTqLgfGxBiqo9CGCN3kFdd/He4k
 y3QVdKHuIz5y3TSxz4DrFXv3Y4ng4mFL7s1EzvSg6H4bHsUUGe3DUDLZWegy/BomAI1l
 yJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132557; x=1782737357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDweJFPNLcjZsW0+IHsRhMBFLDutj96EQCJO+mZv7ls=;
 b=SMWIJ2T3BRGMEvdx2VysuB1+3ex0EIcbEv7eiI6t8Ueopr0dqL8A6d0w9K5wFqBLGr
 8rRUx4qld8OsxCkAxnN4OhUBZiwNSzSVmVcccAzeGnwwMq47hJiOcVMeyddD+NAb/iBP
 g+jFkHUQvtJvrzadPP7u2wxD0FDZ7BFLUx/F7C920xFmB1tH0Q/unEdY2zsJWSfa1HXY
 cvkISOkYAnOKMgPyCVjXun0Nlr4F4p0ougoysxa0Y69JF99Cx1BhU0lSFcCk1q5Cl0lT
 J2GwN2AHq9pwRd5RG+HQ5j05E3LNxBtxpUUGa4WD4fHU8J1aBIbD+KDxQCa7Vjy80UNW
 s5JA==
X-Gm-Message-State: AOJu0YyvBB7OVWXRpJKuNRi44uwEtM0ZVvxdS2a2S25ldqlZHZBebfRA
 XkGQNX/OH4ytu61dnDR03LAa5P4kMRPa42weTEEHbRMysaTsYpaKJmUAusFsXk5tPC+0mo44nCW
 zF4SfL0JTcH8ZItyt+w7+iETb6TwXtxGi7Ta8nzGaKDjvQ57RufSOo6yS
X-Gm-Gg: AfdE7cn9JYdaAMv4YrYHJcdTP1iCijGqrj3WpHVjcNwh8DIskFRovanwgycre/hqtow
 ao7uVjlaDeDIQnjL4olvEDqVvX6CPagtQjNxXTpxrRFZJj/fiuE4Q4wQoJLyf7eXkxVX6QJIwjn
 n3ub6FFEJ65XsOohZ5XAmIN5bi/fFPgK+lEEPO2JY6m8S9zR+jLIxLRx1ckTl8CSV63/PgkdpvZ
 +vnOI8j7U+K9BR/sHaHg7VZaNoz0jGa/m9ek8lOBvy3gLnLzy4q2Ym0IwUK7qsBATJILFsPl+LF
 NvbQMJO1DMP+NwUInyAf9U7QmQFbc/jtrkR9126Zc6QUZdVG/sWYPO3DB3u3v87dXDAeTq4=
X-Received: by 2002:a17:907:60cd:b0:bee:4562:3308 with SMTP id
 a640c23a62f3a-c097c6c17b9mr645808066b.26.1782132557170; 
 Mon, 22 Jun 2026 05:49:17 -0700 (PDT)
X-Received: by 2002:a17:907:60cd:b0:bee:4562:3308 with SMTP id
 a640c23a62f3a-c097c6c17b9mr645806066b.26.1782132556544; 
 Mon, 22 Jun 2026 05:49:16 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e49a9fbsm354224966b.12.2026.06.22.05.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:49:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:49:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 01/10] hw/mem: add sp-mem device for Specific
 Purpose Memory
Message-ID: <20260622144914.29be828b@imammedo>
In-Reply-To: <20260619111136.3481329-2-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-2-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 19 Jun 2026 19:11:27 +0800
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  include/hw/mem/sp-mem.h |  33 ++++++++++++
>  hw/mem/sp-mem.c         | 109 ++++++++++++++++++++++++++++++++++++++++
>  hw/mem/Kconfig          |   4 ++
>  hw/mem/meson.build      |   1 +
>  4 files changed, 147 insertions(+)
>  create mode 100644 include/hw/mem/sp-mem.h
>  create mode 100644 hw/mem/sp-mem.c
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
> diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
> new file mode 100644
> index 0000000000..d088222f54
> --- /dev/null
> +++ b/hw/mem/sp-mem.c
> @@ -0,0 +1,109 @@
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
> +static void sp_mem_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
> +
> +    dc->desc = "SPM (Specific Purpose Memory) device";
> +    dc->hotpluggable = false;
> +    dc->realize = sp_mem_realize;
> +    dc->unrealize = sp_mem_unrealize;
> +    device_class_set_props(dc, sp_mem_properties);
> +
> +    mdc->get_addr            = sp_mem_get_addr;
> +    mdc->set_addr            = sp_mem_set_addr;
> +    mdc->get_memory_region   = sp_mem_get_memory_region;
> +    mdc->get_plugged_size    = memory_device_get_region_size;
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


