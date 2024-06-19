Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65A2C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJj68-0002qz-Kg; Tue, 18 Jun 2024 20:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJj66-0002pw-8y; Tue, 18 Jun 2024 20:22:46 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJj64-00088y-30; Tue, 18 Jun 2024 20:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diJcjUYft7v07t2b3ErWXmhvUdHDxeyVU2XRxMq+bd2jY9BUMgSFLxcbqFH8+mvDa8MlU6dCvyUIYpYQCSgrm3Ykm4YyIZvD/DdUTXzAlxDSUSOjgpGG3dgbE5vlYz3KEFKKpQB5264f4CnIKyeztQz6yE6MMr1NUpImKKE7cSx6smo8gHLTNTRcgYZuX1sYPJYfvlNlCsOzf0J8lUDpJjwmBEgQ+vGIFzQLV7C2KLZFdtGE4VRHm7y1R9Xk6OOFvXp2uP3IxQXfoABTf0qHIead7kVOpXim+rYMTB/7+kIsy1kO/PALAfrVv8xaPV4NNvDXLQ/hULIHYT8QDA8mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYa5DgS4iz5vAhj9GhMi49jvzDT04jztH6e4QM2g2vI=;
 b=E5ZVfDrx1PynzkwpUmkfVmo0Twk8jKMDGiq81FOW04kbKwp2nGb1YMrwOsNapkiwmCUmAlL9uNIxYItOl4aXbbNFuPg3oZSu2ema3xqXGjamMfgd1dxTCzHXmKuZop4JSXEiWb+SJTxTKlOUUhUN8511E4sCa5gULC6Lg7T91EIk4qDychbibmdegdeBfh36Y7eMxAG+GTm8OJ3+57P+v8ZNy32elO+LGl0UJmTqyrKqHrPp5dlXb4L5jii0UIy/Nv/uVgZifvvdCY9N56LYetnsZuZ4EKcAVzABvhYAqUdYWAaMfLLNKsIMhxPV2ve693Vk7MDC95tnEDY0lWnTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYa5DgS4iz5vAhj9GhMi49jvzDT04jztH6e4QM2g2vI=;
 b=cydVVm/Id7ebDxrG33DXLIlKvDdF3FgkItt6vw0mMST+tPlM6ijjrBtI2KrUB5VsqDAbuSl3eIMPnnL6EmzzFtMCFTq1xoukLQETG2n06DBPsItjulGPeeHcpHMXEQftGBET9kJf1therk3p1WLatRTruYLRlyPGFKRI85eRNEAhdtvp5XgxElhCa2yFqyHlNegBbxIcItRO9+5x0jwn90vWTpRptVX+U+aqYoMKB+GyXRXsjVtQIKB3FCxJ7q81Lr67gZWhOPW73vOGSU4QMmu8Ky86IMZGk/otHLV/jrurzv/6NJEGBl7YMR+eUceAX2dQlefmwSn1hwVphskcOA==
Received: from CH0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:610:77::16)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 00:22:35 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:77:cafe::34) by CH0PR04CA0041.outlook.office365.com
 (2603:10b6:610:77::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 00:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.0 via Frontend Transport; Wed, 19 Jun 2024 00:22:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 17:22:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 17:22:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 17:22:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <eric.auger@redhat.com>, <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH] hw/arm/smmu-common: Replace smmu_iommu_mr with smmu_find_sdev
Date: Tue, 18 Jun 2024 17:22:18 -0700
Message-ID: <20240619002218.926674-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 18484dfc-ba97-4d9d-a8bb-08dc8ff5eaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|1800799021|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTpGAOtTjLD83S0A6vyhURwnApD4IrI5+PnvaRm3mYNK3cuQT9peHdrRBamW?=
 =?us-ascii?Q?ycYUNbuKTIzlujKm+aTzPwL5OVFSmhXz2NtOokl9h1WsnG/cDmWkkqg6jVYx?=
 =?us-ascii?Q?wefJL3pD6jbTj33HvEjAyLyFwOgE6NWLc3JqNds0v9WZI/NMRNn4Jia4oxZB?=
 =?us-ascii?Q?F9z5maLJu2WnH9gcl3vZ7f03bBqniRn8RcXv1cfMOf4zPEaqFMOL9/4pBK7W?=
 =?us-ascii?Q?hG39JfYMCnTjIZmug9+8FIr1Qxjt11SbAIecgheA+vKHjZrxfUW5qFnr667V?=
 =?us-ascii?Q?YirwFLHBQmWAz/ngkomjYrK3YyjyynzeeFQSG6rxjMVcPsdoL3cjRjDAl2sb?=
 =?us-ascii?Q?Qt/jHgOouJ6hvVX0OBZnWgj/aJalu8BdkBIziOq8UlxOFgKGUT1uza45BMPt?=
 =?us-ascii?Q?sac3ZRV9hKSiRx7XLJZg/S2kP3uCKUjj+iapa4HzYex8zsVARb8EFKrZoO9M?=
 =?us-ascii?Q?eWqEl+4vuooquHAiKW+jBibJg5DSmtabETQ76x4YdYCzt8sORjHzwsuT8cRe?=
 =?us-ascii?Q?tO0PuBpUXv0/zdUdA1pXCT/ZhANY9M4i/1ciN8cOi2yTX+IAcIVBH/h++4C9?=
 =?us-ascii?Q?fh3XiLzvpbnhxvvCaSSIhpZdF7aJfFHmO5feioUGSEI+1rowlpV/aGwBNRux?=
 =?us-ascii?Q?W3YYz6BaYJObbRwE4W+WRB09JJ2HrZLOTQNvM88cZrCuBOBfs9T94jp48f9G?=
 =?us-ascii?Q?AHKrbZezTlaS851DGr9sLdEPJq7jRmTz829n8Y5NHBdIxZyRZ0KV8Ztlr/af?=
 =?us-ascii?Q?92ASOM+tQw3zNkqMZKNsUZ0IuegMeOG+tzoxBOcfMdF+rKcpvewazD+n8+LT?=
 =?us-ascii?Q?rS2m0o4o3fdG8FtQ09/tXycisYBBxcjZ9o3G23GqC2sLZMTtuSefnKvGiCji?=
 =?us-ascii?Q?luSKxiQUI4tJfItcxE31YUA2p2AfCTsmoAOb3i1iknK3w1Oyf4OS7i+dBlp1?=
 =?us-ascii?Q?H20kq4vQtAhnvDcr50c0ehg8ModAs3ift8CLEhE80BwkvV8Y+27MWAEfdRb/?=
 =?us-ascii?Q?2xGpYe8ILr6yBlkmhk/z46QVQy4Am13ImEBM3I6xRZxYvNLWpxkyikz7rDJh?=
 =?us-ascii?Q?lpWtXH7Hq0eji7QK8IIuRe5pcgj9vhYhpo5bjqawa0hxMWET1S++OpQFpbvO?=
 =?us-ascii?Q?Ck63PghM62JsEjy6MZzDVpgYN+Tgazq1Zdad3k8la5xdPH41sAj/wV2lOz5r?=
 =?us-ascii?Q?kh7Id6zey++sIqShIjDreu4earzCjKlA4yMGzL46rGcokTDlbgoEiRL5FFEa?=
 =?us-ascii?Q?OpJ2k+p+BILUSR6NEWUcrxbZiV3m9k6lKEQ/UKWingxOf0rfpB/g6AC0ecq0?=
 =?us-ascii?Q?Fj88qQzpayORg0sLpRtaocF2peshZ7rDkSHpfKV1AOnL91HpZl2td/r5LVl2?=
 =?us-ascii?Q?RU4dAqHB5YrojCfbky3wy2Bppp754JZt+BvaQL1EibHN15xrlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:22:34.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18484dfc-ba97-4d9d-a8bb-08dc8ff5eaa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
Received-SPF: softfail client-ip=2a01:111:f403:2415::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The caller of smmu_iommu_mr wants to get sdev for smmuv3_flush_config().

Do it directly instead of bridging with an iommu mr pointer.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/smmu-common.c         |  8 ++------
 hw/arm/smmuv3.c              | 12 ++++--------
 include/hw/arm/smmu-common.h |  4 ++--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1ce706bf94..b6601cc102 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -620,20 +620,16 @@ static const PCIIOMMUOps smmu_ops = {
     .get_address_space = smmu_find_add_as,
 };
 
-IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
+SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid)
 {
     uint8_t bus_n, devfn;
     SMMUPciBus *smmu_bus;
-    SMMUDevice *smmu;
 
     bus_n = PCI_BUS_NUM(sid);
     smmu_bus = smmu_find_smmu_pcibus(s, bus_n);
     if (smmu_bus) {
         devfn = SMMU_PCI_DEVFN(sid);
-        smmu = smmu_bus->pbdev[devfn];
-        if (smmu) {
-            return &smmu->iommu;
-        }
+        return smmu_bus->pbdev[devfn];
     }
     return NULL;
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2d1e0d55ec..445e04ddf7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1218,20 +1218,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_STE:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
+            SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
+            if (!sdev) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
 
             break;
@@ -1260,20 +1258,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_CD_ALL:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
+            SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
+            if (!sdev) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
             break;
         }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5ec2e6c1a4..687b7ca132 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -182,8 +182,8 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
  */
 SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
 
-/* Return the iommu mr associated to @sid, or NULL if none */
-IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
+/* Return the SMMUDevice associated to @sid, or NULL if none */
+SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
-- 
2.43.0


