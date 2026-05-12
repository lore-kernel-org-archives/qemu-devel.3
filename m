Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5517ACD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqrl-0004V5-Gm; Tue, 12 May 2026 13:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wMqrk-0004Ue-C0; Tue, 12 May 2026 13:25:56 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wMqri-00013X-4f; Tue, 12 May 2026 13:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC2MmwZ8v80i4POJd4QzImoPpmu2gLCGhKP72GnEvOwakjcnaaPKRHfDnpy52qlddvvcwqQjDi+bmZzHlQI2uySI3t5q3py/oemN8RESm7hM9QAS0XA6YpB/BkkzCqEYH4ovQ7d1o46HmvxQzcZNK3vXt77MvU4Bp8J2hdFrLTYo58+4J+pC2X2EzAMRYLCW5bUmqWOWCcecKMX0dBZ0eoIT/ruvdli4QbK+Hk54RlML2tYIl6WzAmWHvearBlMC2it2g5vH0o11yZRRPK2Z+iiv8PiHOT7HFA2PtL/0xKyOHFNlOoCTgWfgukBbku2yCPKtc92NpdKe0yOKX1rl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quP/4nG1yG3iajMlhgX14inOiVmtip8zaNg4vW5Pu+g=;
 b=t/hv+UUaqoTDqgRpOYYum0FxcgtoqJOHsI0JUqNO2QhPYPwX3DT4/LeR5amu/SwKcny4JtnV66egrw+WK06S8AQRla3UeoJULPJgVRBECqEz6GnOBa/3wPkdvs4+gPI6XriPh/rp4rWJt/4YBDJqLM2WqFS/tdB8cTRbRTSxBfmgSWusQ/38fQ3FDznCuqWYo0qS9IfVH21q9GR1KJfuW8BCz4+TBhSLsgpHqyMpibSg9VdoMGQGKlyRNVPMwdag8yOl+oJYESQckae0meaSi7vZuEGf1nacA4bGxC6AqNBycmHx9yV2QIlriqzpznfffoPpQXyaG5Ivy4rnNF+jvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quP/4nG1yG3iajMlhgX14inOiVmtip8zaNg4vW5Pu+g=;
 b=D2yv/MLlFhthoplKlEmjKZwdQdEQLHH4WR3GxoMKibRzaMIA/zg53h5bKts7YYZhFJ6SoxWI0Faa8I78JsSMRIjW+3vF1OGAuUNH6NpktmQaS2IuUYDRzBZCcpiGwohvaHml7kN5XSqFQDL2ZtuJpITQ9etpg5xdWIeMfNo1tN1mx5/1zix0xe1fMjac0s2SVXSRVj+PQAxHEElSPDqUknU0KKXJAwEeO4dcECBxVUw3ZCl6RM5bJJiN3JhcyCpLa18ZqyYefTOC770t6HWi8ehYak2Xc7MW9ucscgDKRK6bw8hSaXvJioHf1Nj4cpg4gkY4ju6VOQxCRxUKp3pTZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 17:25:47 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 17:25:47 +0000
Message-ID: <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
Date: Tue, 12 May 2026 12:25:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI
 pre-enumeration and fixed BAR allocation
To: Ard Biesheuvel <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: f3abd9bd-7fd3-4f14-9923-08deb04b813d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: LHshUFeEa4JRtflVfCAgq0uQsAbte2LwCc9TLYkS3sjivX2BHBUITW8BrGnfnGv5v1ZBm/7L58qHC0aQ0bmx60BwsXANQLl1l3f7LzisjCx30uVyG6irylPqYHh9yt/9EhOVTesAh9GRJh9MyBNzDElM9XE5ntyVmDSmvBzCgNPoEBXr21KYK8QVyB7vCxGPCfOEteKr8vms5ffRd8ySyRYAKxqM07QNCLgSc9XneJ0os7Yv5NnS++wlocaxgctapgVoHeMJMBltwZ1gJLG0rwShQ7xFhjKkL+dC/k0hZeWkQI/Au6O59z08p/prgh2SyitTExTE9UJkEQIbFbdMvYt05KX6VE9KdQEnRV63U9xwkRVnb/s1EGnAHOKQFYJd42L6Fb38UasGsHUdsOraGncR0uBbJVOvUvcvMfroILVgkOugQcCQKep0lnF6zMnKkKRIPLogPCXsB5g9xlS6OrMMA/5vLpJtrr4EOzUdoAX+N/2bU85fDxh+vx3TOr1xaMDUTcq3m96isSGzry2KOfvPxDlQ5N0Kk70nYi98ZLSm3897SmmG8plkMBOs/DPE9/u/zAav6umS8SQ/dWCRxINlMcOy2fN3kam/Q3cX4/tyM09JKG9cHLmvQS+N5yBJMfxWXdFJ886UatG1jy9mA/OOAdQjEKdHJ3vtOZ9OmN7Or3vtg7ENl7JW5Noq9RyW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4186.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkptUElvcjUyaE9VSUFETXRrUGluQnVWc0VKbGFMQzNVUXYvOXFEblN4MGN4?=
 =?utf-8?B?TlRXeDNkcUdJUnBvQnpQRmR0NXgzdUFSb2VVMHlJVU40S2w1K2VzdG1TOCtZ?=
 =?utf-8?B?QmtpSzBJSGFSaDR3ZGNMQS9Md0VNb21RRUFuODRTdXpaU0c2STM3Z1FmandY?=
 =?utf-8?B?Nks3dnJNOUxYUktDMnU3ZHRUZ1lBakgyODJCcDZ6WVhNMXptRmFrU1BlSUor?=
 =?utf-8?B?U2Q4WlZuUVludkhlT0VkcWpCUWlrMzF1RGlQVGRpSGtvK29XT29MeDhiaWV5?=
 =?utf-8?B?ZTVBeFpLdmFKalFqM25WVFE4cHN5N0pYNm5jYlpNeWlHUmNTK1pJUUhVUWtp?=
 =?utf-8?B?MlhNbytPeUV6VWlDeksxcWpsZXZ4aG5Ba3BNMytHdHhTOTU0NHozWVptcU1N?=
 =?utf-8?B?RWFtQU1IYTBjNDNENzlIOWY0RlJmU0IvdkkvTGQ5NGtiNU9ReUdQTGdlb3pu?=
 =?utf-8?B?aFZqQ254Q284QXpBQ1c3QWdET25rM0kyRktodDV0MHN2dHBac0RKdGRpL0Uy?=
 =?utf-8?B?d0ljM1BvZTJvQ2tlWHdhZEQxcGhRakVsSGRkZlpJRWlyZmwwTU53UVJMdXlD?=
 =?utf-8?B?MGJvS3Rja0V1dlJleVRNamtWeWlTd2Fnd2N3dTNKcHhmb3g4Wkpxa2RNZUtY?=
 =?utf-8?B?V2dLOUsxZ1RXM2lBL0x5alIvTjhMWEpLaXM1MDRrNmFuaTFZYjE3VUFKd3lH?=
 =?utf-8?B?L01CL3kwTUw1LzlucFE0U2lZZFc1d0xRKzBMYjB6K2Q3YmlMMG5UYThtaWhK?=
 =?utf-8?B?bm5yd3JiRkc1T3RYNlJFMnVMRlo4dWdWZ01kbXBMTG5YT1RUaVY0NDYvcHR2?=
 =?utf-8?B?WlRyKzBsZFFIRTV6YkFuVHk3ZkhHUHNFR3d2dHRjS2VtYjVIWDdvREpWZG5n?=
 =?utf-8?B?VG9xNmh0QTlDSmp6b3hEREl6ekFwWUZKVzl5YW1SQ0FveGlITHFZNFlrRmFW?=
 =?utf-8?B?VUdpODZjRmdYbE1uam54K2pFLzNaSmNHQ0haajF6aEhMbzg5UCtmMGdneU9G?=
 =?utf-8?B?ejFWcWZSNzYzbGVYZ0dnemo4STVUcUpSOTkvdmFNN0x5WW5KWitXRStrM2xq?=
 =?utf-8?B?cTB1R0EremJUdFBKa1BGK1ZSS1FQL2cwbGJCekgxcDJNS3I4NkRGNUhBU3d3?=
 =?utf-8?B?d1JGdkFJa0pOeVhUNmJKMkNQeDd3M01QcFBHUTBURjQyeUdUSFRaYWR3WCta?=
 =?utf-8?B?eHo0dTMyTzNGVm5qNWFxaHdLRWNFN0I5R3l0MXJFci9pOUVPV2VaVi9JTVdi?=
 =?utf-8?B?WDdtMVFqS0N1bVNZeXBPSlZMcm1yakF0V0Y3SWl6ZUJJWElTOGlzdG1XYWhW?=
 =?utf-8?B?amorNHdhQ3N3NWdkaS9KQkRqQUtLdGFWYldGWWc5K1V0RTRqMUxuUTZxUDZm?=
 =?utf-8?B?UHdWN1JjSmY5bXlzOUpKQlRmb2haUVE0ajNRTW8wK2R1OUs3UjFjYTIzK1ow?=
 =?utf-8?B?WGYyenlZcXpnN2RaRlhZOXRBMUNNTVo4aHVvU1JpVkRsRHZoR3UrdGE2TldU?=
 =?utf-8?B?NlIzQTFBeTkzeU5lc1d6ZG55YjNGbk1jeEJ1VlVmYVhYaE9zdEJkYVVVMTY1?=
 =?utf-8?B?Q1NSZnVWRmVwZXl2RGtoRXdtK0NqTXZES2MrTFp1VVJ6SDBKY2o5RWNtOUMz?=
 =?utf-8?B?bVROUXZVT0tjREl0dzROZHNnem0wcVpwQ1I5NEFHQmxtOFY4ZGpOU0dTdEll?=
 =?utf-8?B?dTNjOHNITVZ1MllRRFV2MGd3c0pRQ01xTkxDNk53NTFLNVlFMmc0azg3Z2hl?=
 =?utf-8?B?YlpaN3UyYVZXWjVKYXVoOVh5c2NFSi93VWFHVDQrQWRlWDJNSlh1cGRuUlEz?=
 =?utf-8?B?SGZIVk9BbnFkbHNSZDNFRVByaE1yUHdrYzNISXBJSkxrM25JMlBQdTJUUGxW?=
 =?utf-8?B?QzM3S2RIQm9RSC9nc2crNEdYeEV1cG1BUUJhK1didndRWEdQYldKSGg2Rjhm?=
 =?utf-8?B?ekZ1ZUJxbXNxUUNaMVVObFU5QTlEUmZwZVV5MStoSEN3aTBsc0FFVUluZDJ6?=
 =?utf-8?B?SWNCZXdlQTlKS3RIQzc2aWNudGRKekNBTDlwY3licW9OUUtoTnZ3aEVKUzRz?=
 =?utf-8?B?QlE0cjBRU21vQ3RSdG01Nmc2b1U0SVNhOHIwNTI5cGplS3FseVRpTUZTQkg2?=
 =?utf-8?B?MDZPNmFmRGZMOWU0ZjNDbHkyYUdEejY5a0JUaW1KY0J6L041eUIrQlNPQkZ0?=
 =?utf-8?B?aUV5SFRYcXlSNTV2U3JIYklPZGUzcmlOUm0xMUExcFpwR0FoYklFamlTc3dF?=
 =?utf-8?B?Vlp2UzYvVkZuUXdraCtmNkJrUEMxSGhkWDlCSnczSzd0SEd3R1k4b3IzV1Ru?=
 =?utf-8?B?T3hpakJkRWRURTRvZE5PMGFwU2E4L3dzRUpFOEp2dmF2M1hDczVzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abd9bd-7fd3-4f14-9923-08deb04b813d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:25:47.1997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwA+vX5NcXxMw0bRbQ13tpRfAia+ki+zuz+NLffusGOvzEzvF3zQ4v0hN6CB658dggyIRAqk9Qvzg4Yd2NoU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=tdave@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 5/11/2026 6:43 AM, Ard Biesheuvel wrote:
> Hello Tushar,
> 
> On Fri, 8 May 2026, at 20:37, Tushar Dave via groups.io wrote:
>> This RFC introduces a mechanism to specify Guest Physical Addresses
>> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
>> addresses to match host physical addresses for assigned devices.
>>
>> On some platforms, P2P DMA is performed between devices within the same
>> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
>> without going through the host bridge in order to achieve the required
>> performance.
>>
>> To support this multi-device IOMMU group P2P scenario in virtualization,
>> the VM may need to use the same MMIO BAR addresses as the host physical
>> address layout.
>>
> 
> Did you consider implementing this using Enhanced Allocation (EA)? If so,
> could you explain why it is not suitable here?

I have not evaluated EA for this design. When I looked at EDK2, I
chose PcdPciDisableBusEnumeration because it cleanly preserves fixed
BAR programming established by the hypervisor — at the cost of QEMU
performing PCI bus number and resource assignment.

I did a quick search and do not see EA support in EDK2. Any pointers
to EA being used in a similar fashion to achieve fixed BAR placement
would be appreciated.

> 
> Also, I think I understand what the intent is here, but could you describe
> the topology in a bit more detail? These are assigned physical PCIe endpoints
> behind an emulated host bridge, right? And the BAR needs to reside at an
> a priori fixed address so that another PCIe endpoint behind the same emulated
> host bridge can DMA straight into it?

Yes, that is all correct.

      -[0000:00]-+-00.0  Host bridge
                 +-01.0  Root Port
                     \-[0000:02]
                          +-00.0 Switch Upstream Port
                          +-01.0 Switch Downstream Port A
                          |      \-[0000:04] Device A
                          +-02.0 Switch Downstream Port B
                                 \-[0000:05] Device B

> 
> Doing PCIe enumeration at yet another level is not a feasible approach imo,
> having UEFI and Linux play nice together is already a bit of a challenge.

I agree but to clarify, in this case QEMU performs PCI topology
initialization and resource assignment prior to firmware execution,
where EDK2 avoids full PCI bus re-enumeration. Linux sees a fully
enumerated bus from firmware just as it does today. There is no
duplicated enumeration step between firmware and Linux when we use
EDK2 with PcdPciDisableBusEnumeration.

> 
> Is there any way this could be handled by having special rules for inbound
> translation in the host bridge driver/implementation?

Not that I can think of.

Thanks.
-Tushar

