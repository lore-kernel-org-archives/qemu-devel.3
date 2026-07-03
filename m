Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAD4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTil-0002XB-1h; Thu, 02 Jul 2026 22:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wfTib-0002QM-Th
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:33:30 -0400
Received: from mail-westus2azon11012023.outbound.protection.outlook.com
 ([52.101.48.23] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wfTiY-0004Os-UL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+2jjkASJtdlvqOM8D/tttSImHAFNG4kQ4SIeKYqNvGMZFPouZoB4n+zeHO2b6jRktD8odXn6WSUDR/ejfp2G7ojbJbd6hsdRrcu9AjPChyR3dWK5op43SWTlCM0VH+nCiXJoGNXbXBGKGh4CG9DN6TNblqoOZDxQpS5iMwxB3GsChRlAfngxIKXEIE6SuOcrVlbaOrQOPhJ2qMTxQvm29uIKA4bGjINxWGKnvnPnk0vxA8xDqqsZRrfqYo2bZVRQMYcVDtufDIDeuOWUKmIUEGpPBzW27ulS5aUqOfaUMR7AePXuoi9bchhXzzu+p0j/lCBF6eHT2BLV99jAQA2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+KOG1KdMd85cZMRosKUrWdpbxy+VfwG/wOknfNj8ZM=;
 b=xdhi7Ct+fHn8TBc5XY8ObEAWuIv+T/HhZSzn2j5+XJMMFMZpyBozzZWrkTVUUw+nz6h18mS63JmXYUPRwJmVJPbVWem8oXRKZ31iFESvUD3XTIojIRItmMSbDitqUEMJ8P3fysZ+R6aY2IQmFub3IEiQE4gyO1RrB2UzNROPHfGfBoAggZmvDD9f0r0d+wk4Mxutz3MfopQq4Tjo0+zAgJHitkJUptvj03bks5QOFpC4YcxPplIsLRHk9A6uOXozGB8bW7ivV+UqRS4jeO605EomRM/z7NGAibrqcetpQAYvM0+10e2naPiyJnZBRNlyH+8gUl3IpjsBnvvffnY1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+KOG1KdMd85cZMRosKUrWdpbxy+VfwG/wOknfNj8ZM=;
 b=oz2SYExPnxpEZgwzONxuS5QJOlf9pImTKATO/T3OPLXG23h3Yv8+Fvn5F01Pp5o/XneCyQ1hKL46sa/FTV1hsm5BjH8bvay/AceB9Lqu/4lZAi2GabxUT6HTlT/ARAMkm46yuRr4G3YrMqqYEaZ5Z+BNxEWXhcByrEubcv0POBA=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 02:28:15 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::62) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 02:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 02:28:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 21:28:14 -0500
Received: from [10.65.97.70] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 21:28:12 -0500
Message-ID: <2117d301-4f7f-4f5a-a744-ec2422aacc7d@amd.com>
Date: Fri, 3 Jul 2026 10:28:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/10] hw/mem: add sp-mem device for Specific Purpose
 Memory
To: Igor Mammedov <imammedo@redhat.com>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
 <20260625163444.23b168ac@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260625163444.23b168ac@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e7d8c7-1d64-4640-bb0c-08ded8aabc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|4143699003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: x+GO7GMJEqte7PMAz9W6fGp/bgodtlEOOZFcyVtUict6atJ5kIWIT77am3dRu43xZemXBeOExwCm+o6tkBzk+B3kn/MphM7tGP6zRTMaRMQcs5v8a8sJNpxNAZzQE0dlWABqGnzczBhIui7Gp5cT9o2GbZCHV37/6YvCp3fsucLeLcv4CcgHUK+LteRtFB9AJBQCTAltYpLaA0mn4F+P/PlweYnf5H0aeQeu6K7pw+/QRWBPGWsgaE5VuxYul/oh9fGeUniS4oMzJvuLn3eX27+5nWpyHvbwixWK4g9tboD7TUXhhfVvoPvEhR04G0izVS7L+wakT7lvAGkr4P68luNOSCdRaXen002IXZJaZjggRq2gNEM2EE5Tj4XBeN2aJKG0N/sIyAsbKX0vg5A+2y2cUpiSyuxcdIfUe7sok0djS/4fU5usECG0hG757GhIONtL3C9sHsQFNA7v8VlHgsyhPNckDI7eGKiOz8DQ8le0IFQ/xmsxTJtJbhjrynHoIGis8HDpBtNY4vwqKNKabsMNIlBsqEyzASrXzSmqNllLWFkkf0oexrqincqyQmUwinE5oiXZKJuxg55YZtHnN/vVSYGCr4+hB1pfUVBywc3bDNosfyxYkorgkMn7g8ap14jZKbfjaWTvwJp1h6Tdd8ftzUbsRLHwCoFtT773R5QHPfTE7BSrG+CRKoghVR2TXXEWCOLDt9ZOQzslvBDTNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtDg1/5dh5hglb1LnPBlZlsLHWvqtywdUyowAnrpe8+/VLs5Qaie9FYvBy7b369m4twwBKZBGka7CiujK+dRX6USYeAoS329gfpKeR3xl4PKxbgh8bH9UzDnlwHViUbx4FjNlBINKyZEqccqU8sXTqUUQlJLitIZdfQXCVe3qGbc962i48lsRoBX54qHd0INKcAqvmN+6UvX9UUXU9WwTl+M7sxMmdhfviEa9r0qYYPbe2KJuz/zPRt8mkN/CPlyIBE6Nowooat1kpslRnG2WoAV7MWpwTTDykIQFPvI87eqZH7ZjE/MCYQlkyv0bSlcrHgFtXCkmbuSLlZA1hLareeakoUhf5qacePOqv4iRJdwGVHKYWNzDdeuO0LJ8/B22rkn68cjsj3OfaC69iOv3YnOBCBx5y/SQOqf67XM47F98W77HIH7pKOlJ+x4FwwM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 02:28:15.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e7d8c7-1d64-4640-bb0c-08ded8aabc84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
Received-SPF: permerror client-ip=52.101.48.23;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/25/2026 10:34 PM, Igor Mammedov wrote:
> On Tue, 23 Jun 2026 15:50:41 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> This series adds a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
>> SOFT_RESERVED guest memory, following the direction from the v7
>> thread [1] and the v8 / v9 / v10 / v11 / v12 / v13 reviews
>> [2][3][4][5][6][7].
> 
> review is done at this point,
> I guess Michael will take it via his tree.
>

Hi Michael,

All patches now carry Reviewed-by / Acked-by. Would it be possible to
queue this for the 11.1 soft freeze (7/7)?

Best regards,
FangSheng Huang (Jerry)

>>
>> Background
>> ----------
>>
>> This series targets coherent CPU + accelerator shared-address-space
>> systems, where the accelerator's HBM is not a device-private
>> framebuffer behind a PCIe BAR but a tier of host system memory:
>> visible to the CPU in the platform physical address space, shared
>> coherently with the accelerator over the platform fabric, and bound
>> to a NUMA proximity domain set by platform firmware at boot fabric
>> training.
>>
>> For such a region to function correctly in the guest, two things
>> must hold simultaneously: the CPU memory subsystem has to see it in
>> the system memory map (so the CPU side can address it), and it has
>> to be reserved exclusively for the accelerator's driver (so the
>> kernel's general allocator does not hand SPM pages to unrelated
>> workloads). The SOFT_RESERVED memory type in E820 plus a matching
>> SRAT memory-affinity entry is the mechanism that delivers both: a
>> firmware-produced topology that the CPU memory subsystem honors and
>> the accelerator's driver consumes for its own range.
>>
>> Approach
>> --------
>>
>> The series introduces a new TYPE_MEMORY_DEVICE subclass `sp-mem`.
>> Each instance binds one host memory backend to a single NUMA
>> proximity domain and is boot-time only; placement, mapped-state
>> enforcement, and QMP introspection come from the existing
>> memory-device framework.
>>
>> Testing
>> -------
>>
>> Verified end-to-end on q35 + KVM, with both SeaBIOS and OVMF, for:
>>
>> - single sp-mem instance
>> - two sp-mem instances on different NUMA nodes
>>
>> Guest observations: /proc/iomem shows one SOFT_RESERVED entry per
>> sp-mem device, dmesg SRAT parsing reports the matching
>> memory_affinity entries with correct PXM, and the umbrella
>> HOTPLUGGABLE entry covers the remaining hotplug-memory window
>> without overlapping the sp-mem ranges.
>>
>> In-tree coverage: a bios-tables-test case validates the SRAT
>> partition for two sp-mem devices on distinct nodes, and an e820
>> fw_cfg test checks the SOFT_RESERVED range.
>>
>> Changes since v13
>> -----------------
>>
>>    - qapi: note that SpMemDeviceInfo's @size is in bytes.
>>    - pc: fix the indentation of the pc_sp_mem_plug() continuation line.
>>    - Collected the Reviewed-by / Acked-by tags from the v13 review.
>>
>> Previous versions
>> -----------------
>>
>>    v1: https://lore.kernel.org/qemu-devel/20250924103324.2074819-1-FangSheng.Huang@amd.com/
>>    v2: https://lore.kernel.org/qemu-devel/20251020090701.4036748-1-FangSheng.Huang@amd.com/
>>    v3: https://lore.kernel.org/qemu-devel/20251208105137.2058928-1-FangSheng.Huang@amd.com/
>>    v4: https://lore.kernel.org/qemu-devel/20251209093841.2250527-1-FangSheng.Huang@amd.com/
>>    v5: https://lore.kernel.org/qemu-devel/20260123024312.1601732-1-FangSheng.Huang@amd.com/
>>    v6: https://lore.kernel.org/qemu-devel/20260226105023.256568-1-FangSheng.Huang@amd.com/
>>    v7: https://lore.kernel.org/qemu-devel/20260306082735.1106690-1-FangSheng.Huang@amd.com/
>>    v8: https://lore.kernel.org/qemu-devel/20260527074215.229119-1-FangSheng.Huang@amd.com/
>>    v9: https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/
>>    v10: https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/
>>    v11: https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/
>>    v12: https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/
>>    v13: https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/
>>
>>    [1] v7 thread closeout:
>>        https://lore.kernel.org/qemu-devel/666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com/
>>    [2] v8 review:
>>        https://lore.kernel.org/qemu-devel/20260601105057.2d764e55@imammedo/
>>    [3] v9 review:
>>        https://lore.kernel.org/qemu-devel/20260602084447.1100554-1-FangSheng.Huang@amd.com/T/
>>    [4] v10 review:
>>        https://lore.kernel.org/qemu-devel/20260605104609.1739911-1-FangSheng.Huang@amd.com/T/
>>    [5] v11 review:
>>        https://lore.kernel.org/qemu-devel/20260611100637.2460507-1-FangSheng.Huang@amd.com/T/
>>    [6] v12 review:
>>        https://lore.kernel.org/qemu-devel/20260616090808.3047939-1-FangSheng.Huang@amd.com/T/
>>    [7] v13 review:
>>        https://lore.kernel.org/qemu-devel/20260619111136.3481329-1-FangSheng.Huang@amd.com/T/
>>
>> fanhuang (10):
>>    hw/mem: add sp-mem device for Specific Purpose Memory
>>    qapi, hmp: introspection for the sp-mem device
>>    i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
>>    hw/i386: hook sp-mem into the pc machine plug path
>>    MAINTAINERS: cover sp-mem under Memory devices, add R: tag
>>    tests/acpi: add empty expected blobs for sp-mem SRAT test
>>    tests/acpi: add bios-tables-test case for sp-mem
>>    tests/acpi: generate expected blobs for sp-mem SRAT test
>>    tests/qtest: add e820 fw_cfg test
>>    tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
>>
>>   MAINTAINERS                        |   3 +
>>   qapi/machine.json                  |  43 +++++++++-
>>   hw/i386/e820_memory_layout.h       |  11 +--
>>   include/hw/mem/sp-mem.h            |  33 ++++++++
>>   hw/core/machine-hmp-cmds.c         |  11 +++
>>   hw/i386/acpi-build.c               |  96 ++++++++++++++++++++-
>>   hw/i386/pc.c                       |  36 ++++++++
>>   hw/mem/sp-mem.c                    | 128 ++++++++++++++++++++++++++++
>>   tests/qtest/bios-tables-test.c     |  21 +++++
>>   tests/qtest/e820-test.c            | 129 +++++++++++++++++++++++++++++
>>   hw/i386/Kconfig                    |   2 +
>>   hw/mem/Kconfig                     |   4 +
>>   hw/mem/meson.build                 |   1 +
>>   tests/data/acpi/x86/q35/DSDT.spmem | Bin 0 -> 9910 bytes
>>   tests/data/acpi/x86/q35/SRAT.spmem | Bin 0 -> 384 bytes
>>   tests/qtest/meson.build            |   1 +
>>   16 files changed, 508 insertions(+), 11 deletions(-)
>>   create mode 100644 include/hw/mem/sp-mem.h
>>   create mode 100644 hw/mem/sp-mem.c
>>   create mode 100644 tests/qtest/e820-test.c
>>   create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
>>   create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem
>>
>>
>> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> 


