Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79637CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCZ6-00077r-PE; Tue, 04 Nov 2025 03:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vGCZ4-00075b-S4
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:38:54 -0500
Received: from mail-westcentralusazon11010014.outbound.protection.outlook.com
 ([40.93.198.14] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vGCYy-0005T2-S8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/sRZARWWAiSPf8ysVguH9n/eJws6/ZCvwezPDiRbpxh55RR9NBNe5w0l/vysaWFz7IhPmFCleOsxct14YymNXQNjK14Pu2VMQ5hyLXEHAajrAWTtaY0jqDhZEcG5rfWSXNpdGS3DNawBJjuETcYjWh1T2fYpjJGWCFniQ+kaGrOTKWFt9KXX+TQGHYN9u0tI8gpctx4G1g2YAUVVwMX/VwAY0ihMDgz4Rstu1UYc+tTXidGz+HlrDqpSvW9hdCfepbfRtmqVMWFvmS0foWoZ/lE2VvAgHDpkbVNpnfHxmopvImTxdvKjKJ5n5sKts3x2zLugQVRw0m2FUIfLgcDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fNrKvzhFqd16G37IJDpQggYPs44U662hy5HQzBVpKA=;
 b=i9NO9DyXIENURJJqvP2fJYo7tAiVmXOE/Pl1rW0sFq5s8XmxNGKeKOxI0DaF9ET1K7SRpTPMTirTZn0f7WDukaYUm6cnmfxqUHuuGU+V0XkBkFdoBHiZRFJYx4TJp8s6mwU2UFFi1v2LY4ouZ1do1lclyRl4WNzDXP7zdE7yXhLaGFSnkJV/6VQMxNe5R84CNAmJZDvelSR/NQI/mdteSkzL+KdymUf0O8NPncqBHcjCLbl7Px+jhAl6aB1q5XHiojBvt8WRVB2/Z5fgDAewAcdzATUlJB+Jbd4xrIA8uhpUgazCmKBQVLljb8RMjfR8ANppnYWIt5W7vaSVHWq1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fNrKvzhFqd16G37IJDpQggYPs44U662hy5HQzBVpKA=;
 b=3NyZojoYSAUeKtVgFXeFuS9AVLdIVyuxv+OUJRrqtLVVnoESw6GBzo+A5GFFpDEuetnVzPzJCWVQn1xGkDvwTvv/1ck9ho71nkoYOuVmeif+nrAZw9Y4xG0RrxFnElByb4Cfzd6k+IRpa3O2RzDiBdUOnfc/vuR9o1svHrSBWJI=
Received: from BYAPR06CA0037.namprd06.prod.outlook.com (2603:10b6:a03:14b::14)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:00:40 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::91) by BYAPR06CA0037.outlook.office365.com
 (2603:10b6:a03:14b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 08:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:00:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:00:39 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:00:39 -0800
Received: from [10.65.99.107] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 4 Nov 2025 00:00:37 -0800
Message-ID: <286f685c-0694-46d1-a8cb-13c77fc598a1@amd.com>
Date: Tue, 4 Nov 2025 16:00:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>,
 <imammedo@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <20251020090701.4036748-2-FangSheng.Huang@amd.com>
 <9362d717-0c04-4145-a2a4-49230ff5c19c@redhat.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <9362d717-0c04-4145-a2a4-49230ff5c19c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a47c262-defe-48a7-06e3-08de1b783f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzdPajQvbFBTeFp3VlpyMEhDR1p3U1ZkWUJmNnQyN3VWcWZHWW4zVWpoVGlT?=
 =?utf-8?B?ek01aTl1QTN0RWhTeVJLVnlIcmV0SlArWENxcmFFOWZ4M1QraURyWFFMRzRB?=
 =?utf-8?B?elUreDBlRzFJdUtZVHJ3MzZaTmlLa012VzdjamJmTGFqS2E3eC9RbEJISnR6?=
 =?utf-8?B?ODRYSC95WjFBYWJlT0srUnlXZTF2T2RwaG9UdVR1SEYxbUptRVJLWGFieU1y?=
 =?utf-8?B?Y01Bdmg3NXRkVFF1MFlCSGdYS3RDd0pMVzJWTUVkNVBYejJsOWJnNnEvM2hJ?=
 =?utf-8?B?MkNyM1d6dG0vTlJBMXd2ZWFsVXdRUnFsOURvbGkvMHovbVFLc1BCeWdGNS9V?=
 =?utf-8?B?OVdkYUVDb2JRcHc5YjhwTXBmWWhCb1hGbHVxSUJoM1l3cktxS2dmMEErQWVq?=
 =?utf-8?B?WGJrY3B4NCtkN1FaUDdSeHA0VnhFN0dKbjFMczhraFJsUzdEcXV4cGFyck1r?=
 =?utf-8?B?ZWp3Z3VQbk8zQ1MzY0Jhak55UjAwVXM0aUlhUnZaczE3OUdhenBaOHFpdjlW?=
 =?utf-8?B?NkxRVnFsUzdIcDFJUTJPS2Qxa2h0UTM2TDFEd283QWMzS29US0VFdURDeHdX?=
 =?utf-8?B?SjBXc0FmSFp6VFRqalA0N3pCbTBiRTdKNERyTmJaTHZaSm00eXRuTk9QTkly?=
 =?utf-8?B?eFA2eGo5QkhueXhVek1xbXh5Tm9zVklZODVublpzaUxLVEtsd2p3OEVjdDBW?=
 =?utf-8?B?UzdwbGpWKzZtdTNST3c2b1JhM1Nua1Y3RGNVWXZwSDk3c3VKZWlFSlhUVnF4?=
 =?utf-8?B?REZkVlZWNExJdnBENCtMRVRCTC9LK0g5K0R0eHZqY0VVR0V3YnBIMzk3TFNV?=
 =?utf-8?B?bmFvSDZxZkVjSTF6QjlMSWFpWXhTMjJNVmFnUGlEWit3Smt0NUJ6eE1JQ25v?=
 =?utf-8?B?UjZKemNNV1JydGFiTUVxOUJNR0VEbVNxNmJKWUpZK2pBb05ON3RzSlAweTNE?=
 =?utf-8?B?d1NpQnJtaDBMUFBoR1drdjB1bU1uWlA5UkhNUENmajQ2YnBQNmt6SzRkeURz?=
 =?utf-8?B?UWZUSGFCTlMyZ3F6TDhTS3FxWHRDNkkwbWVrT2F2eWl1R0hiOWJ0NlI4UldE?=
 =?utf-8?B?V1FyVHcwbzRJU0lwR1VheWZOcnNmTzZ0V1VYeXdEcTFpNjVQMU9GOTIxM09R?=
 =?utf-8?B?bHIzOTlhU2piRHduZkZxYzZNSnMxRlBQd2RRdlpEckp0eUZQa3NVeWdwUXhk?=
 =?utf-8?B?blY2Qmw5dW40WWxXV2ticTBhK05LQ2I3V09ESStaeVo2OVpzS1ZwNytOMVhV?=
 =?utf-8?B?a3NsWFlVRldzNWpBYUhWaTRPNWdrT1J0SU1Zejd6NEs5dVA0aS9iVDMyb2lh?=
 =?utf-8?B?ZWxGNFl3em8yY0poRmtxdk5tS1d5c29paFJSWmZtUGJ3ZEljcUUwWCtNcUFh?=
 =?utf-8?B?YkhHMk9PTWFpSDVYWXE1Mm9HS2FLU0xBaytEOWlyd1RLZHpTZE4rb3IrSTRz?=
 =?utf-8?B?cDVDVS9XdlNmZXk0aWhUSGM5WXYrRkhyMnJQYnN2aXNEMkZmd05ZR1pFdGJZ?=
 =?utf-8?B?TWhoVlRKN0YxWWZ1a3ZSRzVFTDRrbVRzSzZnRUtOUnhCS0l4T0hQclZOajJi?=
 =?utf-8?B?UTd2cmp3ZHRFQkpzODFGSmk4dXF6RDhNQkwyUVFrUnJ5TE5zMkJlZDBMNXJS?=
 =?utf-8?B?dXZ3R001cHdsM3VrdWtiTXpWekpWcjdueTdJajJwakYxTTFYWk01U2E2NDMz?=
 =?utf-8?B?S0ZRVkt6SnY5Wk1tNlJNYUIwalZXaWpRVEgzVnZPNGkvbDZobWZvbVpoWWw3?=
 =?utf-8?B?VjUwTWRMaUQvbDdVUFBickRGOU00dmYyTDMrbVlyT29PTkRKQ1pWeGhpYmln?=
 =?utf-8?B?V081dFE1RWErQXE1bVRpQVBYNE1RN1hLOHNGWk5wVW1JcUtGVFB3Z0FwSTZM?=
 =?utf-8?B?NmlHelpvOE9hOVI2cXpwdmpsK1BQalVXcFRHSWg3NkxwUE00OFprOFIvem1x?=
 =?utf-8?B?Y3hrOEpESVQ3Y1B2RjRNVDFqUnRFa3lpbW1zVi9CNFVYQ0hPNko5MFVpbGtt?=
 =?utf-8?B?UGgyTUR1a01IRXA4RlhTd1pEZ3pOMThyc21oNnNydnN0YitQKy9KM3JGZUgy?=
 =?utf-8?B?ZDVjRUZ1WjN2UUgzVHN4emxVNFJSZk5oRTFNays0S2FtSExVeWZSNGhzcW4v?=
 =?utf-8?Q?iT5A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:00:40.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a47c262-defe-48a7-06e3-08de1b783f17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
Received-SPF: permerror client-ip=40.93.198.14;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/3/2025 8:32 PM, David Hildenbrand wrote:
> On 20.10.25 11:07, fanhuang wrote:
>> This patch adds support for Specific Purpose Memory (SPM) through the
>> NUMA node configuration. When 'spm=on' is specified for a NUMA node,
>> QEMU will:
>>
>> 1. Set the RAM_SPM flag in the RAM block of the corresponding memory 
>> region
>> 2. Update the overlapping E820 RAM entries before adding 
>> E820_SOFT_RESERVED
>> 3. Set the E820 type to E820_SOFT_RESERVED for this memory region
>>
>> This allows guest operating systems to recognize the memory as soft 
>> reserved
>> memory, which can be used for device-specific memory management without
>> E820 table conflicts.
>>
>> Usage:
>>    -numa node,nodeid=0,memdev=m1,spm=on
>>
>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
>> ---
>>   hw/core/numa.c               |  3 ++
>>   hw/i386/e820_memory_layout.c | 73 ++++++++++++++++++++++++++++++++++++
>>   hw/i386/e820_memory_layout.h |  2 +
>>   hw/i386/pc.c                 | 37 ++++++++++++++++++
>>   include/exec/cpu-common.h    |  1 +
>>   include/system/memory.h      |  3 ++
>>   include/system/numa.h        |  1 +
>>   qapi/machine.json            |  6 +++
>>   system/physmem.c             |  7 +++-
>>   9 files changed, 132 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 218576f745..e680130460 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -163,6 +163,9 @@ static void parse_numa_node(MachineState *ms, 
>> NumaNodeOptions *node,
>>           numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
>>       }
>> +    /* Store spm configuration for later processing */
>> +    numa_info[nodenr].is_spm = node->has_spm && node->spm;
>> +
>>       numa_info[nodenr].present = true;
>>       max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>>       ms->numa_state->num_nodes++;
>> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
>> index 3e848fb69c..5b090ac6df 100644
>> --- a/hw/i386/e820_memory_layout.c
>> +++ b/hw/i386/e820_memory_layout.c
>> @@ -46,3 +46,76 @@ bool e820_get_entry(int idx, uint32_t type, 
>> uint64_t *address, uint64_t *length)
>>       }
>>       return false;
>>   }
>> +
>> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t 
>> new_type)
>> +{
>> +    uint64_t end = start + length;
>> +    bool updated = false;
>> +    assert(!e820_done);
>> +
>> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
>> +    if (new_type == E820_SOFT_RESERVED) {
>> +        bool range_in_ram = false;
>> +        for (size_t j = 0; j < e820_entries; j++) {
>> +            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
>> +            uint64_t ram_end = ram_start + 
>> le64_to_cpu(e820_table[j].length);
>> +            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
>> +
>> +            if (ram_type == E820_RAM && ram_start <= start && ram_end 
>> >= end) {
>> +                range_in_ram = true;
>> +                break;
>> +            }
>> +        }
>> +        if (!range_in_ram) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    /* Find entry that contains the target range and update it */
>> +    for (size_t i = 0; i < e820_entries; i++) {
>> +        uint64_t entry_start = le64_to_cpu(e820_table[i].address);
>> +        uint64_t entry_length = le64_to_cpu(e820_table[i].length);
>> +        uint64_t entry_end = entry_start + entry_length;
>> +
>> +        if (entry_start <= start && entry_end >= end) {
>> +            uint32_t original_type = e820_table[i].type;
>> +
>> +            /* Remove original entry */
>> +            memmove(&e820_table[i], &e820_table[i + 1],
>> +                    (e820_entries - i - 1) * sizeof(struct e820_entry));
>> +            e820_entries--;
>> +
>> +            /* Add split parts inline */
>> +            if (entry_start < start) {
>> +                e820_table = g_renew(struct e820_entry, e820_table,
>> +                                     e820_entries + 1);
>> +                e820_table[e820_entries].address = 
>> cpu_to_le64(entry_start);
>> +                e820_table[e820_entries].length =
>> +                    cpu_to_le64(start - entry_start);
>> +                e820_table[e820_entries].type = original_type;
>> +                e820_entries++;
>> +            }
>> +
>> +            e820_table = g_renew(struct e820_entry, e820_table,
>> +                                 e820_entries + 1);
>> +            e820_table[e820_entries].address = cpu_to_le64(start);
>> +            e820_table[e820_entries].length = cpu_to_le64(length);
>> +            e820_table[e820_entries].type = cpu_to_le32(new_type);
>> +            e820_entries++;
>> +
>> +            if (end < entry_end) {
>> +                e820_table = g_renew(struct e820_entry, e820_table,
>> +                                     e820_entries + 1);
>> +                e820_table[e820_entries].address = cpu_to_le64(end);
>> +                e820_table[e820_entries].length = 
>> cpu_to_le64(entry_end - end);
>> +                e820_table[e820_entries].type = original_type;
>> +                e820_entries++;
>> +            }
>> +
>> +            updated = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    return updated;
>> +}
>> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
>> index b50acfa201..657cc679e2 100644
>> --- a/hw/i386/e820_memory_layout.h
>> +++ b/hw/i386/e820_memory_layout.h
>> @@ -15,6 +15,7 @@
>>   #define E820_ACPI       3
>>   #define E820_NVS        4
>>   #define E820_UNUSABLE   5
>> +#define E820_SOFT_RESERVED  0xEFFFFFFF
>>   struct e820_entry {
>>       uint64_t address;
>> @@ -26,5 +27,6 @@ void e820_add_entry(uint64_t address, uint64_t 
>> length, uint32_t type);
>>   bool e820_get_entry(int index, uint32_t type,
>>                       uint64_t *address, uint64_t *length);
>>   int e820_get_table(struct e820_entry **table);
>> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t 
>> new_type);
>>   #endif
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bc048a6d13..3e50570484 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -26,6 +26,7 @@
>>   #include "qemu/units.h"
>>   #include "exec/target_page.h"
>>   #include "hw/i386/pc.h"
>> +#include "system/ramblock.h"
>>   #include "hw/char/serial-isa.h"
>>   #include "hw/char/parallel.h"
>>   #include "hw/hyperv/hv-balloon.h"
>> @@ -787,6 +788,41 @@ static hwaddr pc_max_used_gpa(PCMachineState 
>> *pcms, uint64_t pci_hole64_size)
>>       return pc_above_4g_end(pcms) - 1;
>>   }
>> +static int pc_update_spm_memory(RAMBlock *rb, void *opaque)
>> +{
>> +    X86MachineState *x86ms = opaque;
>> +    MachineState *ms = MACHINE(x86ms);
>> +    ram_addr_t offset;
>> +    ram_addr_t length;
>> +    bool is_spm = false;
>> +
>> +    /* Check if this RAM block belongs to a NUMA node with spm=on */
>> +    for (int i = 0; i < ms->numa_state->num_nodes; i++) {
>> +        NodeInfo *numa_info = &ms->numa_state->nodes[i];
>> +        if (numa_info->is_spm && numa_info->node_memdev) {
>> +            MemoryRegion *mr = &numa_info->node_memdev->mr;
>> +            if (mr->ram_block == rb) {
>> +                /* Mark this RAM block as SPM and set the flag */
>> +                rb->flags |= RAM_SPM;
>> +                is_spm = true;
>> +                break;
>> +            }
>> +        }
>> +    }
>> +
>> +    if (is_spm) {
>> +        offset = qemu_ram_get_offset(rb) +
>> +                 (0x100000000ULL - x86ms->below_4g_mem_size);
>> +        length = qemu_ram_get_used_length(rb);
>> +        if (!e820_update_entry_type(offset, length, 
>> E820_SOFT_RESERVED)) {
>> +            warn_report("Failed to update E820 entry for SPM at 0x%" 
>> PRIx64
>> +                        " length 0x%" PRIx64, offset, length);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * AMD systems with an IOMMU have an additional hole close to the
>>    * 1Tb, which are special GPAs that cannot be DMA mapped. Depending
>> @@ -901,6 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
>>       if (pcms->sgx_epc.size != 0) {
>>           e820_add_entry(pcms->sgx_epc.base, pcms->sgx_epc.size, 
>> E820_RESERVED);
>>       }
>> +    qemu_ram_foreach_block(pc_update_spm_memory, x86ms);
>>       if (!pcmc->has_reserved_memory &&
>>           (machine->ram_slots ||
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 9b658a3f48..9b437eaa10 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -89,6 +89,7 @@ ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
>>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>>   ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>>   bool qemu_ram_is_shared(RAMBlock *rb);
>> +bool qemu_ram_is_spm(RAMBlock *rb);
>>   bool qemu_ram_is_noreserve(RAMBlock *rb);
>>   bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
>>   void qemu_ram_set_uf_zeroable(RAMBlock *rb);
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index aa85fc27a1..0d36cbd30d 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -275,6 +275,9 @@ typedef struct IOMMUTLBEvent {
>>    */
>>   #define RAM_PRIVATE (1 << 13)
>> +/* RAM is Specific Purpose Memory */
>> +#define RAM_SPM (1 << 14)
>> +
>>   static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify 
>> fn,
>>                                          IOMMUNotifierFlag flags,
>>                                          hwaddr start, hwaddr end,
>> diff --git a/include/system/numa.h b/include/system/numa.h
>> index 1044b0eb6e..438511a756 100644
>> --- a/include/system/numa.h
>> +++ b/include/system/numa.h
>> @@ -41,6 +41,7 @@ typedef struct NodeInfo {
>>       bool present;
>>       bool has_cpu;
>>       bool has_gi;
>> +    bool is_spm;
>>       uint8_t lb_info_provided;
>>       uint16_t initiator;
>>       uint8_t distance[MAX_NODES];
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 038eab281c..1fa31b0224 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -500,6 +500,11 @@
>>   # @memdev: memory backend object.  If specified for one node, it must
>>   #     be specified for all nodes.
>>   #
>> +# @spm: if true, mark the memory region of this node as Specific
>> +#     Purpose Memory (SPM). This will set the RAM_SPM flag for the
>> +#     corresponding memory region and set the E820 type to
>> +#     E820_SOFT_RESERVED. (default: false, since 9.2)
>> +#
>>   # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>>   #     to the nodeid which has the memory controller responsible for
>>   #     this NUMA node.  This field provides additional information as
>> @@ -514,6 +519,7 @@
>>      '*cpus':   ['uint16'],
>>      '*mem':    'size',
>>      '*memdev': 'str',
>> +   '*spm':    'bool',
>>      '*initiator': 'uint16' }}
>>   ##
>> diff --git a/system/physmem.c b/system/physmem.c
>> index ae8ecd50ea..0090d9955d 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1611,6 +1611,11 @@ bool qemu_ram_is_noreserve(RAMBlock *rb)
>>       return rb->flags & RAM_NORESERVE;
>>   }
>> +bool qemu_ram_is_spm(RAMBlock *rb)
>> +{
>> +    return rb->flags & RAM_SPM;
>> +}
>> +
> 
> IIUC, this function is unused, and the only setter is in 
> pc_update_spm_memory().
> 
> Why do we have to modify the RAMBlock at all or walk over them?
> 
> Shouldn't it be sufficient to just walk over all &ms->numa_state- 
>  >nodes[i] and update e820 accordingly?
> 
Hi David,

Thank you for the excellent review and the insightful suggestion!

You're absolutely right - I've simplified the implementation to
directly iterate over NUMA nodes instead of RAMBlocks.

I'll send v3 after internal review. I also understand Igor's
feedback would be valuable - I'll wait to hear if he has any
concerns.

Best regards,
Jerry Huang

