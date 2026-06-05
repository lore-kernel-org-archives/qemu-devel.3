Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7514DCD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVS3S-0001kz-5y; Fri, 05 Jun 2026 06:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS3K-0001k8-4R
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:45:31 -0400
Received: from mail-northcentralusazon11012045.outbound.protection.outlook.com
 ([40.107.200.45] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wVS3C-00041D-SQ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/HCKgXB6zJ+ZFeoz8jc/OUm+YizHlRiOb124P0nW/4ZkZ1Uc2GrnBh6OzVi/eS2D4rMuN9l5Xg+4pLms1tLD6oAU9nA5ouHizmYw8OWYD7E4eM8rlnGLOPq/wBHrw7lQ/HZXAvEtorS9BTvz14m/e0ucQaZHsQTVhsLRa1lLLm1z+NzzIrosOfI6u2y9VRG8ld8ZmkmmtPVUeWuBpbKitmX9Taeem776J8mxKszZX7aoNPqk7A9ji0knqpPZTie081S6UjqRw64NclN5vVcDpwSBEQdruQa0UCC592n2LVfsRxYBETcSFmwyVEHxiDItJ8X0hfRBN+rIwBpGuuFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWRmiY4z3Ys/5vcChx7a0Io5c5SZGY4E/cy9CRZBvpA=;
 b=UNW+i4+DY5j2qE4Vf9+CICCWXuiF33HjpTiJN7/p3v9DQmxB7Z7wC0/LCOUS9bHjdUXhqzjPkl/bt98pJq65Cc83uQb5Ny8Xs6L06lh+N9K9y4sMSe7Zot0N8y5JR6/3fznCrn7qOUv7YX4qAN83Om2VTcSjgBWzR4Ypma1khV/JblJzx1xEApHAqiJwrEUzcw5Ikv31CJA9o8T2oXPc64kKFlWB9sbuLYTsw3zk0yr9FU0cw9sVx/B1UvOkj94RJ7TW3FBsp/o3wZqCO1iJ9iZuxZK5+aX67EIKQBCTZF6bOcqKvcCeVRDr9otuLPbR6ma6UTBYAA5o2SO8XMbbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWRmiY4z3Ys/5vcChx7a0Io5c5SZGY4E/cy9CRZBvpA=;
 b=XSTQP90HUc/E/xg2w8igG1j9xNzeMHzSvuWtO+dAidqofoER6BiFihkimjtsalg7NkJLGh5zvlpX8UUr/sYYxSQaMRsVNU2HQZoPKxj7fhwdZDK/xIaCMI12zsdlQK4CyK3p7As8soyuCMfMu7sunWx3aZWWKGqcT1RE1lXboPc=
Received: from BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::15)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 10:40:09 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::5d) by BY1P220CA0049.outlook.office365.com
 (2603:10b6:a03:59e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:40:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:40:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:40:02 -0500
Received: from [10.65.99.143] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:40:00 -0500
Message-ID: <6f6559c8-f3c2-4d10-be9e-75985bcc934e@amd.com>
Date: Fri, 5 Jun 2026 18:40:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
CC: <qemu-devel@nongnu.org>, <gourry@gourry.net>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, Igor Mammedov <imammedo@redhat.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
 <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
 <20260603151443.612d0e61@imammedo>
 <c7c8e578-86eb-4b74-b63b-6b81a76c4329@amd.com>
 <1d2381a2-7101-4039-b41a-d4cccbade4aa@mailo.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <1d2381a2-7101-4039-b41a-d4cccbade4aa@mailo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 80376095-3395-4c0c-ba1c-08dec2eecfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|4143699003|3023799007|11063799006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9cnGx5BInD7fniZcyPqz1Jok75pMupzSOl98AW//rcq7UEfTylcUKvG6PJrNhlHnbL1+Fu+VhkvWAW9tCIolwyH7B0X/gcy0jcbc+YO3RvdtA1bTVEAQ0OQjY/YBMZE5qFXHYxyNnltNR7dklVc7BHCiG0UWcVANwdLKpYOYs5Xu7SwaAr498lNKsk7Y1MlAHGZGZ5Lpwm77qXFnEVidV0xJ/65PBuHXHA8qkG0PZ64z0KwXGlBbHEl/1E1VaWUKTSDjC2XJAtUYdYVmLaxIxsX0g5kVcBkkJgHkAH5Xszapeg+GOfmV8WlOL/sKHsaRLtZVtaeg1JL3cgs92xJ8EaNDWU0ACfI+S3i1Kyhm+vfqLZ8NO3sQUjyhc1/OXnV/Y/G3XWN6l5ZsnIXSXrkhNKamHYfmORepxY7GUL1O25gImLhjY9BlWZLzqj+qyKcFEuE6PQiVjke6STh0vmOb981UrtERyTOIfgHeUZMIjvQ3T8i9/iCRx4IOr68LB/RvU6sDnY3PwbFd0RuAMPjeJUF0NdQa3DO5juO1dGQsOjSlf3eB7UUj3ufbGfJ7wVSzl33UFHtQMh8axm7ubnXDY0GdhBAilmTEs9q6bT5OQ8Gs9aTD/rqq0uH2ITuKnlj4duefmdzvXxACUMsYFK+cJDRM1GAs8mHi+oTsI3mcoGKQBgnYKlEv2QGtDdM4HG5f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(4143699003)(3023799007)(11063799006)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X63sfutk59OaQj9ToWGY0u85o+xMAVXyLqsqH6eTyjVJ8QkMlCCisRZSNT23pLYhxYmd/ne/BZnXxfXXx4uS1IRzptyD6utzwJcZ/NnJMI6hqunj2dzcex8XdPxR1g4bWGKOdtL3A9g2RIa15rCenQolyaQPMcsD4vor01Ag1R0yi4ZBE8GhJptQ8QYVkKalHTuCiylr2WeKuc1bA1cowdSR67ohNy8kI0Z9cFE+ueqKZyOrKiAr5P3B4QFL0PRhq1W3OD/k36VpMND6a8YloU0995jfg8MEsvcPSFQJXPbhzM3KTp235deLAw0RzW05o67agl3kaZkA7lpkvc1a3fF+d/fgFnjbAUAB9laVK+DN0ATrUI6A8iifoh1R0XDjngvEOxAUzh+MCB5HelWPy09WshyIrJPBiYopyEhgZVZH6z7mYNK9SG+crLovU61G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:40:07.8096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80376095-3395-4c0c-ba1c-08dec2eecfe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Received-SPF: permerror client-ip=40.107.200.45;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 6/4/2026 2:30 PM, Philippe Mathieu-Daudé wrote:
> [Some people who received this message don't often get email from 
> philmd@mailo.com. Learn why this is important at https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> On 4/6/26 05:35, Huang, FangSheng (Jerry) wrote:
>>
>>
>> On 6/3/2026 9:14 PM, Igor Mammedov wrote:
>>> On Wed, 3 Jun 2026 09:45:28 +0200
>>> Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>>
>>>> On 2/6/26 14:21, David Hildenbrand (Arm) wrote:
>>>>> On 6/2/26 12:02, Huang, FangSheng (Jerry) wrote:
>>>>>>
>>>>>>
>>>>>> On 6/2/2026 5:36 PM, David Hildenbrand wrote:
>>>>>>> On 6/2/26 10:44, fanhuang wrote:
>>>>>>>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory`
>>>>>>>
>>>>>>> Very nitty: but spm already includes "memory". And I think most
>>>>>>> things on the
>>>>>>> cmdline use "mem" as abbreviation.
>>>>>>>
>>>>>>> "sp-mem" ? or simply "spm" ? Thoughts?
>>>>>> Good point — the duplication didn't quite register when I named it.
>>>>>> I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym- 
>>>>>> only
>>>>>> pattern.
>>>>>
>>>>> Best to wait for more feedback :)
>>>>
>>>> +1 for 'spm'
>>>
>>> I like spm as well, but it's a very short acronym  and /me/ uselessly
>>> worrying about ambiguity and future name conflicts.
>>>
>>> perhaps: sp-mem would be better in that regards.
>> Confirmed — quick grep on master finds "SPM" used in four unrelated
>> subsystems already (AVR SPM instruction, s390x spm instruction,
>> m25p80 SPI flash Status Protection Mode, AHCI Staggered Power
>> Management). Bare `spm` would land in noisy company.
>>
>> Leaning toward `sp-mem` as you suggested. Concrete before/after:
>>
>>    cmdline:
>>      BEFORE: -device spm-memory,memdev=m0,node=1
>>      AFTER:  -device sp-mem,memdev=m0,node=1
>>
>>    file / TYPE / function (after also dropping the redundant _md_ infix
>>    per Philippe's KISS suggestion):
>>      BEFORE:
>>        hw/mem/spm-memory.c  TYPE_SPM_MEMORY  spm_memory_md_get_addr()
>>      AFTER:
>>        hw/mem/sp-mem.c      TYPE_SP_MEM      sp_mem_get_addr()
>>
>>    QAPI enum value:
>>      BEFORE: 'spm-memory'
>>      AFTER:  'sp-mem'
>>
>>    Kconfig symbol:
>>      BEFORE: CONFIG_SPM_MEMORY
>>      AFTER:  CONFIG_SP_MEM
>>
>>    struct + cast macro (using OBJECT_DECLARE_SIMPLE_TYPE per Philippe,
>>    since the class struct is empty and can be dropped):
>>      BEFORE:
>>        OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass,
>>                            SPM_MEMORY)
>>      AFTER:
>>        OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)
> 
> All these changes LGTM!
>

Thanks, Philippe. v10 also addresses the rest of your patch 1 / patch
4 review (node validation moved to pc_sp_mem_pre_plug, `.unmigratable`
comment, `DEFINE_TYPES()`, dropped `/*< private >*/` markers, R: tag
under Memory devices); diffs visible in the v10 series.

Three items deviate from your suggestion:

   - DEVICE_CATEGORY_MEMORY: the enum doesn't currently exist in
     include/hw/core/qdev.h, and pc-dimm / nvdimm don't set any
     device category here. v10 follows the pc-dimm precedent.

   - QAPI base refactor (id / memaddr / size at TYPE_MEMORY_DEVICE):
     acknowledged as a pre-existing pattern across PCDIMM / NVDIMM /
     VirtioMEM / SgxEPC / HvBalloon; out of scope for this series.

   - MAINTAINERS squash into patch 1: Igor's v8 review asked for
     MAINTAINERS as a separate patch, so v10 keeps it split as patch
     4/4.

>> David, Philippe — any preference between this and `spm`? If sp-mem
>> works for everyone, I'll respin accordingly.
>>
>> Best regards,
>> FangSheng Huang (Jerry)
>>
> 
> 


