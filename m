Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2D9C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueppI-00045B-Qr; Thu, 24 Jul 2025 02:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueppG-00042t-FB
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:53:10 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com
 ([40.107.236.44] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ueppE-0005HO-7X
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:53:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVw5bvUIU3QFmRyiVtmwdF1xvBWd/yGZlu5JgTG95uuGg6INwYtSsVkYh2HuGf7okas/anpPkC1guXqZTrhEnrADGpcmpanVM6QRqt51LIv2XHH2Oc002elLUhJD9e2Mr9YW/WgQRGPTIb3+C8EhWBhmOX+IKeaTYg88leTkLwRVJxk/ANkziFmfGrCBV65Wt+owCAMEYe3ZDvPHwcMTbg0+y9PwsvAL7xG+qwCMAHO5aZMPzIYmXgCllUk5zgLl5kXGdrfxpIJxhfYe+5dQFhjeLVLDBbWfVGWI4Do5SA4n0nD1/ccIZN7/K+oMU/wZxyLP69mn+ZK+dGTzH96q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRkhIy8HMSTJBIFBA+76b4ZhcpYFwxiVCzn4tXdJS4Y=;
 b=L6EgyuJx62NWv6o84FtIobN/wyrlHAk9mALaew9sfV/LoETHZla/KVZhVgBF3QC976uJg27AJjteAEmWZ5kySVAB3BZFujgkoZH6D1lF8KT2yp5uKvnKqjOtAnXAQXWTPRQ56+HD3bbbj7FohG8GNO5tOp4EQhSqEE9M9OuJdiSp3icYS19VyaAlHI0vE0V6ZHsqrvbAwR9HsqVanUKjIPVcGttvq0OsZXXMHu65a0c3QIa7f5I3TbE9KbesINtrbF2lT2Vh6n2VK35J0Q/3RXI639rsf92YaFOptTNw9pkjs041jUNZ1jBUMsV+0ucB34OMGG26W336AqywOYyYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRkhIy8HMSTJBIFBA+76b4ZhcpYFwxiVCzn4tXdJS4Y=;
 b=usXKlYbWRSQXfaYlJnlCUPb+IvEfJChLHP7/q53mF8VkJsITPG+vIatKGca2qdq8VUVThdVO7Xd/k4P88U+7sRNKmXMjbtvK8/DyWp4FZeuutsMrhd2z6swkdtq9F8sz/6v7LHbaLk0ej1q+wj33n9yV3lY6mwt0a4umls08s8g=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 24 Jul
 2025 06:48:00 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::19) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 06:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:47:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:47:56 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 0/6] hw/i386/amd_iommu: Cleanups and fixes
Date: Thu, 24 Jul 2025 12:17:39 +0530
Message-ID: <20250724064745.4091-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: d43385fa-eda8-4938-3cbd-08ddca7e079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w6zndniNPe5t0FSz2twulOqvL66aaIjjfXx2XfELQw1hRjedPeZ9chIFLb8w?=
 =?us-ascii?Q?TjQNLzHEQYJvAfov2rD3PPfhiqEj07AoxZsbL5r3fYBCEux5fbSgU3891rYo?=
 =?us-ascii?Q?SDG+9Sw1FceiTG0ZHwWRjwu1RiAsBudL0JBqG2m/ttPGNhQ8KBAZUsKVjkXh?=
 =?us-ascii?Q?jAPMNEfq/1sWVIYJIZWnh2gMEs2FCoYiyg3HiIM6+9ssnWXk7ruIyAc8Vx9V?=
 =?us-ascii?Q?tTOs63U7QU91W1vLdI6XI0HNUAH0lsEJSdl/S1c2oX+UC/w3l1Q8gxV7TUCy?=
 =?us-ascii?Q?rQ1OzQQCN/sALogEqVPY989GFtSa+I/P6z7+mhvRl31BNOs2qTYSkQZ03ubP?=
 =?us-ascii?Q?xKNpcizZ2fbwtJDp8j9ZloYGxTIfVVFMy1ikQ8BKAxxoS/AdXdXzE/J6TVQS?=
 =?us-ascii?Q?VekQyMOgxQrJJzuLa3Jhb4t6Zd5/guN36MJ8gtVJO46pufDLkcnDhnhMGr4e?=
 =?us-ascii?Q?zzbrrJcqO2K6p0fT9dMj9j3kLO87M+KJsLdHA4MMeAArNteIAUUFmpy4QcKF?=
 =?us-ascii?Q?iXTyR3uMpvTYcNTnhm8d659v9AysTFCY5FJyXkAerszXlLp2A7zVAvvpGyNe?=
 =?us-ascii?Q?gLd5ubJfNY0LlGZHas7BYt4v7fh9dMxq1IjSKknptVLZTtDgsrcJxaIlbSi1?=
 =?us-ascii?Q?mfIHJWe145OvhvsTPqOgcWoD7gqSdrZyDmjU5ahYb6sq/WSAGr9W2ax5cRu2?=
 =?us-ascii?Q?GlQEoYe+D8Zo2ePsN/QaRHCu8zqAjoKtBXfWFm1dp7C/tfCNwkIu72NWia5y?=
 =?us-ascii?Q?/Z1EzJA+WCazzD5xvldnItuayXZ6g+XE0B8fdwTW4b5lrnhxOZWnsJSFInu9?=
 =?us-ascii?Q?RcG3aem/gt1s0p5K9oL3LknRzqetqiXk/i9QSJ/6sKgX0u0kciqMaUTQs2iJ?=
 =?us-ascii?Q?eLbCHgrJEqXYO4gxBb3y7pregguNjV5484X6QJCon/C5zfzKoOEpuqjf4k77?=
 =?us-ascii?Q?RyOkcmSpHiKZN7//9iOc7zFhdCLYvl895DGWs3T/g4x0/IuZJZ/hsYjJvwLQ?=
 =?us-ascii?Q?tqZp2AuNgB1rbZkkIUTySFI9QJ8NhccyOHMUTsjxjixUmJDcgHmH/f1/98Xr?=
 =?us-ascii?Q?0RNNeVBCLEmOoCqW0g6iaNmOeEsXLuvUeqt6WMV8PIZPZoWk8npnJPrrNA3/?=
 =?us-ascii?Q?/YKz2KmDGXzUto7wPVPrch7O6V8PjgXaSVFWM6t0nRSam/QZQLzz54U9a64M?=
 =?us-ascii?Q?CmU8h8cjooeyc3xVAGX4pEgx9eUuhvuBReWEu/uUbROxsLbxsoEgl3vLew2l?=
 =?us-ascii?Q?QNHMIhseleQiMgbt3udQjL/n+muZcdmnaY6mtINjKNnWtNC2tMs/9XQ/GYbV?=
 =?us-ascii?Q?xukAXKmMv5bHtrZR2wLUYBvvAtZNJRLDFgdWZcvel+doRiReuHzfye+tj8+L?=
 =?us-ascii?Q?avCZtBwJTnxuDWOxhRrPZsF9j6e5vT4ibuAyB+yXXYWcuPFTwdl1EkVzKvUW?=
 =?us-ascii?Q?Gi71DDXIx2XatbcnKTc7dPBQduj4f6w8iB+GMZrazZxvAHr7Pi9OZiVanEY+?=
 =?us-ascii?Q?2mTyJsYXI3hnnTxMinkmTsObsgSVcV9oVP7Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:47:59.7631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d43385fa-eda8-4938-3cbd-08ddca7e079e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
Received-SPF: permerror client-ip=40.107.236.44;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

This series provides few cleanups and fixes for the amd iommu

Changes since v1:
- Dropped top two patches which depend on the Alejandro's changes and rebased
  remaining patches on top of v10.1.0-rc0 [Phil].
- Added a patch to fix amdvi_write*() [Ethon].
- Reset event log head and tail when guest writes to event log base register
  [Ethon].
- Considered "evtlog_intr" flag while generating event log interrupt [Ethon].
- Fixed comment [Ethon].

Base commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb (v10.1.0-rc0)

Sairaj Kodilkar (6):
  hw/i386/amd_iommu: Fix MMIO register write tracing
  hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
  hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
  hw/i386/amd_iommu: Fix amdvi_write*()
  hw/i386/amd_iommu: Support MMIO writes to the status register
  hw/i386/amd_iommu: Fix event log generation

 hw/i386/amd_iommu.c | 89 +++++++++++++++++++++++++++++++++------------
 hw/i386/amd_iommu.h |  2 +-
 2 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.34.1


