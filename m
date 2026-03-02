Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A835AE9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1od-00079D-Sy; Mon, 02 Mar 2026 06:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1ob-00078K-Rm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:51:57 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1oZ-0007Uo-IX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERMbTqUVknxl+1zyTxI8PvS+DYZWcDA+x8678HDMQRu0eioG7eZAGX60ePkntEXXj5+i6fMbQ3NAFku1a/QSk3yC+ee118xYd7NlMh3T5ABQv4oT5xbnJ728ulqpVZiH2sZ7JuGJ2rI9s0Kc6fK3arskch8WvXFQ9bGKP/M7F4hWB5cqlsCSvoLELUags2BTFqhGFKMoAxSJHjCvDsqpJylnfs6FFOebvrAjU1GyqhOpC3YwZQZqauoxqcRYarLRij/TPLLsZeDcYeQaOFUANs3mPhjxiWXPhDxf3H1ssxNReLIkq2DECDvjehzY8JCEwwADu3sSezmIT12m8GS+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAdQ71K68SPu6q8bK4L8XcNlzF67ErSu1fh5R9Dj+7M=;
 b=GMgw7dCoOXjYTNxiygjdRpozE0sAqf5htlf/qNo1d/yWQUC52l627khHFG/IqMrOitmHQ5zBNK4Y4R+MMCy/tmbve2TdP2rKB6++XzINfD3hyAJOg/25BaPwkTuAl+gOw9I4b5dfglsylf+S3BjumagqwhApcIVUvnkgdl1KoG4GF6mqMqcJ62bV4LNuSU607iOkMRAF+LU8fkHqns+iiKqmvOmzrKrWhesTkX4FpUZA9QSWNO22dCthqSbBuJgvXP9qh5iheNXz02SgDTjnSR7911lZLM8AQAghmvsdayYowhdv+HyGHtWLWcZ+clNa54nIa2VZTcCdK7qAsCDbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAdQ71K68SPu6q8bK4L8XcNlzF67ErSu1fh5R9Dj+7M=;
 b=mU5nEqHXGX2JuCxCFfZ2gxZJaot7+RQjbkhrhdo2t+OrmrbeYRZoEk6IJsdwy22s1J8zTnUbx+6LXsPvl9RfgZ1V54B5QvL8dMy9673Ijk9mZGpSplu9RMDQBssCMv1oZ1BYUU4v1knK1gmmkvui8p+Q+SWq6woUnflETDcKwvM=
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16; Mon, 2 Mar 2026 11:51:47 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a8) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:51:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 05:51:43 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <clement.mathieu--drif@eviden.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v3 0/3] amd_iommu: Support Generation of IOMMU XT interrupts
Date: Mon, 2 Mar 2026 17:21:27 +0530
Message-ID: <20260302115130.5903-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0783ed63-9360-4b4c-1d4b-08de78521548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: 0KEnvJLmPqr/+DCVFF+yQVTxgsUR+ZvhWcQIokxQHpf9TOWP8O6Fzq6CPmXxpG9nnDCGLAX2TGN7Lw8um+nidCW9fu6sFwCEPmvUjJBZD6HA6Q5muWo5TdrjZg+gbNpbk295DW2XUJlV4RKzy69BE2nUceW/+LX/89z4S2q6wt3VIyRPO0A1Dm7Uqj0jRoowQUKm4uqCSDbYD13Q7HRV635KRn09cMK1egyG754AKgPJwm2Jf4MaUsmVjKp+gj8DHKXSh/mW6Ypgi/YiPy5LqC53D9UbRFLgNYt1H49YFovjkm7LrhrH1BZTy5rZUis/tAEHgqizaVqZ8ttSH8gRec5L05ZjHAPG2fwrdQtUf5NZwKk0SRvp00fUxzFWrsqg4beBX0JDk7B49367G7DGFwmkPo64ssmIOvx5tUQuZP75FlL6C3/fLB9R1W6bdJRYnAMFq+6H3VEy1orkH/zE4KJFVfiZKzXAa8USvY3RZPOFhigJPNUYP1JdZifwOXPDfgrn/bO/J0bYr7vP/PL5mBtIbJ3vhKEn9O8Ru8I7JSdCOgI9VgNnRjr5ahdTErpYZQMLKNrAzdzMHcTMFW4Ya2LM6vDOToFjh7+vejEm26sZYvaauvto+2WDXAC71Ne8IHMbTbNTx0/+1DtoO3Q19xrERHLntYIWFoZIHHdfnAJjbMi/PbYSyIDfLC6bbUPFGNdQjcDPhd2yXI7YOcbDF+xkoFKWOHtuqMFaibwNssFp74WXcBIQ+mk3o0UU3VFPCZJRZXiLDpmoF0p+7lwSbtk0/STXP3vLpUEUvx+CvjjrJLdtUwl5OGeS6RfF+bsG36pNUWTYMcDD09cs7/2Jh8zh3ZYsXp9ykGCH5QxK8jU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Iyc4tR7A3Ill/a3yFAD/ruiGfbuwn6AjNpwajS2UCNiUIfdTSKmpxGK//vxz3LS12UGyEw+sOYQm7BBJUEahiva5xl+4SJw83VVsJclOR70k4vyOLd5hfmbaVnveECIgm/Qai1ccNYCTECdjKgr3ADcPIVSG201KerypjS207Skk/JO/JuaIcqO+B8OHQRNIhMeWhiJ/CxX/IBAPkbyOWjLsoeNqgi0gMrHzM+kpsRV5gwHUu4f8Z7f2Xnl2jQwIWMskDiEBTW3iGf7SUdFFkBPGxPO8vAH73KDM61DUmA9zWyAlCNmbhlUuK2W/tx0IaBwj1PksheJRBL6zfiKX0eUqGTJD+DCXpOpwilrUEsN4s7nsu0WnVuIkESZgJqIAtKNolclqOMSdq/ssWrNbKKcqeHBLpC+eCfibuDQOxft1d7zplq4FxGhyKlEhaayO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:51:47.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0783ed63-9360-4b4c-1d4b-08de78521548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts when guest
has enabled xt support through control register. The guest programs these
registers with appropriate vector and destination ID instead of writing to PCI
MSI capability.

Until now enabling the xt support through command line "xtsup=on" provided
support for 128 bit IRTE. But it has few limitations:

1. It does not consider if guest has actually enabled xt support through MMIO
   control register (0x18). This may cause problems for the guests which do
   not enable this support.
2. The vIOMMU is not capable of generating interrupts using vector and
   destinatio ID in IOMMU x2APIC Control Registers (not supporting event log
   interrupts).

To overcome above limitations, this patch series introduces new internal flag 
"intcapxten" which is set when guest writes "1" to MMIO control register (0x18)
bit 51 (IntCapXTEn) and adds support to generate event log interrupt using
vector and 32 bit destination ID in XT MMIO register 0x170.

-------------------------------------------------------------------------------

Changes since v2:
https://lore.kernel.org/qemu-devel/20260129102814.4488-1-sarunkod@amd.com/
Patch 1:
    - Delete  amdvi_mmio_trace_{read,write} and AMDVI_MMIO_REGS_{LOW,HIGH}
      definitions [AJ]
    - Move MMIO_REG_TO_STRING definition inside amdvi_mmio_get_name() [CM]
Patch 2: Improve commit message [AJ]
Patch 3: Improve commit message and comment [AJ]


Changes since v1:
https://lore.kernel.org/qemu-devel/20251118082403.3455-1-sarunkod@amd.com/
Patch 1: Return string literals directly instead of copying [AJ]
Patch 2: 
    - Update commit message [AJ]
    - Introduce new subsection for migration compatibility [AJ]
    - Update comment [AJ]
Patch 3: Use ga_enabled flag while setting xten flag [AJ]


-------------------------------------------------------------------------------

The patches are based on top of upstream qemu master 07f97d5da04a

-------------------------------------------------------------------------------

Sairaj Kodilkar (3):
  amd_iommu: Use switch case to determine mmio register name
  amd_iommu: Turn on XT support only when guest has enabled it
  amd_iommu: Generate XT interrupts when xt support is enabled

 hw/i386/amd_iommu.c  | 144 ++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h  |  25 ++++++--
 hw/i386/trace-events |   1 +
 3 files changed, 108 insertions(+), 62 deletions(-)

-- 
2.34.1


