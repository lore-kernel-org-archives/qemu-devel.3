Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB261CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTyMk-0007rb-Gj; Mon, 01 Jun 2026 04:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wTyMW-0007pO-Uy
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wTyMT-0001PX-QX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780303862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWbZkY3lOwJYZmNFmFKtUH6WKYcGf7GlA4NDuL1O33s=;
 b=PpagZcV2gNGacdATMGRd9hfYXzVc0QgGH5halIbPeMIi5Kv6ppr00QX08oMLhDi5iPRj4Q
 jEXuTqDbXDesPsopgI4J51fBBRDsrFJK97i1zCy0ljtETcUu3l9uRdTCrxwYRPQktse6/J
 IeoWY0MVHl1FjWMsiEiWKGzvUxe4ohY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Plkp1BdUOnmMiO5pDzXF5g-1; Mon, 01 Jun 2026 04:51:00 -0400
X-MC-Unique: Plkp1BdUOnmMiO5pDzXF5g-1
X-Mimecast-MFC-AGG-ID: Plkp1BdUOnmMiO5pDzXF5g_1780303859
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490abeb7298so3271525e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780303859; x=1780908659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWbZkY3lOwJYZmNFmFKtUH6WKYcGf7GlA4NDuL1O33s=;
 b=eJk3TZTZF16aaNfdrU2or6ha/qB7Ij33Dq15rvuZHtguLtJtHBwdweEb+og7BMMAXG
 24+x0XFVxFYsnULFw1ueGTMqFcdChPdM2P7dp4u5qE5FbSJ2WKBES7HkWT3jaDkgWnaG
 AviIh2EQxc856+QT2vce3UNIdn1eL2eT8RRZr6ZtCLfwES5MnUVSNo1r7n6v7ZyjhKIx
 QBranu/+1LT+wHGG4aJAS5j3eMRW5xob6/hxqNoUyBAsloLzq1fW6QWEbXhkaS0Fc5ae
 eaDtSUAguEB3E2DESRTxJXaUtT07rOS4+u7UBJTetujgngZQpKG9bPzB70RtHwgAfR9Y
 TQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780303859; x=1780908659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWbZkY3lOwJYZmNFmFKtUH6WKYcGf7GlA4NDuL1O33s=;
 b=rOksSj24OycNLgH87IitfhfHu7cmCapzn92c+rgpJC3t1yh1vEvPvHrx0yObL5mF62
 LNf1jy1I5sPwjGxQT8OHeIf1An7qq62ox7Y5PH9JmJtA7HVS5vt1YSqQdpxo9JEluf+8
 XRaeEgxMV2vywpqe5BhmlyqayX2MDtSqDEyvoQ/yNqZWz/Q2AeHFNDPenZ0+tDEcY7J9
 WzTGuAoCd8cW37VQr0h3c2Vp2ogiBPM7Kf1zv7ak2hk+7e5x4Y2Gee0Xkz8fl5RE6ymK
 VH3BVOnBqwpy4EGgpFCHlGJ8ENQKL4aFnPuQ21IccwEYy6g2FjbTBi8JdJdRfDlItAOX
 i9Bw==
X-Gm-Message-State: AOJu0Yy2eekjfxiLgf1DWdrxCPFpDMzuo6zDlwdAjK2pnCzAp7kFwUIi
 9iKbVX3pRTeR8UINYP4Xiqu5cBWhkLne/fKivY34csO3txhkTe5Ey3ZKaf5/OepnorIuL/wUaX+
 E38aCTPw/8whYuShyOrduFVYjffAVXW7G4P9j6+YmywND5NhOm8Pt7W1t
X-Gm-Gg: Acq92OFyyOUuIl9Q4GEabTTit/+pbyvj/wF1M2euGIc4MEDldaFeZgdxFWL3VsLOBog
 75u7aAzvFzUtQ3lyw2C2y11lL26rTE0vWSaGTTTWybEZbfdMZqf9XRGPH+rAnt1Ljvb8N7MSTwW
 UdjLESBsSb5wXiUzii6YsKaESIt/IGv1Wzfh97hxeEPal1//pnc9kWlHa4zG9Q1NwC2+q2kfmR3
 m0KqKzp3mHsEUsRDSN7vTKJV89ZXg9IV0Y2IQaT255yufjcLgMN/TyakFZa+vMgmLZwn96qAEce
 MjQa6zepaGlU409WqC7UmI7CvyBPHgxfVLH76oruYxF9ImQKWZyus+mSoUe96EScWIoeX/QTtuc
 z0uqZyvBd4FSwuTpK
X-Received: by 2002:a05:600c:3151:b0:490:ac9f:eab2 with SMTP id
 5b1f17b1804b1-490ac9feba0mr28862225e9.28.1780303859093; 
 Mon, 01 Jun 2026 01:50:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3151:b0:490:ac9f:eab2 with SMTP id
 5b1f17b1804b1-490ac9feba0mr28861475e9.28.1780303858505; 
 Mon, 01 Jun 2026 01:50:58 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0b896csm168752065e9.1.2026.06.01.01.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 01:50:58 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:50:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v8 1/1] hw/mem: add spm-memory device for Specific
 Purpose Memory
Message-ID: <20260601105057.2d764e55@imammedo>
In-Reply-To: <20260527074215.229119-2-FangSheng.Huang@amd.com>
References: <20260527074215.229119-1-FangSheng.Huang@amd.com>
 <20260527074215.229119-2-FangSheng.Huang@amd.com>
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

On Wed, 27 May 2026 15:42:15 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Introduce a TYPE_MEMORY_DEVICE subclass `spm-memory` for boot-time
> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
> proximity domain.
> 
> The device targets accelerator memory (HBM and similar) that the
> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
> in the guest -- rather than the kernel's general allocator -- owns
> the range.  Per-device NUMA placement matches the natural shape of
> multiple HBM blocks (one block == one driver claim == one PXM).
> 
> Usage:
> 
>     -object memory-backend-ram,id=spm0,size=8G
>     -numa node,nodeid=N
>     -device spm-memory,id=dev0,memdev=spm0,node=N[,addr=GPA]
> 
> The device:
> 
> - inherits TYPE_DEVICE and implements TYPE_MEMORY_DEVICE; placement
>   in machine->device_memory goes through the standard memory-device
>   framework (memory_device_pre_plug + memory_device_plug)
> - is boot-time only: dc->hotpluggable = false, and realize rejects
>   attempts past PHASE_MACHINE_READY
> - emits one E820 SOFT_RESERVED entry per instance at machine_done
> - emits one SRAT memory_affinity entry per instance at acpi-build,
>   ENABLED-only (no HOTPLUGGABLE flag)
> - rejects mixed-memory configurations on the target NUMA node at
>   realize-time
> - is reported by QMP query-memory-devices as a dedicated kind,
>   MEMORY_DEVICE_INFO_KIND_SPM_MEMORY
> 
> The device_memory SRAT umbrella entry in hw/i386/acpi-build.c is
> restructured to partition the region into per-kind chunks rather
> than emitting a single HOTPLUGGABLE entry covering everything.
> For each plugged TYPE_SPM_MEMORY device the partition emits an
> ENABLED entry at the device's proximity_domain; the remaining
> sub-ranges (gaps between SPM devices, leading and trailing
> padding, and ranges occupied by non-SPM memory devices) are
> emitted as HOTPLUGGABLE | ENABLED entries at the placeholder
> PXM (nb_numa_nodes - 1), preserving the upstream convention.
> 
> E820_SOFT_RESERVED is added to hw/i386/e820_memory_layout.h
> alongside the other type codes.
> 
> CONFIG_SPM_MEMORY is selected by the i386 PC and Q35 machines
> (same as DIMM).

this pass is mostly high level review.
patch is doing too much things at once,
Suggest to split it on several pieces,
 1. introducing spm-memory boiler plate code
 2. SRAT mangling
 3. adding E820 entry

> 
> MAINTAINERS gets new file entries under the existing "Memory devices"
> stanza.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>  MAINTAINERS                  |   2 +
a separate patch, pls.

>  hw/i386/Kconfig              |   2 +
>  hw/i386/acpi-build.c         | 105 ++++++++++++--
>  hw/i386/e820_memory_layout.h |  11 +-
>  hw/mem/Kconfig               |   4 +
>  hw/mem/meson.build           |   1 +
>  hw/mem/spm-memory.c          | 269 +++++++++++++++++++++++++++++++++++
>  include/hw/mem/spm-memory.h  |  43 ++++++
>  qapi/machine.json            |  43 +++++-
>  9 files changed, 459 insertions(+), 21 deletions(-)
>  create mode 100644 hw/mem/spm-memory.c
>  create mode 100644 include/hw/mem/spm-memory.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd5c4831e2..2a06515fc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3361,9 +3361,11 @@ S: Supported
>  F: hw/mem/memory-device*.c
>  F: hw/mem/nvdimm.c
>  F: hw/mem/pc-dimm.c
> +F: hw/mem/spm-memory.c
>  F: include/hw/mem/memory-device.h
>  F: include/hw/mem/nvdimm.h
>  F: include/hw/mem/pc-dimm.h
> +F: include/hw/mem/spm-memory.h
>  F: docs/nvdimm.txt
>  
>  SPICE
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 12473acaa7..e31a25b634 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -84,6 +84,7 @@ config I440FX
>      select PCI_I440FX
>      select PIIX
>      select DIMM
> +    select SPM_MEMORY
>      select SMBIOS
>      select SMBIOS_LEGACY
>      select FW_CFG_DMA
> @@ -113,6 +114,7 @@ config Q35
>      select LPC_ICH9
>      select AHCI_ICH9
>      select DIMM
> +    select SPM_MEMORY
>      select SMBIOS
>      select FW_CFG_DMA
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d7c83d5e9..865ab5fa4f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -52,6 +52,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/mem/spm-memory.h"
>  #include "system/numa.h"
>  #include "system/reset.h"
>  #include "hw/hyperv/vmbus-bridge.h"
> @@ -1346,6 +1347,95 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  }
>  #endif
>  
> +typedef struct {
> +    uint64_t addr;
> +    uint64_t size;
> +    uint32_t node;
> +} SpmRange;
> +
> +static int collect_spm_ranges_cb(Object *obj, void *opaque)
> +{
> +    GArray *ranges = opaque;
> +    SpmMemoryDevice *spm;
> +    MemoryDeviceClass *mdc;
> +    SpmRange r;
> +
> +    if (!object_dynamic_cast(obj, TYPE_SPM_MEMORY)) {
> +        return 0;
> +    }
> +    spm = SPM_MEMORY(obj);
> +    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
> +    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
> +    r.size = memory_region_size(
> +                 host_memory_backend_get_memory(spm->hostmem));
> +    r.node = spm->node;
> +    g_array_append_val(ranges, r);
> +    return 0;
> +}
> +
> +static gint spm_range_compare(gconstpointer a, gconstpointer b)
> +{
> +    const SpmRange *range_a = a;
> +    const SpmRange *range_b = b;
> +
> +    if (range_a->addr < range_b->addr) {
> +        return -1;
> +    }
> +    if (range_a->addr > range_b->addr) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Emit SRAT memory-affinity entries covering the device_memory region:
> + *   - ENABLED entry at the device's proximity_domain for each plugged
> + *     TYPE_SPM_MEMORY instance.
> + *   - HOTPLUGGABLE | ENABLED entry with PXM = nb_numa_nodes - 1 for
> + *     every remaining sub-range (gaps, leading/trailing padding, and
> + *     ranges occupied by non-SPM memory devices).
> + */
> +static void build_srat_device_memory(GArray *table_data, MachineState *ms)
> +{
> +    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpmRange));
> +    uint64_t cursor, end;
> +    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
> +    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
> +    guint i;
> +
> +    if (!ms->device_memory) {
> +        return;
> +    }
> +

> +    cursor = ms->device_memory->base;
> +    end = cursor + memory_region_size(&ms->device_memory->mr);
> +
> +    object_child_foreach_recursive(qdev_get_machine(),
> +                                   collect_spm_ranges_cb, ranges);
it's not an objection, but could we do better here, i.e. idea would be:
instead of full machine scan, take  ms->device_memory and go over
children regions -> pick only SPM device owned ones.

> +    g_array_sort(ranges, spm_range_compare);
> +
> +    for (i = 0; i < ranges->len; i++) {
> +        SpmRange *r = &g_array_index(ranges, SpmRange, i);
> +
> +        if (cursor < r->addr) {
> +            build_srat_memory(table_data, cursor, r->addr - cursor,
> +                              hotplug_pxm,
> +                              MEM_AFFINITY_HOTPLUGGABLE |
> +                              MEM_AFFINITY_ENABLED);
> +        }
> +        build_srat_memory(table_data, r->addr, r->size, r->node,
> +                          MEM_AFFINITY_ENABLED);
> +        cursor = r->addr + r->size;
> +    }
> +
> +    if (cursor < end) {
> +        build_srat_memory(table_data, cursor, end - cursor,
> +                          hotplug_pxm,
> +                          MEM_AFFINITY_HOTPLUGGABLE |
> +                          MEM_AFFINITY_ENABLED);
> +    }
> +}
> +
>  #define HOLE_640K_START  (640 * KiB)
>  #define HOLE_640K_END   (1 * MiB)
>  
> @@ -1473,20 +1563,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  
>      build_srat_generic_affinity_structures(table_data);
>  
> -    /*
> -     * Entry is required for Windows to enable memory hotplug in OS
> -     * and for Linux to enable SWIOTLB when booted with less than
> -     * 4G of RAM. Windows works better if the entry sets proximity
> -     * to the highest NUMA node in the machine.
> -     * Memory devices may override proximity set by this entry,
> -     * providing _PXM method if necessary.
> -     */

don't just delete comment,as it still stands true. we should keep reminder
why we adding place holder(s) and its quirks.

> -    if (machine->device_memory) {
> -        build_srat_memory(table_data, machine->device_memory->base,
> -                          memory_region_size(&machine->device_memory->mr),
> -                          nb_numa_nodes - 1,
> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> -    }
> +    build_srat_device_memory(table_data, machine);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> index b50acfa201..6ef169db9c 100644
> --- a/hw/i386/e820_memory_layout.h
> +++ b/hw/i386/e820_memory_layout.h
> @@ -10,11 +10,12 @@
>  #define HW_I386_E820_MEMORY_LAYOUT_H
>  
>  /* e820 types */
> -#define E820_RAM        1
> -#define E820_RESERVED   2
> -#define E820_ACPI       3
> -#define E820_NVS        4
> -#define E820_UNUSABLE   5
> +#define E820_RAM           1
> +#define E820_RESERVED      2
> +#define E820_ACPI          3
> +#define E820_NVS           4
> +#define E820_UNUSABLE      5
> +#define E820_SOFT_RESERVED 0xefffffff
>  
>  struct e820_entry {
>      uint64_t address;
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 73c5ae8ad9..4145870881 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
>      bool
>      default y if CXL
>      select MEM_DEVICE
> +
> +config SPM_MEMORY
> +    bool
> +    select MEM_DEVICE
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 8c2beeb7d4..2c28104282 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>  mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>  mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
>  mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
> +mem_ss.add(when: 'CONFIG_SPM_MEMORY', if_true: files('spm-memory.c'))
>  stub_ss.add(files('cxl_type3_stubs.c'))
>  
>  stub_ss.add(files('memory-device-stubs.c'))
> diff --git a/hw/mem/spm-memory.c b/hw/mem/spm-memory.c
> new file mode 100644
> index 0000000000..85887b2479
> --- /dev/null
> +++ b/hw/mem/spm-memory.c
> @@ -0,0 +1,269 @@
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
> +#include "hw/core/boards.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev.h"
> +#include "hw/mem/spm-memory.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/i386/e820_memory_layout.h"
> +#include "migration/vmstate.h"
> +#include "system/hostmem.h"
> +#include "system/numa.h"
> +#include "system/system.h"
> +
> +static QLIST_HEAD(, SpmMemoryDevice) spm_memory_list =
> +    QLIST_HEAD_INITIALIZER(spm_memory_list);
> +static Notifier spm_machine_done_notifier;
> +static bool spm_machine_done_registered;
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
> +typedef struct {
> +    uint32_t node_id;
> +    const SpmMemoryDevice *self;  /* exclude self when walking */
> +    bool conflict;
> +} SpmNodeCheckCtx;
> +
> +static int spm_check_node_collision_cb(Object *obj, void *opaque)
> +{
> +    SpmNodeCheckCtx *ctx = opaque;
> +    uint32_t other_node;
> +
> +    if (!object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
> +        return 0;
> +    }
> +    /*
> +     * Skip self.  Compare canonical Object* pointers, not interface-cast
> +     * MemoryDeviceState* (different address under INTERFACE_CHECK).
> +     */
> +    if (obj == OBJECT(ctx->self)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Not all memory-device subclasses have a "node" property; skip
> +     * those silently rather than asserting.
> +     */
> +    if (!object_property_find(obj, "node")) {
> +        return 0;
> +    }
> +    other_node = (uint32_t)object_property_get_uint(obj, "node", NULL);
> +    if (other_node == ctx->node_id) {
> +        ctx->conflict = true;
> +        return 1; /* stop walk */
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Require the target NUMA node to be SPM-only: driver-side discovery
> + * uses proximity_domain as the key, so a node mixing SPM with other
> + * memory yields ambiguous discovery.
> + */
> +static void spm_memory_check_node_exclusive(SpmMemoryDevice *spm,
> +                                            MachineState *ms, Error **errp)
> +{
> +    ERRP_GUARD();
> +    SpmNodeCheckCtx ctx = { spm->node, spm, false };
> +
> +    /* Bounds check: spm->node must be a valid NUMA node id */
> +    if (!ms->numa_state || spm->node >= ms->numa_state->num_nodes) {
> +        error_setg(errp,
> +                   "spm-memory: node %u out of range "
> +                   "(numa_state has %d nodes)", spm->node,
> +                   ms->numa_state ? ms->numa_state->num_nodes : 0);
> +        return;
> +    }
> +
> +    /* Check 1: target node must not have memory from -numa node,memdev= */
> +    if (ms->numa_state->nodes[spm->node].node_mem > 0) {
> +        error_setg(errp,
> +                   "spm-memory: NUMA node %u already has memory attached "
> +                   "via -numa node,memdev=; SPM nodes must be SPM-only",
> +                   spm->node);
> +        return;
> +    }
> +
> +    /* Check 2: target node must not already have another memory device */
> +    object_child_foreach_recursive(qdev_get_machine(),
> +                                   spm_check_node_collision_cb, &ctx);
> +    if (ctx.conflict) {
> +        error_setg(errp,
> +                   "spm-memory: NUMA node %u already has another memory "
> +                   "device plugged; SPM nodes must be SPM-only", spm->node);
> +        return;
> +    }
> +}
> +
> +static void spm_memory_machine_done(Notifier *n, void *opaque)
> +{
> +    SpmMemoryDevice *spm;
> +    MemoryDeviceClass *mdc;
> +    uint64_t addr, size;
> +
> +    QLIST_FOREACH(spm, &spm_memory_list, next) {
> +        g_assert(spm->hostmem);
> +        mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
> +        addr = mdc->get_addr(MEMORY_DEVICE(spm));
> +        size = memory_region_size(
> +                   host_memory_backend_get_memory(spm->hostmem));
> +        e820_add_entry(addr, size, E820_SOFT_RESERVED);
> +    }
> +}
> +
> +static void spm_memory_realize(DeviceState *dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    SpmMemoryDevice *spm = SPM_MEMORY(dev);

> +    MachineState *ms = MACHINE(qdev_get_machine());

pls do not use machine from device proper code.
we do have plug handlers that provide it at the time when necessary.

> +

> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        error_setg(errp, "spm-memory: hotplug is not supported "
> +                         "(boot-time-only device)");
> +        return;
> +    }

shouldn't be necessary, dc->hotpluggable in class init should be sufficient.

> +
> +    if (!spm->hostmem) {
> +        error_setg(errp, "'%s' property is required", SPM_MEMORY_MEMDEV_PROP);
> +        return;
> +    }
> +    if (host_memory_backend_is_mapped(spm->hostmem)) {
> +        error_setg(errp, "memory backend '%s' is already in use",
> +                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
> +        return;
> +    }
> +

> +    spm_memory_check_node_exclusive(spm, ms, errp);
> +    if (*errp) {
> +        return;
> +    }

As far as I understood fro previous discussions, so far it's our
own precaution.
 
I'd drop that, well, if you find a spec requiring it then
it should be a separate patch pointing to spec (or something else that
justifies it).  

> +
> +    memory_device_pre_plug(MEMORY_DEVICE(spm), ms, errp);
> +    if (*errp) {
> +        return;
> +    }

> +
> +    host_memory_backend_set_mapped(spm->hostmem, true);
> +    memory_device_plug(MEMORY_DEVICE(spm), ms);

That's basically code duplication, 
that doesn't belong to realize_fn, see how it's used by other devices. 

The gist is mapping into address space, generic checks, machine related
steps go into machine handlers. 


> +
> +    QLIST_INSERT_HEAD(&spm_memory_list, spm, next);
Don't use global list, unless you have to, see below.

> +
> +    if (!spm_machine_done_registered) {
> +        spm_machine_done_notifier.notify = spm_memory_machine_done;
> +        qemu_add_machine_init_done_notifier(&spm_machine_done_notifier);
> +        spm_machine_done_registered = true;
> +    }

e820 part should also go to machine specific plug handler,
that will also hel with getting rid of spm_memory_list.
That also should let you get rid of adding machine_done handler,
the machine plug handler, would do the job instead (and much earlier).

> +}
> +
> +static const VMStateDescription vmstate_spm_memory = {
> +    .name = TYPE_SPM_MEMORY,
> +    .unmigratable = 1,
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
> +}
> +
> +type_init(spm_memory_register_types)
> diff --git a/include/hw/mem/spm-memory.h b/include/hw/mem/spm-memory.h
> new file mode 100644
> index 0000000000..c662864b29
> --- /dev/null
> +++ b/include/hw/mem/spm-memory.h
> @@ -0,0 +1,43 @@
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
> +
> +OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass, SPM_MEMORY)
> +
> +struct SpmMemoryDevice {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +    QLIST_ENTRY(SpmMemoryDevice) next;
> +
> +    /*< public >*/
> +    HostMemoryBackend *hostmem;    /* memdev= backend */
> +    uint32_t node;                 /* NUMA proximity domain (node=) */
> +    uint64_t addr;                 /* GPA (from addr= or framework-assigned) */
> +};
> +
> +struct SpmMemoryDeviceClass {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +};
> +
> +#endif /* QEMU_SPM_MEMORY_H */
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..51b06d7cba 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1413,6 +1413,32 @@
>            }
>  }
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
> +# @spm-memory: since 11.1.
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'MemoryDeviceInfoKind',
>    'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> -            'hv-balloon' ] }
> +            'hv-balloon', 'spm-memory' ] }
>  
>  ##
>  # @PCDIMMDeviceInfoWrapper:
> @@ -1482,6 +1510,16 @@
>  { 'struct': 'HvBalloonDeviceInfoWrapper',
>    'data': { 'data': 'HvBalloonDeviceInfo' } }
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
>  ##
>  # @MemoryDeviceInfo:
>  #
> @@ -1499,7 +1537,8 @@
>              'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>              'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
>              'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> -            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
> +            'spm-memory': 'SpmMemoryDeviceInfoWrapper'
>            }
>  }
>  


