Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AC0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFkuA-00013j-LV; Sun, 02 Nov 2025 22:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vFku8-00013Q-Ky
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:06:48 -0500
Received: from mail-westcentralusazon11013011.outbound.protection.outlook.com
 ([40.93.201.11] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vFku5-00010d-0E
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:06:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV8brtXbMqIrYyXVC6giaLl3by+uvdlxCttPLCv1PzVf9gaYlQVVVJGDhDaV8LLHDEzvqUF6aa0sUuAfWjeM5HDUDDtUvVmlPba9/i6Yyot4aUoAj4k3ZuT6SSUOlb/jA8ZGM5rR0OMOxzWMXd7xr5MYc98LyxNxneZPIoy5mPixF2oIfNrEOlHxVEuNKU19lXdf9KpWiAh5mR6wZI28fxVM911q4THoDi6J/P9NE81PvQcMs0n2eTDXh5zDp3+PkggBKhzSKfkmrf6E/i33EnibVm+Qq4xjQ0mYjx3ePNlTA9ylMdTW2MRsDS+v31FOcP+N2bczc530YBdepo6UtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFk2gA58J9mQdYqcN8sWwZQdEllsY30AHnUI1eH/UeE=;
 b=BKc0yCmX7BkILbXkLP8+Kt+c2XNoMn/5J/kMC2zEvjGUA07MFv1KeIWm+xKvP53HsPYmw5Eb7PxjfswsSKWbEjk933zGXX0mj2UdKT2VrWl0K4Hq8q4R3tPPAES0YBz0MUlhXK5u/BmBd5xYjVRt1RzhENL8joQDLvS4y8p2KyuaewIZphBHPtIigJqhAHEIY9lrch3O7c3Z5kFL/PZ0amMys2O2CU+IUhF5rgRtGnfJS0jZjC5tfP21+gx1sW6uFEXNXkJ7aHT6tvSS52Ha+5P0WlkFY2GAIytm/ldgHiCsLvCdkqxttinBGgxKWfGajya4jpPUl5HJJ9bNKaR8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFk2gA58J9mQdYqcN8sWwZQdEllsY30AHnUI1eH/UeE=;
 b=M0O11rZzREj3HffAaJ9765q6b/Hh6r6wBjdenJcDnMuqb9r2UpS7ugqzMRZ0QQ9dxhQS4l0Dlx3SjKjIGd8SaBHZCD7Myki8kP9UAmNj+h91BkiSD9lmyurN+j/x1eHIk/ZmTP7e8g5OSd1w+7aQLmJGyvXyGV2uTVFCWRDB8ng=
Received: from MW4PR04CA0058.namprd04.prod.outlook.com (2603:10b6:303:6a::33)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:01:30 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::b6) by MW4PR04CA0058.outlook.office365.com
 (2603:10b6:303:6a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 03:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 03:01:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 2 Nov
 2025 19:01:28 -0800
Received: from [10.65.97.80] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 2 Nov 2025 19:01:26 -0800
Message-ID: <1fc33dfc-ae73-4d23-a21a-a3a5ed480dd1@amd.com>
Date: Mon, 3 Nov 2025 11:01:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>,
 <imammedo@redhat.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <c35a21dd-40e5-4fa5-87c4-18ebe8ca73ca@redhat.com>
 <2d0d56d5-72e3-4ae6-b657-96522fde6149@amd.com>
 <eb1b524d-3a8c-481b-85eb-6697f5ee332b@redhat.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <eb1b524d-3a8c-481b-85eb-6697f5ee332b@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3ca11e-efff-4948-e745-08de1a8548a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eThOaGpWRWIyNktZWGRzc2pNVGJ5VHZ4U1M3Qjl6blMvenZWQUNTZzU1SUFH?=
 =?utf-8?B?ZUZIUHc0MHR6aEFRS3pwRlkvKytqczgxVVdNb3BFdUlSOEltb1ZHaFl1OHV5?=
 =?utf-8?B?SGtXOEp3Q2MyMTdMSHdraGhnT3FMdTJ5T3I3Ny9sTHJPSXpqQnZKSExUbWE4?=
 =?utf-8?B?SEx4Vm5QTXQxTWVPcmNxNXhOTllYOXBUWGlDMFNZaDJmY2pMc0ZjR25uZnlO?=
 =?utf-8?B?V2xqSTR1cUNPMHhseE5hYThNdVNBejdIR1BiYURUaitlVGhkZS9qVU9pemVC?=
 =?utf-8?B?U1dIN2ZNbE93QkRNVkQzSEJjRFJKemNwZUVXdnBhemN6WnpSU2IySzJ4Vllz?=
 =?utf-8?B?Yi94Q1grdXBkRU5yWk5xYy80TWxmSzF5eU5pVUt6MmFQeHV2UEF0UDlPeC9w?=
 =?utf-8?B?b3lwbm5qWTlZbDRGWmIzbEQvVUw5N0pyQnRlQ2g1VXA0Nll6dGxaV3YreDI5?=
 =?utf-8?B?ZkFKWUpURU9OT1BmeXRkUFY5MHJXY1VDYTdKSVRYOE1KTEJUMjZEeXZ3YTJR?=
 =?utf-8?B?eU9FZjZ3Z1Q3ZmNWSkU1THdjWlI2b3k3NE9PUzdVN0ttVllVaGNqbk5pblU4?=
 =?utf-8?B?emY3ZGt0OE5vT01QcWh0SDI4bmE4Z3RPOXV6YTNVTm9lMElmUmtWbnlUd3NG?=
 =?utf-8?B?cHNaNDZ5ZmhKUkFrSXZxb2Q4NXNkSVBDRHB1L2xJa1NyZFlIb2tDaWZ2Q0h1?=
 =?utf-8?B?NUpFaUlOamhJbEtXR0VPbWF4anlzSFlHMWtJYWNDZHNYanRIN1ZzdjJ2Zmx1?=
 =?utf-8?B?R3phZ2NzOUVINFQzdDVYSndJT1VGTjVvdHFyS0kwazRFdFluV0NUdmJNZkZB?=
 =?utf-8?B?UVM3bnR2bmcvTTl5c1pZOCtVdWc0R1dhdFNoZktKYTRvNVdKRTdaclN4b2ZG?=
 =?utf-8?B?b1dQNHl0ODl5TXBkNFZ6MXpzdWcwWmVzNE0zV0xCcmYyb3EwVjEvTG5QMnJQ?=
 =?utf-8?B?enRBeEdPV1dRSllOSmpUbEcwb013NGlQdTlVTldyVDRpNjBBeDNxZkxPVm8z?=
 =?utf-8?B?U1kwckQ4aTdPUmI1VjJsa3V6QzIzVk9qWTBUaURuQlA3aXJ2SmEzS085WjAr?=
 =?utf-8?B?dkxCTmt0TS9RSWxPUkZJZUx0a1VYWVIvRi96eXFPeFZUUGZFMCsrcVhMNzBI?=
 =?utf-8?B?NkhaS3NDYzFvWmZDTGxTeEJBR2RZdE0yTmNCQ3IyNUFISEFLMEFmZDh3M2Nu?=
 =?utf-8?B?UVZ0bkNwT213dFY4VkJERzlLQmEvUzhLcGtwcXh6RFdSMVQrVVk1QmpGUEMr?=
 =?utf-8?B?dmdzM3BMcXRrNzFhT3RvWG9aU29iNkt5bm8rWDN3c3dhakxqV0ZoamhtblFB?=
 =?utf-8?B?aStidHJpRWZVMVl2OW9JQ01YOXJaNEZ4NU1RVWhLbytZYjlKSDFCQmZMK0pX?=
 =?utf-8?B?VHZobXExQWdMa01jRmFxSkJDWFA0cWl6ODhWQjE5Nng3bWEycHZXRGFzOW5h?=
 =?utf-8?B?dklyaTYzaXAvaVRZbCt3MEZZV3FjSFViRHZPQjB6Q2lFeUx2d2FsZ3Fzem9J?=
 =?utf-8?B?UGVsLzk1QXd2TGVoMlkwQldVZVdGL3RDUU1JaCtha0VFRzRMUW9JaHlsLzdZ?=
 =?utf-8?B?Vi9HVkp0QzZPd3hiaUFBcUNWU2VFU0NZWlB3UVhLTXRTWG9YU1hJUFE0OFNz?=
 =?utf-8?B?RkhyVGlpY0dWRnRYTFVDd1AzUHJGdi9Bb3JIQzFOMmtqbkhlQmVRYlMxNC94?=
 =?utf-8?B?QjJlbVpNTTFxenFqQmNTaldlS0IyM0J6S2tJR1RtVlZaV3hHU2JNYmRWdEVw?=
 =?utf-8?B?MExnMjcwUmI0NU5ORHhPajY1NjNTOFJRVi9Td1Ntb0xjazNmeENNVlpSL1lS?=
 =?utf-8?B?TGRsSlhHNmIycUlERE1JTXFqZWhnWmtDbytQN2tKZ0RlSldsTHFJdEJXam05?=
 =?utf-8?B?K0xrZmxTY0E0cUpBVndtR2srd09QcVJYZ20vY0lsaEx5TnhPSEZLRmhtaDdB?=
 =?utf-8?B?TXJ0YlBCZS9MeGZCQ3Z5M1hqbStOY3A4aERkR2ptWGJ6TUdmTHkyRi83ZGpj?=
 =?utf-8?B?WGdLMnAwWmFxTUxDOFVvcGl5NXlHTlI3enFHZ00xUjdmZjVaaWIzSkJ4SjV4?=
 =?utf-8?B?amhHRENySzNLa3VMSm9CVUNtVjhLUk5uYmNkVXJYRi8wUzVCM0tnSFo0eno5?=
 =?utf-8?Q?mQ2M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:01:28.3459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ca11e-efff-4948-e745-08de1a8548a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
Received-SPF: permerror client-ip=40.93.201.11;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi David,

I hope this email finds you well. I wanted to follow up on the SPM
patch series we discussed back in October.

I'm reaching out to check on the current status and see if there's
anything else I should address or any additional information I can
provide.

Thank you for your time and guidance on this!

Best regards,
Jerry Huang

On 10/22/2025 6:28 PM, David Hildenbrand wrote:
> On 22.10.25 12:09, Huang, FangSheng (Jerry) wrote:
>>
>>
>> On 10/21/2025 4:10 AM, David Hildenbrand wrote:
>>> On 20.10.25 11:07, fanhuang wrote:
>>>> Hi David and Igor,
>>>>
>>>> I apologize for the delayed response. Thank you very much for your
>>>> thoughtful
>>>> questions and feedback on the SPM patch series.
>>>>
>>>> Before addressing your questions, I'd like to briefly mention what the
>>>> new
>>>> QEMU patch series additionally resolves:
>>>>
>>>> 1. **Corrected SPM terminology**: Fixed the description error from the
>>>> previous
>>>>      version. The correct acronym is "Specific Purpose Memory" (not
>>>> "special
>>>>      purpose memory" as previously stated).
>>>>
>>>> 2. **Fixed overlapping E820 entries**: Updated the implementation to
>>>> properly
>>>>      handle overlapping E820 RAM entries before adding 
>>>> E820_SOFT_RESERVED
>>>>      regions.
>>>>
>>>>      The previous implementation created overlapping E820 entries by
>>>> first adding
>>>>      a large E820_RAM entry covering the entire above-4GB memory range,
>>>> then
>>>>      adding E820_SOFT_RESERVED entries for SPM regions that overlapped
>>>> with the
>>>>      RAM entry. This violated the E820 specification and caused 
>>>> OVMF/UEFI
>>>>      firmware to receive conflicting memory type information for the 
>>>> same
>>>>      physical addresses.
>>>>
>>>>      The new implementation processes SPM regions first to identify
>>>> reserved
>>>>      areas, then adds RAM entries around the SPM regions, generating a
>>>> clean,
>>>>      non-overlapping E820 map.
>>>>
>>>> Now, regarding your questions:
>>>>
>>>> ========================================================================
>>>> Why SPM Must Be Boot Memory
>>>> ========================================================================
>>>>
>>>> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
>>>>
>>>> The primary goal of SPM is to ensure that memory is managed by guest
>>>> device drivers, not the guest OS. This requires boot-time discovery
>>>> for three key reasons:
>>>>
>>>> 1. SPM regions must appear in the E820 memory map as 
>>>> `E820_SOFT_RESERVED`
>>>>      during firmware initialization, before the OS starts.
>>>>
>>>> 2. Hotplug memory is integrated into kernel memory management, making
>>>>      it unavailable for device-specific use.
>>>>
>>>> ========================================================================
>>>> Detailed Use Case
>>>> ========================================================================
>>>>
>>>> **Background**
>>>> Unified Address Space for CPU and GPU:
>>>>
>>>> Modern heterogeneous computing architectures implement a coherent and
>>>> unified address space shared between CPUs and GPUs. Unlike traditional
>>>> discrete GPU designs with dedicated frame buffer, these accelerators
>>>> connect CPU and GPU through high-speed interconnects (e.g., XGMI):
>>>>
>>>> - **HBM (High Bandwidth Memory)**: Physically attached to each GPU,
>>>>     reported to the OS as driver-managed system memory
>>>>
>>>> - **XGMI (eXternal Global Memory Interconnect, aka. Infinity Fabric)**:
>>>>     Maintains data coherence between CPU and GPU, enabling direct CPU
>>>>     access to GPU HBM without data copying
>>>>
>>>> In this architecture, GPU HBM is reported as system memory to the OS,
>>>> but it needs to be managed exclusively by the GPU driver rather than
>>>> the general OS memory allocator. This driver-managed memory provides
>>>> optimal performance for GPU workloads while enabling coherent CPU-GPU
>>>> data sharing through the XGMI. This is where SPM (Specific Purpose
>>>> Memory) becomes essential.
>>>>
>>>> **Virtualization Scenario**
>>>>
>>>> In virtualization, hypervisor need to expose this memory topology to
>>>> guest VMs while maintaining the same driver-managed vs OS-managed
>>>> distinction.
>>>
>>> Just wondering, could device hotplug in that model ever work? I guess we
>>> wouldn't expose the memory at all in e820 (after all, it gets hotplugged
>>> later) and instead the device driver in the guest would have to
>>> detect+hotplug that memoory.
>>>
>>> But that sounds weird, because the device driver in the VM shouldn't do
>>> something virt specific.
>>>
>>> Which raises the question: how is device hoplug of such gpus handled on
>>> bare metal? Or does it simply not work? :)
>>>
>> Hi David, Thank you for your thoughtful feedback.
>> To directly answer your question:
>> in our use case, GPU device hotplug does NOT work on bare metal,
>> and this is by design.
> 
> Cool, thanks for clarifying!
> 


