Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E84CC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyu7-0000qX-9L; Wed, 16 Jul 2025 05:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysS-0002PA-8d; Wed, 16 Jul 2025 05:56:40 -0400
Received: from mail-sn1nam02on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2406::612]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysQ-0006oV-CN; Wed, 16 Jul 2025 05:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpbolJGH50e+p13frnJsamKAL6mj8TRkIuOfkMRXas5Ft0ac5L4rS8/acCKrHHIX1bhAXbeLVY4YDaB0RPWjTgO0M8M4gg/rYmupHhK8zmFUPUYVugSJ06DBZEHGMgsXmho0e4/9xnnt6VDrgp4FQa5WElFmsRGWK72s2Ly2tN/euc1P2nBhOB84c66xbm0mqvlFiP0ViIDwBxAXNrJyi7Pvgqj6awxi9dmWvd7cmnFSOrio1SU0sGRETiZwZHzyMxqv+qLfpZo+1MrbHLbWMJqG/7qzde8kcg02IdECUfu7nsNovt0O15+bWiCbFGgfCwi6aiTuwRyCqcK+6aNnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF13Wqc6+xXOzQY2HuBCdSjIyQ56JZ2nLncwUd0X8UE=;
 b=ps7/xvI9jCboQ77yZ+QFnVdjsSvZ4Bkuw0qBkJl6yJ4k24UKN2xhjdYcQn2LhKyVrY47Lw/oV0FPF12m5TmJsDWEBglfAtPMIjJZuEnbFVc3xPspY6E+M8b+pu+bOJsnw2VKqBpPU34nfXmQnGqjQwnn5+LkDmV7Xj6a+6ErSiS9hGpePX2nCQeIipeUA4kBObK0xorJIYe3YoI4XPPQ4DSMWqqvUUf9C5XgdWA9ui5TP06bodQ84Uz3fUt6mlzxtESwT2A/Wdc0hYfd9htFZAFN9hdahu03QsOIALu6OLi1B/MBwptaupVhparX978Oadc5i0Jpa/9VMSYJXXB5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF13Wqc6+xXOzQY2HuBCdSjIyQ56JZ2nLncwUd0X8UE=;
 b=3KS80w0eKuamZldRndQ6/0jIlZZiTUGAANjQwEmNL6Nl387EtFusxn/xuEcl1DWVu5upAXQvoxK2CXHZVWIw0cno7ErwUbW0yi6GUvC1L/842S3+x0+I406fKY8lITziuhEyZzJxUrRSaOHBGx7wGhD+d7wnYsnz0P+ldQARC0w=
Received: from BYAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:c0::27)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 16 Jul
 2025 09:56:33 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::3) by BYAPR05CA0014.outlook.office365.com
 (2603:10b6:a03:c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 09:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:31 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:30 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 46/48] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Wed, 16 Jul 2025 11:54:28 +0200
Message-ID: <20250716095432.81923-47-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: b870c96e-0e7b-4a37-88df-08ddc44f0b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SH89QcgKNFp+PPp/jJX+YFqJjhHTsDPCwKcwETOlB22fw+BnehHTdq4oYzgs?=
 =?us-ascii?Q?piYy5cX1dtKzN2c8TtV/NdPY4FvaHVMfmi/a6WOHQZWi+CEWPt0Rn9D5pW65?=
 =?us-ascii?Q?sx61vz0bG2yNE93MBfddehu4i7rvYq+ZDBtzlh6gKFxpF/GZEkaVzIir/qWZ?=
 =?us-ascii?Q?McsLOi/ro5NYndFTBwhCTOqtlHuN4+0U0Gjh4iIr77a2Rzcs9HXwJuu+equr?=
 =?us-ascii?Q?7RpvsyrmcVCRFkUq1BX6obBaBRCZsClgRF898yuUxayvFxejflOYttxKzJRm?=
 =?us-ascii?Q?CmsW2I0tz1Y0JkG4hsr15w8Fsz+HIahpTIWUaQH8qgB2hfWDxWL08ooHqrWK?=
 =?us-ascii?Q?uejLwW2F+QWvzN+LCz0LS2NhODj4YO+I3b73GBqqXQpirXxZNvP4CaxsgDt0?=
 =?us-ascii?Q?xIYzKurmFKS8ZT7LiOxuT+3KHION5aZ1iexgrmI5x8GRwxhBo++oL6diugNC?=
 =?us-ascii?Q?9D8qgyM0P7VLKiydwMEYNBXFksEaO5WDwWLMp4eUlVOa7x5dgpCmi3hZ6tlh?=
 =?us-ascii?Q?PDbPESdh5x6fcTMgylwGBNWUczPn9i/tEizLC3ArBWC54jUnC4gETRGceOAs?=
 =?us-ascii?Q?elYTc0mJABCr6OWEp/y68j4RhY0/8L72+xJXa0U+kQi8pjwldC1GOCgY/nO9?=
 =?us-ascii?Q?z15SgZ5z6Sw4LOQJBjb00g8IODtEHN6EOcFsVC1tnjDK9G8dxrTBRui8WByS?=
 =?us-ascii?Q?HEqX51oEBeI+0FL1sdadAXEifpx1iIs3/T/SBrtu6WFm9qDMdGK60BavBjCM?=
 =?us-ascii?Q?OveheISWhzwVrHwjsC9GxcT42HC7rlYjjLXcuII/5o/3jywjn8MZu60S1Dkv?=
 =?us-ascii?Q?LfSk3Fpbxn931jewoFjOpu0AVzVPoezVtMxYih0ei6ucqwEDOI9kPmqmXFBa?=
 =?us-ascii?Q?hWkXSWoMYQsJJ6D/m0ULXA4EDSNTmDkDgPt9vb4NWa/aDbtLgVWmd5r0sFLU?=
 =?us-ascii?Q?h1zcdy8QZsVMWY01MhQHDUCMV81nV0c4x9LTxaeuWSdbirz4HXpz7CC2/BKq?=
 =?us-ascii?Q?VYJ6OSR7sJBGIhndBsTWt3GP43uJR1is/Ye+J7rtDRJLIK/gDSIECwBv36WK?=
 =?us-ascii?Q?rZ4XkBF1bES7shlng5UprjdW+AvxpfBAZVivEcuG5dvaQZePS7Pc7g6qDn14?=
 =?us-ascii?Q?Pax4S7o00w+VaivMaqC2Nsh5uqsJZZANu8UoducAz/JZC5+UEp3yf6SZ8UA4?=
 =?us-ascii?Q?6/zyyaSrqFEn9Bo0xFRz20RSPV7ePvrq4N1+Kc1DGRX1M5w4sxHPOWFHvy3m?=
 =?us-ascii?Q?zejOg7NtgjCsls/fteBsx1fuAiA0UNNhFBwuLCxbcfBN1aWB08EE18VNYuyy?=
 =?us-ascii?Q?FIhV+gRimrxuA40rxTYn92oIIxbWAXoOzbeyBxPUq59cWEF6ANNsfMYOqup7?=
 =?us-ascii?Q?XprhNyAOg0/1ijK7bzH7zc45Z6jAB00hL73XTs1GgvZwdPM5FltjRqO4tzDG?=
 =?us-ascii?Q?alrHY4W6A+3T9hn6py+WEy+esjNpYRzh0h8unN/scLfgxaitfzhMFsF4nFjj?=
 =?us-ascii?Q?d1E9ZY5vkQO8qBgjK++e8qfO0InMScgFytTv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:32.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b870c96e-0e7b-4a37-88df-08ddc44f0b60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
Received-SPF: permerror client-ip=2a01:111:f403:2406::612;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
2.50.0


