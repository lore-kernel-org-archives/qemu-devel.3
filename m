Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD235CFA466
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 02:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMHGQ-0005tY-E4; Thu, 20 Nov 2025 21:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHGJ-0005t9-LN
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:52:39 -0500
Received: from mail-northcentralusazon11013012.outbound.protection.outlook.com
 ([40.107.201.12] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHGH-0007e4-At
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 21:52:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjc76o7lSTQ+3noZb5VvATw8JZZAUsZBBTAaRCh9F2fg8Q4BliCeilAJRrJQXlFEE6LDxiPu6pm4xy8r0WkweysbPQVlYfhNWPwu0qAtG/cRF1JPO/i7MncC84r0Go2WOCJD6spQolk0FM4C3A7o8tZWBOWmzpcZlgEEK48gr6yqXXadejjpn+GHv4PnYyII2gEhZ9bgWWuPz9BTwOAmaZCk7e7CBNRcfQyk/sUJesa1ofN0GsiAEyxmyXeIiF83qtSKalN4zyMTtACL9oPV7PhK1tzQdG5aJ37daDhsR0b8nZCfcfNmlnmqhAiZe71BW43zfeWkaZVb1R+stH6Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8TdSdvRWPYW32EqWJkYrOT1Ka2kAxp6xXBPwpv9Tuo=;
 b=TbGOT6QvypwjKu3PWqfBlCpN83gvYH7G6Bz6DnzJCmbf5IuGUZ0BiDv21gtyZztItfcHucL7JGkz9TmGOdlB0eemhhczCJV7uoQ7eynY/CueM6eVaZMPtHm9KohbBZ2A+CdZYlzIpu1eC+X5nfLMOoSIjLYjsIwaCrL6/03C/4Ql9r7k1HlxiiH9Lg4Qml7TRSow0rRGqKBiY3PvA9l1dGBgB5rre0Z52d3dJJvyZ1Vavo3EBYiXoTzQ4tm53AE/Wy1DvzWzfI6nMQLE5yEywGsV6iTP9FmuWOg9vBxeANWMeaBA6ZEe7oQv0W7u7Hnaa3efdGh3FASi5x0nPhP+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8TdSdvRWPYW32EqWJkYrOT1Ka2kAxp6xXBPwpv9Tuo=;
 b=x8MOqKYjH5sAavbUjEOd6boD+uG5lWyPh9gK/LEOPXKHTLNN3OdR+xE5NozgYyhRbci4xzGBX0r8EXjSaaizXrrsZE1QC7FEkTSjvf5TfUWNgert8B+3J/6folNZEJ1cR6PGB37G6nWkgBVyUq5zJY8h9rjIvVgaKWEzFCroCF0=
Received: from MN2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:208:15e::22)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 02:47:30 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::1f) by MN2PR17CA0009.outlook.office365.com
 (2603:10b6:208:15e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 21 Nov 2025 02:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 02:47:29 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 18:47:26 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [v2 0/3] virtio-gpu: Add user pointer and HSAKMT support enhancements
Date: Fri, 21 Nov 2025 10:47:02 +0800
Message-ID: <20251121024705.1403042-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: eda28020-1b2e-4573-cc63-08de28a84feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EymImo7kn2jcbUrwp5r8HRjpv0vkwficE7+DECToysBpAU1PZV9nsz66BK4i?=
 =?us-ascii?Q?DEpd8l4fnJZv6IaORYaJSwM0LtBjEtRD+4BtPNGJUYmQV/yWxQfBsscoKxDZ?=
 =?us-ascii?Q?upx4hsdvvG7vywrDEehnqHLaZm/7QVcvJljbf7A8zsbm8LMFHJ3LmrVMA68t?=
 =?us-ascii?Q?P/pOlLL5tC6ivHEJx3jJ6U6yYLpqHySVHoSxzZhwMlQrBUQqBa7Rx8Z8VIlP?=
 =?us-ascii?Q?T0n0uHn40C6XiOZWfsznTFz1mKrYjetpRf0Gu4mCBhBkJsS5Mjg6UJ3M71TJ?=
 =?us-ascii?Q?RYCABZ8W/a9V7mJ8D9OWi+8MGIALY5a/ZGhsfcvaPBWC0Y/3ZTVnakDv97Ae?=
 =?us-ascii?Q?0Z18nHuDLUVewqOt5XpyqGnkQ/T0OlksVCUY6lYsm15EfMZdPE6HQNeX/JnY?=
 =?us-ascii?Q?zBoFPIShB0rt+Bj0015wnsMhwvlVhGHFbAOvvi36mzv2vIqYKiHWWzW0au+q?=
 =?us-ascii?Q?uKH0xqD5jMxHjlddLAm9JfS9r3uGkyoldSaPxztqA4kXW0MqA/2wpv9j4uKz?=
 =?us-ascii?Q?gUeNFGq7gE0H+pEHwGovmOTAjKPA8wLTWB+okQmdbdJk3ohgA1wCuZ39i7gt?=
 =?us-ascii?Q?IuvALb2TEFklaprV3NgOBcUHiHMUvJ143R/xtlC83/KOMYWb7i1Nk/WWfKkP?=
 =?us-ascii?Q?Gt1CtwdVo5xJgIhHd9l1dobkJ86X/U/RlZXidk6uV8O0UgA7EBrLToarhOKX?=
 =?us-ascii?Q?CudYkXNfjydzP50K2/Lbeay9FUZVq6lV+cJXyK4HOadF9ajObSPKJ2qusJ98?=
 =?us-ascii?Q?6NsBb78vapzpq/sjgHKEpK+qk7Pz8+EYBHXPsGSDH+Irtxv2eqDZMCmH2erH?=
 =?us-ascii?Q?GLo6gYME0blQV1AAY08jtvV5bGCMXRKEokbRcljJPB+Z0WgIf70osSgtlZzl?=
 =?us-ascii?Q?NOoAm6GWgwDJTGraJls/AuDXxisjmUd5rZMW8jERgN6jp78NO9EUaduI7epF?=
 =?us-ascii?Q?A+uwfZyR2nQx/TZJdcDXhjYL9Wo4fLZtMYPaW43H+9T56bcZpvXBEAe2WiYn?=
 =?us-ascii?Q?FvFtPqn1TCOCAW3pzpcHeiTPjiz3gemkZNrU307BwiGWlXQtu6n6wBdiFch5?=
 =?us-ascii?Q?zA3oN+SFeX8VjI7BiayQoUoSOaoVR8y+DKjMzRvI8VSRIetKewtrMb7vPVjj?=
 =?us-ascii?Q?gSB6Qlm3UxKWVrYgbrR8Ow72mpg1TJ3ZKwleal5Hh7oIvCPORbQPbHqHWzma?=
 =?us-ascii?Q?q55NAJt7RgWlP1kpzFze7I47sjWbFb+Wq1teETkI0cIIxvrQolrOWj3xTw3z?=
 =?us-ascii?Q?1DxlpqmRnX+ZHxjOsfH7DAyemvTglZGuHdlZIfyr2uxwRt8nmg8l3ZfxQ3/K?=
 =?us-ascii?Q?wekCbs1auBk1VfSrSk9VR0JPl1SBWoW9BoIdkIKK8vBUxpDK21B/sGp8FR+G?=
 =?us-ascii?Q?xzjVVcieLTT9U2LNY7U3A6WVfJAymwfZLlFJuJoEMIAkN7NaNmXLPVL3SFXA?=
 =?us-ascii?Q?2bZLxW/sMDKdATVwwhOQ+F/9O2tsBj5O6YXXjaFYPcaX8JXa7EPM/X9jICy6?=
 =?us-ascii?Q?tJ1y2PvgK9cZMUrLozYgEIc1pyr9nyKi6bjLK4eaN1NucXBf3/t2e96p2wY0?=
 =?us-ascii?Q?DeIn1T5qkttmWSwKbeo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 02:47:29.3246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda28020-1b2e-4573-cc63-08de28a84feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022
Received-SPF: permerror client-ip=40.107.201.12;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch series introduces three key enhancements to virtio-gpu to improve
memory management and GPU virtualization capabilities for ROCm workloads:

1. VIRTIO_GPU_BLOB_FLAG_USE_USERPTR support: Enables user pointer mapping
   for blob resources, allowing guest applications to use user-allocated 
   memory for GPU resources more efficiently. This version includes a 
   critical fix for value check logic in blob resource creation.

2. Configurable HSAKMT capset support: Provides better control over HSAKMT
   functionality with a new device property "hsakmt=on" to avoid exposing
   unsupported capabilities to guests. Enhanced to include proper renderer
   initialization flags when HSAKMT is enabled.

3. VIRTIO_GPU_F_RESOURCE_USERPTR feature support: Introduces a new virtio-gpu
   feature flag with configurable "userptr=on" device property to enable
   user pointer resources for enhanced memory management.

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

These patches work together to provide more flexible and efficient memory
management between guest and host in GPU virtualization scenarios. The
changes are backward compatible and controlled by new device properties.

Usage examples:
  -device virtio-gpu-gl,hsakmt=on,userptr=on

The series has been tested with ROCm GPU workloads requiring advanced memory
management capabilities and addresses the error handling issues found in v1.

Related patches in other components:
- Linux kernel virtio-gpu support:
  https://lore.kernel.org/lkml/20251112072910.3716944-1-honglei1.huang@amd.com/
- Virglrenderer support:
  https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
- ROCm Runtime support (merged):
  https://github.com/ROCm/ROCR-Runtime/commit/48d3719dba6ca91f597a8179d8b341387ce155e8

Honglei Huang (3):
  virtio-gpu: Add support for VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
  virtio-gpu: add configurable HSAKMT capset support
  virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR feature support

 hw/display/virtio-gpu-base.c                |  3 +++
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 14 +++++++++++++-
 hw/display/virtio-gpu.c                     |  9 ++-------
 include/hw/virtio/virtio-gpu.h              |  6 ++++++
 include/standard-headers/linux/virtio_gpu.h |  4 ++++
 6 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.34.1


