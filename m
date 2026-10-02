Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737E0CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgK1-000781-7C; Fri, 02 Oct 2026 12:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xCgJy-00077X-I4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:41:18 -0400
Received: from mail-southcentralusazon11011056.outbound.protection.outlook.com
 ([40.93.194.56] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xCgJw-0007cM-O2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qo52sPeEdQeww2wmaZ5h4R52jQ8Im9+lpGOItJJA33IN9GxmaopH3ciNHYdqiOeeeR1rIuzinmJl/390mTpmlVi8+SgFQVHOcQwHNXiwx1bj0xKagGKT3T8eOj41zEeRk2IoaOIxWosTHTjdYrxN445HM4zlHjTsRoRIkCD/rYB2S+N08D5ThPU0OCIXK4tIMyMS3ExVCZPCqI2NHAEJ45L0GP4OQkIteECW6liAcO3ykNQLdlYU2NKF8aJnQ2MGWmSHVUsUed4/mG5wOs+FSiAN/g8p6rc2wnziJZp5nAoMQJ7zqiyuPRJLtHXIuhdGSMzNEehOWUuhMXkS1rEwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaqhQBor53sLaIM/AWWplJ8ePjWUqUrg7RBVIQiWY3g=;
 b=Fdb/zaQIMD73FluV/JG8RzRaOFBVPc5OlPmGQYzrgWPzBtIYcwn8lUiORAcByJDW639UmBI9N24+VPoD/EZxGvVG9RaiTz/1Y8/wgPj2q3J+7yykh1eONSc7VbgZyh6VlpaqY1KHj2MwXILZC2QMNesH8CrCvUa0IxsZ5KCK4GPy43FKjsQ4hegG1S6Smwr/UkqQ9j2X5Y1XMBM8d25jk0yEel9dxKZxH0Pr2V8GH+20NKGrOKEzepSv/ECJiozDzQ6KiP2wyAsWcBnvU5ogaLR2OkUJV24Lz4pFqhDm38ynD+rdNhGW3YWxQqOg7g7V/qQYMR4BxbzBQ0RzsxXQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaqhQBor53sLaIM/AWWplJ8ePjWUqUrg7RBVIQiWY3g=;
 b=fttYAOO6OVaub3sTb+MAcVd/InVnbWXP/9cDKOAop1RK7wXszx2juP6QHc58KU03wW2vnhZqjhSvYMeH+rhsdJOG7xSSVhZEc3mwpciIxCk/rxYcQytZ1WySIGf/rvoDUTcRLKUAF4efxeISXpRdMlvvl9B7JxrcGUKoLB6awC1WAQezgdW33XhJnc85xyssNwLHRphVqeNnchnpV76/PUjHdMe0KYO65/oIls0mnnAq1kAsLPtWWtdMmvMDvXhS9Ei9VUq3X89tKlahD9m/NHpwEiiUu33b+PAvl4MB4CF1cChQhkkLjmX1EbArXdYA+YYmURkIdyaZTLAiC1llrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH8PR12MB7026.namprd12.prod.outlook.com
 (2603:10b6:510:1bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 16:36:04 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 16:36:03 +0000
Message-ID: <73801ed9-7c7d-4094-a0e8-74acc520247d@nvidia.com>
Date: Fri, 2 Oct 2026 11:35:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xio3130_downstream: Add ACS support for downstream
 PCIe ports
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Alex Williamson
 <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260922215008.2554402-1-tdave@nvidia.com>
 <20260922215008.2554402-2-tdave@nvidia.com>
 <SJ0PR12MB8614AB65D581542D1D9B3CA4AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB8614AB65D581542D1D9B3CA4AB892@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d6e2ab-5eea-4dea-ec8e-08df20a34020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|4143699003|6133799003|11063799006|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: iYg6AM8kW/JA38DG47K3DDn9EzM9KGORdjnK1+axtSe5R+MZg8XYHKgoiF1kB9CP/k7u/70W8l5B60IHHg4zNk3iCGZ1UDaz4avgOVIUAfrjuZYq1KfrtlJxlSFTVgreTjmc7CPaZk/TfibK2XHLe9/x8o2ZLgcaGnqQppaILYIyac2Kfshh3MHu+N3dhfCR/uF0Zdhf8tkCKzcuudbGD6Leo4eif08VFupojCSkw+xAMOFo1Vsx5yOqsuSTUt3ekRW8QBjODUNtjhlILe1jmBzatedGTKv+Iiw3CNnXhcxvC7QUw2FqXv/s0mdmGJ2xNB1CCNHRVahW+S9G7MyVhNpnvJV7LyT2tviBXvaPDApMQ/yO/1PVW1qvKj9uNALyX9TSt1ChyXQxtU9IlHmhkb1tBlcbiEl79MnT8qDSErwZsBzXlgyOX07LXCfPG0F8xpdfeB/YjdkqGuQN5zKyIbjN2JSP8Y3IxzK5mTFSCD/gk2aVhWtb7G+TtX1JQ8/aFOAtA2kyN5zQOtEoB6771Na5evhZ47/PsDvoRLGBM0r7wAlzh4GVceS0yKlGf1VxWBsV1rLXK9evuOPUaOfOU/mjdr9vb5Sj12MzhIWSWd9AEiG1bERYMpyAM7jxD68ZLTzxtOU/9SjH68PY7+Vd2jzOv8/+Cz9DycynMn5CjJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(10067099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHMxclhmU2h3NWpuZWluQUtmV21xVXVMWk1Pd0R5dThSSnBCajEyb1h4aTZD?=
 =?utf-8?B?THpsbzZBdW44NTN2SmRZRzVyZEoxVzBBL1NjNE5mZnVHS2FMS05LelBzU1Ra?=
 =?utf-8?B?QzJYSVl1WVQvekdEb29yTG5SOC9iN2tPZXZ1ZG9VWWhvSFY0aldFakhoczln?=
 =?utf-8?B?YlZoR0FueGhDQW5tcGFPRkVNa2c4T0EvMi9lcGRWci8vS3l6RHduZVNqK2pR?=
 =?utf-8?B?WlRqVWJNUk9mZmlHeWx6VmZZMG1JODBCUTgvZG42T0RuRndOYldIaDRYeEVa?=
 =?utf-8?B?VnIzRGhzdU16QTJvTWQvZzFUclpiT1NvckE5RGQ4U1IxcFRtbTBwTzluVmVU?=
 =?utf-8?B?c1RBekpWN1JaUGp1bU03UktrZGU4cWorckFZSHpPb1hyQXhBdEw4K003azVt?=
 =?utf-8?B?OUlucysyWk9TdzBxclYvcDhrRmRCbnEwN1EwdnJjOVlmdU9JamFuZGhUU2Ix?=
 =?utf-8?B?YVFZakV3UnVkN2RuNjluTmptZXlMajVxT29VRmhBVGF4SDMrbnlrSjlpVzU3?=
 =?utf-8?B?Zm5ybVF4SytRUjA1M1NDZ1ZESkcva0ZnZFZYUmhSM1F2aWlsUGZabmppSHZs?=
 =?utf-8?B?OHl2RkplME5IV2hwY09kNVk0RkJmTFdYbTdPdEZoSVQ1L3hYbGs5ZmErRzFK?=
 =?utf-8?B?dmdCWmR0cmJmdmJjYjgxcmlvSzhzNVJDYW9SU1RuUS9yWHJJNHNJSEh5eVA2?=
 =?utf-8?B?bnFya3JrVFhXSE04OWRnWFVqeWRaYWZKdHpIL2RycVBQeGZycE9wcnZNMWJq?=
 =?utf-8?B?SzRTT3pKbjZaeDB6NG9qMk85b1pPN0lmbElXNGZ0SlBRQ2RjTEdiZndzVExn?=
 =?utf-8?B?RkpMdDZOeUNmTy9JOUw1T1hveWJhRjAzeHJyNVNwdWRvbEFicjFqTE5RaXdV?=
 =?utf-8?B?alFyRWRDcjViQWxTVWZPcUFrSzVjL2J2Zlk1aGlwSlVJSDRvdHB5UDhhSzJX?=
 =?utf-8?B?RUo2TXdMbDltaGdqWEk5T0RzaVloRXE5NTlpZFRPMWdoV1ZkYmRKNGw3UUR1?=
 =?utf-8?B?T3BFQm9hMWpqWXJQcE5nQW8zWGpyR3FGamJlMGJjL0hzTjdMbG1SYkRmenBC?=
 =?utf-8?B?UWRGU3duTFNOckNlZGYvYmJZMXBaUDhYOEZPbGFlb09UakMwVm1mNWYrbEt0?=
 =?utf-8?B?VzhnUHFCVTkzUEtDTVQyYnltRzF2VWhlclRaQ0hGZVp4Y21CQ3BKbFAyS1Ba?=
 =?utf-8?B?bUNHb3BwaFJ3K0o3aXVpMExnb2VxcStIVmZpOUdFMHdUOG0wZkFqKzA0bDVF?=
 =?utf-8?B?Nzc4ZmNTcDAyc3dXQVdlZUxDVnhkZEZKL3ZwdmxFWDdkSjFTYjBGTStOcUdT?=
 =?utf-8?B?RkwwQjh1YitMalJPM01kUGZwQjlNV2xCaVJubG52ejdueXRlMXBYVGNEVmNp?=
 =?utf-8?B?a1F6UEJuS21sajQyR0U5Q2ZDSHU0VjhwR3I2OW95UGc0OURpaEJLYXFvWHZF?=
 =?utf-8?B?dEhNTG9kell1YlpvTFV1YXgyQTQxSUQ5c0lKL2lnRVdlZ2xGTXAzRmVRYlNB?=
 =?utf-8?B?UU42cE04MHZFZjd3K1NJVE5qbzFYbkU0d3VwTkFMaUx4UkJjTG5MSkdQclFB?=
 =?utf-8?B?cnJ6QVZTZzJiQTFzRVlzRzBJTk1YcEx3bkJGeVVlbHhBWUF4ZDF2VngxR3Mv?=
 =?utf-8?B?c1Y5a1o3OUlCU1dTZXZNSWlsbGZURUpOOWlPZndWZVNURm1FeFdobVAxdWNk?=
 =?utf-8?B?V2Z4VTFwbmtycGFoMHc4RDVteHlRR3JIUHVBbnFKanpodkZBZG94TFYvc2tB?=
 =?utf-8?B?N3Zydjk1b1V5L0t1bFNjSHhGREVadnVndXNqYkZjTE5rMVcwTnNtT0xHS2JY?=
 =?utf-8?B?MmlaTWN1aG5NN0RPc0NGNHFLMTNONFVIQ1FSM2xaYTVJWjNzN3Z0RGp5YnlB?=
 =?utf-8?B?SWVyelJnSzQyL0FwQjJVUTd0ZDBIQVZaZ2IvVXRQdFRWOE05OTBTeTlyUk4x?=
 =?utf-8?B?QUR0MW9hd0NvMU1aZ3h2R1RhNUF5dFVhN1ZQWW1Fd3Rsa2ppck5hK29KMG8y?=
 =?utf-8?B?RnpWaytITWhwY2krd1g0UTJiNHBFN01TTCt1SXpmUHRadTh1NFdLRUw3OG5Q?=
 =?utf-8?B?ektlMXJhV2lxVjA4TWFQVTIvNDVaaDFiWDV0dStYandNVlpQZWZMdXp4U2tP?=
 =?utf-8?B?eXNKaDdQVlJmRGxCNjl6WnlsUk04MVNDZlhFZHZrOG13ckh1alNzbWtwMGhZ?=
 =?utf-8?B?WDgzY0U2MHNWMWVBNlY2SXZmc0ZmenBWc01EZU5sa2g5OG02bnhwbG5iYVVH?=
 =?utf-8?B?QTZRNzFzMmJmNVB0YU5McUozdDVhN1FGT1o1bXZXK0FSdEJ0bVZBUTJpOGtD?=
 =?utf-8?Q?TDD+RFMb/gqn75BnLT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6e2ab-5eea-4dea-ec8e-08df20a34020
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:36:03.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXg4sC2xCpUvmgzLG2Kugzgb+ndjXKoVxhlibKqfNsXcnR2ygL+PvEj84vOEMJZ/Gnk03JPOeWqkHKE8C09VBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
Received-SPF: permerror client-ip=40.93.194.56; envelope-from=tdave@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 10/2/2026 5:38 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 22 September 2026 22:50
>> To: qemu-devel@nongnu.org
>> Cc: mst@redhat.com; philmd@oss.qualcomm.com; zhao1.liu@intel.com;
>> Yishai Hadas <yishaih@nvidia.com>; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 1/3] xio3130_downstream: Add ACS support for
>> downstream PCIe ports
>>
>> When a PASID-capable device is added behind the PCIe downstream port,
>> for example, an Nvidia GPU, the PCIe downstream ports must expose ACS
>> capability otherwise PASID won't get enabled.
>>
>> In addition, the other use case is GPUDirect RDMA using Data Direct
>> that must require special ACS controls at the PCIe downstream ports
>> for P2P communication.
>>
>> Gate it behind a new x-pcie-acs property (default on), following the
> 
> Why default on? It only matters for the use cases above. With it on,
> a guest with a vIOMMU behind an xio3130 downstream port may see its
> IOMMU groups change. Is that intended? If so, please mention it in the
> commit message.

'x-pcie-acs' exists only for migration compatibility. 'x-pcie-acs' does
not control any ACS control bits. It defaults on so that new machine
types get the capability without an extra option, and older machine
types turn it off through the hw_compat entry, like other properties do
today, so migration is unchanged.

> 
>> x-pcie-* compat-bit convention (x-pcie-ext-tag/x-pcie-err-unc-mask/
>> x-pcie-ari-nextfn-1), so older machine types can disable it via
>> hw_compat to preserve migration compatibility.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/core/machine.c                  | 1 +
>>  hw/pci-bridge/xio3130_downstream.c | 7 +++++++
>>  hw/pci/pci.c                       | 2 ++
>>  include/hw/pci/pci.h               | 3 +++
>>  4 files changed, 13 insertions(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 92f7be52a1..4fd48f594f 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@
>>  GlobalProperty hw_compat_11_1[] = {
>>      { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>>      { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>> +    { TYPE_PCI_DEVICE, "x-pcie-acs", "off" }, /* Added in 11.2 */
>>  };
>>  const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
>>
>> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-
>> bridge/xio3130_downstream.c
>> index 0c3fed3053..87ba30eb36 100644
>> --- a/hw/pci-bridge/xio3130_downstream.c
>> +++ b/hw/pci-bridge/xio3130_downstream.c
>> @@ -40,6 +40,8 @@
>>  #define XIO3130_SSVID_SSID              0
>>  #define XIO3130_EXP_OFFSET              0x90
>>  #define XIO3130_AER_OFFSET              0x100
>> +#define XIO3130_ACS_OFFSET \
>> +    (XIO3130_AER_OFFSET + PCI_ERR_SIZEOF)
>>
>>  static void xio3130_downstream_write_config(PCIDevice *d, uint32_t
>> address,
>>                                           uint32_t val, int len)
>> @@ -60,6 +62,7 @@ static void xio3130_downstream_reset(DeviceState
>> *qdev)
>>      pcie_cap_deverr_reset(d);
>>      pcie_cap_slot_reset(d);
>>      pcie_cap_arifwd_reset(d);
>> +    pcie_acs_reset(d);
>>      pci_bridge_reset(qdev);
>>  }
>>
>> @@ -111,6 +114,10 @@ static void xio3130_downstream_realize(PCIDevice
>> *d, Error **errp)
>>          goto err;
>>      }
>>
>> +    if (d->cap_present & QEMU_PCIE_CAP_ACS) {
>> +        pcie_acs_init(d, XIO3130_ACS_OFFSET);
>> +    }
>> +
>>      return;
>>
>>  err:
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 0efb4eb4bb..807729ca75 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -105,6 +105,8 @@ static const Property pci_props[] = {
>>      DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>>      DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>>                      QEMU_PCIE_EXT_TAG_BITNR, true),
>> +    DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
>> +                    QEMU_PCIE_ACS_BITNR, true),
> 
> This is defined on every PCI device but only xio3130 downstream reads
> it.  I think it is better to limit the scope.

Sure thing.
> 
> Thanks,
> Shameer

Thanks.
-Tushar

