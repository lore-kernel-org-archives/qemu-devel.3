Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29899CD6E55
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUywq-0000rO-Tw; Wed, 03 Jun 2026 23:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUywo-0000rF-HN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:40:46 -0400
Received: from mail-centralusazon11011001.outbound.protection.outlook.com
 ([52.101.62.1] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUywm-0006Sh-9z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:40:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3gLeOVAX/TY5uZ1P2Pz5Zi6oH1gUDWTTVJ0Z2NFlKJAvB64vwuXnEciU/DTHmMVjiNPInIFeVoMoZBIoX2aaPPPMfvsU3eZcuGe9kRWHk0TUqvBuzv47oGJ87y6/+HFnAxeKgi8kpEbc6Eo9PldlxaQ1XhzOka+gGC5DjGusaDHF7hooHExiqzc8GyhRsWqnn/SApYb+ZUB/kglCqcGlpeJgFtABQzKNWQQpuYUZZxKu+zw6ktcFc9o+9QYD/0npo+iU9DliIaQpPWRiQQaMt3k5ewwffltO4tGN2U1iYfaqo1ebRE1n/mG74K0qGJfIe63j90tIKBoMHqJVfdJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaTpXL3Bbbk/QAXPsT+Ju12wpBkKoT5mHvcH9VXLQhQ=;
 b=iD7eNWUwhwzWvF6b41KTGpUM5AQ4BdD1vBLXW5mcB0HuMJ/QHzLAbAyys3L0eBya7II4uOvtpEFJ9jMGm8kjLuPMEkO/D7x38gxvTt2Yiz1ZJvkv0dOU6xugEOTx+JjyzrYqMq8UKyqQkAHaz8ALK3ttkfkdxS1H9EdVcxzN3Q0cTc4OZmD95Nwyo1FNu+2wW+7GOuS53CuZjMtsQzdP5nler8pNOVuR/qxgS1l/RbFYfrqRahCoylLhYjVVUpNeJdPPG4qnjqmD0O/xTfh94fzHBQmI6ZVd2oeIkWlsgEEhNTKeLitKZ0RbxXoq3nwQgkjnbRgDoiYeJ0WzjPKAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaTpXL3Bbbk/QAXPsT+Ju12wpBkKoT5mHvcH9VXLQhQ=;
 b=g0ykPZFtD5ygSGCJFIE0F71dZR96JHPtmVrVN+2AtM6uz2igW/HH+9OIXyFWV7de7M4VCiPwdkD3K0bzgi8CoCadSrKgxktc/1+8+U2OU28wJzHX58aLxldXDZNMWn9CVLRgQFJs4QCQ5MqKPtSWPErFrzip72XZXdu8W9nKJDQ=
Received: from PH7PR17CA0064.namprd17.prod.outlook.com (2603:10b6:510:325::21)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 03:35:36 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::8b) by PH7PR17CA0064.outlook.office365.com
 (2603:10b6:510:325::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 03:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 03:35:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 22:35:35 -0500
Received: from [10.65.97.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 22:35:33 -0500
Message-ID: <c7c8e578-86eb-4b74-b63b-6b81a76c4329@amd.com>
Date: Thu, 4 Jun 2026 11:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>
CC: <qemu-devel@nongnu.org>, <gourry@gourry.net>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
 <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
 <20260603151443.612d0e61@imammedo>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260603151443.612d0e61@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 963e982e-8d19-4738-d891-08dec1ea56e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|4143699003|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2KU1O1Dzw1gBxy23zDJQzaSD2hgsoGhwd5xY1OLd11dYvjalNgLADMgQ3axeM0C2lhWBAWWbKvIh86MB9hv3bNX182NVYPRRAV+smCXCy5exZfZO+9BEbpr5ua794aWCPQq7at8n+fvXqvYZWqzk+Q4BSonHm4o+32vYfmSL+qkxH/ww0zx8nBmmHsqA5FSmkRl4ObpVd1KxVRrXq6hSjnohswq+AKHwo7Gx57UNFMPuhcpvpKsUX5hDAmZxguoPnTeumZBXSd5WgYZG6YlUnImx2KOqagn0LJS5aGJRS17yKAw3cwZ0ePrfElHGhyJhcvtLKGbTITmQHGJ1kEURhhlj4fjDB7Dft3LTOOvKp5uquzEbOXmWYskamMEcdwHIzqeamHr3E8R1Zf348u2XA01NrUb04U6A1pSFupWZU63LtdASjLErOtWuFRJvPXBaFZAWcWSyCojq4qh/D8LT04f2TGhGGSfzeTVzfvCrLRvt06HaTJ/vTJ8WFQc9OSKWzrrMxHlXic9WRr/EUL43uQRozuDmFE7AZxZfnZbWUdjclz+Bla0hHyD3Y8/T9pzWNahzu7qWe50bsdAb0xnrRE6F5J+LrfMf8m7tqNuTnakkjYOG4VLVHIVwPrwJNMex/eMqinNfQOnXGm9hu5p6Q+ghrxkAKxXz7alkHZt9vsBVQuplYQTg370tQYydLqzClX+A4IWJeFabu9ftZV+mJ495yh7Qe95vJd4nITGj0vU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(4143699003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ke7ikw7wgBktTy1Ni1ScNaiIFWedljS/UxkaGNiX/2u73kYjLnm6Qet8qyrGEJE6z70W9UfkG+XXNUJLhzWrPNEzbVmRTWvBenB+ALU067on8xbyC1TkOWJ7N2MxzH8XTNcaVor/9a7oFNgPtqYpKw5x2bFYGsH/JDrsG7n6sGUKw4WE/Q7NS8vlKRUgWzNW3r1i/sdbII+uHX1IfIaA49850aa0MvK2rzT9Hf0Lh5oJxT9wn7njM1DOxxNmPgwmPK4PUpim669tem6q/zlctbLM0XT6lJDI8bJiK6hPNNDujB8bdbDjGXc5Sq+42+eTU1errjZxUBChc7sslr3XmKSFXjwBkuLpi1SVMZYJ84Wsn1Xly2m8WIBc+5ApCJTL5xEHsOvfjFtLJIYh7L8QHH5YjiYOdVhEoehx2LbBg4P39pBA9Y+rxfeTm5MbHXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 03:35:35.6734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963e982e-8d19-4738-d891-08dec1ea56e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
Received-SPF: permerror client-ip=52.101.62.1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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



On 6/3/2026 9:14 PM, Igor Mammedov wrote:
> On Wed, 3 Jun 2026 09:45:28 +0200
> Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
> 
>> On 2/6/26 14:21, David Hildenbrand (Arm) wrote:
>>> On 6/2/26 12:02, Huang, FangSheng (Jerry) wrote:
>>>>
>>>>
>>>> On 6/2/2026 5:36 PM, David Hildenbrand wrote:
>>>>> On 6/2/26 10:44, fanhuang wrote:
>>>>>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory`
>>>>>
>>>>> Very nitty: but spm already includes "memory". And I think most things on the
>>>>> cmdline use "mem" as abbreviation.
>>>>>
>>>>> "sp-mem" ? or simply "spm" ? Thoughts?
>>>>>   
>>>> Good point — the duplication didn't quite register when I named it.
>>>> I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym-only
>>>> pattern.
>>>
>>> Best to wait for more feedback :)
>>
>> +1 for 'spm'
> 
> I like spm as well, but it's a very short acronym  and /me/ uselessly
> worrying about ambiguity and future name conflicts.
> 
> perhaps: sp-mem would be better in that regards.
> Confirmed — quick grep on master finds "SPM" used in four unrelated
subsystems already (AVR SPM instruction, s390x spm instruction,
m25p80 SPI flash Status Protection Mode, AHCI Staggered Power
Management). Bare `spm` would land in noisy company.

Leaning toward `sp-mem` as you suggested. Concrete before/after:

   cmdline:
     BEFORE: -device spm-memory,memdev=m0,node=1
     AFTER:  -device sp-mem,memdev=m0,node=1

   file / TYPE / function (after also dropping the redundant _md_ infix
   per Philippe's KISS suggestion):
     BEFORE:
       hw/mem/spm-memory.c  TYPE_SPM_MEMORY  spm_memory_md_get_addr()
     AFTER:
       hw/mem/sp-mem.c      TYPE_SP_MEM      sp_mem_get_addr()

   QAPI enum value:
     BEFORE: 'spm-memory'
     AFTER:  'sp-mem'

   Kconfig symbol:
     BEFORE: CONFIG_SPM_MEMORY
     AFTER:  CONFIG_SP_MEM

   struct + cast macro (using OBJECT_DECLARE_SIMPLE_TYPE per Philippe,
   since the class struct is empty and can be dropped):
     BEFORE:
       OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass,
                           SPM_MEMORY)
     AFTER:
       OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)

David, Philippe — any preference between this and `spm`? If sp-mem
works for everyone, I'll respin accordingly.

Best regards,
FangSheng Huang (Jerry)

