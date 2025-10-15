Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD522CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tLW-0006QM-5V; Wed, 15 Oct 2025 00:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8tLT-0006Ps-SQ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:42:39 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8tLL-00055i-It
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww7ztVu3vG5dSzE/hkSPzAytbkyQlDWKf269KL3M8PpW+i0YysrLRZEBhwQMLJ4GYfL7wGgitzbliNpvNP6/tbXwkaVVnW/w4Ir2PsSaLvMmm+JpNzBPoyUoTVkGTXrKGdNfLhZWHu6ig6Mf1NMsPp0R7ZCf82gEHYAZmHm2E69Ccm0fejfCZZwEzEIPznKm+enAz2ZoToqtmigayfkzWeWkGhmZ+tsQW7vFfB29to+q5A2yOGW26Q5rLrvpHLD+4YD+bxv9qfDm3Jt3Q3SZxG7U3nZOE9VhvjdKJsCeulvp6bMyzJDtGYUKRrXknskfrsMvuxp2NiZllq3yQ21Oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFLuFu94L7sf7JcbHWYl0+13Z1/CyK7BOemPN/OSkC8=;
 b=jchijyqRymuayvDBNizGu9YP4EAr6LB7ziMUqvSYCKP0PgJ+Wl2akk3Lx1z7gKoHIByPGQdhgi+v5TgYM6eeYLEwBBUInBbrsy9fwDQHzJHYxz93Bnd64bvFmjdxyH5rGe9oshwjgaEFdTG12j2oLxM+yffeJgEVavDTWxqMbemf4BExWXQpwMFbqdL2ZmKmSXlshdRVmZSBsWb5kGSUL7qEilRaOPHy4mLCZxFE/NHQVXyIpEzMztJkLjNZoWMGq3lwCQTSzsybCVoxG6N+yu3R3TwuyDvaPIuPMMPUS0eEumCN6C9Fdzi/iF6VYhVeGRxeh0hsSlOWz99Di1fILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFLuFu94L7sf7JcbHWYl0+13Z1/CyK7BOemPN/OSkC8=;
 b=WICsY60PsYD23YwIus+f/yBWK8C3o6BQCLtFkiG8rzupLC7gTvcQtMD81SpFeNV+Z5gkDLH+P/xvM22x51EfAuUhCWjbpF5AeKSa+7CodlSRT8RprbHZEFBTccp9wvgo/0hbuMclxT5BhMjXx0MzYqfmp8kz8WkZCTowT7JFvVw=
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 04:42:11 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::98) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 04:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 04:42:11 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 21:42:04 -0700
Message-ID: <b486ed18-a7c0-4035-a27c-7bfb87c7c789@amd.com>
Date: Wed, 15 Oct 2025 10:11:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] amd_iommu: Cleanups and fixes (PART 2)
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
 <a50b49dc-d35d-4db9-b177-9901bef6ed75@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <a50b49dc-d35d-4db9-b177-9901bef6ed75@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f2293d-dc04-4166-cde6-08de0ba534b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFNFekJNbDhZZ1prVk5YcFEwOTBObEVUNmo0WE5ZREVoa2NsRXIwOGdHZ2lj?=
 =?utf-8?B?UkxXZ0d0Y1g0eDJqOWFNcjZadkZFblJCd0lPSHZyN3BaclU4VjN4aVhCenBa?=
 =?utf-8?B?Yjg0d0N4MWRCdElOdmFxbkJ1ZG5FSFU0empsTzhjZ0ppVG96WHJ3eTVWWGZQ?=
 =?utf-8?B?dHU2anl3VFk3bWx0VndNc25Cc0dBM1Q4ZnhXRnY5a3VHREFHUHkzQnhlQ3da?=
 =?utf-8?B?UjZ1Q1FxL2F1d01IMGlaSG5MWUduQy9UTnhUZ1pnYlBQemtjTXdzTjlvSDNY?=
 =?utf-8?B?amNDN29yTDlvN2RMNFZXaDV5dC9iZjJ3Zk5wakRaRURtRVpJMXJnOHJMWkRS?=
 =?utf-8?B?K2M0UU9NWnd4eWMwY3lnb05XVnhFTThoNmRPek9iUWtTcVhQSUQvUitzQitp?=
 =?utf-8?B?MTZRVmJjUEhlbC8yQ1dhcUlyT1VSMGhTTlFmcHhKS2NiVW50bm50b3RGdGlM?=
 =?utf-8?B?ZStldmVFRzAzUmxGajkrd1dhV0Y4d0dQaTQrOTFNNDlPait2blk5UFZORkFw?=
 =?utf-8?B?NXdYTi9DWkZWRkM2cTJ3RC9DYnJmOGVGY250THJZWlZuaU4zSHN5cCtQOTRH?=
 =?utf-8?B?NnZJZUNlU1l2cjJrdGdSNFFjNURjRU9rNWYyd1ZTSkxmZVlzS2FLSUMyeXFh?=
 =?utf-8?B?VCt3aFd3YkY0U0lFeE1TVjRXNjZXYXRwVkZvZ2dEQjUzcVdTNkVVclFqZXJ0?=
 =?utf-8?B?Q2Y1ZXk1Z0hmRXlhQ2wxWmsvbjdnOS9adTdzWTU2YXAyVmFPL1ZtdG40RTlF?=
 =?utf-8?B?QTlvM1dCemFJNFBMcFJSa0cxWkhyb3krcnYvWUtEZmpuUFVvUEZreDZRbEFv?=
 =?utf-8?B?VVROOTZIcVVHQ0l6WWJxcmNzTytJR1o5M25XZ1UvdWNJbVVoSDB0Q0Q4WStx?=
 =?utf-8?B?eHVyZ1dhMlByQmlYaktkZnB6RzNlbmh3a2xkZStjSjU0dy9Gc0ttZnlJQzh6?=
 =?utf-8?B?SzVGZnVpck15K0ZIN2RSY1d1dlJmdXBrK3F5TXphUUFKNmRPajZmUmJ6cUlB?=
 =?utf-8?B?L1N6RkkxL1VqSlE0NTVrY1hXSTl3b2lhelJEdWJaQ1U0L1JxVEc3dXFXS3Bn?=
 =?utf-8?B?QnI5Q3JJMXVjdkRWUFIzV2h4S09vUThOOTg1Q3VPZGduOW9ueWRSajdsVy9L?=
 =?utf-8?B?bjRFdUNHTU50UzhZWDBYaW9LOWZqV0N0anRDSnJJSkNZdnVVMFhLbVYvV3Zk?=
 =?utf-8?B?WWgxbnZJYS9xdVZHVWdYMytyYjlxOWN3eVRrMVhCYXdIM3ZEalcrMjVPeWhF?=
 =?utf-8?B?a1VmYzdid0kyTnpLaHNuR1ZIbjV6R21kU1JRd1RYUk00TGk2eUJNMDhIMkVU?=
 =?utf-8?B?YTB5ZHphcE1TR1lDeStNbkxFSUdFVVVVVW03UHBpaGsyOUt0R0VIU3Y5bFZ0?=
 =?utf-8?B?Y1ZaVWxna0Zmd2sxdWx1UFlVdlBSZWFMOVlnTDNOdkJNYThqNjhFYjViaitS?=
 =?utf-8?B?Yy8xOHYvd0xlVkxaMjJEOUMycTh1SkNNUjhZQUZyRkJQRjg5S0dlWXF2T3lO?=
 =?utf-8?B?Z3IvdkJnR2NOazJpOTN5by9WYUNDaXJjcUJOSmxRWmJEdUpQRW5LV0FJWmdt?=
 =?utf-8?B?a25ORmllazdsNDZUYS9LQXJGRkpyRHY2ZkYvcFBDMWxFVGtCMzFvRHp4TUVy?=
 =?utf-8?B?aDVWcjZLM0drNWpyVXlZQXE4bW9CRkJYK0NWV1ZFZmo0S3RYaEJ4M0czU01x?=
 =?utf-8?B?QzhndUdIL01SeTZkK09mWnN5YUY4UFJMWjYrVXVUakhZcVF6QjErbEtCMllJ?=
 =?utf-8?B?enhiSDVNQzcwUXZLaUNtK3JuZ3NmUndiTmt2bXA2UTg3OUpNbXROL05WZkVN?=
 =?utf-8?B?VGo0K0dzY2xTVUNVcHFVRXNNTjJ3N2w4UldZSndqSEg1ZEN5M0hMelNPYUFH?=
 =?utf-8?B?OWZOYWppTVhzL2tqNHFRM3ExeUtJaVVvTFB5S0w4cUg5QVlMNk5FL2k0U2k3?=
 =?utf-8?B?QlVaNjk4VXJwcGpkUDFxQjRQMmZTQmMzNk9nNlFDTnd3T0JLQnY4R1N0M1lu?=
 =?utf-8?B?SE9YT0pZNWg4cmFhby8vQ0c1cjZTdTlWak5xazFSdGZiYnFranZDbThZUG4z?=
 =?utf-8?B?ZE1jbk96cFlhdnZMOVBlTTF6SjhnbVlVYXR5elhGbUR3bTU3Z2FhVmlSaXJO?=
 =?utf-8?Q?a8FA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 04:42:11.3423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f2293d-dc04-4166-cde6-08de0ba534b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/15/2025 2:57 AM, Alejandro Jimenez wrote:
> Hi,
>
> On 10/13/25 1:00 AM, Sairaj Kodilkar wrote:
>> This series provide fixes for following two issues:
>>
>> 1. AMD IOMMU fails to detect the devices when they are attached to 
>> PCI bus with
>>     bus id != 0.
>>     e.g. With following command line, dhclient command fails inside 
>> the guest
>>
>>      -device 
>> pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 
>> \
>>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>>      -device 
>> virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 
>> \
>>
>> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure 
>> while
>>     setting up the devices when guest is booted with command line
>>     "iommu.forcedac=1".
>>
>>     One example of the failure is when there are two virtio ethernet 
>> devices
>>     attached to the guest with command line
>>             -netdev user,id=USER0 \
>>         -netdev user,id=USER1 \
>>         -device 
>> virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 
>> \
>>         -device 
>> virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 
>> \
>>         In this case dhclient fails for second device with following 
>> dmesg
>>         [   24.802644] virtio_net virtio0 enp0s1: TX timeout on 
>> queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 
>> 59: transmit queue 0 timed out 10720 ms
>>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, 
>> sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago
>>
>> ------------------------------------------------------------------------------- 
>>
>>
>> Change log: > ----------
>> P1:
>
> I generally like to include a link to the previous version. Not a 
> must, but makes it easier others to follow the series history.
>
>>   - Use fixed type uint8_t for devfn
>>   - Use uintptr_t instead of uint64_t
>>   - Build hash key using lower 56 bits of bus pointer and 8 bits of 
>> devfn
>>   - Use gboolean instead of int for amdvi_find_as_by_devid
>>   - Update comments
>>   - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE
>>
>> P2:
>>   - Reword commit message
>>   - Correctly initialize `struct amdvi_iotlb_key`
>>   - Remove unused macro
>>
>
> Before sending a new revision, ideally you should run a smoke test (or 
> more thorough testing depending on the scope of the changes). But at 
> the bare minimum please make sure a clean build is done. There are 
> trivial issues in both patches that cause compilation errors. See the 
> replies for details.

Hi Alejandro,
Yep I did that, but I think that somehow I tested a different branch 
thats why failed to catch these errors.
Sorry for inconvenience. Will take care of it in future !

Thanks
Sairaj

>
> Thank you,
> Alejandro
>
>> ------------------------------------------------------------------------------- 
>>
>>
>> Base commit: (qemu uptream) eb7abb4a719f
>>
>> ------------------------------------------------------------------------------- 
>>
>>
>> Sairaj Kodilkar (2):
>>    amd_iommu: Fix handling device on buses != 0
>>    amd_iommu: Support 64 bit address for IOTLB lookup
>>
>>   hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
>>   hw/i386/amd_iommu.h |   6 +-
>>   2 files changed, 113 insertions(+), 72 deletions(-)
>>
>


