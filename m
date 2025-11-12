Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9547DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgm-0003sV-IA; Wed, 12 Nov 2025 09:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gl-0000WH-BA
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:48 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5gi-00036Z-Ew
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:54:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIscrzcURn+gp5tlIIeUQKbR6neVtBSKgghnAV3nk7jGzSvNK0u4vjsR1H4uY7lge64Ee9ejmTLLHYKAtwUogArAY22AVEvdveSrrJ3UwTUQP5k5qwJ9mv2LJW7ZdhzNTlO8rT//WI9OJH5nFZKgzGcm/IJh7Qe9c0pIHMYx/NrutaRhgtyFkWJZnmmXBg7H8or5DoTldaCE3DctfBN/siBZmhu/NwCtmA+7NdDPcGEeRV6dgNLaBEVvxW0UqPJueC+xjcwq+cNrsCabWLWQbV5osZvFcGKZvpx7mSIkKSvEuKUD9MplVfVr6+dxSv158MQZtD2kh1y/bJFPFWQ8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17490A6VpKqSws1LjN+IUxHnh17ABgR5GhjKkbHNVaI=;
 b=hKjHcoFsTTH504iYsMCST/kZOYGZPYdPTOkePgU6X5qCeDviGl0oK77B3e1wrBwYOnK4NYkWDdgTB47Tw7FnfQXC4CVQBY2LJt/73S+VtJD582Usl/3neAkwimqwqhGJFdtDeaOyevv6z6owveUDOXQ6wSw2u8O7nsnHytUdRqd/goIVkztU/mjmJQ7L65XgWRCGEhwNt9aEJrbx2EhyOOa75NM6x9LwH3bzX8UOfndUYE61cp8QDPOG22bJKtYe2B88GYZXoJ8ZYXvYCzJwfVyJwr0sTVkr6czDAC5DPBQgRqLZON9CNzu1oFkskYwZlWq/ZROrGAOwbMSz83JKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17490A6VpKqSws1LjN+IUxHnh17ABgR5GhjKkbHNVaI=;
 b=M9m1T9rLkXlqy1pbPB3T4hv9T17p79TL4/AqsKPSdDTHHXmzmp+/xPQdDD5ecLYZhjVj107DEu7S6homo8ZzrMV3ZD/MHQGifdIHRHURdEFVVVg79n0Apsfmho848YOfLNN0g5TpkkejMAwgG5iSrr5HFtL20HK3qGYGZNPZ0G4=
Received: from BYAPR02CA0028.namprd02.prod.outlook.com (2603:10b6:a02:ee::41)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:54:36 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::df) by BYAPR02CA0028.outlook.office365.com
 (2603:10b6:a02:ee::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 07:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:54:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:54:32 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <Ray.Huang@amd.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
Date: Wed, 12 Nov 2025 15:54:12 +0800
Message-ID: <20251112075414.3719917-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112075414.3719917-1-honghuan@amd.com>
References: <20251112075414.3719917-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf6215d-c530-44ca-ec45-08de21c0b98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FXPCmgaSuK43P0QAPtYk+bLw64nJG1Xaw10ZPWM8suddCBLq4SGOFJl/MAVi?=
 =?us-ascii?Q?IjkI53b+iTqOHw5+bVO9nIwSeoB77RYTlWe4N44aSC1JEQJiadskYTfDELH7?=
 =?us-ascii?Q?LGxAyxLevCsPtdU+DQKrQFjz3LEMzZqzR0iAxkw4wiU2SinJTrJ780KgzuI8?=
 =?us-ascii?Q?wXId3sNwgEf7MmBf96u/eWXWIZGe4XBMeuCibtjWTzprtHE2jLRWHEp5w/yA?=
 =?us-ascii?Q?pffHhfa8zrajSwP+Hw0l9X6ex57cYf+unsRunpEM7cRdjtCHAK4xn9lyjtPj?=
 =?us-ascii?Q?e5dWxSNSRx9/oC2R1Janz4DSDaGfgVgTdfQfJS1yPcxE4dAswjFxEwUz9Sbx?=
 =?us-ascii?Q?WChdAcn/j2Xj/BXH2qvBLO9zLhSkoIUnuHgr/FjR2598L3QxyAaiP3MJvzoI?=
 =?us-ascii?Q?5NrccG/aAw1x+FZ+r6P4CqziilKDMWc+y3fhKni/G7Djp6NZQt0V/0Q68FOT?=
 =?us-ascii?Q?olIbLtOPhq1+H+YMpLUm07OykaWr1v7j+zrgN9MpvwXCvNcB/Kl3PH3zETdf?=
 =?us-ascii?Q?hPRRRZNFEyu9NdgPHp9jxtw08hW/Ue4OWT8jz4Hz7Dmdie2mA3nApBsgoKpg?=
 =?us-ascii?Q?vwIcXFEc4o/WpmbxeyQtBxddj2IqXITrvcoEUNWD7uaMzsyw1qv82GSTTBGp?=
 =?us-ascii?Q?phjVwQ+X6Ewd9gc27MU63BhmudcWrxi7alWPhxf8vxe6cEMZkqvji/EHt0wd?=
 =?us-ascii?Q?oZWI7xjIKhq71qPTXKrJGYyRbjx5ESNVs3uZPte5PYJhfSTJiSmnIqdULFCN?=
 =?us-ascii?Q?IMHAwYv6f+9f7z3oCHUBGZockgRmkJscpgOMfZs0L+eSJJqBPCdQSzqQ8Rpq?=
 =?us-ascii?Q?7pgPOCBOtIClkpLKKUY85nYBKUdChfwkq79UpYJSAiDFp35LJt5OtCXfqxHM?=
 =?us-ascii?Q?l94jJooiEdgZ6aMkdNSXi3BxcaLErbUIY9oLhiZScG+t5e5Wz6frY4680blJ?=
 =?us-ascii?Q?KMFCF1VbzbYIEbcMlYB3gWfamivWYkpS7uQ3ZsBy8mtJ4CaU7r2YAObavQ7r?=
 =?us-ascii?Q?na0g3J8NCnE+3hhEoYxegsgIS2Guhfxnfyx21rMO7P3mUQguRTxeHXwQgCvo?=
 =?us-ascii?Q?xeUeJHTZpavS4/ZW7x9yIE9u5Sz1udI4vxNncNq4axJ2Y5SkTaciiuCCODXG?=
 =?us-ascii?Q?syZ0+vlXn4oRw04rKSeMHPDkuh9wY0Y5BdNTGdNL/sIH/H1a4TibAp+V4IFk?=
 =?us-ascii?Q?xVPCPVFQj1wcNHEQfwzKoxrgmrc/RP5pwuB5n91Hz13ocjjFyQw4o7qE7COo?=
 =?us-ascii?Q?+dHG2/KKa4UQdLY291whr0g8xhk4hdTDenCJxQ+GfNaHR52n0SW+OBv14uU2?=
 =?us-ascii?Q?0jJUiHRBswKVdGhVc9/Jxq5K23mxdoSojZIY+F0h/7V+qugqfB91UpB7FwCq?=
 =?us-ascii?Q?gPOvF7C1HeBs27m8KMSH0B/Taxwr3pKugv04EtdZ9kEVyviWvPnxN9iSh++z?=
 =?us-ascii?Q?7p3byoIw1AtkDxld24UqR1L/QpG5/fYY7EeKG31j4ti31Vm97UaCzfOW5dSZ?=
 =?us-ascii?Q?QA76NmqgQk9PuUVa3viDVZamCXtWzCaUlQt8mdIz32TU0zqplPQXatIwy/K1?=
 =?us-ascii?Q?CwaavBcVmwsRkiEEYMs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:54:36.2173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf6215d-c530-44ca-ec45-08de21c0b98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:03 -0500
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

Add support for the USE_USERPTR blob flag in virtio-gpu to enable
user pointer mapping for blob resources. This allows guest applications
to use user-allocated memory for GPU resources more efficiently.

Changes include:
- Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
- Enhance blob resource creation to handle userptr flag properly
- Remove arbitrary nr_entries limit (16384) in mapping creation
- Add conditional handling for userptr vs regular blob mapping
- Support guest_blob_mapped parameter for virgl renderer

This enables more flexible memory management between guest and host
for GPU virtualization scenarios.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 hw/display/virtio-gpu-virgl.c               | 21 +++++++++++++++------
 hw/display/virtio-gpu.c                     |  7 -------
 include/standard-headers/linux/virtio_gpu.h |  1 +
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad6..9da64bf16f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -702,12 +702,21 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
     res->base.dmabuf_fd = -1;
 
     if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
-        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
-                                            cmd, &res->base.addrs,
-                                            &res->base.iov, &res->base.iov_cnt);
-        if (!ret) {
-            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-            return;
+        if (cblob.blob_flags & VIRTIO_GPU_BLOB_FLAG_USE_USERPTR) {
+            ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob), cmd, &res->base.addrs,
+                                                &res->base.iov, &res->base.iov_cnt);
+            if (ret != 0) {
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+                return;
+            }
+        } else {
+            ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
+                                                cmd, &res->base.addrs,
+                                                &res->base.iov, &res->base.iov_cnt);
+            if (!ret) {
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+                return;
+            }
         }
     }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daf..956dc811fa 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
     size_t esize, s;
     int e, v;
 
-    if (nr_entries > 16384) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
-                      __func__, nr_entries);
-        return -1;
-    }
-
     esize = sizeof(*ents) * nr_entries;
     ents = g_malloc(esize);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af..b85e781a2d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	uint32_t blob_mem;
 	uint32_t blob_flags;
-- 
2.34.1


