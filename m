Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999AECF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNu9-0003qt-Kk; Wed, 07 Jan 2026 02:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNu8-0003qi-1K
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:24:28 -0500
Received: from mail-westus2azon11010067.outbound.protection.outlook.com
 ([52.101.46.67] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdNu5-0005ui-P1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:24:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVCMoKwf54FrdAh1YEzyUZpPAVSmCgprdDGVQi79bM7n7pZpTJjUQo7cQyISktQ6+DANrmhxOJRbtDddUiIh84aukRkCn5QNWsMajxITUxx698X2TijRx9OCcc1Jo1YkXff8vtzKi/zp1lH/t0tI3lnd4WvBrKiBEgqkdR6+c7/s/fqV9Q6442s6p9WSnBlTpscUXOVTqDL0tqrfU+5J1AX5AHfY2/IS/qspKJvV5fEvF7yJsc8MPZGAh1oHCTiG8yHdl0IGpL/Tmyk9aPS8Dne7hyMOP52Ccrh/oZ2+Ngeh9jnu4/yF8fQaXDDrKYy6e1G0yS6rBG8rTIVfaw1JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fysjBnko0G35coBcFm7K6Ti1xzViAmuecVAcxEgDZ48=;
 b=FEo0bIBCuv4kw99xsC8V1xU6WBwOuPNpLa9I9Cuc6VT8ELQs2BcgagpcG4mkp3ZCdtwqL4rZo6l+LlwrmJoZ5NYRN+UjYK2SVEqM8TpMD57nXs8SZpwC8r9WSrRRfrw+Y5CDDyH1UdeOhfZ1IvPtqW4F3cnKwmaC2mI/GXugEW7eZYu97fBiUmisDgiKzSL95hxvXEP8zRYKR3N+0BsTRYj4ZUYBYxZu0liUvTurHRfyezz38LvzFW0ZoXn+VWE85KBgIul48h1x0nAYohLNqMtDc2FWC316aNf6eBTTGPpIB89UhPBRdbMGorGU3+4JEWNb6kzERaAfq+6yjzhCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fysjBnko0G35coBcFm7K6Ti1xzViAmuecVAcxEgDZ48=;
 b=OvLhUHunBuUVIvJZl1d4N8UWzNdijWAZb8LYdQJS1xZhWptmFx32TAjfbbACFB4TqTL/Gf+q1X62dkmDb9XcfuLMAVxAlb2OWLx1DcM/X7UCW39Ky7jEdWpG/pk7E5o7UojqQI7i9cYGYpwZ7vLRYJdeN2ZzgtUtj6tFHXC6EDE=
Received: from BYAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:c0::30)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 07:19:19 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::19) by BYAPR05CA0017.outlook.office365.com
 (2603:10b6:a03:c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 07:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 07:19:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 01:19:16 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <Ray.Huang@amd.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <honghuan@amd.com>
Subject: [PATCH v3 0/3] virtio-gpu: Add user pointer and ROCm support
 enhancements
Date: Wed, 7 Jan 2026 15:18:55 +0800
Message-ID: <20260107071858.3452614-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: af60863d-11d4-4eb5-0469-08de4dbd1315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ePJ5I4xPFNDUXijq+4deeBFtqSGxYMKf4FbGK99j0V313CGJwahVNteUtspC?=
 =?us-ascii?Q?P/bbAuB1J9lUQcqCNrQTLbWujXwBaFURGSEj2iiEVUY6RfM5yzKHfiVb465r?=
 =?us-ascii?Q?sddxCtuo29U8D/q7seEGtpBy55bY9v27PeXq0PD+RKx8K8wq8uPq6T0t6sEM?=
 =?us-ascii?Q?Uk2VeoKSH1oVbtWRoQ5luUEFRF/gzaFRK90r/xuH+2QqDPCGKFB+2M93Uel/?=
 =?us-ascii?Q?3PTjByZwl+Z/XR6onCea8RElyC2vjh0cim+5nbBBqyTD0BKz8HgYTKK1nIG6?=
 =?us-ascii?Q?zQAmB6gRhwzhnkLvZjH3esZPVaFMZtzqDujAYEhqfOY+LvJf9DQ4KNPfEaOF?=
 =?us-ascii?Q?BR5fQSlpy6UJp2Y3Z6XTAgymH0PWN7zvdLwkBrWahS4rbrabqBKKkfmj3wW/?=
 =?us-ascii?Q?RKqAyN0L1E9ZWruOFOzYVKpob6/1qRlpJoXrusfmjHxASWO4knH8a0P2tOi1?=
 =?us-ascii?Q?zg+yW8Tro0FoL2iRX3H2fDLBGasSSgCfTiEt2700kFyXgy4JomBWgTwP9HAm?=
 =?us-ascii?Q?9bxHxWDSAH2tc8YbR/S5V0mnFvwni1ZDxrddmmS9NeS6xmJkDeevVfgO5Djy?=
 =?us-ascii?Q?VCa/tSs6SvODsvtQR54wY7/njihLKVTpJlvzXvC519vNjjKpxm3FDmR4Hd1k?=
 =?us-ascii?Q?WeHRd1YGgIAiBxzaiP6tq2dbnrE/6JlUbk16WUVB5jghmpbRJKLFgcTLwGoU?=
 =?us-ascii?Q?39mZFS+sTumf7bTuCId1NGtAvqaN/NMCFYt0b4oPgXvXzsoPdViTFo4HmvWz?=
 =?us-ascii?Q?aL+dHXm9AI3x1pqdtUI+tjhpx8OIMKp8Rmcnf6BrNlUGMXP+Cmk4mEDPpfpH?=
 =?us-ascii?Q?wNRMFz3PlRMbQU21sPDXiz95GAAPPpffJmtSR5GK6XsSf2DRWxc+SAT7Ptw3?=
 =?us-ascii?Q?cvYwt6VSZvYnKgzkBR2pllXIM0cW1DzILWf7GH5tmwT61FGSMjhPFFhhZUDE?=
 =?us-ascii?Q?WaYHz6hCAgQ3n4Cl1kvSRf6yKfGPTIuEscFbVgIKOamQnStUuC6KE2IDxeUE?=
 =?us-ascii?Q?U6cVqYBSF5StzBuzyHVlaz66TCCPGMODKVYBjNJ636kSvptcAsg67earJdrF?=
 =?us-ascii?Q?QATzLmq8xaqXK1ptJnFzZWsNEaGghuxNicmuxVz3tVXYJfq+tG91C1U3DHKC?=
 =?us-ascii?Q?Pyg+5NYQd6TYrYJrFPqqnLl7PXXFcXty6dTCmMgukSaGIm41pJs2s6M5x0Ux?=
 =?us-ascii?Q?VMnP9qysxZTz62kAE538a0BAou7Ej5tWGL7jtN0AtGXXm+XbDYHgcd9Wb2Lp?=
 =?us-ascii?Q?jjcUC1eSgnYiU2tzJ7G0ZrKm/6DA3jTznPhnbdFWtBFAK9pT5ttNM2CsCnqu?=
 =?us-ascii?Q?EOw0CVFAN0kdzmtbzwS4LaUUW1filpAbQ1ZX6UbJ2HcG9QvLw2WJ4VSmc/sU?=
 =?us-ascii?Q?SL/uvulnpeevJg0nu+U73s0I7Vfv8zzBBCyaU54sHlbW9UzgiTliXGHusB0O?=
 =?us-ascii?Q?JMezKLMWNCQGq6hGuaroX6+gkwt/xNW7jbWK9sVXpa4UDBMyPd7jAcl/vTS2?=
 =?us-ascii?Q?F/okvIFUFc1oAcVALwc20LiTz8XM6zvUNYou?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:19:19.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af60863d-11d4-4eb5-0469-08de4dbd1315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
Received-SPF: permerror client-ip=52.101.46.67;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


