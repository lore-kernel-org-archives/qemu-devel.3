Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F639CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4dQ-0005dK-53; Thu, 20 Nov 2025 08:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dN-0005ca-Jg; Thu, 20 Nov 2025 08:23:37 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dL-0001z3-6B; Thu, 20 Nov 2025 08:23:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGiKyXBuy7v68shtfHsexv2HQP9sY6oept9V8wN3YSbdzYEQrbrhlrMg25z6Pa62jYP50R8JRujFLxHfaj+gST16t+lvhWX/eA6um2EmEJcb2prX401hK/6AMKE6ZB04FTQ1mKTh/EzOX9eAvVFubWFwKlf7OyduJ8xJypvln5Lf94MA9UO8+0IAvOY7oPv+8Wqe9pPe0Cyj6IOekoZ5loPBtp6NSuTYsnqHSctwrHrn0gAUiRruUvzK7Zy1zQtrLVq8i7JcvTFP6MuyL4cZQSOdNwVBW8Oi03luCZfJXI15zb5iRNuTJxriXeGNbHl89ekTsPhW0pgvYQFKgCDnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT2g5vF/5YuZRHXOXTenTet+4i7aaZUUGfb5MRXLka8=;
 b=M4PM/l/IHYcVSTe6utC7O8a4tRoFYRQQ/hglEknGXoSbUz1V4IYazzrvo+KA77qKz1opvCvrKndT1Gdz+wTSg96WaKGztz1qty9wBaNV36rPT256xc+53YqrHdOR4KFsR5BbAkApz/wVa/V03+ycgnAJAixJnTMVmgwQ5rYhC3kPtJRhyH1lbQI0s1/PX3pRPLsftW9IRbGAXJnHozTayyMNFPHhtt6oyvQaJSvHTqagVSJx1vgREbnlYyS9RSSeeMgVP35xvUHnfvxwMvtI9L+zShggy/SbAsPcYqbLiaSxJEUzUD1Qf3z6WjUVp1vgwDh9BYXLS8w482FKpnC8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT2g5vF/5YuZRHXOXTenTet+4i7aaZUUGfb5MRXLka8=;
 b=o0E61YHMerL7E5aZBCVLjJ6AzVNZSJ1hK91/3o0jikeNV3QIMqmYCAnT1SJr+SlQ2/loIxMsG6qgLQ3uM4hfcYX2A/tV+xtnd0b8mAyjGLkw+TpFuOwJNDAamo6lCiyxvlclcOPQssTGzXDST3BjhPK8qwHVvE9YmiHArghhwV0hPb3DBxF19qbbeDwfm9C9tCcXZQteglEE2BT67E5bCIQDB/0PIypNZ3yFVHLuqOddcpR2Do0S0v2liWVZf6PKImPLr3mrElOTFCiwJxipLJWtG8C3UGt52M0EWw0zhFOR2l+n/YVhdAm0AEvaCXSxur9J1vdO7VbCK/rLqfJYfw==
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:23:26 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::ae) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Thu,
 20 Nov 2025 13:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:07 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 04/33] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Thu, 20 Nov 2025 13:21:44 +0000
Message-ID: <20251120132213.56581-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3264196d-ba5b-4b62-3fd5-08de2837fd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9SV1JFT1FlTkhORTltYTdMS0hHSVlRZGpCcnlINkE2WWMrOVJ4OC93YWFK?=
 =?utf-8?B?YzdZYmJSVndiZ1M5STZkMWpTZWNLWXFZalJvczRqbkdMQWFqUkpIaW9EOWQ3?=
 =?utf-8?B?QTU1RTlyNnZZeHg2SnRTbHRhVmp0QkNrcHpLRDNzblJGRWlvS09vSEFEeERq?=
 =?utf-8?B?M3JYbS9Ta051M1VtY3F6QXVpajdwU0d2SEZmeS9iQUREeTllNVlrWkFodWlH?=
 =?utf-8?B?SmhnbkhjQm12Y0pSSXJNREJUWWJPMUhFU3N6eVdCUWhQQTY1cGtaTlJHUzZr?=
 =?utf-8?B?VDBkMTUyYXFRN052UXNtNVdQMStqZ2ZYdTR4QkNndHZtTDRBRmlxc21lVnVu?=
 =?utf-8?B?WlV5SVg0Qm1pQ1JETmI0ekpab1NHeGJoU3o2Rjg5anVIRytVaU9JbmpYdHpl?=
 =?utf-8?B?K1NTUUUyS01NYkduSis5dGptanZpa0hrd29LNGNZcTY2WFFpck1aL3d3T25G?=
 =?utf-8?B?RXlhOWRkZ0lNanpOVXlONXFtZ0ptK2R0UDZKc29UdWwzWTU1eEZhSDRabGdZ?=
 =?utf-8?B?Y24yWTZZSWtjN3ZiWnJiUzVYMENIYWQ2WjhpV3c0REZqOGdPc3IwWTErcXJQ?=
 =?utf-8?B?TXhNWW5yRXlIQ3BMaG1nc2hvR0JkUm4rd2JHeXBCWDRXRExnU3JwWE1LSVc0?=
 =?utf-8?B?VXBBRG9pUmRpVCtuUnRjSHhCVjcvN2o0anBCQjZHdmVrTlAxV05aWWlNcVFj?=
 =?utf-8?B?SmVuSFkxVjBwWHo0WmI0Z2lCcEdyRnZxazdRM1lsL1J3TDJUZk5XR1Jja0Js?=
 =?utf-8?B?R25XdjVwU2krdG9EQzh4QXN3ZkZEUzVZeDEyeDlWU251SS9iK3pXeXYwVG5i?=
 =?utf-8?B?dkxNVmxwc1c1elA3QXJlVkthTFM3anNLSmo3bVU3UVE2S3VaazV4TW04Z1NK?=
 =?utf-8?B?OUFubU44YU9haGV1MWUzamV4eHFvL0FCbjZndEZveGc5ZVMzdUN1OXQyZWIr?=
 =?utf-8?B?SllubXRLTDhBNEpKZlBCNFNSQ2lDYitaV0lPTGEvb3dPQUgyeGVVdUF2OVox?=
 =?utf-8?B?T0k1VmZyUHB3dnB6NTA0QVowL091WDlEVHJFRkhQK3VNQUUyYnhsSGpBSmdI?=
 =?utf-8?B?L2c1SkkxSFV2TGV0c09neC9RNllxeVd1YWRWVHZYc05FaEpOVHI0dkJQY010?=
 =?utf-8?B?ek94U1BOZjd2ekxBenBGc2RtcUpJc3B1bFc0YjJuYWZaMUwwWTFyZHNFUWRr?=
 =?utf-8?B?YkxiYXp2SHhxdWs5ekU1L0R0TkNxSHpnVnNpSmlEMXlEMStEUU9ZeEo3dFVD?=
 =?utf-8?B?L0tzZ3hnWnk1SG1rMlRPUGtxcWF3dnBlKyt2aTRNNU1NQ2N5eGJDcE5uQlBp?=
 =?utf-8?B?ZTIvKzZmRDBkWktCZG9odVkyY2haVE5zSWtHcjlJWU43ck9kUEIyY045ZDRB?=
 =?utf-8?B?M1Fmenk2RXlhNjdJeXVveTVEb1RNdHNFZGc1UHVERTJSRjNIaUs1TEszZXor?=
 =?utf-8?B?K2grR3c3TmUwSkY4QzVkRVMxd0htRnZFN1hKS3ozR1EzQy8yTzY2dTF6RTZu?=
 =?utf-8?B?Y21GR3llWlF6S1MxUGlQWHB0TGZRbTFYQWRKNCtxSVlzNDhpZ2M5ZXY0dld4?=
 =?utf-8?B?VjNnaElCZURRb20xZkpTQTRhMmdSZlFrOXdudWdySzhOTVI5VzM4TkxqMHZv?=
 =?utf-8?B?OHVzeFZHd2Vvcy9hS3JmelBZeFY2eldKa2lkQjV4RXBiR0sxMnpDQkw3Um1G?=
 =?utf-8?B?TURqSHFkWDBMRkNXczRFNnloaHJ5TnZKVkMwa2ZpMWFmQWc4QkJxNzZ5QnhV?=
 =?utf-8?B?TzdUTmdiRnBQK2t6VWRVM2ZpQy9jOXNKM215c2hmQXdoNWZSWXE0eURVSVY5?=
 =?utf-8?B?b1BpNDc4KzJTc3BheWpWV1UxY3IyakRzMGZ2K2tmWWpLdDhBY2d3YW9oYXgv?=
 =?utf-8?B?aFMvYUJLUGJaay9reWJ6QXJ4dU5LVWVtUjZZb2xVUVpGUmU3NmxCVktncHNN?=
 =?utf-8?B?Z0FmNUtvSkw3dGg5SjR5THdmYXlqUVNIUjRTUDVHeDlIenZNTStqYTJzcFp4?=
 =?utf-8?B?bXluVXRmQ0l5ZUV6ZTlkZTNxNEIvMkRjTHpPcm9RdlRHaDZndkhISE1tRmJp?=
 =?utf-8?B?KzlpUUZPTytaUSswaEFrUXFBSkRZUFk3K056TVBGbG1EMXZHZGoxVGMvekNz?=
 =?utf-8?Q?3Uns=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:26.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3264196d-ba5b-4b62-3fd5-08de2837fd16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Make iommu ops part of SMMUState and set to the current default smmu_ops.
No functional change intended. This will allow SMMUv3 accel implementation
to set a different iommu ops later.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 59d6147ec9..4d6516443e 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d307ddd952..eebf2f49e2 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,7 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


