Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523EEE8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ283-0007PR-OW; Fri, 26 Dec 2025 02:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vZ282-0007Mc-AA
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:20:50 -0500
Received: from mail-centralusazon11011033.outbound.protection.outlook.com
 ([52.101.62.33] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vZ27y-0006Cj-Ly
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAH/0ZQgkpwE3cTSC1iENQMrNoFtkGgEeErLIOwrumkySDTbb54RBk4kupmKwx/f3J00FuiPoUm4r0sReZzk2p00dk/ZjgBeSgI0obAo4ges6FblYwuPJyaczOS8p7OHjduZ9OGnbJxxdDhTwYuhW6hdgXNb1MKQ9pfcAq/eJGmSJtSXftEK5ybXCaQA7CTr5G74iN5o4Wzxk/yPzuSKCFVMAhSGse/mEnUmrVWyMzQLDU28nS5rAgbN7OZCxAxTx64bqyN99oHotlVQRxZn46jscMcBrPj0vVLBEfn0omp0lQhkSDjYQnaxASP1h7UoxPZPf5rSLND+hEpqvMEwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJI3PcQpuFwbgWIRZvjsBO9qALQhlsygtqWDvEDkn4k=;
 b=f065NxdTiiuBT9WmANg1Bnq3bb7VJmVqHsr6HOuS/lZreGKKj6tnPApPChUTXhJEFMNZ6ZJrZl4V1ZNDRd9JarSADhQG7Z53ee4dG/lxdkqvNnSzWSuT+CGvShHJ1Oxe93yF4/RsY9zajAl2YwPveAvaFMB6CbBy02jnCU4wC+xwPKVGPNE9vMc7L4fs3V/rnJABMNRzGqRlTWheWe/JrCyg0D3bh7wUgKUTQqBmwi7IR/sP8+IjeB+20Qy7k7E76tNbDBuuasUx/OJ32y7OTqVDTCsz2SSCRgs9pC/FODjWP6u8X4mjvfB7bD0vWyKawksUNITUz0Prbg+pkAXFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJI3PcQpuFwbgWIRZvjsBO9qALQhlsygtqWDvEDkn4k=;
 b=rDoL3iEDFaXdV4IauGimLAY9nPvtKi8MGm9CyqJ340fs8hok8ZP89yiEQUYc991NCuxDInjUH07thB7on95ajSddPpHqqPRH0CKxruMjB9EpjgmDK7dVHMO/eKbJlvWFDAID6qsQSm8fJHWVY2BZ/zU+FV3E+1LtJM5hr/sSTzE=
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 07:15:39 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::b9) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Fri,
 26 Dec 2025 07:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Fri, 26 Dec 2025 07:15:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Dec
 2025 01:15:33 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Dec
 2025 01:15:32 -0600
Received: from [10.65.97.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Dec 2025 23:15:30 -0800
Message-ID: <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
Date: Fri, 26 Dec 2025 15:15:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, Alistair Popple <apopple@nvidia.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>,
 <dan.j.williams@intel.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
 <20251223095605.0000065d@huawei.com>
 <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 415458fa-0fb1-4785-cb31-08de444e9238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MklQd25qa21LRUp3U2wrdE5Hb2s4QmRZUE4xWk94VU1aMHltbzh2N2MxQ0Nn?=
 =?utf-8?B?S2xOaktNaUtmaWFEWDR5VjN0ZXZQNXg5TTY0TWRNSUZFQTRNSUFlU3Rxb1RY?=
 =?utf-8?B?SS9uTUViQ2pUSnlOazUySkdpZnl2MmRZV09HT1BXVTkzVjFIcGcvanFhYTl6?=
 =?utf-8?B?NnA4RXF6OFJ2TUN4VXczRnY2TkhlSytOUi9mbWgyYzBhT1kzMXp0TmlWY1Mr?=
 =?utf-8?B?ZlNQVVlYSFJBZWV6bXJGY2ROMHZiNWhuNW9YMjA5TDh6M3VXUUVKV3gzeFFW?=
 =?utf-8?B?S01OL3E5UTY2dW8yVmxZTFdYVTQ4WnphdHloSjZFU2hXL08ralVmRDJSbVVq?=
 =?utf-8?B?NndNMDIxS24zQytnUkswUDRBMzlSZXJUTWNSN2poUkwvZFBQMkdUdlJkN05B?=
 =?utf-8?B?bGNXK2NtQnlUNVd1UFA2dThvbW1rY21mMnBkOHlub0s0d1d6NzdrSDJkTmxO?=
 =?utf-8?B?Q1JQV25tYmErWThYdkRkTU9YYmUzemR4MUJkaTZaOGtkUWlQYzA1ZURkaWtP?=
 =?utf-8?B?a3I1YWdGQ1BicWdIS2kxVEE0djFWdkg4U2trVDJsNndsVTZMTktFdE1Lam9Z?=
 =?utf-8?B?bWtNYUFvUlF3dFRneEtVN1lKKzdxRi9HTGNQeG5LL1JSUEw1SEdOZ29wQXpl?=
 =?utf-8?B?Uk8ybXZRUTZSK0hRUkpuWitnc3RYNGhQbHpVcUVyL284MnQwb0Y4TGRQL2Iy?=
 =?utf-8?B?NVBDZmY5d2hNN2pRd3JWZEtkQTdHd1FwZ1YzWk0rbWdzMGtJR1Y2KzUwTjRO?=
 =?utf-8?B?OEF5aXdOcUhEbFhlVy9WTGdJd0JLVW13aWNSTGRLdUlMS1FCZSsrd05zMVow?=
 =?utf-8?B?dE1VZENBRm1HT01JUDQ5eHY1MjJleDB2ajZoUE5RQTRIcnNjMlc4K2dqNEh2?=
 =?utf-8?B?bm8zTHN0R0VUWE14enAzbE40Q3hkcnhuRjFqUDEzVERPYlhDVUUvWmZJdEpH?=
 =?utf-8?B?ZWNoNGNYVGs0bUc3YzExcklWbXQyNFJPZTJSajlYejZvblN3bGd1dnFMZXlV?=
 =?utf-8?B?bHFzODlmbThWWUdVa2xMTlBCMVlOS2MxdjlkR3RzM3ZEdTIzYWNLRnlvSGh6?=
 =?utf-8?B?RjhGU3gvWXFOdmVOaFZDRjJKcnAwZHJKMU5YVlRxWVFObWpvRGRYTEdzb2tN?=
 =?utf-8?B?TkZjSjdBcnZMOTdCcXo2MEt3ZnlwR2tjY2FhaVlWdGZEUjA0QUZkdFZzNXBa?=
 =?utf-8?B?ajdjSFBaLzVpWDE4QmtMVVpiU0V2ZVNGMy9nVkRLQStRa1JEUmI5UTgvZGEx?=
 =?utf-8?B?Q011SGJuVWdkVmRqVGxCVzI3RVFHdWpDUy9GN3JzUDMzZ3lsdmQ3YnRXcFRu?=
 =?utf-8?B?TXNmdXAwczJoMjFyZ0hoNFRxSFFuU1JJR1lwSng0RzZTcW05OXRMb1JQUlBB?=
 =?utf-8?B?UDBldzBYSkRRTTNNOW5kZDFDVHZVbWFJNmRyck16RTJuM2tjbFlDY2hLUmJy?=
 =?utf-8?B?ZHpIRUdGei8zOFVjenF3bG80Z3BVajloTFg3djF3OGJSQ3ByNy9IMlYwOXJj?=
 =?utf-8?B?NXJOSlRxQXNuV2QybWM3aUg3QnZEbld5QlduOVFPdVc5Y01lZ1B1enhjc29q?=
 =?utf-8?B?UkJoOUQ5Nkx4RHdVdkZaVDBGZ0RUY09FOHdZV2NJVGpvQkhjNytQSVJMSnZO?=
 =?utf-8?B?Z1hpL0lGclU3OCtRMjhtL3FDc1J0cGdPM1N0NGpwVWVaUGVndlV2ZUxsdFEw?=
 =?utf-8?B?NVhPdFpoT0FhL2xoUm04eTNYM0YrK3ZOUnVWMHpXOGQvRkp4ODdqQSs4aUcx?=
 =?utf-8?B?RFIyaWhqUUVSQXFVai95bEF3RVNGdGFwWUhtMmhjWUtXa0xHbXlGSWpFaXhF?=
 =?utf-8?B?cEpQRGFjaVR5ZUJzSDBVNHowMHEzbmJZQjEwOWdnNlBjdVkwcmRmb3FGQ29H?=
 =?utf-8?B?dHhxWUV0Y2cwQ3gybE5vWW9YQkdWT2FJVCtRZEZnc0pVUElSV0xUbVh6SXNk?=
 =?utf-8?B?L2lNb0xPMGtHM2pPLzZtNW9qa1ZRUEMvWjNzMHVFM1AzY0dPRXF1T0RJRWt0?=
 =?utf-8?B?dXBIUU41YTRKbzFNWG0rRTFpcS9UUXR2WTMxUDMwN2xvZ3UwQjJ2N0ZFVC9q?=
 =?utf-8?B?OXl1dm5LK1BXNzVXcjN2WG5FQWxSMlFPN24vWmZQYzVtNC82YWtoMkhzZ0RF?=
 =?utf-8?Q?dmW0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 07:15:38.4098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415458fa-0fb1-4785-cb31-08de444e9238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
Received-SPF: permerror client-ip=52.101.62.33;
 envelope-from=FangSheng.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Hi Jonathan, David,

Thanks for the review and for pointing out the LPC discussion!

On 12/23/2025 6:01 PM, David Hildenbrand (Red Hat) wrote:
> On 12/23/25 10:56, Jonathan Cameron via wrote:
>> On Tue, 9 Dec 2025 17:38:41 +0800
>> fanhuang <FangSheng.Huang@amd.com> wrote:
>>
>>> This patch adds support for Specific Purpose Memory (SPM) through the
>>> NUMA node configuration. When 'spm=on' is specified for a NUMA node,
>>> the memory region will be reported to the guest as soft reserved,
>>> allowing device drivers to manage it separately from normal system RAM.
>>>
>>> Note: This option is only supported on x86 platforms. Using spm=on
>>> on non-x86 machines will result in an error.
>>>
>>> Usage:
>>>    -numa node,nodeid=0,memdev=m1,spm=on
>>>
>>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
>>
>> Given the discussions at LPC around how to present GPU/HBM memory and
>> suggestions that reserved might be a better choice. I wonder if this
>> patch should provide that option as well?  Or maybe as a potential follow
>> up. The fun their is that you also need to arrange for DSDT entries to
>> tie the region to the driver that actually wants it.
>>
>> Anyhow that session reminded me of what SPM was designed for
>> (you don't want to know how long it took to come up with the name)
>> and it is a little more subtle than the description in here suggests.
>>
>> The x86 specific code looks fine to me but I'm more or less totally
>> unfamiliar with that, so need review from others.
>>
>> +CC a few folk from that discussion. I wasn't there in person and
>> it sounded like the discussion moved to the hallway so it may
>> have come to a totally different conclusion!
>>
>> https://lpc.events/event/19/contributions/2064/ has links to slides
>> and youtube video.
>>

I watched the slides.  Actually we've been experimenting with
a combined approach: SBIOS
reports HBM as SPM, then driver dynamically partitions and hot-plugs it as
driver-managed memory to NUMA nodes. So SPM and driver-managed are
complementary rather than mutually exclusive. This patch focuses on the
first part - enabling QEMU to report memory as SPM to the guest.

For the `reserved` option - agree it could be a potential follow-up, though
it needs more investigation. For now, let's focus on SPM and soft reserved.

>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 907cb25f75..cbb19da35c 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -500,6 +500,12 @@
>>>   # @memdev: memory backend object.  If specified for one node, it must
>>>   #     be specified for all nodes.
>>>   #
>>> +# @spm: if true, mark the memory region of this node as Specific
>>> +#     Purpose Memory (SPM).  The memory will be reported to the
>>> +#     guest as soft reserved, allowing device drivers to manage it
>>> +#     separately from normal system RAM.  Currently only supported
>>> +#     on x86.  (default: false, since 10.0)
>>
>> As below. This needs to say something about letting the guest know
>> that it might want to let a driver manage it separately from normal
>> system RAM.
>>
>>> +#
>>>   # @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145, points
>>>   #     to the nodeid which has the memory controller responsible for
>>>   #     this NUMA node.  This field provides additional information as
>>> @@ -514,6 +520,7 @@
>>>      '*cpus':   ['uint16'],
>>>      '*mem':    'size',
>>>      '*memdev': 'str',
>>> +   '*spm':    'bool',
>>>      '*initiator': 'uint16' }}
>>>   ##
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index fca2b7bc74..ffcd1f47cf 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -431,7 +431,7 @@ ERST
>>>   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>>       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=node]\n"
>>> -    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=node]\n"
>>> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=node][,spm=on|off]\n"
>>>       "-numa dist,src=source,dst=destination,val=distance\n"
>>>       "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>>>       "-numa hmat-lb,initiator=node,target=node,hierarchy=memory| 
>>> first-level|second-level|third-level,data-type=access-latency|read- 
>>> latency|write-latency[,latency=lat][,bandwidth=bw]\n"
>>> @@ -440,7 +440,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>>   SRST
>>>   ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=initiator]``
>>>     \
>>> -``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=initiator]``
>>> +``-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node] 
>>> [,initiator=initiator][,spm=on|off]``
>>>     \
>>>   ``-numa dist,src=source,dst=destination,val=distance``
>>>     \
>>> @@ -508,6 +508,13 @@ SRST
>>>       largest bandwidth) to this NUMA node. Note that this option can be
>>>       set only when the machine property 'hmat' is set to 'on'.
>>> +    '\ ``spm``\ ' option marks the memory region of this NUMA node as
>>> +    Specific Purpose Memory (SPM). When enabled, the memory will be
>>> +    reported to the guest as soft reserved, allowing device drivers to
>>> +    manage it separately from normal system RAM. This is useful for
>>> +    device-specific memory that should not be used as general purpose
>>> +    memory. This option is only supported on x86 platforms.
>>
>> This wants tweaking.  As came up at the LPC discussion, SPM is for
>> memory that 'might' be used as general purpose memory if the policy of 
>> the
>> guest is to do so - as Alistair pointed out at LPC, people don't actually
>> do that very often, but none the less that's why this type exists. It is
>> a strong hint to the guest that it needs to apply a policy choice to
>> what happens to this memory.

Got it. To clarify - this patch only handles the "reporting" part, just
like how SBIOS reports HBM as SPM on real hardware. The guest kernel
then decides how to use this memory based on its own policy (kernel config,
boot parameters, etc.). Will update the docs to describe SPM as a
policy hint rather than a definitive restriction.

> 
> Just curious, it's the same on real hardware, right?
> 

Hi David, could you clarify what you're asking about? Whether the SPM
semantics are the same, or whether this QEMU implementation matches real
hardware behavior?

Best Regards,
Jerry Huang

