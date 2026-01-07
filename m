Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51DACF6BF7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOJw-0004ze-JV; Wed, 07 Jan 2026 02:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJj-0004nr-Bg
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:50:56 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOJh-0003GY-2w
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:50:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH25zOTWHG7tvkM/Cb0NspxnZobgo7WjIDoDr855lhP43H3PKx4wwaK9w4sV2DMAitsz1e17osS/MS6QNCJi7kT/ZUfb8fqFUwNRO0IVH0FnJp7LEz6T3kxFT0nHqYmMbnyku7G/8nqaYWCg79H26gQc/meCGeBEMM+aA9gdyaopHkyQWRSX8Fa9T+TDgy8ohWeZB2nFczh1XMKtawFcfHPyU1zUrl9YHvJXKUBecx4/LYfIufvPeIOULMQ2nUcxeUbsIKy3MhUCpJcCSoo/gOsyIp8vDJk0Sl0K0MOipaEabkuxq/i6sHwRPVyR0asKxukrAZXAN6P8tANANWNKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr03L57wpJofz2pMPKhUNGtbn04gbxJPRk1XVC7nmRY=;
 b=JTeCk+yjN/ebHOQmYTvrtqsYxroTjUr89tSqGvnqQVUW/3HMO06Jgmy2QDntcZGwJ1pYN9n/jeogbpdqCr6H8OkfykSWo+jSvQqkhFICAbbne8f4qUGETz1CFSZlN/ywc+tA2Alnq43jCOpSiO4EY4oXFwBqZDER3tLx0MovcidSrftWzk5LjCIhAYFRKbPkCE+u26crl4jYPmVLWWg2++5a2BBuLvDGTvO75RpC9oJwcIwSci+RSnueJ818tkG3p7H0AoEg+w4MoIqkt/reBdrMZ+kSnq8J9zUGxpFYx0aZkux0f1CeUUUq8XIEo16FQx+ZpjTCjrVj9fSmtmLxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr03L57wpJofz2pMPKhUNGtbn04gbxJPRk1XVC7nmRY=;
 b=rMbqBz3rOJ31MW0FhIUM+rPMc9m3X2NnWTS3BkS6T02Nen7yiUzNJPIQqWz1LEBB96HiG/it8Q/uGKkD7E5eSbaAKeHbDfd+dMX2SIckSTr4ahwoddNyMOmC0t2X6gouvVhiMfuKoKfQJz0bWar8JY+WYF0YN5sv3AwsbTiB3cY=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 07:50:46 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::6e) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 07:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:50:46 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:50:43 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH RFC v4 0/3] virtio-gpu: Add user pointer and ROCm support
 enhancements
Date: Wed, 7 Jan 2026 15:50:27 +0800
Message-ID: <20260107075030.3453924-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: ad157547-ab43-4c85-c9d8-08de4dc17798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7WVilkTr/eZ7hX2YzmhHF8tZ51qGTIdcDGyG3CqVvPaQ87KATDVyXALUO0CG?=
 =?us-ascii?Q?I+N/oPJgoXRNHALobCToxECcgVNCONNl5Ri/j6fyXKz2Zf2t+RJyMghriRzT?=
 =?us-ascii?Q?a6MLBonbivtin752vdE6Yfzs8HtgQAjYnt2dBqGf0WISiPr724krXhRhi3Ne?=
 =?us-ascii?Q?ie+pbTcwdcRjgQnjhst0MklcAiiW7/5tD1oet1j3K+g0JaTOjokWZEmOUndq?=
 =?us-ascii?Q?oRd6E1Fq+Ct//YoriPGfI0V542Pe3Bw4csoplKUD8alQLwEsOpivj5WnJZcN?=
 =?us-ascii?Q?4rw8k9m6F+DaLFKzHBkLtljSdiZrDQMhY95JkK4Jp5GCpERPLArz+AyWiz+L?=
 =?us-ascii?Q?jvsNokA/d9LECxJpdJQKnsxJtCX+32cBlMSeuyv6Gmc9Vo95sJOVLKmyuQ2E?=
 =?us-ascii?Q?IM+LmzBpAp4GApVpQGoaHQ7mNRh4yyviph5EYxP/nlgbMtiN4NIRc0LDeNlX?=
 =?us-ascii?Q?8WdGyYwJBH0fnZgyOlQoiv+lGU/t9ZqqRNoxdOGHqqspScaCxWTiCV6rBJvp?=
 =?us-ascii?Q?K1JwvUZ6Be1y1IMnFwbNJgXiAkiK9UIgIIZJKk8MqPSX37M2Hns2wilxMtdp?=
 =?us-ascii?Q?HJuzuUBL9WGKbTPagw3vfUGv/1/ZS85ypg3ZlV9WQ9cYq+mFbBEfBYGTsSqO?=
 =?us-ascii?Q?LNf/GsfNjlmK+bI9hjYmDQ5LhpSrI/P/mF3gfi2an3IOCGvXaMSPdpEJWlKn?=
 =?us-ascii?Q?ALr1l3uR0RZzJ96FF2FlsHRZsQcAWCAv/8hiLuK/DA+I7Lba6J0NeE76pBm6?=
 =?us-ascii?Q?hBeSPxMHHN0taiSlKymaPAkZ9fDx0n/pNQyMj2oXT3Ii2D3FRR1KptAhL6vB?=
 =?us-ascii?Q?aTsSGtDpmPycevNMp/nLL+9eT825AeTjncxJa42U129A2GQHNhV/GU9ueB8c?=
 =?us-ascii?Q?BdZDA5MA2XpjRfGzPoh2SunN6IvkeKFL5WDMFDyK4EAr7gBHhxMKPXNQiRRF?=
 =?us-ascii?Q?lH57wgUqNeCkmFMsyuLZa4ZaNIyP7z2G5CkfWcWOZKifniGsUsFq2nMIKl/p?=
 =?us-ascii?Q?mCOKRD0tpyOpRqtn45wRJOnMhDdFarx57H/zTfb5LeFoPOxnOvbWjSCD+hIY?=
 =?us-ascii?Q?dz1hyTx5pEJHANY8qPS2dume9e9cia5AnSWInGbneNMOAJnUeabG4fD67U0/?=
 =?us-ascii?Q?D+Jm1fJvCMag3ZiHTRshXSGSNBrPbMH35nyn3NBWrLDO3wfH9DWXM+5vmp5d?=
 =?us-ascii?Q?DhZWwbVPqPevYJYkj7pIXUPcQAqa1BLt7GkvH14mE5oLtiB4uWwH+vN/Fg66?=
 =?us-ascii?Q?puXaklKmeo0mGGU5oSH0NNigeA3xTBueEDLQb01l3pMKhnjKUORymk7Q/cnI?=
 =?us-ascii?Q?z+P+XSjIeT9kRTdVHiwGl72j+xRLfYAvm7mW4vvPeh4GYjFBzLfbnFV2YTmA?=
 =?us-ascii?Q?PFezfDaEhd7i5IOsOcvCUqL3hMWjqOh8/fF6wNgrI5WNF1850eNHazD1IDAH?=
 =?us-ascii?Q?7fZWzqbjRYteZDSY6tgu555Wypj4ZkR2cPYIQoLzn/nOScO8pscLGTyYCBip?=
 =?us-ascii?Q?rMyNfi9ClLVk73zBRf7lniQRMuw8teD9SQIp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:50:46.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad157547-ab43-4c85-c9d8-08de4dc17798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

This patch series introduces enhancements to virtio-gpu to improve
memory management and GPU virtualization capabilities for ROCm workloads.

The series includes:

1. VIRTIO_GPU_BLOB_FLAG_USE_USERPTR support: Enables user pointer mapping
   for blob resources, allowing guest applications to use user-allocated
   memory for GPU resources more efficiently.

2. VIRTIO_GPU_F_RESOURCE_USERPTR feature support: Introduces a new virtio-gpu
   feature flag with configurable "userptr=on" device property to enable
   user pointer resources for enhanced memory management.

3. ROCm capability support: Adds native support for AMD's ROCm (Radeon Open
   Compute) platform through a new "rocm=on" device property and
   VIRTIO_GPU_CAPSET_ROCM capability. This enables GPU compute
   workloads using the ROCm stack through virtio-gpu.

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

These patches work together to provide more flexible and efficient memory
management between guest and host in GPU virtualization scenarios, with
enhanced support for AMD ROCm compute workloads. The changes are backward
compatible and controlled by new device properties.

Usage examples:
  -device virtio-gpu-gl,rocm=on,userptr=on

The series has been tested with ROCm GPU compute workloads requiring
advanced memory management capabilities.

TODO:
- Unify and simplify the handling path for userptr resources.
  This improvement requires coordinated changes across multiple components
  (virglrenderer and virtio-gpu driver), and will be implemented once the
  approach is finalized with other component maintainers.

Related patches in other components:
- Linux kernel virtio-gpu support:
  https://lore.kernel.org/lkml/20251112072910.3716944-1-honglei1.huang@amd.com/
- Virglrenderer support:
  https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
- ROCm Runtime support (merged):
  https://github.com/ROCm/ROCR-Runtime/commit/48d3719dba6ca91f597a8179d8b341387ce155e8

Honglei Huang (3):
  virtio-gpu: Add support for VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
  virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR feature support
  virtio-gpu: Add ROCm capability support

 hw/display/virtio-gpu-base.c                |  3 +++
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
 hw/display/virtio-gpu.c                     |  9 ++-------
 include/hw/virtio/virtio-gpu.h              |  6 ++++++
 include/standard-headers/linux/virtio_gpu.h |  4 ++++
 6 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.34.1


