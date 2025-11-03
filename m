Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtjf-0007s8-Nl; Mon, 03 Nov 2025 07:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vFtjc-0007px-Ix
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vFtjR-00079S-Oy
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762173130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hzZ51thFp4NuYFrc+twb0lM6YLo138VSs3guqiiGCDM=;
 b=GLUDt8YDtqR6h9VhylI2YJMKfGwhHfAE1bn6uDJlJS05lT1Ho0IdEPTU7PRbIM5wI4uHx9
 rmSwJJeGPDhFfaELTAJvcFjMWNChneBlrP1I/dk/VYgG8svhC1GtKBJHqadtB8f9PrhIUo
 EcHYccpHdOQHD8nWDm2BAw/Wm8nyeBE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-9vBbfehfMaWNBhGM8F-Wag-1; Mon, 03 Nov 2025 07:32:08 -0500
X-MC-Unique: 9vBbfehfMaWNBhGM8F-Wag-1
X-Mimecast-MFC-AGG-ID: 9vBbfehfMaWNBhGM8F-Wag_1762173127
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso1527321f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762173127; x=1762777927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hzZ51thFp4NuYFrc+twb0lM6YLo138VSs3guqiiGCDM=;
 b=hIlHaCCxYTeSDWfjaOaA9deDGBmcEuqnGrihAiQIv/hA2o32JcenpUDucACqPQf06/
 5mCoLpqr+VCl/58iWwmLzmi9fXNBsuU6Dlk64dUG24+DPdnTdEM12BSVBiPpaF+kQjoh
 QcTN8bm3EsEcrZA0VmGHW54fZd97t05OOtAfkBoxJpnrDd2gjbzguih3leHOL9hiN8u/
 wCBlKy8+zLsudrQpvxNLqjO5lslW3CSZZNwKJidD8T/vWqsYm4prrhxyuzPwnCilLx3u
 +kDHPX3KsxLDQNoKSe39eVOgwqQaaTsKxn0Cw7yJuL8ZpudDjJroWIrGuAT8/BbBVCCd
 wXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762173127; x=1762777927;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzZ51thFp4NuYFrc+twb0lM6YLo138VSs3guqiiGCDM=;
 b=Bm6yKud4IMQ5sFP3FzS/gNXsf6O8fWS+CbuAVljoyKqijW6VKZgNSAkFEzmfob2Io6
 0XAGF3uA2JdypuwcoaPh7tz04CQ0GORipw7SwTk0zeglZ5LbtKdGYcTijLt1vfI11oWf
 cz8bQoQPHPYn6Au9bOkB1ej+34T0pLg6rk7MhWoQtJYF7WAwcPsOAz2EUdAvrRBepNDj
 ZSVAdC3f3Ma0ZCoCwPzv+BZovp6SQPRDKgteM7G2y0pSkQdCbuByziopjJ2AkBnn+eVg
 3HKpXueDDdwark3kH8Gn1Bh2pqn93sgeHC8aTmbnjxh5aP3I89kuXdYIHNuffBP6Lh+A
 gRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRmxg65MYRuFmDsFKc6JRCRbdhrrBNVna5OS7R+jspeO7JXWMRaJaZFtWc4Tt9Q7da2j2P9rFpZnEE@nongnu.org
X-Gm-Message-State: AOJu0Yz1F+IvolFcumMjrI7xUP1diDwY1l7AtcsPlrftz7UpEt+P8EQR
 OxB4Cn7kmMivtd03tPc6McC9SFzfILl+Cvn58HAwWWT1hywRNY9jaPf8HeSg2kxh3npVORaQl5n
 TcidUakg6cppoNX+/AuDyPqEpFjZQlq2K5sOClp7ahVYkkyihmPDs25US/1ktix5C
X-Gm-Gg: ASbGncvj2WdCA578NkgzQC7UtufpfpQPtfqchHiaPQoAm/QZqKZBJy+G30IEOH4j0vU
 ziRQ1GgPIgghOBq12ADiGbulk+f3lqLgRC4vgxorW/oIK4RcSuGfEh3y5dTI9nAamRP2/sosMVW
 eMWO5My5lChc6obkyb98BffMbgI2YUY+jA4SzTxkN303CyHgxgH6CIM3NcgOloCWFLx3PBjwzJ0
 dksjGG3Bd/wxQ0u71p0WboJIdUnofbSVJGkeougQkbGnRDcjlwcGDMIUmdIEDr9cjbeThqQZLLn
 BnRiE7KZw/nE1tzpw86fomy6BxQ8E2HGFr/G1AADdMlrzG1iz/IlOz1u+813DycZ0WMp09qkUUN
 F+0jlZUlkMjmQcdAQ1nLPkzaSB0hANvZVKVpbc+WCwlriWjtqZ14c2+pXSW4kI2geJjYE/pF2wS
 VeLKkPcJw814Cgt+fNPb8pckieO7Y=
X-Received: by 2002:a05:6000:310a:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-429bd676070mr8355506f8f.6.1762173127297; 
 Mon, 03 Nov 2025 04:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIyIj1mtT6Feveub250mZHXgUHhsZhC619OQU/iCdDorehAPX+5ASGB7TWHGi+DjKFzYe2sg==
X-Received: by 2002:a05:6000:310a:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-429bd676070mr8355478f8f.6.1762173126726; 
 Mon, 03 Nov 2025 04:32:06 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169?
 (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de.
 [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce80ded1sm9607244f8f.4.2025.11.03.04.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 04:32:06 -0800 (PST)
Message-ID: <9362d717-0c04-4145-a2a4-49230ff5c19c@redhat.com>
Date: Mon, 3 Nov 2025 13:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <20251020090701.4036748-2-FangSheng.Huang@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251020090701.4036748-2-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 20.10.25 11:07, fanhuang wrote:
> This patch adds support for Specific Purpose Memory (SPM) through the
> NUMA node configuration. When 'spm=on' is specified for a NUMA node,
> QEMU will:
> 
> 1. Set the RAM_SPM flag in the RAM block of the corresponding memory region
> 2. Update the overlapping E820 RAM entries before adding E820_SOFT_RESERVED
> 3. Set the E820 type to E820_SOFT_RESERVED for this memory region
> 
> This allows guest operating systems to recognize the memory as soft reserved
> memory, which can be used for device-specific memory management without
> E820 table conflicts.
> 
> Usage:
>    -numa node,nodeid=0,memdev=m1,spm=on
> 
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
> ---
>   hw/core/numa.c               |  3 ++
>   hw/i386/e820_memory_layout.c | 73 ++++++++++++++++++++++++++++++++++++
>   hw/i386/e820_memory_layout.h |  2 +
>   hw/i386/pc.c                 | 37 ++++++++++++++++++
>   include/exec/cpu-common.h    |  1 +
>   include/system/memory.h      |  3 ++
>   include/system/numa.h        |  1 +
>   qapi/machine.json            |  6 +++
>   system/physmem.c             |  7 +++-
>   9 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 218576f745..e680130460 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -163,6 +163,9 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>           numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>       }
>   
> +    /* Store spm configuration for later processing */
> +    numa_info[nodenr].is_spm = node->has_spm && node->spm;
> +
>       numa_info[nodenr].present = true;
>       max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>       ms->numa_state->num_nodes++;
> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
> index 3e848fb69c..5b090ac6df 100644
> --- a/hw/i386/e820_memory_layout.c
> +++ b/hw/i386/e820_memory_layout.c
> @@ -46,3 +46,76 @@ bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
>       }
>       return false;
>   }
> +
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
> +{
> +    uint64_t end = start + length;
> +    bool updated = false;
> +    assert(!e820_done);
> +
> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
> +    if (new_type == E820_SOFT_RESERVED) {
> +        bool range_in_ram = false;
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
> +            updated = true;
> +            break;
> +        }
> +    }
> +
> +    return updated;
> +}
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> index b50acfa201..657cc679e2 100644
> --- a/hw/i386/e820_memory_layout.h
> +++ b/hw/i386/e820_memory_layout.h
> @@ -15,6 +15,7 @@
>   #define E820_ACPI       3
>   #define E820_NVS        4
>   #define E820_UNUSABLE   5
> +#define E820_SOFT_RESERVED  0xEFFFFFFF
>   
>   struct e820_entry {
>       uint64_t address;
> @@ -26,5 +27,6 @@ void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
>   bool e820_get_entry(int index, uint32_t type,
>                       uint64_t *address, uint64_t *length);
>   int e820_get_table(struct e820_entry **table);
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type);
>   
>   #endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bc048a6d13..3e50570484 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -26,6 +26,7 @@
>   #include "qemu/units.h"
>   #include "exec/target_page.h"
>   #include "hw/i386/pc.h"
> +#include "system/ramblock.h"
>   #include "hw/char/serial-isa.h"
>   #include "hw/char/parallel.h"
>   #include "hw/hyperv/hv-balloon.h"
> @@ -787,6 +788,41 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>       return pc_above_4g_end(pcms) - 1;
>   }
>   
> +static int pc_update_spm_memory(RAMBlock *rb, void *opaque)
> +{
> +    X86MachineState *x86ms = opaque;
> +    MachineState *ms = MACHINE(x86ms);
> +    ram_addr_t offset;
> +    ram_addr_t length;
> +    bool is_spm = false;
> +
> +    /* Check if this RAM block belongs to a NUMA node with spm=on */
> +    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
> +        NodeInfo *numa_info = &ms->numa_state->nodes[i];
> +        if (numa_info->is_spm && numa_info->node_memdev) {
> +            MemoryRegion *mr = &numa_info->node_memdev->mr;
> +            if (mr->ram_block == rb) {
> +                /* Mark this RAM block as SPM and set the flag */
> +                rb->flags |= RAM_SPM;
> +                is_spm = true;
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (is_spm) {
> +        offset = qemu_ram_get_offset(rb) +
> +                 (0x100000000ULL - x86ms->below_4g_mem_size);
> +        length = qemu_ram_get_used_length(rb);
> +        if (!e820_update_entry_type(offset, length, E820_SOFT_RESERVED)) {
> +            warn_report("Failed to update E820 entry for SPM at 0x%" PRIx64
> +                        " length 0x%" PRIx64, offset, length);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   /*
>    * AMD systems with an IOMMU have an additional hole close to the
>    * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
> @@ -901,6 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
>       if (pcms->sgx_epc.size != 0) {
>           e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, E820_RESERVED);
>       }
> +    qemu_ram_foreach_block(pc_update_spm_memory, x86ms);
>   
>       if (!pcmc->has_reserved_memory &&
>           (machine->ram_slots ||
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 9b658a3f48..9b437eaa10 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -89,6 +89,7 @@ ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>   bool qemu_ram_is_shared(RAMBlock *rb);
> +bool qemu_ram_is_spm(RAMBlock *rb);
>   bool qemu_ram_is_noreserve(RAMBlock *rb);
>   bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
>   void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> diff --git a/include/system/memory.h b/include/system/memory.h
> index aa85fc27a1..0d36cbd30d 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -275,6 +275,9 @@ typedef struct IOMMUTLBEvent {
>    */
>   #define RAM_PRIVATE (1 << 13)
>   
> +/* RAM is Specific Purpose Memory */
> +#define RAM_SPM (1 << 14)
> +
>   static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                          IOMMUNotifierFlag flags,
>                                          hwaddr start, hwaddr end,
> diff --git a/include/system/numa.h b/include/system/numa.h
> index 1044b0eb6e..438511a756 100644
> --- a/include/system/numa.h
> +++ b/include/system/numa.h
> @@ -41,6 +41,7 @@ typedef struct NodeInfo {
>       bool present;
>       bool has_cpu;
>       bool has_gi;
> +    bool is_spm;
>       uint8_t lb_info_provided;
>       uint16_t initiator;
>       uint8_t distance[MAX_NODES];
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c..1fa31b0224 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -500,6 +500,11 @@
>   # @memdev: memory backend object.  If specified for one node, it must
>   #     be specified for all nodes.
>   #
> +# @spm: if true, mark the memory region of this node as Specific
> +#     Purpose Memory (SPM). This will set the RAM_SPM flag for the
> +#     corresponding memory region and set the E820 type to
> +#     E820_SOFT_RESERVED. (default: false, since 9.2)
> +#
>   # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>   #     to the nodeid which has the memory controller responsible for
>   #     this NUMA node.  This field provides additional information as
> @@ -514,6 +519,7 @@
>      '*cpus':   ['uint16'],
>      '*mem':    'size',
>      '*memdev': 'str',
> +   '*spm':    'bool',
>      '*initiator': 'uint16' }}
>   
>   ##
> diff --git a/system/physmem.c b/system/physmem.c
> index ae8ecd50ea..0090d9955d 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1611,6 +1611,11 @@ bool qemu_ram_is_noreserve(RAMBlock *rb)
>       return rb->flags & RAM_NORESERVE;
>   }
>   
> +bool qemu_ram_is_spm(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_SPM;
> +}
> +

IIUC, this function is unused, and the only setter is in 
pc_update_spm_memory().

Why do we have to modify the RAMBlock at all or walk over them?

Shouldn't it be sufficient to just walk over all 
&ms->numa_state->nodes[i] and update e820 accordingly?

-- 
Cheers

David / dhildenb


