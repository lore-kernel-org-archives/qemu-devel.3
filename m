Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F907CEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdYJ-0008S8-EM; Tue, 01 Oct 2024 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1svdYH-0008MG-CY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:33 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com
 ([40.107.220.68] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1svdYC-0001tW-S2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWXxpYuc9/osL0/K+/V/EynaIvITbfnnftwW5PzxLXxuyrRGYESLNu26SqNzowiFhWwItMlaBpkjXYMXH8Pd/f1Iz2BV9Q8BXM0a3IIr0IKxPDqNAkAe/coWZroLwmZtGZCLjG8+jg8JDPcuN5i4G8m9Tk3L3i7CeO17g1EGOlnTxCnXa7nyh/jOwofegP9qzVf3qXCT2i2Nv9JSSrK4flPMzKf0dVN00JwqEHnwwauI5NUWOosZOVmDMX77jf4t5liVzp4ePUusibbnKAcm1Gp2M9reYXaXfwZ+Iq49sDBRFu6bydeD2vmwABc/z/gKyC8VaNyT5R3bw6shyMt9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yHLKKqXz1ogxF3td3faievP5VGLqm8g6H6WnmolOBU=;
 b=UOAAqzQvPu3+yGZZdbDnD8TN0bFEVOM9F1w+62eMC8ojAb+6eEd9GuvVO25pLINPLYdOod8fKOpVKDAWBaje0TTZRqGgpKe2SGJuxqGHfI6RUHLsB/Gwb7Zo/QhpDIFrvLOWD0aj1bqycb/qzLYN4CvMCq67E+kW7P+kw2+AowPTS/f0+mwnioRTEabtNHOB/cYqXl9/eDWJFipN+jgaIu9YJ93gao91PpiuN7kmn4UXRMvAR/mDpaMga3aiTT7uW05KfEzwBiFXZbywTxmHZWHRAVub0nDtTeX98F5XnC2jk3/9Cig3EwkkBI2Ae7KTMhVIQ1awZjFQRcJyUCfk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yHLKKqXz1ogxF3td3faievP5VGLqm8g6H6WnmolOBU=;
 b=TjbrekCc9fAzDn+6tu5sDZkSkJRAnXNodiDgneAB52jY2gab1vxi6evgnrYIj6a5sZRUa/qqOC8T6CvTTeoyGt6WhBYoKzXbAFhCCTMrdA+X9NIgxyrwGTA8Hh2rmC2gLEhUAkNgz2HKV9UYIln1ehuJbN8XFfimF7iXOscvYZw=
Received: from CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 11:32:47 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::3f) by CH2PR16CA0003.outlook.office365.com
 (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 11:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 11:32:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 06:32:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 06:32:44 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 1 Oct 2024 06:32:43 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alistair@alistair23.me>, <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 1/1] hw/ssi/xilinx_spips: Fix flash erase assert in dual
 parallel configuration
Date: Tue, 1 Oct 2024 17:02:40 +0530
Message-ID: <20241001113240.2755645-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc57b87-2df8-4dce-e899-08dce20cc55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0LqKYzxbYMn2ULL/F9rbv+YPbFQKsi2u4QH6M7gbCeFzjKCsmBwBStkxhhur?=
 =?us-ascii?Q?A5eLDD/se5noCJNvcxah9pS4BtIgLWETBwDrBvApAwvDQDo87/DwRnccagom?=
 =?us-ascii?Q?VoRRzWxhi9QCV/TMMX9jkRQiV6wq8PT3TfEDf02vZXXp9yv0pAG/sQurIkPv?=
 =?us-ascii?Q?X8ETWAqC9bg4kMm3B4+J5OmNZZEBArz+qgEF0zOG98YpcTCoU2j0tzJuFkqE?=
 =?us-ascii?Q?nMr3Ig4Ox4znxaaRx0FyYsJizp2BFktnQCIheb0oFHOPZGqLso+tN1V2G2y4?=
 =?us-ascii?Q?l2jya1NVmyf2nnVvuwsbKACFWlFi25GIQiCBXlD4Nf/gXEyoEHOSAJ0q10EM?=
 =?us-ascii?Q?aq4AxejkA3GgFzGffY2ZsJzod1NYQTix60yoLmwLZH+fOEfVZkwSLFxPlvoB?=
 =?us-ascii?Q?tG45+5LkupJ6rDyWPIn+PyTMi7eQvJ+kOHEHRFNRkvzBHXBbm7++U9XQhc0V?=
 =?us-ascii?Q?Qf49YHi+B6e+s7TteIttKKERW+I42zmaT0W9jnHnQqIctYntD6+vfIvUGwjA?=
 =?us-ascii?Q?9p7+84o8DbvdZsetyLS0XntH6R/LWdsQLtK8XOUW4WJx9YiPo9OdrUZpgrAf?=
 =?us-ascii?Q?xCzPfRjRvITCaGPZjKYvr6cr0lEq9OwXIttk90c3fuL+IoPC8roSRi2BM2XA?=
 =?us-ascii?Q?8xgJzbbDWPvIZZZ1f9CdMsvUrVnlahoDyQHtO7hpg99MEJRRBCTFLDV98S59?=
 =?us-ascii?Q?GGOrxzbluvrE2kJrnZd0+CctcvtoloF7qDjt2c8ewifbtOxSLltox7w6HZYq?=
 =?us-ascii?Q?vHa/mLnHvu666o/fKloSJWVtX7XQBHXWpFHQY4sGfydaF4U0q3KK0MyBdu69?=
 =?us-ascii?Q?shNkY+0waqNZrYTNsGtBeugxaLm3PYc+boCChbgdCDcCJ0Iyx5csyXNHSmS5?=
 =?us-ascii?Q?Yk7UDtcNs4QchKdk6NMO48J+kJjc5aUX9kLv/UzkE0LrLTafvg0xncorVC63?=
 =?us-ascii?Q?JzUgq0195kfsiUQe2QnG50EpmN4IqPZpNuSA9aKGcuUn6p74UBMs6D/pY+ZM?=
 =?us-ascii?Q?aB/F+FuTlmphFAUH9oZcr1jyHisw9d20d9v9pwoJXiZxKgEwmuBwcqmT/d9T?=
 =?us-ascii?Q?P2qv22UwUJAcxpINsUH6wwgne4qmKe/J5eHFGV+ZpacEsje+nEHS6J0vUom7?=
 =?us-ascii?Q?zhm78Qit+5FBVLhma7RF++PZFS6fd2+PwqY6vOhPosBuaoix4Bv2gGSHOAu7?=
 =?us-ascii?Q?Lhuet2SftEKszibGr2Em6XHSViGYNKKpbGHHniGDG72exGbyCnjqC4ztrpSZ?=
 =?us-ascii?Q?sviiFlyhl22Ot4J7YuvxjhUQAQAqhfL6c191pLdaO9A28P4iWtGsKNnUzaGW?=
 =?us-ascii?Q?oO8xU7Ll9a9CPOIoTN47E3axFGigJpJ6aMIr4BMThelnGuYAvdQUBGvZfx6W?=
 =?us-ascii?Q?lB7/nViWidejzw4yVeBw0RQC//1Suk0O28Cbm1xrssCaFdB4OjiJspUv6S0p?=
 =?us-ascii?Q?gi5C6EFQTqx7qKHroEOsBV53l7SqTgaX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 11:32:45.7516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc57b87-2df8-4dce-e899-08dce20cc55c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
Received-SPF: permerror client-ip=40.107.220.68;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Ensure that the FIFO is checked for emptiness before popping data from it.
Previously, the code directly popped the data from the FIFO without checking, which
could cause an assertion failure:
../util/fifo8.c:67: fifo8_pop: Assertion `fifo->num > 0

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
V1->V2: corrected the subject line.

 hw/ssi/xilinx_spips.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 71952a410d..adaf404f54 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -620,7 +620,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         } else if (s->snoop_state == SNOOP_STRIPING ||
                    s->snoop_state == SNOOP_NONE) {
             for (i = 0; i < num_effective_busses(s); ++i) {
-                tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                if (!fifo8_is_empty(&s->tx_fifo)) {
+                    tx_rx[i] = fifo8_pop(&s->tx_fifo);
+                }
             }
             stripe8(tx_rx, num_effective_busses(s), false);
         } else if (s->snoop_state >= SNOOP_ADDR) {
-- 
2.34.1


