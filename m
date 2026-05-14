Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1870CCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNVlX-000651-Nj; Thu, 14 May 2026 09:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNVlS-00064r-CW
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNVlP-0006kC-8s
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778763964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4XkJxRR0cwctEb5WioDu6Owg8uthD+5eEyugrKIRWU=;
 b=V5vfvdQAhI+XzJonKao7WstdRXEGbTuZL/ghDVbNZT/yAiR+Cbq7St7oOm1QZLh02gdN1+
 iuDBAPrk8gUbGP00N1JX2vAUzfc+KDixs34gI/97x68Tn6JR3A38aMVRKWFGiE3riX8Bo5
 MXqFrt6i5b6Y1Ea+HZDvA5xE3Y5iOiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-2mSCz66GNbiPkznPAzM2FQ-1; Thu, 14 May 2026 09:06:03 -0400
X-MC-Unique: 2mSCz66GNbiPkznPAzM2FQ-1
X-Mimecast-MFC-AGG-ID: 2mSCz66GNbiPkznPAzM2FQ_1778763962
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fe24773c8so1721555e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778763962; x=1779368762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4XkJxRR0cwctEb5WioDu6Owg8uthD+5eEyugrKIRWU=;
 b=BVBBwD9rHt1sLBYejQGQJ59Zkw9vkGPHejijHyikFfvGCGv84qp/QUyeeE8KcBHn95
 f8wLOcvB3dFW+c9vqrzcBZvaGnG0foudxY5gKzRREAXkXUByBNzGxFEmp9VhERkRZLu8
 UJYnO0XuX0RAXv/RsPrz6d48hZdxl+Ra+9G93Cp8Zls+DDj7NcExop5ZsUCIbFejB7yd
 Q5vWWMZMNB0jdUwCJj598u2ObmI+lV7LJfGvMi5ZwWxPRF+/Y8VfD3poCBGSRDhkTzKR
 5nkYBuPuu0RPd7wELh6zYrBh1GYIWekRx7wOEc0+v3AkLVTRKcEXsFTR72O6G9BN7BOC
 Q5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778763962; x=1779368762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4XkJxRR0cwctEb5WioDu6Owg8uthD+5eEyugrKIRWU=;
 b=N3zaVB+4xK4DQCyl87Afu/4IEcpP8U9dYtuhcVYc7n7We5Rng4ZzMEQ0ugVzu1gQ7J
 1MzL5BQEIw3q/K/KL8ZGtTHhVaJ7MIKwnA0MEbKrtYZ3hocBf9dccxGR12LWkAriZ7//
 Rqz4ueprhl7Jd9C+frTwSSgpUe8I8Q5u029D/OI816wvukXzDaAoytsgsDntyXK/xy5Y
 IqtzJpKQhO+m3gEB/Jg1BbrJ97C8Mdsx+Mtd+vKvcDzFICGY2IVtj1Mn8WUJWeZqEmvF
 llWjNsGMUTO4g98dvq6adE/aySrO+QmVM/Iz+p9afUXQsFoVzt6MV2HG3ntQTw7BR7e3
 kWdg==
X-Gm-Message-State: AOJu0YypuobZJZ62csxw9KGj4cZC5/j5QHbMJPgCIEVHimQD4wr0B47d
 GEJul41+Ehfzm4JjRnzkS73rNgK6w7LGyw0A7B4iPHnBT/nGxcqqWZrkZSpdGBpUDa7YgKLmX4i
 kKuAYgSlCXqoezcLAMfAf0kY0gHt4g+dFZ69TOFlmFCN1KfVEn18WlCdn
X-Gm-Gg: Acq92OG3pegmTd10azhpIX8cvfMFX05lF5vsg3WXsbvPxRGjn/Ch/UFBFqXP8MD89Pz
 gFJGTkFXqMcoVrB6/CymXiAMt7deE2ZcYNt/lPMjcaro+aDAnmspcfqf34zF9nU2l1kh8fnOaVx
 CUm/PgA5DZhQW8WG4tSgaRWaUTRI24NiRAraYQLSoddlgb856afoq0UYFXXOAI/C9J05WjkDOJE
 v3bGr1V3rEKWxvNMANrELq5MqM4+kHrBq7GnXQ/K0gW4S6fBts8os3LPv4N+dkm7CRvOK+7uhS3
 pVMmqTKYhU7cwV235YgqFpHUpVBM1RzSICuUC5tx/V3ED2s5wloaK67tWZjxAMTtwwx+lxsVjlV
 WluIJAjM5WmSx6Gxd
X-Received: by 2002:a05:600c:8b2b:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48fc9a4db09mr126292175e9.29.1778763961703; 
 Thu, 14 May 2026 06:06:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2b:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48fc9a4db09mr126291445e9.29.1778763961173; 
 Thu, 14 May 2026 06:06:01 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fde643428sm28980325e9.3.2026.05.14.06.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:06:00 -0700 (PDT)
Date: Thu, 14 May 2026 15:05:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@redhat.com>, <gourry@gourry.net>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260514150559.3148f9dc@imammedo>
In-Reply-To: <20260306082735.1106690-2-FangSheng.Huang@amd.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
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

On Fri, 6 Mar 2026 16:27:35 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add a 'memmap-type' option to NUMA node configuration that allows
> specifying the memory type for a NUMA node.
> 
> Supported values:
>   - normal:   Regular system RAM (E820 type 1, default)
>   - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>   - reserved: Reserved memory (E820 type 2)
> 
> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
> that this memory might be managed by device drivers based on guest policy.
> The 'reserved' type marks memory as not usable as RAM.
> 
> Note: This option is only supported on x86 platforms.
> 
> Usage:
>   -numa node,nodeid=1,memdev=m1,memmap-type=spm

in short:
  don't do it this way
  I'm against merging it as is, till you convince me otherwise.

more detailed answer:

* mandatory bashing chapter:

the more i look at it, the hackier this approach looks to me,
and what even worse that nonsense propagates to firmware.

Judging by commit message, the goal is to expose some RAM as
E820 SPM, to guest (that's it).

You however picked -numa node as a way to achieve that,
and then hack the numa code not to generate numa data for it (SRAT)
and massage e820 to exclude SPM from  RAM entries.

But at this stage I don't really see a good justification for hack(s)
this patch introduces (it's definitely is not in commit message not cover letter).

And until alternative approach is not explored and proved to be worse,
I'm against merging this patch.

* suggestion chapter:

I don't recall but I likely asked before
why not use device memory instead for it (aka DIMM device or some device derived
from device memory object and then add e820 entry for it).

It would be a way more simpler approach and impl. without need to resplit
anything in e820.
And no need for messing with firmware (SeaBIOS: RamSizeOver4G patch) nor EDK2.



> 
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
> Acked-by: David Hildenbrand <david@kernel.org>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  hw/core/numa.c               | 24 ++++++++++++
>  hw/i386/acpi-build.c         |  8 ++++
>  hw/i386/e820_memory_layout.c | 72 ++++++++++++++++++++++++++++++++++++
>  hw/i386/e820_memory_layout.h | 12 +++---
>  hw/i386/pc.c                 | 48 ++++++++++++++++++++++++
>  include/system/numa.h        |  7 ++++
>  qapi/machine.json            | 24 ++++++++++++
>  qemu-options.hx              | 14 ++++++-
>  8 files changed, 202 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index f462883c87..521c8f10f1 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -38,6 +38,7 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/core/boards.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/i386/x86.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
> @@ -164,6 +165,29 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>      }
>  
> +    if (node->has_memmap_type && node->memmap_type != NUMA_MEMMAP_TYPE_NORMAL) {
> +        if (!node->memdev) {
> +            error_setg(errp, "memmap-type=%s requires memdev to be specified",
> +                       NumaMemmapType_str(node->memmap_type));
> +            return;
> +        }
> +        if (!object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> +            error_setg(errp, "memmap-type=%s is only supported on x86 machines",
> +                       NumaMemmapType_str(node->memmap_type));
> +            return;
> +        }
> +        switch (node->memmap_type) {
> +        case NUMA_MEMMAP_TYPE_SPM:
> +            numa_info[nodenr].memmap_type = NUMA_MEMMAP_SPM;
> +            break;
> +        case NUMA_MEMMAP_TYPE_RESERVED:
> +            numa_info[nodenr].memmap_type = NUMA_MEMMAP_RESERVED;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>      ms->numa_state->num_nodes++;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f622b91b76..521bf66ca1 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1417,6 +1417,14 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          mem_len = numa_info[i - 1].node_mem;
>          next_base = mem_base + mem_len;
>  
> +        /*
> +         * Skip reserved memory nodes - E820 marks them as reserved,
> +         * so SRAT should not report them as enabled memory affinity.
> +         */
> +        if (numa_info[i - 1].memmap_type == NUMA_MEMMAP_RESERVED) {
> +            continue;
> +        }
> +
>          /* Cut out the 640K hole */
>          if (mem_base <= HOLE_640K_START &&
>              next_base > HOLE_640K_START) {
> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
> index 3e848fb69c..4c62b5ddea 100644
> --- a/hw/i386/e820_memory_layout.c
> +++ b/hw/i386/e820_memory_layout.c
> @@ -46,3 +46,75 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
>      }
>      return false;
>  }
> +
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
> +{
> +    uint64_t end = start + length;
> +    assert(!e820_done);
> +
> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
> +    if (new_type == E820_SOFT_RESERVED) {
> +        bool range_in_ram = false;
> +
> +        for (size_t j = 0; j < e820_entries; j++) {
> +            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
> +            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
> +            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
> +
> +            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end) {
> +                range_in_ram = true;
> +                break;
> +            }
> +        }
> +        if (!range_in_ram) {
> +            return false;
> +        }
> +    }
> +
> +    /* Find entry that contains the target range and update it */
> +    for (size_t i = 0; i < e820_entries; i++) {
> +        uint64_t entry_start = le64_to_cpu(e820_table[i].address);
> +        uint64_t entry_length = le64_to_cpu(e820_table[i].length);
> +        uint64_t entry_end = entry_start + entry_length;
> +
> +        if (entry_start <= start && entry_end >= end) {
> +            uint32_t original_type = e820_table[i].type;
> +
> +            /* Remove original entry */
> +            memmove(&e820_table[i], &e820_table[i + 1],
> +                    (e820_entries - i - 1) * sizeof(struct e820_entry));
> +            e820_entries--;
> +
> +            /* Add split parts inline */
> +            if (entry_start < start) {
> +                e820_table = g_renew(struct e820_entry, e820_table,
> +                                     e820_entries + 1);
> +                e820_table[e820_entries].address = cpu_to_le64(entry_start);
> +                e820_table[e820_entries].length =
> +                    cpu_to_le64(start - entry_start);
> +                e820_table[e820_entries].type = original_type;
> +                e820_entries++;
> +            }
> +
> +            e820_table = g_renew(struct e820_entry, e820_table,
> +                                 e820_entries + 1);
> +            e820_table[e820_entries].address = cpu_to_le64(start);
> +            e820_table[e820_entries].length = cpu_to_le64(length);
> +            e820_table[e820_entries].type = cpu_to_le32(new_type);
> +            e820_entries++;
> +
> +            if (end < entry_end) {
> +                e820_table = g_renew(struct e820_entry, e820_table,
> +                                     e820_entries + 1);
> +                e820_table[e820_entries].address = cpu_to_le64(end);
> +                e820_table[e820_entries].length = cpu_to_le64(entry_end - end);
> +                e820_table[e820_entries].type = original_type;
> +                e820_entries++;
> +            }
> +
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> index b50acfa201..a85b4fd14c 100644
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
> +#define E820_RAM            1
> +#define E820_RESERVED       2
> +#define E820_ACPI           3
> +#define E820_NVS            4
> +#define E820_UNUSABLE       5
> +#define E820_SOFT_RESERVED  0xEFFFFFFF
>  
>  struct e820_entry {
>      uint64_t address;
> @@ -26,5 +27,6 @@ void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
>  bool e820_get_entry(int index, uint32_t type,
>                      uint64_t *address, uint64_t *length);
>  int e820_get_table(struct e820_entry **table);
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type);
>  
>  #endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 819e729a6e..c024a34db2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -740,6 +740,51 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>      return pc_above_4g_end(pcms) - 1;
>  }
>  
> +/*
> + * Update E820 entries for NUMA nodes with non-default memory types.
> + */
> +static void pc_update_numa_memory_types(X86MachineState *x86ms)
> +{
> +    MachineState *ms = MACHINE(x86ms);
> +    uint64_t addr = 0;
> +
> +    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
> +        NodeInfo *numa_info = &ms->numa_state->nodes[i];
> +        uint64_t node_size = numa_info->node_mem;
> +
> +        if (numa_info->node_memdev &&
> +            (numa_info->memmap_type == NUMA_MEMMAP_SPM ||
> +             numa_info->memmap_type == NUMA_MEMMAP_RESERVED)) {
> +            uint64_t guest_addr;
> +            uint32_t e820_type = (numa_info->memmap_type == NUMA_MEMMAP_SPM)
> +                                  ? E820_SOFT_RESERVED : E820_RESERVED;
> +
> +            if (addr < x86ms->below_4g_mem_size) {
> +                if (addr + node_size <= x86ms->below_4g_mem_size) {
> +                    guest_addr = addr;
> +                } else {
> +                    error_report("NUMA node %d with memmap-type spans across "
> +                                 "4GB boundary, not supported", i);
> +                    exit(EXIT_FAILURE);
> +                }
> +            } else {
> +                guest_addr = x86ms->above_4g_mem_start +
> +                            (addr - x86ms->below_4g_mem_size);
> +            }
> +
> +            if (!e820_update_entry_type(guest_addr, node_size, e820_type)) {
> +                warn_report("Failed to update E820 entry for node %d "
> +                           "at 0x%" PRIx64 " length 0x%" PRIx64,
> +                           i, guest_addr, node_size);
> +            }
> +        }
> +
> +        if (numa_info->node_memdev) {
> +            addr += node_size;
> +        }
> +    }
> +}
> +
>  /*
>   * AMD systems with an IOMMU have an additional hole close to the
>   * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
> @@ -856,6 +901,9 @@ void pc_memory_init(PCMachineState *pcms,
>          e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
>      }
>  
> +    /* Update E820 for NUMA nodes with special memory types */
> +    pc_update_numa_memory_types(x86ms);
> +
>      if (!pcmc->has_reserved_memory &&
>          (machine->ram_slots ||
>           (machine->maxram_size > machine->ram_size))) {
> diff --git a/include/system/numa.h b/include/system/numa.h
> index 1044b0eb6e..64e8f63736 100644
> --- a/include/system/numa.h
> +++ b/include/system/numa.h
> @@ -35,12 +35,19 @@ enum {
>  
>  #define UINT16_BITS       16
>  
> +typedef enum {
> +    NUMA_MEMMAP_NORMAL = 0,
> +    NUMA_MEMMAP_SPM,
> +    NUMA_MEMMAP_RESERVED,
> +} NumaMemmapTypeInternal;
> +
>  typedef struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
>      bool has_cpu;
>      bool has_gi;
> +    NumaMemmapTypeInternal memmap_type;
>      uint8_t lb_info_provided;
>      uint16_t initiator;
>      uint8_t distance[MAX_NODES];
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..67ba487f6c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -466,6 +466,22 @@
>  { 'enum': 'NumaOptionsType',
>    'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
>  
> +##
> +# @NumaMemmapType:
> +#
> +# Memory mapping type for a NUMA node.
> +#
> +# @normal: Normal system RAM (E820 type 1)
> +#
> +# @spm: Specific Purpose Memory (E820 type 0xEFFFFFFF)
> +#
> +# @reserved: Reserved memory (E820 type 2)
> +#
> +# Since: 10.2
> +##
> +{ 'enum': 'NumaMemmapType',
> +  'data': ['normal', 'spm', 'reserved'] }
> +
>  ##
>  # @NumaOptions:
>  #
> @@ -502,6 +518,13 @@
>  # @memdev: memory backend object.  If specified for one node, it must
>  #     be specified for all nodes.
>  #
> +# @memmap-type: specifies the memory type for this NUMA node.
> +#     'normal' (default) is regular system RAM.
> +#     'spm' is Specific Purpose Memory - a hint to the guest that
> +#     this memory might be managed by device drivers based on policy.
> +#     'reserved' is reserved memory, not usable as RAM.
> +#     Currently only supported on x86.  (since 10.2)
> +#
>  # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>  #     to the nodeid which has the memory controller responsible for
>  #     this NUMA node.  This field provides additional information as
> @@ -516,6 +539,7 @@
>     '*cpus':   ['uint16'],
>     '*mem':    'size',
>     '*memdev': 'str',
> +   '*memmap-type': 'NumaMemmapType',
>     '*initiator': 'uint16' }}
>  
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0da2b4d034..c898428822 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -433,7 +433,7 @@ ERST
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node][,memmap-type=normal|spm|reserved]\n"
>      "-numa dist,src=source,dst=destination,val=distance\n"
>      "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>      "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
> @@ -442,7 +442,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>  SRST
>  ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
>    \ 
> -``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
> +``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator][,memmap-type=type]``
>    \
>  ``-numa dist,src=source,dst=destination,val=distance``
>    \ 
> @@ -510,6 +510,16 @@ SRST
>      largest bandwidth) to this NUMA node. Note that this option can be
>      set only when the machine property 'hmat' is set to 'on'.
>  
> +    '\ ``memmap-type``\ ' specifies the memory type for this NUMA node:
> +
> +    - ``normal`` (default): Regular system RAM (E820 type 1)
> +    - ``spm``: Specific Purpose Memory (E820 type 0xEFFFFFFF). This is a
> +      hint to the guest that the memory might be managed by device drivers
> +      based on guest policy.
> +    - ``reserved``: Reserved memory (E820 type 2), not usable as RAM.
> +
> +    This option is only supported on x86 platforms.
> +
>      Following example creates a machine with 2 NUMA nodes, node 0 has
>      CPU. node 1 has only memory, and its initiator is node 0. Note that
>      because node 0 has CPU, by default the initiator of node 0 is itself


