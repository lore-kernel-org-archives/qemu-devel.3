Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34ADC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XmU-0006TS-Eq; Wed, 23 Apr 2025 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7XmS-0006TD-Pc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:56:40 -0400
Received: from mail-bn8nam11on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2414::624]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7XmQ-0007pk-2Z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFiH3NuW9ByvYeAVKtIx7bylhXziOkcRnvUNchDn55wjjRriGJjVjicF5cszRXX7XAjfol15RtkXh3FHbk4ds2CBbBoQMMq3R8s2y2Y5dyPyc8HNbv9sL2l/9uCWcOQVmr/hYQFQp6+Xuhb2uR5tKN6KJ3OVwR0ZfozmK0nZfzrI/BGW/LR0ykcyqdSfD5weROnbYL1Ov1o8wHzMPLfgQlzQfW46rghD4cgGOaYGXTWf3zKcjI4OWkDUhMhuLjmWJhFhATsXPXkxDKDTC0uQgrGYL+uNEA9n0iVhg+FLWd09HowoJ/1AmqRNIETgRkSP/0dwsl7kxFKNBGR2RjvuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPNZxzXkeGwFx67SpcFKzukW4imCVnv+RODf+vvOTAA=;
 b=RHIZEAXJkcBQykgTzLxPe14EEkH5vG7KfGL4TxUKE5n1tVw5SowoE3NWZ7ZonLjeCwMJi79a2gp2FJD9Z1bq7LfiZlW3iOAtkrCMGdpy2fvQnIIgGKh9MhuBnpZq+E9R1Jtxh7nF7IJMRrdsIWY4BiA4eETChLqT8BabXpm1xseznQFJdjyYqgtwmETwlv0cbKMobrVa4Bmqy2+setodElkHMU7XhfenMeJr/24J6wavHcaMYdK27NNgR3zJqLpI26gaMzStSLiPcS7EUrVbBgY3Eb0tBtx9s2PwwY0pHjmO2YGvahM+5hO+Nlf8oOplN1ENDTnPRe4/9Y6Bgjdhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPNZxzXkeGwFx67SpcFKzukW4imCVnv+RODf+vvOTAA=;
 b=EA5bKh82YEW9Q6Rm225ZvzPvxxUjDboF1a+8ud9qy9CoPngp6hANv3FLIeReW9eT81Rzh95gRvlYlL2NMfo/Y0FOt97a+8094dp0Ar4iHcAQZ8FFmwqXVVwRmF/8hgsQK5YlMWZ8Sh9B3WRyxbleDNmymPUii6JQSmlQC13UGFU=
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 10:56:27 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::75) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Wed,
 23 Apr 2025 10:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:56:26 +0000
Received: from [10.85.41.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:56:21 -0500
Message-ID: <0de21fc6-72d7-43a8-ba03-6cd65b5eeedc@amd.com>
Date: Wed, 23 Apr 2025 16:26:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] AMD vIOMMU: DMA remapping support for VFIO devices
From: Sairaj Kodilkar <sarunkod@amd.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <cf8587fa-f6e7-44c0-a33f-fa118e0d806d@amd.com>
Content-Language: en-US
In-Reply-To: <cf8587fa-f6e7-44c0-a33f-fa118e0d806d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c57d10-d763-4626-3fd1-08dd82557e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm9YOW1taVlqZWJScWhIcFRVTVhBUUREWGFmY0pDcUlkekhSV2x1OHNuclpY?=
 =?utf-8?B?dnFaRlRGbGp2VW5FalV3QUtXL0dNRDN3SlFwb2dlRW1mZk1uay9YZ0lBQitX?=
 =?utf-8?B?NzB5d0Q4L3M2MkFPOWRRYS9ILzVXWXArTVc2NHA0dm9vTzI5WXMxRDFtcy9P?=
 =?utf-8?B?amlBWk9TdEJUWSsxenJXdHZvVW13a0JnamJ5R0dxS3A0Mm9BdTlEblpjZkxP?=
 =?utf-8?B?aTRXWWhpRDVXSFhjNHM5TlVZNmxhcUZEL1VNNkEzc0ZqNlVnak9hVEVUYW9X?=
 =?utf-8?B?L3B1blBidnU4Z2VZVStObXU0cTlXekZ6SVQ2VW8xRlorK2ZIOHZEd1VPTWlh?=
 =?utf-8?B?S0Z0YnYybFBORGtSd1dNUjBrbjc5eHJHbmcvVGMyZExqVU8zVktxanducUtn?=
 =?utf-8?B?NDRla3VzNTJlRUthNnhLK2lvQ20rb3BkMEtXdHFISGxCMFNFbmxFSU54RGty?=
 =?utf-8?B?Ull2UHd4K1hvODluVTBseWk0SGFHcWpTZWpxenE4TEVDTUprczl0Ni83Vit3?=
 =?utf-8?B?T0EzTlcwYmYybzViTTZyRG1MZ0RWMEsxYURVRmtJWGwxU2MzNDBxQy9kU2ox?=
 =?utf-8?B?bmZ4cUkxaW00cmxZL0s1K0h6TEdUVzIzSzRieG9SbkV2TEpJNi9IR2Z0NndY?=
 =?utf-8?B?SVM2S3ZiOGtpd0Q2UElNR0xVZ2FTcEhMblhyUWo4Z1p3TXJFSm1mMHJQWUc1?=
 =?utf-8?B?MDZ3ZUs5S3I3SjNNZlhXRUdHWUdxc1dRNVBYdy9qUkUvcUU1QUIvbE9mSklS?=
 =?utf-8?B?aFE0OHpYaVdDNzlCSTMyQ3RuNGt3S3l5bmdaVi9VT2lCRk92RmZYUzBSRTNt?=
 =?utf-8?B?WUZKRXJDdmp6d1VLM0lwQS9lOU4wMmVqdFVBZ1dCSTkvM3dJSHQzQXYrWkVi?=
 =?utf-8?B?TVNmS29KbjhPUnVIc3BtQkRMTWhYR2t1OU5HVGhOelFVU2V4VkdGWDYxejla?=
 =?utf-8?B?OG51cEovSy9iZDcvU3QwWWlkMGRJcWVBcVUwWDlkZjVGQ1NYejAwRU0wSjBG?=
 =?utf-8?B?S3lSbTBpUG1DVVFBTFFGSmM2UFN5OTh0QjNCZG42N1pZSiszV1hkb1I1bUJt?=
 =?utf-8?B?MnkrVlJMNTUyZEdyeTJMdUxSUTUrQVI4Q05wbWJiKzEzd2hpcHdnbm9mYlZq?=
 =?utf-8?B?SkVrMEY3RXFWQi9vOWxrbHRnVEM3NlZLYS9yK0FlV1EvNWh3K0VoMlpNUGFl?=
 =?utf-8?B?MXFyaVZOZVpSVE5zU0REZkNST21QZmpSQTI5dkRyblZqMzVmeXpMN1lkSGlG?=
 =?utf-8?B?b0d3ZjJ3czAvQjhRZDZNWkFkYjgydm1mUzBsaWZqV3dkSW5LeFllUkNXcUox?=
 =?utf-8?B?eXM0NE1DazZPcmF2SmlJVitwaXNGMjM0SkxINzBkNHE5enkvMlhEQnluRHZ4?=
 =?utf-8?B?Wmk1bDZpaDMwazdQMXpvU1Zzb0loTzZ1UTBQbzhnNnB1SHArLzRmYUhQYmNL?=
 =?utf-8?B?dkhYeUg2bm04dkFtUWxIT2ZESURmNXNuaUp1b1lxM0Y1RFNLZW1WMlZuVk9w?=
 =?utf-8?B?ZW83cGRiSFNPQzVmQzFORGEvUUVpZmZjU09yQXF1S3YzUlp6YkdFNlZtemE1?=
 =?utf-8?B?aDFrcDZWNEJ0bFlSOXpJRGozNXIrMnVwbThzR3IxZk4wdGdUZ1VSY1JmZk5W?=
 =?utf-8?B?RzRCZmpLWG5jT0ludVg3dHYydlpaQ2JpUGpwOVFOYkt2TmZ2ZTV0Q1pOTmpL?=
 =?utf-8?B?UlIrUWYrRmV2MUdFWW96VWlSY1dyMjNhUnBVc1RqMnpuajZyRXRoK05qeFdW?=
 =?utf-8?B?YXdxL01SYy9qaUVlTjAwdm02V3haekFlQXFPaDVEMU93NlMvbCtFOEVOYkFN?=
 =?utf-8?B?dlg4N05Ic0hoMmUvTm1JWXgvYWwvR213LytRSE1wTWZqb0RlOFNvejJIUG1B?=
 =?utf-8?B?YkNnc3JKN1ZUN0FSOGUvNE04S3RMN20wSmI2SnZWTmlHRVRMdHVxdmJzU1gv?=
 =?utf-8?B?cmFhb200eG9LSDNpSnBFU0JPNk54OXRsRm1YZnV3cG5OV0FNTTFzTkEyVVRx?=
 =?utf-8?B?QUg5TTk3MHVjeVpGS21hMUdDelFyNGdYOHpZUGxpalB1UGkvRE1qQktFZDA4?=
 =?utf-8?Q?4bKrZV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:56:26.1302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c57d10-d763-4626-3fd1-08dd82557e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
Received-SPF: permerror client-ip=2a01:111:f403:2414::624;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/23/2025 4:15 PM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
>> This series adds support for guests using the AMD vIOMMU to enable DMA
>> remapping for VFIO devices. In addition to the currently supported
>> passthrough (PT) mode, guest kernels are now able to to provide DMA
>> address translation and access permission checking to VFs attached to
>> paging domains, using the AMD v1 I/O page table format.
>>
>> These changes provide the essential emulation required to boot and
>> support regular operation for a Linux guest enabling DMA remapping e.g.
>> via kernel parameters "iommu=nopt" or "iommu.passthrough=0".
>>
>> A new amd-iommu device property "dma-remap" (default: off) is introduced
>> to control whether the feature is available. See below for a full
>> example of QEMU cmdline parameters used in testing.
>>
>> The patchset has been tested on an AMD EPYC Genoa host, with Linux 6.14
>> host and guest kernels, launching guests with up to 256 vCPUs, 512G
>> memory, and 16 CX6 VFs. Testing with IOMMU x2apic support enabled (i.e.
>> xtsup=on) requires fix:
>> https://lore.kernel.org/all/20250410064447.29583-3-sarunkod@amd.com/
>>
>> Although there is more work to do, I am sending this series as a patch
>> and not an RFC since it provides a working implementation of the
>> feature. With this basic infrastructure in place it becomes easier to
>> add/verify enhancements and new functionality. Here are some items I am
>> working to address in follow up patches:
>>
>> - Page Fault and error reporting
>> - Add QEMU tracing and tests
>> - Provide control over VA Size advertised to guests
>> - Support hotplug/unplug of devices and other advanced features
>>    (suggestions welcomed)
>>
>> Thank you,
>> Alejandro
>>
>> ---
>> Example QEMU command line:
>>
>> $QEMU \
>> -nodefaults \
>> -snapshot \
>> -no-user-config \
>> -display none \
>> -serial mon:stdio -nographic \
>> -machine q35,accel=kvm,kernel_irqchip=split \
>> -cpu host,+topoext,+x2apic,-svm,-vmx,-kvm-msi-ext-dest-id \
>> -smp 32 \
>> -m 128G \
>> -kernel $KERNEL \
>> -initrd $INITRD \
>> -append "console=tty0 console=ttyS0 root=/dev/mapper/ol-root ro 
>> rd.lvm.lv=ol/root rd.lvm.lv=ol/swap iommu.passthrough=0" \
>> -device amd-iommu,intremap=on,xtsup=on,dma-remap=on \
>> -blockdev node- 
>> name=drive0,driver=qcow2,file.driver=file,file.filename=./OracleLinux- 
>> uefi-x86_64.qcow2 \
>> -device virtio-blk-pci,drive=drive0,id=virtio-disk0 \
>> -drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/ovmf/ 
>> OVMF_CODE.fd,readonly=on \
>> -drive if=pflash,format=raw,unit=1,file=./OVMF_VARS.fd \
>> -device vfio-pci,host=0000:a1:00.1,id=net0
>> ---
>>
>> Alejandro Jimenez (18):
>>    memory: Adjust event ranges to fit within notifier boundaries
>>    amd_iommu: Add helper function to extract the DTE
>>    amd_iommu: Add support for IOMMU notifier
>>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>>    amd_iommu: Toggle memory regions based on address translation mode
>>    amd_iommu: Set all address spaces to default translation mode on reset
>>    amd_iommu: Return an error when unable to read PTE from guest memory
>>    amd_iommu: Helper to decode size of page invalidation command
>>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>>    amd_iommu: Add a page walker to sync shadow page tables on
>>      invalidation
>>    amd_iommu: Sync shadow page tables on page invalidation
>>    amd_iommu: Add replay callback
>>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>>    amd_iommu: Toggle address translation on device table entry
>>      invalidation
>>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
>>    amd_iommu: Do not emit I/O page fault events during replay()
>>
>>   hw/i386/amd_iommu.c | 856 ++++++++++++++++++++++++++++++++++++++++----
>>   hw/i386/amd_iommu.h |  52 +++
>>   system/memory.c     |  10 +-
>>   3 files changed, 843 insertions(+), 75 deletions(-)
>>
>>
>> base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
> 
> Hi Alejandro,
> I tested the patches with FIO and VFIO (using guest's /dev/vfio/vfio)
> tests inside the guest. Everything looks good to me.
> 
> I also compared the fio performance with following parameters on a
> passthrough nvme inside the guest with 16 vcpus.
> 
> [FIO PARAMETERS]
> NVMEs     = 1
> JOBS/NVME = 16
> MODE      = RANDREAD
> IOENGINE  = LIBAIO
> IODEPTH   = 32
> BLOCKSIZE = 4K
> SIZE      = 100%
> 
>         RESULTS
> =====================
> Guest
> IOMMU          IOPS
> mode          (kilo)
> =====================
> nopt           13.7
> pt           1191.0
> --------------------
> 
> I see that nopt (emulate IOMMU) has a huge performance.
This is suppose to be "huge performance penalty", sorry about the typo
> I wonder if the DMA remapping is really useful with such performance
> penalty.
> 
> Regards
> Sairaj Kodilkar
> 


