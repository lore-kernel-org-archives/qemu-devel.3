Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B16C83F0A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjdqQ-0006Xq-2u; Thu, 29 Aug 2024 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sjdqJ-0006S5-Sg; Thu, 29 Aug 2024 08:01:37 -0400
Received: from mail-mw2nam04on20606.outbound.protection.outlook.com
 ([2a01:111:f403:240a::606]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sjdqH-0006CG-C5; Thu, 29 Aug 2024 08:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx1CohYIaBuHtJMceGRpTCdO2HIQyEMJ1uh2KEhy4hq1L6jljpRCbwA+KHOLKfuSnmSJe8Ix411iF53i6ts2XlybYIQCsbYjiQb6+FzoeR9ZwT4qJ0fkBwILHWEVoLxBFA6N8Q0IQOVAw0obzBsvzkWmwT7MFJGvs9XeOL6Ex+F+9kf7E5g8UD+VkyeTtzTMnObyqhLSn7O1b4qdvf0Pqn5aGn8l37ilQTgbqUVrewK7TZNWc5l9K0YMP6/gki4knSqmItdPEv32oGGJB99BPBweoPN7oUOTcx03/N2z8m3Yh2f2Su0N9iomNCFlMeai8ZGIXQA3Z1MvnMT1snvIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kwF/pkN0a8cQQryH0EdP9DOGD4KCzd2fsf7JiMDMtc=;
 b=GP1dPF1hVKx0q/HDyY9Um6enC1DDP+ydg0wdXKRrAyhq4SktPXsSBmkj2B1lHzZmwwXluyQZOPDO7twRFZoYSd4rxtOg6eenWYGoUh6ntdjOgrEBJcZ86sWiTjaVElOau+JTFpQz5HcW72ZkblF+EBiivofGUkw1r3+iq+dvkKqC0L3CdghW41gRH9LHFZunASoZdeDRZbP9/1rogY/1vp/q6QBMvclsniAmV4Jl9DdmeF50oolD/w212nblta5e0H/tNpiq1t60Wc/EZiin/UcQtHFFu/2RWGmyUOzL02qmj2Vy7MONJsCihNoPdFdwO3AuGKfCWNJqYoil9DSLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kwF/pkN0a8cQQryH0EdP9DOGD4KCzd2fsf7JiMDMtc=;
 b=JdHKWBsK6bg7yT1e8SbymPIg2sMpo750zqiyY8L99UlYged3u5Pd9x04BNaIXd39bFpJ6FtlQALNCFspZ8Yngi2YWi0mGIFmwBX3Llj8am5WjnF/l+PDN9RMADG0OB42cmxZ8VSr2zX7FB2nHzkn+7rQci9XHXoy3USVO1j2qpc=
Received: from CH2PR18CA0057.namprd18.prod.outlook.com (2603:10b6:610:55::37)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:01:25 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::7c) by CH2PR18CA0057.outlook.office365.com
 (2603:10b6:610:55::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 12:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 12:01:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 07:01:24 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 29 Aug 2024 07:01:22 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <alistair@alistair23.me>,
 <francisco.iglesias@amd.com>, <peter.maydell@linaro.org>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 1/1] m25p80: Add SFDP table for mt35xu01g flash
Date: Thu, 29 Aug 2024 17:31:17 +0530
Message-ID: <20240829120117.616861-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Shivasagar.Myana@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: d78bcc63-f2a2-4057-a9ef-08dcc8224ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QQuqEqxkJQZ1A8UnKxLQcgccznAy5sFXPeoJQHUNFftTvQs0MK8/zvYVFMcx?=
 =?us-ascii?Q?kl1gl/MnZc+exY0gBwmXwAvXRppMpfEZ4UV+6efZnsOeuZGXSuvo2BoZPNG5?=
 =?us-ascii?Q?bWnW+w1r76k/n86lKtzJwLTLI6kHjlq3m6EBP2F7ijgBvEPuuOUu7N2idpg1?=
 =?us-ascii?Q?54sLXSq6zg5TBj60vN99Qr/5kJAlByzMsy1TBaGkBwPesPSUt5rGOCbxDhhN?=
 =?us-ascii?Q?VJ+dgIxX39xgG/FsOGhIV2Bk3Qco/06ba3eMoiynAANcIYVkKcio6lcjFfbx?=
 =?us-ascii?Q?/WqWLiRpRMXnPyT8o3t4EthnYQp39nag8qONtGGkCRTXN3baDlfoN4Z4J4dN?=
 =?us-ascii?Q?6hvl/hw2QtO2YjX8A4LuzDgcCWolzhGMKLlSEfrsxwSdYkwKJR8x2w9QpIhu?=
 =?us-ascii?Q?MGgmxZkeo57caHQ5zr5XxIjL4iTGy89r87r5VBe43ie6OPp7Q+0FGKn8/ug6?=
 =?us-ascii?Q?niRLFnOiiC30J41jTyP5nBJzm+rIWbAzb7WJpewBIzzyDLyVRkJH/5Q3C6y7?=
 =?us-ascii?Q?TSKbDxwFp7A1MbGRAWTd7R3Ha6/YwLH/rf0DYQNkNruomLLNvwjkOIBqXs4M?=
 =?us-ascii?Q?UfjGwa1qZjegPg8S+CP+dHvviS7PyaJnBH03LimPSFBqwkJ5uCenko9+t88v?=
 =?us-ascii?Q?YH2OkQW3mcTvzjpVjcOFSzyQeTDtoarDRpKqjd5QunrlKCpLCI4zt8s8yMqy?=
 =?us-ascii?Q?0vuv/85PY4UariPVKb0cqdZdAXfhmoD+P0zhw4+oilLHkHrUbTTbkwm7MLR7?=
 =?us-ascii?Q?y3A1/iKuXLY9rUORRDaDoH2YVs5EJLzFXXEwY/2Vc7qdcIY1S0u5sy4mFDzD?=
 =?us-ascii?Q?w0nnLVqfHLtIST/HjBotuRoCyos2nkByGOUyDCYN5SATf3msKQdaaSNO4zgW?=
 =?us-ascii?Q?ACRPB9PbQfFCCswxwo2MzUVznOrobBqE2mbxURmkPb1tDaV4fSg49u+Y0XPc?=
 =?us-ascii?Q?Ai/UurxZ0tdkPjs7DJr3ZUhi+c0JZmpFojv6TbNnAy9O7236816lQFq/hvNg?=
 =?us-ascii?Q?oh1cFlv7CTyeYXVnYhbtIWp4z6H/q0WS/tJn8zig/9WVjSE1DfK0TyMH9C62?=
 =?us-ascii?Q?6LCD+9vmBFecLm8T1+jSB9m7exl9VJffbhzKUpK00PqxEkeOEvweyDkZ2kN0?=
 =?us-ascii?Q?oEUuTB+82V/sJrql9Q9w1R0rJKadem3DhcAuZ+zwXeMvpdI7O/m+Gk6/csp0?=
 =?us-ascii?Q?l21++SUuQRsBpipFL5W2c5OT6zI7FfOGvcVfdXfymVhRL92+VbfXcwWA57AE?=
 =?us-ascii?Q?RgtC6xzqMwq8Ka5q0dnQE4vaFc2m3I6CccGjDOXCxyHMXuIKyhzPl4baCapM?=
 =?us-ascii?Q?Vyt9Jj9r5ehNQbC9nkZlwypvv4MtSQFx7R/j9V7j38mdRzgyhT4hiNd9AYSt?=
 =?us-ascii?Q?jAiyNnjlxl8ULjIoK2rr/tlkq4NaM6AsWvHtoVPtgZDJCB1rlPCJDpZquG62?=
 =?us-ascii?Q?x1Q5P5PFyqYPd3YaL2WcmPx34BoYFD7F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:01:25.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78bcc63-f2a2-4057-a9ef-08dcc8224ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
Received-SPF: permerror client-ip=2a01:111:f403:240a::606;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Add the SFDP table for the Micron Xccela mt35xu01g flash.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
---
V1->V2: Change subject and commit message

 hw/block/m25p80.c      |  3 ++-
 hw/block/m25p80_sfdp.c | 37 +++++++++++++++++++++++++++++++++++++
 hw/block/m25p80_sfdp.h |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0b94af3653..23290edfe4 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -266,7 +266,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q512ax3",  0x20ba20,  0x1000,  64 << 10, 1024, ER_4K) },
     { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
     { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
-                   ER_4K | ER_32K, 2) },
+                   ER_4K | ER_32K, 2),
+                   .sfdp_read = m25p80_sfdp_mt35xu01g },
     { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
                    ER_4K | ER_32K, 4),
                    .sfdp_read = m25p80_sfdp_mt35xu02g },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 6ee2cfaf11..82d84cc21f 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -57,6 +57,43 @@ static const uint8_t sfdp_n25q256a[] = {
 };
 define_sfdp_read(n25q256a);
 
+static const uint8_t sfdp_mt35xu01g[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x3f,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0x00, 0x00, 0x0c, 0x20, 0x11, 0xd8,
+    0x0f, 0x52, 0x00, 0x00, 0x24, 0x5a, 0x99, 0x00,
+    0x8b, 0x8e, 0x03, 0xe1, 0xac, 0x01, 0x27, 0x38,
+    0x7a, 0x75, 0x7a, 0x75, 0xfb, 0xbd, 0xd5, 0x5c,
+    0x00, 0x00, 0x70, 0xff, 0x81, 0xb0, 0x38, 0x36,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0x43, 0x0e, 0xff, 0xff, 0x21, 0xdc, 0x5c, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+define_sfdp_read(mt35xu01g);
+
 static const uint8_t sfdp_mt35xu02g[] = {
     0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
     0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 1733b56950..89c2d8f72d 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -16,6 +16,7 @@
 #define M25P80_SFDP_MAX_SIZE  (1 << 24)
 
 uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
+uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
 uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
 
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
-- 
2.34.1


