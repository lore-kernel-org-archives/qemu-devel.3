Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EBE1061B2D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7P0M-00070b-5U; Mon, 30 Mar 2026 22:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w7P0K-00070K-6q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:38:56 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w7P0H-0000Q4-Ni
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:38:55 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso4301657e0c.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774924732; x=1775529532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vbzo55q5WXfBbeRm+WA25oB976faWucpo7ciMtV1joY=;
 b=nx0a2HdpWOhEQodjWgJdIeC59ff/8j5OoaVsrbb5WuQKtq3fSbJd4eGtogG/qiDWyz
 X/fiXiw8b3Vet8aQgRLB4qrXaCR2FmMwoqI1IbNKIHCwvxKMM294UBfb+M7CiWyLb8TZ
 Ei4Vbsz8SQ6EQe7TWmTVWdQYIo4j/viUGjme1norCIehL2UEatT7+eQJq51uMCZtj+DZ
 iabdDMBmUGCcvPgd3391Pb4ocKeqQU1p2Pxl6psj3Bouw4JhHqxNCZJQEN/H0+XEcMYf
 B4pINoqlqOrQkB/vvIoF9e3s5spQqz2PRGRulumQc0c0ZiNErdRXUuRn+RtAx80M0xR7
 XGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774924732; x=1775529532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vbzo55q5WXfBbeRm+WA25oB976faWucpo7ciMtV1joY=;
 b=dSFBU4IKWimY1XwRExWOzKbwCH9PrWbS5SToAGcEwsTaAWqL951tI5s13tnN9DJN86
 RJzzCOrxImunGE2wjvo32H3DZ3fMmwvt3eXblD1ACl78UGAsBLs6kg8M1yYVZZLrjWEy
 OjoiWwu2/QjoqMr/QtyW5RXDBf1eW3c3zzPqHqFXnev+hVQLobvTnnsrksO4P2OGW/I8
 dr+DkkJKerwcOWQdO/vK5A5bKLOKt2tgEfu9iMd3rVHh28PdzKFHvlVISJXXJ4JRshXf
 ysQCOSh7gpbNNrNKVmgxeZBIOS+xLyMH27f7TZoSA8z8C8StYFDJE39B1DiY8OKZn6r0
 XbEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKdmzi4Vel+B1HK++r2PaVpqr7c2roRrGjd/BW+iTbMXNDnhEHDvNNL9flgrgDdeypB6RfEOuca5w7@nongnu.org
X-Gm-Message-State: AOJu0Yx6OpMbIOREUNwCptz+TbBWFamyoechIW5f80TiSADgZ6Fw5KbN
 HMhCh5yEH83MOyyw44MzTqooEgj9tYrC/81osyJgzc/khHt8Ba4yKuvkfdx4nyGDIdw=
X-Gm-Gg: ATEYQzykg38IGh+qD+3/LId0MuvORPwCW86W8QecYChNQOSRlIHgjpXOW+Qz63Vo8Qn
 +SiPn7xYCpnWyDn/7f20+fKUGL3lGItkTrLbZUpJHhfHdagYaCQ/vIAir7GBY9y6vYOETnpLXE0
 zcR8g6KG1WC9c+MailwQhhKu81G6MBSvSDPOuaRoeEUSbNceht6AJXC8ygW5MKRQGlC7wd/DHvj
 +91I4DxbuS6pYOFHY/skEkVjEMZulcTSuh11rVPbpI6U0b9p5Rd9+K4gWk+1wGLzAqeiYh/jMvL
 JaeBb674zTbOy6Ed89s5dTArVt3uqvcbe/58w62xLw/2jjQ8l30LWjCejy4YYRxqF3hBaIqDRm3
 90VNdtcYqWC1jNKhoASAEJ6JedsReWlPti2tqZAFAfL8Owo2e3n/zuGzIfEm+NmaQelZt7yBudN
 5FQhnNcjgZ/3BOQok7p72MXI5eOJEhb6tWuiA=
X-Received: by 2002:a05:6102:5109:b0:5ff:f4ae:a17c with SMTP id
 ada2fe7eead31-604f9055d3dmr6343082137.3.1774924732259; 
 Mon, 30 Mar 2026 19:38:52 -0700 (PDT)
Received: from [192.168.0.104] ([186.215.53.158])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9539e47a026sm8893100241.11.2026.03.30.19.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 19:38:51 -0700 (PDT)
Message-ID: <19ecc22b-747a-4568-a178-da2dd12eae50@linaro.org>
Date: Mon, 30 Mar 2026 23:38:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 3/8] hw/arm/virt: add cache hierarchy to device tree
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260311160609.358-1-alireza.sanaee@huawei.com>
 <20260311160609.358-4-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260311160609.358-4-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa35.google.com
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

Hi Alireza,

On 3/11/26 13:06, Alireza Sanaee wrote:
> Specify which level (core/cluster/socket) caches found at in the CPU
> topology. Updating cache topology to device tree (spec v0.4).
> Example:
> 
> For example, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
> created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
> cores will have L1d and L1i.  However, extending this is not difficult.
> The clusters will share a unified L2 level cache, and finally sockets
> will share L3. In this patch, threads will share L1 caches by default,
> but this can be adjusted if case required.
> 
> Only three levels of caches are supported.  The patch does not
> allow partial declaration of caches. In other words, the topology level
> of every cache must be specified if that of any level is.
> 
> ./qemu-system-aarch64 \
>      -machine virt,\
>           smp-cache.0.cache=l1i,smp-cache.0.topology=core,\
>           smp-cache.1.cache=l1d,smp-cache.1.topology=core,\
>           smp-cache.2.cache=l2,smp-cache.2.topology=cluster,\
>           smp-cache.3.cache=l3,smp-cache.3.topology=socket\
>      -cpu max \
>      -m 2048 \
>      -smp sockets=2,clusters=2,cores=4,threads=1 \
>      -kernel ./Image.gz \
>      -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>      -initrd rootfs.cpio.gz \
>      -bios ./edk2-aarch64-code.fd \
>      -nographic
> 
> For instance, following device tree will be generated for a scenario
> where we have 2 sockets, 2 clusters, 2 cores and 2 threads, in total 16
> PEs. L1i and L1d are private to each thread, and L2 and L3 are shared at
> socket level as an example.
> 
> Limitation: SMT cores cannot share L1 cache for now. This
> problem does not exist in PPTT tables.
> 
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
> Thanks for the review Gustavo.
> Change log:
>       v18->v19:
>            - Fix comments. Adding more details to the commit message.
>            - Removed the extra check on existence of cache at the topology level
>                 in add_cpu_cache_hierarchy function since it is already checked
>                 in fdt_add_cpu_nodes function.
>            - Fixed typos.
> 
>   hw/arm/virt.c         | 335 +++++++++++++++++++++++++++++++++++++++++-
>   include/hw/arm/virt.h |  17 ++-
>   include/hw/core/cpu.h |  12 ++
>   3 files changed, 362 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..87fb31ec6b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -91,6 +91,7 @@
>   #include "hw/virtio/virtio-md-pci.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/char/pl011.h"
> +#include "hw/core/cpu.h"
>   #include "hw/cxl/cxl.h"
>   #include "hw/cxl/cxl_host.h"
>   #include "qemu/guest-random.h"
> @@ -281,6 +282,86 @@ static bool ns_el2_virt_timer_present(void)
>           arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
>   }
>   
> +void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
> +                   int cache_level, bool is_i_cache0)
> +{
> +    int bank_index = ((cache_level - 1) * 2) | is_i_cache0;
> +    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
> +    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
> +
> +    if (ccidx) {
> +        *cpu_cache = (CPUCoreCaches){
> +            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                         CCIDX_LINESIZE) + 4),
> +            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                        CCIDX_ASSOCIATIVITY) + 1,
> +            .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                               CCIDX_NUMSETS) + 1,
> +        };
> +    } else {
> +        *cpu_cache = (CPUCoreCaches){
> +            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                         LINESIZE) + 4),
> +            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                        ASSOCIATIVITY) + 1,
> +            .sets =
> +                FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1, NUMSETS) + 1,
> +        };
> +    }
> +    cpu_cache->type = cache_type;
> +    cpu_cache->level = cache_level;
> +    cpu_cache->size = cpu_cache->associativity *
> +                             cpu_cache->sets *
> +                             cpu_cache->linesize;
> +
> +    return;
> +}
> +
> +unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
> +{
> +    int num_cache = 0;
> +    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
> +    ARMISARegisters *isar = &armcpu->isar;
> +    uint32_t clidr = GET_IDREG(isar, CLIDR);
> +
> +    for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL;
> +         cache_level++) {
> +        uint8_t ctype =
> +            (clidr >> (3 * (cache_level - 1))) & CLIDR_CTYPE_MAX_CACHE_LEVEL;
> +
> +        if (ctype == CLIDR_CTYPE_NO_CACHE) {
> +            /*
> +             * If a "No cache" cache type is found it means no manageable caches
> +             * exist at further-out levels of hierarchy, so ignore them.
> +             */
> +            break;
> +        } else if (ctype == CLIDR_CTYPE_SEPARATE_I_D_CACHES) {
> +            /*
> +             * Create separate D and I caches. D-cache is stored first.
> +             */
> +            enum CacheType cache_type;
> +            for (cache_type = DATA_CACHE; cache_type <= INSTRUCTION_CACHE;
> +                 cache_type++) {
> +                set_cpu_cache(&caches[num_cache++], cache_type, cache_level,
> +                              cache_type == INSTRUCTION_CACHE ? true : false);
> +            }
> +        } else if (ctype == CLIDR_CTYPE_UNIFIED_CACHE) {
> +            set_cpu_cache(&caches[num_cache++], UNIFIED_CACHE, cache_level,
> +                          false);
> +        } else if (ctype == CLIDR_CTYPE_D_CACHE) {
> +            set_cpu_cache(&caches[num_cache++], DATA_CACHE, cache_level, false);
> +        } else if (ctype == CLIDR_CTYPE_I_CACHE) {
> +            set_cpu_cache(&caches[num_cache++], INSTRUCTION_CACHE, cache_level,
> +                          true);
> +        } else {
> +            error_setg(&error_abort, "Unrecognized cache type");
> +            return 0;
> +        }
> +    }
> +
> +    return num_cache;
> +}
> +
>   static void create_fdt(VirtMachineState *vms)
>   {
>       MachineState *ms = MACHINE(vms);
> @@ -431,13 +512,124 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
>       }
>   }
>   
> +static void add_cache_node(void *fdt, char *nodepath, CPUCoreCaches cache,
> +                           uint32_t *next_level)
> +{
> +    /* Assume L2/3 are unified caches. */
> +
> +    uint32_t phandle;
> +
> +    qemu_fdt_add_path(fdt, nodepath);
> +    phandle = qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "phandle", phandle);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-level", cache.level);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-size", cache.size);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-block-size", cache.linesize);
> +    qemu_fdt_setprop_cell(fdt, nodepath, "cache-sets", cache.sets);
> +    qemu_fdt_setprop(fdt, nodepath, "cache-unified", NULL, 0);
> +    qemu_fdt_setprop_string(fdt, nodepath, "compatible", "cache");
> +    if (cache.level != 3) {
> +        /* top level cache doesn't have next-level-cache property */
> +        qemu_fdt_setprop_cell(fdt, nodepath, "next-level-cache", *next_level);
> +    }
> +
> +    *next_level = phandle;
> +}
> +
> +static bool add_cpu_cache_hierarchy(void *fdt, CPUCoreCaches* cache,
> +                                    uint32_t cache_cnt,
> +                                    uint32_t top_level,
> +                                    uint32_t bottom_level,
> +                                    uint32_t cpu_id,
> +                                    uint32_t *next_level) {
> +    bool found_cache = false;
> +
> +    for (int level = top_level; level >= bottom_level; level--) {
> +        for (int i = 0; i < cache_cnt; i++) {
> +            char *nodepath;
> +
> +            if (i != level) {
> +                continue;
> +            }
> +
> +            nodepath = g_strdup_printf("/cpus/cpu@%d/l%d-cache",
> +                                       cpu_id, level);
> +            add_cache_node(fdt, nodepath, cache[i], next_level);
> +            found_cache = true;
> +            g_free(nodepath);
> +
> +        }
> +    }
> +
> +    return found_cache;
> +}
> +
> +static void set_cache_properties(void *fdt, const char *nodename,
> +                                 const char *prefix, CPUCoreCaches cache)
> +{
> +    char prop_name[64];
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-block-size", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.linesize);
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-size", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.size);
> +
> +    snprintf(prop_name, sizeof(prop_name), "%s-sets", prefix);
> +    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.sets);
> +}
> +
> +static bool partial_cache_description(const MachineState *ms, int num_caches)
> +{
> +    assert(num_caches - 1 < CACHE_LEVEL_AND_TYPE__MAX);
> +    enum CpuTopologyLevel topo_level;
> +    enum CacheLevelAndType cache_level;
> +
> +    for (cache_level = 0; cache_level < num_caches; cache_level++) {
> +        topo_level = machine_get_cache_topo_level(ms, cache_level);
> +        if (topo_level == CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +            /* No topology level described for this cache level. */
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>   {
>       int cpu;
>       int addr_cells = 1;
>       const MachineState *ms = MACHINE(vms);
> +    const MachineClass *mc = MACHINE_GET_CLASS(ms);
>       const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       int smp_cpus = ms->smp.cpus;
> +    int socket_id, cluster_id, core_id;
> +    uint32_t next_level = 0;
> +    uint32_t socket_offset = 0;
> +    uint32_t cluster_offset = 0;
> +    uint32_t core_offset = 0;
> +    int last_socket = -1;
> +    int last_cluster = -1;
> +    int last_core = -1;
> +    int top_node = 3;
> +    int top_cluster = 3;
> +    int top_core = 3;
> +    int bottom_node = 3;
> +    int bottom_cluster = 3;
> +    int bottom_core = 3;
> +    unsigned int num_cache;
> +    CPUCoreCaches caches[CPU_MAX_CACHES];
> +    bool cache_created = false;
> +    bool cache_at_topo_level;
> +
> +    num_cache = virt_get_caches(vms, caches);
> +
> +    if (mc->smp_props.has_caches &&
> +        partial_cache_description(ms, num_cache)) {
> +        error_setg(&error_fatal, "Missing cache description");
> +        return;
> +    }
>   
>       /*
>        * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -466,9 +658,14 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>   
>       for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
> +        socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
> +        cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
> +        core_id = cpu / ms->smp.threads % ms->smp.cores;
> +
>           char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>           ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
>           CPUState *cs = CPU(armcpu);
> +        const char *prefix = NULL;
>   
>           qemu_fdt_add_subnode(ms->fdt, nodename);
>           qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
> @@ -498,6 +695,136 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                                     qemu_fdt_alloc_phandle(ms->fdt));
>           }
>   
> +        if (!vmc->no_cpu_topology && num_cache) {
> +            for (uint8_t i = 0; i < num_cache; i++) {
> +                /* Only level 1 in the CPU entry. */
> +                if (caches[i].level > 1) {
> +                    continue;
> +                }
> +
> +                if (caches[i].type == INSTRUCTION_CACHE) {
> +                    prefix = "i-cache";
> +                } else if (caches[i].type == DATA_CACHE) {
> +                    prefix = "d-cache";
> +                } else if (caches[i].type == UNIFIED_CACHE) {
> +                    error_setg(&error_fatal,
> +                               "Unified type is not implemented at level %d",
> +                               caches[i].level);
> +                    return;
> +                } else {
> +                    error_setg(&error_fatal, "Undefined cache type");
> +                    return;
> +                }
> +
> +                set_cache_properties(ms->fdt, nodename, prefix, caches[i]);
> +            }
> +        }
> +
> +        if (socket_id != last_socket) {
> +            bottom_node = top_node;
> +            /* This assumes socket as the highest topological level. */
> +            socket_offset = 0;
> +            cluster_offset = 0;
> +            cache_at_topo_level =
> +                machine_find_lowest_level_cache_at_topo_level(ms,
> +                    &bottom_node,
> +                    CPU_TOPOLOGY_LEVEL_SOCKET);
> +            if (cache_at_topo_level) {
> +                if (bottom_node == 1 && !virt_is_acpi_enabled(vms))
> +                    error_setg(
> +                        &error_fatal,
> +                        "Cannot share L1 at socket_id %d."
> +                        "DT limitation on sharing at cache level = 1",
> +                        socket_id);
> +
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
> +                                                        num_cache,
> +                                                        top_node,
> +                                                        bottom_node, cpu,
> +                                                        &socket_offset);
> +
> +                if (!cache_created) {
> +                    error_setg(&error_fatal,
> +                               "Socket: No caches at levels %d-%d",
> +                               top_node, bottom_node);
> +                    return;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
> +            last_socket = socket_id;
> +        }
> +
> +        if (cluster_id != last_cluster) {
> +            bottom_cluster = top_cluster;
> +            cluster_offset = socket_offset;
> +            core_offset = 0;
> +            cache_at_topo_level =
> +                machine_find_lowest_level_cache_at_topo_level(ms,
> +                    &bottom_cluster,
> +                    CPU_TOPOLOGY_LEVEL_CLUSTER);
> +            if (cache_at_topo_level) {
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
> +                                                        num_cache,
> +                                                        top_cluster,
> +                                                        bottom_cluster, cpu,
> +                                                        &cluster_offset);
> +                if (bottom_cluster == 1 && !virt_is_acpi_enabled(vms)) {
> +                    error_setg(&error_fatal,
> +                        "Cannot share L1 at socket_id %d, cluster_id %d. "
> +                        "DT limitation on sharing at cache level = 1.",
> +                        socket_id, cluster_id);
> +                }
> +
> +                if (!cache_created) {
> +                    error_setg(&error_fatal,
> +                               "Cluster: No caches at levels %d-%d.",
> +                               top_cluster, bottom_cluster);
> +                    return;
> +                }
> +
> +                top_core = bottom_cluster - 1;
> +            } else if (top_cluster == bottom_node - 1) {
> +                top_core = bottom_node - 1;
> +            }
> +
> +            last_cluster = cluster_id;
> +        }
> +
> +        if (core_id != last_core) {
> +            bottom_core = top_core;
> +            core_offset = cluster_offset;
> +            cache_at_topo_level =
> +                machine_find_lowest_level_cache_at_topo_level(ms,
> +                    &bottom_core,
> +                    CPU_TOPOLOGY_LEVEL_CORE);
> +            if (cache_at_topo_level) {
> +                if (bottom_core == 1 && top_core > 1) {
> +                    bottom_core++;
> +                    cache_created = add_cpu_cache_hierarchy(ms->fdt,
> +                                                            caches,
> +                                                            num_cache,
> +                                                            top_core,
> +                                                            bottom_core, cpu,
> +                                                            &core_offset);
> +
> +                    if (!cache_created) {
> +                        error_setg(&error_fatal,
> +                                   "Core: No caches at levels %d-%d",
> +                                   top_core, bottom_core);
> +                        return;
> +                    }
> +                }
> +            }
> +
> +            last_core = core_id;
> +        }
> +
> +        next_level = core_offset;
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "next-level-cache",
> +                              next_level);
> +
>           g_free(nodename);
>       }
>   
> @@ -2912,7 +3239,7 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
>   }
>   
>   
> -bool virt_is_acpi_enabled(VirtMachineState *vms)
> +bool virt_is_acpi_enabled(const VirtMachineState *vms)
>   {
>       if (vms->acpi == ON_OFF_AUTO_OFF) {
>           return false;
> @@ -3496,6 +3823,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>       hc->unplug = virt_machine_device_unplug_cb;
>       mc->nvdimm_supported = true;
>       mc->smp_props.clusters_supported = true;
> +
> +    /* Supported caches */
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
> +    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
>       mc->auto_enable_numa_with_memhp = true;
>       mc->auto_enable_numa_with_memdev = true;
>       /* platform instead of architectural choice */
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index dba8ac7f2f..b22868c210 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -41,6 +41,7 @@
>   #include "system/kvm.h"
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "qom/object.h"
> +#include "hw/core/cpu.h"
>   
>   #define NUM_GICV2M_SPIS       64
>   #define NUM_VIRTIO_TRANSPORTS 32
> @@ -52,6 +53,8 @@
>   /* GPIO pins */
>   #define GPIO_PIN_POWER_BUTTON  3
>   
> +#define CPU_MAX_CACHES 16
> +
>   enum {
>       VIRT_FLASH,
>       VIRT_MEM,
> @@ -195,7 +198,19 @@ struct VirtMachineState {
>   OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
>   
>   void virt_acpi_setup(VirtMachineState *vms);
> -bool virt_is_acpi_enabled(VirtMachineState *vms);
> +bool virt_is_acpi_enabled(const VirtMachineState *vms);
> +
> +#define CLIDR_CTYPE_NO_CACHE 0x00
> +#define CLIDR_CTYPE_I_CACHE 0x01
> +#define CLIDR_CTYPE_D_CACHE 0x02
> +#define CLIDR_CTYPE_SEPARATE_I_D_CACHES 0x03
> +#define CLIDR_CTYPE_UNIFIED_CACHE 0x04
> +#define CLIDR_CTYPE_MAX_CACHE_LEVEL 7
> +
> +unsigned int virt_get_caches(const VirtMachineState *vms,
> +                             CPUCoreCaches *caches);
> +void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
> +                   int cache_level, bool is_i_cache);
>   
>   /* Return number of redistributors that fit in the specified region */
>   static uint32_t virt_redist_capacity(VirtMachineState *vms, int region)
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 7d2f4459d2..08f8df3586 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1218,4 +1218,16 @@ enum CacheType {
>       UNIFIED_CACHE
>   };
>   
> +struct CPUCoreCaches {
> +    enum CacheType type;
> +    uint32_t sets;
> +    uint32_t size;
> +    uint32_t level;
> +    uint16_t linesize;
> +    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
> +    uint8_t associativity;
> +};
> +
> +typedef struct CPUCoreCaches CPUCoreCaches;
> +
>   #endif

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

