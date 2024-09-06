Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB1E6FE43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdW3-0001KW-71; Fri, 06 Sep 2024 14:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVz-00017Y-QN
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:59 -0400
Received: from mail-dm6nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::61b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVw-00064Q-78
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9rCBzPUqT8eaC843VBA521UoSaxe/XjWiphAF8lBoauEi7OXZVAwDAC9f7f4yfPkgR3p/fkAjLVM8AR0wKgsdBJL1D7FgkmNL5NefDdvvo1ZrgIzGcIq9Ogwza2nGfvt8/Q5J5k1XvhJxg8HLe3E1cG6o8DsUnwErnA9sX4sNOfRBaDImRzFTUmt3tCfTRwN5H4WRNYNbipprbymIdg4YO21s13XaBCsRhEUVwHbLF2wGJSAvA8wzRHtzQth0X1BZQDnSpNP3WfIV3z9SOCB5LM/Tb9sv5YDeF0a93sRWLvIkS3PgolC+/5wJq2NsYRuwaNysy3KVs1kl5SQPWlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGCNW3b69VrtZZpq5HkLcrYciQLHIeYbHTQ/cApUcZE=;
 b=YCfbcW/WcnyASqnhu0i0F5aR8kzpScPBEAYoU0qBtRP3/qsfqOBm/3a2C583SyxRX+4psWpWCmONEgGllmTOklCjk7Qle8JxXk9pwNGgNFrhyIEokyXTAlXnrFVX7EFh7T03ypc4I9Sl/6WDchy9GbiwqG4fAYwDiZ5jNsPlM2eYqsdCC5zfQZ6anNqWe5a1Bf8kCjZV7L77OjXGN4gMY5E8uFcc1zpBjJvJQemi0KL6vAL7p10wJxLBL5dDauMEUHiNHW1jFY/0sOsuHK6gfVgPpHrApjFaBh74186w18fUqf4RK3aBNw1chOYx2/Zaji1Bp/NvdVcPWnf+OsmZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGCNW3b69VrtZZpq5HkLcrYciQLHIeYbHTQ/cApUcZE=;
 b=XGD22oR3T2zM6R5JxmuTJzisWlt0nUDfm32lSJzPaiu3ko5unQE8w0E+ZQe66lYlAmPNtcDFjKba2m3B1VBWy6cs8JPR5u4XcAztc6iwysqJ6s77+QsFs7McE1cmuM1Q+H9XwTYb8/rUwaIZRJ2kA/ETRdw70ut/rYHhgxGF2Nc=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 18:16:49 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::44) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 18:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 18:16:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:16:48 -0500
Received: from xse-figlesia-l2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 6 Sep 2024 13:16:47 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 1/3] MAINTAINERS: Remove Vikram Garhwal as maintainer
Date: Fri, 6 Sep 2024 20:16:43 +0200
Message-ID: <20240906181645.40359-2-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906181645.40359-1-francisco.iglesias@amd.com>
References: <20240906181645.40359-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: francisco.iglesias@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: bae1b1ab-62c3-4c40-8b7c-08dccea01386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfyYWgOj7rKlLSNs/FWiwHjT4WpaxA+gY9NSiUGhrPxX1+WDGiXsuUTwOv9n?=
 =?us-ascii?Q?FVrZ3j2ntnVhZve7FPISvmbvSKw8VkYm6N9qhPJ8wn1cfwhhdz0WvuQ9skS8?=
 =?us-ascii?Q?TDPmd5tXwHJXssB4SJSTLsTr0E4hYxr1oHOo0E6zK9k5enyKYUVUzhT8g3FN?=
 =?us-ascii?Q?wOTWtVakrbjeId65YaTiN9jgEaIuhyN8FqvB2KuvLGZmtmP4ynPsnpQ8Lt3o?=
 =?us-ascii?Q?L3rFfGV1hJVIZ0UC5XxySnZ4oZ1wsMg2oobERN5B2vB3Tza3NGRKfQj3Lars?=
 =?us-ascii?Q?6gevELHMV9FuupEyFvnYyypekWKbqsflUDvH3O0y+G/D6pEcaP8L4r3vZN7p?=
 =?us-ascii?Q?bPTkISXo5Bcqit58iSS1+2SvYoEe7Lzm8YUS+1JuGH2/EdrmItIGkshc2F8J?=
 =?us-ascii?Q?LY5fuepvlTNFGQusRBuZB7k/7IxqZbSElym1lmWa87Z62wsX9sU56usttT5B?=
 =?us-ascii?Q?rfhrtjoiC43ACZtDOUpHru8Fnf7rndjxNoZbwjYlkcUoSaM4kQlmrIWPUFf6?=
 =?us-ascii?Q?WzhLc6qTTbIGVAI2WGbo5Uwr0+wJi5sC1Rh4teUimFLIPHTpO2SpLCuqXkaO?=
 =?us-ascii?Q?IAHiYXsx/bcZpPMbQdqrL+Scm/ROwFbnvh1bsordT7ow/xmNxZlLsM01GCWz?=
 =?us-ascii?Q?6O4NhCfcrU69KE/h66t1yr8L0/zHaD8YLwmy5ctK6bzAJDVO4+L32nHNGusC?=
 =?us-ascii?Q?k6/icPgcQ5cxEPfyoPGIYpjCriUaZ7ndR0uD1EGhY3UwcgN01VIAMJSvRLaQ?=
 =?us-ascii?Q?pD4Cc/anjH9Ka2m5m97TdL3QmrkPL96bBzuHMaGKkLbQQoJYSoD/LHuGdioQ?=
 =?us-ascii?Q?pfT0JWWUU7pWece2TRxDY3YpK+fUmGYCSct8XsopxYjhRTppqMRjSx5Fh4jQ?=
 =?us-ascii?Q?OO4JnODPd6ub+iqQYARkPv2JgpRhNfQEKaYKtj3AOSB+sEQkYKzbn7M8YrkV?=
 =?us-ascii?Q?fqpdJwy9oUVDJN/TSERRqliMJwY22PqhpLo56evr41J+FJsSLxiAHBUb6ly/?=
 =?us-ascii?Q?IipidmNpGeky6nqD6mDf0BIu2anRa7jVa+KOSPOPHaeg7EEgDo8rUwUi/P0E?=
 =?us-ascii?Q?wKy/0GwWWAA/3JOBd4Ci4dX6Mb88DpY79KomJ9sK+/SZBQ9FfLWbVDNvMsCJ?=
 =?us-ascii?Q?5odo8+wLHNMApYmrlF/eLixRC52zOzqyLE7j3ae+90bcCXnUl7RJrVeUTrhy?=
 =?us-ascii?Q?WnWCWlWIjlwXT0yvnhcQ19A003QELWtC+iLtvG36nBWiKFIpH3QHzsi5lCrq?=
 =?us-ascii?Q?kO/X3eSqB04hkSeX56KT9SdlV/lIaHg2AwxtYdq80/Isrh42QKJSEK7/wngF?=
 =?us-ascii?Q?epFGR2GXYXCGgVE2l0aMymuV/O5Yw/5kS+4kHBd2aigjUrLdOxLcLeBHyZNt?=
 =?us-ascii?Q?H8OIL01ZGNj5cgBZihKtsSDLeUx/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:16:49.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae1b1ab-62c3-4c40-8b7c-08dccea01386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
Received-SPF: permerror client-ip=2a01:111:f403:2417::61b;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Vikram's email is bouncing, pause his maintainership until a new email is
provided.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1bc69828..ad957ca5e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,7 +1945,6 @@ F: tests/qtest/intel-hda-test.c
 F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
-M: Vikram Garhwal <vikram.garhwal@amd.com>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/net/can/xlnx-*
@@ -2702,7 +2701,6 @@ F: include/hw/rx/
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
-M: Vikram Garhwal <fnu.vikram@xilinx.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.34.1


