Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B3CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqxf-0007xk-OH; Mon, 20 Oct 2025 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqxd-0007wm-OU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:09 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqxa-000288-7X
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:34:09 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso2861663a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760970843; x=1761575643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IB/GmjzpLoptyto6Y6E6ro1/cvOi90Plpuog8w9IMyI=;
 b=ok2Gl2xuNJsF0gp/8FWo4terveMMtXIq6QxO8S9vA0nQIXDg2reMbHuYl58dttu0Xe
 eU1aj5oIVp5dnVVpOX7EQXLc5v5mn7iGUhdYMWVC2W2TKVtZRk6vVlYE5LFt1NzdhlAf
 Y99fl/+d1VMxq6PU3eFvjLPkQBO/I9HDgleQFap9sllEttBV0PKixvSoNoDfY8A1njku
 CbwuIWj2BYGKnEegjhMKu0USnB3oxceYXOqQk0N61+DvgPOgCZYjBjnhP+dsw2ZyP5dm
 CB5i5AFUrP4dNbLX+lvwRVj+213QllNsTQS7si+DChhvOq53vEfAmrmlwXNwJLdGWQ2z
 cKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970843; x=1761575643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IB/GmjzpLoptyto6Y6E6ro1/cvOi90Plpuog8w9IMyI=;
 b=cF1cPMezVbgEC0jvPGivhanuphv+IXAcM8yDidkE4OUuTP8k6oqv23GyRvoYkfu4Gd
 BebhXqSgvX08VCcStPtA2iQ5Tho/FtZ3WFW0KV2UyScnUkxFLhgWGe0tH4tO9/jSbQOZ
 JC5wdZ8in6DJlM6nxlN326VvcADGj3fHXernN/map7fbLGYUFhQxJTclc4tE2jY0vR9v
 GHIgRG39xd0iRubOGVzVARFzgy148vICxPVB6REVS7q/+pa2PoJz3xFPkyUUrS7tpSrP
 NLg91ayvcJ/ihLIjzGsc5oDYGZRVpaql/tqgxb3hLV+dr7qCjNeSLTufjfuYpcWW5zte
 3CCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcveEaH4TvnTvUPKmoObzW7/hj8t+o8mD30hD6Nstt2rM7EjTrAXk/WMFAWPXrmTIi2M3V8vFyYsiG@nongnu.org
X-Gm-Message-State: AOJu0Yzc0kpwVXVDAmrL/x8/UXHX3XuLS3SXtd3aHxKsoyZLpRugUyLo
 DJCSDUCF4bi1+Brw7Eh4N+H40mbmmCY76Lvkvgw9yliLY8B/6joaPDnsFtbR5VvlPjQ=
X-Gm-Gg: ASbGncs8KHNjx/iomexjlQY72WMMklaQBXT1fm2ZBdGUCEnrlSGPfNnsV4Nqr1wFDcX
 xLMvckrANjp8tavfxgMCjLzQZANKa6DfeZGjXjw0QD2hpT6dS1YjejkeL0cfS5UHE/y841ijbV2
 sW3lgqYujIWQalkwE4/ffBuf7SN61lkJUHE5ucp94D3haHK7rKitWKWEP2SI3m2BTos2EZm5GQO
 L+PyC0kQBnSDOLWVQp9smQ/8ZnZ+tVx+jWYape+ZXALKFRkF/lTWu1niXx/j/hqLYjCKbRzp2ct
 j7+nWEAmZN5leEGnwlXd7C92iVgYz6UQJwwoTeOc+7QQlCXQqr3VGVEdg/J3YGQforZB9kXa4jc
 5fOFvsb5nR35kDZwe8MXoiKEYtwMd57HdS2Nx6M0GP3Vv9iPGXLf5NGLG3KvSm+mOSyJ4rvbN+w
 xJmkR4QhMoRcYCICXwbgNrSZsOAyQVn/1zhIa4bsc+/AdgwA2tOBEzm4h/h5g1CQ/TIa/f8/DBe
 zI=
X-Google-Smtp-Source: AGHT+IHp8AK4UEVL8UKqbGePGhAy4l3OvyYFReS8U7Bcbgp+MlwmkY/6YDU5b5WP6qdP25V6Y15MtA==
X-Received: by 2002:a17:902:c942:b0:26a:8171:daf7 with SMTP id
 d9443c01a7336-290c9cbc095mr179549875ad.16.1760970842806; 
 Mon, 20 Oct 2025 07:34:02 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:5a7c:524e:bcac:abea?
 ([2804:7f0:b401:1d95:5a7c:524e:bcac:abea])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcde4sm82722395ad.5.2025.10.20.07.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 07:34:02 -0700 (PDT)
Message-ID: <f9bfc752-2ed4-40f8-bcb2-429dec55ca5a@linaro.org>
Date: Mon, 20 Oct 2025 11:33:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 6/8] hw/acpi: add cache hierarchy to pptt table
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mst@redhat.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
References: <20250827142152.206-1-alireza.sanaee@huawei.com>
 <20250827142152.206-7-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250827142152.206-7-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alireza,

On 8/27/25 11:21, Alireza Sanaee wrote:
> Add cache topology to PPTT table. With this patch, both ACPI PPTT table
> and device tree will represent the same cache topology given users
> input.

This patch touches APCI only, so please remove "and device tree" from the
comment message. I understand you're saying it considering the series, but
in this case the commit message should describe the changes in its commit only.


Cheers,
Gustavo

> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   hw/acpi/aml-build.c      | 200 +++++++++++++++++++++++++++++++++++++--
>   hw/arm/virt-acpi-build.c |   8 +-
>   include/hw/acpi/cpu.h    |  10 ++
>   3 files changed, 209 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index e854f14565..72b6bfdbe9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -31,6 +31,7 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_bridge.h"
>   #include "qemu/cutils.h"
> +#include "hw/core/cpu.h"
>   
>   static GArray *build_alloc_array(void)
>   {
> @@ -2140,6 +2141,104 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>       }
>       acpi_table_end(linker, &table);
>   }
> +
> +static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
> +                              uint32_t next_offset)
> +{
> +    int val;
> +
> +    /* Type 1 - cache */
> +    build_append_byte(tbl, 1);
> +    /* Length */
> +    build_append_byte(tbl, 24);
> +    /* Reserved */
> +    build_append_int_noprefix(tbl, 0, 2);
> +    /* Flags */
> +    build_append_int_noprefix(tbl, 0x7f, 4);
> +    /* Offset of next cache up */
> +    build_append_int_noprefix(tbl, next_offset, 4);
> +    build_append_int_noprefix(tbl, cache->size, 4);
> +    build_append_int_noprefix(tbl, cache->sets, 4);
> +    build_append_byte(tbl, cache->associativity);
> +    val = 0x3;
> +    switch (cache->type) {
> +    case INSTRUCTION_CACHE:
> +        val |= (1 << 2);
> +        break;
> +    case DATA_CACHE:
> +        val |= (0 << 2); /* Data */
> +        break;
> +    case UNIFIED_CACHE:
> +        val |= (3 << 2); /* Unified */
> +        break;
> +    }
> +    build_append_byte(tbl, val);
> +    build_append_int_noprefix(tbl, cache->linesize, 2);
> +}
> +
> +/*
> + * builds caches from the top level (`level_high` parameter) to the bottom
> + * level (`level_low` parameter).  It searches for caches found in
> + * systems' registers, and fills up the table. Then it updates the
> + * `data_offset` and `instr_offset` parameters with the offset of the data
> + * and instruction caches of the lowest level, respectively.
> + */
> +static bool build_caches(GArray *table_data, uint32_t pptt_start,
> +                         int num_caches, CPUCoreCaches *caches,
> +                         uint8_t level_high, /* Inclusive */
> +                         uint8_t level_low,  /* Inclusive */
> +                         uint32_t *data_offset,
> +                         uint32_t *instr_offset)
> +{
> +    uint32_t next_level_offset_data = 0, next_level_offset_instruction = 0;
> +    uint32_t this_offset, next_offset = 0;
> +    int c, level;
> +    bool found_cache = false;
> +
> +    /* Walk caches from top to bottom */
> +    for (level = level_high; level >= level_low; level--) {
> +        for (c = 0; c < num_caches; c++) {
> +            if (caches[c].level != level) {
> +                continue;
> +            }
> +
> +            /* Assume only unified above l1 for now */
> +            this_offset = table_data->len - pptt_start;
> +            switch (caches[c].type) {
> +            case INSTRUCTION_CACHE:
> +                next_offset = next_level_offset_instruction;
> +                break;
> +            case DATA_CACHE:
> +                next_offset = next_level_offset_data;
> +                break;
> +            case UNIFIED_CACHE:
> +                /* Either is fine here */
> +                next_offset = next_level_offset_instruction;
> +                break;
> +            }
> +            build_cache_nodes(table_data, &caches[c], next_offset);
> +            switch (caches[c].type) {
> +            case INSTRUCTION_CACHE:
> +                next_level_offset_instruction = this_offset;
> +                break;
> +            case DATA_CACHE:
> +                next_level_offset_data = this_offset;
> +                break;
> +            case UNIFIED_CACHE:
> +                next_level_offset_instruction = this_offset;
> +                next_level_offset_data = this_offset;
> +                break;
> +            }
> +            *data_offset = next_level_offset_data;
> +            *instr_offset = next_level_offset_instruction;
> +
> +            found_cache = true;
> +        }
> +    }
> +
> +    return found_cache;
> +}
> +
>   /*
>    * ACPI spec, Revision 6.3
>    * 5.2.29 Processor Properties Topology Table (PPTT)
> @@ -2150,11 +2249,32 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       CPUArchIdList *cpus = ms->possible_cpus;
> -    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> -    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> +    uint32_t core_data_offset = 0;
> +    uint32_t core_instr_offset = 0;
> +    uint32_t cluster_instr_offset = 0;
> +    uint32_t cluster_data_offset = 0;
> +    uint32_t node_data_offset = 0;
> +    uint32_t node_instr_offset = 0;
> +    int top_node = 3;
> +    int top_cluster = 3;
> +    int top_core = 3;
> +    int bottom_node = 3;
> +    int bottom_cluster = 3;
> +    int bottom_core = 3;
> +    int64_t socket_id = -1;
> +    int64_t cluster_id = -1;
> +    int64_t core_id = -1;
> +    uint32_t socket_offset = 0;
> +    uint32_t cluster_offset = 0;
> +    uint32_t core_offset = 0;
>       uint32_t pptt_start = table_data->len;
>       uint32_t root_offset;
>       int n;
> +    uint32_t priv_rsrc[2];
> +    uint32_t num_priv = 0;
> +    bool cache_available;
> +    bool llevel;
> +
>       AcpiTable table = { .sig = "PPTT", .rev = 2,
>                           .oem_id = oem_id, .oem_table_id = oem_table_id };
>   
> @@ -2184,11 +2304,30 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>               socket_id = cpus->cpus[n].props.socket_id;
>               cluster_id = -1;
>               core_id = -1;
> +            bottom_node = top_node;
> +            num_priv = 0;
> +            cache_available = machine_defines_cache_at_topo_level(
> +                ms, CPU_TOPOLOGY_LEVEL_SOCKET);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(
> +                ms, &bottom_node, CPU_TOPOLOGY_LEVEL_SOCKET);
> +            if (cache_available && llevel) {
> +                build_caches(table_data, pptt_start, num_caches, caches,
> +                             top_node, bottom_node, &node_data_offset,
> +                             &node_instr_offset);
> +                priv_rsrc[0] = node_instr_offset;
> +                priv_rsrc[1] = node_data_offset;
> +                if (node_instr_offset || node_data_offset) {
> +                    num_priv = node_instr_offset == node_data_offset ? 1 : 2;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
>               socket_offset = table_data->len - pptt_start;
>               build_processor_hierarchy_node(table_data,
>                   (1 << 0) | /* Physical package */
>                   (1 << 4), /* Identical Implementation */
> -                root_offset, socket_id, NULL, 0);
> +                root_offset, socket_id, priv_rsrc, num_priv);
>           }
>   
>           if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
> @@ -2196,21 +2335,68 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                   assert(cpus->cpus[n].props.cluster_id > cluster_id);
>                   cluster_id = cpus->cpus[n].props.cluster_id;
>                   core_id = -1;
> +                bottom_cluster = top_cluster;
> +                num_priv = 0;
> +                cache_available = machine_defines_cache_at_topo_level(
> +                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER);
> +                llevel = machine_find_lowest_level_cache_at_topo_level(
> +                    ms, &bottom_cluster, CPU_TOPOLOGY_LEVEL_CLUSTER);
> +
> +                if (cache_available && llevel) {
> +                    build_caches(table_data, pptt_start, num_caches, caches,
> +                                 top_cluster, bottom_cluster,
> +                                 &cluster_data_offset, &cluster_instr_offset);
> +                    priv_rsrc[0] = cluster_instr_offset;
> +                    priv_rsrc[1] = cluster_data_offset;
> +                    if (cluster_instr_offset || cluster_data_offset) {
> +                        num_priv =
> +                            cluster_instr_offset == cluster_data_offset ? 1 : 2;
> +                    }
> +                    top_core = bottom_cluster - 1;
> +                } else if (top_cluster == bottom_node - 1) {
> +                    /* socket cache but no cluster cache */
> +                    top_core = bottom_node - 1;
> +                }
> +
>                   cluster_offset = table_data->len - pptt_start;
>                   build_processor_hierarchy_node(table_data,
>                       (0 << 0) | /* Not a physical package */
>                       (1 << 4), /* Identical Implementation */
> -                    socket_offset, cluster_id, NULL, 0);
> +                    socket_offset, cluster_id, priv_rsrc, num_priv);
>               }
>           } else {
> +            if (machine_defines_cache_at_topo_level(
> +                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER)) {
> +                error_setg(&error_fatal, "Not clusters found for the cache");
> +                return;
> +            }
> +
>               cluster_offset = socket_offset;
> +            top_core = bottom_node - 1; /* there is no cluster */
> +        }
> +
> +        if (cpus->cpus[n].props.core_id != core_id) {
> +            bottom_core = top_core;
> +            num_priv = 0;
> +            cache_available = machine_defines_cache_at_topo_level(
> +                ms, CPU_TOPOLOGY_LEVEL_CORE);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(
> +                ms, &bottom_core, CPU_TOPOLOGY_LEVEL_CORE);
> +            if (cache_available && llevel) {
> +                build_caches(table_data, pptt_start, num_caches, caches,
> +                             top_core, bottom_core, &core_data_offset,
> +                             &core_instr_offset);
> +                priv_rsrc[0] = core_instr_offset;
> +                priv_rsrc[1] = core_data_offset;
> +                num_priv = core_instr_offset == core_data_offset ? 1 : 2;
> +            }
>           }
>   
>           if (ms->smp.threads == 1) {
>               build_processor_hierarchy_node(table_data,
>                   (1 << 1) | /* ACPI Processor ID valid */
> -                (1 << 3),  /* Node is a Leaf */
> -                cluster_offset, n, NULL, 0);
> +                (1 << 3), /* Node is a Leaf */
> +                cluster_offset, n, priv_rsrc, num_priv);
>           } else {
>               if (cpus->cpus[n].props.core_id != core_id) {
>                   assert(cpus->cpus[n].props.core_id > core_id);
> @@ -2219,7 +2405,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                   build_processor_hierarchy_node(table_data,
>                       (0 << 0) | /* Not a physical package */
>                       (1 << 4), /* Identical Implementation */
> -                    cluster_offset, core_id, NULL, 0);
> +                    cluster_offset, core_id, priv_rsrc, num_priv);
>               }
>   
>               build_processor_hierarchy_node(table_data,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a6115f2f80..5fca69fcb2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1022,6 +1022,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       unsigned dsdt, xsdt;
>       GArray *tables_blob = tables->table_data;
>       MachineState *ms = MACHINE(vms);
> +    CPUCoreCaches caches[CPU_MAX_CACHES];
> +    unsigned int num_caches;
> +
> +    num_caches = virt_get_caches(vms, caches);
>   
>       table_offsets = g_array_new(false, true /* clear */,
>                                           sizeof(uint32_t));
> @@ -1043,8 +1047,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>   
>       if (!vmc->no_cpu_topology) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_pptt(tables_blob, tables->linker, ms,
> -                   vms->oem_id, vms->oem_table_id, 0, NULL);
> +        build_pptt(tables_blob, tables->linker, ms, vms->oem_id,
> +                   vms->oem_table_id, num_caches, caches);
>       }
>   
>       acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 32654dc274..a4027a2a76 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -70,6 +70,16 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>   
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>   
> +struct CPUPPTTCaches {
> +    enum CacheType type;
> +    uint32_t sets;
> +    uint32_t size;
> +    uint32_t level;
> +    uint16_t linesize;
> +    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
> +    uint8_t associativity;
> +};
> +
>   extern const VMStateDescription vmstate_cpu_hotplug;
>   #define VMSTATE_CPU_HOTPLUG(cpuhp, state) \
>       VMSTATE_STRUCT(cpuhp, state, 1, \


