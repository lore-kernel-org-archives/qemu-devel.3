Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB387C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFrxl-0007uk-VC; Fri, 16 May 2025 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFrxZ-0007n1-6w
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:34 -0400
Received: from mail-dm6nam11on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFrxT-0006tW-EW
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg+kAEAfpV+C3zmdA3LP9qsgYV8A8ftMIzZnHnWEfZKAIigIICjkocyKohg8a/XUT+fVOQwgDJhRBkPErLBJ52Hs1g8cBPL8LJTdbmRVVX0yvwiasG0Nh6aJ06bO4UgLQjQnFNphpZ9BVE0XvRP1k0Na3qVf2FxR3C4WOmxxai8/XdAzaXxB0vqRQVRgRh4s+pR9SBChCP1njnnZgSA473cAdcoPYgk7osHokERGEIS4ZnBu3iwKl1PjvI6C+ADyIlkceoDwyUTH0+6w3E0Nam3y7fETm1NQdavGxwd74fn3EhywAcPfKauImFrNzG8qjDEGVaZTf7NhDdPq7JhduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mx2BKDEo3zrHxtC7Tzxai4k36XyrRQyMUuKrCGRIq8=;
 b=jbbDAbQcpoKzkWgg0Bjdv7h3nqzpslTheRPGwHvZo80pBRi6NGKZ8rh8Zt3CmJIF3CPfGqBcufeOUcNS5AAfb8yR1+EoqBC2jqOqSfC1kVEKppkVI8kTTY1totAtsZWWO5IgDPpfEA/aKH0QGv3bOwA9jeNaQM3XN6JBbOFGRJK7Fli2znuhdxx5g1DHeeOh6/+v716XSpiwo6yfSdwywl11ZpywwcfSruRiCQXSPgM/rTfT8JurVi7YsTxDM5t43rvYIRpml8ArEXXagX8mlAmUssWBHwFN5OohpK4b38LZMAFqHnUwOZr0AE5xyYI5wNaac9SrbIhZfMSZD44JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mx2BKDEo3zrHxtC7Tzxai4k36XyrRQyMUuKrCGRIq8=;
 b=hyBRi24Zx9Gi0v0iXJTX1N0sAEsaaYptRQ8YMz0Yvdlcil9bR9nHvcZqbDkan/EUvUJN0sno/71BZkv5PR9zy/PdbSXe9YCyr9mpOOQuUOzC9LqzorFG/S1/NhTnOYEROE4i8v6ZbqNSzicWv+lVQi0fw3DDSBaxp29Mgna14Kk=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 10:06:22 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::59) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Fri,
 16 May 2025 10:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:06:22 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:06:18 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>, Vasant Hegde
 <vasant.hegde@amd.com>
Subject: [PATCH v3 1/2] hw/i386/amd_iommu: Fix device setup failure when PT is
 on.
Date: Fri, 16 May 2025 15:35:34 +0530
Message-ID: <20250516100535.4980-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516100535.4980-1-sarunkod@amd.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e33f2e-183b-46dd-fb2c-08dd94614f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E5Nd1ZrdsX3TxJi0U53yso6XXK4NAgZauAcK2qAOjXJzytcrP3+YvclFGp6v?=
 =?us-ascii?Q?pzCZIYL8vCBlSdquUCuMVMgdgDtd6AVtxaCj1ptr7+9DkHerG8PPd6wAiVIB?=
 =?us-ascii?Q?zf0SiNYHEQbVcJUsFoItsJV9D3494rz0xkA1xSX496e2P3vsEjqANihA/3v9?=
 =?us-ascii?Q?D0NBef7geAKJ26LKH2PHDFA6z3pzzq8OWW/78gzj6JOPZgD85yV7DQI9kQfm?=
 =?us-ascii?Q?TancLEmL7Tk2y/Nm0X1yy5iJTJ/+sjNrkvhaNJYaj95xwU+NgZWpChb0OLTz?=
 =?us-ascii?Q?LLT4CCl/2f7pzdzrFIMXdkF1wyj1JJv92rWsbTx7WMLq8LW4RJOeN2y+6iyW?=
 =?us-ascii?Q?MWBqjmQMeqeWcLLlIKuoSVfDhMPi1KeAKjaWGZW20o/00QDaPXK/bSsth7aP?=
 =?us-ascii?Q?wSxU+HIccqLakam6MDw/De0n41iUxnyuzvpm35kJpl24kMgTpew+K/GQMLb2?=
 =?us-ascii?Q?X0G1MpvPSw4it2mlyjoyJ8BB/9qMR5BmCktXb3Eda4hzVcx69G8gkq8iChI8?=
 =?us-ascii?Q?sWOi1jtXwmZ988T8QeLGg8V6e30ESpQNcqw1miaoaDUggfr+QXqaub7Cwkdc?=
 =?us-ascii?Q?yHb2MKPDWfmlE8SxmZkYbB3VhZ6tWVX9NEDdgvFaR2zdrEpFn7ozKpo6zATO?=
 =?us-ascii?Q?jwHQIQX7Lww28r4/0pYDC//6zxmq3Q6Ulm+5aqaGv1EyHX0Fu1F4coKcMd0e?=
 =?us-ascii?Q?wQgGDYF66kn7YB1YQwlxJDWfT5Qb2aKCMThGlTsGWRJZ4mXjlKm/iLaumNca?=
 =?us-ascii?Q?hO6Lt8DyEhUG5YFEdF2lO0pyWK7w9uiFYkTHbppePB36g0e6+z9k+4p5b5LW?=
 =?us-ascii?Q?4b+qFoluPYaKnC921qgYA/rIrw89kL9kpbt5mDpgoIl0ckzuDmieh9JP8gzN?=
 =?us-ascii?Q?ZRD/fiptWFby8x2Kc2byyaSEB4WxrtDDROcKVHeBmw3AysaFOB05iqhgvgt3?=
 =?us-ascii?Q?WdMFdCzGlnHffTZRYJIj0hTfXJl2ZyyoyJh1AtxN0XSrIU31NKFez4HT9uBs?=
 =?us-ascii?Q?I+28aDAluCgA/OPsfgS/woZEi+HmqNYZJ4680cAtnbVymEWX0xjrtM+oO/U2?=
 =?us-ascii?Q?qaXMIv7RN+SGxw+70jFDWVjAAO//re8URi1jgpRmDEqYxE6K20/fOvfJZcZv?=
 =?us-ascii?Q?IYOM+Z1/ow6jUCnCNvgz6Upzzv5UfgN+snfybGNK6Bx/GpOd10R10uXjrA31?=
 =?us-ascii?Q?53W5oYUUz6FII5049cEEtf4JLzt/nidU/qcMZhNADp3xiFZAvcaJiJxx9Ltu?=
 =?us-ascii?Q?mEIhBcVUW3+hqQzdUbfedhB+WGs/EZdv+t9E1MwUvmUC8AVt358tgTktuETr?=
 =?us-ascii?Q?6r5xXtDv7c45r5NQ2FtKFPd0vd9ADe5UpxveCnC+OV8Y6MEBsISmzJLCG7QY?=
 =?us-ascii?Q?opiVMfN3YtVS/N1RNTImfXQrm+dlBkCT/2/WIONCd1BtbcHdlVx7apIk4+1Z?=
 =?us-ascii?Q?6AtJd3jbQxslWoe/2pW0fB2mXyoPgxzfEpGITYTaYQUtxHiFmtMLE48mL29V?=
 =?us-ascii?Q?Uxlrari1B8GXGDN0DRMogN2kc8I0tF9xTjHc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:06:22.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e33f2e-183b-46dd-fb2c-08dd94614f8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
Received-SPF: permerror client-ip=2a01:111:f403:2415::61f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Commit c1f46999ef506 ("amd_iommu: Add support for pass though mode")
introduces the support for "pt" flag by enabling nodma memory when
"pt=off". This allowed VFIO devices to successfully register notifiers
by using nodma region.

But, This also broke things when guest is booted with the iommu=nopt
because, devices bypass the IOMMU and use untranslated addresses (IOVA) to
perform DMA reads/writes to the nodma memory region, ultimately resulting in
a failure to setup the devices in the guest.

Fix the above issue by always enabling the amdvi_dev_as->iommu memory region.
But this will once again cause VFIO devices to fail while registering the
notifiers with AMD IOMMU memory region.

Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f9b95279997..df8ba5d39ada 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.34.1


