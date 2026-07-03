Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E3C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZNr-0003za-5N; Fri, 03 Jul 2026 04:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZNq-0003zR-57
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:36:26 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZNo-0002ih-Bm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQm7uyg4PSoOsQsE4TuESI9rhJwMEBXABZXSuo4o9+wgRr2q/qVMzRaCNpmO8CJYvYkP4TOIVNZkeait86tdk+JTuIt7zDTjcY0x2pep8E3PtAY9hS0ZiVNWFHkkVRvypBphFxo6k/CGAwUUbi3imOgPVgUJTFAfmp+i23Ro5LNP4T0cw0+0iE1212oE8BrpyJLb15souO8Aq4wyjHSKq97NDlWvjLGaHx0+E8FKFigy4lCb60s4jhRt2gHB2sxNrtLhknI+BTZOeKRsoLt3WIYE/sAcUzzoXqVkfxV9mcge9dBqEC8YZ1VTg9NonqsdhUcO8aUViQosUQCl8Cm+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRcg40UEH3YAKMi4tIM90+DQ+35au8SeInnfEbgJG7g=;
 b=xoTNjNEuwRvVE7VN7m82h0mxw5TG+unMp7ZtHoXfa4cOq7BwzqG7hSajCPsQTizEJ4UKjqy9HTY+s4d+xW+fUb1QWpyZNRKeuLNQm4sVdtg9c7VYlLwXxeAOSexFtUEady65Ndi1y3NPN8Lq1OgmODwz+hQxUFx/D8ANzD8d6FqXKyO1Hq2s3ubBFHUycxjMp3n8rkdPBr1xdWf59dkAAvcUWT7o1VdWVDmM7BKVQNFJtCp+++LuMnzZCxqBa74g3aYHecCS4jQSTgNQIzc3ZM7L6ADjdPOqkzIwk5uwE+thrKIdMerrrXbyuxPGAN+6fzREz5r5EQhUlnjh8pIapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRcg40UEH3YAKMi4tIM90+DQ+35au8SeInnfEbgJG7g=;
 b=Lg7A4ULk+gt0qgiOhGWwPwXzoTcOGsx9sI4ULaJ1/GxCHadJ8jv6kIBCkFavefE1kpR0XSvB4CaySt7lmNP1RxE+35mwGHqie1SV2SczZSWYtkFtZ5txVxB5zRsQ7DK6bbOC6lztSN/1XvP+5PU2jyx18npIwAGSxAjrZgOk7IM=
Received: from PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::7)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 3 Jul
 2026 08:36:17 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::ad) by PH7P220CA0034.outlook.office365.com
 (2603:10b6:510:32b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:36:15 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:36:13 -0500
Message-ID: <938974a6-5eb5-4b06-bc78-801dc0ca8441@amd.com>
Date: Fri, 3 Jul 2026 14:06:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 1/4] amd_iommu: Do not create duplicate MSI capability
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-2-dongli.zhang@oracle.com>
 <bac12de8-8957-4c8d-86e6-b28e858be8b1@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <bac12de8-8957-4c8d-86e6-b28e858be8b1@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e2ff8a-69bf-4eb4-850b-08ded8de25ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|22082099003|4143699003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XAlrXdUBP3hMmB/RoAF1NCl1A47rYru030nXfRDjZ7mEkETcnpxVZ0a0TJl+neEKNpEqe3+IPv85lY3YAFOkMLbooROoP/9zNbBPC9IYUGo1QrRi1El7uGLtrsjwkcoBxD+8HCE6VpQRNmzsOQxMY+lag7h61ouG039i+GbD0RoUSDrd453m068o3tCDc6cOTzUrpuqw+6pHG7/734Cu46gB/jstDPaazzF+41yBtpB/rmYeETMBQTP4RYE0n8JJolV6w29O4eujHrmfrx09jZxY0c32fKlHMNV3rjPN5JsZ720v40PlKeYqMOjaVrZBic8t/baDXEmT8v6kFgyjeDQq5XMl9ZGjNPDmMxFclDqglPKx5AKQ3C14Fsvzkxs3qCN7onhSoCXiFO6pxjcF3dZR5gziDig+CPvkOjvG8zcwAj1Pe0hyrf9e+uLQqGWJfkMTJzQiCwRcO3JrlcIVy7JtSRpgoNI4SQD6YzFO2GLpf9v8Cis1SGc8/jrEO3m20XA9jGg4jLb39zMJy2wsITCAeXmqvNa8cWREOrcYQ3Mf/cdIHnXLSBKHu5lTxIDxH0yRyxCtSxWzErT/C4uaaI8gVu2tGRwT8f+c8ABXDDWp1p7n9g3GzJr+Yu0LTKsVIdQEDXpFFSNYqDkFbxVdEMOgWKZr4U2JH/3Pdac4ODkmKJ+FedC2vyoGrWQE4WLEfcrq+yKTtLpHO5V7r3qxdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(22082099003)(4143699003)(56012099006)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GGMZbvOoaCyUw5xfz8l0d8Lws828ADDnD+ye4GSMAGKg+Zhb7EnEtT4zPfnTzeZqQUqYDMAHFnC5RAsFQpRjwQmwFc1gbNLkfaTc45mT35+FNxCQZ1hGpEuzF525Q8XNG3H9gfDRKM5nEXL5hQDiPKU8dLdHFeKFKYDXwwxg5stHlyxeVfbd1pdrP0TY7ZiuxU5rRcJaQEuvHq3idVdemuHd6yFAtDEGuWLVqTw1V+CPiui1ERiGlFaE/ttYZM+rU3h9lCVds+b77U8He1wjU3DaFTeI8XKdlbc8qy33NoOsd6Z6tmSPf6MKmt60M9c2YH/FsGuZPNvMenK6WB3hYqpqVkhi2DyzeyCzaC0VTvWLaRhxmDrdSpHV6VpXDHjFQs6OOWoxpN1d22fARhzN64aYiUDDg0GWepcLT+nHxMbUI7h9sWnIc0qQYu94Mujc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:36:15.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e2ff8a-69bf-4eb4-850b-08ded8de25ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Sairaj.K@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 7/3/2026 1:58 PM, Sairaj Kodilkar wrote:
>
>
> On 6/10/2026 2:13 AM, Dongli Zhang wrote:
>> amdvi_pci_realize() manually adds an MSI capability before calling
>> msi_init(). msi_init() creates the MSI capability itself, so the device
>> can expose duplicate MSI capabilities to the guest.
>>
>> Drop the manual MSI capability and let msi_init() create the single MSI
>> capability used by QEMU.
>>
>> Otherwise, there are duplicate MSI capabilities in guest VM lspci.
>>
>> [root@vm ~]# lspci -vvv -s 00:02.0
>> 00:02.0 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 
>> 10h-1fh) I/O Memory Management Unit
>>     Subsystem: Red Hat, Inc. Device 1100
>>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR+ FastB2B- DisINTx+
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Interrupt: pin ? routed to IRQ 24
>>     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>         Address: 00000000fee02000  Data: 0021
>>     Capabilities: [5c] HyperTransport: Slave or Primary Interface
>>         Command: BaseUnitID=0 UnitCnt=0 MastHost- DefDir-
>>         Link Control 0: CFlE- CST+ CFE- <LkFail- Init- EOC- TXO- 
>> <CRCErr=c
>>         Link Config 0: MLWI=16bit MLWO=8bit LWI=8bit LWO=8bit
>>         Link Control 1: CFlE- CST- CFE- <LkFail- Init- EOC- TXO- 
>> <CRCErr=0
>>         Link Config 1: MLWI=8bit MLWO=[6] LWI=[6] LWO=N/C
>>         Revision ID: 0.00
>>     Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit-
>>         Address: 00005808  Data: 5c05
>>     Capabilities: [40] Secure device <?>
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 789e09d6f2..997d02eab5 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -2422,11 +2422,6 @@ static void amdvi_pci_realize(PCIDevice *pdev, 
>> Error **errp)
>>       }
>>       s->capab_offset = ret;
>>   -    ret = pci_add_capability(pdev, PCI_CAP_ID_MSI, 0,
>> -                             AMDVI_CAPAB_REG_SIZE, errp);
>> -    if (ret < 0) {
>> -        return;
>> -    }
>>       ret = pci_add_capability(pdev, PCI_CAP_ID_HT, 0,
>>                                AMDVI_CAPAB_REG_SIZE, errp);
>>       if (ret < 0) {
>
> This qualifies for a fixes-by tag
>
Apologies for the typo, I meant fixes tag.

Thanks
Sairaj

