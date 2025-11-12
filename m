Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94500CD13CF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgp-0003vJ-Vk; Wed, 12 Nov 2025 09:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5lW-0004AU-Ab
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:59:42 -0500
Received: from mail-westus2azon11012023.outbound.protection.outlook.com
 ([52.101.48.23] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ5lU-0003yS-Lb
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8CHK/vvgL1pxkzvV78Fw1/xh8UYQbxq2/LY/AiCoTFSjZtDjkuE6Qytly/exVKJumOzZH/LUQC2lq8jGivZFYgMp/+s+jqltZD7vqd1CUDFNUwQzaeaGtMN3PfZ6tup6Q7fVX/72WETMe5Nfj8BKGVvH0ymokViaMJsdN5Yv4oBaAjIBnbHQk6t09YmYJ9qYb8QYYL3oiRNg/v0O3MC+ZTmxpq0ivt3GBs4fWMSW834NKTW5NdlS49+yRWZkiFQxqM/P6bmuukNVEPIDozQJAbelwijZBCSuX40q6BN5mGymS+wMBE3+iW0Ys1M4ZTcBRGnt4N+L7lBK45JPR1wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W4hG2xjFXt+RyVsANw+BRzv4CI4PXnX+/Ti81llJL0=;
 b=IyLSwewy5Tdy4uyiv+wULpnA+g8X1npU6fu8xuPRyTJqgTxroaTjNpjpvnBqBLqwpMr4bisOLobAUp4q3Tkmt9QKGemElUGsE3AWMsuD+6GbvCEJQllDAlLw0qb6erOS+eoZF4F/XFix5/zj3y9Lt1YItlZkQvw/1oRAEg9cEm/edKFlhPpOVLuObhx17xWEOTfMvPdteZ/LTJGbyA5YEk+ImlK0TIg7RIoooJB/kYKnW9S9EbpcfVaZWrQ4cmFq3ArGucLU43YFmfySfbGHrldKjJ9XiGaAoZMr0gw/JYrIhVlWCx1NudQD9S0+hoGf6acl5TcUQNGMXQU6gbUkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W4hG2xjFXt+RyVsANw+BRzv4CI4PXnX+/Ti81llJL0=;
 b=ZYc0cn+3PyPfFep8xNWEqV/N6GiTL8ndnCecgUZlBTzXnnq/on+MXpPs0AL08/8BQtHUgAeYWlXiEvSNjXMyzzjG/tteG4+B+E2HPoJ+Gu3ttn6m3EHaSFbEYugCHALfsuXNTpDrpp6N9WqKuVPDiJbsYSxLooGC91aM0FpgP+8=
Received: from BYAPR02CA0029.namprd02.prod.outlook.com (2603:10b6:a02:ee::42)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:54:33 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::36) by BYAPR02CA0029.outlook.office365.com
 (2603:10b6:a02:ee::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 07:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:54:32 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 23:54:30 -0800
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <Ray.Huang@amd.com>
CC: <odaki@rsg.ci.i.u-tokyo.ac.jp>, <mst@redhat.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH 0/3] virtio-gpu: Add user pointer and HSAKMT support
 enhancements
Date: Wed, 12 Nov 2025 15:54:11 +0800
Message-ID: <20251112075414.3719917-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 87509c3e-6be1-4f97-46d2-08de21c0b78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hg12Zq+y+yFj68Tw2lARD5crwm7r/TBss63dQaDuW4zlCf6zF+mWqldR1E8v?=
 =?us-ascii?Q?9QbhU7nVCuOKAOtc/VKzUG/C7L2XFNUsqQeYyKYsYnydI/vbxZZMbsuvoU6m?=
 =?us-ascii?Q?NxBq+ILtTJKj6Do63QbM/WEKwx3gf7kWww8t2P3mdFxDkRUZ6kglKSYnr6hP?=
 =?us-ascii?Q?KCp0iqM3b9hE3jf/ehTz2n14yCJJb6PQaEScUXa0MDZsReItRtQcCa71cUyy?=
 =?us-ascii?Q?LGpC8hB+7bFJ7FVq+gR4P9GQHEAIKMMx567oqRu8ISYld8T0YGDp/uC9/z1T?=
 =?us-ascii?Q?1/nhZ51ArzOZpprhVSuM5euVQqoOupySNGroIxMi/Dcn7Kql4diZEXH+4GdL?=
 =?us-ascii?Q?wzGcOyFxRzP+cM5IHnHqFamRnk6VeuDGnh/9LhayvERD+tSXWbIz+Lsf8qVN?=
 =?us-ascii?Q?bTMMhedkvuiyqZCT2yLZWhWjvN0vs6cdUWBfTNjTSHcbniFkFGQTDWoenTq6?=
 =?us-ascii?Q?KoqCLls7X+G1NUHkQqog9br1jw8z0JfDsIU5EG01d+nNVcqi5k7ImPJobrss?=
 =?us-ascii?Q?2ZrTTzKcXOLY2B+gfj/7ogxx4R0q/9RFpq/cMFzzJ+rXaixIxlD2M51cvsQJ?=
 =?us-ascii?Q?vsMkzkbzFb4g7Ro3ZmEiOeeNya03KPatEI7pXEPiltjH/1RTk4ib9bZ6RJtG?=
 =?us-ascii?Q?IsQY9ZHAXkCadgH5JUIo1mkHkGEhTFA1ToWljr3ip4sYzAggI5Ya3qQdZYDt?=
 =?us-ascii?Q?2iPK3UOS9+MoVPKQIJRoK1VcK7OaPkEYcMURwcEsSP1gQP1Pn0Vdr7E8o0J7?=
 =?us-ascii?Q?EBNmXSlO+lWieytH33aIFkeVo/DGUu09t5pnb1mqRJbGY91Ch6JbLbyPbE2z?=
 =?us-ascii?Q?gdCtNcMg0fuYjY7oDfb+/ci8EidVAfRioxtHBBYHpq9OtIkzyQ2Ilc+CcSRx?=
 =?us-ascii?Q?W8yYLzc3hvnLEIHM0+bGjbCgy+7vH6nXUdyZ4ZCyjJ294Uh/UzjzPBLyoFhb?=
 =?us-ascii?Q?TrfhTQp+w19t8knwH8Q68gAIMO0jQpeSve44052gMd2luwApM4f5WPnpl5CZ?=
 =?us-ascii?Q?RKCLJXrVoWxIxJb5YHeF+E8SwAz2NGOcSZfGRdc6RcPOTCkhLZEhqM/iMFEF?=
 =?us-ascii?Q?1l/TJgfIs3mqzqAww57ZCTHWZgfGyyOlyM1sw8Lgz+h5DVrEAIkJF/7Rylt8?=
 =?us-ascii?Q?L3uaDi1NuiZsNjlJiCsWSjE6mtDQb+ryXm2vCJ57AAsxlzwEeidJzTDlW7IC?=
 =?us-ascii?Q?YiYDXVFU+LmKcNYH1LW+giuZ+/i6BJy5183ryAhwtYGJr1pC0qqAP1IIcs7c?=
 =?us-ascii?Q?y2e2yepEFE0fwpsEDhCQgnqzW1YtJL2T2qwngC2IWfdDK6q6oeOiI4sRaRH2?=
 =?us-ascii?Q?bodPmEjpJQNuEBsjHm9xwnpbMH3W5vISe4efmVIcGzQgVdGYaf3LaB1Oh1q1?=
 =?us-ascii?Q?euvJKoSQ99oxSGCruXrkrrF93ziABI8T0ucTlqWyh9WVFGsg1pbjjEFDIlSr?=
 =?us-ascii?Q?XE8nQCyvDbd6hz+Y307y1uqwVc0Rtw0EgQ2saNe6RbPe7ykM/FeTzv+q2SfJ?=
 =?us-ascii?Q?/yrYh9Qj7+E+xA/1IQxl2SzFFnpyzcGDFBkiTUhiRKJDotQOs+/ann1/1eaN?=
 =?us-ascii?Q?PNl8VXAsK5s4R5PfCZI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:54:32.8584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87509c3e-6be1-4f97-46d2-08de21c0b78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
Received-SPF: permerror client-ip=52.101.48.23;
 envelope-from=Honglei1.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:06 -0500
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
memory management and GPU virtualization capabilities:

1. VIRTIO_GPU_BLOB_FLAG_USE_USERPTR support: Enables user pointer mapping
   for blob resources, allowing guest applications to use user-allocated 
   memory for GPU resources more efficiently.

2. Configurable HSAKMT capset support: Provides better control over HSAKMT
   functionality with a new device property "hsakmt=on" to avoid exposing
   unsupported capabilities to guests.

3. VIRTIO_GPU_F_RESOURCE_USERPTR feature support: Introduces a new virtio-gpu
   feature flag with configurable "userptr=on" device property to enable
   user pointer resources for enhanced memory management.

These patches work together to provide more flexible and efficient memory
management between guest and host in GPU virtualization scenarios. The
changes are backward compatible and controlled by new device properties.

Usage examples:
  -device virtio-gpu-gl,hsakmt=on,userptr=on

The series has been tested with GPU workloads requiring advanced memory
management capabilities.

Honglei Huang (3):
  virtio-gpu: Add support for VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
  virtio-gpu: add configurable HSAKMT capset support
  virtio-gpu: Add VIRTIO_GPU_F_RESOURCE_USERPTR feature support

 hw/display/virtio-gpu-base.c                |  3 +++
 hw/display/virtio-gpu-gl.c                  |  2 ++
 hw/display/virtio-gpu-virgl.c               | 30 ++++++++++++++++-----
 hw/display/virtio-gpu.c                     |  9 ++-----
 include/hw/virtio/virtio-gpu.h              |  6 +++++
 include/standard-headers/linux/virtio_gpu.h |  4 +++
 6 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.34.1

