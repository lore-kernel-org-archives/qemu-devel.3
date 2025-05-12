Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5F0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMNC-0004Ux-T4; Mon, 12 May 2025 02:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMNB-0004UN-Av
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:10:45 -0400
Received: from mail-bn8nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2414::628]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEMN9-0008Ju-C7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:10:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsaU2WG7ctwpXX37Csx3pB1h3wconXzI3ku5fsMFi7EERX9kC4p3XJUUtkkS/Yefe213EVMz9rPfIuXmHlexH1rGROuVj4s8MY+G3JvJZKFH861jolriPtRkqWlrmebx8FlzbtQZr0ODmrA0pvPyI/WChFST4nJhXxX3ca4gx5QyTb3nEduX64qn1tS3jRJPCXo/wjuRmN6HIff/oZMfiBa6cUwkwQidA1zqbFAZEDVf1R1Fy4Z2FcAuYeVQAsSWgORPUBIoVHtOGI4GvA+JKwtlz4kRaF1OcqhJ3X9dQNLw4iPc+7rYlv2m+bsMX8qxOyun6Bn08dFIeyO5jE0+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrN8luj/3TJADoCtOiE8NR8C3VgPxIB3ZWimxUKU2Ts=;
 b=cJgucG12ijjNuLJR7uu6/qxd5iOquuyW4laQ2zu7rRPqTD/sajQ0KyDvtIi7VPUMNW80hlCFKqQeB1dbtpAw5+DpdDbUUvA+iPUCFY60YmfLMLs5WDgTXBb9XwHITQnqc1X9QXz34wS/ptYUb2KIdH3E37sznz8ANSYIarV4D5cMdbwxHH/48DTCv0WU8Af2KG1+xcwXvi8Fhg7QUGVijDyu5XmDIfHx1tIpH5pDGYF1GlmrWYdhRrI58gWivjPS2kFyoCD28sCqfajr5UIFn0oMM5RvGmukETIVFyOoRxZJ01N6ApqZ8GqV2CgCNGGlH0BqFY8DdzEAwjlUrpJFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrN8luj/3TJADoCtOiE8NR8C3VgPxIB3ZWimxUKU2Ts=;
 b=HnE2tBos52x9aa6MhzOqOuO/Ki5Wr2DXMgnUxi/eT04K7Ww6MVdNzKDYAkxyUU/GeskfqhRyQtyhuSUV8g06YzTNdklMV/NI3GP7vCltuDwKUW5hov0edyhjwEUikCR9RexgZ9OvFE9pwwYzdRQU+Hb+h/+1sxiTPnoOA0L+ClA=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 12 May
 2025 06:10:36 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::aa) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 12 May 2025 06:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Mon, 12 May 2025 06:10:35 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:10:32 -0500
Message-ID: <6a836252-1fe3-49d3-be96-fea32319deeb@amd.com>
Date: Mon, 12 May 2025 11:40:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] amd_iommu: Fixes
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <philmd@linaro.org>
References: <20250509064526.15500-1-sarunkod@amd.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250509064526.15500-1-sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 13113153-ebce-48c6-bded-08dd911bb5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29HNFNNUGVSOXVqQTZEaXhJZFNFbFpLMStraHdhbXI4dHB1N2hkSko1R1pN?=
 =?utf-8?B?U2syUG1sN0pyWXF5TFVLd3lEYXYvUitPblNRMkdPOVA4RTFTRWV4eHZpc3Ja?=
 =?utf-8?B?NmhQaWpjU1Q0SE5FelN2Z0ZkenJrNUZkRUF5aDVHY0p0UnVCSmhHU21vYjRE?=
 =?utf-8?B?WExNeWY3M1BWTEU0QmphWksrTTI1RG1VUmdRZDNLaVFzOGpnY1RXRHZOV0VB?=
 =?utf-8?B?clNaenBtaGw5Y3F3YzFUaktDcHNhNE9zMUlUcFRaWHNodk9QZDhrSWRlMWJu?=
 =?utf-8?B?aWpVdXRHc2FNekhMMjdWVmQwbEFhaUh4MjEvSktxaXJiVkIweHNybVRjWWxH?=
 =?utf-8?B?NTcveTY3TjRpMHBTOEhndTVFRC9uWUJkOFVTV1BxRWY4Y1B4NXppd1gzc3B0?=
 =?utf-8?B?ei9oNXdGMTVMbUtZTjJCV0Jjd0FsV0x1R2dQaHpBaEEvZ0RIVVVoSTRPNnU3?=
 =?utf-8?B?U2xtNytxRndEUm84Tk1rNytWTHVEZElZdFYwRjlBQ2djZGRuTVNkVU1HWlF2?=
 =?utf-8?B?N3lMVEF0d0h0eWRoVm9zK21ucVhhTmV5QUc5czczRGdudWpaeFVpd0hHelQr?=
 =?utf-8?B?WUk2R1R4c0Z1bkNoVmkwMGljaDZnOGx5M2FEdjN4VGo0eHFEK3pmU0RvS1Z2?=
 =?utf-8?B?QmtmbWYyUW44Z3JtYys4b3lYdndHZlREKy91QUNQaFZmTkxEQnIvNnMxM08z?=
 =?utf-8?B?UlV1QkRqcVNYaGZIblo4d0kyQnRyQTBVSUxQYUVsZ3lrSmpKaklwbThaQU5r?=
 =?utf-8?B?bWxWa0JMTDgwWWdHcDZTWC9hamtPcmRwcFp5RC9BajgrNzlwbzNnMWUyWkFY?=
 =?utf-8?B?Z016V21NRUMyT0FQeFFLVktSRmwxUGRGalZwS3UzZ3I2N0FPZGYvbTEzNFQ4?=
 =?utf-8?B?aUZobGNjbUowanoydmExNWRUWTZ1RWVadnJYRHNDT0hBTVVzV0hJK2ltdWZY?=
 =?utf-8?B?Z0xmMU9JcmRQQ0pWM1NmdTUxSWNaaHBOMzVMNVZuTDlxN0FSV2NoVGo4SFhN?=
 =?utf-8?B?RDhqOUpXSlNVWG9TRXdicXc2TnpjNFptVElqT3JXeXdTSFQzWTVmU0dFdUVQ?=
 =?utf-8?B?ZHF5QTA2SVFFY2JBbHdjeXRaTUNBZFFjWFc3cmtoZHVSMmg2a29wbk9DeGVZ?=
 =?utf-8?B?czRPbER3VnZseldPbnA4bTJMM3Rlb3ZYaWo2RTNwd0dYcnc4TGlFeWJYRnNn?=
 =?utf-8?B?b0NLcXUzZVd3UE9qb2VZUysxOENuSUVqd204WkFxeE04ZEFaRDlVR09WZDZU?=
 =?utf-8?B?SjNZOVF4UmhIMGJiVlgvQVVpMktWdmJxKzFDNWtYTEdzWUhQM25GV29KSTdM?=
 =?utf-8?B?YkpBdFRJcFd0Q2Y2U3ZyWWZTTVN0M3FYYlVKT1Q5VE83SERCLzFOT1JVa0M3?=
 =?utf-8?B?eUpzYmtSejdQbUs2Qy85cTRBMExHVjJUSXJSekdJR3kwWTdtTmpqT2ozU2k5?=
 =?utf-8?B?SDZlSXhIRTBUMXBINm9FOVJlUnpqUlZBQlNkUXRwaGxNV0IwTmMrc2RkbWNv?=
 =?utf-8?B?L0V5NzZzSHFwSGs5bWNxQzhPREFaenBXSVpET0gzZlFWbEtTdkw4Q0VkclJy?=
 =?utf-8?B?YW1vU1RzRVRiY1JrekVGbXJDUEhQOG9QdnhvaENoUUFHbDlTamRmTXdLZS9D?=
 =?utf-8?B?cG5yNDY4RzRjRGFLSkJuRzZlU0k0a0V2OVl0dThpdnZZTmY5eGZQNkRCQ0ZC?=
 =?utf-8?B?R2pLcW1tR3c4SzlpUjh4UjVNSmFUbzNxdXdKV0NBS3hIa01CMXpWVnlFem9o?=
 =?utf-8?B?Z1lkQzZiNC9PL0hRb3cvdEJDN3ZmMzFqRDBzRHR6MjNDc0cwck9tWmVjekNn?=
 =?utf-8?B?cHNIMjBMcUdxY0RhajRyU0RXZUhIMnBmTklOOHluVS92ZlpSamMrRkkyMGg1?=
 =?utf-8?B?ZXdLbGhsamN5RGdQSjJLN25jTWRmQzVlenJIVFdNVmVtSU5venJtREN1QUta?=
 =?utf-8?B?N3R2N0NYdW1aaVJrY2F6RUNlZk9vU3ZvQzdoNzZxcHkzQzY4UFpaVmFQQTJm?=
 =?utf-8?B?bDBMWVIvMFExOVRYR2ZVZndsY2FTMVhyNUgzdmdTbm84UVJXQW1RNnREdGZm?=
 =?utf-8?Q?EkxlhY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:10:35.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13113153-ebce-48c6-bded-08dd911bb5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
Received-SPF: permerror client-ip=2a01:111:f403:2414::628;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

++ Philippe Mathieu-Daudé

On 5/9/2025 12:15 PM, Sairaj Kodilkar wrote:
> Fix following two issues in the amd viommu
> 1. The guest fails to setup the passthrough device when for following setup
>     because amd iommu enables the no DMA memory region even when guest is
>     using DMA remapping mode.
> 
>      -device amd-iommu,intremap=on,xtsup=on,pt=on \
>      -device vfio-pci,host=<DEVID> \
> 
>      and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
> 
>      which will cause failures from QEMU:
> 
>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
> 
> 
> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
>     does not enable x2apic mode.
> 
> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
> 
> Sairaj Kodilkar (1):
>    hw/i386/amd_iommu: Fix device setup failure when PT is on.
> 
> Vasant Hegde (1):
>    hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> 
>   hw/i386/amd_iommu.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 


