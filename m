Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E0EC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOuQZ-0003Kg-Jt; Tue, 10 Jun 2025 04:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uOuQX-0003KF-TY; Tue, 10 Jun 2025 04:33:49 -0400
Received: from mail-sn1nam02on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2406::61a]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uOuQU-0002gc-Ta; Tue, 10 Jun 2025 04:33:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxS4avm8zyDWBKEI+Gkcl/mKxmIxEwos4YPQ38eebAhLiz8kRmvrdWWpqUzE4jqz1ip3QWOCwb6U0CwcD5sN53PcNpWdfZ0Tmbx8gw9xwN000TDbVEnNXTr7uIWO9Jsp1+w0okhPbth9qXAdfFl/gDAfJ7fVgYx0yD6hFrTMDy+JjLfuJsOt6WyHPERvgm9a+i/L/uxb7vAiDPYRNsXBMO3I/WbW5l8tamOKCTdoLOpCz5f2Lg2YfJ9UdepTNm8gTRc4TboOKAUmxPZAanhqx2wHdAJDpMgqzvSBpiMC8I4lovdn/EJIV0hAmn0DEVSU03bQKPVuH2YVCyxyt+MUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPkOr3nUhvgNxfBJgjSsszJQAkBD/HkYnTMlblhx87o=;
 b=PjOMlpM8YdwCoZw6Fi6FIsJItcqtF//LWBXKf2mIOtEET+zVLsMP4owvR3u8trknUh6972775hIw3umNpDlFo9jVjoFgX0DzsX7kDPSHN29QKqzwZeh0NgchChVyj9qNH1cVf5htwR5XthIGU+6RyrtfH5khgrK3BgPf6naQZgxB8RD/+ZlD4ZRIAzjD8nXGDgNgh9l0608VWVEf571ngaDs4U/5PszuI8g+zV1cF+WrfYLwXIRCwenCt/Bt8FCk9tJVJMNnbtq6p/B7VO3AnOxOnfrUp1BQupjhZiVjguHF7ft/dJPGcLFmEUCvaaIKm0sY+ruRbS4/5gW35ydAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=tls.msk.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPkOr3nUhvgNxfBJgjSsszJQAkBD/HkYnTMlblhx87o=;
 b=sjuUhrKPvovD2oWSbPXgfW/PiM2fcrQa/F5qH3fQUAhJjl6KjyVjOCJQzQHH90qshveQTvvxqFXmNyteO2IZBE2frN/SSk1OVdC8I1JwKQ7lX4aphlRKVqJTbxPltwsprgam0x75KCKFaf4Qx/47oa/BeN/8oVMU6EUgfoO3PPQ=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 08:33:36 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::13) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Tue,
 10 Jun 2025 08:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 08:33:33 +0000
Received: from [10.136.40.159] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 03:33:30 -0500
Message-ID: <ff1aa145-161c-42f6-8b9d-5057a89d4e12@amd.com>
Date: Tue, 10 Jun 2025 14:03:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] amd_iommu: Fixes
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250516100535.4980-1-sarunkod@amd.com>
 <f43d5b05-39fe-497b-9166-098e37ff65f1@tls.msk.ru>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <f43d5b05-39fe-497b-9166-098e37ff65f1@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c279182-cdea-4618-d548-08dda7f97ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEFNWXZSQ2RpZEM1QjYycllpc0gzWjJybkp2aE9uVEhmYm5YeUpTT1RmT3VD?=
 =?utf-8?B?eUFGY1pROHgreG9JRitQNWJneEdlZ25LbFVGdTRWUDIxa0JJRkR3QUZXeFE0?=
 =?utf-8?B?VS9HVWYyUWY3WHN5dlRSUWlQdWNLZEthZXFvcEFCZHZxdWxoZmpnMGRVNERU?=
 =?utf-8?B?T3h4YUFHREg3eXMrOHFrRnVWYnVrRks2eUE5aGQrKzA0TzhhZGZWS09DQzZ0?=
 =?utf-8?B?RXo1ZGkxWWZIcUtYb2s4SGEvNmRkTEtZMVJwMm1GV0p1aExQb1liTit2ZnND?=
 =?utf-8?B?b2t2UDNHSzA2cVdxbEljMWIxMFJTNDJHWk9lWkxlKy82NTJwb2lPcHkzNTk2?=
 =?utf-8?B?b3RBa1pDYlhDRXB5R09YZG85VkE1SDJCdnNGcDBBeVpNVnF6R2FsSVhBYVk5?=
 =?utf-8?B?N1BPa0x0OGlObUZNNTJOTW5jd2kxQ0psVVlwOXoxU081NW9kL0dJQWhZTFZR?=
 =?utf-8?B?L3NCMDN5eVRTcDIxM2w2R2Irdlh3Wml6cERTSjBQTDBDOFV2QlNSUnFvK2VR?=
 =?utf-8?B?S3FoK3V5UHdSdS9Td2QzNFlvKzhGUTdVRUQvcjFCUUI2eWd3dFlHTDZjbVR3?=
 =?utf-8?B?NVdUVmo4NTZlMnRRSDBsTHNBckJJaTF1MnVHN1Z2Z3hNYnZNb3VtUGpNODhi?=
 =?utf-8?B?SnhmMkpYanVrUTFZK3hNdWUrWllSUDRsd1ljTER5ZlVHNkN0Q2JYSkp1QXdI?=
 =?utf-8?B?Tml2YUh3VGRWZ2dZTEtCS2dvUDVvRVZqUGhVdkhxQktCUm84NWRKUW5GSnc3?=
 =?utf-8?B?V0Nab1RHZGxNNXpPRWtoMFpmSkJIZkM0Z3lGQnpxZmI3VzFQUkdKY0VzVEw5?=
 =?utf-8?B?MUk3ek1PL25aazEyZ1JsM1VIRzBaNEFRaEFhaEFyMWdrZ0xkMXA1bzhiSFlQ?=
 =?utf-8?B?anJBdkQ5VG1SanlOWStBY3pWWEpIRjZrMG9qZ1U4bWg3UkhSdXVOUmd1T3JE?=
 =?utf-8?B?bk5UNVVjSGpJaldkUG5FTDhzRFJoak93Ny9WMHNxZlpBbHdLeFdkczlGcEll?=
 =?utf-8?B?cnh6Tm94MUJ5bnVxbkxSWFVtZXJkTXhySEpNVFRYQk1GTUQ1eWpBYW02TmY4?=
 =?utf-8?B?aXRKdmRhaFNqZHh0R09lYmhxcVUxRVBZOWZuTWU5dnFIQ0daSktsMXUwOEZp?=
 =?utf-8?B?ZFB3TGlxQ1dVTGJtQ3YxdUJCSWZBUEQ0dExEd25LMm5IeHVKV3RmM1JJVWM5?=
 =?utf-8?B?bXJSamkyT21scmhwb0ViR200bEE5c3ZiUGF6SFYrNERXRDNHbnpSWGtZZkVC?=
 =?utf-8?B?QlVJTng3K25peGZjTG5uNnFJc1BWZm1BNEVQQi9SeC9vdWUwZGpqc2x0d2Nh?=
 =?utf-8?B?REo5NmlhSmtlMkpOMFhEbk80bk0raHZmWTJ5aHlETGRaVWJwN3BZRFJJZGJV?=
 =?utf-8?B?S3E1cjVIaVRMVUZyajhzTGdrYVdtY0l3QURKMnQ0NHRaeHNLTkFnbmJjL3B3?=
 =?utf-8?B?c2F4UzhyN0UrM2JLeE4rdXovbXJYN3VSckcrbGxWYlVRMGpWaXpxWTlCbnhv?=
 =?utf-8?B?UFhvNEdyZUtLaXp5UHFjNmdLQXZ3T21YbUluRFdUYTg4Ri9GamdjRXMxdnRu?=
 =?utf-8?B?K05VQjVzN3dKYm9MM3dWTDhIL1RqSTF1dVduNE5UQmZkckdsS0RiS3g0NmpB?=
 =?utf-8?B?RmtvdU15WEk2VEdTMXVHTjl0MjhJdjVQREpCcjZablBBdnE2NldVWnlJM3A1?=
 =?utf-8?B?MW9HeEE4bTVBQjNkZ2w4SFhQUTI3SU9SbTltUm9xU3hEZzM2R0MzOUlzdkh0?=
 =?utf-8?B?M2ZjeVovYy9PNVFsYVh0QUZPRXR2TmtoZVZxaEp2eHloeXBGcVM4Y1FITXpM?=
 =?utf-8?B?UFRQc3psRytweWo1dGQweWV4TmRROEc4SDZlNmZaWGtRdWl1cmszbGJZSk1v?=
 =?utf-8?B?aXBycXpxUkNHOGJpeGovSTlDTFYxL01ramp2dWRqUUNFa3NuSGxTakgxbmQx?=
 =?utf-8?B?b2gvbUM5TnJQR1NSanNNdy9lMjB5dXZaVXQzZE5VSUxZR2J2blJFeTdVdy8w?=
 =?utf-8?B?cDlxTU5JUkNVc2VxUG51a0JYTXlEaklBTHlrR3R0NjdEZysxaG5WQ1F2cFYv?=
 =?utf-8?Q?CZN5Q+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:33:33.5640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c279182-cdea-4618-d548-08dda7f97ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
Received-SPF: permerror client-ip=2a01:111:f403:2406::61a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/3/2025 2:24 AM, Michael Tokarev wrote:
> On 16.05.2025 13:05, Sairaj Kodilkar wrote:
>> Fix following two issues in the amd viommu
>> 1. The guest fails to setup the passthrough device when for following 
>> setup
>>     because amd iommu enables the no DMA memory region even when guest is
>>     using DMA remapping mode.
>>
>>      -device amd-iommu,intremap=on,xtsup=on,pt=on \
>>      -device vfio-pci,host=<DEVID> \
>>
>>      and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
>>
>>      which will cause failures from QEMU:
>>
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command 
>> list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad 
>> FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command 
>> list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad 
>> FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command 
>> list buffer address
>>
>>
>> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because 
>> amd_iommu
>>     does not enable x2apic mode.
>>
>> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
>>
>> Sairaj Kodilkar (1):
>>    hw/i386/amd_iommu: Fix device setup failure when PT is on.
>>
>> Vasant Hegde (1):
>>    hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> 
> Hi!
> 
> Is this a qemu-stable material (for 10.0.x)?

Yes it is

Thanks
Sairaj Kodilkar



