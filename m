Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E616C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0zRN-0005Db-6o; Mon, 31 Aug 2026 06:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0zRH-0005DL-Ta
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:40:32 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0zRF-00066n-9q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDovPQTr9GbaaU/QvJ89Fiv9nvuNlKBciFGriugmPlk5vE4OqWqgX4KN9m9SFp8KN8RarnLJLEZVjkuRimlEc4ZmrBV/iYEDa5Mp8FecH4AR8PvmCxBUhjEofXO6907oIcJ7V9uNGD9+wtEAJV7HCJ6e0s5PTaY/eFZ6a/cJZT4dxAe7/5xUXn8OyFEJb18HrinP+CQp99QBsR6n7a6If5wOw/23WevL9bSBEdkhg1v91OzqEWRjYESk1PQt6hFJi2DH3EIsRPUG1csxwr6qRdtRfocZzgtu3X2DkVDqUY6y5yze9z4szc5EqFGsTAOkLsQpw9EyTJb8Dp7ADX0s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RDCo0IM1Gdqz1eJVo44vRFO8W2LmhdBc6BAu47dEJU=;
 b=ukVgNMbJYN1w6V9QUux3qICR0FUXi1WEvPsNpTUQLm8uJu2BtSoxEMKMBofOsUWNhGUTobQA+iGVHXg7mP1C5P/l71S4Zi1hU8gckAvYDsS5xDzEUX6c5slhDEMTPpbVVlFw+XZEHQVd6e9VAL5P4genzE3RDqy5+l2DQuHpLOOYSGfrBHqxLevuN7BZvQVFGZSxxsqRPL4WIwLh1qdQT/FtXEdpypKphmgd8G9I+R+wxh1AYa0EPkVoqA3tRXBQK1JNEayk2EW6apOfkbrXk9rvjzjLKUfX3qFM7t4zKgZJiWb0jA2C2fwuqVRN1gEhTynH2mACzaR4jnzM6oLI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RDCo0IM1Gdqz1eJVo44vRFO8W2LmhdBc6BAu47dEJU=;
 b=4gZls3NxUldGP9AQB5RtwSJivXoR/xJCdADCU5DfXyXXdv1b4mRO8n43s8VG/gRGRbAWi7R41RZYDHtZV7BgeYE9XlPxZtiPFVD3Icjf2QUda4hXajzgAvMeTLcJipHyXxx96o8jTjDv7WP9/f/rEBl1kr2CtEtnZNSYuxuhE4k=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:40:20 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ca) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 10:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 10:40:20 +0000
Received: from [10.85.43.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 05:40:16 -0500
Message-ID: <d77edd98-7bdb-42e4-86cc-ea3e5e9454a6@amd.com>
Date: Mon, 31 Aug 2026 16:10:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
 <14e2f520-e5fb-48a8-9fb5-9b8c451d2aea@amd.com>
 <73ade3bf-9c80-4aa3-852a-a7643f184ca8@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <73ade3bf-9c80-4aa3-852a-a7643f184ca8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: b564d56a-8e63-41d4-c9fa-08df074c4121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|10067099003|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qhQbv+JFN60/96kn3e38yc6MRuvFGNfykN0bileJT27xx6idz4jc4gMsBRENETY7FVhcGVaKlRZsqLq99JnZABNtCORF1vXav3dgLnqQuya79w42/URgoMv95YgrO6LoPt99ywGx0TseHEapUIqxg+GEKq/2vnKGC/biOx0qzAx98kzDWkp8LNJgBrFZfOSs1SU8Q2VuJ9r4wVjjFfikSArYfieHu8ji+DJhTPP+D0wlOYVajmakMnyh7yA3UaLPRrXm8x/tFm1989PNoiSln4IVqsYFWHbpcmzyztVCpLmbClr9tlGAvWef9qK36Jwq4QOfpuG1AMKY+Jgn7FhvBA5yZO8d3Uk0KmIOwwHxYxuR9ymcUmN2BTJkE9W1CHsT4Qp4gq7qbLXQRDvK+R4dQeAHQZkxS4/UMrAMkxuIIQYfG+5xT+PVvZf0D++sS1o58DHAyehBHRAVt33mGX4R9BSFgW5BleQ8w9W0Y4nraLm6PrY9tLQB/nnwAwoRBP3ljw7+0UodOBuYZxNbXnEDgojYEckDgF5PHC2/A8ifgulHQrmwavyweO5nMhvVp4Bdpx0s7Yw682s9wMmQASTpHafpFJ1Ibmy+Y0mBt4s/vQ95Th8znl/cAyQWNre70sD0e+IPWcFhyc0McA4jtnNmQtsZ5wnewzx0yEmQ86T3kfVErCPeHI78qQTULMDmVrGo7tTkTbm5z8DT2bOqNp7rdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(10067099003)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1cEDaCSRp2Mp4VrlWDgubhsKd+aBBBtfCvzD10IozAmsKrv1/DWJz+x1QA+TnnNUlyF488CVIL68pHT0BCG8hidZWnN1bI1pU2YloI5AAab9Xf/9kFahnH6sgx39gX9RC0d23prriXJvQfMPsii61b35xqBwr0fkyLN0hpsrHLialuw2ViGEnx3ERlzaC4O+tppmpXg54eynEoCsgMF4B03BwzCQO8V29TFoFvE6az7OgqK13f3Fo3O23CfYHffWw4i3lAcwmKhnJqNsKZadWGbUfj0GsUDciCX1q+sJLGgD+kroAHTCoZ2wTnPmz/1p8qveN/KNFKalOwOLcnfZTUpb2B0FBzDYN1tIdEiIqY7LvODAyKmbIisCiXfWHIkYxY+QHDoLBx1Au7onwVUisvq0OjOpNopqd5Z2sNwql/g/aFSTz9qVbMoWtvZZU8yS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:40:20.0470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b564d56a-8e63-41d4-c9fa-08df074c4121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.K@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 8/28/2026 6:44 AM, Alejandro Jimenez wrote:
> 
> 
> On 8/27/26 2:18 AM, Sairaj Kodilkar wrote:
>> On 8/1/2026 3: 17 AM, Alejandro Jimenez wrote: > > On 7/31/26 8: 32 AM,
>> Sairaj Kodilkar wrote: >> On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote:
>>> On Mon, May 11, 2026 at >> 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >>
>>
>>
>> On 8/1/2026 3:17 AM, Alejandro Jimenez wrote:
>>>
>>> On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
>>>> On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote: > On Mon, May 11, 2026 at
>>>> 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >> Currently, build_amd_iommu()
>>>> uses "addr" property to build the device ID for >> IOMMU device and
>>>> advertise it
>>>>
>>>>
>>>> On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
>>>>> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>>>>>> Currently, build_amd_iommu() uses "addr" property to build the device ID for
>>>>>> IOMMU device and advertise it throught IVRS. But this property does not encode
>>>>>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
>>>>>> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
>>>>>>
>>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>>>
>>>>> But is this called after firmware has enumerated the pci bus?
>>>>> And I guess OS better not change that bus number eh?
>>>
>>> The above line sounds fairly threatening :) so I dug a bit more into the
>>> details.
>>> Short story: I tested placing the IOMMU behind a PCI bridge, which the
>>> implementation currently allows, and the guest can (easily) change the bus
>>> number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS becomes
>>> incorrect.
>>>
>>
>> Hi alejandro,
>>
>> Could you please share the steps and commands you used to change the bus
>> number inside guest ? 
> 
> Sorry, my earlier statement was ambiguous/confusing because I used DeviceID
> referring to the name of the IVRS field, but can also be taken as a portion
> of the BDF. Let me try to be more clear:
> 
> I did not change the IOMMU device or function values (I don't think that is
> currently possible). What I was able to change is the secondary bus number
> of the pcie-root-port above the IOMMU. Then this changes the IOMMU BDF
> (more specifically the Bus part of it).
> I launched the guest with this topology:
> 
>   -device pcie-root-port,id=pcie-rp1,bus=pcie.0,addr=1c.0
>   -device AMDVI-PCI,id=iommu-pci,bus=pcie-rp1,addr=0
>   -device amd-iommu,dma-remap=on,xtsup=on,pci-id=iommu-pci
> 
> so firmware placed the IOMMU at 01:00.0, behind root port 00:1c.0.
> Inside the guest:
> 
> # setpci -s 00:1c.0 PRIMARY_BUS SECONDARY_BUS SUBORDINATE_BUS
> 00
> 01
> 01
> 
> # setpci -s 00:1c.0 SECONDARY_BUS=02 SUBORDINATE_BUS=02
> 
> so the write is targeting the root port (pcie-rp1), not the IOMMU endpoint
> itself. After that the IOMMU BDF in the guest is 02:00.0. IIUC the standard
> lspci output displays the old BDF that has been cached by the guest OS when
> enumerating the PCI devices, but setpci and lspci with option -H1 will do a
> raw access and show the new BDF.
> 
> # lspci -H1 -Dnn
> [...]
> 0000:02:00.0 IOMMU ... [1022:1419]
> 
> The IVRS table is not rebuilt following this guest write, which is I think
> what MST is warning about.
> 
> Now we need to decide whether that operation I described above (which I
> found researching ways to force the change to prove Michael's point) is
> something that is considered valid. Perhaps there is a use for it that I am
> not aware of, or perhaps it is just another way that a guest can break
> itself and we are just supposed to let it.
> 

Hi Alejandro,

I see that you are using lspci -H1 to read the actual hardware config instead
of kernel topology, The plain lspci does not show new bus, It seems like you 
have to perform pci rescan. 

When I perform PCI rescan I see following NULL pointer access in kernel

oot@ubuntu:~# echo 1 | sudo tee /sys/bus/pci/devices/0000:00:1c.0/rescan
1
[  238.666837] pci 0000:02:00.0: EDR: Failed to install notify handler
[  238.675198] BUG: unable to handle page fault for address: 0000000000080060
[  238.677682] #PF: supervisor read access in kernel mode
[  238.679330] #PF: error_code(0x0000) - not-present page
[  238.680976] PGD 0 P4D 0
[  238.681846] Oops: Oops: 0000 [#1] SMP NOPTI
[  238.683206] CPU: 0 UID: 0 PID: 1436 Comm: tee Tainted: G        W           7.1.0-rc1-qemu #2 PREEMPT(lazy)
[  238.686328] Tainted: [W]=WARN
[  238.687326] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  238.690864] RIP: 0010:amd_iommu_probe_device+0x53/0x470
[  238.692598] Code: b0 0f 84 6d 01 00 00 31 f6 e8 e9 d2 ff ff 85 c0 0f 88 45 01 00 00 4c 89 e7 0f b7 d8 e8 96 d6 ff ff 48 85 c0 0f 84 31 01 00 00 <48> 8b 40 60 0f b7 40 1a 39 c3 0f 8f 21 01 00 00 4c 89 e7 e8 6
[  238.697728] RSP: 0018:ffffd317452ab948 EFLAGS: 00010206
[  238.698706] RAX: 0000000000080000 RBX: 0000000000000200 RCX: 0000000000000000
[  238.700044] RDX: ffff8e374195f000 RSI: 0000000000000200 RDI: ffff8e376ff580d0
[  238.701369] RBP: ffffd317452ab970 R08: 0000000000080000 R09: ffff8e375156e380
[  238.702693] R10: ffff8e37707264b8 R11: ffffffffb0f28a20 R12: ffff8e376ff580d0
[  238.704033] R13: ffff8e376ff580d0 R14: 00000000ffffffff R15: ffff8e3740d0f5d8
[  238.705358] FS:  00007f2d02060540(0000) GS:ffff8e37ff749000(0000) knlGS:0000000000000000
[  238.706843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  238.707918] CR2: 0000000000080060 CR3: 0000000101d00004 CR4: 0000000000770ef0
[  238.709285] PKRU: 55555554
[  238.709828] Call Trace:
[  238.710314]  <TASK>
[  238.710742]  iommu_init_device+0xbf/0x330
[  238.711518]  ? srso_alias_return_thunk+0x5/0xfbef5
[  238.712450]  iommu_probe_device+0x70/0xb0
[  238.713214]  iommu_bus_notifier+0x2c/0x80
[  238.713984]  ? srso_alias_return_thunk+0x5/0xfbef5
[  238.714889]  notifier_call_chain+0x66/0xf0
[  238.715673]  blocking_notifier_call_chain+0x47/0x70
[  238.716632]  bus_notify+0x3b/0x50
[  238.717295]  device_add+0x631/0x870
[  238.717982]  pci_device_add+0x303/0x720
[  238.718735]  pci_scan_single_device+0xad/0xd0
[  238.719571]  pci_scan_slot+0x97/0x230
[  238.720279]  ? srso_alias_return_thunk+0x5/0xfbef5
[  238.721186]  pci_scan_child_bus_extend+0x3b/0x2f0
[  238.722082]  ? srso_alias_return_thunk+0x5/0xfbef5
[  238.722987]  pci_scan_bridge_extend+0x447/0x4f0
[  238.723847]  pci_scan_child_bus_extend+0x106/0x2f0
[  238.724795]  pci_rescan_bus+0x1b/0x40
[  238.725499]  dev_rescan_store+0x70/0x90
[  238.726252]  dev_attr_store+0x1b/0x30
[  238.726963]  sysfs_kf_write+0x76/0x90
[  238.727677]  kernfs_fop_write_iter+0x145/0x1d0
[  238.728530]  vfs_write+0x307/0x420
[  238.729401]  ksys_write+0x6d/0xe0
[  238.730223]  __x64_sys_write+0x1d/0x30
[  238.731116]  x64_sys_call+0x1704/0x21c0
[  238.732018]  do_syscall_64+0xa3/0x7c0
[  238.732907]  ? irqentry_exit+0x42/0x5a0
[  238.733815]  ? srso_alias_return_thunk+0x5/0xfbef5
[  238.734877]  ? do_syscall_64+0x58/0x7c0
[  238.735768]  ? exc_page_fault+0x98/0x1c0
[  238.736709]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  238.737825] RIP: 0033:0x7f2d01b10104
[  238.738673] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 e1 08 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 5
[  238.742405] RSP: 002b:00007ffd09b75168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  238.743966] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d01b10104
[  238.745478] RDX: 0000000000000002 RSI: 00007ffd09b75250 RDI: 0000000000000003
[  238.746962] RBP: 00007ffd09b75250 R08: 0000000000000002 R09: 00007f2d02060540
[  238.748466] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000555ec468b280
[  238.749943] R13: 0000000000000002 R14: 00007f2d01de7760 R15: 0000000000000002
[  238.751418]  </TASK>
[  238.752010] Modules linked in:
[  238.752772] CR2: 0000000000080060
[  238.753571] ---[ end trace 0000000000000000 ]---
[  238.754628] RIP: 0010:amd_iommu_probe_device+0x53/0x470
[  238.755772] Code: b0 0f 84 6d 01 00 00 31 f6 e8 e9 d2 ff ff 85 c0 0f 88 45 01 00 00 4c 89 e7 0f b7 d8 e8 96 d6 ff ff 48 85 c0 0f 84 31 01 00 00 <48> 8b 40 60 0f b7 40 1a 39 c3 0f 8f 21 01 00 00 4c 89 e7 e8 6
[  238.759542] RSP: 0018:ffffd317452ab948 EFLAGS: 00010206
[  238.760706] RAX: 0000000000080000 RBX: 0000000000000200 RCX: 0000000000000000
[  238.762210] RDX: ffff8e374195f000 RSI: 0000000000000200 RDI: ffff8e376ff580d0
[  238.763708] RBP: ffffd317452ab970 R08: 0000000000080000 R09: ffff8e375156e380
[  238.765248] R10: ffff8e37707264b8 R11: ffffffffb0f28a20 R12: ffff8e376ff580d0
[  238.766761] R13: ffff8e376ff580d0 R14: 00000000ffffffff R15: ffff8e3740d0f5d8
[  238.768279] FS:  00007f2d02060540(0000) GS:ffff8e37ff749000(0000) knlGS:0000000000000000
[  238.769959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  238.771227] CR2: 0000000000080060 CR3: 0000000101d00004 CR4: 0000000000770ef0
[  238.772767] PKRU: 55555554
[  238.773488] note: tee[1436] exited with irqs disabled

It seems like this operations is not safe and we may need to patch kernel.

Can you try running pci bus rescan after changing the secondary bus ?

Thanks
Sairaj

> I do see your explanation about why my initial proposal is too restrictive
> for the future. I am just not sure yet what the right solution is.
> 
> Thank you,
> Alejandro
> 
> I would like to run few tests around it but I am
>> not able to change the PCI ID of the IOMMU with setpci command on root
>> pci bridge.
>>
>> Thanks
>> Sairaj
>>
> 


