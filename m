Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49675C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwhi-0003Wp-KE; Wed, 16 Jul 2025 03:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwhg-0003Ur-CV
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:37:24 -0400
Received: from mail-sn1nam02on2084.outbound.protection.outlook.com
 ([40.107.96.84] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ubwhe-0001XT-3H
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No1Vwpe+uRqUNZJodFw57ilcciZzRj7hr+TawoXPUcLwRqOcN77+ULgjkmOakjDuCp0kVpB4apkwdmWJ7fV9YBrJ8TxQCTVMmOcAjsGZAqWAtDuI6q615N2427omZ1rQq9puPNQWsgViX2ErfHXTYsSvQn1nAG2E7YCe0KoMF9U8FKZeQo5SHGzTHEu0bBqM+5EcJ7oOqvAtz3l10UpnSnr9R4EDOyKaoeJqn4hkaKt5XMUG3nqrSlkGEVtzJU0o5baX49qHqTgDHJELedMJXW6q2AybST5XW0svhU21J9VRlYwoVQSh4rQmaDxdex6xJXS1o8sdUXcz9PW7D77muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSdg58PMORlD6aMjsU6yIew08DqM9K7tHX/1IwEDltc=;
 b=QhgfY+QXIhd4iM/4d11rEXOHVHHR+b8Zr41DyRfHMk8oCtv83uB1iyVKgAnTXOx+K0l4o+zDHpwr2f7hFa/D/tZavm8tfKohUYurykbJVuAJeIkozakL2zDTU/OJbj2GUFe5XiFaPtThKU2yMt5rQPIbmwRNwrt6HxitZMEG31FZjekgSrC0ZseTWEvSA6XIBQsm+Pzb88/dWwrhiNOeuWSxCDBhkkWpAvYKO+b+o4dyraElOBllydEwA1k8BW9NbT+pr55AXB7kfn3cj1tFhIKABjOdVrJhtPQRUbuD+iagcbM5SOjQmCk88Jh8jbL431YAelR8WFhGfWFgiclCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSdg58PMORlD6aMjsU6yIew08DqM9K7tHX/1IwEDltc=;
 b=bjwEOsp01ebjQpfMi56HTMep+lfJi19dIh0UGoGTeKnLmGYvXEgb5xAtVle8ZxAuAJrVEXtaLRRmXRXnBvuTB2RbLCaCsMmeJK+U3ihDI2i8Nzn346arsv+nYv+LeHOoSks8sZVsQXzgNX6ODJ3oMvocWVyCM3oLa1TJlzvd/Dc=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 16 Jul
 2025 07:32:12 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::6e) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 07:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 07:32:12 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 02:32:05 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
Date: Wed, 16 Jul 2025 13:01:38 +0530
Message-ID: <20250716073145.915-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d10935a-1f5f-491b-5c82-08ddc43ae157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F1AQZ841HAVkKehrG43yYG//7p1fkw/Javlycu7kRk6j61cSkOvt2F1X6VlS?=
 =?us-ascii?Q?mzaibC7QxZTJtti5Hs3k9CbcPrBwiiCO4LMTJ78XyaFum0Rug0lUi+wmt0WQ?=
 =?us-ascii?Q?4T6ZMtCFC+YND63a6q11+P5Rs0TzcRbx602ZV38uayF+zRDv83NOEWV1k7QA?=
 =?us-ascii?Q?pkJVvAyXioVeOIpHu5Ikr6h6iDo6M9s3XTbHPQF+B/sQB+xwOmpyEPCdhfMH?=
 =?us-ascii?Q?tIlPwpzcz7VaiZD02Vn6hjG5strBXrrTy8yie7W1ZW7K3wsLzJYcEckcLYif?=
 =?us-ascii?Q?IcNCh8iyEBF0xWQbeor/yY2YRzIy3UE4DfCLUU5ZIqfQzShOyy88VsJqFMTM?=
 =?us-ascii?Q?Tvus741Q88kDnFrVMsm2YF+RkUTT3GSEvUW/gE8N5eI5r00RPjvaFzWVNfVn?=
 =?us-ascii?Q?d2mI+Y6lkCnrQ0A7vvn4Nct6hdTI7br02MCF/+Ligzz82WHJPG3KHVyNf+Vv?=
 =?us-ascii?Q?aodZJvCfnOcFCelGW5pul24UIaozaQKVGfh752kELsF5rgLYQ/wdrT5q+Kd1?=
 =?us-ascii?Q?P0PTWgvT32+RdAsr6ZsCXWxXkL6DDN4wSzK2lCDjyUJjRRWPq9tZwHVyWP/q?=
 =?us-ascii?Q?Fb/QzxcyMSHgh2cyhANhG5Ygim3eOg7bFw11wG/UWWh1CmS+5TvtYS/52op4?=
 =?us-ascii?Q?W9M4SJ3e/Ub7KG0jih1yCOjJMx3T08IYGHAAhXQItPFCU5cuGmsioTlpMrMN?=
 =?us-ascii?Q?KMIaeoDCabdCXZ69//sengZ0iUZ4jyqO9Exj96dDioq4/DIINve+BOsO0XgP?=
 =?us-ascii?Q?FO4fvOV1ZFkePVh6wi/gYeZI/f6l5mbbSdOpGb1+b/fzdrJfWXwxS0csQ6Qo?=
 =?us-ascii?Q?e/i8x07tYTIC+OQRHou/1OIVp0gHC++0w7BzyRTGjrHYaAusLQawEVBTmwEm?=
 =?us-ascii?Q?pCMNtp+rMe2Cu4uf0RZaCBjiHdr4TnN7DUCtPcitZsOUQmfB4ZF5LRg4eL/R?=
 =?us-ascii?Q?19JLzdTeMUhCIcuWoZ4+A/dtPVCnN7f9WCcPDcz3yBjDZBXh6Bm0LGcqbBkf?=
 =?us-ascii?Q?GncQ8ryw9fUd7/U6LVhu09XewoFJlATULlNymteKXaqFDW3Ib0INFxkB2ly+?=
 =?us-ascii?Q?adqbPYHEYCLqN3GcONxw+aIQCBR/Ix++zbQLoPaVjXrl3ylj/YAPx40s1A6k?=
 =?us-ascii?Q?sOlRs86cQU3lBt6w00mXp09hoDyK/VZGXj1bfAnKvLU1tCdz1OcwNTApDnPt?=
 =?us-ascii?Q?M1fAkYv+YvhyBrvVOAI/6QsY6tED6YUrEZ8GvVl/D8g86SsLr40JKRoLrEX/?=
 =?us-ascii?Q?i1rRb5twyUR+PiQ4l8GQpfIDpXU9Un6y21L2sSsZeN14NqbzpI4yLRDchxnL?=
 =?us-ascii?Q?fYFgsOO2VG+++7CtjaWyW2aWF3zkEorDeAmzR9hkneDK2WZ9QZSY2zGB90cT?=
 =?us-ascii?Q?1x+nqisc8un4GH4+JhDUH5TZAvCZ4AMVs2rAL9EO0A2K1mokQlAEAgGUgRr5?=
 =?us-ascii?Q?k3VVoYMcKycPJSk1/A2U72wBN2HiXZygpvJkjtj7042rXIK2X0mcD84T5vGg?=
 =?us-ascii?Q?M/NtAvta2t/kUwg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:32:12.3768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10935a-1f5f-491b-5c82-08ddc43ae157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
Received-SPF: permerror client-ip=40.107.96.84;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and Alejandro's
DMA remapping series [1].

[1] https://lore.kernel.org/all/20250502021605.1795985-1-alejandro.j.jimenez@oracle.com/

The series is uploaded on github:
https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1

Sairaj Kodilkar (7):
  hw/i386/amd_iommu: Fix MMIO register write tracing
  hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
  hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
  hw/i386/amd_iommu: Support MMIO writes to the status register
  hw/i386/amd_iommu: Fix event log generation
  hw/i386/amd_iommu: Fix handling device on buses != 0
  hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup

 hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
 hw/i386/amd_iommu.h |   9 +-
 2 files changed, 146 insertions(+), 80 deletions(-)

-- 
2.34.1


