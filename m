Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE04CCD1A4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqxF-0007td-Un; Mon, 20 Oct 2025 10:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqx5-0007sM-5z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:33:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqwz-00023w-PD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:33:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-290b48e09a7so51309145ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760970806; x=1761575606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6PZwKrCIDN1btrdbj0AGh2ssYj5hmMYIV62MhvWTTHg=;
 b=VbCWHtWLp/0rIgw6ryQTE7+KKcQsOhe2zn8YpeoLOuH2ijnIphIaUzL45CmUIv1mLk
 srzbnSbo+Gk5aMg2oO4SfvzVJVMCH087XBpR9PEPF4A/ACa0/3VfHDK4472hRPhvvYYa
 TZj6OvNWWu0I1ucuUriS/86uX/c4quFPTq7SZTPHBhsxgSNZaKBmjG0eeEh8kRUJ4guO
 vraT2W9+/EZgZ5f16xb8bqhFrJV/i9EP86Z/IWamEowjVxZQxJioak1nrEp8DJiXFz/m
 NMrd7h8MJGJrcD1TzyvwTjmRj8hUyK4/SOj7Y/asOdPTksQl3mXbNqXIwMJ+HT0q208w
 URHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970806; x=1761575606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6PZwKrCIDN1btrdbj0AGh2ssYj5hmMYIV62MhvWTTHg=;
 b=dsmAmeo0H54IE0vKYuFGFf26769ZhZ8j7PE+6aZzGIvXtCB4t5OA6HuFBda7cOwPxj
 IjC8pxTFuHdJG/Hzr8AC/JmKzuvQ43ecCiV+aK6Chk0N3mV6O/AFUwg+oOh0L9Z4Hkr0
 jS9fxbgXn/JsKDvUGQ4onVsEULD0VcwMmX8N7tTOmWMpdVOIvnnAotPZDq7R6P/F2rR3
 VoM6+5jPXg0+C8Hb2vEo3hIJ2axhYbg9zHcSl+uspdpum2POh0nTUPHJl9YEcRKKzRpI
 llDhuMlfV/dTHbbFXpx2EXmjAg5b8DOJAF/Ss3NY9AbLnP0Gwn6p0G5yvd3GwQ1whfND
 rjtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLM5eADVp2zqrlTcOpaJfP2q8SkU6l9VwoD/gB7Sko9bBPdL/CT+SECnuWERhKYIOhgk3xfha0SyE8@nongnu.org
X-Gm-Message-State: AOJu0Yyaw8lMzjGaOpYXJNmGFP9iUUbNfxZdaPguqowJ+fqNEP68J2C/
 Y6pUhMHx0YDB9LYdRjac1tK2WITtbciPgpJ4X+3AlarI/QpO0MA4urWJntxpRRHVs0M=
X-Gm-Gg: ASbGncsGGQ0+e0NVn21aazNg3nHK7U8o0tq4GVhdj+jowApDo00yj2PDRhDyb6F7i+b
 XWPl5kg+hXDo+gMG2LlLV/1k+6X5s/ku8lJjoKHbUcjE6RVe4unWvw0JddnA4nNwlf0cahd/FEY
 N+BTivModzQHtzrFWaBULhONT1lTzUNu7BgbvqJzTh88/911jaXmRZOoz+yUqqtVS/x5W1s3AXL
 j9xAH26ePSZzjPs/RDwOiGjAUZuABFpEkR1WNzOf8sh/t8RZyJ6HpN5GnPyURY7YLgpkCu7dEug
 QERpF4EIJMTedRV+M268qMVq+ONwNt7szDxFOPJzU5jUDAa3TRFgu29UJYh2IdbtARhQmKe03NO
 xDH+Tedfej1O4ZbqVoMBvXMSHKQkIV4IOTgSXr3U6hhmeMnTQnavWuWw002NO7Ijj45XXYRWaHk
 q/uRzJOCOlc9ycJp9oH/6hfDH/2O5JtEb3SMy1+gvMZxHEge1gvWZlHTMfh+PdX6i4
X-Google-Smtp-Source: AGHT+IFR1ZeI+O9ZoQEhtB7oMFOKnacrnmeAKj/wu0cfXj03GnBkjB8IXzz8xMEPQdlnaortsHtJkA==
X-Received: by 2002:a17:902:dac6:b0:290:b158:5db8 with SMTP id
 d9443c01a7336-290cb65b668mr192780485ad.44.1760970806139; 
 Mon, 20 Oct 2025 07:33:26 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:5a7c:524e:bcac:abea?
 ([2804:7f0:b401:1d95:5a7c:524e:bcac:abea])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de14becsm8269256a91.10.2025.10.20.07.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 07:33:25 -0700 (PDT)
Message-ID: <7829a001-cede-49a5-855b-40cabc65c15a@linaro.org>
Date: Mon, 20 Oct 2025 11:33:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/8] hw/arm/virt: add cache hierarchy to device tree
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mst@redhat.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
References: <20250827142152.206-1-alireza.sanaee@huawei.com>
 <20250827142152.206-4-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250827142152.206-4-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Specify which layer (core/cluster/socket) caches found at in the CPU
> topology. Updating cache topology to device tree (spec v0.4).
> Example:

Could we stick with the terms "cache topology" and "cache level", which
are already used in the context in QEMU, instead of "layer caches" here?

So it would smth like "Specify the cache topology for the cache levels".


> For example, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
> created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
> cores will have l1d and l1i.  However, extending this is not difficult.
> The clusters will share a unified l2 level cache, and finally sockets
> will share l3. In this patch, threads will share l1 caches by default,
> but this can be adjusted if case required.

As I mentioned before, let's trick to stick to no notation form for the
caches, preferable the levels always in upper case. Here you use l1i
and right below L1i and the same happens in other code comments.

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
> PEs. L1i and L1d are private to each thread, and l2 and l3 are shared at
> socket level as an example.
> 
> Limitation: SMT cores cannot share L1 cache for now. This
> problem does not exist in PPTT tables.
> 
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   hw/arm/virt.c         | 412 +++++++++++++++++++++++++++++++++++++++++-
>   include/hw/arm/virt.h |   7 +-
>   include/hw/core/cpu.h |  12 ++
>   3 files changed, 429 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f..9094d8bef8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -88,6 +88,7 @@
>   #include "hw/virtio/virtio-md-pci.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/char/pl011.h"
> +#include "hw/core/cpu.h"
>   #include "hw/cxl/cxl.h"
>   #include "hw/cxl/cxl_host.h"
>   #include "qemu/guest-random.h"
> @@ -273,6 +274,134 @@ static bool ns_el2_virt_timer_present(void)
>           arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
>   }
>   
> +unsigned int virt_get_caches(const VirtMachineState *vms,
> +                             CPUCoreCaches *caches)
> +{
> +    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
> +    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
> +    ARMISARegisters *isar = &armcpu->isar;
> +    unsigned int num_cache, i;
> +    int level_instr = 1, level_data = 1;
> +
> +    for (i = 0, num_cache = 0; i < CPU_MAX_CACHES; i++, num_cache++) {
> +        uint32_t clidr = GET_IDREG(isar, CLIDR);

Probably the compiler will do it for us, but you can hoist getting the CLIDR out
of the loop since it's an invariant, so for code readability.


> +        int type = (clidr >> (3 * i)) & 7;
> +        int bank_index;
> +        int level;
> +        enum CacheType cache_type;
> +
> +        if (type == 0) {
> +            break;
> +        }

It should be iterating over the 7 cache levels in CLIDR, not over the CPU_MAX_CACHES (16)
defined in QEMU, for two reasons: it might be the case that this break condition is never meet,
like when there is a description for all the 7 cache levels, i.e, no Ctype<n> == 0; and second
because it would avoid the necessity of vars like "level_instr" and "level_data" because we
know the cache level directly (since would be pretty much iterating over all the cache levels
available in the machine).


> +
> +        switch (type) {
> +        case 1:
> +            cache_type = INSTRUCTION_CACHE;
> +            level = level_instr;
> +            break;
> +        case 2:
> +            cache_type = DATA_CACHE;
> +            level = level_data;
> +            break;
> +        case 4:
> +            cache_type = UNIFIED_CACHE;
> +            level = level_instr > level_data ? level_instr : level_data;
> +            break;
> +        case 3: /* Split - Do data first */
> +            cache_type = DATA_CACHE;
> +            level = level_data;
> +            break;
> +        default:
> +            error_setg(&error_abort, "Unrecognized cache type");
> +            return 0;
> +        }
> +        /*
> +         * ccsidr is indexed using both the level and whether it is
> +         * an instruction cache. Unified caches use the same storage
> +         * as data caches.
> +         */
> +        bank_index = (i * 2) | ((type == 1) ? 1 : 0);
> +        if (ccidx) {
> +            caches[num_cache] = (CPUCoreCaches) {
> +                .type =  cache_type,
> +                .level = level,
> +                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                             CCSIDR_EL1,
> +                                             CCIDX_LINESIZE) + 4),
> +                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                            CCSIDR_EL1,
> +                                            CCIDX_ASSOCIATIVITY) + 1,
> +                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                   CCIDX_NUMSETS) + 1,
> +            };
> +        } else {
> +            caches[num_cache] = (CPUCoreCaches) {
> +                .type =  cache_type,
> +                .level = level,
> +                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                             CCSIDR_EL1, LINESIZE) + 4),
> +                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                            CCSIDR_EL1,
> +                                            ASSOCIATIVITY) + 1,
> +                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                   NUMSETS) + 1,
> +            };
> +        }
> +        caches[num_cache].size = caches[num_cache].associativity *
> +            caches[num_cache].sets * caches[num_cache].linesize;
> +
> +        /* Break one 'split' entry up into two records */
> +        if (type == 3) {
> +            num_cache++;
> +            bank_index = (i * 2) | 1;
> +            if (ccidx) {
> +                /* Instruction cache: bottom bit set when reading banked reg */
> +                caches[num_cache] = (CPUCoreCaches) {
> +                    .type = INSTRUCTION_CACHE,
> +                    .level = level_instr,
> +                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                 CCSIDR_EL1,
> +                                                 CCIDX_LINESIZE) + 4),
> +                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                CCSIDR_EL1,
> +                                                CCIDX_ASSOCIATIVITY) + 1,
> +                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                       CCIDX_NUMSETS) + 1,
> +                };
> +            } else {
> +                caches[num_cache] = (CPUCoreCaches) {
> +                    .type = INSTRUCTION_CACHE,
> +                    .level = level_instr,
> +                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                 CCSIDR_EL1, LINESIZE) + 4),
> +                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
> +                                                CCSIDR_EL1,
> +                                                ASSOCIATIVITY) + 1,
> +                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
> +                                       NUMSETS) + 1,
> +                };
> +            }
> +            caches[num_cache].size = caches[num_cache].associativity *
> +                caches[num_cache].sets * caches[num_cache].linesize;
> +        }

Could you please move the field extractions to a new function to make this
function less cluttered? I think having a function with the following
signature would make it (it's a suggestion, few free to adjust it):

void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type, int cache_level, bool is_i_cache)

where you can call again qemu_get_cpu(0) (ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0))) to
check for FEAT_CCIDX and acccess the ccidr bank.


> +        switch (type) {
> +        case 1:
> +            level_instr++;
> +            break;
> +        case 2:
> +            level_data++;
> +            break;
> +        case 3:
> +        case 4:
> +            level_instr++;
> +            level_data++;
> +            break;
> +        }
> +    }
> +
> +    return num_cache;
> +}
> +

In general this function is clunky and it's necessary to improve it.

Besides the iteration issue mentioned above and the factoring out of
the field extractions:

- Defines should be used in the cases, instead of magics constants, the could be:

#define CLIDR_CTYPE_NO_CACHE 0x00
#define CLIDR_CTYPE_I_CACHE 0x01
#define CLIDR_CTYPE_D_CACHE 0x02
#define CLIDR_CTYPE_SEPARATE_I_D_CACHES 0x03
#define CLIDR_CTYPE_UNIFIED_CACHE 0x04

also, it would be convenint to have:

#define CLIDR_CTYPE_MAX_CACHE_LEVEL 7 for the iteration over CLIDR cache type fields.


- Get rid of the level_instr and level_data variables, since the cache level is already available if we iterate over CLIDR.
   For example:

   int num_cache = 0;
   for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL; cache_level++) {
       uint8_t ctype = (clidr >> (3 * (cache_level - 1))) & 7;

       if (ctype == CLIDR_CTYPE_NO_CACHE) {
           /*
           * If a "No cache" cache type is found it means no menageable caches
           * exist at further-out levels of hierarchy, so ignore them.
           */
          break;
       } else if (ctype == CLIDR_CTYPE_SEPARATE_I_D_CACHES) {
          /*
          * Create separate D and I caches. D-cache is stored first.
          */
         enum CacheType cache_type;
         for (cache_type = DATA_CACHE;
              cache_type <= INSTRUCTION_CACHE;
              cache_type++) {
             set_cpu_cache(&caches[num_cache++], cache_type, cache_level,
                           cache_type == INSTRUCTION_CACHE ? true : false);
          }
      } else if (ctype == CLIDR_CTYPE_UNIFIED_CACHE) {
          set_cpu_cache(&caches[num_cache++], UNIFIED_CACHE, cache_level, false);
      } else if (ctype == CLIDR_CTYPE_D_CACHE) {
          set_cpu_cache(&caches[num_cache++], DATA_CACHE, cache_level, false);
      } else if (ctype == CLIDR_CTYPE_I_CACHE) {
          set_cpu_cache(&caches[num_cache++], INSTRUCTION_CACHE, cache_level, true);
      } else {
          error_setg(&error_abort, "Unrecognized cache type");
          return 0;
      }
   }

   return num_cache;


   This an example so you can see what I mean here precisely. Feel free to adjust it or keep it.


Cheers,
Gustavo

>   static void create_fdt(VirtMachineState *vms)
>   {
>       MachineState *ms = MACHINE(vms);
> @@ -423,13 +552,150 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
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
> +static int partial_cache_description(const MachineState *ms,
> +                                     CPUCoreCaches *caches, int num_caches)
> +{
> +    int level, c;
> +
> +    for (level = 1; level < num_caches; level++) {
> +        for (c = 0; c < num_caches; c++) {
> +            if (caches[c].level != level) {
> +                continue;
> +            }
> +
> +            switch (level) {
> +            case 1:
> +                /*
> +                 * L1 cache is assumed to have both L1I and L1D available.
> +                 * Technically both need to be checked.
> +                 */
> +                if (machine_get_cache_topo_level(ms,
> +                                                 CACHE_LEVEL_AND_TYPE_L1I) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            case 2:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            case 3:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    return 0;
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
> +    CPUCoreCaches caches[16];
> +    bool cache_created = false;
> +    bool cache_available;
> +    bool llevel;
> +
> +    num_cache = virt_get_caches(vms, caches);
> +
> +    if (mc->smp_props.has_caches &&
> +        partial_cache_description(ms, caches, num_cache)) {
> +        error_setg(&error_fatal, "Missing cache description");
> +        return;
> +    }
>   
>       /*
>        * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -458,9 +724,14 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
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
> @@ -490,6 +761,139 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                                     qemu_fdt_alloc_phandle(ms->fdt));
>           }
>   
> +        if (!vmc->no_cpu_topology && num_cache) {
> +            for (uint8_t i = 0; i < num_cache; i++) {
> +                /* only level 1 in the CPU entry */
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
> +            /* this assumes socket as the highest topological level */
> +            socket_offset = 0;
> +            cluster_offset = 0;
> +            cache_available = machine_defines_cache_at_topo_level(ms,
> +                                  CPU_TOPOLOGY_LEVEL_SOCKET);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
> +                        &bottom_node,
> +                        CPU_TOPOLOGY_LEVEL_SOCKET);
> +            if (cache_available && llevel) {
> +                if (bottom_node == 1 && !virt_is_acpi_enabled(vms))
> +                    error_setg(
> +                        &error_fatal,
> +                        "Cannot share L1 at socket_id %d."
> +                        "DT limiation on sharing at cache level = 1",
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
> +            cache_available = machine_defines_cache_at_topo_level(ms,
> +                                 CPU_TOPOLOGY_LEVEL_CLUSTER);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
> +                        &bottom_cluster,
> +                        CPU_TOPOLOGY_LEVEL_CLUSTER);
> +            if (cache_available && llevel) {
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
> +            cache_available = machine_defines_cache_at_topo_level(ms,
> +                                 CPU_TOPOLOGY_LEVEL_CORE);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
> +                        &bottom_core,
> +                        CPU_TOPOLOGY_LEVEL_CORE);
> +            if (cache_available && llevel) {
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
> @@ -2721,7 +3125,7 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
>   }
>   
>   
> -bool virt_is_acpi_enabled(VirtMachineState *vms)
> +bool virt_is_acpi_enabled(const VirtMachineState *vms)
>   {
>       if (vms->acpi == ON_OFF_AUTO_OFF) {
>           return false;
> @@ -3247,6 +3651,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
> index 365a28b082..0099ea7fa1 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -40,6 +40,7 @@
>   #include "system/kvm.h"
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "qom/object.h"
> +#include "hw/core/cpu.h"
>   
>   #define NUM_GICV2M_SPIS       64
>   #define NUM_VIRTIO_TRANSPORTS 32
> @@ -51,6 +52,8 @@
>   /* GPIO pins */
>   #define GPIO_PIN_POWER_BUTTON  3
>   
> +#define CPU_MAX_CACHES 16
> +
>   enum {
>       VIRT_FLASH,
>       VIRT_MEM,
> @@ -187,7 +190,9 @@ struct VirtMachineState {
>   OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
>   
>   void virt_acpi_setup(VirtMachineState *vms);
> -bool virt_is_acpi_enabled(VirtMachineState *vms);
> +bool virt_is_acpi_enabled(const VirtMachineState *vms);
> +unsigned int virt_get_caches(const VirtMachineState *vms,
> +                             CPUCoreCaches *caches);
>   
>   /* Return number of redistributors that fit in the specified region */
>   static uint32_t virt_redist_capacity(VirtMachineState *vms, int region)
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..045219a68b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1134,4 +1134,16 @@ enum CacheType {
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

