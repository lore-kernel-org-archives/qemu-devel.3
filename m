Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5B6CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVsK-0001IP-8K; Wed, 22 Oct 2025 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vBVsF-0001AS-1Z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:15:20 -0400
Received: from mail-southcentralusazon11013061.outbound.protection.outlook.com
 ([40.93.196.61] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vBVs8-0000cj-Ky
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtzPntmvHw6LZr5k4kL21YXTCJMubuY/KZzvik2755WCpHYqhttCk/XCLLi7KIc9/vPLRUkRwbuuUBmXJJxDkHwKP+Xsv5Pj0/tBdeKHdqCu3tA8ExORKtn4Q0Fyj4kgQM5qd4IK/4/Kte/aOvp/zuu0nUW5FgO0YKCO9kpFrjft3IQesP8+Q8ae8FzhZ5FHC0oqrgHLaUTdeM/gP6YMkYKlsgHG+UxUXDYU8rMSuVdk1EIOd3v0pjbL7NVR4Yy3SQtDxOZaM+KisOnuXwv/cL4hoEM43hEyVjlyNbaPp/9XSmdFPN6bUe4ql5GtDeqPJkeTvmfsmiyO/dcGBKW11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BDGEpRxqD71Ui+BUfiMgYrdaPp1pdtUJBiq0gzuLGw=;
 b=GIR93B3Ctk4Ah7t8dmCa7lweE8cWEY8YGns2c8hcXvRgMKVK5Hj1YXSCeESFj3mXAHOXQ0HOaZV+Tkg9esDO2Xw1yghRqtyvdvWscZn7K80To+oAI50L60kkDK+k3kPSLYjoPBRUucpsUTC6OyxioqEamkY3JxU2rfTOCDQpDudTAgk10y+yrc/Wp17UA/EqIi0dqJSNLfxk+TwWaOpXRRrpnoRXn19haRUc/Kqqz0FBzlkkft9e1nHBmpFAkxHdTQA5ckFmnWhU6Kf+v1xMhECMvm/Q6lSMPbM2do4pWYEBYAoerA9g5jUOriqM76JzxO5nc3Mvt67aGiRt4uKfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BDGEpRxqD71Ui+BUfiMgYrdaPp1pdtUJBiq0gzuLGw=;
 b=O3kN/07FWnSYR1qkL/lzQZ3IdDXVeY/aTbZm60toJWF6qOF0NSqWzzIXyciLeFo53cj4lV/4+z9DmplLAP4a4pbW1fCsWqglx32Fld1D+5gmlCSr9iUOtFahjGCx/pAg7YY6E++O/EuM1qDW+5FHNUHxDw35//6W1NJpRR3XJQ4=
Received: from DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) by SJ2PR12MB8134.namprd12.prod.outlook.com
 (2603:10b6:a03:4fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:10:03 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:2c:400:0:1002:0:9) by DS2PEPF00004553.outlook.office365.com
 (2603:10b6:f:fc00::51b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.4 via Frontend Transport; Wed,
 22 Oct 2025 10:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 10:10:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 03:10:02 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 05:10:02 -0500
Received: from [10.254.202.150] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 03:10:00 -0700
Message-ID: <2d0d56d5-72e3-4ae6-b657-96522fde6149@amd.com>
Date: Wed, 22 Oct 2025 18:09:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>,
 <imammedo@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <c35a21dd-40e5-4fa5-87c4-18ebe8ca73ca@redhat.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <c35a21dd-40e5-4fa5-87c4-18ebe8ca73ca@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: dc819910-1985-4cb1-5b80-08de11532b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vkt0Y0JNQlB6UUVnUDJiajNwa2VWYU1ab0lWQlFnUDdvOU1oZkNrMm9RU1VV?=
 =?utf-8?B?alR5QVVuMWZEZ3huYlVXcHF0VjFaWnJoU0ZoOVJwSUl4RGk4ZERUajE5bUsy?=
 =?utf-8?B?ODhuZmZzM2sxUzkzTXpzMlZNRFJVbzlqc0tCaGdyMkMwZ2VZUENsUWlyRmJH?=
 =?utf-8?B?SmYyR2JDN2l5dG42TnZLeXhUZ1M3OXFMYXEvRmVYM3BydkxLRFA2TVFOMDEy?=
 =?utf-8?B?KzBHQnRCcVlJMHhUbGo3cThBQnBRZkxJZXp4ZkhZRGN0YTNwZmYzYytQYjRQ?=
 =?utf-8?B?RXJjUmhMZFhreVlwNjJpbG8rbTYrM0lXeEh5Myt5VDJhZ3VieDZrVXhlQ0t4?=
 =?utf-8?B?cXFyek9EbEc1MWovd0tnZkJ6TXhvOGNHWTZYMmwxZzM4V2lrMkdmY1h1NVN6?=
 =?utf-8?B?Ym5yUncxS1ZHZnYzdzE1cm9DeFZLS2laRmJIR3dJQ0dsMWY1QVZyeWV6Vk5D?=
 =?utf-8?B?U2xEZ21ROVlVaHlMQk5MMFBrTGJUNTBDVGFGenZuNlFUVUhGOEd5VXRzVjdm?=
 =?utf-8?B?SVhJKzN5c0YranI4NGxTeUlBMmM4ZndrcHAxeXZMeG5GQjhlMG01WUJXNGRj?=
 =?utf-8?B?b0tpTEs5azYxaUNvRVVrOWVLejA0VTczUE1FeTJzQ0lFVGFQS3VQKzR2Sjhi?=
 =?utf-8?B?QTVjSlIzc0JwdWZDZVAvdFE2Qk1Ecm53cVVXRDNzN2FCVSsyQ3I3Ymx2Tm0w?=
 =?utf-8?B?WlA5QXVCZG1WcEJyTkpYN3ZkVUFCWmhBbFkrNWNuVE5PbHJwV3hvTWozQ3lU?=
 =?utf-8?B?TjJaQUtPb1cyeTNkdmFPRWNOOVQzRW1jUXlZeGs4WXhxRzlXaTlwdnpwYkpK?=
 =?utf-8?B?TWtqMHhuVFlqMHFySzNNdUhQRUJ3Q2xGdTVuQzAvdyt1V1hSMG9mb3BNMVJq?=
 =?utf-8?B?NTdKVmloS2U3ZThJb0JlSm92Y3hmVGhiazV1NXBuMGNEL09WWTBuV2dyR2hn?=
 =?utf-8?B?UGhCUjRTRGpwZDZISUlha212OTRQTm9KYnphK2VHeDBnbTFhVTZYallHQVI4?=
 =?utf-8?B?S3RLYk1iYU9yNUxscWdlWkptLzRiMElHdlZlNkNXSmlMeU1zZTUxd1pISE93?=
 =?utf-8?B?R29YeXhWTnBtc2N2SUVHYjdVN0p0MlNpb1NVUUxMc2J2T1dEcEVwNVhmclYv?=
 =?utf-8?B?dnh6TjZrcXhzNDUxeHRwUEtGdkdabVBIa2dqcXJySUNVWGRJMkxLdGtZVW9z?=
 =?utf-8?B?S3htWWJLaFNaVU1WSyt4NlFMWFlsNkQvNnhaNnRweTJRaS82MGF2Y0lRWVYy?=
 =?utf-8?B?VWpzTXkvaWJjYUFqRlFVb3FNNVZySnBjSXpyN1MrM3FrQUgweElXSFltb0NY?=
 =?utf-8?B?S1d2NlRzbDBOaGVLUnRReHM3bXR1TVZwUkVKN2tWZkdwKzFDVFZ0NEVXRUJD?=
 =?utf-8?B?M2FVNm8wRmdndER3M256NmNXQ1ZZRXFzanVjUEZORjhCNGNEZjhDd3UvR2Fr?=
 =?utf-8?B?TmhkSDlYdW8vYU95L3ZKMzlJUFRQWGFwZ2VFSWl6Q25FRE5PQW1NZjR0UW5D?=
 =?utf-8?B?Um1SWnhsQklJWFp5blJjeVZMckhZaHQ3NHJFUjdSZUJEcVdWWlJNc042QStj?=
 =?utf-8?B?YWNDdW0wWm9TQkNTYjgwdFV3Tk5JbUdrOGFNeDlRS3RpVzVCRzVQSVpHN0JC?=
 =?utf-8?B?dTRhQXhJTTQ4ZjhGR1ViZCsrTVZ3R1lReTJHMVIvVnhJeWtoMW40QnBmam90?=
 =?utf-8?B?RVdJYXBBdDlHbUdyVVVNZ0hQUUo5dFdZWkVNdFh2TnBQcnpiTk5lSmZOODcw?=
 =?utf-8?B?TEpKME8zTURmakd4d3UxVTNBUnRpVXRaRzhDbmN3Mi9pMDRFTTFsOXBObGVa?=
 =?utf-8?B?NUpocE5kWXRubEdPMHJpR2FKL3JrRFNzQVN6VkdKMVdRbHB0Y2xtVTlDdnQ4?=
 =?utf-8?B?TXN1RGxaTmVrWTRPb2xQUmw1K3lsbDVQNmR1OVgzbi9OQXVVTHFYWGZxRitP?=
 =?utf-8?B?TDlWWjFRT0VERitxaDVDK2lXaXZWOTJYd2VPa0NBcDk5N1JsYWNWeVMwcFd6?=
 =?utf-8?B?UWVHK1BLclJqa0Y1VGdTa2hvMDRKbFdzMFAvS0w0WWplTnUrQmlYSXFtV0pE?=
 =?utf-8?B?SWE1VWZsNkF1bjNIb1dMckhvSzEzOVR6aUt3b1pxSzBjYzVsUVFuWFJyZlZm?=
 =?utf-8?Q?XxhM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 10:10:03.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc819910-1985-4cb1-5b80-08de11532b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
Received-SPF: permerror client-ip=40.93.196.61;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 10/21/2025 4:10 AM, David Hildenbrand wrote:
> On 20.10.25 11:07, fanhuang wrote:
>> Hi David and Igor,
>>
>> I apologize for the delayed response. Thank you very much for your 
>> thoughtful
>> questions and feedback on the SPM patch series.
>>
>> Before addressing your questions, I'd like to briefly mention what the 
>> new
>> QEMU patch series additionally resolves:
>>
>> 1. **Corrected SPM terminology**: Fixed the description error from the 
>> previous
>>     version. The correct acronym is "Specific Purpose Memory" (not 
>> "special
>>     purpose memory" as previously stated).
>>
>> 2. **Fixed overlapping E820 entries**: Updated the implementation to 
>> properly
>>     handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
>>     regions.
>>
>>     The previous implementation created overlapping E820 entries by 
>> first adding
>>     a large E820_RAM entry covering the entire above-4GB memory range, 
>> then
>>     adding E820_SOFT_RESERVED entries for SPM regions that overlapped 
>> with the
>>     RAM entry. This violated the E820 specification and caused OVMF/UEFI
>>     firmware to receive conflicting memory type information for the same
>>     physical addresses.
>>
>>     The new implementation processes SPM regions first to identify 
>> reserved
>>     areas, then adds RAM entries around the SPM regions, generating a 
>> clean,
>>     non-overlapping E820 map.
>>
>> Now, regarding your questions:
>>
>> ========================================================================
>> Why SPM Must Be Boot Memory
>> ========================================================================
>>
>> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
>>
>> The primary goal of SPM is to ensure that memory is managed by guest
>> device drivers, not the guest OS. This requires boot-time discovery
>> for three key reasons:
>>
>> 1. SPM regions must appear in the E820 memory map as `E820_SOFT_RESERVED`
>>     during firmware initialization, before the OS starts.
>>
>> 2. Hotplug memory is integrated into kernel memory management, making
>>     it unavailable for device-specific use.
>>
>> ========================================================================
>> Detailed Use Case
>> ========================================================================
>>
>> **Background**
>> Unified Address Space for CPU and GPU:
>>
>> Modern heterogeneous computing architectures implement a coherent and
>> unified address space shared between CPUs and GPUs. Unlike traditional
>> discrete GPU designs with dedicated frame buffer, these accelerators
>> connect CPU and GPU through high-speed interconnects (e.g., XGMI):
>>
>> - **HBM (High Bandwidth Memory)**: Physically attached to each GPU,
>>    reported to the OS as driver-managed system memory
>>
>> - **XGMI (eXternal Global Memory Interconnect, aka. Infinity Fabric)**:
>>    Maintains data coherence between CPU and GPU, enabling direct CPU
>>    access to GPU HBM without data copying
>>
>> In this architecture, GPU HBM is reported as system memory to the OS,
>> but it needs to be managed exclusively by the GPU driver rather than
>> the general OS memory allocator. This driver-managed memory provides
>> optimal performance for GPU workloads while enabling coherent CPU-GPU
>> data sharing through the XGMI. This is where SPM (Specific Purpose
>> Memory) becomes essential.
>>
>> **Virtualization Scenario**
>>
>> In virtualization, hypervisor need to expose this memory topology to
>> guest VMs while maintaining the same driver-managed vs OS-managed
>> distinction.
> 
> Just wondering, could device hotplug in that model ever work? I guess we 
> wouldn't expose the memory at all in e820 (after all, it gets hotplugged 
> later) and instead the device driver in the guest would have to 
> detect+hotplug that memoory.
> 
> But that sounds weird, because the device driver in the VM shouldn't do 
> something virt specific.
> 
> Which raises the question: how is device hoplug of such gpus handled on 
> bare metal? Or does it simply not work? :)
> 
Hi David, Thank you for your thoughtful feedback.
To directly answer your question:
in our use case, GPU device hotplug does NOT work on bare metal,
and this is by design.

HBM as Boot Memory:
- HBM (High Bandwidth Memory) is physically attached to each GPU.
- This memory is exposed via ACPI during firmware initialization.
- GPU drivers discover HBM regions by parsing these ACPI tables.

