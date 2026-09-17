Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB1C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Aha-0000rf-0T; Thu, 17 Sep 2026 07:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x759s-00080a-KR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:59:44 -0400
Received: from mail-westusazon11010065.outbound.protection.outlook.com
 ([52.101.85.65] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x759q-0007oN-RM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtqQdFTgO8fpfMjj95LHFo3WkTulvWL8uZnmznL9IdpN3K7feKiSk6wD4KDbU96HoU4jRaaRtcCw8d4KcFSNLTxXrpJRTKZNfjsEyZreHcTZm4hV/7FYHbj1eUukS3PAdKlGrX5h/K5IKA2pBjAN/xdPz4CedUXujZvr8Snj8VtTzbBQNWkos+j+slEXIe8W31O3XdhDcKqDgRMGth/TDKBvctxKClQSD4MNzRjaFAYk7nFv8j2wMUEfkILRSK7nhDmUkGc7kZxvz+3MbMLYzOJybWmrU2jR0mTc96Rw48n7BxH6sTEffU/Q5fLDyQ/0d37fibi5QXDa6FAnndgOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faxgwyaAWwQ6/bqf8psAY4RZ3jhNUM5pcbTniRG+BFY=;
 b=NUDjRx8NE6I1JwohNhw/+tCu6KFw3mqTMSNL+aAMl0o58e/d8OzsBaEDMgJhFEZrmgigvOud9MYZv5X2pwC/mR29os42CwDeXuyGLaBRpSpWxaJo5cmjzZ/Uinf5f33sIrDUpYs1fWdx2yw0Ery2zL4yyntpM5RMQnzouw2ZiyH8mcnIuGzkig1kMJcVUXbVaYWQLR3lTtWneGg/oDX11XIiFCRZfqcCz23Qv/ncdHKWfKVs0uXOaLl+aH/+tvaGDZi32nRF5BqGPLMM8FzeO2nfh/sNNkguMz5fySzvX4KDZGFPPBvDWC2yezwYLtUfmXF4onRHcYlZmIdmL9OjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faxgwyaAWwQ6/bqf8psAY4RZ3jhNUM5pcbTniRG+BFY=;
 b=MGM3qjtDdoRI6VVXgun7K6Tyy8KNKpysMso1hap7qXbc8aTbllCL3in3r5JX4bCjTWDkE2u0tbs1KTdvZITKMSZEx2rvPioyJwI6AJ2pcne4M05JVZ52nelBCTqFtY7Z5wowjmN4rnO9xTSpKA5jitymRYr+PSAi8ejNsXu8aH0=
Received: from CH2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:610:57::14)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 05:54:34 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::82) by CH2PR12CA0004.outlook.office365.com
 (2603:10b6:610:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 05:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 05:54:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 00:54:32 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 00:54:31 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Meng Zhang <Meng.Zhang@amd.com>,
 Baorui.Liu <baorliu@amd.com>
Subject: [RFC PATCH 0/3] virtio-cpufreq: Xen backend for guest CPU frequency
Date: Thu, 17 Sep 2026 13:54:14 +0800
Message-ID: <20260917055417.495-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 06477f13-f4cb-4178-eab1-08df14802593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8wckHPxVc2Ffsb/0NJaAuOsYTVDB7os/O0LreNWWzwLsQTULfM2gYsTFb3yFDfF7ZIez2riF6hqi27Ak3/eZr/gVU92FLGboae1qlO7uihN8F8k+vaH76xz+UU2vuwM+uv6LVrG9ggoqAf79TZ/wrairUKSyWdBDMZ5X8agLwpfB/1r74+3oYTBrYlytYuQ+QRMZamNLznq3gY5o6UPjxy3IisnuWK7itNvysDKQ03+LiWIPZYiGJ4jYy29bvor+xCbhC1t6HiujacoKiwzzEZHUCkbkrph/awNLvzyrZg1GA9GvPUMZYcQVuvmE8svG/T2mcRo1taQbMICpNLZTVgpwgmM+R+C9EA+uWWvY0mLz4ro7z/bRrle44MV//q3xznmIfCBar6rc/fWTnVvj2X/byr6RBSfveGDa+tbewkSwLBZ4xU5SbnrkKJtQFek400vVe0kGLK2vmgOs1qnjq0YTkkGS/wag3P3xm1sV4yz4l+fxj6JW154kHlD8jLfuUFRaccONMYVLaoCjX9EV3KkRb9pAZsZuVgOOK+9cgiCJnJoV0gsanIvMoAigQ9Bjx2cMzt9CFTi8Oq1HE9/EGPMBS/KA2gPyQyJYHhflOMwCd2SUxMZG8jHURWHh2oTqA1ZpDuazv/qhc8XcCklECD1JTWpMT8WiLaUXa5kbJTG2oTKE8w2T9VYZQS/825uaN+IGPCsJdKC6hS4ewwbdag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kQkqM6p9p6+208isIThrKqLtDToDCjAULtCxXhrC5wJbmG2SDR3aq5wS+lWWHJWbUyWVA2eyKPDWQn66vo0gSAUPOasMEa9yFbsrFy2Yb6CyR8A91nTfJGpVSJsPAr1G7P4+DSE9tP/LBFAbGmYhEceDLd/1Ikb5G7ZuHpb4OMkC2o9Y/bkuj9EQk8bBsSRviQdE5j/AjDMCPuu2Rj7EcOs2rdEHw53v7lPcGTy5GShNPzzD02uJ5KNAaHb31YEnKlCNwr16OTqStrLHPtQe4WBBgzWhi2tWRFua3XGIKBS9KIWysbw91S05Va9ZGsgKHaqKrb24fDh3S58gXBO7jHa6JXcYOUjLrAV6oCiIxqShqNZ5syintumG8EaYotwy7/VcizNxDMuKF8iDOGXPErRAjRWm3+i/HUtX9n0hqPv15jcAp19936SDziUPNxVH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:54:32.8259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06477f13-f4cb-4178-eab1-08df14802593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
Received-SPF: permerror client-ip=52.101.85.65;
 envelope-from=Baorui.Liu@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:54:51 -0400
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

This RFC adds a Xen-specific virtio-cpufreq device model so a guest
frontend can query the host pCPU frequency of the pCPU that currently
runs a given vCPU.

The guest protocol uses virtio device ID 42, which is not assigned by
the virtio specification or by Linux. Patch 1 defines that ID in
QEMU's imported virtio_ids.h. checkpatch warns that this file is
normally updated via scripts/update-linux-headers.sh; that script
cannot produce ID 42 until the ID exists upstream, so the define is
added by hand for this RFC.

The backend requires each vCPU to be pinned to a unique pCPU. The PCI
device uses two MSI-X vectors so virtio_notify() reaches the Android
frontend we tested against.

This is a port of an AMD qemu-xen device. A companion Linux guest
driver RFC was sent to linux-pm.

Based on work by Meng Zhang.

Baorui.Liu (3):
  standard-headers: add experimental VIRTIO_ID_CPUFREQ
  hw/virtio: add virtio-cpufreq Xen backend
  hw/virtio: give virtio-cpufreq two MSI-X vectors

 MAINTAINERS                                 |   7 +
 hw/virtio/Kconfig                           |   5 +
 hw/virtio/meson.build                       |   2 +
 hw/virtio/virtio-cpufreq-pci.c              |  88 +++++++
 hw/virtio/virtio-cpufreq.c                  | 242 ++++++++++++++++++++
 hw/virtio/virtio-pci.c                      |   3 +
 hw/virtio/virtio-qmp.c                      |   1 +
 hw/virtio/virtio.c                          |   1 +
 include/hw/virtio/virtio-cpufreq.h          |  23 ++
 include/standard-headers/linux/virtio_ids.h |   1 +
 10 files changed, 373 insertions(+)
 create mode 100644 hw/virtio/virtio-cpufreq-pci.c
 create mode 100644 hw/virtio/virtio-cpufreq.c
 create mode 100644 include/hw/virtio/virtio-cpufreq.h

-- 
2.34.1


