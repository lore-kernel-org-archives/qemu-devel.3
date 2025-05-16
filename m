Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C73C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqB7-0001a5-Ba; Fri, 16 May 2025 04:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFqB5-0001Ze-Da
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:12:23 -0400
Received: from mail-bn1nam02on2084.outbound.protection.outlook.com
 ([40.107.212.84] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFqB2-0003FD-5y
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1YYkOpYmgZfUOHoCqPSgv6KogWSBJot0jxqG2AmIMOFoqfUXJcsrrI4FGn0Xpsrzg/GMGURbUEx17Uf22Lc5P8D92+eHrBVxAVmkTzHVyV0hVxPHrLlLNo7DvEAxP9WvBpL/yA+xJm2Jb20RTtbvS/m2W8JcAAiaT4KeleMv8/n6evUavxPAM44MUfDMjfgoa1dqjAhZes0g2i3i/NqAEPkZeLc8cgVqlKvDHUqmC2FSzjE7TET8Rcx6Tz4DyrgLMRwdIato/U/1C23NdfK7W4VrHoGuGFfIV7rVEN5GBO4CO8516rxNeuHPPeAP5ryTxUzHxqPNfvLNGd6DKYiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6YYXinDbnrEeinC43238rOnPulqYpMTX0yNbIj7pzU=;
 b=qRlvMQz9QYYZ5B6h6ojLf5p3YcGXDrAOdfI7YwYXblY6i4DoAPdonR7E+fytkbODEXDJgifrjjGa4/x7Hss4rs87H0FKPzgjlPZB08cOVbShmFbhPbeE6EOvS4nZPLPkFayMBOXE3M2bI9tQZ3xeXDMFLWOrmVA9P38xUSfTxxR1yV60QkZW3GC66EXbAt83UTk66vpcoyYaccxuzaP+0ttPO47pUnwSwPET8zMxKrQon5OEnkU3/SGqyQh7eey1QflirglNJLMkca6fjUdbl0HcXpz3Fta/3wHf0YfJm9fRlvKY0DqREyf7GtS5z/EigCGLdtyp9FiUFKaV7JrxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6YYXinDbnrEeinC43238rOnPulqYpMTX0yNbIj7pzU=;
 b=hgP32ji0403qjuioT3Qkyc1YfLmD8wlJR+91Mxq+iEIG/Ew3TzIeRQp1mE5MFhiFDqnmchWzqeHFD4tTXJYzsL4X21rKlQMnTQ9fswT7CLaVAdem+mQiLUhfqE0uNm9clj+JDC7QIWgqPBGHz2O0kneY44LdoPCJAZc220VMw+E=
Received: from BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 08:07:11 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::d4) by BY5PR04CA0029.outlook.office365.com
 (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 16 May 2025 08:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 08:07:11 +0000
Received: from [10.136.37.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 03:07:03 -0500
Message-ID: <77942c0b-c7a4-4614-b0a7-f8d047cb47ee@amd.com>
Date: Fri, 16 May 2025 13:37:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4874a052-d709-4a47-6e1c-08dd9450a91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzNmUlhQZTBoUmJ1ZlJCdm9VaEhQS2FYOGhvS0V4dC96N0IzSXBmWGRoS2NW?=
 =?utf-8?B?ZDZXOGtUdEp6Q3BYbDh1eTA1RjhKMjJQY0lvYktrZ05LNHpOSmVBcTI0Ykxw?=
 =?utf-8?B?bFhwOU1YeVM0a0ZMOHpMYVdveVc4bllQNk9ybGR0Z3dNNkxuVGNvcjNmN2s5?=
 =?utf-8?B?THN4ZnovMnVoNkplb2xkYlQyQ2lIenlmSTdJTGIyd3hjVGZRUzBTbDZId3FB?=
 =?utf-8?B?SncyNjh4cUNoYzJ0alpxVW54Z2N3RzkvRkVJSEgrTmkwTkozL25OUlErVmV3?=
 =?utf-8?B?WmM4eEIxZk9oUnVxNEwxekZhNFJuTU5ucjUxSDBvaHpBcjBNaDFDNFgyU1FM?=
 =?utf-8?B?YWNvVm1hN1NOTFR5NTcyNEJZb3VZTHZEMG9OTG5aOEVaWGM4K20zRE95eXdT?=
 =?utf-8?B?b3RVRXlzdGEzYWJiWG1YbU5qczEzbXBCUlhpYzRsQnprd3VNUkg5UXB3WjNy?=
 =?utf-8?B?cWV3Y2J4Z0cvWTk5aXdIQzJ1bUEwMmt0RlY1d2xwRVJMSDBIOU9iSENDRTVX?=
 =?utf-8?B?QzRiNC85OGRpQmN5SjNDYlQwbk8xUU80eWtPakZkTzJQMmVmRHAyMlB2ODNu?=
 =?utf-8?B?WnJGYXBLZEJUM1B5SHVxRHU5MWFhcHo5N1hCck5pS3BlYmYzQmdSTnhrbFN0?=
 =?utf-8?B?N2xxL1JBTitYR0JKWnZjZER4bjFEU1B2QmovbjlJSXBBa290VHhBQzVsbktI?=
 =?utf-8?B?bXpKY1AxaVEvRXIxbXpDZ2pmaFJnYlluUWxqRGpweVlxN29lbU1oUS84TjZ6?=
 =?utf-8?B?Z0M0SkZsdGZYbHdCUXE0Y1RQVnZzdHN5Y0pNbXBBc1JPbUVpejFxcnJtTmZI?=
 =?utf-8?B?OC9kWE54OVRFQXB1bGZvSXBzRDkyVlNXeUdaWWpsTGphb0RlK2V6cE5uQjlh?=
 =?utf-8?B?MnNJdnVhdkRQZEQwZ1RVTm9La2w2WGRORk5aQ3NoTFl3KzdBUjRlWkl5WHJV?=
 =?utf-8?B?cTZRS2libkp1U2hTY0F1REdFN3c2UDdNRWJWS0xsNDhwTUQ3U3FiMjZLQlFB?=
 =?utf-8?B?VTRTSVhPS3hLdkhPdmszUTUzVERRNlRjOHZZc0NOR1NhWjZvMEJlcitkcGor?=
 =?utf-8?B?Ni85Tmd6dkFPc3R3TjAxbmFMWHpXU0ZNZVhURjREN3VkTk11OEVreVFTcllk?=
 =?utf-8?B?ZGZOV3Zpd2k1aVZjd3psWFFDTGZzelVEK0pkS2t5STFodWhGeVhPa0ZYcExp?=
 =?utf-8?B?ZkM3a1hMSDN6aUVkMG1yOHBiazQvNzJqb0dRZUVMcDk2L1QvaWJ0YVVjUGRN?=
 =?utf-8?B?ejJYejBzRGlTM2VsNTNtOW1zOERkOGZPaTFxejFWMmEwSWsxN2lsZndjRkZy?=
 =?utf-8?B?dldoenRvTGV0a282RUhpK2VEaXdMSXBKNmxyKzBpMERER0tHTGNURXVOQnFj?=
 =?utf-8?B?aERUWlFOWmJ1UUFRbWVNWGxqbitzalpHMWRmWThBMUd5blpTWUhRUm5xTi9I?=
 =?utf-8?B?Q210ZTluc3JiWnNvSkZOQVNhMWxjQ0JLcnBNcEg3QzYxdXpibWRsL0RjRmoz?=
 =?utf-8?B?ZzlRTEJZVCsxMDZ4RzlnbjZ5UGZ2ZUx6Nmx4WisxYVdFWHRxSmN2cWNPQVJm?=
 =?utf-8?B?bzZiTjNkM04xQUJSa1NQNDRIY2V1TkJNQi9NenhHN0M1c0hkT3p6dEZEeU5y?=
 =?utf-8?B?dDRvV2hMUkdEQXNwcmJpQktxSG82QmNFOEFMTG5NZGU4a2t2aGtDeHRVK004?=
 =?utf-8?B?QXAvQ1VvMnlNU1BJVmNiUmlmYUxzT0RtTTFSRHVZY1ljbG42T0V0bEh0Ukds?=
 =?utf-8?B?bTR6clFpMzJFeTBnZWpzTkJkYnJSQy8zZ2VkR2tZSmNiQ2ZHVzlqK3Rza1Ur?=
 =?utf-8?B?bWg4SFJkcjVGaU5wKzZ3d1hTemt2TmxSdnNvVGk1T2pwZnBBeldnSStPMXcz?=
 =?utf-8?B?eVd3cUcrMnhCWDRGR3JsaHhPK0FVOE1pQnVxL0ltckM1Zko4REFmTlJrUElh?=
 =?utf-8?B?dHFROHlIOW9LZ3dBYXlCUCtSK2lLV0NTZ3dDWVB0M01RZXdRdWJoLzFRQVpM?=
 =?utf-8?B?UjdVbkxVZytBMWRlME9HMXkxS0p0Q2wzTWJSelJ5aFYwcGZyb05raEdjcE05?=
 =?utf-8?Q?WKtq6b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 08:07:11.0723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4874a052-d709-4a47-6e1c-08dd9450a91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
Received-SPF: permerror client-ip=40.107.212.84;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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



On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> This series adds support for guests using the AMD vIOMMU to enable DMA
> remapping for VFIO devices. In addition to the currently supported
> passthrough (PT) mode, guest kernels are now able to to provide DMA
> address translation and access permission checking to VFs attached to
> paging domains, using the AMD v1 I/O page table format.
> 
> Please see v1[0] cover letter for additional details such as example
> QEMU command line parameters used in testing.
> 
> Changes since v1[0]:
> - Added documentation entry for '-device amd-iommu'
> - Code movement with no functional changes to avoid use of forward
>    declarations in later patches [Sairaj, mst]
> - Moved addr_translation and dma-remap property to separate commits.
>    The dma-remap feature is only available for users to enable after
>    all required functionality is implemented [Sairaj]
> - Explicit initialization of significant fields like addr_translation
>    and notifier_flags [Sairaj]
> - Fixed bug in decoding of invalidation size [Sairaj]
> - Changed fetch_pte() to use an out parameter for pte, and be able to
>    check for error conditions via negative return value [Clement]
> - Removed UNMAP-only notifier optimization, leaving vhost support for
>    later series [Sairaj]
> - Fixed ordering between address space unmap and memory region activation
>    on devtab invalidation [Sairaj]
> - Fixed commit message with "V=1, TV=0" [Sairaj]
> - Dropped patch removing the page_fault event. That area is better
>    addressed in separate series.
> - Independent testing by Sairaj (thank you!)
> 
> Thank you,
> Alejandro
> 
> [0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/
> 
> Alejandro Jimenez (20):
>    memory: Adjust event ranges to fit within notifier boundaries
>    amd_iommu: Document '-device amd-iommu' common options
>    amd_iommu: Reorder device and page table helpers
>    amd_iommu: Helper to decode size of page invalidation command
>    amd_iommu: Add helper function to extract the DTE
>    amd_iommu: Return an error when unable to read PTE from guest memory
>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>    amd_iommu: Add a page walker to sync shadow page tables on
>      invalidation
>    amd_iommu: Add basic structure to support IOMMU notifier updates
>    amd_iommu: Sync shadow page tables on page invalidation
>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>    amd_iommu: Add replay callback
>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>    amd_iommu: Toggle memory regions based on address translation mode
>    amd_iommu: Set all address spaces to default translation mode on reset
>    amd_iommu: Add dma-remap property to AMD vIOMMU device
>    amd_iommu: Toggle address translation mode on devtab entry
>      invalidation
>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
> 
>   hw/i386/amd_iommu.c | 1005 ++++++++++++++++++++++++++++++++++++-------
>   hw/i386/amd_iommu.h |   52 +++
>   qemu-options.hx     |   23 +
>   system/memory.c     |   10 +-
>   4 files changed, 934 insertions(+), 156 deletions(-)
> 
> 
> base-commit: 5134cf9b5d3aee4475fe7e1c1c11b093731073cf

Hi Alejandro,

Tested the v2, everything looks good when I boot guest with upstream
kernel. But I observed that NVME driver fails to load with guest kernel
version 4.15.0-213-generic. This is the default kernel that comes with
the ubuntu image.

This is what I see in the dmesg

[   26.702381] nvme nvme0: pci function 0000:00:04.0
[   26.817847] nvme nvme0: missing or invalid SUBNQN field.

I am using following command qemu command line

-enable-kvm -m 10G -smp cpus=$NUM_VCPUS  \
-device amd-iommu,dma-remap=on \
-netdev user,id=USER0,hostfwd=tcp::3333-:22 \
-device 
virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 
\
-cpu 
EPYC-Genoa,x2apic=on,kvm-msi-ext-dest-id=on,+kvm-pv-unhalt,kvm-pv-tlb-flush,kvm-pv-ipi,kvm-pv-sched-yield 
  \
-name guest=my-vm,debug-threads=on \
-machine q35,kernel_irqchip=split \
-global kvm-pit.lost_tick_policy=discard \
-nographic -vga none -chardev stdio,id=STDIO0,signal=off,mux=on \
-device isa-serial,id=isa-serial0,chardev=STDIO0 \
-smbios type=0,version=2.8 \
-blockdev 
node-name=drive0,driver=qcow2,file.driver=file,file.filename=$IMG \
-device virtio-blk-pci,num-queues=8,drive=drive0 \
-chardev socket,id=SOCKET1,server=on,wait=off,path=qemu.mon.user3333 \
-mon chardev=SOCKET1,mode=control \
-device vfio-pci,host=0000:44:00.0

Do you have any idea what might trigger this.

I see the error only when I am using emulated AMD IOMMU with passthrough
device. Regular passthrough works fine.

Regards
Sairaj Kodilkar

P.S. I know that the guest kernel is quite old but still wanted to make 
you aware.


