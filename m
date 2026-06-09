Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A589DCD8C85
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWnbl-0000TW-Cm; Mon, 08 Jun 2026 23:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wWnbj-0000Si-JU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:58:31 -0400
Received: from mail-westcentralusazon11010029.outbound.protection.outlook.com
 ([40.93.198.29] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wWnbf-0006h3-E7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC/uqMw/m11OKQRg9w/kY1CJ1lkuCCZSk/GASQEBiVrGrZc9/ne/j+5FboiGdEeS7ohBx9780TFTuO4HTD43gXvSGhmSrAVDXUy2dcDqZe6zY0+WP52LsNHMYVNv1cDb805Yjs3x6k46+tMBittQYPth+qdBhZWhDkAGu6B8qsVaBPIgI7P98VEW0FjL8WjyWg9L+AgxFxK4999NZlN6VXBwd765INUdFNQWwkkjybH1n+R/8awQmWcqc6Edz+t/8KV35zJ+2F7Fzt9dJ2MKWMIyoDYiVEG5dBj7e5qDu1VnWxd90jH8elH9cA6S8iLMKciMcaB2zUDdesTbZqM7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHJqD0OtOVfg4qiB78m2sFttEZmea0zrDrXetWx2beo=;
 b=xTv0SbXf+Lv35EzV6Bn5dwLz71t481HWrcDbd9bgZ6jXT4v5V5rzZ8B17PonnkdYb1sCjeSEWOpdnas92biW8+g5Pa6EDOSUppp1/CO54u1y9ZDEZ1Lj5Rz8uYd/3aQRBOTS/+8WR/1+jYPr/wMKIc4qmMucaldU0xGFzyvaFCgDLk1xzEXJRKKAfp4MYM2no1/sEnGX2SjPJhzRfTksiw3QCWHpB75FYrdzdbD2XfwRO3OfJlPLKm6KqYuhN3EngwaK1YPSnbhBV8Z8GZbAeS+Dt6ApC3X/Ufe78okF3lKJnYp80su3vRXw9LHVyv63n3oPfaO9R5mCvKn2YfoWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHJqD0OtOVfg4qiB78m2sFttEZmea0zrDrXetWx2beo=;
 b=QuGfk99DKOJDgT/Lk4+2o+ytjkfPUanMb6CAFbaeLhvh/7nKhiP9Uh3uCtHUVYOZ3TDdWwXUcfN2Rw5lga2+j4JR2r1nvms6qk+WgdfJYoA09rOewlCtLDBW6jLo9YmpriE8N7/B9wh5/CGC/H8uajGnjR2tzS3sDbG+rSZVFG4=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 03:53:11 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::45) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Tue, 9
 Jun 2026 03:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 03:53:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 22:53:09 -0500
Received: from [172.31.100.11] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 22:53:06 -0500
Message-ID: <c10c48b9-59cb-45a8-b399-ecc8362653b8@amd.com>
Date: Tue, 9 Jun 2026 11:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] i386/acpi-build: partition device_memory SRAT
 umbrella for sp-mem
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-3-FangSheng.Huang@amd.com>
 <aiM_NHx0a6x95KtP@gourry-fedora-PF4VCD3F>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <aiM_NHx0a6x95KtP@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5665d0b4-fa12-426c-9ae0-08dec5da9fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oxqX17ZGcDdf2X064w11hWhLBVEn4gOaAcHhOo6CbN7/MoJYAUhcfEF0jbaw1HAQmfTg2BsIuuK5qVVnoA/YkB9dAGxU5Y4QB6pQQZVVvhqZaqbPN7P516ANR/dhY/L3ZeqCaw57p7aQiZq+XJRFqUpCmVtDe+iyD82KSe4Dm/CSaS4RqGuEBHB1m5foSw+CxliAmXgRss2UWPrQ8CkqfYsAi5rRmQbcEmcsixrqtBrhZjjeGvaGC87tUSzJbpUv7fQfdlu/9AWX2NftkV6tSYp5foyI23u0mLRcuK2xWvpwWMREpLGVhqTkIC/bIQzfp0P/g+OfAuasoqNYwQuBtDnGKZuasNefWSxTESIhrQWXNrOUi7ObFP+DMDQoOVnd6HLeogvxerzXOaKR9kcG+ZN4LayYxVb97f9BKQwbKZK3vLsUUvmOakkQ8heGhlB+LSKFcKANusLQ+ax5iFRn9gtYM5l7c2MsL4F8JBOjyrVyZjA7WAw8aIIpca5+Yg85G91SzQZpTcZ1bB57O3EJymIpJT+ywvQACmvciojZh+Yj9YRp02cqMez4nNiBQj9WkRa7p1tK67dRuYRBn8BmSqV8K9/k+ZQ/JQgbT2+ZmwxLWRlD8T6BNG6R82yAD/MdGoJLTYXdeJvgnE+ImTULJ9XfL3xm8JHjUKvuRZY/k9Gc2RGxb6n6Odwund8o0+hL3mk00TTW1yEhFB2MpIG9c3KRuZI3QeDwYyEjfholamk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KZwpBilgHbGbZlGZopYI46vXZ0v9opHmSufeR0P9xlvuKUC1I6WdIJpB+A9JsFiphfz2Jhrk2/6DBBiaAqtqJTCPrak6Lt/40b6ylZfMFPvFn184MmPBTLbLfZYsSj+87oqEKYhjuq2ojBJLkEV+32h6foufFghS5v3OrELMS4Ip5+kPL5GM7RB+NX6yGEi/Cb4SPWQIM01apEnZHgoPKcNfpW4hdt839uEh3pYUDPp7NAxd5f/mIJ9clgqaEHD6l2QkJkhnBXL/9Xo9eBMQSVHeRmbtm/eVGgaPa7ojL+EpG5iG9uktMkrD+JJC75iCPMb0a8+439qWKAQMJmaRnzdF1gTMHZBP852Gue8bwBO2lWUPnzc0LYvTCwZ8pMEprNDlsbUsvca45xND3Z6svX3sdO6Bl3wsyfUU4YIiDulfKN+p+A0DLAojpCN+7upg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:53:10.7500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5665d0b4-fa12-426c-9ae0-08dec5da9fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
Received-SPF: permerror client-ip=40.93.198.29;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 6/6/2026 5:27 AM, Gregory Price wrote:
> On Fri, Jun 05, 2026 at 06:46:07PM +0800, fanhuang wrote:
>> Restructure the device_memory SRAT umbrella entry into a per-kind
>> partition: each TYPE_SP_MEM device gets an ENABLED entry at its own
>> proximity_domain; the remaining sub-ranges get HOTPLUGGABLE | ENABLED
>> placeholders at the highest PXM, preserving the existing umbrella
>> convention.
>>
>> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
>> ---
>>   hw/i386/acpi-build.c | 98 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 92 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 0d7c83d5e9..76efa83808 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -52,6 +52,7 @@
>>   #include "migration/vmstate.h"
>>   #include "hw/mem/memory-device.h"
>>   #include "hw/mem/nvdimm.h"
>> +#include "hw/mem/sp-mem.h"
>>   #include "system/numa.h"
>>   #include "system/reset.h"
>>   #include "hw/hyperv/vmbus-bridge.h"
>> @@ -1346,6 +1347,96 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>>   }
>>   #endif
>>   
>> +typedef struct {
>> +    uint64_t addr;
>> +    uint64_t size;
>> +    uint32_t node;
>> +} SpMemRange;
>> +
>> +static int collect_sp_mem_ranges_cb(Object *obj, void *opaque)
>> +{
>> +    GArray *ranges = opaque;
>> +    SpMemDevice *spm;
>> +    MemoryDeviceClass *mdc;
>> +    SpMemRange r;
>> +
>> +    if (!object_dynamic_cast(obj, TYPE_SP_MEM)) {
>> +        return 0;
>> +    }
>> +    spm = SP_MEM(obj);
>> +    mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(spm));
>> +    r.addr = mdc->get_addr(MEMORY_DEVICE(spm));
>> +    r.size = memory_region_size(
>> +                 host_memory_backend_get_memory(spm->hostmem));
>> +    r.node = spm->node;
>> +    g_array_append_val(ranges, r);
>> +    return 0;
>> +}
>> +
>> +static gint sp_mem_range_compare(gconstpointer a, gconstpointer b)
>> +{
>> +    const SpMemRange *range_a = a;
>> +    const SpMemRange *range_b = b;
>> +
>> +    if (range_a->addr < range_b->addr) {
>> +        return -1;
>> +    }
>> +    if (range_a->addr > range_b->addr) {
>> +        return 1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Emit SRAT memory-affinity entries covering the device_memory region.
>> + *
>> + * For each plugged TYPE_SP_MEM device, emit an ENABLED entry at the
>> + * device's own proximity_domain.  All remaining sub-ranges (gaps
>> + * between sp-mem devices, leading and trailing padding, and ranges
>> + * occupied by other memory devices) are covered by HOTPLUGGABLE |
>> + * ENABLED placeholder entries at PXM = nb_numa_nodes - 1.
>> + */
>> +static void build_srat_device_memory(GArray *table_data, MachineState *ms)
>> +{
>> +    g_autoptr(GArray) ranges = g_array_new(FALSE, TRUE, sizeof(SpMemRange));
>> +    uint64_t cursor, end;
>> +    int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
>> +    uint32_t hotplug_pxm = nb_nodes > 0 ? nb_nodes - 1 : 0;
>> +    guint i;
>> +
>> +    if (!ms->device_memory) {
>> +        return;
>> +    }
>> +
>> +    cursor = ms->device_memory->base;
>> +    end = cursor + memory_region_size(&ms->device_memory->mr);
>> +
>> +    object_child_foreach_recursive(qdev_get_machine(),
>> +                                   collect_sp_mem_ranges_cb, ranges);
>> +    g_array_sort(ranges, sp_mem_range_compare);
>> +
>> +    for (i = 0; i < ranges->len; i++) {
>> +        SpMemRange *r = &g_array_index(ranges, SpMemRange, i);
>> +
>> +        if (cursor < r->addr) {
>> +            build_srat_memory(table_data, cursor, r->addr - cursor,
>> +                              hotplug_pxm,
>> +                              MEM_AFFINITY_HOTPLUGGABLE |
>> +                              MEM_AFFINITY_ENABLED);
>> +        }
>> +        build_srat_memory(table_data, r->addr, r->size, r->node,
>> +                          MEM_AFFINITY_ENABLED);
>> +        cursor = r->addr + r->size;
>> +    }
>> +
> 
> Should we expect (cursor == end) here and fire a warning if there wasn't
> a full range to cover the region?  If not - why set it all as
> hotpluggable anyway?
> 
> (Maybe just worth a comment here what the last block is actually doing)
>

Thanks, Gregory.

(cursor == end) is not an invariant — ms->device_memory is sized
for the maxmem cap, so sp-mem typically leaves the rest of the
window unused. The trailing HOTPLUGGABLE | ENABLED entry covers
that remainder so future pc-dimm / virtio-mem hot-add into the same
window still sees a properly-flagged SRAT range, preserving the
prior umbrella behaviour.

Agreed on the inline comment; will include if/when we respin.

>> +    if (cursor < end) {
>> +        build_srat_memory(table_data, cursor, end - cursor,
>> +                          hotplug_pxm,
>> +                          MEM_AFFINITY_HOTPLUGGABLE |
>> +                          MEM_AFFINITY_ENABLED);
>> +    }
>> +}
>> +
>>   #define HOLE_640K_START  (640 * KiB)
>>   #define HOLE_640K_END   (1 * MiB)
>>   
>> @@ -1481,12 +1572,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>        * Memory devices may override proximity set by this entry,
>>        * providing _PXM method if necessary.
>>        */
>> -    if (machine->device_memory) {
>> -        build_srat_memory(table_data, machine->device_memory->base,
>> -                          memory_region_size(&machine->device_memory->mr),
>> -                          nb_numa_nodes - 1,
>> -                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>> -    }
>> +    build_srat_device_memory(table_data, machine);
>>   
>>       acpi_table_end(linker, &table);
>>   }
>> -- 
>> 2.34.1
>>


