Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E842D33A09
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIn1-0000uJ-5F; Thu, 15 Jan 2026 03:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgImx-0000k2-5v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:33:08 -0500
Received: from mail-centralusazon11010056.outbound.protection.outlook.com
 ([52.101.61.56] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgImv-0002lE-Hp
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaCT1tjjfdN+X2ukIIxS0N19VAFoV1HO3+TnQi4fdwPR+Nx8WmhelrWSR6VjkK9LWs4GdKhveY/k64QvWRFZ73IdFzIDfz1/kGEELRY8ht7+Gj2lCUzzoynJkEf1sl0LcBMIvwUACJSslw0YOJLrCEUUV8oCtyEoq/p2sxIldd8AwSIBrBzsyAgsc8Nj39WzdYRIbtKVvu86tiN3F7fEoUIo6jln9jhkb11ZzvIs4SFX6X0j2frIz/6yiBlGLJOwBgDm0vQRSLjdQsbvg185nnBQGaYeI3MGjql3QEs+X3+4iejLozJO/xM6egKfyCKBhgS9WgyH98DppT76QmqFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hobFZoGJUl+y/IB94YbkL7Cj8D+Or1nPlGMm4csT5DY=;
 b=ht9hsNG3WjYhMiP56WUclq2P+xrQ+fzypV4Ngf59/fToJo/KT3eFImeHY1D8mSeXxFjNylGKw2d582tly4b5oWBLOoemeskWKnvI846tjN9Z7hViOqd9JfdE31HIr4ZGgbQcPJPmkS85OixbWlytV/I3ohyICwU0kwklyEiYBVjLvc/BWtsHTXY7//CaE9aL34FpbVWbZ5fIEHhTU25tRDKSW1X7OSEuZhbso/7g5/g7FVCBQDWw1hQQFMtgbtG0DjXeCd/PxXUCj6tZ+xfaGvuir11GE1DRk4PMMjYSoU3y7Fl0T66x/rruMz45UtJG4GqKPNGEEX5899EHO8rDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hobFZoGJUl+y/IB94YbkL7Cj8D+Or1nPlGMm4csT5DY=;
 b=zAabYrnzq0LLgtIwtMoLAN9vC8EstaTClQuTlYxLLKDDX49mFaV9kzjdtyvKDYFB6R0nGkjaJgpUDdH8ltTf6ZdEq9iwMoBz73URd8luugB2mWeGCvaNNBUphdZ0pud+Vxd/BiB+q2kg1+vxs9JyNQnM9u299Rqnz6xEsdHEoTg=
Received: from BN9PR03CA0100.namprd03.prod.outlook.com (2603:10b6:408:fd::15)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:27:58 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::8c) by BN9PR03CA0100.outlook.office365.com
 (2603:10b6:408:fd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 08:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 08:27:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 02:27:55 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v5 1/4] virtio-gpu: Update Linux headers to add virtio-gpu
 userptr support
Date: Thu, 15 Jan 2026 16:27:36 +0800
Message-ID: <20260115082739.174224-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115082739.174224-1-honghuan@amd.com>
References: <20260115082739.174224-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d22fe9e-6376-42d3-0c28-08de540ffd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2d3RTueQfzZXzNcqIkEY9y9wcC8tHk2pUhmU6w3cK8WNOz+7twbbcoHVnaJZ?=
 =?us-ascii?Q?eyyShLB/I5oZCxNpE2C458vsjgsU3Umpsc7BdT+GBnf7ilGT8TBV0wDuYk40?=
 =?us-ascii?Q?GCovIyGh4VPxcbb+AduqB5oQ5mt2Dc9aVlSHky5+3XdvGdOmRF08vOmdGmP6?=
 =?us-ascii?Q?bJxc1PLmX7DnZsYi9CqE9Y0d0H0CeNj3y2hjTAxaQjfoM441wbjyIcpnshqs?=
 =?us-ascii?Q?qhO4UbM44SZjysVtdps7ClhPNPuR2dTTq33K1wYbxY3BeooFKsr7CP9/ptj4?=
 =?us-ascii?Q?VtrfaviVs33HdrfwC9gsztPCT9FeojiLsDY6IMHAgYNLxttSWVahutc55OKd?=
 =?us-ascii?Q?QzYVp9aWY8R4xNPnsny6silit3joMR+GzlE9cTIXLN6/MC2rAQXHMlWSmnL7?=
 =?us-ascii?Q?zqJ8Apu/71HpsiTt5Xt3YVLfY6Ox+0kEy5WhqmHBuun/t80B4vICiZe2N0A1?=
 =?us-ascii?Q?M4rzgBgEhpqxNJXQ5AKWcrx0aI2mIO8fHtAmT7AnfkH53ZS9JwuxezQ5qcZE?=
 =?us-ascii?Q?8e0dA6w0KrRFXF/QoTwbC+0gT2h1Z00zYz4M7N+mN04EjSn/MzoCAbbDaUUA?=
 =?us-ascii?Q?Q3PSMMF0KpDOSo5Y6JlIFIgVCpkXmVJAwet4oGkFMnIeYEK0kGhrDhs9jpKx?=
 =?us-ascii?Q?bO54NNsfIYNeZK/dNrLB8QuXQOFJZmFTt61duPErhRo+A+3IoATAcb3DZNNE?=
 =?us-ascii?Q?do9Zv9t/ta110cN+TUeKenDlh0c3ouovHNuIgyATrfKCQ7jVvt7aFLlBoKeg?=
 =?us-ascii?Q?5B6umpk7L4ojJnLNgH8BkVb8VSSNAHf+nYMISsNMCfKo+KOBBzr+dOBag4WQ?=
 =?us-ascii?Q?gFXhAKo9FSPCVpGGW5VYKJ7tzvKAV3ViY1G5kRNapmxYUB8g9AcNu9/qEmzz?=
 =?us-ascii?Q?eNfOU5rS6XSJfGZF40rU8+3M1TSSoSiygHifFnyLNC1l31a4jipn0WsRFso5?=
 =?us-ascii?Q?JwfMak/zzEsOnto6tT8Vew76JQvfX+Z0JksK+IovwRWjDRYZuDb9u7x/sXqm?=
 =?us-ascii?Q?BU9o0Xjy2Xr4t+hHAsgnYmSuVwSRlsnOWYp1F6Z+VWHFO6yBkXX/A+T3O9bp?=
 =?us-ascii?Q?KHzonv1VYQoc8cTTc6euVAxUzft2p22FIPu6dKtRgGRsZcgR7t8L/zQ9L2Yj?=
 =?us-ascii?Q?t3izcSZUG2SihrkmJW37/WBS1uEzw86wOlKhTArPRjJ8zosW2cfyCwWBVdKY?=
 =?us-ascii?Q?t+fU78ZOv8xh8dlkXDAU+3g+nld9Ap6Y8FWJ9zQcVOvmbvvov+dix+Tz2NMN?=
 =?us-ascii?Q?3yJNcuY4UE2i+5gK0iXxqQwx34wPJszqnjogBavZD7T1wylo4+Z/8zUb3ALN?=
 =?us-ascii?Q?BScEFSy0/Pu02umFshozguAbPn2q182u7b3DRJVEVXbgc6w5fJHVNmj/yeUW?=
 =?us-ascii?Q?xFiXHHtvv+qDJxS1pO5vWKqo03Ws78nLqDe1nZOj2mCdnUsN31IDMTqoxX3+?=
 =?us-ascii?Q?Ysi43iI2pp/sqQ3vLUlKNZfhaWtrO6/9pAiDUNU9xD2v9MBaJFj3XiY4dqKJ?=
 =?us-ascii?Q?lgoEEy5qqPCPPiVChcxECEk6CfYD5CEA4njfj0FXKsRy3mzk4yWQV72Sr7n0?=
 =?us-ascii?Q?DISmjO8w5deZXC4zV/C2CQHyPUgrUb8xXJ7U4hiJ+KoHzejiVb6U39QqMjIP?=
 =?us-ascii?Q?eBpTbDs9UlME7P43zJGLUPBkD6JzrNaGaJ/DROwZVwDXWiQb3kwXUAzlLPfw?=
 =?us-ascii?Q?Ury9pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:27:57.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d22fe9e-6376-42d3-0c28-08de540ffd08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
Received-SPF: permerror client-ip=52.101.61.56;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update linux header same with the related linux patches.
kernel headers, which introduces:
- VIRTIO_GPU_F_RESOURCE_USERPTR feature flag
- VIRTIO_GPU_BLOB_FLAG_USE_USERPTR blob flag

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/standard-headers/linux/virtio_gpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..b562f5d6a0 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -64,6 +64,10 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * VIRTGPU_BLOB_FLAG_USE_USERPTR
+ */
+#define VIRTIO_GPU_F_RESOURCE_USERPTR    5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -405,6 +409,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


