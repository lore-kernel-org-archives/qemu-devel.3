Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE0CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dno-0007Xd-Sl; Fri, 17 Oct 2025 02:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9dnn-0007Ww-RK
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:18:59 -0400
Received: from mail-centralusazon11011059.outbound.protection.outlook.com
 ([52.101.62.59] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9dnh-0000Tw-Rj
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIxWSqePnQLZW85y226b3bRRXhitS+BJyz1bFLyt0GaiT41eWtNg0nCfSmiNWmD356R9XBavMziN//Gcqv3UnUlt/xJa2lsVjpjK++D6uo3rWLERR7NXAcX5XnUNmIrEDy1r8WRFI+W2kcUuP6qlvniFxJ2MoyvXreb5d0vDSlwHb5/nH2K8ahPeQROktIWvYS7iiCUfHqarVd2Gd2IJxuLfrCon+IFaH055KAdoO6UTMOtXqPw4x1WQpaoLG4QYz5CnRaeC4O1Q7ZV5YRludxl0CWsTxDh2x2UmV8Aq4ym2f6z7koMOb2vuXG+kUSdYAD1UGHJ8ESrkwetQ2aveSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp6YYcHSu4hYsbVIbMis+AykoOJQuL8XJnXxqCblEaY=;
 b=mkzDcAfcQa0C3u27qxTRZB4I/HfZOT+I35BYMMI18W5nmewfpYrlr74O6bvJa4TGDd7ZBfqOGen7Fx8kuwIuLo0o6zYwdi6De9ODydkwNHdaejPbV4ySRqBICttE/6+8ConnNxjAs/Q+iwgbdgPjYc/viLhPMZS93TXMHbhctrMBAE6xtNP/JXOp4lmSOxGQTWXEmDrbeNZxRSjfneJFOeFq+ekfC1xFFAtVTURN8FkVaC1D6Dg9ws2OAcqnXvzpQQWnHsElyci2WGw8ZTLWYrp7uWuL/QLGChWguGf6FadvfiBDWpESLsA8Ri7vKA7ORkC7x93cRP3mMvQ+Atlhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp6YYcHSu4hYsbVIbMis+AykoOJQuL8XJnXxqCblEaY=;
 b=yje9OAFaGHaPzzJs6cT81RlUV0SSYnzaEOPrN/PvtKCk/DncC1CYnhMYitOVIEL20erGr/wHhzaPo2AJLRl5dcptvdhpwOfaM1rzNrH3omSGVbFjvtdPP8fvpe4Dv6q5dXkMeKkZJVLbTN0MKam4PTbUbmLfwqjKIE7kjWhtPxQ=
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 06:13:45 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::58) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 06:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:13:44 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:13:40 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v3 0/2] amd_iommu: Cleanups and fixes (PART 2)
Date: Fri, 17 Oct 2025 11:43:20 +0530
Message-ID: <20251017061322.1584-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b277dd-8220-4841-c9a2-08de0d44539b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GRBPOBqB228bBFOuaA1g1a8IYb2VCOI0CZcBPTWVDePYa8XgSekegoV1Uggn?=
 =?us-ascii?Q?xgHL2TjirFTQT/ewHzMA8I6n3izFkzyJrsgZ3wdCDLF1kWwvFlLDCa3LyjfA?=
 =?us-ascii?Q?VAnwh+4AyF+nbAFstYN/oV/gsrA2ceGP3T3P2Uwj4Q8fohTA/wgQd4DUBs5U?=
 =?us-ascii?Q?5HwY0ivXiGfwWfheW8ziDkypPVke68vokh353keKZk3V0b6bi9JzEPfNxe1b?=
 =?us-ascii?Q?wNcyTZFV46yNFCfWUv//wHwTbvUJ5gQzpXNnoWeO/0sm7LfozTzXLSq7nbip?=
 =?us-ascii?Q?nGZRrznbzw5FFlvG0/N1iotsIWUJzHULGyPx3JqPOxJLMROtgwRRXVLYP60Q?=
 =?us-ascii?Q?N5gZzJX96kUumPFYHYYJJmVeV1+zEw2FdoO8u6KhatqUYtH/FYykliQ7G0DX?=
 =?us-ascii?Q?mkaEttID6fa0PsKx7UjI7tGi+QZH5LELBMJR9WP6GrE2q7e04YqHRa9fkNEC?=
 =?us-ascii?Q?l0AMlzNpWCQsSMsIHKt9S4/Rioy5d2H1rhyL3Nzr6OH52z8KbGn9YdE7ak/X?=
 =?us-ascii?Q?3d9hAOY+KQiZcQrm/9GSqvLD30CfOlhei/LT+WltzpU2XR/oDg9mxaPvUjW4?=
 =?us-ascii?Q?f6bBITmuGM3EvkeNlg/PoCR0dkFusg+Qk9x9ERVKtgFxaCFdfb1yPNjWeaSE?=
 =?us-ascii?Q?HT3b3/WHrGFezsBf+VaudsU0Wiq4cDOz9DSdZRDy1T2ryu2O5E5pFEXrU51t?=
 =?us-ascii?Q?fCCN4ym1xwpF2CCcL07YnA/yZq0S0cYQ1JeSBUD0RUvJwPwBQuCMBOtozv6R?=
 =?us-ascii?Q?qtgpIUkGg5cQYVEFtUm05AbJfMKLZeR8Duhw6PGwZvm8lKle1h1Uu+93k8Hb?=
 =?us-ascii?Q?WV8HRSIiya8GIo3fBb2REQLVSPDyUHq2QSb3mBit0T5UKCbyEua9yV+hDg4v?=
 =?us-ascii?Q?EOCfdv4GQNYunFl//cZMGlh78K5M+UaWYpgTQmTnMARL5PS5D3h1djkAbo9d?=
 =?us-ascii?Q?eUEv5A22plZDDHfP18aOMc2Ou5GJOjU0fGjjLpGrGwgPLAYTolu1xdOhriDM?=
 =?us-ascii?Q?622/Eedcwmj1EdIJ5YcnyE4ynDtM4f5f7/dVnyNMiVtSoAp8oq7LWy7LKqq0?=
 =?us-ascii?Q?+5tjktY/kTHdHJryM2RtjOe5l9QO0Wa9130DJx+Q+PuaxM8rbo5pOTx0b7Ox?=
 =?us-ascii?Q?ATsp9cTuSQBf8eW0MBt3WB1c/qxtiubPpLeC0Wuv+DsKIqxrB+xQOtSY0JnJ?=
 =?us-ascii?Q?7VBSK7to7S6Z5qXpzy4XM5+ZxUS1UgeljaJCwt6QCpuIYGRERFp0D7xB2+3T?=
 =?us-ascii?Q?a+lDtB86X7WWWNPw2x3X0nYHzeaHEKbztTvuRlprDKzOQDpYLzmZIaCSFFk3?=
 =?us-ascii?Q?PWQ8Zg8IEb3hNRWpWltwY05IAx09bhXtvKgYaM9JDCWlLYPIU1h6acXpmqlK?=
 =?us-ascii?Q?riS/veYm0B3EpvTdFOW/BG4xQglZVz97k46GflrfpYIWQjPHJLdTtBZ9OsCn?=
 =?us-ascii?Q?Dqx2h7goRBTJIDfIMikHmHDcHW3DAHe4+qUTzkVESRDMLhtPWpsa4pX9lyzj?=
 =?us-ascii?Q?mL/eyUEZMFvxGFjKpoeJVXhgTiArJ/2yupcY/xo7TEJnoz4sVLPZcCwL4nNy?=
 =?us-ascii?Q?XH72q6TShqi9MV4kWMc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:13:44.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b277dd-8220-4841-c9a2-08de0d44539b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
Received-SPF: permerror client-ip=52.101.62.59;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This series provide fixes for following two issues:

1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
   bus id != 0.
   e.g. With following command line, dhclient command fails inside the guest

    -device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
    -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
    -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \

2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
   setting up the devices when guest is booted with command line 
   "iommu.forcedac=1".

   One example of the failure is when there are two virtio ethernet devices
   attached to the guest with command line
   
       -netdev user,id=USER0 \
       -netdev user,id=USER1 \
       -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER0 \
       -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-legacy=on,romfile=,netdev=USER1 \
   
   In this case dhclient fails for second device with following dmesg
   
   [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 5664000 usecs ago
   [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59: transmit queue 0 timed out 10720 ms
   [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq: output.0, vq: 0x1, name: output.0, 10720000 usecs ago

-------------------------------------------------------------------------------

Change log:
----------

* Changes since V2:
https://lore.kernel.org/qemu-devel/20251013050046.393-1-sarunkod@amd.com/
P1:
 - Remove cast from the pointer assignment [MST]
 - Rename struct amdvi_as_key to AMDViAsKey [Alejandro, MST]
 - Fix compilation error due to missing 'static' [Alejandro]

P2:
 - Rename struct amdvi_iotlb_key to AMDViIOTLBKey [Alejandro, MST]
 - Fix compilation error [Alejandro]


* Changes Since V1:
https://lore.kernel.org/qemu-devel/20251008164324.21553-1-sarunkod@amd.com/
P1:
 - Use fixed type uint8_t for devfn
 - Use uintptr_t instead of uint64_t
 - Build hash key using lower 56 bits of bus pointer and 8 bits of devfn
 - Use gboolean instead of int for amdvi_find_as_by_devid
 - Update comments
 - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE

P2:
 - Reword commit message
 - Correctly initialize `struct amdvi_iotlb_key`
 - Remove unused macro

-------------------------------------------------------------------------------

Base commit: (qemu uptream) eb7abb4a719f

-------------------------------------------------------------------------------


Sairaj Kodilkar (2):
  amd_iommu: Fix handling device on buses != 0
  amd_iommu: Support 64 bit address for IOTLB lookup

 hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |   6 +-
 2 files changed, 113 insertions(+), 72 deletions(-)

-- 
2.34.1


