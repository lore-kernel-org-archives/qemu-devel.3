Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37EBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAH0-0005E8-NE; Thu, 06 Jun 2024 06:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFAGy-0005DW-P9
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:23:08 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFAGw-0007rj-MI
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkRxcwhSbd6FnZentT5yur5WowKhLVxZruZRMIds9LDFFB1L2lNYrjqaGeWnp9Sp7si+2MVED93ScFRh3CHm53Sq1BZjaQvsv9MjR8EAHY/Ws25f8+7YMk8Z4W3bAxttR40vP3ObFNt6MtvCTaEMPDii2hl+OBkKmeWnemqD5Z9iR9ff9j2qfa0pmD/uNq+79Si1a5V44RYFUepp9ahrThReok862Ce+Dt9PlNoDfZJ9pqPU8ldgAFGJtFX78Vn/PriP4QQG2vkoy4jXR3lD1WgpSrYJ93zUpKeY8QlZQdbQQvUI75EEHnAxbEjeGhq+SkqjqJ8Brmubus5kfAp1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adzI6SwRWiCX4dOhcKq60SVFvOBfBB/gvXFt8Sn1tD0=;
 b=EdzEdDB5i67hT2HWldLeBbGTgwUFdvY3sQ37WVxZZzJVZy4QdC2raADdmUg0HWKZLWkVz5KG1xVFRtDaioPRIfSmBE5dYE6R5vborfrHr+IA294mLmd/NL73DuWqwG00huw362R/hZPndbeDpGJ07a2t7qajldMpwtpcAAcJU7vKmu85Rz4pJNfMVkwj27j0uRLzue3i4yOlERuY0DtwMwsaCkynQujtltXJMp+8pH0GAq/j+7bvF4Fw9Sb6QTP1wSnaViB9OiZCdgtJfMGrvYE8FIcdgbhIqQNYZ2JDedcwdm4q7NmSnX8JgH+kDhpgIDytCIsTca6ec71g5hl70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adzI6SwRWiCX4dOhcKq60SVFvOBfBB/gvXFt8Sn1tD0=;
 b=MBKOnR6OKRohjwgZA07+ke2O2tzZhy5jvaLFHMBzZ35BVJZKsE9jYoIB/dMXF+oIF8xLoxUiSQBZnx56Llj8zzdfNeRH5QN7BkFwLwFcboumDv5QJt2Lx/eb2XCM4har5Q9c0XU+8EmPatAexVLfshgL+3MCwkuczmxEfXNG6n4=
Received: from PH7PR10CA0017.namprd10.prod.outlook.com (2603:10b6:510:23d::10)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 10:22:55 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1c) by PH7PR10CA0017.outlook.office365.com
 (2603:10b6:510:23d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 10:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 10:22:55 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 05:22:52 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v11 1/2] virtio-pci: only reset pm state during resetting
Date: Thu, 6 Jun 2024 18:22:04 +0800
Message-ID: <20240606102205.114671-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606102205.114671-1-Jiqian.Chen@amd.com>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bbaf9e-073b-4e2c-68d2-08dc8612a131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nm27N3WlJH53aFg+V83ZuyWthbqZZ5kFEgr3OM9BiNnPR6JBbtmmHRyVdehZ?=
 =?us-ascii?Q?iLVPeVADyfseeUmbvLXGpkl7XIn0yJTgmrZqbePwqr1XLystrPdf6L/+PBDs?=
 =?us-ascii?Q?MH+Rqj3ibHIalzm+mJCJd+V2tTCFU3qii1MSe418DX5FOUWaSFRO/sQrC3S3?=
 =?us-ascii?Q?nZMYonlmopUR52uQp9mJuJqCZ7Mq8s5TkKDRpPF/j7My0AC0Do8yBZxOC4+B?=
 =?us-ascii?Q?DMJBD9vFVx5XdbizTfB6Wp55MiaEdGc5f7KlYIpi0x2xMDMOYvm0MaIzPQ9+?=
 =?us-ascii?Q?xgLNpbM0/mvc6x++/2vUpmBBrLunCtpXmlcXOCGEi28BNwCG6AHMrt78hnYY?=
 =?us-ascii?Q?PVltOhrt2bnYGksBTythe1tI6U3mVYutc8j7iec4IH5VLisG+zEIUXwUijIt?=
 =?us-ascii?Q?4rqk/LRO08cg1vjOdYLSh60geNq76fWFcZ8xP5u0F7ox1xDkpVJaub7ruuVP?=
 =?us-ascii?Q?22NQ6JJqHwCTTzOazoi76+1/msS9TLcBq+M/cY6Eh0g9dxVdn8pYblrcxk3w?=
 =?us-ascii?Q?+yM4t/XaVk79l5Bzanu/phdGcnu9FN5xZYcmhoK7VTS/JzkFdCbGLD93VJbw?=
 =?us-ascii?Q?qPEHl9XPcC5XdwdvhqXWax78N27AHkcx2eImsEnlaG5aVu6BC22VYPU2zPgW?=
 =?us-ascii?Q?ecbmeRf0xeATW+IA+pQzxdYGwoWzICqXKi/DVRy19jT9LcvCzIcoaOZZkwRV?=
 =?us-ascii?Q?6/LGUEF9GtLAOrjdBSUPwDSMHByQSfTzxS85njoN/9NooXYN+OlkJNaFKW2d?=
 =?us-ascii?Q?zX9Wz7ncmrK2YcXKEPpqvtZ5ZDMSeCAjK0yh/nO5NqAi/tGI/AFza+a8wzF4?=
 =?us-ascii?Q?gW7bbX45unpNB85o2EZZu8Uxsys7pIwkeM/udB/a9wFCga12Bx3kyv7uMgdh?=
 =?us-ascii?Q?ORBw2ny1FOdvy25knyOgPBWE+Phm6XUzthp1vZdFtoL1ZCEPdv43sdXZbMuL?=
 =?us-ascii?Q?KGEDoBIeHaY9bgUT0tZzv4aKPwt3P+xpXKw83AkyVCbmbh5FfEucqljPGd1w?=
 =?us-ascii?Q?aI2f00Ef4ipC7JarARGxawjT/EEuq1uNAKjvs2MamYr01SMxzbDI+9YxPvpO?=
 =?us-ascii?Q?f5Fu8YbnHEYbOZ8XbjGbsNqqkSrSqvXOCQ08C+RORHM3N4+N5gXGev3yP3Qq?=
 =?us-ascii?Q?FtocbESQQng08z5M09Rjge9ZWDiFophxOc0yB+pFD6L2bVBqnjt8QhPPqYjd?=
 =?us-ascii?Q?u0e1dg3YtzbTnZeRAydIn95svAHLYjy03JoVd1fV3TeXpoBcHWnz/dI8ugSA?=
 =?us-ascii?Q?ffAU5SuuRQ8oYO2YbE7oTZ17jNzqvrDHB1t8fvhZi5qpFnsBh9f9OXznDrAZ?=
 =?us-ascii?Q?BxP164X52ZfPURxLIKlxU30ljmLevrlWpfRv0dm1gq7VX3alOcAdoRSn9Cb6?=
 =?us-ascii?Q?NT4H1u88IhXcQ1MxQ0UJ4C61SEJsdop0g3JAVKqJWn/siVanhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:22:55.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bbaf9e-073b-4e2c-68d2-08dc8612a131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
After this change, observe that QEMU may erroneously clear the power status of the device,
or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b1d02f4b3de0..1b63bcb3f15c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2300,10 +2300,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            pci_word_test_and_clear_mask(
+                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                PCI_PM_CTRL_STATE_MASK);
+        }
     }
 }
 
-- 
2.34.1


