Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FD7D4A613
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfWk-0005MR-PX; Fri, 16 Jan 2026 03:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWh-0005LF-GE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:51 -0500
Received: from mail-southcentralusazon11013015.outbound.protection.outlook.com
 ([40.93.196.15] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vgfWf-0006lN-6n
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGbHfrH6G6dv7Z2qJur1N7LfDaYnWOfTrzuGcO0BJXn37W6Xd2EWML4HZ7eklI8/bREktR5DUpBuI3qInffq4xCeP5LNCX9uyU4jSHLL+1/eCCj1O+W1x4prM+G5x9qqshLSMxUngGR6squVGci86iAVxDPpR21LiF59YpKWePgDTpAYadyaNIrFl8US79j8+xzpomNakhlpq85ZYqqrWAokczLg8YLu+/ywIdN5D7YyRa4OxmXJ52ehLvXiGGl8J+M82E1ZXOmp0t3PyFJguGABZxsdbelM1FD2SFd5dh6ohYnVFFMUCFIRgjhZaNpgsO0jdoZBu6vcS+z64LHKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGf7jyJpBiHxJiRIv6OMKRM97zqNbCPhJia+MybEATI=;
 b=PW66lSGY9OyHMNl7XT6KZZE179x5xnw/QvAg/mTcqwzqsuQjvIEkTSTWrQAAkQQJtIn5X1xyoFBb4l8HAyQ2Pfs2QiLvfu9F9GuAAQWwGE+5HElQPVktxTlofnkvj/3/w3OV1mKLRzV1E2Kb9VUlT6EBuj4fAztOrxo1SIo6s9mYyFKGP/JtkpW0Hjk2/TojdTxWjXs4un1AfJpMr2qJKNewPdtu0DghqtKUYg67WevCwedM03imxRwUbPX02Zy5B0NDpeR+hOlucJzPZ/QigdWl9VyQ4ljKkzChDRedvuVuXt9pZ9Cq5Hi1iDz60JPl9HoKFGLEoC5RQR5WUZuUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGf7jyJpBiHxJiRIv6OMKRM97zqNbCPhJia+MybEATI=;
 b=YJNj1Y23CdlO6JucIjQedopRBvIjDc3rzu+MXjAh/nIbYn63dYbcObbc1cbfmhHRgRoQFusdYj2AfyGN3BkWKe9mDFZKFeRIzWHOmdSL1faujxS8k+4iMmz/oINu938fsyX7/aovSrcm2pPv1ymrjZ44ulAQe3PYv7K+0NIdNNs=
Received: from BN9PR03CA0493.namprd03.prod.outlook.com (2603:10b6:408:130::18)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 08:44:40 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::ac) by BN9PR03CA0493.outlook.office365.com
 (2603:10b6:408:130::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 08:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:44:40 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 02:44:24 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [RFC v6 0/4] virtio-gpu: Add userptr support and ROCm capability
 enhancements
Date: Fri, 16 Jan 2026 16:44:05 +0800
Message-ID: <20260116084409.326062-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3cf9b9-7aef-40e4-d5c9-08de54db7cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZ4E4/HI8EM5ZGECUN0cy3MHpF5RvFDv6M8BdJS3dEfKIMoc1TXd6xFwP44U?=
 =?us-ascii?Q?YMZWrb4w309NV7zaUUrf9KkO6gLLB4qDYEH484FBOoRNyzzDRLrHrydjPORb?=
 =?us-ascii?Q?lGf0DTyQQHfI2lAuD64/qSkhNNk7jQ6K530HIwteag9UkP3Co7smjRIMLggj?=
 =?us-ascii?Q?Qdnpeh0MpJggWE4ZbH9yXXQV1oVGTvCTsek8vXD2NY00w7gbTUspa0Cs/cap?=
 =?us-ascii?Q?iZaV1nqinCcW7PqU9k4xmratY3QMeKSHXWMyao+mi22KSqoqJh5Od3qnrjrV?=
 =?us-ascii?Q?KtJ4DTI4RNJnxK5RycBWNRU8NLschHQ/yCDA8Ft2HBn+RnMAD1t+PuSp6Uv5?=
 =?us-ascii?Q?3wF7ciLc06UpqjEap1JV0lyXj5XAlErccdYqSQRUGfSj+I7IN3+QpUOLvYt9?=
 =?us-ascii?Q?5BpjqdpoHdLpf9ErKREqLTu2s/uJNrTjipqh+Mj1O4auBDfdQ5g8+QmM7sBr?=
 =?us-ascii?Q?hTrABZs1Hb209oJ8zWlw1xgkbqj3/oUHg79TNNQelkoD6jIp489Nw70Z+Kid?=
 =?us-ascii?Q?HcRJq0n+Y8KWUFtp8t4hjDAj163ZH+laUL05nJu4Cx0fOz1PEPOgeiffCHBh?=
 =?us-ascii?Q?4L2CFubEBd20jC5K2MEWKrbcBPkaP3GkIdSuXect3wLz6Rj5+0smOb+SWY6h?=
 =?us-ascii?Q?s8u/oOXl//fZ0MLe4JuR0zf9be8OLPlGpJIvbG2OtVjBnCSZlA9w8A9lBgR6?=
 =?us-ascii?Q?6vvKQGMOIjBC/DN/M+6KBjJ8ll01eBhTWRGb+XkAwe7Le9Kj8sYUNTan0pyU?=
 =?us-ascii?Q?D3+wO5OjSzHekrUvTV6HFX3WFTZMep2CITZc8yfJPyGIOry3Nl+NgCdKSCN4?=
 =?us-ascii?Q?xsH5CInfp7cLfZm5BF/vnjCBznqLiO/JUK5sr4xFzW2gxm4LvGyM6hWkCuZu?=
 =?us-ascii?Q?QXi87oOhOQtzUrRRCHPrULrttJvx6lX2iiJOOzKrVvKWmPd5hfFXg5danhTm?=
 =?us-ascii?Q?PQ17Ik2NmB1FLhPL3+PjW8VE3dLPp6hhQYbYFWYFHIS+FrL4ozWWaEiqb+Lg?=
 =?us-ascii?Q?qlpp6cXePS+4W0qzZ5gSpvoI5iMcRzE0teW4QYIYyTonhSKFcuAhtC2jp54Y?=
 =?us-ascii?Q?J00yl5AD/M3QRF2MMfVucVxzV3nzQO8rAGkk3cmx0qfX+VZRAwgImTZafTty?=
 =?us-ascii?Q?LxWCLKH3QrjjYA/jzg3dCYDSkPgMd9V4ymyUK+Mp1UJQs4QztYWsA2QTnTQb?=
 =?us-ascii?Q?/A0Un8OXYsPVfqwUboelevIo0Urm0AKHd2NylPgt9mmcSHQeYKhJVWpRppyi?=
 =?us-ascii?Q?jyjUaVQK9qAvRZt2Uc7H1Eu0fxK0LHvLAu6Kbf20R4D6SCoT4e5J12efl0Zq?=
 =?us-ascii?Q?gv0FkHDZlkJC133tZU02ny6LiG/8lu/2zs3XFJs0yY+HSKBaHg1xJtQ7VyJE?=
 =?us-ascii?Q?wXlIF2UodFJbyHYyJJNyg5KvQEJXsRARzQ+YGOAwLriVU82XOzRbhIsDKoz1?=
 =?us-ascii?Q?so7j1u7jSlFoRO/cYpVVbi7Uo2CabtkI7xcgxFzRE7sYW5yaGifR/0YSkzAK?=
 =?us-ascii?Q?1Bw2eiXFo4NAcIe/S0x79PzqhEPflqMT0sravRUOBpph4UpM/pO3DSaNNgNr?=
 =?us-ascii?Q?pEMW0ePAnxg2r9NZ3zvhbfdW76lm9A2V7/OUquMrhssvQt7cac8Eo72YpCr7?=
 =?us-ascii?Q?Aah1r6BC3yoPpXJsRecFvbU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:44:40.2002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3cf9b9-7aef-40e4-d5c9-08de54db7cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
Received-SPF: permerror client-ip=40.93.196.15;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

This patch series introduces enhancements to virtio-gpu to improve
memory management and GPU virtualization capabilities for ROCm (Radeon Open Compute) 
workloads.

Usage example:
  -device virtio-gpu-gl,rocm=on

The series includes:

1. Linux header updates for userptr blob flags: Synchronizes virtio-gpu headers
   with upstream kernel changes, adding VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and
   VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY blob flags. This enables user pointer
   mapping for blob resources, allowing guest applications to use user-allocated
   memory for GPU resources more efficiently.

2. Removal of nr_entries limit: Removes the artificial 16384 entry limit in
   virtio_gpu_create_mapping_iov() to align with kernel driver behavior and
   support legitimate large scatter-gather operations.

3. Linux header updates for ROCm capability: Synchronizes headers to add
   VIRTIO_GPU_CAPSET_ROCM capability set definition.

4. ROCm capability support: Adds native support for AMD's ROCm (Radeon Open
   Compute) platform through a new "rocm=on" device property and capability.
   This enables GPU compute workloads using the ROCm stack through virtio-gpu.

Changes in v6:
- Changed to RFC status
- Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature flag from patch 1
- Added VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY flag to patch 1

Changes in v5:
- Split userptr header updates into dedicated patch (patch 1/4)
- Extracted nr_entries limit removal into standalone commit (patch 2/4)
- Split ROCm header updates into dedicated patch (patch 3/4)
- Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature detection
- Keep ROCm capability support with "rocm=on" device property (patch 4/4)
- Change corresponding commit messages, change corresponding cover letter content
- Remove RFC label

Changes in v4:
- Change this series to RFC
- Renamed HSAKMT-related functionality to ROCm for better clarity and
  alignment with the ROCm ecosystem terminology
- Changed device property from "hsakmt=on" to "rocm=on"
- Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
  VIRTIO_GPU_FLAG_ROCM_ENABLED
- Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
  VIRGL_RENDERER_USE_ROCM
- Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
  VIRTIO_GPU_CAPSET_HSAKMT (8)
- Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
  another thread

Changes in v3:
- Renamed HSAKMT-related functionality to ROCm for better clarity and
  alignment with the ROCm ecosystem terminology
- Changed device property from "hsakmt=on" to "rocm=on"
- Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
  VIRTIO_GPU_FLAG_ROCM_ENABLED
- Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
  VIRGL_RENDERER_USE_ROCM
- Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
  VIRTIO_GPU_CAPSET_HSAKMT (8)
- Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
  another thread

Changes in v2:
- Fixed error handling bug in virtio-gpu-virgl.c where the return
  value check was inverted (changed from "if (!ret)" to "if (ret != 0)")
- Added VIRGL_RENDER_USE_HSAKMT flag initialization in virtio_gpu_virgl_init()
  when HSAKMT support is enabled
- Simplified blob resource creation logic by removing complex conditional
  branching for userptr vs regular blob handling
- Updated commit messages to reflect bug fixes and improvements
- Added references to related patches in Linux kernel, virglrenderer, and
  ROCm Runtime components for complete feature implementation tracking

Related patches in other components:
- Linux kernel virtio-gpu support:
  https://lore.kernel.org/lkml/20251112072910.3716944-1-honglei1.huang@amd.com/
- Virglrenderer support:
  https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
- ROCm Runtime support (merged):
  https://github.com/ROCm/ROCR-Runtime/commit/48d3719dba6ca91f597a8179d8b341387ce155e8

Honglei Huang (4):
  virtio-gpu: Update Linux headers to add userptr blob flags
  virtio-gpu: Remove nr_entries limit check in create_mapping_iov
  virtio-gpu: Update Linux headers to add ROCM capability set
  virtio-gpu: Add ROCm capability support

 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
 hw/display/virtio-gpu.c                     |  7 -------
 include/hw/virtio/virtio-gpu.h              |  3 +++
 include/standard-headers/linux/virtio_gpu.h |  3 +++
 5 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.34.1


