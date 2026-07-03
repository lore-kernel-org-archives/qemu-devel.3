Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D4AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZLX-000343-Uf; Fri, 03 Jul 2026 04:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZLW-00033c-BB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:34:02 -0400
Received: from mail-westus2azon11010061.outbound.protection.outlook.com
 ([52.101.46.61] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZLU-0002Cv-II
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8owi924IR5Jp0NQ2IbT6kdNKaxVh4Ym469GM/Z1qvDu4qV/DDN1YJ2HGMeWy65HLo8gtCHNmx/qzdiuyXAXxyZPsaUIiNm05Mj2Avj4YD51NKAMUeR1p0sf105UTPealmbKmacMALJWgl2he8LIoK1tFC8AR2GgWKiaG2NSYgMrPp8O5qc0qLobb+ReeO4qJIS+Kcw7I4klMaYTVZw+vGC1S8m0bTiQHFf/7/CYrF5Ms3LJ1ry9DYHJ25lhpBb1TmU7vq3TYe5xTKO1PjnA5VbAjiux2uLILIh4APeMF3a3Lo9ppS0YEtK9bbeF1xFkY9bx9cXggO12Dhguhd5RGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiOool052Cxi8H/gaUKe1g41ocin6dQBCcdHf5ARZsM=;
 b=s/Db13ogWn9orA7v+s+pQ8jhoI+RGINqEMF/bcecpDU7WKNKwFyYFNxgGK+NTMixj74qL2YLC6oIUtwXTLDwJCMREw1AxdByY1zL0d2WT0p6pJkVg0of6oOCl4RvarkRmbpXb1x+wOqGpGLE5p7NpTrflDm4s0Q5XnTproxu31xjeaOVVANXnmGbhStVS/PliIcrlHqM9gjAP4S0sNhhhxyAJllBD83EIyDmRGpr1AWp8CklCgkva60dHVvvTHvq8ihaAuLcJkD0GnXjpwNV/xRISpZfZVkJUe0j8bimju2+W/pv5lBXqiKcvRP0tXebM8/5/43mhujUGyeICtXaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiOool052Cxi8H/gaUKe1g41ocin6dQBCcdHf5ARZsM=;
 b=DjfnQQtJvG05hpoy/a6aBRDR7zFmBBnJ8tNgywSWS2Xv4AoXjw2ev7kSIxs8EtwZoG2xOFQMv3W3UFmZjeY9aCXxdxbPMG2NSvzc0CjqCDH4Lqac4iN0SahJERgn/h9BXpMgfdzBLB9Tqx3rSUdvLI4uTOZtlNlUytyGg9fCUJI=
Received: from CH0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:610:b1::11)
 by SAWPR12MB999118.namprd12.prod.outlook.com (2603:10b6:806:4e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 08:28:53 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::39) by CH0PR13CA0006.outlook.office365.com
 (2603:10b6:610:b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 08:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:28:53 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:28:51 -0500
Message-ID: <bac12de8-8957-4c8d-86e6-b28e858be8b1@amd.com>
Date: Fri, 3 Jul 2026 13:58:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 1/4] amd_iommu: Do not create duplicate MSI capability
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-2-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260609204403.323149-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SAWPR12MB999118:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9a8d89-4f2a-47a5-bcff-08ded8dd1e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YPGnbP9vF32Ckt/wIRl6gV6zsa7+Mkirvn5+YC44UTT5sDz6T087+HygF514VSlDFnZhCO42gZKJsPU7JRjMAXtIano9Jt3Gb/jTkZLFnQ97DpBqV7LTWSC5kvwRLvb/FsQN9ZpvwKY6nMj5i+sbiZL+RiQgmwNcjMu2STbOj7rUzYGzs0WqVJo2+NJF8xK3/QbHqIIC1HRQyfgRuW1LQIYdQT2s7GrvK3b1hC545s5n/dud6q6T++u7cX/Ibjd5egI2YPYvJdTlAigqafDjHnAPsGVhc4kY/P1ftJc2BfT1uFNAC9mfngSw2LSWpvBt3E4Y02X9eHhvHDDm16PHDPSUu64Cavu2dKPaq6WY6p3v0RKXDd78VGFcGeys+V746u+G4qhUJwWgoQ0wuM4veDqrd0Q0OxKtdGYrb6Z4bfwVaLBafd/GBOdccX0/rcDzLCN8ocvYQDu3JOUiOjuDb2i60ZMRcyuAebaaDSQBMli5KMx9pleEfq5p7rc9rtFZethHzXqcZEneRIOVi8j4TdHp9rz9lm69/gEmUnMuhVwnC+ml5KcLqBDXNa+DyUb2ZGd+loCinwzxVmnjr41SkNI3bhYEb1zGOr1VoFjSUESIlavqZux0Smoe8Dmk6oHCIoBEoWiayuYUd2CzTKuEsX9H6msdWhp3ubOXISIR6kc4M2gqLu38eXzk+pltO3CrXitoHIP/N/m+8HZYd1AG7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nQOyJFR83Vq7sMZFNnQNk3FjnvE7159pMbjDLWNxMp4dZaTZIIYFSrKzt5kTquXzD3GomcdVAHCfd2c99jJHvHJzZ9u+JqCkjE49axz+NntrVTbazLcbA2uFi8+NANZaTSr054ndTinKCm1miWRG+WQckaZlZQd6Nn7OpjQoBM21Tb/JcRpOpnTCy4E09tzTG3G2tRal2q4LAhnN7K8Z2z0X5b4nzUiye9uW2VYDzsb1XN50DouHf+MHIVOSKg4cjHkZboqgn+GuVt498hKWSk5o74ae3xmCONzNcXgjeC27jhFu0FcP5y8S9gJTwhpEhgwzkNbrH8GnWXf5dGp927KTOYPS/QlxUsPojX9lJFSSb1hgBvuZ6LszYLRkIeCkIA8viorhF9uqw8UWD9fQ/DYsDd21kMIAg4d2JQJLIEsj+kYEael0DFVquZCxYM4H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:28:53.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9a8d89-4f2a-47a5-bcff-08ded8dd1e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999118
Received-SPF: permerror client-ip=52.101.46.61; envelope-from=Sairaj.K@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 6/10/2026 2:13 AM, Dongli Zhang wrote:
> amdvi_pci_realize() manually adds an MSI capability before calling
> msi_init(). msi_init() creates the MSI capability itself, so the device
> can expose duplicate MSI capabilities to the guest.
>
> Drop the manual MSI capability and let msi_init() create the single MSI
> capability used by QEMU.
>
> Otherwise, there are duplicate MSI capabilities in guest VM lspci.
>
> [root@vm ~]# lspci -vvv -s 00:02.0
> 00:02.0 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models 10h-1fh) I/O Memory Management Unit
> 	Subsystem: Red Hat, Inc. Device 1100
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin ? routed to IRQ 24
> 	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 00000000fee02000  Data: 0021
> 	Capabilities: [5c] HyperTransport: Slave or Primary Interface
> 		Command: BaseUnitID=0 UnitCnt=0 MastHost- DefDir-
> 		Link Control 0: CFlE- CST+ CFE- <LkFail- Init- EOC- TXO- <CRCErr=c
> 		Link Config 0: MLWI=16bit MLWO=8bit LWI=8bit LWO=8bit
> 		Link Control 1: CFlE- CST- CFE- <LkFail- Init- EOC- TXO- <CRCErr=0
> 		Link Config 1: MLWI=8bit MLWO=[6] LWI=[6] LWO=N/C
> 		Revision ID: 0.00
> 	Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit-
> 		Address: 00005808  Data: 5c05
> 	Capabilities: [40] Secure device <?>
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2..997d02eab5 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2422,11 +2422,6 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
>       }
>       s->capab_offset = ret;
>   
> -    ret = pci_add_capability(pdev, PCI_CAP_ID_MSI, 0,
> -                             AMDVI_CAPAB_REG_SIZE, errp);
> -    if (ret < 0) {
> -        return;
> -    }
>       ret = pci_add_capability(pdev, PCI_CAP_ID_HT, 0,
>                                AMDVI_CAPAB_REG_SIZE, errp);
>       if (ret < 0) {

This qualifies for a fixes-by tag

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

