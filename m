Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A52CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeBi-0000Dd-BG; Wed, 20 Aug 2025 04:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAi-0007lS-EM; Wed, 20 Aug 2025 04:27:54 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAa-00018g-C6; Wed, 20 Aug 2025 04:27:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhNOVE8ArzKut7yhmjbHwltkC00euJ9UPeoCNYazpzI0PoPNk9ThoGjzttNs61hZVBEc5oPGS4mvqDS4qhguOUARPTQwQsN54keHCOSVrMDN4KCdGXAb4JSXR8FAKlCW7SkEUj/umSCxbJmOTbi+/Ck/Qk7GumZcHazcXNReIgCV5MtvqPg7rdX2eg6mvBy7jx+uLc2BYFHYuRZxYatMjUgMpFvTtzaYGyDaBJcz/AfWzPmg18oIefcxmCPDm4CNDx+xSBBUJfLBA4TUPgF7sGIMfd8fSvpRPSNNdgj380mfap4rObtspXUBMnilt37hiIfuJNr2WY4FFBOs85BdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=Czfd0uhTEBWFlPnIzWGM5EMXFH8PGHAaQFtkrrfddZ9Bx1VrjQlCc1gMxiopuS5Dz/SbTZvf5//xUkAM1toqJS38iSzsLHE1/WLsirMSiKH/LOMRoG3qDayhrw1Re+QkK7hIo/5SGefdiwCi1hWWF9HwaaPfejMvjWsmaDGmNgN+H7Ci2OZBPOm5M8oysX4sU9lbbbhlau3DEft0pXOS/LRj4P35bco8OEo39nWL2f9Vzra9fZpUtCauK5mIMX/DC9918laF+gGSxhoD5m8130U0E26VE3xgL6Q+Wzv5uz7X1bJeZS1tg2mlbXT1BKVPmRDjmgu6KAgJyh/apuFa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=M3tSoPfkA+O7o1IZprF6pJ+RcVMDt7y+mJWccvrFiiJDoEslVPN0gkY7CIr/gCIx52rVLiOv/oUH8wO3DfoDNcse1qT/R0qL60VJg1DLgbB+b+U2ljIjlkjTI5VYILiIVpW6hBxbydm8iMgI308GSlhHefXcgILxNk+pLRJOJ9E=
Received: from SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:27:38 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ce) by SJ0PR13CA0033.outlook.office365.com
 (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:36 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:35 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 45/47] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Wed, 20 Aug 2025 10:25:44 +0200
Message-ID: <20250820082549.69724-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 087d1ef6-a53e-41e4-ce2a-08dddfc36c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OhmrItO5y10cOrdcOlHf6Ya0dmYBLNMp4TpwuK62v1sXVsrwAB2IKJIfhCF9?=
 =?us-ascii?Q?jeLrls/w30+cbupXXJsTmI81idUDYTWthRpj/yi3gCrjSOykxch9+1lG8hh0?=
 =?us-ascii?Q?V4kLcpYqCV4HnnbkBEmKS1KRmVrFOchtoKGNAOAUuDfLYAwtvyQlpEgPjUUe?=
 =?us-ascii?Q?W2MAN7veDqENnZ7pEZSAcuI2VC/Iap9gekMwHxMMCnqnoUTGRP2M1F265NIN?=
 =?us-ascii?Q?TcvZHsvgN8usvLx1PHFrP45SHKHImuQc+HMLzGGhdbfd5dbYzLO61g/4lIEM?=
 =?us-ascii?Q?kyn2IXJMj4VBN51jEt1spi4E0sk7vF/oymwmy61x9yzIvR3HmrrrFZsyhjgK?=
 =?us-ascii?Q?0g1o5pWaspIh7QXaEs92B/cySDkxgqCicGPyYxv5O0HQe2IGhGZQRPRsu6Up?=
 =?us-ascii?Q?D8nwJWm9Y8N7dp/33Opo5rGcV0Ok73eBJndGfM9HLZqyofOAk+rnMmJ0vvA9?=
 =?us-ascii?Q?GBdnvoE0lqFO7iclwgUjgD8ksLodJv7kR6urXNhZ008Lfi8kijStRASjIyJw?=
 =?us-ascii?Q?VoZGZ3VA8dvH7EsTKbdncdPd+xfat4mSmwuo9W1HxBsJzjuVgMAFAPmYyZOb?=
 =?us-ascii?Q?JKoaitbCTCFYFTwdMsfWWIWdvhZJBwy5HV7XwOP0rkWf95VkPPwJwA4qU/ez?=
 =?us-ascii?Q?RorQ+BYdJDfP+IZFvqaDR5R9M8D+FvrpMxwo4gjY5nhyo4/8Bewu5XlnjUEr?=
 =?us-ascii?Q?6D08AMwne3xjOWkWVhZEsmrqvP/t234FZp0be5m0UwGlkTNXU0+NmfhiIgIy?=
 =?us-ascii?Q?gfP2kaFINt6sQn0+5zhL5ZZXPah0fD3IGc+NUvMIoVmLlYjqwioBqPWzJ5/g?=
 =?us-ascii?Q?IKVcWgHzwCEjNF3Pa7ma6KdRkh28jXg5a/VN7S5BtUOFdf2a9TSOv4Pkf/gc?=
 =?us-ascii?Q?mvwF0JK43XK7HUHT3TJtzGLVeQ6n2hnUxqo4SmkwC51uk3Zju4v4jILdDBvJ?=
 =?us-ascii?Q?Sr2iAHFQwhOrI+NgXtxIRtOYrXgWldSgESpFlIzXgc6EJNJMaLwAHDOw9rks?=
 =?us-ascii?Q?ZS7wIzGXv2ENt9iZPcGL80TIyywsDflKdZAgcq28KcFeOjETiBuDPq80JeDd?=
 =?us-ascii?Q?mfhsaLckWMW1j3Hcr611FZPOUvEVw9pC8hHuDqP9cxKdpd+VvrHQ6ymgbbhL?=
 =?us-ascii?Q?0Ms9Y1VSgWFOmTe4t17Nh1ZNx31JI6MQNclKtDtz3feeoj0cdXLou3P7XD09?=
 =?us-ascii?Q?m6vlx98r3mYonBxzEDCMvf5JNsmVUcl3IbRsuuo9zOkAy7JGQsVfPHy+wy46?=
 =?us-ascii?Q?rSwndYa915CffBGo7tPno7laONWDupHD+IhnUcgSoGGZ/lEde5Hx9S9jrv3w?=
 =?us-ascii?Q?wc4uwF82TFOgT8rH2bryuWKlT2QG5PoG+jhKhdrEoibeWAjNj+wYvY+9qOCg?=
 =?us-ascii?Q?upt4UZ5xIpFKQDK0r8tEGR2xsKa7s01/OEinEPnUko0vn2lTXzlaf9fZO65A?=
 =?us-ascii?Q?AKEhYP1BTGO12+2jKtvY+vuC4ZOCOBFmDolRbglhcoeo/I+HKNhQ6UTY+gq3?=
 =?us-ascii?Q?T/PJQ2Vhcg8xtgz9DjBoqEypWnviAeBJUHHG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:37.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087d1ef6-a53e-41e4-ce2a-08dddfc36c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
Received-SPF: permerror client-ip=2a01:111:f403:200a::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a note in the DTB section explaining how to dump the generated DTB
using the dumpdtb machine option.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 94c8bacf61a..5d7fa18592b 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -63,11 +63,17 @@ Users can load firmware or boot-loaders with the ``-device loader`` options.
 
 When loading an OS, QEMU generates a DTB and selects an appropriate address
 where it gets loaded. This DTB will be passed to the kernel in register x0.
 
 If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
-for boot-loaders or firmware to pick it up.
+for boot-loaders or firmware to pick it up. To dump and observe the generated
+DTB, one can use the ``dumpdtb`` machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
+
 
 If users want to provide their own DTB, they can use the ``-dtb`` option.
 These DTBs will have their memory nodes modified to match QEMU's
 selected ram_size option before they get passed to the kernel or FW.
 
-- 
2.50.1


