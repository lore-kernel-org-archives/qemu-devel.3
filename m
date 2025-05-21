Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ADDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHcuN-0003sg-AD; Wed, 21 May 2025 02:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uHcuL-0003sS-De
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:26:29 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com
 ([40.107.237.87] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uHcuI-00008Q-Cn
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9wLcHcICGuY5Z3X2KyRzt+iZOi6crWcykbe2GmNquyIAJxeqmfOUBOKS5Oe7rnGfS7iAVeCVqdxHueJzn50kAZrFC/GI0GNAI/XkPvgTDjp/aKlREwvFodJwvDIvo2WyAeFIoqnf1H2a6fX160smnGiA3+yEYuM7iXd73HqwUHk1gfO91VxpoBbO1p6Gr09ysMnj7SLy7po9TQWosWV6ZsfNHEaJAoKA9zA0a2ZWJrNFRW9P/EvJWea4SUg0HELV4+OeeoQHsdeg3RbFO0kzKX7RlXwnzPswHOq0nqGQ5msOF5CqrDXwMSJ7vP0B0G4+U7pw5sITPYDwXX+iLmBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2rZ0fRpxvRq3tKqsDPZeq9ggQ41nDOyZm5nU5mqvoQ=;
 b=V7BVFGhiIZLdmEywesT+PnuCZLZ/NwlgUMa/3EPi3y7qGKO6/60gO6KQesdHE7IEwI3X/4qOSs+73oPukYYdFoiStVljhALWDCeUY/eMbbXTfp/OzmlwLcARc54ChyvQqlHVZYuYqZWGGQ3LtEjKgXha7FqwRcmWcrDpaQ8e1KF+uNn4NXFtOsLg2mnTCkoNJetYX7nJ2v5LgoKZnvcMIiX/BdgKmIzYk7qpetnsP4GygT4uGkEP6XvHNttMOiItJDaWJpqJfIiIAMYuB2AIStsm8MZaZwZljT/ukCHh9LdozMsNSNbWGP9FlpABATyGriWSe5R/6oozaawuAEqSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2rZ0fRpxvRq3tKqsDPZeq9ggQ41nDOyZm5nU5mqvoQ=;
 b=OxhUm2/JV5T2BrtVpdeMWXGtL0LaumQcuwLc356py10hFvL0qNzMUgzgIV0lDJS0s4AFX+7G7B7XhJvmxEa4yDRppu1A/zNLX66kyhjsNhXF+bS+Avy2ljxoP65oLkt4OTZ4QBWUB4qTV5n7Pw4TNliYto3N3rUgGSX2CxsVtxE=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 06:21:17 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::76) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.20 via Frontend Transport; Wed,
 21 May 2025 06:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 06:21:16 +0000
Received: from [10.85.46.226] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 01:21:11 -0500
Message-ID: <592e4fdd-d4d1-450e-8035-6c781f1c3340@amd.com>
Date: Wed, 21 May 2025 11:51:09 +0530
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
 <77942c0b-c7a4-4614-b0a7-f8d047cb47ee@amd.com>
 <a04f20f6-17f9-4001-9f44-2d41cc9ca96a@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <a04f20f6-17f9-4001-9f44-2d41cc9ca96a@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e5c8a7-680a-4bc7-0a29-08dd982fb1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|30052699003|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnE3VDZyck9SQU81bXQ2ZlBWcVYwKzRwNWp2NW9CRno1cmFTMnlLN09UbnBj?=
 =?utf-8?B?VmNML2syVFFIWWhEWUNWNXlJQUd4RDdQcWtjdG5JZ1FuaVJlRmVXVFYyYW4x?=
 =?utf-8?B?b2NZa25tOTl2OWxlSEZjZ21Camw3M1VQWmZtZW5GUzlQUDM5bnFYaW5UQkdY?=
 =?utf-8?B?SW9lcGx1b3FUYURSZ0QwdFg5M2VLUjJidkxzWmNTVk1TVytyMHNWQWY4dnhk?=
 =?utf-8?B?a3pSdVRtYXp1dkZyMTFnS0YweHhVVTRjYi80N1FrYjRuWmR3NzdJYjVjSGls?=
 =?utf-8?B?eXlFcHJrM1EwV1lrb2k4dG1hdnVzSFVoSk1scmRqNURGWERpUlg0R1lvcExT?=
 =?utf-8?B?RVM0VWRMblZibjBhZmw5Y3pFUzlIVWdKOVFTQUFTSXU5ekJBeGZneHZScnRD?=
 =?utf-8?B?UkJENXZhbXV4V0E1dWloUjJNMWRDWEtHYjBFTEM0cktZZXZuVnhPN0ZPRzE5?=
 =?utf-8?B?V0RPUzErdFREYWh4SEhRRktvMVp2cHZhRWtZeXcxaGxJL0pJWXJEcTdoQXBP?=
 =?utf-8?B?UTE1dlZBSWRwVmV4Y1plcC9CUm1wK2V4Ti8rK1pXTVRKOTZaRVV3bGFiRGlo?=
 =?utf-8?B?Qm9yZlYvQ3J2U1YyTnlxQzN2WkhtdTVzUDFmb2tESkExMU1aM3dOWmZpbUlh?=
 =?utf-8?B?NVJ4bmRpVWFoNWpPSHBKVlU3cktzbGhVRUNuTWg3VGlMYlU2b3ZJSThtb0xN?=
 =?utf-8?B?YzVoeUxYbWg1SzFucUR3Tytwb05qRkRCY0xSb0ZGRDljeDJpMDE5eXRRRURR?=
 =?utf-8?B?QkF4Yy83V3RzSnY4cEVNN3NVanExdlJvZUM1cExBTWJ2WGtkUUNVME1wcXBj?=
 =?utf-8?B?UTdZakdkSUErWU5nS2tydWM1RTQ3YnVSZi9jSmI5SWRpV3prVUo0SnpHL3Rw?=
 =?utf-8?B?Vm5uL214OE9XaUtaLytBeVNQKzNwK1RqdWdRTTF5NTMwV295ckp0SDZFcXdt?=
 =?utf-8?B?VjMxZ0hGeGM0dlJPTXlVK1RqZ2E3amNRNFNMQWJjelpoMTNPdWFjSFQ5MU1F?=
 =?utf-8?B?OU1qQjd3bWRvdjFvWFFMQlhnZXJGMUFzM2FuSGxFeWpBTGV0ekx3RUdvQ29i?=
 =?utf-8?B?MU5YdUtKZkZOWXhSYWRrN0FqY3IwOEUrRSthWFE2OHdMR0hYSzVIbzlueE9W?=
 =?utf-8?B?bXlXWlV6QmpxVHVpV3NaanpheCttSU1zVWVKN1J4MVRUM3hFYlg4dE9tTnBr?=
 =?utf-8?B?VFZXbytWbFN3R20yV3FuUUNQekdRRzNFL29ZQUdBaXRuQWlkOTAvSVUzZHN4?=
 =?utf-8?B?Qk1Vd2FzeFlrSjR5QWRHaFl3V2tKNmdUOEVVQVk5U2UxMERKekpLejlobWNW?=
 =?utf-8?B?b3ZEVGJyelpyZnp6aVh5NUxORzZDdjgxQkZqazBoQzlXek8wWGZLUnVRNFlI?=
 =?utf-8?B?cXRLbmNWdGcxK1JCTFREWFk5U1ZWbHFKVzhmSi9TaHZyZlNpU3pHdkNVMkVI?=
 =?utf-8?B?bTZzVlp4YUFRZTNqQXIyT3JFRDBsYzdCWHpTR3BtT21CbVcxMzk0cGJuS0hJ?=
 =?utf-8?B?NU1yUVovMUw5R0NsRU00MjUvYXdiRmx0OTRnKys5a3BGUkpScndSYTNUcU1X?=
 =?utf-8?B?eDE2NVNzcWVJdnlZK0JBdVdoWXVsemRydExCaVp3T0FJc2lhNTMwNVUwYmpJ?=
 =?utf-8?B?UDdMMlBYMGVUcTlwRC9meWVrRUJCRHhSZWExeGRETnZYTUhrNmlBM0VLU0Ez?=
 =?utf-8?B?YmRqcngrY3EyeXgxZ3ZFaUlHdFlscDlCVU0xVjhpLzMrVVM1NWxYb3A1TmYv?=
 =?utf-8?B?bnd5cVhkVlJhTi9wa3BsU0hKalhNcmJxNm1qTUk2RXRWVkJGMFNYeFJGb0lo?=
 =?utf-8?B?V25hSnZhc2pwWWUwOHpBL0RnYWtiUkdTdkI2ZTUzcGhNVjcwellUTjFNb0hh?=
 =?utf-8?B?NmI2ZmJVajk1L0pOZVRxT3NIMkNrSmNWd0pEMVJhVGVTQVRLN2tveGxkWW9i?=
 =?utf-8?B?djFLYnR1cGZnNXNTRUVCZnVjUEk1bGlQc2NJbFZpSHRBTTlwMGpZZ3RVdXlx?=
 =?utf-8?B?TEtvRXFsa0VWaEVBaEE3by84Y09SQm5pUG8wWHZ3aTBjM2tpRTJGNjRRZnBM?=
 =?utf-8?Q?/jl8+V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(30052699003)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:21:16.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e5c8a7-680a-4bc7-0a29-08dd982fb1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
Received-SPF: permerror client-ip=40.107.237.87;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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



On 5/21/2025 8:05 AM, Alejandro Jimenez wrote:
> Hi Sairaj
> 
> On 5/16/25 4:07 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> 
>> Hi Alejandro,
>>
>> Tested the v2, everything looks good when I boot guest with upstream
>> kernel. But I observed that NVME driver fails to load with guest kernel
>> version 4.15.0-213-generic. This is the default kernel that comes with
>> the ubuntu image.
> 
> Thank you for the additional testing and for the report. I wanted to 
> investigate and if possible solve the issue before replying, but since 
> it is taking me some time I wanted to ACK your message. Minor comments 
> below...
>>
>> This is what I see in the dmesg
>>
>> [   26.702381] nvme nvme0: pci function 0000:00:04.0
>> [   26.817847] nvme nvme0: missing or invalid SUBNQN field.
> 
> There are multiple reports of that warning which would indicate that is 
> not caused by an issue with the IOMMU emulation, but it is interesting 
> that you don't see it with "regular passthrough" (I assume that means 
> with guest kernel in pt mode).
> 

Yep The "regular passthrough" is guest without amd-iommu or pt=on

>>
>> I am using following command qemu command line
>>
>> -enable-kvm -m 10G -smp cpus=$NUM_VCPUS  \
>> -device amd-iommu,dma-remap=on \
>> -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>> -device virtio-net-pci,id=vnet0,iommu_platform=on,disable- 
>> legacy=on,romfile=,netdev=USER0 \
>> -cpu EPYC-Genoa,x2apic=on,kvm-msi-ext-dest-id=on,+kvm-pv-unhalt,kvm- 
>> pv- tlb-flush,kvm-pv-ipi,kvm-pv-sched-yield  \
>> -name guest=my-vm,debug-threads=on \
>> -machine q35,kernel_irqchip=split \
>> -global kvm-pit.lost_tick_policy=discard \
>> -nographic -vga none -chardev stdio,id=STDIO0,signal=off,mux=on \
>> -device isa-serial,id=isa-serial0,chardev=STDIO0 \
>> -smbios type=0,version=2.8 \
>> -blockdev node- 
>> name=drive0,driver=qcow2,file.driver=file,file.filename=$IMG \
>> -device virtio-blk-pci,num-queues=8,drive=drive0 \
>> -chardev socket,id=SOCKET1,server=on,wait=off,path=qemu.mon.user3333 \
>> -mon chardev=SOCKET1,mode=control \
>> -device vfio-pci,host=0000:44:00.0
>>
>> Do you have any idea what might trigger this.
> 
> There are some parameters above that are unnecessary and perhaps 
> conflicting e.g. we don't need kvm-msi-ext-dest-id=on since the vIOMMU 
> provides interrupt remapping (plus you are likely not using more than 
> 255 vCPUs). We also don't need kvm-pit.lost_tick_policy when using split 
> irqchip, since the PIT is not emulated by KVM. But to be fair I don't 
> believe those are likely to be causing the problem...

Thanks for letting me know, I'll update the script.

> 
> My main suspicion is the guest IOMMU driver being too old and missing 
> lots of fixes, so it could be missing some essential operations that the 
> emulation requires to work. e.g. if the guest driver does not comply 
> with the spec and fails to issue a DEVTAB_INVALIDATE after changing the 
> DTE, the vIOMMU code never gets the chance to enable the IOMMU memory 
> region, and it all goes wrong from that point on.
 > But I need to reproduce the problem and figure out where/when the > 
emulation is failing. I've tested as far back as 5.15 based kernels.
> 
> I would argue that while it is something that I am definitely going to 
> address if possible, this issue should not be a blocker. I'll update as 
> soon as I have more data on the cause.
> 
> Thank you,
> Alejandro
> 

I also think the same. This may be some old driver issue and we should 
not block on it.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>

Regards
Sairaj Kodilkar


